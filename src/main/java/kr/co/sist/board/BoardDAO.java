package kr.co.sist.board;

import java.io.BufferedReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import kr.co.sist.dao.DbConnection;

public class BoardDAO {

	private static BoardDAO bDAO;
	
	private BoardDAO() {
	}//BoardDAO
	
	public static BoardDAO getInstance() {
		if(bDAO == null) {
			bDAO=new BoardDAO();
		}//end if
		return bDAO;
	}//getInstance
	
	public int selectTotalCount(RangeDTO rDTO) throws SQLException {
		int cnt=0;
		
		DbConnection db=DbConnection.getInstance();
		
		ResultSet rs=null;
		PreparedStatement pstmt=null;
		Connection con=null;
		
		try {
		//1. JNDI 사용객체 생성
		//2. DBCP에서 연결객체얻기(DataSource)
		//3. Connection얻기
			con=db.getDbConn();
		//4. 쿼리문 생성객체 얻기
			StringBuilder selectIdQuery=new StringBuilder();
			selectIdQuery
			.append("	select 	count(num) cnt	")
			.append("	from 	board	");
			
			//검색 키워드가 존재
			if (rDTO.getKeyword() != null && !"".equals(rDTO.getKeyword())) {
				selectIdQuery.append("where instr(").append(rDTO.getFieldName())
				.append(",?) != 0");
			}//end if
			
			pstmt=con.prepareStatement(selectIdQuery.toString());
		//5. 바인드 변수에 값 할당
			if (rDTO.getKeyword() != null && !"".equals(rDTO.getKeyword())) {
				pstmt.setString(1, rDTO.getKeyword());
			}//end if
		//6. 쿼리문 수행 후 결과 얻기
			rs=pstmt.executeQuery();
			if(rs.next()){//검색결과가 있으면 true, 없으면 false
				cnt=rs.getInt("cnt");
			}
		} finally {
		//7. 연결 끊기
			db.dbClose(rs, pstmt, con);
		}
		
		
		return cnt;
	}//selectId
	
	
	/**
	 * 시작번호와 끝번호 사이에 있는 레코드를 얻는 일
	 * @param rDTO
	 * @return
	 * @throws SQLException
	 */
	public List<BoardDTO> selectBoard(RangeDTO rDTO) throws SQLException{
		
		List<BoardDTO> list= new ArrayList<BoardDTO>(); 
		
		DbConnection db=DbConnection.getInstance();
		
		ResultSet rs=null;
		PreparedStatement pstmt=null;
		Connection con=null;
		
		try {
		//1. JNDI 사용객체 생성
		//2. DBCP에서 연결객체얻기(DataSource)
		//3. Connection얻기
			con=db.getDbConn();
		//4. 쿼리문 생성객체 얻기
			StringBuilder selectBoard=new StringBuilder();
			selectBoard
			.append("	select num, subject, id, input_date, cnt	")
			.append("	from (select num, subject, id, input_date, cnt,	")
			.append("	row_number() over(order by input_date desc) rnum	")
			.append("	from board	");
			if (rDTO.getKeyword() != null && !"".equals(rDTO.getKeyword())) {
				selectBoard.append("where instr(").append(rDTO.getFieldName())
				.append(",?) != 0");
			}//end if
			selectBoard.append("	)where rnum between ? and ?");
			
			pstmt=con.prepareStatement(selectBoard.toString());
		//5. 바인드 변수에 값 할당
			int bindInd=1;
			if (rDTO.getKeyword() != null && !"".equals(rDTO.getKeyword())) {
				pstmt.setString(bindInd++, rDTO.getKeyword());
			}//end if
			pstmt.setInt(bindInd++, rDTO.getStartNum());
			pstmt.setInt(bindInd++, rDTO.getEndNum());
				
		//6. 쿼리문 수행 후 결과 얻기
			rs=pstmt.executeQuery();
			
			BoardDTO bDTO=null;
			while(rs.next()) {
				bDTO=new BoardDTO();
				
				bDTO.setNum(rs.getInt("num"));
				bDTO.setCnt(rs.getInt("cnt"));
				
				bDTO.setSubject(rs.getString("subject"));
				bDTO.setId(rs.getString("id"));
				
				bDTO.setInput_date(rs.getDate("input_date"));

				list.add(bDTO);
			}
		
		} finally {
		//7. 연결 끊기
			db.dbClose(rs, pstmt, con);
		}
		
		return list;
		
	}//
	
	/**
	 * 게시글을 추가하는 일
	 * @param bDTO
	 * @throws SQLException
	 */
	public void insertBoard(BoardDTO bDTO) throws SQLException{
		DbConnection db=DbConnection.getInstance();
		
		PreparedStatement pstmt=null;
		Connection con=null;
		try {
		//1.JNDI 사용객체 생성
		//2.DBCP에서 연결객체 얻기(DataSource)
		//3.Connection 얻기
			con=db.getDbConn();
		//4.쿼리문 생성객체 얻기
			StringBuilder insertWebMember=new StringBuilder();
			insertWebMember
			.append("	insert into board(num, subject, content, id, ip)")
			.append("	values( seq_board.nextval,?,?,?,?)	");
			
			pstmt=con.prepareStatement(insertWebMember.toString());
		//5.바인드 변수에 값 할당
			pstmt.setString(1, bDTO.getSubject());
			pstmt.setString(2, bDTO.getContent());
			pstmt.setString(3, bDTO.getId());
			pstmt.setString(4, bDTO.getIp());
		//6.쿼리문 수행 후 결과 얻기
			pstmt.executeQuery();
			
		
			
		}finally {
		//7.연결 끊기
			db.dbClose(null, pstmt, con);
		}//end finally
	}//insertBoard
	
