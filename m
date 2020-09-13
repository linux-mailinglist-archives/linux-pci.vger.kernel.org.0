Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F526267D56
	for <lists+linux-pci@lfdr.de>; Sun, 13 Sep 2020 04:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725913AbgIMCs5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 12 Sep 2020 22:48:57 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:22503 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725908AbgIMCsz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 12 Sep 2020 22:48:55 -0400
X-UUID: a8020bd14d53441fa66cb55b810d10ea-20200913
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=ixnwdilJm1ik+Sm2/G6gQSeRU/yl+c9RA2y6lHXtiFM=;
        b=G4CWgI6+sQwUrvN3CNkPJzNy6Jm8nDmAtg/KRE4ctCeI0w0J6DIpjlhstq9roJlENw2lQR9DDb2ng3Et89chyfI1HC/nghVrD5DoE2UU2souXqzF5tNh+R06+Z0FXyFPwJNNEd9IcNCZGPpEk9sNYwO4bNvJMg7dFFA5L4Ra/yE=;
X-UUID: a8020bd14d53441fa66cb55b810d10ea-20200913
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chuanjia.liu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 133974669; Sun, 13 Sep 2020 10:48:36 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 13 Sep
 2020 10:48:34 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 13 Sep 2020 10:48:34 +0800
Message-ID: <1599965194.7466.28.camel@mhfsdcap03>
Subject: Re: [PATCH v5 2/4] PCI: mediatek: Use regmap to get shared pcie-cfg
 base
From:   Chuanjia Liu <chuanjia.liu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <devicetree@vger.kernel.org>, Ryder Lee <ryder.lee@mediatek.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <yong.wu@mediatek.com>
Date:   Sun, 13 Sep 2020 10:46:34 +0800
In-Reply-To: <b627b938-2210-16d2-1682-3c25506e30f3@gmail.com>
References: <20200910061115.909-1-chuanjia.liu@mediatek.com>
         <20200910061115.909-3-chuanjia.liu@mediatek.com>
         <b627b938-2210-16d2-1682-3c25506e30f3@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: B622682C64DBF4B97D327ED91874FA7AE6E2A95E360E8685FB83F62B6AA965732000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVGh1LCAyMDIwLTA5LTEwIGF0IDEyOjQ0ICswMjAwLCBNYXR0aGlhcyBCcnVnZ2VyIHdyb3Rl
