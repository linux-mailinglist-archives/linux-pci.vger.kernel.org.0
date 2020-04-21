Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E24851B276E
	for <lists+linux-pci@lfdr.de>; Tue, 21 Apr 2020 15:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728884AbgDUNS1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Apr 2020 09:18:27 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2075 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726018AbgDUNSV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 21 Apr 2020 09:18:21 -0400
Received: from lhreml721-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 03865D7CE7C48204ACB2;
        Tue, 21 Apr 2020 14:18:18 +0100 (IST)
Received: from lhreml715-chm.china.huawei.com (10.201.108.66) by
 lhreml721-chm.china.huawei.com (10.201.108.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 21 Apr 2020 14:18:17 +0100
Received: from lhreml715-chm.china.huawei.com ([10.201.108.66]) by
 lhreml715-chm.china.huawei.com ([10.201.108.66]) with mapi id 15.01.1913.007;
 Tue, 21 Apr 2020 14:18:17 +0100
From:   Shiju Jose <shiju.jose@huawei.com>
To:     James Morse <james.morse@arm.com>, Borislav Petkov <bp@alien8.de>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
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
Thread-Index: AQHWAsR+4nldebv71E6VKNN8PAfzw6hcw70AgBI/yoCAFI/PUA==
Date:   Tue, 21 Apr 2020 13:18:17 +0000
Message-ID: <4d7bfedd175345a198d47e5fa0561ec1@huawei.com>
References: <ShijuJose> <20200325164223.650-1-shiju.jose@huawei.com>
 <20200325164223.650-2-shiju.jose@huawei.com> <20200327182214.GD8015@zn.tnic>
 <c73bb18b-02ef-6c35-f4cf-1738c17a96e5@arm.com>
In-Reply-To: <c73bb18b-02ef-6c35-f4cf-1738c17a96e5@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.83.77]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgSmFtZXMsDQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IGxpbnV4LXBj
aS1vd25lckB2Z2VyLmtlcm5lbC5vcmcgW21haWx0bzpsaW51eC1wY2ktDQo+b3duZXJAdmdlci5r
ZXJuZWwub3JnXSBPbiBCZWhhbGYgT2YgSmFtZXMgTW9yc2UNCj5TZW50OiAwOCBBcHJpbCAyMDIw
IDExOjAzDQo+VG86IEJvcmlzbGF2IFBldGtvdiA8YnBAYWxpZW44LmRlPjsgU2hpanUgSm9zZSA8
c2hpanUuam9zZUBodWF3ZWkuY29tPg0KPkNjOiBsaW51eC1hY3BpQHZnZXIua2VybmVsLm9yZzsg
bGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+a2VybmVsQHZnZXIua2VybmVsLm9y
Zzsgcmp3QHJqd3lzb2NraS5uZXQ7IGhlbGdhYXNAa2VybmVsLm9yZzsNCj5sZW5iQGtlcm5lbC5v
cmc7IHRvbnkubHVja0BpbnRlbC5jb207IGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnOw0KPnpo
YW5nbGlndWFuZ0BsaW51eC5hbGliYWJhLmNvbTsgdGdseEBsaW51dHJvbml4LmRlOyBMaW51eGFy
bQ0KPjxsaW51eGFybUBodWF3ZWkuY29tPjsgSm9uYXRoYW4gQ2FtZXJvbg0KPjxqb25hdGhhbi5j
YW1lcm9uQGh1YXdlaS5jb20+OyB0YW54aWFvZmVpIDx0YW54aWFvZmVpQGh1YXdlaS5jb20+Ow0K
Pnlhbmd5aWNvbmcgPHlhbmd5aWNvbmdAaHVhd2VpLmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENI
IHY2IDEvMl0gQUNQSSAvIEFQRUk6IEFkZCBzdXBwb3J0IHRvIG5vdGlmeSB0aGUgdmVuZG9yDQo+
c3BlY2lmaWMgSFcgZXJyb3JzDQo+DQo+SGkgQm9yaXMsIFNoaWp1LA0KPg0KPlNvcnJ5IGZvciBu
b3Qgc3BvdHRpbmcgdGhpcyByZXBseSBlYXJsaWVyOiBJdHMgaW4tcmVwbHkgdG8gdjEsIHNvIGdl
dHMgYnVyaWVkLg0KSSB3aWxsIHJlc2VuZCB0aGUgdjcgcGF0Y2ggc29sdmluZyB0aGlzIGlzc3Vl
Lg0KSSBndWVzcyB0aGUgcmVtYWluaW5nICBxdWVzdGlvbnMgaGVyZSBhcmUgZm9yIEJvcmlzLiBN
YXkgYmUgY2FuIHdlIGRpc2N1c3MNCnlvdXIgY29tbWVudHMgd2l0aCBWNyBwYXRjaCwgd2hpY2gg
SSB3aWxsIHNlbmQ/DQoNCj4NCj5PbiAyNy8wMy8yMDIwIDE4OjIyLCBCb3Jpc2xhdiBQZXRrb3Yg
d3JvdGU6DQo+PiBPbiBXZWQsIE1hciAyNSwgMjAyMCBhdCAwNDo0MjoyMlBNICswMDAwLCBTaGlq
dSBKb3NlIHdyb3RlOg0KPj4+IFByZXNlbnRseSBBUEVJIGRvZXMgbm90IHN1cHBvcnQgcmVwb3J0
aW5nIHRoZSB2ZW5kb3Igc3BlY2lmaWMgSFcNCj4+PiBlcnJvcnMsIHJlY2VpdmVkIGluIHRoZSB2
ZW5kb3IgZGVmaW5lZCB0YWJsZSBlbnRyaWVzLCB0byB0aGUgdmVuZG9yDQo+Pj4gZHJpdmVycyBm
b3IgYW55IHJlY292ZXJ5Lg0KPj4+DQo+Pj4gVGhpcyBwYXRjaCBhZGRzIHRoZSBzdXBwb3J0IHRv
IHJlZ2lzdGVyIGFuZCB1bnJlZ2lzdGVyIHRoZQ0KPj4NCj4+IEF2b2lkIGhhdmluZyAiVGhpcyBw
YXRjaCIgb3IgIlRoaXMgY29tbWl0IiBpbiB0aGUgY29tbWl0IG1lc3NhZ2UuIEl0DQo+PiBpcyB0
YXV0b2xvZ2ljYWxseSB1c2VsZXNzLg0KPj4NCj4+IEFsc28sIGRvDQo+Pg0KPj4gJCBnaXQgZ3Jl
cCAnVGhpcyBwYXRjaCcgRG9jdW1lbnRhdGlvbi9wcm9jZXNzDQo+Pg0KPj4gZm9yIG1vcmUgZGV0
YWlscy4NCj4+DQo+Pj4gZXJyb3IgaGFuZGxpbmcgZnVuY3Rpb24gZm9yIHRoZSB2ZW5kb3Igc3Bl
Y2lmaWMgSFcgZXJyb3JzIGFuZCBub3RpZnkNCj4+PiB0aGUgcmVnaXN0ZXJlZCBrZXJuZWwgZHJp
dmVyLg0KPg0KPj4+IEBAIC01MjYsMTAgKzU1MiwxNyBAQCBzdGF0aWMgdm9pZCBnaGVzX2RvX3By
b2Moc3RydWN0IGdoZXMgKmdoZXMsDQo+Pj4gIAkJCWxvZ19hcm1faHdfZXJyb3IoZXJyKTsNCj4+
PiAgCQl9IGVsc2Ugew0KPj4+ICAJCQl2b2lkICplcnIgPSBhY3BpX2hlc3RfZ2V0X3BheWxvYWQo
Z2RhdGEpOw0KPj4+ICsJCQl1OCBlcnJvcl9oYW5kbGVkID0gZmFsc2U7DQo+Pj4gKwkJCWludCBy
ZXQ7DQo+Pj4gKw0KPj4+ICsJCQlyZXQgPQ0KPmF0b21pY19ub3RpZmllcl9jYWxsX2NoYWluKCZn
aGVzX2V2ZW50X25vdGlmeV9saXN0LCAwLA0KPj4+ICtnZGF0YSk7DQo+Pg0KPj4gV2VsbCwgdGhp
cyBpcyBhIG5vdGlmaWVyIHdpdGggc3RhbmRhcmQgbmFtZSBmb3IgYSBub24tc3RhbmRhcmQgZXZl
bnQuDQo+PiBOb3Qgb3B0aW1hbC4NCj4+DQo+PiBXaHkgZG9lcyBvbmx5IHRoaXMgZXZlbnQgbmVl
ZCBhIG5vdGlmaWVyPyBCZWNhdXNlIHlvdXIgZHJpdmVyIGlzDQo+PiBpbnRlcmVzdGVkIGluIG9u
bHkgdGhvc2UgZXZlbnRzPw0KPg0KPkl0cyB0aGUgJ2Vsc2UnIGNhdGNoLWFsbCBmb3Igc3R1ZmYg
ZHJpdmVycy9hY3BpL2FwZWkgIGRvZXNuJ3Qga25vdyB0byBoYW5kbGUuDQo+DQo+SW4gdGhpcyBj
YXNlIGl0cyBiZWNhdXNlIGl0cyBhIHZlbmRvciBzcGVjaWZpYyBHVUlEIHRoYXQgb25seSB0aGUg
dmVuZG9yIGRyaXZlcg0KPmtub3dzIGhvdyB0byBwYXJzZS4NCj4NCj4NCj4+PiArCQkJaWYgKHJl
dCAmIE5PVElGWV9PSykNCj4+PiArCQkJCWVycm9yX2hhbmRsZWQgPSB0cnVlOw0KPj4+DQo+Pj4g
IAkJCWxvZ19ub25fc3RhbmRhcmRfZXZlbnQoc2VjX3R5cGUsIGZydV9pZCwgZnJ1X3RleHQsDQo+
Pj4gIAkJCQkJICAgICAgIHNlY19zZXYsIGVyciwNCj4+PiAtCQkJCQkgICAgICAgZ2RhdGEtPmVy
cm9yX2RhdGFfbGVuZ3RoKTsNCj4+PiArCQkJCQkgICAgICAgZ2RhdGEtPmVycm9yX2RhdGFfbGVu
Z3RoLA0KPj4+ICsJCQkJCSAgICAgICBlcnJvcl9oYW5kbGVkKTsNCj4+DQo+PiBXaGF0J3MgdGhh
dCBlcnJvcl9oYW5kbGVkIHRoaW5nIGZvcj8gVGhhdCdzIGp1c3Qgc2lsbHkuDQo+Pg0KPj4gWW91
ciBub3RpZmllciByZXR1cm5zIE5PVElGWV9TVE9QIHdoZW4gaXQgaGFzIHF1ZXVlZCB0aGUgZXJy
b3IuIElmIHlvdQ0KPj4gZG9uJ3Qgd2FudCB0byBsb2cgaXQsIGp1c3QgdGVzdCA9PSBOT1RJRllf
U1RPUCBhbmQgZG8gbm90IGxvZyBpdCB0aGVuLg0KPg0KPk15IHRoaW5raW5nIGZvciB0aGlzIGJl
aW5nIG5lZWRlZCB3YXMgc28gdXNlci1zcGFjZSBjb25zdW1lcnMgb2YgdGhvc2UNCj50cmFjZXBv
aW50cyBrZWVwIHdvcmtpbmcuIE90aGVyd2lzZSB5b3UgdXBncmFkZSwgZ2V0IHRoaXMgZmVhdHVy
ZSwgYW5kIHlvdXINCj51c2VyLXNwYWNlIGNvdW50ZXJzIHN0b3Agd29ya2luZy4NCj4NCj5Zb3Un
ZCBuZWVkIHRvIGtub3cgdGhpcyBlcnJvciBzb3VyY2Ugd2FzIG5vdyBtYW5hZ2VkIGJ5IGFuIGlu
LWtlcm5lbA0KPmRyaXZlciwgd2hpY2ggbWF5IHJlcG9ydCB0aGUgZXJyb3JzIHNvbWV3aGVyZSBl
bHNlLi4uDQo+DQo+DQo+PiBUaGVuIHlvdXIgbm90aWZpZXIgY2FsbGJhY2sgaXMgcXVldWluZyB0
aGUgZXJyb3IgaW50byBhIGtmaWZvIGZvcg0KPj4gd2hhdGV2ZXIgcmVhc29uIGFuZCB0aGVuIHNj
aGVkdWxpbmcgYSB3b3JrcXVldWUgdG8gaGFuZGxlIGl0IGluIHVzZXINCj4+IGNvbnRleHQuLi4N
Cj4+DQo+PiBTbyBJJ20gdGhpbmtpbmcgdGhhdCBpdCB3b3VsZCBiZSBiZXR0ZXIgaWYgeW91Og0K
Pj4NCj4+ICogbWFrZSB0aGF0IGtmaWZvIGdlbmVyaWMgYW5kIHBhcnQgb2YgZ2hlcy5jIGFuZCBx
dWV1ZSBhbGwgdHlwZXMgb2YNCj4+IGVycm9yIHJlY29yZHMgaW50byBpdCBpbiBnaGVzX2RvX3By
b2MoKSAtIG5vdCBqdXN0IHRoZSBub24tc3RhbmRhcmQNCj4+IG9uZXMuDQo+DQo+TW92ZSB0aGUg
ZHJvcCB0byBwcm9jZXNzIGNvbnRleHQgaW50byBnaGVzLmM/IFRoaXMgc2hvdWxkIHJlc3VsdCBp
biBsZXNzIGNvZGUuDQo+DQo+SSBhc2tlZCBmb3IgdGhpcyBob29raW5nIHRvIG9ubHkgYmUgZm9y
IHRoZSAnY2F0Y2ggYWxsJyBkb24ndC1rbm93IGNhc2Ugc28gdGhhdA0KPndlIGRvbid0IGdldCBk
cml2ZXJzIHRyeWluZyB0byBob29rIGFuZCBoYW5kbGUgbWVtb3J5IGVycm9ycy4gKGlmIHdlIGV2
ZXINCj53YW50ZWQgdGhhdCwgaXQgc2hvdWxkIGJlIGZyb20gcGFydCBvZiBtZW1vcnlfZmFpbHVy
ZSgpIHNvIGl0IGNhdGNoZXMgYWxsIHRoZQ0KPndheXMgb2YgcmVwb3J0aW5nIG1lbW9yeS1mYWls
dXJlKSAzMmJpdCBhcm0gaGFzIHByaW9yIGluIHRoaXMgYXJlYS4NCj4NCj4NCj4+ICogdGhlbiwg
d2hlbiB5b3UncmUgZG9uZSBxdWV1aW5nLCB5b3Uga2ljayBhIHdvcmtxdWV1ZS4NCj4+DQo+PiAq
IHRoYXQgd29ya3F1ZXVlIHJ1bnMgYSBub3JtYWwsIGJsb2NraW5nIG5vdGlmaWVyIHRvIHdoaWNo
IGRyaXZlcnMNCj4+IHJlZ2lzdGVyLg0KPj4NCj4+IFlvdXIgZHJpdmVyIGNhbiByZWdpc3RlciB0
byB0aGF0IG5vdGlmaWVyIHRvbyBhbmQgZG8gdGhlIG5vcm1hbA0KPj4gaGFuZGxpbmcgdGhlbiBh
bmQgbm90IGhhdmUgdGhpcyBhZC1ob2MsIHNlbWktZ2VuZXJpYywgc2VtaS12ZW5kb3Itc3BlY2lm
aWMNCj50aGluZy4NCj4NCj5BcyBsb25nIGFzIHdlIGRvbid0IHdhbGsgYSBsaXN0IG9mIHRoaW5n
cyB0aGF0IG1pZ2h0IGhhbmRsZSBhIG1lbW9yeS1lcnJvciwNCj5hbmQgaGF2ZSBzb21lIHJhbmRv
bSBkcml2ZXIgdHJ5IGFuZCBOT1RJRllfU1RPUCBpdC4uLi4NCj4NCj5hZXJfcmVjb3Zlcl9xdWV1
ZSgpIHdvdWxkIGJlIHJlcGxhY2VkIGJ5IHRoaXMuIG1lbW9yeV9mYWlsdXJlX3F1ZXVlKCkgaGFz
DQo+b25lIGFkZGl0aW9uYWwgY2FsbGVyIGluIGRyaXZlcnMvcmFzL2NlYy5jLg0KPg0KPg0KPlRo
YW5rcywNCj4NCj5KYW1lcw0KVGhhbmtzLA0KU2hpanUNCg==
