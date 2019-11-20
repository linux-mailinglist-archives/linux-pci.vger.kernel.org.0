Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 652CE1041A2
	for <lists+linux-pci@lfdr.de>; Wed, 20 Nov 2019 18:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbfKTRAF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Nov 2019 12:00:05 -0500
Received: from mga04.intel.com ([192.55.52.120]:33876 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728134AbfKTRAF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 20 Nov 2019 12:00:05 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2019 09:00:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,222,1571727600"; 
   d="scan'208";a="231994270"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
  by fmsmga004.fm.intel.com with ESMTP; 20 Nov 2019 09:00:04 -0800
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.229]) by
 ORSMSX109.amr.corp.intel.com ([169.254.11.161]) with mapi id 14.03.0439.000;
 Wed, 20 Nov 2019 09:00:04 -0800
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
CC:     "kbusch@kernel.org" <kbusch@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>
Subject: Re: [PATCH v2 1/2] PCI: vmd: Add bus 224-255 restriction decode
Thread-Topic: [PATCH v2 1/2] PCI: vmd: Add bus 224-255 restriction decode
Thread-Index: AQHVmYoDJjxVmnKcgk2CqrW1hBuLVKeU11UAgAADlAA=
Date:   Wed, 20 Nov 2019 17:00:03 +0000
Message-ID: <5f8820ad2c545d21c21e5e95429227ba2a35fef5.camel@intel.com>
References: <1573562873-96828-1-git-send-email-jonathan.derrick@intel.com>
         <1573562873-96828-2-git-send-email-jonathan.derrick@intel.com>
         <20191120164710.GB3279@e121166-lin.cambridge.arm.com>
