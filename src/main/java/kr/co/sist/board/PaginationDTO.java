package kr.co.sist.board;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@Getter
@Setter
@ToString

public class PaginationDTO {
	
	private int pageNumber, currentPage, totalPage;
	private String url, field, keyword;
	
}//class
