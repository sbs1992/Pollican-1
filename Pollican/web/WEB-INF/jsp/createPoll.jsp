<%
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
response.setDateHeader("Expires", 0); // Proxies.
%>
<%@include file="header.jspf" %>

        
        <div id="page-wrapper">

            <div class="container-fluid">

                <!-- Page Heading -->
                <div class="row" id="createPolldiv">
                    <div class="col-lg-12 form-horizontal">
                        <h1 class="page-header">
                            Create Poll
                        </h1>
                      
                        <div id='d1' class="col-sm-8 col-md-8 col-lg-8 col-sm-offset-0 col-md-offset-1 col-lg-offset-2">
                            <div class="form-group">
                                <label class="control-label col-sm-3" for="title">Title:</label>
                                <div class="col-sm-9">
                                <input type="text" class="form-control" id="title" placeholder="Enter a Relevant Title"  maxlength="70" required>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-sm-3" for="desc">Description:</label>
                                <div class="col-sm-9">
                                <textarea class="form-control" id="desc" rows="3"></textarea>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-sm-3" for="category">Tag Categories:</label>
                                <div class="col-sm-9" >
                                    <select id="category" multiple="multiple"  tabindex="-1" class="select2-offscreen" style="width: 150px;" required></select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-sm-3" for="sd">Start Time <small>Poll will start on this time</small>:</label>
                                <div class="col-sm-3">
                                <input type="text" class="form-control" id="sd" name="sd"/>
                                </div>
                                <label class="control-label col-sm-3" for="ed">End Time:</label>
                                <div class="col-sm-3">
                                <input type="text" class="form-control" id="ed" name="ed"/>
                                </div>
                            </div>
                            <div class="form-group" id='d2'>
                                
                            </div>
                            <div class="form-group" id='d3'>
                                
                            </div>
                           
                            <div class="form-group" id="tk">
                            <button class="btn btn-primary btn-group-sm" onclick="addQuestion()" id="addQuestion">Add Question</button>
                           
                            <input class="btn btn-success pull-right" type='button' onclick="send()" value='Submit Poll' id='Submit'>
                            </div>
                        </div>
                       
                        
                        
                    </div>
                </div>
            </div>
              
        <div class="jumbotron text-center" id="afterPollCreation">
      <div class="container">
        <h1>Your Poll has been successfully created!</h1>
        <p>Now you can Share it, tweet it or embed it with the link given below</p>
        <div class="row" id="share_id">
           
        </div>
        <p>OR</p>
        <p><button class="btn btn-primary btn-group-lg" onclick="window.location.reload()" id="createAnother">Create Another Poll</button></p>
      </div>
    </div>
    </div>
                        
 

<script type="text/javascript">
    $(window).bind("load", function() {
       $.getScript('${delimiter}pages/resources/js/social.js', function() {});
    });
