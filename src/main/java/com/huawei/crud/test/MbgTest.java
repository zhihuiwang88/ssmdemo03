package com.huawei.crud.test;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import org.mybatis.generator.api.MyBatisGenerator;
import org.mybatis.generator.config.Configuration;
import org.mybatis.generator.config.xml.ConfigurationParser;
import  org.mybatis.generator.internal.DefaultShellCallback;

public class MbgTest {
  public static void main(String[] args)  throws  Exception{	
	  
	 //使用Mybatis-Generator自动生成Dao、Model、Mapping相关文件  
	  
	 List<String> warnings = new ArrayList<String>();
	   boolean overwrite = true;
	   File configFile = new File("generatorConfig.xml");
	   ConfigurationParser cp = new ConfigurationParser(warnings);
	   Configuration config = cp.parseConfiguration(configFile);
	   DefaultShellCallback callback = new DefaultShellCallback(overwrite);
	   MyBatisGenerator myBatisGenerator = new MyBatisGenerator(config, callback, warnings);
	   myBatisGenerator.generate(null);
         }
   }
