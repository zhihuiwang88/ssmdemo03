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

//ʹ��Spring����Ա��CRUD����ȷ��

@RunWith(value = SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = { "classpath:applicationContext.xml",
		"file:src/main/webapp/WEB-INF/dispatcherServlet-servlet.xml" })
public class MvcTest {
   //����MVC���󣬻�ȡ������
	MockMvc  mockMvc;
	//����springmvc��IOC
	@Autowired
	WebApplicationContext  context;
	
	@Before
	public  void initMockMvc(){
		//����MockMvc
		mockMvc=MockMvcBuilders.webAppContextSetup(context).build();
	}
	
	//���������в��Խӿ���ȷ��
	@Test
	public  void  pageTest() throws Exception{
		//ģ�������õ�����ֵ
	MvcResult	result=mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn", "1")).andReturn();
	//����ɹ�������������pageInfo�����Ը��������֤
	MockHttpServletRequest  request=result.getRequest();
	
	PageInfo  pi=(PageInfo) request.getAttribute("pageInfo");
	System.out.println("---��ǰҳ�룺"+pi.getPageNum());
	System.out.println("---��ҳ�룺"+pi.getPages());
	System.out.println("---�ܼ�¼����"+pi.getTotal());
	
	//������ʾ��ҳ�������� 1 2 3 4 5
	int[] nums=pi.getNavigatepageNums();
	System.out.println("������ʾ��ҳ��:");
	for (int i : nums) {
		System.out.print(" "+i);
	}
	System.out.println();
	//��ȡԱ������
	List<Employee> list=pi.getList();
	System.out.println("��ȡԱ�����ݺ���ʾ�������ݣ�");
	for (Employee employee : list) {
		System.out.println();
		System.out.println("ID:"+employee.getEmpId()+",NAME:"+employee.getEmpName());
	}
	
	}
}
