package com.huawei.crud.bean;

import java.util.HashMap;
import java.util.Map;
//Msg��JsonResult�������Ǹ�������
public class Msg {

	/*
	 * 1.���÷���״̬��
	 * 2.���÷�����Ϣ���ѣ��ɹ���ʧ�ܣ�
	 * 3.���÷��������������
	 */
	
	//1.���÷���״̬��
	private  Integer code;
	//2.���÷�����Ϣ���ѣ��ɹ���ʧ�ܣ�
	private  String message;
	//3.���÷��������������
	private  Map<String ,Object>  extend=new HashMap<String,Object>();
	
	//���ѷ��سɹ���Ϣ
	public static Msg  succes(){
		Msg  result=new  Msg();
		result.setCode(200);
		result.setMessage("成功");
		return result;
	}
	
	//���ѷ���ʧ����Ϣ
	public static Msg  fail(){
		Msg  result=new  Msg();
		result.setCode(100);
		result.setMessage("失败");
	    return result;  
	}
	//���ص����ݸ�ǰ̨
	public  Msg add(String key,Object  value){
		this.getExtend().put(key, value);
		return this;
	}
	
	
	public Integer getCode() {
		return code;
	}
	public void setCode(Integer code) {
		this.code = code;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public Map<String, Object> getExtend() {
		return extend;
	}
	public void setExtend(Map<String, Object> extend) {
		this.extend = extend;
	}
	
	
}
