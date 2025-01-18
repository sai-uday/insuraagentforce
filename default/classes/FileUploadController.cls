public with sharing class FileUploadController {
    @AuraEnabled
    public static String uploadFile(String base64Data, String fileName, String contentType, String caseId) {
        if (String.isBlank(caseId)) {
            throw new AuraHandledException('Case ID is required');
        }

        try {
            // Decode the Base64 string into a Blob
            Blob fileBlob = EncodingUtil.base64Decode(base64Data);

            // Step 1: Save as File (ContentVersion)
            ContentVersion contentVersion = new ContentVersion();
            contentVersion.Title = fileName;
            contentVersion.PathOnClient = fileName;
            contentVersion.VersionData = fileBlob;
            // FileType will be inferred based on the file extension, so no need to set it
            insert contentVersion;

            // Retrieve ContentDocument ID
            String contentDocumentId = [
                SELECT ContentDocumentId
                FROM ContentVersion
                WHERE Id = :contentVersion.Id
                LIMIT 1
            ].ContentDocumentId;

            // Link the file to the Case
            ContentDocumentLink contentDocumentLink = new ContentDocumentLink();
            contentDocumentLink.LinkedEntityId = caseId;
            contentDocumentLink.ContentDocumentId = contentDocumentId;
            contentDocumentLink.ShareType = 'I'; // Inferred permission
            contentDocumentLink.Visibility = 'AllUsers';
            insert contentDocumentLink;

            // Step 2: Save as Attachment
            // Attachment attachment = new Attachment();
            // attachment.ParentId = caseId;
            // attachment.Name = fileName;
            // attachment.Body = fileBlob;
            // attachment.ContentType = contentType;
            // insert attachment;

            return 'File and Attachment successfully linked to Case.';
        } catch (Exception e) {
            throw new AuraHandledException('Error uploading file: ' + e.getMessage());
        }
    }
}
