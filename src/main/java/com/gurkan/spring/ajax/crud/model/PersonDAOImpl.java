/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.gurkan.spring.ajax.crud.model;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

/**
 *
 * @author bjk_g
 */

@Repository
public class PersonDAOImpl implements PersonDAO{
    
    private static final List<Person> myPersons = new ArrayList<>();
    
    static int id = 4;
    
    static { 
       
        myPersons.add(new Person(1, "Person1", 14));
        myPersons.add(new Person(2, "Person2", 24));
        myPersons.add(new Person(3, "Person3", 34));
        myPersons.add(new Person(4, "Person4", 45));
    }
    
    @Override
    public  void insert(Person p) {
        p.setId(++id);
        myPersons.add(p);
    }
    
    @Override
    public  void remove(int id) {
//        myData.removeIf(p -> p.getId() == id);
            myPersons.stream()
                .filter(p -> p.getId()==id)
                .findFirst()
                .map(p -> myPersons.remove(p));
//                .collect(Collectors.toList());
    }
    
    @Override
    public void update(Person person) {
        myPersons.stream()
            .filter(p -> p.getId() == person.getId())
            .findFirst()
            .map(newP -> {
                newP.setName(person.getName());
                newP.setAge(person.getAge());
                return newP;
            });
       
    }
    
    @Override
    public  List<Person> getAllPerson(){
        return myPersons;
    }
}
