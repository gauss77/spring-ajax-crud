/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.gurkan.spring.ajax.crud.model;

import java.util.List;


/**
 *
 * @author bjk_g
 */


public interface PersonDAO {
    public  void insert(Person p);
    public  List<Person> getAllPerson();
    public  void update(Person person);
    public  void remove(int id);   
}
