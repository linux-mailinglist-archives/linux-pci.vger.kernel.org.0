Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B60734E2EC
	for <lists+linux-pci@lfdr.de>; Tue, 30 Mar 2021 10:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbhC3IPI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Mar 2021 04:15:08 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:42129 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231508AbhC3IOn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Mar 2021 04:14:43 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-29-HPU7qmWKMOSJ9xQqljUORg-1; Tue, 30 Mar 2021 09:14:38 +0100
X-MC-Unique: HPU7qmWKMOSJ9xQqljUORg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Tue, 30 Mar 2021 09:14:37 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.012; Tue, 30 Mar 2021 09:14:37 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Zhang Rui' <rui.zhang@intel.com>,
        Xiaofei Tan <tanxiaofei@huawei.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>
Subject: RE: [PATCH v2 04/15] ACPI: table: replace __attribute__((packed)) by
 __packed
Thread-Topic: [PATCH v2 04/15] ACPI: table: replace __attribute__((packed)) by
 __packed
Thread-Index: AQHXJTqteusKxfb1K0qiX/864DlgraqcLa0g
Date:   Tue, 30 Mar 2021 08:14:37 +0000
Message-ID: <6df8e01e2e9e4906be5ceaea72c61c0f@AcuMS.aculab.com>
References: <1616831193-17920-1-git-send-email-tanxiaofei@huawei.com>
         <1616831193-17920-5-git-send-email-tanxiaofei@huawei.com>
         <6df04be78e544e17b3b57f159312541f@AcuMS.aculab.com>
         <34dd3de8-644d-6e44-965a-0991b7027cae@huawei.com>
         <b5ad5909f3fb14b46d6ff0f81c10e42507a60c74.camel@intel.com>
 <af3fd5adb62dcac93f2ff4ea7b6aff74d0106ac5.camel@intel.com>
In-Reply-To: <af3fd5adb62dcac93f2ff4ea7b6aff74d0106ac5.camel@intel.com>
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

