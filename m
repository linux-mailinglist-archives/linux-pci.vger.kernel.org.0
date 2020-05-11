Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C154F1CDE85
	for <lists+linux-pci@lfdr.de>; Mon, 11 May 2020 17:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730369AbgEKPL6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 May 2020 11:11:58 -0400
Received: from mga02.intel.com ([134.134.136.20]:56314 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729439AbgEKPL5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 May 2020 11:11:57 -0400
IronPort-SDR: EA9ohjJdGwFV3KZFe+d4vUEcxqyd2R7g6rJzzMdTrHbMTQCetNgGtuR3X0p5SzgAUNgVYlMTY4
 TzajbjP9Qndg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2020 08:11:57 -0700
IronPort-SDR: iWvHlVulKfmq2k8WG167U4maE8HkHLOYNQK+cQ+H09CbJEG11kEavg4dCTqeNwS+MrzuUzHauM
 GR801k1gGpOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,380,1583222400"; 
   d="scan'208";a="463203390"
Received: from orsmsx103.amr.corp.intel.com ([10.22.225.130])
  by fmsmga005.fm.intel.com with ESMTP; 11 May 2020 08:11:56 -0700
Received: from orsmsx114.amr.corp.intel.com (10.22.240.10) by
 ORSMSX103.amr.corp.intel.com (10.22.225.130) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 11 May 2020 08:11:56 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.204]) by
 ORSMSX114.amr.corp.intel.com ([169.254.8.99]) with mapi id 14.03.0439.000;
 Mon, 11 May 2020 08:11:56 -0700
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "thomas.petazzoni@bootlin.com" <thomas.petazzoni@bootlin.com>,
        "rmk+kernel@armlinux.org.uk" <rmk+kernel@armlinux.org.uk>
Subject: Re: [PATCH 3/5] PCI: pci-bridge-emul: Convert to GENMASK and BIT
Thread-Topic: [PATCH 3/5] PCI: pci-bridge-emul: Convert to GENMASK and BIT
Thread-Index: AQHWEp2a4ZwOLz33HU2mmQddOoKGFKh70c4AgAB2/YCAJv7pAIAAVRyA
Date:   Mon, 11 May 2020 15:11:55 +0000
Message-ID: <866a9330a57266a586bb0283e97abfcab07cc5db.camel@intel.com>
References: <20200414203005.5166-1-jonathan.derrick@intel.com>
         <20200414203005.5166-4-jonathan.derrick@intel.com>
         <20200416073004.GB32000@infradead.org>
         <47e4b64208ec1f8400a420db434cbbd8322cbbd8.camel@intel.com>
         <20200511100610.GB24149@e121166-lin.cambridge.arm.com>
