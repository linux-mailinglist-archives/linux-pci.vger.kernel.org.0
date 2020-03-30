Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2DD8198011
	for <lists+linux-pci@lfdr.de>; Mon, 30 Mar 2020 17:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729605AbgC3Poe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Mar 2020 11:44:34 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2618 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727973AbgC3Poe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Mar 2020 11:44:34 -0400
Received: from lhreml712-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id E142A8F24654BDC4DE4B;
        Mon, 30 Mar 2020 16:44:29 +0100 (IST)
Received: from lhreml715-chm.china.huawei.com (10.201.108.66) by
 lhreml712-chm.china.huawei.com (10.201.108.63) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 30 Mar 2020 16:44:29 +0100
Received: from lhreml715-chm.china.huawei.com ([10.201.108.66]) by
 lhreml715-chm.china.huawei.com ([10.201.108.66]) with mapi id 15.01.1713.004;
 Mon, 30 Mar 2020 16:44:29 +0100
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
Thread-Index: AQHWAsR+4nldebv71E6VKNN8PAfzw6hcw70AgAQRUuCAABIOgIAAEy5wgAAhnICAACCLgA==
Date:   Mon, 30 Mar 2020 15:44:29 +0000
Message-ID: <613133075a174454a88312448b9b333c@huawei.com>
References: <ShijuJose> <20200325164223.650-1-shiju.jose@huawei.com>
 <20200325164223.650-2-shiju.jose@huawei.com> <20200327182214.GD8015@zn.tnic>
 <b180618fb6cb477ea7185979c11c5868@huawei.com>
 <20200330103353.GC16242@zn.tnic>
 <ee79588ee82445dcb76f1fe6c1082fb8@huawei.com>
 <20200330134249.GF16242@zn.tnic>
In-Reply-To: <20200330134249.GF16242@zn.tnic>
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
IFBldGtvdiBbbWFpbHRvOmJwQGFsaWVuOC5kZV0NCj5TZW50OiAzMCBNYXJjaCAyMDIwIDE0OjQz
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
cw0KPg0KPk9uIE1vbiwgTWFyIDMwLCAyMDIwIGF0IDExOjU1OjM1QU0gKzAwMDAsIFNoaWp1IEpv
c2Ugd3JvdGU6DQo+PiBUaGUgaWRlYSB3YXMgdGhlIGVycm9yIGhhbmRsZWQgZmllbGQgd2lsbCBo
ZWxwIHRoZSBkZWNvZGluZyBwYXJ0IG9mDQo+PiB0aGUgcmFzZGFlbW9uIHRvIGRvIHRoZSBhcHBy
b3ByaWF0ZSBzdGVwcyBmb3IgbG9nZ2luZyB0aGUgdmVuZG9yIGVycm9yDQo+PiBpbmZvcm1hdGlv
biBkZXBlbmRpbmcgb24gd2hldGhlciBhIGNvcnJlc3BvbmRpbmcga2VybmVsIGRyaXZlciBoYXMN
Cj4+IGhhbmRsZWQgdGhlIGVycm9yIG9yIG5vdC4NCj4NCj5XaGF0J3MgdGhlIGRpZmZlcmVuY2Ug
Zm9yIHJhc2RhZW1vbiB3aGV0aGVyIHRoZSBlcnJvciBoYXMgYmVlbiBoYW5kbGVkIG9yDQo+bm90
Pw0KRm9sbG93aW5nIGFyZSBzb21lIG9mIHRoZSBleGFtcGxlcyBvZiB0aGUgdXNhZ2Ugb2YgZXJy
b3IgaGFuZGxlZCBzdGF0dXMNCmluIHRoZSB2ZW5kb3Igc3BlY2lmaWMgY29kZSBvZiB0aGUgcmFz
ZGFlbW9uLA0KMS4gcmFzZGFlbW9uIG5lZWQgbm90IHRvIHByaW50IHRoZSB2ZW5kb3IgZXJyb3Ig
ZGF0YSByZXBvcnRlZCBieSB0aGUgZmlybXdhcmUgaWYgdGhlIA0KICAgIGtlcm5lbCBkcml2ZXIg
YWxyZWFkeSBwcmludCB0aG9zZSBpbmZvcm1hdGlvbi4gSW4gdGhpcyBjYXNlIHJhc2RhZW1vbiB3
aWxsIG9ubHkgbmVlZCB0byBzdG9yZQ0KICAgIHRoZSBkZWNvZGVkIHZlbmRvciBlcnJvciBkYXRh
IHRvIHRoZSBTUUwgZGF0YWJhc2UuICANCjIuIElmIHRoZSB2ZW5kb3Iga2VybmVsIGRyaXZlciB3
YW50IHRvIHJlcG9ydCBleHRyYSBlcnJvciBpbmZvcm1hdGlvbiB0aHJvdWdoDQogICAgdGhlIHZl
bmRvciBzcGVjaWZpYyBkYXRhICh0aG91Z2ggcHJlc2VudGx5IHdlIGRvIG5vdCBoYXZlIGFueSBz
dWNoIHVzZSBjYXNlKSBmb3IgdGhlIHJhc2RhbW9uIHRvIGxvZy4gDQogICAgSSB0aGluayB0aGUg
ZXJyb3IgaGFuZGxlZCBzdGF0dXMgdXNlZnVsIHRvIGluZGljYXRlIHRoYXQgdGhlIGtlcm5lbCBk
cml2ZXIgaGFzIGZpbGxlZCB0aGUgZXh0cmEgaW5mb3JtYXRpb24gYW5kDQogICAgcmFzZGFlbW9u
IHRvIGRlY29kZSBhbmQgbG9nIHRoZW0gYWZ0ZXIgZXh0cmEgZGF0YSBzcGVjaWZpYyB2YWxpZGl0
eSBjaGVjay4NCiAgICAgIA0KPg0KPi0tDQo+UmVnYXJkcy9HcnVzcywNCj4gICAgQm9yaXMuDQo+
DQo+aHR0cHM6Ly9wZW9wbGUua2VybmVsLm9yZy90Z2x4L25vdGVzLWFib3V0LW5ldGlxdWV0dGUN
Cg0KVGhhbmtzLA0KU2hpanUNCg==
