Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57C7526893A
	for <lists+linux-pci@lfdr.de>; Mon, 14 Sep 2020 12:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgINKZZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Sep 2020 06:25:25 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:27909 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726383AbgINKZY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Sep 2020 06:25:24 -0400
X-UUID: aa63b43d134b45bd9b8c4ed090a3263b-20200914
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=xEzcpucgYacwPxI4zW8BRzU1nv7ljitEBf6N+fXDGNU=;
        b=HAuDh/ofVwcimDuhbMuCnCSNwRW31PaagkQpu1VUjWA+8YN6A+ZwhJK3ToQg1vm5rW4uqHW1/qmQwx/MkFXSy3LgIudrN+dm4kpuRxDHMDTJZ/v+7UhcuTDw4Jx9Yzci9bKOdRT0iMBc6c8NBY2DDscV6NmERq5Ky0Ge5jUusxc=;
X-UUID: aa63b43d134b45bd9b8c4ed090a3263b-20200914
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 275340207; Mon, 14 Sep 2020 18:25:18 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by mtkmbs08n2.mediatek.inc
 (172.21.101.56) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 14 Sep
 2020 18:25:14 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 14 Sep 2020 18:25:13 +0800
Message-ID: <1600078992.2521.27.camel@mhfsdcap03>
Subject: Re: [v2,1/3] dt-bindings: PCI: mediatek: Add YAML schema
From:   Jianjun Wang <jianjun.wang@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        <davem@davemloft.net>, <linux-pci@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Sj Huang <sj.huang@mediatek.com>
Date:   Mon, 14 Sep 2020 18:23:12 +0800
In-Reply-To: <20200911224554.GB2905744@bogus>
References: <20200910034536.30860-1-jianjun.wang@mediatek.com>
         <20200910034536.30860-2-jianjun.wang@mediatek.com>
         <20200911224554.GB2905744@bogus>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 9CF3AAFAF8100D953018214FE70B22C96AE44896732AEC350BE3FCE945D1000F2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gRnJpLCAyMDIwLTA5LTExIGF0IDE2OjQ1IC0wNjAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
