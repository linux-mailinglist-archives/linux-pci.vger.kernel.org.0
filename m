Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4996B51CE
	for <lists+linux-pci@lfdr.de>; Tue, 17 Sep 2019 17:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729800AbfIQPvm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Sep 2019 11:51:42 -0400
Received: from mga07.intel.com ([134.134.136.100]:64580 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729780AbfIQPvl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Sep 2019 11:51:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Sep 2019 08:51:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,517,1559545200"; 
   d="scan'208";a="180815306"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by orsmga008.jf.intel.com with ESMTP; 17 Sep 2019 08:51:40 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.204]) by
 ORSMSX104.amr.corp.intel.com ([169.254.4.204]) with mapi id 14.03.0439.000;
 Tue, 17 Sep 2019 08:51:39 -0700
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Busch, Keith" <keith.busch@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>
Subject: Re: [PATCH 2/2] PCI: vmd: Fix shadow offsets to reflect spec changes
Thread-Topic: [PATCH 2/2] PCI: vmd: Fix shadow offsets to reflect spec
 changes
Thread-Index: AQHVbMjFlFehq2RCUUKRkku/dOKnLKcwJJgAgAA2cgCAAAKugIAACwgAgAAIeoCAAAohAA==
Date:   Tue, 17 Sep 2019 15:51:39 +0000
Message-ID: <ec24dc3d6f6f962a9f96ab1bab8c9cf4e138d61a.camel@intel.com>
References: <20190916135435.5017-1-jonathan.derrick@intel.com>
         <20190916135435.5017-3-jonathan.derrick@intel.com>
         <20190917104106.GB32602@e121166-lin.cambridge.arm.com>
         <87f1f92276becb6f83d040b36697ef8084e63105.camel@intel.com>
         <20190917140525.GA6377@e121166-lin.cambridge.arm.com>
         <087e23dc3bb7b94bb96c33b380732ebd1285e467.camel@intel.com>
         <20190917151523.GA7948@e121166-lin.cambridge.arm.com>
