<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>views/lecture/detail.jsp</title>
</head>
<body>
	<div class="container">
		<a href="${pageContext.request.contextPath}/lecture/updateform?num=${dto.lectureNum }">수정</a>
        <a href="javascript:" onclick="deleteConfirm()">삭제</a>
        <script>
            function deleteConfirm(){
               const isDelete=confirm("이 글을 삭제 하겠습니까?");
               if(isDelete){
                  location.href="${pageContext.request.contextPath}/lecture/delete?num=${dto.lectureNum}";
               }
            }
        </script>
		<div>
			<img style="width:100px; height:100px;" src="${pageContext.request.contextPath }/lecture/images/${dto.imagePath}">
		</div>
		<div>
			<a href="">수강 신청</a>
			<a href="${pageContext.request.contextPath}/qna_board/list"  target="_blank">1:1 문의</a>	
		</div>
		
		<div>					   
	    	<p>${dto.describe}</p>
  	    </div>
  	   
		
		<iframe width="560" height="315" src="${dto.videoPath }" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
	</div>
</body>
</html>