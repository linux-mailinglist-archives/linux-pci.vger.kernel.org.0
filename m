Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C993720A6B5
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jun 2020 22:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405890AbgFYUVN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Jun 2020 16:21:13 -0400
Received: from mga14.intel.com ([192.55.52.115]:33236 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405161AbgFYUVN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 Jun 2020 16:21:13 -0400
IronPort-SDR: DMyh8nfoKC4b54W3Aahi+AKZAUE/G962KNz2rkHqvmEQCCeQ5h57KuXJUxxCqRpcYAeFh04yml
 ACdqsLrKe6nw==
X-IronPort-AV: E=McAfee;i="6000,8403,9663"; a="144144191"
X-IronPort-AV: E=Sophos;i="5.75,280,1589266800"; 
   d="scan'208";a="144144191"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2020 13:21:11 -0700
IronPort-SDR: /p4fEMETlNVXbhXQEfRb7XUwBC+d5by5n8OrKI1PBWIQg+69HOgr6fksbjRoVl7amesRiFKgOY
 +9UaYXlx4eHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,280,1589266800"; 
   d="scan'208";a="279932657"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
  by orsmga006.jf.intel.com with ESMTP; 25 Jun 2020 13:21:11 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.209]) by
 ORSMSX108.amr.corp.intel.com ([169.254.2.56]) with mapi id 14.03.0439.000;
 Thu, 25 Jun 2020 13:21:10 -0700
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "helgaas@kernel.org" <helgaas@kernel.org>
CC:     "Kalakota, SushmaX" <sushmax.kalakota@intel.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] PCI: vmd: Keep fwnode allocated through VMD irqdomain
 life
Thread-Topic: [PATCH] PCI: vmd: Keep fwnode allocated through VMD irqdomain
 life
