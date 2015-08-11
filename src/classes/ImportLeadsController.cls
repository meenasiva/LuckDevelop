public class ImportLeadsController {
public Blob csvFileBody{get;set;}
public string csvAsString{get;set;}
public String[] csvFileLines{get;set;}
public List<Lead> leadlist{get;set;}
  public ImportLeadsController(){
    csvFileLines = new String[]{};
    leadlist = New List<Lead>(); 
  }
  
  public void importCSVFile(){
       try{
           csvAsString = csvFileBody.toString();
           csvFileLines = csvAsString.split('\n'); 
            
           for(Integer i=1;i<csvFileLines.size();i++){
               Lead leadObj = new Lead() ;
               string[] csvRecordData = csvFileLines[i].split(',');
               leadObj.FirstName = csvRecordData[0] ;             
               leadObj.LastName = csvRecordData[1];
               leadObj.Street = csvRecordData[2];
               leadObj.City = csvRecordData[3];   
               leadObj.State = csvRecordData[4];  
               leadObj.PostalCode = csvRecordData[5];
               leadObj.Company = csvRecordData[6];
               leadlist.add(leadObj);   
           }
        insert leadlist;
        }
        catch (Exception e)
        {
            ApexPages.addMessages(e); 
            Messaging.SingleEmailMessage mail=new Messaging.SingleEmailMessage();
            String[] toAddresses = new String[] {'meenasiva6@gmail.com'};
            mail.setToAddresses(toAddresses);

           mail.setReplyTo('meenasiva6@gmail.com');
           mail.setSenderDisplayName('Apex error message');
          // mail.setSubject('Error from Org : ' + UserInfo.getOrganizationName());

           mail.setPlainTextBody(e.getMessage());

            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });

            //ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.ERROR,'An error has occured while importin data Please make sure input csv file is correct');
            //ApexPages.addMessage(errorMessage);
        }  
  }
}