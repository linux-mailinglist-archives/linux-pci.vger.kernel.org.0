Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9533C82F2
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jul 2021 12:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239137AbhGNKdE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Jul 2021 06:33:04 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:57456 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S239084AbhGNKdD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Jul 2021 06:33:03 -0400
X-UUID: 11ce90c742ac4fcc87812fa62567ad2a-20210714
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=aMvi45gbpJSoRaiIcIqBkq7M/xz+yG1kS/cPkMPAaJA=;
        b=eHXtz8DBbyuUZWQWH+qo31Gf1BSf+nCcjclfx1fyYJJGD5oMxQoYTtOenoM3z0R+N4B+q6Q3KsfT6lnVmtE52NlXaHcj6NY7YfmZH/82EcFR2/4PjfVp9JIo/+q8hZZXav1KSH0QFgfbck8kKXzrgUcHbKSm7IIsY9ARwzozxqA=;
X-UUID: 11ce90c742ac4fcc87812fa62567ad2a-20210714
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <chuanjia.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1769286616; Wed, 14 Jul 2021 18:30:09 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 14 Jul 2021 18:30:08 +0800
Received: from [10.17.3.153] (10.17.3.153) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 14 Jul 2021 18:30:07 +0800
Message-ID: <1626258607.13880.9.camel@mhfsdcap03>
Subject: Re: [PATCH v10 2/4] PCI: mediatek: Add new method to get shared
 pcie-cfg base address and parse node
From:   Chuanjia Liu <chuanjia.liu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     <lorenzo.pieralisi@arm.com>, <robh+dt@kernel.org>,
        <bhelgaas@google.com>, <ryder.lee@mediatek.com>,
        <jianjun.wang@mediatek.com>, <yong.wu@mediatek.com>,
        <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Frank Wunderlich <frank-w@public-files.de>
Date:   Wed, 14 Jul 2021 18:30:07 +0800
In-Reply-To: <e462d9f0-2fa3-6106-f060-9753dc604b9f@gmail.com>
References: <20210611060902.12418-1-chuanjia.liu@mediatek.com>
         <20210611060902.12418-3-chuanjia.liu@mediatek.com>
         <e462d9f0-2fa3-6106-f060-9753dc604b9f@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVHVlLCAyMDIxLTA3LTEzIGF0IDEzOjMyICswMjAwLCBNYXR0aGlhcyBCcnVnZ2VyIHdyb3Rl
