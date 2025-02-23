package com.javainuse.model;

public class Employee {
	private String empId;
	private String certId;
	private String certification;
	private String dateCompletion;
 
	 

	public Employee() {
	}

	

	public String getCertId() {
		return certId;
	}



	public void setCertId(String certId) {
		this.certId = certId;
	}



	public String getCertification() {
		return certification;
	}



	public void setCertification(String certification) {
		this.certification = certification;
	}



	public String getDateCompletion() {
		return dateCompletion;
	}



	public void setDateCompletion(String dateCompletion) {
		this.dateCompletion = dateCompletion;
	}



	public String getEmpId() {
		return empId;
	}

	public void setEmpId(String empId) {
		this.empId = empId;
	}

}