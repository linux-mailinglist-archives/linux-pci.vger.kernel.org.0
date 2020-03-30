Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E585E197B57
	for <lists+linux-pci@lfdr.de>; Mon, 30 Mar 2020 13:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729961AbgC3Lzi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Mar 2020 07:55:38 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2616 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729941AbgC3Lzi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Mar 2020 07:55:38 -0400
Received: from lhreml712-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 884F3AD7BE6865FE7E10;
        Mon, 30 Mar 2020 12:55:36 +0100 (IST)
Received: from lhreml715-chm.china.huawei.com (10.201.108.66) by
 lhreml712-chm.china.huawei.com (10.201.108.63) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 30 Mar 2020 12:55:36 +0100
Received: from lhreml715-chm.china.huawei.com ([10.201.108.66]) by
 lhreml715-chm.china.huawei.com ([10.201.108.66]) with mapi id 15.01.1713.004;
 Mon, 30 Mar 2020 12:55:36 +0100
From:   Shiju Jose <shiju.jose@huawei.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "zhangliguang@linux.alibaba.com" <zhangliguang@linux.alibaba.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        Linuxarm <linuxarm@huawei.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        tanxiaofei <tanxiaofei@huawei.com>,
        yangyicong <yangyicong@huawei.com>
Subject: RE: [PATCH v6 1/2] ACPI / APEI: Add support to notify the vendor
 specific HW errors
Thread-Topic: [PATCH v6 1/2] ACPI / APEI: Add support to notify the vendor
 specific HW errors
Thread-Index: AQHWAsR+4nldebv71E6VKNN8PAfzw6hcw70AgAQRUuCAABIOgIAAEy5w
Date:   Mon, 30 Mar 2020 11:55:35 +0000
Message-ID: <ee79588ee82445dcb76f1fe6c1082fb8@huawei.com>
References: <ShijuJose> <20200325164223.650-1-shiju.jose@huawei.com>
 <20200325164223.650-2-shiju.jose@huawei.com> <20200327182214.GD8015@zn.tnic>
 <b180618fb6cb477ea7185979c11c5868@huawei.com>
 <20200330103353.GC16242@zn.tnic>
