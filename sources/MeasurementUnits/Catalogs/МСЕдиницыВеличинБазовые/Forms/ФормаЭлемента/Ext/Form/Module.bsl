﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	// СтандартныеПодсистемы.ЗапретРедактированияРеквизитовОбъектов
	ЗапретРедактированияРеквизитовОбъектов.ЗаблокироватьРеквизиты(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ЗапретРедактированияРеквизитовОбъектов
	
	// СтандартныеПодсистемы.ЦентрМониторинга
	
	// Подсчитываем количество созданий формы, стандартный разделитель ".".
	Комментарий = Строка(ПолучитьСкоростьКлиентскогоСоединения());
	ЦентрМониторинга.ЗаписатьОперациюБизнесСтатистики("Справочник.МСЕдиницыВеличинБазовые.ПриСозданииНаСервере", 1, Комментарий);
	
	// Конец СтандартныеПодсистемы.ЦентрМониторинга
	
	// СтандартныеПодсистемы.СклонениеПредставленийОбъектов
	СклонениеПредставленийОбъектов.ПриСозданииНаСервере(ЭтотОбъект,
		Объект[МСЕдиницыВеличинКлиентСерверПовтИсп.ПолучитьРеквизитНаименования()]);
	// Конец СтандартныеПодсистемы.СклонениеПредставленийОбъектов
	
	// ОтложенноеОбновлениеПредставления
	МассивРеквизитов = Новый Массив;
	РеквизитНеобходимоИзменениеПредставления = Новый РеквизитФормы("НеобходимоИзменениеПредставления", Новый ОписаниеТипов("Булево"), , "Необходимо изменение представления");	
	МассивРеквизитов.Добавить(РеквизитНеобходимоИзменениеПредставления);
	ИзменитьРеквизиты(МассивРеквизитов);
	// Конец ОтложенноеОбновлениеПредставления
	
	Если Параметры.Ключ.Пустая() И Параметры.ЗначениеКопирования.Пустая() Тогда
		Объект.Выражение.Добавить().ПоказательСтепени = 1;
	КонецЕсли;
	
	УстановитьДоступность();

КонецПроцедуры

&НаСервере
Процедура ПриЗаписиНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	// СтандартныеПодсистемы.СклонениеПредставленийОбъектов
	СклонениеПредставленийОбъектов.ПриЗаписиНаСервере(ЭтотОбъект,
		Объект[МСЕдиницыВеличинКлиентСерверПовтИсп.ПолучитьРеквизитНаименования()],
		ТекущийОбъект.Ссылка);
	// Конец СтандартныеПодсистемы.СклонениеПредставленийОбъектов
	
КонецПроцедуры

&НаСервере
Процедура ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи)

	// СтандартныеПодсистемы.ЗапретРедактированияРеквизитовОбъектов
	ЗапретРедактированияРеквизитовОбъектов.ЗаблокироватьРеквизиты(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ЗапретРедактированияРеквизитовОбъектов

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

// СтандартныеПодсистемы.СклонениеПредставленийОбъектов

&НаКлиенте
Процедура Склонения(Команда)
	
	СклонениеПредставленийОбъектовКлиент.ОбработатьКомандуСклонения(ЭтотОбъект,
		Объект["Наименование" + Прав(Команда.Имя, СтрДлина(Команда.Имя)-СтрДлина("Склонения"))]);
			
КонецПроцедуры

// Конец СтандартныеПодсистемы.СклонениеПредставленийОбъектов

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура НаименованиеПриИзменении(Элемент)
		
	// СтандартныеПодсистемы.СклонениеПредставленийОбъектов
	СклонениеПредставленийОбъектовКлиент.ПриИзмененииПредставления(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.СклонениеПредставленийОбъектов

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовФормы

&НаКлиенте
Процедура ПредикатыПриИзменении(Элемент)
	
	Если Объект.ЭтоОсновнаяЕдиница Тогда

		Объект.ЭтоКогерентнаяЕдиница = Истина;
		Объект.ИмеетСпециальныеНаименованиеИОбозначение = Истина;

	КонецЕсли;

	Если Объект.ЭтоКогерентнаяЕдиница Тогда

		Объект.Коэффициент = "1";

		Для Каждого Множитель Из Объект.Выражение Цикл
			Множитель.Приставка = Неопределено;
		КонецЦикла;

	КонецЕсли;

	Подключаемый_ПриИзмененииРеквизита(Элемент);

	// ОтложенноеОбновлениеПредставления
	Если Не Объект.ИмеетСпециальныеНаименованиеИОбозначение Тогда

		НеобходимоИзменениеПредставления = Истина;
		ПодключитьОбработчикОжидания("Подключаемый_ИзменитьПредставление", 0.5, Истина);

	КонецЕсли;	
	// Конец ОтложенноеОбновлениеПредставления

КонецПроцедуры

&НаКлиенте
Процедура ВыражениеПриНачалеРедактирования(Элемент, НоваяСтрока, Копирование)
	Если НоваяСтрока И НЕ Копирование Тогда
		Элемент.ТекущиеДанные.ПоказательСтепени=1;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ВыражениеПриИзменении(Элемент)
	
	// ОтложенноеОбновлениеПредставления
	
	НеобходимоИзменениеПредставления = Истина;
	ПодключитьОбработчикОжидания("Подключаемый_ИзменитьПредставление", 0.5, Истина);
	
	// Конец ОтложенноеОбновлениеПредставления
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

////////////////////////////////////////////////////////////////////////////////
// Клиент

// ОтложенноеОбновлениеПредставления

&НаКлиенте
Процедура Подключаемый_ИзменитьПредставление() 
	НовыеЗначения = ПолучитьВычисляемыеРеквизиты();
	ЗаполнитьЗначенияСвойств(Объект, НовыеЗначения);
	НеобходимоИзменениеПредставления = Ложь;
КонецПроцедуры

// Конец ОтложенноеОбновлениеПредставления
	
&НаКлиенте
Процедура Подключаемый_РазрешитьРедактированиеРеквизитовОбъекта(Команда)
    ЗапретРедактированияРеквизитовОбъектовКлиент.РазрешитьРедактированиеРеквизитовОбъекта(ЭтотОбъект);
КонецПроцедуры

// СтандартныеПодсистемы.СклонениеПредставленийОбъектов

&НаКлиенте 
Процедура Подключаемый_ПросклонятьПредставлениеПоВсемПадежам() 
	
	СклонениеПредставленийОбъектовКлиент.ПросклонятьПредставлениеПоВсемПадежам(ЭтотОбъект,
		Объект[МСЕдиницыВеличинКлиентСерверПовтИсп.ПолучитьРеквизитНаименования()]);

КонецПроцедуры

// Конец СтандартныеПодсистемы.СклонениеПредставленийОбъектов

&НаКлиенте
Процедура Подключаемый_ПриИзмененииРеквизита(Элемент, ОбновлятьИнтерфейс = Истина)
	
	УстановитьДоступность();
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// Клиент и Сервер

Процедура УстановитьДоступность(РеквизитПутьКДанным = "")
	
	Если Объект.ЭтоОсновнаяЕдиница Тогда
		
		ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
			Элементы, "ЭтоКогерентнаяЕдиница", "Доступность",
			Ложь);
		ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
			Элементы, "ИмеетСпециальныеНаименованиеИОбозначение", "Доступность",
			Ложь);
		ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
			Элементы, "ГруппаВыражение", "Видимость",
			Ложь);
		
	Иначе
		
		ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
			Элементы, "ЭтоКогерентнаяЕдиница", "Доступность",
			Истина);
		ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
			Элементы, "ИмеетСпециальныеНаименованиеИОбозначение", "Доступность",
			Истина);
		ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
			Элементы, "ГруппаВыражение", "Видимость",
			Истина);
		ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
			Элементы, "ВыражениеПриставка", "Видимость",
			Объект.ЭтоКогерентнаяЕдиница <> Истина);
		// TODO: вопрос с "кг" здесь возникает... "кг" - когерентная единица, но при этом - с приставкой "кило"...
		
	КонецЕсли;
	
	Если Объект.ИмеетСпециальныеНаименованиеИОбозначение Тогда
		
		ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
			Элементы, "ГруппаНаименованияИОбозначения", "ТолькоПросмотр",
			Ложь);
			
			Для Каждого ВариантОбозначения Из МСЕдиницыВеличинКлиентСерверПовтИсп.ПолучитьВариантыОбозначенийЕдиницВеличин() Цикл
			ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
				Элементы, МСЕдиницыВеличинКлиентСерверПовтИсп.ПолучитьРеквизитПредлогаДляЗнаменателя(ВариантОбозначения), "Видимость",
				Истина);
		КонецЦикла;
	
		ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
			Элементы, "ИспользоватьНаименованиеСтепениКакПрилагательное", "Видимость",
			Истина);
			
	Иначе

		ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
			Элементы, "ГруппаНаименованияИОбозначения", "ТолькоПросмотр",
			Истина);
		
		Для Каждого ВариантОбозначения Из МСЕдиницыВеличинКлиентСерверПовтИсп.ПолучитьВариантыОбозначенийЕдиницВеличин() Цикл
			ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
				Элементы, МСЕдиницыВеличинКлиентСерверПовтИсп.ПолучитьРеквизитПредлогаДляЗнаменателя(ВариантОбозначения), "Видимость",
				Ложь);
		КонецЦикла;
	
		ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
			Элементы, "ИспользоватьНаименованиеСтепениКакПрилагательное", "Видимость",
			Ложь);
			
	КонецЕсли;
	
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
		Элементы, "ГруппаКоэффициент", "Видимость",
		(Объект.ЭтоКогерентнаяЕдиница <> Истина)
		И (Объект.ИмеетСпециальныеНаименованиеИОбозначение = Истина)
	);
			
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// Вызов сервера

&НаСервере
Функция ПолучитьВычисляемыеРеквизиты()
	
	Перем НовыеЗначения;
	
	НовыеЗначения = Новый Структура();
	
	Для Каждого ВариантОбозначения Из МСЕдиницыВеличинКлиентСерверПовтИсп.ПолучитьВариантыОбозначенийЕдиницВеличин() Цикл
		
		Если МСЕдиницыВеличинКлиентСерверПовтИсп.ИспользуютсяОбозначения(ВариантОбозначения) Тогда
			
			НовыеЗначения.Вставить(МСЕдиницыВеличинКлиентСерверПовтИсп.ПолучитьРеквизитОбозначения(ВариантОбозначения),
				МСЕдиницыВеличинСервер.СформироватьОбозначениеЕдиницыВеличины(Объект, ВариантОбозначения));
			НовыеЗначения.Вставить(МСЕдиницыВеличинКлиентСерверПовтИсп.ПолучитьРеквизитНаименования(ВариантОбозначения),
				МСЕдиницыВеличинСервер.СформироватьНаименованиеЕдиницыВеличины(Объект, ВариантОбозначения));
				
			КонецЕсли;
			
	КонецЦикла;
	
	Возврат НовыеЗначения;
	
КонецФункции

#КонецОбласти