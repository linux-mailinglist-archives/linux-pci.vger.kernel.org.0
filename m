Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5774E295324
	for <lists+linux-pci@lfdr.de>; Wed, 21 Oct 2020 21:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440773AbgJUTzH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Oct 2020 15:55:07 -0400
Received: from mga11.intel.com ([192.55.52.93]:43578 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439094AbgJUTzG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 21 Oct 2020 15:55:06 -0400
IronPort-SDR: YkSbgy2/8SA5oTUGMLsbW3/Je3vYMpBzNiOwZHKuq2WaKPGsJMGk+7SP/Du01pt4cfof6f2TBA
 Q3LMZDDFEuDg==
X-IronPort-AV: E=McAfee;i="6000,8403,9781"; a="163935336"
X-IronPort-AV: E=Sophos;i="5.77,402,1596524400"; 
   d="scan'208";a="163935336"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2020 12:55:06 -0700
IronPort-SDR: kvY5l9GDwpCuyiNTSbE8ChN1IZA6XYNY7AYqp/zbXBaK92nmoc4QRBykb+LnCTG9+jqndEcIrp
 XmywqAcRqgNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,402,1596524400"; 
   d="scan'208";a="316481043"
Received: from irsmsx602.ger.corp.intel.com ([163.33.146.8])
  by orsmga003.jf.intel.com with ESMTP; 21 Oct 2020 12:55:04 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 irsmsx602.ger.corp.intel.com (163.33.146.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 21 Oct 2020 20:55:03 +0100
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.1713.004;
 Wed, 21 Oct 2020 12:55:01 -0700
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "helgaas@kernel.org" <helgaas@kernel.org>
CC:     "hch@lst.de" <hch@lst.de>, "x86@kernel.org" <x86@kernel.org>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "andrzej.jakowski@linux.intel.com" <andrzej.jakowski@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Kalakota, SushmaX" <sushmax.kalakota@intel.com>
Subject: Re: [PATCH 5/6] x86/apic/msi: Use Real PCI DMA device when
 configuring IRTE
Thread-Topic: [PATCH 5/6] x86/apic/msi: Use Real PCI DMA device when
 configuring IRTE
Thread-Index: AQHWZRquq8JGneVUfEO6lOcwn6JN/amh6dCAgABRyoCAABFQgIABJi4A
Date:   Wed, 21 Oct 2020 19:55:01 +0000
Message-ID: <10b74567985e3c03ac52b0eee58291eebf034444.camel@intel.com>
References: <20201021022131.GA409218@bjorn-Precision-5520>
In-Reply-To: <20201021022131.GA409218@bjorn-Precision-5520>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.22.254.132]
Content-Type: text/plain; charset="utf-8"
Content-ID: <59B7A34FEC056748A09DEBFF743E994E@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVHVlLCAyMDIwLTEwLTIwIGF0IDIxOjIxIC0wNTAwLCBCam9ybiBIZWxnYWFzIHdyb3RlOg0K
PiBPbiBXZWQsIE9jdCAyMSwgMjAyMCBhdCAwMToyMDoyNEFNICswMDAwLCBEZXJyaWNrLCBKb25h
dGhhbiB3cm90ZToNCj4gPiBPbiBUdWUsIDIwMjAtMTAtMjAgYXQgMTU6MjYgLTA1MDAsIEJqb3Ju
IEhlbGdhYXMgd3JvdGU6DQo+ID4gPiBPbiBUdWUsIEp1bCAyOCwgMjAyMCBhdCAwMTo0OTo0NFBN
IC0wNjAwLCBKb24gRGVycmljayB3cm90ZToNCj4gPiA+ID4gVk1EIHJldHJhbnNtaXRzIGNoaWxk
IGRldmljZSBNU0kvWCB3aXRoIHRoZSBWTUQgZW5kcG9pbnQncyByZXF1ZXN0ZXItaWQuDQo+ID4g
PiA+IEluIG9yZGVyIHRvIHN1cHBvcnQgZGlyZWN0IGludGVycnVwdCByZW1hcHBpbmcgb2YgVk1E
IGNoaWxkIGRldmljZXMsDQo+ID4gPiA+IGVuc3VyZSB0aGF0IHRoZSBJUlRFIGlzIHByb2dyYW1t
ZWQgd2l0aCB0aGUgVk1EIGVuZHBvaW50J3MgcmVxdWVzdGVyLWlkDQo+ID4gPiA+IHVzaW5nIHBj
aV9yZWFsX2RtYV9kZXYoKS4NCj4gPiA+ID4gDQo+ID4gPiA+IFJldmlld2VkLWJ5OiBBbmR5IFNo
ZXZjaGVua28gPGFuZHJpeS5zaGV2Y2hlbmtvQGludGVsLmNvbT4NCj4gPiA+ID4gU2lnbmVkLW9m
Zi1ieTogSm9uIERlcnJpY2sgPGpvbmF0aGFuLmRlcnJpY2tAaW50ZWwuY29tPg0KPiA+ID4gDQo+
ID4gPiBBcyBUaG9tYXMgKGFuZCBTdGVwaGVuKSBwb2ludGVkIG91dCwgdGhpcyBjb25mbGljdHMg
d2l0aCA3Y2E0MzVjZjg1N2QNCj4gPiA+ICgieDg2L2lycTogQ2xlYW51cCB0aGUgYXJjaF8qX21z
aV9pcnFzKCkgbGVmdG92ZXJzIiksIHdoaWNoIHJlbW92ZXMNCj4gPiA+IG5hdGl2ZV9zZXR1cF9t
c2lfaXJxcygpLg0KPiA+ID4gDQo+ID4gPiBTdGVwaGVuIHJlc29sdmVkIHRoZSBjb25mbGljdCBi
eSBkcm9wcGluZyB0aGlzIGh1bmsuICBJIHdvdWxkIHJhdGhlcg0KPiA+ID4ganVzdCBkcm9wIHRo
aXMgcGF0Y2ggY29tcGxldGVseSBmcm9tIHRoZSBQQ0kgdHJlZS4gIElmIEkga2VlcCB0aGUNCj4g
PiA+IHBhdGNoLCAoMSkgTGludXMgd2lsbCBoYXZlIHRvIHJlc29sdmUgdGhlIGNvbmZsaWN0LCBh
bmQgd29yc2UsICgyKQ0KPiA+ID4gaXQncyBub3QgY2xlYXIgd2hhdCBoYXBwZW5lZCB0byB0aGUg
dXNlIG9mIHBjaV9yZWFsX2RtYV9kZXYoKSBoZXJlLg0KPiA+ID4gSXQgd2lsbCBqdXN0IHZhbmlz
aCBpbnRvIHRoZSBldGhlciB3aXRoIG5vIGV4cGxhbmF0aW9uIG90aGVyIHRoYW4NCj4gPiA+ICJ0
aGlzIGZ1bmN0aW9uIHdhcyByZW1vdmVkLiINCj4gPiA+IA0KPiA+ID4gSXMgZHJvcHBpbmcgdGhp
cyBwYXRjaCB0aGUgY29ycmVjdCB0aGluZyB0byBkbz8gIE9yIGRvIHlvdSBuZWVkIHRvIGFkZA0K
PiA+ID4gcGNpX3JlYWxfZG1hX2RldigpIGVsc2V3aGVyZSB0byBjb21wZW5zYXRlPw0KPiA+IA0K
PiA+IEl0IHdvdWxkIHN0aWxsIG5lZWQgdGhlIHBjaV9yZWFsX2RtYV9kZXYoKSBmb3IgSVJURSBw
cm9ncmFtbWluZy4NCj4gPiANCj4gPiBJIHRoaW5rIGF0IHRoaXMgcG9pbnQgSSB3b3VsZCByYXRo
ZXIgc2VlIDUrNiBkcm9wcGVkIGFuZCB0aGlzIGluY2x1ZGVkDQo+ID4gZm9yIFRHTCBlbmFibGVt
ZW50Og0KPiA+IGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1wY2kv
cGF0Y2gvMjAyMDA5MTQxOTAxMjguNTExNC0xLWpvbmF0aGFuLmRlcnJpY2tAaW50ZWwuY29tLw0K
PiANCj4gSXQncyB0b28gbGF0ZSB0byBhZGQgbmV3IHRoaW5ncyBmb3IgdjUuMTAuICBJJ2xsIGRy
b3AgNSBhbmQgSSdsbCBiZQ0KPiBoYXBweSB0byBkcm9wIDYsIHRvbywgaWYgeW91IHdhbnQuICBJ
IGhhdmUgc2V2ZXJhbCBjb21tZW50cy9xdWVzdGlvbnMNCj4gb24gNiBhbnl3YXkgdGhhdCBJIGhh
dmVuJ3QgZmluaXNoZWQgd3JpdGluZyB1cC4NCj4gDQo+IEJ1dCBpZiB5b3UnZCByYXRoZXIgaGF2
ZSAxLTQgKyA2IGluIHY1LjEwIGluc3RlYWQgb2YganVzdCAxLTQsIGxldCBtZQ0KPiBrbm93Lg0K
PiANCj4gQmpvcm4NCg0KSGVyZSdzIHRoZSBwcm9wb3NlZCBuZXcgbG9jYXRpb24gZm9yIHBhdGNo
IDUgZm9yIHBjaV9yZWFsX2RtYV9kZXYoKSwNCmJ1dCBJIGNhbid0IHRlc3QgdGhpcyBhdCB0aGUg
bW9tZW50Og0KDQpkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL2FwaWMvbXNpLmMgYi9hcmNo
L3g4Ni9rZXJuZWwvYXBpYy9tc2kuYw0KaW5kZXggNjMxM2YwYTA1ZGI3Li43MDc5NjhiMjM0ZTkg
MTAwNjQ0DQotLS0gYS9hcmNoL3g4Ni9rZXJuZWwvYXBpYy9tc2kuYw0KKysrIGIvYXJjaC94ODYv
a2VybmVsL2FwaWMvbXNpLmMNCkBAIC0xOTQsNiArMTk0LDcgQEAgaW50IHBjaV9tc2lfcHJlcGFy
ZShzdHJ1Y3QgaXJxX2RvbWFpbiAqZG9tYWluLA0Kc3RydWN0IGRldmljZSAqZGV2LCBpbnQgbnZl
YywNCiAgICAgICAgICAgICAgICBhcmctPnR5cGUgPSBYODZfSVJRX0FMTE9DX1RZUEVfUENJX01T
STsNCiAgICAgICAgICAgICAgICBhcmctPmZsYWdzIHw9IFg4Nl9JUlFfQUxMT0NfQ09OVElHVU9V
U19WRUNUT1JTOw0KICAgICAgICB9DQorICAgICAgIGFyZy0+ZGV2aWQgPSBwY2lfcmVhbF9kbWFf
ZGV2KHBkZXYpOw0KIA0KICAgICAgICByZXR1cm4gMDsNCiB9DQotLSANCjIuMTguMQ0KDQoNCk90
aGVyd2lzZSBJIHdvdWxkIHdhbnQgdG8gZHJvcCA1ICYgNiBiZWNhdXNlIDYgd2lsbCBsaWtlbHkg
YnJlYWsgVk1EDQp3aXRob3V0IHBhdGNoIDUgd2hlbiBJTyBBUElDIGlzIGluIHVzZQ0K
