Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9979921D78F
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jul 2020 15:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729796AbgGMNu1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jul 2020 09:50:27 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2458 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729492AbgGMNu1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Jul 2020 09:50:27 -0400
Received: from lhreml713-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 2AD8B535D0E24ED2A09F;
        Mon, 13 Jul 2020 14:50:25 +0100 (IST)
Received: from lhreml715-chm.china.huawei.com (10.201.108.66) by
 lhreml713-chm.china.huawei.com (10.201.108.64) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Mon, 13 Jul 2020 14:50:24 +0100
Received: from lhreml715-chm.china.huawei.com ([10.201.108.66]) by
 lhreml715-chm.china.huawei.com ([10.201.108.66]) with mapi id 15.01.1913.007;
 Mon, 13 Jul 2020 14:50:24 +0100
From:   Shiju Jose <shiju.jose@huawei.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
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
Subject: RE: [PATCH v11 1/2] ACPI / APEI: Add a notifier chain for unknown
 (vendor) CPER records
Thread-Topic: [PATCH v11 1/2] ACPI / APEI: Add a notifier chain for unknown
 (vendor) CPER records
Thread-Index: AQHWSI3SBRG6MT5ZnEeiXXWtP5HqWakFTx6ggAAdaICAADIgMP//9UIAgAARyYA=
Date:   Mon, 13 Jul 2020 13:50:24 +0000
Message-ID: <9009d75f37a34c7b82ead695bbab147b@huawei.com>
References: <20200622120527.690-1-shiju.jose@huawei.com>
 <20200622120527.690-2-shiju.jose@huawei.com>
 <05c8916f4f85421f871e9cbff112512b@huawei.com>
 <CAJZ5v0gfpsejvNAOso2ODqLdSBCZFe=mV32BtTr6aZ2-C=X-BA@mail.gmail.com>
 <9a5b81441f7149f8bfc4e65a4309a2c5@huawei.com>
 <CAJZ5v0jXV6MCxoYk7h2vVzvraFeyeWUhEarNK2R02Kb9pscodg@mail.gmail.com>