	public BoardDTO selectOneBoard(int num) throws SQLException{
	      BoardDTO bDTO=null;
	      
	      DbConnection db=DbConnection.getInstance();
	      
	      ResultSet rs=null;
	      PreparedStatement pstmt=null;
	      Connection con=null;
	      
	      try {
	      //1. JNDI 사용객체 생성
	      //2. DBCP에서 연결객체얻기(DataSource)
	      //3. Connection얻기
	         con=db.getDbConn();
	      //4. 쿼리문 생성객체 얻기
	         StringBuilder selectOneBoard=new StringBuilder();
	         selectOneBoard
	         .append("   select    subject,content,id,input_date,ip,cnt   ")
	         .append("   from    board   ")
	         .append("   where    num=?   ");
	         
	         pstmt=con.prepareStatement(selectOneBoard.toString());
	      //5. 바인드 변수에 값 할당
	         pstmt.setInt(1, num);
	      //6. 쿼리문 수행 후 결과 얻기
	         rs=pstmt.executeQuery();
	         if(rs.next()){//검색결과가 있으면 true, 없으면 false
	            bDTO=new BoardDTO();
	            bDTO.setNum(num);
	            bDTO.setSubject(rs.getString("subject"));
	            bDTO.setId(rs.getString("id"));
	            bDTO.setIp(rs.getString("ip"));
	            bDTO.setInput_date(rs.getDate("input_date"));
	            bDTO.setCnt(rs.getInt("cnt"));
	            
	            //bDTO.setContent(rs.getString("content"));
	            //CLOB은 긴 문자열을 저장하므로 별도에 Stream을 연결하여 값을 읽어들인다.
	            StringBuilder tempContent=new StringBuilder();
	            String lineData="";
	            
	            //try~with~resources
	            try (BufferedReader br=new BufferedReader(
	                  rs.getClob("content").getCharacterStream()) ) {
	               
	               while((lineData=br.readLine()) != null) {
	                  tempContent.append(lineData).append("\n");
	               }//end while
	            } catch (IOException e) {
	               e.printStackTrace();
	               tempContent.append("글 내용 읽기 실패");
	            }//end catch
	            
	            bDTO.setContent(tempContent.toString());
	            
	         }//end if
	         
	      } finally {
	      //7. 연결 끊기
	         db.dbClose(rs, pstmt, con);
	      }
	      
	      return bDTO;
	   }//selectOneBoard
	
	/**
	 * 조회수 변경
	 * @param num
	 * @return
	 * @throws SQLException
	 */
	public int updateCnt(int num) throws SQLException{
		int rowCnt=0;
		
		DbConnection db=DbConnection.getInstance();
		
		PreparedStatement pstmt=null;
		Connection con=null;
		try {
		//1.JNDI 사용객체 생성
		//2.DBCP에서 연결객체 얻기(DataSource)
		//3.Connection 얻기
			con=db.getDbConn();
		//4.쿼리문 생성객체 얻기
			StringBuilder updateCnt=new StringBuilder();
			updateCnt
			.append("	update board set cnt= cnt+1")
			.append("	where num=?	");
			
			pstmt=con.prepareStatement(updateCnt.toString());
		//5.바인드 변수에 값 할당
			pstmt.setInt(1, num);
		//6.쿼리문 수행 후 결과 얻기
			rowCnt=pstmt.executeUpdate();
			
		}finally {
		//7.연결 끊기
			db.dbClose(null, pstmt, con);
		}//end finally
		
		return rowCnt;
	}//updateCnt
	
	public int deleteBoard(BoardDTO bDTO) throws SQLException{
		int rowCnt=0;
		
		DbConnection db=DbConnection.getInstance();
		
		PreparedStatement pstmt=null;
		Connection con=null;
		try {
		//1.JNDI 사용객체 생성
		//2.DBCP에서 연결객체 얻기(DataSource)
		//3.Connection 얻기
			con=db.getDbConn();
		//4.쿼리문 생성객체 얻기
			StringBuilder deleteBoard=new StringBuilder();
			deleteBoard
			.append("	delete from board ")
			.append("	where num=?	and id=?");
			
			pstmt=con.prepareStatement(deleteBoard.toString());
		//5.바인드 변수에 값 할당
			pstmt.setInt(1, bDTO.getNum());
			pstmt.setString(2, bDTO.getId());
		//6.쿼리문 수행 후 결과 얻기
			rowCnt=pstmt.executeUpdate();
			
		}finally {
		//7.연결 끊기
			db.dbClose(null, pstmt, con);
		}//end finally
		
		return rowCnt;
	}//deleteBoard
	
	public int updateBoard(BoardDTO bDTO) throws SQLException{
		int rowCnt=0;
		
		DbConnection db=DbConnection.getInstance();
		
		PreparedStatement pstmt=null;
		Connection con=null;
		try {
		//1.JNDI 사용객체 생성
		//2.DBCP에서 연결객체 얻기(DataSource)
		//3.Connection 얻기
			con=db.getDbConn();
		//4.쿼리문 생성객체 얻기
			StringBuilder updateBoard=new StringBuilder();
			updateBoard
			.append("	update board ")
			.append("	set content=?	")
			.append("	where num=?	and id=?	");
			
			pstmt=con.prepareStatement(updateBoard.toString());
		//5.바인드 변수에 값 할당
			pstmt.setString(1, bDTO.getContent());
			pstmt.setInt(2, bDTO.getNum());
			pstmt.setString(3, bDTO.getId());
		//6.쿼리문 수행 후 결과 얻기
			rowCnt=pstmt.executeUpdate();
			
		}finally {
		//7.연결 끊기
			db.dbClose(null, pstmt, con);
		}//end finally
		
		return rowCnt;
	}//updateBoard
	
}//class
