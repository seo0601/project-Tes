package com.acorn.project.lecture.service;

import java.io.File;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;


import com.acorn.project.lecture.dto.LectureDto;
import com.acorn.project.lecture.dto.LectureReq;
import com.acorn.project.lecture.dto.LectureRes;
import com.acorn.project.lectureReview.dao.LectureReviewDao;
import com.acorn.project.lectureReview.dto.LectureReviewDto;
import com.acorn.project.lectureStudent.dao.LectureStudentDao;
import com.acorn.project.lectureStudent.dto.LectureStudentDto;
import com.acorn.project.letcure.dao.LectureDao;


@Service
public class LectureServiceImpl implements LectureService{

	@Autowired LectureDao lectureDao;
	@Autowired LectureReviewDao reviewDao;
	@Autowired LectureStudentDao studentDao;

	
	@Value("${file.location}")
	private String fileLocation;
	
	@Override
	public Map<String, Object> LectureList(int pageNum, String large_category, String small_category) {
		
		final int PAGE_ROW_COUNT=8;
		final int PAGE_DISPLAY_COUNT=5;
	   
		int num = 1;
		String strPageNum = Integer.toString(pageNum);
		if(strPageNum != null){
			pageNum=Integer.parseInt(strPageNum);
		}
	   
		int startRowNum = 1 + (pageNum-1) * PAGE_ROW_COUNT;
		int endRowNum = pageNum * PAGE_ROW_COUNT;
	   
		LectureDto dto = new LectureDto();
		dto.setStartRowNum(startRowNum);
		dto.setEndRowNum(endRowNum);
		dto.setLarge_category(large_category);
		dto.setSmall_category(small_category);
	   
		List<LectureDto> list = lectureDao.LectureList(dto);
	   
		int startPageNum = 1 + ((pageNum-1)/PAGE_DISPLAY_COUNT) * PAGE_DISPLAY_COUNT;
		int endPageNum = startPageNum + PAGE_DISPLAY_COUNT - 1;
	   
		int totalRow = lectureDao.getCount();
		int totalPageCount = (int)Math.ceil(totalRow / (double)PAGE_ROW_COUNT);
		if(endPageNum > totalPageCount){
			endPageNum = totalPageCount;  
		}
		
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("large_category", large_category);
		map.put("small_category", small_category);
		map.put("pageNum", pageNum);
		map.put("startPageNum", startPageNum);
		map.put("endPageNum", endPageNum);
		map.put("totalPageCount", totalPageCount);
		map.put("totalRow", totalRow);
		map.put("list", list);
		return map;
		
	}
	

	@Override
	public Map<String, String> insert(LectureRes lectureRes) {
		lectureDao.insert(lectureRes);
		Map<String, String> map = new HashMap<>();
		map.put("isSuccess", "success");
		return map;
	}

	@Override
	public Map<String, Object> getDetail(int num, String ref_group) {

		lectureDao.addViewCount(num);

		LectureDto dto=new LectureDto();
		dto.setNum(num);

		LectureDto resultDto=lectureDao.getData(num);
		
		
		final int PAGE_ROW_COUNT=10;
	
		//detail.jsp ?????????????????? ?????? 1???????????? ?????? ????????? ????????????. 
		int pageNum=1;
	
		//????????? ???????????? ?????? ROWNUM
		int startRowNum=1+(pageNum-1)*PAGE_ROW_COUNT;
		//????????? ???????????? ??? ROWNUM
		int endRowNum=pageNum*PAGE_ROW_COUNT;
	
		//????????? ???????????? ???????????? ???????????? ?????? ?????? ????????? ????????????.
		LectureReviewDto commentDto=new LectureReviewDto();
		commentDto.setRef_group(num);
		//1???????????? ???????????? startRowNum ??? endRowNum ??? dto ??? ?????????  
		commentDto.setStartRowNum(startRowNum);
		commentDto.setEndRowNum(endRowNum);
		
		//1???????????? ???????????? ?????? ????????? select ????????? ??????. 
		List<LectureReviewDto> commentList=reviewDao.getList(commentDto);
		
		//????????? ???????????? ???????????? ?????? ????????? ????????? ????????????.
		int totalRow=reviewDao.getCount(num);
		//?????? ?????? ???????????? ??????
		int totalPageCount=(int)Math.ceil(totalRow/(double)PAGE_ROW_COUNT);
				
		LectureStudentDto lsDto = new LectureStudentDto();		
		LectureStudentDto lsDto2  = studentDao.studentData(lsDto);
		
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("dto", resultDto);
		map.put("ref_group", ref_group);
		return map;
		
	}