var iq=0,ie=0,del=0,ttval=0,mapper=0,editmapper=0;
var questions,qtypes,divqid,answer,column,row,divsqid,buttonid,buttonval,buttondelid,buttondelval,diveditid,tt,selectbutton,flag=0,diveditid,sss,flag1=0;
var detailArray=new Array();
var qtnArray= new Array();
var ansArray= new Array();
var deltrackArray= new Array();
var count=0;
var uid=${uid};
console.log(${cat_list});
var cat_json=${cat_list};
var cat_list=new Array();
var currPid=0;
$(document).ready(function(){
    $("#afterPollCreation").hide();
   for(var i=0; i<cat_json.length; i++)
   {
       cat_list.push({id:cat_json[i]['cid'], text:cat_json[i]['category_name']});
       $("#category").append("<option value="+cat_json[i]['cid']+">"+cat_json[i]['category_name']+"</option>");
   }
    $("#category").select2({
       // multiple: true,
  placeholder:"tag poll categories",
  maximumSelectionSize:5,
  
  
  //tags: cat_list//[{id: 0, text: 'story'},{id: 1, text: 'bug'},{id: 2, text: 'task'}]
});
     $("#sd").datetimepicker(
      /*   showMinute: true,
           showSecond: true,
           timeFormat: 'hh:mm:ss',
           dateFormat:"mm/dd/yy" */
                   );
      $("#ed").datetimepicker(
         /*   showMinute: true,
           showSecond: true,
           timeFormat: 'hh:mm:ss',
           dateFormat:"mm/dd/yy" */
                   );
  });

  function addQuestion()
    {//console.log($("#category").val());
        iq++;ie++; console.log("ie value in addqtn");console.log(ie);
         divqid="divq"+iq;
         questions="question"+iq;
         qtypes="Qtype"+iq;
        $("#addQuestion").prop("disabled", true);
        $("#d3").append('<div id="'+divqid+'" class="form-group"></div>');
        $("#"+divqid).append("<p></p><p></p><div class='panel panel-info'>\n\
                                <div class='panel-heading'>\n\
                                        <h3 class='panel-title'>Add Question</h3>\n\
                                </div>\n\
                                <div class='panel-body'>\n\
                                    <div class='form-group'>\n\
                                        <label class='control-label col-sm-2' for='name'>Question:</label>\n\
                                        <div class='col-sm-6'>\n\
                                        <input type='text' class='form-control' name='question' id='"+questions+"' placeholder='Type a Question'>\n\
                                        </div>\n\
                                    </div>\n\
                                    <div class='form-group'>\n\
                                        <label class='control-label col-sm-2' for='name'>Question Type:</label>\n\
                                        <div class='col-sm-6'>\n\
                                        <select id='"+qtypes+"' onchange='selector();' class='form-control' placeholder='Select One'>\n\
                                            <option value='no_questiontype'>Select One</option>\n\
                                            <option value='mcss'>Multiple choice Single select</option>\n\
                                            <option value='mcms'>Multiple choice Multiple select</option>\n\
                                            <option value='tb'>TextBox</option>\n\
                                            <option value='moc'>Matrix of choices</option>\n\
                                            <option value='momc'>Matrix of Multiple choices</option>\n\
                                        </select>\n\
                                        </div>\n\
                                    </div>\n\
                                </div>\n\
                            </div>");
                //append('Question: <input type="text" name="question" id="'+questions+'"/><br/>Question Type: <select id="'+qtypes+'" onchange="selector()"><option value="no_questiontype">Select One</option><option value="mcss">Multiple choice Single select</option><option value="mcms">Multiple choice Multiple select</option><option value="tb">Textbox</option><option value="moc">Matrix of choices</option><option value="momc">Matrix of Multiple choices</option></select>');
    }
    
    function selector()
    {
        if(flag==1)
            editmapper++;
        else
        mapper++;
        createQtn();
        
    }
    function createQtn()
    {
        
         answer="answers"+iq;
         column="columns"+iq;
         row="rows"+iq;
              
           tt="t"+(iq+1);
           ttval=iq+1;
        if(flag==1)
         {
             var qtype=$('#Qtype'+selectbutton).val();
            // var tee="t"+(parseInt(selectbutton)+1);
             var te="t"+(parseInt(selectbutton)+1);
              answer="answers"+selectbutton;
         column="columns"+selectbutton;
         row="rows"+selectbutton;
        
         }
         else
         {    
            var qtype=$('#'+qtypes).val();
         }
         ////alert(qtype);
        //$("#d3").empty();
        
        if(flag==1)
        {
            if(editmapper>=1)
           {      
           switch(qtype)
           {
            case 'mcss':    {$("#t1").remove();$("#"+te).remove();$("#divq"+selectbutton).append('<div id="'+te+'"  class="form-group" > <label class="control-label col-sm-2" for="'+answer+'">Answer choices:</label><div class="col-sm-6"><textarea id="'+answer+'" class="form-control"></textarea></div></div>');$("#submitqtn").prop("disabled",false);}break;
            case 'mcms':    {$("#t1").remove();$("#"+te).remove();$("#divq"+selectbutton).append('<div id="'+te+'" class="form-group" > <label class="control-label col-sm-2" for="'+answer+'">Answer choices:</label><div class="col-sm-6"><textarea id="'+answer+'" class="form-control"></textarea></div></div>');$("#submitqtn").prop("disabled",false);}break;
            case 'tb':      {$("#t1").remove();$("#"+te).remove();$("#divq"+selectbutton).append('<div id="'+te+'" class="form-group" > <label class="control-label col-sm-2" for="'+answer+'">A textbox will be created for the user to fill in the answer</label> <div class="col-sm-6"><input type="hidden" id="'+answer+'"/></div>');$("#submitqtn").prop("disabled",false);}break;
            case 'moc':     {$("#t1").remove();$("#"+te).remove();$("#divq"+selectbutton).append('<div id="'+te+'" class="form-group" > <label class="control-label col-sm-2" for="'+row+'">Enter columns and rows</label> <div class="col-sm-3"><textarea id="'+column+'" class="form-control"></textarea></div><div class="col-sm-3"><textarea id="'+row+'" class="form-control"></textarea></div></div>');$("#submitqtn").prop("disabled",false);}break;
            case 'momc':    {$("#t1").remove();$("#"+te).remove();$("#divq"+selectbutton).append('<div id="'+te+'" class="form-group" > <label class="control-label col-sm-2" for="'+row+'">Enter columns and rows</label> <div class="col-sm-3"><textarea id="'+column+'" class="form-control"></textarea></div><div class="col-sm-3"><textarea id="'+row+'" class="form-control"></textarea></div></div>');$("#submitqtn").prop("disabled",false);}break;
            case 'no_questiontype' :  {$("#t1").remove();$("#"+te).remove();alert("please select a question type");$("#submitqtn").prop("disabled",true);}break;
           }   
           if(qtype!='no_questiontype')
           { 
               
             $("#"+te).append('<button class="btn btn-primary" id="submitqtn" onclick="submitQtn()">Submit Question</button>');  
           }
                
           }
        }
        else
        {     
            if(mapper==1)
          {       
         switch(qtype)
        {
            case 'mcss':    {$("#t1").remove();$("#"+divqid).append('<div id="'+tt+'" class="form-group"><label class="control-label col-sm-2" for="'+answer+'">Answer choices:</label><div class="col-sm-6"><textarea id="'+answer+'"  class="form-control"></textarea></div></div>');$("#submitqtn").prop("disabled",false);}break;
            case 'mcms':    {$("#t1").remove();$("#"+divqid).append('<div id="'+tt+'" class="form-group"><label class="control-label col-sm-2" for="'+answer+'">Answer choices:</label><div class="col-sm-6"><textarea id="'+answer+'"  class="form-control"></textarea></div></div>');$("#submitqtn").prop("disabled",false);}break;
            case 'tb':      {$("#t1").remove();$("#"+divqid).append('<div id="'+tt+'" class="form-group"><label class="control-label col-sm-6" for="'+answer+'">A textbox will be created for the user to fill in the answer </label><input type="hidden" id="'+answer+'"/></div>');$("#submitqtn").prop("disabled",false);}break;
            case 'moc':     {$("#t1").remove();$("#"+divqid).append('<div id="'+tt+'" class="form-group" ><label class="control-label col-sm-2" for="'+row+'">Enter columns and rows </label><div class="col-sm-3"><textarea id="'+column+'"  class="form-control"></textarea></div><div class="col-sm-3"><textarea  class="form-control" id="'+row+'" ></textarea></div></div>');$("#submitqtn").prop("disabled",false);}break;
            case 'momc':    {$("#t1").remove();$("#"+divqid).append('<div id="'+tt+'" class="form-group"><label class="control-label col-sm-2" for="'+row+'">Enter columns and rows </label><div class="col-sm-3"><textarea id="'+column+'" class="form-control"></textarea></div><div class="col-sm-3"><textarea class="form-control" id="'+row+'" ></textarea></div></div>');$("#submitqtn").prop("disabled",false);}break;
             case 'no_questiontype' :  {$("#t1").remove();alert("please select a question type");$("#submitqtn").prop("disabled",true);}break;
         }
         if(qtype!='no_questiontype')
           { 
             
          $("#"+tt).append('<button class="btn btn-primary" id="submitqtn" onclick="submitQtn()">Submit Question</button>');
           } 
                
         }
          else
          {
         
         switch(qtype)
        {
            case 'mcss':    {$("#t1").remove();$("#"+tt).remove();$("#"+divqid).append('<div id="'+tt+'" class="form-group"><label class="control-label col-sm-2" for="'+answer+'">Answer choices:</label><div class="col-sm-6"><textarea id="'+answer+'" class="form-control"></textarea></div></div>');$("#submitqtn").prop("disabled",false);}break;
            case 'mcms':    {$("#t1").remove();$("#"+tt).remove();$("#"+divqid).append('<div id="'+tt+'" class="form-group"><label class="control-label col-sm-2" for="'+answer+'">Answer choices:</label><div class="col-sm-6"><textarea id="'+answer+'" class="form-control"></textarea></div></div>');$("#submitqtn").prop("disabled",false);}break;
            case 'tb':      {$("#t1").remove();$("#"+tt).remove();$("#"+divqid).append('<div id="'+tt+'" class="form-group"><label class="control-label col-sm-6" for="'+answer+'">A textbox will be created for the user to fill in the answer</label> <div class="col-sm-6"><input type="hidden" id="'+answer+'"/></div></div>');$("#submitqtn").prop("disabled",false);}break;
            case 'moc':     {$("#t1").remove();$("#"+tt).remove();$("#"+divqid).append('<div id="'+tt+'" class="form-group"><label class="control-label col-sm-2" for="'+row+'">Enter columns and rows</label><div class="col-sm-3"> <textarea id="'+column+'" class="form-control"></textarea></div><div class="col-sm-3"><textarea id="'+row+'" class="form-control" ></textarea></div></div>');$("#submitqtn").prop("disabled",false);}break;
            case 'momc':    {$("#t1").remove();$("#"+tt).remove();$("#"+divqid).append('<div id="'+tt+'" class="form-group"><label class="control-label col-sm-2" for="'+row+'">Enter columns and rows</label><div class="col-sm-3"> <textarea id="'+column+'" class="form-control"></textarea></div><div class="col-sm-3"><textarea id="'+row+'" class="form-control" ></textarea></div></div>');$("#submitqtn").prop("disabled",false);}break;
             case 'no_questiontype' :  {$("#t1").remove();$("#"+tt).remove();alert("please select a question type");$("#submitqtn").prop("disabled",true);}break;
                
        } 
        if(qtype!='no_questiontype')
           {  
               
           
                $("#"+tt).append('<button class="btn btn-primary" id="submitqtn" onclick="submitQtn()">Submit Question</button>');
           } 
                
                
                
         }
         } 
         // $("#"+qtypes).prop("disabled",true);
         console.log("ttval value: ");console.log(tt);
        
       
    }
    
    function submitQtn()
    {
       
        if(flag===1)
        {
            editmapper=0;
            flag1=1;
            divsqid="divsq"+selectbutton;console.log("divsqid initail wen created with iq ");console.log(divsqid);
        buttonid="buttons"+selectbutton;
        buttonval=selectbutton;
        buttondelid="buttonsdel"+selectbutton;
        buttondelval=selectbutton;    
        }
        else
        {
            mapper=0;
        divsqid="divsq"+iq;console.log("divsqid initail wen created with iq ");console.log(divsqid);
        buttonid="buttons"+iq;
        buttonval=iq;
        buttondelid="buttonsdel"+iq;
        buttondelval=iq;
       }
    console.log("buttonval");
          console.log(buttonval);
          
       // diveditid="diveditid"+iq;
       if(flag===1)
       {
           var question=$("#question"+selectbutton).val();
           var qtype=$("#Qtype"+selectbutton).val();
       }
       else
       {
        var question=$("#"+questions).val();
        var qtype=$("#"+qtypes).val();
       }
            var qtnArray2=new Array();
        //qtnArray[count]=new Array(6);
        if(flag===1)
        {
            qtnArray2[0]=selectbutton;
        }
        else
        {
        qtnArray2[0]=count+1;
        }
        qtnArray2[1]=count+1;
        qtnArray2[2]=qtype;
        qtnArray2[3]=question;
         var qtnTypeforDisplay;
        switch(qtype)
        {
            case 'mcss':{qtnTypeforDisplay='Multiple Choice Single Select';}break;
            case 'mcms':{qtnTypeforDisplay='Multiple Choice Multiple Select';}break;
            case 'tb':{qtnTypeforDisplay='TextBox';}break;
            case 'moc':{qtnTypeforDisplay='Matrix of Choices';}break;
            case 'momc':{qtnTypeforDisplay='Matrix of Multiple Choices';}break;
        }
        $("#d2").append('<div id="'+divsqid+'" ></div>');
        if(qtype==="moc" || qtype==="momc")
        {
           if(flag===1)
           {
              
                    
               var columns=$('#columns'+selectbutton).val();
                var rows=$('#rows'+selectbutton).val();
               
        qtnArray2[4]=JSON.stringify(rows.split("\n"));
        qtnArray2[5]=JSON.stringify(columns.split("\n"));
         columns=columns.replace(/\n/g, "<br>");
        rows=rows.replace(/\n/g, "<br>");
       
        
  
        $("#divsq"+selectbutton).append("<p><p><br></p></p><div class='panel panel-primary'>\n\
                                <div class='panel-heading'>\n\
                                        <h3 class='panel-title'>"+question+"</h3>\n\
                                </div>\n\
                                <div class='panel-body'>\n\
                                    <div class='form-group'>\n\
                                         <label class='control-label col-sm-6' for='name'>Type : <small>"+qtnTypeforDisplay+"</small></label>\n\
                                </div>\n\
                      <div class='form-group'>\n\
                                         <label class='control-label col-sm-6' for='name'>Columns : <small>"+columns+"</small></label>\n\
                                          <label class='control-label col-sm-6' for='name'>Rows : <small>"+rows+"</small></label>\n\
                                    </div>\n\
                                    </div> \n\
                                  </div>\n\
                                    ");
           }
           
            
            else
            {
            
            var columns=$('#'+column).val();
            var rows=$('#'+row).val();
          
        qtnArray2[4]=JSON.stringify(rows.split("\n"));
        qtnArray2[5]=JSON.stringify(columns.split("\n"));
        
        columns=columns.replace(/\n/g, "<br>");
        rows=rows.replace(/\n/g, "<br>");
        $("#"+divsqid).append("<p><p><br></p></p><div class='panel panel-primary'>\n\
                                <div class='panel-heading'>\n\
                                        <h3 class='panel-title'>"+question+"</h3>\n\
                                </div>\n\
                                <div class='panel-body'>\n\
                                    <div class='form-group '>\n\
                                         <label class='control-label col-sm-6' for='name'>Type : <small>"+qtnTypeforDisplay+"</small></label>\n\
                                </div>\n\
                      <div class='form-group'>\n\
                                         <label class='control-label col-sm-6 ' for='name'>Columns : <small>"+columns+"</small></label>\n\
                                          <label class='control-label col-sm-6 ' for='name'>Rows : <small>"+rows+"</small></label>\n\
                                  </div> \n\
                                  </div>\n\
                                  </div>\n\
                                           ");
        
            } 
        }
        else
        {
           if(flag===1)
           {
                   
                var answers=$("#answers"+selectbutton).val();
               
              qtnArray2[4]=JSON.stringify(answers.split("\n"));
               qtnArray2[5]="";
        
                answers=answers.replace(/\n/g, "<br>");
        $("#divsq"+selectbutton).append("<p><p><br></p></p><div class='panel panel-primary'>\n\
                                <div class='panel-heading'>\n\
                                        <h3 class='panel-title'>"+question+"</h3>\n\
                                </div>\n\
                                <div class='panel-body'>\n\
                                    <div class='form-group'>\n\
                                         <label class='control-label col-sm-6' for='name'>Type: <small>"+qtnTypeforDisplay+"</small></label>\n\
                                </div>\n\
                      <div class='form-group'>\n\
                                         <label class='control-label' for='name'>Options : <small>"+answers+"</small></label>\n\
                                  </div> \n\
                                  </div>\n\
                                  </div>\n\
                                     ");
           }
            
            else
            {
              var answers=$("#"+answer).val();
              
                qtnArray2[4]=JSON.stringify(answers.split("\n"));
                 qtnArray2[5]="";
               answers=answers.replace(/\n/g, "<br>");
               $("#"+divsqid).append("<p><p><br></p></p> <div class='panel panel-primary'>\n\
                                <div class='panel-heading'>\n\
                                        <h3 class='panel-title'>"+question+"</h3>\n\
                                </div>\n\
                                <div class='panel-body'>\n\
                                    <div class='form-group'>\n\
                                         <label class='control-label col-sm-6' for='name'>Type: <small>"+qtnTypeforDisplay+"</small></label>\n\
                                    </div>\n\
                                    <div class='form-group'>\n\
                                <label class='control-label' for='name'>Options : <small>"+answers+"</small></label>\n\
                                     </div>\n\
                                  </div>\n\
                                  </div>\n\
                                    ");
        
            }
            
         }
        console.log("qtnArray2=");
        console.log(qtnArray2);
        console.log("answers=");
        console.log(answers);
        
        if(flag===1)
        {
            qtnArray.splice(selectbutton-1,1);
            qtnArray.splice(selectbutton-1,0,qtnArray2);
        }
        else
        {
        qtnArray.push(qtnArray2);
        count++;
        }
    console.log(qtnArray);
        
        if(flag===1)
        {
            //$("#"+sss).
            //$("#"+diveditid);
        $("#divq"+selectbutton).hide();
        }
        else
        {
            $("#"+divqid).hide();
        }
            var json=JSON.stringify(qtnArray);
        console.log(json);
        //count++;
        
        
        $("#addQuestion").prop("disabled", false);
        
        
        if(flag===1)
        {
            //var butn="buttons"+selectbutton;
            $("#divsq"+selectbutton).append('<button id="'+buttonid+'" value="'+buttonval+'" onclick="editQtn(id)"><span class="glyphicon glyphicon-pencil" > EDIT </span></button>&nbsp;&nbsp;');
            $("#divsq"+selectbutton).append('<button id="'+buttondelid+'" value="'+buttondelval+'" onclick="deleteQtn(id)"><span class="glyphicon glyphicon-trash"> DELETE </span></button><p></p>');
            flag=0
           
            for(var i=1;i<=iq;i++)
        {
            if(i!=selectbutton)
            {
                $("#buttons"+i).prop("disabled", false);
            }
        }
        }
        else
        {
        $("#"+divsqid).append('<button id="'+buttonid+'" value="'+buttonval+'" onclick="editQtn(id)"><span class="glyphicon glyphicon-pencil"> EDIT </span></button>&nbsp;&nbsp;');
        $("#"+divsqid).append('<button id="'+buttondelid+'" value="'+buttondelval+'" onclick="deleteQtn(id)"><span class="glyphicon glyphicon-trash"> DELETE </span></button><p></p>');
        flag=0;
        var edit = "divedit"+ie;
         $("#d2").append('<div id="'+edit+'"></div>');
        }
        
        console.log("ie value in submitqtn");console.log(ie);
    }
    
    function editQtn(id)
    {
        flag=1;
      
        console.log("ie value in editqtn");console.log(ie);
        selectbutton=document.getElementById(id).value;
       console.log("value of selected button");
       console.log(selectbutton); 
        diveditid="divedit"+selectbutton;
        sss="divsq"+selectbutton;
      
      $("#"+sss).empty();
        console.log("divsqid"); console.log(sss);
      
        
        console.log(diveditid);
        $("#"+diveditid).append( $("#divq"+selectbutton).show());
      
        console.log("iq =  "+iq)
        for(var i=1;i<=iq;i++)
        {
            if(i!=selectbutton)
            {
                $("#buttons"+i).prop("disabled", true);
            }
        }
    }
    
    function deleteQtn(id)
    {
        var selectbuttondel=document.getElementById(id).value;
        deltrackArray[del]=selectbuttondel-1;
        del++;
        $("#divsq"+selectbuttondel).remove();
         qtnArray.splice(selectbuttondel-1,1);
          qtnArray.splice(selectbuttondel-1,0,"del");
        
        
    }
    function send()
    {   
        deltrackArray=deltrackArray.sort();
        console.log("delTrackArray contains id");console.log(deltrackArray);
        detailArray[0]=uid;
        detailArray[1]=$("#title").val();
        detailArray[2]=$("#desc").val();
        var category_temp=$("#category").val();
        console.log(category_temp);
        detailArray[3]=category_temp[0];
        for(var i=1; i<category_temp.length;i++)
        {
        detailArray[3]=detailArray[3]+","+category_temp[i];    
        }
        //detailArray[3]=$("#category").val();
        
        detailArray[4]=count;
        for(var i=0;i<deltrackArray.length;i++)
        {
            var xdel=deltrackArray[i];
            console.log("xdel");console.log(xdel);
            qtnArray.splice(xdel,1);
            for(var j=i+1;j<deltrackArray.length;j++)
            {
                deltrackArray[j]=deltrackArray[j]-1;
            }
        }
       // qtnArray.splice(xdel-1,1);
        var detailJSON=JSON.stringify(detailArray);
        var qtnJSON=JSON.stringify(qtnArray);
        //var ansJSON=JSON.stringify(ansArray);
        console.log("sending complete Poll");
        console.log(detailJSON);
        console.log(qtnArray);
        var sd=$("#sd").val();
      //  var startdate=new Date(sd).getTime();
        var ed=$("#ed").val();
      //  var enddate=new Date(ed).getTime();
      
        //console.log(ansArray);
        //, std:startdate,etd:enddate
        console.log("alia bhatt details "+detailJSON);
         console.log("alia bhatt qtns "+qtnJSON);
           console.log("alia bhatt start "+sd+" end "+ed+" uid "+uid+" hhahhha ");
        $.ajax({
           type: "POST",       // the dNodeNameefault
           url: "submitPollData",
           data: { detailJSON:detailJSON, qtnJSON:qtnJSON ,start:sd,end:ed,uid:uid },
           success: function(data){
               
               //console.log(currPid);
               if (data =="0")
               {  Alerts("alert-danger",'Sorry your poll was not created');
                   
               }   
               else 
               {    //Alerts("alert-success",'Your Poll has been created Successfully');
                   //window.location.reload();
                   var poll_share = JSON.parse(data);
                   //console.log(poll_share)
                   $("#createPolldiv").hide();
                  $("#afterPollCreation").show();
           $("#share_id").append("<div class='col-md-1 col-md-offset-3'><a  class='btn btn-facebook' href='https://www.facebook.com/sharer/sharer.php?u=http://www.pollican.com/solvePoll"+poll_share[1]+"' target='_blank'><i class='fa fa-facebook'></i> | Share</a></div>");
           $("#share_id").append("<div class='col-md-1'><a class='btn btn-twitter' href='http://twitter.com/share?text=Amazing_Poll_on_Pollican&url=http://www.pollican.com/solvePoll"+poll_share[1]+"&hashtags=pollican' target='_blank'><i class='fa fa-twitter'></i> | tweet</a></div>")
           $("#share_id").append("<div class='col-md-4'><input class='form-control'  name='share_url' value='http://www.pollican.com/solvePoll"+poll_share[1]+"' type='text' size='60' title='Share link' onClick='this.setSelectionRange(0, this.value.length)' autofocus></div>");
       // $("#afterPollCreation").append("<br><a href='https://www.facebook.com/sharer/sharer.php?u=http://www.pollican.com"+poll_share[1]+"' target='_blank'>Share on Facebook</a><br>");
       // $("#afterPollCreation").append("<a href='http://twitter.com/share?text=Amazing_Poll_on_Pollican&url=http://www.pollican.com"+poll_share[1]+"&hashtags=pollican' target='_blank'>Tweet</a><br>");      
        //$("#afterPollCreation").append("<br>Share the Poll Link!!  <input  name='share_url' value='http://www.pollican.com"+poll_share[1]+"' type='text' size='60' title='Share link' onClick='this.setSelectionRange(0, this.value.length)' autofocus>");
    
                }
                    
            }
            
            
            });
    
   
    
    }
  
    
   </script>
            