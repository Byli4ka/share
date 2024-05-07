﻿
&НаСервере
Функция ТаблицаРасписаниеНомерЗаказаПриИзмененииНаСервере(Ссылка)
	Запрос = Новый Запрос;
	
	Запрос.Текст = "ВЫБРАТЬ
		|	Заказы.Адрес КАК Адрес
		|ИЗ
		|	Документ.Заказы КАК Заказы
		|ГДЕ
		|	Заказы.Ссылка = &Ссылка";

	Запрос.УстановитьПараметр("Ссылка", Ссылка);
 
	РезультатЗапроса = Запрос.Выполнить().Выгрузить();
    Альфа = РезультатЗапроса.Получить(0).Адрес;
	Возврат Альфа;
	КонецФункции

&НаКлиенте
Процедура ТаблицаРасписаниеНомерЗаказаПриИзменении(Элемент)
	ТекущиеДанные = Элементы.ТаблицаРасписание.ТекущиеДанные;
	
	Бета = ТаблицаРасписаниеНомерЗаказаПриИзмененииНаСервере(ТекущиеДанные.НомерЗаказа);
	 ТекущиеДанные.Адрес = Бета;
	 
КонецПроцедуры

&НаКлиенте
Процедура ТаблицаРасписаниеВремяПринятияЗаказаПриИзменении(Элемент)
	ТекущиеДанные = Элементы.ТаблицаРасписание.ТекущиеДанные;
	ТекущиеДанные.Конец =ТекущиеДанные.Начало + (3600 * ТекущиеДанные.ВремяДоставки);
	//////////ТекущиеДанные.ВремяДоставки =  ТекущиеДанные.Конец - ТекущиеДанные.Начало ;
	ПроверкаКурьера();
	ПроверкаНаЗаказа()
	
	
КонецПроцедуры 
 &НаКлиенте
Процедура ПроверкаКурьера()
ТекущиеДанные = Элементы.ТаблицаРасписание.ТекущиеДанные;	
	Для каждого строка из объект.ТаблицаРасписание цикл
		
		Если не Строка.НомерСтроки = ТекущиеДанные.НомерСтроки и Строка.Курьер = ТекущиеДанные.Курьер и  не Строка.НомерЗаказа = ТекущиеДанные.НомерЗаказа   тогда
			//////////
			Если ТекущиеДанные.Начало > Строка.Начало и ТекущиеДанные.Конец <  Строка.Конец тогда 
				Сообщить("Выбранный вами курьер занят. Выберите другого ");
				ТекущиеДанные.Начало = Дата('00010101');
				ТекущиеДанные.Конец = Дата('00010101')
			//////////
			ИначеЕсли ТекущиеДанные.Начало < Строка.Начало и ТекущиеДанные.Конец > Строка.Конец тогда
				Сообщить("Выбранный вами курьер занят.Выберите другого ");
				ТекущиеДанные.Начало = Дата('00010101');
				ТекущиеДанные.Конец = Дата('00010101');
			//////////	
			ИначеЕсли  ТекущиеДанные.Начало < Строка.Начало и ТекущиеДанные.Конец < Строка.Конец тогда
				Сообщить("Выбранный вами курьер занят. Выберите другого");
				ТекущиеДанные.Начало = Дата('00010101');
				ТекущиеДанные.Конец = Дата('00010101');
			//////////
		ИначеЕсли  ТекущиеДанные.Начало = Строка.Начало и  ТекущиеДанные.Конец = Строка.Конец тогда
			Сообщить("Выбранный вами курьер занят. Выберите другого ");
				ТекущиеДанные.Начало = Дата('00010101');
				ТекущиеДанные.Конец = Дата('00010101');
			
			КонецЕсли; 
			
		КонецЕсли
	КонецЦикла   
	
КонецПроцедуры 
  &НаКлиенте
Процедура ПроверкаНаЗаказа()
ТекущиеДанные = Элементы.ТаблицаРасписание.ТекущиеДанные;	
	Для каждого строка из объект.ТаблицаРасписание цикл
		Если не Строка.НомерСтроки = ТекущиеДанные.НомерСтроки   и не Строка.Курьер = ТекущиеДанные.Курьер и Строка.НомерЗаказа = ТекущиеДанные.НомерЗаказа тогда 
			Сообщить ("Данный заказ выполняет другой курьер")
		Конецесли
		КонецЦикла
	КонецПроцедуры 

&НаКлиенте
	Процедура ТаблицаРасписаниеВремяДоставкиЗаказаПриИзменении(Элемент)
	ТекущиеДанные = Элементы.ТаблицаРасписание.ТекущиеДанные;
	
	ПроверкаКурьера();
	ПроверкаНаЗаказа()
	

	КонецПроцедуры
