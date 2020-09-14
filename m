Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21182269536
	for <lists+linux-pci@lfdr.de>; Mon, 14 Sep 2020 20:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbgINSzB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Sep 2020 14:55:01 -0400
Received: from mga14.intel.com ([192.55.52.115]:34539 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725914AbgINSy4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 14 Sep 2020 14:54:56 -0400
IronPort-SDR: sQjsBGnE7QS77yalwpZMR4+qgdyPRoJOXqd1TKYXvl6aQWgdZSag5d8AeCqCUPj5yaZ1Z4ZZ7W
 GGfcaTDCh9Tg==
X-IronPort-AV: E=McAfee;i="6000,8403,9744"; a="158429890"
X-IronPort-AV: E=Sophos;i="5.76,427,1592895600"; 
   d="scan'208";a="158429890"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2020 11:54:55 -0700
IronPort-SDR: Cl/stOt9S67dXEmCEnZshZimKFxQmaIFp573ILNRYir73CyiNE21C1Zwaz/WndDGjWaUWn2Phe
 5QeA2HeHLQ0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,427,1592895600"; 
   d="scan'208";a="379477186"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP; 14 Sep 2020 11:54:54 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 14 Sep 2020 11:54:54 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 14 Sep 2020 11:54:54 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.1713.004;
 Mon, 14 Sep 2020 11:54:54 -0700
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "kbusch@kernel.org" <kbusch@kernel.org>
CC:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "vicamo.yang@canonical.com" <vicamo.yang@canonical.com>
Subject: Re: [PATCH v2] PCI: vmd: Offset Client VMD MSI/X vectors
Thread-Topic: [PATCH v2] PCI: vmd: Offset Client VMD MSI/X vectors
Thread-Index: AQHWir/b9F/pEHaXbESh2Kd/QuJL06lo7XwAgAADXwA=
Date:   Mon, 14 Sep 2020 18:54:53 +0000
Message-ID: <7f4c254704704fd9d57129fb0d20f27456218d0f.camel@intel.com>
References: <20200914173255.5481-1-jonathan.derrick@intel.com>
         <20200914184238.GA10507@redsun51.ssa.fujisawa.hgst.com>
In-Reply-To: <20200914184238.GA10507@redsun51.ssa.fujisawa.hgst.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.209.178.80]
Content-Type: text/plain; charset="utf-8"
Content-ID: <3E8A8A2E9837784EBE83FAD880AE4EEA@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVHVlLCAyMDIwLTA5LTE1IGF0IDAzOjQyICswOTAwLCBLZWl0aCBCdXNjaCB3cm90ZToNCj4g
T24gTW9uLCBTZXAgMTQsIDIwMjAgYXQgMDE6MzI6NTVQTSAtMDQwMCwgSm9uIERlcnJpY2sgd3Jv
dGU6DQo+ID4gQ2xpZW50IFZNRCBwbGF0Zm9ybXMgaGF2ZSBhIHNvZnR3YXJlLXRyaWdnZXJlZCBN
U0kvWCB2ZWN0b3IgMCB0aGF0IHdpbGwNCj4gPiBub3QgZm9yd2FyZCBoYXJkd2FyZS1yZW1hcHBl
ZCBNU0kvWCB2ZWN0b3JzIGZyb20gdGhlIHN1Yi1kZXZpY2UgZG9tYWluLg0KPiA+IFRoaXMgY2F1
c2VzIGFuIGlzc3VlIHdpdGggVk1EIHBsYXRmb3JtcyB0aGF0IHVzZSBBSENJIGJlaGluZCBWTUQg
YW5kDQo+ID4gaGF2ZSBhIHNpbmdsZSBNU0kvWCB2ZWN0b3IgbWFwcGluZyB0byB2ZWN0b3IgMC4g
QWRkIGFuIE1TSS9YIHZlY3Rvcg0KPiA+IG9mZnNldCBmb3IgdGhlc2UgcGxhdGZvcm1zLg0KPiA+
IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEpvbiBEZXJyaWNrIDxqb25hdGhhbi5kZXJyaWNrQGludGVs
LmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci92bWQuYyB8IDM1ICsr
KysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAy
NSBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9wY2kvY29udHJvbGxlci92bWQuYyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvdm1k
LmMNCj4gPiBpbmRleCBmNjllZjhjODlmNzIuLmY4MTk1YmFkNzlkMSAxMDA2NDQNCj4gPiAtLS0g
YS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3ZtZC5jDQo+ID4gKysrIGIvZHJpdmVycy9wY2kvY29u
dHJvbGxlci92bWQuYw0KPiA+IEBAIC01Myw2ICs1MywxMiBAQCBlbnVtIHZtZF9mZWF0dXJlcyB7
DQo+ID4gIAkgKiB2ZW5kb3Itc3BlY2lmaWMgY2FwYWJpbGl0eSBzcGFjZQ0KPiA+ICAJICovDQo+
ID4gIAlWTURfRkVBVF9IQVNfTUVNQkFSX1NIQURPV19WU0NBUAk9ICgxIDw8IDIpLA0KPiA+ICsN
Cj4gPiArCS8qDQo+ID4gKwkgKiBEZXZpY2UgbWF5IHVzZSBNU0kvWCB2ZWN0b3IgMCBmb3Igc29m
dHdhcmUgdHJpZ2dlcmluZyBhbmQgd2lsbCBub3QNCj4gPiArCSAqIGJlIHVzZWQgZm9yIE1TSS9Y
IHJlbWFwcGluZw0KPiA+ICsJICovDQo+ID4gKwlWTURfRkVBVF9PRkZTRVRfRklSU1RfVkVDVE9S
CQk9ICgxIDw8IDMpLA0KPiA+ICB9Ow0KPiA+ICANCj4gPiAgLyoNCj4gPiBAQCAtMTA0LDYgKzEx
MCw3IEBAIHN0cnVjdCB2bWRfZGV2IHsNCj4gPiAgCXN0cnVjdCBpcnFfZG9tYWluCSppcnFfZG9t
YWluOw0KPiA+ICAJc3RydWN0IHBjaV9idXMJCSpidXM7DQo+ID4gIAl1OAkJCWJ1c25fc3RhcnQ7
DQo+ID4gKwl1OAkJCWZpcnN0X3ZlYzsNCj4gPiAgfTsNCj4gPiAgDQo+ID4gIHN0YXRpYyBpbmxp
bmUgc3RydWN0IHZtZF9kZXYgKnZtZF9mcm9tX2J1cyhzdHJ1Y3QgcGNpX2J1cyAqYnVzKQ0KPiA+
IEBAIC0xOTksMjUgKzIwNiwyNiBAQCBzdGF0aWMgaXJxX2h3X251bWJlcl90IHZtZF9nZXRfaHdp
cnEoc3RydWN0IG1zaV9kb21haW5faW5mbyAqaW5mbywNCj4gPiAgICovDQo+ID4gIHN0YXRpYyBz
dHJ1Y3Qgdm1kX2lycV9saXN0ICp2bWRfbmV4dF9pcnEoc3RydWN0IHZtZF9kZXYgKnZtZCwgc3Ry
dWN0IG1zaV9kZXNjICpkZXNjKQ0KPiA+ICB7DQo+ID4gLQlpbnQgaSwgYmVzdCA9IDE7DQo+ID4g
IAl1bnNpZ25lZCBsb25nIGZsYWdzOw0KPiA+ICsJaW50IGksIGJlc3Q7DQo+ID4gIA0KPiA+ICAJ
aWYgKHZtZC0+bXNpeF9jb3VudCA9PSAxKQ0KPiANCj4gVGhpcyBjb25kaXRpb24gbmVlZHMgYWNj
b3VudCBmb3IgdGhlIHZlY3RvciBvZmZzZXQsIHJpZ2h0Pw0KPiANCj4gICAJaWYgKHZtZC0+bXNp
eF9jb3VudCA9PSAxICsgdm1kLT5maXJzdF92ZWMpKQ0KDQpMb29rcyBsaWtlIGl0LCB5ZXMNCg0K
VGhhbmsgeW91DQoNCj4gDQo+ID4gLQkJcmV0dXJuICZ2bWQtPmlycXNbMF07DQo+ID4gKwkJcmV0
dXJuICZ2bWQtPmlycXNbdm1kLT5maXJzdF92ZWNdOw0K
