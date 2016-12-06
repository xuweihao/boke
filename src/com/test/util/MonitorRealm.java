package com.test.util;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authz.AuthorizationException;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;

import com.test.dao.PermissionDao;
import com.test.dao.RoleDao;
import com.test.dao.UserDao;
import com.test.model.Permission;
import com.test.model.RoleBean;
import com.test.model.UserBean;

public class MonitorRealm extends AuthorizingRealm{

	@Resource(name="userDao")
	private UserDao userDao;
	
	@Resource(name="roleDao")
	private RoleDao roleDao;
	
	@Resource(name="permissionDao")
	private PermissionDao permissionDao;
	
	protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
		String currentUsername = (String)super.getAvailablePrincipal(principals);
		UserBean user = userDao.findUserByName(currentUsername);
		List<String> roles = new ArrayList<String>();
		List<String> permissions = new ArrayList<String>();
		
		if(null != user){  
			List<RoleBean> list1 = roleDao.findRoleByUserId(user.getId());
			if(null != list1 && !list1.isEmpty()){
				for(RoleBean role:list1){
					roles.add(role.getName());
					List<Permission> list = permissionDao.findPermissionByRoleId(role.getId());
					if(null != list && !list.isEmpty()){
						for(Permission permission:list){
							permissions.add(permission.getToken());
							System.out.println("��Ϊ�û�["+currentUsername+"]������["+role.getName()+"]��ɫ��["+role.getName()+":"+permission.getToken()+"]Ȩ��");  
						}
					}
				}
			}
		}else{  
			throw new AuthorizationException();  
		}
		SimpleAuthorizationInfo simpleAuthorInfo = new SimpleAuthorizationInfo();  
        simpleAuthorInfo.addRoles(roles);
        simpleAuthorInfo.addStringPermissions(permissions);  
        //ʵ���п��ܻ�������ע�͵����������ݿ�ȡ��  
        if(null!=currentUsername && "admin".equals(currentUsername)){  
            //���һ����ɫ,�������������ϵ����,����֤�����û�ӵ��admin��ɫ    
            simpleAuthorInfo.addRole("admin");  
            //���Ȩ��  
            simpleAuthorInfo.addStringPermission("admin:manage");  
            System.out.println("��Ϊ�û�["+currentUsername+"]������[admin]��ɫ��[admin:manage]Ȩ��");  
            return simpleAuthorInfo;  
        }
        //���÷���ʲô������ֱ�ӷ���null�Ļ�,�ͻᵼ���κ��û�����/admin/listUser.jspʱ�����Զ���ת��unauthorizedUrlָ���ĵ�ַ  
        //���applicationContext.xml�е�<bean id="shiroFilter">������  
        return simpleAuthorInfo;  
	}

	
	
	protected AuthenticationInfo doGetAuthenticationInfo(
			AuthenticationToken authcToken) throws AuthenticationException {
		UsernamePasswordToken token = (UsernamePasswordToken) authcToken;
		UserBean user = new UserBean();
		user.setLoginName(token.getUsername());
		user.setPasswd(new String(token.getPassword()));
		List<UserBean> list = userDao.login(user);
		if(!list.isEmpty()){
			return  new SimpleAuthenticationInfo(user.getLoginName(),  
	                user.getPasswd().toCharArray(), getName());
		}
		return null;
	}

}
