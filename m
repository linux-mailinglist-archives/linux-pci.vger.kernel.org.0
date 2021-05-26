Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6C4391179
	for <lists+linux-pci@lfdr.de>; Wed, 26 May 2021 09:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232975AbhEZHqT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 May 2021 03:46:19 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:19153 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232617AbhEZHqT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 May 2021 03:46:19 -0400
X-UUID: b1893dfb59e64b41aa1cf71a7b9f6fa6-20210526
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=rhis7ZdFLWANZ7b2DBYk1HWn5k7BbGfIhqdHKsjdI6c=;
        b=i/t8UBBc5C2q4VCptCrrBxH1Q9wSJzuJfy55+XzthiGljpfe9EEBAoWyLQILmGUSrkZVWD4bbLO143bMCyVHElwGA9pKBKtiH+CFOtASIKENwIi3j7o0id5dRSW/Fyjnk4NfR0Y+PpYrTOgiNavtnIvjs1CHpktYXZmDwHW4N2o=;
X-UUID: b1893dfb59e64b41aa1cf71a7b9f6fa6-20210526
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1411923585; Wed, 26 May 2021 15:44:41 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 26 May
 2021 15:44:35 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 26 May 2021 15:44:34 +0800
Message-ID: <1622015074.22554.7.camel@mhfsdcap03>
Subject: Re: [PATCH 2/2] PCI: mediatek-gen3: Add support for disable dvfsrc
 voltage request
From:   Jianjun Wang <jianjun.wang@mediatek.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Ryder Lee <ryder.lee@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <youlin.pei@mediatek.com>,
        <chuanjia.liu@mediatek.com>, <qizhong.cheng@mediatek.com>,
        <sin_jieyang@mediatek.com>, <drinkcat@chromium.org>,
        <Rex-BC.Chen@mediatek.com>, Krzysztof Wilczyski <kw@linux.com>,
        <Ryan-JH.Yu@mediatek.com>
Date:   Wed, 26 May 2021 15:44:34 +0800
In-Reply-To: <20210514065927.20774-3-jianjun.wang@mediatek.com>
References: <20210514065927.20774-1-jianjun.wang@mediatek.com>
         <20210514065927.20774-3-jianjun.wang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: AA820A6B0B6D8B6EB8E0F75C994FDD6EAA37103BB9F953B2506EA02435B992782000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgQmpvcm4sIFJvYiwgTG9yZW56bywNCg0KQ291bGQgeW91IHBsZWFzZSBoZWxwIHRvIHRha2Ug
