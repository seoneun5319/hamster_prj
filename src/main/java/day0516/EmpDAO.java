package day0516;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import kr.co.sist.dao.DbConnection;

public class EmpDAO {
	private static EmpDAO dDAO;
	
	private EmpDAO() {
		
	}//DeptDAO
	
	public static EmpDAO getInstance() {
		if (dDAO == null) {
			dDAO = new EmpDAO();
		}//end if
		return dDAO;
	}//getInstance
	
	public List<EmpDTO> selectEmp(int deptno) throws SQLException{
		List<EmpDTO> list=new ArrayList<EmpDTO>();
		
		DbConnection dbCon=DbConnection.getInstance();
		
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		try {
		//1. JNDI 사용 객체 생성
		//2. DBCP에서 DataSource 얻기
		//3. Connection 얻기
			con=dbCon.getDbConn();
		//4. 쿼리문 생성 객체 얻기
			String selectEmp=
			"select empno,ename,job,hiredate,sal from emp where deptno=?";
			pstmt=con.prepareStatement(selectEmp);
		//5. 바인드 변수에 값 할당
			pstmt.setInt(1, deptno);
		//6. 쿼리문 수행 후 결과 얻기
			rs=pstmt.executeQuery();
			
			EmpDTO empDto=null;
			
			while( rs.next() ) {
				empDto=new EmpDTO();
				empDto.setEmpno(rs.getInt("empno"));
				empDto.setEname(rs.getString("ename"));
				empDto.setJob(rs.getString("job"));
				empDto.setHiredate(rs.getDate("hiredate"));
				empDto.setSal(rs.getInt("sal"));
				
				list.add(empDto);
			}//end while
		}finally {
		//7. 연결 끊기
			dbCon.dbClose(rs, pstmt, con);
		}//end finally
		return list;
	}//selectAllDept
	
}//class
