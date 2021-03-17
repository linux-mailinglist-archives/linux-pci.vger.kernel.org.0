Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 454F833F8EA
	for <lists+linux-pci@lfdr.de>; Wed, 17 Mar 2021 20:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233125AbhCQTOn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Mar 2021 15:14:43 -0400
Received: from mga18.intel.com ([134.134.136.126]:13842 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233196AbhCQTOT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 17 Mar 2021 15:14:19 -0400
IronPort-SDR: KwqNhsd3hQMVRfUIK3OLAoy6yawS9sLlpkJR31CrQoRuVvDSk46QCc4Bt7+n5VvjzNIZhZvQ7G
 k1l9YtuCpx3g==
X-IronPort-AV: E=McAfee;i="6000,8403,9926"; a="177125903"
X-IronPort-AV: E=Sophos;i="5.81,257,1610438400"; 
   d="scan'208";a="177125903"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2021 12:14:19 -0700
IronPort-SDR: YwYHs2w9lumWpuB08p5WHfrA6CMiVs4J43sVUpgCMIbQmeEwSRHThJB0srKbMhFMS0wjZIfGjS
 hYv3XMYCEX6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,257,1610438400"; 
   d="scan'208";a="406048973"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga008.fm.intel.com with ESMTP; 17 Mar 2021 12:14:19 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 17 Mar 2021 12:14:18 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 17 Mar 2021 12:14:18 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2106.013;
 Wed, 17 Mar 2021 12:14:18 -0700
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
CC:     "Karkra, Kapil" <kapil.karkra@intel.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "Patel, Nirmal" <nirmal.patel@intel.com>,
        "kw@linux.com" <kw@linux.com>
Subject: Re: [PATCH v4 0/2] VMD MSI Remapping Bypass
Thread-Topic: [PATCH v4 0/2] VMD MSI Remapping Bypass
Thread-Index: AQHW/8ernlIsBQTka0W7z8h+KA9vr6qJOSKA
Date:   Wed, 17 Mar 2021 19:14:17 +0000
Message-ID: <0a70914085c25cf99536d106a280b27819328fff.camel@intel.com>
References: <20210210161315.316097-1-jonathan.derrick@intel.com>
In-Reply-To: <20210210161315.316097-1-jonathan.derrick@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.22.254.132]
Content-Type: text/plain; charset="utf-8"
Content-ID: <3D316745D3F3BF4A84092E28A6E5659A@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

R2VudGxlIHJlbWluZGVyLCBmb3IgdjUuMTMgPw0KDQpPbiBXZWQsIDIwMjEtMDItMTAgYXQgMDk6
MTMgLTA3MDAsIEpvbiBEZXJyaWNrIHdyb3RlOg0KPiBUaGUgSW50ZWwgVm9sdW1lIE1hbmFnZW1l
bnQgRGV2aWNlIGFjdHMgc2ltaWxhciB0byBhIFBDSS10by1QQ0kgYnJpZGdlIGluIHRoYXQNCj4g
aXQgY2hhbmdlcyBkb3duc3RyZWFtIGRldmljZXMnIHJlcXVlc3Rlci1pZHMgdG8gaXRzIG93bi4g
QXMgVk1EIHN1cHBvcnRzIFBDSWUNCj4gZGV2aWNlcywgaXQgaGFzIGl0cyBvd24gTVNJLVggdGFi
bGUgYW5kIHRyYW5zbWl0cyBjaGlsZCBkZXZpY2UgTVNJLVggYnkNCj4gcmVtYXBwaW5nIGNoaWxk
IGRldmljZSBNU0ktWCBhbmQgaGFuZGxpbmcgbGlrZSBhIGRlbXVsdGlwbGV4ZXIuDQo+IA0KPiBT
b21lIG5ld2VyIFZNRCBkZXZpY2VzIChJY2VsYWtlIFNlcnZlcikgaGF2ZSBhbiBvcHRpb24gdG8g
YnlwYXNzIHRoZSBWTUQgTVNJLVgNCj4gcmVtYXBwaW5nIHRhYmxlLiBUaGlzIGFsbG93cyBmb3Ig
YmV0dGVyIHBlcmZvcm1hbmNlIHNjYWxpbmcgYXMgdGhlIGNoaWxkIGRldmljZQ0KPiBNU0ktWCB3
b24ndCBiZSBsaW1pdGVkIGJ5IFZNRCdzIE1TSS1YIGNvdW50IGFuZCBJUlEgaGFuZGxlci4NCj4g
DQo+IFYzLT5WNDoNCj4gSW50ZWdyYXRlZCB3b3JkaW5nIHN1Z2dlc3Rpb25zOyBubyBmdW5jdGlv
bmFsIGNoYW5nZXMNCj4gDQo+IFYyLT5WMzoNCj4gVHJpdmlhbCBjb21tZW50IGZpeGVzDQo+IEFk
ZGVkIGFja3MNCj4gDQo+IFYxLT5WMjoNCj4gVXBkYXRlZCBmb3IgNS4xMi1uZXh0DQo+IE1vdmVk
IElSUSBhbGxvY2F0aW9uIGFuZCByZW1hcHBpbmcgZW5hYmxlL2Rpc2FibGUgdG8gYSBtb3JlIGxv
Z2ljYWwgbG9jYXRpb24NCj4gDQo+IFYxIHBhdGNoZXMgMS00IHdlcmUgYWxyZWFkeSBtZXJnZWQN
Cj4gVjEsIDUvNjogaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LXBj
aS9wYXRjaC8yMDIwMDcyODE5NDk0NS4xNDEyNi02LWpvbmF0aGFuLmRlcnJpY2tAaW50ZWwuY29t
Lw0KPiBWMSwgNi82OiBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgt
cGNpL3BhdGNoLzIwMjAwNzI4MTk0OTQ1LjE0MTI2LTctam9uYXRoYW4uZGVycmlja0BpbnRlbC5j
b20vDQo+IA0KPiANCj4gSm9uIERlcnJpY2sgKDIpOg0KPiAgIGlvbW11L3Z0LWQ6IFVzZSBSZWFs
IFBDSSBETUEgZGV2aWNlIGZvciBJUlRFDQo+ICAgUENJOiB2bWQ6IERpc2FibGUgTVNJLVggcmVt
YXBwaW5nIHdoZW4gcG9zc2libGUNCj4gDQo+ICBkcml2ZXJzL2lvbW11L2ludGVsL2lycV9yZW1h
cHBpbmcuYyB8ICAzICstDQo+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL3ZtZC5jICAgICAgICB8
IDYzICsrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDUz
IGluc2VydGlvbnMoKyksIDEzIGRlbGV0aW9ucygtKQ0KPiANCg==
