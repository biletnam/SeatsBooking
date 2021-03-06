package dao;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
/**
 * 
 * @author Eduardo
 * @date 16-01-25
 *
 */
public class ConnectDB {
	public static Connection getConnection()
	{
		Connection conn = null;
		try{
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost:3306/db_test";
			conn = DriverManager.getConnection(url, "root", "root");
		}catch (Exception e)
		{
			e.printStackTrace();
		}
		
		return conn;
	}
	public static Connection getConnectionSeat()
	{
		Connection conn = null;
		try{
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost:3306/seat_db";
			conn = DriverManager.getConnection(url, "root", "root");
		}catch (Exception e)
		{
			e.printStackTrace();
		}
		
		return conn;
	}
	public static void closeConnection(Connection conn)
	{
		if(conn != null)
		{
			try{
				conn.close();
			}catch(SQLException e)
			{
				e.printStackTrace();
			}
		}
	}
	public static Connection getConnectionGroupSeat()
	{
		Connection conn = null;
		try{
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost:3306/group_seat_db";
			conn = DriverManager.getConnection(url, "root", "root");
		}catch (Exception e)
		{
			e.printStackTrace();
		}
		
		return conn;
	}

	
}