RnJvbTogWmhhbmcgUnVpDQo+IFNlbnQ6IDMwIE1hcmNoIDIwMjEgMDk6MDANCj4gVG86IFhpYW9m
ZWkgVGFuIDx0YW54aWFvZmVpQGh1YXdlaS5jb20+OyBEYXZpZCBMYWlnaHQgPERhdmlkLkxhaWdo
dEBBQ1VMQUIuQ09NPjsgcmp3QHJqd3lzb2NraS5uZXQ7DQo+IGxlbmJAa2VybmVsLm9yZzsgYmhl
bGdhYXNAZ29vZ2xlLmNvbQ0KPiBDYzogbGludXgtYWNwaUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxp
bnV4YXJtQG9wZW5ldWxlci5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAwNC8xNV0gQUNQ
STogdGFibGU6IHJlcGxhY2UgX19hdHRyaWJ1dGVfXygocGFja2VkKSkgYnkgX19wYWNrZWQNCj4g
DQo+IE9uIFR1ZSwgMjAyMS0wMy0zMCBhdCAxNTozMSArMDgwMCwgWmhhbmcgUnVpIHdyb3RlOg0K
PiA+IE9uIFR1ZSwgMjAyMS0wMy0zMCBhdCAxMDoyMyArMDgwMCwgWGlhb2ZlaSBUYW4gd3JvdGU6
DQo+ID4gPiBIaSBEYXZpZCwNCj4gPiA+DQo+ID4gPiBPbiAyMDIxLzMvMjkgMTg6MDksIERhdmlk
IExhaWdodCB3cm90ZToNCj4gPiA+ID4gRnJvbTogWGlhb2ZlaSBUYW4NCj4gPiA+ID4gPiBTZW50
OiAyNyBNYXJjaCAyMDIxIDA3OjQ2DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBSZXBsYWNlIF9fYXR0
cmlidXRlX18oKHBhY2tlZCkpIGJ5IF9fcGFja2VkIGZvbGxvd2luZyB0aGUNCj4gPiA+ID4gPiBh
ZHZpY2Ugb2YgY2hlY2twYXRjaC5wbC4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFNpZ25lZC1vZmYt
Ynk6IFhpYW9mZWkgVGFuIDx0YW54aWFvZmVpQGh1YXdlaS5jb20+DQo+ID4gPiA+ID4gLS0tDQo+
ID4gPiA+ID4gIGRyaXZlcnMvYWNwaS9hY3BpX2ZwZHQuYyB8IDYgKysrLS0tDQo+ID4gPiA+ID4g
IDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+ID4gPiA+
ID4NCj4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9hY3BpL2FjcGlfZnBkdC5jDQo+ID4g
PiA+ID4gYi9kcml2ZXJzL2FjcGkvYWNwaV9mcGR0LmMNCj4gPiA+ID4gPiBpbmRleCBhODlhODA2
Li42OTBhODhhIDEwMDY0NA0KPiA+ID4gPiA+IC0tLSBhL2RyaXZlcnMvYWNwaS9hY3BpX2ZwZHQu
Yw0KPiA+ID4gPiA+ICsrKyBiL2RyaXZlcnMvYWNwaS9hY3BpX2ZwZHQuYw0KPiA+ID4gPiA+IEBA
IC01Myw3ICs1Myw3IEBAIHN0cnVjdCByZXN1bWVfcGVyZm9ybWFuY2VfcmVjb3JkIHsNCj4gPiA+
ID4gPiAgCXUzMiByZXN1bWVfY291bnQ7DQo+ID4gPiA+ID4gIAl1NjQgcmVzdW1lX3ByZXY7DQo+
ID4gPiA+ID4gIAl1NjQgcmVzdW1lX2F2ZzsNCj4gPiA+ID4gPiAtfSBfX2F0dHJpYnV0ZV9fKChw
YWNrZWQpKTsNCj4gPiA+ID4gPiArfSBfX3BhY2tlZDsNCj4gPiA+ID4gPg0KPiA+ID4gPiA+ICBz
dHJ1Y3QgYm9vdF9wZXJmb3JtYW5jZV9yZWNvcmQgew0KPiA+ID4gPiA+ICAJc3RydWN0IGZwZHRf
cmVjb3JkX2hlYWRlciBoZWFkZXI7DQo+ID4gPiA+ID4gQEAgLTYzLDEzICs2MywxMyBAQCBzdHJ1
Y3QgYm9vdF9wZXJmb3JtYW5jZV9yZWNvcmQgew0KPiA+ID4gPiA+ICAJdTY0IGJvb3Rsb2FkZXJf
bGF1bmNoOw0KPiA+ID4gPiA+ICAJdTY0IGV4aXRib290c2VydmljZV9zdGFydDsNCj4gPiA+ID4g
PiAgCXU2NCBleGl0Ym9vdHNlcnZpY2VfZW5kOw0KPiA+ID4gPiA+IC19IF9fYXR0cmlidXRlX18o
KHBhY2tlZCkpOw0KPiA+ID4gPiA+ICt9IF9fcGFja2VkOw0KPiA+ID4gPiA+DQo+ID4gPiA+ID4g
IHN0cnVjdCBzdXNwZW5kX3BlcmZvcm1hbmNlX3JlY29yZCB7DQo+ID4gPiA+ID4gIAlzdHJ1Y3Qg
ZnBkdF9yZWNvcmRfaGVhZGVyIGhlYWRlcjsNCj4gPiA+ID4gPiAgCXU2NCBzdXNwZW5kX3N0YXJ0
Ow0KPiA+ID4gPiA+ICAJdTY0IHN1c3BlbmRfZW5kOw0KPiA+ID4gPiA+IC19IF9fYXR0cmlidXRl
X18oKHBhY2tlZCkpOw0KPiA+ID4gPiA+ICt9IF9fcGFja2VkOw0KPiA+ID4gPg0KPiA+ID4gPiBN
eSBzdGFuZGFyZCBxdWVzdGlvbiBhYm91dCAncGFja2VkJyBpcyB3aGV0aGVyIGl0IGlzIGFjdHVh
bGx5DQo+ID4gPiA+IG5lZWRlZC4NCj4gPiA+ID4gSXQgc2hvdWxkIG9ubHkgYmUgdXNlZCBpZiB0
aGUgc3RydWN0dXJlcyBtaWdodCBiZSBtaXNhbGlnbmVkIGluDQo+ID4gPiA+IG1lbW9yeS4NCj4g
PiA+ID4gSWYgdGhlIG9ubHkgcHJvYmxlbSBpcyB0aGF0IGEgNjRiaXQgaXRlbSBuZWVkcyB0byBi
ZSAzMmJpdA0KPiA+ID4gPiBhbGlnbmVkDQo+ID4gPiA+IHRoZW4gYSBzdWl0YWJsZSB0eXBlIHNo
b3VsZCBiZSB1c2VkIGZvciB0aG9zZSBzcGVjaWZpYyBmaWVsZHMuDQo+ID4gPiA+DQo+ID4gPiA+
IFRob3NlIGFsbCBsb29rIHZlcnkgZHViaW91cyAtIHRoZSBzdGFuZGFyZCBoZWFkZXIgaXNuJ3Qg
cGFja2VkDQo+ID4gPiA+IHNvIGV2ZXJ5dGhpbmcgbXVzdCBlYiBhc3N1bWVkIHRvIGJlIGF0IGxl
YXN0IDMyYml0IGFsaWduZWQuDQo+ID4gPiA+DQo+ID4gPiA+IFRoZXJlIGFyZSBhbHNvIG90aGVy
IHN1Yi1zdHJ1Y3R1cmVzIHRoYXQgY29udGFpbiA2NGJpdCB2YWx1ZXMuDQo+ID4gPiA+IFRoZXNl
IGRvbid0IGNvbnRhaW4gcGFkZGluZyAtIGJ1dCB0aGF0IHJlcXVpcmVzIDY0Yml0IGFsaWduZW1l
bnQuDQo+ID4gPiA+DQo+ID4gPiA+IFRoZSBvbmx5IHByb2JsZW1hdGljIHN0cnVjdHVyZSBpcyB0
aGUgbGFzdCBvbmUgLSB3aGljaCB3b3VsZCBoYXZlDQo+ID4gPiA+IGEgMzJiaXQgcGFkIGFmdGVy
IHRoZSBoZWFkZXIuDQo+ID4gPiA+IElzIHRoaXMgZXZlbiByaWdodCBnaXZlbiB0aGFuIHRoZXJl
IGFyZSBleHBsaWNpdCBhbGlnbm1lbnQgcGFkcw0KPiA+ID4gPiBpbiBzb21lIG9mIHRoZSBvdGhl
ciBzdHJ1Y3R1cmVzLg0KPiA+ID4gPg0KPiA+ID4gPiBJZiA2NGJpdCBhbGlnbm1lbnQgaXNuJ3Qg
Z3VhcmFudGVlZCB0aGVuIGEgJzY0Yml0IGFsaWduZWQgdG8NCj4gPiA+ID4gMzJiaXQnDQo+ID4g
PiA+IHR5cGUgc2hvdWxkIGJlIHVzZWQgZm9yIHRoZSB1NjQgZmllbGRzLg0KPiA+ID4gPg0KPiA+
ID4NCj4gPiA+IFllcywgc29tZSBvZiB0aGVtIGhhcyBiZWVuIGFsaWduZWQgYWxyZWFkeSwgdGhl
biBub3RoaW5nIGNoYW5nZWQNCj4gPiA+IHdoZW4NCj4gPiA+IGFkZCB0aGlzICJwYWNrZWQgIi4g
TWF5YmUgdGhlIHB1cnBvc2Ugb2YgdGhlIG9yaWdpbmFsIGF1dGhvciBpcw0KPiA+ID4gZm9yDQo+
ID4gPiBleHRlbnNpb24sIGFuZCBjYW4gdGVsbCBvdGhlcnMgdGhhdCB0aGlzIHN0cnVjdCBuZWVk
IGJlIHBhY2tlZC4NCj4gPiA+DQo+ID4NCj4gPiBUaGUgcGF0Y2ggaXMgdXBzdHJlYW1lZCByZWNl
bnRseSBidXQgaXQgd2FzIG1hZGUgbG9uZyB0aW1lIGFnby4NCj4gPiBJIHRoaW5rIHRoZSBvcmln
aW5hbCBwcm9ibGVtIGlzIHRoYXQgb25lIG9mIHRoZSBhZGRyZXNzLCBwcm9iYWJseSB0aGUNCj4g
PiBzdXNwZW5kX3BlcmZvcm1hbmNlIHJlY29yZCwgaXMgbm90IDY0Yml0IGFsaWduZWQsIHRodXMg
d2UgY2FuIG5vdA0KPiA+IHJlYWQNCj4gPiB0aGUgcHJvcGVyIGNvbnRlbnQgb2Ygc3VzcGVuZF9z
dGFydCBhbmQgc3VzcGVuZF9lbmQsIG1hcHBlZCBmcm9tDQo+ID4gcGh5c2ljYWwgbWVtb3J5Lg0K
PiA+DQo+ID4gSSB3aWxsIHRyeSB0byBmaW5kIGEgbWFjaGluZSB0byByZXByb2R1Y2UgdGhlIHBy
b2JsZW0gd2l0aCBhbGwNCj4gPiBfX2F0dHJpYnV0ZV9fKChwYWNrZWQpKSByZW1vdmVkIHRvIGRv
dWJsZSBjb25maXJtIHRoaXMuDQo+ID4NCj4gDQo+IFNvIGhlcmUgaXMgdGhlIHByb2JsZW0sIHdp
dGhvdXQgX19hdHRyaWJ1dGVfXygocGFja2VkKSkNCj4gDQo+IFsgICAgMC44NTg0NDJdIHN1c3Bl
bmRfcmVjb3JkOiAweGZmZmZhYWQ1MDAxNzUwMjANCj4gL3N5cy9maXJtd2FyZS9hY3BpL2ZwZHQv
c3VzcGVuZC9zdXNwZW5kX2VuZF9uczphZGRyOg0KPiAweGZmZmZhYWQ1MDAxNzUwMzAsIDE1OTk4
MTc5MjkyNjU5ODQzMDcyDQo+IC9zeXMvZmlybXdhcmUvYWNwaS9mcGR0L3N1c3BlbmQvc3VzcGVu
ZF9zdGFydF9uczphZGRyOg0KPiAweGZmZmZhYWQ1MDAxNzUwMjgsIDANCj4gDQo+IHN1c3BlbmRf
cmVjb3JkIGlzIG1hcHBlZCB0byAweGZmZmZhYWQ1MDAxNzUwMjAsIGFuZCBpdCBpcyBjb21iaW5l
ZCB3aXRoDQo+IG9uZSAzMmJpdCBoZWFkZXIgYW5kIHR3byA2NGJpdCBmaWVsZHMgKHN1c3BlbmRf
c3RhcnQgYW5kIHN1c3BlbmRfZW5kKSwNCj4gdGhpcyBpcyBob3cgaXQgaXMgbG9jYXRlZCBpbiBw
aHlzaWNhbCBtZW1vcnkuDQo+IFNvIHRoZSBhZGRyZXNzZXMgb2YgdGhlIHR3byA2NGJpdCBmaWVs
ZHMgYXJlIGFjdHVhbGx5IG5vdCA2NGJpdA0KPiBhbGlnbmVkLg0KPiANCj4gRGF2aWQsDQo+IElz
IHRoaXMgdGhlICJhIDY0Yml0IGl0ZW0gbmVlZHMgdG8gYmUgMzJiaXQgYWxpZ25lZCIgcHJvYmxl
bSB5b3UNCj4gcmVmZXJyZWQ/DQo+IElmIHllcywgd2hhdCBpcyB0aGUgcHJvcGVyIGZpeD8gc2hv
dWxkIEkgdXNlZCB0d28gMzJiaXRzIGZvciBlYWNoIG9mDQo+IHRoZSBmaWVsZCBpbnN0ZWFkPw0K
DQpEZWZpbmUgc29tZXRoaW5nIGxpa2U6DQp0eXBlZGVmIHU2NCBfX2F0dHJpYnV0ZV9fKChhbGln
bmVkKDQpKSkgdTY0X2FsaWduMzI7DQphbmQgdGhlbiB1c2UgaXQgZm9yIHRoZSA2NGJpdCBzdHJ1
Y3R1cmUgbWVtYmVycy4NCg0KVGhlcmUgZG9lc24ndCBzZWVtIHRvIGJlIGEgc3RhbmRhcmQgdHlw
ZSBuYW1lIGZvciBpdCAtIGFsdGhvdWdoDQppdCBpcyB1c2VkIGluIHNldmVyYWwgcGxhY2VzLg0K
DQpJJ20gbm90IGVudGlyZWx5IHN1cmUgYnV0IGlzIEFDUEkgYWx3YXlzIExFPw0KKGlzIGl0IGV2
ZW4geDg2IG9ubHk/PykNCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lk
ZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0K
UmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

