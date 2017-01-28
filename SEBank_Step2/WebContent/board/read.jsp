<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="sebank.vo.*,sebank.dao.*, java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>[read.jsp임]</title>

<script type="text/javascript">
function replyUpdateFormOpen(replyNum, boardNum) {
	window.open("/SEBank_Step2/board/replyUpdateForm.jsp?replynum="+replyNum+"&boardnum="+boardNum,"replyUpdateForm", "top=200, left=400, width=400, height=250");
}
function replyformCheck() {
	var text = document.getElementById('replytext');
	if (text.value.length == 0) {
		alert('내용을 입력하세요');
		return false;
	}
	return true;
}
</script>

<style>
table, th, td {
    text-align: center;
	vertical-align: center;
}
</style>

</head>
<body>
<h2>[선택한 글 읽기]</h2>
<br>

<%
	String myid=(String) session.getAttribute("custid");
	Board thisBoard= (Board) session.getAttribute("thisBoard");
%>

<form id="boardRead" action="/SEBank_Step2/bs" method="post">
<div align="center">
<table  width="80%" border="1">
	<tr>
		<td bgcolor="#FAEBD7">제목</td>
		<td>
			<input type="text" name="title" id="title" style="width:98%;" value= "<%=thisBoard.getTitle()%>" readonly/>
		</td>
	</tr>
	<tr>
		<td bgcolor="#FAEBD7">내용</td>
		<td>
			<textarea rows=5 name="content" id="content" style="width:98%;" readonly><%=thisBoard.getContent()%></textarea>
		</td>
	</tr>
</table>
</div>
<br>
	<div align="center">
<%
	if (myid!=null) {
		if (myid.equals(thisBoard.getId()) || myid.equals("admin")) {
%>
		<table border="0">
			<tr>
				<td width="40%"></td>
				<td width="20%">
					<input type=submit formaction="/SEBank_Step2/bs?action=updateForm" value='수정' />
					<input type=submit formaction="/SEBank_Step2/bs?action=delete" value='삭제' /></td>
				<td width="30%"></td>
				<td width="10%"><input type=submit formaction="bs?action=main" value='목록으로' /></td>
			</tr>
		</table>
<%
		} else {
%>
			<input type=submit formaction="/SEBank_Step2/bs?action=main" value='목록으로' />
<%
		}
	} else {
%>
		<input type=submit formaction="/SEBank_Step2/bs?action=main" value='목록으로' />
<%
	}
%>
	</div></form><br><br>

<%
	if (myid!=null) {
%>
<div align="center">
<form action="/SEBank_Step2/bs" method="post" onsubmit="return replyformCheck()">
	<input type="hidden" name="action" value="replyInsert" />
	<input type=text name="replytext" id="replytext" placeholder="댓글 입력">
	<input type=submit value='리플달기'>
</form>
</div><br><br>
<%
	}
%>

<div align="center">
<%
	ArrayList<Reply> replyList = new BoardDAO().replyList(thisBoard.getBoardnum());	
	if (replyList.size()==0) {
%>
		<font color="DeepPink">아직 등록된 댓글이 없어요~</font>
<%	
	} else {
%>
<table width="50%">
	<tr>
		<th bgcolor="#6495ED">ID</th>
		<th bgcolor="#6495ED">댓글</th>
		<th bgcolor="#6495ED">action(s)</th>
	</tr>
<%
		for (Reply r : replyList) {
%>
	<tr>
		<td> <%=r.getId()%> </td>
		<td id="<%=r.getReplynum()%>"> <%=r.getText()%> </td>
		<td>
	<%
	if (myid!=null) {%>
		<form method="get">
	<%	if (myid.equals(r.getId())) { %>
			<input type="button" value="수정" onClick="return replyUpdateFormOpen(<%=r.getReplynum()%>,<%=r.getBoardnum()%>);">
	<%	}if (myid.equals(r.getId()) || myid.equals("admin")) { %>
			<input type=submit formaction="/SEBank_Step2/bs?action=replyDelete&replynum=<%=r.getReplynum()%>" formmethod="post" value='삭제'>
	<%	}%>
		</form>
<%	} %>
		</td>
	</tr>
<%		}%>
	</table>
<%
	}
%>
</div>

</body>
</html>