Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3939B1A6AA1
	for <lists+linux-pci@lfdr.de>; Mon, 13 Apr 2020 18:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732189AbgDMQzX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Apr 2020 12:55:23 -0400
Received: from mga09.intel.com ([134.134.136.24]:50250 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731847AbgDMQzW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Apr 2020 12:55:22 -0400
IronPort-SDR: xBxpnuXe0k2zON6Jh82sepuEYQNdZshLgsi9+fISsF4lngJKPwC6YiMhwHiJTI/rk7p4aOJ8sh
 TtWaun1yHcPA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2020 09:55:20 -0700
IronPort-SDR: IUjmDCbhZlfXyhpzdiyidAClYTBodmcsTA3bZWUB3fQ27iRZAvjemJlR+xjZ0WfLdEUa23WXSF
 1gMPVXzmd8oA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,378,1580803200"; 
   d="scan'208";a="453221178"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by fmsmga005.fm.intel.com with ESMTP; 13 Apr 2020 09:55:20 -0700
Received: from orsmsx126.amr.corp.intel.com (10.22.240.126) by
 ORSMSX102.amr.corp.intel.com (10.22.225.129) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 13 Apr 2020 09:55:20 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.204]) by
 ORSMSX126.amr.corp.intel.com ([169.254.4.246]) with mapi id 14.03.0439.000;
 Mon, 13 Apr 2020 09:55:20 -0700
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
CC:     "Kalakota, SushmaX" <sushmax.kalakota@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>
Subject: Re: [PATCH] PCI: vmd: Filter resource type bits from shadow register
Thread-Topic: [PATCH] PCI: vmd: Filter resource type bits from shadow
 register
Thread-Index: AQHV/umGQ06Mrizjq0+0sw5eTPqC8ahwEBwAgAfQCAA=
Date:   Mon, 13 Apr 2020 16:55:19 +0000
Message-ID: <9f2e64822b8d9578133be73f47d3ae6091335c58.camel@intel.com>
References: <1584730690-57253-1-git-send-email-jonathan.derrick@intel.com>
         <1f3bc6cb57988f052cb94c325fb0af84bd76b980.camel@intel.com>
In-Reply-To: <1f3bc6cb57988f052cb94c325fb0af84bd76b980.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.255.0.111]
Content-Type: text/plain; charset="utf-8"
Content-ID: <FF8B063B1205C243B4704ED7607CD6CA@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