In-Reply-To: <20200330103353.GC16242@zn.tnic>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.25.189]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgQm9yaXMsDQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEJvcmlzbGF2
IFBldGtvdiBbbWFpbHRvOmJwQGFsaWVuOC5kZV0NCj5TZW50OiAzMCBNYXJjaCAyMDIwIDExOjM0
DQo+VG86IFNoaWp1IEpvc2UgPHNoaWp1Lmpvc2VAaHVhd2VpLmNvbT4NCj5DYzogbGludXgtYWNw
aUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPmtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmc7IHJqd0Byand5c29ja2kubmV0OyBoZWxnYWFzQGtlcm5lbC5v
cmc7DQo+bGVuYkBrZXJuZWwub3JnOyBqYW1lcy5tb3JzZUBhcm0uY29tOyB0b255Lmx1Y2tAaW50
ZWwuY29tOw0KPmdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnOyB6aGFuZ2xpZ3VhbmdAbGludXgu
YWxpYmFiYS5jb207DQo+dGdseEBsaW51dHJvbml4LmRlOyBMaW51eGFybSA8bGludXhhcm1AaHVh
d2VpLmNvbT47IEpvbmF0aGFuIENhbWVyb24NCj48am9uYXRoYW4uY2FtZXJvbkBodWF3ZWkuY29t
PjsgdGFueGlhb2ZlaSA8dGFueGlhb2ZlaUBodWF3ZWkuY29tPjsNCj55YW5neWljb25nIDx5YW5n
eWljb25nQGh1YXdlaS5jb20+DQo+U3ViamVjdDogUmU6IFtQQVRDSCB2NiAxLzJdIEFDUEkgLyBB
UEVJOiBBZGQgc3VwcG9ydCB0byBub3RpZnkgdGhlIHZlbmRvcg0KPnNwZWNpZmljIEhXIGVycm9y
cw0KPg0KPk9uIE1vbiwgTWFyIDMwLCAyMDIwIGF0IDEwOjE0OjIwQU0gKzAwMDAsIFNoaWp1IEpv
c2Ugd3JvdGU6DQo+PiBUaGlzIGZpZWxkIGFkZGVkIGJhc2VkIG9uIHRoZSBpbnB1dCBmcm9tIEph
bWVzIE1vcnNlIG9uIHY0IHBhdGNoIHRvDQo+PiBlbmFibGUgdGhlIHVzZXIgc3BhY2UgYXBwbGlj
YXRpb24ocmFzZGFlbW9uKSBkbyB0aGUgZGVjb2RpbmcgYW5kDQo+PiBsb2dnaW5nIG9mIHRoZSBh
bnkgZXh0cmEgZXJyb3IgaW5mb3JtYXRpb24gc2hhcmVkIGJ5IHRoZSBjb3JyZXNwb25kaW5nDQo+
PiBrZXJuZWwgZHJpdmVyIHRvIHRoZSB1c2VyIHNwYWNlLg0KPg0KPkhvdyBpcyB5b3VyIGVycm9y
IHJlcG9ydGluZyBzdXBwb3NlZCB0byB3b3JrPw0KPg0KPllvdXIgZHJpdmVyIGlzIHByaW50aW5n
IGVycm9yIGluZm9ybWF0aW9uIGluIGRtZXNnIGFuZCwgYXQgdGhlIHNhbWUgdGltZSwgeW91DQo+
d2FudCB0byByZXBvcnQgZXJyb3JzIHdpdGggdGhlIHJhc2RhZW1vbi4NCj4NCj5DdXJyZW50bHks
IHRoZSBrZXJuZWwgZG9lcyBub3QgcmVwb3J0IGFueSBlcnJvciBpbmZvIGlmIHRoZXJlJ3MgYSB1
c2VyIGFnZW50IGxpa2UNCj5yYXNkYWVtb24gcmVnaXN0ZXJlZCBzbyB5b3UgbmVlZCB0byB0aGlu
ayBhYm91dCB3aGF0IGV4YWN0bHkgeW91J3JlIHRyeWluZw0KPnRvIGFjaGlldmUgaGVyZSB3cnQg
dG8gZXJyb3IgaGFuZGxpbmcuIFBvcnQgcmVzZXR0aW5nLCBwcmludGluZyBlcnJvciBpbmZvLCBl
dGMuDQo+QWx3YXlzIGFzayB5b3Vyc2VsZiwgd2hhdCBjYW4gdGhlIHVzZXIgZG8gd2l0aCB0aGUg
aW5mb3JtYXRpb24geW91J3JlDQo+cHJpbnRpbmcuIEFuZCBzbyBvbi4uLg0KVGhlIGVycm9yX2hh
bmRsZWQgZmllbGQgYWRkZWQgb24gdGhlIGdlbmVyaWMgYmFzaXMgZm9yIHRoZSBub24tc3RhbmRh
cmQgZXJyb3JzLg0KcmFzZGFlbW9uIHN1cHBvcnRzIGFkZGluZyBkZWNvZGluZyBvZiB0aGUgdmVu
ZG9yLXNwZWNpZmljIGVycm9yIGRhdGEsIHByaW50aW5nIGFuZCANCnN0b3JpbmcgdGhlIGRlY29k
ZWQgdmVuZG9yIGVycm9yIGluZm9ybWF0aW9uIHRvIHRoZSBzcWwgZGF0YWJhc2UuIA0KVGhlIGlk
ZWEgd2FzIHRoZSAgZXJyb3IgaGFuZGxlZCBmaWVsZCAgd2lsbCBoZWxwIHRoZSBkZWNvZGluZyBw
YXJ0IG9mIHRoZSByYXNkYWVtb24gdG8gZG8gdGhlDQphcHByb3ByaWF0ZSBzdGVwcyBmb3IgbG9n
Z2luZyB0aGUgdmVuZG9yIGVycm9yIGluZm9ybWF0aW9uIGRlcGVuZGluZyBvbiB3aGV0aGVyIGEg
Y29ycmVzcG9uZGluZyBrZXJuZWwgZHJpdmVyDQpoYXMgaGFuZGxlZCB0aGUgZXJyb3Igb3Igbm90
LiAgDQpIb3dldmVyIEkgdGhpbmsgdGhlIHNhbWUgY2FuIGJlIGFjaGlldmVkIGJ5IGFkZGluZyBh
biBlcnJvciBoYW5kbGluZyBzdGF0dXMgZmllbGQgdG8gdGhlIHZlbmRvci1zcGVjaWZpYyBkYXRh
LCB3aGljaA0KdGhlIGtlcm5lbCAgZHJpdmVyIHdpbGwgc2V0IGFmdGVyIGhhbmRsaW5nIHRoZSBl
cnJvciBhbmQgY29ycmVzcG9uZGluZyB2ZW5kb3Itc3BlY2lmaWMgY29kZSBpbiB0aGUgcmFzZGFl
bW9uIHdpbGwgdXNlIGl0IA0Kd2hpbGUgbG9nZ2luZyB0aGUgdmVuZG9yIGVycm9yIGRhdGEuDQo+
DQo+PiBDYW4geW91IHBsZWFzZSBjb25maXJtIHlvdSB3YW50IGFsbCB0aGUgZXhpc3Rpbmcgc3Rh
bmRhcmQNCj4+IGVycm9ycyhtZW1vcnksIEFSTSwgUENJRSkgaW4gdGhlIGdoZXNfZG9fcHJvYyAo
KSB0byBiZSByZXBvcnRlZA0KPj4gdGhyb3VnaCB0aGUgYmxvY2tpbmcgbm90aWZpZXI/DQo+DQo+
WWVzLCBJIHdvdWxkIHZlcnkgbXVjaCBwcmVmZXIgdG8gaGF2ZSBhIGdlbmVyaWMgc29sdXRpb24g
aW5zdGVhZCBvZiB2ZW5kb3ItDQo+c3BlY2lmaWMgc3R1ZmYgbGVmdCBhbmQgcmlnaHQuDQpTdXJl
Lg0KDQo+DQo+VGh4Lg0KPg0KPi0tDQo+UmVnYXJkcy9HcnVzcywNCj4gICAgQm9yaXMuDQo+DQo+
aHR0cHM6Ly9wZW9wbGUua2VybmVsLm9yZy90Z2x4L25vdGVzLWFib3V0LW5ldGlxdWV0dGUNCg0K
VGhhbmtzLA0KU2hpanUNCg==
