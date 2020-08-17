Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAD16246C5E
	for <lists+linux-pci@lfdr.de>; Mon, 17 Aug 2020 18:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731066AbgHQQPE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Aug 2020 12:15:04 -0400
Received: from mga09.intel.com ([134.134.136.24]:6678 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388787AbgHQQO2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 Aug 2020 12:14:28 -0400
IronPort-SDR: 2ZiApwySqv2gkItqNgh77wmRq25CykFT8fS2kQlK7+cNs30IjOvlKObyK14vti055m4gAto68W
 sUaMLML2JcRA==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="155832265"
X-IronPort-AV: E=Sophos;i="5.76,324,1592895600"; 
   d="scan'208";a="155832265"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2020 09:14:20 -0700
IronPort-SDR: MTQWkYEYgj/KBxUGT4WFuP6A9a245S5GKHlQqV8lWuAiLfq4/IjZP5uqQAI5d7iC4vw956h7bT
 Zx4MNLXe8dIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,324,1592895600"; 
   d="scan'208";a="496530789"
Received: from orsmsx601-2.jf.intel.com (HELO ORSMSX601.amr.corp.intel.com) ([10.22.229.81])
  by fmsmga006.fm.intel.com with ESMTP; 17 Aug 2020 09:14:19 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 17 Aug 2020 09:14:18 -0700
Received: from orsmsx114.amr.corp.intel.com (10.22.240.10) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 17 Aug 2020 09:14:18 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.181]) by
 ORSMSX114.amr.corp.intel.com ([169.254.8.104]) with mapi id 14.03.0439.000;
 Mon, 17 Aug 2020 09:14:17 -0700
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
CC:     "hch@lst.de" <hch@lst.de>,
        "andrzej.jakowski@linux.intel.com" <andrzej.jakowski@linux.intel.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Kalakota, SushmaX" <sushmax.kalakota@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 0/6] VMD MSI Remapping Bypass
