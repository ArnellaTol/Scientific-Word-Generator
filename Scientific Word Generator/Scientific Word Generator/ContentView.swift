//
//  ContentView.swift
//  Scientific Word Generator
//
//  Created by Arnella Tolegen on 21.03.2022.
//

import SwiftUI

struct ContentView: View {
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
        if words.isEmpty {
            for i in 0...setWords.count-1 {
                let word = Words(context: moc)
                word.word = setWords[i]
                word.category = setCategory[i]
                word.transcription = setTranscriptions[i]
                try? moc.save()
            }
        }
    }
    
    @State var num: Int? = 0
    
    var body: some View {
        ResponsiveView { prop in
            NavigationView{
                VStack{
                    Text("Scientific Word Generator").font(.system(size:42)).padding(EdgeInsets(top: -10, leading: 0, bottom: 0, trailing: 0))
                    Text("Categories").font(.system(size:35)).padding()
                    Group{
                        NavigationLink(destination: PhysicsWordGeneration(), tag: 1, selection: $num) {
                            EmptyView()
                        }
                        NavigationLink(destination: ChemistryWordGeneration(), tag: 2, selection: $num) {
                            EmptyView()
                        }
                        NavigationLink(destination: BiologyWordGeneration(), tag: 3, selection: $num) {
                            EmptyView()
                        }
                        NavigationLink(destination: ComputerScienceWordGeneration(), tag: 4, selection: $num) {
                            EmptyView()
                        }
                        NavigationLink(destination: YourSubjectWordGeneration(), tag: 7, selection: $num) {
                            EmptyView()
                        }
                        NavigationLink(destination: RandomWordGeneration(), tag: 8, selection: $num) {
                            EmptyView()
                        }
                        NavigationLink(destination: IdeaList(), tag: 5, selection: $num) {
                            EmptyView()
                        }
                        NavigationLink(destination: WordView(), tag: 6, selection: $num) {
                            EmptyView()
                        }
                    }
                    
                    Group{
                        Button(action: {
                            self.num = 1
                            GetSetWord()
                        }){
                            ZStack{
                                RoundedRectangle(cornerRadius: 20).frame(width: 200, height: 50).foregroundColor(Color.indigo)
                                Text("Physics").foregroundColor(Color.white).font(.title3).bold()
                            }
                        }.padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
                        
                        Button(action: {
                            self.num = 2
                            GetSetWord()
                        }){
                            ZStack{
                                RoundedRectangle(cornerRadius: 20).frame(width: 200, height: 50).foregroundColor(Color.indigo)
                                Text("Chemistry").foregroundColor(Color.white).font(.title3).bold()
                            }
                        }
                        
                        Button(action: {
                            self.num = 3
                            GetSetWord()
                        }){
                            ZStack{
                                RoundedRectangle(cornerRadius: 20).frame(width: 200, height: 50).foregroundColor(Color.indigo)
                                Text("Biology").foregroundColor(Color.white).font(.title3).bold()
                            }
                        }
                        
                        Button(action: {
                            self.num = 4
                            GetSetWord()
                        }){
                            ZStack{
                                RoundedRectangle(cornerRadius: 20).frame(width: 200, height: 50).foregroundColor(Color.indigo)
                                Text("Informatics").foregroundColor(Color.white).font(.title3).bold()
                            }
                        }
                        
                        Button(action: {
                            self.num = 7
                            GetSetWord()
                        }){
                            ZStack{
                                RoundedRectangle(cornerRadius: 20).frame(width: 200, height: 50).foregroundColor(Color.indigo)
                                Text("Your Subject").foregroundColor(Color.white).font(.title3).bold()
                            }
                        }
                        
                        Button(action: {
                            self.num = 8
                            GetSetWord()
                        }){
                            ZStack{
                                RoundedRectangle(cornerRadius: 20).frame(width: 200, height: 50).foregroundColor(Color.indigo)
                                Text("Random").foregroundColor(Color.white).font(.title3).bold()
                            }
                        }
                        Button(action: {
                            self.num = 5
                        }){
                            ZStack{
                                RoundedRectangle(cornerRadius: 20).frame(width: 300, height: 60).foregroundColor(Color.mint)
                                Text("How can you use the app?").foregroundColor(Color.white).font(.title2).bold()
                            }
                        }.padding(EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0))
                        
                        Button(action: {
                            self.num = 6
                        }){
                            ZStack{
                                RoundedRectangle(cornerRadius: 20).frame(width: 200, height: 50).foregroundColor(Color.purple)
                                Text("View words").foregroundColor(Color.white).font(.title3).bold()
                            }
                        }
                    }
                }
            }
            .navigationViewStyle(.stack)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portrait)
    }
}
