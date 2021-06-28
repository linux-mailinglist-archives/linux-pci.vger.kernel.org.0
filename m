Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E13B63B5A36
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jun 2021 10:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbhF1IGS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Jun 2021 04:06:18 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:17526 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229911AbhF1IGS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Jun 2021 04:06:18 -0400
X-UUID: 37a9a923059e48819e7bcb92db666673-20210628
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=UyCUoWq5C8H8X3Ls/9jw1l30aSnsYNS8MIqI3Jdte34=;
        b=NQShitKfmMb479YptqZkariH15y33S2g8+NDnwgUZ+eDrNkMRyFunmkMb7By0jVUIZSbsLMJqa2tFzr9mtZZChfk+abZn0TBa5ACznHKLh+5bkm38UEgRgGO8Ekd5hBsQJPM211xrhtYh9OPpy8oPpP01bUSxJ+/bQaXIaZWDag=;
X-UUID: 37a9a923059e48819e7bcb92db666673-20210628
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1510859484; Mon, 28 Jun 2021 16:03:45 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 28 Jun
 2021 16:03:36 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 28 Jun 2021 16:03:35 +0800
Message-ID: <1624867415.19871.7.camel@mhfsdcap03>
Subject: Re: [PATCH v2 1/2] dt-bindings: PCI: mediatek-gen3: Add property to
 disable dvfsrc voltage request
From:   Jianjun Wang <jianjun.wang@mediatek.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Ryder Lee <ryder.lee@mediatek.com>, <linux-pci@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <youlin.pei@mediatek.com>,
        <chuanjia.liu@mediatek.com>, <qizhong.cheng@mediatek.com>,
        <sin_jieyang@mediatek.com>, <drinkcat@chromium.org>,
        <Rex-BC.Chen@mediatek.com>, Krzysztof Wilczyski <kw@linux.com>,
        <Ryan-JH.Yu@mediatek.com>
Date:   Mon, 28 Jun 2021 16:03:35 +0800
In-Reply-To: <20210611114824.14537-2-jianjun.wang@mediatek.com>
References: <20210611114824.14537-1-jianjun.wang@mediatek.com>
         <20210611114824.14537-2-jianjun.wang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 3C847F0C72EE72988F88A8EF8A8CFC570617985F93A7278597666503F0F909702000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgUm9iLCBCam9ybiwgTWF0dGhpYXMsDQoNCkNvdWxkIHlvdSBwbGVhc2UgaGVscCB0byB0YWtl
IGEgbG9vayBhdCB0aGlzIHBhdGNoIHNlcmllcz8NCg0KV2UgaGF2ZSBkb25lIHRoZSBpbnRlcm5h
bCB0ZXN0cyBhbmQgbmVlZCB0byBpbXBsZW1lbnQgdGhpcyBmdW5jdGlvbiBpbg0KdGhlIGZpbmFs
IHByb2R1Y3QsIFdlIHJlYWxseSBuZWVkIHlvdXIgc3VnZ2VzdGlvbnMuDQoNClRoYW5rcy4NCg0K
T24gRnJpLCAyMDIxLTA2LTExIGF0IDE5OjQ4ICswODAwLCBKaWFuanVuIFdhbmcgd3JvdGU6DQo+
IEFkZCBwcm9wZXJ0eSB0byBkaXNhYmxlIGR2ZnNyYyB2b2x0YWdlIHJlcXVlc3QsIGlmIHRoaXMg
cHJvcGVydHkNCj4gaXMgcHJlc2VudGVkLCB3ZSBhc3N1bWUgdGhhdCB0aGUgcmVxdWVzdGVkIHZv
bHRhZ2UgaXMgYWx3YXlzDQo+IGhpZ2hlciBlbm91Z2ggdG8ga2VlcCB0aGUgUENJZSBjb250cm9s
bGVyIGFjdGl2ZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEppYW5qdW4gV2FuZyA8amlhbmp1bi53
YW5nQG1lZGlhdGVrLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IFFpemhvbmcgQ2hlbmcgPHFpemhvbmcu
Y2hlbmdAbWVkaWF0ZWsuY29tPg0KPiBUZXN0ZWQtYnk6IFFpemhvbmcgQ2hlbmcgPHFpemhvbmcu
Y2hlbmdAbWVkaWF0ZWsuY29tPg0KPiAtLS0NCj4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Bj
aS9tZWRpYXRlay1wY2llLWdlbjMueWFtbCAgICAgICB8IDggKysrKysrKysNCj4gIDEgZmlsZSBj
aGFuZ2VkLCA4IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvcGNpL21lZGlhdGVrLXBjaWUtZ2VuMy55YW1sIGIvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9tZWRpYXRlay1wY2llLWdlbjMueWFtbA0K
PiBpbmRleCBlN2IxZjk4OTJkYTQuLjNlMjZjMDMyY2VhOSAxMDA2NDQNCj4gLS0tIGEvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9tZWRpYXRlay1wY2llLWdlbjMueWFtbA0K
PiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL21lZGlhdGVrLXBj
aWUtZ2VuMy55YW1sDQo+IEBAIC05Niw2ICs5NiwxMiBAQCBwcm9wZXJ0aWVzOg0KPiAgICBwaHlz
Og0KPiAgICAgIG1heEl0ZW1zOiAxDQo+ICANCj4gKyAgZGlzYWJsZS1kdmZzcmMtdmx0LXJlcToN
Cj4gKyAgICBkZXNjcmlwdGlvbjogRGlzYWJsZSBkdmZzcmMgdm9sdGFnZSByZXF1ZXN0LCBpZiB0
aGlzIHByb3BlcnR5IGlzIHByZXNlbnRlZCwNCj4gKyAgICAgIHdlIGFzc3VtZSB0aGF0IHRoZSBy
ZXF1ZXN0ZWQgdm9sdGFnZSBpcyBhbHdheXMgaGlnaGVyIGVub3VnaCB0byBrZWVwDQo+ICsgICAg
ICB0aGUgUENJZSBjb250cm9sbGVyIGFjdGl2ZS4NCj4gKyAgICB0eXBlOiBib29sZWFuDQo+ICsN
Cj4gICAgJyNpbnRlcnJ1cHQtY2VsbHMnOg0KPiAgICAgIGNvbnN0OiAxDQo+ICANCj4gQEAgLTE2
Niw2ICsxNzIsOCBAQCBleGFtcGxlczoNCj4gICAgICAgICAgICAgICAgICAgICAgIDwmaW5mcmFj
ZmdfcnN0IDM+Ow0KPiAgICAgICAgICAgICAgcmVzZXQtbmFtZXMgPSAicGh5IiwgIm1hYyI7DQo+
ICANCj4gKyAgICAgICAgICAgIGRpc2FibGUtZHZmc3JjLXZsdC1yZXE7DQo+ICsNCj4gICAgICAg
ICAgICAgICNpbnRlcnJ1cHQtY2VsbHMgPSA8MT47DQo+ICAgICAgICAgICAgICBpbnRlcnJ1cHQt
bWFwLW1hc2sgPSA8MCAwIDAgMHg3PjsNCj4gICAgICAgICAgICAgIGludGVycnVwdC1tYXAgPSA8
MCAwIDAgMSAmcGNpZV9pbnRjIDA+LA0KDQo=

