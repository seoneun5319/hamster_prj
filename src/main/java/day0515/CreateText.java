package day0515;

import java.io.FileWriter;
import java.io.IOException;

public class CreateText {

	public static void main(String[] args) {
		String msg="AJAX 동작은 쉽지않네요 오늘은 금요일이면 좋겠다";
		try {
			FileWriter fw=
				new FileWriter("C:/dev/jsp_prj/src/main/webapp/day0515/ajax.txt");
			fw.write(msg);
			fw.flush();
			if ( fw != null ) {fw.close();}//end if
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
}
