Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02359182FFB
	for <lists+linux-pci@lfdr.de>; Thu, 12 Mar 2020 13:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbgCLMK2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Mar 2020 08:10:28 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2554 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725268AbgCLMK2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 12 Mar 2020 08:10:28 -0400
Received: from lhreml705-cah.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id A1C5738194AA22480A3B;
        Thu, 12 Mar 2020 12:10:25 +0000 (GMT)
Received: from lhreml717-chm.china.huawei.com (10.201.108.68) by
 lhreml705-cah.china.huawei.com (10.201.108.46) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 12 Mar 2020 12:10:25 +0000
Received: from lhreml715-chm.china.huawei.com (10.201.108.66) by
 lhreml717-chm.china.huawei.com (10.201.108.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 12 Mar 2020 12:10:25 +0000
Received: from lhreml715-chm.china.huawei.com ([10.201.108.66]) by
 lhreml715-chm.china.huawei.com ([10.201.108.66]) with mapi id 15.01.1713.004;
 Thu, 12 Mar 2020 12:10:25 +0000
From:   Shiju Jose <shiju.jose@huawei.com>
To:     James Morse <james.morse@arm.com>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "zhangliguang@linux.alibaba.com" <zhangliguang@linux.alibaba.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        Linuxarm <linuxarm@huawei.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        tanxiaofei <tanxiaofei@huawei.com>,
        yangyicong <yangyicong@huawei.com>
Subject: RE: [PATCH v4 1/2] ACPI: APEI: Add support to notify the vendor
 specific HW errors
Thread-Topic: [PATCH v4 1/2] ACPI: APEI: Add support to notify the vendor
 specific HW errors
Thread-Index: AQHV3aHpvUUiw2j43UuF7uWUQ9pa06hD2fwAgAADqhA=
Date:   Thu, 12 Mar 2020 12:10:24 +0000
Message-ID: <689f0c7cb0fe49d6a9df140cc1b56690@huawei.com>
References: <Shiju Jose> <20200207103143.20104-1-shiju.jose@huawei.com>
 <20200207103143.20104-2-shiju.jose@huawei.com>
 <4967c0e6-b264-a13a-28c7-5ca497442823@arm.com>
In-Reply-To: <4967c0e6-b264-a13a-28c7-5ca497442823@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.88.146]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgSmFtZXMsDQoNClRoYW5rcyBmb3IgcmV2aWV3aW5nIHRoZSBjb2RlLg0KDQo+LS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj5Gcm9tOiBsaW51eC1wY2ktb3duZXJAdmdlci5rZXJuZWwub3Jn
IFttYWlsdG86bGludXgtcGNpLQ0KPm93bmVyQHZnZXIua2VybmVsLm9yZ10gT24gQmVoYWxmIE9m
IEphbWVzIE1vcnNlDQo+U2VudDogMTEgTWFyY2ggMjAyMCAxNzozMA0KPlRvOiBTaGlqdSBKb3Nl
IDxzaGlqdS5qb3NlQGh1YXdlaS5jb20+DQo+Q2M6IGxpbnV4LWFjcGlAdmdlci5rZXJuZWwub3Jn
OyBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj5rZXJuZWxAdmdlci5rZXJuZWwu
b3JnOyByandAcmp3eXNvY2tpLm5ldDsgaGVsZ2Fhc0BrZXJuZWwub3JnOw0KPmxlbmJAa2VybmVs
Lm9yZzsgYnBAYWxpZW44LmRlOyB0b255Lmx1Y2tAaW50ZWwuY29tOw0KPmdyZWdraEBsaW51eGZv
dW5kYXRpb24ub3JnOyB6aGFuZ2xpZ3VhbmdAbGludXguYWxpYmFiYS5jb207DQo+dGdseEBsaW51
dHJvbml4LmRlOyBMaW51eGFybSA8bGludXhhcm1AaHVhd2VpLmNvbT47IEpvbmF0aGFuIENhbWVy
b24NCj48am9uYXRoYW4uY2FtZXJvbkBodWF3ZWkuY29tPjsgdGFueGlhb2ZlaSA8dGFueGlhb2Zl
aUBodWF3ZWkuY29tPjsNCj55YW5neWljb25nIDx5YW5neWljb25nQGh1YXdlaS5jb20+DQo+U3Vi
amVjdDogUmU6IFtQQVRDSCB2NCAxLzJdIEFDUEk6IEFQRUk6IEFkZCBzdXBwb3J0IHRvIG5vdGlm
eSB0aGUgdmVuZG9yDQo+c3BlY2lmaWMgSFcgZXJyb3JzDQo+DQo+SGkgU2hpanUsDQo+DQo+T24g
MDcvMDIvMjAyMCAxMDozMSwgU2hpanUgSm9zZSB3cm90ZToNCj4+IFByZXNlbnRseSBBUEVJIGRv
ZXMgbm90IHN1cHBvcnQgcmVwb3J0aW5nIHRoZSB2ZW5kb3Igc3BlY2lmaWMgSFcNCj4+IGVycm9y
cywgcmVjZWl2ZWQgaW4gdGhlIHZlbmRvciBkZWZpbmVkIHRhYmxlIGVudHJpZXMsIHRvIHRoZSB2
ZW5kb3INCj4+IGRyaXZlcnMgZm9yIGFueSByZWNvdmVyeS4NCj4+DQo+PiBUaGlzIHBhdGNoIGFk
ZHMgdGhlIHN1cHBvcnQgdG8gcmVnaXN0ZXIgYW5kIHVucmVnaXN0ZXIgdGhlIGVycm9yDQo+PiBo
YW5kbGluZyBmdW5jdGlvbiBmb3IgdGhlIHZlbmRvciBzcGVjaWZpYyBIVyBlcnJvcnMgYW5kIG5v
dGlmeSB0aGUNCj4+IHJlZ2lzdGVyZWQga2VybmVsIGRyaXZlci4NCj4NCj5JcyBpdCBwb3NzaWJs
ZSB0byB1c2UgdGhlIGtlcm5lbCdzIGV4aXN0aW5nIGF0b21pY19ub3RpZmllcl9jaGFpbl9yZWdp
c3RlcigpIEFQSSBmb3INCj50aGlzPw0KPg0KPlRoZSBvbmUgdGhpbmcgdGhhdCBjYW4ndCBiZSBk
b25lIGluIHRoZSBzYW1lIHdheSBpcyB0aGUgR1VJRCBmaWx0ZXJpbmcgaW4gZ2hlcy5jLg0KPkVh
Y2ggZHJpdmVyIHdvdWxkIG5lZWQgdG8gY2hlY2sgaWYgdGhlIGNhbGwgbWF0Y2hlZCBhIEdVSUQg
dGhleSBrbmV3IGFib3V0LA0KPmFuZCByZXR1cm4gTk9USUZZX0RPTkUgaWYgdGhleSAiZG9uJ3Qg
Y2FyZSIuDQo+DQo+SSB0aGluayB0aGlzIHBhdGNoIHdvdWxkIGJlIGEgbG90IHNtYWxsZXIgaWYg
aXQgd2FzIHR3ZWFrZWQgdG8gYmUgYWJsZSB0byB1c2UgdGhlDQo+ZXhpc3RpbmcgQVBJLiBJZiB0
aGVyZSBpcyBhIHJlYXNvbiBub3QgdG8gdXNlIGl0LCBpdCB3b3VsZCBiZSBnb29kIHRvIGtub3cg
d2hhdCBpdA0KPmlzLg0KSSB0aGluayB3aGVuIHVzaW5nIGF0b21pY19ub3RpZmllcl9jaGFpbl9y
ZWdpc3RlciB3ZSBoYXZlIGZvbGxvd2luZyBsaW1pdGF0aW9ucywNCjEuIEFsbCB0aGUgcmVnaXN0
ZXJlZCBlcnJvciBoYW5kbGVycyB3b3VsZCBnZXQgY2FsbGVkLCB0aG91Z2ggYW4gZXJyb3IgaXMg
bm90IHJlbGF0ZWQgdG8gdGhvc2UgaGFuZGxlcnMuICAgIA0KICAgIEFsc28gdGhpcyBtYXkgbGVh
ZCB0byBtaXNoYW5kbGluZyBvZiB0aGUgZXJyb3IgaW5mb3JtYXRpb24gaWYgYSBoYW5kbGVyIGRv
ZXMgbm90DQogICAgaW1wbGVtZW50IEdVSUQgY2hlY2tpbmcgZXRjLg0KMi4gYXRvbWljX25vdGlm
aWVyX2NoYWluX3JlZ2lzdGVyIChub3RpZmllcl9jaGFpbl9yZWdpc3RlcikgbG9va3MgbGlrZSBk
b2VzIG5vdCBzdXBwb3J0IA0KICAgIHBhc3MgdGhlIGhhbmRsZXIncyBwcml2YXRlIGRhdGEgZHVy
aW5nIHRoZSByZWdpc3RyYXRpb24gd2hpY2ggc3VwcG9zZWQgdG8gDQogICAgcGFzc2VkIGxhdGVy
IGluIHRoZSBjYWxsIGJhY2sgZnVuY3Rpb24gKm5vdGlmaWVyX2ZuX3QoLi4uICx2b2lkICpkYXRh
KSB0byB0aGUgaGFuZGxlci4NCjMuIEFsc28gZ290IGRpZmZpY3VsdHkgaW4gcGFzc2luZyB0aGUg
Z2hlcyBlcnJvciBkYXRhKGFjcGlfaGVzdF9nZW5lcmljX2RhdGEpLCBHVUlEDQogICAgZm9yIHRo
ZSBlcnJvciByZWNlaXZlZCB0byB0aGUgaGFuZGxlciB0aHJvdWdoIHRoZSBub3RpZmllcl9jaGFp
biAgY2FsbGJhY2sgaW50ZXJmYWNlLiANCiAgICANClNvcnJ5IGlmIEkgZGlkIG5vdCAgdW5kZXJz
dG9vZCB5b3VyIHN1Z2dlc3Rpb24gY29ycmVjdGx5Lg0KIA0KPg0KPg0KPj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvYWNwaS9hcGVpL2doZXMuYyBiL2RyaXZlcnMvYWNwaS9hcGVpL2doZXMuYyBpbmRl
eA0KPj4gMTAzYWNiYi4uNjllMThkNyAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvYWNwaS9hcGVp
L2doZXMuYw0KPj4gKysrIGIvZHJpdmVycy9hY3BpL2FwZWkvZ2hlcy5jDQo+PiBAQCAtNDkwLDYg
KzQ5MCwxMDkgQEAgc3RhdGljIHZvaWQgZ2hlc19oYW5kbGVfYWVyKHN0cnVjdA0KPj4gYWNwaV9o
ZXN0X2dlbmVyaWNfZGF0YSAqZ2RhdGEpDQo+DQo+PiArLyoqDQo+PiArICogZ2hlc191bnJlZ2lz
dGVyX2V2ZW50X2hhbmRsZXIgLSB1bnJlZ2lzdGVyIHRoZSBwcmV2aW91c2x5DQo+PiArICogcmVn
aXN0ZXJlZCBldmVudCBoYW5kbGluZyBmdW5jdGlvbi4NCj4+ICsgKiBAc2VjX3R5cGU6IHNlY190
eXBlIG9mIHRoZSBjb3JyZXNwb25kaW5nIENQRVIuDQo+PiArICogQGRhdGE6IGRyaXZlciBzcGVj
aWZpYyBkYXRhIHRvIGRpc3Rpbmd1aXNoIGRldmljZXMuDQo+PiArICovDQo+PiArdm9pZCBnaGVz
X3VucmVnaXN0ZXJfZXZlbnRfaGFuZGxlcihndWlkX3Qgc2VjX3R5cGUsIHZvaWQgKmRhdGEpIHsN
Cj4+ICsJc3RydWN0IGdoZXNfZXZlbnRfbm90aWZ5ICpldmVudF9ub3RpZnk7DQo+PiArCWJvb2wg
Zm91bmQgPSBmYWxzZTsNCj4+ICsNCj4+ICsJbXV0ZXhfbG9jaygmZ2hlc19ldmVudF9ub3RpZnlf
bXV0ZXgpOw0KPj4gKwlyY3VfcmVhZF9sb2NrKCk7DQo+PiArCWxpc3RfZm9yX2VhY2hfZW50cnlf
cmN1KGV2ZW50X25vdGlmeSwNCj4+ICsJCQkJJmdoZXNfZXZlbnRfaGFuZGxlcl9saXN0LCBsaXN0
KSB7DQo+PiArCQlpZiAoZ3VpZF9lcXVhbCgmZXZlbnRfbm90aWZ5LT5zZWNfdHlwZSwgJnNlY190
eXBlKSkgew0KPg0KPj4gKwkJCWlmIChkYXRhICE9IGV2ZW50X25vdGlmeS0+ZGF0YSkNCj4NCj5J
dCBsb29rcyBsaWtlIHlvdSBuZWVkIG11bHRpcGxlIGRyaXZlcnMgdG8gaGFuZGxlIHRoZSBzYW1l
IEdVSUQgYmVjYXVzZSBvZg0KPm11bHRpcGxlIHJvb3QgcG9ydHMuIENhbid0IHRoZSBoYW5kbGVy
IGxvb2t1cCB0aGUgcmlnaHQgZGV2aWNlPw0KVGhpcyBjaGVjayB3YXMgYmVjYXVzZSBHVUlEIGlz
IHNoYXJlZCBhbW9uZyBtdWx0aXBsZSBkZXZpY2VzIHdpdGggb25lIGRyaXZlciBhcyBzZWVuDQpp
biB0aGUgQjI4ODlGQzkgZHJpdmVyIChwY2llLWhpc2ktZXJyb3IuYykuIA0KICANCj4NCj4NCj4+
ICsJCQkJY29udGludWU7DQo+PiArCQkJbGlzdF9kZWxfcmN1KCZldmVudF9ub3RpZnktPmxpc3Qp
Ow0KPj4gKwkJCWZvdW5kID0gdHJ1ZTsNCj4+ICsJCQlicmVhazsNCj4+ICsJCX0NCj4+ICsJfQ0K
Pj4gKwlyY3VfcmVhZF91bmxvY2soKTsNCj4+ICsJbXV0ZXhfdW5sb2NrKCZnaGVzX2V2ZW50X25v
dGlmeV9tdXRleCk7DQo+PiArDQo+PiArCWlmICghZm91bmQpIHsNCj4+ICsJCXByX2VycigiVHJp
ZWQgdG8gdW5yZWdpc3RlciBhIEdIRVMgZXZlbnQgaGFuZGxlciB0aGF0IGhhcyBub3QNCj5iZWVu
IHJlZ2lzdGVyZWRcbiIpOw0KPj4gKwkJcmV0dXJuOw0KPj4gKwl9DQo+PiArDQo+PiArCXN5bmNo
cm9uaXplX3JjdSgpOw0KPj4gKwlrZnJlZShldmVudF9ub3RpZnkpOw0KPj4gK30NCj4+ICtFWFBP
UlRfU1lNQk9MX0dQTChnaGVzX3VucmVnaXN0ZXJfZXZlbnRfaGFuZGxlcik7DQo+DQo+PiBAQCAt
NTI1LDExICs2MjgsMTQgQEAgc3RhdGljIHZvaWQgZ2hlc19kb19wcm9jKHN0cnVjdCBnaGVzICpn
aGVzLA0KPj4NCj4+ICAJCQlsb2dfYXJtX2h3X2Vycm9yKGVycik7DQo+PiAgCQl9IGVsc2Ugew0K
Pj4gLQkJCXZvaWQgKmVyciA9IGFjcGlfaGVzdF9nZXRfcGF5bG9hZChnZGF0YSk7DQo+PiAtDQo+
PiAtCQkJbG9nX25vbl9zdGFuZGFyZF9ldmVudChzZWNfdHlwZSwgZnJ1X2lkLCBmcnVfdGV4dCwN
Cj4+IC0JCQkJCSAgICAgICBzZWNfc2V2LCBlcnIsDQo+PiAtCQkJCQkgICAgICAgZ2RhdGEtPmVy
cm9yX2RhdGFfbGVuZ3RoKTsNCj4+ICsJCQlpZiAoIWdoZXNfaGFuZGxlX25vbl9zdGFuZGFyZF9l
dmVudChzZWNfdHlwZSwgZ2RhdGEsDQo+PiArCQkJCQkJCSAgICBzZXYpKSB7DQo+PiArCQkJCXZv
aWQgKmVyciA9IGFjcGlfaGVzdF9nZXRfcGF5bG9hZChnZGF0YSk7DQo+PiArDQo+PiArCQkJCWxv
Z19ub25fc3RhbmRhcmRfZXZlbnQoc2VjX3R5cGUsIGZydV9pZCwNCj4+ICsJCQkJCQkgICAgICAg
ZnJ1X3RleHQsIHNlY19zZXYsIGVyciwNCj4+ICsJCQkJCQkgICAgICAgZ2RhdGEtPmVycm9yX2Rh
dGFfbGVuZ3RoKTsNCj4+ICsJCQl9DQo+DQo+U28sIGEgc2lkZSBlZmZlY3Qgb2YgdGhlIGtlcm5l
bCBoYW5kbGluZyB0aGVzZSBpcyB0aGV5IG5vIGxvbmdlciBnZXQgbG9nZ2VkIG91dCBvZg0KPnRy
YWNlIHBvaW50cz8NCj4NCj5JIGd1ZXNzIHRoZSBkcml2ZXIgdGhlIGNsYWltcyB0aGlzIGxvZ3Mg
c29tZSBtb3JlIGFjY3VyYXRlIGluZm9ybWF0aW9uLiBBcmUNCj50aGVyZSBleHBlY3RlZCB0byBi
ZSBhbnkgdXNlci1zcGFjZSBwcm9ncmFtcyBkb2luZyBzb21ldGhpbmcgdXNlZnVsIHdpdGgNCj5C
Mjg4OUZDOS4uLiB0b2RheT8NClRoZSBCMjg4OUZDOSBkcml2ZXIgZG9lcyBub3QgZXhwZWN0IGFu
eSBjb3JyZXNwb25kaW5nIHVzZXIgc3BhY2UgcHJvZ3JhbXMuIA0KVGhlIGRyaXZlciBtYWlubHkg
Zm9yIHRoZSBlcnJvciByZWNvdmVyeSBhbmQgYmFzaWMgZXJyb3IgZGVjb2RpbmcgYW5kIGxvZ2dp
bmcuDQpQcmV2aW91c2x5IHdlIGFkZGVkIHRoZSBlcnJvciBsb2dnaW5nIGZvciB0aGUgQjI4ODlG
QzkgaW4gdGhlIHJhc2RhZW1vbi4NCj4NCj4NCj5UaGFua3MsDQo+DQo+SmFtZXMNCg0KVGhhbmtz
LA0KU2hpanUNCg==
