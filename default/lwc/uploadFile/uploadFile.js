import { LightningElement } from 'lwc';
import uploadFileToApex from '@salesforce/apex/FileUploadController.uploadFile';

export default class UploadFile extends LightningElement {
    fileData;
    pdfContent = '';
    Id;
    connectedCallback(){
        const currentPageUrl = window.location.href;
        const params = new URLSearchParams(window.location.search);
        this.Id = params.get("Id");
        console.log("Id",this.Id);
        console.log("currentPageUrl",currentPageUrl);
    }
    handleFileChange(event) {
        const filea = event.target.files[0];
        const reader = new FileReader();
        

        reader.onload = () => {
            const base64 = reader.result.split(',')[1]; 
            this.fileData = {
                filename: filea.name,
                base64: base64,
                type: filea.type
            };
        };

        reader.readAsDataURL(filea); // Convert the file to base64 format
    }

    uploadFile() {
        if (this.fileData) {
            uploadFileToApex({ 
                base64Data: this.fileData.base64, 
                fileName: this.fileData.filename, 
                contentType: this.fileData.type,
                caseId: this.Id // You can change or pass dynamically
            })
            .then(result => {
                console.log('File uploaded successfully', result);
            })
            .catch(error => {
                console.error('Error uploading file', error);
            });
        }
    }
}
