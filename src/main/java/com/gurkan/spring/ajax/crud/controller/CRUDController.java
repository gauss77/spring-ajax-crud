/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.gurkan.spring.ajax.crud.controller;

import com.gurkan.spring.ajax.crud.model.Person;
import com.gurkan.spring.ajax.crud.model.PersonDAOImpl;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 *
 * @author bjk_g
 */
@Controller
public class CRUDController {
    
    public static final String APP_NAME = "CRUD %100 AJAX";
    
    @Autowired 
    PersonDAOImpl dAOImpl;
    
    @RequestMapping(value = "/" , method = RequestMethod.GET)
    public String index(ModelMap map) {
        map.put("users", dAOImpl.getAllPerson());
        map.put("hello", APP_NAME);
        return "index";
    }
   
//    ,headers = {"Accept=*"}
    @RequestMapping(value = "/addPerson" , method = RequestMethod.POST)
    @ResponseBody
    public Person addPerson(@RequestBody Person person) {
        if (person.getName().equals("")) {
            return null;
        }
        dAOImpl.insert(person);
        
        return person;
    }
//    ,produces = MediaType.APPLICATION_JSON_VALUE,consumes= MediaType.APPLICATION_JSON_VALUE
    @RequestMapping(value = "/updatePerson" , method = RequestMethod.PUT)
    @ResponseBody
    public String updatePerson(@RequestBody Person person) {
        dAOImpl.update(person);
        return "{\"status\":\"Success\"}";
    }
    
    @RequestMapping(value = "/deletePerson" , method = RequestMethod.DELETE)
    @ResponseBody
    public void deletePerson(@RequestBody Map<String, String> id) {
        dAOImpl.remove(Integer.parseInt(id.get("id")));
    }
    
}
