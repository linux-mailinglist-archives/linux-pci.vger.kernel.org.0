Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B66601F6F45
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jun 2020 23:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbgFKVQv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Jun 2020 17:16:51 -0400
Received: from mga18.intel.com ([134.134.136.126]:47108 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726186AbgFKVQv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Jun 2020 17:16:51 -0400
IronPort-SDR: HdHGNNhiqE/b+tntMXJnGqZ/rK2H0qrVMerG50F6h8ytxWyGK4z9kLXrqsn8Ig1p+bF1A9XjFf
 CFuJ+NhuMDFA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2020 14:16:50 -0700
IronPort-SDR: u+tXLqzRyd+zHsf/JJDI9ZiTv3gWJtMM94LaYd+rYqmUS7aSwvkPbOLyf5qfKTne2GAdAn7qNH
 owA/ehE0GJWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,501,1583222400"; 
   d="scan'208";a="473962908"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by fmsmga005.fm.intel.com with ESMTP; 11 Jun 2020 14:16:50 -0700
Received: from orsmsx125.amr.corp.intel.com (10.22.240.125) by
 ORSMSX104.amr.corp.intel.com (10.22.225.131) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 11 Jun 2020 14:16:49 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.250]) by
 ORSMSX125.amr.corp.intel.com ([169.254.3.61]) with mapi id 14.03.0439.000;
 Thu, 11 Jun 2020 14:16:49 -0700
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
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
Thread-Index: AQHWNJ6/KA9BUx6s/UuCJV3Lsz6Rn6i/VTmAgABYZACAAAgMAIAUwX2A
Date:   Thu, 11 Jun 2020 21:16:48 +0000
Message-ID: <f1d36b8fc4ab7aacf6efca19303b04a5b4f8189c.camel@intel.com>
References: <20200528030240.16024-1-jonathan.derrick@intel.com>
         <20200528030240.16024-3-jonathan.derrick@intel.com>
         <20200529103315.GC12270@e121166-lin.cambridge.arm.com>
         <163e8cb37ece0c8daa6d6e5fd7fcae47ba4fa437.camel@intel.com>
         <20200529161824.GA17642@e121166-lin.cambridge.arm.com>
