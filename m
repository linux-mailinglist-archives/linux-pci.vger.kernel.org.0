Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A61211BA9D9
	for <lists+linux-pci@lfdr.de>; Mon, 27 Apr 2020 18:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbgD0QLL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Apr 2020 12:11:11 -0400
Received: from mga01.intel.com ([192.55.52.88]:61685 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726000AbgD0QLL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Apr 2020 12:11:11 -0400
IronPort-SDR: T39rW1dvExem4+kYQ+PTRmzSSaLoyuX7e2qo91oyGe41dO+Yp4HTxMOnylxN7tzZoKSwGhd1V5
 FYDNlrKBCL1g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2020 09:11:09 -0700
IronPort-SDR: lULvdyllQw0PboddjAM+x97Ht9uRCEl8SrhCg+wC1babmEGmtzrZGtabA4svY696axJa883k1Z
 GLvujQktJZBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,324,1583222400"; 
   d="scan'208";a="336338865"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
  by orsmga001.jf.intel.com with ESMTP; 27 Apr 2020 09:11:09 -0700
Received: from orsmsx162.amr.corp.intel.com (10.22.240.85) by
 ORSMSX108.amr.corp.intel.com (10.22.240.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 27 Apr 2020 09:11:08 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.204]) by
 ORSMSX162.amr.corp.intel.com ([169.254.3.2]) with mapi id 14.03.0439.000;
 Mon, 27 Apr 2020 09:11:08 -0700
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "helgaas@kernel.org" <helgaas@kernel.org>
CC:     "rajatja@google.com" <rajatja@google.com>,
        "fred@fredlawl.com" <fred@fredlawl.com>,
        "ruscur@russell.cc" <ruscur@russell.cc>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "olof@lixom.net" <olof@lixom.net>,
        "sbobroff@linux.ibm.com" <sbobroff@linux.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "oohall@gmail.com" <oohall@gmail.com>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Patel, Mayurkumar" <mayurkumar.patel@intel.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v2 1/2] PCI/AER: Allow Native AER Host Bridges to use AER
Thread-Topic: [PATCH v2 1/2] PCI/AER: Allow Native AER Host Bridges to use
 AER
