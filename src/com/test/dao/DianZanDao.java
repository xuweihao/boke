package com.test.dao;

import java.util.Map;

import com.test.model.DianZan;

public interface DianZanDao extends BaseMapper<DianZan, Integer> {

	public String selectDianZan(Map map);
}
