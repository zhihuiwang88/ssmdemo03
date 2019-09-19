package com.huawei.crud.bean;

import java.util.HashMap;
import java.util.Map;

public class JsonResult {
	/**
	 * ״̬��(����404��һ��״̬) State=1,��ʾҵ��ɹ����. State=0,��ʾҵ�����ʧ��
	 */
	private int state;
	/**
	 * ��״̬���Ӧ�ľ�����Ϣ( ����404��ʾ������Ϣ,��url��Ӧ�ĵ�ַû�ҵ�)
	 */
	private String message;
	/**
	 * ���������Է�װ����˷��صľ�������, �����ѯ�Ľ��
	 */
	private Object data;

	public JsonResult() {
	}

	public JsonResult(int state, String message) {
		this.state = state;
		this.message = message;
	}

	public JsonResult(int state, String message, Object data) {
		this.state = state;
		this.message = message;
		this.data = data;
	}

	private Map<String, Object> extend = new HashMap<String, Object>();

	public JsonResult addPut(String key, Object value) {
		this.getExtend().put(key, value);
		return this;

	}

	public Map<String, Object> getExtend() {
		return extend;
	}

	public void setExtend(Map<String, Object> extend) {
		this.extend = extend;
	}

	/**
	 * ���ڿ��Ʋ㽫һ��JsonResult���� ת��ΪJSON��ʱ,����ô˶����Ӧ�� get����
	 */
	public int getState() {
		return state;
	}

	public String getMessage() {
		return message;
	}

	public Object getData() {
		return data;
	}

	@Override
	public String toString() {
		return "JsonResult [state=" + state + ", message=" + message + ", data=" + data + "]";
	}

}
