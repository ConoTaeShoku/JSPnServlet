<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="sebank.vo.*,sebank.dao.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>[search.jsp임]</title>
</head>

<style>
table, td, th{
    border: 1px solid black;
    text-align: center;
}

</style>

<script>
function redirect() {
	window.location=document.getElementById('selectBnumperpage').value;
}
function searchformCheck() {
	var stext = document.getElementById('stext');
	if (stext.value.length == 0) {
		alert('검색내용을 입력하세요.');
		return false;
	}
	return true;
}
</script>

<body>
<h1>[ 게시판 ]</h1>
<%
	session.setAttribute("search", "yesss");
	String myid = (String) session.getAttribute("custid");

	int method = (int) session.getAttribute("method");
	session.removeAttribute("method");
	String text = (String) session.getAttribute("text");
	session.removeAttribute("text");

%>
<div>
	<br><a href='index.jsp'>index page로 돌아가기!</a>
	<br><a href='board/main.jsp'>board main으로 돌아기기!</a>
</div><br><br>

<table align="center">
<tr>
	<th bgcolor="#FAEBD7" width="5%">글 번호</th>
	<th bgcolor="#FAEBD7" width="15%">작성자 아이디</th>
	<th bgcolor="#FAEBD7" width="15%">글 제목</th> 
	<th bgcolor="#FAEBD7">글 내용</th>
	<th bgcolor="#FAEBD7" width="15%">작성 날짜와 시간</th>
	<th bgcolor="#FAEBD7" width="5%">조회수</th>
</tr>
<%
	BoardDAO dao = new BoardDAO();
	ArrayList<Board> bList = dao.boardSearchList(method,text);
	
	if (bList.size()==0) {
%>
	<tr>
		<th colspan="6">
			<font color="DeepPink">검색된 글이 없어요~</font>
		</th>
	</tr>
<%
	} else {
		
		int num = 1;
		for (Board b : bList) {
%>
<tr>
	<td><%= num %></td>
	<td><%= b.getId() %></td>
	<td>
		<a href="/SEBank_Step2/bs?action=read&boardnum=<%=b.getBoardnum()%>">
			<%= b.getTitle() %>
		</a>
	</td>
	<td><%= b.getContent() %></td>
	<td><%= b.getInputdate() %></td>
	<td><%= b.getHits() %></td>
</tr>
<%
			num++;
		}
	}
%>
</table><br><br>

<form method="post">
	<div class="searching" align="center">
		<select name="smethod" id="smethod">
			<option value="1" checked>제목</option>
			<option value="2">내용</option>
			<option value="3">제목+내용</option>
		</select>
		<input type="text" name="stext" id="stext" placeholder="검색 내용 입력" />
		<input type="submit" formaction="/SEBank_Step2/bs?action=search" value="검색 " onclick="return searchformCheck()"/>
	</div>
</form>

</body>
</html>
