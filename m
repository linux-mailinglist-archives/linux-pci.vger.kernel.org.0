Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB93A1E828F
	for <lists+linux-pci@lfdr.de>; Fri, 29 May 2020 17:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgE2Pxj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 May 2020 11:53:39 -0400
Received: from mga05.intel.com ([192.55.52.43]:6484 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726838AbgE2Pxj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 29 May 2020 11:53:39 -0400
IronPort-SDR: McqokuqJPIn34PEgZG6CsdjpOqLRZn9bXXoRDBIu7z7CwZOrq+u9QFXddMj2kIXZ4Ch2QBVOFx
 RhJmxilz0L4Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2020 08:53:36 -0700
IronPort-SDR: 2LJzmXHoxG3l3dt/Xjw9fYZRV1akjKmqCZ5JCidjlXjHVzdL9loI3YC2zgbv+/d7I40+b7pgbl
 cAe4oqT7s6nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,449,1583222400"; 
   d="scan'208";a="303162420"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
  by orsmga008.jf.intel.com with ESMTP; 29 May 2020 08:53:38 -0700
Received: from orsmsx113.amr.corp.intel.com (10.22.240.9) by
 ORSMSX101.amr.corp.intel.com (10.22.225.128) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 29 May 2020 08:53:38 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.250]) by
 ORSMSX113.amr.corp.intel.com ([169.254.9.126]) with mapi id 14.03.0439.000;
 Fri, 29 May 2020 08:53:38 -0700
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
Thread-Index: AQHWNJ6/KA9BUx6s/UuCJV3Lsz6Rn6i/VTmAgABYZAA=
Date:   Fri, 29 May 2020 15:53:37 +0000
Message-ID: <163e8cb37ece0c8daa6d6e5fd7fcae47ba4fa437.camel@intel.com>
References: <20200528030240.16024-1-jonathan.derrick@intel.com>
         <20200528030240.16024-3-jonathan.derrick@intel.com>
         <20200529103315.GC12270@e121166-lin.cambridge.arm.com>
