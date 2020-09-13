Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79A70267D5D
	for <lists+linux-pci@lfdr.de>; Sun, 13 Sep 2020 04:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725910AbgIMCwq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 12 Sep 2020 22:52:46 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:34534 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725908AbgIMCwq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 12 Sep 2020 22:52:46 -0400
X-UUID: 21ce4642b0db4c4ca7d760aa9d689c60-20200913
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=sHr/3SgqkGgC0cmR+vYMugDYlp4UjJix+vEWHOHpO8Q=;
        b=Xr4nBJaVRF0yXg5XcgzF8tMYB4lqLQmEByZCEUkKnAllH99qHEssVevHaY50x/DmXxmZBNS4eh7cCl2CYGMnwzPbXtr0Ejvr6LuCWa7BYG4wRXymht+6/RBsfYzDk1ILRSmhwBhKRP57k/fpt251jaECtH8vlYIUPqOIwkEfzqk=;
X-UUID: 21ce4642b0db4c4ca7d760aa9d689c60-20200913
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chuanjia.liu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 116126680; Sun, 13 Sep 2020 10:52:35 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 13 Sep
 2020 10:52:32 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 13 Sep 2020 10:52:31 +0800
Message-ID: <1599965431.7466.32.camel@mhfsdcap03>
Subject: Re: [PATCH v5 1/4] dt-bindings: pci: mediatek: Modified the Device
 tree bindings
From:   Chuanjia Liu <chuanjia.liu@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Ryder Lee <ryder.lee@mediatek.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Rob Herring <robh+dt@kernel.org>, <yong.wu@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-mediatek@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <devicetree@vger.kernel.org>
Date:   Sun, 13 Sep 2020 10:50:31 +0800
In-Reply-To: <20200911224709.GA2960430@bogus>
References: <20200910061115.909-1-chuanjia.liu@mediatek.com>
         <20200910061115.909-2-chuanjia.liu@mediatek.com>
         <20200911224709.GA2960430@bogus>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 12547BB23CCC94C1400331408C8C42EC0E0AF5263CE508083E8DD47762F0BBDA2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gRnJpLCAyMDIwLTA5LTExIGF0IDE2OjQ3IC0wNjAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
T24gVGh1LCAxMCBTZXAgMjAyMCAxNDoxMToxMiArMDgwMCwgQ2h1YW5qaWEgTGl1IHdyb3RlOg0K
PiA+IFNwbGl0IHRoZSBQQ0llIG5vZGUgYW5kIGFkZCBwY2llY2ZnIG5vZGUgdG8gZml4IE1TSSBp
c3N1ZS4NCj4gPiANCj4gPiBBY2tlZC1ieTogUnlkZXIgTGVlIDxyeWRlci5sZWVAbWVkaWF0ZWsu
Y29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IENodWFuamlhIExpdSA8Y2h1YW5qaWEubGl1QG1lZGlh
dGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgLi4uL2JpbmRpbmdzL3BjaS9tZWRpYXRlay1wY2llLWNm
Zy55YW1sICAgICAgIHwgIDM4ICsrKysrDQo+ID4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Bj
aS9tZWRpYXRlay1wY2llLnR4dCB8IDE0NCArKysrKysrKysrKy0tLS0tLS0NCj4gPiAgMiBmaWxl
cyBjaGFuZ2VkLCAxMjkgaW5zZXJ0aW9ucygrKSwgNTMgZGVsZXRpb25zKC0pDQo+ID4gIGNyZWF0
ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL21lZGlh
dGVrLXBjaWUtY2ZnLnlhbWwNCj4gPiANCj4gDQo+IA0KPiBNeSBib3QgZm91bmQgZXJyb3JzIHJ1
bm5pbmcgJ21ha2UgZHRfYmluZGluZ19jaGVjaycgb24geW91ciBwYXRjaDoNCj4gDQo+IC9idWls
ZHMvcm9iaGVycmluZy9saW51eC1kdC1yZXZpZXcvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL3BjaS9tZWRpYXRlay1wY2llLWNmZy5leGFtcGxlLmR0LnlhbWw6IGV4YW1wbGUtMDog
cGNpZWNmZ0AxYTE0MDAwMDpyZWc6MDogWzAsIDQzNzUxODMzNiwgMCwgNDA5Nl0gaXMgdG9vIGxv
bmcNCj4gCUZyb20gc2NoZW1hOiAvdXNyL2xvY2FsL2xpYi9weXRob24zLjgvZGlzdC1wYWNrYWdl
cy9kdHNjaGVtYS9zY2hlbWFzL3JlZy55YW1sDQo+IA0KPiANCj4gU2VlIGh0dHBzOi8vcGF0Y2h3
b3JrLm96bGFicy5vcmcvcGF0Y2gvMTM2MTI0OQ0KPiANCj4gSWYgeW91IGFscmVhZHkgcmFuICdt
YWtlIGR0X2JpbmRpbmdfY2hlY2snIGFuZCBkaWRuJ3Qgc2VlIHRoZSBhYm92ZQ0KPiBlcnJvcihz
KSwgdGhlbiBtYWtlIHN1cmUgZHQtc2NoZW1hIGlzIHVwIHRvIGRhdGU6DQo+IA0KPiBwaXAzIGlu
c3RhbGwgZ2l0K2h0dHBzOi8vZ2l0aHViLmNvbS9kZXZpY2V0cmVlLW9yZy9kdC1zY2hlbWEuZ2l0
QG1hc3RlciAtLXVwZ3JhZGUNCj4gDQo+IFBsZWFzZSBjaGVjayBhbmQgcmUtc3VibWl0Lg0KPiAN
ClRoYW5rcyBmb3IgeW91ciByZXZpZXcsIEkgd2lsbCB1cGRhdGUgbXkgZHQtc2NoZW1hIGFuZCBm
aXggaXQgaW4gbmV4dA0KdmVyc2lvbi4NCg0KcmVnYXJkcywNCkNodWFuamlhDQoNCg==

