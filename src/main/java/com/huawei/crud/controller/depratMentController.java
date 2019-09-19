package com.huawei.crud.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.huawei.crud.bean.Department;
import com.huawei.crud.bean.JsonResult;
import com.huawei.crud.service.departMentService;

@Controller
public class depratMentController {

	/**
	 * ��ʾ������Ϣ
	 */
	@Autowired
	departMentService  depService;
	
	@RequestMapping("departs")
	@ResponseBody
	public JsonResult getAllDepart(){
		
		List<Department>  list=depService.getDepartment();
		return  new  JsonResult(200,"���ز��ųɹ�",list);
	}
	
}
