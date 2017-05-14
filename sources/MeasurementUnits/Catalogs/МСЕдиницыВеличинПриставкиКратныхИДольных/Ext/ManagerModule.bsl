﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

// Возвращает элемент справочника по основанию степени и показателю.
//
// Параметры:
//  ПоказательСтепени	- Строка, Число		- Показатель степени
//  ОснованиеСтепени    - Строка, Число		- Основание степени
// 
// Возвращаемое значение:
//   Ссылка             - элемент справочника
//   Неопределено       - в случае, искомый элемент не найден.
//
Функция НайтиПоПоказателю(Знач ПоказательСтепени, Знач ОснованиеСтепени = 10) Экспорт
	Возврат НайтиПоКоду(ПолучитьКод(ПоказательСтепени, ОснованиеСтепени));
КонецФункции

// Создаёт либо обновляет поставляемый элемент справочника при обновлении ИБ.
//
// Параметры:
//  Основание           - Число		- Основание степени
//  Показатель			- Число		- Показатель степени
//  Наименование 		- Строка    - Наименование приставки
//  Обозначение 		- Строка    - Обозначение приставки
// 
Процедура ЗаполнитьПредопределённый(Знач Основание, Знач Порядок, Знач Наименование,
	Знач Приставка, Знач Обозначение,
	Знач ПриставкаМеждународная, Знач ОбозначениеМеждународное,
	Знач ПриставкаISO_80000_1 = Неопределено, Знач ОбозначениеISO_80000_1 = Неопределено,
	Знач ПриставкаМеждународнаяISO_80000_1 = Неопределено, Знач ОбозначениеМеждународноеISO_80000_1 = Неопределено) Экспорт
	
	Перем ТребуетсяЗапись;
		
	Параметры = Новый ФиксированнаяСтруктура(
		"Основание,Порядок,Наименование," +
		"Приставка,Обозначение," +
		"ПриставкаМеждународная,ОбозначениеМеждународное," +
		"ПриставкаISO_80000_1,ОбозначениеISO_80000_1," +
		"ПриставкаМеждународнаяISO_80000_1,ОбозначениеМеждународноеISO_80000_1",
		Основание, Порядок, Наименование,
		Приставка, Обозначение,
		ПриставкаМеждународная, ОбозначениеМеждународное,
		?(ПриставкаISO_80000_1 <> Неопределено, ПриставкаISO_80000_1, Приставка),
			?(ОбозначениеISO_80000_1 <> Неопределено, ОбозначениеISO_80000_1, Обозначение),
		?(ПриставкаМеждународнаяISO_80000_1 <> Неопределено, ПриставкаМеждународнаяISO_80000_1, ПриставкаМеждународная),
			?(ОбозначениеМеждународноеISO_80000_1 <> Неопределено, ОбозначениеМеждународноеISO_80000_1, ОбозначениеМеждународное)
	);

	Приставка = НайтиПоПоказателю(Порядок, Основание);
	
	Если Приставка <> ПустаяСсылка() Тогда
		
		ТребуетсяЗапись = Ложь;
		
		Для Каждого Реквизит из Параметры цикл
			ТребуетсяЗапись = НЕ (Реквизит.Значение = Приставка[Реквизит.Ключ]);
			Если ТребуетсяЗапись Тогда
                Прервать;
	        КонецЕсли;
	    КонецЦикла;

		Если НЕ ТребуетсяЗапись Тогда
			Возврат;
		Иначе
			ПриставкаОбъект = Приставка.ПолучитьОбъект();
		КонецЕсли;
		
	Иначе
		
		ПриставкаОбъект = СоздатьЭлемент();
		
	КонецЕсли;
	
	ПриставкаОбъект.Заполнить(Параметры);
	ОбновлениеИнформационнойБазы.ЗаписатьДанные(ПриставкаОбъект, , Истина);
	
КонецПроцедуры

#КонецОбласти

#Область Представление

Процедура ОбработкаПолученияПолейПредставления(Поля, СтандартнаяОбработка) 
	СтандартнаяОбработка = Ложь; 
    Поля.Добавить("Наименование");
    Поля.Добавить("Основание");
    Поля.Добавить("Порядок");
КонецПроцедуры 

Процедура ОбработкаПолученияПредставления(Данные, Представление, СтандартнаяОбработка) 
    СтандартнаяОбработка = Ложь;
    Представление = Данные.Наименование + " (" + Данные.Основание + РаботаСоСтрокамиЮникодКлиентСервер.ПолучитьСтрокуИзПоказателяСтепени(Данные.Порядок) + ")";
КонецПроцедуры

#КонецОбласти

#Область КодСправочника

// Преобразует переданные основание и показатель степени (число) в значение кода для справочника.
//
// Параметры:
//  ПоказательСтепени	 - Строка, Число	 - Показатель степени
//  ОснованиеСтепени     - Строка, Число     - Основание степени
// 
// Возвращаемое значение:
//   Число - значение кода для справочника
//
Функция ПолучитьКод(Знач ПоказательСтепени, Знач ОснованиеСтепени = 10) Экспорт
	ПоказательСтепениЧисло = Число(ПоказательСтепени);
	ОснованиеСтепениЧисло = Число(ОснованиеСтепени);
	Результат = (ПоказательСтепениЧисло + 100)*100 + ОснованиеСтепениЧисло;
	Возврат Результат;
КонецФункции

#КонецОбласти

#КонецЕсли