package reply;

import java.sql.Timestamp;

import util.CommonVo;

public class ReplyVo extends CommonVo {   
	
	private int no;
	private String title;
	private String content;
	private Timestamp regdate;
	private int readcount;
	private String filename_org;	// 사용자가첨부한 원본파일명
	private String filename_real;	// 서버에 저장된 실제파일명
	private String isDel;
	private int user_no;
	private int gno;				// 그룹번호
	private int ono;				// 순서
	private int nested;				// 들여쓰기
	
	private int comment_count;
	private String name;
	
	public ReplyVo() {
		
	}
	
	
	public int getGno() {
		return gno;
	}


	public void setGno(int gno) {
		this.gno = gno;
	}


	public int getOno() {
		return ono;
	}


	public void setOno(int ono) {
		this.ono = ono;
	}


	public int getNested() {
		return nested;
	}


	public void setNested(int nested) {
		this.nested = nested;
	}


	public int getComment_count() {
		return comment_count;
	}


	public void setComment_count(int comment_count) {
		this.comment_count = comment_count;
	}


	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getUser_no() {
		return user_no;
	}

	public void setUser_no(int user_no) {
		this.user_no = user_no;
	}

	public String getIsDel() {
		return isDel;
	}

	public void setIsDel(String isDel) {
		this.isDel = isDel;
	}

	public String getFilename_org() {
		return filename_org;
	}

	public void setFilename_org(String filename_org) {
		this.filename_org = filename_org;
	}

	public String getFilename_real() {
		return filename_real;
	}

	public void setFilename_real(String filename_real) {
		this.filename_real = filename_real;
	}

	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Timestamp getRegdate() {
		return regdate;
	}
	public void setRegdate(Timestamp regdate) {
		this.regdate = regdate;
	}
	public int getReadcount() {
		return readcount;
	}
	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}
	
	
}
