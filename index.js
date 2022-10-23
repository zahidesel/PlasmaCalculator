
///calculator///
const convertBtn=document.getElementById("convertBtn")

let densityEl=document.getElementById("eDensity")
let temperatureEl=document.getElementById("tElec")
let bFieldEl=document.getElementById("bField")
let vBulkEl=document.getElementById("vBulk")

const magneticConstant=1.25663706e-6
const electronMass= 9.10938215e-31
const elementaryCharge=1.60217649e-19
const boltzmannConstant=1.38065042e-23
const vacuumPermit=8.85418782e-12


///gets input values
let alfven=document.getElementById("i1")
let debye=document.getElementById("i2")
let gyroRadius=document.getElementById("i3")
let plasmaFreq=document.getElementById("i4")
let angularFreq=document.getElementById("i5")
let gyrotime=document.getElementById("i6")
let thermalVelo=document.getElementById("i7")

///shows the calculations
convertBtn.addEventListener("click", function(){

     let density=densityEl.value
     let temperature=temperatureEl.value
     let bField=bFieldEl.value
     let vBulk=vBulkEl.value

     

 alfven.value=(bField/(Math.sqrt(magneticConstant*density*electronMass))).toExponential(4)

 debye.value=(Math.sqrt((vacuumPermit*boltzmannConstant*temperature)/(density*(elementaryCharge**2)))).toExponential(4)
 gyroRadius.value=((electronMass*vBulk)/(elementaryCharge*bField)).toExponential(4)
 plasmaFreq.value=(Math.sqrt((density*(elementaryCharge**2))/(vacuumPermit*electronMass))).toExponential(4)
 angularFreq.value=((elementaryCharge*bField)/electronMass).toExponential(4)
 gyrotime.value=((2*Math.PI)/((elementaryCharge*bField)/electronMass)).toExponential(4)
 thermalVelo.value=(Math.sqrt((2*boltzmannConstant*temperature)/(electronMass))).toExponential(4)

 })

 //end of calculation


 // this function hides all the planet input divs but only shows selected one.

 
 function enableBrand(selectedOption){
    if(selectedOption.value==1){
        document.getElementById("earthDiv").classList.remove('noneEarth')
        document.getElementById("marsDiv").classList.add('noneMars')
        document.getElementById("jupiterDiv").classList.add('noneJupiter')
        document.getElementById("saturnDiv").classList.add('noneSaturn')
        document.getElementById("uranusDiv").classList.add('noneUranus')
        document.getElementById("neptuneDiv").classList.add('noneNeptune')        
    }
    else if(selectedOption.value==2){
        document.getElementById("marsDiv").classList.remove('noneMars')
        document.getElementById("earthDiv").classList.add('noneEarth')
        document.getElementById("jupiterDiv").classList.add('noneJupiter')
        document.getElementById("saturnDiv").classList.add('noneSaturn')
        document.getElementById("uranusDiv").classList.add('noneUranus')
        document.getElementById("neptuneDiv").classList.add('noneNeptune')
    }
    else if(selectedOption.value==3){
        document.getElementById("jupiterDiv").classList.remove('noneJupiter')
        document.getElementById("earthDiv").classList.add('noneEarth')
        document.getElementById("marsDiv").classList.add('noneMars')
        document.getElementById("saturnDiv").classList.add('noneSaturn')
        document.getElementById("uranusDiv").classList.add('noneUranus')
        document.getElementById("neptuneDiv").classList.add('noneNeptune')
    }
    else if(selectedOption.value==4){
      document.getElementById("saturnDiv").classList.remove('noneSaturn')
      document.getElementById("earthDiv").classList.add('noneEarth')
      document.getElementById("marsDiv").classList.add('noneMars')
      document.getElementById("jupiterDiv").classList.add('noneJupiter')
      document.getElementById("uranusDiv").classList.add('noneUranus')
      document.getElementById("neptuneDiv").classList.add('noneNeptune')
    }
    else if(selectedOption.value==5){
        document.getElementById("uranusDiv").classList.remove('noneUranus')
        document.getElementById("earthDiv").classList.add('noneEarth')
        document.getElementById("marsDiv").classList.add('noneMars')
        document.getElementById("jupiterDiv").classList.add('noneJupiter')
        document.getElementById("saturnDiv").classList.add('noneSaturn')
        document.getElementById("neptuneDiv").classList.add('noneNeptune')
      }
    else {
        document.getElementById("neptuneDiv").classList.remove('noneNeptune')
        document.getElementById("earthDiv").classList.add('noneEarth')
        document.getElementById("marsDiv").classList.add('noneMars')
        document.getElementById("jupiterDiv").classList.add('noneJupiter')
        document.getElementById("saturnDiv").classList.add('noneSaturn')
        document.getElementById("uranusDiv").classList.add('noneUranus')
    }

 }