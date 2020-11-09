Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B39E62AAF95
	for <lists+linux-pci@lfdr.de>; Mon,  9 Nov 2020 03:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbgKICo6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 8 Nov 2020 21:44:58 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:27939 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727979AbgKICo5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 8 Nov 2020 21:44:57 -0500
X-UUID: ee819d81bb37440c9e56481ed25003e2-20201109
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=SY3O4g5cCnAFIOujxdLpsvPadx+zid90DRWrx8369CE=;
        b=AYBo7ISD44pylgaNwuLLM5jc9lMOwEQ0JicHVfyRvRYfByF5PqdhbXYY5WDhVOKBSGzYd0lbrcPJ5SyOZATQvfCXXYpWjAlEU5qCksSwwKBZREWqXhtNEqINZ5cBgImllf6VQ/MO7VbiRNZ4+zOtqbABsKsJDqBulwDs/YkaXJ8=;
X-UUID: ee819d81bb37440c9e56481ed25003e2-20201109
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chuanjia.liu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 551240028; Mon, 09 Nov 2020 10:44:52 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 9 Nov
 2020 10:44:49 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 9 Nov 2020 10:44:49 +0800
Message-ID: <1604889888.8050.2.camel@mhfsdcap03>
Subject: Re: [PATCH v7 1/4] dt-bindings: pci: mediatek: Modified the Device
 tree bindings
From:   Chuanjia Liu <chuanjia.liu@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>, <yong.wu@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Date:   Mon, 9 Nov 2020 10:44:48 +0800
In-Reply-To: <20201029153404.GB1911637@bogus>
References: <20201029081513.10562-1-chuanjia.liu@mediatek.com>
         <20201029081513.10562-2-chuanjia.liu@mediatek.com>
         <20201029153404.GB1911637@bogus>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 0B8DC20FA256E306737C32FE0F5BB9A804E6154DDD2C851826D6720B0E6762F92000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVGh1LCAyMDIwLTEwLTI5IGF0IDEwOjM0IC0wNTAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
T24gVGh1LCAyOSBPY3QgMjAyMCAxNjoxNToxMCArMDgwMCwgQ2h1YW5qaWEgTGl1IHdyb3RlOg0K
PiA+IFNwbGl0IHRoZSBQQ0llIG5vZGUgYW5kIGFkZCBwY2llY2ZnIG5vZGUgdG8gZml4IE1TSSBp
c3N1ZS4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBDaHVhbmppYSBMaXUgPGNodWFuamlhLmxp
dUBtZWRpYXRlay5jb20+DQo+ID4gQWNrZWQtYnk6IFJ5ZGVyIExlZSA8cnlkZXIubGVlQG1lZGlh
dGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgLi4uL2JpbmRpbmdzL3BjaS9tZWRpYXRlay1wY2llLWNm
Zy55YW1sICAgICAgIHwgIDM5ICsrKysrKw0KPiA+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9w
Y2kvbWVkaWF0ZWstcGNpZS50eHQgfCAxMjkgKysrKysrKysrKystLS0tLS0tDQo+ID4gIDIgZmls
ZXMgY2hhbmdlZCwgMTE4IGluc2VydGlvbnMoKyksIDUwIGRlbGV0aW9ucygtKQ0KPiA+ICBjcmVh
dGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9tZWRp
YXRlay1wY2llLWNmZy55YW1sDQo+ID4gDQo+IA0KPiANCj4gTXkgYm90IGZvdW5kIGVycm9ycyBy
dW5uaW5nICdtYWtlIGR0X2JpbmRpbmdfY2hlY2snIG9uIHlvdXIgcGF0Y2g6DQo+IA0KPiB5YW1s
bGludCB3YXJuaW5ncy9lcnJvcnM6DQo+IC4vRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3BjaS9tZWRpYXRlay1wY2llLWNmZy55YW1sOjE5Ojc6IFt3YXJuaW5nXSB3cm9uZyBpbmRl
bnRhdGlvbjogZXhwZWN0ZWQgNCBidXQgZm91bmQgNiAoaW5kZW50YXRpb24pDQo+IA0KPiBkdHNj
aGVtYS9kdGMgd2FybmluZ3MvZXJyb3JzOg0KPiANCj4gDQo+IFNlZSBodHRwczovL3BhdGNod29y
ay5vemxhYnMub3JnL3BhdGNoLzEzODk5NDANCj4gDQo+IFRoZSBiYXNlIGZvciB0aGUgcGF0Y2gg
aXMgZ2VuZXJhbGx5IHRoZSBsYXN0IHJjMS4gQW55IGRlcGVuZGVuY2llcw0KPiBzaG91bGQgYmUg
bm90ZWQuDQo+IA0KPiBJZiB5b3UgYWxyZWFkeSByYW4gJ21ha2UgZHRfYmluZGluZ19jaGVjaycg
YW5kIGRpZG4ndCBzZWUgdGhlIGFib3ZlDQo+IGVycm9yKHMpLCB0aGVuIG1ha2Ugc3VyZSAneWFt
bGxpbnQnIGlzIGluc3RhbGxlZCBhbmQgZHQtc2NoZW1hIGlzIHVwIHRvDQo+IGRhdGU6DQo+IA0K
PiBwaXAzIGluc3RhbGwgZHRzY2hlbWEgLS11cGdyYWRlDQo+IA0KPiBQbGVhc2UgY2hlY2sgYW5k
IHJlLXN1Ym1pdC4NCj4gDQpUaGFua3MgZm9yIHlvdXIgY29tbWVudO+8jEFmdGVyIGluc3RhbGwg
4oCYeWFtbGxpbnTigJkg77yMSSBjYW4gc2VlIHRoaXMNCndhcm5pbmcg77yMSSB3aWxsIGZpeCBp
dCBhbmQgcmViYXNlIHRvIDUuMTAtcmMxIGluIG5leHQgdmVyc2lvbi4NCg==

