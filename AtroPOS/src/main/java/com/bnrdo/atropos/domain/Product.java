package com.bnrdo.atropos.domain;

import java.math.BigDecimal;

public class Product {
	
	private String id;
	private String name;
	private String shortName;
	private BigDecimal price;
	
	public Product(String id, String name, String shortName, BigDecimal price){
		this.id = id;
		this.name = name;
		this.shortName = shortName;
		this.price = price;
	}

	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public BigDecimal getPrice() {
		return price;
	}
	public void setPrice(BigDecimal price) {
		this.price = price;
	}
	public String getShortName() {
		return shortName;
	}
	public void setShortName(String shortName) {
		this.shortName = shortName;
	}
}
