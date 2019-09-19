package com.huawei.crud.controller;

import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.huawei.crud.bean.Employee;
import com.huawei.crud.bean.JsonResult;
import com.huawei.crud.bean.Msg;
import com.huawei.crud.service.EmployeeService;

//����Ա�����CRUD

@Controller

public class EmployeeController {

	@Autowired
	EmployeeService emService;

	// https://github.com/pagehelper/Mybatis-PageHelper pageNum,pn:�ӵ�һҳ��ʼ

	@RequestMapping("emps")
	@ResponseBody
	public JsonResult selectAllData(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model) {
		// ��ѯ֮ǰ����startPage. 3---һҳ��ʾ����������
		PageHelper.startPage(pn, 5);
		// startPage������Ƿ�ҳ��ѯ
		List<Employee> emps = emService.getAll();
		// ��PageInfo�Խ�����а�װ. 5--������ʾ��ҳ��
		PageInfo page = new PageInfo(emps, 5);
		model.addAttribute("pageInfo", page);
		// return Msg.succes().add("pageInfo", page);
		return new JsonResult(1, "����json���ݳɹ�", page);
	}

	/**
	 * JSR303数据校验
	 * 
	 * @param employee
	 *            Valid注解用于校验
	 */
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	@ResponseBody
	public Msg saveEmp(@Valid Employee employee, BindingResult result) {
		// 根据result判断成功或者失败
		if (result.hasErrors()) {
			// 1.校验失败
			List<FieldError> errors = result.getFieldErrors();
			Map<String, Object> map = new HashMap<String, Object>();
			for (FieldError fieldError : errors) {
				System.out.println("错误的字段： " + fieldError.getField());
				System.out.println("错误的信息： " + fieldError.getDefaultMessage());
				map.put(fieldError.getField(), fieldError.getDefaultMessage());
			}
			return Msg.fail().add("errorField", map);
		} else {
			// 2.校验成功
			emService.insert(employee);
			return Msg.succes();
		}

	}

	/**
	 * ����û����Ƿ����
	 * @param empName
	 *            �û���
	 */
	@RequestMapping(value = "/checkuser", method = RequestMethod.POST)
	@ResponseBody
	public JsonResult checkUser(@RequestParam("empName") String empName) {
		// ��֤�û����Ϸ���
		String regex = "(^[a-zA-Z0-9_-]{5,16}$)|(^[\u2E80-\u9FFF]{2,5})";
		if (!empName.matches(regex)) {
			return new JsonResult(101, "用户名要求2-5位中文或者5-16位的数字和字母的组合！");
		}

		boolean b = emService.checkUser(empName);
		if (b) {
			return new JsonResult(200, "用户名可用");
		} else {
			return new JsonResult(100, "用户名不可用哦");
		}
	}

	/**
	 * 根据id查询数据
	 * @param id
	 */
	@RequestMapping("/select/{id}")
	@ResponseBody
	public JsonResult selectEmp(@PathVariable("id") Integer id) {
		Employee employee = emService.select(id);
		return new JsonResult(200, "查询全部成功！", employee);
	}

	/**
	 * 根据ID更新数据 1.Tomcat可以封装POST的请求体内容，不能封装PUT的请求体内容
	 * 2.在web.xml里加入HttpPutFormContentFilter，就可以啦。
	 * @param employee
	 * @param request
	 * @return
	 */

	@RequestMapping(value = "update/{empId}", method = RequestMethod.PUT)
	@ResponseBody
	public JsonResult updateById(Employee employee, HttpServletRequest request) {
		emService.updateById(employee);
		return new JsonResult(200, "更新数据成功！", employee);
	}

	/**
	 * 根据ID进行删除 批量删除:1-2-3-4-5 
	 * 单个删除：1
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "delete/{ids}", method = RequestMethod.PUT)
	@ResponseBody
	public JsonResult deleteById(@PathVariable("ids") String ids) {
		// 如果是批量删除.contains(),该方法是判断字符串中是否有子字符串
		if (ids.contains("-")) {
			List<Integer> listIds = new ArrayList<>();
			// split(),把字符串按照 - 分割成字符串数组
			String[] strids = ids.split("-");
			// 组装多个ID
			for (String string : strids) {
				listIds.add(Integer.parseInt(string));
			}
			emService.deleteBatch(listIds);
		} else {
			// 单个删除，把String的ids转为 Integer的id
			Integer id = Integer.parseInt(ids);
			emService.deleteById(id);
		}
		return new JsonResult(200, "删除成功！");
	}
	
	
	
	
}