T24gVGh1LCBTZXAgMTAsIDIwMjAgYXQgMTE6NDU6MzRBTSArMDgwMCwgSmlhbmp1biBXYW5nIHdy
b3RlOg0KPiA+IEFkZCBZQU1MIHNjaGVtYXMgZG9jdW1lbnRhdGlvbiBmb3IgR2VuMyBQQ0llIGNv
bnRyb2xsZXIgb24NCj4gPiBNZWRpYVRlayBTb0NzLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6
IEppYW5qdW4gV2FuZyA8amlhbmp1bi53YW5nQG1lZGlhdGVrLmNvbT4NCj4gPiBBY2tlZC1ieTog
UnlkZXIgTGVlIDxyeWRlci5sZWVAbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICAuLi4vYmlu
ZGluZ3MvcGNpL21lZGlhdGVrLXBjaWUtZ2VuMy55YW1sICAgICAgfCAxMzAgKysrKysrKysrKysr
KysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxMzAgaW5zZXJ0aW9ucygrKQ0KPiA+ICBjcmVh
dGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9tZWRp
YXRlay1wY2llLWdlbjMueWFtbA0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvcGNpL21lZGlhdGVrLXBjaWUtZ2VuMy55YW1sIGIvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9tZWRpYXRlay1wY2llLWdlbjMueWFtbA0K
PiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gaW5kZXggMDAwMDAwMDAwMDAwLi5hMmRmYzBk
MTVkMmUNCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL3BjaS9tZWRpYXRlay1wY2llLWdlbjMueWFtbA0KPiA+IEBAIC0wLDAgKzEs
MTMwIEBADQo+ID4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IChHUEwtMi4wIE9SIEJTRC0y
LUNsYXVzZSkNCj4gPiArJVlBTUwgMS4yDQo+ID4gKy0tLQ0KPiA+ICskaWQ6IGh0dHA6Ly9kZXZp
Y2V0cmVlLm9yZy9zY2hlbWFzL3BjaS9tZWRpYXRlay1wY2llLWdlbjMueWFtbCMNCj4gPiArJHNj
aGVtYTogaHR0cDovL2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjDQo+ID4g
Kw0KPiA+ICt0aXRsZTogR2VuMyBQQ0llIGNvbnRyb2xsZXIgb24gTWVkaWFUZWsgU29Dcw0KPiA+
ICsNCj4gPiArbWFpbnRhaW5lcnM6DQo+ID4gKyAgLSBKaWFuanVuIFdhbmcgPGppYW5qdW4ud2Fu
Z0BtZWRpYXRlay5jb20+DQo+ID4gKw0KPiA+ICthbGxPZjoNCj4gPiArICAtICRyZWY6IC9zY2hl
bWFzL3BjaS9wY2ktYnVzLnlhbWwjDQo+ID4gKw0KPiA+ICtwcm9wZXJ0aWVzOg0KPiA+ICsgIGNv
bXBhdGlibGU6DQo+ID4gKyAgICBvbmVPZjoNCj4gPiArICAgICAgLSBjb25zdDogbWVkaWF0ZWss
Z2VuMy1wY2llDQo+IA0KPiBHZW5lcmljIGNvbXBhdGlibGVzIGxpa2UgdGhpcyBzaG91bGQgb25s
eSBiZSBhIGZhbGxiYWNrIHN0cmluZywgbm90IG9uIA0KPiBpdHMgb3duLg0KPiANCj4gPiArICAg
ICAgLSBjb25zdDogbWVkaWF0ZWssbXQ4MTkyLXBjaWUNCj4gPiArDQo+ID4gKyAgcmVnOg0KPiA+
ICsgICAgbWF4SXRlbXM6IDENCj4gPiArDQo+ID4gKyAgaW50ZXJydXB0czoNCj4gPiArICAgIG1h
eEl0ZW1zOiAxDQo+ID4gKw0KPiA+ICsgIGJ1cy1yYW5nZToNCj4gPiArICAgIGRlc2NyaXB0aW9u
OiBSYW5nZSBvZiBidXMgbnVtYmVycyBhc3NvY2lhdGVkIHdpdGggdGhpcyBjb250cm9sbGVyLg0K
PiANCj4gRHJvcCB0aGlzLiBTdGFuZGFyZCBwcm9wZXJ0eS4NCg0KVGhhbmtzIGZvciB5b3VyIHJl
dmlldywgSSB3aWxsIGRyb3AgaXQgaW4gdGhlIG5leHQgdmVyc2lvbi4NCj4gDQo+ID4gKw0KPiA+
ICsgIHJhbmdlczoNCj4gPiArICAgIG1pbkl0ZW1zOiAxDQo+ID4gKyAgICBtYXhJdGVtczogOA0K
PiA+ICsNCj4gPiArICByZXNldHM6DQo+ID4gKyAgICBtaW5JdGVtczogMQ0KPiA+ICsgICAgbWF4
SXRlbXM6IDINCj4gPiArDQo+ID4gKyAgcmVzZXQtbmFtZXM6DQo+ID4gKyAgICBhbnlPZjoNCj4g
PiArICAgICAgLSBjb25zdDogbWFjLXJzdA0KPiA+ICsgICAgICAtIGNvbnN0OiBwaHktcnN0DQo+
ID4gKw0KPiA+ICsgIGNsb2NrczoNCj4gPiArICAgIG1heEl0ZW1zOiA1DQo+ID4gKw0KPiA+ICsg
IGFzc2lnbmVkLWNsb2NrczoNCj4gPiArICAgIG1heEl0ZW1zOiAxDQo+ID4gKw0KPiA+ICsgIGFz
c2lnbmVkLWNsb2NrLXBhcmVudHM6DQo+ID4gKyAgICBtYXhJdGVtczogMQ0KPiA+ICsNCj4gPiAr
ICBwaHlzOg0KPiA+ICsgICAgbWF4SXRlbXM6IDENCj4gPiArDQo+ID4gKyAgJyNpbnRlcnJ1cHQt
Y2VsbHMnOg0KPiA+ICsgICAgY29uc3Q6IDENCj4gPiArDQo+ID4gKyAgaW50ZXJydXB0LWNvbnRy
b2xsZXI6DQo+ID4gKyAgICBkZXNjcmlwdGlvbjogSW50ZXJydXB0IGNvbnRyb2xsZXIgbm9kZSBm
b3IgaGFuZGxpbmcgbGVnYWN5IFBDSSBpbnRlcnJ1cHRzLg0KPiA+ICsgICAgdHlwZTogb2JqZWN0
DQo+ID4gKyAgICBwcm9wZXJ0aWVzOg0KPiA+ICsgICAgICAnI2FkZHJlc3MtY2VsbHMnOg0KPiA+
ICsgICAgICAgIGNvbnN0OiAwDQo+ID4gKyAgICAgICcjaW50ZXJydXB0LWNlbGxzJzoNCj4gPiAr
ICAgICAgICBjb25zdDogMQ0KPiA+ICsgICAgICBpbnRlcnJ1cHQtY29udHJvbGxlcjogdHJ1ZQ0K
PiA+ICsNCj4gPiArICAgIHJlcXVpcmVkOg0KPiA+ICsgICAgICAtICcjYWRkcmVzcy1jZWxscycN
Cj4gPiArICAgICAgLSAnI2ludGVycnVwdC1jZWxscycNCj4gPiArICAgICAgLSBpbnRlcnJ1cHQt
Y29udHJvbGxlcg0KPiA+ICsNCj4gPiArICAgIGFkZGl0aW9uYWxQcm9wZXJ0aWVzOiBmYWxzZQ0K
PiA+ICsNCj4gPiArcmVxdWlyZWQ6DQo+ID4gKyAgLSBjb21wYXRpYmxlDQo+ID4gKyAgLSByZWcN
Cj4gPiArICAtIGludGVycnVwdHMNCj4gPiArICAtIHJhbmdlcw0KPiA+ICsgIC0gY2xvY2tzDQo+
ID4gKyAgLSAnI2ludGVycnVwdC1jZWxscycNCj4gPiArICAtIGludGVycnVwdC1jb250cm9sbGVy
DQo+ID4gKw0KPiA+ICt1bmV2YWx1YXRlZFByb3BlcnRpZXM6IGZhbHNlDQo+ID4gKw0KPiA+ICtl
eGFtcGxlczoNCj4gPiArICAtIHwNCj4gPiArICAgICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9pbnRl
cnJ1cHQtY29udHJvbGxlci9hcm0tZ2ljLmg+DQo+ID4gKyAgICAjaW5jbHVkZSA8ZHQtYmluZGlu
Z3MvaW50ZXJydXB0LWNvbnRyb2xsZXIvaXJxLmg+DQo+ID4gKw0KPiA+ICsgICAgYnVzIHsNCj4g
PiArICAgICAgICAjYWRkcmVzcy1jZWxscyA9IDwyPjsNCj4gPiArICAgICAgICAjc2l6ZS1jZWxs
cyA9IDwyPjsNCj4gPiArDQo+ID4gKyAgICAgICAgcGNpZTogcGNpZUAxMTIzMDAwMCB7DQo+ID4g
KyAgICAgICAgICAgIGNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTkyLXBjaWUiOw0KPiA+ICsg
ICAgICAgICAgICBkZXZpY2VfdHlwZSA9ICJwY2kiOw0KPiA+ICsgICAgICAgICAgICAjYWRkcmVz
cy1jZWxscyA9IDwzPjsNCj4gPiArICAgICAgICAgICAgI3NpemUtY2VsbHMgPSA8Mj47DQo+ID4g
KyAgICAgICAgICAgIHJlZyA9IDwweDAwIDB4MTEyMzAwMDAgMHgwMCAweDQwMDA+Ow0KPiA+ICsg
ICAgICAgICAgICByZWctbmFtZXMgPSAicGNpZS1tYWMiOw0KPiA+ICsgICAgICAgICAgICBpbnRl
cnJ1cHRzID0gPEdJQ19TUEkgMjUxIElSUV9UWVBFX0xFVkVMX0hJR0ggMD47DQo+ID4gKyAgICAg
ICAgICAgIGJ1cy1yYW5nZSA9IDwweDAwIDB4ZmY+Ow0KPiA+ICsgICAgICAgICAgICByYW5nZXMg
PSA8MHg4MjAwMDAwMCAweDAwIDB4MTIwMDAwMDAgMHgwMCAweDEyMDAwMDAwIDB4MDAgMHgxMDAw
MDAwPjsNCj4gPiArICAgICAgICAgICAgY2xvY2tzID0gPCZpbmZyYWNmZyA0MD4sDQo+ID4gKyAg
ICAgICAgICAgICAgICAgICAgIDwmaW5mcmFjZmcgNDM+LA0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgICA8JmluZnJhY2ZnIDk3PiwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgPCZpbmZyYWNm
ZyA5OT4sDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIDwmaW5mcmFjZmcgMTExPjsNCj4gPiAr
ICAgICAgICAgICAgYXNzaWduZWQtY2xvY2tzID0gPCZ0b3Bja2dlbiA1MD47DQo+ID4gKyAgICAg
ICAgICAgIGFzc2lnbmVkLWNsb2NrLXBhcmVudHMgPSA8JnRvcGNrZ2VuIDkxPjsNCj4gPiArDQo+
ID4gKyAgICAgICAgICAgIHBoeXMgPSA8JnBjaWVwaHk+Ow0KPiA+ICsgICAgICAgICAgICBwaHkt
bmFtZXMgPSAicGNpZS1waHkiOw0KPiA+ICsgICAgICAgICAgICByZXNldHMgPSA8JmluZnJhY2Zn
X3JzdCAwPjsNCj4gPiArICAgICAgICAgICAgcmVzZXQtbmFtZXMgPSAicGh5LXJzdCI7DQo+ID4g
Kw0KPiA+ICsgICAgICAgICAgICAjaW50ZXJydXB0LWNlbGxzID0gPDE+Ow0KPiA+ICsgICAgICAg
ICAgICBpbnRlcnJ1cHQtbWFwLW1hc2sgPSA8MCAwIDAgMHg3PjsNCj4gPiArICAgICAgICAgICAg
aW50ZXJydXB0LW1hcCA9IDwwIDAgMCAxICZwY2llX2ludGMgMD4sDQo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICA8MCAwIDAgMiAmcGNpZV9pbnRjIDE+LA0KPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgPDAgMCAwIDMgJnBjaWVfaW50YyAyPiwNCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIDwwIDAgMCA0ICZwY2llX2ludGMgMz47DQo+ID4gKyAgICAgICAg
ICAgIHBjaWVfaW50YzogaW50ZXJydXB0LWNvbnRyb2xsZXIgew0KPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgI2FkZHJlc3MtY2VsbHMgPSA8MD47DQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAjaW50ZXJydXB0LWNlbGxzID0gPDE+Ow0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgaW50
ZXJydXB0LWNvbnRyb2xsZXI7DQo+ID4gKyAgICAgICAgICAgIH07DQo+ID4gKyAgICAgICAgfTsN
Cj4gPiArICAgIH07DQo+ID4gLS0gDQo+ID4gMi4yNS4xDQoNCg==

