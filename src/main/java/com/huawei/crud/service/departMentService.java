package com.huawei.crud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.huawei.crud.bean.Department;
import com.huawei.crud.dao.DepartmentMapper;

@Service
public class departMentService {

	@Autowired
	DepartmentMapper  depMapper;
	
	public List<Department> getDepartment() {
		List<Department>  list=depMapper.selectByExample(null);
		return list;
	}

	
	
	
}
