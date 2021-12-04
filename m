Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC2F46855C
	for <lists+linux-pci@lfdr.de>; Sat,  4 Dec 2021 15:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233973AbhLDOhe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 4 Dec 2021 09:37:34 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:49905 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229553AbhLDOhd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 4 Dec 2021 09:37:33 -0500
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-267-MTGFJstEMMy1CY558vknEA-1; Sat, 04 Dec 2021 14:34:04 +0000
X-MC-Unique: MTGFJstEMMy1CY558vknEA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.26; Sat, 4 Dec 2021 14:34:04 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.026; Sat, 4 Dec 2021 14:34:04 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Subhashini Rao Beerisetty' <subhashbeerisetty@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernelnewbies <kernelnewbies@kernelnewbies.org>
Subject: RE: latency
Thread-Topic: latency
Thread-Index: AQHX6GdhmNv7avsZu0CbwMJv9zlFaKwiXsGw
Date:   Sat, 4 Dec 2021 14:34:04 +0000
Message-ID: <3b914a515b1d4e749e58d3b46cf12b26@AcuMS.aculab.com>
References: <CAPY=qRQJ-YbRi0AStrytsE3ke4vFN9K4Cos2T+b1JKDPJGUVOg@mail.gmail.com>
In-Reply-To: <CAPY=qRQJ-YbRi0AStrytsE3ke4vFN9K4Cos2T+b1JKDPJGUVOg@mail.gmail.com>
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

