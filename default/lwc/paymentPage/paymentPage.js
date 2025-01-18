import { LightningElement } from 'lwc';

export default class paymentPage extends LightningElement {
    handlePayment(event) {
        event.preventDefault();
        const fields = Array.from(this.template.querySelectorAll('lightning-input')).reduce((form, input) => {
            form[input.name] = input.value;
            return form;
        }, {});
        
        console.log('Payment details:', fields);
        if (this.validateFields(fields)) {
            alert('Payment processed successfully!');
        } else {
            alert('Please fill in all the fields correctly.');
        }
    }

    validateFields(fields) {
        return fields.cardNumber && fields.expiryDate && fields.cvv && fields.amount;
    }
}
