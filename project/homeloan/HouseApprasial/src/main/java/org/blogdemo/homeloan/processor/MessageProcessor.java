package org.blogdemo.homeloan.processor;

import java.util.Map;

import org.apache.camel.Exchange;
import org.apache.camel.Message;
import org.apache.camel.Processor;

public class MessageProcessor implements Processor{
	
	@Override
	public void process(Exchange exchange) throws Exception {
		Map<String,Object> headers = exchange.getIn().getHeaders();
		
		for(String headerName : headers.keySet()){
			System.out.println("headerName:{"+headerName+"]");
		}
		Message originalMessage = exchange.getUnitOfWork().getOriginalInMessage(); 
		System.out.println("Original Message:{"+originalMessage+"]"); 
		exchange.getOut().setHeader("SchoolNum", exchange.getIn().getBody());
		exchange.getOut().setBody(originalMessage.getBody());
		
		
	}

}
