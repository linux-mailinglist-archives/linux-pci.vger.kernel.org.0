Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63C7722C1AD
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jul 2020 11:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbgGXJIS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Jul 2020 05:08:18 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2522 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726870AbgGXJIS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 24 Jul 2020 05:08:18 -0400
Received: from lhreml712-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id CC85C756A4357BF9B826;
        Fri, 24 Jul 2020 10:08:16 +0100 (IST)
Received: from lhreml715-chm.china.huawei.com (10.201.108.66) by
 lhreml712-chm.china.huawei.com (10.201.108.63) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Fri, 24 Jul 2020 10:08:16 +0100
Received: from lhreml715-chm.china.huawei.com ([10.201.108.66]) by
 lhreml715-chm.china.huawei.com ([10.201.108.66]) with mapi id 15.01.1913.007;
 Fri, 24 Jul 2020 10:08:16 +0100
From:   Shiju Jose <shiju.jose@huawei.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "bp@alien8.de" <bp@alien8.de>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "zhangliguang@linux.alibaba.com" <zhangliguang@linux.alibaba.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "Wangkefeng (OS Kernel Lab)" <wangkefeng.wang@huawei.com>,
        "jroedel@suse.de" <jroedel@suse.de>,
        Linuxarm <linuxarm@huawei.com>,
        yangyicong <yangyicong@huawei.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        tanxiaofei <tanxiaofei@huawei.com>
Subject: RE: [PATCH v13 0/2] ACPI / APEI: Add support to notify the vendor
 specific HW errors
Thread-Topic: [PATCH v13 0/2] ACPI / APEI: Add support to notify the vendor
 specific HW errors
Thread-Index: AQHWYBVLUw9+eDYtd0e9WQRb1j3VeakVv3yAgACxleA=
Date:   Fri, 24 Jul 2020 09:08:16 +0000
Message-ID: <5c86b434fe3a47eaabf488dea14efd25@huawei.com>
References: <20200722104245.1060-1-shiju.jose@huawei.com>
 <20200723232301.GA1468407@bjorn-Precision-5520>