RnJvbTogU3ViaGFzaGluaSBSYW8gQmVlcmlzZXR0eSA8c3ViaGFzaGJlZXJpc2V0dHlAZ21haWwu
Y29tPg0KPiBTZW50OiAwMyBEZWNlbWJlciAyMDIxIDE3OjAxDQo+IA0KPiAgWyBQbGVhc2Uga2Vl
cCBtZSBpbiBDQyBhcyBJJ20gbm90IHN1YnNjcmliZWQgdG8gdGhlIGxpc3RdDQo+IA0KPiBIaSBh
bGwsDQo+IA0KPiBXZSBhcmUgdXNpbmcgdGhlIExpbnV4IE9TIG9uIGFuIHg4Nl82NCBtYWNoaW5l
LiBJIG5lZWQgdG8gbWVhc3VyZSB0aGUNCj4gUENJZSBsYXRlbmN5IG9uIG15IHN5c3RlbSwgZG9l
cyBrZXJuZWwgaGF2ZSBhbnkgbGF0ZW5jeSBtZWFzdXJlbWVudA0KPiBtb2R1bGUgZm9yIHRoZSBQ
Q0llIGJ1cz8NCg0KU2xvd2VyIHRoYW4geW91IGV4cGVjdCA6LSkNCg0KV3JpdGVzIGFyZSBhc3lu
Y2hyb25vdXMgc28gcmVhbGx5IG9ubHkgbGltaXRlZCBieSB0aGUgYWN0dWFsIHNwZWVkDQpvZiB0
aGUgUENJZSBsaW5rIGFuZCB0aGUgcmF0ZSB0aGUgc2xhdmUgY2FuIHByb2Nlc3MgdGhlbS4NClNv
IHRoZSBhY3R1YWwgbGF0ZW5jeSBvZiB3cml0ZXMgZG9lc24ndCBtYXR0ZXIgYW5kIHRoZSB0aHJv
dWdocHV0DQppcyByZWFzb25hYmxlLg0KDQpSZWFkcyBhcmUgbXVjaCBtb3JlIHByb2JsZW1hdGlj
Lg0KV2hpbGUgdGhlIFBDSWUgYnVzIGFsbG93cyBtdWx0aXBsZSBvdXRzdGFuZGluZyByZWFkIHJl
cXVlc3RzIHRoZQ0KSW50ZWwgeDg2IEkndmUgdGVzdGVkIHdpbGwgb25seSBnZW5lcmF0ZSBvbmUg
b3V0c3RhbmRpbmcgcmVxdWVzdA0KZm9yIGVhY2ggY3B1IGNvcmUuDQpTbyBidWZmZXIgcmVhZHMg
YXJlIHBhcnRpY3VsYXJseSBzbG93Lg0KDQpUaGUgZGVsYXlzIGJldHdlZW4gb24gcmVhZCBjb21w
bGV0aW5nIGFuZCB0aGUgbmV4dCByZWFkIFRMUCBiZWluZw0Kc2VudCBhcmUgKHByb2JhYmx5KSBu
ZWdsaWdpYmxlIGNvbXBhcmVkIHRvIHRoZSBvdGhlciBkZWxheXMuDQpTbyB0aGUgbGF0ZW5jeSBv
ZiBhIHJlYWQgaXMganVzdCB0aGUgdGltZSB0aGUgdHdvIFRMUCB0YWtlIHRvDQpiZSB0cmFuc21p
dHRlZCBvdmVyIHRoZSB3aXJlIChpbmNsdWRpbmcgZGVsYXlzIGZvciBQQ0llIGJyaWRnZXMpDQpw
bHVzIHRoZSB0aW1lIHRoZSBzbGF2ZSB0YWtlcyB0byBnZW5lcmF0ZSB0aGUgcmVzcG9uc2UgVExQ
Lg0KT24gdGhlIGZwZ2Egc2xhdmVzIHdlIGFyZSB1c2luZyB0aGF0IGlzIChmcm9tIG1lbW9yeSkg
YWJvdXQgMTI4DQpjeWNsZXMgb2YgdGhlIDYyLjVNSHogY2xvY2sgLSBpZSBhYnNvbHV0ZWx5IGFn
ZXMuDQoNCkZvciByZWFkcyB5b3UgZGVmaW5pdGVseSBuZWVkIHRvIHVzZSB0aGUgbGFyZ2VzdCBy
ZWdpc3RlciBzaXplDQpwb3NzaWJsZSAtIGVhY2ggcmVhZCBpbnN0cnVjdGlvbiAoZXZlbiBtaXNh
bGlnbmVkIG9uZXMpIGdlbmVyYXRlcw0KZXhhY3RseSBvbmUgcmVhZCBUTFAuDQoNCklmIHlvdSBh
cmUgZGVzaWduaW5nIGFuIGludGVyZmFjZSBmb3IgYW4gZnBnYSB0aGVuIGNvbnNpZGVyIHVzaW5n
DQp3cml0ZXMgZnJvbSBib3RoIHNpZGVzIGZvciBldmVyeXRoaW5nIGV4Y2VwdCBidWxrIGRhdGEu
DQoNCllvdSBjYW4gKHByb2JhYmx5KSBtZWFzdXJlIHRoZSBsYXRlbmN5IG9mIHlvdXIgYWN0dWFs
IHN5c3RlbSB1c2luZzoNCgl4ID0gcmR0c2MoKTsNCgl2ID0gcmVhZGwoKTsNCglsZmVuY2U7DQoJ
ZWxhcHNlZCA9IHJkdHNjKCkgLSB4Ow0KSG93ZXZlciB0aGUgVFNDIHZhbHVlcyBkZXBlbmQgb24g
dGhlIGN1cnJlbnQgY3B1IGZyZXF1ZW5jeSAod2hpY2gNCndpbGwgY2hhbmdlICdyYW5kb21seScp
Lg0KT3IgcHV0IHRoZSByZWFkbCgpIGludG8gYSBsb29wIGFuZCBkbyBlbm91Z2ggdGhhdCB0aGUg
aGlnaC1yZXMNCnN5c3RlbSB0aW1lIGRlbHRzIG1ha2VzIHNlbnNlLg0KDQoJRGF2aWQNCg0KLQ0K
UmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1p
bHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVz
KQ0K