In-Reply-To: <20200529161824.GA17642@e121166-lin.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.251.23.49]
Content-Type: text/plain; charset="utf-8"
Content-ID: <66D5545A7F2B504AB19EF890BBF933F1@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gRnJpLCAyMDIwLTA1LTI5IGF0IDE3OjE4ICswMTAwLCBMb3JlbnpvIFBpZXJhbGlzaSB3cm90
ZToNCj4gT24gRnJpLCBNYXkgMjksIDIwMjAgYXQgMDM6NTM6MzdQTSArMDAwMCwgRGVycmljaywg
Sm9uYXRoYW4gd3JvdGU6DQo+ID4gT24gRnJpLCAyMDIwLTA1LTI5IGF0IDExOjMzICswMTAwLCBM
b3JlbnpvIFBpZXJhbGlzaSB3cm90ZToNCj4gPiA+IE9uIFdlZCwgTWF5IDI3LCAyMDIwIGF0IDEx
OjAyOjM5UE0gLTA0MDAsIEpvbiBEZXJyaWNrIHdyb3RlOg0KPiA+ID4gPiBWZXJzaW9ucyBvZiBW
TUQgd2l0aCB0aGUgSG9zdCBQaHlzaWNhbCBBZGRyZXNzIHNoYWRvdyByZWdpc3RlciB1c2UgdGhp
cw0KPiA+ID4gPiByZWdpc3RlciB0byBjYWxjdWxhdGUgdGhlIGJ1cyBhZGRyZXNzIG9mZnNldCBu
ZWVkZWQgdG8gZG8gZ3Vlc3QNCj4gPiA+ID4gcGFzc3Rocm91Z2ggb2YgdGhlIGRvbWFpbi4gVGhp
cyByZWdpc3RlciBzaGFkb3dzIHRoZSBIb3N0IFBoeXNpY2FsDQo+ID4gPiA+IEFkZHJlc3MgcmVn
aXN0ZXJzIGluY2x1ZGluZyB0aGUgcmVzb3VyY2UgdHlwZSBiaXRzLiBBZnRlciBjYWxjdWxhdGlu
Zw0KPiA+ID4gPiB0aGUgb2Zmc2V0LCB0aGUgZXh0cmEgcmVzb3VyY2UgdHlwZSBiaXRzIGxlYWQg
dG8gdGhlIFZNRCByZXNvdXJjZXMgYmVpbmcNCj4gPiA+ID4gb3Zlci1wcm92aXNpb25lZCBhdCB0
aGUgZnJvbnQgYW5kIHVuZGVyLXByb3Zpc2lvbmVkIGF0IHRoZSBiYWNrLg0KPiA+ID4gPiANCj4g
PiA+ID4gRXhhbXBsZToNCj4gPiA+ID4gcGNpIDEwMDAwOjgwOjAyLjA6IHJlZyAweDEwOiBbbWVt
IDB4ZjgwMWZmZmMtMHhmODAzZmZmYiA2NGJpdF0NCj4gPiA+ID4gDQo+ID4gPiA+IEV4cGVjdGVk
Og0KPiA+ID4gPiBwY2kgMTAwMDA6ODA6MDIuMDogcmVnIDB4MTA6IFttZW0gMHhmODAyMDAwMC0w
eGY4MDNmZmZmIDY0Yml0XQ0KPiA+ID4gPiANCj4gPiA+ID4gSWYgb3RoZXIgZGV2aWNlcyBhcmUg
bWFwcGVkIGluIHRoZSBvdmVyLXByb3Zpc2lvbmVkIGZyb250LCBpdCBjb3VsZCBsZWFkDQo+ID4g
PiA+IHRvIHJlc291cmNlIGNvbmZsaWN0IGlzc3VlcyB3aXRoIFZNRCBvciB0aG9zZSBkZXZpY2Vz
Lg0KPiA+ID4gPiANCj4gPiA+ID4gRml4ZXM6IGExYTMwMTcwMTM4YzkgKCJQQ0k6IHZtZDogRml4
IHNoYWRvdyBvZmZzZXRzIHRvIHJlZmxlY3Qgc3BlYyBjaGFuZ2VzIikNCj4gPiA+ID4gU2lnbmVk
LW9mZi1ieTogSm9uIERlcnJpY2sgPGpvbmF0aGFuLmRlcnJpY2tAaW50ZWwuY29tPg0KPiA+ID4g
PiAtLS0NCj4gPiA+ID4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvdm1kLmMgfCA2ICsrKystLQ0K
PiA+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkN
Cj4gPiA+IA0KPiA+ID4gSGkgSm9uLA0KPiA+ID4gDQo+ID4gPiBpdCBsb29rcyBsaWtlIEkgY2Fu
IHRha2UgdGhpcyBwYXRjaCBmb3IgdjUuOCB3aGVyZWFzIHBhdGNoIDIgZGVwZW5kcw0KPiA+ID4g
b24gdGhlIFFFTVUgY2hhbmdlcyBhY2NlcHRhbmNlIGFuZCBzaG91bGQgcHJvYmFibHkgd2FpdC4N
Cj4gPiA+IA0KPiA+ID4gUGxlYXNlIGxldCBtZSBrbm93IHlvdXIgdGhvdWdodHMgYXNhcCBhbmQg
SSB3aWxsIHRyeSB0byBhdCBsZWFzdA0KPiA+ID4gc3F1ZWV6ZSB0aGlzIHBhdGNoIGluLg0KPiA+
ID4gDQo+ID4gPiBMb3JlbnpvDQo+ID4gDQo+ID4gSGkgTG9yZW56bywNCj4gPiANCj4gPiBUaGlz
IGlzIGZpbmUuIFBsZWFzZSB0YWtlIFBhdGNoIDEuDQo+ID4gUGF0Y2ggMiBpcyBoYXJtbGVzcyB3
aXRob3V0IHRoZSBRRU1VIGNoYW5nZXMsIGJ1dCBtYXkgYWx3YXlzIG5lZWQgYQ0KPiA+IGRpZmZl
cmVudCBhcHByb2FjaC4NCj4gDQo+IFB1bGxlZCBwYXRjaCAxIGludG8gcGNpL3ZtZCwgdGhhbmtz
Lg0KPiANCj4gTG9yZW56bw0KDQpIaSBMb3JlbnpvLA0KDQpBbGV4IGhhcyBwci1lZCB0aGUgUUVN
VSBwYXRjaCBbMV0NCklzIGl0IHRvbyBsYXRlIHRvIHB1bGwgcGF0Y2ggMi8yIGZvciB2NS44Pw0K
DQpbMV0gDQpodHRwczovL2dpdGh1Yi5jb20vYXdpbGxpYW0vcWVtdS12ZmlvL3JlbGVhc2VzL3Rh
Zy92ZmlvLXVwZGF0ZS0yMDIwMDYxMS4wDQo=
