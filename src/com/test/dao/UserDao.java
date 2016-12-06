package com.test.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.test.model.UserBean;

public interface UserDao extends BaseMapper<UserBean, Integer>{

	public UserBean findUserByName(String loginName);
	
	public List<UserBean> login(UserBean user);
	
	public List<UserBean> selectUserMost();
	
	public int updateUserById(UserBean user);
	
	public int selectHYbyDate(@Param(value = "time") String time,@Param(value = "id") int id);
}
