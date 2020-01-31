Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67E2214EBC1
	for <lists+linux-pci@lfdr.de>; Fri, 31 Jan 2020 12:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbgAaLdH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 31 Jan 2020 06:33:07 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:41824 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728398AbgAaLdH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 31 Jan 2020 06:33:07 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-166-aCOUkESTNNevMVdNmDuoQg-1; Fri, 31 Jan 2020 11:33:03 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 31 Jan 2020 11:33:03 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 31 Jan 2020 11:33:03 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Bjorn Helgaas' <helgaas@kernel.org>,
        Muni Sekhar <munisekharrms@gmail.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: pcie: xilinx: kernel hang - ISR readl()
Thread-Topic: pcie: xilinx: kernel hang - ISR readl()
Thread-Index: AQHV15+VMjSgSoHAFUG77qtnfiBRTqgEpIfQ
Date:   Fri, 31 Jan 2020 11:33:03 +0000
Message-ID: <446f8f85815b480cb1e8cf477b74b1af@AcuMS.aculab.com>
References: <CAHhAz+ijB_SNqRiC1Fn0Uw3OpiS7go4dPPYm6YZckaQ0fuq=QQ@mail.gmail.com>
 <20200130190040.GA96992@google.com>
In-Reply-To: <20200130190040.GA96992@google.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: aCOUkESTNNevMVdNmDuoQg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

RnJvbTogQmpvcm4gSGVsZ2Fhcw0KPiBTZW50OiAzMCBKYW51YXJ5IDIwMjAgMTk6MDENCi4uDQo+
ID4gPiBZb3UgY291bGQgbGVhcm4gdGhpcyBlaXRoZXIgdmlhIGEgUENJZSBhbmFseXplciAoZXhw
ZW5zaXZlIHBpZWNlIG9mDQo+ID4gPiBoYXJkd2FyZSkgb3IgcG9zc2libHkgc29tZSBsb2dpYyBp
biB0aGUgRlBHQSB0aGF0IHdvdWxkIGxvZyBQQ0llDQo+ID4gPiB0cmFuc2FjdGlvbnMgaW4gYSBi
dWZmZXIgYW5kIG1ha2UgdGhlbSBhY2Nlc3NpYmxlIHZpYSBzb21lIG90aGVyDQo+ID4gPiBpbnRl
cmZhY2UgKHlvdSBtZW50aW9uZWQgaXQgaGFkIHBhcmFsbGVsIGFuZCBvdGhlciBpbnRlcmZhY2Vz
KS4NCg0KWW91IGNhbiBwcm9iYWJseSB1c2UgdGhlIFhpbGlueCBlcXVpdmFsZW50IG9mIEFsdGVy
YSAnc2lnbmFsdGFwJw0KdG8gd29yayBvdXQgd2hhdCBpcyBoYXBwZW5pbmcgd2l0aGluIHRoZSBm
cGdhLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5
IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRp
b24gTm86IDEzOTczODYgKFdhbGVzKQ0K

