Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1E75132F4F
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2020 20:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728633AbgAGTXC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Jan 2020 14:23:02 -0500
Received: from mga18.intel.com ([134.134.136.126]:38401 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728307AbgAGTXB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 7 Jan 2020 14:23:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jan 2020 11:23:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,407,1571727600"; 
   d="scan'208";a="217847246"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by fmsmga008.fm.intel.com with ESMTP; 07 Jan 2020 11:22:50 -0800
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.147]) by
 ORSMSX107.amr.corp.intel.com ([169.254.1.58]) with mapi id 14.03.0439.000;
 Tue, 7 Jan 2020 11:22:50 -0800
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "kbusch@kernel.org" <kbusch@kernel.org>,
        "Kalakota, SushmaX" <sushmax.kalakota@intel.com>
CC:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>
Subject: Re: [PATCH 2/2] PCI: vmd: Add device id for VMD device 8086:467F
Thread-Topic: [PATCH 2/2] PCI: vmd: Add device id for VMD device 8086:467F
Thread-Index: AQHVxOHfBS8aoRB1SEWYa+dlTiYrs6fgGWCAgAACeIA=
Date:   Tue, 7 Jan 2020 19:22:49 +0000
Message-ID: <f6bebb58f3c86980d4fb5c387e1a357a2e152e42.camel@intel.com>
References: <20200106224122.3231-1-sushmax.kalakota@intel.com>
         <20200106224122.3231-3-sushmax.kalakota@intel.com>
         <20200107191317.GA610403@chuupie.wdl.wdc.com>
In-Reply-To: <20200107191317.GA610403@chuupie.wdl.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.232.115.159]
Content-Type: text/plain; charset="utf-8"
Content-ID: <6A0F9D64C3241D498F30CF18260FEF81@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

VGhhbmtzIEtlaXRoLA0KDQpPbiBUdWUsIDIwMjAtMDEtMDcgYXQgMTI6MTMgLTA3MDAsIEtlaXRo
IEJ1c2NoIHdyb3RlOg0KPiBPbiBNb24sIEphbiAwNiwgMjAyMCBhdCAwMzo0MToyMlBNIC0wNzAw
LCBTdXNobWEgS2FsYWtvdGEgd3JvdGU6DQo+ID4gVGhpcyBwYXRjaCBhZGRzIHN1cHBvcnQgZm9y
IHRoaXMgVk1EIGRldmljZSB3aGljaCBzdXBwb3J0cyB0aGUgYnVzDQo+ID4gcmVzdHJpY3Rpb24g
bW9kZS4NCj4gDQo+IFN1Z2dlc3RlZCByZXBocmFzaW5nIHRvIGFuIGltcGVyYXRpdmUgdm9pY2U6
DQo+IA0KPiAgIEFkZCBuZXcgVk1EIGRldmljZSBJRHMgdGhhdCByZXF1aXJlIHRoZSBidXMgcmVz
dHJpY3Rpb24gbW9kZS4NCj4gDQpTdXJlDQoNCj4gPiBTaWduZWQtb2ZmLWJ5OiBKb24gRGVycmlj
ayA8am9uYXRoYW4uZGVycmlja0BpbnRlbC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogU3VzaG1h
IEthbGFrb3RhIDxzdXNobWF4LmthbGFrb3RhQGludGVsLmNvbT4NCj4gDQo+IFRoZSBmaXJzdCBz
aWduLW9mZiBzaG91bGQgYmUgdGhlIGF1dGhvciwgYnV0IHRoZXJlJ3Mgbm8gIkZyb206IiBoZWFk
ZXINCj4gbGluZSBmb3IgSm9uLiBJcyB0aGUgYXR0cmlidXRpb24gY29ycmVjdD8NCldlIGJvdGgg
d29ya2VkIG9uIHRoaXMsIHRob3VnaCBpdCB3YXMgcHJpbWFyaWx5IFN1c2htYS4NCldlJ2xsIHN3
aXRjaCB0aGUgYXR0cmlidXRpb24gb3JkZXIgcGVyIA0KaHR0cHM6Ly93d3cua2VybmVsLm9yZy9k
b2MvaHRtbC92NC4xNy9wcm9jZXNzL3N1Ym1pdHRpbmctcGF0Y2hlcy5odG1sI3NpZ24teW91ci13
b3JrLXRoZS1kZXZlbG9wZXItcy1jZXJ0aWZpY2F0ZS1vZi1vcmlnaW4NCg0KDQo+IA0KPiA+IEBA
IC04NjgsNiArODY4LDggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBwY2lfZGV2aWNlX2lkIHZtZF9p
ZHNbXSA9IHsNCj4gPiAgCXtQQ0lfREVWSUNFKFBDSV9WRU5ET1JfSURfSU5URUwsIFBDSV9ERVZJ
Q0VfSURfSU5URUxfVk1EXzI4QzApLA0KPiA+ICAJCS5kcml2ZXJfZGF0YSA9IFZNRF9GRUFUX0hB
U19NRU1CQVJfU0hBRE9XIHwNCj4gPiAgCQkJCVZNRF9GRUFUX0hBU19CVVNfUkVTVFJJQ1RJT05T
LH0sDQo+ID4gKwl7UENJX0RFVklDRShQQ0lfVkVORE9SX0lEX0lOVEVMLCBQQ0lfREVWSUNFX0lE
X0lOVEVMX1ZNRF80NjdGKSwNCj4gPiArCQkuZHJpdmVyX2RhdGEgPSBWTURfRkVBVF9IQVNfQlVT
X1JFU1RSSUNUSU9OUyx9LA0KPiA+ICAJe1BDSV9ERVZJQ0UoUENJX1ZFTkRPUl9JRF9JTlRFTCwg
UENJX0RFVklDRV9JRF9JTlRFTF9WTURfNEMzRCksDQo+ID4gIAkJLmRyaXZlcl9kYXRhID0gVk1E
X0ZFQVRfSEFTX0JVU19SRVNUUklDVElPTlMsfSwNCj4gDQo+IFNpbmNlIHlvdSBrbm93IGFsbCB0
aGUgbmV3IGRldmljZSBpZHMsIG1pZ2h0IGFzIHdlbGwgY29sbGFwc2UgdGhpcyBwYXRjaA0KPiB3
aXRoIHRoZSBmaXJzdCBvbmUgZnJvbSB0aGlzIHNlcmllcy4NClN1cmUNCg==
