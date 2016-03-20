package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.GroupSeatDao;
import dao.SeatDao;
import util.Seats;

public class SeatsServlet extends HttpServlet{
	/**
	 * 
	 */
	private static final long serialVersionUID = -6629330825826632277L;

	public void doPost(HttpServletRequest request , HttpServletResponse response)
	throws ServletException, IOException
	{
		String bookdate = request.getParameter("bookdate");

//		System.out.println(bookdate);
		
		SeatDao seatDao = new SeatDao();
		
		Seats[] seats = new Seats[12];

		seats = seatDao.getSeats(bookdate);
		
		request.getSession().setAttribute("seats", seats);
		
		request.getSession().setAttribute("bookdate", bookdate);
		
		GroupSeatDao groupSeatDao = new GroupSeatDao();
		
		Seats[] gseats = new Seats[2];

		gseats = groupSeatDao.getGroupSeats(bookdate);
		request.getSession().setAttribute("groupseats", gseats);
		
		request.getRequestDispatcher("./seatsbooking.jsp").forward(request, response);
	}
	
}
