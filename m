Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6E173B1664
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jun 2021 11:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbhFWJFN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Jun 2021 05:05:13 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:39569 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229833AbhFWJFN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Jun 2021 05:05:13 -0400
X-UUID: 552431a23ebe4ed6ab6a1b0e58b8b1c6-20210623
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=WHVs4dh6AbAKAbeIIKWBxdhvq+wckIntxxe4eFfwL3A=;
        b=gZMamKoetcWP3ttbQXdOp/wfPXqx/YKRVd5BPGlaE6AvZnbVcP01sgyKX9kWl7YOtN1nwYvKaDxrnEiknpXU19V0plkvv58G+rc7peFJyMUoNamQ4PIqtgbGL73P0aOV6vv+pNfZDxQ1TslBxrqooxHsFYo+GrbwSISXdsowYT4=;
X-UUID: 552431a23ebe4ed6ab6a1b0e58b8b1c6-20210623
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1401636374; Wed, 23 Jun 2021 17:02:52 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 23 Jun
 2021 17:02:49 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 23 Jun 2021 17:02:48 +0800
Message-ID: <1624438968.2701.3.camel@mhfsdcap03>
Subject: Re: [PATCH 1/2] dt-bindings: PCI: mediatek-gen3: Add support for
 MT8195
From:   Jianjun Wang <jianjun.wang@mediatek.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Randy Wu <Randy.Wu@mediatek.com>, <youlin.pei@mediatek.com>
Date:   Wed, 23 Jun 2021 17:02:48 +0800
In-Reply-To: <20210622110517.GB24565@lpieralisi>
References: <20210601024408.24485-1-jianjun.wang@mediatek.com>
         <20210601024408.24485-2-jianjun.wang@mediatek.com>
         <CAGXv+5G-8+ppafiUnqWm2UeiL+edHJ2zYZvU-S7mz_NdrM3YsA@mail.gmail.com>
         <1622526594.9054.6.camel@mhfsdcap03>
         <CAGXv+5GMTbC5TTgURhPAvxBEY18S6-T-BZ9CpXsO91Trim7TXw@mail.gmail.com>
         <db62910b-febd-6cba-8a72-2bf718f7b110@gmail.com>
         <20210622110517.GB24565@lpieralisi>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 4D63936515B4AAF2E78DF35DD5D25263CB69BF69C06A8201811E5A3736340AA42000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVHVlLCAyMDIxLTA2LTIyIGF0IDEyOjA1ICswMTAwLCBMb3JlbnpvIFBpZXJhbGlzaSB3cm90