YSBsb29rIGF0IHRoaXMgcGF0Y2gsIEknbSBub3Qgc3VyZSBpZiB0aGlzDQppcyBhIGdvb2Qgc29s
dXRpb24sIGFuZCBJIHJlYWxseSBuZWVkIHlvdXIgc3VnZ2VzdGlvbnMuDQoNClRoYW5rcy4NCg0K
T24gRnJpLCAyMDIxLTA1LTE0IGF0IDE0OjU5ICswODAwLCBKaWFuanVuIFdhbmcgd3JvdGU6DQo+
IFBDSWUgR2VuMyBQSFkgbGF5ZXIgY2Fubm90IHdvcmsgcHJvcGVybHkgd2hlbiB0aGUgcmVxdWVz
dGVkIHZvbHRhZ2UNCj4gaXMgbG93ZXIgdGhhbiBhIHNwZWNpZmljIGxldmVsKGUuZy4gMC41NVYs
IGl0J3MgZGVwZW5kcyBvbg0KPiB0aGUgY2hpcCBtYW51ZmFjdHVyaW5nIHByb2Nlc3MpLg0KPiAN
Cj4gV2hlbiB0aGUgZHZmc3JjIGZlYXR1cmUgaXMgaW1wbGVtZW50ZWQsIHRoZSByZXF1ZXN0ZWQg
dm9sdGFnZQ0KPiBtYXkgYmUgcmVkdWNlZCB0byBhIGxvd2VyIGxldmVsIGluIHN1c3BlbmQgbW9k
ZSwgaGVuY2UgdGhhdA0KPiB0aGUgTUFDIGxheWVyIHdpbGwgYXNzZXJ0IGEgSFcgc2lnbmFsIHRv
IHJlcXVlc3QgdGhlIGR2ZnNyYw0KPiB0byByYWlzZSB2b2x0YWdlIHRvIG5vcm1hbCBtb2RlLCBh
bmQgaXQgd2lsbCB3YWl0IHRoZSB2b2x0YWdlDQo+IHJlYWR5IHNpZ25hbCB3aGljaCBpcyBkZXJp
dmVkIGZyb20gZHZmc3JjIHRvIGRldGVybWluZSB3aGV0aGVyDQo+IHRoZSBMVFNTTSBjYW4gc3Rh
cnQgbm9ybWFsbHkuDQo+IA0KPiBXaGVuIHRoZSBkdmZzcmMgZmVhdHVyZSBpcyBub3QgaW1wbGVt
ZW50ZWQsIHRoZSBNQUMgbGF5ZXIgc3RpbGwNCj4gYXNzZXJ0IHRoZSB2b2x0YWdlIHJlcXVlc3Qg
dG8gZHZmc3JjIHdoZW4gZXhpdCBzdXNwZW5kIG1vZGUsDQo+IGJ1dCB3aWxsIG5vdCByZWNlaXZl
IHRoZSB2b2x0YWdlIHJlYWR5IHNpZ25hbCwgaW4gdGhpcyBjYXNlLA0KPiB0aGUgTFRTU00gY2Fu
bm90IHN0YXJ0IG5vcm1hbGx5LCBhbmQgdGhlIFBDSWUgbGluayB3aWxsIGJlIGZhaWxlZC4NCj4g
DQo+IEFkZCBzdXBwb3J0IGZvciBkaXNhYmxlIGR2ZnNyYyB2b2x0YWdlIHJlcXVlc3QuIElmIHRo
ZSBwcm9wZXJ0eSBvZg0KPiAiZGlzYWJsZS1kdmZzcmMtdmx0LXJlcSIgaXMgcHJlc2VudGVkIGlu
IGRldmljZSBub2RlLCB3ZSBhc3N1bWUgdGhhdA0KPiB0aGUgcmVxdWVzdGVkIHZvbHRhZ2UgaXMg
YWx3YXlzIGhpZ2hlciBlbm91Z2ggdG8ga2VlcCB0aGUgUENJZSBHZW4zDQo+IFBIWSBhY3RpdmUs
IGFuZCB0aGUgdm9sdGFnZSByZXF1ZXN0IHRvIGR2ZnNyYyBzaG91bGQgYmUgZGlzYWJsZWQuDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBKaWFuanVuIFdhbmcgPGppYW5qdW4ud2FuZ0BtZWRpYXRlay5j
b20+DQo+IC0tLQ0KPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLW1lZGlhdGVrLWdlbjMu
YyB8IDMyICsrKysrKysrKysrKysrKysrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDMyIGluc2Vy
dGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUt
bWVkaWF0ZWstZ2VuMy5jIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLW1lZGlhdGVrLWdl
bjMuYw0KPiBpbmRleCAyMDE2NWU0YTc1YjIuLmQxODY0MzAzMjE3ZSAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLW1lZGlhdGVrLWdlbjMuYw0KPiArKysgYi9kcml2
ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtbWVkaWF0ZWstZ2VuMy5jDQo+IEBAIC02OCw2ICs2OCw5
IEBADQo+ICAjZGVmaW5lIFBDSUVfTVNJX1NFVF9FTkFCTEVfUkVHCQkweDE5MA0KPiAgI2RlZmlu
ZSBQQ0lFX01TSV9TRVRfRU5BQkxFCQlHRU5NQVNLKFBDSUVfTVNJX1NFVF9OVU0gLSAxLCAwKQ0K
PiAgDQo+ICsjZGVmaW5lIFBDSUVfTUlTQ19DVFJMX1JFRwkJMHgzNDgNCj4gKyNkZWZpbmUgUENJ
RV9ESVNBQkxFX0RWRlNSQ19WTFRfUkVRCUJJVCgxKQ0KPiArDQo+ICAjZGVmaW5lIFBDSUVfTVNJ
X1NFVF9CQVNFX1JFRwkJMHhjMDANCj4gICNkZWZpbmUgUENJRV9NU0lfU0VUX09GRlNFVAkJMHgx
MA0KPiAgI2RlZmluZSBQQ0lFX01TSV9TRVRfU1RBVFVTX09GRlNFVAkweDA0DQo+IEBAIC0yOTcs
NiArMzAwLDM1IEBAIHN0YXRpYyBpbnQgbXRrX3BjaWVfc3RhcnR1cF9wb3J0KHN0cnVjdCBtdGtf
cGNpZV9wb3J0ICpwb3J0KQ0KPiAgCXZhbCAmPSB+UENJRV9JTlRYX0VOQUJMRTsNCj4gIAl3cml0
ZWxfcmVsYXhlZCh2YWwsIHBvcnQtPmJhc2UgKyBQQ0lFX0lOVF9FTkFCTEVfUkVHKTsNCj4gIA0K
PiArCS8qDQo+ICsJICogUENJZSBHZW4zIFBIWSBsYXllciBjYW4gbm90IHdvcmsgcHJvcGVybHkg
d2hlbiB0aGUgcmVxdWVzdGVkIHZvbHRhZ2UNCj4gKwkgKiBpcyBsb3dlciB0aGFuIGEgc3BlY2lm
aWMgbGV2ZWwoZS5nLiAwLjU1ViwgaXQncyBkZXBlbmRzIG9uDQo+ICsJICogdGhlIGNoaXAgbWFu
dWZhY3R1cmluZyBwcm9jZXNzKS4NCj4gKwkgKg0KPiArCSAqIFdoZW4gdGhlIGR2ZnNyYyBmZWF0
dXJlIGlzIGltcGxlbWVudGVkLCB0aGUgcmVxdWVzdGVkIHZvbHRhZ2UNCj4gKwkgKiBtYXkgYmUg
cmVkdWNlZCB0byBhIGxvd2VyIGxldmVsIGluIHN1c3BlbmQgbW9kZSwgaGVuY2UgdGhhdA0KPiAr
CSAqIHRoZSBNQUMgbGF5ZXIgd2lsbCBhc3NlcnQgYSBIVyBzaWduYWwgdG8gcmVxdWVzdCB0aGUg
ZHZmc3JjDQo+ICsJICogdG8gcmFpc2Ugdm9sdGFnZSB0byBub3JtYWwgbW9kZSwgYW5kIGl0IHdp
bGwgd2FpdCB0aGUgdm9sdGFnZQ0KPiArCSAqIHJlYWR5IHNpZ25hbCB3aGljaCBpcyBkZXJpdmVk
IGZyb20gZHZmc3JjIHRvIGRldGVybWluZSB3aGV0aGVyDQo+ICsJICogdGhlIExUU1NNIGNhbiBz
dGFydCBub3JtYWxseS4NCj4gKwkgKg0KPiArCSAqIFdoZW4gdGhlIGR2ZnNyYyBmZWF0dXJlIGlz
IG5vdCBpbXBsZW1lbnRlZCwgdGhlIE1BQyBsYXllciBzdGlsbA0KPiArCSAqIGFzc2VydCB0aGUg
dm9sdGFnZSByZXF1ZXN0IHRvIGR2ZnNyYyB3aGVuIGV4aXQgc3VzcGVuZCBtb2RlLA0KPiArCSAq
IGJ1dCB3aWxsIG5vdCByZWNlaXZlIHRoZSB2b2x0YWdlIHJlYWR5IHNpZ25hbCwgaW4gdGhpcyBj
YXNlLA0KPiArCSAqIHRoZSBMVFNTTSBjYW5ub3Qgc3RhcnQgbm9ybWFsbHksIGFuZCB0aGUgUENJ
ZSBsaW5rIHdpbGwgYmUgZmFpbGVkLg0KPiArCSAqDQo+ICsJICogSWYgdGhlIHByb3BlcnR5IG9m
ICJkaXNhYmxlLWR2ZnNyYy12bHQtcmVxIiBpcyBwcmVzZW50ZWQNCj4gKwkgKiBpbiBkZXZpY2Ug
bm9kZSwgd2UgYXNzdW1lIHRoYXQgdGhlIHJlcXVlc3RlZCB2b2x0YWdlIGlzIGFsd2F5cw0KPiAr
CSAqIGhpZ2hlciBlbm91Z2ggdG8ga2VlcCB0aGUgUENJZSBHZW4zIFBIWSBhY3RpdmUsIGFuZCB0
aGUgdm9sdGFnZQ0KPiArCSAqIHJlcXVlc3QgdG8gZHZmc3JjIHNob3VsZCBiZSBkaXNhYmxlZC4N
Cj4gKwkgKi8NCj4gKwl2YWwgPSByZWFkbF9yZWxheGVkKHBvcnQtPmJhc2UgKyBQQ0lFX01JU0Nf
Q1RSTF9SRUcpOw0KPiArCXZhbCAmPSB+UENJRV9ESVNBQkxFX0RWRlNSQ19WTFRfUkVROw0KPiAr
CWlmIChvZl9wcm9wZXJ0eV9yZWFkX2Jvb2wocG9ydC0+ZGV2LT5vZl9ub2RlLCAiZGlzYWJsZS1k
dmZzcmMtdmx0LXJlcSIpKQ0KPiArCQl2YWwgfD0gUENJRV9ESVNBQkxFX0RWRlNSQ19WTFRfUkVR
Ow0KPiArDQo+ICsJd3JpdGVsKHZhbCwgcG9ydC0+YmFzZSArIFBDSUVfTUlTQ19DVFJMX1JFRyk7
DQo+ICsNCj4gIAkvKiBBc3NlcnQgYWxsIHJlc2V0IHNpZ25hbHMgKi8NCj4gIAl2YWwgPSByZWFk
bF9yZWxheGVkKHBvcnQtPmJhc2UgKyBQQ0lFX1JTVF9DVFJMX1JFRyk7DQo+ICAJdmFsIHw9IFBD
SUVfTUFDX1JTVEIgfCBQQ0lFX1BIWV9SU1RCIHwgUENJRV9CUkdfUlNUQiB8IFBDSUVfUEVfUlNU
QjsNCg0K

