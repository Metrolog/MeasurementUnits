﻿////////////////////////////////////////////////////////////////////////////////
// Подсистема "Метрологическая служба. Единицы величин".
// ОбщийМодуль.МСЕдиницыВеличин.
//
////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

////////////////////////////////////////////////////////////////////////////////
// Интеграция с Библиотекой стандартных подсистем (БСП).
// Подсистема "Базовая функциональность".

////////////////////////////////////////////////////////////////////////////////
// Обработчики событий подсистемы ЗапретРедактированияРеквизитовОбъектов.

// См. комментарий к одноименной процедуре в общем модуле ЗапретРедактированияРеквизитовОбъектовПереопределяемый.
Процедура ПриОпределенииОбъектовСЗаблокированнымиРеквизитами(Объекты) Экспорт
	
	Объекты.Вставить(Метаданные.Справочники.МСЕдиницыВеличинПриставкиКратныхИДольных.ПолноеИмя(), "");
	Объекты.Вставить(Метаданные.Справочники.МСЕдиницыВеличинБазовые.ПолноеИмя(), "");
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Возвращает идентификатор подсистемы в в справочнике объектов
// метаданных.
//
Функция ИдентификаторПодсистемы() Экспорт
	
	Возврат ОбщегоНазначения.ИдентификаторОбъектаМетаданных(
		"Подсистема.МетрологическаяСлужба.Подсистема.ЕдиницыВеличин");
	
КонецФункции

// Заполняет массив типов неразделенных данных, для которых поддерживается сопоставление ссылок
// при загрузке данных в другую информационную базу.
//
// Параметры:
//  Типы - Массив(ОбъектМетаданных).
//
Процедура ПриЗаполненииТиповОбщихДанныхПоддерживающихСопоставлениеСсылокПриЗагрузке(Типы) Экспорт
	
	Типы.Добавить(Метаданные.Справочники.ВариантыОбозначенийЕдиницВеличин);
	Типы.Добавить(Метаданные.Справочники.МСЕдиницыВеличинПриставкиКратныхИДольных);
	
КонецПроцедуры

// Заполняет массив типов, исключаемых из выгрузки и загрузки данных.
//
// Параметры:
//  Типы - Массив - заполняется метаданными.
//
Процедура ПриЗаполненииТиповИсключаемыхИзВыгрузкиЗагрузки(Типы) Экспорт
	
	Типы.Добавить(Метаданные.Справочники.ВариантыОбозначенийЕдиницВеличин);
	Типы.Добавить(Метаданные.Справочники.МСЕдиницыВеличинПриставкиКратныхИДольных);
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// Подсистема "Поиск и удаление дублей".

// Определить объекты, в модулях менеджеров которых предусмотрена возможность параметризации 
//   алгоритма поиска дублей с помощью экспортных процедур ПараметрыПоискаДублей, ПриПоискеДублей 
//   и ВозможностьЗаменыЭлементов.
//
// Параметры:
//   Объекты - Соответствие - Объекты, в модулях менеджеров которых размещены экспортные процедуры.
//       ** Ключ     - Строка - Полное имя объекта метаданных, подключенного к подсистеме "Поиск и удаление дублей".
//       ** Значение - Строка - Имена экспортных процедур, определенных в модуле менеджера.
//           Могут быть перечислены:
//           "ПараметрыПоискаДублей",
//           "ПриПоискеДублей",
//           "ВозможностьЗаменыЭлементов".
//           Каждое имя должно начинаться с новой строки.
//           Если указана пустая строка, значит в модуле менеджера определены все процедуры.
//
// Примеры:
//
//  1. Определены все процедуры.
//	Объекты.Вставить(Метаданные.Документы.ЗаказПокупателя.ПолноеИмя(), "");
//
//  2. Определены процедуры ПараметрыПоискаДублей и ПриПоискеДублей.
//	Объекты.Вставить(Метаданные.БизнесПроцессы.ЗаданиеСРолевойАдресацией.ПолноеИмя(), "ПараметрыПоискаДублей
//		|ПриПоискеДублей");
//
Процедура ПриОпределенииОбъектовСПоискомДублей(Объекты) Экспорт
	
	Объекты.Вставить(Метаданные.Справочники.МСЕдиницыВеличинПриставкиКратныхИДольных.ПолноеИмя(),
		"ПараметрыПоискаДублей
		|ПриПоискеДублей"
	);
	Объекты.Вставить(Метаданные.Справочники.МСЕдиницыВеличинБазовые.ПолноеИмя(),
		"ПараметрыПоискаДублей
		|ПриПоискеДублей"
	);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытий

Процедура ПриЗаписиВариантаОбозначенийЕдиницыВеличин(Источник, Отказ) Экспорт

	// TODO: инкапсулировать вычисление имён констакт
	Для Каждого ВариантОбозначения Из МСЕдиницыВеличинКлиентСерверПовтИсп.ПолучитьВариантыОбозначенийЕдиницВеличин() Цикл
		Константы["МСЕдиницыВеличинИспользоватьОбозначенияПриставок" + ВариантОбозначения.Код].Установить(
			Константы["МСЕдиницыВеличинИспользоватьОбозначения" + ВариантОбозначения.Код].Получить()
			И (Константы["МСЕдиницыВеличинОбозначенияПриставок"].Получить() = Перечисления.МСЕдиницыВеличинОбозначенияПриставок.ПоПостановлениюПравительстваРФ879)
		);
		Константы["МСЕдиницыВеличинИспользоватьОбозначенияПриставок" + ВариантОбозначения.Код + "ISO_80000_1"].Установить(
			Константы["МСЕдиницыВеличинИспользоватьОбозначения" + ВариантОбозначения.Код].Получить()
			И (Константы["МСЕдиницыВеличинОбозначенияПриставок"].Получить() = Перечисления.МСЕдиницыВеличинОбозначенияПриставок.ПоISO_80000_1)
		);
	КонецЦикла;
	
	Отказ = Ложь;
	
КонецПроцедуры

Процедура ПередЗаписьюУдалитьЛишниеПробелыВНаименованииИОбозначении(Источник, Отказ) Экспорт
	
	Перем РеквизитНаименование;
	Перем РеквизитОбозначение;
	
	Если Источник.ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	Для Каждого ВариантОбозначения Из МСЕдиницыВеличинКлиентСерверПовтИсп.ПолучитьВариантыОбозначенийЕдиницВеличин() Цикл
		РеквизитНаименование = МСЕдиницыВеличинКлиентСерверПовтИсп.ПолучитьРеквизитНаименования(ВариантОбозначения);
		Источник[РеквизитНаименование] = СокрЛП(Источник[РеквизитНаименование]);
		РеквизитОбозначение = МСЕдиницыВеличинКлиентСерверПовтИсп.ПолучитьРеквизитОбозначения(ВариантОбозначения);
		Источник[РеквизитОбозначение] = СокрЛП(Источник[РеквизитОбозначение]);
	КонецЦикла;
	
	Отказ = Ложь;
	
КонецПроцедуры

#КонецОбласти