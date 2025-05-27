package kr.co.sist.member;

import java.sql.Date;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MemberDTO {
	private String id, pass, name, birth, tel, email, domain, useEmail, gender, zipcode, addr, addr2, intro, ip, profile_img;
	private Date input_date;
}//class
