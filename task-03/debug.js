/**
 * Pga feil i oppgaveteksten måtte jeg lage en js implementasjon for å debugge... løsningen er også etter siste tick+=1, så 1169
 */

var rice = 100; var peas = 100; var carrots = 100; reindeer = 100; pretzel = 100;
var tick = 0;
var riceRefill = [0,0,1,0,0,2]; var peasRefill = [0,3,0,0]; var carrotsRefill = [0,1,0,0,0,8]; reindeerRefill = [100,80,40,20,10];
var reindeerCooldown = 0;
var reindeerRefillIndex = 0;

function refillReindeer() {
    if (reindeer > 0) return 0;
    if (reindeerCooldown == 50) {
        if (reindeerRefillIndex > 4) return 0;
        reindeerCooldown = 0;
        let amount = reindeerRefill[reindeerRefillIndex];
        reindeerRefillIndex += 1;
        console.log (" REFILLING REINDEER ---- "+amount);
        return amount;
    }
    reindeerCooldown += 1;
    return 0;
}

while (true) {
    // let riceTake = rice > 4 ? 5 : rice > 2 ? 3 : 0;
    // let peasTake = (riceTake > 4 && peas > 2) ? 3 : (riceTake < 4 && peas > 4) ? 5 : 0;
    // let carrotsTake = (riceTake > 0 && peasTake > 0) ? 0 : (((riceTake > 4 && peasTake == 0) || (riceTake == 0 && peasTake > 4)) && carrots > 2) ? 3 : carrots > 4 ? 5 : carrots > 2 ? 3 : 0;
    // let reindeerTake = (riceTake == 0 && peasTake == 0 && carrotsTake == 0) && reindeer > 0 ? 2 : 0;
    // let pretzelTake = (riceTake == 0 && peasTake == 0 && carrotsTake == 0 && reindeerTake == 0) ? 1 : 0;

    let riceTake = rice > 0 ? 5 : 0;
    let peasTake = peas > 0 ? (riceTake > 0 ? 3 : 5) : 0;
    let carrotsTake = carrots > 0 ? (riceTake > 0 && peasTake > 0 ? 0 : (((riceTake > 0 && peasTake == 0) || (riceTake == 0 && peasTake > 0)) ? 3 : 5)) : 0;
    let reindeerTake = (riceTake == 0 && peasTake == 0 && carrotsTake == 0) && reindeer > 0 ? 2 : 0;
    let pretzelTake = (riceTake == 0 && peasTake == 0 && carrotsTake == 0 && reindeerTake == 0) ? 1 : 0;

    rice = Math.max(0, rice - riceTake);
    peas = Math.max(0, peas - peasTake);
    carrots = Math.max(0, carrots - carrotsTake);
    reindeer = Math.max(0, reindeer - reindeerTake);
    pretzel -= pretzelTake;

    rice += riceRefill[(tick) % 6];
    peas += peasRefill[(tick) % 4];
    carrots += tick > 30 ? carrotsRefill[(tick - 30) % 6] : 0;
    reindeer += refillReindeer();

    console.log("Tick "+tick+": TAKE "+riceTake+" rice, "+peasTake+" peas, "+carrotsTake+" carrots, "+reindeerTake+" reindeer, "+pretzelTake+" pretzels. STOCK: "+rice+" rice, "+peas+" peas, "+carrots+" carrots, "+reindeer+" reindeer, "+pretzel+" pretzel.");
    tick += 1;
    if (pretzel == 0) break;
}