In-Reply-To: <20190917151523.GA7948@e121166-lin.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.255.2.79]
Content-Type: text/plain; charset="utf-8"
Content-ID: <9B67814C91AC654BBCE50CD5362AD5A5@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVHVlLCAyMDE5LTA5LTE3IGF0IDE2OjE1ICswMTAwLCBMb3JlbnpvIFBpZXJhbGlzaSB3cm90
ZToNCj4gT24gVHVlLCBTZXAgMTcsIDIwMTkgYXQgMDI6NDU6MDNQTSArMDAwMCwgRGVycmljaywg
Sm9uYXRoYW4gd3JvdGU6DQo+ID4gT24gVHVlLCAyMDE5LTA5LTE3IGF0IDE1OjA1ICswMTAwLCBM
b3JlbnpvIFBpZXJhbGlzaSB3cm90ZToNCj4gPiA+IE9uIFR1ZSwgU2VwIDE3LCAyMDE5IGF0IDAx
OjU1OjU5UE0gKzAwMDAsIERlcnJpY2ssIEpvbmF0aGFuIHdyb3RlOg0KPiA+ID4gPiBPbiBUdWUs
IDIwMTktMDktMTcgYXQgMTE6NDEgKzAxMDAsIExvcmVuem8gUGllcmFsaXNpIHdyb3RlOg0KPiA+
ID4gPiA+IE9uIE1vbiwgU2VwIDE2LCAyMDE5IGF0IDA3OjU0OjM1QU0gLTA2MDAsIEpvbiBEZXJy
aWNrIHdyb3RlOg0KPiA+ID4gPiA+ID4gVGhlIHNoYWRvdyBvZmZzZXQgc2NyYXRjaHBhZCB3YXMg
bW92ZWQgdG8gMHgyMDAwLTB4MjAxMC4gVXBkYXRlIHRoZQ0KPiA+ID4gPiA+ID4gbG9jYXRpb24g
dG8gZ2V0IHRoZSBjb3JyZWN0IHNoYWRvdyBvZmZzZXQuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4g
SGkgSm9uLA0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IHdoYXQgZG9lcyAid2FzIG1vdmVkIiBtZWFu
ID8gV291bGQgdGhpcyBjb2RlIHN0aWxsIHdvcmsgb24gcHJldmlvdXMgSFcgPw0KPiA+ID4gPiA+
IA0KPiA+ID4gPiBUaGUgcHJldmlvdXMgY29kZSB3b24ndCB3b3JrIG9uIChub3QgeWV0IHJlbGVh
c2VkKSBody4gR3Vlc3RzIHVzaW5nIHRoZQ0KPiA+ID4gPiBkb21haW4gd2lsbCBzZWUgdGhlIHdy
b25nIG9mZnNldCBhbmQgZW51bWVyYXRlIHRoZSBkb21haW4gaW5jb3JyZWN0bHkuDQo+ID4gPiAN
Cj4gPiA+IFRoYXQncyB0cnVlIGFsc28gZm9yIG5ldyBrZXJuZWxzIG9uIF9jdXJyZW50XyBoYXJk
d2FyZSwgaXNuJ3QgaXQgPw0KPiA+ID4gDQo+ID4gPiBXaGF0IEkgYW0gc2F5aW5nIGlzIHRoYXQg
dGhlcmUgbXVzdCBiZSBhIHdheSB0byBkZXRlY3QgdGhlIHJpZ2h0DQo+ID4gPiBvZmZzZXQgZnJv
bSBIVyBwcm9iaW5nIG9yIGZpcm13YXJlIG90aGVyd2lzZSB0aGluZ3Mgd2lsbCBicmVhaw0KPiA+
ID4gb25lIHdheSBvZiBhbm90aGVyLg0KPiA+ID4gDQo+ID4gSSB0aGluayB0aGlzIGlzIGJhc2lj
YWxseSB0aGF0LCBidXQgdGhlIHNwZWMgY2hhbmdlZCB3aGljaCByZWdpc3Rlcg0KPiA+IGFkZHJl
c3NlcyBjb250YWluZWQgdGhlIG9mZnNldC4gVGhlIG9mZnNldCB3YXMgc3RpbGwgZGlzY292ZXJh
YmxlDQo+ID4gZWl0aGVyIHdheSwgYnV0IGlzIG5vdyB3aXRoaW4gMHgyMDAwLTB4MjAxMCwgd2l0
aCAweDIwMTAtMHgyMDkwIGFzIG9vYg0KPiA+IGludGVyZmFjZS4NCj4gPiANCj4gPiANCj4gPiAN
Cj4gPiA+ID4gPiBXZSBtdXN0IG1ha2Ugc3VyZSB0aGF0IHRoZSBhZGRyZXNzIG1vdmUgaXMgbWFu
YWdlZCBzZWFtbGVzc2x5IGJ5IHRoZQ0KPiA+ID4gPiA+IGtlcm5lbC4NCj4gPiA+ID4gSWYgd2Ug
bmVlZCB0byBhdm9pZCBjaGFuZ2luZyBhZGRyZXNzaW5nIHdpdGhpbiBzdGFibGUsIHRoZW4gdGhh
dCdzDQo+ID4gPiA+IGZpbmUuIEJ1dCBvdGhlcndpc2UgaXMgdGhlcmUgYW4gaXNzdWUgbWVyZ2lu
ZyB3aXRoIDUuND8NCj4gPiA+IA0KPiA+ID4gU2VlIGFib3ZlLiBXb3VsZCA1LjQgd2l0aCB0aGlz
IHBhdGNoIGFwcGxpZWQgd29yayBvbiBzeXN0ZW1zIHdoZXJlDQo+ID4gPiB0aGUgb2Zmc2V0IGlz
IHRoZSBzYW1lIGFzIHRoZSBfY3VycmVudF8gb25lIHdpdGhvdXQgdGhpcyBwYXRjaA0KPiA+ID4g
YXBwbGllZCA/DQo+ID4gSSB1bmRlcnN0YW5kIHlvdXIgY29uY2VybiwgYnV0IHRoZXNlIHN5c3Rl
bXMgd2l0aCB3cm9uZyBhZGRyZXNzaW5nDQo+ID4gd29uJ3QgZXhpc3QgYmVjYXVzZSB0aGUgaGFy
ZHdhcmUgaXNuJ3QgcmVsZWFzZWQgeWV0Lg0KPiA+IA0KPiA+IEluIHRoZSBmdXR1cmUsIHRoZSBo
YXJkd2FyZSB3aWxsIGJlIHJlbGVhc2VkIGFuZCB1c2VycyB3aWxsIGluZXZpdGFibHkNCj4gPiBs
b2FkIHNvbWUgdW5maXhlZCBrZXJuZWwsIGFuZCB3ZSB3b3VsZCBsaWtlIHRvIHBvaW50IHRvIHN0
YWJsZSBmb3IgdGhlDQo+ID4gZml4Lg0KPiANCj4gSSBhbSBzb3JyeSBmb3IgYmVpbmcgYmx1bnQg
YnV0IEkgbmVlZCB0byB1bmRlcnN0YW5kLiBJZiB3ZSBhcHBseQ0KPiB0aGlzIHBhdGNoLCBhcmUg
eW91IHRlbGxpbmcgbWUgdGhhdCB0aGUgX2N1cnJlbnRfIEhXIHdvdWxkIGZhaWwgPw0KPiANCj4g
SSBhc3N1bWUgdGhlIGN1cnJlbnQgSFcra2VybmVsIHNldC11cCBpcyB3b3JraW5nLCBtYXliZSB0
aGF0J3MNCj4gd2hhdCBJIGdvdCB3cm9uZy4NCj4gDQo+IFJld29yZGVkOiBvbiBleGlzdGluZyBI
VywgaXMgdGhpcyBwYXRjaCBmaXhpbmcgYW55dGhpbmcgPw0KPiANCj4gVGhpcyBwYXRjaCB3aGVu
IGl0IGhpdHMgdGhlIG1haW5saW5lIHdpbGwgdHJpY2tsZSBpbnRvIHN0YWJsZQ0KPiBrZXJuZWwg
dW5jaGFuZ2VkLg0KU29ycnkgZm9yIHRoZSBjb25mdXNpb24uDQoNClRoZXNlIGNoYW5nZXMgb25s
eSBhZmZlY3Qgc3lzdGVtcyB3aXRoIFZNRCBkZXZpY2VzIHdpdGggODA4NjoyOEMwDQpkZXZpY2Ug
SURzLCBidXQgdGhlc2Ugd29uJ3QgYmUgcHJvZHVjdGlvbiBoYXJkd2FyZSBmb3Igc29tZSB0aW1l
Lg0KDQpTeXN0ZW1zIHdpdGggVk1EIGRldmljZXMgZXhpc3QgaW4gdGhlIHdpbGQgd2l0aCA4MDg2
OjIwMUQgZGV2aWNlIElEcy4NClRoZXNlIGRvbid0IHN1cHBvcnQgdGhlIGd1ZXN0IHBhc3N0aHJv
dWdoIG1vZGUgYW5kIHRoaXMgY29kZSB3b24ndA0KYnJlYWsgYW55dGhpbmcgd2l0aCB0aGVtLiBB
ZGRpdGlvbmFsbHksIHBhdGNoIDEvMiAoYnVzIG51bWJlcmluZykgb25seQ0KYWZmZWN0cyA4MDg2
OjI4QzAuDQoNClNvIG9uIGV4aXN0aW5nIEhXLCB0aGVzZSBwYXRjaGVzIHdvbid0IGFmZmVjdCBh
bnl0aGluZw0KDQoNCg0KPiANCj4gPiA+ID4gPiBGb3IgdGhlIHRpbWUgYmVpbmcgSSBoYXZlIHRv
IGRyb3AgdGhpcyBmaXggYW5kIGl0IGlzIGV4dHJlbWVseQ0KPiA+ID4gPiA+IHRpZ2h0IHRvIGdl
dCBpdCBpbiB2NS40LCBJIGNhbid0IHNlbmQgc3RhYmxlIGNoYW5nZXMgdGhhdCB3ZSBtYXkNCj4g
PiA+ID4gPiBoYXZlIHRvIHJldmVydC4NCj4gPiA+ID4gQXJlbid0IHdlIGluIHRoZSBiZWdpbm5p
bmcgb2YgdGhlIG1lcmdlIHdpbmRvdz8NCj4gPiA+IA0KPiA+ID4gWWVzIGFuZCB0aGF0J3MgdGhl
IHByb2JsZW0sIHBhdGNoZXMgZm9yIHY1LjQgc2hvdWxkIGhhdmUgYWxyZWFkeQ0KPiA+ID4gYmVp
bmcgcXVldWVkIGEgd2hpbGUgYWdvLCBJIGRvIG5vdCBrbm93IHdoZW4gQmpvcm4gd2lsbCBzZW5k
IHRoZQ0KPiA+ID4gUFIgZm9yIHY1LjQgYnV0IHRoYXQncyBnb2luZyB0byBoYXBwZW4gc2hvcnRs
eSwgSSBhbSBtYWtpbmcgYW4NCj4gPiA+IGV4Y2VwdGlvbiB0byBzcXVlZXplIHRoZXNlIHBhdGNo
ZXMgaW4gc2luY2UgaXQgaXMgdm1kIG9ubHkgY29kZQ0KPiA+ID4gYnV0IHN0aWxsIGl0IGlzIHZl
cnkgdmVyeSB0aWdodC4NCj4gPiA+IA0KPiA+IElmIHlvdSBmZWVsIHRoZXJlJ3MgYSByaXNrLCB0
aGVuIEkgdGhpbmsgaXQgY2FuIGJlIHN0YWdlZCBmb3IgdjUuNS4NCj4gPiBIYXJkd2FyZSB3aWxs
IG5vdCBiZSBhdmFpbGFibGUgZm9yIHNvbWUgdGltZS4NCj4gDQo+IEkgZG8gbm90IGZlZWwgaXQg
aXMgcmlza3ksIEkgZmVlbCBpdCB3b3VsZCBiZSBtdWNoIGJldHRlciBpZiB0aGUNCj4gc2NyYXRj
aHBhZCBhZGRyZXNzIGNvdWxkIGJlIGRldGVjdGVkIGF0IHJ1bnRpbWUgdGhyb3VnaCB2ZXJzaW9u
aW5nDQo+IG9mIHNvcnRzIGVpdGhlciBIVyBvciBmaXJtd2FyZSBiYXNlZC4NCj4gDQo+IElmIHdl
IGNhbid0IHByb2JlIGl0IGluZXZpdGFibHkgd2Ugd2lsbCBoYXZlIHN5c3RlbXMgd2hlcmUga2Vy
bmVscw0KPiB3b3VsZCBicmVhayBhbmQgdGhhdCdzIHNvbWV0aGluZyB3ZSBzaG91bGQgYXZvaWQu
DQo+IA0KSSBhZ3JlZSB0aGF0IGl0IG1pZ2h0IGhhdmUgYmVlbiBuaWNlciBpZiBpdCB3ZXJlIGFu
IEFDUEkvRUZJIHZhciwgYnV0IEkNCnRoaW5rIHRoZXJlIHdlcmUgc29tZSBjb21wbGV4aXRpZXMg
d2l0aCB0ZWFjaGluZyBoeXBlcnZpc29ycyB0byBleHBvc2UNCml0IHRvIHRoZSBndWVzdHMgZm9y
IHVzZSB3aGVuIGVudW1lcmF0aW5nIHRoZSBkb21haW4gZnJvbSB0aGUgcGFzc2VkLQ0KdGhyb3Vn
aCBlbmRwb2ludC4gVGhlIG1ldGhvZCB0aGF0IGV4aXN0cyBpbiA4MDg2OjI4QzAgaGFyZHdhcmUg
ZGl2b3JjZXMNCnRoZSBmaXJtd2FyZSBkZXNjcmlwdG9ycyBmcm9tIHRoZSBkZXZpY2Ugc28gdGhh
dCB0aGUgZ3Vlc3QgZHJpdmVyIG9ubHkNCm5lZWRzIHRvIHJlYWQgdGhlIGhvc3QtdG8tZ3Vlc3Qg
cGh5c2ljYWwgb2Zmc2V0IGZyb20gdGhlIGRldmljZSBpdHNlbGYuDQoNCg0KQmVzdCByZWdhcmRz
LA0KSm9uDQoNCg0KPiBMb3JlbnpvDQo=
