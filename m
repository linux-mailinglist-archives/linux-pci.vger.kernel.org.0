Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90050234756
	for <lists+linux-pci@lfdr.de>; Fri, 31 Jul 2020 16:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730802AbgGaOHQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 31 Jul 2020 10:07:16 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2551 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730766AbgGaOHQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 31 Jul 2020 10:07:16 -0400
Received: from lhreml718-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 2158DCE1B436D3FEB019;
        Fri, 31 Jul 2020 15:07:14 +0100 (IST)
Received: from lhreml715-chm.china.huawei.com (10.201.108.66) by
 lhreml718-chm.china.huawei.com (10.201.108.69) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Fri, 31 Jul 2020 15:07:13 +0100
Received: from lhreml715-chm.china.huawei.com ([10.201.108.66]) by
 lhreml715-chm.china.huawei.com ([10.201.108.66]) with mapi id 15.01.1913.007;
 Fri, 31 Jul 2020 15:07:13 +0100
From:   Shiju Jose <shiju.jose@huawei.com>
To:     James Morse <james.morse@arm.com>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "lenb@kernel.org" <lenb@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "zhangliguang@linux.alibaba.com" <zhangliguang@linux.alibaba.com>,
        "Wangkefeng (OS Kernel Lab)" <wangkefeng.wang@huawei.com>,
        "jroedel@suse.de" <jroedel@suse.de>,
        Linuxarm <linuxarm@huawei.com>,
        yangyicong <yangyicong@huawei.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        tanxiaofei <tanxiaofei@huawei.com>
Subject: RE: [PATCH v13 1/2] ACPI / APEI: Add a notifier chain for unknown
 (vendor) CPER records
Thread-Topic: [PATCH v13 1/2] ACPI / APEI: Add a notifier chain for unknown
 (vendor) CPER records
Thread-Index: AQHWYBeNEuC2snlLPEu+XBWu+0jruKkTg3ww///49wCADjUBgIAAES8A
Date:   Fri, 31 Jul 2020 14:07:13 +0000
Message-ID: <9b7f58f2d60549ad91bde2db4e4455ae@huawei.com>
References: <20200722103952.1009-1-shiju.jose@huawei.com>
 <20200722103952.1009-2-shiju.jose@huawei.com>
 <20200722110146.GW3703480@smile.fi.intel.com>
 <eb8336f0357f447baf5c37309d320f57@huawei.com>
 <20200722125038.GZ3703480@smile.fi.intel.com>
 <185f69dd-bfec-20ce-01d6-76947f553e45@arm.com>
