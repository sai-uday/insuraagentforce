import { LightningElement } from 'lwc';
import CheckQuizID from '@salesforce/apex/FetechQuizData.CheckQuizID';
export default class TestScreen extends LightningElement {
    entryScreen=true;
    quizScreen=false;
    resultScreen=false;
    quizdata;
    totalQuestions;
    correctAnswers={};
    userAnswers={};
    tempscore;
    CheckQuiz(){
        console.log("hello");
        let quizid=this.template.querySelector('lightning-input[data-id="checkinput"]').value;
        console.log(quizid);
        CheckQuizID({input:quizid}).then((data)=>{
            console.log(data);
            if(data.length>0){
            this.totalQuestions=data.length;
            this.correctObject(data);
            this.entryScreen=false;
            this.quizScreen=true;
            this.quizdata=data;
            }
        }).catch((error)=>{
            console.log(error);
            alert("Invalid Quiz ID");
        })
        console.log("hihi");
    }
    correctObject(data){
        for(let i=0;i<data.length;i++){
            this.correctAnswers[i]=data[i].Correct_Answer_Index__c;
        }
        console.log(JSON.stringify(this.correctAnswers));
    }
    checkOptions(event){
        console.log("hii");
        const questionIndex = event.target.dataset.queindex;
        const optionIndex = event.target.dataset.optindex;
        this.userAnswers[questionIndex]=optionIndex;
        console.log(JSON.stringify(this.userAnswers));
        
    }
    checkScore(){
        console.log("hiiiid")
        this.tempscore=0;
        let temp=0;
        for(let i=0;i<this.totalQuestions;i++){
            if(this.correctAnswers[i]==this.userAnswers[i]){
                temp+=1;
            }
             console.log(temp);
        }
        this.tempscore=temp;
        console.log("hiiiidddd");
        console.log("score is"+temp+" out of"+this.totalQuestions);
        this.quizScreen=false;
        this.resultScreen=true;

    }
    get progressRing(){
        return this.tempscore/this.totalQuestions*100;
    }
}