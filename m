Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0F9F32493F
	for <lists+linux-pci@lfdr.de>; Thu, 25 Feb 2021 04:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235661AbhBYDKn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Feb 2021 22:10:43 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:47121 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S235249AbhBYDKk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Feb 2021 22:10:40 -0500
X-UUID: 8f2eef21216a4f76862035cdceb4bf6f-20210225
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=1zp0U8dsDetgT6kM22d52xIB+sQkmxl4ezqgzrOyb3g=;
        b=ebADRC50u0ypJeSXBODAjtlV7jOilV1qHFGC4wYUMh3cbC7lKTA7uyoPl+AuYMe0iGX562DTh5ei+cl3TFqEB1lKSzpmy2pnzPfWI0PGWbdAeZi5aM9WH6gI9lsmNULIqSZ592tDoCmF16Ek8BOz8ah3GsByQS+BPl8k1ZQDdRw=;
X-UUID: 8f2eef21216a4f76862035cdceb4bf6f-20210225
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 352445290; Thu, 25 Feb 2021 11:09:53 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 25 Feb
 2021 11:09:47 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 25 Feb 2021 11:09:46 +0800
Message-ID: <1614222586.25750.7.camel@mhfsdcap03>
Subject: Re: [v8,5/7] PCI: mediatek-gen3: Add MSI support
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
Date:   Thu, 25 Feb 2021 11:09:46 +0800
In-Reply-To: <YDZjOHKmks9ChFQI@rocinante>
References: <20210224061132.26526-1-jianjun.wang@mediatek.com>
         <20210224061132.26526-6-jianjun.wang@mediatek.com>
         <YDZjOHKmks9ChFQI@rocinante>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: EAE103E295B37CA6894E09C61D96B779CBA43719D8E25FE9B54B3F4A000DA6162000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQpUaGFua3MgZm9yIHlvdXIgcmV2aWV3LCBJIHdpbGwgZml4IGl0IGF0
IG5leHQgdmVyc2lvbi4NCg0KT24gV2VkLCAyMDIxLTAyLTI0IGF0IDE1OjMxICswMTAwLCBLcnp5
c3p0b2YgV2lsY3p5xYRza2kgd3JvdGU6DQo+IEhpIEppYW5qdW4sDQo+IA0KPiBbLi4uXQ0KPiA+
ICtzdGF0aWMgc3RydWN0IGlycV9jaGlwIG10a19tc2lfaXJxX2NoaXAgPSB7DQo+ID4gKwkubmFt
ZSA9ICJNU0kiLA0KPiA+ICsJLmlycV9lbmFibGUgPSBtdGtfcGNpZV9pcnFfdW5tYXNrLA0KPiA+
ICsJLmlycV9kaXNhYmxlID0gbXRrX3BjaWVfaXJxX21hc2ssDQo+ID4gKwkuaXJxX2FjayA9IGly
cV9jaGlwX2Fja19wYXJlbnQsDQo+ID4gKwkuaXJxX21hc2sgPSBtdGtfcGNpZV9pcnFfbWFzaywN
Cj4gPiArCS5pcnFfdW5tYXNrID0gbXRrX3BjaWVfaXJxX3VubWFzaywNCj4gPiArfTsNCj4gDQo+
IEZvciBjb25zaXN0ZW5jeSBzYWtlLCB3aGF0IGFib3V0IGFsaWduaW5nIHRoaXMgbGlrZSB0aGUN
Cj4gc3RydWN0IG10a19tc2lfYm90dG9tX2lycV9jaGlwIGhhcyBiZWVuPyAgU2VlIGltbWVkaWF0
ZWx5IGJlbG93Lg0KPiANCj4gWy4uLl0NCj4gPiArc3RhdGljIHN0cnVjdCBpcnFfY2hpcCBtdGtf
bXNpX2JvdHRvbV9pcnFfY2hpcCA9IHsNCj4gPiArCS5pcnFfYWNrCQk9IG10a19tc2lfYm90dG9t
X2lycV9hY2ssDQo+ID4gKwkuaXJxX21hc2sJCT0gbXRrX21zaV9ib3R0b21faXJxX21hc2ssDQo+
ID4gKwkuaXJxX3VubWFzawkJPSBtdGtfbXNpX2JvdHRvbV9pcnFfdW5tYXNrLA0KPiA+ICsJLmly
cV9jb21wb3NlX21zaV9tc2cJPSBtdGtfY29tcG9zZV9tc2lfbXNnLA0KPiA+ICsJLmlycV9zZXRf
YWZmaW5pdHkJPSBtdGtfcGNpZV9zZXRfYWZmaW5pdHksDQo+ID4gKwkubmFtZQkJCT0gIk1TSSIs
DQo+ID4gK307DQo+IA0KPiBLcnp5c3p0b2YNCg0KVGhhbmtzLg0K

