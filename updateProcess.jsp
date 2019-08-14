<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	//Bring session
	String id = (String) session.getAttribute("id");
	// 세션값 없으면 loginForm.jsp 이동
	if (id == null) {
		response.sendRedirect("loginForm.jsp");
		return;
	}
%>

<%
	// post 파라미터값 한글처리
	request.setCharacterEncoding("utf-8");
	// Bring parameter value
	String passwd = request.getParameter("passwd");
	String name = request.getParameter("name");

	String strAge = request.getParameter("age");
	Integer age = null;
	if (strAge != null) {
		age = Integer.parseInt(strAge);
	}

	String gender = request.getParameter("gender");

	String email = request.getParameter("email");
	if (email.equals("")) {
		email = null;
	}
%>

<%
	//DB접속정보
	String url = "jdbc:oracle:thin:@localhost:1521:xe";
	String user = "scott";
	String password = "tiger";

	//1단계: DB 드라이버 로딩
	Class.forName("oracle.jdbc.OracleDriver");
	//2단계: DB연결
	Connection con = DriverManager.getConnection(url, user, password);
	//3단계: sql문 준비
	String sql = "SELECT passwd FROM member WHERE id = ?";
	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setString(1, id);
	//4th: sql execute
	ResultSet rs = pstmt.executeQuery();
	//5th: rs use
	// rs data exist => 
	// 			compare passwd => update
	//			wrong -> wrong password -> go back
	if (rs.next()) {
		if (passwd.equals(rs.getString("passwd"))) {
			pstmt.close(); // select문 가진 pstmt 객체 닫기

			// update문 수행. id에 해당하는 name age gender email 수정
			sql = "UPDATE member SET name=?, age=?, gender=?, email=? WHERE id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, name);
			pstmt.setObject(2, age); // Integer값으로 설정
			pstmt.setString(3, gender);
			pstmt.setString(4, email);
			pstmt.setString(5, id);
			// 실행
			pstmt.executeUpdate();
			// main.jsp로 이동
		} else {
		%>
		<script>
			alert('wrong passwd');
			history.back();
		</script>
		<%
	}
}
%>