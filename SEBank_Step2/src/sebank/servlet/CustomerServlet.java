package sebank.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import sebank.dao.CustomerDAO;
import sebank.vo.Customer;

@WebServlet("/cs")
public class CustomerServlet extends HttpServlet {

	private void showAlert(int result, PrintWriter out, String message) {
		switch (result) {
		case 0:
			out.println("<html><body><script>");
			out.println("alert('" + message + " 실패')");
			out.println("history.go(-1)");
			out.println("</script></body></html>");
			break;
		case 1:
			out.println("<html><body><script>");
			out.println("alert('" + message + " 성공')");
			out.println("location.href='index.jsp'");
			out.println("</script></body></html>");
			break;
		}
	}
	
	private void showAlert(int result, PrintWriter out, String message, String redirect) {
		switch (result) {
		case 0:
			out.println("<html><body><script>");
			out.println("alert('" + message + " 실패')");
			out.println("location.href='"+redirect+"'");
			out.println("</script></body></html>");
			break;
		case 1:
			out.println("<html><body><script>");
			out.println("alert('" + message + " 성공')");
			out.println("location.href='"+redirect+"'");
			out.println("</script></body></html>");
			break;
		}
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");

		PrintWriter out = response.getWriter();
		HttpSession session = request.getSession();
		String action = request.getParameter("action");

		CustomerDAO dao = new CustomerDAO();

		if (action == null) {
			return;

		} else if (action.equals("joinForm")) {
			request.getRequestDispatcher("customer/joinForm.jsp").forward(request, response);

		} else if (action.equals("idCheck")) {
			String id = request.getParameter("id");
			Customer c = dao.select(id);
			request.setAttribute("customer", c);
			request.setAttribute("id", id);
			request.getRequestDispatcher("customer/idCheck.jsp").forward(request, response);

		} else if (action.equals("join")) {
			Customer c = new Customer();
			c.setCustid(request.getParameter("custid"));
			c.setPassword(request.getParameter("password1"));
			c.setName(request.getParameter("name"));
			c.setEmail(request.getParameter("email"));
			c.setDivision(request.getParameter("division"));
			c.setIdno(request.getParameter("idno"));
			c.setAddress(request.getParameter("address"));
			showAlert(dao.insert(c), out, "회원가입");

		} else if (action.equals("loginForm")) {
			request.getRequestDispatcher("customer/loginForm.jsp").forward(request, response);

		} else if (action.equals("login")) {
			String custid = request.getParameter("custid");
			String password = request.getParameter("password");
			int cnt = dao.login(custid, password);
			if (cnt != 0) {
				session.setAttribute("custid", custid);
			}
			showAlert(cnt, out, "로그인");

		} else if (action.equals("logout")) {			
			session.invalidate();
			showAlert(1,out,"로그아웃");

		} else if (action.equals("updateForm")) {
			String custid = (String) session.getAttribute("custid");
			Customer c = dao.select(custid);
			request.setAttribute("customer", c);
			request.getRequestDispatcher("customer/updateForm.jsp").forward(request, response);

		} else if (action.equals("update")) {
			String custid = request.getParameter("custid");
			String password = request.getParameter("password1");
			String name = request.getParameter("name");
			String email = request.getParameter("email");
			String division = request.getParameter("division");
			String idno = request.getParameter("idno");
			String address = request.getParameter("address");
			Customer c = new Customer(custid, password, name, email, division, idno, address);
			showAlert(dao.update(c), out, "회원수정");

		} else if (action.equals("deleteForm")) {
			request.getRequestDispatcher("customer/deleteForm.jsp").forward(request, response);

		} else if (action.equals("delete")) {
			String custid = (String) session.getAttribute("custid");
			int cnt = dao.delete(custid);
			if (cnt != 0) {
				session.invalidate();
			}
			showAlert(cnt, out, "회원삭제");

		} else if (action.equals("deleteAdmin")) {
			String id = (String) request.getParameter("did");
			showAlert(dao.delete(id), out, "회원삭제", "cs?action=getlistAdmin");

		} else if (action.equals("getlistAdmin")) {
			request.getRequestDispatcher("customer/getlistAdmin.jsp").forward(request, response);
		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
