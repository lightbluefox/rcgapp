import UIKit

class News {
    var id = 0;
    var title = "";
    var announcement = "";
    var fullText = "";
    var fullTextImageURL = "";
    var createdDate = "";
    init (id: Int, title: String, announcement: String, fulltext: String, fullTextImageURL: String, createdDate: String) {
        self.id = id;
        self.title = title;
        self.announcement = announcement;
        self.fullText = fulltext;
        self.fullTextImageURL = fullTextImageURL;
        self.createdDate = createdDate;
    }
}

class Vacancy: News {
    //var announceImage = UIImage(named: "FullTextImage")!;
    var announceImageURL = "";
    var rate = "";
    //TODO: Сделать пол через Enum
    var gender = 2; //0 - мужчины, 1 - женщины, 2 - мужчины и женщины
    var city = "";
    var schedule = "";
    var validTillDate = "";
    
    init (id: Int, title: String, announcement: String, announceImageURL: String, fulltext: String, fullTextImageURL: String, createdDate: String, rate: String, gender: Int, city: String, schedule: String, validTillDate: String) {
        super.init(id: id, title: title, announcement: announcement, fulltext: fulltext, fullTextImageURL: fullTextImageURL, createdDate: createdDate);
        self.id = id;
        self.title = title;
        self.announcement = announcement;
        self.announceImageURL = announceImageURL;
        self.fullText = fulltext;
        self.fullTextImageURL = fullTextImageURL;
        self.createdDate = createdDate;
        self.rate = rate;
        self.gender = gender;
        self.city = city;
        self.schedule = schedule;
        self.validTillDate = validTillDate;
    }
}

@available(iOS 8.0, *)
class NewsAndVacanciesReceiver {
    //класс-получатель новостей и вакансий
    var newsStack = [News]();
    var vacStack = [Vacancy]();
    
