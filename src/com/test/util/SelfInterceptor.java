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
	 * ������������ϻص�������������ͼ��Ⱦ���ʱ�ص���
	 * �����ܼ�������ǿ����ڴ˼�¼����ʱ�䲢�������ʱ�䣬
	 * �����Խ���һЩ��Դ���������ô�����ִ������preHandle����true
	 */
	public void afterCompletion(HttpServletRequest arg0,
			HttpServletResponse arg1, Object arg2, Exception arg3)
			throws Exception {

	}

	/**
	 * ����ص�������ʵ�ִ������ĺ���������Ⱦ��ͼ֮ǰ����
	 * ��ʱ���ǿ���ͨ��modelAndView��ģ�ͺ���ͼ���󣩶�ģ�����ݽ��д�������ͼ���д���
	 * modelAndViewҲ����Ϊ��
	 */
	public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1,
			Object arg2, ModelAndView arg3) throws Exception {


	}

	
	/**
	 * Ԥ����ص�������ʵ�ִ�������Ԥ�������¼��飩������������Ϊ��Ӧ�Ĵ�������
	 * false:��ʾ�����ж� ��ʱ������Ҫͨ��response��������Ӧ
	 */
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response,
			Object arg2) throws Exception {
		if(request.getServletPath().startsWith("/user.do/login.do") || request.getServletPath().startsWith("/user.do/tologin.do") ){
			return true;
		}
		if(request.getSession().getAttribute("userinfo")!=null){
//			Subject subject = SecurityUtils.getSubject();
//			//������ӦShiroDbRealm��doGetAuthorizationInfo���ж��Ƿ������url����ӦȨ��
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
