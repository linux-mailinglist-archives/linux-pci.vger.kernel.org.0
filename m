Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5359C31397A
	for <lists+linux-pci@lfdr.de>; Mon,  8 Feb 2021 17:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234363AbhBHQbk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Feb 2021 11:31:40 -0500
Received: from mga06.intel.com ([134.134.136.31]:19248 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234385AbhBHQbf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 8 Feb 2021 11:31:35 -0500
IronPort-SDR: w8A3dw0pUoqojApfa7isZPsccaizS7S10GYNQ9vNjmhsa2hgaNB0CTkWU89GeHCUpt8iWuQP/y
 H/9tNIvQED7Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9889"; a="243239018"
X-IronPort-AV: E=Sophos;i="5.81,162,1610438400"; 
   d="scan'208";a="243239018"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 08:30:50 -0800
IronPort-SDR: 8i4vN7cHtGmxFxqlQtWG8JmDoVMk+L7DpLAWuf9/p1Vo9HDd/nPHZeMM7DpX2E/L/Br0bHGXsN
 HW9Bxh8z05XQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,162,1610438400"; 
   d="scan'208";a="435683959"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 08 Feb 2021 08:30:50 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 8 Feb 2021 08:30:49 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 8 Feb 2021 08:30:48 -0800
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2106.002;
 Mon, 8 Feb 2021 08:30:48 -0800
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "kw@linux.com" <kw@linux.com>
CC:     "joro@8bytes.org" <joro@8bytes.org>,
        "Patel, Nirmal" <nirmal.patel@intel.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "jroedel@suse.de" <jroedel@suse.de>,
        "Karkra, Kapil" <kapil.karkra@intel.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] PCI: vmd: Disable MSI-X remapping when possible
Thread-Topic: [PATCH v3 2/2] PCI: vmd: Disable MSI-X remapping when possible
Thread-Index: AQHW/DkUNvX+5gOMpEiNiIzEbeMxXqpOxWOAgAA3ygA=
Date:   Mon, 8 Feb 2021 16:30:48 +0000
Message-ID: <37b6f55d6fad77d7536890a540ecf5369f8de0a9.camel@intel.com>
References: <20210206033502.103964-1-jonathan.derrick@intel.com>
         <20210206033502.103964-3-jonathan.derrick@intel.com>
         <YCE4a4swLUTw6j9Y@rocinante>