U29ycnkgSSBqdXN0IG5vdGljZWQgdGhpcyBuZXZlciBoaXQgdGhlIE1MLg0KSSdtIGd1ZXNzaW5n
IGl0IHdhcyByZWplY3RlZCBhdCB0aGUgbWFpbHNlcnZlciBkdWUgdG8gdGhlIGJhZCBzdGFibGUg
YWRkcmVzcy4NCg0KSSdsbCByZXN1Ym1pdCBmb3IgNS44IGluIGEgd2hpbGUuDQoNCk9uIFdlZCwg
MjAyMC0wNC0wOCBhdCAxMTozNiAtMDYwMCwgSm9uYXRoYW4gRGVycmljayB3cm90ZToNCj4gQW55
dGhpbmcgd3Jvbmcgd2l0aCB0aGlzLCBMb3JlbnpvPw0KPiANCj4gVGhhbmtzDQo+IA0KPiBPbiBG
cmksIDIwMjAtMDMtMjAgYXQgMTI6NTggLTA2MDAsIEpvbiBEZXJyaWNrIHdyb3RlOg0KPiA+IFZl
cnNpb25zIG9mIFZNRCB3aXRoIHRoZSBIb3N0IFBoeXNpY2FsIEFkZHJlc3Mgc2hhZG93IHJlZ2lz
dGVyIHVzZSB0aGlzDQo+ID4gcmVnaXN0ZXIgdG8gY2FsY3VsYXRlIHRoZSBidXMgYWRkcmVzcyBv
ZmZzZXQgbmVlZGVkIHRvIGRvIGd1ZXN0DQo+ID4gcGFzc3Rocm91Z2ggb2YgdGhlIGRvbWFpbi4g
VGhpcyByZWdpc3RlciBzaGFkb3dzIHRoZSBIb3N0IFBoeXNpY2FsDQo+ID4gQWRkcmVzcyByZWdp
c3RlcnMgZGlyZWN0bHksIGluY2x1ZGluZyB0aGUgcmVzb3VyY2UgdHlwZSBiaXRzLiBBZnRlcg0K
PiA+IGNhbGN1bGF0aW5nIHRoZSBvZmZzZXQsIHRoZSBleHRyYSBiaXRzIGxlYWQgdG8gdGhlIFZN
RCByZXNvdXJjZXMgYmVpbmcNCj4gPiBvdmVyLXByb3Zpc2lvbmVkIGF0IHRoZSBmcm9udCBhbmQg
dW5kZXItcHJvdmlzaW9uZWQgYXQgdGhlIGJhY2suDQo+ID4gDQo+ID4gRXhhbXBsZToNCj4gPiBw
Y2kgMTAwMDA6ODA6MDIuMDogcmVnIDB4MTA6IFttZW0gMHhmODAxZmZmYy0weGY4MDNmZmZiIDY0
Yml0XQ0KPiA+IA0KPiA+IEV4cGVjdGVkOg0KPiA+IHBjaSAxMDAwMDo4MDowMi4wOiByZWcgMHgx
MDogW21lbSAweGY4MDIwMDAwLTB4ZjgwM2ZmZmYgNjRiaXRdDQo+ID4gDQo+ID4gSWYgb3RoZXIg
ZGV2aWNlcyBhcmUgbWFwcGVkIGluIHRoZSBvdmVyLXByb3Zpc2lvbmVkIGZyb250LCBpdCBjb3Vs
ZCBsZWFkDQo+ID4gdG8gcmVzb3VyY2UgY29uZmxpY3QgaXNzdWVzIHdpdGggVk1EIG9yIHRob3Nl
IGRldmljZXMuDQo+ID4gDQo+ID4gRml4ZXM6IGExYTMwMTcwMTM4YzkgKCJQQ0k6IHZtZDogRml4
IHNoYWRvdyBvZmZzZXRzIHRvIHJlZmxlY3Qgc3BlYyBjaGFuZ2VzIikNCj4gPiBDYzogc3RhYmxl
QHZnZXIua2VybmVsLm9yZyAjIHY0LjE5Kw0KPiA+IFNpZ25lZC1vZmYtYnk6IEpvbiBEZXJyaWNr
IDxqb25hdGhhbi5kZXJyaWNrQGludGVsLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9wY2kv
Y29udHJvbGxlci92bWQuYyB8IDYgKysrKy0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2Vy
dGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
cGNpL2NvbnRyb2xsZXIvdm1kLmMgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3ZtZC5jDQo+ID4g
aW5kZXggZGFjOTFkNi4uZTM4NmQ0ZSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250
cm9sbGVyL3ZtZC5jDQo+ID4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci92bWQuYw0KPiA+
IEBAIC00NDUsOSArNDQ1LDExIEBAIHN0YXRpYyBpbnQgdm1kX2VuYWJsZV9kb21haW4oc3RydWN0
IHZtZF9kZXYgKnZtZCwgdW5zaWduZWQgbG9uZyBmZWF0dXJlcykNCj4gPiAgCQkJaWYgKCFtZW1i
YXIyKQ0KPiA+ICAJCQkJcmV0dXJuIC1FTk9NRU07DQo+ID4gIAkJCW9mZnNldFswXSA9IHZtZC0+
ZGV2LT5yZXNvdXJjZVtWTURfTUVNQkFSMV0uc3RhcnQgLQ0KPiA+IC0JCQkJCXJlYWRxKG1lbWJh
cjIgKyBNQjJfU0hBRE9XX09GRlNFVCk7DQo+ID4gKwkJCQkJKHJlYWRxKG1lbWJhcjIgKyBNQjJf
U0hBRE9XX09GRlNFVCkgJg0KPiA+ICsJCQkJCSBQQ0lfQkFTRV9BRERSRVNTX01FTV9NQVNLKTsN
Cj4gPiAgCQkJb2Zmc2V0WzFdID0gdm1kLT5kZXYtPnJlc291cmNlW1ZNRF9NRU1CQVIyXS5zdGFy
dCAtDQo+ID4gLQkJCQkJcmVhZHEobWVtYmFyMiArIE1CMl9TSEFET1dfT0ZGU0VUICsgOCk7DQo+
ID4gKwkJCQkJKHJlYWRxKG1lbWJhcjIgKyBNQjJfU0hBRE9XX09GRlNFVCArIDgpICYNCj4gPiAr
CQkJCQkgUENJX0JBU0VfQUREUkVTU19NRU1fTUFTSyk7DQo+ID4gIAkJCXBjaV9pb3VubWFwKHZt
ZC0+ZGV2LCBtZW1iYXIyKTsNCj4gPiAgCQl9DQo+ID4gIAl9DQo=
