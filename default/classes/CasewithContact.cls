public class CasewithContact {
 
    @InvocableMethod
    public static List<Response> getPrompt(List<Request> requests) {
        Request input = requests[0];
        List<Response> responses = new List<Response>();
        Response output = new Response();
        responses.add(output);
        Case temp = new Case();
        temp.ContactId = input.id;
        temp.Origin = 'Community Agent AI';
        insert temp;
        output.Prompt =  temp.Id;

        return responses;
    }
 
    // Type and API Name of all variables must match the template
    public class Request {
        @InvocableVariable(required=true)
        public String id;
    }

    public class Response {
        @InvocableVariable
        public String Prompt;
    }
}   