Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0C931CD7BC
	for <lists+linux-pci@lfdr.de>; Mon, 11 May 2020 13:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729642AbgEKLUz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 May 2020 07:20:55 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2183 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729651AbgEKLUx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 May 2020 07:20:53 -0400
Received: from lhreml719-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 7CDFC8E0A97ECCF7093;
        Mon, 11 May 2020 12:20:51 +0100 (IST)
Received: from lhreml715-chm.china.huawei.com (10.201.108.66) by
 lhreml719-chm.china.huawei.com (10.201.108.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Mon, 11 May 2020 12:20:51 +0100
Received: from lhreml715-chm.china.huawei.com ([10.201.108.66]) by
 lhreml715-chm.china.huawei.com ([10.201.108.66]) with mapi id 15.01.1913.007;
 Mon, 11 May 2020 12:20:51 +0100
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
Thread-Index: AQHWAsR+4nldebv71E6VKNN8PAfzw6hcw70AgBI/yoCAM/mpcA==
Date:   Mon, 11 May 2020 11:20:50 +0000
Message-ID: <26acef2760e843ea92edeba199812d73@huawei.com>
References: <ShijuJose> <20200325164223.650-1-shiju.jose@huawei.com>
 <20200325164223.650-2-shiju.jose@huawei.com> <20200327182214.GD8015@zn.tnic>
 <c73bb18b-02ef-6c35-f4cf-1738c17a96e5@arm.com>
In-Reply-To: <c73bb18b-02ef-6c35-f4cf-1738c17a96e5@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.83.192]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgQm9yaXMsIEhpIEphbWVzLA0KDQo+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj5Gcm9t
OiBsaW51eC1wY2ktb3duZXJAdmdlci5rZXJuZWwub3JnIFttYWlsdG86bGludXgtcGNpLQ0KPm93
bmVyQHZnZXIua2VybmVsLm9yZ10gT24gQmVoYWxmIE9mIEphbWVzIE1vcnNlDQo+U2VudDogMDgg
QXByaWwgMjAyMCAxMTowMw0KPlRvOiBCb3Jpc2xhdiBQZXRrb3YgPGJwQGFsaWVuOC5kZT47IFNo
aWp1IEpvc2UgPHNoaWp1Lmpvc2VAaHVhd2VpLmNvbT4NCj5DYzogbGludXgtYWNwaUB2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPmtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmc7IHJqd0Byand5c29ja2kubmV0OyBoZWxnYWFzQGtlcm5lbC5vcmc7DQo+bGVu
YkBrZXJuZWwub3JnOyB0b255Lmx1Y2tAaW50ZWwuY29tOyBncmVna2hAbGludXhmb3VuZGF0aW9u
Lm9yZzsNCj56aGFuZ2xpZ3VhbmdAbGludXguYWxpYmFiYS5jb207IHRnbHhAbGludXRyb25peC5k
ZTsgTGludXhhcm0NCj48bGludXhhcm1AaHVhd2VpLmNvbT47IEpvbmF0aGFuIENhbWVyb24NCj48
am9uYXRoYW4uY2FtZXJvbkBodWF3ZWkuY29tPjsgdGFueGlhb2ZlaSA8dGFueGlhb2ZlaUBodWF3
ZWkuY29tPjsNCj55YW5neWljb25nIDx5YW5neWljb25nQGh1YXdlaS5jb20+DQo+U3ViamVjdDog
UmU6IFtQQVRDSCB2NiAxLzJdIEFDUEkgLyBBUEVJOiBBZGQgc3VwcG9ydCB0byBub3RpZnkgdGhl
IHZlbmRvcg0KPnNwZWNpZmljIEhXIGVycm9ycw0KPg0KPkhpIEJvcmlzLCBTaGlqdSwNCj4NCj5T
b3JyeSBmb3Igbm90IHNwb3R0aW5nIHRoaXMgcmVwbHkgZWFybGllcjogSXRzIGluLXJlcGx5IHRv
IHYxLCBzbyBnZXRzIGJ1cmllZC4NCj4NCj5PbiAyNy8wMy8yMDIwIDE4OjIyLCBCb3Jpc2xhdiBQ
ZXRrb3Ygd3JvdGU6DQo+PiBPbiBXZWQsIE1hciAyNSwgMjAyMCBhdCAwNDo0MjoyMlBNICswMDAw
LCBTaGlqdSBKb3NlIHdyb3RlOg0KPj4+IFByZXNlbnRseSBBUEVJIGRvZXMgbm90IHN1cHBvcnQg
cmVwb3J0aW5nIHRoZSB2ZW5kb3Igc3BlY2lmaWMgSFcNCj4+PiBlcnJvcnMsIHJlY2VpdmVkIGlu
IHRoZSB2ZW5kb3IgZGVmaW5lZCB0YWJsZSBlbnRyaWVzLCB0byB0aGUgdmVuZG9yDQo+Pj4gZHJp
dmVycyBmb3IgYW55IHJlY292ZXJ5Lg0KPj4+DQo+Pj4gVGhpcyBwYXRjaCBhZGRzIHRoZSBzdXBw
b3J0IHRvIHJlZ2lzdGVyIGFuZCB1bnJlZ2lzdGVyIHRoZQ0KPj4NCj4+IEF2b2lkIGhhdmluZyAi
VGhpcyBwYXRjaCIgb3IgIlRoaXMgY29tbWl0IiBpbiB0aGUgY29tbWl0IG1lc3NhZ2UuIEl0DQo+
PiBpcyB0YXV0b2xvZ2ljYWxseSB1c2VsZXNzLg0KPj4NCj4+IEFsc28sIGRvDQo+Pg0KPj4gJCBn
aXQgZ3JlcCAnVGhpcyBwYXRjaCcgRG9jdW1lbnRhdGlvbi9wcm9jZXNzDQo+Pg0KPj4gZm9yIG1v
cmUgZGV0YWlscy4NCj4+DQo+Pj4gZXJyb3IgaGFuZGxpbmcgZnVuY3Rpb24gZm9yIHRoZSB2ZW5k
b3Igc3BlY2lmaWMgSFcgZXJyb3JzIGFuZCBub3RpZnkNCj4+PiB0aGUgcmVnaXN0ZXJlZCBrZXJu
ZWwgZHJpdmVyLg0KPg0KPj4+IEBAIC01MjYsMTAgKzU1MiwxNyBAQCBzdGF0aWMgdm9pZCBnaGVz
X2RvX3Byb2Moc3RydWN0IGdoZXMgKmdoZXMsDQo+Pj4gIAkJCWxvZ19hcm1faHdfZXJyb3IoZXJy
KTsNCj4+PiAgCQl9IGVsc2Ugew0KPj4+ICAJCQl2b2lkICplcnIgPSBhY3BpX2hlc3RfZ2V0X3Bh
eWxvYWQoZ2RhdGEpOw0KPj4+ICsJCQl1OCBlcnJvcl9oYW5kbGVkID0gZmFsc2U7DQo+Pj4gKwkJ
CWludCByZXQ7DQo+Pj4gKw0KPj4+ICsJCQlyZXQgPQ0KPmF0b21pY19ub3RpZmllcl9jYWxsX2No
YWluKCZnaGVzX2V2ZW50X25vdGlmeV9saXN0LCAwLA0KPj4+ICtnZGF0YSk7DQo+Pg0KPj4gV2Vs
bCwgdGhpcyBpcyBhIG5vdGlmaWVyIHdpdGggc3RhbmRhcmQgbmFtZSBmb3IgYSBub24tc3RhbmRh
cmQgZXZlbnQuDQo+PiBOb3Qgb3B0aW1hbC4NCj4+DQo+PiBXaHkgZG9lcyBvbmx5IHRoaXMgZXZl
bnQgbmVlZCBhIG5vdGlmaWVyPyBCZWNhdXNlIHlvdXIgZHJpdmVyIGlzDQo+PiBpbnRlcmVzdGVk
IGluIG9ubHkgdGhvc2UgZXZlbnRzPw0KPg0KPkl0cyB0aGUgJ2Vsc2UnIGNhdGNoLWFsbCBmb3Ig
c3R1ZmYgZHJpdmVycy9hY3BpL2FwZWkgIGRvZXNuJ3Qga25vdyB0byBoYW5kbGUuDQo+DQo+SW4g
dGhpcyBjYXNlIGl0cyBiZWNhdXNlIGl0cyBhIHZlbmRvciBzcGVjaWZpYyBHVUlEIHRoYXQgb25s
eSB0aGUgdmVuZG9yIGRyaXZlcg0KPmtub3dzIGhvdyB0byBwYXJzZS4NCj4NCj4NCj4+PiArCQkJ
aWYgKHJldCAmIE5PVElGWV9PSykNCj4+PiArCQkJCWVycm9yX2hhbmRsZWQgPSB0cnVlOw0KPj4+
DQo+Pj4gIAkJCWxvZ19ub25fc3RhbmRhcmRfZXZlbnQoc2VjX3R5cGUsIGZydV9pZCwgZnJ1X3Rl
eHQsDQo+Pj4gIAkJCQkJICAgICAgIHNlY19zZXYsIGVyciwNCj4+PiAtCQkJCQkgICAgICAgZ2Rh
dGEtPmVycm9yX2RhdGFfbGVuZ3RoKTsNCj4+PiArCQkJCQkgICAgICAgZ2RhdGEtPmVycm9yX2Rh
dGFfbGVuZ3RoLA0KPj4+ICsJCQkJCSAgICAgICBlcnJvcl9oYW5kbGVkKTsNCj4+DQo+PiBXaGF0
J3MgdGhhdCBlcnJvcl9oYW5kbGVkIHRoaW5nIGZvcj8gVGhhdCdzIGp1c3Qgc2lsbHkuDQo+Pg0K
Pj4gWW91ciBub3RpZmllciByZXR1cm5zIE5PVElGWV9TVE9QIHdoZW4gaXQgaGFzIHF1ZXVlZCB0
aGUgZXJyb3IuIElmIHlvdQ0KPj4gZG9uJ3Qgd2FudCB0byBsb2cgaXQsIGp1c3QgdGVzdCA9PSBO
T1RJRllfU1RPUCBhbmQgZG8gbm90IGxvZyBpdCB0aGVuLg0KPg0KPk15IHRoaW5raW5nIGZvciB0
aGlzIGJlaW5nIG5lZWRlZCB3YXMgc28gdXNlci1zcGFjZSBjb25zdW1lcnMgb2YgdGhvc2UNCj50
cmFjZXBvaW50cyBrZWVwIHdvcmtpbmcuIE90aGVyd2lzZSB5b3UgdXBncmFkZSwgZ2V0IHRoaXMg
ZmVhdHVyZSwgYW5kIHlvdXINCj51c2VyLXNwYWNlIGNvdW50ZXJzIHN0b3Agd29ya2luZy4NCj4N
Cj5Zb3UnZCBuZWVkIHRvIGtub3cgdGhpcyBlcnJvciBzb3VyY2Ugd2FzIG5vdyBtYW5hZ2VkIGJ5
IGFuIGluLWtlcm5lbA0KPmRyaXZlciwgd2hpY2ggbWF5IHJlcG9ydCB0aGUgZXJyb3JzIHNvbWV3
aGVyZSBlbHNlLi4uDQo+DQo+DQo+PiBUaGVuIHlvdXIgbm90aWZpZXIgY2FsbGJhY2sgaXMgcXVl
dWluZyB0aGUgZXJyb3IgaW50byBhIGtmaWZvIGZvcg0KPj4gd2hhdGV2ZXIgcmVhc29uIGFuZCB0
aGVuIHNjaGVkdWxpbmcgYSB3b3JrcXVldWUgdG8gaGFuZGxlIGl0IGluIHVzZXINCj4+IGNvbnRl
eHQuLi4NCj4+DQo+PiBTbyBJJ20gdGhpbmtpbmcgdGhhdCBpdCB3b3VsZCBiZSBiZXR0ZXIgaWYg
eW91Og0KPj4NCj4+ICogbWFrZSB0aGF0IGtmaWZvIGdlbmVyaWMgYW5kIHBhcnQgb2YgZ2hlcy5j
IGFuZCBxdWV1ZSBhbGwgdHlwZXMgb2YNCj4+IGVycm9yIHJlY29yZHMgaW50byBpdCBpbiBnaGVz
X2RvX3Byb2MoKSAtIG5vdCBqdXN0IHRoZSBub24tc3RhbmRhcmQNCj4+IG9uZXMuDQo+DQo+TW92
ZSB0aGUgZHJvcCB0byBwcm9jZXNzIGNvbnRleHQgaW50byBnaGVzLmM/IFRoaXMgc2hvdWxkIHJl
c3VsdCBpbiBsZXNzIGNvZGUuDQo+DQo+SSBhc2tlZCBmb3IgdGhpcyBob29raW5nIHRvIG9ubHkg
YmUgZm9yIHRoZSAnY2F0Y2ggYWxsJyBkb24ndC1rbm93IGNhc2Ugc28gdGhhdA0KPndlIGRvbid0
IGdldCBkcml2ZXJzIHRyeWluZyB0byBob29rIGFuZCBoYW5kbGUgbWVtb3J5IGVycm9ycy4gKGlm
IHdlIGV2ZXINCj53YW50ZWQgdGhhdCwgaXQgc2hvdWxkIGJlIGZyb20gcGFydCBvZiBtZW1vcnlf
ZmFpbHVyZSgpIHNvIGl0IGNhdGNoZXMgYWxsIHRoZQ0KPndheXMgb2YgcmVwb3J0aW5nIG1lbW9y
eS1mYWlsdXJlKSAzMmJpdCBhcm0gaGFzIHByaW9yIGluIHRoaXMgYXJlYS4NCj4NCj4NCj4+ICog
dGhlbiwgd2hlbiB5b3UncmUgZG9uZSBxdWV1aW5nLCB5b3Uga2ljayBhIHdvcmtxdWV1ZS4NCj4+
DQo+PiAqIHRoYXQgd29ya3F1ZXVlIHJ1bnMgYSBub3JtYWwsIGJsb2NraW5nIG5vdGlmaWVyIHRv
IHdoaWNoIGRyaXZlcnMNCj4+IHJlZ2lzdGVyLg0KPj4NCj4+IFlvdXIgZHJpdmVyIGNhbiByZWdp
c3RlciB0byB0aGF0IG5vdGlmaWVyIHRvbyBhbmQgZG8gdGhlIG5vcm1hbA0KPj4gaGFuZGxpbmcg
dGhlbiBhbmQgbm90IGhhdmUgdGhpcyBhZC1ob2MsIHNlbWktZ2VuZXJpYywgc2VtaS12ZW5kb3It
c3BlY2lmaWMNCj50aGluZy4NCj4NCj5BcyBsb25nIGFzIHdlIGRvbid0IHdhbGsgYSBsaXN0IG9m
IHRoaW5ncyB0aGF0IG1pZ2h0IGhhbmRsZSBhIG1lbW9yeS1lcnJvciwNCj5hbmQgaGF2ZSBzb21l
IHJhbmRvbSBkcml2ZXIgdHJ5IGFuZCBOT1RJRllfU1RPUCBpdC4uLi4NCj4NCj5hZXJfcmVjb3Zl
cl9xdWV1ZSgpIHdvdWxkIGJlIHJlcGxhY2VkIGJ5IHRoaXMuIG1lbW9yeV9mYWlsdXJlX3F1ZXVl
KCkgaGFzDQo+b25lIGFkZGl0aW9uYWwgY2FsbGVyIGluIGRyaXZlcnMvcmFzL2NlYy5jLg0KDQpD
YW4geW91IHN1Z2dlc3Qgd2hldGhlciB0aGUgc3RhbmRhcmQgZXJyb3JzIGNhbiByZXBvcnQgdGhy
b3VnaCB0aGUgDQpub3RpZmllciAoa2ZpZm8gKyBibG9ja2luZyBub3RpZmllciksIFt3aGljaCBp
bXBsZW1lbnRlZCAgaW4gVjcgcGF0Y2hdLCBvciBub3QgDQpzbyB0aGF0IHdlIGNhbiBwcm9jZWVk
IHdpdGggdGhlIGNoYW5nZXMgdG8gbm90aWZ5IHRoZSB2ZW5kb3Igc3BlY2lmaWMgZXJyb3JzPw0K
DQo+DQo+DQo+VGhhbmtzLA0KPg0KPkphbWVzDQoNClRoYW5rcywNClNoaWp1DQo=
