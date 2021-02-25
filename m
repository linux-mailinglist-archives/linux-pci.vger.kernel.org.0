Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96E63324946
	for <lists+linux-pci@lfdr.de>; Thu, 25 Feb 2021 04:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235960AbhBYDLm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Feb 2021 22:11:42 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:5522 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S235745AbhBYDLi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Feb 2021 22:11:38 -0500
X-UUID: 853e14c8a2d044ef8095201542d43cb8-20210225
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=8AfxQgMLd5LAOyHUuhbTLCDggQdgcP/KVwPluxawHEI=;
        b=Np7Elwv0qmDQN7s5zBQSUifBPwgKxBYmhoh55d72XYgiAnkm0+21XQ2hFC4vxAkOyR15kw3FT1ZGSq7yUB/1Eo+MNIR+7Fp7EpoMMTkT+d4KJspj2+W/vgXIbARArwynKvc5+ZDCHO8Qd4WbZWFVQsjKcK+/+nto3wZiEl48Tek=;
X-UUID: 853e14c8a2d044ef8095201542d43cb8-20210225
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 883676415; Thu, 25 Feb 2021 11:10:53 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 25 Feb
 2021 11:10:47 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 25 Feb 2021 11:10:46 +0800
Message-ID: <1614222646.25750.8.camel@mhfsdcap03>
Subject: Re: [v8,4/7] PCI: mediatek-gen3: Add INTx support
From:   Jianjun Wang <jianjun.wang@mediatek.com>
To:     Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
CC:     Bjorn Helgaas <helgaas@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <maz@kernel.org>,
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
Date:   Thu, 25 Feb 2021 11:10:46 +0800
In-Reply-To: <YDZhuwbgdUsnBD/0@rocinante>
References: <20210224061132.26526-1-jianjun.wang@mediatek.com>
         <20210224061132.26526-5-jianjun.wang@mediatek.com>
         <YDZhuwbgdUsnBD/0@rocinante>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 4481712F5FD8DB778D110BBC2B7BB028FF4AF1B4B16E4CAF6ACB5AA1DB123F3D2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQpUaGFua3MgZm9yIHlvdXIgcmV2aWV3LCBJIHdpbGwgZml4IGl0IGF0
IG5leHQgdmVyc2lvbi4NCg0KT24gV2VkLCAyMDIxLTAyLTI0IGF0IDE1OjI0ICswMTAwLCBLcnp5
c3p0b2YgV2lsY3p5xYRza2kgd3JvdGU6DQo+IEhpIEppYW5qdW4sDQo+IA0KPiBbLi4uXQ0KPiA+
ICsvKioNCj4gPiArICogbXRrX2ludHhfZW9pDQo+ID4gKyAqIEBkYXRhOiBwb2ludGVyIHRvIGNo
aXAgc3BlY2lmaWMgZGF0YQ0KPiA+ICsgKg0KPiA+ICsgKiBBcyBhbiBlbXVsYXRlZCBsZXZlbCBJ
UlEsIGl0cyBpbnRlcnJ1cHQgc3RhdHVzIHdpbGwgcmVtYWluDQo+ID4gKyAqIHVudGlsIHRoZSBj
b3JyZXNwb25kaW5nIGRlLWFzc2VydCBtZXNzYWdlIGlzIHJlY2VpdmVkOyBoZW5jZSB0aGF0DQo+
ID4gKyAqIHRoZSBzdGF0dXMgY2FuIG9ubHkgYmUgY2xlYXJlZCB3aGVuIHRoZSBpbnRlcnJ1cHQg
aGFzIGJlZW4gc2VydmljZWQuDQo+ID4gKyAqLw0KPiBbLi4uXQ0KPiANCj4gU2VlIG15IGNvbW1l
bnQgYWJvdXQgdGhlIGtlcm5lbC1kb2MgZnJvbSB0aGUgZm9sbG93aW5nOg0KPiANCj4gICBodHRw
czovL2xvcmUua2VybmVsLm9yZy9saW51eC1wY2kvWURaV1VHY0tldCUyRmxOV2xGQHJvY2luYW50
ZS8NCj4gDQo+IFsuLi5dDQo+ID4gKwlpZiAoZXJyKSB7DQo+ID4gKwkJZGV2X2VycihkZXYsICJm
YWlsZWQgdG8gaW5pdCBQQ0llIElSUSBkb21haW5cbiIpOw0KPiA+ICsJCXJldHVybiBlcnI7DQo+
ID4gKwl9DQo+IFsuLi5dDQo+IA0KPiBKdXN0IGEgbml0cGljay4gIFdoYXQgYWJvdXQgdXNpbmcg
ImluaXRpYWxpemUiIGluIHRoZSBhYm92ZT8NCj4gDQo+IEtyenlzenRvZg0KDQpUaGFua3MuDQoN
Cg==

