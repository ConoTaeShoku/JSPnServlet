<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>[replyUpdateForm.jsp 임]</title>
<script type="text/javascript">
function formCheck() {
	var text = document.getElementById('replytext');
	if (text.value.length == 0) {
		alert('내용을 입력하세요');
		return false;
	}
	return true;
}
function isSelected(id) {
	opener.location.href = '/SEBank_Step2/bs?action=read&boardnum=<%=session.getAttribute("boardnum")%>';
	this.close();
}
</script>
</head>
<body>
<form method="post">
	<input type="text" name="replytext" id="replytext" placeholder="수정할 댓글 내용 입력" />
	<input type=submit formaction="/SEBank_Step2/bs?action=replyUpdate&replynum=<%=session.getAttribute("replynum")%>" value="수정" onclick="return replyformCheck()">
	<input type="button" value="종료" onClick="isSelected()">
</form><br>
<%
	if (request.getMethod().equalsIgnoreCase("GET")) {
		String rnum = (String) request.getParameter("replynum");
		String bnum = (String) request.getParameter("boardnum");
		if (rnum != null) {
			session.setAttribute("replynum", rnum);
		}
		if (bnum != null) {
			session.setAttribute("boardnum", bnum);
		}
		return;
	}
%>
</body>
</html>