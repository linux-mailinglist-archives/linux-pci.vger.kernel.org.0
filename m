Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA9921A2808
	for <lists+linux-pci@lfdr.de>; Wed,  8 Apr 2020 19:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbgDHRg7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Apr 2020 13:36:59 -0400
Received: from mga14.intel.com ([192.55.52.115]:33692 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726687AbgDHRg6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 8 Apr 2020 13:36:58 -0400
IronPort-SDR: dYfYU+zrhZv41wXbm1NCdk9COFPk5hVXwVKs8z3IMmCem/mBMde5y4XzFzsuBSsU0ljOET8/Ys
 FqxDvqkEtpzA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2020 10:36:58 -0700
IronPort-SDR: NrrouB/3PB08gRYM+dGi9DxzVTlqMa7roUndG1syB/WoX0KjUXf99ShbXLs3jrINH95WkS4cOt
 rUGIQDGgRwIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,359,1580803200"; 
   d="scan'208";a="275519550"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by fmsmga004.fm.intel.com with ESMTP; 08 Apr 2020 10:36:57 -0700
Received: from orsmsx151.amr.corp.intel.com (10.22.226.38) by
 ORSMSX104.amr.corp.intel.com (10.22.225.131) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 8 Apr 2020 10:36:56 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.225]) by
 ORSMSX151.amr.corp.intel.com ([169.254.7.134]) with mapi id 14.03.0439.000;
 Wed, 8 Apr 2020 10:36:56 -0700
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
CC:     "Kalakota, SushmaX" <sushmax.kalakota@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>
Subject: Re: [PATCH] PCI: vmd: Filter resource type bits from shadow register
Thread-Topic: [PATCH] PCI: vmd: Filter resource type bits from shadow
 register
Thread-Index: AQHV/umGQ06Mrizjq0+0sw5eTPqC8ahwEBwA
Date:   Wed, 8 Apr 2020 17:36:55 +0000
Message-ID: <1f3bc6cb57988f052cb94c325fb0af84bd76b980.camel@intel.com>
References: <1584730690-57253-1-git-send-email-jonathan.derrick@intel.com>
In-Reply-To: <1584730690-57253-1-git-send-email-jonathan.derrick@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.255.0.45]
Content-Type: text/plain; charset="utf-8"
Content-ID: <CA24D78AE5660B41A7354A07757C6AE9@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

