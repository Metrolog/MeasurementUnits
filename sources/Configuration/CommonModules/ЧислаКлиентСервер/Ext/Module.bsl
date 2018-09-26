﻿////////////////////////////////////////////////////////////////////////////////
// Подсистема "Метрологическая служба. Числа".
// ОбщийМодуль.ЧислаКлиентСервер.
//
////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Возвращает номер версии библиотеки.
//
// Возвращаемое значение:
//	Строка - номер версии библиотеки.
//
Функция ВерсияБиблиотеки() Экспорт
	
	Возврат "0.1.0.0";
	
КонецФункции

// Конструктор структуры - числа.
//
Функция СтруктураЧисла() Экспорт
	
	Возврат Новый Структура("Мантисса, Порядок", "0", 0);
	
КонецФункции

// Функция - Получить представление числа
//
// Параметры:
//  Число	 - Структура	 - структура числа (см. СтруктураЧисла), для которого необходимо вернуть представление.
// 
// Возвращаемое значение:
//  Строка - представление числа.
//
Функция ПолучитьПредставлениеЧисла(Знач Число) Экспорт
	
	Перем Представление;
	
	Представление = Число.Мантисса;
	
	Если Число.Порядок <> 0 Тогда
	    Представление = Представление + "⋅10" +
			РаботаСоСтрокамиЮникодКлиентСервер.ПолучитьСтрокуИзПоказателяСтепени(Число.Порядок);
	КонецЕсли;
	
	Возврат Представление;
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#КонецОбласти
