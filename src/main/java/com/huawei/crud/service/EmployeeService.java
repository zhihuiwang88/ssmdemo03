package com.huawei.crud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.huawei.crud.bean.Employee;
import com.huawei.crud.bean.EmployeeExample;
import com.huawei.crud.bean.EmployeeExample.Criteria;
import com.huawei.crud.dao.EmployeeMapper;

@Service
public class EmployeeService {

	@Autowired
	EmployeeMapper employeeMapper;

	public List<Employee> getAll() {
		return employeeMapper.selectByExampleWithDept(null);
	}

	// ����Ա����Ϣ
	public void insert(Employee employee) {
		employeeMapper.insertSelective(employee);
	}

	/**
	 * ����û����Ƿ����
	 * 
	 * @param empName
	 * @return true:�û������� �� false:�û���������
	 */
	public boolean checkUser(String empName) {
		EmployeeExample example = new EmployeeExample();
		// Criteria��ѯ��Hibernate�ṩ��һ�ֲ�ѯ��ʽ
		Criteria criteria = example.createCriteria();
		// ��ѯ�û���
		criteria.andEmpNameEqualTo(empName);
		long count = employeeMapper.countByExample(example);
		return count == 0;
	}
//根据id查询数据

	public Employee select(Integer id) {
		Employee employee= employeeMapper.selectByPrimaryKey(id);
		return employee;
		 
	}
/*
 * 根据ID更新数据
 * "empId":7,"empName":null,"gender":"G","email":"7b90@huawei.com","dId":13,"department":null
 * updateByPrimaryKeySelective选择性更新数据是这样的效果。
 */
	public void updateById(Employee employee) {
		employeeMapper.updateByPrimaryKeySelective(employee);
	}
/*
 * 根据ID进行删除
 */
	public void deleteById(Integer id) {
		employeeMapper.deleteByPrimaryKey(id);
	}

	/*
	 * 批量删除
	 */
	public void deleteBatch(List<Integer> ids) {
		EmployeeExample emple = new EmployeeExample();
		Criteria createCriteria = emple.createCriteria();
		// delete from A where emp_id in()
		createCriteria.andEmpIdIn(ids);
		employeeMapper.deleteByExample(emple);
	}
	

}