In-Reply-To: <20200723232301.GA1468407@bjorn-Precision-5520>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.85.142]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgQmpvcm4sDQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEJqb3JuIEhl
bGdhYXMgW21haWx0bzpoZWxnYWFzQGtlcm5lbC5vcmddDQo+U2VudDogMjQgSnVseSAyMDIwIDAw
OjIzDQo+VG86IFNoaWp1IEpvc2UgPHNoaWp1Lmpvc2VAaHVhd2VpLmNvbT4NCj5DYzogbGludXgt
YWNwaUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0K
Pmtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IHJqd0Byand5c29ja2kubmV0OyBicEBhbGllbjguZGU7
DQo+amFtZXMubW9yc2VAYXJtLmNvbTsgbGVuYkBrZXJuZWwub3JnOyB0b255Lmx1Y2tAaW50ZWwu
Y29tOw0KPmRhbi5jYXJwZW50ZXJAb3JhY2xlLmNvbTsgemhhbmdsaWd1YW5nQGxpbnV4LmFsaWJh
YmEuY29tOw0KPmFuZHJpeS5zaGV2Y2hlbmtvQGxpbnV4LmludGVsLmNvbTsgV2FuZ2tlZmVuZyAo
T1MgS2VybmVsIExhYikNCj48d2FuZ2tlZmVuZy53YW5nQGh1YXdlaS5jb20+OyBqcm9lZGVsQHN1
c2UuZGU7IExpbnV4YXJtDQo+PGxpbnV4YXJtQGh1YXdlaS5jb20+OyB5YW5neWljb25nIDx5YW5n
eWljb25nQGh1YXdlaS5jb20+OyBKb25hdGhhbg0KPkNhbWVyb24gPGpvbmF0aGFuLmNhbWVyb25A
aHVhd2VpLmNvbT47IHRhbnhpYW9mZWkNCj48dGFueGlhb2ZlaUBodWF3ZWkuY29tPg0KPlN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggdjEzIDAvMl0gQUNQSSAvIEFQRUk6IEFkZCBzdXBwb3J0IHRvIG5vdGlm
eSB0aGUgdmVuZG9yDQo+c3BlY2lmaWMgSFcgZXJyb3JzDQo+DQo+T24gV2VkLCBKdWwgMjIsIDIw
MjAgYXQgMTE6NDI6NDNBTSArMDEwMCwgU2hpanUgSm9zZSB3cm90ZToNCj4+IENQRVIgcmVjb3Jk
cyBkZXNjcmliaW5nIGEgZmlybXdhcmUtZmlyc3QgZXJyb3IgYXJlIGlkZW50aWZpZWQgYnkgR1VJ
RC4NCj4+IFRoZSBnaGVzIGRyaXZlciBjdXJyZW50bHkgbG9ncywgYnV0IGlnbm9yZXMgYW55IHVu
a25vd24gQ1BFUiByZWNvcmRzLg0KPj4gVGhpcyBwcmV2ZW50cyBkZXNjcmliaW5nIGVycm9ycyB0
aGF0IGNhbid0IGJlIHJlcHJlc2VudGVkIGJ5IGENCj4+IHN0YW5kYXJkIGVudHJ5LCB0aGF0IHdv
dWxkIG90aGVyd2lzZSBhbGxvdyBhIGRyaXZlciB0byByZWNvdmVyIGZyb20gYW4NCj5lcnJvci4N
Cj4+IFRoZSBVRUZJIHNwZWMgY2FsbHMgdGhlc2UgJ05vbi1zdGFuZGFyZCBTZWN0aW9uIEJvZHkn
IChOLjIuMyBvZg0KPj4gdmVyc2lvbiAyLjgpLg0KPj4NCj4+IHBhdGNoIHNldA0KPj4gMS4gYWRk
IGEgbm90aWZpZXIgY2hhaW4gZm9yIHRoZXNlIG5vbi1zdGFuZGFyZC92ZW5kb3ItcmVjb3Jkcw0K
Pj4gICAgaW4gdGhlIGdoZXMgZHJpdmVyLg0KPj4NCj4+IDIuIGFkZCBhIGRyaXZlciB0byBoYW5k
bGUgSGlTaWxpY29uIEhJUCBQQ0llIGNvbnRyb2xsZXIncyBlcnJvcnMuDQo+Pg0KPj4gQ2hhbmdl
czoNCj4+DQo+PiBWMTM6DQo+PiAxLiBGb2xsb3dpbmcgY2hhbmdlcyBpbiB0aGUgSElQIFBDSWUg
ZXJyb3IgaGFuZGxpbmcgZHJpdmVyLg0KPj4gMS4xIEFkZCBCam9ybidzIGFja2VkLWJ5Lg0KPj4g
MS4yLiBBZGRyZXNzIHRoZSBjb21tZW50cyBhbmQgbWFjcm9zIG9yZGVyIEJqb3JuIG1lbnRpb25l
ZC4NCj4+ICAgICAgRml4IHRoZSB3b3JkcyBpbiB0aGUgY29tbWl0Lg0KPg0KPlRoaXMgc2VyaWVz
IGlzIGlsbC1mb3JtZWQ6DQo+DQo+ICAtIEp1bCAyMiAgNTozOSBTaGlqdSBKb3NlICAgICAgW1BB
VENIIHYxMyAwLzJdIEFDUEkgLyBBUEVJOiBBZGQgc3VwcG9ydCB0byBub3QNCj4gIC0gSnVsIDIy
ICA1OjM5IFNoaWp1IEpvc2UgICAgICDilJTilIA+W1BBVENIIHYxMyAxLzJdIEFDUEkgLyBBUEVJ
OiBBZGQgYSBub3RpZmllcg0KPiAgLSBKdWwgMjIgIDU6NDIgU2hpanUgSm9zZSAgICAgIFtQQVRD
SCB2MTMgMC8yXSBBQ1BJIC8gQVBFSTogQWRkIHN1cHBvcnQgdG8gbm90DQo+ICAtIEp1bCAyMiAg
NTo0MiBTaGlqdSBKb3NlICAgICAg4pSU4pSAPltQQVRDSCB2MTMgMi8yXSBQQ0k6IGhpcDogQWRk
IGhhbmRsaW5nIG9mIEhpDQpnaXQgc2VuZC1lbWFpbCBmYWlsZWQgdG8gc2VuZCBvdXQgb25lIHBh
dGNoIGVhY2ggdGltZSBpbiB0aGUgcGF0Y2ggc2VyaWVzDQpkdWUgdG8gc29tZSBpbnRlcm5hbCBl
cnJvci4gDQo+DQo+UGF0Y2hlcyAxLzIgYW5kIDIvMiBuZXZlciBhcHBlYXIgaW4gdGhlIHNhbWUg
dGhyZWFkLiAgQm90aCBzaG91bGQgYmUgcmVwbGllcw0KPnRvIDAvMi4gIEFuZCBzaG91bGQgYmUg
b25seSAqb25lKiB2MTMgMC8yLCBub3QgdHdvIDopDQo+DQo+Qmpvcm4NCg0KVGhhbmtzLA0KU2hp
anUNCg0K
