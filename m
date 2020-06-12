Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE7D1F7A6C
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jun 2020 17:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbgFLPLR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Jun 2020 11:11:17 -0400
Received: from mga09.intel.com ([134.134.136.24]:16985 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbgFLPLR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Jun 2020 11:11:17 -0400
IronPort-SDR: HUiCym2u5oAucKpHPMLIaH4mili8nEQVNYbX+/Geq1d+3/QLnGBavlnKTlCa5YMHTju+CKrk6y
 06USnvGvZeTQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2020 08:11:16 -0700
IronPort-SDR: gWYtmwS4CqAZdgOvyx7dX8ZDmyOqJ8Y4Fncp77qtakbVb+6bOLwLOrg3dsdSHXoyVoGIl5GBnZ
 RVwuMDRwmTLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,503,1583222400"; 
   d="scan'208";a="271925759"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
  by orsmga003.jf.intel.com with ESMTP; 12 Jun 2020 08:11:16 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.250]) by
 ORSMSX108.amr.corp.intel.com ([169.254.2.62]) with mapi id 14.03.0439.000;
 Fri, 12 Jun 2020 08:11:16 -0700
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>
CC:     "hch@lst.de" <hch@lst.de>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "andrzej.jakowski@linux.intel.com" <andrzej.jakowski@linux.intel.com>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>
Subject: Re: [PATCH v3 1/2] PCI: vmd: Filter resource type bits from shadow
 register
Thread-Topic: [PATCH v3 1/2] PCI: vmd: Filter resource type bits from shadow
 register
Thread-Index: AQHWNJ6/KA9BUx6s/UuCJV3Lsz6Rn6i/VTmAgABYZACAAAgMAIAUwX2AgAEXAYCAABUAgA==
Date:   Fri, 12 Jun 2020 15:11:15 +0000
Message-ID: <8466e3ff386547a3bbaf578c3099dd12d545a7f8.camel@intel.com>
References: <20200528030240.16024-1-jonathan.derrick@intel.com>
         <20200528030240.16024-3-jonathan.derrick@intel.com>
         <20200529103315.GC12270@e121166-lin.cambridge.arm.com>
         <163e8cb37ece0c8daa6d6e5fd7fcae47ba4fa437.camel@intel.com>
         <20200529161824.GA17642@e121166-lin.cambridge.arm.com>
         <f1d36b8fc4ab7aacf6efca19303b04a5b4f8189c.camel@intel.com>
         <20200612135443.GA25653@e121166-lin.cambridge.arm.com>
In-Reply-To: <20200612135443.GA25653@e121166-lin.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.209.129.249]
Content-Type: text/plain; charset="utf-8"
Content-ID: <D2235C0C9FC0184E9366125CF83DC4A3@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gRnJpLCAyMDIwLTA2LTEyIGF0IDE0OjU0ICswMTAwLCBMb3JlbnpvIFBpZXJhbGlzaSB3cm90
ZToNCj4gT24gVGh1LCBKdW4gMTEsIDIwMjAgYXQgMDk6MTY6NDhQTSArMDAwMCwgRGVycmljaywg
Sm9uYXRoYW4gd3JvdGU6DQo+IA0KPiBbLi4uXQ0KPiANCj4gPiA+ID4gPiBIaSBKb24sDQo+ID4g
PiA+ID4gDQo+ID4gPiA+ID4gaXQgbG9va3MgbGlrZSBJIGNhbiB0YWtlIHRoaXMgcGF0Y2ggZm9y
IHY1Ljggd2hlcmVhcyBwYXRjaCAyIGRlcGVuZHMNCj4gPiA+ID4gPiBvbiB0aGUgUUVNVSBjaGFu
Z2VzIGFjY2VwdGFuY2UgYW5kIHNob3VsZCBwcm9iYWJseSB3YWl0Lg0KPiA+ID4gPiA+IA0KPiA+
ID4gPiA+IFBsZWFzZSBsZXQgbWUga25vdyB5b3VyIHRob3VnaHRzIGFzYXAgYW5kIEkgd2lsbCB0
cnkgdG8gYXQgbGVhc3QNCj4gPiA+ID4gPiBzcXVlZXplIHRoaXMgcGF0Y2ggaW4uDQo+ID4gPiA+
ID4gDQo+ID4gPiA+ID4gTG9yZW56bw0KPiA+ID4gPiANCj4gPiA+ID4gSGkgTG9yZW56bywNCj4g
PiA+ID4gDQo+ID4gPiA+IFRoaXMgaXMgZmluZS4gUGxlYXNlIHRha2UgUGF0Y2ggMS4NCj4gPiA+
ID4gUGF0Y2ggMiBpcyBoYXJtbGVzcyB3aXRob3V0IHRoZSBRRU1VIGNoYW5nZXMsIGJ1dCBtYXkg
YWx3YXlzIG5lZWQgYQ0KPiA+ID4gPiBkaWZmZXJlbnQgYXBwcm9hY2guDQo+ID4gPiANCj4gPiA+
IFB1bGxlZCBwYXRjaCAxIGludG8gcGNpL3ZtZCwgdGhhbmtzLg0KPiA+ID4gDQo+ID4gPiBMb3Jl
bnpvDQo+ID4gDQo+ID4gSGkgTG9yZW56bywNCj4gPiANCj4gPiBBbGV4IGhhcyBwci1lZCB0aGUg
UUVNVSBwYXRjaCBbMV0NCj4gPiBJcyBpdCB0b28gbGF0ZSB0byBwdWxsIHBhdGNoIDIvMiBmb3Ig
djUuOD8NCj4gDQo+IEkgdGhpbmsgaXQgaXMgLSBJIGRvbid0IGtub3cgaWYgQmpvcm4gcGxhbm5l
ZCBhIHNlY29uZCBQUiBmb3IgdGhpcw0KPiBtZXJnZSB3aW5kb3csIGlmIG5vdCBpdCBpcyB2NS45
IG1hdGVyaWFsIEkgYW0gYWZyYWlkLg0KPiANCj4gVGhhbmtzLA0KPiBMb3JlbnpvDQo+IA0KPiA+
IFsxXSANCj4gPiBodHRwczovL2dpdGh1Yi5jb20vYXdpbGxpYW0vcWVtdS12ZmlvL3JlbGVhc2Vz
L3RhZy92ZmlvLXVwZGF0ZS0yMDIwMDYxMS4wDQoNCk5vIHByb2JsZW0NCkpvbg0K
