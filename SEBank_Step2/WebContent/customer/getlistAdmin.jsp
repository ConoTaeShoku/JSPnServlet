<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="sebank.vo.*,sebank.dao.*, java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>[getlistAdmin.jsp]</title>
</head>
<style>
table {
    text-align: center;
	vertical-align: center;
}
</style>
<body>
<%
	CustomerDAO dao = new CustomerDAO();
	ArrayList<Customer> clist = new ArrayList<>();
	clist = dao.list();
	//boolean a = clist.remove(dao.select("admin")); //false
	//clist.remove(clist.indexOf(dao.select("admin"))); //java.lang.ArrayIndexOutOfBoundsException: -1
	//int size = clist.size(); //dao.totnum()
	int size = clist.size() - 1;
%>
<div align="center">
<%if (size==0) {%>
	<h2>Admin 밖에 없음~</h2>
<%} else { %>
	<h2>Total <%=size%> Customers</h2>
<%}%>

<table border="1">
<tr>
	<th width="15%" bgcolor="#FAEBD7">번호</th>
	<th width="15%" bgcolor="#FAEBD7">아이디</th>
	<th width="15%" bgcolor="#FAEBD7">비밀번호</th>
	<th width="15%" bgcolor="#FAEBD7">삭제</th>
</tr>
<%	
if (clist.size()==1) {
%>
<tr>
	<th colspan="4">
		<font color="DeepPink">가입한 회원이 없어요!</font>
	</th>
</tr>
<%
} else {
	int num = 1;
	for (Customer c : clist) {
		if (!c.getCustid().equals("admin")) {
%>
<tr>
	<td><%= num %></td>
	<td><%= c.getCustid()%></td>
	<td><%= c.getPassword()%></td>
	<td><a href="cs?action=deleteAdmin&did=<%=c.getCustid()%>">없애기</a></td>
</tr>
<%
		num++;
		}
	}
}
%>
</table><br><br>

<a href='index.jsp'>go back to index</a><br>
</div>
</body>
</html>