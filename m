Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3BD336F31
	for <lists+linux-pci@lfdr.de>; Thu, 11 Mar 2021 10:48:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbhCKJsH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Mar 2021 04:48:07 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:22066 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232078AbhCKJr5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Mar 2021 04:47:57 -0500
X-UUID: e815e2896fb546e58ba5ab0c1064d138-20210311
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=RNnASkbqhv8ODVj5ReFqDIzkkJKHV9MWUz02H5UDhV0=;
        b=QjgGCaYJOe1peZaZHiPDwcpAnJBubRkweCWEdGJ9NgJ8lRVB5LT7LycrhEQAAPUGyBT2mbKBfj5TEhjK+4bB6UxGkqSLu+DwzbNevXw0qoyf++g2qtBGhqRjNXxHGtJAfLNjfwPT74zjobpBqb8UulW40I4gkuL/MTgvxehrr4Q=;
X-UUID: e815e2896fb546e58ba5ab0c1064d138-20210311
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 757726739; Thu, 11 Mar 2021 17:47:48 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 11 Mar
 2021 17:47:46 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 11 Mar 2021 17:47:45 +0800
Message-ID: <1615456065.25662.60.camel@mhfsdcap03>
Subject: Re: [v8,5/7] PCI: mediatek-gen3: Add MSI support
From:   Jianjun Wang <jianjun.wang@mediatek.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "Sj Huang" <sj.huang@mediatek.com>, <youlin.pei@mediatek.com>,
        <chuanjia.liu@mediatek.com>, <qizhong.cheng@mediatek.com>,
        <sin_jieyang@mediatek.com>, <drinkcat@chromium.org>,
        <Rex-BC.Chen@mediatek.com>, <anson.chuang@mediatek.com>
Date:   Thu, 11 Mar 2021 17:47:45 +0800
In-Reply-To: <87a6rbxs4w.wl-maz@kernel.org>
References: <20210224061132.26526-1-jianjun.wang@mediatek.com>
         <20210224061132.26526-6-jianjun.wang@mediatek.com>
         <87pn08y3ja.wl-maz@kernel.org> <1615358929.25662.47.camel@mhfsdcap03>
         <87a6rbxs4w.wl-maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 75906D7FE3E9CB7C6B4B63E7D7430F2D0076DFB9B07E89AAFCC25501E7DC0BD72000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gV2VkLCAyMDIxLTAzLTEwIGF0IDA5OjQxICswMDAwLCBNYXJjIFp5bmdpZXIgd3JvdGU6DQo+
