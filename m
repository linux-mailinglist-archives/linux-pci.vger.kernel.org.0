Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1663D3150
	for <lists+linux-pci@lfdr.de>; Fri, 23 Jul 2021 03:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233039AbhGWAuz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Jul 2021 20:50:55 -0400
Received: from mx21.baidu.com ([220.181.3.85]:34170 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232992AbhGWAuz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Jul 2021 20:50:55 -0400
Received: from BC-Mail-Ex27.internal.baidu.com (unknown [172.31.51.21])
        by Forcepoint Email with ESMTPS id CAD2866F9C9FEE926CA;
        Fri, 23 Jul 2021 09:30:57 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex27.internal.baidu.com (172.31.51.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 23 Jul 2021 09:30:57 +0800
Received: from BJHW-MAIL-EX27.internal.baidu.com ([169.254.58.247]) by
 BJHW-MAIL-EX27.internal.baidu.com ([169.254.58.247]) with mapi id
 15.01.2308.014; Fri, 23 Jul 2021 09:30:57 +0800
From:   "Cai,Huoqing" <caihuoqing@baidu.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "jonathan.derrick@intel.com" <jonathan.derrick@intel.com>,
        "kw@linux.com" <kw@linux.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/2] PCI: Make use of PCI_DEVICE_XXX() helper function
Thread-Topic: [PATCH 0/2] PCI: Make use of PCI_DEVICE_XXX() helper function
Thread-Index: AQHXfutlH33bL9BhfEO2Qe6OtAUea6tOr/GAgAEQVdA=
Date:   Fri, 23 Jul 2021 01:30:57 +0000
Message-ID: <e31495411e8b41f785dd619f51c0f5cc@baidu.com>
References: <20210722111903.432-1-caihuoqing@baidu.com>
 <20210722165225.GA316118@bjorn-Precision-5520>
In-Reply-To: <20210722165225.GA316118@bjorn-Precision-5520>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.18.18.94]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGVsbG8NCglJIGdldCBpdCBhbmQgd2lsbCBzZW5kIHBhdGNoIFBBVENIIGFnYWluLg0KDQpUSFgN
Cg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEJqb3JuIEhlbGdhYXMgPGhlbGdh
YXNAa2VybmVsLm9yZz4gDQpTZW50OiAyMDIxxOo31MIyM8jVIDA6NTINClRvOiBDYWksSHVvcWlu
ZyA8Y2FpaHVvcWluZ0BiYWlkdS5jb20+DQpDYzogYmhlbGdhYXNAZ29vZ2xlLmNvbTsgam9uYXRo
YW4uZGVycmlja0BpbnRlbC5jb207IGt3QGxpbnV4LmNvbTsgb25hdGhhbi5kZXJyaWNrQGludGVs
LmNvbTsgbG9yZW56by5waWVyYWxpc2lAYXJtLmNvbTsgcm9iaEBrZXJuZWwub3JnOyBsaW51eC1w
Y2lAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQpTdWJqZWN0
OiBSZTogW1BBVENIIDAvMl0gUENJOiBNYWtlIHVzZSBvZiBQQ0lfREVWSUNFX1hYWCgpIGhlbHBl
ciBmdW5jdGlvbg0KDQpPbiBUaHUsIEp1bCAyMiwgMjAyMSBhdCAwNzoxOTowMVBNICswODAwLCBD
YWkgSHVvcWluZyB3cm90ZToNCj4gQ291bGQgbWFrZSB1c2Ugb2YgUENJX0RFVklDRV9YWFgoKSBo
ZWxwZXIgZnVuY3Rpb24NCj4gDQo+IENhaSBIdW9xaW5nICgyKToNCj4gICBQQ0k6IE1ha2UgdXNl
IG9mIFBDSV9ERVZJQ0VfU1VCL19DTEFTUygpIGhlbHBlciBmdW5jdGlvbg0KPiAgIFBDSTogdm1k
OiBNYWtlIHVzZSBvZiBQQ0lfREVWSUNFX0RBVEEoKSBoZWxwZXIgZnVuY3Rpb24NCj4gDQo+ICBk
cml2ZXJzL3BjaS9jb250cm9sbGVyL3ZtZC5jICAgICAgfCAzOCArKysrKysrKysrKysrKystLS0t
LS0tLS0tLS0tLS0tDQo+ICBkcml2ZXJzL3BjaS9ob3RwbHVnL2NwcXBocF9jb3JlLmMgfCAxMyAr
Ky0tLS0tLS0tLQ0KPiAgZHJpdmVycy9wY2kvc2VhcmNoLmMgICAgICAgICAgICAgIHwgMTQgKyst
LS0tLS0tLS0tDQo+ICBpbmNsdWRlL2xpbnV4L3BjaV9pZHMuaCAgICAgICAgICAgfCAgMiArKw0K
PiAgNCBmaWxlcyBjaGFuZ2VkLCAyNSBpbnNlcnRpb25zKCspLCA0MiBkZWxldGlvbnMoLSkNCg0K
V2hlbiB5b3UgZml4IHRoZSBwcm9ibGVtIGJlbG93LCBhbHNvOg0KDQpzL01ha2UgdXNlIG9mL1Vz
ZS8NCg0KVXBkYXRlIGNvbW1pdCBsb2cgdG8gc2F5IHdoYXQgdGhlIHBhdGNoIGRvZXMuICBTZWUg
aHR0cHM6Ly9jaHJpcy5iZWFtcy5pby9wb3N0cy9naXQtY29tbWl0LyBmb3IgaGludHMuDQpBZGQg
cGVyaW9kIGF0IGVuZCBvZiBzZW50ZW5jZXMuDQoNCkkgZG9uJ3Qgc2VlIGV4YWN0bHkgd2hhdCdz
IHdyb25nLCBidXQgdGhpcyBzZXJpZXMgZG9lc24ndCBhcHBseSBjbGVhbmx5LiAgSSdtIHVzaW5n
IGI0IHRvIGZldGNoIHRoZSBzZXJpZXMuICBiNCBpcyBmcm9tIGh0dHBzOi8vZ2l0Lmtlcm5lbC5v
cmcvcHViL3NjbS91dGlscy9iNC9iNC5naXQNCg0KICAxMTo0NzowNCB+L2xpbnV4IChtYWluKSQg
Z2l0IGNoZWNrb3V0IC1iIHdpcC9jYWkgdjUuMTQtcmMxDQogIFN3aXRjaGVkIHRvIGEgbmV3IGJy
YW5jaCAnd2lwL2NhaScNCiAgMTE6NDc6MTcgfi9saW51eCAod2lwL2NhaSkkIGI0IGFtIC1vbS8g
MjAyMTA3MjIxMTE5MDMuNDMyLTEtY2FpaHVvcWluZ0BiYWlkdS5jb20NCiAgTG9va2luZyB1cCBo
dHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjEwNzIyMTExOTAzLjQzMi0xLWNhaWh1b3Fpbmcl
NDBiYWlkdS5jb20NCiAgR3JhYmJpbmcgdGhyZWFkIGZyb20gbG9yZS5rZXJuZWwub3JnL2xpbnV4
LXBjaQ0KICBBbmFseXppbmcgMyBtZXNzYWdlcyBpbiB0aGUgdGhyZWFkDQogIC0tLQ0KICBXcml0
aW5nIG0vMjAyMTA3MjJfY2FpaHVvcWluZ19wY2lfbWFrZV91c2Vfb2ZfcGNpX2RldmljZV94eHhf
aGVscGVyX2Z1bmN0aW9uLm1ieA0KICAgIFtQQVRDSCAxLzJdIFBDSTogTWFrZSB1c2Ugb2YgUENJ
X0RFVklDRV9TVUIvX0NMQVNTKCkgaGVscGVyIGZ1bmN0aW9uDQogICAgW1BBVENIIDIvMl0gUENJ
OiB2bWQ6IE1ha2UgdXNlIG9mIFBDSV9ERVZJQ0VfREFUQSgpIGhlbHBlciBmdW5jdGlvbg0KICAt
LS0NCiAgVG90YWwgcGF0Y2hlczogMg0KICAtLS0NCiAgQ292ZXI6IG0vMjAyMTA3MjJfY2FpaHVv
cWluZ19wY2lfbWFrZV91c2Vfb2ZfcGNpX2RldmljZV94eHhfaGVscGVyX2Z1bmN0aW9uLmNvdmVy
DQogICBMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjEwNzIyMTExOTAzLjQzMi0x
LWNhaWh1b3FpbmdAYmFpZHUuY29tDQogICBCYXNlOiBub3QgZm91bmQgKGFwcGxpZXMgY2xlYW4g
dG8gY3VycmVudCB0cmVlKQ0KCSBnaXQgYW0gbS8yMDIxMDcyMl9jYWlodW9xaW5nX3BjaV9tYWtl
X3VzZV9vZl9wY2lfZGV2aWNlX3h4eF9oZWxwZXJfZnVuY3Rpb24ubWJ4DQogIDExOjQ3OjQ1IH4v
bGludXggKHdpcC9jYWkpJCBnaXQgYW0gbS8yMDIxMDcyMl9jYWlodW9xaW5nX3BjaV9tYWtlX3Vz
ZV9vZl9wY2lfZGV2aWNlX3h4eF9oZWxwZXJfZnVuY3Rpb24ubWJ4DQogIEFwcGx5aW5nOiBQQ0k6
IE1ha2UgdXNlIG9mIFBDSV9ERVZJQ0VfU1VCL19DTEFTUygpIGhlbHBlciBmdW5jdGlvbg0KICBl
cnJvcjogcGF0Y2ggZmFpbGVkOiBkcml2ZXJzL3BjaS9ob3RwbHVnL2NwcXBocF9jb3JlLmM6MTM1
Nw0KICBlcnJvcjogZHJpdmVycy9wY2kvaG90cGx1Zy9jcHFwaHBfY29yZS5jOiBwYXRjaCBkb2Vz
IG5vdCBhcHBseQ0KICBlcnJvcjogcGF0Y2ggZmFpbGVkOiBkcml2ZXJzL3BjaS9zZWFyY2guYzoz
MDMNCiAgZXJyb3I6IGRyaXZlcnMvcGNpL3NlYXJjaC5jOiBwYXRjaCBkb2VzIG5vdCBhcHBseQ0K
ICBQYXRjaCBmYWlsZWQgYXQgMDAwMSBQQ0k6IE1ha2UgdXNlIG9mIFBDSV9ERVZJQ0VfU1VCL19D
TEFTUygpIGhlbHBlciBmdW5jdGlvbg0KICBoaW50OiBVc2UgJ2dpdCBhbSAtLXNob3ctY3VycmVu
dC1wYXRjaCcgdG8gc2VlIHRoZSBmYWlsZWQgcGF0Y2gNCiAgV2hlbiB5b3UgaGF2ZSByZXNvbHZl
ZCB0aGlzIHByb2JsZW0sIHJ1biAiZ2l0IGFtIC0tY29udGludWUiLg0KICBJZiB5b3UgcHJlZmVy
IHRvIHNraXAgdGhpcyBwYXRjaCwgcnVuICJnaXQgYW0gLS1za2lwIiBpbnN0ZWFkLg0KICBUbyBy
ZXN0b3JlIHRoZSBvcmlnaW5hbCBicmFuY2ggYW5kIHN0b3AgcGF0Y2hpbmcsIHJ1biAiZ2l0IGFt
IC0tYWJvcnQiLg0KDQo=