Og0KPiANCj4gT24gMTAvMDkvMjAyMCAwODoxMSwgQ2h1YW5qaWEgTGl1IHdyb3RlOg0KPiA+IFVz
ZSByZWdtYXAgdG8gZ2V0IHNoYXJlZCBwY2llLWNmZyBiYXNlIGFuZCBjaGFuZ2UNCj4gPiB0aGUg
bWV0aG9kIHRvIGdldCBwY2llIGlycS4NCj4gPiANCj4gPiBBY2tlZC1ieTogUnlkZXIgTGVlIDxy
eWRlci5sZWVAbWVkaWF0ZWsuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IENodWFuamlhIExpdSA8
Y2h1YW5qaWEubGl1QG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvcGNpL2Nv
bnRyb2xsZXIvcGNpZS1tZWRpYXRlay5jIHwgMjUgKysrKysrKysrKysrKysrKysrLS0tLS0tLQ0K
PiA+ICAgMSBmaWxlIGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pDQo+
ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tZWRpYXRl
ay5jIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLW1lZGlhdGVrLmMNCj4gPiBpbmRleCBj
ZjRjMThmMGMyNWEuLjk4Nzg0NWQxOTk4MiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3BjaS9j
b250cm9sbGVyL3BjaWUtbWVkaWF0ZWsuYw0KPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xs
ZXIvcGNpZS1tZWRpYXRlay5jDQo+ID4gQEAgLTE0LDYgKzE0LDcgQEANCj4gPiAgICNpbmNsdWRl
IDxsaW51eC9pcnFjaGlwL2NoYWluZWRfaXJxLmg+DQo+ID4gICAjaW5jbHVkZSA8bGludXgvaXJx
ZG9tYWluLmg+DQo+ID4gICAjaW5jbHVkZSA8bGludXgva2VybmVsLmg+DQo+ID4gKyNpbmNsdWRl
IDxsaW51eC9tZmQvc3lzY29uLmg+DQo+ID4gICAjaW5jbHVkZSA8bGludXgvbXNpLmg+DQo+ID4g
ICAjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+DQo+ID4gICAjaW5jbHVkZSA8bGludXgvb2ZfYWRk
cmVzcy5oPg0KPiA+IEBAIC0yMyw2ICsyNCw3IEBADQo+ID4gICAjaW5jbHVkZSA8bGludXgvcGh5
L3BoeS5oPg0KPiA+ICAgI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPg0KPiA+ICAg
I2luY2x1ZGUgPGxpbnV4L3BtX3J1bnRpbWUuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L3JlZ21h
cC5oPg0KPiA+ICAgI2luY2x1ZGUgPGxpbnV4L3Jlc2V0Lmg+DQo+ID4gICANCj4gPiAgICNpbmNs
dWRlICIuLi9wY2kuaCINCj4gPiBAQCAtMjA1LDYgKzIwNyw3IEBAIHN0cnVjdCBtdGtfcGNpZV9w
b3J0IHsNCj4gPiAgICAqIHN0cnVjdCBtdGtfcGNpZSAtIFBDSWUgaG9zdCBpbmZvcm1hdGlvbg0K
PiA+ICAgICogQGRldjogcG9pbnRlciB0byBQQ0llIGRldmljZQ0KPiA+ICAgICogQGJhc2U6IElP
IG1hcHBlZCByZWdpc3RlciBiYXNlDQo+ID4gKyAqIEBjZmc6IElPIG1hcHBlZCByZWdpc3RlciBt
YXAgZm9yIFBDSWUgY29uZmlnDQo+ID4gICAgKiBAZnJlZV9jazogZnJlZS1ydW4gcmVmZXJlbmNl
IGNsb2NrDQo+ID4gICAgKiBAbWVtOiBub24tcHJlZmV0Y2hhYmxlIG1lbW9yeSByZXNvdXJjZQ0K
PiA+ICAgICogQHBvcnRzOiBwb2ludGVyIHRvIFBDSWUgcG9ydCBpbmZvcm1hdGlvbg0KPiA+IEBA
IC0yMTMsNiArMjE2LDcgQEAgc3RydWN0IG10a19wY2llX3BvcnQgew0KPiA+ICAgc3RydWN0IG10
a19wY2llIHsNCj4gPiAgIAlzdHJ1Y3QgZGV2aWNlICpkZXY7DQo+ID4gICAJdm9pZCBfX2lvbWVt
ICpiYXNlOw0KPiA+ICsJc3RydWN0IHJlZ21hcCAqY2ZnOw0KPiA+ICAgCXN0cnVjdCBjbGsgKmZy
ZWVfY2s7DQo+ID4gICANCj4gPiAgIAlzdHJ1Y3QgbGlzdF9oZWFkIHBvcnRzOw0KPiA+IEBAIC02
NDgsNyArNjUyLDcgQEAgc3RhdGljIGludCBtdGtfcGNpZV9zZXR1cF9pcnEoc3RydWN0IG10a19w
Y2llX3BvcnQgKnBvcnQsDQo+ID4gICAJCXJldHVybiBlcnI7DQo+ID4gICAJfQ0KPiA+ICAgDQo+
ID4gLQlwb3J0LT5pcnEgPSBwbGF0Zm9ybV9nZXRfaXJxKHBkZXYsIHBvcnQtPnNsb3QpOw0KPiA+
ICsJcG9ydC0+aXJxID0gcGxhdGZvcm1fZ2V0X2lycV9ieW5hbWUocGRldiwgInBjaWVfaXJxIik7
DQo+ID4gICAJaWYgKHBvcnQtPmlycSA8IDApDQo+ID4gICAJCXJldHVybiBwb3J0LT5pcnE7DQo+
IA0KPiBZb3Ugd2lsbCBuZWVkIHRvIG1ha2Ugc3VyZSB0YWh0IHRoZSBkcml2ZXIga2VlcHMgd29y
a2luZyB3aXRoIHRoZSBvbGQgRFRTIA0KPiBmb3JtYXQuIFRoaXMgaXMgbm90IHRoZSBjYXNlIGhl
cmUuDQo+IA0KVGhhbmtzIGZvciB5b3VyIHJldmlldywgSSB3aWxsIGZpeCBpdCBpbiB0aGUgbmV4
dCB2ZXJzaW9uLg0KDQpSZWdhcmRzLA0KQ2h1YW5qaWENCj4gUmVnYXJkcywNCj4gTWF0dGhpYXMN
Cj4gDQo+ID4gICANCj4gPiBAQCAtNjc0LDEyICs2NzgsMTEgQEAgc3RhdGljIGludCBtdGtfcGNp
ZV9zdGFydHVwX3BvcnRfdjIoc3RydWN0IG10a19wY2llX3BvcnQgKnBvcnQpDQo+ID4gICAJaWYg
KCFtZW0pDQo+ID4gICAJCXJldHVybiAtRUlOVkFMOw0KPiA+ICAgDQo+ID4gLQkvKiBNVDc2MjIg
cGxhdGZvcm1zIG5lZWQgdG8gZW5hYmxlIExUU1NNIGFuZCBBU1BNIGZyb20gUENJZSBzdWJzeXMg
Ki8NCj4gPiAtCWlmIChwY2llLT5iYXNlKSB7DQo+ID4gLQkJdmFsID0gcmVhZGwocGNpZS0+YmFz
ZSArIFBDSUVfU1lTX0NGR19WMik7DQo+ID4gLQkJdmFsIHw9IFBDSUVfQ1NSX0xUU1NNX0VOKHBv
cnQtPnNsb3QpIHwNCj4gPiAtCQkgICAgICAgUENJRV9DU1JfQVNQTV9MMV9FTihwb3J0LT5zbG90
KTsNCj4gPiAtCQl3cml0ZWwodmFsLCBwY2llLT5iYXNlICsgUENJRV9TWVNfQ0ZHX1YyKTsNCj4g
PiArCS8qIE1UNzYyMi9NVDc2MjkgcGxhdGZvcm1zIG5lZWQgdG8gZW5hYmxlIExUU1NNIGFuZCBB
U1BNLiAqLw0KPiA+ICsJaWYgKHBjaWUtPmNmZykgew0KPiA+ICsJCXZhbCA9IFBDSUVfQ1NSX0xU
U1NNX0VOKHBvcnQtPnNsb3QpIHwNCj4gPiArCQkgICAgICBQQ0lFX0NTUl9BU1BNX0wxX0VOKHBv
cnQtPnNsb3QpOw0KPiA+ICsJCXJlZ21hcF91cGRhdGVfYml0cyhwY2llLT5jZmcsIFBDSUVfU1lT
X0NGR19WMiwgdmFsLCB2YWwpOw0KPiA+ICAgCX0NCj4gPiAgIA0KPiA+ICAgCS8qIEFzc2VydCBh
bGwgcmVzZXQgc2lnbmFscyAqLw0KPiA+IEBAIC05ODMsNiArOTg2LDcgQEAgc3RhdGljIGludCBt
dGtfcGNpZV9zdWJzeXNfcG93ZXJ1cChzdHJ1Y3QgbXRrX3BjaWUgKnBjaWUpDQo+ID4gICAJc3Ry
dWN0IGRldmljZSAqZGV2ID0gcGNpZS0+ZGV2Ow0KPiA+ICAgCXN0cnVjdCBwbGF0Zm9ybV9kZXZp
Y2UgKnBkZXYgPSB0b19wbGF0Zm9ybV9kZXZpY2UoZGV2KTsNCj4gPiAgIAlzdHJ1Y3QgcmVzb3Vy
Y2UgKnJlZ3M7DQo+ID4gKwlzdHJ1Y3QgZGV2aWNlX25vZGUgKmNmZ19ub2RlOw0KPiA+ICAgCWlu
dCBlcnI7DQo+ID4gICANCj4gPiAgIAkvKiBnZXQgc2hhcmVkIHJlZ2lzdGVycywgd2hpY2ggYXJl
IG9wdGlvbmFsICovDQo+ID4gQEAgLTk5NSw2ICs5OTksMTMgQEAgc3RhdGljIGludCBtdGtfcGNp
ZV9zdWJzeXNfcG93ZXJ1cChzdHJ1Y3QgbXRrX3BjaWUgKnBjaWUpDQo+ID4gICAJCX0NCj4gPiAg
IAl9DQo+ID4gICANCj4gPiArCWNmZ19ub2RlID0gb2ZfcGFyc2VfcGhhbmRsZShkZXYtPm9mX25v
ZGUsICJtZWRpYXRlayxwY2llLWNmZyIsIDApOw0KPiA+ICsJaWYgKGNmZ19ub2RlKSB7DQo+ID4g
KwkJcGNpZS0+Y2ZnID0gc3lzY29uX25vZGVfdG9fcmVnbWFwKGNmZ19ub2RlKTsNCj4gPiArCQlp
ZiAoSVNfRVJSKHBjaWUtPmNmZykpDQo+ID4gKwkJCXJldHVybiBQVFJfRVJSKHBjaWUtPmNmZyk7
DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICAgCXBjaWUtPmZyZWVfY2sgPSBkZXZtX2Nsa19nZXQoZGV2
LCAiZnJlZV9jayIpOw0KPiA+ICAgCWlmIChJU19FUlIocGNpZS0+ZnJlZV9jaykpIHsNCj4gPiAg
IAkJaWYgKFBUUl9FUlIocGNpZS0+ZnJlZV9jaykgPT0gLUVQUk9CRV9ERUZFUikNCj4gPiANCg0K

