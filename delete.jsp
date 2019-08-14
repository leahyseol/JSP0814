<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 삭제</title>
</head>
<body>

<%
// 세션값 가져오기
String id = (String) session.getAttribute("id");
// 세션값 없으면 loginForm.jsp 이동
if (id == null) {
	response.sendRedirect("loginForm.jsp");
	return;
}
%>

<h1>회원정보 삭제</h1>

<form action="deleteProcess.jsp" method="post">
	아이디: <input type="text" value="<%=id %>" disabled /><br>
	패스워드: <input type="password" name="passwd" /><br>
	<button type="submit">회원 삭제하기</button>
</form>

</body>
</html>
    