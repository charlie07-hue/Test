package junit5;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

public class Test1 {

	// 모든 테스트 전 실행
	@BeforeAll
	static void beforeAll() {
		System.out.println("BeforeAll");
	}
	
	// 각 테스트 전 실행
	@BeforeEach
	void beforeEach() {
		System.out.println("BeforeEach");
	}
	
	// 각 테스트 후 실행
	@AfterEach
	void afterEach() {
		System.out.println("AfterEach");
	}
	
	// 모든 테스트 후 실행
	@AfterAll
	static void afterAll() {
		System.out.println("AfterAll");
	}
	
	// 테스트
	@Test
	void test() {
		System.out.println("Test");
	}
	
	@Test
	void test2() {
		System.out.println("Test2");
	}
}
