import UIKit

class News {
    var id = 0;
    var title = "";
    var announcement = "";
    var fullText = "";
    var fullTextImage = UIImage(named: "FullTextImage")!;
    var createdDate = "";
    
    init (id: Int, title: String, announcement: String, fulltext: String, fulltextImage: UIImage, createdDate: String) {
        self.id = id;
        self.title = title;
        self.announcement = announcement;
        self.fullText = fulltext;
        self.fullTextImage = fulltextImage;
        self.createdDate = createdDate;
    }
}

class Vacancy: News {
    var announceImage = UIImage(named: "FullTextImage")!;
    var rate = "";
    var gender = 2; //0 - мужчины, 1 - женщины, 2 - мужчины и женщины
    var city = "";
    var schedule = "";
    var validTillDate = "";
    
    init (id: Int, title: String, announcement: String, announceImage: UIImage, fulltext: String, fulltextImage: UIImage, createdDate: String, rate: String, gender: Int, city: String, schedule: String, validTillDate: String) {
        super.init(id: id, title: title, announcement: announcement, fulltext: fulltext, fulltextImage: fulltextImage, createdDate: createdDate);
        self.id = id;
        self.title = title;
        self.announcement = announcement;
        self.announceImage = announceImage;
        self.fullText = fulltext;
        self.fullTextImage = fulltextImage;
        self.createdDate = createdDate;
        self.rate = rate;
        self.gender = gender;
        self.city = city;
        self.schedule = schedule;
        self.validTillDate = validTillDate;
    }
}

class NewsAndVacanciesReceiver {
    //класс-получатель новостей и вакансий
    var newsStack = [News]();
    var vacStack = [Vacancy]();
    
