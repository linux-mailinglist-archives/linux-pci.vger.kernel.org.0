Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 777A9396CFE
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jun 2021 07:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232869AbhFAFvo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Jun 2021 01:51:44 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:59266 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229477AbhFAFvn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Jun 2021 01:51:43 -0400
X-UUID: 1cb6a43bf84b4a87878f30a5af8883f2-20210601
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=jiSLFkIn1fEytymJzHWtMUL+9HgJF2xAn74O+cTz5C4=;
        b=tRm3/ronP2BskDtwbWBhHsaA4mr/GVUFdWPUyT1rt1b8kLk8JDz5LMVtiPUBMqSYsz0QbG3AmxGR5EAS4jiJlJr03hcuqEDfpnP/7VZ0uK9bPJCz+WP1m+peYoP9BBG+nTsHGEuY4YXgEYnJOUwjDGX9/XLHUvCpCpLJWAlFZ/g=;
X-UUID: 1cb6a43bf84b4a87878f30a5af8883f2-20210601
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 303169635; Tue, 01 Jun 2021 13:50:00 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 1 Jun
 2021 13:49:55 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 1 Jun 2021 13:49:54 +0800
Message-ID: <1622526594.9054.6.camel@mhfsdcap03>
Subject: Re: [PATCH 1/2] dt-bindings: PCI: mediatek-gen3: Add support for
 MT8195
From:   Jianjun Wang <jianjun.wang@mediatek.com>
To:     Chen-Yu Tsai <wenst@chromium.org>
CC:     Ryder Lee <ryder.lee@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Randy Wu <Randy.Wu@mediatek.com>, <youlin.pei@mediatek.com>
Date:   Tue, 1 Jun 2021 13:49:54 +0800
In-Reply-To: <CAGXv+5G-8+ppafiUnqWm2UeiL+edHJ2zYZvU-S7mz_NdrM3YsA@mail.gmail.com>
References: <20210601024408.24485-1-jianjun.wang@mediatek.com>
         <20210601024408.24485-2-jianjun.wang@mediatek.com>
         <CAGXv+5G-8+ppafiUnqWm2UeiL+edHJ2zYZvU-S7mz_NdrM3YsA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: B186BFA5F6860A0A9441A37F5F3612750236F03574A7631EB87997CBB9D33AC02000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVHVlLCAyMDIxLTA2LTAxIGF0IDExOjUzICswODAwLCBDaGVuLVl1IFRzYWkgd3JvdGU6DQo+
IEhpLA0KPiANCj4gT24gVHVlLCBKdW4gMSwgMjAyMSBhdCAxMDo1MCBBTSBKaWFuanVuIFdhbmcg
PGppYW5qdW4ud2FuZ0BtZWRpYXRlay5jb20+IHdyb3RlOg0KPiA+DQo+ID4gTVQ4MTk1IGlzIGFu
IEFSTSBwbGF0Zm9ybSBTb0Mgd2hpY2ggaGFzIHRoZSBzYW1lIFBDSWUgSVAgd2l0aCBNVDgxOTIu
DQo+IA0KPiBCYXNlZCBvbiB3aGF0IEknbSBzZWVpbmcgaW50ZXJuYWxseSwgdGhlcmUgc2VlbXMg
dG8gYmUgc29tZSBpbmNvbnNpc3RlbmN5DQo+IGFjcm9zcyB0aGUgTWVkaWFUZWsgcGxhdGZvcm0g
b24gd2hldGhlciBuZXcgY29tcGF0aWJsZSBzdHJpbmdzIHNob3VsZCBiZQ0KPiBpbnRyb2R1Y2Vk
IGZvciAiZnVsbHkgY29tcGF0aWJsZSIgSVAgYmxvY2tzLg0KPiANCj4gSWYgdGhpcyBoYXJkd2Fy
ZSBibG9jayBpbiBNVDgxOTUgaXMgInRoZSBzYW1lIiBhcyB0aGUgb25lIGluIE1UODE5MiwgZG8g
d2UNCj4gcmVhbGx5IG5lZWQgdGhlIG5ldyBjb21wYXRpYmxlIHN0cmluZz8gQXJlIHRoZXJlIGFu
eSBjb25jZXJucz8NCg0KSGkgQ2hlbi1ZdSwNCg0KSXQncyBvayB0byByZXVzZSB0aGUgY29tcGF0
aWJsZSBzdHJpbmcgd2l0aCBNVDgxOTIsIGJ1dCBJIHRoaW5rIHRoaXMNCndpbGwgYmUgZWFzaWVy
IHRvIGZpbmQgd2hpY2ggcGxhdGZvcm1zIHRoaXMgZHJpdmVyIGlzIGNvbXBhdGlibGUgd2l0aCwN
CmVzcGVjaWFsbHkgd2hlbiB3ZSBoYXZlIG1vcmUgYW5kIG1vcmUgcGxhdGZvcm1zIGluIHRoZSBm
dXR1cmUuDQoNClRoYW5rcy4gDQo+IA0KPiANCj4gVGhhbmtzDQo+IENoZW5ZdQ0KPiANCj4gDQo+
ID4gU2lnbmVkLW9mZi1ieTogSmlhbmp1biBXYW5nIDxqaWFuanVuLndhbmdAbWVkaWF0ZWsuY29t
Pg0KPiA+IC0tLQ0KPiA+ICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL21l
ZGlhdGVrLXBjaWUtZ2VuMy55YW1sIHwgNCArKystDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAzIGlu
c2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL21lZGlhdGVrLXBjaWUtZ2VuMy55YW1sIGIv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9tZWRpYXRlay1wY2llLWdlbjMu
eWFtbA0KPiA+IGluZGV4IGU3YjFmOTg5MmRhNC4uZDVlNGEzZTYzZDk3IDEwMDY0NA0KPiA+IC0t
LSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvbWVkaWF0ZWstcGNpZS1n
ZW4zLnlhbWwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNp
L21lZGlhdGVrLXBjaWUtZ2VuMy55YW1sDQo+ID4gQEAgLTQ4LDcgKzQ4LDkgQEAgYWxsT2Y6DQo+
ID4NCj4gPiAgcHJvcGVydGllczoNCj4gPiAgICBjb21wYXRpYmxlOg0KPiA+IC0gICAgY29uc3Q6
IG1lZGlhdGVrLG10ODE5Mi1wY2llDQo+ID4gKyAgICBvbmVPZjoNCj4gPiArICAgICAgLSBjb25z
dDogbWVkaWF0ZWssbXQ4MTkyLXBjaWUNCj4gPiArICAgICAgLSBjb25zdDogbWVkaWF0ZWssbXQ4
MTk1LXBjaWUNCj4gPg0KPiA+ICAgIHJlZzoNCj4gPiAgICAgIG1heEl0ZW1zOiAxDQo+ID4gLS0N
Cj4gPiAyLjE4LjANCj4gPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXw0KPiA+IExpbnV4LW1lZGlhdGVrIG1haWxpbmcgbGlzdA0KPiA+IExpbnV4LW1lZGlh
dGVrQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gPiBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2xpbnV4LW1lZGlhdGVrDQoNCg==

