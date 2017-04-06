<%-- 
    Document   : index
    Created on : 07.Mar.2017, 11:13:34
    Author     : bjk_g
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>JSP Page</title>
    <style>
        table, th, td {
            border: 1px solid black;
        }
    </style>
    <link rel="stylesheet" href="https://bootswatch.com/readable/bootstrap.min.css" />
</head>
<body>
    <h1>${hello}</h1>
    <table id="person-list" class="table table-striped table-hover" style="width: 35%">
        <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Age</th>
        </tr>
        <c:forEach items="${users}" var="user">
            <tr>
                <td> ${user.id}</td>
                <td class="display${user.id}" id="displayName${user.id}"> ${user.name}</td>
                <td class="display${user.id}" id="displayAge${user.id}"> ${user.age}</td>
                <td style="display: none;" class="edit${user.id}"> 
                  <input type="text" name="editName${user.id}" id="editName${user.id}" value="${user.name}" />
                </td>
                <td style="display: none;" class="edit${user.id}"> 
                  <input type="text" name="editAge${user.id}" id="editAge${user.id}" value="${user.age}" />
                </td>
                <td>
                  <input type="button" class="delete-person" data-item-id="${user.id}" id="delete-person${user.id}" value="Delete" /> 
                </td>
                <td> 
                  <input type="button" class="update-person" data-item-id="${user.id}" id="update-person${user.id}" value="Update" /> 
                </td>
                <td style="display: none;" class="edit${user.id}">
                  <input type="button"  class="update-person" data-item-id="${user.id}" id="edit-person${user.id}" value="Confirm" /> 
                </td>
                <td id="updatecheck${user.id}" style="display: none"><span class="label label-success" >OK</span></td>
            </tr>
        </c:forEach>
        <tr>
            <td>NEW</td>
            <td><input type="text" name="name" id="name" placeholder="Enter Name" /></td>
            <td><input type="text" name="age" id="age" placeholder="Enter Age" /></td>
            <td>
                <input type="button" id="add-person" value="Add" />
            </td>
        </tr>
    </table>
    <span class="otherchecks label label-success" style="display: none;">SUCCESS</span>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"
  integrity="sha256-hVVnYaiADRTO2PzUGmuLJr8BLUSjGIZsDYGmIJLv2b8="
  crossorigin="anonymous">
</script>
<script>
    $(document).ready(function() {
        
        $("#add-person").click(function(){
            
            var name= $("#name").val();
            var age = $("#age").val();
           
            var data = JSON.stringify({"name":name,"age":age});
           
            $.ajax({
            type : "POST",
            url : "${pageContext.request.contextPath}/addPerson",
            contentType: "application/json",
            data : data,
            success: function(data){
            
            if(data===""){
                return;
            }else{           
                var html = [];
                html.push(
                  '<tr>',
                  '<td>'+data.id+'</td>',
                  '<td class="display'+data.id+'" id="displayName'+data.id+'">'+data.name+'</td>',
                  '<td class="display'+data.id+'" id="displayAge'+data.id+'">'+ data.age+'</td>',
                  '<td style="display: none;" class="edit'+data.id+'"> <input type="text" name="editName'+data.id+'" id="editName'+data.id+'" value="'+data.name+'" /></td>',
                  '<td style="display: none;" class="edit'+data.id+'"> <input type="text" name="editAge'+data.id+'" id="editAge'+data.id+'" value="'+data.age+'" /></td>',
                  '<td><input type="button" class="delete-person" data-item-id="'+data.id+'" id="delete-person'+data.id+'" value="Delete" /></td>',
                  '<td> <input type="button" class="update-person" data-item-id="'+data.id+'" id="update-person'+data.id+'" value="Update" /> </td>',
                  '<td style="display: none;" class="edit'+data.id+'"> <input type="button"  class="update-person" data-item-id="'+data.id+'" id="edit-person'+data.id+'" value="Confirm" /> </td>',
                  '<td id="updatecheck'+data.id+'" style="display: none;background-color: greenyellow; color:white;">OK</td>',
                  '</tr>'
                );
                var a = html.join("");
                $('#person-list tr:last').before(a);

                   $("#name").val("");
                   $("#age").val("");

                   $(".otherchecks").show();
                   setTimeout(function() { $(".otherchecks").hide(); }, 2000);
                 }
               }
            });
        });
        
        $("#person-list").on('click','.update-person',function(){
          
            var value = $(event.target).val();
            var id = $(event.target).data('itemId');
            var tdclassshow = ".edit"+id;
            var tdclasshide = ".display"+id;
            var editnameid = "#editName"+id;
            var editageid = "#editAge"+id;

            var confirmbuttonshow = ".edit"+id;

            if(value==="Update"){
                $(tdclassshow).show();
                $(tdclasshide).hide();
                $(confirmbuttonshow).show();
            }else if(value==="Confirm"){
                var name = $(editnameid).val();
                var age = $(editageid).val();
                var data = JSON.stringify({"id":id ,"name":name,"age":age});

                $.ajax({
                   type : "PUT",
                   url : "${pageContext.request.contextPath}/updatePerson",
                   contentType: "application/json",
                   data : data,
                   success: function(data){

                     $(tdclassshow).hide();
                     $(tdclasshide).show();
                     $(confirmbuttonshow).hide();
                     
                     var dispName = "#displayName"+id;
                     var dispAge = "#displayAge"+id;
                     $(dispName).text(name);
                     $(dispAge).text(age);
                     
                     $('#updatecheck'+id).show();
                     setTimeout(function() { $('#updatecheck'+id).hide(); }, 2000);

                   }
                 });
                 
            }
          
        });

        $("#person-list").on('click','.delete-person',function(event){
            var id = $(event.target).data('itemId');
            var data = JSON.stringify({"id":id});
            var rowId= "#"+event.target.id;
            $.ajax({
            type : "DELETE",
            url : "${pageContext.request.contextPath}/deletePerson",
            contentType: "application/json",
            data : data,
            success: function(data){
               $(rowId).closest('tr').remove();
               $(".otherchecks").show();
               setTimeout(function() { $(".otherchecks").hide(); }, 2000);
            }
            });
        });
        
        $("#testmap").click(function(){
           
           var data = JSON.stringify({question:"1",answer:"2"});
          
            $.ajax({
            type : "POST",
            url : "${pageContext.request.contextPath}/testmap",
            headers: { 
                'Accept': 'application/json',
                'Content-Type': 'application/json' 
            },
//            contentType: "application/json",
            data : data,
            success: function(data){
               
            }
            });
        });
        
        
    });
    
</script>
</body>
</html>
