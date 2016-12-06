package com.test.dao;

import java.util.List;

import com.test.model.RoleBean;

public interface RoleDao extends BaseMapper<RoleBean, Integer> {

	public List<RoleBean> findRoleByUserId(int id);
}
