package com.bnrdo.atropos.controller;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bnrdo.atropos.domain.Product;

@Controller
public class ProductController {
	@ResponseBody
	@RequestMapping(value = "/getQuickItems.htm", method = RequestMethod.POST)
	protected String getQuickItems(HttpServletRequest request) throws Exception {
		System.out.println("inside the getquickitems");
		List<Product> products = new ArrayList<Product>();
		
		Product p1 = new Product("ABC21X", "Salompas", "SALOMPAS", new BigDecimal("8.75"));
		Product p2 = new Product("FK3HJ2", "Candy", "CANDY", new BigDecimal("6.00"));
		Product p3 = new Product("KSI82U", "Ligo Sardines", "LIGOSARDNS", new BigDecimal("15.25"));
		Product p4 = new Product("3HYU71", "Lollipop", "LOLLIP", new BigDecimal("15.15"));
		Product p5 = new Product("QAAW2H", "Biogesic", "BIOGSC", new BigDecimal("4.50"));
		Product p6 = new Product("KJHYT7", "Medicol", "MEDICL", new BigDecimal("5.00"));
		Product p7 = new Product("XNJYAN", "Chippy", "CHIPPY", new BigDecimal("7.00"));
		Product p8 = new Product("KALS21", "Sunsilk Pink", "SUNSILKPNK", new BigDecimal("150.00"));
		Product p9 = new Product("ITE23G", "Safeguard", "SAFEGRD", new BigDecimal("45.00"));
		Product p10 = new Product("KJ8S81", "Baygon Katol", "BAYGONKTOL", new BigDecimal("32.00"));
		Product p11 = new Product("NM21MX", "Nestle Cococrunch", "NESTLCOCO", new BigDecimal("60.50"));
		Product p12 = new Product("ZP1JAK", "Vaseline", "VASELINE", new BigDecimal("215.25"));
		
		products.add(p1);
		products.add(p2);
		products.add(p3);
		products.add(p4);
		products.add(p5);
		products.add(p6);
		products.add(p7);
		products.add(p8);
		products.add(p9);
		products.add(p10);
		products.add(p11);
		products.add(p12);
		
		ObjectMapper mapper = new ObjectMapper();
		
		return mapper.writeValueAsString(products);
	}
}
