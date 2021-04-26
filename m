Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11F4636B3B1
	for <lists+linux-pci@lfdr.de>; Mon, 26 Apr 2021 15:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233501AbhDZNCA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Apr 2021 09:02:00 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:54811 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233471AbhDZNB7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Apr 2021 09:01:59 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-226-bKRoWGHJPtmB3JBEE_yQBQ-1; Mon, 26 Apr 2021 14:01:11 +0100
X-MC-Unique: bKRoWGHJPtmB3JBEE_yQBQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Mon, 26 Apr 2021 14:01:11 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.015; Mon, 26 Apr 2021 14:01:10 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Rafael J. Wysocki'" <rafael@kernel.org>,
        Oliver Neukum <oneukum@suse.com>
CC:     Rajat Jain <rajatja@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" 
        <linux-usb@vger.kernel.org>, "Bjorn Helgaas" <helgaas@kernel.org>,
        Rajat Jain <rajatxjain@gmail.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Dmitry Torokhov <dtor@google.com>
Subject: RE: [PATCH v2 2/2] pci: Support "removable" attribute for PCI devices
Thread-Topic: [PATCH v2 2/2] pci: Support "removable" attribute for PCI
 devices
Thread-Index: AQHXOpI8ukue0tNuwUC9JgKnmYtYG6rGwqQQ
Date:   Mon, 26 Apr 2021 13:01:10 +0000
Message-ID: <79b994f2476249498797e1784f735fd7@AcuMS.aculab.com>
References: <20210424021631.1972022-1-rajatja@google.com>
 <20210424021631.1972022-2-rajatja@google.com>
 <d53c72949d81db9f092a9aecb49bf56b47727738.camel@suse.com>
 <CAJZ5v0iNrSFjhmTE8K-JrO07kJon3ikhatbg0Jg2hs+x-frDJg@mail.gmail.com>
In-Reply-To: <CAJZ5v0iNrSFjhmTE8K-JrO07kJon3ikhatbg0Jg2hs+x-frDJg@mail.gmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

RnJvbTogUmFmYWVsIEouIFd5c29ja2kNCj4gU2VudDogMjYgQXByaWwgMjAyMSAxMjo0OQ0KPiAN
Cj4gT24gTW9uLCBBcHIgMjYsIDIwMjEgYXQgMTE6MTcgQU0gT2xpdmVyIE5ldWt1bSA8b25ldWt1
bUBzdXNlLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBBbSBGcmVpdGFnLCBkZW4gMjMuMDQuMjAyMSwg
MTk6MTYgLTA3MDAgc2NocmllYiBSYWphdCBKYWluOg0KPiA+ID4gRXhwb3J0IHRoZSBhbHJlYWR5
IGF2YWlsYWJsZSBpbmZvLCB0byB0aGUgdXNlcnNwYWNlIHZpYSB0aGUNCj4gPiA+IGRldmljZSBj
b3JlLCBzbyB0aGF0IHVzZXJzcGFjZSBjYW4gaW1wbGVtZW50IHdoYXRldmVyIHBvbGljaWVzIGl0
DQo+ID4gPiB3YW50cyB0bywgZm9yIGV4dGVybmFsIHJlbW92YWJsZSBkZXZpY2VzLg0KPiA+DQo+
ID4gSGksDQo+ID4NCj4gPiBpcyB0aGVyZSBhIHdheSB0byB0ZWxsIGFwYXJ0IHdoZXRoZXIgYSBk
ZXZpY2UgY2FuIHVuZGVyZ28gcmVndWxhcg0KPiA+IHN1cnByaXNlIHJlbW92YWw/DQo+IA0KPiBQ
Q0kgZGV2aWNlcyBsb2NhdGVkIHVuZGVyIGEgcmVtb3ZhYmxlIHBhcmVudCBjYW4gdW5kZXJnbyBz
dXJwcmlzZQ0KPiByZW1vdmFsLiAgVGhlIG9uZXMgb24gYSBUaHVuZGVyYm9sdCBjaGFpbiB0b28u
DQo+IA0KPiA+IERvIHdlIHdhbnQgdGhhdD8NCj4gDQo+IERvIHlvdSBtZWFuIHN1cnByaXNlIHJl
bW92YWw/ICBZZXMsIHdlIGRvLg0KDQpBbHdheXMgYmVlbiB0cnVlIC0gdGhpbmsgb2YgY2FyZGJ1
cyAoUENJIHBjbWNpYSkgY2FyZHMgd2l0aA0KUENJIGJyaWRnZXMgdG8gZXh0ZXJuYWwgUENJIGV4
cGFuc2lvbiBjaGFzc2lzIGNvbnRhaW5pbmcNCmFkZGl0aW9uYWwgUENJIHNsb3RzLg0KVGhlIGNh
cmRidXMgY2FyZCBpcyBob3QgcmVtb3ZhYmxlLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBB
ZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMs
IE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

