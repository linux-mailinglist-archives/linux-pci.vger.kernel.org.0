Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4D8B50AB
	for <lists+linux-pci@lfdr.de>; Tue, 17 Sep 2019 16:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbfIQOpG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Sep 2019 10:45:06 -0400
Received: from mga18.intel.com ([134.134.136.126]:59808 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728187AbfIQOpG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Sep 2019 10:45:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Sep 2019 07:45:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,516,1559545200"; 
   d="scan'208";a="201845550"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
  by fmsmga001.fm.intel.com with ESMTP; 17 Sep 2019 07:45:04 -0700
Received: from orsmsx113.amr.corp.intel.com (10.22.240.9) by
 ORSMSX109.amr.corp.intel.com (10.22.240.7) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 17 Sep 2019 07:45:04 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.204]) by
 ORSMSX113.amr.corp.intel.com ([169.254.9.232]) with mapi id 14.03.0439.000;
 Tue, 17 Sep 2019 07:45:04 -0700
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Busch, Keith" <keith.busch@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>
Subject: Re: [PATCH 2/2] PCI: vmd: Fix shadow offsets to reflect spec changes
Thread-Topic: [PATCH 2/2] PCI: vmd: Fix shadow offsets to reflect spec
 changes
Thread-Index: AQHVbMjFlFehq2RCUUKRkku/dOKnLKcwJJgAgAA2cgCAAAKugIAACwgA
Date:   Tue, 17 Sep 2019 14:45:03 +0000
Message-ID: <087e23dc3bb7b94bb96c33b380732ebd1285e467.camel@intel.com>
References: <20190916135435.5017-1-jonathan.derrick@intel.com>
         <20190916135435.5017-3-jonathan.derrick@intel.com>
         <20190917104106.GB32602@e121166-lin.cambridge.arm.com>
         <87f1f92276becb6f83d040b36697ef8084e63105.camel@intel.com>
         <20190917140525.GA6377@e121166-lin.cambridge.arm.com>
