package junit4;

import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpSession;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.RequestBuilder;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import board.BoardDao;
import board.BoardVo;
import user.UserVo;

// JUnit4에서 RunWith
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:config/context-servlet.xml"})
@WebAppConfiguration
public class Test3 {
	
	@Autowired
	BoardDao dao;
	// 가상MVC객체
	MockMvc mockMvc;
	@Autowired
	WebApplicationContext ctx; // 어노테이션 추가
	MockHttpSession session;
	
	@Before
	public void init() {
		mockMvc = MockMvcBuilders.webAppContextSetup(ctx).build();
		
		// 세션
		MockHttpServletRequest request = new MockHttpServletRequest();
		RequestContextHolder.setRequestAttributes(new ServletRequestAttributes(request));
		UserVo vo = new UserVo();
		vo.setNo(999);
		session = new MockHttpSession();
		session.setAttribute("userInfo", vo);
		request.setSession(session);
	}
	
	@Test
	public void selectAllTest() {
		BoardVo bv = new BoardVo();
		bv.setReqPage(2);
		List<BoardVo> list = dao.selectAll(bv);
		for (BoardVo vo : list) {
			System.out.println(vo.getTitle());
		}
	}
	
	@Test
	public void detailTest() {
		System.out.println("detail");
		BoardVo bv = new BoardVo();
		bv.setNo(100);
		BoardVo vo = dao.detail(bv);
		System.out.println(vo.getTitle());
	}
	
	// /board/index.do로 접속 테스트
	@Test
	public void bordIndex() throws Exception {
		RequestBuilder req = MockMvcRequestBuilders.get("/board/index.do");
		mockMvc.perform(req);
	}
	@Test
	public void bordIndex2() {
		RequestBuilder req = MockMvcRequestBuilders.get("/board/index.do").param("reqPage", "2");
		try {
			mockMvc.perform(req);
		} catch(Exception e) {
			System.out.println(1);
		}
	}
	@Test
	public void mypage() throws Exception {
		RequestBuilder req = MockMvcRequestBuilders.get("/user/mypage.do").session(session);
		mockMvc.perform(req);
	}
	@Test
	public void login() {
		RequestBuilder req = MockMvcRequestBuilders.post("/user/login.do").param("id", "aaa").param("pwd", "aaa");
		try {
			mockMvc.perform(req);
		} catch(Exception e) {
			System.out.println(1);
		}
	}
}
