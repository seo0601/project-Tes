<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<script>
	   alert("${param.id}회원님 수강신청되었습니다!");
	   location.href="${pageContext.request.contextPath}/lecture/frontend/frontendList";
	</script>
</body>
</html>