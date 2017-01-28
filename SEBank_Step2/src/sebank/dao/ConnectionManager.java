package sebank.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Oracle 연결 기능 제공 클래스
 */
public class ConnectionManager {
	private static final String driver = "oracle.jdbc.driver.OracleDriver";
	private static final String url = "jdbc:oracle:thin:@localhost:1521:xe";
	private static final String dbid = "hr";
	private static final String dbpw = "hr";

	//jdbc 드라이버 로딩
	static {
		try {
			Class.forName(driver); 
		}
		catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}

	private ConnectionManager() {}
		
	//Connection 생성하여 리턴
	public static Connection getConnection() {
		Connection con = null;
		try {
			con = DriverManager.getConnection(url, dbid, dbpw);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return con;
	}
	
	//Connection 연결 종료
	public static void close(Connection con) {
		try {
			if (con != null) con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
