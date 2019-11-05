Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E49FAF0868
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2019 22:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729934AbfKEVcK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Nov 2019 16:32:10 -0500
Received: from mga14.intel.com ([192.55.52.115]:46836 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729830AbfKEVcJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 Nov 2019 16:32:09 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Nov 2019 13:32:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,271,1569308400"; 
   d="scan'208";a="214033521"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by orsmga002.jf.intel.com with ESMTP; 05 Nov 2019 13:32:08 -0800
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.212]) by
 ORSMSX104.amr.corp.intel.com ([169.254.4.167]) with mapi id 14.03.0439.000;
 Tue, 5 Nov 2019 13:32:07 -0800
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
CC:     "helgaas@kernel.org" <helgaas@kernel.org>,
        "andrew.murray@arm.com" <andrew.murray@arm.com>,
        "Paszkiewicz, Artur" <artur.paszkiewicz@intel.com>,
        "Baldysiak, Pawel" <pawel.baldysiak@intel.com>,
        "Fugate, David" <david.fugate@intel.com>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Busch, Keith" <keith.busch@intel.com>
Subject: Re: [PATCH 2/3] PCI: vmd: Expose VMD details from BIOS
Thread-Topic: [PATCH 2/3] PCI: vmd: Expose VMD details from BIOS
Thread-Index: AQHVhHZYe7i9MHwHgU2a4PswmMHji6d3aeMAgAAGmACABIIDAIABDacAgAC9+wA=
Date:   Tue, 5 Nov 2019 21:32:07 +0000
Message-ID: <5a87add6071259c45522001648b29c9e597ebd69.camel@intel.com>
References: <20191101215302.GA217821@google.com>
         <5c4521d26f45cfe01631d14c3d7edc9a10f99245.camel@intel.com>
         <20191104180700.GB26409@e121166-lin.cambridge.arm.com>
         <20191105101208.GA21113@e121166-lin.cambridge.arm.com>
