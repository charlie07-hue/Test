package junit4;

import org.junit.After;
import org.junit.Before;
import org.junit.FixMethodOrder;
import org.junit.Test;
import org.junit.runners.MethodSorters;

public class Test1 {

	// junit4
	// Before -> Test -> After
	
	@Before
	public void before() {
		System.out.println("Before");
	}
	
	@Test
	public void bbb() {
		System.out.println("Test2");
	}
	
	@Test
	public void aaa() {
		System.out.println("Test");
	}
	
	
	
	@After
	public void after() {
		System.out.println("After");
	}
}
