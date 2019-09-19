package com.huawei.crud.test;

import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;
import com.github.pagehelper.PageInfo;
import com.huawei.crud.bean.Employee;

//使用Spring测试员工CRUD的正确性

@RunWith(value = SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = { "classpath:applicationContext.xml",
		"file:src/main/webapp/WEB-INF/dispatcherServlet-servlet.xml" })
public class MvcTest {
   //虚拟MVC请求，获取处理结果
	MockMvc  mockMvc;
	//传入springmvc的IOC
	@Autowired
	WebApplicationContext  context;
	
	@Before
	public  void initMockMvc(){
		//创建MockMvc
		mockMvc=MockMvcBuilders.webAppContextSetup(context).build();
	}
	
	//接下来进行测试接口正确否
	@Test
	public  void  pageTest() throws Exception{
		//模拟请求拿到返回值
	MvcResult	result=mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn", "1")).andReturn();
	//请求成功后，请求域中有pageInfo，可以根据这个验证
	MockHttpServletRequest  request=result.getRequest();
	
	PageInfo  pi=(PageInfo) request.getAttribute("pageInfo");
	System.out.println("---当前页码："+pi.getPageNum());
	System.out.println("---总页码："+pi.getPages());
	System.out.println("---总记录数："+pi.getTotal());
	
	//连续显示的页数，例如 1 2 3 4 5
	int[] nums=pi.getNavigatepageNums();
	System.out.println("连续显示的页数:");
	for (int i : nums) {
		System.out.print(" "+i);
	}
	System.out.println();
	//获取员工数据
	List<Employee> list=pi.getList();
	System.out.println("获取员工数据后显示部分数据：");
	for (Employee employee : list) {
		System.out.println();
		System.out.println("ID:"+employee.getEmpId()+",NAME:"+employee.getEmpName());
	}
	
	}
}