In-Reply-To: <YCE4a4swLUTw6j9Y@rocinante>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.1.200.100]
Content-Type: text/plain; charset="utf-8"
Content-ID: <AD7512E5603F2F4FBC75F2218B96054A@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQpPbiBNb24sIDIwMjEtMDItMDggYXQgMTQ6MTEgKzAxMDAsIEtyenlz
enRvZiBXaWxjennFhHNraSB3cm90ZToNCj4gSGkgSm9uLA0KPiANCj4gVGhhbmsgeW91IGZvciBh
bGwgdGhlIHdvcmsgaGVyZSENCj4gDQo+IEp1c3QgYSBudW1iZXIgb2Ygc3VnZ2VzdGlvbnMsIG1h
aW5seSBuaXRwaWNrcywgc28gZmVlbCBmcmVlIHRvIGlnbm9yZQ0KPiB0aGVzZSwgb2YgY291cnNl
Lg0KPiANCj4gWy4uLl0NCj4gPiArI2RlZmluZSBWTUNGR19NU0lfUk1QX0RJUwkweDINCj4gWy4u
Ll0NCj4gDQo+IFdoYXQgYWJvdXQgY2FsbGluZyB0aGlzIFZNQ09ORklHX01TSV9SRU1BUCBzbyB0
aGF0IGlzIG1vcmUNCj4gc2VsZi1leHBsYW5hdG9yeSAoaXQgYWxzbyBzaGFyZXMgc29tZSBzaW1p
bGFyaXR5IHdpdGggdGhlDQo+IFBDSV9SRUdfVk1DT05GSUcgZGVmaW50aXRpb24pLg0KPiANCj4g
Wy4uLl0NCj4gPiArCVZNRF9GRUFUX0JZUEFTU19NU0lfUkVNQVAJCT0gKDEgPDwgNCksDQo+IFsu
Li5dDQo+IA0KPiBGb2xsb3dpbmcgb24gdGhlIG5hbWluZyB0aGF0IGluY2x1ZGVkICJIQVMiIHRv
IGluZGljYXRlIGEgZmVhdHVyZSAob3INCj4gc3VwcG9ydCBmb3IgdGhlcmVvZiksIHBlcmhhcHMg
d2UgY291bGQgbmFtZSB0aGlzIGFzLCBmb3IgZXhhbXBsZToNCj4gDQo+IAlWTURfRkVBVF9DQU5f
QllQQVNTX01TSV9SRU1BUA0KPiANCj4gV2hhdCBkbyB5b3UgdGhpbms/DQpTdXJlDQoNCj4gDQo+
IFsuLi5dIA0KPiA+ICtzdGF0aWMgdm9pZCB2bWRfZW5hYmxlX21zaV9yZW1hcHBpbmcoc3RydWN0
IHZtZF9kZXYgKnZtZCwgYm9vbCBlbmFibGUpDQo+ID4gK3sNCj4gPiArCXUxNiByZWc7DQo+ID4g
Kw0KPiA+ICsJcGNpX3JlYWRfY29uZmlnX3dvcmQodm1kLT5kZXYsIFBDSV9SRUdfVk1DT05GSUcs
ICZyZWcpOw0KPiA+ICsJcmVnID0gZW5hYmxlID8gKHJlZyAmIH5WTUNGR19NU0lfUk1QX0RJUykg
OiAocmVnIHwgVk1DRkdfTVNJX1JNUF9ESVMpOw0KPiA+ICsJcGNpX3dyaXRlX2NvbmZpZ193b3Jk
KHZtZC0+ZGV2LCBQQ0lfUkVHX1ZNQ09ORklHLCByZWcpOw0KPiA+ICt9DQo+IA0KPiBJIHdvbmRl
ciBpZiBjYWxsaW5nIHRoaXMgZnVuY3Rpb24gdm1kX3NldF9tc2lfcmVtYXBwaW5nKCkgd291bGQg
YmUgbW9yZQ0KPiBhbGlnbmVkIHdpdGggd2hhdCBpdCBkb2VzLCBzaW5jZSBpdCB0dXJucyB0aGUg
TVNJIHJlbWFwcGluZyBzdXBwb3J0IG9uDQo+IGFuZCBvZmYsIHNvIHRvIHNwZWFrLCBhcyBuZWVk
ZWQuICBEbyB5b3UgdGhpbmsgdGhpcyB3b3VsZCBiZSBPSyB0byBkbz8NCj4gDQpZZXMgdGhhdCBt
YWtlcyBzZW5zZQ0KDQo+IFsuLi5dDQo+ID4gKwkJLyoNCj4gPiArCQkgKiBPdmVycmlkZSB0aGUg
aXJxIGRvbWFpbiBidXMgdG9rZW4gc28gdGhlIGRvbWFpbiBjYW4gYmUNCj4gPiArCQkgKiBkaXN0
aW5ndWlzaGVkIGZyb20gYSByZWd1bGFyIFBDSS9NU0kgZG9tYWluLg0KPiA+ICsJCSAqLw0KPiAN
Cj4gSXQgd291bGQgYmUgIklSUSIgaGVyZS4NCj4gDQpObyBwcm9ibGVtIQ0KDQoNCj4gUmV2aWV3
ZWQtYnk6IEtyenlzenRvZiBXaWxjennFhHNraSA8a3dAbGludXguY29tPg0KPiANClRoYW5rcyEN
Cg0KPiBLcnp5c3p0b2YNCg==
