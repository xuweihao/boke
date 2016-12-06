package com.test.dao;

import java.util.List;

public interface BaseMapper<T,PK> {
	/**
	 * 通过id查询
	 * @param id
	 * @return
	 */
	public T findEntityById(PK id);
	
	/**
	 * 查询数量
	 * @param obj
	 * @return
	 */
	public Integer findCount(T t);
	
	
	/**
	 * 查询全部
	 * @param obj
	 * @return
	 */
	public List<T> findEntity(Object obj);
	
	
	/**
	 * 条件查询
	 * @param obj
	 * @return
	 */
	public List<T> findLikeEntity(Object obj);
	
	
	/**
	 * 新增
	 * @param t
	 */
	public int insertEntity(T t);
	
	
	/**
	 * 更新
	 * @param t
	 */
	public int updateEntityById(T t);
	
	
	/**
	 * 通过id删除
	 * @param id
	 */
	public int deleteEntityById(PK id);
	
	
	/**
	 * 条件删除
	 * @param obj
	 */
	public int deleteEntityByCondition(Object obj);
	
}
