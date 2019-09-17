Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A64FDB54CF
	for <lists+linux-pci@lfdr.de>; Tue, 17 Sep 2019 20:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbfIQSBB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Sep 2019 14:01:01 -0400
Received: from mga03.intel.com ([134.134.136.65]:10292 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727406AbfIQSBB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Sep 2019 14:01:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Sep 2019 11:01:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,517,1559545200"; 
   d="scan'208";a="187531639"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
  by fmsmga007.fm.intel.com with ESMTP; 17 Sep 2019 11:01:00 -0700
Received: from orsmsx115.amr.corp.intel.com (10.22.240.11) by
 ORSMSX108.amr.corp.intel.com (10.22.240.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 17 Sep 2019 11:00:59 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.204]) by
 ORSMSX115.amr.corp.intel.com ([169.254.4.199]) with mapi id 14.03.0439.000;
 Tue, 17 Sep 2019 11:00:59 -0700
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Busch, Keith" <keith.busch@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>
Subject: Re: [PATCH 2/2] PCI: vmd: Fix shadow offsets to reflect spec changes
Thread-Topic: [PATCH 2/2] PCI: vmd: Fix shadow offsets to reflect spec
 changes
Thread-Index: AQHVbMjFlFehq2RCUUKRkku/dOKnLKcwJJgAgAA2cgCAAAKugIAACwgAgAAIeoCAAAohAIAADMoAgAAXVwA=
Date:   Tue, 17 Sep 2019 18:00:58 +0000
Message-ID: <331edc682197a497db91dd2378c6436688006012.camel@intel.com>
References: <20190916135435.5017-1-jonathan.derrick@intel.com>
         <20190916135435.5017-3-jonathan.derrick@intel.com>
         <20190917104106.GB32602@e121166-lin.cambridge.arm.com>
         <87f1f92276becb6f83d040b36697ef8084e63105.camel@intel.com>
         <20190917140525.GA6377@e121166-lin.cambridge.arm.com>
         <087e23dc3bb7b94bb96c33b380732ebd1285e467.camel@intel.com>
         <20190917151523.GA7948@e121166-lin.cambridge.arm.com>
         <ec24dc3d6f6f962a9f96ab1bab8c9cf4e138d61a.camel@intel.com>
         <20190917163716.GA9715@e121166-lin.cambridge.arm.com>
In-Reply-To: <20190917163716.GA9715@e121166-lin.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.255.2.79]
Content-Type: text/plain; charset="utf-8"
Content-ID: <C269F6C4B3B7294F971AC72F9BBB551F@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVHVlLCAyMDE5LTA5LTE3IGF0IDE3OjM3ICswMTAwLCBMb3JlbnpvIFBpZXJhbGlzaSB3cm90
ZToNCj4gT24gVHVlLCBTZXAgMTcsIDIwMTkgYXQgMDM6NTE6MzlQTSArMDAwMCwgRGVycmljaywg
Sm9uYXRoYW4gd3JvdGU6DQo+IA0KPiBbLi4uXQ0KPiANCj4gPiBTb3JyeSBmb3IgdGhlIGNvbmZ1
c2lvbi4NCj4gPiANCj4gPiBUaGVzZSBjaGFuZ2VzIG9ubHkgYWZmZWN0IHN5c3RlbXMgd2l0aCBW
TUQgZGV2aWNlcyB3aXRoIDgwODY6MjhDMA0KPiA+IGRldmljZSBJRHMsIGJ1dCB0aGVzZSB3b24n
dCBiZSBwcm9kdWN0aW9uIGhhcmR3YXJlIGZvciBzb21lIHRpbWUuDQo+ID4gDQo+ID4gU3lzdGVt
cyB3aXRoIFZNRCBkZXZpY2VzIGV4aXN0IGluIHRoZSB3aWxkIHdpdGggODA4NjoyMDFEIGRldmlj
ZSBJRHMuDQo+ID4gVGhlc2UgZG9uJ3Qgc3VwcG9ydCB0aGUgZ3Vlc3QgcGFzc3Rocm91Z2ggbW9k
ZSBhbmQgdGhpcyBjb2RlIHdvbid0DQo+ID4gYnJlYWsgYW55dGhpbmcgd2l0aCB0aGVtLiBBZGRp
dGlvbmFsbHksIHBhdGNoIDEvMiAoYnVzIG51bWJlcmluZykgb25seQ0KPiA+IGFmZmVjdHMgODA4
NjoyOEMwLg0KPiA+IA0KPiA+IFNvIG9uIGV4aXN0aW5nIEhXLCB0aGVzZSBwYXRjaGVzIHdvbid0
IGFmZmVjdCBhbnl0aGluZw0KPiANCj4gSXQgaXMgbWUgd2hvIGNyZWF0ZWQgY29uZnVzaW9uLCBh
cG9sb2dpZXMuIEkgcmVhZCB0aGUgY29kZSBwcm9wZXJseSBhbmQNCj4gSSB1bmRlcnN0YW5kIHRo
YXQgYm90aCBwYXRjaGVzIGFyZSBmaXhlcyBmb3IgSFcgdGhhdCBpcyBzdGlsbCBub3QNCj4gYXZh
aWxhYmxlIChhbmQgdGhleSBjYW4ndCBjcmVhdGUgYW4gaXNzdWUgd2l0aCBjdXJyZW50IGtlcm5l
bCBiZWNhdXNlDQo+IEhBU19NRU1CQVJfU0hBRE9XIGFuZCBIQVNfQlVTX1JFU1RSSUNUSU9OUyBm
ZWF0dXJlcyBhcmUgbm90IGltcGxlbWVudGVkDQo+IG9uIDgwODY6MjAxRCksIHdlIHNob3VsZCB0
YWtlIHRoZXNlIHBhdGNoZXMgYW5kIHRyaWNrbGUgdGhlbSB0byBzdGFibGUNCj4ga2VybmVscyBh
cyBzb29uIGFzIHBvc3NpYmxlIHNvIHRoYXQgd2hlbiBIVyBfaXNfIGF2YWlsYWJsZSBtYWlubGlu
ZSBhbmQNCj4gc3RhYmxlIGtlcm5lbHMgYXJlIGZpeGVkLg0KPiANCj4gQ29ycmVjdCA/DQo+IA0K
PiBMb3JlbnpvDQoNClRoYXQncyBjb3JyZWN0LiBJdCB3aWxsIGFwcGx5IHRvIDUuMiBzdGFibGUg
YnV0IGlzIG1pc3NpbmcgYSBmZXcgZGVwcw0KZm9yIDQuMTkgdGhhdCBJIHdvdWxkbid0IGNvbnNp
ZGVyIGFzIHF1YWxpZnlpbmcgYXMgc3RhYmxlLiBJIGNhbg0KYmFja3BvcnQgdG8gNC4xOSBmYWly
bHkgZWFzaWx5Lg0KDQoNClRoYW5rcywNCkpvbg0K
