package com.javainuse.controllers;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.javainuse.model.Employee;

@RestController
public class TestController {

	@RequestMapping(value = "/empcertifications", method = RequestMethod.GET)
	public Employee firstPage() {

		Employee emp = new Employee();
		emp.setEmpId("36975");
		emp.setCertId("AZ-204");
		emp.setCertification("Developing Solutions for Microsoft Azure");
		emp.setDateCompletion("01/01/2023");
		return emp;
	}

}