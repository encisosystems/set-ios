import SwiftUI

struct About: View {
    let coordinadorDetails: [(name: String, role: String)] = [
        ("Cristian Infante", "Administrador de la aplicación con acceso privilegiado y control total sobre todas las funcionalidades."),
    ]
    
    let peopleDetails: [(name: String, role: String)] = [
        ("Andrés Muñoz", "Menú lateral con ventana de créditos en sección Acerca de."),
        ("Laura Yañez", "Botón de compartir."),
    ]
    
    let directorDetails: [(name: String, role: String)] = [
        ("Javier Enciso", "Encargado de la toma de decisiones estratégicas."),
    ]
    
    var body: some View {
        NavigationView{
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    SectionTitle(text: "Desarrollado por")
                    HStack{
                        Image("logotipo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 400, height: 100)
                            .padding(.top, 10)
                    }
                    .frame(maxWidth: .infinity)
                    SectionTitle(text: "Coordinador de Desarrollo")
                    ForEach(coordinadorDetails, id: \.name) { person in
                        Person(name: person.name, role: person.role)
                    }
                    SectionTitle(text: "Desarrolladores")
                    ForEach(peopleDetails, id: \.name) { person in
                        Person(name: person.name, role: person.role)
                    }
                    SectionTitle(text: "Director del Proyecto")
                    ForEach(directorDetails, id: \.name) { person in
                        Person(name: person.name, role: person.role)
                    }
                }
                .padding(.horizontal, 14)
            }
            .navigationTitle("Acerca de")
        }
    }
}

struct SectionTitle: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.title)
            .fontWeight(.bold)
            .foregroundColor(Color(red:0, green: 0, blue: 0.5))
            .padding(.top, 18)
            .padding(.leading, 14)
    }
}

struct Person: View {
    var name: String
    var role: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(name)
                .font(.body)
                .padding(.top, 15)
                .padding(.leading, 15)
            DescriptionText(text: role)
        }
    }
}

struct DescriptionText: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.footnote)
            .foregroundColor(.gray)
            .padding(.top, 0)
            .padding(.leading, 15)
            .padding(.trailing, 15)
    }
}


struct About_Previews:PreviewProvider{
    static var previews:some View{
        About()
    }
}
