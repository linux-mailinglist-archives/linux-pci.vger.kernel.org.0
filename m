Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC6B714ACB8
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2020 00:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbgA0XsD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Jan 2020 18:48:03 -0500
Received: from mga06.intel.com ([134.134.136.31]:26980 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbgA0XsD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Jan 2020 18:48:03 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jan 2020 15:48:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,371,1574150400"; 
   d="scan'208";a="246563775"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by orsmga002.jf.intel.com with ESMTP; 27 Jan 2020 15:48:02 -0800
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.100]) by
 ORSMSX105.amr.corp.intel.com ([169.254.2.174]) with mapi id 14.03.0439.000;
 Mon, 27 Jan 2020 15:48:02 -0800
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
CC:     "Paszkiewicz, Artur" <artur.paszkiewicz@intel.com>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "Fugate, David" <david.fugate@intel.com>,
        "Baldysiak, Pawel" <pawel.baldysiak@intel.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "keith.busch@intel.com" <keith.busch@intel.com>,
        "andrew.murray@arm.com" <andrew.murray@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 2/3] PCI: vmd: Expose VMD details from BIOS
Thread-Topic: [PATCH 2/3] PCI: vmd: Expose VMD details from BIOS
Thread-Index: AQHVhHZYe7i9MHwHgU2a4PswmMHji6d3aeMAgAAGmACABIIDAIABDacAgAC9+wCAgbrPgIAA3KoA
Date:   Mon, 27 Jan 2020 23:48:01 +0000
Message-ID: <0a1d748bc159b0a8c93ed1e52ea031f84fe1dab6.camel@intel.com>
References: <20191101215302.GA217821@google.com>
         <5c4521d26f45cfe01631d14c3d7edc9a10f99245.camel@intel.com>
         <20191104180700.GB26409@e121166-lin.cambridge.arm.com>
         <20191105101208.GA21113@e121166-lin.cambridge.arm.com>
         <5a87add6071259c45522001648b29c9e597ebd69.camel@intel.com>
         <20200127103813.GA25595@e121166-lin.cambridge.arm.com>
