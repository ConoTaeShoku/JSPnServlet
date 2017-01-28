<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="sebank.vo.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>[idCheck.jsp 임]</title>

<script type="text/javascript">
function formCheck() {
	var id = document.getElementById('id');
	if (id.value.length < 3 || id.value.length > 10) {
		alert('ID는 3~10자로 입력하세요.');
		return false;
	}
	return true;
}
function isSelected(id) {
	opener.document.getElementById("custid").value=id;
	this.close();
}
</script>

</head>
<body>

<form action="/SEBank_Step2/cs?action=idCheck" method="post" onsubmit="return formCheck()">
	<input type="text" name="id" id="id" placeholder="검색할 아이디 입력" />
	<input type="submit" value="검색" />
</form><br>

<font color="DeepPink">
<%
	if (request.getMethod().equalsIgnoreCase("GET")) return;

	Customer c = (Customer) request.getAttribute("customer");
	String id = (String) request.getAttribute("id");

	if (c == null) {
%>
	<%= id %> : 사용할 수 있는 ID입니다. 
	<input type="button" value="use" onClick="isSelected('<%=id%>')">
<%
	} else {
%>
	<%= id %> : 이미 사용 중인 ID입니다.
<%
	}
%>
</font>

</body>
</html>