﻿
&НаКлиенте
Процедура Реквизит1ТипаЧислоНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	// Вставить содержимое обработчика.
КонецПроцедуры

&НаКлиенте
Процедура Реквизит1ТипаЧислоОткрытие(Элемент, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	ЗаголовокФормыСтруктурированногоЗначения = Элемент.Заголовок;
	Если ПустаяСтрока(ЗаголовокФормыСтруктурированногоЗначения) Тогда
		ЗаголовокФормыСтруктурированногоЗначения = ПолучитьЗаголовокЭлемента(Элемент.Имя);
	КонецЕсли;
	ПараметрыФормыСтруктурированногоЗначения = Новый Структура;
	ПараметрыФормыСтруктурированногоЗначения.Вставить("Заголовок", ЗаголовокФормыСтруктурированногоЗначения);
	ПараметрыФормыСтруктурированногоЗначения.Вставить("Данные", ЭтаФорма.Реквизит1ТипаЧислоДанные);
	ОповещениеОЗакрытииФормыСтруктурированногоЗначения = Новый ОписаниеОповещения("ОткрытьЧислоЗавершение", ЭтотОбъект,
		Новый Структура("Элемент", Элемент));
	ОткрытьФорму("ОбщаяФорма.ЧислоВЭкспоненциальнойЗаписи", ПараметрыФормыСтруктурированногоЗначения,
		ЭтаФорма, Строка(ЭтаФорма.УникальныйИдентификатор) + Элемент.Имя, , ,
		ОповещениеОЗакрытииФормыСтруктурированногоЗначения, РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	
КонецПроцедуры
	
&НаСервере
Функция ПолучитьЗаголовокЭлемента(Знач ИмяЭлемента)
	
	Элемент = Элементы[ИмяЭлемента];
	Если ПустаяСтрока(Элемент.Заголовок) Тогда
		РеквизитыЭлемента = ЭтаФорма.ПолучитьРеквизиты(Элемент.ПутьКДанным);
		Если РеквизитыЭлемента.Количество() > 0 Тогда
			РеквизитЭлемента = РеквизитыЭлемента[0];
			Возврат РеквизитЭлемента.Заголовок;
		Иначе
			Возврат Элемент.Имя;
		КонецЕсли;
	Иначе
		Возврат Элемент.Заголовок;
	КонецЕсли;
	
КонецФункции
	
&НаКлиенте
Процедура ОткрытьЧислоЗавершение(Результат, ДополнительныеПараметры) Экспорт
	
	Если ТипЗнч(Результат) = Тип("Структура") Тогда
		ЭтаФорма.Реквизит1ТипаЧислоДанные = Результат;
		Объект.Реквизит1ТипаЧисло = ЧислаКлиентСервер.ПолучитьПредставлениеЧисла(ЭтаФорма.Реквизит1ТипаЧислоДанные);
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ЭтаФорма.Реквизит1ТипаЧислоДанные = Объект.Ссылка.Реквизит1ТипаЧислоДанные.Получить();
	
КонецПроцедуры

&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	ТекущийОбъект.Реквизит1ТипаЧислоДанные = Новый ХранилищеЗначения(ЭтаФорма.Реквизит1ТипаЧислоДанные);
	
КонецПроцедуры
