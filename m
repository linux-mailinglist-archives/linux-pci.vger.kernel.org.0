Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB3B3260FD
	for <lists+linux-pci@lfdr.de>; Fri, 26 Feb 2021 11:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbhBZKJv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Feb 2021 05:09:51 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:24657 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231208AbhBZKHo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Feb 2021 05:07:44 -0500
X-UUID: fc30d3fd80e648dda72a3f05d36f43bd-20210226
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=PVKSM4Lm1Un0eIRTe/LnvU17Suj/+2hi3zvhdZHUu3o=;
        b=VNoxE7uO5d+hskiokRvh5NMeX97PSMud89+8mUkO5zowKa5zxj/WQPEjR3H34xXIKNvzQqao6xtHvSXTfyY2SCIvu9VEIB103OxdWhhjvz0IgIjdFbts6j9e7ZVkTLI46uA//I/RuAdGSZm4eQtFSqEWLWs2/ELmQL5fwpit21E=;
X-UUID: fc30d3fd80e648dda72a3f05d36f43bd-20210226
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1566552519; Fri, 26 Feb 2021 18:06:52 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 26 Feb
 2021 18:06:44 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 26 Feb 2021 18:06:43 +0800
Message-ID: <1614334003.25750.17.camel@mhfsdcap03>
Subject: Re: [v8,6/7] PCI: mediatek-gen3: Add system PM support
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
Date:   Fri, 26 Feb 2021 18:06:43 +0800
In-Reply-To: <YDgeAoYHgiAyU16a@rocinante>
References: <20210224061132.26526-1-jianjun.wang@mediatek.com>
         <20210224061132.26526-7-jianjun.wang@mediatek.com>
         <YDZeRc6CHV/WzyCm@rocinante> <1614224089.25750.14.camel@mhfsdcap03>
         <YDgeAoYHgiAyU16a@rocinante>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 83325A2427D844602B40EF0F0B42549976481FE7C785EA4C1A7D7650DD31D3DD2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQpUaGFua3MgZm9yIHlvdXIgc3VnZ2VzdGlvbiwgSSB3aWxsIGZpeCBp
dCBpbiB0aGUgbmV4dCB2ZXJzaW9uLg0KDQpPbiBUaHUsIDIwMjEtMDItMjUgYXQgMjM6MDAgKzAx
MDAsIEtyenlzenRvZiBXaWxjennFhHNraSB3cm90ZToNCj4gSGkgSmlhbmp1biwNCj4gDQo+IFsu
Li5dDQo+ID4gVGhhbmtzIGZvciB5b3VyIHJldmlldywNCj4gDQo+IFRoYW5rIFlPVSBmb3IgYWxs
IHRoZSB3b3JrIGhlcmUhDQo+ICANCj4gWy4uLl0NCj4gPiA+ID4gQWRkIHN1c3BlbmRfbm9pcnEg
YW5kIHJlc3VtZV9ub2lycSBjYWxsYmFjayBmdW5jdGlvbnMgdG8gaW1wbGVtZW50DQo+ID4gPiA+
IFBNIHN5c3RlbSBzdXNwZW5kIGhvb2tzIGZvciBNZWRpYVRlayBHZW4zIFBDSWUgY29udHJvbGxl
ci4NCj4gPiA+IA0KPiA+ID4gU28sICJzeXN0ZW1zIHN1c3BlbmQiIGFuZCAicmVzdW1lIiBob29r
cywgY29ycmVjdD8NCj4gPiANCj4gPiBUaGUgY2FsbGJhY2sgZnVuY3Rpb25zIGlzIHN1c3BlbmRf
bm9pcnEgYW5kIHJlc3VtZV9ub2lycSwgc2hvdWxkIEkgdXNlDQo+ID4gInN5c3RlbXMgc3VzcGVu
ZCIgYW5kICJyZXN1bWUiIGluIHRoZSBjb21taXQgbWVzc2FnZT8NCj4gWy4uLl0NCj4gDQo+IA0K
PiBXaGF0IEkgbWVhbnQgd2FzIHNvbWV0aGluZyBhbG9uZyB0aGVzZSBsaW5lczoNCj4gDQo+ICAg
QWRkIHN1c3BlbmRfbm9pcnEgYW5kIHJlc3VtZV9ub2lycSBjYWxsYmFjayBmdW5jdGlvbnMgdG8g
aW1wbGVtZW50IFBNDQo+ICAgc3lzdGVtIHN1c3BlbmQgYW5kIHJlc3VtZSBob29rcyBmb3IgdGhl
IE1lZGlhVGVrIEdlbjMgUENJZSBjb250cm9sbGVyLg0KPiAgIA0KPiAgIFdoZW4gdGhlIHN5c3Rl
bSBzdXNwZW5kcywgdHJpZ2dlciB0aGUgUENJZSBsaW5rIHRvIGVudGVyIHRoZSBMMiBzdGF0ZQ0K
PiAgIGFuZCBwdWxsIGRvd24gdGhlIFBFUlNUIyBwaW4sIGdhdGluZyB0aGUgY2xvY2tzIG9mIHRo
ZSBNQUMgbGF5ZXIsIGFuZA0KPiAgIHRoZW4gcG93ZXItb2ZmIHRoZSBwaHlzaWNhbCBsYXllciB0
byBwcm92aWRlIHBvd2VyLXNhdmluZy4NCj4gICANCj4gICBXaGVuIHRoZSBzeXN0ZW0gcmVzdW1l
cywgdGhlIFBDSWUgbGluayBzaG91bGQgYmUgcmUtZXN0YWJsaXNoZWQgYW5kIHRoZQ0KPiAgIHJl
bGF0ZWQgY29udHJvbCByZWdpc3RlciB2YWx1ZXMgc2hvdWxkIGJlIHJlc3RvcmVkLg0KPiANCj4g
VGhlIGFib3ZlIGlzIGp1c3QgYSBzdWdnZXN0aW9uLCB0aHVzIGZlZWwgdHJlZSB0byBpZ25vcmUg
aXQgY29tcGxldGVseSwNCj4gYW5kIGl0J3MgaGVhdmlseSBiYXNlZCBvbiB5b3VyIG9yaWdpbmFs
IGNvbW1pdCBtZXNzYWdlLg0KPiANCj4gS3J6eXN6dG9mDQoNClRoYW5rcy4NCg0K

