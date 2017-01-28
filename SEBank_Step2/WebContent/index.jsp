<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>[index.jsp 임]</title>
</head>

<body>
<%
	String loginId = (String) session.getAttribute("custid");
	if (session.getAttribute("search") != null) {
		session.removeAttribute("search");
	}

%>
<h1>SES Bank Step 2 (Model 2)</h1>
<script>
	document.write(Date());
</script>

<ul>
<%
	session.setAttribute("bpp", 10); // number of boards per page
	session.setAttribute("spg", 1); // selected page number

	if (loginId == null) {
%>
		<h2>Guest</h2>
		<li><a href="cs?action=joinForm">회원가입</a></li>
		<li><a href="cs?action=loginForm">로그인</a><br>&nbsp;</li>
		<li><a href="bs?action=main">게시판</a></li>
<%
	} else {
%>
		<h2>Welcome, <%= loginId %>!!!</h2>
<%
		if (loginId.equals("admin")) {
%>
			<li><a href="cs?action=getlistAdmin">회원명단</a></li>
<%
		} else {
%>
			<li><a href="cs?action=updateForm">개인정보수정</a></li>
			<li><a href="cs?action=deleteForm">탈퇴</a></li>
<%
		}
%>
			<li><a href="cs?action=logout">로그아웃</a><br>&nbsp;</li>
			<li><a href="bs?action=main">게시판</a></li>		
<%
	}
%>
</ul>

</body>
</html>