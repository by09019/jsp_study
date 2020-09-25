package kr.list.utility;

import java.sql.DriverManager;
import java.sql.ResultSet;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class DBConnector {
	
	public static Connection getConnector() {
		Connection conn = null;
		String id = "root";
		String password = "0000";
		try {
//			1. driver load
			Class.forName("com.mysql.jdbc.Driver");
			
//			2. 연결설정
			String url = "jdbc:mysql://localhost:3306/sublet_project?useSSL=false&serverTimezone=Asia/Seoul";
			conn = (Connection) DriverManager.getConnection(url, id, password);
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return conn;
	}
	
	public static void close(ResultSet rs, PreparedStatement stmt, Connection conn) {
		try {
			if(rs != null) rs.close();
			if(stmt != null) stmt.close();
			if(conn != null) conn.close();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public static void close(PreparedStatement stmt, Connection conn) {
		try {
			if(stmt != null) stmt.close();
			if(conn != null) conn.close();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
}
