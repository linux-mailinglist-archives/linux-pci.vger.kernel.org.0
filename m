Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 362D7F1F93
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2019 21:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbfKFUOn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Nov 2019 15:14:43 -0500
Received: from mga11.intel.com ([192.55.52.93]:56809 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726934AbfKFUOn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 6 Nov 2019 15:14:43 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2019 12:14:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,275,1569308400"; 
   d="scan'208";a="200816649"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by fmsmga008.fm.intel.com with ESMTP; 06 Nov 2019 12:14:43 -0800
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.212]) by
 ORSMSX104.amr.corp.intel.com ([169.254.4.167]) with mapi id 14.03.0439.000;
 Wed, 6 Nov 2019 12:14:42 -0800
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "kbusch@kernel.org" <kbusch@kernel.org>
CC:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>
Subject: Re: [PATCH 3/3] PCI: vmd: Use managed irq affinities
Thread-Topic: [PATCH 3/3] PCI: vmd: Use managed irq affinities
Thread-Index: AQHVlMmHESuT4wY8tEuHupbWJEM8x6d+934AgAAir4A=
Date:   Wed, 6 Nov 2019 20:14:41 +0000
Message-ID: <0a4a4151b56567f3c8ca71a29a2e39add6e3bf77.camel@intel.com>
References: <1573040408-3831-1-git-send-email-jonathan.derrick@intel.com>
         <1573040408-3831-4-git-send-email-jonathan.derrick@intel.com>
         <20191106181032.GD29853@redsun51.ssa.fujisawa.hgst.com>
In-Reply-To: <20191106181032.GD29853@redsun51.ssa.fujisawa.hgst.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.232.115.131]
Content-Type: text/plain; charset="utf-8"
Content-ID: <2DDA9324BA9CBC4EAF796617BF2E3EDC@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVGh1LCAyMDE5LTExLTA3IGF0IDAzOjEwICswOTAwLCBLZWl0aCBCdXNjaCB3cm90ZToNCj4g
T24gV2VkLCBOb3YgMDYsIDIwMTkgYXQgMDQ6NDA6MDhBTSAtMDcwMCwgSm9uIERlcnJpY2sgd3Jv
dGU6DQo+ID4gVXNpbmcgbWFuYWdlZCBJUlEgYWZmaW5pdGllcyBzZXRzIHVwIHRoZSBWTUQgYWZm
aW5pdGllcyBpZGVudGljYWxseSB0bw0KPiA+IHRoZSBjaGlsZCBkZXZpY2VzIHdoZW4gdGhvc2Ug
ZGV2aWNlcyB2ZWN0b3IgY291bnRzIGFyZSBsaW1pdGVkIGJ5IFZNRC4NCj4gPiBUaGlzIHByb21v
dGVzIGJldHRlciBhZmZpbml0eSBoYW5kbGluZyBhcyBpbnRlcnJ1cHRzIHdvbid0IG5lY2Vzc2Fy
aWx5DQo+ID4gbmVlZCB0byBwYXNzIGNvbnRleHQgYmV0d2VlbiBub24tbG9jYWwgQ1BVcy4gT25l
IHByZS12ZWN0b3IgaXMgcmVzZXJ2ZWQNCj4gPiBmb3IgdGhlIHNsb3cgaW50ZXJydXB0IGFuZCBu
b3QgY29uc2lkZXJlZCBpbiB0aGUgYWZmaW5pdHkgYWxnb3JpdGhtLg0KPiANCj4gVGhpcyBvbmx5
IHdvcmtzIGlmIGFsbCBkZXZpY2VzIGhhdmUgZXhhY3RseSB0aGUgc2FtZSBudW1iZXIgb2YgaW50
ZXJydXB0cw0KPiBhcyB0aGUgcGFyZW50IFZNRCBob3N0IGJyaWRnZS4gSWYgYSBjaGlsZCBkZXZp
Y2UgaGFzIGxlc3MsIHRoZSBkZXZpY2UNCj4gd2lsbCBzdG9wIHdvcmtpbmcgaWYgeW91IG9mZmxp
bmUgYSBjcHU6IHRoZSBjaGlsZCBkZXZpY2UgbWF5IGhhdmUgYQ0KPiByZXNvdXJjZSBhZmZpbmVk
IHRvIG90aGVyIG9ubGluZSBjcHVzLCBidXQgdGhlIFZNRCBkZXZpY2UgYWZmaW5pdHkgaXMgdG8N
Cj4gdGhhdCBzaW5nbGUgb2ZmbGluZSBjcHUuDQoNClllcyB0aGF0IHByb2JsZW0gZXhpc3RzIHRv
ZGF5IGFuZCB0aGlzIHNldCBsaW1pdHMgdGhlIGV4cG9zdXJlIGFzIGl0J3MNCmEgcmFyZSBjYXNl
IHdoZXJlIHlvdSBoYXZlIGEgY2hpbGQgTlZNZSBkZXZpY2Ugd2l0aCBmZXdlciB0aGFuIDMyDQp2
ZWN0b3JzLg0K