QW55dGhpbmcgd3Jvbmcgd2l0aCB0aGlzLCBMb3JlbnpvPw0KDQpUaGFua3MNCg0KT24gRnJpLCAy
MDIwLTAzLTIwIGF0IDEyOjU4IC0wNjAwLCBKb24gRGVycmljayB3cm90ZToNCj4gVmVyc2lvbnMg
b2YgVk1EIHdpdGggdGhlIEhvc3QgUGh5c2ljYWwgQWRkcmVzcyBzaGFkb3cgcmVnaXN0ZXIgdXNl
IHRoaXMNCj4gcmVnaXN0ZXIgdG8gY2FsY3VsYXRlIHRoZSBidXMgYWRkcmVzcyBvZmZzZXQgbmVl
ZGVkIHRvIGRvIGd1ZXN0DQo+IHBhc3N0aHJvdWdoIG9mIHRoZSBkb21haW4uIFRoaXMgcmVnaXN0
ZXIgc2hhZG93cyB0aGUgSG9zdCBQaHlzaWNhbA0KPiBBZGRyZXNzIHJlZ2lzdGVycyBkaXJlY3Rs
eSwgaW5jbHVkaW5nIHRoZSByZXNvdXJjZSB0eXBlIGJpdHMuIEFmdGVyDQo+IGNhbGN1bGF0aW5n
IHRoZSBvZmZzZXQsIHRoZSBleHRyYSBiaXRzIGxlYWQgdG8gdGhlIFZNRCByZXNvdXJjZXMgYmVp
bmcNCj4gb3Zlci1wcm92aXNpb25lZCBhdCB0aGUgZnJvbnQgYW5kIHVuZGVyLXByb3Zpc2lvbmVk
IGF0IHRoZSBiYWNrLg0KPiANCj4gRXhhbXBsZToNCj4gcGNpIDEwMDAwOjgwOjAyLjA6IHJlZyAw
eDEwOiBbbWVtIDB4ZjgwMWZmZmMtMHhmODAzZmZmYiA2NGJpdF0NCj4gDQo+IEV4cGVjdGVkOg0K
PiBwY2kgMTAwMDA6ODA6MDIuMDogcmVnIDB4MTA6IFttZW0gMHhmODAyMDAwMC0weGY4MDNmZmZm
IDY0Yml0XQ0KPiANCj4gSWYgb3RoZXIgZGV2aWNlcyBhcmUgbWFwcGVkIGluIHRoZSBvdmVyLXBy
b3Zpc2lvbmVkIGZyb250LCBpdCBjb3VsZCBsZWFkDQo+IHRvIHJlc291cmNlIGNvbmZsaWN0IGlz
c3VlcyB3aXRoIFZNRCBvciB0aG9zZSBkZXZpY2VzLg0KPiANCj4gRml4ZXM6IGExYTMwMTcwMTM4
YzkgKCJQQ0k6IHZtZDogRml4IHNoYWRvdyBvZmZzZXRzIHRvIHJlZmxlY3Qgc3BlYyBjaGFuZ2Vz
IikNCj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcgIyB2NC4xOSsNCj4gU2lnbmVkLW9mZi1i
eTogSm9uIERlcnJpY2sgPGpvbmF0aGFuLmRlcnJpY2tAaW50ZWwuY29tPg0KPiAtLS0NCj4gIGRy
aXZlcnMvcGNpL2NvbnRyb2xsZXIvdm1kLmMgfCA2ICsrKystLQ0KPiAgMSBmaWxlIGNoYW5nZWQs
IDQgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3BjaS9jb250cm9sbGVyL3ZtZC5jIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci92bWQuYw0K
PiBpbmRleCBkYWM5MWQ2Li5lMzg2ZDRlIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250
cm9sbGVyL3ZtZC5jDQo+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvdm1kLmMNCj4gQEAg
LTQ0NSw5ICs0NDUsMTEgQEAgc3RhdGljIGludCB2bWRfZW5hYmxlX2RvbWFpbihzdHJ1Y3Qgdm1k
X2RldiAqdm1kLCB1bnNpZ25lZCBsb25nIGZlYXR1cmVzKQ0KPiAgCQkJaWYgKCFtZW1iYXIyKQ0K
PiAgCQkJCXJldHVybiAtRU5PTUVNOw0KPiAgCQkJb2Zmc2V0WzBdID0gdm1kLT5kZXYtPnJlc291
cmNlW1ZNRF9NRU1CQVIxXS5zdGFydCAtDQo+IC0JCQkJCXJlYWRxKG1lbWJhcjIgKyBNQjJfU0hB
RE9XX09GRlNFVCk7DQo+ICsJCQkJCShyZWFkcShtZW1iYXIyICsgTUIyX1NIQURPV19PRkZTRVQp
ICYNCj4gKwkJCQkJIFBDSV9CQVNFX0FERFJFU1NfTUVNX01BU0spOw0KPiAgCQkJb2Zmc2V0WzFd
ID0gdm1kLT5kZXYtPnJlc291cmNlW1ZNRF9NRU1CQVIyXS5zdGFydCAtDQo+IC0JCQkJCXJlYWRx
KG1lbWJhcjIgKyBNQjJfU0hBRE9XX09GRlNFVCArIDgpOw0KPiArCQkJCQkocmVhZHEobWVtYmFy
MiArIE1CMl9TSEFET1dfT0ZGU0VUICsgOCkgJg0KPiArCQkJCQkgUENJX0JBU0VfQUREUkVTU19N
RU1fTUFTSyk7DQo+ICAJCQlwY2lfaW91bm1hcCh2bWQtPmRldiwgbWVtYmFyMik7DQo+ICAJCX0N
Cj4gIAl9DQo=
