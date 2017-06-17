package com.fs;
import java.sql.*;

public class CreateTables {
	
	private static final String messageDetail = "create table messageDetail(from1 varchar(255) ,subject varchar(1000),date varchar(50),to1 varchar(255),message varchar(1000),star varchar(10),messId int NOT NULL AUTO_INCREMENT,status varchar(20),PRIMARY KEY (messId))";
	private static final String sentDetail = "create table sentDetail(from1 varchar(255) ,subject varchar(1000),date varchar(50),to1 varchar(255),message varchar(1000),star varchar(10),messId int NOT NULL AUTO_INCREMENT,status varchar(20),PRIMARY KEY (messId))";
	private static final String user = "create table user(name varchar(255),email varchar(255) not null,phone int,password varchar(255),logout varchar(50),primary key(email))";
	private static final String draft = "create table draft(from1 varchar(255),to1 varchar(255),status varchar(10),subject varchar(255),messId int not null auto_increment,message varchar(1000),primary key(messId))";
	
	
	public static void create(){ 
		try {
			Connection con = ConnectDatabase.getConnect();
			Statement pep = con.createStatement();
			pep.execute(messageDetail);
			pep.execute(sentDetail);
			pep.execute(user);
			pep.execute(draft);
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
}