Thread-Index: AQHWSw+RDEde7kWBZ0WSf8C7+Aw2bqjqNSwAgAAGIQA=
Date:   Thu, 25 Jun 2020 20:21:10 +0000
Message-ID: <1ff5050b83e009fa3a7be4fad0509472d8644941.camel@intel.com>
References: <20200625195820.GA2701690@bjorn-Precision-5520>
In-Reply-To: <20200625195820.GA2701690@bjorn-Precision-5520>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.134.79.251]
Content-Type: text/plain; charset="utf-8"
Content-ID: <E5CCC44B025233409BF3EE013FECEE62@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVGh1LCAyMDIwLTA2LTI1IGF0IDE0OjU4IC0wNTAwLCBCam9ybiBIZWxnYWFzIHdyb3RlOg0K
PiBbK2NjIFRob21hc10NCj4gDQo+IE9uIFRodSwgSnVuIDI1LCAyMDIwIGF0IDEyOjI0OjQ5UE0g
LTA0MDAsIEpvbiBEZXJyaWNrIHdyb3RlOg0KPiA+IEZyb206IEFuZHkgU2hldmNoZW5rbyA8YW5k
cml5LnNoZXZjaGVua29AbGludXguaW50ZWwuY29tPg0KPiA+IA0KPiA+IFRoZSBWTUQgZG9tYWlu
IGRvZXMgbm90IHN1YnNjcmliZSB0byBBQ1BJLCBhbmQgc28gZG9lcyBub3Qgb3BlcmF0ZSBvbg0K
PiA+IGl0J3MgaXJxZG9tYWluIGZ3bm9kZS4gSXQgd2FzIGZyZWVpbmcgdGhlIGhhbmRsZSBhZnRl
ciBhbGxvY2F0aW9uIG9mIHRoZQ0KPiA+IGRvbWFpbi4gQXMgb2YgMTgxZTlkNGVmYWY2YSAoaXJx
ZG9tYWluOiBNYWtlIF9faXJxX2RvbWFpbl9hZGQoKSBsZXNzDQo+ID4gT0YtZGVwZW5kZW50KSwg
dGhlIGZ3bm9kZSBpcyBwdXQgZHVyaW5nIGlycV9kb21haW5fcmVtb3ZlIGNhdXNpbmcgYSBwYWdl
DQo+ID4gZmF1bHQuIFRoaXMgcGF0Y2gga2VlcHMgVk1EJ3MgZndub2RlIGFsbG9jYXRlZCB0aHJv
dWdoIHRoZSBsaWZldGltZSBvZg0KPiA+IHRoZSBWTUQgaXJxZG9tYWluLg0KPiA+IA0KPiA+IEZp
eGVzOiBhZTkwNGNhZmQ1OWQgKCJQQ0kvdm1kOiBDcmVhdGUgbmFtZWQgaXJxIGRvbWFpbiIpDQo+
ID4gU2lnbmVkLW9mZi1ieTogQW5keSBTaGV2Y2hlbmtvIDxhbmRyaXkuc2hldmNoZW5rb0BsaW51
eC5pbnRlbC5jb20+DQo+ID4gQ28tZGV2ZWxvcGVkLWJ5OiBBbmR5IFNoZXZjaGVua28gPGFuZHJp
eS5zaGV2Y2hlbmtvQGxpbnV4LmludGVsLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBKb24gRGVy
cmljayA8am9uYXRoYW4uZGVycmlja0BpbnRlbC5jb20+DQo+ID4gLS0tDQo+ID4gSGkgTG9yZW56
bywgQmpvcm4sDQo+ID4gDQo+ID4gUGxlYXNlIHRha2UgdGhpcyBwYXRjaCBmb3IgdjUuOCBmaXhl
cy4gSXQgZml4ZXMgYW4gaXNzdWUgZHVyaW5nIFZNRA0KPiA+IHVubG9hZC4NCj4gDQo+IEkgdGVu
dGF0aXZlbHkgYXBwbGllZCB0aGlzIHRvIGZvci1saW51cyBmb3IgdjUuOC4NCj4gDQo+IEJ1dCBJ
IHdvdWxkIGxpa2UgdG8gY2xhcmlmeSB0aGUgY29tbWl0IGxvZy4gIEl0IHNheXMgdGhpcyBmaXhl
cw0KPiBUaG9tYXMnIGFlOTA0Y2FmZDU5ZCAoIlBDSS92bWQ6IENyZWF0ZSBuYW1lZCBpcnEgZG9t
YWluIikuICBUaGF0DQo+IGFwcGVhcmVkIGluIHY0LjEzLCB3aGljaCBzdWdnZXN0cyB0aGF0IHRo
aXMgcGF0Y2ggc2hvdWxkIGJlIGJhY2twb3J0ZWQNCj4gdG8gdjQuMTMgYW5kIGxhdGVyLg0KPiAN
Cj4gQnV0IGl0J3Mgbm90IGNsZWFyIHRvIG1lIHRoYXQgYWU5MDRjYWZkNTlkIGlzIGFjdHVhbGx5
IGJyb2tlbiwgc2luY2UNCj4gdGhlIGxvZyBhbHNvIHNheXMgdGhlIHByb2JsZW0gYXBwZWFyZWQg
YWZ0ZXIgMTgxZTlkNGVmYWY2ICgiaXJxZG9tYWluOg0KPiBNYWtlIF9faXJxX2RvbWFpbl9hZGQo
KSBsZXNzIE9GLWRlcGVuZGVudCIpLCB3aGljaCB3ZSBqdXN0IG1lcmdlZCBmb3INCj4gdjUuOC1y
YzEuDQo+IA0KPiBBbmQgb2J2aW91c2x5LCBmcmVlaW5nIHRoZSBmd25vZGUgZG9lc24ndCAqY2F1
c2UqIGEgcGFnZSBmYXVsdC4gIEENCj4gdXNlLWFmdGVyLWZyZWUgbWlnaHQgY2F1c2UgYSBmYXVs
dCwgYnV0IGl0J3Mgbm90IGNsZWFyIHdoZXJlIHRoYXQNCj4gaGFwcGVucy4gIEkgZ3Vlc3MgZndu
b2RlIGlzIHVzZWQgaW4gdGhlIGludGVydmFsIGJldHdlZW46DQo+IA0KPiAgIHZtZF9lbmFibGVf
ZG9tYWluDQo+ICAgICBwY2lfbXNpX2NyZWF0ZV9pcnFfZG9tYWluDQo+IA0KPiAgIC4uLiAgICAg
ICAgPC0tIGZ3bm9kZSB1c2VkIGhlcmUgc29tZXdoZXJlDQo+IA0KPiAgIHZtZF9yZW1vdmUNCj4g
ICAgIHZtZF9jbGVhbnVwX3NyY3UNCj4gICAgICAgaXJxX2RvbWFpbl9mcmVlX2Z3bm9kZQ0KPiAN
Cj4gQnV0IEkgY2FuJ3QgdGVsbCBob3cgMTgxZTlkNGVmYWY2YSBhbmQvb3IgYWU5MDRjYWZkNTlk
IGFyZSByZWxhdGVkIHRvDQo+IHRoYXQuDQoNClRoZSBhY3R1YWwgaXNzdWUgaXMgdGhhdCBkb21h
aW4tPmZ3bm9kZSB3YXMgZnJlZWQgKGFuZCBub3Qgc2V0IE5VTEwpLA0KbGVhZGluZyB0byBwYWdl
IGZhdWx0IGhlcmU6DQp2b2lkIGlycV9kb21haW5fcmVtb3ZlKHN0cnVjdCBpcnFfZG9tYWluICpk
b21haW4pDQp7DQouLi4NCiAgICAgICAgZndub2RlX2hhbmRsZV9wdXQoZG9tYWluLT5md25vZGUp
Ow0KDQpCdXQgaXQncyBub3Qgb2J2aW91cyB0byBtZSB0aGF0IFZNRCBoYXMgYSByZWFzb24gdG8g
ZnJlZSBmd25vZGUgaWYNCnRoZXJlJ3Mgb3RoZXIgZGVwcyB0aGF0IHJlbHkgb24gaXQgZXhpc3Rp
bmcNCg0KPiANCj4gPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci92bWQuYyB8IDggKysrKysrLS0N
Cj4gPiAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4g
PiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci92bWQuYyBiL2RyaXZl
cnMvcGNpL2NvbnRyb2xsZXIvdm1kLmMNCj4gPiBpbmRleCBlMzg2ZDRlYWM0MDcuLmViZWMwYTZl
NzdlZCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3ZtZC5jDQo+ID4g
KysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci92bWQuYw0KPiA+IEBAIC01NDYsOSArNTQ2LDEw
IEBAIHN0YXRpYyBpbnQgdm1kX2VuYWJsZV9kb21haW4oc3RydWN0IHZtZF9kZXYgKnZtZCwgdW5z
aWduZWQgbG9uZyBmZWF0dXJlcykNCj4gPiAgDQo+ID4gIAl2bWQtPmlycV9kb21haW4gPSBwY2lf
bXNpX2NyZWF0ZV9pcnFfZG9tYWluKGZuLCAmdm1kX21zaV9kb21haW5faW5mbywNCj4gPiAgCQkJ
CQkJICAgIHg4Nl92ZWN0b3JfZG9tYWluKTsNCj4gPiAtCWlycV9kb21haW5fZnJlZV9md25vZGUo
Zm4pOw0KPiA+IC0JaWYgKCF2bWQtPmlycV9kb21haW4pDQo+ID4gKwlpZiAoIXZtZC0+aXJxX2Rv
bWFpbikgew0KPiA+ICsJCWlycV9kb21haW5fZnJlZV9md25vZGUoZm4pOw0KPiA+ICAJCXJldHVy
biAtRU5PREVWOw0KPiA+ICsJfQ0KPiA+ICANCj4gPiAgCXBjaV9hZGRfcmVzb3VyY2UoJnJlc291
cmNlcywgJnZtZC0+cmVzb3VyY2VzWzBdKTsNCj4gPiAgCXBjaV9hZGRfcmVzb3VyY2Vfb2Zmc2V0
KCZyZXNvdXJjZXMsICZ2bWQtPnJlc291cmNlc1sxXSwgb2Zmc2V0WzBdKTsNCj4gPiBAQCAtNTU5
LDYgKzU2MCw3IEBAIHN0YXRpYyBpbnQgdm1kX2VuYWJsZV9kb21haW4oc3RydWN0IHZtZF9kZXYg
KnZtZCwgdW5zaWduZWQgbG9uZyBmZWF0dXJlcykNCj4gPiAgCWlmICghdm1kLT5idXMpIHsNCj4g
PiAgCQlwY2lfZnJlZV9yZXNvdXJjZV9saXN0KCZyZXNvdXJjZXMpOw0KPiA+ICAJCWlycV9kb21h
aW5fcmVtb3ZlKHZtZC0+aXJxX2RvbWFpbik7DQo+ID4gKwkJaXJxX2RvbWFpbl9mcmVlX2Z3bm9k
ZShmbik7DQo+ID4gIAkJcmV0dXJuIC1FTk9ERVY7DQo+ID4gIAl9DQo+ID4gIA0KPiA+IEBAIC02
NzIsNiArNjc0LDcgQEAgc3RhdGljIHZvaWQgdm1kX2NsZWFudXBfc3JjdShzdHJ1Y3Qgdm1kX2Rl
diAqdm1kKQ0KPiA+ICBzdGF0aWMgdm9pZCB2bWRfcmVtb3ZlKHN0cnVjdCBwY2lfZGV2ICpkZXYp
DQo+ID4gIHsNCj4gPiAgCXN0cnVjdCB2bWRfZGV2ICp2bWQgPSBwY2lfZ2V0X2RydmRhdGEoZGV2
KTsNCj4gPiArCXN0cnVjdCBmd25vZGVfaGFuZGxlICpmbiA9IHZtZC0+aXJxX2RvbWFpbi0+Zndu
b2RlOw0KPiA+ICANCj4gPiAgCXN5c2ZzX3JlbW92ZV9saW5rKCZ2bWQtPmRldi0+ZGV2LmtvYmos
ICJkb21haW4iKTsNCj4gPiAgCXBjaV9zdG9wX3Jvb3RfYnVzKHZtZC0+YnVzKTsNCj4gPiBAQCAt
Njc5LDYgKzY4Miw3IEBAIHN0YXRpYyB2b2lkIHZtZF9yZW1vdmUoc3RydWN0IHBjaV9kZXYgKmRl
dikNCj4gPiAgCXZtZF9jbGVhbnVwX3NyY3Uodm1kKTsNCj4gPiAgCXZtZF9kZXRhY2hfcmVzb3Vy
Y2VzKHZtZCk7DQo+ID4gIAlpcnFfZG9tYWluX3JlbW92ZSh2bWQtPmlycV9kb21haW4pOw0KPiA+
ICsJaXJxX2RvbWFpbl9mcmVlX2Z3bm9kZShmbik7DQo+ID4gIH0NCj4gPiAgDQo+ID4gICNpZmRl
ZiBDT05GSUdfUE1fU0xFRVANCj4gPiAtLSANCj4gPiAyLjE4LjENCj4gPiANCg==
