package com.test.util;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

public class SelfInterceptor implements HandlerInterceptor {

	/**
	 * 整个请求处理完毕回调方法，即在视图渲染完毕时回调，
	 * 如性能监控中我们可以在此记录结束时间并输出消耗时间，
	 * 还可以进行一些资源清理，仅调用处理器执行链中preHandle返回true
	 */
	public void afterCompletion(HttpServletRequest arg0,
			HttpServletResponse arg1, Object arg2, Exception arg3)
			throws Exception {

	}

	/**
	 * 后处理回调方法，实现处理器的后处理（但在渲染视图之前），
	 * 此时我们可以通过modelAndView（模型和视图对象）对模型数据进行处理或对视图进行处理
	 * modelAndView也可能为空
	 */
	public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1,
			Object arg2, ModelAndView arg3) throws Exception {


	}

	
	/**
	 * 预处理回调方法，实现处理器的预处理（如登录检查），第三个参数为响应的处理器、
	 * false:表示流程中断 此时我们需要通过response来产生响应
	 */
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response,
			Object arg2) throws Exception {
		if(request.getServletPath().startsWith("/user.do/login.do") || request.getServletPath().startsWith("/user.do/tologin.do") ){
			return true;
		}
		if(request.getSession().getAttribute("userinfo")!=null){
//			Subject subject = SecurityUtils.getSubject();
//			//具体响应ShiroDbRealm。doGetAuthorizationInfo，判断是否包含此url的响应权限
//			boolean isPermitted = subject.hasRole("admin");
//			if(isPermitted == true) {
//				return true;
//			}else{
//				isPermitted = subject.isPermitted(request.getServletPath());
//				if(isPermitted == true){
//					return true;
//				}
//				response.sendRedirect(request.getContextPath()+"/user.do/tologin.do");
//				return false;
//			}
			return true;
		}
		PrintWriter out = response.getWriter();
//		out.write("<script type='text/javascript'>window.location.href='"+request.getContextPath()+"/user.do/tologin.do'</script>");
		out.write("<script type='text/javascript'>window.location.href='"+request.getContextPath()+"/login.jsp'</script>");

		return false;
		
	}

}