	@Override
	public void saveImage(LectureDto dto, HttpServletRequest request) {
		//???????????? ????????? ????????? ????????? ?????? MultipartFile ????????? ???????????? ????????????
		MultipartFile image = dto.getImage();
		//?????? ????????? -> ????????? ?????? ?????? ?????????????????? ?????????
		String orgFileName = image.getOriginalFilename();
		//?????? ?????? -> ??????????????? ????????????, ???????????? ?????? ??????.
		long fileSize = image.getSize();
		
		// ????????? ????????? ??????????????? ?????? ??????
		String realPath = fileLocation;
		//db ??? ????????? ????????? ????????? ?????? ??????
		String filePath = realPath + File.separator;
		//??????????????? ?????? ?????? ?????? ??????
		File upload = new File(filePath);
		if(!upload.exists()) {
			//?????? ??????????????? ????????????X
			upload.mkdir();//?????? ??????
		}
		//????????? ????????? ????????? ????????????. -> ????????? ?????? ?????????????????????.
		String saveFileName = System.currentTimeMillis() + orgFileName;
		
		try {
			//upload ????????? ????????? ????????????.
			image.transferTo(new File(filePath + saveFileName));
			System.out.println();	//?????? ??????
		}catch(Exception e) {
			e.printStackTrace();
		}
		String id = (String)request.getSession().getAttribute("id");
		dto.setWriter(id);
	
		dto.setImagePath(saveFileName);
		
		
		

	}

	@Override
	public Map<String, String> updateContent(LectureReq lectureReq) {
	
		lectureDao.update(lectureReq);
		Map<String, String> map = new HashMap<String, String>();
		map.put("isSuccess","success");
		return map;
	}
	

	@Override
	public Map<String, String> deleteContent(int num) {
		lectureDao.delete(num);
		Map<String, String> map = new HashMap<String, String>();
		map.put("isSuccess","success");
				
		return map;
	}

	@Override
	public Map<String, Object> getData(int num) {
		LectureDto dto=lectureDao.getData(num);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("isSuccess","success");
		map.put("dto", dto);
		
		return map;	
		
	}

	

	@Override
	public Map<String, Object> uploadImage(LectureDto dto, HttpServletRequest request) {
		//???????????? ????????? ????????? ????????? ?????? MultipartFile ????????? ???????????? ????????????
		MultipartFile image = dto.getImage();
		//?????? ????????? -> ????????? ?????? ?????? ?????????????????? ?????????
		String orgFileName = image.getOriginalFilename();
		//?????? ??????
		long fileSize = image.getSize();
		
		// webapp/upload ?????? ????????? ?????? ??????(????????? ?????? ????????? ???????????? ??????)
		String realPath = request.getServletContext().getRealPath("/resources/upload");
		//db ??? ????????? ????????? ????????? ?????? ??????
		String filePath = realPath + File.separator;
		//??????????????? ?????? ?????? ?????? ??????
		File upload = new File(filePath);
		if(!upload.exists()) {
			//?????? ??????????????? ????????????X
			upload.mkdir();//?????? ??????
		}
		//????????? ????????? ????????? ????????????. -> ????????? ?????? ?????????????????????.
		String saveFileName = System.currentTimeMillis() + orgFileName;
		
		try {
			//upload ????????? ????????? ????????????.
			image.transferTo(new File(filePath + saveFileName));
			System.out.println();	//?????? ??????
		}catch(Exception e) {
			e.printStackTrace();
		}

		String imagePath = "/resources/upload/" + saveFileName;
		
		//ajax upload ??? ?????? imagePath return
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("imagePath", imagePath);
		
		return map;
	}


}
