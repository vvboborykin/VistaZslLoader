{*******************************************************
* Project: VistaBillExtractor
* Unit: SubscriptionUnit.pas
* Description: Паттерн "подписка"
*
* Created: 15.12.2022 13:08:03
* Copyright (C) 2022 Боборыкин В.В. (bpost@yandex.ru)
*******************************************************}
unit Lib.Subscription;

interface

uses
  System.SysUtils, System.Classes, System.Variants, System.Generics.Collections,
  Lib.ThreadSafeObject;

type
  ISubscriber<TMessageData> = interface;

  IPublisher<TMessageData> = interface;

  /// <summary>ISubscriber
  /// Подписчик
  /// </summary>
  ISubscriber<TMessageData> = interface
  ['{6C782291-9B1F-4D10-A33B-5A7B04FC910C}']
    /// <summary>ISubscriber<TMessageData>.OnPublisherMessage
    /// Обработчик событий получаемых от издателей
    /// </summary>
    /// <param name="APublisher"> (IPublisher<TMessageData>) Издатель</param>
    /// <param name="AMessage"> (TMessageData) Событие</param>
    procedure OnPublisherMessage(APublisher: IPublisher<TMessageData>; AMessage:
        TMessageData); stdcall;
  end;

  /// <summary>TMessagePredicate<>
  /// Тип функции для фильтрации сообщений доставляемых подписчику
  /// </summary>
  /// type:
  /// <param name="AMessage"> (TMessageData) </param>
  TMessagePredicate<TMessageData> = reference to function (AMessage: TMessageData): Boolean;

  /// <summary>IPublisher
  /// Издатель
  /// </summary>
  IPublisher<TMessageData> = interface
  ['{9F6B99FC-5211-4E3F-9EEA-BA32C12F95B2}']
    /// <summary>IPublisher<TMessageData>.BroadcastMessage
    /// Разослать данные события всем подписчикам
    /// </summary>
    /// <param name="AMessage"> (TMessageData) Данные события</param>
    procedure BroadcastMessage(AMessage: TMessageData); stdcall;
    /// <summary>IPublisher<TMessageData>.RegisterSubscriber
    /// Зарегистрировать подписчика
    /// </summary>
    /// <param name="ASubscriber"> (ISubscriber<TMessageData>) Новый подписчик</param>
    procedure RegisterSubscriber(ASubscriber: ISubscriber<TMessageData>;
      AMessageFilter: TMessagePredicate<TMessageData> = nil); stdcall;
    /// <summary>IPublisher<TMessageData>.UnRegisterSubscriber
    /// Отменить регистрацию подписчика
    /// </summary>
    /// <param name="ASubscriber"> (ISubscriber<TMessageData>) Удаляемый
    /// подписчик</param>
    procedure UnRegisterSubscriber(ASubscriber: ISubscriber<TMessageData>); stdcall;
  end;

  /// <summary>TSubscriberRecord
  /// Запись для хранения регистрации подписчика
  /// </summary>
  TSubscriberRecord<TMessageData> = record
  public
    /// <summary>TSubscriberRecord<>.Subscriber
    /// Подписчик
    /// </summary>
    /// type:ISubscriber<TMessageData>
    Subscriber: ISubscriber<TMessageData>;
    /// <summary>TSubscriberRecord<>.MessageFilter
    /// Фильтр для выборки доставляемых сообщений
    /// </summary>
    /// type:TMessagePredicate<TMessageData>
    MessageFilter: TMessagePredicate<TMessageData>;
    constructor Create(ASubscriber: ISubscriber<TMessageData>; AMessageFilter:
        TMessagePredicate<TMessageData>);
  end;

  /// <summary>TPublisher
  /// Реализация IPublisher
  /// </summary>
  TPublisher<TMessageData> = class(TThreadSafeInterfacedObject, IPublisher<
    TMessageData>)
  strict private
    FSubscribers: TDictionary<ISubscriber<TMessageData>, TMessagePredicate<TMessageData>>;
    procedure RegisterSubscriber(ASubscriber: ISubscriber<TMessageData>;
        AMessageFilter: TMessagePredicate<TMessageData> = nil); stdcall;
    procedure UnRegisterSubscriber(ASubscriber: ISubscriber<TMessageData>);
      stdcall;
    const
      SSubscribersLockName = 'FSubscribers';
  strict protected
    procedure BroadcastMessage(AMessage: TMessageData); stdcall;
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

constructor TPublisher<TMessageData>.Create;
begin
  inherited Create;
  FSubscribers := TDictionary<ISubscriber<TMessageData>,
    TMessagePredicate<TMessageData>>.Create();
end;

destructor TPublisher<TMessageData>.Destroy;
begin
  FSubscribers.Free;
  inherited Destroy;
end;

procedure TPublisher<TMessageData>.BroadcastMessage(AMessage: TMessageData);
begin
  UsingResourceLock(
    procedure
    begin
      for var vPair in FSubscribers do
      begin
        if not Assigned(vPair.Value) or vPair.Value(AMessage) then
          vPair.Key.OnPublisherMessage(Self, AMessage);
      end;
    end, SSubscribersLockName);
end;

procedure TPublisher<TMessageData>.RegisterSubscriber(ASubscriber:
    ISubscriber<TMessageData>; AMessageFilter: TMessagePredicate<TMessageData>
    = nil);
begin
  UsingResourceLock(
    procedure
    begin
      if not FSubscribers.ContainsKey(ASubscriber) then
        FSubscribers.Add(ASubscriber, AMessageFilter);
    end, SSubscribersLockName);
end;

procedure TPublisher<TMessageData>.UnRegisterSubscriber(ASubscriber: ISubscriber
  <TMessageData>);
begin
  UsingResourceLock(
    procedure
    begin
      if FSubscribers.ContainsKey(ASubscriber) then
        FSubscribers.Remove(ASubscriber);
    end, SSubscribersLockName);
end;

constructor TSubscriberRecord<TMessageData>.Create(ASubscriber:
    ISubscriber<TMessageData>; AMessageFilter: TMessagePredicate<TMessageData>);
begin
  Subscriber := ASubscriber;
  MessageFilter := AMessageFilter;
end;

end.

