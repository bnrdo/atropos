package com.bnrdo.atropos.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller 
public class FeesController {
	@ResponseBody
	@RequestMapping(value = "/getCustomerInfo.htm", method = RequestMethod.POST)
	protected String getCustomerInfo(HttpServletRequest request) throws Exception {
		return "";
	}
}
