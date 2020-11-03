Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 092C42A3C26
	for <lists+linux-pci@lfdr.de>; Tue,  3 Nov 2020 06:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725980AbgKCFoV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Nov 2020 00:44:21 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:35743 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725934AbgKCFoU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Nov 2020 00:44:20 -0500
X-UUID: 34e9a2dc190c4cc9a81bb458581c45da-20201103
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=z9k3swHPOBws0A9zWk40FtkS7hwYp0UsWwC4lqhKB/E=;
        b=cuzDLsLkMj32LUTruhLS3GF+ZVsgKlsGn+iz4ZWmaut+0mEYCqnakFLTgOQ7ddHrU3E+29P0vASH2reWmOnZMfWEoz8IeQxYqOQWvix1bYbrjqcoc2u5GVYAkvJdFD9znr/Te/V+DiKaRIgC5XjaZ89kXZaDa+eFlTscL3RWCfY=;
X-UUID: 34e9a2dc190c4cc9a81bb458581c45da-20201103
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2109648111; Tue, 03 Nov 2020 13:44:13 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 3 Nov
 2020 13:44:03 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 3 Nov 2020 13:44:02 +0800
Message-ID: <1604382242.2521.62.camel@mhfsdcap03>
Subject: Re: [v3,2/3] PCI: mediatek: Add new generation controller support
From:   Jianjun Wang <jianjun.wang@mediatek.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        <davem@davemloft.net>, <linux-pci@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Sj Huang <sj.huang@mediatek.com>, <youlin.pei@mediatek.com>,
        <chuanjia.liu@mediatek.com>, <qizhong.cheng@mediatek.com>,
        <sin_jieyang@mediatek.com>
Date:   Tue, 3 Nov 2020 13:44:02 +0800
In-Reply-To: <aaccd827fa6de117d27319884f2d70a2ea91aa5e.camel@pengutronix.de>
References: <20200927074555.4155-1-jianjun.wang@mediatek.com>
         <20200927074555.4155-3-jianjun.wang@mediatek.com>
         <aaccd827fa6de117d27319884f2d70a2ea91aa5e.camel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 9C6198D0BAC2FA8D8B8BDDFFBAC2EDB7EF6F48FF231ECF7E375D29328861266A2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gTW9uLCAyMDIwLTA5LTI4IGF0IDEwOjMyICswMjAwLCBQaGlsaXBwIFphYmVsIHdyb3RlOg0K