In-Reply-To: <20191120164710.GB3279@e121166-lin.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.232.115.147]
Content-Type: text/plain; charset="utf-8"
Content-ID: <239C8525C74A4C4281A6D5AD84B3A46E@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gV2VkLCAyMDE5LTExLTIwIGF0IDE2OjQ3ICswMDAwLCBMb3JlbnpvIFBpZXJhbGlzaSB3cm90
ZToNCj4gT24gVHVlLCBOb3YgMTIsIDIwMTkgYXQgMDU6NDc6NTJBTSAtMDcwMCwgSm9uIERlcnJp
Y2sgd3JvdGU6DQo+ID4gVk1EIGJ1cyByZXN0cmljdGlvbnMgYXJlIHJlcXVpcmVkIHdoZW4gSU8g
ZmFicmljIGlzIG11bHRpcGxleGVkIHN1Y2gNCj4gPiB0aGF0IFZNRCBjYW5ub3QgdXNlIHRoZSBl
bnRpcmUgYnVzIHJhbmdlLiBUaGlzIHBhdGNoIGFkZHMgYW5vdGhlciBidXMNCj4gPiByZXN0cmlj
dGlvbiBkZWNvZGUgYml0IHRoYXQgY2FuIGJlIHNldCBieSBmaXJtd2FyZSB0byByZXN0cmljdCB0
aGUgVk1EDQo+ID4gYnVzIHJhbmdlIHRvIGJldHdlZW4gMjI0LTI1NS4NCj4gPiANCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBKb24gRGVycmljayA8am9uYXRoYW4uZGVycmlja0BpbnRlbC5jb20+DQo+ID4g
LS0tDQo+ID4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvdm1kLmMgfCAzMCArKysrKysrKysrKysr
KysrKysrKysrLS0tLS0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDIyIGluc2VydGlvbnMoKyks
IDggZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRy
b2xsZXIvdm1kLmMgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3ZtZC5jDQo+ID4gaW5kZXggYTM1
ZDNmMy4uMTUzMDJhMSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3Zt
ZC5jDQo+ID4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci92bWQuYw0KPiA+IEBAIC02MDIs
MTYgKzYwMiwzMCBAQCBzdGF0aWMgaW50IHZtZF9lbmFibGVfZG9tYWluKHN0cnVjdCB2bWRfZGV2
ICp2bWQsIHVuc2lnbmVkIGxvbmcgZmVhdHVyZXMpDQo+ID4gIA0KPiA+ICAJLyoNCj4gPiAgCSAq
IENlcnRhaW4gVk1EIGRldmljZXMgbWF5IGhhdmUgYSByb290IHBvcnQgY29uZmlndXJhdGlvbiBv
cHRpb24gd2hpY2gNCj4gPiAtCSAqIGxpbWl0cyB0aGUgYnVzIHJhbmdlIHRvIGJldHdlZW4gMC0x
Mjcgb3IgMTI4LTI1NQ0KPiA+ICsJICogbGltaXRzIHRoZSBidXMgcmFuZ2UgdG8gYmV0d2VlbiAw
LTEyNywgMTI4LTI1NSwgb3IgMjI0LTI1NQ0KPiA+ICAJICovDQo+ID4gIAlpZiAoZmVhdHVyZXMg
JiBWTURfRkVBVF9IQVNfQlVTX1JFU1RSSUNUSU9OUykgew0KPiA+IC0JCXUzMiB2bWNhcCwgdm1j
b25maWc7DQo+ID4gLQ0KPiA+IC0JCXBjaV9yZWFkX2NvbmZpZ19kd29yZCh2bWQtPmRldiwgUENJ
X1JFR19WTUNBUCwgJnZtY2FwKTsNCj4gPiAtCQlwY2lfcmVhZF9jb25maWdfZHdvcmQodm1kLT5k
ZXYsIFBDSV9SRUdfVk1DT05GSUcsICZ2bWNvbmZpZyk7DQo+ID4gLQkJaWYgKEJVU19SRVNUUklD
VF9DQVAodm1jYXApICYmDQo+ID4gLQkJICAgIChCVVNfUkVTVFJJQ1RfQ0ZHKHZtY29uZmlnKSA9
PSAweDEpKQ0KPiA+IC0JCQl2bWQtPmJ1c25fc3RhcnQgPSAxMjg7DQo+ID4gKwkJdTE2IHJlZzE2
Ow0KPiA+ICsNCj4gPiArCQlwY2lfcmVhZF9jb25maWdfd29yZCh2bWQtPmRldiwgUENJX1JFR19W
TUNBUCwgJnJlZzE2KTsNCj4gPiArCQlpZiAoQlVTX1JFU1RSSUNUX0NBUChyZWcxNikpIHsNCj4g
PiArCQkJcGNpX3JlYWRfY29uZmlnX3dvcmQodm1kLT5kZXYsIFBDSV9SRUdfVk1DT05GSUcsDQo+
ID4gKwkJCQkJICAgICAmcmVnMTYpOw0KPiA+ICsNCj4gPiArCQkJc3dpdGNoIChCVVNfUkVTVFJJ
Q1RfQ0ZHKHJlZzE2KSkgew0KPiA+ICsJCQljYXNlIDE6DQo+ID4gKwkJCQl2bWQtPmJ1c25fc3Rh
cnQgPSAxMjg7DQo+ID4gKwkJCQlicmVhazsNCj4gPiArCQkJY2FzZSAyOg0KPiA+ICsJCQkJdm1k
LT5idXNuX3N0YXJ0ID0gMjI0Ow0KPiA+ICsJCQkJYnJlYWs7DQo+ID4gKwkJCWNhc2UgMzoNCj4g
PiArCQkJCXBjaV9lcnIodm1kLT5kZXYsICJVbmtub3duIEJ1cyBPZmZzZXQgU2V0dGluZ1xuIik7
DQo+IA0KPiBUZWNobmljYWxseSB0aGlzIGVycm9yK21lc3NhZ2Ugc2hvdWxkIGJlIHByZXNlbnQg
aW4gdGhlIGN1cnJlbnQga2VybmVsDQo+IGFzIHdlbGwgYnV0IGFueXdheSwgSSBoYXZlIGFwcGxp
ZWQgdGhlIHNlcmllcyB0byBwY2kvdm1kLg0KQWdyZWVkLiBJdCB3YXMgYW4gYW1iaWd1b3VzIGRl
ZmluaXRpb24gaW4gYSBwcmV2aW91cyBzcGVjLg0KDQoNCj4gDQo+IFRoYW5rcywNCj4gTG9yZW56
bw0KVGhhbmsgeW91DQoNCg0KPiANCj4gPiArCQkJCXJldHVybiAtRU5PREVWOw0KPiA+ICsJCQlk
ZWZhdWx0Og0KPiA+ICsJCQkJYnJlYWs7DQo+ID4gKwkJCX0NCj4gPiArCQl9DQo+ID4gIAl9DQo+
ID4gIA0KPiA+ICAJcmVzID0gJnZtZC0+ZGV2LT5yZXNvdXJjZVtWTURfQ0ZHQkFSXTsNCj4gPiAt
LSANCj4gPiAxLjguMy4xDQo+ID4gDQo=
