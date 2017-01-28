<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>[loginForm.jsp 임]</title>
</head>
<body>

<h1>[ 로그인 ]</h1>

<form method="post">
<table>
	<tr>
		<td>고객 ID</td>
		<td><input type="text" name="custid" id="custid" placeholder="ID 입력"/></td>
	</tr>
	<tr>
		<td>비밀번호</td>
		<td><input type="password" name="password" id="password" placeholder="Password 입력" /></td>
	</tr>
	<tr>
		<th colspan="2">
			<input type="submit" formaction="cs?action=login" value="로그인">
			<input type="reset" value="다시 쓰기">
			<input type="submit" formaction="index.jsp" value="index로">
		</th>
	</tr>
</table>
</form>

</body>
</html>
