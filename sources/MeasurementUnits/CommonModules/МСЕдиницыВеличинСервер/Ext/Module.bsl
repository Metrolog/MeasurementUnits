﻿////////////////////////////////////////////////////////////////////////////////
// Подсистема "Метрологическая служба. Единицы величин".
// ОбщийМодуль.МСЕдиницыВеличинСервер.
//
////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

////////////////////////////////////////////////////////////////////////////////
// Работа с обозначениями

// Формирует обозначение единицы величины по её выражению из базовых.
//
// Параметры:
// 	Единица	- Ссылка, Объект, Структура	- Ссылка на объект единицы величины.
// 	ОбозначениеЕдиницыВеличин - МСЕдиницыВеличинОбозначения	- Вариант обозначения единиц величин.
//
// Возвращаемое значение:
//  Строка - Обозначение единицы величины.
//
Функция СформироватьОбозначениеЕдиницыВеличины(Знач Единица, Знач ОбозначениеЕдиницыВеличин = Неопределено) Экспорт
	
	Перем Обозначение;
	Перем ПредставлениеМножителя;
	
	ОбщегоНазначенияКлиентСервер.ПроверитьПараметр(
		"МСЕдиницыВеличинСервер.СформироватьОбозначениеЕдиницыВеличины",
		"Единица",
		Единица,
		Новый ОписаниеТипов(
			"СправочникСсылка.ЕдиницыВеличин, СправочникОбъект.ЕдиницыВеличин,
			|ДанныеФормыСтруктура, Структура"));
		
	Обозначение = "";
	
	Если Единица <> Справочники.ЕдиницыВеличин.ПустаяСсылка() Тогда 
		
		Для Каждого Множитель Из Единица.Выражение Цикл
			
			Если Число(Множитель.ПоказательСтепени) <> 0 
				И (Множитель.БазоваяЕдиница <> Справочники.ЕдиницыВеличин.ПустаяСсылка())
			Тогда 
				ПредставлениеМножителя =
					МСЕдиницыВеличинКлиентСервер.ПолучитьОбозначение(Множитель.Приставка, ОбозначениеЕдиницыВеличин)
					+ МСЕдиницыВеличинКлиентСервер.ПолучитьОбозначение(Множитель.БазоваяЕдиница, ОбозначениеЕдиницыВеличин)
					+ РаботаСоСтрокамиЮникодКлиентСервер.ПолучитьСтрокуИзПоказателяСтепениКраткую(Множитель.ПоказательСтепени)
				;
				Обозначение = ?(НЕ ПустаяСтрока(Обозначение),Обозначение + "⋅","") + ПредставлениеМножителя;
			КонецЕсли;
			
		КонецЦикла;
		
	КонецЕсли;

	Возврат Обозначение;

КонецФункции

////////////////////////////////////////////////////////////////////////////////
// Работа с наименованиями

// Формирует наименование единицы величины по её выражению из базовых.
//
// Параметры:
// 	Единица		- Ссылка, Объект, Структура	- Сссылка на объект единицы величины.
// 	ОбозначениеЕдиницыВеличин - МСЕдиницыВеличинОбозначения	- Вариант обозначения единиц величин.
//
// Возвращаемое значение:
//  Строка - Наименование единицы величины.
//
Функция СформироватьНаименованиеЕдиницыВеличины(Знач Единица, Знач ОбозначениеЕдиницыВеличин = Неопределено) Экспорт
	
	Перем НаименованиеЧислителя, НаименованиеЗнаменателя, Предлог, МодульПоказателяСтепени, Падеж,
		ПредставлениеМножителя, КодЯзыка;
	
	ОбщегоНазначенияКлиентСервер.ПроверитьПараметр(
		"МСЕдиницыВеличинСервер.СформироватьНаименованиеЕдиницыВеличины",
		"Единица",
		Единица,
		Новый ОписаниеТипов(
			"СправочникСсылка.ЕдиницыВеличин, СправочникОбъект.ЕдиницыВеличин,
			|ДанныеФормыСтруктура, Структура"));
	
	Если ОбозначениеЕдиницыВеличин = Неопределено Тогда
		ОбозначениеЕдиницыВеличин = ПолучитьФункциональнуюОпцию("МСЕдиницыВеличинОбозначения");
	КонецЕсли;

	КодЯзыка = Перечисления.Языки.ПолучитьКодЯзыка(ОбозначениеЕдиницыВеличин.Язык);
	
	Если Единица <> Справочники.ЕдиницыВеличин.ПустаяСсылка() Тогда 
		
		НаименованиеЧислителя = "";
		НаименованиеЗнаменателя = "";
		Предлог = "";
		
		Для Каждого Множитель Из Единица.Выражение Цикл
			
			Если Число(Множитель.ПоказательСтепени) <> 0 
				И (Множитель.БазоваяЕдиница <> Справочники.ЕдиницыВеличин.ПустаяСсылка())
			Тогда 
			
				МодульПоказателяСтепени = ?(Множитель.ПоказательСтепени < 0,
					-Множитель.ПоказательСтепени,
					Множитель.ПоказательСтепени
				);
				Падеж = ?(Множитель.ПоказательСтепени > 0, 1, 4);
				
				ПредставлениеМножителя = 
					МСЕдиницыВеличинКлиентСервер.ПолучитьНаименование(Множитель.Приставка, ОбозначениеЕдиницыВеличин)
					+ СклонениеПредставленийОбъектов.ПросклонятьПредставление(
						МСЕдиницыВеличинКлиентСервер.ПолучитьНаименование(Множитель.БазоваяЕдиница, ОбозначениеЕдиницыВеличин),
						Падеж, Множитель.БазоваяЕдиница);
						
				ПредставлениеМножителя = РаботаСоСтрокамиЮникодКлиентСервер.СтепеньПрописью(
					ПредставлениеМножителя,
					МодульПоказателяСтепени,
					Множитель.БазоваяЕдиница.ИспользоватьНаименованиеСтепениКакПрилагательное,
					ОбозначениеЕдиницыВеличин.Язык);
				
				Если Множитель.ПоказательСтепени > 0 Тогда
					
					НаименованиеЧислителя = ?(НЕ ПустаяСтрока(НаименованиеЧислителя), НаименованиеЧислителя + "-", "") + ПредставлениеМножителя;
					
				ИначеЕсли Множитель.ПоказательСтепени < 0 Тогда
					
					НаименованиеЗнаменателя = ?(НЕ ПустаяСтрока(НаименованиеЗнаменателя), НаименованиеЗнаменателя + "-", "") + ПредставлениеМножителя;
					Если ПустаяСтрока(Предлог)
						И (МодульПоказателяСтепени = 1)
					Тогда
						Предлог = МСЕдиницыВеличинКлиентСервер.ПолучитьПредлогДляЗнаменателя(Множитель.БазоваяЕдиница, ОбозначениеЕдиницыВеличин);
					Иначе
						Предлог = НСтр("ru='на';en='per'", КодЯзыка);
					КонецЕсли;
					
				КонецЕсли;
				
			КонецЕсли;
			
		КонецЦикла;
		
		Возврат 
			?(ПустаяСтрока(НаименованиеЧислителя),
				НСтр("ru='единица';en='one'", КодЯзыка),
				НаименованиеЧислителя)
			+ ?(ПустаяСтрока(НаименованиеЗнаменателя), "", " " + Предлог + " " + НаименованиеЗнаменателя)
		;
		
	Иначе
		
		Возврат "";
		
	КонецЕсли;
	
КонецФункции

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

#КонецОбласти
