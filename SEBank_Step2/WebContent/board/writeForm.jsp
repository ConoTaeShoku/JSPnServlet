<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>[writeForm.jsp임]</title>

<script type="text/javascript">
function formCheck() {
	var title = document.getElementById('title');
	var content = document.getElementById('content');
	if (title.value.length == 0) {
		alert("제목을 입력하세요");
		return false;
	}
	if (content.value.length == 0) {
		alert('내용을 입력하세요');
		return false;
	}
	return true;
}
</script>

<style>
table, td {
    border: 1px solid black;
    text-align: center;
}
table {
    width: 80%;
}
.center {
    text-align: center;
}
</style>
</head>

<body>
<h2>[게시판 글 쓰기]</h2>
<br>
<%
	String myid = (String)session.getAttribute("custid");
%>
<form method="post">
	<input type="hidden" name="id" id="id" value="<%=myid%>" />
	<table align="center">
		<tr>
			<td>제목</td>
			<td><input type="text" name="title" id="title" style="width:98%;"/></td>
		</tr>
		<tr>
			<td>내용</td>
			<td><textarea rows=5 name="content" id="content" style="width:98%;"></textarea></td>
		</tr>
	</table><br>
	<div class="center">
		<input type="reset" value="다시 쓰기">
		<input type=submit formaction="bs?action=write" value="저장" onclick="return formCheck()">
		<input type=submit formaction="bs?action=main" value="board main">
		<input type=submit formaction="index.jsp" value="starting pg">		
	</div>
</form>
</body>
</html>