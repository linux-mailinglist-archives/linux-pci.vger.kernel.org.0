Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91AA03B7C21
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jun 2021 05:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233598AbhF3Dkz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Jun 2021 23:40:55 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:53374 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233806AbhF3Dkv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Jun 2021 23:40:51 -0400
X-UUID: fefe8626717f4900a25b0c8d2479e50a-20210630
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=2VlqRRg44sL5xrfMMeXAy4DWOwYJ341cF9f4mlVSKCQ=;
        b=cPTbapyDf3MA3l1lchFnAbmAqSNaMa5ER/3XGsPOHF67CO31q+KFVkuEVnwO2NVLIIrdA3+3ULsAqx8lnxunRZmNQY2wlkffw/PGwJ8COClDlwTuUBzU6yzUHgctuLbU6keJOpQQrLUZFvq7vBlQ0G2IftsSatTS3PBOHCGsobY=;
X-UUID: fefe8626717f4900a25b0c8d2479e50a-20210630
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <qizhong.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1553400662; Wed, 30 Jun 2021 11:38:19 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 30 Jun 2021 11:38:11 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 30 Jun 2021 11:38:08 +0800
Message-ID: <1625024288.20084.9.camel@mhfsdcap03>
Subject: Re: [PATCH v3 2/2] PCI: mediatek-gen3: Add support for disable
 dvfsrc voltage request
From:   Qizhong Cheng <qizhong.cheng@mediatek.com>
To:     Jianjun Wang <jianjun.wang@mediatek.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <youlin.pei@mediatek.com>,
        <chuanjia.liu@mediatek.com>, <ot_jieyang@mediatek.com>,
        <drinkcat@chromium.org>, <Rex-BC.Chen@mediatek.com>,
        Krzysztof Wilczyski <kw@linux.com>, <Ryan-JH.Yu@mediatek.com>
Date:   Wed, 30 Jun 2021 11:38:08 +0800
In-Reply-To: <20210630024934.18903-3-jianjun.wang@mediatek.com>
References: <20210630024934.18903-1-jianjun.wang@mediatek.com>
         <20210630024934.18903-3-jianjun.wang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

