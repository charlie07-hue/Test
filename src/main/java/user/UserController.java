package user;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import board.BoardService;
import board.BoardVo;

@Controller
public class UserController {

	@Autowired
	UserService service;
	@Autowired
	BoardService boardService;
	
//	@RequestMapping("/admin/user/index.do")
//	public String index(Model model, UserVo vo) {
//		model.addAttribute("list", service.selectAll(vo));
//		return "admin/user/index";
//	}
	
//	@RequestMapping("/board/detail.do")
//	public String detail(Model model, UserVo vo) {
//		model.addAttribute("vo", service.deatil(vo));
//		return "board/detail";
//	}
	
	@RequestMapping("/user/join.do")
	public String write(Model model, UserVo vo) {
		return "user/join";
	}
	
	// form에서 submit용
	@RequestMapping("/user/insert.do")
	public String insert(Model model, UserVo vo, HttpServletRequest req) {
		int r = service.insert(vo);
		// r > 0 : 정상 -> alert -> 목록으로 이동
		// r == 0 : 비정상 -> alert -> 이전페이지로 이동
		if (r > 0) {
			model.addAttribute("msg", "정상적으로 등록되었습니다.");
			model.addAttribute("url", "/project/sample/index.do");
		} else {
			model.addAttribute("msg", "등록실패");
			model.addAttribute("url", "join.do");
		}
		return "include/alert";
	}
	
	// ajax용
	@RequestMapping("/user/insertAjax.do")
	public String insertAjax(Model model, UserVo vo, HttpServletRequest req) {
		int r = service.insert(vo);
		if (r > 0) {
			model.addAttribute("result", "true");
		} else {
			model.addAttribute("result", "false");
		}
		return "include/result";
	}
	
//	@RequestMapping("/board/edit.do")
//	public String edit(Model model, UserVo vo) {
//		model.addAttribute("vo", service.edit(vo));
//		return "board/edit";
//	}
	
//	@RequestMapping("/board/update.do")
//	public String update(Model model, UserVo vo, HttpServletRequest req) {
//		int r = service.update(vo);
//		// r > 0 : 정상 -> alert -> 목록으로 이동
//		// r == 0 : 비정상 -> alert -> 이전페이지로 이동
//		if (r > 0) {
//			model.addAttribute("msg", "정상적으로 수정되었습니다.");
//			model.addAttribute("url", "index.do");
//		} else {
//			model.addAttribute("msg", "수정실패");
//			model.addAttribute("url", "edit.do?no="+vo.getNo());
//		}
//		return "include/alert";
//	}
	
//	@RequestMapping("/board/delete.do")
//	public String delete(Model model, UserVo vo, HttpServletRequest req) {
//		int r = service.delete(vo);
//		if (r > 0) {
//			model.addAttribute("result", "true");
//		} else {
//			model.addAttribute("result", "false");
//		}
//		return "include/result";
//	}
	
	@RequestMapping("/user/isDuplicateId.do")
	public String isDuplicateId(Model model, @RequestParam String id) {
		if (service.isDuplicateId(id) == 0) {
			model.addAttribute("result", "false");
		} else {
			model.addAttribute("result", "true");
		}
		return "include/result";
	}
	
	@GetMapping("/user/login.do")
	public String loginForm(UserVo vo, @CookieValue(value="cookieId", required = false) Cookie cookie) {
		if (cookie != null) {
			vo.setId(cookie.getValue());
		}
		return "user/login";
	}
	
	@PostMapping("/user/login.do")
	public String login(Model model, UserVo vo, HttpServletRequest req, HttpServletResponse res, HttpSession sess) {
		UserVo uv = service.login(vo);
		if (uv == null) {
			model.addAttribute("msg", "아이디 비밀번호가 올바르지 않습니다.");
			model.addAttribute("url", "login.do");
			return "include/alert";
		} else {
			sess.setAttribute("userInfo", uv);
			// 쿠키에 저장
			Cookie cookie = new Cookie("cookieId", vo.getId());
			cookie.setPath("/");
			if ("check".equals(vo.getCheckId())) {
				cookie.setMaxAge(60*60*24*365);
			} else {
				cookie.setMaxAge(0);
			}
			res.addCookie(cookie);
			String url = "/project/board/index.do";
			if (req.getParameter("url") != null && !"".equals(req.getParameter("url"))) url = req.getParameter("url");
			return "redirect: "+url;
		}
	}
	
	@GetMapping("/user/logout.do")
	public String logout(Model model, HttpSession sess) {
		sess.invalidate();
		model.addAttribute("msg", "로그아웃되었습니다.");
		model.addAttribute("url", "/project/board/index.do");
		return "include/alert";
	}
	
	@RequestMapping("/user/mypage.do")
	public String mypage(Model model, BoardVo vo, HttpSession sess) {
		vo.setUser_no(((UserVo)sess.getAttribute("userInfo")).getNo());
		model.addAttribute("list", boardService.selectAll(vo));
		
		return "user/mypage";
	}
	
	@RequestMapping(value = "/user/searchId.do", method = RequestMethod.GET)
	public String searchId(Model model, UserVo vo) {
		return "user/searchId";
	}
	@RequestMapping(value = "/user/searchId.do", method = RequestMethod.POST)
	public String searchId2(Model model, UserVo vo) {
		UserVo uv = service.searchId(vo);
		String id = "";
		if (uv != null) {
			id = uv.getId();
		}
		model.addAttribute("result", id);
		return "include/result";
	}
	
	@RequestMapping(value = "/user/searchPwd.do", method = RequestMethod.GET)
	public String searchPwd(Model model, UserVo vo) {
		return "user/searchPwd";
	}
	
	@RequestMapping(value = "/user/searchPwd.do", method = RequestMethod.POST)
	public String searchPwd2(Model model, UserVo vo) {
		UserVo uv = service.searchPwd(vo);
		if (uv != null) {
			model.addAttribute("result", "ok");
		} else {
			model.addAttribute("result", "no");
		}
		return "include/result";
	}
}