In-Reply-To: <20200529103315.GC12270@e121166-lin.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.212.4.51]
Content-Type: text/plain; charset="utf-8"
Content-ID: <9320F8450203F74885A01C2338E0390F@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gRnJpLCAyMDIwLTA1LTI5IGF0IDExOjMzICswMTAwLCBMb3JlbnpvIFBpZXJhbGlzaSB3cm90
ZToNCj4gT24gV2VkLCBNYXkgMjcsIDIwMjAgYXQgMTE6MDI6MzlQTSAtMDQwMCwgSm9uIERlcnJp
Y2sgd3JvdGU6DQo+ID4gVmVyc2lvbnMgb2YgVk1EIHdpdGggdGhlIEhvc3QgUGh5c2ljYWwgQWRk
cmVzcyBzaGFkb3cgcmVnaXN0ZXIgdXNlIHRoaXMNCj4gPiByZWdpc3RlciB0byBjYWxjdWxhdGUg
dGhlIGJ1cyBhZGRyZXNzIG9mZnNldCBuZWVkZWQgdG8gZG8gZ3Vlc3QNCj4gPiBwYXNzdGhyb3Vn
aCBvZiB0aGUgZG9tYWluLiBUaGlzIHJlZ2lzdGVyIHNoYWRvd3MgdGhlIEhvc3QgUGh5c2ljYWwN
Cj4gPiBBZGRyZXNzIHJlZ2lzdGVycyBpbmNsdWRpbmcgdGhlIHJlc291cmNlIHR5cGUgYml0cy4g
QWZ0ZXIgY2FsY3VsYXRpbmcNCj4gPiB0aGUgb2Zmc2V0LCB0aGUgZXh0cmEgcmVzb3VyY2UgdHlw
ZSBiaXRzIGxlYWQgdG8gdGhlIFZNRCByZXNvdXJjZXMgYmVpbmcNCj4gPiBvdmVyLXByb3Zpc2lv
bmVkIGF0IHRoZSBmcm9udCBhbmQgdW5kZXItcHJvdmlzaW9uZWQgYXQgdGhlIGJhY2suDQo+ID4g
DQo+ID4gRXhhbXBsZToNCj4gPiBwY2kgMTAwMDA6ODA6MDIuMDogcmVnIDB4MTA6IFttZW0gMHhm
ODAxZmZmYy0weGY4MDNmZmZiIDY0Yml0XQ0KPiA+IA0KPiA+IEV4cGVjdGVkOg0KPiA+IHBjaSAx
MDAwMDo4MDowMi4wOiByZWcgMHgxMDogW21lbSAweGY4MDIwMDAwLTB4ZjgwM2ZmZmYgNjRiaXRd
DQo+ID4gDQo+ID4gSWYgb3RoZXIgZGV2aWNlcyBhcmUgbWFwcGVkIGluIHRoZSBvdmVyLXByb3Zp
c2lvbmVkIGZyb250LCBpdCBjb3VsZCBsZWFkDQo+ID4gdG8gcmVzb3VyY2UgY29uZmxpY3QgaXNz
dWVzIHdpdGggVk1EIG9yIHRob3NlIGRldmljZXMuDQo+ID4gDQo+ID4gRml4ZXM6IGExYTMwMTcw
MTM4YzkgKCJQQ0k6IHZtZDogRml4IHNoYWRvdyBvZmZzZXRzIHRvIHJlZmxlY3Qgc3BlYyBjaGFu
Z2VzIikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBKb24gRGVycmljayA8am9uYXRoYW4uZGVycmlja0Bp
bnRlbC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvdm1kLmMgfCA2
ICsrKystLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9u
cygtKQ0KPiANCj4gSGkgSm9uLA0KPiANCj4gaXQgbG9va3MgbGlrZSBJIGNhbiB0YWtlIHRoaXMg
cGF0Y2ggZm9yIHY1Ljggd2hlcmVhcyBwYXRjaCAyIGRlcGVuZHMNCj4gb24gdGhlIFFFTVUgY2hh
bmdlcyBhY2NlcHRhbmNlIGFuZCBzaG91bGQgcHJvYmFibHkgd2FpdC4NCj4gDQo+IFBsZWFzZSBs
ZXQgbWUga25vdyB5b3VyIHRob3VnaHRzIGFzYXAgYW5kIEkgd2lsbCB0cnkgdG8gYXQgbGVhc3QN
Cj4gc3F1ZWV6ZSB0aGlzIHBhdGNoIGluLg0KPiANCj4gTG9yZW56bw0KDQpIaSBMb3JlbnpvLA0K
DQpUaGlzIGlzIGZpbmUuIFBsZWFzZSB0YWtlIFBhdGNoIDEuDQpQYXRjaCAyIGlzIGhhcm1sZXNz
IHdpdGhvdXQgdGhlIFFFTVUgY2hhbmdlcywgYnV0IG1heSBhbHdheXMgbmVlZCBhDQpkaWZmZXJl
bnQgYXBwcm9hY2guDQoNCkJlc3QsDQpqb24NCg0KDQo+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3BjaS9jb250cm9sbGVyL3ZtZC5jIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci92bWQuYw0K
PiA+IGluZGV4IGRhYzkxZDYuLmUzODZkNGUgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9wY2kv
Y29udHJvbGxlci92bWQuYw0KPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvdm1kLmMN
Cj4gPiBAQCAtNDQ1LDkgKzQ0NSwxMSBAQCBzdGF0aWMgaW50IHZtZF9lbmFibGVfZG9tYWluKHN0
cnVjdCB2bWRfZGV2ICp2bWQsIHVuc2lnbmVkIGxvbmcgZmVhdHVyZXMpDQo+ID4gIAkJCWlmICgh
bWVtYmFyMikNCj4gPiAgCQkJCXJldHVybiAtRU5PTUVNOw0KPiA+ICAJCQlvZmZzZXRbMF0gPSB2
bWQtPmRldi0+cmVzb3VyY2VbVk1EX01FTUJBUjFdLnN0YXJ0IC0NCj4gPiAtCQkJCQlyZWFkcSht
ZW1iYXIyICsgTUIyX1NIQURPV19PRkZTRVQpOw0KPiA+ICsJCQkJCShyZWFkcShtZW1iYXIyICsg
TUIyX1NIQURPV19PRkZTRVQpICYNCj4gPiArCQkJCQkgUENJX0JBU0VfQUREUkVTU19NRU1fTUFT
Syk7DQo+ID4gIAkJCW9mZnNldFsxXSA9IHZtZC0+ZGV2LT5yZXNvdXJjZVtWTURfTUVNQkFSMl0u
c3RhcnQgLQ0KPiA+IC0JCQkJCXJlYWRxKG1lbWJhcjIgKyBNQjJfU0hBRE9XX09GRlNFVCArIDgp
Ow0KPiA+ICsJCQkJCShyZWFkcShtZW1iYXIyICsgTUIyX1NIQURPV19PRkZTRVQgKyA4KSAmDQo+
ID4gKwkJCQkJIFBDSV9CQVNFX0FERFJFU1NfTUVNX01BU0spOw0KPiA+ICAJCQlwY2lfaW91bm1h
cCh2bWQtPmRldiwgbWVtYmFyMik7DQo+ID4gIAkJfQ0KPiA+ICAJfQ0KPiA+IC0tIA0KPiA+IDEu
OC4zLjENCj4gPiANCg==
