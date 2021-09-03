package board;

import java.io.File;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import comment.CommentService;
import comment.CommentVo;

@Controller
public class AdminBoardController {

	@Autowired
	BoardService service;
	@Autowired
	CommentService cService;
	
	static final String TABLENAME = "board";
	
	@RequestMapping("/admin/board/index.do")
	public String index(Model model, BoardVo vo) {
		model.addAttribute("list", service.selectAll(vo));
		return "admin/board/index";
	}
	
	@RequestMapping("/admin/board/detail.do")
	public String detail(Model model, BoardVo vo, CommentVo cv) {
		model.addAttribute("vo", service.deatil(vo));
		return "admin/board/view";
	}
	
	@RequestMapping("/admin/board/write.do")
	public String write(Model model, BoardVo vo) {
		return "admin/board/write";
	}
	
	@RequestMapping("/admin/board/insert.do")
	public String insert(Model model, BoardVo vo, 
						@RequestParam MultipartFile file, HttpServletRequest req) {
		//service.insert(vo, filename, req)
		if (!file.isEmpty()) { // 첨부파일이 있으면
			try {
				String org = file.getOriginalFilename(); // 원본파일명
				String ext = ""; //확장자
				
				ext = org.substring(org.lastIndexOf("."));
				String real = new Date().getTime()+ext; // 서버에 저장할 파일명
	//			System.out.println("org:"+org);
	//			System.out.println("real:"+real);
				// 파일 저장
				String path = req.getRealPath("/upload/"); // 경로
				file.transferTo(new File(path+real)); // 경로+파일명 저장
				// vo에 set
				vo.setFilename_org(org);
				vo.setFilename_real(real);
			} catch (Exception e) {
				
			}
		}
		int r = service.insert(vo);
		// r > 0 : 정상 -> alert -> 목록으로 이동
		// r == 0 : 비정상 -> alert -> 이전페이지로 이동
		if (r > 0) {
			model.addAttribute("msg", "정상적으로 등록되었습니다.");
			model.addAttribute("url", "index.do");
		} else {
			model.addAttribute("msg", "등록실패");
			model.addAttribute("url", "write.do");
		}
		return "include/alert";
	}
	
	@RequestMapping("/admin/board/edit.do")
	public String edit(Model model, BoardVo vo) {
		model.addAttribute("vo", service.edit(vo));
		return "admin/board/edit";
	}
	
	@RequestMapping("/admin/board/update.do")
	public String update(Model model, BoardVo vo, 
						@RequestParam MultipartFile file, HttpServletRequest req) {
		//service.insert(vo, filename, req)
		if (!file.isEmpty()) { // 첨부파일이 있으면
			try {
				String org = file.getOriginalFilename(); // 원본파일명
				String ext = ""; //확장자
				
				ext = org.substring(org.lastIndexOf("."));
				String real = new Date().getTime()+ext; // 서버에 저장할 파일명
	//			System.out.println("org:"+org);
	//			System.out.println("real:"+real);
				// 파일 저장
				String path = req.getRealPath("/upload/"); // 경로
				file.transferTo(new File(path+real)); // 경로+파일명 저장
				// vo에 set
				vo.setFilename_org(org);
				vo.setFilename_real(real);
			} catch (Exception e) {
				
			}
		}
		int r = service.update(vo);
		// r > 0 : 정상 -> alert -> 목록으로 이동
		// r == 0 : 비정상 -> alert -> 이전페이지로 이동
		if (r > 0) {
			model.addAttribute("msg", "정상적으로 수정되었습니다.");
			model.addAttribute("url", "index.do");
		} else {
			model.addAttribute("msg", "수정실패");
			model.addAttribute("url", "edit.do?no="+vo.getNo());
		}
		return "include/alert";
	}
	
	@RequestMapping("/admin/board/delete.do")
	public String delete(Model model, BoardVo vo, HttpServletRequest req) {
		int r = service.delete(vo);
		if (r > 0) {
			model.addAttribute("result", "true");
		} else {
			model.addAttribute("result", "false");
		}
		return "include/result";
	}
	
	// request로 처리
	@RequestMapping("/admin/board/groupDelete.do")
	public String groupDelete(Model model, HttpServletRequest req) {
		String[] no = req.getParameterValues("no");
		int count=0;
		for (int i=0; i<no.length; i++) {
			BoardVo vo = new BoardVo();
			vo.setNo(Integer.parseInt(no[i]));
			count+=service.delete(vo);
		}
		model.addAttribute("msg", "총 "+count+"건이 삭제되었습니다.");
		model.addAttribute("url", "index.do");
		return "include/alert";
	}
	// 커맨드객체로 처리
	@RequestMapping("/admin/board/groupDelete2.do")
	public String groupDelete2(Model model, BoardVo vo, HttpServletRequest req) {
		int count=service.deleteGroup(vo);
				
		model.addAttribute("msg", "총 "+count+"건이 삭제되었습니다.");
		model.addAttribute("url", "index.do");
		return "include/alert";
	}
	
}
