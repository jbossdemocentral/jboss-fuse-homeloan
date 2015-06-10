package org.blogdemo.homeloan.processor;

public class HouseInfoProcessor {
	
	public String processAddress(String address){
		
		address = address.replaceAll(" ","+" );
		address = address.replaceAll(",", "");
		
		return address;
		
	}

}
