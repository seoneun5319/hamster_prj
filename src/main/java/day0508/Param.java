package day0508;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Param {
	
	//txt=%E3%84%B4&pass=s&file=%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7+2025-04-28+162554.png&hid=5%EC%9B%94%EC%9D%80+%EC%89%AC%EB%8A%94+%EB%82%A0+%EB%81%9D&flag=flag&sel=%EC%98%A4%EB%9D%BC%ED%81%B4&ta=aaa&lang=Java
	
	private String txt,pass,file,hid,flag,sel,ta;
	private int age;
	private String[] lang;
}
