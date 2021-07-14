Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4113C83BD
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jul 2021 13:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbhGNLXN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Jul 2021 07:23:13 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:34994 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S239252AbhGNLXN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Jul 2021 07:23:13 -0400
X-UUID: 9e8e18d3f251481dad6f4a190c7ce515-20210714
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=JvxaiGfMsn7QBnaqj6qePbCrrXbpLHrwC0rk4w7ViDc=;
        b=sbz3OeVTXFtBumuY38Rq1MKrRmoRIIaGKIPQhOqcbuIdIemzVL2I1/g3MMo6AIdJr9jTQnK4WzVho3wknUxYK+Duzfj8ZGlKTTdh8xRHnZfMAjzJ4zZm+Z9H5E0DmViR9gazXPZBqw1ifPo9Ue/OuFqLHLLxRSmb3n8c2OJIYn0=;
X-UUID: 9e8e18d3f251481dad6f4a190c7ce515-20210714
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1090164648; Wed, 14 Jul 2021 19:20:19 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 14 Jul
 2021 19:20:13 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 14 Jul 2021 19:20:12 +0800
Message-ID: <1626261612.8134.1.camel@mhfsdcap03>
Subject: Re: [PATCH v3 1/2] dt-bindings: PCI: mediatek-gen3: Add property to
 disable dvfsrc voltage request
From:   Jianjun Wang <jianjun.wang@mediatek.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Qizhong Cheng <qizhong.cheng@mediatek.com>
CC:     Ryder Lee <ryder.lee@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <youlin.pei@mediatek.com>,
        <chuanjia.liu@mediatek.com>, <ot_jiey.yang@mediatek.com>,
        <drinkcat@chromium.org>, <Rex-BC.Chen@mediatek.com>,
        Krzysztof Wilczyski <kw@linux.com>, <Ryan-JH.Yu@mediatek.com>
Date:   Wed, 14 Jul 2021 19:20:12 +0800
In-Reply-To: <1625024423.20084.12.camel@mhfsdcap03>
References: <20210630024934.18903-1-jianjun.wang@mediatek.com>
         <20210630024934.18903-2-jianjun.wang@mediatek.com>
         <1625024423.20084.12.camel@mhfsdcap03>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 2BFD83614F95DED623F532636757125FFAAE8188D0AA27564AC8C064EC7B622D2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGksDQoNCkp1c3QgZ2VudGxlIHBpbmcgZm9yIHRoaXMgcGF0Y2ggc2V0LCBwbGVhc2Uga2luZGx5
IGxldCBtZSBrbm93IHlvdXINCmNvbW1lbnRzIGFib3V0IHRoaXMgcGF0Y2ggc2V0Lg0KDQpUaGFu
a3MuDQoNCk9uIFdlZCwgMjAyMS0wNi0zMCBhdCAxMTo0MCArMDgwMCwgUWl6aG9uZyBDaGVuZyB3
cm90ZToNCj4gUmV2aWV3ZWQtYnk6IFFpemhvbmcgQ2hlbmcgPHFpemhvbmcuY2hlbmdAbWVkaWF0
ZWsuY29tPg0KPiBUZXN0ZWQtYnk6IFFpemhvbmcgQ2hlbmcgPHFpemhvbmcuY2hlbmdAbWVkaWF0
ZWsuY29tPg0KPiANCj4gT24gV2VkLCAyMDIxLTA2LTMwIGF0IDEwOjQ5ICswODAwLCBKaWFuanVu
IFdhbmcgd3JvdGU6DQo+ID4gQWRkIHByb3BlcnR5IHRvIGRpc2FibGUgZHZmc3JjIHZvbHRhZ2Ug
cmVxdWVzdCwgaWYgdGhpcyBwcm9wZXJ0eQ0KPiA+IGlzIHByZXNlbnRlZCwgd2UgYXNzdW1lIHRo
YXQgdGhlIHJlcXVlc3RlZCB2b2x0YWdlIGlzIGFsd2F5cw0KPiA+IGhpZ2hlciBlbm91Z2ggdG8g
a2VlcCB0aGUgUENJZSBjb250cm9sbGVyIGFjdGl2ZS4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5
OiBKaWFuanVuIFdhbmcgPGppYW5qdW4ud2FuZ0BtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4g
IC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9tZWRpYXRlay1wY2llLWdlbjMueWFtbCAgICAg
ICB8IDggKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKQ0KPiA+
IA0KPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNp
L21lZGlhdGVrLXBjaWUtZ2VuMy55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3BjaS9tZWRpYXRlay1wY2llLWdlbjMueWFtbA0KPiA+IGluZGV4IGU3YjFmOTg5MmRhNC4u
M2UyNmMwMzJjZWE5IDEwMDY0NA0KPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9wY2kvbWVkaWF0ZWstcGNpZS1nZW4zLnlhbWwNCj4gPiArKysgYi9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL21lZGlhdGVrLXBjaWUtZ2VuMy55YW1sDQo+ID4g
QEAgLTk2LDYgKzk2LDEyIEBAIHByb3BlcnRpZXM6DQo+ID4gICAgcGh5czoNCj4gPiAgICAgIG1h
eEl0ZW1zOiAxDQo+ID4gIA0KPiA+ICsgIGRpc2FibGUtZHZmc3JjLXZsdC1yZXE6DQo+ID4gKyAg
ICBkZXNjcmlwdGlvbjogRGlzYWJsZSBkdmZzcmMgdm9sdGFnZSByZXF1ZXN0LCBpZiB0aGlzIHBy
b3BlcnR5IGlzIHByZXNlbnRlZCwNCj4gPiArICAgICAgd2UgYXNzdW1lIHRoYXQgdGhlIHJlcXVl
c3RlZCB2b2x0YWdlIGlzIGFsd2F5cyBoaWdoZXIgZW5vdWdoIHRvIGtlZXANCj4gPiArICAgICAg
dGhlIFBDSWUgY29udHJvbGxlciBhY3RpdmUuDQo+ID4gKyAgICB0eXBlOiBib29sZWFuDQo+ID4g
Kw0KPiA+ICAgICcjaW50ZXJydXB0LWNlbGxzJzoNCj4gPiAgICAgIGNvbnN0OiAxDQo+ID4gIA0K
PiA+IEBAIC0xNjYsNiArMTcyLDggQEAgZXhhbXBsZXM6DQo+ID4gICAgICAgICAgICAgICAgICAg
ICAgIDwmaW5mcmFjZmdfcnN0IDM+Ow0KPiA+ICAgICAgICAgICAgICByZXNldC1uYW1lcyA9ICJw
aHkiLCAibWFjIjsNCj4gPiAgDQo+ID4gKyAgICAgICAgICAgIGRpc2FibGUtZHZmc3JjLXZsdC1y
ZXE7DQo+ID4gKw0KPiA+ICAgICAgICAgICAgICAjaW50ZXJydXB0LWNlbGxzID0gPDE+Ow0KPiA+
ICAgICAgICAgICAgICBpbnRlcnJ1cHQtbWFwLW1hc2sgPSA8MCAwIDAgMHg3PjsNCj4gPiAgICAg
ICAgICAgICAgaW50ZXJydXB0LW1hcCA9IDwwIDAgMCAxICZwY2llX2ludGMgMD4sDQo+IA0KPiAN
Cg0K