    func getAllNews() {
        newsStack.removeAll(keepCapacity: false);
        let url = NSURL(string: "http://agency.cloudapp.net/news");
        let request = NSURLRequest(URL: url!);
        //var response = NSURLResponse?();
        var response = AutoreleasingUnsafeMutablePointer<NSURLResponse?>()
        var error = NSErrorPointer();
        var data = NSURLConnection.sendSynchronousRequest(request, returningResponse: response, error: error);
        if (data != nil)
        {
            let requestedData = NSString(data: data!, encoding: NSUTF8StringEncoding)
            let requestedDataUnwrapped = requestedData!;
            let jsonString = requestedDataUnwrapped;
            let jsonData = jsonString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
            let jsonObject: AnyObject! = NSJSONSerialization.JSONObjectWithData(jsonData!, options: NSJSONReadingOptions(0), error: nil)
            
            let json = JSON(jsonObject);
            for var i = 0; i < json.count; i++ {
                
                //меняем формат даты
                
                var id = json[i]["id"] != nil ? json[i]["id"].int! : 0;
                var title =  json[i]["title"] != nil ? json[i]["title"].string! : "";
                var announcement = json[i]["shortText"] != nil ? json[i]["shortText"].string! : "";
                var fulltext = json[i]["text"] != nil ? json[i]["text"].string! : "";
           //
                var fulltextImage = UIImage(named: "FullTextImage")!;
            //
                var createdDate = json[i]["dateCreated"] != nil ? json[i]["dateCreated"].string!.formatedDate : "";
                
                newsStack.append(News(id: id, title: title, announcement: announcement, fulltext: fulltext, fulltextImage: fulltextImage, createdDate: createdDate));
            }
        }
        
        
        newsStack.append(News(id: 55, title: "Узурпатор наказан", announcement: "Сегодня был наказан узурпатор Ренли Баратеон", fulltext: "Ренли Баратеон, претендовавший на трон после загадочной смерти его брата Роберта Баратеона, был убит своим личным гвардейцем Радужных Плащей, неказистой женщиной, Бриеной Тарт. Сама Бриена причастность к смерти наследника престола отрицает, и утверждает, что Ренли убила тень с лицом старшего брата Роберта - Станниса Баратеона.", fulltextImage: UIImage(named: "FullTextImage")!, createdDate: "20.07.2015"));
        newsStack.append(News(id: 56,title: "Узурпатор будет наказан через две недели после полуночи", announcement: "Через две недели после полуночи будет наказан узурпатор Ренли Баратеон, его сразит Тень с лицом Станниса Баратеона", fulltext: "Ренли Баратеон, претендовавший на трон после загадочной смерти его брата Роберта Баратеона, был убит своим личным гвардейцем Радужных Плащей, неказистой женщиной, Бриеной Тарт. Сама Бриена причастность к смерти наследника престола отрицает, и утверждает, что Ренли убила тень с лицом старшего брата Роберта - Станниса Баратеона.", fulltextImage: UIImage(named: "FullTextImage")!, createdDate: "21.07.2015"));
        newsStack.append(News(id: 57, title: "Кастинг и сразу тренинг 22 апреля", announcement: "Самый известный алкогольный бренд! Дегустация новых коктейлей! Длительный годовой проект", fulltext: "Равным образом постоянное пропогандисткое-информационное обеспечение нашей деятельности требует определения и уточнения системы чего-то там.", fulltextImage: UIImage(named: "FullTextImage")!, createdDate: "22.07.2015"));
        newsStack.append(News(id: 58, title: "Узурпатор наказан", announcement: "Сегодня был наказан узурпатор Ренли Баратеон", fulltext: "Ренли Баратеон, претендовавший на трон после загадочной смерти его брата Роберта Баратеона, был убит своим личным гвардейцем Радужных Плащей, неказистой женщиной, Бриеной Тарт. Сама Бриена причастность к смерти наследника престола отрицает, и утверждает, что Ренли убила тень с лицом старшего брата Роберта - Станниса Баратеона.", fulltextImage: UIImage(named: "FullTextImage")!, createdDate: "23.07.2015"));
        newsStack.append(News(id: 59, title: "Узурпатор наказан", announcement: "Сегодня был наказан узурпатор Ренли Баратеон", fulltext: "Ренли Баратеон, претендовавший на трон после загадочной смерти его брата Роберта Баратеона, был убит своим личным гвардейцем Радужных Плащей, неказистой женщиной, Бриеной Тарт. Сама Бриена причастность к смерти наследника престола отрицает, и утверждает, что Ренли убила тень с лицом старшего брата Роберта - Станниса Баратеона.", fulltextImage: UIImage(named: "FullTextImage")!, createdDate: "23.07.2015"));
        newsStack.append(News(id: 60, title: "Узурпатор наказан", announcement: "Сегодня был наказан узурпатор Ренли Баратеон", fulltext: "Ренли Баратеон, претендовавший на трон после загадочной смерти его брата Роберта Баратеона, был убит своим личным гвардейцем Радужных Плащей, неказистой женщиной, Бриеной Тарт. Сама Бриена причастность к смерти наследника престола отрицает, и утверждает, что Ренли убила тень с лицом старшего брата Роберта - Станниса Баратеона.", fulltextImage: UIImage(named: "FullTextImage")!, createdDate: "23.07.2015"));
    }
    func getAllVacancies() {
        vacStack.removeAll(keepCapacity: false);
        let url = NSURL(string: "http://agency.cloudapp.net/vacancy");
        let request = NSURLRequest(URL: url!);
        //var response = NSURLResponse?();
        var response = AutoreleasingUnsafeMutablePointer<NSURLResponse?>()
        var error = NSErrorPointer();
        var data = NSURLConnection.sendSynchronousRequest(request, returningResponse: response, error: error);
        if (data != nil)
        {
            let requestedData = NSString(data: data!, encoding: NSUTF8StringEncoding)
            let requestedDataUnwrapped = requestedData!;
            let jsonString = requestedDataUnwrapped;
            let jsonData = jsonString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
            let jsonObject: AnyObject! = NSJSONSerialization.JSONObjectWithData(jsonData!, options: NSJSONReadingOptions(0), error: nil)
            
            let json = JSON(jsonObject);
            for var i = 0; i < json.count; i++ {
                
                //Получаем все поля, проверяем на наличие значения
                
                var id = json[i]["id"] != nil ? json[i]["id"].int? : 0;
                var title = json[i]["title"] != nil ? json[i]["title"].string! : "";
                var announcement = json[i]["shortText"] != nil ? json[i]["shortText"].string! : "";
                var fulltext = json[i]["text"] != nil ? json[i]["text"].string! : "";
// Заполнить нормальными значениями, когда смогу
                var announceImage = UIImage(named: "FullTextImage")!;
                var fulltextImage = UIImage(named: "FullTextImage")!;
                var gender = 1
//
                var createdDate = json[i]["dateCreated"] != nil ? json[i]["dateCreated"].string!.formatedDate : "";
                var rate = "";
                var schedule = "";
                var city = "";
                var validTillDate = "";
                var vac = json[i]["Vacancy"];
                if json[i]["Vacancy"] != nil {
                    rate = json[i]["Vacancy"]["money"] != nil ? json[i]["Vacancy"]["money"].string! : "";
                    schedule = json[i]["Vacancy"]["workTime"] != nil ? json[i]["Vacancy"]["workTime"].string! : "";
                    city = json[i]["Vacancy"]["city"] != nil ? json[i]["Vacancy"]["city"].string! : "";
                    validTillDate = json[i]["Vacancy"]["endTime"] != nil ? json[i]["Vacancy"]["endTime"].string!.formatedDate : "";
                }
                
                vacStack.append(Vacancy(id: id!, title: title, announcement: announcement, announceImage: announceImage, fulltext: fulltext, fulltextImage: fulltextImage, createdDate: createdDate, rate: rate, gender: gender, city: city, schedule: schedule, validTillDate: validTillDate));
            }
        }
        
        
        
        vacStack.append(Vacancy(id: 1, title: "Модель", announcement: "ВРЕМЕННАЯ РАБОТА С 23 ПО 26 АПРЕЛЯ", announceImage: UIImage(named: "FullTextImage")!, fulltext: "На железном троне сейчас бастард Ланнистеров, так же свои права на трон предъявляет младший брат Роберта - Ренли и Роб Старк. Огненным жрицам нужно будет сжигать пиявок и таким образом, при помощи огненной магии, убить всех троих.", fulltextImage: UIImage(named: "FullTextImage")!, createdDate: "15.05.2015", rate: "400р/час", gender: 0, city: "Москва", schedule: "Ежедневно с 01 до 03 часов ночи", validTillDate: "20.06.2015"));
        vacStack.append(Vacancy(id: 2, title: "Наказание узурпатора", announcement: "Ищем огненных жрецов в помощь нашему королю", announceImage: UIImage(named: "VacancyImg")!, fulltext: "На железном троне сейчас бастард Ланнистеров, так же свои права на трон предъявляет младший брат Роберта - Ренли и Роб Старк. Огненным жрицам нужно будет сжигать пиявок и таким образом, при помощи огненной магии, убить всех троих.", fulltextImage: UIImage(named: "FullTextImage")!, createdDate: "11.05.2015", rate: "5000USD", gender: 2, city: "Москва", schedule: "Ежедневно с 01 до 03 часов ночи", validTillDate: "20.08.2015"));
        vacStack.append(Vacancy(id: 3, title: "Наказание узурпатора", announcement: "Ищем огненных жрецов в помощь нашему королю", announceImage: UIImage(named: "VacancyImg")!, fulltext: "На железном троне сейчас бастард Ланнистеров, так же свои права на трон предъявляет младший брат Роберта - Ренли и Роб Старк. Огненным жрицам нужно будет сжигать пиявок и таким образом, при помощи огненной магии, убить всех троих.", fulltextImage: UIImage(named: "FullTextImage")!, createdDate: "10.05.2015", rate: "400р/час", gender: 1, city: "Москва", schedule: "Ежедневно с 01 до 03 часов ночи", validTillDate: "20.07.2015"));
        vacStack.append(Vacancy(id: 4, title: "Наказание узурпатора", announcement: "Ищем огненных жрецов в помощь нашему королю", announceImage: UIImage(named: "VacancyImg")!, fulltext: "На железном троне сейчас бастард Ланнистеров, так же свои права на трон предъявляет младший брат Роберта - Ренли и Роб Старк. Огненным жрицам нужно будет сжигать пиявок и таким образом, при помощи огненной магии, убить всех троих.", fulltextImage: UIImage(named: "FullTextImage")!, createdDate: "10.05.2015", rate: "400р/час", gender: 1, city: "Москва", schedule: "Ежедневно с 01 до 03 часов ночи", validTillDate: "20.07.2015"));
        vacStack.append(Vacancy(id: 5, title: "Наказание узурпатора", announcement: "Ищем огненных жрецов в помощь нашему королю", announceImage: UIImage(named: "VacancyImg")!, fulltext: "На железном троне сейчас бастард Ланнистеров, так же свои права на трон предъявляет младший брат Роберта - Ренли и Роб Старк. Огненным жрицам нужно будет сжигать пиявок и таким образом, при помощи огненной магии, убить всех троих.", fulltextImage: UIImage(named: "FullTextImage")!, createdDate: "10.05.2015", rate: "400р/час", gender: 2, city: "Москва", schedule: "Ежедневно с 01 до 03 часов ночи", validTillDate: "20.07.2015"));
    }
    
}