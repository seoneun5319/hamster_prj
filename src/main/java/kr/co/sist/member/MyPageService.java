package kr.co.sist.member;

import java.sql.SQLException;

import javax.servlet.http.HttpSession;

import kr.co.sist.cipher.DataDecryption;
import kr.co.sist.member.login.LoginResultDTO;

public class MyPageService {
	public boolean modifyMember(MyPageDTO mpDTO, HttpSession session) {
		
		boolean flag=false;
		
		MyPageDAO mpDAO=MyPageDAO.getInstance();
		
		try {
			mpDTO.setId(((LoginResultDTO)session.getAttribute("userData")).getId());
			
			String key="abcdef0123456789";
			DataDecryption dd=new DataDecryption(key);
			//이미지를 선택하지 않았을 때 이미지 처리
			if ( mpDTO.getImgName() == null || mpDTO.getImgName().isEmpty()) {
				mpDTO.setImgName("default.jpg");
			}//end if
			try {
				mpDTO.setTel(dd.decrypt(mpDTO.getTel()));
			} catch (Exception e) {
				e.printStackTrace();
			}//end catch
			
			mpDAO.updateMember(mpDTO);
			flag=true;
		} catch (SQLException e) {
			e.printStackTrace();
		}//end catch
		return flag;
	}//modifyMember
}
