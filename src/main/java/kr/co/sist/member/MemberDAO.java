package kr.co.sist.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import kr.co.sist.dao.DbConnection;

public class MemberDAO {
	
	private static MemberDAO mDAO;
	
	private MemberDAO() {
		
	}//MemberDAO
	
	public static MemberDAO getInstance() {
		if (mDAO == null) {
			mDAO=new MemberDAO();
		}//end if
		return mDAO;
	}//getInstance
	
	/**
	 * 입력받은 아이디를 검색하는
	 * @param id 검색할 아이디
	 * @return 검색된 아이디
	 * @throws SQLException
	 */
	public boolean selectId(String id)throws SQLException{
		boolean flag=false;
	
		DbConnection db=DbConnection.getInstance();
		
		ResultSet rs=null;
		PreparedStatement pstmt=null;
		Connection con=null;
		try {
		//1.JNDI 사용객체 생성
		//2.DBCP에서 연결객체 얻기(DataSource)
		//3.Connection 얻기
			con=db.getDbConn();
		//4.쿼리문 생성객체 얻기
			StringBuilder selectIdQuery=new StringBuilder();
			selectIdQuery
			.append("	select	id			")
			.append("	from	web_member	")
			.append("	where	id=?		");
			
			pstmt=con.prepareStatement(selectIdQuery.toString());
		//5.바인드 변수에 값 할당
			pstmt.setString(1, id);
		//6.쿼리문 수행 후 결과 얻기
			rs=pstmt.executeQuery();
			flag=rs.next();//검색결과가 있으면 true | 없으면 false
		}finally {
		//7.연결 끊기
			db.dbClose(rs, pstmt, con);
		}//end finally
		
		return flag;
	}//selectId
	
	public void insertMember(MemberDTO mDTO) throws SQLException{
		
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
			.append("	insert into web_member			")
			.append("	(ID, PASS, NAME, BIRTH, TEL, EMAIL, GENDER, ZIPCODE, ADDR, ADDR2, INTRO, IP)	")
			.append("	values( ?,?,?,?,?,?,?,?,?,?,?,?)		");
			
			pstmt=con.prepareStatement(insertWebMember.toString());
		//5.바인드 변수에 값 할당
			pstmt.setString(1, mDTO.getId());
			pstmt.setString(2, mDTO.getPass());
			pstmt.setString(3, mDTO.getName());
			pstmt.setString(4, mDTO.getBirth());
			pstmt.setString(5, mDTO.getTel());
			pstmt.setString(6, mDTO.getUseEmail());
			pstmt.setString(7, mDTO.getGender());
			pstmt.setString(8, mDTO.getZipcode());
			pstmt.setString(9, mDTO.getAddr());
			pstmt.setString(10, mDTO.getAddr2());
			pstmt.setString(11, mDTO.getIntro());
			pstmt.setString(12, mDTO.getIp());
		//6.쿼리문 수행 후 결과 얻기
			pstmt.executeQuery();
			
		}finally {
		//7.연결 끊기
			db.dbClose(null, pstmt, con);
		}//end finally
	}//insertMember
	
	public List<MemberDTO> selectAllMember() throws SQLException{
		
		List<MemberDTO> list=new ArrayList<MemberDTO>();
		
		DbConnection db=DbConnection.getInstance();
		
		ResultSet rs=null;
		PreparedStatement pstmt=null;
		Connection con=null;
		try {
		//1.JNDI 사용객체 생성
		//2.DBCP에서 연결객체 얻기(DataSource)
		//3.Connection 얻기
			con=db.getDbConn();
		//4.쿼리문 생성객체 얻기
			StringBuilder selectIdQuery=new StringBuilder();
			selectIdQuery
			.append("	select	id,name,birth,tel,email,gender,zipcode,addr,addr2,intro,ip,input_date")
			.append("	from	web_member	");
			
			pstmt=con.prepareStatement(selectIdQuery.toString());
		//5.바인드 변수에 값 할당
		//6.쿼리문 수행 후 결과 얻기
			rs=pstmt.executeQuery();
			
			MemberDTO mDTO=null;
			while(rs.next()) {
				mDTO=new MemberDTO();
				mDTO.setId(rs.getString("id"));
				mDTO.setName(rs.getString("name"));
				mDTO.setBirth(rs.getString("birth"));
				mDTO.setTel(rs.getString("tel"));
				mDTO.setUseEmail(rs.getString("email"));
				mDTO.setGender(rs.getString("gender"));
				mDTO.setInput_date(rs.getDate("input_date"));
				
				list.add(mDTO);
			}//end while
		}finally {
		//7.연결 끊기
			db.dbClose(rs, pstmt, con);
		}//end finally
		
		return list;
	}//selectAllMember
	
	public MemberDTO selectOneMember(String id) throws SQLException{
		
		MemberDTO mDTO=null;
		
		DbConnection db=DbConnection.getInstance();
		
		ResultSet rs=null;
		PreparedStatement pstmt=null;
		Connection con=null;
		try {
			//1.JNDI 사용객체 생성
			//2.DBCP에서 연결객체 얻기(DataSource)
			//3.Connection 얻기
			con=db.getDbConn();
			//4.쿼리문 생성객체 얻기
			StringBuilder selectIdQuery=new StringBuilder();
			selectIdQuery
			.append("	select	id,name,birth,tel,gender,ip,input_date,profile_img")
			.append("	from	web_member	")
			.append("	where	id=?	")
			;
			
			pstmt=con.prepareStatement(selectIdQuery.toString());
			//5.바인드 변수에 값 할당
			pstmt.setString(1, id);
			//6.쿼리문 수행 후 결과 얻기
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				mDTO=new MemberDTO();
				mDTO.setName(rs.getString("name"));
				mDTO.setBirth(rs.getString("birth"));
				mDTO.setTel(rs.getString("tel"));
				mDTO.setGender(rs.getString("gender"));
				mDTO.setIp(rs.getString("ip"));
				mDTO.setInput_date(rs.getDate("input_date"));
				mDTO.setProfile_img(rs.getString("profile_img"));
				
			}//end while
		}finally {
			//7.연결 끊기
			db.dbClose(rs, pstmt, con);
		}//end finally
		
		return mDTO;
	}//selectAllMember
	
	
	
}//class
