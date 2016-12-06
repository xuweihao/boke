package com.test.dao;

import java.util.List;

import com.test.model.Permission;

public interface PermissionDao extends BaseMapper<Permission, Integer> {

	public List<Permission> findPermissionByRoleId(int id);
}