ZToNCj4gT24gV2VkLCBKdW4gMDIsIDIwMjEgYXQgMDE6MzM6MDdQTSArMDIwMCwgTWF0dGhpYXMg
QnJ1Z2dlciB3cm90ZToNCj4gPiANCj4gPiANCj4gPiBPbiAwMS8wNi8yMDIxIDA4OjA3LCBDaGVu
LVl1IFRzYWkgd3JvdGU6DQo+ID4gPiBIaSwNCj4gPiA+IA0KPiA+ID4gT24gVHVlLCBKdW4gMSwg
MjAyMSBhdCAxOjUwIFBNIEppYW5qdW4gV2FuZyA8amlhbmp1bi53YW5nQG1lZGlhdGVrLmNvbT4g
d3JvdGU6DQo+ID4gPj4NCj4gPiA+PiBPbiBUdWUsIDIwMjEtMDYtMDEgYXQgMTE6NTMgKzA4MDAs
IENoZW4tWXUgVHNhaSB3cm90ZToNCj4gPiA+Pj4gSGksDQo+ID4gPj4+DQo+ID4gPj4+IE9uIFR1
ZSwgSnVuIDEsIDIwMjEgYXQgMTA6NTAgQU0gSmlhbmp1biBXYW5nIDxqaWFuanVuLndhbmdAbWVk
aWF0ZWsuY29tPiB3cm90ZToNCj4gPiA+Pj4+DQo+ID4gPj4+PiBNVDgxOTUgaXMgYW4gQVJNIHBs
YXRmb3JtIFNvQyB3aGljaCBoYXMgdGhlIHNhbWUgUENJZSBJUCB3aXRoIE1UODE5Mi4NCj4gPiA+
Pj4NCj4gPiA+Pj4gQmFzZWQgb24gd2hhdCBJJ20gc2VlaW5nIGludGVybmFsbHksIHRoZXJlIHNl
ZW1zIHRvIGJlIHNvbWUgaW5jb25zaXN0ZW5jeQ0KPiA+ID4+PiBhY3Jvc3MgdGhlIE1lZGlhVGVr
IHBsYXRmb3JtIG9uIHdoZXRoZXIgbmV3IGNvbXBhdGlibGUgc3RyaW5ncyBzaG91bGQgYmUNCj4g
PiA+Pj4gaW50cm9kdWNlZCBmb3IgImZ1bGx5IGNvbXBhdGlibGUiIElQIGJsb2Nrcy4NCj4gPiA+
Pj4NCj4gPiA+Pj4gSWYgdGhpcyBoYXJkd2FyZSBibG9jayBpbiBNVDgxOTUgaXMgInRoZSBzYW1l
IiBhcyB0aGUgb25lIGluIE1UODE5MiwgZG8gd2UNCj4gPiA+Pj4gcmVhbGx5IG5lZWQgdGhlIG5l
dyBjb21wYXRpYmxlIHN0cmluZz8gQXJlIHRoZXJlIGFueSBjb25jZXJucz8NCj4gPiA+Pg0KPiA+
ID4+IEhpIENoZW4tWXUsDQo+ID4gPj4NCj4gPiA+PiBJdCdzIG9rIHRvIHJldXNlIHRoZSBjb21w
YXRpYmxlIHN0cmluZyB3aXRoIE1UODE5MiwgYnV0IEkgdGhpbmsgdGhpcw0KPiA+ID4+IHdpbGwg
YmUgZWFzaWVyIHRvIGZpbmQgd2hpY2ggcGxhdGZvcm1zIHRoaXMgZHJpdmVyIGlzIGNvbXBhdGli
bGUgd2l0aCwNCj4gPiA+PiBlc3BlY2lhbGx5IHdoZW4gd2UgaGF2ZSBtb3JlIGFuZCBtb3JlIHBs
YXRmb3JtcyBpbiB0aGUgZnV0dXJlLg0KPiA+ID4gDQo+ID4gPiBJZiBpdCdzIGp1c3QgZm9yIGlu
Zm9ybWF0aW9uYWwgcHVycG9zZXMsIHRoZW4gaGF2aW5nIHRoZSBNVDgxOTIgY29tcGF0aWJsZQ0K
PiA+ID4gYXMgYSBmYWxsYmFjayB3b3VsZCB3b3JrLCBhbmQgd2Ugd291bGRuJ3QgbmVlZCB0byBt
YWtlIGNoYW5nZXMgdG8gdGhlIGRyaXZlci4NCj4gPiA+IFRoaXMgd29ya3MgYmV0dGVyIGVzcGVj
aWFsbHkgaWYgd2UgaGF2ZSB0byBzdXBwb3J0IG11bHRpcGxlIG9wZXJhdGluZyBzeXN0ZW1zDQo+
ID4gPiB0aGF0IHVzZSBkZXZpY2UgdHJlZS4NCj4gPiA+IA0KPiA+ID4gU28gd2Ugd291bGQgd2Fu
dA0KPiA+ID4gDQo+ID4gPiAgICAgIm1lZGlhdGVrLG10ODE5NS1wY2llIiwgIm1lZGlhdGVrLG10
ODE5Mi1wY2llIg0KPiA+ID4gDQo+ID4gPiBhbmQNCj4gPiA+IA0KPiA+ID4gICAgICJtZWRpYXRl
ayxtdDgxOTItcGNpZSINCj4gPiA+IA0KPiA+ID4gYmUgdGhlIHZhbGlkIG9wdGlvbnMuDQo+ID4g
PiANCj4gPiA+IFBlcnNvbmFsbHkgSSdtIG5vdCBzZWVpbmcgZW5vdWdoIHZhbHVlIHRvIGp1c3Rp
ZnkgYWRkaW5nIHRoZSBjb21wYXRpYmxlIHN0cmluZw0KPiA+ID4ganVzdCBmb3IgaW5mb3JtYXRp
b25hbCBwdXJwb3NlcyB0aG91Z2guIE9uZSBjb3VsZCBlYXNpbHkgZGlzY2VybiB3aGljaCBoYXJk
d2FyZQ0KPiA+ID4gaXMgdXNlZCBieSBsb29raW5nIGF0IHRoZSBkZXZpY2UgdHJlZS4NCj4gPiA+
IA0KPiA+IA0KPiA+IEkgYWdyZWUsIGlmIG5vIGRpZmZlcmVuY2VzIGJldHdlZW4gdGhlIHR3byBj
aGlwcyBhcmUga25vd24sIGFkZGluZyBhDQo+ID4gYmluZGluZyB3aXRoZSBuZXcgY29tcGF0aWJs
ZSBhbmQgYSBmYWxsYmFjayBpcyBhIGdvb2QgdGhpbmcuIElmIHdlDQo+ID4gbGF0ZXIgb24gcmVh
bGl6ZSB0aGF0IG10ODE5NSBQQ0kgYmxvY2sgaGFzIGRpZmZlcmVuY2VzLCB3ZSBjYW4gYWRkIHRo
ZQ0KPiA+IG1hdGNoaW5nIHRvIHRoZSBkcml2ZXIuDQo+IA0KPiBTbyB0aGlzIHNlcmllcyBjYW4g
YmUgZHJvcHBlZCwgcmlnaHQgPw0KDQpZZXMsIHdlIHdpbGwgc2VuZCBkdC1iaW5kaW5ncyB3aXRo
IGR0cyBjaGFuZ2VzIGluIGFub3RoZXIgc2VyaWVzLA0KdGhhbmtzLg0KPiANCj4gVGhhbmtzLA0K
PiBMb3JlbnpvDQo+IA0KPiA+IFJlZ2FyZHMsDQo+ID4gTWF0dGhpYXMNCj4gPiANCj4gPiA+IA0K
PiA+ID4gUmVnYXJkcw0KPiA+ID4gQ2hlbll1DQo+ID4gPiANCj4gPiA+IA0KPiA+ID4+IFRoYW5r
cy4NCj4gPiA+Pj4NCj4gPiA+Pj4NCj4gPiA+Pj4gVGhhbmtzDQo+ID4gPj4+IENoZW5ZdQ0KPiA+
ID4+Pg0KPiA+ID4+Pg0KPiA+ID4+Pj4gU2lnbmVkLW9mZi1ieTogSmlhbmp1biBXYW5nIDxqaWFu
anVuLndhbmdAbWVkaWF0ZWsuY29tPg0KPiA+ID4+Pj4gLS0tDQo+ID4gPj4+PiAgRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9tZWRpYXRlay1wY2llLWdlbjMueWFtbCB8IDQg
KysrLQ0KPiA+ID4+Pj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRp
b24oLSkNCj4gPiA+Pj4+DQo+ID4gPj4+PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL3BjaS9tZWRpYXRlay1wY2llLWdlbjMueWFtbCBiL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvbWVkaWF0ZWstcGNpZS1nZW4zLnlhbWwNCj4gPiA+
Pj4+IGluZGV4IGU3YjFmOTg5MmRhNC4uZDVlNGEzZTYzZDk3IDEwMDY0NA0KPiA+ID4+Pj4gLS0t
IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9tZWRpYXRlay1wY2llLWdl
bjMueWFtbA0KPiA+ID4+Pj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L3BjaS9tZWRpYXRlay1wY2llLWdlbjMueWFtbA0KPiA+ID4+Pj4gQEAgLTQ4LDcgKzQ4LDkgQEAg
YWxsT2Y6DQo+ID4gPj4+Pg0KPiA+ID4+Pj4gIHByb3BlcnRpZXM6DQo+ID4gPj4+PiAgICBjb21w
YXRpYmxlOg0KPiA+ID4+Pj4gLSAgICBjb25zdDogbWVkaWF0ZWssbXQ4MTkyLXBjaWUNCj4gPiA+
Pj4+ICsgICAgb25lT2Y6DQo+ID4gPj4+PiArICAgICAgLSBjb25zdDogbWVkaWF0ZWssbXQ4MTky
LXBjaWUNCj4gPiA+Pj4+ICsgICAgICAtIGNvbnN0OiBtZWRpYXRlayxtdDgxOTUtcGNpZQ0KPiA+
ID4+Pj4NCj4gPiA+Pj4+ICAgIHJlZzoNCj4gPiA+Pj4+ICAgICAgbWF4SXRlbXM6IDENCj4gPiA+
Pj4+IC0tDQo+ID4gPj4+PiAyLjE4LjANCj4gPiA+Pj4+IF9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fDQo+ID4gPj4+PiBMaW51eC1tZWRpYXRlayBtYWlsaW5n
IGxpc3QNCj4gPiA+Pj4+IExpbnV4LW1lZGlhdGVrQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gPiA+
Pj4+IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbWVk
aWF0ZWsNCj4gPiA+Pg0KDQo=