In-Reply-To: <20200511100610.GB24149@e121166-lin.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.255.64.94]
Content-Type: text/plain; charset="utf-8"
Content-ID: <5647B4E0DC3CA6419B89D7EFB118513C@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gTW9uLCAyMDIwLTA1LTExIGF0IDExOjA2ICswMTAwLCBMb3JlbnpvIFBpZXJhbGlzaSB3cm90
ZToNCj4gT24gVGh1LCBBcHIgMTYsIDIwMjAgYXQgMDI6MzU6NTlQTSArMDAwMCwgRGVycmljaywg
Sm9uYXRoYW4gd3JvdGU6DQo+ID4gT24gVGh1LCAyMDIwLTA0LTE2IGF0IDAwOjMwIC0wNzAwLCBD
aHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4gPiA+IE9uIFR1ZSwgQXByIDE0LCAyMDIwIGF0IDA0
OjMwOjAzUE0gLTA0MDAsIEpvbiBEZXJyaWNrIHdyb3RlOg0KPiA+ID4gPiBJbiBvcmRlciB0byBt
YWtlIHBjaS1icmlkZ2UtZW11bCBlYXNpZXIgdG8ga2VlcCB1cC10by1kYXRlIHdpdGggbmV3IFBD
SWUNCj4gPiA+ID4gZmVhdHVyZXMsIGNvbnZlcnQgYWxsIG5hbWVkIHJlZ2lzdGVyIGJpdHMgdG8g
R0VOTUFTSyBhbmQgQklUIHBhaXJzLiBUaGlzDQo+ID4gPiA+IHBhdGNoIGRvZXNuJ3QgYWx0ZXIg
YW55IG9mIHRoZSBQQ0kgY29uZmlndXJhdGlvbiBzcGFjZSBhcyB0aGVzZSBiaXRzIGFyZQ0KPiA+
ID4gPiBmdWxseSBkZWZpbmVkLg0KPiA+ID4gPiANCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogSm9u
IERlcnJpY2sgPGpvbmF0aGFuLmRlcnJpY2tAaW50ZWwuY29tPg0KPiA+ID4gPiAtLS0NCj4gPiA+
ID4gIGRyaXZlcnMvcGNpL3BjaS1icmlkZ2UtZW11bC5jIHwgMTcgKysrKysrLS0tLS0tLS0tLS0N
Cj4gPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygt
KQ0KPiA+ID4gPiANCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL3BjaS1icmlkZ2Ut
ZW11bC5jIGIvZHJpdmVycy9wY2kvcGNpLWJyaWRnZS1lbXVsLmMNCj4gPiA+ID4gaW5kZXggYzAw
YzMwZmZiMTk4Li5iYmNjY2FkY2E4NWUgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2RyaXZlcnMvcGNp
L3BjaS1icmlkZ2UtZW11bC5jDQo+ID4gPiA+ICsrKyBiL2RyaXZlcnMvcGNpL3BjaS1icmlkZ2Ut
ZW11bC5jDQo+ID4gPiA+IEBAIC0yMjEsMTEgKzIyMSw4IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qg
cGNpX2JyaWRnZV9yZWdfYmVoYXZpb3IgcGNpZV9jYXBfcmVnc19iZWhhdmlvcltdID0gew0KPiA+
ID4gPiAgCQkgKiBhcyByZXNlcnZlZCBiaXRzLg0KPiA+ID4gPiAgCQkgKi8NCj4gPiA+ID4gIAkJ
LnJ3ID0gR0VOTUFTSygxMiwgMCksDQo+ID4gPiA+IC0JCS53MWMgPSAoUENJX0VYUF9TTFRTVEFf
QUJQIHwgUENJX0VYUF9TTFRTVEFfUEZEIHwNCj4gPiA+ID4gLQkJCVBDSV9FWFBfU0xUU1RBX01S
TFNDIHwgUENJX0VYUF9TTFRTVEFfUERDIHwNCj4gPiA+ID4gLQkJCVBDSV9FWFBfU0xUU1RBX0ND
IHwgUENJX0VYUF9TTFRTVEFfRExMU0MpIDw8IDE2LA0KPiA+ID4gPiAtCQkucm8gPSAoUENJX0VY
UF9TTFRTVEFfTVJMU1MgfCBQQ0lfRVhQX1NMVFNUQV9QRFMgfA0KPiA+ID4gPiAtCQkgICAgICAg
UENJX0VYUF9TTFRTVEFfRUlTKSA8PCAxNiwNCj4gPiA+ID4gKwkJLncxYyA9IChCSVQoOCkgfCBH
RU5NQVNLKDQsIDApKSA8PCAxNiwNCj4gPiA+ID4gKwkJLnJvID0gR0VOTUFTSyg3LCA1KSA8PCAx
NiwNCj4gPiA+IA0KPiA+ID4gRllJLCBJIGZpbmQgdGhlIHByZXZpb3VzIHZlcnNpb24gYSBsb3Qg
bW9yZSByZWFkYWJsZS4gIE9yIHJhdGhlciBJIGZpbmQNCj4gPiA+IGl0IHJlYWRhYmxlIHdoaWxl
IHRoZSBuZXcgb25lIGxvb2tzIGxpa2UgaW50ZW50aW9uYWxseSBvYnNmdWNhdGVkDQo+ID4gPiBn
YXJiYWdlIHRvIG1lLg0KPiA+IA0KPiA+IFdlbGwgSSBndWVzcyB0aGF0J3MgZW50aXJlbHkgc3Vi
amVjdGl2ZS4gQnV0IEkgZG8gdGhpbmsgaWYgYWxsIHRoZQ0KPiA+IGV4aXN0aW5nIEJJVCBhbmQg
R0VOTUFTSyB3ZXJlIGNvbnZlcnRlZCB0byBuYW1lZCByZWdpc3RlcnMgaW5zdGVhZCwgaXQNCj4g
PiB3b3VsZCBiZSBhIGxvdCBlYXNpZXIgdG8gb3Zlcmxvb2sgbWlzdGFrZXMuDQo+IA0KPiBIaSBK
b24sDQo+IA0KPiB3aGVyZSBhcmUgd2Ugd2l0aCB0aGlzIHBhdGNoID8gSWYgd2UgZHJvcCBpdCBJ
IGFzc3VtZSB5b3Ugd2lsbCBoYXZlDQo+IHRvIHJlYmFzZSBzdWJzZXF1ZW50IHBhdGNoZXMgLSBJ
IGRvIHRoaW5rIENocmlzdG9waCBoYXMgYSBwb2ludCBoZXJlLg0KPiANCj4gVGhhbmtzLA0KPiBM
b3JlbnpvDQoNCkknbGwgcG9zdCB2MiB3aXRob3V0IDMgaW4gYSBiaXQNCg==
