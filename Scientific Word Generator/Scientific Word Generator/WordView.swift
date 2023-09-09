//
//  WordView.swift
//  Scientific Word Generator
//
//  Created by Arnella Tolegen on 24.03.2022.
//

import SwiftUI
import Foundation

struct WordView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var words: FetchedResults<Words>
    var word: Words?
    @State var wordName = ""
    @State var wordForDelete = Words()
    
    @State var showingPopup1 = false
    
    let setWords: [String] = ["atom",  "electron", "ion", "molecule", "neutron", "nucleus", "proton", "acid", "reaction", "balance", "acceptor", "base", "catalyst", "chemical equation", "crystal", "diffusion", "electrolysis", "electrolyte", "entropy", "enzyme", "equilibrium", "kelvin", "kinetic energy", "mole", "nucleon", "period", "pressure", "salt", "solute", "sublimation", "vaporization", "polyatomi", "oxidation", "orbital", "nucleon", "isotope", "insoluble", "hydration", "heat", "covalent bond", "circuit", "cathode", "aqueous", "anode", "alloy", "lithium", "barium", "beryllium", "calcium", "magnesium", "lead", "tin", "enzyme", "base ", "alkaline", "isomer", "allotropy", "vanadium", "sulfur", "cesium", "addition reaction", "aldehyde", "alkali metal", "alkane", "alkene", "allotrope", "chemical property", "covalent bond", "critical mass", "delocalization", "dilution", "excess reagent", "lattice energy", "volatile", "molarity", "gamma ray", "amine", "absorption", "anabolism", "antibiotic", "antigen", "bile", "biomass", "biome", "biosynthesis", "botany", "catabolism", "catalyst", "cellulose", "cerebrum", "chlorophyll", "chloroplast", "chromosome", "circulatory system", "cohesion", "cytoplasm", "digestion", "ecology", "ecosystem", "ectoplasm", "ectothermic", "endothermic ", "epidermis", "epithelium", "excretion", "fermentation", "gene", "genetics", "genotype", "hibernation", "homeostasis", "hydrolysis", "hydrophobic", "inheritance", "isotonic solution", "loam", "lysosome", "macroevolution", "meiosis ", "membrane", "metabolism", "mitosis", "molt", "mutualism", "mutation", "nervous system", "neurotoxin", "nucleus", "osmosis", "parasite", "pathogen", "pedigree", "phagocytosis", "phenotype", "photosynthesis", "plankton", "pollen", "pollination", "population", "regeneration", "reproduction", "respiration", "secretion", "seed", "species", "spore", "symbiosis", "vaccine", "virus", "zygote", "abdomen", "abiogenesis", "bilateral symmetry", "cerebellum", "chitin", "commensalism", "conjugation", "cytology", "cytolysis", "deciduous plant", "endoplasm", "endospore", "endoskeleton", "gestation", "haustorium", "karyotype", "medulla oblongata", "mesenchyme", "mycelium", "notochord", "gravity", "friction", "electromagnetism", "inertia", "centrifugal force", "centripetal force", "magnitude", "vector", "static friction", "force", "acceleration", "constant acceleration", "constant speed", "negative velocity", "scalar", "velocity", "relative motion", "weightlessness", "mass", "universal gravity", "energy", "kinetic energy", "potential energy", "external force", "internal force", "momentum", "collision", "elastic collision", "inelastic collision", "elasticity", "angular velocity", "lever arm", "precession", "torque", "chemical energy", "fictitious force", "distance", "accelerometer", "ampere", "amplifier", "anion", "antimatter", "cathode ray", "conductor", "decibel", "density", "doppler effect", "electromotive force", "fission", "fluorescence", "fusion", "gamma ray", "generator", "impetus", "momentum", "neutrino", "radioactivity", "surface tension", "viscosity", "x-ray", "inclined plane", "projectile", "uniform circular motion", "alternating current", "brownian motion", "capacitance", "farad", "hyperon", "database", "hardware", "install", "access", "browse", "back up", "bug", "folder", "hardware", "software", "application", "domain", "download", "emulation", "encryption", "hyperlink"]
    
    let setTranscriptions: [String] = ["/ˈæt.əm/", "/iˈlek.trɒn/", "/ˈaɪ.ɒn/", "/ˈmɒl.ɪ.kjuːl/", "/ˈnjuː.trɒn/",  "/ˈnjuː.kli.əs/", "/ˈprəʊ.tɒn/", "/ˈæs.ɪd/", "/riˈæk.ʃən/", "/ˈbæl.əns/", "/əkˈsep.tə/", "/beɪs/", "/ˈkæt.əl.ɪst/", "/'kem.ɪ.kəl ɪˈkweɪ.ʒən/", "/ˈkrɪs.təl/", "/dɪˈfjuː.ʒən/", "/iˌlekˈtrɒl.ə.sɪs/", "/iˈlek.trə.laɪt/", "/ˈen.trə.pi/", "/ˈen.zaɪm/", "/ˌek.wɪˈlɪb.ri.əm/", "/ˈkel.vɪn/", "/kɪˌnet.ɪk ˈen.ə.dʒi/", "/məʊl/", "/ˈnjuː.kli.ɒn/", "/ˈpɪə.ri.əd/", "/ˈpreʃ.ər/", "/sɒlt/", "/ˈsɒl.juːt/", "/sʌb.lɪˈmeɪ.ʃən/", "/veɪ.pər.aɪˈzeɪ.ʃən/", "/pɒl.i.əˈtɒm.ɪk/", "/ˌɑːk.səˈdeɪ.ʃən/", "/ˈɔː.bɪ.təl/", "/ˈnjuː.kli.ɒn/",  "/ˈaɪ.sə.təʊp/", "/ɪnˈsɒl.jə.bəl/", "/haɪˈdreɪ.ʃən/", "/hiːt/", "/kəʊˌveɪ.lənt ˈbɒnd/", "/ˈsɜː.kɪt/", "/ˈkæθ.əʊd/", "/ˈeɪ.kwi.əs/", "/ˈæn.əʊd/", "/ˈæl.ɔɪ/", "/ˈlɪθ.i.əm/", "/ˈbeə.ri.əm/", "/bəˈrɪl.i.əm/", "/ˈkæl.si.əm/", "/mæɡˈniː.zi.əm/", "/liːd/", "/tɪn/", "/ˈen.zaɪm/", "/beɪs/", "/ˈæl.kəl.aɪn/", "/ˈaɪ.sə.mər/", "/əˈlɒt.rə.piː/", "/vəˈneɪ.di.əm/", "/ˈsʌl.fər/", "/ˈsiːzɪəm/", "/əˈdɪʃn rɪˈækʃn/", "/ˈældɪhaɪd/", "/ˈælkəlaɪ metlz/", "/ˈalˌkān/", "/ˈalˌkēn/", "/ˈaləˌtrōp/", "/ˈkemək(ə)l ˈpräpərdē/", "/ˌkōˈvālənt bänd/", "/ˈˌkridəkəl ˈmas/", "/diːləʊkəlaɪˈzeɪʃən/", "/dīˈlo͞oSHn/", "/ikˈses rēˈājənt/", "/ˈladəs ˈenərjē/", "/ˈvälədl/", "/məʊˈlærɪtɪ/", "/ˈgæmə reɪ/", "/ˈæmiːn/", "/əbˈzɔːp.ʃən/", "/uh-nab-uh-liz-uhm/", "/æn.ti.baɪˈɒt.ɪk/", "/ˈæn.tɪ.dʒən/", "/baɪl/", "/ˈbaɪ.əʊˌmæs/", "/ˈbaɪ.əʊm/", "/baɪ.əʊˈsɪn.θə.sɪs/", "/ˈbɒt.ən.i/", "/kəˈtæbəlɪzəm/", "/ˈkæt.əl.ɪst/", "/ˈsel.jə.ləʊs/", "/səˈriː.brəm/", "/ˈklɒr.ə.fɪl/", "/ˈklɒr.ə.plɑːst/", "/ˈkrəʊ.mə.səʊm/", "/ˌsɜː(r)kjʊˈleɪt(ə)ri  ˈsɪs.təm/", "/kəʊˈhiː.ʒən/", "/ˈsaɪ.tə.plæz.əm/", "/daɪˈdʒes.tʃən/", "/iˈkɒl.ə.dʒi/", "/ˈiː.kəʊˌsɪs.təm/", "/ˈek.tə.plæz.əm/", "/ˈektəʊθɜː(r)mik/", "/ˌen.dəʊˈθɜː.mɪk/", "/ˌep.ɪˈdɜː.mɪs/", "/ˌep.ɪˈθiː.li.əm/", "/ɪkˈskriː.ʃən/", "/fɜː.menˈteɪ.ʃən/", "/dʒiːn/", "/dʒəˈnet.ɪks/", "/ˈdʒen.ə.taɪp/", "/haɪ.bəˈneɪ.ʃən/", "/həʊ.mi.əʊˈsteɪ.sɪs/", "/haɪˈdrɒl.ə.sɪs/", "/ˌhaɪdrəʊˈfəʊbɪk/", "/ɪnˈher.ɪ.təns/", "/aɪ.səˈtɒn.ɪk səˈluː.ʃən/", "/ləʊm/", "/lai·suh·sowm/", "/ˈmakrōˌe​vəˈlüshən/", "/maɪˈəʊ.sɪs/", "/ˈmem.breɪn/", "/məˈtæb.əl.ɪ.zəm/", "/maɪˈtəʊ.sɪs/", "/məʊlt/", "/ˈmjuː.tʃu.əlɪ.zəm/", "mjuːˈteɪʃn", "/ˈnɜːvəs ˈsɪstɪm/", "/njʊəˈrɒtɒksɪn/", "/ˈnjuːklɪəs/", "/ɒzˈməʊsɪs/", "/ˈpærəsaɪt/", "/ˈpæθəʤən/", "/ˈpedɪgriː/", "/ˈfægəsaɪtəʊsɪs/", "/ˈfiːnəʊtaɪp/", "/fəʊtəʊˈsɪnθɪsɪs/", "/ˈplæŋktən/", "/ˈpɒlən/", "/pɒlɪˈneɪʃn/", "/pɒpjʊˈleɪʃn/", "/rɪʤenəˈreɪʃn/", "/riːprəˈdʌkʃn/", "/respɪˈreɪʃn/", "/sɪˈkriːʃn/", "/siːd/", "/ˈspiːʃiːz/", "/spɔː/", "/sɪmbɪˈəʊsɪs/", "/ˈvæksiːn/", "/ˈvaɪərəs/", "/ˈzaɪgəʊt/", "/ˈæbdəmən/", "/eɪbaɪə(ʊ)ˈʤenəsɪs/", "/baɪˈlætərəl ˈsɪmɪtrɪ/", "/serɪˈbeləm/", "/ˈkaɪtɪn/", "/kəˈmens(ə)lɪz(ə)m/", "/kɒnʤʊˈgeɪʃn/", "/saɪˈtɒləʤɪ/", "/saɪˈtɒlɪsɪs/", "/dɪˈsɪdjʊəs plɑːnts/", "/ˈɪntəplæzm/", "/ˈendəˌspôr/", "/ˌendōˈskelətn/", "/jeˈstāSH(ə)n/", "/hôˈstôrēəm/", "/ˈkerēōˌtīp/", "/məˌdələ äˌblôNGˈɡädə/", "/ˈmezənˌkīm/", "/mīˈsēlēəm/", "/ˈnōdəˌkôrd/", "/ˈɡravədē/", "/ˈfrikSH(ə)n/", "/əˌlektrōˈmaɡnəˌtizəm/", "/iˈnərSHə/", "/senˈtrif(y)əɡəl fôrs/", "/senˈtripədl fôrs/", "/ˈmaɡnəˌt(y)o͞od/", "/ˈvektər/", "/ˈstætɪk ˈfrɪkʃən /", "/fɔrs /", "/ˌækˌsɛləˈreɪʃən/", "/ˈkɑnstənt ˌækˌsɛləˈreɪʃən /", "/ˈkɑnstənt spid/", "/ˈnɛgətɪv vəˈlɑsəti/", "/ˈskeɪlər/", "/vəˈlɑsəti/", "/ˈrɛlətɪv ˈmoʊʃən/", "/ˈweɪtləsnəs/", "/mæs/", "/ˌjunəˈvɜrsəl ˈgrævəti/", "/ˈɛnərʤi/", "/kəˈnɛtɪk ˈɛnərʤi/", "/pəˈtɛnʃəl ˈɛnərʤi/", "/ɪkˈstɜrnəl fɔrs/", "/ɪnˈtɜrnəl fɔrs/", "/moʊˈmɛntəm/", "/kəˈlɪʒən/", "/ɪˈlæstɪk kəˈlɪʒən/", "/ˌɪnəˈlæstɪk kəˈlɪʒən/", "/ˌiˌlæˈstɪsəti/", "/ˈæŋgjələr vəˈlɑsəti/", "/ˈlɛvər ɑrm/", "/priˈsɛʃən/", "/tɔrk/", "/ˈkɛməkəl ˈɛnərʤi/", "/fɪkˈtɪʃəs fɔrs/", "/ˈdɪstəns/", "/ækˌsɛləˈrɑmətər/", "/ˈæmpeə/", "/ˈæmplɪfaɪə/", "/ˈanˌīən/", "/ˈan(t)ēˌmadər/", "/ˈkaˌTHōd ˌrā/", "/kənˈdəktər/", "/ˈdesəˌbel/", "/ˈdensədē/", "/ˈdɑplər ɪˈfɛkt/", "/ɪˈlɛktrəʊməʊtɪv fɔːs/", "/ˈfɪʃən/", "/flʊəˈrɛsns/", "/ˈfjuːʒən/", "/ˈgæmə reɪ/", "/ˈʤɛnəreɪtə/", "/ˈɪmpɪtəs/", "/məʊˈmentəm/", "/nju(ː)ˈtriːnəʊ/", "/ˌreɪdɪəʊækˈtɪvɪti/", "/ˈsɜːfɪs ˈtɛnʃən/", "/vɪsˈkɒsɪti/", "/ˈɛksˈreɪ/", "/ɪnˈklaɪnd pleɪn/", "/ˈprɒʤɪktaɪl/", "/ˈjuːnɪfɔːm ˈsɜːkjʊlə ˈməʊʃən/", "/ˈɔːltəneɪtɪŋ ˈkʌrənt/", "/ˈbraʊnɪən ˈməʊʃən/", "/kəˈpæsɪtəns/", "/ˈfærəd/", "/ˈhīpəˌrän/", "/ˈdeɪtəˌbeɪs/", "/ˈhɑrˌdwɛr/", "/ɪnˈstɔl/", "/ˈækˌsɛs/", "/braʊz/", "/bæk ʌp/", "/bʌg/", "/ˈfoʊldər/", "/ˈhɑrˌdwɛr/", "/ˈsɔfˌtwɛr/", "/ˌæpləˈkeɪʃən/", "/doʊˈmeɪn/", "/ˈdaʊnˌloʊd/", "/ˌɛmjəˈleɪʃən/", "/ɛnˈkrɪpʃən/", "/ˈhaɪpərlɪŋk/"]
    
    let setCategory: [String] = ["chemistry", "chemistry", "chemistry", "chemistry", "chemistry", "chemistry", "chemistry", "chemistry", "chemistry", "chemistry", "chemistry", "chemistry", "chemistry", "chemistry", "chemistry", "chemistry", "chemistry", "chemistry", "chemistry", "chemistry", "chemistry", "chemistry", "chemistry", "chemistry", "chemistry", "chemistry", "chemistry", "chemistry", "chemistry", "chemistry", "chemistry", "chemistry", "chemistry", "chemistry", "chemistry", "chemistry", "chemistry", "chemistry", "chemistry", "chemistry", "chemistry", "chemistry", "chemistry", "chemistry", "chemistry", "chemistry", "chemistry", "chemistry", "chemistry", "chemistry", "chemistry", "chemistry", "chemistry", "chemistry", "chemistry", "chemistry", "chemistry", "chemistry", "chemistry", "chemistry", "chemistry", "chemistry", "chemistry", "chemistry", "chemistry", "chemistry", "chemistry", "chemistry", "chemistry", "chemistry", "chemistry", "chemistry", "chemistry", "chemistry", "chemistry", "chemistry", "chemistry", "biology", "biology", "biology", "biology", "biology", "biology", "biology", "biology", "biology", "biology", "biology", "biology", "biology", "biology", "biology", "biology", "biology", "biology", "biology", "biology", "biology", "biology", "biology", "biology", "biology", "biology", "biology", "biology", "biology", "biology", "biology", "biology", "biology", "biology", "biology", "biology", "biology", "biology", "biology", "biology", "biology", "biology", "biology", "biology", "biology", "biology", "biology", "biology", "biology", "biology", "biology", "biology", "biology", "biology", "biology", "biology", "biology", "biology", "biology", "biology", "biology", "biology", "biology", "biology", "biology", "biology", "biology", "biology", "biology", "biology", "biology", "biology", "biology", "biology", "biology", "biology", "biology", "biology", "biology", "biology", "biology", "biology", "biology", "biology", "biology", "biology", "biology", "biology", "biology", "biology", "biology", "biology", "biology", "physics", "physics", "physics", "physics", "physics", "physics", "physics", "physics", "physics", "physics", "physics", "physics", "physics", "physics", "physics", "physics", "physics", "physics", "physics", "physics", "physics", "physics", "physics", "physics", "physics", "physics", "physics", "physics", "physics", "physics", "physics", "physics", "physics", "physics", "physics", "physics", "physics", "physics", "physics", "physics", "physics", "physics", "physics", "physics", "physics", "physics", "physics", "physics", "physics", "physics", "physics", "physics", "physics", "physics", "physics", "physics", "physics", "physics", "physics", "physics", "physics", "physics", "physics", "physics", "physics", "physics", "physics", "physics", "informatics", "informatics", "informatics", "informatics", "informatics", "informatics", "informatics", "informatics", "informatics", "informatics", "informatics", "informatics", "informatics", "informatics", "informatics", "informatics"]
    
    func GetSetWord(){
        print(Words(context: moc).accessibilityElementCount())
        if Words(context: moc).accessibilityElementCount() == 0 {
            for i in 0...setWords.count-1 {
                let word = Words(context: moc)
                word.word = setWords[i]
                word.category = setCategory[i]
                word.transcription = setTranscriptions[i]
                print(i)
                try? moc.save()
            }
        }
    }
    
    
    func categoryWords(category: String)->[String]{
        var wordsMass: [String] = []
        for w in words{
            if(w.category == category){
                wordsMass.append("\(w.word ?? "no word") \(w.transcription ?? "no transcription")")
            }
        }
        return wordsMass
    }
    
    
    @State private var confirmationShown = false
    @State private var confirmationShownAll = false
    
    var body: some View {
        let physicsWords: [String] = self.categoryWords(category: "physics")
        let chemistryWords: [String] = self.categoryWords(category: "chemistry")
        let biologyWords: [String] = self.categoryWords(category: "biology")
        let computerScienceWords: [String] = self.categoryWords(category: "informatics")
        let yourSubjectWords: [String] = self.categoryWords(category: "your subject")
        
        VStack{
            List(){
                Section(header: Text("Physics words")){
                    ForEach(physicsWords, id: \.self){ word in HStack{
                        Text("\(word)")
                    }
                    }
                }
                Section(header: Text("Chemistry words")){
                    ForEach(chemistryWords, id: \.self){ word in HStack{
                        Text("\(word)")
                    }
                    }
                }
                Section(header: Text("Biology words")){
                    ForEach(biologyWords, id: \.self){ word in HStack{
                        Text("\(word)")
                    }
                    }
                }
                Section(header: Text("Informatics words")){
                    ForEach(computerScienceWords, id: \.self){ word in HStack{
                        Text("\(word)")
                    }
                    }
                }
                Section(header: Text("Your Subject words")){
                    ForEach(yourSubjectWords, id: \.self){ word in HStack{
                        Text("\(word)")
                    }
                    }
                }
            }.listStyle(.sidebar)
            
            TextField("Word",text: $wordName)
            
            Button(role: .destructive,
                   action: { confirmationShown = true }){
                Text("Delete word")
            }.foregroundColor(.red)
                .confirmationDialog("Are you sure?", isPresented: $confirmationShown) {
                    Button("Delete") {
                        withAnimation {
                            for word1 in words {
                                if(wordName == word1.word){
                                    wordForDelete = word1
                                }
                            }
                            moc.delete(wordForDelete)
                            try? moc.save()
                        }
                    }
                }
            
            Spacer().frame(width: 10, height: 40)
            
            Button(role: .destructive,
                   action: { confirmationShownAll = true }){
                Text("Delete all words")
            }.foregroundColor(.red)
                .confirmationDialog("Are you sure?", isPresented: $confirmationShownAll) {
                    Button("Delete") {
                        withAnimation {
                            showingPopup1 = true
                            for word1 in words {
                                wordForDelete = word1
                                moc.delete(wordForDelete)
                                try? moc.save()
                            }
                        }
                    }
                }
            
            Spacer().frame(width: 10, height: 40)
            
            Button("Load standard set of words"){
                for i in 0...setWords.count-1 {
                    let word = Words(context: moc)
                    word.word = setWords[i]
                    word.category = setCategory[i]
                    word.transcription = setTranscriptions[i]
                    try? moc.save()
                }
            }
            
            Spacer().frame(width: 10, height: 40)
            
            NavigationLink(destination: AddWord(), label: {Text("Add word")})
        }
    }
}