Og0KPiANCj4gT24gMTEvMDYvMjAyMSAwODowOSwgQ2h1YW5qaWEgTGl1IHdyb3RlOg0KPiA+IEZv
ciB0aGUgbmV3IGR0cyBmb3JtYXQsIGFkZCBhIG5ldyBtZXRob2QgdG8gZ2V0DQo+ID4gc2hhcmVk
IHBjaWUtY2ZnIGJhc2UgYWRkcmVzcyBhbmQgcGFyc2Ugbm9kZS4NCj4gPiANCj4gPiBTaWduZWQt
b2ZmLWJ5OiBDaHVhbmppYSBMaXUgPGNodWFuamlhLmxpdUBtZWRpYXRlay5jb20+DQo+ID4gQWNr
ZWQtYnk6IFJ5ZGVyIExlZSA8cnlkZXIubGVlQG1lZGlhdGVrLmNvbT4NCj4gDQo+IFlvdSBtaXNz
ZWQgdGhlDQo+IFJldmlld2VkLWJ5OiBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPg0KPiBn
aXZlbiBpbiB2OC4gT3Igd2VyZSB0aGVyZSBhbnkgc3Vic3RhbnRpYWwgY2hhbmdlcyBpbiB0aGlz
IHBhdGNoPw0KPiANClRoYW5rcyBmb3IgeW91ciByZXZpZXchDQoNCk9ubHkgYSBzbWFsbCBjaGFu
Z2XvvIxhcyBzaG93biBiZWxvdw0KDQogCQlpZiAoZXJyKQ0KLQkJCWdvdG8gZXJyb3JfcHV0X25v
ZGU7DQorCQkJcmV0dXJuIGVycjsNCiAJfQ0KSSBoYXZlIGEgZGVzY3JpcHRpb24gaW4gdGhlIFY5
IHZlcnNpb246DQpmaXgga2VybmVsLWNpIGJvdCB3YXJuaW5n77yMSW4gdGhlIHNjZW5lIG9mIHVz
aW5nIG5ldyBkdHMgZm9ybWF0LA0Kd2hlbiBtdGtfcGNpZV9wYXJzZV9wb3J0IGZhaWxzLCBvZl9u
b2RlX3B1dCBkb24ndCBuZWVkIHRvIGJlIGNhbGxlZC4NCg0KU28gSSBkaWRuJ3QgYWRkIHJldmll
d2VkLWJ5IHJvYiBiZWNhdXNlIEkgY2hhbmdlZCB0aGUgcGF0Y2jjgIINCj4gPiAtLS0NCj4gPiAg
ZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLW1lZGlhdGVrLmMgfCA1MiArKysrKysrKysrKysr
KysrKysrLS0tLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMzkgaW5zZXJ0aW9ucygrKSwgMTMg
ZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xs
ZXIvcGNpZS1tZWRpYXRlay5jIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLW1lZGlhdGVr
LmMNCj4gPiBpbmRleCA2MmEwNDJlNzVkOWEuLjk1MGY1NzdhMmY0NCAxMDA2NDQNCj4gPiAtLS0g
YS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtbWVkaWF0ZWsuYw0KPiA+ICsrKyBiL2RyaXZl
cnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tZWRpYXRlay5jDQo+ID4gQEAgLTE0LDYgKzE0LDcgQEAN
Cj4gPiAgI2luY2x1ZGUgPGxpbnV4L2lycWNoaXAvY2hhaW5lZF9pcnEuaD4NCj4gPiAgI2luY2x1
ZGUgPGxpbnV4L2lycWRvbWFpbi5oPg0KPiA+ICAjaW5jbHVkZSA8bGludXgva2VybmVsLmg+DQo+
ID4gKyNpbmNsdWRlIDxsaW51eC9tZmQvc3lzY29uLmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9t
c2kuaD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPg0KPiA+ICAjaW5jbHVkZSA8bGlu
dXgvb2ZfYWRkcmVzcy5oPg0KPiA+IEBAIC0yMyw2ICsyNCw3IEBADQo+ID4gICNpbmNsdWRlIDxs
aW51eC9waHkvcGh5Lmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4N
Cj4gPiAgI2luY2x1ZGUgPGxpbnV4L3BtX3J1bnRpbWUuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4
L3JlZ21hcC5oPg0KPiA+ICAjaW5jbHVkZSA8bGludXgvcmVzZXQuaD4NCj4gPiAgDQo+ID4gICNp
bmNsdWRlICIuLi9wY2kuaCINCj4gPiBAQCAtMjA3LDYgKzIwOSw3IEBAIHN0cnVjdCBtdGtfcGNp
ZV9wb3J0IHsNCj4gPiAgICogc3RydWN0IG10a19wY2llIC0gUENJZSBob3N0IGluZm9ybWF0aW9u
DQo+ID4gICAqIEBkZXY6IHBvaW50ZXIgdG8gUENJZSBkZXZpY2UNCj4gPiAgICogQGJhc2U6IElP
IG1hcHBlZCByZWdpc3RlciBiYXNlDQo+ID4gKyAqIEBjZmc6IElPIG1hcHBlZCByZWdpc3RlciBt
YXAgZm9yIFBDSWUgY29uZmlnDQo+ID4gICAqIEBmcmVlX2NrOiBmcmVlLXJ1biByZWZlcmVuY2Ug
Y2xvY2sNCj4gPiAgICogQG1lbTogbm9uLXByZWZldGNoYWJsZSBtZW1vcnkgcmVzb3VyY2UNCj4g
PiAgICogQHBvcnRzOiBwb2ludGVyIHRvIFBDSWUgcG9ydCBpbmZvcm1hdGlvbg0KPiA+IEBAIC0y
MTUsNiArMjE4LDcgQEAgc3RydWN0IG10a19wY2llX3BvcnQgew0KPiA+ICBzdHJ1Y3QgbXRrX3Bj
aWUgew0KPiA+ICAJc3RydWN0IGRldmljZSAqZGV2Ow0KPiA+ICAJdm9pZCBfX2lvbWVtICpiYXNl
Ow0KPiA+ICsJc3RydWN0IHJlZ21hcCAqY2ZnOw0KPiA+ICAJc3RydWN0IGNsayAqZnJlZV9jazsN
Cj4gPiAgDQo+ID4gIAlzdHJ1Y3QgbGlzdF9oZWFkIHBvcnRzOw0KPiA+IEBAIC02NTAsNyArNjU0
LDExIEBAIHN0YXRpYyBpbnQgbXRrX3BjaWVfc2V0dXBfaXJxKHN0cnVjdCBtdGtfcGNpZV9wb3J0
ICpwb3J0LA0KPiA+ICAJCXJldHVybiBlcnI7DQo+ID4gIAl9DQo+ID4gIA0KPiA+IC0JcG9ydC0+
aXJxID0gcGxhdGZvcm1fZ2V0X2lycShwZGV2LCBwb3J0LT5zbG90KTsNCj4gPiArCWlmIChvZl9m
aW5kX3Byb3BlcnR5KGRldi0+b2Zfbm9kZSwgImludGVycnVwdC1uYW1lcyIsIE5VTEwpKQ0KPiA+
ICsJCXBvcnQtPmlycSA9IHBsYXRmb3JtX2dldF9pcnFfYnluYW1lKHBkZXYsICJwY2llX2lycSIp
Ow0KPiA+ICsJZWxzZQ0KPiA+ICsJCXBvcnQtPmlycSA9IHBsYXRmb3JtX2dldF9pcnEocGRldiwg
cG9ydC0+c2xvdCk7DQo+ID4gKw0KPiANCj4gRG8gSSB1bmRlcnN0YW5kIHRoYXQgdGhpcyBpcyB1
c2VkIGZvciBiYWNrd2FyZHMgY29tcGF0aWJpbGl0eSB3aXRoIG9sZGVyIERUUz8gSQ0KPiBqdXN0
IHdvbmRlciB3aHkgd2UgZG9uJ3QgbmVlZCB0byBtYW5kYXRlDQo+IGludGVycnVwdC1uYW1lcyA9
ICJwY2llX2lycSINCj4gaW4gdGhlIGJpbmRpbmcgZGVzY3JpcHRpb24uDQpZZXPvvIx0aGlzIGlz
IHVzZWQgZm9yIGJhY2t3YXJkcyBjb21wYXRpYmlsaXR5IHdpdGggb2xkZXIgRFRT44CCDQpJZiBu
ZWNlc3NhcnksIEkgd2lsbCBhZGQgdGhlIGZvbGxvd2luZyBpbiBiaW5kaW5nIGRlc2NyaXB0aW9u
Lg0KLSBpbnRlcnJ1cHQtbmFtZXPvvJpNdXN0IGluY2x1ZGUgdGhlIGZvbGxvd2luZyBlbnRyaWVz
77yaDQogICAgLSAicGNpZV9pcnEi77yaIFRoZSBpbnRlcnJ1cHQgdGhhdCBpcyBhc3NlcnRlZCB3
aGVuIGFuIE1TSS9JTlRYIGlzDQpyZWNlaXZlZA0KDQpCZXN0IHJlZ2FyZHMNCkNodWFuamlhDQo+
IA0KPiBSZWdhcmRzLA0KPiBNYXR0aGlhcw0KDQo=