Thread-Index: AQHWF186RsEJQYVN9kSvtTlNVZfJFaiJZzgAgAQ8SQA=
Date:   Mon, 27 Apr 2020 16:11:07 +0000
Message-ID: <ac3d3b2d3f0e678b792281a1debf5762f1d52b1f.camel@intel.com>
References: <20200424233016.GA218665@google.com>
In-Reply-To: <20200424233016.GA218665@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.255.3.119]
Content-Type: text/plain; charset="utf-8"
Content-ID: <42640F90ECC84045B19B484D16CF3500@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgQmpvcm4sDQoNCk9uIEZyaSwgMjAyMC0wNC0yNCBhdCAxODozMCAtMDUwMCwgQmpvcm4gSGVs
Z2FhcyB3cm90ZToNCj4gSGkgSm9uLA0KPiANCj4gSSdtIGdsYWQgeW91IHJhaXNlZCB0aGlzIGJl
Y2F1c2UgSSB0aGluayB0aGUgd2F5IHdlIGhhbmRsZQ0KPiBGSVJNV0FSRV9GSVJTVCBpcyByZWFs
bHkgc2NyZXdlZCB1cC4NCj4gDQo+IE9uIE1vbiwgQXByIDIwLCAyMDIwIGF0IDAzOjM3OjA5UE0g
LTA2MDAsIEpvbiBEZXJyaWNrIHdyb3RlOg0KPiA+IFNvbWUgcGxhdGZvcm1zIGhhdmUgYSBtaXgg
b2YgcG9ydHMgd2hvc2UgY2FwYWJpbGl0aWVzIGNhbiBiZSBuZWdvdGlhdGVkDQo+ID4gYnkgX09T
QywgYW5kIHNvbWUgcG9ydHMgd2hpY2ggYXJlIG5vdCBkZXNjcmliZWQgYnkgQUNQSSBhbmQgaW5z
dGVhZA0KPiA+IG1hbmFnZWQgYnkgTmF0aXZlIGRyaXZlcnMuIFRoZSBleGlzdGluZyBGaXJtd2Fy
ZS1GaXJzdCBIRVNUIG1vZGVsIGNhbg0KPiA+IGluY29ycmVjdGx5IHRhZyB0aGVzZSBOYXRpdmUs
IE5vbi1BQ1BJIHBvcnRzIGFzIEZpcm13YXJlLUZpcnN0IG1hbmFnZWQNCj4gPiBwb3J0cyBieSBh
ZHZlcnRpc2luZyB0aGUgSEVTVCBHbG9iYWwgRmxhZyBhbmQgbWF0Y2hpbmcgdGhlIHR5cGUgYW5k
DQo+ID4gY2xhc3Mgb2YgdGhlIHBvcnQgKGFlcl9oZXN0X3BhcnNlKS4NCj4gPiANCj4gPiBJZiB0
aGUgcG9ydCByZXF1ZXN0cyBOYXRpdmUgQUVSIHRocm91Z2ggdGhlIEhvc3QgQnJpZGdlJ3MgY2Fw
YWJpbGl0eQ0KPiA+IHNldHRpbmdzLCB0aGUgQUVSIGRyaXZlciBzaG91bGQgaG9ub3IgdGhvc2Ug
c2V0dGluZ3MgYW5kIGFsbG93IHRoZSBwb3J0DQo+ID4gdG8gYmluZC4gVGhpcyBwYXRjaCBjaGFu
Z2VzIHRoZSBkZWZpbml0aW9uIG9mIEZpcm13YXJlLUZpcnN0IHRvIGV4Y2x1ZGUNCj4gPiBwb3J0
cyB3aG9zZSBIb3N0IEJyaWRnZXMgcmVxdWVzdCBOYXRpdmUgQUVSLg0KPiA+IA0KPiA+IFNpZ25l
ZC1vZmYtYnk6IEpvbiBEZXJyaWNrIDxqb25hdGhhbi5kZXJyaWNrQGludGVsLmNvbT4NCj4gPiAt
LS0NCj4gPiAgZHJpdmVycy9wY2kvcGNpZS9hZXIuYyB8IDMgKysrDQo+ID4gIDEgZmlsZSBjaGFu
Z2VkLCAzIGluc2VydGlvbnMoKykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kv
cGNpZS9hZXIuYyBiL2RyaXZlcnMvcGNpL3BjaWUvYWVyLmMNCj4gPiBpbmRleCBmNDI3NGQzLi4z
MGZiZDFmIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvcGNpL3BjaWUvYWVyLmMNCj4gPiArKysg
Yi9kcml2ZXJzL3BjaS9wY2llL2Flci5jDQo+ID4gQEAgLTMxNCw2ICszMTQsOSBAQCBpbnQgcGNp
ZV9hZXJfZ2V0X2Zpcm13YXJlX2ZpcnN0KHN0cnVjdCBwY2lfZGV2ICpkZXYpDQo+ID4gIAlpZiAo
cGNpZV9wb3J0c19uYXRpdmUpDQo+ID4gIAkJcmV0dXJuIDA7DQo+ID4gIA0KPiA+ICsJaWYgKHBj
aV9maW5kX2hvc3RfYnJpZGdlKGRldi0+YnVzKS0+bmF0aXZlX2FlcikNCj4gPiArCQlyZXR1cm4g
MDsNCj4gDQo+IEkgaG9wZSB3ZSBkb24ndCBoYXZlIHRvIGNvbXBsaWNhdGUgcGNpZV9hZXJfZ2V0
X2Zpcm13YXJlX2ZpcnN0KCkgYnkNCj4gYWRkaW5nIHRoaXMgIm5hdGl2ZV9hZXIiIGNoZWNrIGhl
cmUuICBJJ20gbm90IHN1cmUgd2hhdCB3ZSBhY3R1YWxseQ0KPiAqc2hvdWxkKiBkbyBiYXNlZCBv
biBGSVJNV0FSRV9GSVJTVCwgYnV0IEkgZG9uJ3QgdGhpbmsgdGhlIGN1cnJlbnQNCj4gdXNlcyBy
ZWFsbHkgbWFrZSBzZW5zZS4NCj4gDQo+IEkgdGhpbmsgTGludXggbWFrZXMgdG9vIG1hbnkgYXNz
dW1wdGlvbnMgYmFzZWQgb24gdGhlIEZJUk1XQVJFX0ZJUlNUDQo+IGJpdC4gIFRoZSBBQ1BJIHNw
ZWMgcmVhbGx5IG9ubHkgc2F5cyAoQUNQSSB2Ni4zLCBzZWMgMTguMy4yLjQpOg0KPiANCj4gICBJ
ZiBzZXQsIEZJUk1XQVJFX0ZJUlNUIGluZGljYXRlcyB0byB0aGUgT1NQTSB0aGF0IHN5c3RlbSBm
aXJtd2FyZQ0KPiAgIHdpbGwgaGFuZGxlIGVycm9ycyBmcm9tIHRoaXMgc291cmNlIGZpcnN0Lg0K
PiANCj4gICBJZiBGSVJNV0FSRV9GSVJTVCBpcyBzZXQgaW4gdGhlIGZsYWdzIGZpZWxkLCB0aGUg
RW5hYmxlZCBmaWVsZCBbb2YNCj4gICB0aGUgSEVTVCBBRVIgc3RydWN0dXJlXSBpcyBpZ25vcmVk
IGJ5IHRoZSBPU1BNLg0KPiANCj4gSSBkbyBub3Qgc2VlIGFueXRoaW5nIHRoZXJlIGFib3V0IHdo
byBvd25zIHRoZSBBRVIgQ2FwYWJpbGl0eSwgYnV0DQo+IExpbnV4IGFzc3VtZXMgdGhhdCBpZiBG
SVJNV0FSRV9GSVJTVCBpcyBzZXQsIGZpcm13YXJlIG11c3Qgb3duIHRoZSBBRVINCj4gQ2FwYWJp
bGl0eS4gIEkgdGhpbmsgdGhhdCdzIHJlYWRpbmcgdG9vIG11Y2ggaW50byB0aGUgc3BlYy4NCj4g
DQo+IFdlIGFscmVhZHkgaGF2ZSBfT1NDLCB3aGljaCAqZG9lcyogZXhwbGljaXRseSB0YWxrIGFi
b3V0IHdobyBvd25zIHRoZQ0KPiBBRVIgQ2FwYWJpbGl0eSwgYW5kIEkgdGhpbmsgd2Ugc2hvdWxk
IHJlbHkgb24gdGhhdC4gIElmIGZpcm13YXJlDQo+IGRvZXNuJ3Qgd2FudCB0aGUgT1MgdG8gdG91
Y2ggdGhlIEFFUiBDYXBhYmlsaXR5LCBpdCBzaG91bGQgZGVjbGluZSB0bw0KPiBnaXZlIG93bmVy
c2hpcCB0byB0aGUgT1MgdmlhIF9PU0MuDQo+IA0KPiA+ICAJaWYgKCFkZXYtPl9fYWVyX2Zpcm13
YXJlX2ZpcnN0X3ZhbGlkKQ0KPiA+ICAJCWFlcl9zZXRfZmlybXdhcmVfZmlyc3QoZGV2KTsNCj4g
PiAgCXJldHVybiBkZXYtPl9fYWVyX2Zpcm13YXJlX2ZpcnN0Ow0KPiA+IC0tIA0KPiA+IDEuOC4z
LjENCj4gPiANCg0KSnVzdCBhIGxpdHRsZSBiaXQgb2YgcmVhZGluZyBhbmQgbXkgaW50ZXJwcmV0
YXRpb24sIGFzIGl0IHNlZW1zIGxpa2UNCnNvbWUgb2YgdGhpcyBpcyBqdXN0IGxheWVycyB1cG9u
IGxheWVycyBvZiBwb3NzaWJseSBjb25mbGljdGluZyB5ZXQNCmludGVudGlvbmFsbHkgdmFndWUg
ZGVzY3JpcHRpb25zLg0KDQpfT1NDIHNlZW1zIHRvIGRlc2NyaWJlIHRoYXQgT1NQTSBjYW4gaGFu
ZGxlIEFFUiAoNi4yLjExLjMpOg0KUENJIEV4cHJlc3MgQWR2YW5jZWQgRXJyb3IgUmVwb3J0aW5n
IChBRVIpIGNvbnRyb2wNCiAgIFRoZSBPUyBzZXRzIHRoaXMgYml0IHRvIDEgdG8gcmVxdWVzdCBj
b250cm9sIG92ZXIgUENJIEV4cHJlc3MgQUVSLg0KICAgSWYgdGhlIE9TIHN1Y2Nlc3NmdWxseSBy
ZWNlaXZlcyBjb250cm9sIG9mIHRoaXMgZmVhdHVyZSwgaXQgbXVzdA0KICAgaGFuZGxlIGVycm9y
IHJlcG9ydGluZyB0aHJvdWdoIHRoZSBBRVIgQ2FwYWJpbGl0eSBhcyBkZXNjcmliZWQgaW4NCiAg
IHRoZSBQQ0kgRXhwcmVzcyBCYXNlIFNwZWNpZmljYXRpb24uDQoNCg0KRm9yIEFFUiBhbmQgRFBD
IHRoZSBBQ1BJIHJvb3QgcG9ydCBlbnVtZXJhdGlvbiB3aWxsIHByb3Blcmx5IHNldA0KbmF0aXZl
X2Flci9kcGMgYmFzZWQgb24gX09TQzoNCg0Kc3RydWN0IHBjaV9idXMgKmFjcGlfcGNpX3Jvb3Rf
Y3JlYXRlKHN0cnVjdCBhY3BpX3BjaV9yb290ICpyb290LA0KLi4uDQoJaWYgKCEocm9vdC0+b3Nj
X2NvbnRyb2xfc2V0ICYgT1NDX1BDSV9FWFBSRVNTX0FFUl9DT05UUk9MKSkNCgkJaG9zdF9icmlk
Z2UtPm5hdGl2ZV9hZXIgPSAwOw0KCWlmICghKHJvb3QtPm9zY19jb250cm9sX3NldCAmIE9TQ19Q
Q0lfRVhQUkVTU19QTUVfQ09OVFJPTCkpDQoJCWhvc3RfYnJpZGdlLT5uYXRpdmVfcG1lID0gMDsN
CglpZiAoIShyb290LT5vc2NfY29udHJvbF9zZXQgJiBPU0NfUENJX0VYUFJFU1NfTFRSX0NPTlRS
T0wpKQ0KCQlob3N0X2JyaWRnZS0+bmF0aXZlX2x0ciA9IDA7DQoJaWYgKCEocm9vdC0+b3NjX2Nv
bnRyb2xfc2V0ICYgT1NDX1BDSV9FWFBSRVNTX0RQQ19DT05UUk9MKSkNCgkJaG9zdF9icmlkZ2Ut
Pm5hdGl2ZV9kcGMgPSAwOw0KDQpBcyBEUEMgd2FzIGRlZmluZWQgaW4gYW4gRUNOIFsxXSwgSSB3
b3VsZCBpbWFnaW5lIEFFUiB3aWxsIG5lZWQgdG8NCmNvdmVyIERQQyBmb3IgbGVnYWN5IHBsYXRm
b3JtcyBwcmlvciB0byB0aGUgRUNOLg0KDQoNCg0KVGhlIGNvbXBsaWNhdGlvbiBpcyB0aGF0IEhF
U1QgYWxzbyBzZWVtcyB0byBkZXNjcmliZSBob3cgcG9ydHMgKGFuZA0Kb3RoZXIgZGV2aWNlcykg
YXJlIG1hbmFnZWQgZWl0aGVyIGluZGl2aWR1YWxseSBvciBnbG9iYWxseToNCg0KVGFibGUgMTgt
Mzg3ICBQQ0kgRXhwcmVzcyBSb290IFBvcnQgQUVSIFN0cnVjdHVyZQ0KLi4uDQpGbGFnczoNCiAg
IFswXSAtIEZJUk1XQVJFX0ZJUlNUOiBJZiBzZXQsIHRoaXMgYml0IGluZGljYXRlcyB0byB0aGUg
T1NQTSB0aGF0DQogICBzeXN0ZW0gZmlybXdhcmUgd2lsbCBoYW5kbGUgZXJyb3JzIGZyb20gdGhp
cyBzb3VyY2UNCiAgIFsxXSAtIEdMT0JBTDogSWYgc2V0LCBpbmRpY2F0ZXMgdGhhdCB0aGUgc2V0
dGluZ3MgY29udGFpbmVkIGluIHRoaXMNCiAgIHN0cnVjdHVyZSBhcHBseSBnbG9iYWxseSB0byBh
bGwgUENJIEV4cHJlc3MgRGV2aWNlcy4gQWxsIG90aGVyIGJpdHMNCiAgIG11c3QgYmUgc2V0IHRv
IHplcm8NCg0KDQpUaGUgX09TQyBkZWZpbml0aW9uIHNlZW1zIHRvIGNvbnRyYWRpY3QvbmVnYXRl
IHRoZSBhYm92ZSBGSVJNV0FSRV9GSVJTVA0KZGVmaW5pdGlvbiB0aGF0IHNheXMgb25seSBmaXJt
d2FyZSB3aWxsIGhhbmRsZSBlcnJvcnMuIEl0J3MgYSBiaXQNCmRpZmZlcmVudCB0aGFuIHRoZSBJ
QV8zMiBNQ0UgZGVmaW5pdGlvbiB3aGljaCBhbGxvd3MgZm9yIGEgR0hFU19BU1NJU1QNCmNvbmRp
dGlvbiwgd2hpY2ggd291bGQgY2F1c2UgRmlybXdhcmUgJ0ZpcnN0JywgaG93ZXZlciBkb2VzIGFs
bG93IHRoZQ0KZXJyb3IgdG8gYmUgcmVjZWl2ZWQgYnkgT1NQTSBBRVIgdmlhIEdIRVM6DQoNClRh
YmxlIDE4LTM4NSAgSUEtMzIgQXJjaGl0ZWN0dXJlIENvcnJlY3RlZCBNYWNoaW5lIENoZWNrIFN0
cnVjdHVyZQ0KICAgWzBdIC0gRklSTVdBUkVfRklSU1Q6IElmIHNldCwgdGhpcyBiaXQgaW5kaWNh
dGVzIHRoYXQgc3lzdGVtDQogICBmaXJtd2FyZSB3aWxsIGhhbmRsZSBlcnJvcnMgZnJvbSB0aGlz
IHNvdXJjZSBmaXJzdC4NCiAgIFsyXSAtIEdIRVNfQVNTSVNUOiBJZiBzZXQsIHRoaXMgYml0IGlu
ZGljYXRlcyB0aGF0IGFsdGhvdWdoIE9TUE0gaXMNCiAgIHJlc3BvbnNpYmxlIGZvciBkaXJlY3Rs
eSBoYW5kbGluZyB0aGUgZXJyb3IgKGFzIGV4cGVjdGVkIHdoZW4NCiAgIEZJUk1XQVJFX0ZJUlNU
IGlzIG5vdCBzZXQpLCBzeXN0ZW0gZmlybXdhcmUgcmVwb3J0cyBhZGRpdGlvbmFsDQogICBpbmZv
cm1hdGlvbiBpbiB0aGUgY29udGV4dCBvZiBhbiBpbnRlcnJ1cHQgZ2VuZXJhdGVkIGJ5IHRoZSBl
cnJvci4NCiAgIFRoZSBhZGRpdGlvbmFsIGluZm9ybWF0aW9uIGlzIHJlcG9ydGVkIGluIGEgR2Vu
ZXJpYyBIYXJkd2FyZSBFcnJvcg0KICAgU291cmNlIHN0cnVjdHVyZSB3aXRoIGEgbWF0Y2hpbmcg
UmVsYXRlZCBTb3VyY2UgSWQuDQoNCg0KSSB0aGluayBMaW51eCBuZWVkcyB0byBtYWtlIGFuIGFz
c3VtcHRpb24gdGhhdCBkZXZpY2VzIGVpdGhlcg0KZW51bWVyYXRlZCBpbiBIRVNUIG9yIGVudW1l
cmF0ZWQgZ2xvYmFsbHkgYnkgSEVTVCBzaG91bGQgYmUgbWFuYWdlZCBieQ0KRkZTLiBIb3dldmVy
IGl0IHNlZW1zIHRoYXQgTGludXggc2hvdWxkIGFsc28gYmUgY29ycmVsYXRpbmcgdGhhdCB3aXRo
DQpfT1NDIGFzIF9PU0Mgc2VlbXMgdG8gZGlyZWN0bHkgY29udHJhZGljdCBhbmQgcG9zc2libHkg
c3VwZXJjZWRlIHRoZQ0KSEVTVCBleHBlY3RhdGlvbi4NCg0KDQoNClsxXSBodHRwczovL21lbWJl
cnMucGNpc2lnLmNvbS93Zy9QQ0ktU0lHL2RvY3VtZW50LzEyODg4DQoNCg==
