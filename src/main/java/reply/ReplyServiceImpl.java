package reply;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ReplyServiceImpl implements ReplyService {

	@Autowired
	ReplyDao dao;
	
	@Override
	public List<ReplyVo> selectAll(ReplyVo vo) {
		int totCount = dao.count(vo); // 총갯수
		// 총페이지수
		int totPage = totCount / vo.getPageRow();
		if (totCount % vo.getPageRow() > 0) totPage++;
		// 시작페이지
		int startPage = (vo.getReqPage()-1)/vo.getPageRange()
						*vo.getPageRange()+1;
		int endPage = startPage+vo.getPageRange()-1;
		if (endPage > totPage) endPage = totPage;
		
		vo.setStartPage(startPage);
		vo.setEndPage(endPage);
		vo.setTotCount(totCount);
		vo.setTotPage(totPage);
		return dao.selectAll(vo);
	}

	@Override
	public ReplyVo deatil(ReplyVo vo) {
		dao.updateReadcount(vo);
		return dao.detail(vo);
	}

	@Override
	public int insert(ReplyVo vo) {
		if (dao.insert(vo) > 0) {
			dao.gno(vo.getNo());
			return 1;
		} else {
			return 0;
		}
	}
	
	@Override
	public int insertReply(ReplyVo vo) {
		dao.onoUpdate(vo);
		vo.setOno(vo.getOno()+1);
		vo.setNested(vo.getNested()+1);
		return dao.insertReply(vo);
	}

	@Override
	public ReplyVo edit(ReplyVo vo) {
		return dao.detail(vo);
	}
	
	@Override
	public int update(ReplyVo vo) {
		if ("1".equals(vo.getIsDel())) {
			dao.delFilename(vo);
		}
		return dao.update(vo);
	}
	
	@Override
	public int delete(ReplyVo vo) {
		return dao.delete(vo);
	}
}
