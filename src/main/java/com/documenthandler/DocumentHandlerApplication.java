package com.documenthandler;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.web.SecurityFilterChain;

@SpringBootApplication
public class DocumentHandlerApplication {
	
	public static void main(String[] args) {
		SpringApplication.run(DocumentHandlerApplication.class, args);
	}
	
	 @Bean
	    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
			http.authorizeHttpRequests().anyRequest().authenticated().and().formLogin().and().httpBasic();
			http.cors().and().csrf().disable(); // disabling since internal JSP to hit Servlet
	        return http.build();
	    }

}
