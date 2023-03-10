package com.acorn.project.faq.dao;

import java.util.List;

import com.acorn.project.faq.dto.FaqDto;

public interface FaqDao {
	//글목록
	public List<FaqDto> getList(FaqDto dto);
	//글의 갯수
	public int getCount(FaqDto dto);
	//글 추가
	public void insert(FaqDto dto);
	//글 삭제
	public void delete(int num);
	//글 수정
	public void update(FaqDto dto);
	
	public FaqDto getData(int num);
	
	public FaqDto getData(FaqDto dto);
}
