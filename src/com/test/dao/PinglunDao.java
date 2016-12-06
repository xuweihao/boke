package com.test.dao;

import java.util.List;
import java.util.Map;

import com.test.model.Pinglun;

public interface PinglunDao extends BaseMapper<Pinglun, Integer> {

	public List<Pinglun> findPinglunByTextId(int id);
	
	public List<Pinglun> findPinglunByNO(int id);
	
	public int insertHuifu(Pinglun pl);
	
	public List<Pinglun> findPinglunByUser(Map map);
	
	public int selectPLCountByUser(int userId);
}
