package com.bnrdo.atropos.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class MainController {
	@RequestMapping(value = "/dashboard.htm", method = RequestMethod.GET)
	protected String showDashboard(HttpServletRequest request) throws Exception {
		return "dashboard";
	}
	@RequestMapping(value = "/browse.htm", method = RequestMethod.GET)
	protected String showBrowse(HttpServletRequest request) throws Exception {
		return "browse";
	}
	@RequestMapping(value = "/pos.htm", method = RequestMethod.GET)
	protected String showPOS(HttpServletRequest request) throws Exception {
		return "pos";
	}
	@RequestMapping(value = "/reports.htm", method = RequestMethod.GET)
	protected String showReports(HttpServletRequest request) throws Exception {
		return "reports";
	}
	@RequestMapping(value = "/settings.htm", method = RequestMethod.GET)
	protected String showSettings(HttpServletRequest request) throws Exception {
		return "settings";
	}
}
