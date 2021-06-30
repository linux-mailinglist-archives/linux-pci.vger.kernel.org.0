Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC9B3B7C27
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jun 2021 05:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233199AbhF3DnD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Jun 2021 23:43:03 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:55493 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232373AbhF3Dm7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Jun 2021 23:42:59 -0400
X-UUID: 50b005d2c5b0406f98065ae3087202b3-20210630
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=/nGVkr6rIatMfAOPxcJiFy+Lah+mHvqzDrJW7I9oyG4=;
        b=Y7YKCtteZjkYo1Lj0Wo3T4lSsiDYx1H2+6VjGl/hjDsPnooxsvImfEYZLtKdLiPG95o7Xu56NGx/3ELnmq7Cn1c1VXPNVNVUvzzYZsoZBapXyh/2iN8Ams/3YH8ky7fKV3dHQGQ8KxBzQGb52Ur8KY6SfK6djiURmUGQP3S5Xvc=;
X-UUID: 50b005d2c5b0406f98065ae3087202b3-20210630
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <qizhong.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 912788740; Wed, 30 Jun 2021 11:40:27 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 30 Jun 2021 11:40:25 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 30 Jun 2021 11:40:23 +0800
Message-ID: <1625024423.20084.12.camel@mhfsdcap03>
Subject: Re: [PATCH v3 1/2] dt-bindings: PCI: mediatek-gen3: Add property to
 disable dvfsrc voltage request
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
        <chuanjia.liu@mediatek.com>, <ot_jiey.yang@mediatek.com>,
        <drinkcat@chromium.org>, <Rex-BC.Chen@mediatek.com>,
        Krzysztof Wilczyski <kw@linux.com>, <Ryan-JH.Yu@mediatek.com>
Date:   Wed, 30 Jun 2021 11:40:23 +0800
In-Reply-To: <20210630024934.18903-2-jianjun.wang@mediatek.com>
References: <20210630024934.18903-1-jianjun.wang@mediatek.com>
         <20210630024934.18903-2-jianjun.wang@mediatek.com>
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
IEFkZCBwcm9wZXJ0eSB0byBkaXNhYmxlIGR2ZnNyYyB2b2x0YWdlIHJlcXVlc3QsIGlmIHRoaXMg
cHJvcGVydHkNCj4gaXMgcHJlc2VudGVkLCB3ZSBhc3N1bWUgdGhhdCB0aGUgcmVxdWVzdGVkIHZv
bHRhZ2UgaXMgYWx3YXlzDQo+IGhpZ2hlciBlbm91Z2ggdG8ga2VlcCB0aGUgUENJZSBjb250cm9s
bGVyIGFjdGl2ZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEppYW5qdW4gV2FuZyA8amlhbmp1bi53
YW5nQG1lZGlhdGVrLmNvbT4NCj4gLS0tDQo+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kv
bWVkaWF0ZWstcGNpZS1nZW4zLnlhbWwgICAgICAgfCA4ICsrKysrKysrDQo+ICAxIGZpbGUgY2hh
bmdlZCwgOCBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9tZWRpYXRlay1wY2llLWdlbjMueWFtbCBiL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvbWVkaWF0ZWstcGNpZS1nZW4zLnlhbWwNCj4g
aW5kZXggZTdiMWY5ODkyZGE0Li4zZTI2YzAzMmNlYTkgMTAwNjQ0DQo+IC0tLSBhL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvbWVkaWF0ZWstcGNpZS1nZW4zLnlhbWwNCj4g
KysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9tZWRpYXRlay1wY2ll
LWdlbjMueWFtbA0KPiBAQCAtOTYsNiArOTYsMTIgQEAgcHJvcGVydGllczoNCj4gICAgcGh5czoN
Cj4gICAgICBtYXhJdGVtczogMQ0KPiAgDQo+ICsgIGRpc2FibGUtZHZmc3JjLXZsdC1yZXE6DQo+
ICsgICAgZGVzY3JpcHRpb246IERpc2FibGUgZHZmc3JjIHZvbHRhZ2UgcmVxdWVzdCwgaWYgdGhp
cyBwcm9wZXJ0eSBpcyBwcmVzZW50ZWQsDQo+ICsgICAgICB3ZSBhc3N1bWUgdGhhdCB0aGUgcmVx
dWVzdGVkIHZvbHRhZ2UgaXMgYWx3YXlzIGhpZ2hlciBlbm91Z2ggdG8ga2VlcA0KPiArICAgICAg
dGhlIFBDSWUgY29udHJvbGxlciBhY3RpdmUuDQo+ICsgICAgdHlwZTogYm9vbGVhbg0KPiArDQo+
ICAgICcjaW50ZXJydXB0LWNlbGxzJzoNCj4gICAgICBjb25zdDogMQ0KPiAgDQo+IEBAIC0xNjYs
NiArMTcyLDggQEAgZXhhbXBsZXM6DQo+ICAgICAgICAgICAgICAgICAgICAgICA8JmluZnJhY2Zn
X3JzdCAzPjsNCj4gICAgICAgICAgICAgIHJlc2V0LW5hbWVzID0gInBoeSIsICJtYWMiOw0KPiAg
DQo+ICsgICAgICAgICAgICBkaXNhYmxlLWR2ZnNyYy12bHQtcmVxOw0KPiArDQo+ICAgICAgICAg
ICAgICAjaW50ZXJydXB0LWNlbGxzID0gPDE+Ow0KPiAgICAgICAgICAgICAgaW50ZXJydXB0LW1h
cC1tYXNrID0gPDAgMCAwIDB4Nz47DQo+ICAgICAgICAgICAgICBpbnRlcnJ1cHQtbWFwID0gPDAg
MCAwIDEgJnBjaWVfaW50YyAwPiwNCg0K

