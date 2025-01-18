import { LightningElement, track } from 'lwc';
import storeData from '@salesforce/apex/StoreQuizData.storeData';

export default class AddOption extends LightningElement {
    @track master = [];
    masterLength=this.master.length;
    createScreen=true;
    SucessScreen=false;
    addQuestion() {
        const questionIndex = this.master.length;
        this.master.push({
            questionNumber: `Question ${questionIndex + 1}`,
            questionDetails: "",
            correctAnswerIndex:null,
            options: [{ name: `Option 1`, value: "", index: 1 }]
        });
        this.masterLength=this.master.length;
       // console.log(this.masterLength);
    }
    deleteQuestion(event){
        console.log("hi")
        const questionIndex = event.target.dataset.questionIndex;
        //const optionIndex = event.target.dataset.optionIndex;
        this.master.splice(questionIndex, 1);
        console.log(this.master);
        
        this.master = this.master.map((data, index) => ({
            ...data,
            questionNumber: `Question ${index + 1}`,
        }));
        
    }
    

    addOption(event) {
        const questionIndex = event.target.dataset.questionIndex;
        const question = this.master[questionIndex];
        const optionIndex = question.options.length;
        const temp =  optionIndex + 1
        question.options.push({
            name: `Option ${temp}`,
            value: "",
            index: temp
        });
        console.log(JSON.stringify(question));
        
    }

    chooseOption(event){
        const questionIndex = event.target.dataset.questionIndex;
        const optionIndex = event.target.dataset.optionIndex;
        this.master[questionIndex].correctAnswerIndex=optionIndex;
    }
   
    updateOptionValues(event) {
        const questionIndex = event.target.dataset.questionIndex;
        const optionIndex = event.target.dataset.optionIndex;
        this.master[questionIndex].options[optionIndex].value = event.target.value;
    }

    
    updateQuestionDetails(event) {
        const questionIndex = event.target.dataset.questionIndex;
        this.master[questionIndex].questionDetails = event.target.value;
    }


    deleteOption(event) {
        const questionIndex = event.target.dataset.questionIndex;
        const optionIndex = event.target.dataset.optionIndex;
        this.master[questionIndex].options.splice(optionIndex, 1);

        
        this.master[questionIndex].options = this.master[questionIndex].options.map((data, index) => ({
            ...data,
            name: `Option ${index + 1}`,
            index
        }));
    }
    submitQuiz(){
        console.log("hi",JSON.stringify(this.master))
        storeData({inputData:JSON.stringify(this.master)}).then(result => {
            console.log(result);
            this.SucessScreen=true;
            this.createScreen=false;
        }).catch(error => {
            console.log(error);
        })
    }
}
