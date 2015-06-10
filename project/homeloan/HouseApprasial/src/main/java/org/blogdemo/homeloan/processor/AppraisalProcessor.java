package org.blogdemo.homeloan.processor;

import org.apache.camel.LoggingLevel;
import org.apache.camel.util.CamelLogger;
import org.blogdemo.homeloan.model.HouseInfo;

public class AppraisalProcessor {
	private final CamelLogger logger = new CamelLogger(AppraisalProcessor.class.getCanonicalName(), LoggingLevel.INFO);
	
	public HouseInfo quote(HouseInfo houseInfo){
		
		int appraisedValue = 0;
		
		
		appraisedValue += houseInfo.getLandSize() * 1000;
		appraisedValue += houseInfo.getBathroom() * 2000;
		appraisedValue += houseInfo.getBedroom() * 2500;
		
		houseInfo.setAppraisedValue(appraisedValue);
		
		return houseInfo;	
	}
	
	
	public HouseInfo updateQuoteWithSchools(HouseInfo houseInfo, int noSchool){

		
		
		double upPrice = ((110.00+noSchool)/100.00)*houseInfo.getAppraisedValue();

		logger.doLog("Up percent ["+(110+noSchool)/100.00+"]");
		
		int appraisedValue = (int) Math.round(upPrice);
		logger.doLog("This price has gone up from ["+houseInfo.getAppraisedValue()+"] to ["+appraisedValue+"]");
		
		
		houseInfo.setAppraisedValue(appraisedValue);
		
		return houseInfo;	
	}
	
}
