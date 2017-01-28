package sebank.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import sebank.vo.Board;
import sebank.vo.Reply;

public class BoardDAO {

	// ***** BOARD

	public int myboardNum(String id) {
		try {
			Connection con = ConnectionManager.getConnection();
			String sql = "select count(boardnum) from board2 where id = ?";
			PreparedStatement stat = con.prepareStatement(sql);
			stat.setString(1, id);
			ResultSet res = stat.executeQuery();
			while (res.next()) {
				return res.getInt("count(boardnum)");
			}
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

	public int totnum() {
		try {
			Connection con = ConnectionManager.getConnection();
			String sql = "select count(boardnum) from board2";
			PreparedStatement stat = con.prepareStatement(sql);
			ResultSet res = stat.executeQuery();
			while (res.next()) {
				return res.getInt("count(boardnum)");
			}
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

	public int totpgs(int bnum) {
		int tot = totnum();
		int totpgs = 0;
		if (tot == 0) {
			totpgs = 1;
		}
		if (tot % bnum == 0) {
			totpgs = tot / bnum;
		} else {
			totpgs = tot / bnum + 1;
		}
		return totpgs;
	}

	public ArrayList<Board> boardThispage(ArrayList<Board> list, int start, int end) {
		ArrayList<Board> thispage = new ArrayList<>();
		if (end > list.size()) {
			end = list.size();
		}
		for (int i = (start - 1); i < end; i++) {
			thispage.add(list.get(i));
		}
		return thispage;
	}

	public int boardInsert(Board b) {
		int cnt = 0;
		try {
			Connection con = ConnectionManager.getConnection();
			String sql = "insert into board2 (boardnum, id, title, content) values (board2_seq.nextval, ?, ?, ?)";
			PreparedStatement stat = con.prepareStatement(sql);
			stat.setString(1, b.getId());
			stat.setString(2, b.getTitle());
			stat.setString(3, b.getContent());
			cnt = stat.executeUpdate();
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return cnt;
	}

	public ArrayList<Board> boardList() {
		ArrayList<Board> boardList = new ArrayList<>();
		try {
			Connection con = ConnectionManager.getConnection();
			String sql = "select * from board2 order by inputdate desc";
			PreparedStatement stat = con.prepareStatement(sql);
			ResultSet res = stat.executeQuery();
			while (res.next()) {
				Board b = new Board();
				b.setBoardnum(res.getInt("boardnum"));
				b.setContent(res.getString("content"));
				b.setHits(res.getInt("hits"));
				b.setId(res.getString("id"));
				b.setInputdate(res.getString("inputdate"));
				b.setTitle(res.getString("title"));
				boardList.add(b);
			}
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return boardList;
	}

	public ArrayList<Board> boardSearchList(int method, String text) {
		ArrayList<Board> searchList = new ArrayList<>();
		try {
			Connection con = ConnectionManager.getConnection();
			String sql = "select * from board2 where ";
			switch (method) {
			case 1:
				sql += "title like '%'||?||'%'";
				break;
			case 2:
				sql += "content like '%'||?||'%'";
				break;
			case 3:
				sql += "title like '%'||?||'%' or content like '%'||?||'%'";
				break;
			default:
				return null;
			}
			sql += " order by inputdate desc";
			PreparedStatement stat = con.prepareStatement(sql);
			if (method == 3) {
				stat.setString(2, text);
			}
			stat.setString(1, text);
			ResultSet res = stat.executeQuery();
			while (res.next()) {
				Board b = new Board();
				b.setBoardnum(res.getInt("boardnum"));
				b.setContent(res.getString("content"));
				b.setHits(res.getInt("hits"));
				b.setId(res.getString("id"));
				b.setInputdate(res.getString("inputdate"));
				b.setTitle(res.getString("title"));
				searchList.add(b);
			}
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return searchList;
	}

	public Board boardRead(int boardnum) {
		Board b = null;
		try {
			Connection con = ConnectionManager.getConnection();
			String sql = "select * from board2 where boardnum = ?";
			PreparedStatement stat = con.prepareStatement(sql);
			stat.setInt(1, boardnum);
			ResultSet rs = stat.executeQuery();
			while (rs.next()) {
				b = new Board();
				b.setBoardnum(rs.getInt("BOARDNUM"));
				b.setId(rs.getString("ID"));
				b.setTitle(rs.getString("TITLE"));
				b.setContent(rs.getString("CONTENT"));
				b.setInputdate(rs.getString("INPUTDATE"));
				b.setHits(rs.getInt("HITS"));
			}
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return b;
	}

	public int addHits(int boardnum) {
		int cnt = 0;
		try {
			Connection con = ConnectionManager.getConnection();
			String sql = "update board2 set hits = ? where boardnum = " + boardnum;
			PreparedStatement stat = con.prepareStatement(sql);
			stat.setInt(1, (boardRead(boardnum).getHits() + 1));
			cnt = stat.executeUpdate();
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return cnt;
	}

	public int boardUpdate(Board b) {
		int cnt = 0;
		try {
			Connection con = ConnectionManager.getConnection();
			String sql = "update board2 set title = ?, content = ?, hits = 0 where boardnum = " + b.getBoardnum();
			PreparedStatement stat = con.prepareStatement(sql);
			stat.setString(1, b.getTitle());
			stat.setString(2, b.getContent());
			cnt = stat.executeUpdate();
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return cnt;
	}

	public int boardDelete(int boardnum) {
		int cnt = 0;
		try {
			Connection con = ConnectionManager.getConnection();
			String sql = "delete from board2 where boardnum = ?";
			PreparedStatement stat = con.prepareStatement(sql);
			stat.setInt(1, boardnum);
			cnt = stat.executeUpdate();
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return cnt;
	}

	///// ***** REPLY

	public int myreplyNum(String id) {
		try {
			Connection con = ConnectionManager.getConnection();
			String sql = "select count(replynum) from reply2 where id = ?";
			PreparedStatement stat = con.prepareStatement(sql);
			stat.setString(1, id);
			ResultSet res = stat.executeQuery();
			while (res.next()) {
				return res.getInt("count(replynum)");
			}
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

	public int replyNum(int boardnum) {
		try {
			Connection con = ConnectionManager.getConnection();
			String sql = "select count(replynum) from reply2 where boardnum = ?";
			PreparedStatement stat = con.prepareStatement(sql);
			stat.setInt(1, boardnum);
			ResultSet res = stat.executeQuery();
			while (res.next()) {
				return res.getInt("count(replynum)");
			}
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

	public int replyInsert(Reply r) {
		int cnt = 0;
		try {
			Connection con = ConnectionManager.getConnection();
			String sql = "insert into reply2 (replynum, boardnum, id, text) values (reply2_seq.NEXTVAL, ?, ?, ?)";
			PreparedStatement stat = con.prepareStatement(sql);
			stat.setInt(1, r.getBoardnum());
			stat.setString(2, r.getId());
			stat.setString(3, r.getText());
			cnt = stat.executeUpdate();
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return cnt;
	}

	public int replyUpdate(int replynum, String text) {
		int cnt = 0;
		try {
			Connection con = ConnectionManager.getConnection();
			String sql = "update reply2 set text = ? where replynum = " + replynum;
			PreparedStatement stat = con.prepareStatement(sql);
			stat.setString(1, text);
			cnt = stat.executeUpdate();
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return cnt;
	}

	public int replyDelete(int replynum) {
		int cnt = 0;
		try {
			Connection con = ConnectionManager.getConnection();
			String sql = "delete from reply2 where replynum = ?";
			PreparedStatement stat = con.prepareStatement(sql);
			stat.setInt(1, replynum);
			cnt = stat.executeUpdate();
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return cnt;
	}

	public ArrayList<Reply> replyList(int boardnum) {
		ArrayList<Reply> replyList = new ArrayList<>();
		try {
			Connection con = ConnectionManager.getConnection();
			String sql = "select * from reply2 where boardnum = " + boardnum + " order by inputdate desc";
			PreparedStatement stat = con.prepareStatement(sql);
			ResultSet res = stat.executeQuery();
			while (res.next()) {
				Reply r = new Reply();
				r.setBoardnum(res.getInt("BOARDNUM"));
				r.setId(res.getString("ID"));
				r.setInputdate(res.getString("INPUTDATE"));
				r.setReplynum(res.getInt("REPLYNUM"));
				r.setText(res.getString("TEXT"));
				replyList.add(r);
			}
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return replyList;
	}

}
