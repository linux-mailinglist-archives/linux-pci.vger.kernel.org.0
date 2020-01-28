Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82A4C14BE5A
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2020 18:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbgA1ROA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jan 2020 12:14:00 -0500
Received: from mga07.intel.com ([134.134.136.100]:50553 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbgA1ROA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 28 Jan 2020 12:14:00 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jan 2020 08:50:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,374,1574150400"; 
   d="scan'208";a="217665209"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by orsmga007.jf.intel.com with ESMTP; 28 Jan 2020 08:50:37 -0800
Received: from orsmsx112.amr.corp.intel.com (10.22.240.13) by
 ORSMSX102.amr.corp.intel.com (10.22.225.129) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 28 Jan 2020 08:50:37 -0800
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.100]) by
 ORSMSX112.amr.corp.intel.com ([169.254.3.36]) with mapi id 14.03.0439.000;
 Tue, 28 Jan 2020 08:50:36 -0800
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "Kalakota, SushmaX" <sushmax.kalakota@intel.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
CC:     "kbusch@kernel.org" <kbusch@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>
Subject: Re: [PATCH v3] PCI: vmd: Add two VMD Device IDs
Thread-Topic: [PATCH v3] PCI: vmd: Add two VMD Device IDs
Thread-Index: AQHVxm8hDoDGz5oM1Eew6W0GkAvE4KgA71yA
Date:   Tue, 28 Jan 2020 16:50:36 +0000
Message-ID: <95e7feafca42f6f5c20f05d827f2bca29525ade5.camel@intel.com>
References: <20200108220510.12063-1-sushmax.kalakota@intel.com>
In-Reply-To: <20200108220510.12063-1-sushmax.kalakota@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.255.0.144]
Content-Type: text/plain; charset="utf-8"
Content-ID: <4813E9BC3090EC459C9D54F8DF68FB85@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

R2VudGxlIHJlbWluZGVyIHRoaXMgb25lJ3MgZ29vZCB0byBnbw0KDQpPbiBXZWQsIDIwMjAtMDEt
MDggYXQgMTU6MDUgLTA3MDAsIFN1c2htYSBLYWxha290YSB3cm90ZToNCj4gQWRkIG5ldyBWTUQg
ZGV2aWNlIElEcyB0aGF0IHJlcXVpcmUgdGhlIGJ1cyByZXN0cmljdGlvbiBtb2RlLg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogU3VzaG1hIEthbGFrb3RhIDxzdXNobWF4LmthbGFrb3RhQGludGVsLmNv
bT4NCj4gU2lnbmVkLW9mZi1ieTogSm9uIERlcnJpY2sgPGpvbmF0aGFuLmRlcnJpY2tAaW50ZWwu
Y29tPg0KPiAtLS0NCj4gdjItPnYzIFJlbW92ZWQgZnJvbSBwY2lfaWRzLmgNCj4gdjEtPnYyIFNx
dWFzaGVkDQo+IA0KPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci92bWQuYyB8IDQgKysrKw0KPiAg
MSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvcGNpL2NvbnRyb2xsZXIvdm1kLmMgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3ZtZC5jDQo+
IGluZGV4IDIxMjg0MjI2M2Y1NS4uYzUwMmI2YzBkYWY1IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L3BjaS9jb250cm9sbGVyL3ZtZC5jDQo+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvdm1k
LmMNCj4gQEAgLTg2OCw2ICs4NjgsMTAgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBwY2lfZGV2aWNl
X2lkIHZtZF9pZHNbXSA9IHsNCj4gIAl7UENJX0RFVklDRShQQ0lfVkVORE9SX0lEX0lOVEVMLCBQ
Q0lfREVWSUNFX0lEX0lOVEVMX1ZNRF8yOEMwKSwNCj4gIAkJLmRyaXZlcl9kYXRhID0gVk1EX0ZF
QVRfSEFTX01FTUJBUl9TSEFET1cgfA0KPiAgCQkJCVZNRF9GRUFUX0hBU19CVVNfUkVTVFJJQ1RJ
T05TLH0sDQo+ICsJe1BDSV9ERVZJQ0UoUENJX1ZFTkRPUl9JRF9JTlRFTCwgMHg0NjdmKSwNCj4g
KwkJLmRyaXZlcl9kYXRhID0gVk1EX0ZFQVRfSEFTX0JVU19SRVNUUklDVElPTlMsfSwNCj4gKwl7
UENJX0RFVklDRShQQ0lfVkVORE9SX0lEX0lOVEVMLCAweDRjM2QpLA0KPiArCQkuZHJpdmVyX2Rh
dGEgPSBWTURfRkVBVF9IQVNfQlVTX1JFU1RSSUNUSU9OUyx9LA0KPiAgCXtQQ0lfREVWSUNFKFBD
SV9WRU5ET1JfSURfSU5URUwsIFBDSV9ERVZJQ0VfSURfSU5URUxfVk1EXzlBMEIpLA0KPiAgCQku
ZHJpdmVyX2RhdGEgPSBWTURfRkVBVF9IQVNfQlVTX1JFU1RSSUNUSU9OUyx9LA0KPiAgCXswLH0N
Cg==
