Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B62B2625AB
	for <lists+linux-pci@lfdr.de>; Wed,  9 Sep 2020 05:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbgIIDKg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Sep 2020 23:10:36 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:64706 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728015AbgIIDKe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Sep 2020 23:10:34 -0400
X-UUID: a2974b5376d349bc8e5d23f795aa0d8e-20200909
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=aAEAwDECFXixyNhBd49ROmx+esoPcCLIkxRXsqfgM/k=;
        b=YaIU9tUtTcBJXB3kmzOnruqzpv66F86/fWgAAdAOnnopr4kx2MU5uT66fILQMt14EtNEMHNkeKx9SVf3xzoY9cMwweWtMqK/36oMFZadpv2FNwJOXcMVVy51o4r9nT2y25/4F7+LLrJwLLBX0vsWxNDgvtUmLbTi6N+o8zB1xl8=;
X-UUID: a2974b5376d349bc8e5d23f795aa0d8e-20200909
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 949759035; Wed, 09 Sep 2020 11:10:31 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by mtkmbs08n1.mediatek.inc
 (172.21.101.55) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 9 Sep
 2020 11:10:29 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 9 Sep 2020 11:10:28 +0800
Message-ID: <1599620917.2521.9.camel@mhfsdcap03>
Subject: Re: [v1,1/3] dt-bindings: Add YAML schemas for Gen3 PCIe controller
From:   Jianjun Wang <jianjun.wang@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     <davem@davemloft.net>, Philipp Zabel <p.zabel@pengutronix.de>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        <linux-pci@vger.kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Sj Huang <sj.huang@mediatek.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Date:   Wed, 9 Sep 2020 11:08:37 +0800
In-Reply-To: <20200908195050.GA795070@bogus>
References: <20200907120852.12090-1-jianjun.wang@mediatek.com>
         <20200907120852.12090-2-jianjun.wang@mediatek.com>
         <20200908195050.GA795070@bogus>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVHVlLCAyMDIwLTA5LTA4IGF0IDEzOjUwIC0wNjAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
T24gTW9uLCAwNyBTZXAgMjAyMCAyMDowODo1MCArMDgwMCwgSmlhbmp1biBXYW5nIHdyb3RlOg0K
PiA+IEFkZCBZQU1MIHNjaGVtYXMgZG9jdW1lbnRhdGlvbiBmb3IgR2VuMyBQQ0llIGNvbnRyb2xs
ZXIgb24NCj4gPiBNZWRpYVRlayBTb0NzLg0KPiA+IA0KPiA+IEFja2VkLWJ5OiBSeWRlciBMZWUg
PHJ5ZGVyLmxlZUBtZWRpYXRlay5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogSmlhbmp1biBXYW5n
IDxqaWFuanVuLndhbmdAbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICAuLi4vYmluZGluZ3Mv
cGNpL21lZGlhdGVrLXBjaWUtZ2VuMy55YW1sICAgICAgfCAxNTggKysrKysrKysrKysrKysrKysr
DQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxNTggaW5zZXJ0aW9ucygrKQ0KPiA+ICBjcmVhdGUgbW9k
ZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9tZWRpYXRlay1w
Y2llLWdlbjMueWFtbA0KPiA+IA0KPiANCj4gDQo+IE15IGJvdCBmb3VuZCBlcnJvcnMgcnVubmlu
ZyAnbWFrZSBkdF9iaW5kaW5nX2NoZWNrJyBvbiB5b3VyIHBhdGNoOg0KPiANCj4gRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9tZWRpYXRlay1wY2llLWdlbjMuZXhhbXBsZS5k
dHM6NTUuNTYtNTkuMTk6IFdhcm5pbmcgKHBjaV9kZXZpY2VfcmVnKTogL2V4YW1wbGUtMC9idXMv
cGNpZUAxMTIzMDAwMC9sZWdhY3ktaW50ZXJydXB0LWNvbnRyb2xsZXI6IG1pc3NpbmcgUENJIHJl
ZyBwcm9wZXJ0eQ0KPiANCj4gDQo+IFNlZSBodHRwczovL3BhdGNod29yay5vemxhYnMub3JnL3Bh
dGNoLzEzNTkxMTkNCj4gDQo+IElmIHlvdSBhbHJlYWR5IHJhbiAnbWFrZSBkdF9iaW5kaW5nX2No
ZWNrJyBhbmQgZGlkbid0IHNlZSB0aGUgYWJvdmUNCj4gZXJyb3IocyksIHRoZW4gbWFrZSBzdXJl
IGR0LXNjaGVtYSBpcyB1cCB0byBkYXRlOg0KPiANCj4gcGlwMyBpbnN0YWxsIGdpdCtodHRwczov
L2dpdGh1Yi5jb20vZGV2aWNldHJlZS1vcmcvZHQtc2NoZW1hLmdpdEBtYXN0ZXIgLS11cGdyYWRl
DQo+IA0KPiBQbGVhc2UgY2hlY2sgYW5kIHJlLXN1Ym1pdC4NCj4gDQoNClllcywgSSBoYXZlIGFs
cmVhZHkgZm91bmQgdGhpcyB3YXJuaW5nIG1lc3NhZ2UsIGJ1dCBJJ20gY29uZnVzZWQgd2l0aA0K
aG93IHRvIGFkZCB0aGlzIHJlZyBwcm9wZXJ0eSwgc2luY2UgdGhlIGludGVycnVwdC1jb250cm9s
bGVyIGhhcyBpbmhlcml0DQp0aGUgcGNpIGRldmljZSB0eXBlIGJ1dCBkb2VzIG5vdCBoYXZlIGl0
cyBvd24gcmVnaXN0ZXJzLg0KDQpDb3VsZCB5b3UgcGxlYXNlIHRlbGwgbWUgaG93IHRvIGZpeCB0
aGlzIGVycm9yLCBvciB3aGljaCBkb2NzIGNhbiBJDQpyZWZlciB0bz8NCg0KVGhhbmtzLg0K

