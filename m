Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33D4B2A3AE3
	for <lists+linux-pci@lfdr.de>; Tue,  3 Nov 2020 04:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725980AbgKCDO0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Nov 2020 22:14:26 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:3655 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbgKCDOZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Nov 2020 22:14:25 -0500
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4CQFHx1QbzzXj8j;
        Tue,  3 Nov 2020 11:14:21 +0800 (CST)
Received: from dggema758-chm.china.huawei.com (10.1.198.200) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Tue, 3 Nov 2020 11:14:21 +0800
Received: from dggema755-chm.china.huawei.com (10.1.198.197) by
 dggema758-chm.china.huawei.com (10.1.198.200) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Tue, 3 Nov 2020 11:14:21 +0800
Received: from dggema755-chm.china.huawei.com ([10.1.198.197]) by
 dggema755-chm.china.huawei.com ([10.1.198.197]) with mapi id 15.01.1913.007;
 Tue, 3 Nov 2020 11:14:21 +0800
From:   zhangqilong <zhangqilong3@huawei.com>
To:     Vidya Sagar <vidyas@nvidia.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0hdIFBDSTogZHdjOiBmaXggcmVmZXJlbmNlIGxlYWsg?=
 =?utf-8?B?aW4gcGV4X2VwX2V2ZW50X3BleF9yc3RfZGVhc3NlcnQ=?=
Thread-Topic: [PATCH] PCI: dwc: fix reference leak in
 pex_ep_event_pex_rst_deassert
Thread-Index: AQHWsYxe5e1btT8ehUO6I3qlOytw3Km1ttWA
Date:   Tue, 3 Nov 2020 03:14:21 +0000
Message-ID: <b1f6b6805a7746b48020d7cfaaa73fab@huawei.com>
References: <20201102143045.142121-1-zhangqilong3@huawei.com>
 <f09c0801-d584-3c27-d3e7-ca59a64a30d1@nvidia.com>
In-Reply-To: <f09c0801-d584-3c27-d3e7-ca59a64a30d1@nvidia.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.179.28]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkNCg0KPiANCj4gDQo+IE9uIDExLzIvMjAyMCA4OjAwIFBNLCBaaGFuZyBRaWxvbmcgd3JvdGU6
DQo+ID4gRXh0ZXJuYWwgZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNo
bWVudHMNCj4gPg0KPiA+DQo+ID4gcG1fcnVudGltZV9nZXRfc3luYyB3aWxsIGluY3JlbWVudCBw
bSB1c2FnZSBjb3VudGVyIGV2ZW4gaXQgZmFpbGVkLg0KPiA+IEZvcmdldHRpbmcgdG8gcG1fcnVu
dGltZV9wdXRfbm9pZGxlIHdpbGwgcmVzdWx0IGluIHJlZmVyZW5jZSBsZWFrIGluDQo+ID4gcGV4
X2VwX2V2ZW50X3BleF9yc3RfZGVhc3NlcnQsIHNvIHdlIHNob3VsZCBmaXggaXQuDQo+ID4NCj4g
PiBGaXhlczogYzU3MjQ3Zjk0MGU4ZSAoIlBDSTogdGVncmE6IEFkZCBzdXBwb3J0IGZvciBQQ0ll
IGVuZHBvaW50IG1vZGUNCj4gPiBpbiBUZWdyYTE5NCIpDQo+ID4gU2lnbmVkLW9mZi1ieTogWmhh
bmcgUWlsb25nIDx6aGFuZ3FpbG9uZzNAaHVhd2VpLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGRyaXZl
cnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtdGVncmExOTQuYyB8IDEgKw0KPiA+ICAgMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9w
Y2kvY29udHJvbGxlci9kd2MvcGNpZS10ZWdyYTE5NC5jDQo+ID4gYi9kcml2ZXJzL3BjaS9jb250
cm9sbGVyL2R3Yy9wY2llLXRlZ3JhMTk0LmMNCj4gPiBpbmRleCBmOTIwZTdlZmUxMTguLjkzNjUx
MGI1YzY0OSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ll
LXRlZ3JhMTk0LmMNCj4gPiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLXRl
Z3JhMTk0LmMNCj4gPiBAQCAtMTY2Miw2ICsxNjYyLDcgQEAgc3RhdGljIHZvaWQgcGV4X2VwX2V2
ZW50X3BleF9yc3RfZGVhc3NlcnQoc3RydWN0DQo+ID4gdGVncmFfcGNpZV9kdyAqcGNpZSkNCj4g
Pg0KPiA+ICAgICAgICAgIHJldCA9IHBtX3J1bnRpbWVfZ2V0X3N5bmMoZGV2KTsNCj4gPiAgICAg
ICAgICBpZiAocmV0IDwgMCkgew0KPiA+ICsgICAgICAgICAgICAgICBwbV9ydW50aW1lX3B1dF9u
b2lkbGUoZGV2KTsNCj4gV2h5IGNhbid0IHdlIGNhbGwgcG1fcnVudGltZV9wdXRfc3luYyhkZXYp
IGFzIHRoYXQgaXMgd2hhdCBpcyBiZWluZyBjYWxsZWQgaW4NCj4gZmFpbHVyZSBjYXNlcyBhbnl3
YXkgZnVydGhlciBkb3duIGluIHRoaXMgQVBJPw0KPiANCkJvdGggb2YgdGhlIHR3byBmdW5jdGlv
bnMgYXJlIE9LLCB0aGUgZGlmZmVyZW5jZSBpcyB0aGF0LCB3aGVuIHBtX3J1bnRpbWVfcHV0X3N5
bmMgZmFpbGVkKHJ1bnRpbWUgb2YgdGhlIGRldmljZSBoYXMgZXJyb3IsIHRoZSBkZXZpY2UgaXMg
aW4gSW5hY2Nlc3NpYmxlIHN0YXRlIG9yIG90aGVyIGVycm9yIHN0YXRlLi4uKSwgaXQgb25seSBp
bmNyZWFzZSB0aGUgdXNhZ2UgY291bnQgb2YgdGhlIHBvd2VyLCBhbmQgZG8gbm90aGluZyBlbHNl
LiBXZSBtZXJlbHkgbmVlZCBjYWxsIHBtX3J1bnRpbWVfcHV0X25vaWRsZSB0byBkZWNyZWFzZSB0
aGUgdXNhZ2UgY291bnQuIElmIHdlIGNhbGwgcG1fcnVudGltZV9wdXRfc3luYyB0byByZXNldCBp
dCwgaXQgd2lsbCBub3RpZnkgZGV2aWNlIGJ1cyB0eXBlIGlmIHRoZSBkZXZpY2UgY2FuIGJlIHN1
c3BlbmRlZCwgYW5kIHRoYXQgaXMgbWVhbmxlc3Mgd2hlbiBwbV9ydW50aW1lX3B1dF9zeW5jIGZh
aWxlZC4NCg0KVGhhbmtzLCBiZXN0IHdpc2ghDQoNClpoYW5nIFFpbG9uZw0KPiA+ICAgICAgICAg
ICAgICAgICAgZGV2X2VycihkZXYsICJGYWlsZWQgdG8gZ2V0IHJ1bnRpbWUgc3luYyBmb3IgUENJ
ZQ0KPiBkZXY6ICVkXG4iLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICByZXQpOw0KPiA+
ICAgICAgICAgICAgICAgICAgcmV0dXJuOw0KPiA+IC0tDQo+ID4gMi4xNy4xDQo+ID4NCg==