In-Reply-To: <CAJZ5v0jXV6MCxoYk7h2vVzvraFeyeWUhEarNK2R02Kb9pscodg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.82.58]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgUmFmYWVsLA0KDQo+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj5Gcm9tOiBsaW51eC1w
Y2ktb3duZXJAdmdlci5rZXJuZWwub3JnIFttYWlsdG86bGludXgtcGNpLQ0KPm93bmVyQHZnZXIu
a2VybmVsLm9yZ10gT24gQmVoYWxmIE9mIFJhZmFlbCBKLiBXeXNvY2tpDQo+U2VudDogMTMgSnVs
eSAyMDIwIDE0OjM4DQo+VG86IFNoaWp1IEpvc2UgPHNoaWp1Lmpvc2VAaHVhd2VpLmNvbT4NCj5D
YzogUmFmYWVsIEouIFd5c29ja2kgPHJhZmFlbEBrZXJuZWwub3JnPjsgbGludXgtYWNwaUB2Z2Vy
Lmtlcm5lbC5vcmc7IGxpbnV4LQ0KPnBjaUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc7IHJqd0Byand5c29ja2kubmV0Ow0KPmhlbGdhYXNAa2VybmVsLm9yZzsg
YnBAYWxpZW44LmRlOyBqYW1lcy5tb3JzZUBhcm0uY29tOw0KPmxlbmJAa2VybmVsLm9yZzsgdG9u
eS5sdWNrQGludGVsLmNvbTsgZGFuLmNhcnBlbnRlckBvcmFjbGUuY29tOw0KPnpoYW5nbGlndWFu
Z0BsaW51eC5hbGliYWJhLmNvbTsgYW5kcml5LnNoZXZjaGVua29AbGludXguaW50ZWwuY29tOw0K
PldhbmdrZWZlbmcgKE9TIEtlcm5lbCBMYWIpIDx3YW5na2VmZW5nLndhbmdAaHVhd2VpLmNvbT47
DQo+anJvZWRlbEBzdXNlLmRlOyBMaW51eGFybSA8bGludXhhcm1AaHVhd2VpLmNvbT47IHlhbmd5
aWNvbmcNCj48eWFuZ3lpY29uZ0BodWF3ZWkuY29tPjsgSm9uYXRoYW4gQ2FtZXJvbg0KPjxqb25h
dGhhbi5jYW1lcm9uQGh1YXdlaS5jb20+OyB0YW54aWFvZmVpIDx0YW54aWFvZmVpQGh1YXdlaS5j
b20+DQo+U3ViamVjdDogUmU6IFtQQVRDSCB2MTEgMS8yXSBBQ1BJIC8gQVBFSTogQWRkIGEgbm90
aWZpZXIgY2hhaW4gZm9yIHVua25vd24NCj4odmVuZG9yKSBDUEVSIHJlY29yZHMNCj4NCj5PbiBN
b24sIEp1bCAxMywgMjAyMCBhdCAzOjMzIFBNIFNoaWp1IEpvc2UgPHNoaWp1Lmpvc2VAaHVhd2Vp
LmNvbT4gd3JvdGU6DQo+Pg0KPj4gSGkgUmFmYWVsLA0KPj4NCj4+ID4tLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KPj4gPkZyb206IFJhZmFlbCBKLiBXeXNvY2tpIFttYWlsdG86cmFmYWVsQGtl
cm5lbC5vcmddDQo+PiA+U2VudDogMTMgSnVseSAyMDIwIDEyOjE4DQo+PiA+VG86IFNoaWp1IEpv
c2UgPHNoaWp1Lmpvc2VAaHVhd2VpLmNvbT4NCj4+ID5DYzogbGludXgtYWNwaUB2Z2VyLmtlcm5l
bC5vcmc7IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPj4gPmtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmc7IHJqd0Byand5c29ja2kubmV0OyBoZWxnYWFzQGtlcm5lbC5vcmc7DQo+PiA+
YnBAYWxpZW44LmRlOyBqYW1lcy5tb3JzZUBhcm0uY29tOyBsZW5iQGtlcm5lbC5vcmc7DQo+PiA+
dG9ueS5sdWNrQGludGVsLmNvbTsgZGFuLmNhcnBlbnRlckBvcmFjbGUuY29tOw0KPj4gPnpoYW5n
bGlndWFuZ0BsaW51eC5hbGliYWJhLmNvbTsgYW5kcml5LnNoZXZjaGVua29AbGludXguaW50ZWwu
Y29tOw0KPj4gPldhbmdrZWZlbmcgKE9TIEtlcm5lbCBMYWIpIDx3YW5na2VmZW5nLndhbmdAaHVh
d2VpLmNvbT47DQo+PiA+anJvZWRlbEBzdXNlLmRlOyBMaW51eGFybSA8bGludXhhcm1AaHVhd2Vp
LmNvbT47IHlhbmd5aWNvbmcNCj4+ID48eWFuZ3lpY29uZ0BodWF3ZWkuY29tPjsgSm9uYXRoYW4g
Q2FtZXJvbg0KPj4gPjxqb25hdGhhbi5jYW1lcm9uQGh1YXdlaS5jb20+OyB0YW54aWFvZmVpIDx0
YW54aWFvZmVpQGh1YXdlaS5jb20+DQo+PiA+U3ViamVjdDogUmU6IFtQQVRDSCB2MTEgMS8yXSBB
Q1BJIC8gQVBFSTogQWRkIGEgbm90aWZpZXIgY2hhaW4gZm9yDQo+PiA+dW5rbm93bg0KPj4gPih2
ZW5kb3IpIENQRVIgcmVjb3Jkcw0KPj4gPg0KPj4gPk9uIE1vbiwgSnVsIDEzLCAyMDIwIGF0IDEw
OjM1IEFNIFNoaWp1IEpvc2UgPHNoaWp1Lmpvc2VAaHVhd2VpLmNvbT4NCj4+ID53cm90ZToNCj4+
ID4+DQo+PiA+PiBIaSBSYWZhZWwsIEhpIEphbWVzLA0KPj4gPj4NCj4+ID4+IENhbiB5b3UgaGVs
cCB0byBtZXJnZSB0aGlzIHBhdGNoIGJlY2F1c2UgSSBhZGRlZCBhbmQgdGVzdGVkIGFsbCB0aGUN
Cj4+ID5zdWdnZXN0aW9ucyBmcm9tIEphbWVzLg0KPj4gPg0KPj4gPkkgY291bGQgYXBwbHkgdGhl
IFsxLzJdIGluIHByaW5jaXBsZSwgYnV0IEkgbmVlZCBhbiBBQ0sgZm9yIHRoZSBbMi8yXQ0KPj4g
PmZyb20gdGhlIFBDSSBzaWRlLg0KPj4gPg0KPj4gPlRoYXQgc2FpZCwgaXQgbG9va3MgbGlrZSB0
aGUgWzEvMl0gaXMgYSBKYW1lcycgcGF0Y2ggdGhhdCB5b3UgYXJlDQo+PiA+c2VuZGluZyB3aXRo
IHNvbWUgY2hhbmdlcyBtYWRlIGJ5IHlvdS4NCj4+IEphbWVzIGFkZGVkIGZvbGxvd2luZyBjaGFu
Z2VzIG9uIHRvcCBvZiB0aGUgb3JpZ2luYWwgcGF0Y2goVjEwKSBieSBtZSwNCj4+IFsgUmVtb3Zl
ZCBrZmlmbyBhbmQgZ2hlc19nZGF0YV9wb29sLiBFeHBhbmRlZCBjb21taXQgbWVzc2FnZSBdIEkg
aGFkDQo+PiBjb25mdXNpb24gaG93IHRoZSBTLW8tYiB0YWcgdG8gYmUgYWRkZWQgZm9yIEphbWVz
J3MgY2hhbmdlcyBpbiB0aGUgVjExDQo+cGF0Y2ggcG9zdGVkLg0KPg0KPlNvIEphbWVzIHNob3Vs
ZCBoYXZlIHNlbnQgdGhlIHBhdGNoIHdpdGggaGlzIFMtby1iIHVuZGVyIGl0Lg0KPg0KPllvdSBj
YW5ub3QgYWRkIFMtby1iIGZvciBzb21lYm9keSBlbHNlIHRvIGFueSBwYXRjaGVzLiAgWW91IGNh
biBvbmx5IGFkZA0KPnlvdXIgUy1vLWIgdG8gc29tZWJvZHkgZWxzZSdzIHBhdGNoIGlmIHlvdSBo
YXZlIG1hZGUgYW55IGNoYW5nZXMgb24gdG9wIG9mDQo+dGhlIG9yaWdpbmFsLg0KPg0KPkluIGNh
c2UgeW91IHdhbnQgdG8gbWFrZSBhIHJlY29yZCBvZiBzb21lYm9keSBlbHNlJ3MgY29udHJpYnV0
aW9uIHRvIHlvdXINCj5wYXRjaCwgeW91IGNhbiB1c2UgdGhlIENvLWRldmVsb3BlZC1ieSB0YWcu
DQoNCk9rLiBJIHdpbGwgcmVzZW5kIHRoZSBwYXRjaCB3aXRoIENvLWRldmVsb3BlZC1ieSB0YWcu
DQoNCj4NCj5UaGFua3MhDQoNClRoYW5rcywNClNoaWp1DQo=
