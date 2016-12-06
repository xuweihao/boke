package com.test.dao;

import java.util.List;
import java.util.Map;

import com.test.model.Text;

public interface TextDao extends BaseMapper<Text, Integer>{

	public List<Text> selectTextByUserId(Map map);
	
	public List<Text> selectTiWenByUserId(Map map);
	
	public int selectCountByUserId(int UserId);
	
	public List<Text> findEntityMost(int type);
	
	public List<Text> selectThingByType(Map map);
	
	public List<Text> selectThingByType2(Map map);
	
	public int selectCountByType(int type);
}
