<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="sebank.vo.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>[updateForm.jsp임]</title>

<script type="text/javascript">
function formCheck() {
	var title = document.getElementById('title');
	var content = document.getElementById('content');
	if (title.value.length = 0) {
		alert("제목을 입력하세요");
		return false;
	}
	if (content.value.length = 0) {
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
</style>

</head>

<body>
<h2>[내 글 수정하기]</h2>
<br>

<%
	Board thisBoard= (Board) session.getAttribute("thisBoard");
%>

<form id="updateForm" action="bs" method="post" onsubmit="return formCheck()">
	<input type="hidden" name="action" value="update" />

<table align="center">
	<tr>
		<td bgcolor="#FAEBD7">제목</td>
		<td><input type="text" name="title" id="title" style="width:98%;"
			value="<%=thisBoard.getTitle()%>"/></td>
	</tr>
	<tr>
		<td bgcolor="#FAEBD7">내용</td>
		<td><textarea rows=5 name="content" id="content" style="width:98%;"><%=thisBoard.getContent()%></textarea>
		</td>
	</tr>
</table>

<br>

<div class="buttons" align="center">
	<input type=submit value='저장'>
	<input type=reset value='초기화'>
</div>

</form>
</body>
</html>