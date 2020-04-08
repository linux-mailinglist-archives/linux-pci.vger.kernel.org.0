Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8DD1A1DFF
	for <lists+linux-pci@lfdr.de>; Wed,  8 Apr 2020 11:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgDHJUx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Apr 2020 05:20:53 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2639 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726980AbgDHJUx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 8 Apr 2020 05:20:53 -0400
Received: from lhreml720-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id E7677CFDC49A649A2E59;
        Wed,  8 Apr 2020 10:20:51 +0100 (IST)
Received: from lhreml715-chm.china.huawei.com (10.201.108.66) by
 lhreml720-chm.china.huawei.com (10.201.108.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Wed, 8 Apr 2020 10:20:51 +0100
Received: from lhreml715-chm.china.huawei.com ([10.201.108.66]) by
 lhreml715-chm.china.huawei.com ([10.201.108.66]) with mapi id 15.01.1913.007;
 Wed, 8 Apr 2020 10:20:51 +0100
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
Thread-Index: AQHWAsR+4nldebv71E6VKNN8PAfzw6hcw70AgAQRUuCAABIOgIAAEy5wgAAhnICAACCLgIABJWuAgAya7lA=
Date:   Wed, 8 Apr 2020 09:20:51 +0000
Message-ID: <26f99f46a3e045889b96b147207905e6@huawei.com>
References: <ShijuJose> <20200325164223.650-1-shiju.jose@huawei.com>
 <20200325164223.650-2-shiju.jose@huawei.com> <20200327182214.GD8015@zn.tnic>
 <b180618fb6cb477ea7185979c11c5868@huawei.com>
 <20200330103353.GC16242@zn.tnic>
 <ee79588ee82445dcb76f1fe6c1082fb8@huawei.com>
 <20200330134249.GF16242@zn.tnic>
 <613133075a174454a88312448b9b333c@huawei.com>
 <20200331090929.GB29131@zn.tnic>
In-Reply-To: <20200331090929.GB29131@zn.tnic>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.86.201]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgQm9yaXMsDQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEJvcmlzbGF2
IFBldGtvdiBbbWFpbHRvOmJwQGFsaWVuOC5kZV0NCj5TZW50OiAzMSBNYXJjaCAyMDIwIDEwOjA5
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
cw0KPg0KPk9uIE1vbiwgTWFyIDMwLCAyMDIwIGF0IDAzOjQ0OjI5UE0gKzAwMDAsIFNoaWp1IEpv
c2Ugd3JvdGU6DQo+PiAxLiByYXNkYWVtb24gbmVlZCBub3QgdG8gcHJpbnQgdGhlIHZlbmRvciBl
cnJvciBkYXRhIHJlcG9ydGVkIGJ5IHRoZQ0KPmZpcm13YXJlIGlmIHRoZQ0KPj4gICAgIGtlcm5l
bCBkcml2ZXIgYWxyZWFkeSBwcmludCB0aG9zZSBpbmZvcm1hdGlvbi4gSW4gdGhpcyBjYXNlIHJh
c2RhZW1vbiB3aWxsDQo+b25seSBuZWVkIHRvIHN0b3JlDQo+PiAgICAgdGhlIGRlY29kZWQgdmVu
ZG9yIGVycm9yIGRhdGEgdG8gdGhlIFNRTCBkYXRhYmFzZS4NCj4NCj5XZWxsLCB0aGVyZSdzIGEg
cHJvYmxlbSB3aXRoIHRoaXM6DQo+DQo+cmFzZGFlbW9uIHByaW50aW5nICE9IGtlcm5lbCBkcml2
ZXIgcHJpbnRpbmcNCj4NCj5CZWNhdXNlIHByaW50aW5nIGluIGRtZXNnIHdvdWxkIG5lZWQgcGVv
cGxlIHRvIGdvIGdyZXAgZG1lc2cuDQo+DQo+UHJpbnRpbmcgdGhyb3VnaCByYXNkYWVtb24gb3Ig
YW55IHVzZXJzcGFjZSBhZ2VudCwgT1RPSCwgaXMgYSBsb3QgbW9yZQ0KPmZsZXhpYmxlIHdydCBh
bmFseXppbmcgYW5kIGNvbGxlY3RpbmcgdGhvc2UgZXJyb3IgcmVjb3Jkcy4gRXNwZWNpYWxseSBp
ZiB5b3UgYXJlIGENCj5kYXRhIGNlbnRlciBhZG1pbiBhbmQgeW91IHdhbnQgdG8gY29sbGVjdCBh
bGwgeW91ciBlcnJvcg0KPnJlY29yZHM6IGdyZXBwaW5nIGRtZXNnIHNpbXBseSBkb2Vzbid0IHNj
YWxlIHZlcnN1cyBhbGwgdGhlIHJhc2RhZW1vbg0KPmFnZW50cyByZXBvcnRpbmcgdG8gYSBjZW50
cmFsbGl6ZWQgbG9jYXRpb24uDQpPay4NCkkgcG9zdGVkIFY3IG9mIHRoaXMgc2VyaWVzLiAgDQoi
W3Y3IFBBVENIIDAvNl0gQUNQSSAvIEFQRUk6IEFkZCBzdXBwb3J0IHRvIG5vdGlmeSBub24tZmF0
YWwgSFcgZXJyb3JzIg0KDQo+DQo+PiAyLiBJZiB0aGUgdmVuZG9yIGtlcm5lbCBkcml2ZXIgd2Fu
dCB0byByZXBvcnQgZXh0cmEgZXJyb3IgaW5mb3JtYXRpb24NCj50aHJvdWdoDQo+PiAgICAgdGhl
IHZlbmRvciBzcGVjaWZpYyBkYXRhICh0aG91Z2ggcHJlc2VudGx5IHdlIGRvIG5vdCBoYXZlIGFu
eSBzdWNoIHVzZQ0KPmNhc2UpIGZvciB0aGUgcmFzZGFtb24gdG8gbG9nLg0KPj4gICAgIEkgdGhp
bmsgdGhlIGVycm9yIGhhbmRsZWQgc3RhdHVzIHVzZWZ1bCB0byBpbmRpY2F0ZSB0aGF0IHRoZSBr
ZXJuZWwgZHJpdmVyDQo+aGFzIGZpbGxlZCB0aGUgZXh0cmEgaW5mb3JtYXRpb24gYW5kDQo+PiAg
ICAgcmFzZGFlbW9uIHRvIGRlY29kZSBhbmQgbG9nIHRoZW0gYWZ0ZXIgZXh0cmEgZGF0YSBzcGVj
aWZpYyB2YWxpZGl0eQ0KPmNoZWNrLg0KPg0KPlRoZSBrZXJuZWwgZHJpdmVyIGNhbiByZXBvcnQg
dGhhdCBleHRyYSBpbmZvcm1hdGlvbiB3aXRob3V0IHRoZSBrZXJuZWwgc2F5aW5nDQo+dGhhdCB0
aGUgZXJyb3Igd2FzIGhhbmRsZWQuDQo+DQo+U28gSSBzdGlsbCBzZWUgbm8gc2Vuc2UgZm9yIHRo
ZSBrZXJuZWwgdG8gdGVsbCB1c2Vyc3BhY2UgZXhwbGljaXRseSB0aGF0IGl0IGhhbmRsZWQNCj50
aGUgZXJyb3IuIFRoZXJlIG1pZ2h0IGJlIGEgdmFsaWQgcmVhc29uLCB0aG91Z2gsIG9mIHdoaWNo
IEkgY2Fubm90IHRoaW5rIG9mDQo+cmlnaHQgbm93Lg0KT2suDQoNCj4NCj5UaHguDQo+DQo+LS0N
Cj5SZWdhcmRzL0dydXNzLA0KPiAgICBCb3Jpcy4NCj4NCj5odHRwczovL3Blb3BsZS5rZXJuZWwu
b3JnL3RnbHgvbm90ZXMtYWJvdXQtbmV0aXF1ZXR0ZQ0KDQpUaGFua3MsDQpTaGlqdQ0K