In-Reply-To: <20190917140525.GA6377@e121166-lin.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.255.2.79]
Content-Type: text/plain; charset="utf-8"
Content-ID: <2694499191B9CC43AF03218690A31295@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVHVlLCAyMDE5LTA5LTE3IGF0IDE1OjA1ICswMTAwLCBMb3JlbnpvIFBpZXJhbGlzaSB3cm90
ZToNCj4gT24gVHVlLCBTZXAgMTcsIDIwMTkgYXQgMDE6NTU6NTlQTSArMDAwMCwgRGVycmljaywg
Sm9uYXRoYW4gd3JvdGU6DQo+ID4gT24gVHVlLCAyMDE5LTA5LTE3IGF0IDExOjQxICswMTAwLCBM
b3JlbnpvIFBpZXJhbGlzaSB3cm90ZToNCj4gPiA+IE9uIE1vbiwgU2VwIDE2LCAyMDE5IGF0IDA3
OjU0OjM1QU0gLTA2MDAsIEpvbiBEZXJyaWNrIHdyb3RlOg0KPiA+ID4gPiBUaGUgc2hhZG93IG9m
ZnNldCBzY3JhdGNocGFkIHdhcyBtb3ZlZCB0byAweDIwMDAtMHgyMDEwLiBVcGRhdGUgdGhlDQo+
ID4gPiA+IGxvY2F0aW9uIHRvIGdldCB0aGUgY29ycmVjdCBzaGFkb3cgb2Zmc2V0Lg0KPiA+ID4g
DQo+ID4gPiBIaSBKb24sDQo+ID4gPiANCj4gPiA+IHdoYXQgZG9lcyAid2FzIG1vdmVkIiBtZWFu
ID8gV291bGQgdGhpcyBjb2RlIHN0aWxsIHdvcmsgb24gcHJldmlvdXMgSFcgPw0KPiA+ID4gDQo+
ID4gVGhlIHByZXZpb3VzIGNvZGUgd29uJ3Qgd29yayBvbiAobm90IHlldCByZWxlYXNlZCkgaHcu
IEd1ZXN0cyB1c2luZyB0aGUNCj4gPiBkb21haW4gd2lsbCBzZWUgdGhlIHdyb25nIG9mZnNldCBh
bmQgZW51bWVyYXRlIHRoZSBkb21haW4gaW5jb3JyZWN0bHkuDQo+IA0KPiBUaGF0J3MgdHJ1ZSBh
bHNvIGZvciBuZXcga2VybmVscyBvbiBfY3VycmVudF8gaGFyZHdhcmUsIGlzbid0IGl0ID8NCj4g
DQo+IFdoYXQgSSBhbSBzYXlpbmcgaXMgdGhhdCB0aGVyZSBtdXN0IGJlIGEgd2F5IHRvIGRldGVj
dCB0aGUgcmlnaHQNCj4gb2Zmc2V0IGZyb20gSFcgcHJvYmluZyBvciBmaXJtd2FyZSBvdGhlcndp
c2UgdGhpbmdzIHdpbGwgYnJlYWsNCj4gb25lIHdheSBvZiBhbm90aGVyLg0KPiANCkkgdGhpbmsg
dGhpcyBpcyBiYXNpY2FsbHkgdGhhdCwgYnV0IHRoZSBzcGVjIGNoYW5nZWQgd2hpY2ggcmVnaXN0
ZXINCmFkZHJlc3NlcyBjb250YWluZWQgdGhlIG9mZnNldC4gVGhlIG9mZnNldCB3YXMgc3RpbGwg
ZGlzY292ZXJhYmxlDQplaXRoZXIgd2F5LCBidXQgaXMgbm93IHdpdGhpbiAweDIwMDAtMHgyMDEw
LCB3aXRoIDB4MjAxMC0weDIwOTAgYXMgb29iDQppbnRlcmZhY2UuDQoNCg0KDQo+ID4gPiBXZSBt
dXN0IG1ha2Ugc3VyZSB0aGF0IHRoZSBhZGRyZXNzIG1vdmUgaXMgbWFuYWdlZCBzZWFtbGVzc2x5
IGJ5IHRoZQ0KPiA+ID4ga2VybmVsLg0KPiA+IElmIHdlIG5lZWQgdG8gYXZvaWQgY2hhbmdpbmcg
YWRkcmVzc2luZyB3aXRoaW4gc3RhYmxlLCB0aGVuIHRoYXQncw0KPiA+IGZpbmUuIEJ1dCBvdGhl
cndpc2UgaXMgdGhlcmUgYW4gaXNzdWUgbWVyZ2luZyB3aXRoIDUuND8NCj4gDQo+IFNlZSBhYm92
ZS4gV291bGQgNS40IHdpdGggdGhpcyBwYXRjaCBhcHBsaWVkIHdvcmsgb24gc3lzdGVtcyB3aGVy
ZQ0KPiB0aGUgb2Zmc2V0IGlzIHRoZSBzYW1lIGFzIHRoZSBfY3VycmVudF8gb25lIHdpdGhvdXQg
dGhpcyBwYXRjaA0KPiBhcHBsaWVkID8NCkkgdW5kZXJzdGFuZCB5b3VyIGNvbmNlcm4sIGJ1dCB0
aGVzZSBzeXN0ZW1zIHdpdGggd3JvbmcgYWRkcmVzc2luZw0Kd29uJ3QgZXhpc3QgYmVjYXVzZSB0
aGUgaGFyZHdhcmUgaXNuJ3QgcmVsZWFzZWQgeWV0Lg0KDQpJbiB0aGUgZnV0dXJlLCB0aGUgaGFy
ZHdhcmUgd2lsbCBiZSByZWxlYXNlZCBhbmQgdXNlcnMgd2lsbCBpbmV2aXRhYmx5DQpsb2FkIHNv
bWUgdW5maXhlZCBrZXJuZWwsIGFuZCB3ZSB3b3VsZCBsaWtlIHRvIHBvaW50IHRvIHN0YWJsZSBm
b3IgdGhlDQpmaXguDQoNCg0KDQo+IA0KPiA+ID4gRm9yIHRoZSB0aW1lIGJlaW5nIEkgaGF2ZSB0
byBkcm9wIHRoaXMgZml4IGFuZCBpdCBpcyBleHRyZW1lbHkNCj4gPiA+IHRpZ2h0IHRvIGdldCBp
dCBpbiB2NS40LCBJIGNhbid0IHNlbmQgc3RhYmxlIGNoYW5nZXMgdGhhdCB3ZSBtYXkNCj4gPiA+
IGhhdmUgdG8gcmV2ZXJ0Lg0KPiA+IEFyZW4ndCB3ZSBpbiB0aGUgYmVnaW5uaW5nIG9mIHRoZSBt
ZXJnZSB3aW5kb3c/DQo+IA0KPiBZZXMgYW5kIHRoYXQncyB0aGUgcHJvYmxlbSwgcGF0Y2hlcyBm
b3IgdjUuNCBzaG91bGQgaGF2ZSBhbHJlYWR5DQo+IGJlaW5nIHF1ZXVlZCBhIHdoaWxlIGFnbywg
SSBkbyBub3Qga25vdyB3aGVuIEJqb3JuIHdpbGwgc2VuZCB0aGUNCj4gUFIgZm9yIHY1LjQgYnV0
IHRoYXQncyBnb2luZyB0byBoYXBwZW4gc2hvcnRseSwgSSBhbSBtYWtpbmcgYW4NCj4gZXhjZXB0
aW9uIHRvIHNxdWVlemUgdGhlc2UgcGF0Y2hlcyBpbiBzaW5jZSBpdCBpcyB2bWQgb25seSBjb2Rl
DQo+IGJ1dCBzdGlsbCBpdCBpcyB2ZXJ5IHZlcnkgdGlnaHQuDQo+IA0KSWYgeW91IGZlZWwgdGhl
cmUncyBhIHJpc2ssIHRoZW4gSSB0aGluayBpdCBjYW4gYmUgc3RhZ2VkIGZvciB2NS41Lg0KSGFy
ZHdhcmUgd2lsbCBub3QgYmUgYXZhaWxhYmxlIGZvciBzb21lIHRpbWUuDQoNCg0KDQpCZXN0IHJl
Z2FyZHMsDQpKb24NCg0KDQo+IFRoYW5rcywNCj4gTG9yZW56bw0KPiANCj4gPiA+IFRoYW5rcywN
Cj4gPiA+IExvcmVuem8NCj4gPiA+IA0KPiA+ID4gPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9y
ZyAjIHY1LjIrDQo+ID4gPiA+IEZpeGVzOiA2Nzg4OTU4ZSAoIlBDSTogdm1kOiBBc3NpZ24gbWVt
YmFyIGFkZHJlc3NlcyBmcm9tIHNoYWRvdyByZWdpc3RlcnMiKQ0KPiA+ID4gPiBTaWduZWQtb2Zm
LWJ5OiBKb24gRGVycmljayA8am9uYXRoYW4uZGVycmlja0BpbnRlbC5jb20+DQo+ID4gPiA+IC0t
LQ0KPiA+ID4gPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci92bWQuYyB8IDkgKysrKysrLS0tDQo+
ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0K
PiA+ID4gPiANCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvdm1k
LmMgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3ZtZC5jDQo+ID4gPiA+IGluZGV4IDJlNGRhM2Y1
MWQ2Yi4uYTM1ZDNmMzk5NmQ3IDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250
cm9sbGVyL3ZtZC5jDQo+ID4gPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvdm1kLmMN
Cj4gPiA+ID4gQEAgLTMxLDYgKzMxLDkgQEANCj4gPiA+ID4gICNkZWZpbmUgUENJX1JFR19WTUxP
Q0sJCTB4NzANCj4gPiA+ID4gICNkZWZpbmUgTUIyX1NIQURPV19FTih2bWxvY2spCSh2bWxvY2sg
JiAweDIpDQo+ID4gPiA+ICANCj4gPiA+ID4gKyNkZWZpbmUgTUIyX1NIQURPV19PRkZTRVQJMHgy
MDAwDQo+ID4gPiA+ICsjZGVmaW5lIE1CMl9TSEFET1dfU0laRQkJMTYNCj4gPiA+ID4gKw0KPiA+
ID4gPiAgZW51bSB2bWRfZmVhdHVyZXMgew0KPiA+ID4gPiAgCS8qDQo+ID4gPiA+ICAJICogRGV2
aWNlIG1heSBjb250YWluIHJlZ2lzdGVycyB3aGljaCBoaW50IHRoZSBwaHlzaWNhbCBsb2NhdGlv
biBvZiB0aGUNCj4gPiA+ID4gQEAgLTU3OCw3ICs1ODEsNyBAQCBzdGF0aWMgaW50IHZtZF9lbmFi
bGVfZG9tYWluKHN0cnVjdCB2bWRfZGV2ICp2bWQsIHVuc2lnbmVkIGxvbmcgZmVhdHVyZXMpDQo+
ID4gPiA+ICAJCXUzMiB2bWxvY2s7DQo+ID4gPiA+ICAJCWludCByZXQ7DQo+ID4gPiA+ICANCj4g
PiA+ID4gLQkJbWVtYmFyMl9vZmZzZXQgPSAweDIwMTg7DQo+ID4gPiA+ICsJCW1lbWJhcjJfb2Zm
c2V0ID0gTUIyX1NIQURPV19PRkZTRVQgKyBNQjJfU0hBRE9XX1NJWkU7DQo+ID4gPiA+ICAJCXJl
dCA9IHBjaV9yZWFkX2NvbmZpZ19kd29yZCh2bWQtPmRldiwgUENJX1JFR19WTUxPQ0ssICZ2bWxv
Y2spOw0KPiA+ID4gPiAgCQlpZiAocmV0IHx8IHZtbG9jayA9PSB+MCkNCj4gPiA+ID4gIAkJCXJl
dHVybiAtRU5PREVWOw0KPiA+ID4gPiBAQCAtNTkwLDkgKzU5Myw5IEBAIHN0YXRpYyBpbnQgdm1k
X2VuYWJsZV9kb21haW4oc3RydWN0IHZtZF9kZXYgKnZtZCwgdW5zaWduZWQgbG9uZyBmZWF0dXJl
cykNCj4gPiA+ID4gIAkJCWlmICghbWVtYmFyMikNCj4gPiA+ID4gIAkJCQlyZXR1cm4gLUVOT01F
TTsNCj4gPiA+ID4gIAkJCW9mZnNldFswXSA9IHZtZC0+ZGV2LT5yZXNvdXJjZVtWTURfTUVNQkFS
MV0uc3RhcnQgLQ0KPiA+ID4gPiAtCQkJCQkJcmVhZHEobWVtYmFyMiArIDB4MjAwOCk7DQo+ID4g
PiA+ICsJCQkJCXJlYWRxKG1lbWJhcjIgKyBNQjJfU0hBRE9XX09GRlNFVCk7DQo+ID4gPiA+ICAJ
CQlvZmZzZXRbMV0gPSB2bWQtPmRldi0+cmVzb3VyY2VbVk1EX01FTUJBUjJdLnN0YXJ0IC0NCj4g
PiA+ID4gLQkJCQkJCXJlYWRxKG1lbWJhcjIgKyAweDIwMTApOw0KPiA+ID4gPiArCQkJCQlyZWFk
cShtZW1iYXIyICsgTUIyX1NIQURPV19PRkZTRVQgKyA4KTsNCj4gPiA+ID4gIAkJCXBjaV9pb3Vu
bWFwKHZtZC0+ZGV2LCBtZW1iYXIyKTsNCj4gPiA+ID4gIAkJfQ0KPiA+ID4gPiAgCX0NCj4gPiA+
ID4gLS0gDQo+ID4gPiA+IDIuMjAuMQ0KPiA+ID4gPiANCg==
