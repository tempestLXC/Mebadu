package cn.tomoya.module.oauth;

import cn.tomoya.common.Constants;
import cn.tomoya.module.system.Role;
import cn.tomoya.module.system.UserRole;
import cn.tomoya.module.user.User;
import cn.tomoya.utils.DateUtil;
import cn.tomoya.utils.StrUtil;
import com.jfinal.kit.PropKit;
import com.qq.connect.QQConnectException;
import com.qq.connect.api.OpenID;
import com.qq.connect.api.qzone.UserInfo;
import com.qq.connect.javabeans.AccessToken;
import com.qq.connect.javabeans.qzone.UserInfoBean;
import com.qq.connect.oauth.Oauth;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;

/**
 * Date: 12-12-4
 * Time: 下午4:36
 */
public class AfterLoginRedirectServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
		response.setContentType("text/html; charset=utf-8");

		PrintWriter out = response.getWriter();

		try {
			AccessToken accessTokenObj = (new Oauth()).getAccessTokenByRequest(request);

			String accessToken = null,
					openID = null;
			long tokenExpireIn = 0L;

			if (accessTokenObj.getAccessToken().equals("")) {
				//                我们的网站被CSRF攻击了或者用户取消了授权
				//                做一些数据统计工作
				//                System.out.print("没有获取到响应参数");
			} else {
				accessToken = accessTokenObj.getAccessToken();
				tokenExpireIn = accessTokenObj.getExpireIn();

				request.getSession().setAttribute("demo_access_token", accessToken);
				request.getSession().setAttribute("demo_token_expirein", String.valueOf(tokenExpireIn));

				// 利用获取到的accessToken 去获取当前用的openid -------- start
				OpenID openIDObj = new OpenID(accessToken);
				openID = openIDObj.getUserOpenID();

				User user = User.me.findByThirdId(String.valueOf(openID));
				boolean flag = true;
				Date now = new Date();

				UserInfo qzoneUserInfo = new UserInfo(accessToken, openID);
				UserInfoBean userInfoBean = qzoneUserInfo.getUserInfo();
				out.println("<br/>");
				if (userInfoBean.getRet() == 0) {
					out.println(userInfoBean.getNickname() + "<br/>");
					out.println(userInfoBean.getGender() + "<br/>");
					out.println("黄钻等级： " + userInfoBean.getLevel() + "<br/>");
					out.println("会员 : " + userInfoBean.isVip() + "<br/>");
					out.println("黄钻会员： " + userInfoBean.isYellowYearVip() + "<br/>");
					out.println("<image src=" + userInfoBean.getAvatar().getAvatarURL30() + "/><br/>");
					out.println("<image src=" + userInfoBean.getAvatar().getAvatarURL50() + "/><br/>");
					out.println("<image src=" + userInfoBean.getAvatar().getAvatarURL100() + "/><br/>");
				} else {
					out.println("很抱歉，我们没能正确获取到您的信息，原因是： " + userInfoBean.getMsg());
				}
				out.println(
						"<p> end -----------------------------------利用获取到的accessToken,openid 去获取用户在Qzone的昵称等信息 ---------------------------- end </p>");

				if (user == null) {
					user = new User();
					flag = false;
				}

				user.set("in_time", now)
						.set("access_token", accessToken)
						.set("third_access_token", accessToken)
						.set("score", 0)
						.set("third_id", String.valueOf(openID))
						.set("isblock", false)
						.set("expire_time", DateUtil.getDateAfter(now, 30))
								//                            .set("signature", description)
						.set("avatar", userInfoBean.getAvatar().getAvatarURL100())
						.set("nickname", userInfoBean.getNickname())
						.set("channel", Constants.LoginEnum.QQ.name())
						.set("receive_msg", true);//邮箱接收社区消息
				if (flag) {
					user.update();
				} else {
					user.save();
					//新注册的用户角色都是普通用户
					Role role = Role.me.findByName("user");
					if (role != null) {
						UserRole userRole = new UserRole();
						userRole.set("uid", user.getInt("id"))
								.set("rid", role.getInt("id"))
								.save();
					}
				response = setCookie(Constants.USER_ACCESS_TOKEN,
						StrUtil.getEncryptionToken(user.getStr("access_token")),
						30 * 24 * 60 * 60, "/",
						PropKit.get("cookie.domain"),
						true, response);
//				String callback = getPara("callback");
//				if (StrUtil.notBlank(callback)) {
//					callback = URLDecoder.decode(callback, "UTF-8");
//				}

				//                response.sendRedirect(StrUtil.notBlank(callback) ? callback : "/");


				//                out.println("欢迎你，代号为 " + openID + " 的用户!");
				//                request.getSession().setAttribute("demo_openid", openID);
				//                out.println("<a href=" + "/shuoshuoDemo.html" +  " target=\"_blank\">去看看发表说说的demo吧</a>");
				//                // 利用获取到的accessToken 去获取当前用户的openid --------- end
				//
				//
				//                out.println("<p> start -----------------------------------利用获取到的accessToken,openid 去获取用户在Qzone的昵称等信息 ---------------------------- start </p>");
				//
				//
				//
				//                out.println("<p> start ----------------------------------- 验证当前用户是否为认证空间的粉丝------------------------------------------------ start <p>");
				//                PageFans pageFansObj = new PageFans(accessToken, openID);
				//                PageFansBean pageFansBean = pageFansObj.checkPageFans("97700000");
				//                if (pageFansBean.getRet() == 0) {
				//                    out.println("<p>验证您" + (pageFansBean.isFans() ? "是" : "不是")  + "QQ空间97700000官方认证空间的粉丝</p>");
				//                } else {
				//                    out.println("很抱歉，我们没能正确获取到您的信息，原因是： " + pageFansBean.getMsg());
				//                }
				//                out.println("<p> end ----------------------------------- 验证当前用户是否为认证空间的粉丝------------------------------------------------ end <p>");
				//
				//
				//
				//                out.println("<p> start -----------------------------------利用获取到的accessToken,openid 去获取用户在微博的昵称等信息 ---------------------------- start </p>");
				//                com.qq.connect.api.weibo.UserInfo weiboUserInfo = new com.qq.connect.api.weibo.UserInfo(accessToken, openID);
				//                com.qq.connect.javabeans.weibo.UserInfoBean weiboUserInfoBean = weiboUserInfo.getUserInfo();
				//                if (weiboUserInfoBean.getRet() == 0) {
				//                    //获取用户的微博头像----------------------start
				//                    out.println("<image src=" + weiboUserInfoBean.getAvatar().getAvatarURL30() + "/><br/>");
				//                    out.println("<image src=" + weiboUserInfoBean.getAvatar().getAvatarURL50() + "/><br/>");
				//                    out.println("<image src=" + weiboUserInfoBean.getAvatar().getAvatarURL100() + "/><br/>");
				//                    //获取用户的微博头像 ---------------------end
				//
				//                    //获取用户的生日信息 --------------------start
				//                    out.println("<p>尊敬的用户，你的生日是： " + weiboUserInfoBean.getBirthday().getYear()
				//                                +  "年" + weiboUserInfoBean.getBirthday().getMonth() + "月" +
				//                                weiboUserInfoBean.getBirthday().getDay() + "日");
				//                    //获取用户的生日信息 --------------------end
				//
				//                    StringBuffer sb = new StringBuffer();
				//                    sb.append("<p>所在地:" + weiboUserInfoBean.getCountryCode() + "-" + weiboUserInfoBean.getProvinceCode() + "-" + weiboUserInfoBean.getCityCode()
				//                             + weiboUserInfoBean.getLocation());
				//
				//                    //获取用户的公司信息---------------------------start
				//                    ArrayList<Company> companies = weiboUserInfoBean.getCompanies();
				//                    if (companies.size() > 0) {
				//                        //有公司信息
				//                        for (int i=0, j=companies.size(); i<j; i++) {
				//                            sb.append("<p>曾服役过的公司：公司ID-" + companies.get(i).getID() + " 名称-" +
				//                            companies.get(i).getCompanyName() + " 部门名称-" + companies.get(i).getDepartmentName() + " 开始工作年-" +
				//                            companies.get(i).getBeginYear() + " 结束工作年-" + companies.get(i).getEndYear());
				//                        }
				//                    } else {
				//                        //没有公司信息
				//                    }
				//                    //获取用户的公司信息---------------------------end
				//
				//                    out.println(sb.toString());
				//
				//                } else {
				//                    out.println("很抱歉，我们没能正确获取到您的信息，原因是： " + weiboUserInfoBean.getMsg());
				//                }
				//
				//                out.println("<p> end -----------------------------------利用获取到的accessToken,openid 去获取用户在微博的昵称等信息 ---------------------------- end </p>");

			}
		} catch (QQConnectException e) {

		}

		response.sendRedirect("/");
	}

	/**
	 * Set Cookie to response.
	 *
	 * @param name            cookie name
	 * @param value           cookie value
	 * @param maxAgeInSeconds -1: clear cookie when close browser. 0: clear cookie immediately.  n>0 : max age in n seconds.
	 * @param path            see Cookie.setPath(String)
	 * @param domain          the domain name within which this cookie is visible; form is according to RFC 2109
	 * @param isHttpOnly      true if this cookie is to be marked as HttpOnly, false otherwise
	 */
	public HttpServletResponse setCookie(String name, String value, int maxAgeInSeconds, String path, String domain,
			boolean isHttpOnly, HttpServletResponse response) {

		return doSetCookie(name, value, maxAgeInSeconds, path, domain, isHttpOnly, response);
	}

	private HttpServletResponse doSetCookie(String name, String value, int maxAgeInSeconds, String path, String domain,
			Boolean isHttpOnly, HttpServletResponse response) {
		Cookie cookie = new Cookie(name, value);
		cookie.setMaxAge(maxAgeInSeconds);
		// set the default path value to "/"
		if (path == null) {
			path = "/";
		}
		cookie.setPath(path);

		if (domain != null) {
			cookie.setDomain(domain);
		}
		if (isHttpOnly != null) {
			cookie.setHttpOnly(isHttpOnly);
		}
		response.addCookie(cookie);
		return response;
	}

}
