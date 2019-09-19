package com.huawei.crud.test;

import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import com.huawei.crud.bean.Department;
import com.huawei.crud.bean.Employee;
import com.huawei.crud.dao.DepartmentMapper;
import com.huawei.crud.dao.EmployeeMapper;

@RunWith(value = SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:applicationContext.xml" })
public class MapperTest {

	@Autowired
	DepartmentMapper deMapper;

	@Autowired
	EmployeeMapper emMapper;

	@Autowired
	SqlSession sqlSession;

	@Test
	public void testCrud() {

		System.out.println("1---" + deMapper);

		// 部门表测试
		deMapper.insertSelective(new Department(null, "研发部"));
		deMapper.insertSelective(new Department(null, "研发部2"));
		deMapper.insertSelective(new Department(null, "研发部3"));
		System.out.println("1-----部门表插入数据成功");

		// 2员工表测试
		// 2.1 单个插入
		emMapper.insertSelective(new Employee(null, "李四", "男", "lisi@huawei.com", 4));
		emMapper.insertSelective(new Employee(null, "张三", "男", "zsan@huawei.com", 4));
		emMapper.insertSelective(new Employee(null, "王五", "男", "wwu@huawei.com", 4));
		System.out.println("2----员工表单个插入数据成功");

		// 2.2批量插入
		EmployeeMapper emp = sqlSession.getMapper(EmployeeMapper.class);
		for (int i = 0; i < 11; i++) {
			String uuid = UUID.randomUUID().toString().substring(0, 6) + i;
			emp.insertSelective(new Employee(null, uuid, "M", uuid + "@huawei.com", 4));
		}
		System.out.println("3----员工表批量插入数据成功");
	}

}
