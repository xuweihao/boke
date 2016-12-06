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
							System.out.println("已为用户["+currentUsername+"]赋予了["+role.getName()+"]角色和["+role.getName()+":"+permission.getToken()+"]权限");  
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
        //实际中可能会像上面注释的那样从数据库取得  
        if(null!=currentUsername && "admin".equals(currentUsername)){  
            //添加一个角色,不是配置意义上的添加,而是证明该用户拥有admin角色    
            simpleAuthorInfo.addRole("admin");  
            //添加权限  
            simpleAuthorInfo.addStringPermission("admin:manage");  
            System.out.println("已为用户["+currentUsername+"]赋予了[admin]角色和[admin:manage]权限");  
            return simpleAuthorInfo;  
        }
        //若该方法什么都不做直接返回null的话,就会导致任何用户访问/admin/listUser.jsp时都会自动跳转到unauthorizedUrl指定的地址  
        //详见applicationContext.xml中的<bean id="shiroFilter">的配置  
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