In-Reply-To: <185f69dd-bfec-20ce-01d6-76947f553e45@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.82.38]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgSmFtZXMsIA0KDQo+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj5Gcm9tOiBsaW51eC1h
Y3BpLW93bmVyQHZnZXIua2VybmVsLm9yZyBbbWFpbHRvOmxpbnV4LWFjcGktDQo+b3duZXJAdmdl
ci5rZXJuZWwub3JnXSBPbiBCZWhhbGYgT2YgSmFtZXMgTW9yc2UNCj5TZW50OiAzMSBKdWx5IDIw
MjAgMTQ6NDgNCj5UbzogU2hpanUgSm9zZSA8c2hpanUuam9zZUBodWF3ZWkuY29tPg0KPkNjOiBB
bmR5IFNoZXZjaGVua28gPGFuZHJpeS5zaGV2Y2hlbmtvQGxpbnV4LmludGVsLmNvbT47IGxpbnV4
LQ0KPmFjcGlAdmdlci5rZXJuZWwub3JnOyBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBsaW51
eC0NCj5rZXJuZWxAdmdlci5rZXJuZWwub3JnOyByandAcmp3eXNvY2tpLm5ldDsgaGVsZ2Fhc0Br
ZXJuZWwub3JnOw0KPmJwQGFsaWVuOC5kZTsgbGVuYkBrZXJuZWwub3JnOyB0b255Lmx1Y2tAaW50
ZWwuY29tOw0KPmRhbi5jYXJwZW50ZXJAb3JhY2xlLmNvbTsgemhhbmdsaWd1YW5nQGxpbnV4LmFs
aWJhYmEuY29tOyBXYW5na2VmZW5nDQo+KE9TIEtlcm5lbCBMYWIpIDx3YW5na2VmZW5nLndhbmdA
aHVhd2VpLmNvbT47IGpyb2VkZWxAc3VzZS5kZTsNCj5MaW51eGFybSA8bGludXhhcm1AaHVhd2Vp
LmNvbT47IHlhbmd5aWNvbmcgPHlhbmd5aWNvbmdAaHVhd2VpLmNvbT47DQo+Sm9uYXRoYW4gQ2Ft
ZXJvbiA8am9uYXRoYW4uY2FtZXJvbkBodWF3ZWkuY29tPjsgdGFueGlhb2ZlaQ0KPjx0YW54aWFv
ZmVpQGh1YXdlaS5jb20+DQo+U3ViamVjdDogUmU6IFtQQVRDSCB2MTMgMS8yXSBBQ1BJIC8gQVBF
STogQWRkIGEgbm90aWZpZXIgY2hhaW4gZm9yIHVua25vd24NCj4odmVuZG9yKSBDUEVSIHJlY29y
ZHMNCj4NCj5IaSBTaGlqdSwNCj4NCj5PbiAyMi8wNy8yMDIwIDEzOjUwLCBBbmR5IFNoZXZjaGVu
a28gd3JvdGU6DQo+PiBPbiBXZWQsIEp1bCAyMiwgMjAyMCBhdCAxMjozNDoyM1BNICswMDAwLCBT
aGlqdSBKb3NlIHdyb3RlOg0KPg0KPj4+Pj4gQ28tZGV2ZWxvcGVkLWJ5OiBKYW1lcyBNb3JzZSA8
amFtZXMubW9yc2VAYXJtLmNvbT4NCj4+Pj4NCj4+Pj4gQ28tZGV2ZWxvcGVkLWJ5OiBpcyBnb2lu
ZyBfaW4gY29uanVuY3Rpb24gd2l0aF8gU29CIHRhZyB3aGljaCBpcw0KPj4+PiBtaXNzaW5nIGhl
cmUuDQo+Pj4gVGhpcyB0YWcgd2FzIGFkZGVkIGFzIHBlciBpbnN0cnVjdGlvbiBmcm9tIFJhZmFl
bC4NCj4+PiBJIHdhcyB0b2xkIHRoYXQgSSBjYW5ub3QgYWRkIFNvQiB0YWcgZm9yIG90aGVycyB1
bmxlc3Mgc3BlY2lmaWNhbGx5IGdpdmVuLg0KPj4+IFByb2JhYmx5IEkgd2lsbCBsZWF2ZSBpdCB3
aXRoIFJhZmFlbC9KYW1lcyB0byBoZWxwIG9uIHRoaXMgU29CIHRhZyBhcw0KPj4+IFJhZmFlbCB3
YXMgb2sgdG8gbWVyZ2UgdGhpcyBwYXRjaC4NCj4+DQo+PiBJIHRoaW5rIGl0J3MgYSBtaXN1bmRl
cnN0YW5kaW5nIHNvbWV3aGVyZS4gQWNjb3JkaW5nIHRvIFsxXToNCj4+ICJTaW5jZSBDby1kZXZl
bG9wZWQtYnk6IGRlbm90ZXMgYXV0aG9yc2hpcCwgZXZlcnkgQ28tZGV2ZWxvcGVkLWJ5Og0KPj4g
bXVzdCBiZSBpbW1lZGlhdGVseSBmb2xsb3dlZCBieSBhIFNpZ25lZC1vZmYtYnk6IG9mIHRoZSBh
c3NvY2lhdGVkIGNvLQ0KPmF1dGhvci4iDQo+Pg0KPj4gSXQgbWVhbnMgZWl0aGVyIGJvdGggb3Ig
bm9uZS4NCj4+DQo+PiBbMV06DQo+PiBodHRwczovL3d3dy5rZXJuZWwub3JnL2RvYy9odG1sL2xh
dGVzdC9wcm9jZXNzL3N1Ym1pdHRpbmctcGF0Y2hlcy5odG1sDQo+DQo+U29ycnkgZm9yIHRoaXMg
bWVzcyEgTXkgaW50ZW50aW9uIHdhcyB0byBzdW1tYXJpc2UgbXkgc3VnZ2VzdGlvbiBpbiB0aGUN
Cj5mb3JtIG9mIGEgcGF0Y2gsIEkgd2Fzbid0IGV4cGVjdGluZyB5b3UgdG8gcGljayBpdCB1cC4g
KGFuZCBJIGRpZG4ndCBwb3N0IGl0DQo+YmVjYXVzZSB0aGVyZSB3YXMgb25nb2luZyBkaXNjdXNz
aW9uIG9uIHRoZSBzZWNvbmQgcGFydCkNCj4NCj5JJ2xsIHJlcG9zdCB0aGlzIHdpdGggdGhlIENv
LURldmVsb3BlZC1ieSBzdHVmZi4gWW91J2xsIG5lZWQgdG8gcmUtcG9zdCBpdCB3aXRoDQo+dGhl
IHNlcmllcywgeW91J2xsIG5lZWQgdG8gbW92ZSB5b3VyIFNpZ25lZC1PZmYtQnkgdG8gYmUgbGFz
dCB3aGVuIHlvdSBkbw0KPnRoYXQuDQoNClN1cmUuIFRoYW5rcy4NCkFsc28gcGxlYXNlIGNvbnNp
ZGVyIG1ha2UgeW91IGFzIHRoZSBhdXRob3Igb2YgdGhpcyBwYXRjaCANCmJlY2F1c2UgaXQgaGFz
IG1vcmUgY2hhbmdlcyBmcm9tIHlvdS4NCg0KPg0KPg0KPlRoYW5rcywNCj4NCj5KYW1lcw0KDQpU
aGFua3MsDQpTaGlqdQ0K
