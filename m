Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14F6EECB44
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2019 23:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbfKAWQk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Nov 2019 18:16:40 -0400
Received: from mga03.intel.com ([134.134.136.65]:55591 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbfKAWQk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 Nov 2019 18:16:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Nov 2019 15:16:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,257,1569308400"; 
   d="scan'208";a="352073297"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by orsmga004.jf.intel.com with ESMTP; 01 Nov 2019 15:16:39 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.212]) by
 ORSMSX107.amr.corp.intel.com ([169.254.1.115]) with mapi id 14.03.0439.000;
 Fri, 1 Nov 2019 15:16:39 -0700
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "helgaas@kernel.org" <helgaas@kernel.org>
CC:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "andrew.murray@arm.com" <andrew.murray@arm.com>,
        "Paszkiewicz, Artur" <artur.paszkiewicz@intel.com>,
        "Baldysiak, Pawel" <pawel.baldysiak@intel.com>,
        "Fugate, David" <david.fugate@intel.com>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Busch, Keith" <keith.busch@intel.com>
Subject: Re: [PATCH 2/3] PCI: vmd: Expose VMD details from BIOS
Thread-Topic: [PATCH 2/3] PCI: vmd: Expose VMD details from BIOS
Thread-Index: AQHVhHZYe7i9MHwHgU2a4PswmMHji6d3aeMAgAAGmAA=
Date:   Fri, 1 Nov 2019 22:16:39 +0000
Message-ID: <5c4521d26f45cfe01631d14c3d7edc9a10f99245.camel@intel.com>
References: <20191101215302.GA217821@google.com>
In-Reply-To: <20191101215302.GA217821@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.255.7.114]
Content-Type: text/plain; charset="utf-8"
Content-ID: <E9FC84462207CA4F9D41D87312920ACA@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgQmpvcm4sDQoNCk9uIEZyaSwgMjAxOS0xMS0wMSBhdCAxNjo1MyAtMDUwMCwgQmpvcm4gSGVs
Z2FhcyB3cm90ZToNCj4gWytjYyBBbmRyZXddDQo+IA0KPiBPbiBXZWQsIE9jdCAxNiwgMjAxOSBh
dCAxMTowNDo0N0FNIC0wNjAwLCBKb24gRGVycmljayB3cm90ZToNCj4gPiBXaGVuIHNvbWUgVk1E
cyBhcmUgZW5hYmxlZCBhbmQgb3RoZXJzIGFyZSBub3QsIGl0J3MgZGlmZmljdWx0IHRvDQo+ID4g
ZGV0ZXJtaW5lIHdoaWNoIElJTyBzdGFjayBjb3JyZXNwb25kcyB0byB0aGUgZW5hYmxlZCBWTUQu
DQo+ID4gDQo+ID4gVG8gYXNzaXN0IHVzZXJzcGFjZSB3aXRoIG1hbmFnZW1lbnQgdGFza3MsIFZN
RCBCSU9TIHdpbGwgd3JpdGUgdGhlIFZNRA0KPiA+IGluc3RhbmNlIG51bWJlciBhbmQgc29ja2V0
IG51bWJlciBpbnRvIHRoZSBmaXJzdCBlbmFibGVkIHJvb3QgcG9ydCdzIElPDQo+ID4gQmFzZS9M
aW1pdCByZWdpc3RlcnMgcHJpb3IgdG8gT1MgaGFuZG9mZi4gVk1EIGRyaXZlciBjYW4gY2FwdHVy
ZSB0aGlzDQo+ID4gaW5mb3JtYXRpb24gYW5kIGV4cG9zZSBpdCB0byB1c2Vyc3BhY2UuDQo+IA0K
PiBIbW1tLCBJJ20gbm90IHN1cmUgSSB1bmRlcnN0YW5kIHRoaXMsIGJ1dCBpdCBzb3VuZHMgcG9z
c2libHkgZnJhZ2lsZS4NCj4gQXJlIHRoZXNlIFJvb3QgUG9ydHMgdmlzaWJsZSB0byB0aGUgZ2Vu
ZXJpYyBQQ0kgY29yZSBkZXZpY2UNCj4gZW51bWVyYXRpb24/ICBJZiBzbywgaXQgd2lsbCBmaW5k
IHRoZW0gYW5kIHJlYWQgdGhlc2UgSS9PIHdpbmRvdw0KPiByZWdpc3RlcnMuICBNYXliZSB0b2Rh
eSB0aGUgUENJIGNvcmUgZG9lc24ndCBjaGFuZ2UgdGhlbSwgYnV0IEknbSBub3QNCj4gc3VyZSB3
ZSBzaG91bGQgcmVseSBvbiB0aGVtIGFsd2F5cyBiZWluZyBwcmVzZXJ2ZWQgdW50aWwgdGhlIHZt
ZA0KPiBkcml2ZXIgY2FuIGNsYWltIHRoZSBkZXZpY2UuDQo+IA0KDQpUaGUgUm9vdCBQb3J0cyBh
cmUgb24gdGhlIFZNRCBQQ0kgZG9tYWluLCBhbmQgdGhpcyBJTyBCQVNFL0xJTUlUDQpwYXJzaW5n
IG9jY3VycyBiZWZvcmUgdGhpcyBQQ0kgZG9tYWluIGlzIGV4cG9zZWQgdG8gdGhlIGdlbmVyaWMg
UENJDQpzY2FuY29kZSB3aXRoIHBjaV9zY2FuX2NoaWxkX2J1cygpLiBVbnRpbCB0aGF0IHBvaW50
IHRoZSBWTUQgUENJIGRvbWFpbg0KaXMgaW52aXNpYmxlIHRvIHRoZSBrZXJuZWwgb3V0c2lkZSBv
ZiAvZGV2L21lbSBvciByZXNvdXJjZTAuDQoNCkhvd2V2ZXIsIHllcywgaXQgaXMgc29tZXdoYXQg
ZnJhZ2lsZSBpbiB0aGF0IGEgdGhpcmQtcGFydHkgZHJpdmVyIGNvdWxkDQphdHRhY2ggdG8gdGhl
IFZNRCBlbmRwb2ludCBwcmlvciB0byB0aGUgVk1EIGRyaXZlciBhbmQgbW9kaWZ5IHRoZQ0KdmFs
dWVzLiBBIC9kZXYvbWVtIG9yIHJlc291cmNlMCB1c2VyIGNvdWxkIGFsc28gZG8gdGhpcyBvbiBh
bg0KdW5hdHRhY2hlZCBWTUQgZW5kcG9pbnQuDQoNCkknbSB3b25kZXJpbmcgaWYgdGhpcyB3b3Vs
ZCBhbHNvIGJlIGJldHRlciBzdWl0ZWQgZm9yIGEgc3BlY2lhbCByZXNldA0KaW4gcXVpcmtzLmMs
IGJ1dCBpdCB3b3VsZCBuZWVkIHRvIGV4cG9zZSBhIGJpdCBvZiBWTUQgY29uZmlnIGFjY2Vzc2lu
Zw0KaW4gcXVpcmtzLmMgdG8gZG8gdGhhdC4NCg0KPiBCdXQgSSBndWVzcyB5b3UncmUgdXNpbmcg
YSBzcGVjaWFsIGNvbmZpZyBhY2Nlc3NvciAodm1kX2NmZ19yZWFkKCkpLA0KPiBzbyB0aGVzZSBh
cmUgcHJvYmFibHkgaW52aXNpYmxlIHRvIHRoZSBnZW5lcmljIGVudW1lcmF0aW9uPw0KPiANCg0K
WWVzIHRoZSBWTUQgZG9tYWluIGlzIGludmlzaWJsZSB0byBnZW5lcmljIFBDSSB1bnRpbCB0aGUg
ZG9tYWluIGlzDQplbnVtZXJhdGVkIGxhdGUgaW4gdm1kX2VuYWJsZV9kb21haW4oKS4NCg0KPiA+
ICsgKiBmb3JfZWFjaF92bWRfcm9vdF9wb3J0IC0gaXRlcmF0ZSBvdmVyIGFsbCBlbmFibGVkIFZN
RCBSb290IFBvcnRzDQo+ID4gKyAqIEB2bWQ6ICZzdHJ1Y3Qgdm1kX2RldiBWTUQgZGV2aWNlIGRl
c2NyaXB0b3INCj4gPiArICogQHJwOiBpbnQgaXRlcmF0b3IgY3Vyc29yDQo+ID4gKyAqIEB0ZW1w
OiB1MzIgdGVtcG9yYXJ5IHZhbHVlIGZvciBjb25maWcgcmVhZA0KPiA+ICsgKg0KPiA+ICsgKiBW
TUQgUm9vdCBQb3J0cyBhcmUgbG9jYXRlZCBpbiB0aGUgVk1EIFBDSWUgRG9tYWluIGF0IDAwOlsw
LTNdLjAsIGFuZCBjb25maWcNCj4gPiArICogc3BhY2UgY2FuIGJlIGRldGVybWluYXRlbHkgYWNj
ZXNzZWQgdGhyb3VnaCB0aGUgVk1EIENvbmZpZyBCQVIuIEJlY2F1c2UgVk1EDQo+IA0KPiBJJ20g
bm90IHN1cmUgaG93IHRvIHBhcnNlICJkZXRlcm1pbmF0ZWx5IGFjY2Vzc2VkIi4gIE1heWJlIHRo
aXMgY29uZmlnDQo+IHNwYWNlIGNhbiAqb25seSogYmUgYWNjZXNzZWQgdmlhIHRoZSBWTUQgQ29u
ZmlnIEJBUj8NCg0KUGVyaGFwcyBpdCBzaG91bGQgaW5zdGVhZCBzYXkgZGV0ZXJtaW5hdGVseSBh
ZGRyZXNzZWQsIGFzIGVhY2ggUm9vdA0KUG9ydCBjb25maWcgc3BhY2UgaXMgYWRkcmVzc2FibGUg
YXQgc29tZSBvZmZzZXQgb2YgTiAqIDB4ODAwMCBmcm9tIHRoZQ0KYmFzZSBvZiB0aGUgVk1EIGVu
ZHBvaW50IGNvbmZpZyBiYXIuIEkgY2FuIHNlZSB0aGUgY29tbWVudCBtYXkgbm90IGJlDQpoZWxw
ZnVsIGFzIHRoYXQgZGV0YWlsIGlzIGFic3RyYWN0ZWQgdXNpbmcgdGhlIHZtZF9jZmdfcmVhZCgp
IGhlbHBlci4NCg0KDQo+IA0KPiA+ICsgKiBSb290IFBvcnRzIGNhbiBiZSBpbmRpdmlkdWFsbHkg
ZGlzYWJsZWQsIGl0J3MgaW1wb3J0YW50IHRvIGl0ZXJhdGUgZm9yIHRoZQ0KPiA+ICsgKiBmaXJz
dCBlbmFibGVkIFJvb3QgUG9ydCBhcyBkZXRlcm1pbmVkIGJ5IHJlYWRpbmcgdGhlIFZlbmRvci9E
ZXZpY2UgcmVnaXN0ZXIuDQo+ID4gKyAqLw0KPiA+ICsjZGVmaW5lIGZvcl9lYWNoX3ZtZF9yb290
X3BvcnQodm1kLCBycCwgdGVtcCkJCQkJXA0KPiA+ICsJZm9yIChycCA9IDA7IHJwIDwgNDsgcnAr
KykJCQkJCVwNCj4gPiArCQlpZiAodm1kX2NmZ19yZWFkKHZtZCwgMCwgUENJX0RFVkZOKHJvb3Rf
cG9ydCwgMCksCVwNCj4gPiArCQkJCSBQQ0lfVkVORE9SX0lELCA0LCAmdGVtcCkgfHwJCVwNCj4g
PiArCQkgICAgdGVtcCA9PSAweGZmZmZmZmZmKSB7fSBlbHNlDQo=
