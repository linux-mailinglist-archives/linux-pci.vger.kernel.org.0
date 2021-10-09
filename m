Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF2AA42756E
	for <lists+linux-pci@lfdr.de>; Sat,  9 Oct 2021 03:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbhJIBqX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Oct 2021 21:46:23 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:13881 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbhJIBqX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Oct 2021 21:46:23 -0400
Received: from dggeml709-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HR75k4CsKz903F;
        Sat,  9 Oct 2021 09:39:38 +0800 (CST)
Received: from dggeme756-chm.china.huawei.com (10.3.19.102) by
 dggeml709-chm.china.huawei.com (10.3.17.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Sat, 9 Oct 2021 09:44:24 +0800
Received: from dggeme756-chm.china.huawei.com ([10.6.80.68]) by
 dggeme756-chm.china.huawei.com ([10.6.80.68]) with mapi id 15.01.2308.008;
 Sat, 9 Oct 2021 09:44:24 +0800
From:   "Songxiaowei (Kirin_DRV)" <songxiaowei@hisilicon.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linuxarm <linuxarm@huawei.com>,
        Mauro Carvalho Chehab <mauro.chehab@huawei.com>,
        =?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kw@linux.com>,
        "Wangbinghui (Biggio, Kirin_DRV)" <wangbinghui@hisilicon.com>,
        Rob Herring <robh@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>
Subject: Re: [PATCH v12 00/11] Add support for Hikey 970 PCIe
Thread-Topic: [PATCH v12 00/11] Add support for Hikey 970 PCIe
Thread-Index: Ade8q7iJlFQZnl/9QeuKIfdoWRmMGg==
Date:   Sat, 9 Oct 2021 01:44:24 +0000
Message-ID: <cd22c1e143b94f55a78d969193847812@hisilicon.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.143.62.236]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

