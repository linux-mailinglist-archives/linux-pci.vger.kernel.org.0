Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F42BB4FBE
	for <lists+linux-pci@lfdr.de>; Tue, 17 Sep 2019 15:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbfIQN4c (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Sep 2019 09:56:32 -0400
Received: from mga01.intel.com ([192.55.52.88]:12998 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725902AbfIQN4B (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Sep 2019 09:56:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Sep 2019 06:56:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,516,1559545200"; 
   d="scan'208";a="186151888"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by fmsmga008.fm.intel.com with ESMTP; 17 Sep 2019 06:56:00 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.204]) by
 ORSMSX106.amr.corp.intel.com ([169.254.1.22]) with mapi id 14.03.0439.000;
 Tue, 17 Sep 2019 06:56:00 -0700
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Busch, Keith" <keith.busch@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>
Subject: Re: [PATCH 2/2] PCI: vmd: Fix shadow offsets to reflect spec changes
Thread-Topic: [PATCH 2/2] PCI: vmd: Fix shadow offsets to reflect spec
 changes
Thread-Index: AQHVbMjFlFehq2RCUUKRkku/dOKnLKcwJJgAgAA2cgA=
Date:   Tue, 17 Sep 2019 13:55:59 +0000
Message-ID: <87f1f92276becb6f83d040b36697ef8084e63105.camel@intel.com>
References: <20190916135435.5017-1-jonathan.derrick@intel.com>
         <20190916135435.5017-3-jonathan.derrick@intel.com>
         <20190917104106.GB32602@e121166-lin.cambridge.arm.com>
In-Reply-To: <20190917104106.GB32602@e121166-lin.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.255.2.79]
Content-Type: text/plain; charset="utf-8"
Content-ID: <1B41BE72A9A3F74288515073D050B4FF@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVHVlLCAyMDE5LTA5LTE3IGF0IDExOjQxICswMTAwLCBMb3JlbnpvIFBpZXJhbGlzaSB3cm90
ZToNCj4gT24gTW9uLCBTZXAgMTYsIDIwMTkgYXQgMDc6NTQ6MzVBTSAtMDYwMCwgSm9uIERlcnJp
Y2sgd3JvdGU6DQo+ID4gVGhlIHNoYWRvdyBvZmZzZXQgc2NyYXRjaHBhZCB3YXMgbW92ZWQgdG8g
MHgyMDAwLTB4MjAxMC4gVXBkYXRlIHRoZQ0KPiA+IGxvY2F0aW9uIHRvIGdldCB0aGUgY29ycmVj
dCBzaGFkb3cgb2Zmc2V0Lg0KPiANCj4gSGkgSm9uLA0KPiANCj4gd2hhdCBkb2VzICJ3YXMgbW92
ZWQiIG1lYW4gPyBXb3VsZCB0aGlzIGNvZGUgc3RpbGwgd29yayBvbiBwcmV2aW91cyBIVyA/DQo+
IA0KVGhlIHByZXZpb3VzIGNvZGUgd29uJ3Qgd29yayBvbiAobm90IHlldCByZWxlYXNlZCkgaHcu
IEd1ZXN0cyB1c2luZyB0aGUNCmRvbWFpbiB3aWxsIHNlZSB0aGUgd3Jvbmcgb2Zmc2V0IGFuZCBl
bnVtZXJhdGUgdGhlIGRvbWFpbiBpbmNvcnJlY3RseS4NCg0KDQo+IFdlIG11c3QgbWFrZSBzdXJl
IHRoYXQgdGhlIGFkZHJlc3MgbW92ZSBpcyBtYW5hZ2VkIHNlYW1sZXNzbHkgYnkgdGhlDQo+IGtl
cm5lbC4NCklmIHdlIG5lZWQgdG8gYXZvaWQgY2hhbmdpbmcgYWRkcmVzc2luZyB3aXRoaW4gc3Rh
YmxlLCB0aGVuIHRoYXQncw0KZmluZS4gQnV0IG90aGVyd2lzZSBpcyB0aGVyZSBhbiBpc3N1ZSBt
ZXJnaW5nIHdpdGggNS40Pw0KDQoNCj4gDQo+IEZvciB0aGUgdGltZSBiZWluZyBJIGhhdmUgdG8g
ZHJvcCB0aGlzIGZpeCBhbmQgaXQgaXMgZXh0cmVtZWx5DQo+IHRpZ2h0IHRvIGdldCBpdCBpbiB2
NS40LCBJIGNhbid0IHNlbmQgc3RhYmxlIGNoYW5nZXMgdGhhdCB3ZSBtYXkNCj4gaGF2ZSB0byBy
ZXZlcnQuDQpBcmVuJ3Qgd2UgaW4gdGhlIGJlZ2lubmluZyBvZiB0aGUgbWVyZ2Ugd2luZG93Pw0K
DQoNCj4gDQo+IFRoYW5rcywNCj4gTG9yZW56bw0KPiANCj4gPiBDYzogc3RhYmxlQHZnZXIua2Vy
bmVsLm9yZyAjIHY1LjIrDQo+ID4gRml4ZXM6IDY3ODg5NThlICgiUENJOiB2bWQ6IEFzc2lnbiBt
ZW1iYXIgYWRkcmVzc2VzIGZyb20gc2hhZG93IHJlZ2lzdGVycyIpDQo+ID4gU2lnbmVkLW9mZi1i
eTogSm9uIERlcnJpY2sgPGpvbmF0aGFuLmRlcnJpY2tAaW50ZWwuY29tPg0KPiA+IC0tLQ0KPiA+
ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL3ZtZC5jIHwgOSArKysrKystLS0NCj4gPiAgMSBmaWxl
IGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci92bWQuYyBiL2RyaXZlcnMvcGNpL2NvbnRy
b2xsZXIvdm1kLmMNCj4gPiBpbmRleCAyZTRkYTNmNTFkNmIuLmEzNWQzZjM5OTZkNyAxMDA2NDQN
Cj4gPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3ZtZC5jDQo+ID4gKysrIGIvZHJpdmVy
cy9wY2kvY29udHJvbGxlci92bWQuYw0KPiA+IEBAIC0zMSw2ICszMSw5IEBADQo+ID4gICNkZWZp
bmUgUENJX1JFR19WTUxPQ0sJCTB4NzANCj4gPiAgI2RlZmluZSBNQjJfU0hBRE9XX0VOKHZtbG9j
aykJKHZtbG9jayAmIDB4MikNCj4gPiAgDQo+ID4gKyNkZWZpbmUgTUIyX1NIQURPV19PRkZTRVQJ
MHgyMDAwDQo+ID4gKyNkZWZpbmUgTUIyX1NIQURPV19TSVpFCQkxNg0KPiA+ICsNCj4gPiAgZW51
bSB2bWRfZmVhdHVyZXMgew0KPiA+ICAJLyoNCj4gPiAgCSAqIERldmljZSBtYXkgY29udGFpbiBy
ZWdpc3RlcnMgd2hpY2ggaGludCB0aGUgcGh5c2ljYWwgbG9jYXRpb24gb2YgdGhlDQo+ID4gQEAg
LTU3OCw3ICs1ODEsNyBAQCBzdGF0aWMgaW50IHZtZF9lbmFibGVfZG9tYWluKHN0cnVjdCB2bWRf
ZGV2ICp2bWQsIHVuc2lnbmVkIGxvbmcgZmVhdHVyZXMpDQo+ID4gIAkJdTMyIHZtbG9jazsNCj4g
PiAgCQlpbnQgcmV0Ow0KPiA+ICANCj4gPiAtCQltZW1iYXIyX29mZnNldCA9IDB4MjAxODsNCj4g
PiArCQltZW1iYXIyX29mZnNldCA9IE1CMl9TSEFET1dfT0ZGU0VUICsgTUIyX1NIQURPV19TSVpF
Ow0KPiA+ICAJCXJldCA9IHBjaV9yZWFkX2NvbmZpZ19kd29yZCh2bWQtPmRldiwgUENJX1JFR19W
TUxPQ0ssICZ2bWxvY2spOw0KPiA+ICAJCWlmIChyZXQgfHwgdm1sb2NrID09IH4wKQ0KPiA+ICAJ
CQlyZXR1cm4gLUVOT0RFVjsNCj4gPiBAQCAtNTkwLDkgKzU5Myw5IEBAIHN0YXRpYyBpbnQgdm1k
X2VuYWJsZV9kb21haW4oc3RydWN0IHZtZF9kZXYgKnZtZCwgdW5zaWduZWQgbG9uZyBmZWF0dXJl
cykNCj4gPiAgCQkJaWYgKCFtZW1iYXIyKQ0KPiA+ICAJCQkJcmV0dXJuIC1FTk9NRU07DQo+ID4g
IAkJCW9mZnNldFswXSA9IHZtZC0+ZGV2LT5yZXNvdXJjZVtWTURfTUVNQkFSMV0uc3RhcnQgLQ0K
PiA+IC0JCQkJCQlyZWFkcShtZW1iYXIyICsgMHgyMDA4KTsNCj4gPiArCQkJCQlyZWFkcShtZW1i
YXIyICsgTUIyX1NIQURPV19PRkZTRVQpOw0KPiA+ICAJCQlvZmZzZXRbMV0gPSB2bWQtPmRldi0+
cmVzb3VyY2VbVk1EX01FTUJBUjJdLnN0YXJ0IC0NCj4gPiAtCQkJCQkJcmVhZHEobWVtYmFyMiAr
IDB4MjAxMCk7DQo+ID4gKwkJCQkJcmVhZHEobWVtYmFyMiArIE1CMl9TSEFET1dfT0ZGU0VUICsg
OCk7DQo+ID4gIAkJCXBjaV9pb3VubWFwKHZtZC0+ZGV2LCBtZW1iYXIyKTsNCj4gPiAgCQl9DQo+
ID4gIAl9DQo+ID4gLS0gDQo+ID4gMi4yMC4xDQo+ID4gDQo=
