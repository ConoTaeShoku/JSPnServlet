package sebank.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import sebank.dao.BoardDAO;
import sebank.vo.Board;
import sebank.vo.Reply;

@WebServlet("/bs")
public class BoardServlet extends HttpServlet {

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
			out.println("location.href='bs?action=main'");
			out.println("</script></body></html>");
			break;
		}
	}

	private void showAlert(boolean isReply, int result, PrintWriter out, String message) {
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
			out.println("location.href='bs?action=read'");
			out.println("</script></body></html>");
			break;
		}
	}

	private void movePage(PrintWriter out, String message, String href) {
		out.println("<html><body><script>");
		out.println("alert('" + message + "성공')");
		out.println("location.href='" + href + "'");
		out.println("</script></body></html>");
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");

		PrintWriter out = response.getWriter();
		HttpSession session = request.getSession();
		String action = request.getParameter("action");

		BoardDAO dao = new BoardDAO();
		String myid = (String) session.getAttribute("custid");

		if (action == null) {
			return;

		} else if (action.equals("main")) {
			request.getRequestDispatcher("board/main.jsp").forward(request, response);

		} else if (action.equals("setPage")) {
			int spg = Integer.parseInt(request.getParameter("spg"));
			int bpp = Integer.parseInt(request.getParameter("bpp"));
			if (spg < 1 || spg > dao.totpgs(bpp)) {
				if (session.getAttribute("search") != null) {
					movePage(out, "이동불가능!", "bs?action=search");
				}
				movePage(out, "이동불가능!", "bs?action=main");
			} else {
				session.setAttribute("bpp", bpp);
				session.setAttribute("spg", spg);
				if (session.getAttribute("search") != null) {
					response.sendRedirect("bs?action=search");
				}
				response.sendRedirect("bs?action=main");
			}

		} else if (action.equals("writeForm")) {
			request.getRequestDispatcher("board/writeForm.jsp").forward(request, response);

		} else if (action.equals("write")) {
			Board b = new Board();
			b.setId(request.getParameter("id"));
			b.setTitle(request.getParameter("title"));
			b.setContent(request.getParameter("content"));
			showAlert(dao.boardInsert(b), out, "등록");

		} else if (action.equals("read")) {
			int bnum = Integer.parseInt(request.getParameter("boardnum"));
			Board b = dao.boardRead(bnum);
			session.setAttribute("thisBoard", b);
			if (dao.addHits(bnum) != 1) {
				movePage(out, "조회수error!", "bs?action=main");
			}
			request.getRequestDispatcher("board/read.jsp").forward(request, response);

		} else if (action.equals("updateForm")) {
			request.getRequestDispatcher("board/updateForm.jsp").forward(request, response);

		} else if (action.equals("update")) {
			Board b = (Board) session.getAttribute("thisBoard");
			int bnum = b.getBoardnum();
			b.setTitle(request.getParameter("title"));
			b.setContent(request.getParameter("content"));
			int cnt = dao.boardUpdate(b);
			session.setAttribute("thisBoard", dao.boardRead(bnum));
			showAlert(cnt, out, "수정");

		} else if (action.equals("delete")) {
			Board b = (Board) session.getAttribute("thisBoard");
			showAlert(dao.boardDelete(b.getBoardnum()), out, "삭제");
			session.removeAttribute("thisBoard");

		} else if (action.equals("search")) {
			int method = Integer.parseInt(request.getParameter("smethod"));
			String text = request.getParameter("stext");
			session.setAttribute("method", method);
			session.setAttribute("text", text);
			request.getRequestDispatcher("board/search.jsp").forward(request, response);

		} else if (action.equals("replyInsert")) {
			Board b = (Board) session.getAttribute("thisBoard");
			String rtxt = request.getParameter("replytext");
			Reply r = new Reply(b.getBoardnum(), myid, rtxt);
			dao.replyInsert(r);
			movePage(out, "댓글등록", "bs?action=read&boardnum=" + b.getBoardnum());

		} else if (action.equals("replyUpdate")) {
			Board b = (Board) session.getAttribute("thisBoard");
			int rnum = Integer.parseInt(request.getParameter("replynum"));
			String rtxt = request.getParameter("replytext");
			dao.replyUpdate(rnum, rtxt);
			movePage(out, "댓글수정", "/SEBank_Step2/board/replyUpdateForm.jsp");

		} else if (action.equals("replyDelete")) {
			Board b = (Board) session.getAttribute("thisBoard");
			int rnum = Integer.parseInt(request.getParameter("replynum"));
			dao.replyDelete(rnum);
			movePage(out, "댓글삭제", "bs?action=read&boardnum=" + b.getBoardnum());
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