Thread-Topic: [PATCH 0/6] VMD MSI Remapping Bypass
Thread-Index: AQHWZRqrLAh+FrI8VUaY5BXRXtS0R6k9DceA
Date:   Mon, 17 Aug 2020 16:14:17 +0000
Message-ID: <5b9074dcdfef82ab2f93ab09b635a657666b3d91.camel@intel.com>
References: <20200728194945.14126-1-jonathan.derrick@intel.com>
In-Reply-To: <20200728194945.14126-1-jonathan.derrick@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.212.53.47]
Content-Type: text/plain; charset="utf-8"
Content-ID: <EB914BCED3046A4F91E4346ACFAA8FAA@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgTG9yZW56bywNCg0KT24gVHVlLCAyMDIwLTA3LTI4IGF0IDEzOjQ5IC0wNjAwLCBKb24gRGVy
cmljayB3cm90ZToNCj4gVGhlIEludGVsIFZvbHVtZSBNYW5hZ2VtZW50IERldmljZSBhY3RzIHNp
bWlsYXIgdG8gYSBQQ0ktdG8tUENJIGJyaWRnZSBpbiB0aGF0DQo+IGl0IGNoYW5nZXMgZG93bnN0
cmVhbSBkZXZpY2VzJyByZXF1ZXN0ZXItaWRzIHRvIGl0cyBvd24uIEFzIFZNRCBzdXBwb3J0cyBQ
Q0llDQo+IGRldmljZXMsIGl0IGhhcyBpdHMgb3duIE1TSS9YIHRhYmxlIGFuZCB0cmFuc21pdHMg
Y2hpbGQgZGV2aWNlIE1TSS9YIGJ5DQo+IHJlbWFwcGluZyBjaGlsZCBkZXZpY2UgTVNJL1ggYW5k
IGhhbmRsaW5nIGxpa2UgYSBkZW11bHRpcGxleGVyLg0KPiANCj4gU29tZSBuZXdlciBWTUQgZGV2
aWNlcyAoSWNlbGFrZSBTZXJ2ZXIgYW5kIGNsaWVudCkgaGF2ZSBhbiBvcHRpb24gdG8gYnlwYXNz
IHRoZQ0KPiBWTUQgTVNJL1ggcmVtYXBwaW5nIHRhYmxlLiBUaGlzIGFsbG93cyBmb3IgYmV0dGVy
IHBlcmZvcm1hbmNlIHNjYWxpbmcgYXMgdGhlDQo+IGNoaWxkIGRldmljZSBNU0kvWCB3b24ndCBi
ZSBsaW1pdGVkIGJ5IFZNRCdzIE1TSS9YIGNvdW50IGFuZCBJUlEgaGFuZGxlci4NCj4gDQo+IEl0
J3MgZXhwZWN0ZWQgdGhhdCBtb3N0IHVzZXJzIGRvbid0IHdhbnQgTVNJL1ggcmVtYXBwaW5nIHdo
ZW4gdGhleSBjYW4gZ2V0DQo+IGJldHRlciBwZXJmb3JtYW5jZSB3aXRob3V0IHRoaXMgbGltaXRh
dGlvbi4gVGhpcyBzZXQgaW5jbHVkZXMgc29tZSBsb25nIG92ZXJkdWUNCj4gY2xlYW51cCBvZiBv
dmVyZ3Jvd24gVk1EIGNvZGUgYW5kIGludHJvZHVjZXMgdGhlIE1TSS9YIHJlbWFwcGluZyBkaXNh
YmxlLg0KPiANCj4gQXBwbGllcyBvbiB0b3Agb2YgZTNiZWNhNDhhNDViICgiaXJxZG9tYWluL3Ry
ZWV3aWRlOiBLZWVwIGZpcm13YXJlIG5vZGUNCj4gdW5jb25kaXRpb25hbGx5IGFsbG9jYXRlZCIp
IGFuZCBlYzAxNjA4OTFlMzggKCJpcnFkb21haW4vdHJlZXdpZGU6IEZyZWUNCj4gZmlybXdhcmUg
bm9kZSBhZnRlciBkb21haW4gcmVtb3ZhbCIpIGluIHRpcC91cmdlbnQNCj4gDQo+IA0KPiBKb24g
RGVycmljayAoNik6DQo+ICAgUENJOiB2bWQ6IENyZWF0ZSBwaHlzaWNhbCBvZmZzZXQgaGVscGVy
DQo+ICAgUENJOiB2bWQ6IENyZWF0ZSBidXMgb2Zmc2V0IGNvbmZpZ3VyYXRpb24gaGVscGVyDQo+
ICAgUENJOiB2bWQ6IENyZWF0ZSBJUlEgRG9tYWluIGNvbmZpZ3VyYXRpb24gaGVscGVyDQo+ICAg
UENJOiB2bWQ6IENyZWF0ZSBJUlEgYWxsb2NhdGlvbiBoZWxwZXINCj4gICB4ODYvYXBpYy9tc2k6
IFVzZSBSZWFsIFBDSSBETUEgZGV2aWNlIHdoZW4gY29uZmlndXJpbmcgSVJURQ0KPiAgIFBDSTog
dm1kOiBEaXNhYmxlIE1TSS9YIHJlbWFwcGluZyB3aGVuIHBvc3NpYmxlDQo+IA0KPiAgYXJjaC94
ODYva2VybmVsL2FwaWMvbXNpLmMgICB8ICAgMiArLQ0KPiAgZHJpdmVycy9wY2kvY29udHJvbGxl
ci92bWQuYyB8IDM0NCArKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLQ0KPiAgMiBm
aWxlcyBjaGFuZ2VkLCAyMjQgaW5zZXJ0aW9ucygrKSwgMTIyIGRlbGV0aW9ucygtKQ0KPiANCj4g
DQo+IGJhc2UtY29tbWl0OiBlYzAxNjA4OTFlMzg3ZjQ3NzFmOTUzYjg4OGIxZmU5NTEzOThlNWQ5
DQoNCkdlbnRsZSByZW1pbmRlci4gUGxlYXNlIGRvbid0IGZvcmdldCBhYm91dCB0aGlzLg0KV2Ug
aGF2ZSBhIGZldyBtb3JlIHBhdGNoZXMgY29taW5nIHNvb24gdGhhdCBJJ2QgcHJlZmVyIHRvIHN0
YWdlIHVwb24NCnRoaXMgc2V0Lg0K
