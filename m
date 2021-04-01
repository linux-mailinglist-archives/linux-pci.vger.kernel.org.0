Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9282351E28
	for <lists+linux-pci@lfdr.de>; Thu,  1 Apr 2021 20:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234114AbhDASf7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Apr 2021 14:35:59 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:48755 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238089AbhDASYT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Apr 2021 14:24:19 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-121-k3M7_sOBMMSUMd0vtI6_sg-1; Thu, 01 Apr 2021 15:23:18 +0100
X-MC-Unique: k3M7_sOBMMSUMd0vtI6_sg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Thu, 1 Apr 2021 15:23:17 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.012; Thu, 1 Apr 2021 15:23:17 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Rafael J. Wysocki'" <rafael@kernel.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Xiaofei Tan <tanxiaofei@huawei.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>
Subject: RE: [PATCH v2 04/15] ACPI: table: replace __attribute__((packed)) by
 __packed
Thread-Topic: [PATCH v2 04/15] ACPI: table: replace __attribute__((packed)) by
 __packed
Thread-Index: AQHXJlJheusKxfb1K0qiX/864DlgraqfWwQwgABDWwCAABZkEA==
Date:   Thu, 1 Apr 2021 14:23:17 +0000
Message-ID: <a0ec3dbdffc145ac909089048e552eb6@AcuMS.aculab.com>
References: <e0d626837e577e60f226b8bbf354bd8cbb1fe40a.camel@intel.com>
 <20210331172210.GA1397554@bjorn-Precision-5520>
 <100f5a45dae14c77b341b7f1c5ea1db0@AcuMS.aculab.com>
 <CAJZ5v0jJ2XDYSwqP3AyKuUvuxhwuNwvk3Z=xwtAL3hG5uYGG-Q@mail.gmail.com>
In-Reply-To: <CAJZ5v0jJ2XDYSwqP3AyKuUvuxhwuNwvk3Z=xwtAL3hG5uYGG-Q@mail.gmail.com>
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

RnJvbTogUmFmYWVsIEouIFd5c29ja2kNCj4gU2VudDogMDEgQXByaWwgMjAyMSAxNDo1MA0KLi4u
DQo+IFNvIHdoYXQgZXhhY3RseSBpcyB3cm9uZyB3aXRoIHVzaW5nICJwYWNrZWQiPyAgSXQgaXMg
d2F5IGVhc2llciB0bw0KPiB1bmRlcnN0YW5kIGZvciBhIGNhc3VhbCByZWFkZXIgb2YgdGhlIGNv
ZGUuDQoNCkJlY2F1c2UgaXQgaXMgdXN1YWxseSB3cm9uZyENCg0KSWYgSSBoYXZlOg0KCXN0cnVj
dCBmb28gew0KCQl1NjQgdmFsOw0KCX0gX19wYWNrZWQ7DQoNCkFuZCB0aGVuIGhhdmU6DQp1NjQg
YmFyKHN0cnVjdCBmb28gKmZvbykNCnsNCglyZXR1cm4gZm9vLT52YWw7DQp9DQoNClRoZSBvbiBz
b21lIGNwdSB0aGUgY29tcGlsZXIgaGFzIHRvIGdlbmVyYXRlIHRoZSBlcXVpdmFsZW50IG9mOg0K
CXU4ICp4ID0gKHZvaWQgKikmZm9vLT52YWw7DQoJcmV0dXJuIHhbMF0gfCB4WzFdIDw8IDggfCB4
WzJdIDw8IDE2IHwgeFszXSA8PCAyNCB8IHhbNF0gPDwgMzIgfCB4WzVdIDw8IDQwIHwgeFs2XSA8
PCA0OCB8IHhbN10gPDwgNTY7DQoNCklmIHlvdSBjYW4gZ3VhcmFudGVlIHRoYXQgdGhlIHN0cnVj
dHVyZSBpcyAzMmJpdCBhbGlnbmVkDQp0aGVuIGl0IGNhbiBnZW5lcmF0ZSB0aGUgc2ltcGxlcjoN
Cgl1MzIgKnggPSAodm9pZCAqKSZmb28tPnZhbDsNCglyZXR1cm4geFswXSB8IHhbMV0gPDwgMzI7
DQoNCihZZXMgSSd2ZSBtaXNzZWQgb3V0IHRoZSA2NC1iaXQgY2FzdHMpDQoNClRoaXMgaXMgd2h5
IHlvdSBzaG91bGQgYWxtb3N0IG5ldmVyIHVzZSBfX3BhY2tlZC4NCg0KVGhlcmUgYXJlIGhpc3Rv
cmljIHN0cnVjdHVyZXMgd2l0aCA2NCBiaXQgaXRlbXMgb24gNCBieXRlIGJvdW5kYXJpZXMNCihh
bmQgMzIgYml0IHZhbHVlcyBvbiAyIGJ5dGUgYm91bmRhcmllcykuDQpUeXBpY2FsbHkgbW9zdCBv
ZiB0aGUgZmllbGRzIGFyZSBzaG9ydGVyIHNvIGNhbiBiZSByZWFkIGRpcmVjdGx5DQooYWx0aG91
Z2ggdGhleSBtaWdodCBuZWVkIGEgYnl0ZS1zd2FwcGluZyBsb2FkKS4NCg0KCURhdmlkDQoNCi0N
ClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBN
aWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxl
cykNCg==

