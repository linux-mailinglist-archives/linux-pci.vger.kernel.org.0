Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C89CC373E60
	for <lists+linux-pci@lfdr.de>; Wed,  5 May 2021 17:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbhEEPVM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 May 2021 11:21:12 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:54097 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233034AbhEEPVM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 May 2021 11:21:12 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-178-BQ8_e9FxPlmU9ZviEyU3mQ-1; Wed, 05 May 2021 16:20:12 +0100
X-MC-Unique: BQ8_e9FxPlmU9ZviEyU3mQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Wed, 5 May 2021 16:20:11 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.015; Wed, 5 May 2021 16:20:11 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     =?utf-8?B?J1BhbGkgUm9ow6FyJw==?= <pali@kernel.org>,
        Lukas Wunner <lukas@wunner.de>
CC:     Greg KH <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>
Subject: RE: xhci_pci & PCIe hotplug crash
Thread-Topic: xhci_pci & PCIe hotplug crash
Thread-Index: AQHXQa7y6ld2lnJxqUeg15sWnzByEKrU/keg
Date:   Wed, 5 May 2021 15:20:11 +0000
Message-ID: <ea58430d088742a1910475a680fb1de5@AcuMS.aculab.com>
References: <20210505120117.4wpmo6fhvzznf3wv@pali>
 <YJKK7SDIaeH1L/fC@kroah.com> <20210505123346.kxfpumww5i4qmhnk@pali>
 <20210505124402.GB29101@wunner.de> <20210505130240.lmryb26xffzkg4pl@pali>
In-Reply-To: <20210505130240.lmryb26xffzkg4pl@pali>
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

RnJvbTogUGFsaSBSb2jDoXINCj4gU2VudDogMDUgTWF5IDIwMjEgMTQ6MDMNCi4uLg0KPiBJIGFs
cmVhZHkgZmlndXJlZCBvdXQgdGhhdCBDUFUgcmVjZWl2ZSBleHRlcm5hbCBhYm9ydCBhbHNvIHdo
ZW4gdHJ5aW5nDQo+IHRvIGlzc3VlIGEgbmV3IFBJTyB0cmFuc2ZlciBmb3IgYWNjZXNzaW5nIFBD
SSBjb25maWcgc3BhY2Ugd2hpbGUNCj4gcHJldmlvdXMgdHJhbnNmZXIgaGFzIG5vdCBmaW5pc2hl
ZCB5ZXQuIEFuZCBhbHNvIHRoZXJlIGlzIG5vIHdheSAoYXQNCj4gbGVhc3QgaW4gZG9jdW1lbnRh
dGlvbikgd2hpY2ggYWxsb3dzIHRvICJtYXNrIiB0aGlzIGV4dGVybmFsIGFib3J0LiBCdXQNCj4g
dGhpcyBpc3N1ZSBjYW4gYmUgZml4ZWQgaW4gcGNpLWFhcmR2YXJrLmMgZHJpdmVyIHRvIGRpc2Fs
bG93IGFjY2VzcyB0bw0KPiBjb25maWcgc3BhY2Ugd2hpbGUgcHJldmlvdXMgdHJhbnNmZXIgaXMg
c3RpbGwgcnVubmluZyAoSSB3aWxsIHNlbmQgcGF0Y2gNCj4gZm9yIHRoaXMgb25lKS4NCg0KTXkg
dGhlIHNvdW5kIG9mIHRoZSBhYm92ZSB5b3UgbmVlZCB0byBwdXQgYSBnbG9iYWwgc3BpbmxvY2sg
YXJvdW5kDQphbGwgUENJZSBjb25maWcgc3BhY2UgYWNjZXNzZXMuDQoNCklzIHRoaXMgdGhlIGhv
cnJpZCBoYXJkd2FyZSB0aGF0IGNhbid0IGRvIGEgJ25vcm1hbCcgUENJZSB0cmFuc2Zlcg0Kd2hp
bGUgYSBjb25maWcgc3BhY2UgYWNjZXNzIGlzIGluIHByb2dyZXNzPw0KSWYgdGhhdCBpdCB0cnVl
IHRoZW4geW91IGhhdmUgYmlnZ2VyIHByb2JsZW1zLg0KRXNwZWNpYWxseSBpZiBpdCBpcyBhbiBT
TVAgc3lzdGVtLg0KDQo+IFNvIHNlZW1zIHRoYXQgUENJZSBjb250cm9sbGVyIEhXIHRyaWdnZXJz
IHRoZXNlIGV4dGVybmFsIGFib3J0cyB3aGVuDQo+IGRldmljZSBvbiBQQ0llIGJ1cyBpcyBub3Qg
YWNjZXNzaWJsZSBhbnltb3JlLg0KPiANCj4gSWYgdGhpcyBpc3N1ZSBpcyByZWFsbHkgY2F1c2Vk
IGJ5IE1NSU8gYWNjZXNzIGZyb20geGhjaSBkcml2ZXIgd2hlbg0KPiBkZXZpY2UgaXMgbm90IGFj
Y2Vzc2libGUgb24gdGhlIGJ1cyBhbnltb3JlLCBjYW4gd2UgZG8gc29tZXRoaW5nIHRvDQo+IHBy
ZXZlbnQgdGhpcyBrZXJuZWwgY3Jhc2g/IFNvbWVob3cgbWFzayB0aGF0IGV4dGVybmFsIGFib3J0
IGluIGtlcm5lbA0KPiBmb3IgYSB0aW1lIGR1cmluZyBNTUlPIGFjY2Vzcz8NCg0KSWYgaXQgaXMg
YSBjeWNsZSBhYm9ydCB0aGVuIHRoZSBpbnRlcnJ1cHRlZCBhZGRyZXNzIGlzIHByb2JhYmx5DQp0
aGF0IG9mIHRoZSBNTUlPIGluc3RydWN0aW9uLg0KU28geW91IG5lZWQgdG8gY2F0Y2ggdGhlIGFi
b3J0LCBlbXVsYXRlIHRoZSBpbnN0cnVjdGlvbiBhbmQNCnRoZW4gcmV0dXJuIHRvIHRoZSBuZXh0
IG9uZS4NCg0KVGhpcyBwcm9iYWJseSByZXF1aXJlcyBhbiBleGNlcHRpb24gdGFibGUgY29udGFp
bmluZyB0aGUgYWRkcmVzcw0Kb2YgZXZlcnkgcmVhZGIvdy9sKCkgaW5zdHJ1Y3Rpb24uDQoNCklm
IHlvdSBnZXQgYSBzaW1pbGFyIGVycm9yIG9uIHdyaXRlcyBpdCBpcyBsaWtlbHkgdG8gYmUgYSBm
ZXcNCmluc3RydWN0aW9ucyBhZnRlciB0aGUgYWN0dWFsIHdyaXRlYi93L2woKSBpbnN0cnVjdGlv
bi4NCldyaXRlIGFyZSBub3JtYWxseSAncG9zdGVkJyBhbmQgYXN5bmNocm9ub3VzLg0KDQpJZiB5
b3UgYXJlIHJlYWxseSBsdWNreSB5b3UgY2FuIGdldCBlbm91Z2ggc3RhdGUgb3V0IG9mIHRoZQ0K
YWJvcnQgaGFuZGxlciB0byBmaXh1cC9pZ25vcmUgdGhlIGN5Y2xlIHdpdGhvdXQgYW4NCmV4Y2Vw
dGlvbiB0YWJsZS4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwg
QnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVn
aXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