PiBIaSBKaWFuanVuLA0KPiANCj4gT24gU3VuLCAyMDIwLTA5LTI3IGF0IDE1OjQ1ICswODAwLCBK
aWFuanVuIFdhbmcgd3JvdGU6DQo+ID4gTWVkaWFUZWsncyBQQ0llIGhvc3QgY29udHJvbGxlciBo
YXMgdGhyZWUgZ2VuZXJhdGlvbiBIV3MsIHRoZSBuZXcNCj4gPiBnZW5lcmF0aW9uIEhXIGlzIGFu
IGluZGl2aWR1YWwgYnJpZGdlLCBpdCBzdXBvb3J0cyBHZW4zIHNwZWVkIGFuZA0KPiA+IHVwIHRv
IDI1NiBNU0kgaW50ZXJydXB0IG51bWJlcnMgZm9yIG11bHRpLWZ1bmN0aW9uIGRldmljZXMuDQo+
ID4gDQo+ID4gQWRkIHN1cHBvcnQgZm9yIG5ldyBHZW4zIGNvbnRyb2xsZXIgd2hpY2ggY2FuIGJl
IGZvdW5kIG9uIE1UODE5Mi4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBKaWFuanVuIFdhbmcg
PGppYW5qdW4ud2FuZ0BtZWRpYXRlay5jb20+DQo+ID4gQWNrZWQtYnk6IFJ5ZGVyIExlZSA8cnlk
ZXIubGVlQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9wY2kvY29udHJvbGxl
ci9LY29uZmlnICAgICAgICAgICAgICB8ICAgMTQgKw0KPiA+ICBkcml2ZXJzL3BjaS9jb250cm9s
bGVyL01ha2VmaWxlICAgICAgICAgICAgIHwgICAgMSArDQo+ID4gIGRyaXZlcnMvcGNpL2NvbnRy
b2xsZXIvcGNpZS1tZWRpYXRlay1nZW4zLmMgfCAxMDI0ICsrKysrKysrKysrKysrKysrKysNCj4g
PiAgMyBmaWxlcyBjaGFuZ2VkLCAxMDM5IGluc2VydGlvbnMoKykNCj4gPiAgY3JlYXRlIG1vZGUg
MTAwNjQ0IGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tZWRpYXRlay1nZW4zLmMNCj4gPiAN
Cj4gWy4uLl0NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLW1l
ZGlhdGVrLWdlbjMuYyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tZWRpYXRlay1nZW4z
LmMNCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+IGluZGV4IDAwMDAwMDAwMDAwMC4uYWQ2
OWM3ODliMjRkDQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRy
b2xsZXIvcGNpZS1tZWRpYXRlay1nZW4zLmMNCj4gPiBAQCAtMCwwICsxLDEwMjQgQEANCj4gWy4u
Ll0NCj4gPiArc3RhdGljIGludCBtdGtfcGNpZV9wb3dlcl91cChzdHJ1Y3QgbXRrX3BjaWVfcG9y
dCAqcG9ydCkNCj4gPiArew0KPiA+ICsJc3RydWN0IGRldmljZSAqZGV2ID0gcG9ydC0+ZGV2Ow0K
PiA+ICsJaW50IGVycjsNCj4gPiArDQo+ID4gKwlwb3J0LT5waHlfcmVzZXQgPSBkZXZtX3Jlc2V0
X2NvbnRyb2xfZ2V0X29wdGlvbmFsX2V4Y2x1c2l2ZShkZXYsDQo+ID4gKwkJCQkJCQkJICAgICJw
aHktcnN0Iik7DQo+ID4gKwlpZiAoSVNfRVJSKHBvcnQtPnBoeV9yZXNldCkpDQo+ID4gKwkJcmV0
dXJuIFBUUl9FUlIocG9ydC0+cGh5X3Jlc2V0KTsNCj4gPiArDQo+ID4gKwlyZXNldF9jb250cm9s
X2RlYXNzZXJ0KHBvcnQtPnBoeV9yZXNldCk7DQo+IA0KPiBJbiBnZW5lcmFsLCBpdCBpcyBiZXR0
ZXIgdG8gcmVxdWVzdCBhbGwgcmVxdWlyZWQgcmVzb3VyY2VzIGJlZm9yZQ0KPiBzdGFydGluZyB0
byBhY3RpdmF0ZSB0aGUgaGFyZHdhcmUuDQo+IA0KPiA+ICsNCj4gPiArCS8qIFBIWSBwb3dlciBv
biBhbmQgZW5hYmxlIHBpcGUgY2xvY2sgKi8NCj4gPiArCXBvcnQtPnBoeSA9IGRldm1fcGh5X29w
dGlvbmFsX2dldChkZXYsICJwY2llLXBoeSIpOw0KPiA+ICsJaWYgKElTX0VSUihwb3J0LT5waHkp
KQ0KPiA+ICsJCXJldHVybiBQVFJfRVJSKHBvcnQtPnBoeSk7DQo+IA0KPiBGb3IgZXhhbXBsZSwg
aWYgdGhlIFBIWSBkcml2ZXIgaXMgbm90IGxvYWRlZCB5ZXQgYW5kIHRoaXMgcmV0dXJucw0KPiAt
RVBST0JFX0RFRkVSLCBpdCB3YXMgbm90IHVzZWZ1bCB0byB0YWtlIHRoZSBQSFkgb3V0IG9mIHJl
c2V0IGFib3ZlLg0KPiBBbHNvLCBwaHktcnN0IGlzIGtlcHQgZGVhc3NlcnRlZCBpZiB0aGlzIGZh
aWxzLg0KPiANCj4gPiArDQo+ID4gKwllcnIgPSBwaHlfaW5pdChwb3J0LT5waHkpOw0KPiA+ICsJ
aWYgKGVycikgew0KPiA+ICsJCWRldl9ub3RpY2UoZGV2LCAiZmFpbGVkIHRvIGluaXRpYWxpemUg
cGNpZSBwaHlcbiIpOw0KPiA+ICsJCXJldHVybiBlcnI7DQo+IA0KPiBwaHktcnN0IGlzIGtlcHQg
ZGVhc3NlcnRlZCBpZiB0aGlzIGZhaWxzLg0KPiANCj4gPiArCX0NCj4gPiArDQo+ID4gKwllcnIg
PSBwaHlfcG93ZXJfb24ocG9ydC0+cGh5KTsNCj4gPiArCWlmIChlcnIpIHsNCj4gPiArCQlkZXZf
bm90aWNlKGRldiwgImZhaWxlZCB0byBwb3dlciBvbiBwY2llIHBoeVxuIik7DQo+ID4gKwkJZ290
byBlcnJfcGh5X29uOw0KPiA+ICsJfQ0KPiA+ICsNCj4gPiArCXBvcnQtPm1hY19yZXNldCA9IGRl
dm1fcmVzZXRfY29udHJvbF9nZXRfb3B0aW9uYWxfZXhjbHVzaXZlKGRldiwNCj4gPiArCQkJCQkJ
CQkgICAgIm1hYy1yc3QiKTsNCj4gPiArCWlmIChJU19FUlIocG9ydC0+bWFjX3Jlc2V0KSkNCj4g
PiArCQlyZXR1cm4gUFRSX0VSUihwb3J0LT5tYWNfcmVzZXQpOw0KPiANCj4gVGhlIFBIWSBpcyBu
b3QgcG93ZXJlZCBkb3duIGlmIHRoaXMgZmFpbHMuDQo+IA0KPiA+ICsNCj4gPiArCXJlc2V0X2Nv
bnRyb2xfZGVhc3NlcnQocG9ydC0+bWFjX3Jlc2V0KTsNCj4gPiArDQo+ID4gKwkvKiBNQUMgcG93
ZXIgb24gYW5kIGVuYWJsZSB0cmFuc2FjdGlvbiBsYXllciBjbG9ja3MgKi8NCj4gPiArCXBtX3J1
bnRpbWVfZW5hYmxlKGRldik7DQo+ID4gKwlwbV9ydW50aW1lX2dldF9zeW5jKGRldik7DQo+ID4g
Kw0KPiA+ICsJZXJyID0gbXRrX3BjaWVfY2xrX2luaXQocG9ydCk7DQo+ID4gKwlpZiAoZXJyKSB7
DQo+ID4gKwkJZGV2X25vdGljZShkZXYsICJjbG9jayBpbml0IGZhaWxlZFxuIik7DQo+ID4gKwkJ
Z290byBlcnJfY2xrX2luaXQ7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJcmV0dXJuIDA7DQo+ID4g
Kw0KPiA+ICtlcnJfY2xrX2luaXQ6DQo+ID4gKwlwbV9ydW50aW1lX3B1dF9zeW5jKGRldik7DQo+
ID4gKwlwbV9ydW50aW1lX2Rpc2FibGUoZGV2KTsNCj4gPiArCXJlc2V0X2NvbnRyb2xfYXNzZXJ0
KHBvcnQtPm1hY19yZXNldCk7DQo+ID4gKwlwaHlfcG93ZXJfb2ZmKHBvcnQtPnBoeSk7DQo+ID4g
K2Vycl9waHlfb246DQo+ID4gKwlwaHlfZXhpdChwb3J0LT5waHkpOw0KPiA+ICsJcmVzZXRfY29u
dHJvbF9hc3NlcnQocG9ydC0+cGh5X3Jlc2V0KTsNCj4gPiArDQo+ID4gKwlyZXR1cm4gLUVCVVNZ
Ow0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgdm9pZCBtdGtfcGNpZV9wb3dlcl9kb3duKHN0
cnVjdCBtdGtfcGNpZV9wb3J0ICpwb3J0KQ0KPiA+ICt7DQo+ID4gKwlwaHlfcG93ZXJfb2ZmKHBv
cnQtPnBoeSk7DQo+ID4gKwlwaHlfZXhpdChwb3J0LT5waHkpOw0KPiA+ICsNCj4gPiArCWNsa19i
dWxrX2Rpc2FibGVfdW5wcmVwYXJlKHBvcnQtPm51bV9jbGtzLCBwb3J0LT5jbGtzKTsNCj4gDQo+
IEluIHRoZSBwb3dlci11cCBzZXF1ZW5jZSBjbG9ja3MgYXJlIGVuYWJsZWQgbGFzdCwgYnV0IGhl
cmUgdGhleSBhcmUgbm90DQo+IGRpc2FibGVkIGJlZm9yZSB0aGUgUEhZIGlzIHBvd2VyZWQgb2Zm
LiBJcyB0aGlzIG9uIHB1cnBvc2U/DQo+IA0KPiA+ICsNCj4gPiArCXBtX3J1bnRpbWVfcHV0X3N5
bmMocG9ydC0+ZGV2KTsNCj4gPiArCXBtX3J1bnRpbWVfZGlzYWJsZShwb3J0LT5kZXYpOw0KPiAN
Cj4gSW4gdGhlIHBvd2VyLXVwIGVycm9yIHBhdGgsIFBIWSBhbmQgY29udHJvbGxlciByZXNldHMg
YXJlIGFzc2VydGVkDQo+IGFnYWluLCBidXQgaGVyZSB0aGV5IGFyZSBrZXB0IGRlYXNzZXJ0ZWQu
IFNob3VsZCB0aGV5IGJlIGFzc2VydGVkIGhlcmUNCj4gYXMgd2VsbD8NCj4gDQo+IHJlZ2FyZHMN
Cj4gUGhpbGlwcA0KDQpIaSBQaGlsaXBwLA0KDQpTb3JyeSBmb3IgdGhlIGxhdGUgcmVzcG9uZGlu
ZyBhbmQgdGhhbmtzIGZvciB5b3VyIHJldmlldywgSSB3aWxsIGZpeCBpdA0KaW4gdGhlIG5leHQg
dmVyc2lvbi4NCg0KVGhhbmtzLg0KDQo=

