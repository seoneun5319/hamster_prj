package day0515;

import java.io.FileWriter;
import java.io.IOException;

public class CreateHTML {

	public static void main(String[] args) {
		String msg="내 이름은<strong>눈송이</strong>예요.<br>\r\n"
				+ "<img src=\"http://localhost/jsp_prj/common/images/snow.png\"/>";
		try {
			FileWriter fw=
				new FileWriter("C:/dev/jsp_prj/src/main/webapp/day0515/ajax.html");
			fw.write(msg);
			fw.flush();
			if ( fw != null ) {fw.close();}//end if
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
}
