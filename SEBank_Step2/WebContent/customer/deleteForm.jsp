<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="sebank.vo.*,sebank.dao.*, java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>[deleteForm.jsp 임]</title>
</head>
<body>
<%
	CustomerDAO dao = new CustomerDAO();
	String myid = (String) session.getAttribute("custid");
	Customer c = dao.select(myid);
%>
<script type="text/javascript">
function pwCheck() {
	var pw = document.getElementById('password');
	if (pw.value != <%=c.getPassword()%>) {
		pw.value = "";
		alert('탈퇴 실패(wrong password)');
		return false;
	}
	return true;
}
</script>
<style>
.input {
    position: relative;
    left: 20%;
    top: 50px;
}
</style>
<form class="input" method="post">
	<input type="password" name="password" id="password" placeholder="비밀번호를 입력하세요" />
	<input type="submit" formaction="cs?action=delete" value="탈퇴" onclick="return pwCheck();"/>
	<input type="submit" formaction="index.jsp" value="index로">
</form>

</body>
</html>