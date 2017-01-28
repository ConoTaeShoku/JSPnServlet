<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import = "sebank.vo.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>[updateForm.jsp임]</title>

<script type="text/javascript">
function formCheck() {
	var pw = document.getElementById('password');
	var pw2 = document.getElementById('password2');
	var nm = document.getElementById('name');
	
	if (pw.value.length < 3 || pw.value.length > 10) {
		alert("비밀번호는 3~10자로 입력하세요.");
		return false;
	}
	if (pw.value != pw2.value) {
		alert('비밀번호를 정확하게 다시 입력하세요.');
		return false;
	}
	if (nm.value == '') {
		alert('이름을 입력하세요.');
		return false;
	}
	return true;
}
</script>

</head>
<body>
<%
	String loginId = (String) session.getAttribute("custid");
	Customer c = (Customer) request.getAttribute("customer");
%>
<h1>[ 회원 정보 수정 ]</h1>

<form method="post">
	<table>
		<tr>
			<td>고객 ID</td>
			<input type="hidden" name="custid" id="custid" value="<%= loginId %>"/>
			<td><%= loginId %></td>
		</tr>
		<tr>
			<td>비밀번호</td>
			<td><input type="password" name="password1" id="password1" placeholder="새로운 Password를 3~10자로 입력" value = "<%=c.getPassword()%>"/></td>
		</tr>
		<tr>
			<td>비밀번호 확인</td>
			<td><input type="password" name="password2" id="password2" placeholder="비밀번호를 다시 한번 입력" value = "<%=c.getPassword()%>"/></td>
		</tr>
		<tr>
			<td>이름</td>
			<td><input type="text" name="name" id="name" placeholder= "이름 입력" value ="<%=c.getName()%>" /></td>
		</tr>
		<tr>
			<td>E-mail</td>
			<td><input type="text" name="email" placeholder="E-mail 주소 입력" value="<%=c.getEmail()%>" /></td>
		</tr>
		<tr>
			<td>회원구분</td>
			<td>
			<% if (c.getDivision().equals("personal")) { %>
				<input type="radio" name="division" value="personal" checked />개인
				<input type="radio" name="division" value="company" />법인</td>
			<% } else if (c.getDivision().equals("company")) {%>
				<input type="radio" name="division" value="personal"/>개인
				<input type="radio" name="division" value="company" checked />법인</td>
			<% } %>
		</tr>
		<tr>
			<td>식별번호</td>
			<td><input type="text" name="idno" placeholder="개인:주민번호 /법인:사업자번호" value="<%=c.getIdno()%>" /></td>
		</tr>
		<tr>
			<td>주소</td>
			<td><input type="text" name="address" placeholder="주소입력" value ="<%=c.getAddress()%>" /></td>
		</tr>
		<tr>
			<th colspan="2">
				<input type="submit" formaction="cs?action=update" value="수정" onclick="return formCheck()">
				<input type="reset" value="다시 쓰기">
				<input type="submit" formaction="index.jsp" value="index로">
			</th>
		</tr>
	</table>
</form>

</body>
</html>