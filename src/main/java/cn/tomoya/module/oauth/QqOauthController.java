package cn.tomoya.module.oauth;

import cn.tomoya.common.BaseController;
import cn.tomoya.common.Constants;
import cn.tomoya.module.system.Role;
import cn.tomoya.module.system.UserRole;
import cn.tomoya.module.user.User;
import cn.tomoya.utils.DateUtil;
import cn.tomoya.utils.StrUtil;
import cn.tomoya.utils.ext.route.ControllerBind;
import com.jfinal.kit.PropKit;
import com.qq.connect.QQConnectException;
import com.qq.connect.api.OpenID;
import com.qq.connect.api.qzone.UserInfo;
import com.qq.connect.javabeans.AccessToken;
import com.qq.connect.javabeans.qzone.UserInfoBean;
import com.qq.connect.oauth.Oauth;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.util.Date;

/**
 * Created by tempestlxc on 2016/8/28.
 */
@ControllerBind(controllerKey = "/QQoauth", viewPath = "WEB-INF/page")
public class QqOauthController extends BaseController {

	public void qqOauthLogin() {
		try {
			this.redirect(new Oauth().getAuthorizeURL(this.getRequest()));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return;
	}

	public void callBack() throws IOException, ServletException {

		this.setCookie("tet", String.valueOf(Math.random()), 10000, false);

		HttpServletRequest request = this.getRequest();

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
				if (userInfoBean == null || qzoneUserInfo == null) {
					/**
					 * 跳转错误页面
					 */
					return;
				}
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
				}
				setCookie(Constants.USER_ACCESS_TOKEN,
						StrUtil.getEncryptionToken(user.getStr("access_token")),
						30 * 24 * 60 * 60, "/", PropKit.get("cookie.domain"),
						true);
				String callback = getPara("callback");
				if (StrUtil.notBlank(callback)) {
					callback = URLDecoder.decode(callback, "UTF-8");
				}
				redirect(StrUtil.notBlank(callback) ? callback : "/");
				return;
			}
		} catch (QQConnectException e) {
			e.printStackTrace();
		}
		redirect("/");
		return;
	}

}