IE9uIFdlZCwgMTAgTWFyIDIwMjEgMDY6NDg6NDkgKzAwMDAsDQo+IEppYW5qdW4gV2FuZyA8amlh
bmp1bi53YW5nQG1lZGlhdGVrLmNvbT4gd3JvdGU6DQo+ID4gPiA+ICtzdGF0aWMgc3RydWN0IGly
cV9jaGlwIG10a19tc2lfaXJxX2NoaXAgPSB7DQo+ID4gPiA+ICsJLm5hbWUgPSAiTVNJIiwNCj4g
PiA+ID4gKwkuaXJxX2VuYWJsZSA9IG10a19wY2llX2lycV91bm1hc2ssDQo+ID4gPiA+ICsJLmly
cV9kaXNhYmxlID0gbXRrX3BjaWVfaXJxX21hc2ssDQo+ID4gPiANCj4gPiA+IFNhbWUgY29tbWVu
dCBhcyBmb3IgdGhlIHByZXZpb3VzIHBhdGNoOiBlbmFibGUvZGlzYWJsZSBzZXJ2ZSBubw0KPiA+
ID4gcHVycG9zZSBoZXJlLg0KPiA+IA0KPiA+IFJlcGxpZWQgaW4gdGhlIHByZXZpb3VzIHBhdGNo
LCB0aGUgZW5hYmxlL2Rpc2FibGUgY2FsbGJhY2sgaXMgdXNlZCB3aGVuDQo+ID4gdGhlIHN5c3Rl
bSBzdXNwZW5kL3Jlc3VtZS4NCj4gDQo+IEFzIEkgc2FpZCwgeW91ciBzdXNwZW5kL3Jlc3VtZSBz
aG91bGQgYmUgc2VsZiBjb250YWluZWQsIGFuZCBub3QgcmVseQ0KPiBvbiB0aGUgaXJxIHN1YnN5
c3RlbSB0byByZXN0b3JlIGEgdmlhYmxlIHN0YXRlLg0KDQpPSywgSSB3aWxsIHRyeSB0byBmaW5k
IGFub3RoZXIgd2F5IHRvIHNhdmUgYW5kIHJlc3RvcmUgdGhlIGVuYWJsZWQgc3RhdGUNCm9mIGlu
dGVycnVwdHMgd2hlbiB0aGUgc3lzdGVtIHN1c3BlbmQvcmVzdW1lLg0KDQo+IA0KPiBbLi4uXQ0K
PiANCj4gPiA+ID4gQEAgLTQwOCw2ICs2NzcsMTQgQEAgc3RhdGljIHZvaWQgbXRrX3BjaWVfaXJx
X2hhbmRsZXIoc3RydWN0IGlycV9kZXNjICpkZXNjKQ0KPiA+ID4gPiAgCQlnZW5lcmljX2hhbmRs
ZV9pcnEodmlycSk7DQo+ID4gPiA+ICAJfQ0KPiA+ID4gPiAgDQo+ID4gPiA+ICsJaXJxX2JpdCA9
IFBDSUVfTVNJX1NISUZUOw0KPiA+ID4gPiArCWZvcl9lYWNoX3NldF9iaXRfZnJvbShpcnFfYml0
LCAmc3RhdHVzLCBQQ0lFX01TSV9TRVRfTlVNICsNCj4gPiA+ID4gKwkJCSAgICAgIFBDSUVfTVNJ
X1NISUZUKSB7DQo+ID4gPiA+ICsJCW10a19wY2llX21zaV9oYW5kbGVyKHBvcnQsIGlycV9iaXQg
LSBQQ0lFX01TSV9TSElGVCk7DQo+ID4gPiA+ICsNCj4gPiA+ID4gKwkJd3JpdGVsX3JlbGF4ZWQo
QklUKGlycV9iaXQpLCBwb3J0LT5iYXNlICsgUENJRV9JTlRfU1RBVFVTX1JFRyk7DQo+ID4gPiAN
Cj4gPiA+IElzbid0IHRoaXMgd3JpdGUgdGhlIHNhbWUgdGhpbmcgeW91IGhhdmUgZm9yIEVPSSBp
biB0aGUgSU5UeCBjYXNlPw0KPiA+ID4gV2hpbGUgSSBjb3VsZCB1bmRlcnN0YW5kIHlvdXIgZGVz
Y3JpcHRpb24gaW4gdGhhdCBjYXNlICh0aGlzIGlzIGENCj4gPiA+IHJlc2FtcGxpbmcgb3BlcmF0
aW9uKSwgSSBkb24ndCBnZXQgd2hhdCB0aGlzIGRvZXMgaGVyZS4gRWl0aGVyIHRoaXMgaXMNCj4g
PiA+IGFsc28gYW4gRU9JLCBidXQgeW91ciBpbml0aWFsIGRlc2NyaXB0aW9uIGRvZXNuJ3QgbWFr
ZSBzZW5zZSwgb3IgaXQgaXMNCj4gPiA+IGFuIEFjaywgYW5kIGl0IHNob3VsZCBiZSBtb3ZlZCB0
byB0aGUgcmlnaHQgcGxhY2UuDQo+ID4gPiANCj4gPiA+IFdoaWNoIG9uZSBpcyBpdD8NCj4gPiAN
Cj4gPiBJIHRoaW5rIGl0IHNob3VsZCBiZSBhbiBFT0kgd2hpY2ggdXNlZCB0byBjbGVhciB0aGUg
aW50ZXJydXB0IHN0YXR1cyBvZg0KPiA+IGEgc2luZ2xlIHNldCBpbiB0aGUgUENJZSBpbnRjIGZp
ZWxkLCBtYXliZSBJIHNob3VsZCBtb3ZlIGl0IHRvIHRoZSBlbmQNCj4gPiBvZiB0aGUgbXRrX3Bj
aWVfbXNpX2hhbmRsZXIoKSBmdW5jdGlvbi4NCj4gDQo+IEkgZG91YnQgdGhpcyBpcyBhbiBFT0ku
IElmLCBhcyBJIHN1c3BlY3QsIGl0IGluc3RydWN0cyB0aGUgSFcgdG8gY2xlYXINCj4gdGhlIGJp
dCBzbyB0aGF0IG5ldyBwZW5kaW5nIGJpdHMgY2FuIGJlIHJlY29yZGVkLCBpdCBtdXN0IHRha2Ug
cGxhY2UNCj4gKmJlZm9yZSogdGhlIGludGVycnVwdCBpcyBoYW5kbGVkLCBvciB5b3UgbWF5IGxv
c2UgTVNJcyBpbiB0aGUNCj4gaW50ZXJ2YWwgYmV0d2VlbiB0aGUgaGFuZGxpbmcgb2YgdGhlIGlu
dGVycnVwdCBhbmQgdGhlIGNsZWFyaW5nIG9mIHRoZQ0KPiBwZW5kaW5nIGJpdC4gVG8gc2F0aXNm
eSB0aGlzIHJlcXVpcmVtZW50LCB0aGlzIHNob3VsZCBiZSBhbiBBQ0ssIHdoaWNoDQo+IGlzIGNv
bnNpc3RlbnQgd2l0aCB0aGUgd2F5IG1vc3QgTVNJIGNvbnRyb2xsZXJzIHN1Y2ggYXMgdGhpcyBv
bmUgd29yay4NCg0KVGhlc2UgYml0cyBhcmUgc2ltaWxhciB3aXRoIHRoZSBpbnRlcnJ1cHQgc3Rh
dHVzIG9mIElOVHgsIGFuZCB0aGUNCmludGVycnVwdCBzdGF0dXMgd2lsbCByZW1haW4gdW50aWwg
YWxsIHRoZSBzdGF0dXMgb2YgdGhlIGNvcnJlc3BvbmRpbmcNCnNldCBhcmUgY2xlYXJlZC4gVGhl
cmUgaXMgYSB3aGlsZSBsb29wIGluIG10a19wY2llX21zaV9oYW5kbGVyKCkgd2hpY2gNCmlzIHVz
ZWQgdG8gY29udGludW91c2x5IHBvbGxpbmcgYW5kIEFDSyB0aGUgc3RhdHVzIG9mIHRoZSBNU0kg
c2V0LCBJDQp0aGluayB0aGUgTVNJIG1heSBub3QgYmUgbG9zZSBpbiB0aGlzIGNhc2UuDQogDQo+
IA0KPiA+IA0KPiA+ICAgICAgICAgICAgICAgICAgICstLS0tLSsNCj4gPiAgICAgICAgICAgICAg
ICAgICB8IEdJQyB8DQo+ID4gICAgICAgICAgICAgICAgICAgKy0tLS0tKw0KPiA+ICAgICAgICAg
ICAgICAgICAgICAgIF4NCj4gPiAgICAgICAgICAgICAgICAgICAgICB8DQo+ID4gICAgICAgICAg
ICAgICAgICBwb3J0LT5pcnENCj4gPiAgICAgICAgICAgICAgICAgICAgICB8DQo+ID4gICAgICAg
ICAgICAgICstKy0rLSstKy0rLSstKy0rDQo+ID4gICAgICAgICAgICAgIHwwfDF8MnwzfDR8NXw2
fDd8IChQQ0llIGludGMpDQo+ID4gICAgICAgICAgICAgICstKy0rLSstKy0rLSstKy0rDQo+ID4g
ICAgICAgICAgICAgICBeIF4gICAgICAgICAgIF4NCj4gPiAgICAgICAgICAgICAgIHwgfCAgICAu
Li4gICAgfA0KPiA+ICAgICAgICstLS0tLS0tKyArLS0tLS0tKyAgICArLS0tLS0tLS0tLS0rDQo+
ID4gICAgICAgfCAgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgIHwNCj4gPiArLSstKy0t
LSstLSstLSsgICstKy0rLS0tKy0tKy0tKyAgKy0rLSstLS0rLS0rLS0rDQo+ID4gfDB8MXwuLi58
MzB8MzF8ICB8MHwxfC4uLnwzMHwzMXwgIHwwfDF8Li4ufDMwfDMxfCAoTVNJIHNldHMpDQo+ID4g
Ky0rLSstLS0rLS0rLS0rICArLSstKy0tLSstLSstLSsgICstKy0rLS0tKy0tKy0tKw0KPiA+ICBe
IF4gICAgICBeICBeICAgIF4gXiAgICAgIF4gIF4gICAgXiBeICAgICAgXiAgXg0KPiA+ICB8IHwg
ICAgICB8ICB8ICAgIHwgfCAgICAgIHwgIHwgICAgfCB8ICAgICAgfCAgfCAgKE1TSSB2ZWN0b3Jz
KQ0KPiA+ICB8IHwgICAgICB8ICB8ICAgIHwgfCAgICAgIHwgIHwgICAgfCB8ICAgICAgfCAgfA0K
PiA+IA0KPiA+ICAgKE1TSSBTRVQwKSAgICAgICAoTVNJIFNFVDEpICAuLi4gICAoTVNJIFNFVDcp
DQo+ID4gDQo+ID4gSSB3b3VsZCBsaWtlIHRvIGFzayBhbm90aGVyIHF1ZXN0aW9uLiBJbiB0aGlz
IGludGVycnVwdCBhcmNoaXRlY3R1cmUsIHdlDQo+ID4gY2Fubm90IGltcGxlbWVudCBhbiBhZmZp
bml0eSBmb3IgUENJZSBpbnRlcnJ1cHRzLCBzbyB3ZSByZXR1cm4gYQ0KPiA+IG5lZ2F0aXZlIHZh
bHVlIGluIHRoZSBtdGtfcGNpZV9zZXRfYWZmaW5pdHkgY2FsbGJhY2sgYXMgZm9sbG93czogDQo+
ID4gDQo+ID4gK3N0YXRpYyBpbnQgbXRrX3BjaWVfc2V0X2FmZmluaXR5KHN0cnVjdCBpcnFfZGF0
YSAqZGF0YSwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25zdCBzdHJ1
Y3QgY3B1bWFzayAqbWFzaywgYm9vbCBmb3JjZSkNCj4gPiArew0KPiA+ICsgICAgICAgcmV0dXJu
IC1FSU5WQUw7DQo+ID4gK30NCj4gPiANCj4gPiBCdXQgdGhlcmUgd2lsbCBhbHdheXMgYmUgZXJy
b3IgbG9ncyB3aGVuIGhvdHBsdWcgYSBDUFU6DQo+ID4gDQo+ID4gfiAjIGVjaG8gMCA+IC9zeXMv
ZGV2aWNlcy9zeXN0ZW0vY3B1L2NwdTEvb25saW5lDQo+ID4gWyAgIDkzLjYzMzA1OV0gSVJRMjU1
OiBzZXQgYWZmaW5pdHkgZmFpbGVkKC0yMikuDQo+ID4gWyAgIDkzLjYzMzYyNF0gSVJRMjU2OiBz
ZXQgYWZmaW5pdHkgZmFpbGVkKC0yMikuDQo+ID4gWyAgIDkzLjYzNDIyMl0gQ1BVMTogc2h1dGRv
d24NCj4gPiBbICAgOTMuNjM0NTg2XSBwc2NpOiBDUFUxIGtpbGxlZCAocG9sbGVkIDAgbXMpDQo+
ID4gDQo+ID4gT3Igd2hlbiB0aGUgc3lzdGVtIHN1c3BlbmRzOg0KPiA+IA0KPiA+IH4gIyBlY2hv
IG1lbSA+IC9zeXMvcG93ZXIvc3RhdGUNCj4gPiBbICAgOTMuNjM1MTQ1XSBjcHVocDogY3B1X29m
ZiBjbHVzdGVyPTAsIGNwdT0xDQo+ID4gWyAgMTY5LjgzNTY1M10gUE06IHN1c3BlbmQgZW50cnkg
KGRlZXApDQo+ID4gWyAgMTY5LjgzNjcxN10gRmlsZXN5c3RlbXMgc3luYzogMC4wMDAgc2Vjb25k
cw0KPiA+IFsgIDE2OS44Mzc5MjRdIEZyZWV6aW5nIHVzZXIgc3BhY2UgcHJvY2Vzc2VzIC4uLiAo
ZWxhcHNlZCAwLjAwMSBzZWNvbmRzKQ0KPiA+IGRvbmUuDQo+ID4gWyAgMTY5LjgzOTkyMl0gT09N
IGtpbGxlciBkaXNhYmxlZC4NCj4gPiBbICAxNjkuODQwMzM2XSBGcmVlemluZyByZW1haW5pbmcg
ZnJlZXphYmxlIHRhc2tzIC4uLiAoZWxhcHNlZCAwLjAwMQ0KPiA+IHNlY29uZHMpIGRvbmUuDQo+
ID4gWyAgMTY5Ljg0NDcxNV0gRGlzYWJsaW5nIG5vbi1ib290IENQVXMgLi4uDQo+ID4gWyAgMTY5
Ljg0NjQ0M10gSVJRMjU1OiBzZXQgYWZmaW5pdHkgZmFpbGVkKC0yMikuDQo+ID4gWyAgMTY5Ljg0
NzAwMl0gSVJRMjU2OiBzZXQgYWZmaW5pdHkgZmFpbGVkKC0yMikuDQo+ID4gWyAgMTY5Ljg0NzU4
Nl0gQ1BVMjogc2h1dGRvd24NCj4gPiBbICAxNjkuODQ3OTQzXSBwc2NpOiBDUFUyIGtpbGxlZCAo
cG9sbGVkIDAgbXMpDQo+ID4gWyAgMTY5Ljg0ODQ4OV0gY3B1aHA6IGNwdV9vZmYgY2x1c3Rlcj0w
LCBjcHU9Mg0KPiA+IFsgIDE2OS44NTAyODVdIElSUTI1NTogc2V0IGFmZmluaXR5IGZhaWxlZCgt
MjIpLg0KPiA+IFsgIDE2OS44NTEzNjldIElSUTI1Njogc2V0IGFmZmluaXR5IGZhaWxlZCgtMjIp
Lg0KPiA+IC4uLg0KPiA+IA0KPiA+IFNvbWV0aW1lcyB0aGlzIGNhbiBjYXVzZSBtaXN1bmRlcnN0
YW5kaW5ncyB0byB1c2VycywgZG8gd2UgaGF2ZSBhIGNoYW5jZQ0KPiA+IHRvIHByZXZlbnQgdGhp
cyBlcnJvciBsb2c/DQo+IA0KPiBOby4gVGhpcyBIVyBkb2Vzbid0IGFsbG93IE1TSXMgdG8gYmUg
aW5kaXZpZHVhbGx5IHJldGFyZ2V0ZWQsIGFuZCB0aGUNCj4ga2VybmVsIGlzbid0IGhhcHB5IGFi
b3V0IHRoYXQuIFRoYXQncyBvbmUgb2YgdGhlIG1hbnkgcmVhc29ucyB3aHkNCj4gaGlkaW5nIE1T
SXMgYmVoaW5kIGEgbXV4IChvciB0d28gaW4geW91ciBjYXNlKSBpcyBhICp2ZXJ5IGJhZCBpZGVh
Ki4NCj4gDQo+IFRoYW5rcywNCj4gDQo+IAlNLg0KPiANCg0K