QWNrLWJ5IFhpYW93ZWkgU29uZy4NCg0KPiBIaSBMb3JlbnpvLA0KPiANCj4gRW0gVGh1LCA3IE9j
dCAyMDIxIDE1OjQxOjAzICswMTAwDQo+IExvcmVuem8gUGllcmFsaXNpIDxsb3JlbnpvLnBpZXJh
bGlzaUBhcm0uY29tPiBlc2NyZXZldToNCj4gDQo+ID4gT24gVHVlLCBPY3QgMDUsIDIwMjEgYXQg
MDE6MjM6MjFQTSAtMDUwMCwgQmpvcm4gSGVsZ2FhcyB3cm90ZToNCj4gPiA+IFsrY2MgTG9yZW56
b10NCj4gPiA+IA0KPiA+ID4gT24gVHVlLCBPY3QgMDUsIDIwMjEgYXQgMTE6MjQ6NDhBTSArMDIw
MCwgTWF1cm8gQ2FydmFsaG8gQ2hlaGFiIHdyb3RlOiAgDQo+ID4gPiA+IEhpIEJqb3JuLA0KPiA+
ID4gPiANCj4gPiA+ID4gRW0gVHVlLCAyOCBTZXAgMjAyMSAwOTozNDoxMCArMDIwMA0KPiA+ID4g
PiBNYXVybyBDYXJ2YWxobyBDaGVoYWIgPG1jaGVoYWIraHVhd2VpQGtlcm5lbC5vcmc+IGVzY3Jl
dmV1OiAgDQo+ID4gPiAgIA0KPiA+ID4gPiA+ICAgUENJOiBraXJpbjogUmVvcmdhbml6ZSB0aGUg
UEhZIGxvZ2ljIGluc2lkZSB0aGUgZHJpdmVyDQo+ID4gPiA+ID4gICBQQ0k6IGtpcmluOiBBZGQg
c3VwcG9ydCBmb3IgYSBQSFkgbGF5ZXINCj4gPiA+ID4gPiAgIFBDSToga2lyaW46IFVzZSByZWdt
YXAgZm9yIEFQQiByZWdpc3RlcnMNCj4gPiA+ID4gPiAgIFBDSToga2lyaW46IEFkZCBzdXBwb3J0
IGZvciBicmlkZ2Ugc2xvdCBEVCBzY2hlbWENCj4gPiA+ID4gPiAgIFBDSToga2lyaW46IEFkZCBL
aXJpbiA5NzAgY29tcGF0aWJsZQ0KPiA+ID4gPiA+ICAgUENJOiBraXJpbjogQWRkIE1PRFVMRV8q
IG1hY3Jvcw0KPiA+ID4gPiA+ICAgUENJOiBraXJpbjogQWxsb3cgYnVpbGRpbmcgaXQgYXMgYSBt
b2R1bGUNCj4gPiA+ID4gPiAgIFBDSToga2lyaW46IEFkZCBwb3dlcl9vZmYgc3VwcG9ydCBmb3Ig
S2lyaW4gOTYwIFBIWQ0KPiA+ID4gPiA+ICAgUENJOiBraXJpbjogZml4IHBvd2Vyb2ZmIHNlcXVl
bmNlDQo+ID4gPiA+ID4gICBQQ0k6IGtpcmluOiBBbGxvdyByZW1vdmluZyB0aGUgZHJpdmVyICAN
Cj4gPiA+ID4gDQo+ID4gPiA+IEkgZ3Vlc3MgZXZlcnl0aGluZyBpcyBhbHJlYWR5IHNhdGlzZnlp
bmcgdGhlIHJldmlldyBmZWVkYmFja3MuDQo+ID4gPiA+IElmIHNvLCBjb3VsZCB5b3UgcGxlYXNl
IG1lcmdlIHRoZSBQQ0kgb25lcz8gIA0KPiA+ID4gDQo+ID4gPiBMb3JlbnpvIHRha2VzIGNhcmUg
b2YgdGhlIG5hdGl2ZSBob3N0IGJyaWRnZSBkcml2ZXJzLCBzbyBJJ20gc3VyZSB0aGlzDQo+ID4g
PiBpcyBvbiBoaXMgbGlzdC4gIEkgYWRkZWQgaGltIHRvIGNjOiBpbiBjYXNlIG5vdC4gIA0KPiA+
IA0KPiA+IElkZWFsbHkgSSdkIGxpa2UgdG8gc2VlIHRoZXNlIHBhdGNoZXMgQUNLZWQvUmV2aWV3
LWVkIGJ5IHRoZSBraXJpbg0KPiA+IG1haW50YWluZXJzIC0gdGhhdCdzIHdoYXQgSSB3YXMgd2Fp
dGluZyBmb3IgYW5kIHRoYXQncyB3aGF0IHRoZXkNCj4gPiBhcmUgdGhlcmUgZm9yLg0KPiA+IA0K
PiA+IEhhdmluZyBzYWlkIHRoYXQsIEkgd2lsbCBrZWVwIGFuIGV5ZSBvbiB0aGlzIHNlcmllcyBz
byB0aGF0IHdlDQo+ID4gY2FuIGhvcGVmdWxseSBxdWV1ZSBpdCBmb3IgdjUuMTYuDQo+IA0KPiBO
b3Qgc3VyZSBpZiB5b3UgcmVjZWl2ZWQgdGhlIGUtbWFpbCBmcm9tIFhpYW93ZWkgd2l0aCBoaXMg
YWNrLg0KDQpJIGhhdmUgbm90IChhbmQgaXQgZGlkIG5vdCBtYWtlIGl0IHRvIGxpbnV4LXBjaSBl
aXRoZXIpLg0KDQo+IEF0IGxlYXN0IGhlcmUsIEkgb25seSByZWNlaXZlZCBvbiBteSBpbnRlcm5h
bCBlLW1haWwgKHBlcmhhcHMgYmVjYXVzZQ0KPiB0aGUgb3JpZ2luYWwgZS1tYWlsIHdhcyBiYXNl
NjQtZW5jb2RlZCB3aXRoIGdiMjMxMiBjaGFyc2V0KS4gDQo+IA0KPiBTbywgbGV0IG1lIGZvcndh
cmQgaGlzIGFuc3dlciB0byB5b3UsIGMvYyB0aGUgbWFpbGluZyBsaXN0cy4NCg0KUGF0Y2hlcyBz
aG91bGQgYmUgYWNrZWQgd2l0aCB0YWdzIHRoYXQgdG9vbGluZyByZWNvZ25pemUsIHRoaXMNCndv
dWxkIGhlbHAgbWUuDQoNCj4gVGhhbmtzLA0KPiBNYXVybw0KPiANCg0KVGhhbmtzLg0K
