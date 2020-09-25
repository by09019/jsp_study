package kr.list.member.view;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.list.member.dao.memberDAO;
import kr.list.member.vo.memberVO;


public class JoinAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String
		id = request.getParameter("id"),
		pw = request.getParameter("pw"),
		name = request.getParameter("name");
		
		memberDAO dao =  new memberDAO();
		memberVO vo = new memberVO();
		vo.setId(id);
		vo.setName(name);
		vo.setPw(pw);
		
		dao.joinAction(vo);
		
		response.sendRedirect("/");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