UmV2aWV3ZWQtYnk6IFFpemhvbmcgQ2hlbmcgPHFpemhvbmcuY2hlbmdAbWVkaWF0ZWsuY29tPg0K
VGVzdGVkLWJ5OiBRaXpob25nIENoZW5nIDxxaXpob25nLmNoZW5nQG1lZGlhdGVrLmNvbT4NCg0K
T24gV2VkLCAyMDIxLTA2LTMwIGF0IDEwOjQ5ICswODAwLCBKaWFuanVuIFdhbmcgd3JvdGU6DQo+
IFBDSWUgR2VuMyBQSFkgbGF5ZXIgY2Fubm90IHdvcmsgcHJvcGVybHkgd2hlbiB0aGUgcmVxdWVz
dGVkIHZvbHRhZ2UNCj4gaXMgbG93ZXIgdGhhbiBhIHNwZWNpZmljIGxldmVsKGUuZy4gMC41NVYs
IGl0J3MgZGVwZW5kcyBvbg0KPiB0aGUgY2hpcCBtYW51ZmFjdHVyaW5nIHByb2Nlc3MpLg0KPiAN
Cj4gV2hlbiB0aGUgZHZmc3JjIGZlYXR1cmUgaXMgaW1wbGVtZW50ZWQsIHRoZSByZXF1ZXN0ZWQg
dm9sdGFnZQ0KPiBtYXkgYmUgcmVkdWNlZCB0byBhIGxvd2VyIGxldmVsIGluIHN1c3BlbmQgbW9k
ZSwgaGVuY2UgdGhhdA0KPiB0aGUgTUFDIGxheWVyIHdpbGwgYXNzZXJ0IGEgSFcgc2lnbmFsIHRv
IHJlcXVlc3QgdGhlIGR2ZnNyYw0KPiB0byByYWlzZSB2b2x0YWdlIHRvIG5vcm1hbCBtb2RlLCBh
bmQgaXQgd2lsbCB3YWl0IHRoZSB2b2x0YWdlDQo+IHJlYWR5IHNpZ25hbCBmcm9tIGR2ZnNyYyB0
byBkZWNpZGUgaWYgdGhlIExUU1NNIGNhbiBzdGFydCBub3JtYWxseS4NCj4gDQo+IFdoZW4gdGhl
IGR2ZnNyYyBmZWF0dXJlIGlzIG5vdCBpbXBsZW1lbnRlZCwgdGhlIE1BQyBsYXllciBzdGlsbA0K
PiBhc3NlcnQgdGhlIHZvbHRhZ2UgcmVxdWVzdCB0byBkdmZzcmMgd2hlbiBleGl0IHN1c3BlbmQg
bW9kZSwNCj4gYnV0IHdpbGwgbm90IHJlY2VpdmUgdGhlIHZvbHRhZ2UgcmVhZHkgc2lnbmFsLCBp
biB0aGlzIGNhc2UsDQo+IHRoZSBMVFNTTSBjYW5ub3Qgc3RhcnQgbm9ybWFsbHksIGFuZCB0aGUg
UENJZSBsaW5rIHdpbGwgYmUgZmFpbGVkLg0KPiANCj4gQWRkIHN1cHBvcnQgZm9yIGRpc2FibGUg
ZHZmc3JjIHZvbHRhZ2UgcmVxdWVzdCwgaWYgdGhlIHByb3BlcnR5IG9mDQo+ICJkaXNhYmxlLWR2
ZnNyYy12bHQtcmVxIiBpcyBwcmVzZW50ZWQgaW4gZGV2aWNlIG5vZGUsIHdlIGFzc3VtZSB0aGF0
DQo+IHRoZSByZXF1ZXN0ZWQgdm9sdGFnZSBpcyBhbHdheXMgaGlnaGVyIGVub3VnaCB0byBrZWVw
IHRoZSBQQ0llIEdlbjMNCj4gUEhZIGFjdGl2ZSwgYW5kIHRoZSB2b2x0YWdlIHJlcXVlc3QgdG8g
ZHZmc3JjIHNob3VsZCBiZSBkaXNhYmxlZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEppYW5qdW4g
V2FuZyA8amlhbmp1bi53YW5nQG1lZGlhdGVrLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL3BjaS9j
b250cm9sbGVyL3BjaWUtbWVkaWF0ZWstZ2VuMy5jIHwgMzEgKysrKysrKysrKysrKysrKysrKysr
DQo+ICAxIGZpbGUgY2hhbmdlZCwgMzEgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tZWRpYXRlay1nZW4zLmMgYi9kcml2ZXJzL3Bj
aS9jb250cm9sbGVyL3BjaWUtbWVkaWF0ZWstZ2VuMy5jDQo+IGluZGV4IDNjNWI5NzcxNmQ0MC4u
MDI4MDE0NzA3NTg4IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUt
bWVkaWF0ZWstZ2VuMy5jDQo+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tZWRp
YXRlay1nZW4zLmMNCj4gQEAgLTc5LDYgKzc5LDkgQEANCj4gICNkZWZpbmUgUENJRV9JQ01EX1BN
X1JFRwkJMHgxOTgNCj4gICNkZWZpbmUgUENJRV9UVVJOX09GRl9MSU5LCQlCSVQoNCkNCj4gIA0K
PiArI2RlZmluZSBQQ0lFX01JU0NfQ1RSTF9SRUcJCTB4MzQ4DQo+ICsjZGVmaW5lIFBDSUVfRElT
QUJMRV9EVkZTUkNfVkxUX1JFUQlCSVQoMSkNCj4gKw0KPiAgI2RlZmluZSBQQ0lFX1RSQU5TX1RB
QkxFX0JBU0VfUkVHCTB4ODAwDQo+ICAjZGVmaW5lIFBDSUVfQVRSX1NSQ19BRERSX01TQl9PRkZT
RVQJMHg0DQo+ICAjZGVmaW5lIFBDSUVfQVRSX1RSU0xfQUREUl9MU0JfT0ZGU0VUCTB4OA0KPiBA
QCAtMjk3LDYgKzMwMCwzNCBAQCBzdGF0aWMgaW50IG10a19wY2llX3N0YXJ0dXBfcG9ydChzdHJ1
Y3QgbXRrX3BjaWVfcG9ydCAqcG9ydCkNCj4gIAl2YWwgJj0gflBDSUVfSU5UWF9FTkFCTEU7DQo+
ICAJd3JpdGVsX3JlbGF4ZWQodmFsLCBwb3J0LT5iYXNlICsgUENJRV9JTlRfRU5BQkxFX1JFRyk7
DQo+ICANCj4gKwkvKg0KPiArCSAqIFBDSWUgR2VuMyBQSFkgbGF5ZXIgY2FuIG5vdCB3b3JrIHBy
b3Blcmx5IHdoZW4gdGhlIHJlcXVlc3RlZCB2b2x0YWdlDQo+ICsJICogaXMgbG93ZXIgdGhhbiBh
IHNwZWNpZmljIGxldmVsKGUuZy4gMC41NVYsIGl0J3MgZGVwZW5kcyBvbg0KPiArCSAqIHRoZSBj
aGlwIG1hbnVmYWN0dXJpbmcgcHJvY2VzcykuDQo+ICsJICoNCj4gKwkgKiBXaGVuIHRoZSBkdmZz
cmMgZmVhdHVyZSBpcyBpbXBsZW1lbnRlZCwgdGhlIHJlcXVlc3RlZCB2b2x0YWdlDQo+ICsJICog
bWlnaHQgYmUgcmVkdWNlZCB0byBhIGxvd2VyIGxldmVsIGluIHN1c3BlbmQgbW9kZSwgaGVuY2Ug
dGhhdA0KPiArCSAqIHRoZSBNQUMgbGF5ZXIgd2lsbCBhc3NlcnQgYSBIVyBzaWduYWwgdG8gcmVx
dWVzdCB0aGUgZHZmc3JjDQo+ICsJICogdG8gcmFpc2Ugdm9sdGFnZSB0byBub3JtYWwgbW9kZSwg
YW5kIGl0IHdpbGwgd2FpdCB0aGUgdm9sdGFnZQ0KPiArCSAqIHJlYWR5IHNpZ25hbCBmcm9tIGR2
ZnNyYyB0byBzdGFydCB0aGUgTFRTU00gbm9ybWFsbHkuDQo+ICsJICoNCj4gKwkgKiBXaGVuIHRo
ZSBkdmZzcmMgZmVhdHVyZSBpcyBub3QgaW1wbGVtZW50ZWQsIHRoZSBNQUMgbGF5ZXIgc3RpbGwN
Cj4gKwkgKiBhc3NlcnQgdGhlIHZvbHRhZ2UgcmVxdWVzdCB0byBkdmZzcmMgd2hlbiBleGl0IHN1
c3BlbmQgbW9kZSwNCj4gKwkgKiBidXQgd2lsbCBub3QgZ2V0IHRoZSB2b2x0YWdlIHJlYWR5IHNp
Z25hbCwgaW4gdGhpcyBjYXNlLCB0aGUgTFRTU00NCj4gKwkgKiBjYW5ub3Qgc3RhcnQgbm9ybWFs
bHksIGFuZCB0aGUgUENJZSBsaW5rIHdpbGwgYmUgZmFpbGVkLg0KPiArCSAqDQo+ICsJICogSWYg
dGhlIHByb3BlcnR5IG9mICJkaXNhYmxlLWR2ZnNyYy12bHQtcmVxIiBpcyBwcmVzZW50ZWQNCj4g
KwkgKiBpbiBkZXZpY2Ugbm9kZSwgd2UgYXNzdW1lIHRoYXQgdGhlIHJlcXVlc3RlZCB2b2x0YWdl
IGlzIGFsd2F5cw0KPiArCSAqIGhpZ2hlciBlbm91Z2ggdG8ga2VlcCB0aGUgUENJZSBHZW4zIFBI
WSBhY3RpdmUsIGFuZCB0aGUgdm9sdGFnZQ0KPiArCSAqIHJlcXVlc3QgdG8gZHZmc3JjIHNob3Vs
ZCBiZSBkaXNhYmxlZC4NCj4gKwkgKi8NCj4gKwl2YWwgPSByZWFkbF9yZWxheGVkKHBvcnQtPmJh
c2UgKyBQQ0lFX01JU0NfQ1RSTF9SRUcpOw0KPiArCXZhbCAmPSB+UENJRV9ESVNBQkxFX0RWRlNS
Q19WTFRfUkVROw0KPiArCWlmIChvZl9wcm9wZXJ0eV9yZWFkX2Jvb2wocG9ydC0+ZGV2LT5vZl9u
b2RlLCAiZGlzYWJsZS1kdmZzcmMtdmx0LXJlcSIpKQ0KPiArCQl2YWwgfD0gUENJRV9ESVNBQkxF
X0RWRlNSQ19WTFRfUkVROw0KPiArDQo+ICsJd3JpdGVsX3JlbGF4ZWQodmFsLCBwb3J0LT5iYXNl
ICsgUENJRV9NSVNDX0NUUkxfUkVHKTsNCj4gKw0KPiAgCS8qIEFzc2VydCBhbGwgcmVzZXQgc2ln
bmFscyAqLw0KPiAgCXZhbCA9IHJlYWRsX3JlbGF4ZWQocG9ydC0+YmFzZSArIFBDSUVfUlNUX0NU
UkxfUkVHKTsNCj4gIAl2YWwgfD0gUENJRV9NQUNfUlNUQiB8IFBDSUVfUEhZX1JTVEIgfCBQQ0lF
X0JSR19SU1RCIHwgUENJRV9QRV9SU1RCOw0KDQo=