In-Reply-To: <20191105101208.GA21113@e121166-lin.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.232.115.129]
Content-Type: text/plain; charset="utf-8"
Content-ID: <B82F98BF3DF8D646BADB51811C056B81@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVHVlLCAyMDE5LTExLTA1IGF0IDEwOjEyICswMDAwLCBMb3JlbnpvIFBpZXJhbGlzaSB3cm90
ZToNCj4gT24gTW9uLCBOb3YgMDQsIDIwMTkgYXQgMDY6MDc6MDBQTSArMDAwMCwgTG9yZW56byBQ
aWVyYWxpc2kgd3JvdGU6DQo+ID4gT24gRnJpLCBOb3YgMDEsIDIwMTkgYXQgMTA6MTY6MzlQTSAr
MDAwMCwgRGVycmljaywgSm9uYXRoYW4gd3JvdGU6DQo+ID4gPiBIaSBCam9ybiwNCj4gPiA+IA0K
PiA+ID4gT24gRnJpLCAyMDE5LTExLTAxIGF0IDE2OjUzIC0wNTAwLCBCam9ybiBIZWxnYWFzIHdy
b3RlOg0KPiA+ID4gPiBbK2NjIEFuZHJld10NCj4gPiA+ID4gDQo+ID4gPiA+IE9uIFdlZCwgT2N0
IDE2LCAyMDE5IGF0IDExOjA0OjQ3QU0gLTA2MDAsIEpvbiBEZXJyaWNrIHdyb3RlOg0KPiA+ID4g
PiA+IFdoZW4gc29tZSBWTURzIGFyZSBlbmFibGVkIGFuZCBvdGhlcnMgYXJlIG5vdCwgaXQncyBk
aWZmaWN1bHQgdG8NCj4gPiA+ID4gPiBkZXRlcm1pbmUgd2hpY2ggSUlPIHN0YWNrIGNvcnJlc3Bv
bmRzIHRvIHRoZSBlbmFibGVkIFZNRC4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBUbyBhc3Npc3Qg
dXNlcnNwYWNlIHdpdGggbWFuYWdlbWVudCB0YXNrcywgVk1EIEJJT1Mgd2lsbCB3cml0ZSB0aGUg
Vk1EDQo+ID4gPiA+ID4gaW5zdGFuY2UgbnVtYmVyIGFuZCBzb2NrZXQgbnVtYmVyIGludG8gdGhl
IGZpcnN0IGVuYWJsZWQgcm9vdCBwb3J0J3MgSU8NCj4gPiA+ID4gPiBCYXNlL0xpbWl0IHJlZ2lz
dGVycyBwcmlvciB0byBPUyBoYW5kb2ZmLiBWTUQgZHJpdmVyIGNhbiBjYXB0dXJlIHRoaXMNCj4g
PiA+ID4gPiBpbmZvcm1hdGlvbiBhbmQgZXhwb3NlIGl0IHRvIHVzZXJzcGFjZS4NCj4gPiA+ID4g
DQo+ID4gPiA+IEhtbW0sIEknbSBub3Qgc3VyZSBJIHVuZGVyc3RhbmQgdGhpcywgYnV0IGl0IHNv
dW5kcyBwb3NzaWJseSBmcmFnaWxlLg0KPiA+ID4gPiBBcmUgdGhlc2UgUm9vdCBQb3J0cyB2aXNp
YmxlIHRvIHRoZSBnZW5lcmljIFBDSSBjb3JlIGRldmljZQ0KPiA+ID4gPiBlbnVtZXJhdGlvbj8g
IElmIHNvLCBpdCB3aWxsIGZpbmQgdGhlbSBhbmQgcmVhZCB0aGVzZSBJL08gd2luZG93DQo+ID4g
PiA+IHJlZ2lzdGVycy4gIE1heWJlIHRvZGF5IHRoZSBQQ0kgY29yZSBkb2Vzbid0IGNoYW5nZSB0
aGVtLCBidXQgSSdtIG5vdA0KPiA+ID4gPiBzdXJlIHdlIHNob3VsZCByZWx5IG9uIHRoZW0gYWx3
YXlzIGJlaW5nIHByZXNlcnZlZCB1bnRpbCB0aGUgdm1kDQo+ID4gPiA+IGRyaXZlciBjYW4gY2xh
aW0gdGhlIGRldmljZS4NCj4gPiA+ID4gDQo+ID4gPiANCj4gPiA+IFRoZSBSb290IFBvcnRzIGFy
ZSBvbiB0aGUgVk1EIFBDSSBkb21haW4sIGFuZCB0aGlzIElPIEJBU0UvTElNSVQNCj4gPiA+IHBh
cnNpbmcgb2NjdXJzIGJlZm9yZSB0aGlzIFBDSSBkb21haW4gaXMgZXhwb3NlZCB0byB0aGUgZ2Vu
ZXJpYyBQQ0kNCj4gPiA+IHNjYW5jb2RlIHdpdGggcGNpX3NjYW5fY2hpbGRfYnVzKCkuIFVudGls
IHRoYXQgcG9pbnQgdGhlIFZNRCBQQ0kgZG9tYWluDQo+ID4gPiBpcyBpbnZpc2libGUgdG8gdGhl
IGtlcm5lbCBvdXRzaWRlIG9mIC9kZXYvbWVtIG9yIHJlc291cmNlMC4NCj4gPiANCj4gPiBUaGF0
J3MgYmVjYXVzZSB0aGUgVk1EIGNvbnRyb2xsZXIgaXMgYSBQQ0kgZGV2aWNlIGl0c2VsZiBhbmQg
aXRzDQo+ID4gQkFScyB2YWx1ZXMgYXJlIHVzZWQgdG8gY29uZmlndXJlIHRoZSBWTUQgaG9zdCBj
b250cm9sbGVyLg0KPiA+IA0KPiA+IEludGVyZXN0aW5nLg0KPiA+IA0KPiA+IFRvIGFkZCB0byBC
am9ybidzIHF1ZXN0aW9uLCB0aGlzIHJlYXNvbmluZyBhc3N1bWVzIHRoYXQgd2hhdGV2ZXINCj4g
PiBjb2RlIGVudW1lcmF0ZXMgdGhlIFBDSSBkZXZpY2UgcmVwcmVzZW50aW5nIHRoZSBWTUQgaG9z
dCBjb250cm9sbGVyDQo+ID4gZG9lcyBub3Qgb3ZlcndyaXRlIGl0cyBCQVJzIHVwb24gYnVzIGVu
dW1lcmF0aW9uIG90aGVyd2lzZSB0aGUgVk1EDQo+ID4gY29udHJvbGxlciBjb25maWd1cmF0aW9u
IHdvdWxkIGJlIGxvc3QuIEFtIEkgcmVhZGluZyB0aGUgY3VycmVudA0KPiA+IGNvZGUgY29ycmVj
dGx5ID8NCj4gDQo+IFNvcnJ5LCBJIGp1c3Qgd2VudCB0aHJvdWdoIHRoZSBjb2RlIGFnYWluLCBJ
IHRoaW5rIHRoZSBWTUQgY29udHJvbGxlcg0KPiBQQ0kgZGV2aWNlIEJBUnMgY2FuIGFuZCBhcmUg
YWxsb3dlZCB0byBiZSByZWFzc2lnbmVkIGJ5IHRoZSBQQ0kNCj4gZW51bWVyYXRpb24gY29kZSAt
IEkgbWlzcmVhZCB0aGUgY29kZSwgc28gSSByYWlzZWQgYSBub24tZXhpc3RlbnQgaXNzdWUNCj4g
aGVyZSwgdGhleSBhcmUgbGlrZSBhbnkgb3RoZXIgUENJIGRldmljZSBNRU0vSU8gQkFScyBpbiB0
aGlzIHJlc3BlY3QuDQo+IA0KPiBMb3JlbnpvDQo+IA0KDQpZZXMgdGhlIFZNRCBlbmRwb2ludCBp
dHNlbGYgZXhwb3NlcyB0aGUgZG9tYWluIGNvbnRhaW5pbmcgdGhlIFJvb3QNClBvcnRzLiBJdCdz
IHRoZSBSb290IFBvcnRzIHdoaWNoIGdldCBlbnVtZXJhdGVkIGJ5IGdlbmVyaWMgUENJDQpzY2Fu
Y29kZSwgYW5kIGFsc28gdGhlIFJvb3QgUG9ydCBjb25maWcgc3BhY2Ugd2hlcmUgdGhpcyBkb21h
aW4gaW5mbyBpcw0Kc3VwcGxpZWQuIFdpdGhvdXQgYSBWTUQgZHJpdmVyLCB0aGUgb25seSBhcGVy
dHVyZSB0byBhY2Nlc3MgdGhlIFJvb3QNClBvcnQgY29uZmlnIHNwYWNlIGlzIE1NSU8gdGhyb3Vn
aCB0aGUgVk1EIGVuZHBvaW50J3MgJ0NvbmZpZycgQkFSIChha2ENCk1FTUJBUjApLg0KDQpXaXRo
b3V0IHRoaXMgcGF0Y2gsIGEgL2Rldi9tZW0sIHJlc291cmNlMCwgb3IgdGhpcmQtcGFydHkgZHJp
dmVyIGNvdWxkDQpvdmVyd3JpdGUgdGhlc2UgdmFsdWVzIGlmIHRoZXkgZG9uJ3QgYWxzbyByZXN0
b3JlIHRoZW0gb24gY2xvc2UvdW5iaW5kLg0KSSBpbWFnaW5lIGEga2V4ZWMgdXNlciB3b3VsZCBh
bHNvIG92ZXJ3cml0ZSB0aGVzZSB2YWx1ZXMuDQoNClRoaXMgaXMgb25lIG9mIHRoZSByZWFzb25z
IEkgd2FzIGFsc28gdGhpbmtpbmcgaXQgY291bGQgbGl2ZSBpbiBkZXZpY2UNCnNwZWNpZmljIHJl
c2V0IGNvZGUgYXMgbG9uZyBhcyBpdCBjYW4gY2FsbCBpbnRvIFZNRCBmb3IgdGhlIHNwZWNpZmlj
cy4NCk1hbnkga2VybmVsIHZlbmRvcnMgYWxyZWFkeSBzaGlwIHdpdGggVk1EPXksIHNvIEkgYW0g
dGVtcHRlZCB0byBzaW1wbHkNCm1ha2UgdGhhdCBwZXJtYW5lbnQgYW5kIGV4cG9ydCBhIHJlc2V0
IGNhbGwgdG8gYSBkZXYgc3BlY2lmaWMgcmVzZXQgaW4NCnF1aXJrcy5jLg0K
