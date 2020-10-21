Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E22F294642
	for <lists+linux-pci@lfdr.de>; Wed, 21 Oct 2020 03:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411060AbgJUBU3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Oct 2020 21:20:29 -0400
Received: from mga07.intel.com ([134.134.136.100]:18144 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2411059AbgJUBU3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Oct 2020 21:20:29 -0400
IronPort-SDR: +n47gxD0G4NKBtzin7mlBLH52jP9ggMlbEK3vAx8vX4WC4C9zd8U3i39E8ulOOb7Bho4X2DMBW
 rEfd8+hdR/lA==
X-IronPort-AV: E=McAfee;i="6000,8403,9780"; a="231493147"
X-IronPort-AV: E=Sophos;i="5.77,399,1596524400"; 
   d="scan'208";a="231493147"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2020 18:20:28 -0700
IronPort-SDR: /cVOH9vAJOQ34iU0xZBNUPlnCNqQNfx8KGYVbGXCSE1u2dINXoaIWlk2b3s5VU6+acOgf4baLz
 u+biUPoVpkLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,399,1596524400"; 
   d="scan'208";a="358725497"
Received: from irsmsx605.ger.corp.intel.com ([163.33.146.138])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Oct 2020 18:20:27 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 IRSMSX605.ger.corp.intel.com (163.33.146.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 21 Oct 2020 02:20:25 +0100
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.1713.004;
 Tue, 20 Oct 2020 18:20:24 -0700
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
Thread-Index: AQHWZRquq8JGneVUfEO6lOcwn6JN/amh6dCAgABRyoA=
Date:   Wed, 21 Oct 2020 01:20:24 +0000
Message-ID: <a7862c6f4ee5ccad035037473b211366e29436ba.camel@intel.com>
References: <20201020202649.GA394225@bjorn-Precision-5520>
In-Reply-To: <20201020202649.GA394225@bjorn-Precision-5520>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.22.254.132]
Content-Type: text/plain; charset="utf-8"
Content-ID: <42E9A7F239CE5940A7132227973412CB@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVHVlLCAyMDIwLTEwLTIwIGF0IDE1OjI2IC0wNTAwLCBCam9ybiBIZWxnYWFzIHdyb3RlOg0K
PiBPbiBUdWUsIEp1bCAyOCwgMjAyMCBhdCAwMTo0OTo0NFBNIC0wNjAwLCBKb24gRGVycmljayB3
cm90ZToNCj4gPiBWTUQgcmV0cmFuc21pdHMgY2hpbGQgZGV2aWNlIE1TSS9YIHdpdGggdGhlIFZN
RCBlbmRwb2ludCdzIHJlcXVlc3Rlci1pZC4NCj4gPiBJbiBvcmRlciB0byBzdXBwb3J0IGRpcmVj
dCBpbnRlcnJ1cHQgcmVtYXBwaW5nIG9mIFZNRCBjaGlsZCBkZXZpY2VzLA0KPiA+IGVuc3VyZSB0
aGF0IHRoZSBJUlRFIGlzIHByb2dyYW1tZWQgd2l0aCB0aGUgVk1EIGVuZHBvaW50J3MgcmVxdWVz
dGVyLWlkDQo+ID4gdXNpbmcgcGNpX3JlYWxfZG1hX2RldigpLg0KPiA+IA0KPiA+IFJldmlld2Vk
LWJ5OiBBbmR5IFNoZXZjaGVua28gPGFuZHJpeS5zaGV2Y2hlbmtvQGludGVsLmNvbT4NCj4gPiBT
aWduZWQtb2ZmLWJ5OiBKb24gRGVycmljayA8am9uYXRoYW4uZGVycmlja0BpbnRlbC5jb20+DQo+
IA0KPiBBcyBUaG9tYXMgKGFuZCBTdGVwaGVuKSBwb2ludGVkIG91dCwgdGhpcyBjb25mbGljdHMg
d2l0aCA3Y2E0MzVjZjg1N2QNCj4gKCJ4ODYvaXJxOiBDbGVhbnVwIHRoZSBhcmNoXypfbXNpX2ly
cXMoKSBsZWZ0b3ZlcnMiKSwgd2hpY2ggcmVtb3Zlcw0KPiBuYXRpdmVfc2V0dXBfbXNpX2lycXMo
KS4NCj4gDQo+IFN0ZXBoZW4gcmVzb2x2ZWQgdGhlIGNvbmZsaWN0IGJ5IGRyb3BwaW5nIHRoaXMg
aHVuay4gIEkgd291bGQgcmF0aGVyDQo+IGp1c3QgZHJvcCB0aGlzIHBhdGNoIGNvbXBsZXRlbHkg
ZnJvbSB0aGUgUENJIHRyZWUuICBJZiBJIGtlZXAgdGhlDQo+IHBhdGNoLCAoMSkgTGludXMgd2ls
bCBoYXZlIHRvIHJlc29sdmUgdGhlIGNvbmZsaWN0LCBhbmQgd29yc2UsICgyKQ0KPiBpdCdzIG5v
dCBjbGVhciB3aGF0IGhhcHBlbmVkIHRvIHRoZSB1c2Ugb2YgcGNpX3JlYWxfZG1hX2RldigpIGhl
cmUuDQo+IEl0IHdpbGwganVzdCB2YW5pc2ggaW50byB0aGUgZXRoZXIgd2l0aCBubyBleHBsYW5h
dGlvbiBvdGhlciB0aGFuDQo+ICJ0aGlzIGZ1bmN0aW9uIHdhcyByZW1vdmVkLiINCj4gDQo+IElz
IGRyb3BwaW5nIHRoaXMgcGF0Y2ggdGhlIGNvcnJlY3QgdGhpbmcgdG8gZG8/ICBPciBkbyB5b3Ug
bmVlZCB0byBhZGQNCj4gcGNpX3JlYWxfZG1hX2RldigpIGVsc2V3aGVyZSB0byBjb21wZW5zYXRl
Pw0KSXQgd291bGQgc3RpbGwgbmVlZCB0aGUgcGNpX3JlYWxfZG1hX2RldigpIGZvciBJUlRFIHBy
b2dyYW1taW5nLg0KDQpJIHRoaW5rIGF0IHRoaXMgcG9pbnQgSSB3b3VsZCByYXRoZXIgc2VlIDUr
NiBkcm9wcGVkIGFuZCB0aGlzIGluY2x1ZGVkDQpmb3IgVEdMIGVuYWJsZW1lbnQ6DQpodHRwczov
L3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtcGNpL3BhdGNoLzIwMjAwOTE0MTkw
MTI4LjUxMTQtMS1qb25hdGhhbi5kZXJyaWNrQGludGVsLmNvbS8NCg0KPiANCj4gPiAtLS0NCj4g
PiAgYXJjaC94ODYva2VybmVsL2FwaWMvbXNpLmMgfCAyICstDQo+ID4gIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9h
cmNoL3g4Ni9rZXJuZWwvYXBpYy9tc2kuYyBiL2FyY2gveDg2L2tlcm5lbC9hcGljL21zaS5jDQo+
ID4gaW5kZXggYzJiMjkxMWZlZWVmLi43Y2EyNzFiOGQ4OTEgMTAwNjQ0DQo+ID4gLS0tIGEvYXJj
aC94ODYva2VybmVsL2FwaWMvbXNpLmMNCj4gPiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvYXBpYy9t
c2kuYw0KPiA+IEBAIC0xODksNyArMTg5LDcgQEAgaW50IG5hdGl2ZV9zZXR1cF9tc2lfaXJxcyhz
dHJ1Y3QgcGNpX2RldiAqZGV2LCBpbnQgbnZlYywgaW50IHR5cGUpDQo+ID4gIA0KPiA+ICAJaW5p
dF9pcnFfYWxsb2NfaW5mbygmaW5mbywgTlVMTCk7DQo+ID4gIAlpbmZvLnR5cGUgPSBYODZfSVJR
X0FMTE9DX1RZUEVfTVNJOw0KPiA+IC0JaW5mby5tc2lfZGV2ID0gZGV2Ow0KPiA+ICsJaW5mby5t
c2lfZGV2ID0gcGNpX3JlYWxfZG1hX2RldihkZXYpOw0KPiA+ICANCj4gPiAgCWRvbWFpbiA9IGly
cV9yZW1hcHBpbmdfZ2V0X2lycV9kb21haW4oJmluZm8pOw0KPiA+ICAJaWYgKGRvbWFpbiA9PSBO
VUxMKQ0KPiA+IC0tIA0KPiA+IDIuMjcuMA0KPiA+IA0K
