Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0989121D743
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jul 2020 15:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729837AbgGMNdh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jul 2020 09:33:37 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2457 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729564AbgGMNdg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Jul 2020 09:33:36 -0400
Received: from lhreml714-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id AAD3E441B1BF1BE1EE13;
        Mon, 13 Jul 2020 14:33:34 +0100 (IST)
Received: from lhreml715-chm.china.huawei.com (10.201.108.66) by
 lhreml714-chm.china.huawei.com (10.201.108.65) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Mon, 13 Jul 2020 14:33:34 +0100
Received: from lhreml715-chm.china.huawei.com ([10.201.108.66]) by
 lhreml715-chm.china.huawei.com ([10.201.108.66]) with mapi id 15.01.1913.007;
 Mon, 13 Jul 2020 14:33:34 +0100
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
Thread-Index: AQHWSI3SBRG6MT5ZnEeiXXWtP5HqWakFTx6ggAAdaICAADIgMA==
Date:   Mon, 13 Jul 2020 13:33:33 +0000
Message-ID: <9a5b81441f7149f8bfc4e65a4309a2c5@huawei.com>
References: <20200622120527.690-1-shiju.jose@huawei.com>
 <20200622120527.690-2-shiju.jose@huawei.com>
 <05c8916f4f85421f871e9cbff112512b@huawei.com>
 <CAJZ5v0gfpsejvNAOso2ODqLdSBCZFe=mV32BtTr6aZ2-C=X-BA@mail.gmail.com>
In-Reply-To: <CAJZ5v0gfpsejvNAOso2ODqLdSBCZFe=mV32BtTr6aZ2-C=X-BA@mail.gmail.com>
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

SGkgUmFmYWVsLA0KDQo+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj5Gcm9tOiBSYWZhZWwg
Si4gV3lzb2NraSBbbWFpbHRvOnJhZmFlbEBrZXJuZWwub3JnXQ0KPlNlbnQ6IDEzIEp1bHkgMjAy
MCAxMjoxOA0KPlRvOiBTaGlqdSBKb3NlIDxzaGlqdS5qb3NlQGh1YXdlaS5jb20+DQo+Q2M6IGxp
bnV4LWFjcGlAdmdlci5rZXJuZWwub3JnOyBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBsaW51
eC0NCj5rZXJuZWxAdmdlci5rZXJuZWwub3JnOyByandAcmp3eXNvY2tpLm5ldDsgaGVsZ2Fhc0Br
ZXJuZWwub3JnOw0KPmJwQGFsaWVuOC5kZTsgamFtZXMubW9yc2VAYXJtLmNvbTsgbGVuYkBrZXJu
ZWwub3JnOw0KPnRvbnkubHVja0BpbnRlbC5jb207IGRhbi5jYXJwZW50ZXJAb3JhY2xlLmNvbTsN
Cj56aGFuZ2xpZ3VhbmdAbGludXguYWxpYmFiYS5jb207IGFuZHJpeS5zaGV2Y2hlbmtvQGxpbnV4
LmludGVsLmNvbTsNCj5XYW5na2VmZW5nIChPUyBLZXJuZWwgTGFiKSA8d2FuZ2tlZmVuZy53YW5n
QGh1YXdlaS5jb20+Ow0KPmpyb2VkZWxAc3VzZS5kZTsgTGludXhhcm0gPGxpbnV4YXJtQGh1YXdl
aS5jb20+OyB5YW5neWljb25nDQo+PHlhbmd5aWNvbmdAaHVhd2VpLmNvbT47IEpvbmF0aGFuIENh
bWVyb24NCj48am9uYXRoYW4uY2FtZXJvbkBodWF3ZWkuY29tPjsgdGFueGlhb2ZlaSA8dGFueGlh
b2ZlaUBodWF3ZWkuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjExIDEvMl0gQUNQSSAvIEFQ
RUk6IEFkZCBhIG5vdGlmaWVyIGNoYWluIGZvciB1bmtub3duDQo+KHZlbmRvcikgQ1BFUiByZWNv
cmRzDQo+DQo+T24gTW9uLCBKdWwgMTMsIDIwMjAgYXQgMTA6MzUgQU0gU2hpanUgSm9zZSA8c2hp
anUuam9zZUBodWF3ZWkuY29tPg0KPndyb3RlOg0KPj4NCj4+IEhpIFJhZmFlbCwgSGkgSmFtZXMs
DQo+Pg0KPj4gQ2FuIHlvdSBoZWxwIHRvIG1lcmdlIHRoaXMgcGF0Y2ggYmVjYXVzZSBJIGFkZGVk
IGFuZCB0ZXN0ZWQgYWxsIHRoZQ0KPnN1Z2dlc3Rpb25zIGZyb20gSmFtZXMuDQo+DQo+SSBjb3Vs
ZCBhcHBseSB0aGUgWzEvMl0gaW4gcHJpbmNpcGxlLCBidXQgSSBuZWVkIGFuIEFDSyBmb3IgdGhl
IFsyLzJdIGZyb20gdGhlDQo+UENJIHNpZGUuDQo+DQo+VGhhdCBzYWlkLCBpdCBsb29rcyBsaWtl
IHRoZSBbMS8yXSBpcyBhIEphbWVzJyBwYXRjaCB0aGF0IHlvdSBhcmUgc2VuZGluZyB3aXRoDQo+
c29tZSBjaGFuZ2VzIG1hZGUgYnkgeW91Lg0KSmFtZXMgYWRkZWQgZm9sbG93aW5nIGNoYW5nZXMg
b24gdG9wIG9mIHRoZSBvcmlnaW5hbCBwYXRjaChWMTApIGJ5IG1lLCANClsgUmVtb3ZlZCBrZmlm
byBhbmQgZ2hlc19nZGF0YV9wb29sLiBFeHBhbmRlZCBjb21taXQgbWVzc2FnZSBdDQpJIGhhZCBj
b25mdXNpb24gaG93IHRoZSBTLW8tYiB0YWcgdG8gYmUgYWRkZWQgZm9yIEphbWVzJ3MgY2hhbmdl
cyBpbiB0aGUgVjExIHBhdGNoIHBvc3RlZC4NCg0KPg0KPkluIHRoYXQgY2FzZSB0aGUgb3JkZXJp
bmcgb2YgdGhlIFMtby1iIHRhZ3MgdW5kZXIgaXQgc2hvdWxkIGJlIGRpZmZlcmVudCAodGhlIFMt
DQo+by1iIGZyb20gSmFtZXMsIHRoZSB3aGF0LXlvdS1oYXZlLWNoYW5nZSBsaW5lIGFuZCB0aGUg
Uy1vLWIgZnJvbSB5b3UpIGFuZA0KPmFsc28gdGhlIEZyb206IHRhZyBzaG91bGQgcG9pbnQgdG8g
SmFtZXMuDQo+DQo+VGhhbmtzIQ0KDQpUaGFua3MsDQpTaGlqdQ0K
