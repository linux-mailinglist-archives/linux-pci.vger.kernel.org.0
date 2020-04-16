Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F14A31AC639
	for <lists+linux-pci@lfdr.de>; Thu, 16 Apr 2020 16:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732480AbgDPOgE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Apr 2020 10:36:04 -0400
Received: from mga01.intel.com ([192.55.52.88]:61312 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731215AbgDPOgC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 16 Apr 2020 10:36:02 -0400
IronPort-SDR: F6uq4FAKuH64T8xFxBkGy35jLi2MkDDLQows8yfvbuG38P7sefj3thhygYsfQKMl/8p3sdLt0p
 FQHrr2NG4vTA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2020 07:36:01 -0700
IronPort-SDR: SROi9I5Y4DMuAAwFHH+FCbgLmbU9xuG4npbsAjItBf2ngT4l9phTfNGbTKf6WKvkRkFUzG/d6R
 E7eD6MtKVPvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,391,1580803200"; 
   d="scan'208";a="277128372"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by orsmga008.jf.intel.com with ESMTP; 16 Apr 2020 07:36:00 -0700
Received: from orsmsx159.amr.corp.intel.com (10.22.240.24) by
 ORSMSX105.amr.corp.intel.com (10.22.225.132) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 16 Apr 2020 07:36:00 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.204]) by
 ORSMSX159.amr.corp.intel.com ([169.254.11.47]) with mapi id 14.03.0439.000;
 Thu, 16 Apr 2020 07:36:00 -0700
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "hch@infradead.org" <hch@infradead.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "thomas.petazzoni@bootlin.com" <thomas.petazzoni@bootlin.com>,
        "rmk+kernel@armlinux.org.uk" <rmk+kernel@armlinux.org.uk>
Subject: Re: [PATCH 3/5] PCI: pci-bridge-emul: Convert to GENMASK and BIT
Thread-Topic: [PATCH 3/5] PCI: pci-bridge-emul: Convert to GENMASK and BIT
Thread-Index: AQHWEp2a4ZwOLz33HU2mmQddOoKGFKh70c4AgAB2/YA=
Date:   Thu, 16 Apr 2020 14:35:59 +0000
Message-ID: <47e4b64208ec1f8400a420db434cbbd8322cbbd8.camel@intel.com>
References: <20200414203005.5166-1-jonathan.derrick@intel.com>
         <20200414203005.5166-4-jonathan.derrick@intel.com>
         <20200416073004.GB32000@infradead.org>
In-Reply-To: <20200416073004.GB32000@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.255.0.232]
Content-Type: text/plain; charset="utf-8"
Content-ID: <8A50CC0FF1D3E24B8C7D26B3F13617F2@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVGh1LCAyMDIwLTA0LTE2IGF0IDAwOjMwIC0wNzAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToNCj4gT24gVHVlLCBBcHIgMTQsIDIwMjAgYXQgMDQ6MzA6MDNQTSAtMDQwMCwgSm9uIERlcnJp
Y2sgd3JvdGU6DQo+ID4gSW4gb3JkZXIgdG8gbWFrZSBwY2ktYnJpZGdlLWVtdWwgZWFzaWVyIHRv
IGtlZXAgdXAtdG8tZGF0ZSB3aXRoIG5ldyBQQ0llDQo+ID4gZmVhdHVyZXMsIGNvbnZlcnQgYWxs
IG5hbWVkIHJlZ2lzdGVyIGJpdHMgdG8gR0VOTUFTSyBhbmQgQklUIHBhaXJzLiBUaGlzDQo+ID4g
cGF0Y2ggZG9lc24ndCBhbHRlciBhbnkgb2YgdGhlIFBDSSBjb25maWd1cmF0aW9uIHNwYWNlIGFz
IHRoZXNlIGJpdHMgYXJlDQo+ID4gZnVsbHkgZGVmaW5lZC4NCj4gPiANCj4gPiBTaWduZWQtb2Zm
LWJ5OiBKb24gRGVycmljayA8am9uYXRoYW4uZGVycmlja0BpbnRlbC5jb20+DQo+ID4gLS0tDQo+
ID4gIGRyaXZlcnMvcGNpL3BjaS1icmlkZ2UtZW11bC5jIHwgMTcgKysrKysrLS0tLS0tLS0tLS0N
Cj4gPiAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pDQo+
ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL3BjaS1icmlkZ2UtZW11bC5jIGIvZHJp
dmVycy9wY2kvcGNpLWJyaWRnZS1lbXVsLmMNCj4gPiBpbmRleCBjMDBjMzBmZmIxOTguLmJiY2Nj
YWRjYTg1ZSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3BjaS9wY2ktYnJpZGdlLWVtdWwuYw0K
PiA+ICsrKyBiL2RyaXZlcnMvcGNpL3BjaS1icmlkZ2UtZW11bC5jDQo+ID4gQEAgLTIyMSwxMSAr
MjIxLDggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBwY2lfYnJpZGdlX3JlZ19iZWhhdmlvciBwY2ll
X2NhcF9yZWdzX2JlaGF2aW9yW10gPSB7DQo+ID4gIAkJICogYXMgcmVzZXJ2ZWQgYml0cy4NCj4g
PiAgCQkgKi8NCj4gPiAgCQkucncgPSBHRU5NQVNLKDEyLCAwKSwNCj4gPiAtCQkudzFjID0gKFBD
SV9FWFBfU0xUU1RBX0FCUCB8IFBDSV9FWFBfU0xUU1RBX1BGRCB8DQo+ID4gLQkJCVBDSV9FWFBf
U0xUU1RBX01STFNDIHwgUENJX0VYUF9TTFRTVEFfUERDIHwNCj4gPiAtCQkJUENJX0VYUF9TTFRT
VEFfQ0MgfCBQQ0lfRVhQX1NMVFNUQV9ETExTQykgPDwgMTYsDQo+ID4gLQkJLnJvID0gKFBDSV9F
WFBfU0xUU1RBX01STFNTIHwgUENJX0VYUF9TTFRTVEFfUERTIHwNCj4gPiAtCQkgICAgICAgUENJ
X0VYUF9TTFRTVEFfRUlTKSA8PCAxNiwNCj4gPiArCQkudzFjID0gKEJJVCg4KSB8IEdFTk1BU0so
NCwgMCkpIDw8IDE2LA0KPiA+ICsJCS5ybyA9IEdFTk1BU0soNywgNSkgPDwgMTYsDQo+IA0KPiBG
WUksIEkgZmluZCB0aGUgcHJldmlvdXMgdmVyc2lvbiBhIGxvdCBtb3JlIHJlYWRhYmxlLiAgT3Ig
cmF0aGVyIEkgZmluZA0KPiBpdCByZWFkYWJsZSB3aGlsZSB0aGUgbmV3IG9uZSBsb29rcyBsaWtl
IGludGVudGlvbmFsbHkgb2JzZnVjYXRlZA0KPiBnYXJiYWdlIHRvIG1lLg0KDQpXZWxsIEkgZ3Vl
c3MgdGhhdCdzIGVudGlyZWx5IHN1YmplY3RpdmUuIEJ1dCBJIGRvIHRoaW5rIGlmIGFsbCB0aGUN
CmV4aXN0aW5nIEJJVCBhbmQgR0VOTUFTSyB3ZXJlIGNvbnZlcnRlZCB0byBuYW1lZCByZWdpc3Rl
cnMgaW5zdGVhZCwgaXQNCndvdWxkIGJlIGEgbG90IGVhc2llciB0byBvdmVybG9vayBtaXN0YWtl
cy4NCg==
