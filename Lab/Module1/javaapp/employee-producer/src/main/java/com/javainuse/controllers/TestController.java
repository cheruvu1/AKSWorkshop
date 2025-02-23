package com.javainuse.controllers;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.javainuse.model.Employee;

@RestController
public class TestController {

	@RequestMapping(value = "/employee", method = RequestMethod.GET)
	public Employee firstPage() {

		Employee emp = new Employee();
		emp.setName("David Lee");
		emp.setDesignation("Cloud Architect");
		emp.setEmpId("36975");
		emp.setSalary(7000.00);
		emp.setAddress("One Microsoft Way, Redmond, Washington, 98052-6399, USA");

		return emp;
	}

}