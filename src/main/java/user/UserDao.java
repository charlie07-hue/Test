package user;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class UserDao {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public List<UserVo> selectAll(UserVo vo) {
		return sqlSession.selectList("user.selectAll", vo);
	}
	
	public int count(UserVo vo) {
		return sqlSession.selectOne("user.count", vo);
	}
	
	public UserVo detail(UserVo vo) {
		return sqlSession.selectOne("user.detail", vo);
	}
	
	public int insert(UserVo vo) {
		return sqlSession.insert("user.insert", vo);
	}
	
	public int update(UserVo vo) {
		return sqlSession.update("user.update", vo);
	}
	
	public int delete(UserVo vo) {
		return sqlSession.delete("user.delete", vo);
	}
	
	public int isDuplicateId(String id) {
		return sqlSession.selectOne("user.isDuplicateId", id);
	}
	
	public UserVo login(UserVo vo) {
		return sqlSession.selectOne("user.login", vo);
	}
	
	public UserVo searchId(UserVo vo) {
		return sqlSession.selectOne("user.searchId", vo);
	}
	
	public UserVo searchPwd(UserVo vo) {
		return sqlSession.selectOne("user.searchPwd", vo);
	}
	
	public int updateTempPwd(UserVo vo) {
		return sqlSession.update("user.updateTempPwd", vo);
	}
}
