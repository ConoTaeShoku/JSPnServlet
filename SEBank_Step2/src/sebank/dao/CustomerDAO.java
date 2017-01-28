package sebank.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import sebank.vo.Customer;

public class CustomerDAO {

	public int login(String custid, String password) {
		int cnt = 0;
		try {
			Connection con = ConnectionManager.getConnection();
			String sql = "select * from customer where custid = ? and password = ?";
			PreparedStatement stat = con.prepareStatement(sql);
			stat.setString(1, custid);
			stat.setString(2, password);
			cnt = stat.executeUpdate();
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return cnt;
	}

	public Customer select(String custid) {
		Customer c = null;
		try {
			Connection con = ConnectionManager.getConnection();
			String sql = "select * from customer where custid = ?";
			PreparedStatement stat = con.prepareStatement(sql);
			stat.setString(1, custid);
			ResultSet rs = stat.executeQuery();
			while (rs.next()) {
				c = new Customer();
				c.setCustid(rs.getString("CUSTID"));
				c.setPassword(rs.getString("PASSWORD"));
				c.setName(rs.getString("NAME"));
				c.setEmail(rs.getString("EMAIL"));
				c.setDivision(rs.getString("DIVISION"));
				c.setIdno(rs.getString("IDNO"));
				c.setAddress(rs.getString("ADDRESS"));
			}
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return c;
	}

	public int insert(Customer c) {
		int cnt = 0;
		try {
			Connection con = ConnectionManager.getConnection();
			String sql = "insert into customer values (?, ?, ?, ?, ?, ?, ?)";
			PreparedStatement stat = con.prepareStatement(sql);
			stat.setString(1, c.getCustid());
			stat.setString(2, c.getPassword());
			stat.setString(3, c.getName());
			stat.setString(4, c.getEmail());
			stat.setString(5, c.getDivision());
			stat.setString(6, c.getIdno());
			stat.setString(7, c.getAddress());
			cnt = stat.executeUpdate();
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return cnt;
	}

	public int update(Customer c) {
		int cnt = 0;
		try {
			Connection con = ConnectionManager.getConnection();
			String sql = "update customer set password = ?, name = ?, email = ?,"
					+ "division = ?, idno = ?, address = ? where custid = ?";
			PreparedStatement stat = con.prepareStatement(sql);
			stat.setString(1, c.getPassword());
			stat.setString(2, c.getName());
			stat.setString(3, c.getEmail());
			stat.setString(4, c.getDivision());
			stat.setString(5, c.getIdno());
			stat.setString(6, c.getAddress());
			stat.setString(7, c.getCustid());
			cnt = stat.executeUpdate();
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return cnt;
	}

	public int delete(String myid) {
		int cnt = 0;
		try {
			Connection con = ConnectionManager.getConnection();
			String sql = "delete from customer where custid = ?";
			PreparedStatement stat = con.prepareStatement(sql);
			stat.setString(1, myid);
			cnt = stat.executeUpdate();
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return cnt;
	}

	public int totnum() {
		try {
			Connection con = ConnectionManager.getConnection();
			String sql = "select custid, count(custid) from customer";
			PreparedStatement stat = con.prepareStatement(sql);
			ResultSet res = stat.executeQuery();
			while (res.next()) {
				return res.getInt("count(custid)");
			}
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

	public int totpgs(int cnum) {
		int tot = totnum();
		int totpgs = 0;
		if (tot == 0) {
			totpgs = 1;
		}
		if (tot % cnum == 0) {
			totpgs = tot / cnum;
		} else {
			totpgs = tot / cnum + 1;
		}
		return totpgs;
	}

	public ArrayList<Customer> list() {
		ArrayList<Customer> clist = new ArrayList<>();
		try {
			Connection con = ConnectionManager.getConnection();
			String sql = "select * from customer";
			PreparedStatement stat = con.prepareStatement(sql);
			ResultSet rs = stat.executeQuery();
			while (rs.next()) {
				Customer c = new Customer();
				c.setCustid(rs.getString("CUSTID"));
				c.setPassword(rs.getString("PASSWORD"));
				c.setName(rs.getString("NAME"));
				c.setEmail(rs.getString("EMAIL"));
				c.setDivision(rs.getString("DIVISION"));
				c.setIdno(rs.getString("IDNO"));
				c.setAddress(rs.getString("ADDRESS"));
				clist.add(c);
			}
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return clist;
	}

	public ArrayList<Customer> thispage(ArrayList<Customer> clist, int start, int end) {
		ArrayList<Customer> thispage = new ArrayList<>();
		if (end > clist.size()) {
			end = clist.size();
		}
		for (int i = (start - 1); i < end; i++) {
			thispage.add(clist.get(i));
		}
		return thispage;
	}
}
