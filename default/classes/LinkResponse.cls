public class LinkResponse {
 
    @InvocableMethod
    public static List<Response> getPrompt(List<Request> requests) {
        Request input = requests[0];
        List<Response> responses = new List<Response>();
        Response output = new Response();
        responses.add(output);
        if(input.type=='docs'){
            output.Prompt = 'https://ac1729747848962.my.site.com/tesca121/File?Id=' + input.id;
        }
        if(input.type=='payment'){
             output.Prompt = 'https://ac1729747848962.my.site.com/tesca121/paymentpage';
        }
        return responses;
            
      
    }
 
    // Type and API Name of all variables must match the template
    public class Request {
        @InvocableVariable(required=true)
        public String type;
        @InvocableVariable
        public String id;
    }

    public class Response {
        @InvocableVariable
        public String Prompt;
    }
}   