package reply;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ReplyDao {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public List<ReplyVo> selectAll(ReplyVo vo) {
		return sqlSession.selectList("reply.selectAll", vo);
	}
	
	public int count(ReplyVo vo) {
		return sqlSession.selectOne("reply.count", vo);
	}
	
	public ReplyVo detail(ReplyVo vo) {
		return sqlSession.selectOne("reply.detail", vo);
	}
	
	public void updateReadcount(ReplyVo vo) {
		sqlSession.update("reply.updateReadcount", vo);
	}
	public void gno(int no) {
		sqlSession.update("reply.gno", no);
	}
	
	public int insert(ReplyVo vo) {
		return sqlSession.insert("reply.insert", vo);
	}
	public int insertReply(ReplyVo vo) {
		return sqlSession.insert("reply.insertReply", vo);
	}
	public int onoUpdate(ReplyVo vo) {
		return sqlSession.update("reply.onoUpdate", vo);
	}
	
	public int update(ReplyVo vo) {
		return sqlSession.update("reply.update", vo);
	}
	
	public int delFilename(ReplyVo vo) {
		return sqlSession.update("reply.delFilename", vo);
	}
	
	public int delete(ReplyVo vo) {
		return sqlSession.delete("reply.delete", vo);
	}
}
