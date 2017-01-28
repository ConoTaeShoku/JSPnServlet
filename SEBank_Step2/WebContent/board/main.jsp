<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="sebank.vo.*,sebank.dao.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>[main.jsp임]</title>
</head>
<style>
table, th, td {
    border: 1px solid black;
    text-align: center;
}
</style>
<script>
function redirect() {
	window.location=document.getElementById('selectbpp').value;
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
	BoardDAO dao = new BoardDAO();
	String myid = (String) session.getAttribute("custid");
	int bpp = (int) session.getAttribute("bpp");
	int spg = (int) session.getAttribute("spg");
	if (myid==null) {
%>
		Guest님 (<a href='/SEBank_Step2/index.jsp'>go back to index</a>)<br>
<%
	} else {
%>
		<%=myid%>님 (<a href='/SEBank_Step2/index.jsp'>go back to index</a>)<br>
		내가 작성한 게시글 수 : <%=dao.myboardNum(myid)%> (<a href="/SEBank_Step2/bs?action=writeForm"> 새 글 등록</a>)<br>
		내가 작성한 댓글 수 : <%=dao.myreplyNum(myid) %><br>
<%
	}
%>
현재 page : <%=spg%>쪽<br><br>

<table align="center" width="80%">
<tr>
	<th bgcolor="#FAEBD7">글 번호</th>
	<th bgcolor="#FAEBD7">작성자 아이디</th>
	<th bgcolor="#FAEBD7">글 제목</th> 
	<th bgcolor="#FAEBD7">작성 날짜와 시간</th>
	<th bgcolor="#FAEBD7">조회수</th>
	<th bgcolor="#FAEBD7">댓글 수</th>
</tr>
<%
	int totpgs = dao.totpgs(bpp);
	int start = (spg - 1) * bpp +1;
	int end = spg * bpp;

	ArrayList<Board> boardList = dao.boardList();
	ArrayList<Board> thispage = dao.boardThispage(boardList, start, end);
	
	if (boardList.size()==0) {
%>
	<tr>
		<th colspan="5">
			<font color="DeepPink">아직 등록된 글이 없어요~</font>
		</th>
	</tr>
<%
	} else {
		int num = start;
		for (Board b : thispage) {
%>
<tr>
	<td><%= num %></td>
	<td><%= b.getId() %></td>
	<td><a href="/SEBank_Step2/bs?action=read&boardnum=<%=b.getBoardnum()%>"><%= b.getTitle() %></a></td>
	<td><%= b.getInputdate() %></td>
	<td><%= b.getHits() %></td>
	<td><%= dao.replyNum(b.getBoardnum()) %></td>
</tr>
<%
			num++;
		}
	}
%>
</table>

<br>

<div class="paging" align="center">
	<select id="selectbpp" onchange="redirect()">
		<option selected><%=bpp%></option>
		<option value="/SEBank_Step2/bs?action=setPage&spg=1&bpp=10">10</option>
		<option value="/SEBank_Step2/bs?action=setPage&spg=1&bpp=15">15</option>
		<option value="/SEBank_Step2/bs?action=setPage&spg=1&bpp=20">20</option>
		<option value="/SEBank_Step2/bs?action=setPage&spg=1&bpp=30">30</option>
	</select>
	<a href="/SEBank_Step2/bs?action=setPage&spg=1&bpp=<%=bpp%>"><span>◀◀first</span></a>
	<a href="/SEBank_Step2/bs?action=setPage&spg=<%=(spg-1)%>&bpp=<%=bpp%>"><span>◀before</span></a>
<%
	for (int i=0; i<totpgs; i++) {%>
    	<a href="/SEBank_Step2/bs?action=setPage&spg=<%=(i+1)%>&bpp=<%=bpp%>"><span><%=(i+1)%></span></a>
<%
	}
%>
	<a href="/SEBank_Step2/bs?action=setPage&spg=<%=(spg+1)%>&bpp=<%=bpp%>"><span>next▶</span></a>
	<a href="/SEBank_Step2/bs?action=setPage&spg=<%=totpgs%>&bpp=<%=bpp%>"><span>last▶▶</span></a>
</div>

<br>

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