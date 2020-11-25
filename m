Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBE52C468F
	for <lists+linux-pci@lfdr.de>; Wed, 25 Nov 2020 18:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731256AbgKYRWL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Nov 2020 12:22:11 -0500
Received: from mga17.intel.com ([192.55.52.151]:61737 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730567AbgKYRWL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 25 Nov 2020 12:22:11 -0500
IronPort-SDR: Ll6oxsOVPjMnZdFadIPqERtfLIXssLKo+9SugkBIIZCg6OXl1K2xRBRVn8adRa5ez3VzG/car0
 3BZuG0epq+iQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9816"; a="152007787"
X-IronPort-AV: E=Sophos;i="5.78,369,1599548400"; 
   d="scan'208";a="152007787"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2020 09:22:06 -0800
IronPort-SDR: AizFAFFhIEZkU+cBuVzV+PEXxQ5vgvHtAFTYsURMPHovQ2ULshQoxAkF8ToaGGhdTLJJKb05PO
 T26WpSEt/oLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,369,1599548400"; 
   d="scan'208";a="433032323"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga001.fm.intel.com with ESMTP; 25 Nov 2020 09:22:06 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 25 Nov 2020 09:22:06 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 25 Nov 2020 09:22:06 -0800
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.1713.004;
 Wed, 25 Nov 2020 09:22:06 -0800
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "helgaas@kernel.org" <helgaas@kernel.org>
CC:     "Kalakota, SushmaX" <sushmax.kalakota@intel.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Patel, Nirmal" <nirmal.patel@intel.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>
Subject: Re: [PATCH 2/5] PCI: Add a reset quirk for VMD
Thread-Topic: [PATCH 2/5] PCI: Add a reset quirk for VMD
Thread-Index: AQHWv4++6qsNAgRtSUy537ctw5YhrqnYW8wAgAFKLoA=
Date:   Wed, 25 Nov 2020 17:22:05 +0000
Message-ID: <57d28cdc12734c38b09f18ccd493a4b60b1e9031.camel@intel.com>
References: <20201124214020.GA590491@bjorn-Precision-5520>
In-Reply-To: <20201124214020.GA590491@bjorn-Precision-5520>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.1.200.100]
Content-Type: text/plain; charset="utf-8"
Content-ID: <291B33B46B03D243BA1010BC75CB2E58@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgQmpvcm4sDQoNCk9uIFR1ZSwgMjAyMC0xMS0yNCBhdCAxNTo0MCAtMDYwMCwgQmpvcm4gSGVs
Z2FhcyB3cm90ZToNCj4gWytjYyBBbGV4XQ0KPiANCj4gT24gRnJpLCBOb3YgMjAsIDIwMjAgYXQg
MDM6NTE6NDFQTSAtMDcwMCwgSm9uIERlcnJpY2sgd3JvdGU6DQo+ID4gVk1EIGRvbWFpbnMgc2hv
dWxkIGJlIHJlc2V0IGluLWJldHdlZW4gc3BlY2lhbCBhdHRhY2htZW50IHN1Y2ggYXMgVkZJTw0K
PiA+IHVzZXJzLiBWTUQgZG9lcyBub3Qgb2ZmZXIgYSByZXNldCwgaG93ZXZlciB0aGUgc3ViZGV2
aWNlIGRvbWFpbiBpdHNlbGYNCj4gPiBjYW4gYmUgcmVzZXQgc3RhcnRpbmcgYXQgdGhlIFJvb3Qg
QnVzLiBBZGQgYSBTZWNvbmRhcnkgQnVzIFJlc2V0IG9uIGVhY2gNCj4gPiBvZiB0aGUgaW5kaXZp
ZHVhbCByb290IHBvcnQgZGV2aWNlcyBpbW1lZGlhdGVseSBkb3duc3RyZWFtIG9mIHRoZSBWTUQN
Cj4gPiByb290IGJ1cy4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBKb24gRGVycmljayA8am9u
YXRoYW4uZGVycmlja0BpbnRlbC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvcGNpL3F1aXJr
cy5jIHwgNDggKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
DQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA0OCBpbnNlcnRpb25zKCspDQo+ID4gDQo+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvcGNpL3F1aXJrcy5jIGIvZHJpdmVycy9wY2kvcXVpcmtzLmMNCj4gPiBp
bmRleCBmNzA2OTJhLi5lZTU4YjUxIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvcGNpL3F1aXJr
cy5jDQo+ID4gKysrIGIvZHJpdmVycy9wY2kvcXVpcmtzLmMNCj4gPiBAQCAtMzc0NCw2ICszNzQ0
LDQ5IEBAIHN0YXRpYyBpbnQgcmVzZXRfaXZiX2lnZChzdHJ1Y3QgcGNpX2RldiAqZGV2LCBpbnQg
cHJvYmUpDQo+ID4gIAlyZXR1cm4gMDsNCj4gPiAgfQ0KPiA+ICANCj4gPiArLyogSXNzdWVzIFNC
UiB0byBWTUQgZG9tYWluIHRvIGNsZWFyIFBDSSBjb25maWd1cmF0aW9uICovDQo+ID4gK3N0YXRp
YyBpbnQgcmVzZXRfdm1kX3NicihzdHJ1Y3QgcGNpX2RldiAqZGV2LCBpbnQgcHJvYmUpDQo+ID4g
K3sNCj4gPiArCWNoYXIgX19pb21lbSAqY2ZnYmFyLCAqYmFzZTsNCj4gPiArCWludCBycDsNCj4g
PiArCXUxNiBjdGw7DQo+ID4gKw0KPiA+ICsJaWYgKHByb2JlKQ0KPiA+ICsJCXJldHVybiAwOw0K
PiA+ICsNCj4gPiArCWlmIChkZXYtPmRldi5kcml2ZXIpDQo+ID4gKwkJcmV0dXJuIDA7DQo+IA0K
PiBJIGd1ZXNzICJkZXYiIGhlcmUgaXMgdGhlIFZNRCBlbmRwb2ludD8gIEFuZCBpZiB0aGUgdm1k
LmMgZHJpdmVyIGlzDQo+IGJvdW5kIHRvIGl0LCB5b3UgcmV0dXJuIHN1Y2Nlc3Mgd2l0aG91dCBk
b2luZyBhbnl0aGluZz8NCj4gDQo+IElmIHRoZXJlJ3Mgbm8gZHJpdmVyIGZvciB0aGUgVk1EIGRl
dmljZSwgd2hvIGlzIHRyeWluZyB0byByZXNldCBpdD8NCj4gDQo+IEkgZ3Vlc3MgSSBkb24ndCBx
dWl0ZSB1bmRlcnN0YW5kIGhvdyBWTUQgd29ya3MuICBJIHdvdWxkIGhhdmUgdGhvdWdodA0KPiB0
aGF0IGlmIHZtZC5jIGlzbid0IGJvdW5kIHRvIHRoZSBWTUQgZGV2aWNlLCB0aGUgZGV2aWNlcyBi
ZWhpbmQgdGhlDQo+IFZNRCB3b3VsZCBiZSBpbmFjY2Vzc2libGUgYW5kIHRoZXJlJ2QgYmUgbm8g
cG9pbnQgaW4gYSByZXNldC4NCg0KVGhpcyBpcyBiYXNpY2FsbHkgdGhlIGlkZWEgYmVoaW5kIHRo
aXMgcmVzZXQgLSBhbGxvdyB0aGUgdXNlciB0byByZXNldA0KVk1EIGlmIHRoZXJlIGlzIG5vIGRy
aXZlciBib3VuZCB0byBpdCwgYnV0IHByZXZlbnQgdGhlIHJlc2V0IGZyb20NCmRlZW51bWVyYXRp
bmcgdGhlIGRvbWFpbiBpZiB0aGVyZSBpcyBhIGRyaXZlci4NCg0KSWYgdGhpcyBpcyBhbiB1bnVz
dWFsL3VuZXhwZWN0ZWQgdXNlIGNhc2UsIHdlIGNhbiBkcm9wIGl0Lg0KDQoNCj4gDQo+ID4gKwlj
ZmdiYXIgPSBwY2lfaW9tYXAoZGV2LCAwLCAwKTsNCj4gPiArCWlmICghY2ZnYmFyKQ0KPiA+ICsJ
CXJldHVybiAtRU5PTUVNOw0KPiA+ICsNCj4gPiArCS8qDQo+ID4gKwkgKiBTdWJkZXZpY2UgY29u
ZmlnIHNwYWNlIGlzIG1hcHBlZCBsaW5lYXJseSB1c2luZyA0ayBjb25maWcgc3BhY2UNCj4gPiAr
CSAqIGluY3JlbWVudHMuIFVzZSBpbmNyZW1lbnRzIG9mIDB4ODAwMCB0byBsb2NhdGUgcm9vdCBw
b3J0IGRldmljZXMuDQo+ID4gKwkgKi8NCj4gPiArCWZvciAocnAgPSAwOyBycCA8IDQ7IHJwKysp
IHsNCj4gPiArCQliYXNlID0gY2ZnYmFyICsgcnAgKiAweDgwMDA7DQo+IA0KPiBJIHJlYWxseSBk
b24ndCBsaWtlIHRoaXMgcGFydCAtLSBpb21hcHBpbmcgQkFSIDAgKGFwcGFyZW50bHkNCj4gVk1E
X0NGR0JBUiksIGFuZCBtYWtpbmcgdXAgdGhlIEVDQU0taXNoIGFkZHJlc3NlcyBhbmQgYmFzaWNh
bGx5DQo+IG9wZW4tY29kaW5nIEVDQU0gYWNjZXNzZXMgYmVsb3cuICBJIGd1ZXNzIHRoaXMgYXNz
dW1lcyBSb290IFBvcnRzIGFyZQ0KPiBvbmx5IG9uIGZ1bmN0aW9ucyAuMCwgLjIsIC40LCAuNj8N
Cg0KVGhlIFJvb3QgUG9ydHMgYXJlIERldmljZXMgeHg6MDAuMCwgeHg6MDEuMCwgeHg6MDIuMCwg
YW5kIHh4OjAzLjANCihjb3JyZXNwb25kaW5nIHRvIFBDSUVfRVhUX1NMT1RfU0hJRlQgPSAxNSkN
Cg0KDQo+IA0KPiBJcyBpdCBhbGwgb3Blbi1jb2RlZCBoZXJlIGJlY2F1c2UgdGhpcyByZXNldCBw
YXRoIGlzIG9ubHkgb2YgaW50ZXJlc3QNCj4gd2hlbiB2bWQuYyBpcyBOT1QgYm91bmQgdG8gdGhl
IHRoZSBWTUQgZGV2aWNlLCBzbyB5b3UgY2FuJ3QgdXNlDQo+IHZtZC0+Y2ZnYmFyLCBldGM/DQoN
ClRoYXQncyBjb3JyZWN0LCBidXQgYXMgbWVudGlvbmVkIGFib3ZlIGl0IG1pZ2h0IGJlIGFuIHVu
dXN1YWwgY29kZSBwYXRoDQpzbyBpcyBub3QgYXMgaW1wb3J0YW50IGFzIHRoZSByZXNldCB3aXRo
aW4gdGhlIGRyaXZlciBpbiBwYXRjaCAxLzUuDQoNCj4gDQo+IFdoYXQgYWJvdXQgdGhlIGNhc2Ug
d2hlbiB2bWQuYyBJUyBib3VuZD8gIFdlIGRvbid0IGRvIGFueXRoaW5nIGhlcmUsDQo+IHNvIGRv
ZXMgdGhhdCBtZWFuIHdlIGluc3RlYWQgdXNlIHRoZSB1c3VhbCBjYXNlIG9mIGFzc2VydGluZyBT
QlIgb24NCj4gdGhlIFJvb3QgUG9ydHMgYmVoaW5kIHRoZSBWTUQ/DQoNCkl0IHVzZXMgdGhlIHN0
YW5kYXJkIExpbnV4IHJlc2V0IGNvZGUgcGF0aHMgZm9yIFJvb3QgUG9ydCBkZXZpY2VzDQoNCj4g
DQo+ID4gKwkJaWYgKHJlYWRsKGJhc2UgKyBQQ0lfQ09NTUFORCkgPT0gMHhGRkZGRkZGRikNCj4g
PiArCQkJY29udGludWU7DQo+ID4gKw0KPiA+ICsJCS8qIHBjaV9yZXNldF9zZWNvbmRhcnlfYnVz
KCkgKi8NCj4gPiArCQljdGwgPSByZWFkdyhiYXNlICsgUENJX0JSSURHRV9DT05UUk9MKTsNCj4g
PiArCQljdGwgfD0gUENJX0JSSURHRV9DVExfQlVTX1JFU0VUOw0KPiA+ICsJCXdyaXRldyhjdGws
IGJhc2UgKyBQQ0lfQlJJREdFX0NPTlRST0wpOw0KPiA+ICsJCXJlYWR3KGJhc2UgKyBQQ0lfQlJJ
REdFX0NPTlRST0wpOw0KPiA+ICsJCW1zbGVlcCgyKTsNCj4gPiArDQo+ID4gKwkJY3RsICY9IH5Q
Q0lfQlJJREdFX0NUTF9CVVNfUkVTRVQ7DQo+ID4gKwkJd3JpdGV3KGN0bCwgYmFzZSArIFBDSV9C
UklER0VfQ09OVFJPTCk7DQo+ID4gKwkJcmVhZHcoYmFzZSArIFBDSV9CUklER0VfQ09OVFJPTCk7
DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJc3NsZWVwKDEpOw0KPiA+ICsJcGNpX2lvdW5tYXAoZGV2
LCBjZmdiYXIpOw0KPiA+ICsJcmV0dXJuIDA7DQo+ID4gK30NCj4gPiArDQo+ID4gIC8qIERldmlj
ZS1zcGVjaWZpYyByZXNldCBtZXRob2QgZm9yIENoZWxzaW8gVDQtYmFzZWQgYWRhcHRlcnMgKi8N
Cj4gPiAgc3RhdGljIGludCByZXNldF9jaGVsc2lvX2dlbmVyaWNfZGV2KHN0cnVjdCBwY2lfZGV2
ICpkZXYsIGludCBwcm9iZSkNCj4gPiAgew0KPiA+IEBAIC0zOTE5LDYgKzM5NjIsMTEgQEAgc3Rh
dGljIGludCBkZWxheV8yNTBtc19hZnRlcl9mbHIoc3RydWN0IHBjaV9kZXYgKmRldiwgaW50IHBy
b2JlKQ0KPiA+ICAJCXJlc2V0X2l2Yl9pZ2QgfSwNCj4gPiAgCXsgUENJX1ZFTkRPUl9JRF9JTlRF
TCwgUENJX0RFVklDRV9JRF9JTlRFTF9JVkJfTTJfVkdBLA0KPiA+ICAJCXJlc2V0X2l2Yl9pZ2Qg
fSwNCj4gPiArCXsgUENJX1ZFTkRPUl9JRF9JTlRFTCwgUENJX0RFVklDRV9JRF9JTlRFTF9WTURf
MjAxRCwgcmVzZXRfdm1kX3NiciB9LA0KPiA+ICsJeyBQQ0lfVkVORE9SX0lEX0lOVEVMLCBQQ0lf
REVWSUNFX0lEX0lOVEVMX1ZNRF8yOEMwLCByZXNldF92bWRfc2JyIH0sDQo+ID4gKwl7IFBDSV9W
RU5ET1JfSURfSU5URUwsIDB4NDY3ZiwgcmVzZXRfdm1kX3NiciB9LA0KPiA+ICsJeyBQQ0lfVkVO
RE9SX0lEX0lOVEVMLCAweDRjM2QsIHJlc2V0X3ZtZF9zYnIgfSwNCj4gPiArCXsgUENJX1ZFTkRP
Ul9JRF9JTlRFTCwgUENJX0RFVklDRV9JRF9JTlRFTF9WTURfOUEwQiwgcmVzZXRfdm1kX3NiciB9
LA0KPiA+ICAJeyBQQ0lfVkVORE9SX0lEX1NBTVNVTkcsIDB4YTgwNCwgbnZtZV9kaXNhYmxlX2Fu
ZF9mbHIgfSwNCj4gPiAgCXsgUENJX1ZFTkRPUl9JRF9JTlRFTCwgMHgwOTUzLCBkZWxheV8yNTBt
c19hZnRlcl9mbHIgfSwNCj4gPiAgCXsgUENJX1ZFTkRPUl9JRF9DSEVMU0lPLCBQQ0lfQU5ZX0lE
LA0KPiA+IC0tIA0KPiA+IDEuOC4zLjENCj4gPiANCg==