    func getAllNews(completionHandlerNews: (success: Bool, result: String) -> Void) {
        newsStack.removeAll(keepCapacity: false);
        
        let request = HTTPTask()
        request.GET("http://agency.cloudapp.net/news", parameters: nil, completionHandler: {(response: HTTPResponse) in
            if let err = response.error {
                        dispatch_async(dispatch_get_main_queue()) {
                            completionHandlerNews(success: false, result: err.localizedDescription)
                        }
                return
            }
            else if let data = response.responseObject as? NSData {
                let requestedData = NSString(data: data, encoding: NSUTF8StringEncoding)
                let requestedDataUnwrapped = requestedData!;
                let jsonString = requestedDataUnwrapped;
                let jsonData = jsonString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
                let jsonObject: AnyObject! = try? NSJSONSerialization.JSONObjectWithData(jsonData!, options: NSJSONReadingOptions(rawValue: 0))
    
                let json = JSON(jsonObject);
                for var i = 0; i < json.count; i++ {
    
    
                    let id = json[i]["id"] != nil ? json[i]["id"].int! : 0;
                    let title =  json[i]["title"] != nil ? json[i]["title"].string! : "";
                    let announcement = json[i]["shortText"] != nil ? json[i]["shortText"].string! : "";
                    let fulltext = json[i]["text"] != nil ? json[i]["text"].string! : "";
               //
                    let fullTextImageURL = json[i]["picture"] != nil ? json[i]["picture"].string! : "";
                //
                    let createdDate = json[i]["dateCreated"] != nil ? json[i]["dateCreated"].string!.formatedDate : "";
                    
                    self.newsStack.append(News(id: id, title: title, announcement: announcement, fulltext: fulltext, fullTextImageURL: fullTextImageURL, createdDate: createdDate));
                }
                
                dispatch_async(dispatch_get_main_queue()) {
                    completionHandlerNews(success: true, result: "Новости загружены")
                }

            }
        })
    }
    func getAllVacancies(completionHandlerVacancy: (success: Bool, result: String) -> Void) {
        vacStack.removeAll(keepCapacity: false);
        
        let request = HTTPTask()
        request.GET("http://agency.cloudapp.net/vacancy", parameters: nil, completionHandler: {(response: HTTPResponse) in
            if let err = response.error {
                dispatch_async(dispatch_get_main_queue()) {
                    completionHandlerVacancy(success: true, result: err.localizedDescription)
                }
                return //also notify app of failure as needed
            }
            else if let data = response.responseObject as? NSData {
                let requestedData = NSString(data: data, encoding: NSUTF8StringEncoding)
                let requestedDataUnwrapped = requestedData!;
                let jsonString = requestedDataUnwrapped;
                let jsonData = jsonString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
                let jsonObject: AnyObject! = try? NSJSONSerialization.JSONObjectWithData(jsonData!, options: NSJSONReadingOptions(rawValue: 0))
                
                let json = JSON(jsonObject);
                for var i = 0; i < json.count; i++ {
                    
                    //Получаем все поля, проверяем на наличие значения
                    
                    let id = json[i]["id"] != nil ? json[i]["id"].int : 0;
                    let title = json[i]["title"] != nil ? json[i]["title"].string! : "";
                    let announcement = json[i]["shortText"] != nil ? json[i]["shortText"].string! : "";
                    let fulltext = json[i]["text"] != nil ? json[i]["text"].string! : "";
                    let announceImageURL = json[i]["previewPicture"] != nil ? json[i]["previewPicture"].string! : "";
                    let fullTextImageURL = json[i]["picture"] != nil ? json[i]["picture"].string! : "";
                    var gender = 0
                    let createdDate = json[i]["dateCreated"] != nil ? json[i]["dateCreated"].string!.formatedDate : "";
                    var rate = "";
                    var schedule = "";
                    var city = "";
                    var validTillDate = "";
                    _ = json[i]["Vacancy"];
                    if json[i]["Vacancy"] != nil {
                        gender = json[i]["Vacancy"]["isMale"].int!;
                        rate = json[i]["Vacancy"]["money"] != nil ? json[i]["Vacancy"]["money"].string! : "";
                        schedule = json[i]["Vacancy"]["workTime"] != nil ? json[i]["Vacancy"]["workTime"].string! : "";
                        city = json[i]["Vacancy"]["city"] != nil ? json[i]["Vacancy"]["city"].string! : "";
                        validTillDate = json[i]["Vacancy"]["endTime"] != nil ? json[i]["Vacancy"]["endTime"].string!.formatedDate : "";
                    }
                    
                    self.vacStack.append(Vacancy(id: id!, title: title, announcement: announcement, announceImageURL: announceImageURL, fulltext: fulltext, fullTextImageURL: fullTextImageURL, createdDate: createdDate, rate: rate, gender: gender, city: city, schedule: schedule, validTillDate: validTillDate));
                }
                dispatch_async(dispatch_get_main_queue()) {
                    completionHandlerVacancy(success: true, result: "Вакансии загружены")
                }
            }
        })
        
    }
        
        
        
//        vacStack.append(Vacancy(id: 1, title: "Модель", announcement: "ВРЕМЕННАЯ РАБОТА С 23 ПО 26 АПРЕЛЯ", announceImage: UIImage(named: "FullTextImage")!, fulltext: "На железном троне сейчас бастард Ланнистеров, так же свои права на трон предъявляет младший брат Роберта - Ренли и Роб Старк. Огненным жрицам нужно будет сжигать пиявок и таким образом, при помощи огненной магии, убить всех троих.", fulltextImage: UIImage(named: "FullTextImage")!, createdDate: "15.05.2015", rate: "400р/час", gender: 0, city: "Москва", schedule: "Ежедневно с 01 до 03 часов ночи", validTillDate: "20.06.2015"));
//        vacStack.append(Vacancy(id: 2, title: "Наказание узурпатора", announcement: "Ищем огненных жрецов в помощь нашему королю", announceImage: UIImage(named: "VacancyImg")!, fulltext: "На железном троне сейчас бастард Ланнистеров, так же свои права на трон предъявляет младший брат Роберта - Ренли и Роб Старк. Огненным жрицам нужно будет сжигать пиявок и таким образом, при помощи огненной магии, убить всех троих.", fulltextImage: UIImage(named: "FullTextImage")!, createdDate: "11.05.2015", rate: "5000USD", gender: 2, city: "Москва", schedule: "Ежедневно с 01 до 03 часов ночи", validTillDate: "20.08.2015"));
//        vacStack.append(Vacancy(id: 3, title: "Наказание узурпатора", announcement: "Ищем огненных жрецов в помощь нашему королю", announceImage: UIImage(named: "VacancyImg")!, fulltext: "На железном троне сейчас бастард Ланнистеров, так же свои права на трон предъявляет младший брат Роберта - Ренли и Роб Старк. Огненным жрицам нужно будет сжигать пиявок и таким образом, при помощи огненной магии, убить всех троих.", fulltextImage: UIImage(named: "FullTextImage")!, createdDate: "10.05.2015", rate: "400р/час", gender: 1, city: "Москва", schedule: "Ежедневно с 01 до 03 часов ночи", validTillDate: "20.07.2015"));
//        vacStack.append(Vacancy(id: 4, title: "Наказание узурпатора", announcement: "Ищем огненных жрецов в помощь нашему королю", announceImage: UIImage(named: "VacancyImg")!, fulltext: "На железном троне сейчас бастард Ланнистеров, так же свои права на трон предъявляет младший брат Роберта - Ренли и Роб Старк. Огненным жрицам нужно будет сжигать пиявок и таким образом, при помощи огненной магии, убить всех троих.", fulltextImage: UIImage(named: "FullTextImage")!, createdDate: "10.05.2015", rate: "400р/час", gender: 1, city: "Москва", schedule: "Ежедневно с 01 до 03 часов ночи", validTillDate: "20.07.2015"));
//        vacStack.append(Vacancy(id: 5, title: "Наказание узурпатора", announcement: "Ищем огненных жрецов в помощь нашему королю", announceImage: UIImage(named: "VacancyImg")!, fulltext: "На железном троне сейчас бастард Ланнистеров, так же свои права на трон предъявляет младший брат Роберта - Ренли и Роб Старк. Огненным жрицам нужно будет сжигать пиявок и таким образом, при помощи огненной магии, убить всех троих.", fulltextImage: UIImage(named: "FullTextImage")!, createdDate: "10.05.2015", rate: "400р/час", gender: 2, city: "Москва", schedule: "Ежедневно с 01 до 03 часов ночи", validTillDate: "20.07.2015"));
    }