In-Reply-To: <20200127103813.GA25595@e121166-lin.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.232.115.22]
Content-Type: text/plain; charset="utf-8"
Content-ID: <9BCAC8D0F4381C439921CE451E1DDF89@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gTW9uLCAyMDIwLTAxLTI3IGF0IDEwOjM4ICswMDAwLCBMb3JlbnpvIFBpZXJhbGlzaSB3cm90
ZToNCj4gT24gVHVlLCBOb3YgMDUsIDIwMTkgYXQgMDk6MzI6MDdQTSArMDAwMCwgRGVycmljaywg
Sm9uYXRoYW4gd3JvdGU6DQo+ID4gT24gVHVlLCAyMDE5LTExLTA1IGF0IDEwOjEyICswMDAwLCBM
b3JlbnpvIFBpZXJhbGlzaSB3cm90ZToNCj4gPiA+IE9uIE1vbiwgTm92IDA0LCAyMDE5IGF0IDA2
OjA3OjAwUE0gKzAwMDAsIExvcmVuem8gUGllcmFsaXNpIHdyb3RlOg0KPiA+ID4gPiBPbiBGcmks
IE5vdiAwMSwgMjAxOSBhdCAxMDoxNjozOVBNICswMDAwLCBEZXJyaWNrLCBKb25hdGhhbiB3cm90
ZToNCj4gPiA+ID4gPiBIaSBCam9ybiwNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBPbiBGcmksIDIw
MTktMTEtMDEgYXQgMTY6NTMgLTA1MDAsIEJqb3JuIEhlbGdhYXMgd3JvdGU6DQo+ID4gPiA+ID4g
PiBbK2NjIEFuZHJld10NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gT24gV2VkLCBPY3QgMTYs
IDIwMTkgYXQgMTE6MDQ6NDdBTSAtMDYwMCwgSm9uIERlcnJpY2sgd3JvdGU6DQo+ID4gPiA+ID4g
PiA+IFdoZW4gc29tZSBWTURzIGFyZSBlbmFibGVkIGFuZCBvdGhlcnMgYXJlIG5vdCwgaXQncyBk
aWZmaWN1bHQgdG8NCj4gPiA+ID4gPiA+ID4gZGV0ZXJtaW5lIHdoaWNoIElJTyBzdGFjayBjb3Jy
ZXNwb25kcyB0byB0aGUgZW5hYmxlZCBWTUQuDQo+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4g
PiBUbyBhc3Npc3QgdXNlcnNwYWNlIHdpdGggbWFuYWdlbWVudCB0YXNrcywgVk1EIEJJT1Mgd2ls
bCB3cml0ZSB0aGUgVk1EDQo+ID4gPiA+ID4gPiA+IGluc3RhbmNlIG51bWJlciBhbmQgc29ja2V0
IG51bWJlciBpbnRvIHRoZSBmaXJzdCBlbmFibGVkIHJvb3QgcG9ydCdzIElPDQo+ID4gPiA+ID4g
PiA+IEJhc2UvTGltaXQgcmVnaXN0ZXJzIHByaW9yIHRvIE9TIGhhbmRvZmYuIFZNRCBkcml2ZXIg
Y2FuIGNhcHR1cmUgdGhpcw0KPiA+ID4gPiA+ID4gPiBpbmZvcm1hdGlvbiBhbmQgZXhwb3NlIGl0
IHRvIHVzZXJzcGFjZS4NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gSG1tbSwgSSdtIG5vdCBz
dXJlIEkgdW5kZXJzdGFuZCB0aGlzLCBidXQgaXQgc291bmRzIHBvc3NpYmx5IGZyYWdpbGUuDQo+
ID4gPiA+ID4gPiBBcmUgdGhlc2UgUm9vdCBQb3J0cyB2aXNpYmxlIHRvIHRoZSBnZW5lcmljIFBD
SSBjb3JlIGRldmljZQ0KPiA+ID4gPiA+ID4gZW51bWVyYXRpb24/ICBJZiBzbywgaXQgd2lsbCBm
aW5kIHRoZW0gYW5kIHJlYWQgdGhlc2UgSS9PIHdpbmRvdw0KPiA+ID4gPiA+ID4gcmVnaXN0ZXJz
LiAgTWF5YmUgdG9kYXkgdGhlIFBDSSBjb3JlIGRvZXNuJ3QgY2hhbmdlIHRoZW0sIGJ1dCBJJ20g
bm90DQo+ID4gPiA+ID4gPiBzdXJlIHdlIHNob3VsZCByZWx5IG9uIHRoZW0gYWx3YXlzIGJlaW5n
IHByZXNlcnZlZCB1bnRpbCB0aGUgdm1kDQo+ID4gPiA+ID4gPiBkcml2ZXIgY2FuIGNsYWltIHRo
ZSBkZXZpY2UuDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBUaGUgUm9vdCBQ
b3J0cyBhcmUgb24gdGhlIFZNRCBQQ0kgZG9tYWluLCBhbmQgdGhpcyBJTyBCQVNFL0xJTUlUDQo+
ID4gPiA+ID4gcGFyc2luZyBvY2N1cnMgYmVmb3JlIHRoaXMgUENJIGRvbWFpbiBpcyBleHBvc2Vk
IHRvIHRoZSBnZW5lcmljIFBDSQ0KPiA+ID4gPiA+IHNjYW5jb2RlIHdpdGggcGNpX3NjYW5fY2hp
bGRfYnVzKCkuIFVudGlsIHRoYXQgcG9pbnQgdGhlIFZNRCBQQ0kgZG9tYWluDQo+ID4gPiA+ID4g
aXMgaW52aXNpYmxlIHRvIHRoZSBrZXJuZWwgb3V0c2lkZSBvZiAvZGV2L21lbSBvciByZXNvdXJj
ZTAuDQo+ID4gPiA+IA0KPiA+ID4gPiBUaGF0J3MgYmVjYXVzZSB0aGUgVk1EIGNvbnRyb2xsZXIg
aXMgYSBQQ0kgZGV2aWNlIGl0c2VsZiBhbmQgaXRzDQo+ID4gPiA+IEJBUnMgdmFsdWVzIGFyZSB1
c2VkIHRvIGNvbmZpZ3VyZSB0aGUgVk1EIGhvc3QgY29udHJvbGxlci4NCj4gPiA+ID4gDQo+ID4g
PiA+IEludGVyZXN0aW5nLg0KPiA+ID4gPiANCj4gPiA+ID4gVG8gYWRkIHRvIEJqb3JuJ3MgcXVl
c3Rpb24sIHRoaXMgcmVhc29uaW5nIGFzc3VtZXMgdGhhdCB3aGF0ZXZlcg0KPiA+ID4gPiBjb2Rl
IGVudW1lcmF0ZXMgdGhlIFBDSSBkZXZpY2UgcmVwcmVzZW50aW5nIHRoZSBWTUQgaG9zdCBjb250
cm9sbGVyDQo+ID4gPiA+IGRvZXMgbm90IG92ZXJ3cml0ZSBpdHMgQkFScyB1cG9uIGJ1cyBlbnVt
ZXJhdGlvbiBvdGhlcndpc2UgdGhlIFZNRA0KPiA+ID4gPiBjb250cm9sbGVyIGNvbmZpZ3VyYXRp
b24gd291bGQgYmUgbG9zdC4gQW0gSSByZWFkaW5nIHRoZSBjdXJyZW50DQo+ID4gPiA+IGNvZGUg
Y29ycmVjdGx5ID8NCj4gPiA+IA0KPiA+ID4gU29ycnksIEkganVzdCB3ZW50IHRocm91Z2ggdGhl
IGNvZGUgYWdhaW4sIEkgdGhpbmsgdGhlIFZNRCBjb250cm9sbGVyDQo+ID4gPiBQQ0kgZGV2aWNl
IEJBUnMgY2FuIGFuZCBhcmUgYWxsb3dlZCB0byBiZSByZWFzc2lnbmVkIGJ5IHRoZSBQQ0kNCj4g
PiA+IGVudW1lcmF0aW9uIGNvZGUgLSBJIG1pc3JlYWQgdGhlIGNvZGUsIHNvIEkgcmFpc2VkIGEg
bm9uLWV4aXN0ZW50IGlzc3VlDQo+ID4gPiBoZXJlLCB0aGV5IGFyZSBsaWtlIGFueSBvdGhlciBQ
Q0kgZGV2aWNlIE1FTS9JTyBCQVJzIGluIHRoaXMgcmVzcGVjdC4NCj4gPiA+IA0KPiA+ID4gTG9y
ZW56bw0KPiA+ID4gDQo+ID4gDQo+ID4gWWVzIHRoZSBWTUQgZW5kcG9pbnQgaXRzZWxmIGV4cG9z
ZXMgdGhlIGRvbWFpbiBjb250YWluaW5nIHRoZSBSb290DQo+ID4gUG9ydHMuIEl0J3MgdGhlIFJv
b3QgUG9ydHMgd2hpY2ggZ2V0IGVudW1lcmF0ZWQgYnkgZ2VuZXJpYyBQQ0kNCj4gPiBzY2FuY29k
ZSwgYW5kIGFsc28gdGhlIFJvb3QgUG9ydCBjb25maWcgc3BhY2Ugd2hlcmUgdGhpcyBkb21haW4g
aW5mbyBpcw0KPiA+IHN1cHBsaWVkLiBXaXRob3V0IGEgVk1EIGRyaXZlciwgdGhlIG9ubHkgYXBl
cnR1cmUgdG8gYWNjZXNzIHRoZSBSb290DQo+ID4gUG9ydCBjb25maWcgc3BhY2UgaXMgTU1JTyB0
aHJvdWdoIHRoZSBWTUQgZW5kcG9pbnQncyAnQ29uZmlnJyBCQVIgKGFrYQ0KPiA+IE1FTUJBUjAp
Lg0KPiA+IA0KPiA+IFdpdGhvdXQgdGhpcyBwYXRjaCwgYSAvZGV2L21lbSwgcmVzb3VyY2UwLCBv
ciB0aGlyZC1wYXJ0eSBkcml2ZXIgY291bGQNCj4gPiBvdmVyd3JpdGUgdGhlc2UgdmFsdWVzIGlm
IHRoZXkgZG9uJ3QgYWxzbyByZXN0b3JlIHRoZW0gb24gY2xvc2UvdW5iaW5kLg0KPiA+IEkgaW1h
Z2luZSBhIGtleGVjIHVzZXIgd291bGQgYWxzbyBvdmVyd3JpdGUgdGhlc2UgdmFsdWVzLg0KPiA+
IA0KPiA+IFRoaXMgaXMgb25lIG9mIHRoZSByZWFzb25zIEkgd2FzIGFsc28gdGhpbmtpbmcgaXQg
Y291bGQgbGl2ZSBpbiBkZXZpY2UNCj4gPiBzcGVjaWZpYyByZXNldCBjb2RlIGFzIGxvbmcgYXMg
aXQgY2FuIGNhbGwgaW50byBWTUQgZm9yIHRoZSBzcGVjaWZpY3MuDQo+ID4gTWFueSBrZXJuZWwg
dmVuZG9ycyBhbHJlYWR5IHNoaXAgd2l0aCBWTUQ9eSwgc28gSSBhbSB0ZW1wdGVkIHRvIHNpbXBs
eQ0KPiA+IG1ha2UgdGhhdCBwZXJtYW5lbnQgYW5kIGV4cG9ydCBhIHJlc2V0IGNhbGwgdG8gYSBk
ZXYgc3BlY2lmaWMgcmVzZXQgaW4NCj4gPiBxdWlya3MuYy4NCj4gDQo+IEhpIEpvbiwNCj4gDQo+
IGp1c3Qgd2FudGVkIHRvIGFzayB5b3Ugd2hhdCdzIHRoZSBwbGFuIHdpdGggdGhpcyBzZXJpZXMu
DQo+IA0KPiBUaGFua3MsDQo+IExvcmVuem8NCg0KDQoNClBsZWFzZSBkcm9wLiBXZSd2ZSBpbXBs
ZW1lbnRlZCBhIGRpZmZlcmVudCBzb2x1dGlvbi4NCg0KVGhhbmtzIGFnYWluLA0KSm9uDQo=
