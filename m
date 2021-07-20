Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 796943CF1F0
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jul 2021 04:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238066AbhGTBcU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Jul 2021 21:32:20 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:35672 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S242083AbhGTB1A (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Jul 2021 21:27:00 -0400
X-UUID: 77655248267e4d199c82af3a1ebba31a-20210720
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=ttqP5SP7Nx2GRTcelHSglyFAHET3dzB0AdI8DouZgsc=;
        b=azURQ8psTBxX5dAqnrmtcCh0YJGlpJ0PweS3R6SxkwoHH+G8GILROLOK+Wn1d9bFY8z59IDCvJBs3A1SUH9IAQl+BGOaURM7/5PbLLZketKy011L0on43Ghi8tmu3fKtCGXwgvLe85j0C3Qxy825Z4Ooyairm94ctNMzKhBKafE=;
X-UUID: 77655248267e4d199c82af3a1ebba31a-20210720
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <chuanjia.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1464592333; Tue, 20 Jul 2021 10:07:26 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 20 Jul 2021 10:07:24 +0800
Received: from [10.17.3.153] (10.17.3.153) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 20 Jul 2021 10:07:24 +0800
Message-ID: <1626746843.2466.10.camel@mhfsdcap03>
Subject: Re: [PATCH v11 1/4] dt-bindings: PCI: mediatek: Update the Device
 tree bindings
From:   Chuanjia Liu <chuanjia.liu@mediatek.com>
To:     Rob Herring <robh@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-kernel@vger.kernel.org>, <jianjun.wang@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <ryder.lee@mediatek.com>,
        <linux-pci@vger.kernel.org>,
        Frank Wunderlich <frank-w@public-files.de>,
        <devicetree@vger.kernel.org>, <yong.wu@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>
Date:   Tue, 20 Jul 2021 10:07:23 +0800
In-Reply-To: <20210719224718.GA2766057@robh.at.kernel.org>
References: <20210719073456.28666-1-chuanjia.liu@mediatek.com>
         <20210719073456.28666-2-chuanjia.liu@mediatek.com>
         <20210719224718.GA2766057@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gTW9uLCAyMDIxLTA3LTE5IGF0IDE2OjQ3IC0wNjAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
T24gTW9uLCAxOSBKdWwgMjAyMSAxNTozNDo1MyArMDgwMCwgQ2h1YW5qaWEgTGl1IHdyb3RlOg0K
PiA+IFRoZXJlIGFyZSB0d28gaW5kZXBlbmRlbnQgUENJZSBjb250cm9sbGVycyBpbiBNVDI3MTIg
YW5kIE1UNzYyMg0KPiA+IHBsYXRmb3JtLiBFYWNoIG9mIHRoZW0gc2hvdWxkIGNvbnRhaW4gYW4g
aW5kZXBlbmRlbnQgTVNJIGRvbWFpbi4NCj4gPiANCj4gPiBJbiBvbGQgZHRzIGFyY2hpdGVjdHVy
ZSwgTVNJIGRvbWFpbiB3aWxsIGJlIGluaGVyaXRlZCBmcm9tIHRoZSByb290DQo+ID4gYnJpZGdl
LCBhbmQgYWxsIG9mIHRoZSBkZXZpY2VzIHdpbGwgc2hhcmUgdGhlIHNhbWUgTVNJIGRvbWFpbi4N
Cj4gPiBIZW5jZSB0aGF0LCB0aGUgUENJZSBkZXZpY2VzIHdpbGwgbm90IHdvcmsgcHJvcGVybHkg
aWYgdGhlIGlycSBudW1iZXINCj4gPiB3aGljaCByZXF1aXJlZCBpcyBtb3JlIHRoYW4gMzIuDQo+
ID4gDQo+ID4gU3BsaXQgdGhlIFBDSWUgbm9kZSBmb3IgTVQyNzEyIGFuZCBNVDc2MjIgcGxhdGZv
cm0gdG8gY29tcGx5IHdpdGgNCj4gPiB0aGUgaGFyZHdhcmUgZGVzaWduIGFuZCBmaXggTVNJIGlz
c3VlLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IENodWFuamlhIExpdSA8Y2h1YW5qaWEubGl1
QG1lZGlhdGVrLmNvbT4NCj4gPiBBY2tlZC1ieTogUnlkZXIgTGVlIDxyeWRlci5sZWVAbWVkaWF0
ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICAuLi4vYmluZGluZ3MvcGNpL21lZGlhdGVrLXBjaWUtY2Zn
LnlhbWwgICAgICAgfCAgMzkgKysrKw0KPiA+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kv
bWVkaWF0ZWstcGNpZS50eHQgfCAyMDYgKysrKysrKysrKy0tLS0tLS0tDQo+ID4gIDIgZmlsZXMg
Y2hhbmdlZCwgMTUwIGluc2VydGlvbnMoKyksIDk1IGRlbGV0aW9ucygtKQ0KPiA+ICBjcmVhdGUg
bW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9tZWRpYXRl
ay1wY2llLWNmZy55YW1sDQo+ID4gDQo+IA0KPiANCj4gUGxlYXNlIGFkZCBBY2tlZC1ieS9SZXZp
ZXdlZC1ieSB0YWdzIHdoZW4gcG9zdGluZyBuZXcgdmVyc2lvbnMuIEhvd2V2ZXIsDQo+IHRoZXJl
J3Mgbm8gbmVlZCB0byByZXBvc3QgcGF0Y2hlcyAqb25seSogdG8gYWRkIHRoZSB0YWdzLiBUaGUg
dXBzdHJlYW0NCj4gbWFpbnRhaW5lciB3aWxsIGRvIHRoYXQgZm9yIGFja3MgcmVjZWl2ZWQgb24g
dGhlIHZlcnNpb24gdGhleSBhcHBseS4NCj4gDQo+IElmIGEgdGFnIHdhcyBub3QgYWRkZWQgb24g
cHVycG9zZSwgcGxlYXNlIHN0YXRlIHdoeSBhbmQgd2hhdCBjaGFuZ2VkLg0KPiANCkhpLFJvYg0K
SSBoYXZlIGRlc2NyaWJlZCBpbiB0aGUgY292ZXIgbGV0dGVyOg0KdjExOlJlYmFzZSBmb3IgNS4x
NC1yYzEgYW5kIGFkZCAiaW50ZXJydXB0LW5hbWVzIiwgImxpbnV4LHBjaS1kb21haW4iIA0KICAg
IGRlc2NyaXB0aW9uIGluIGJpbmRpbmcgZmlsZS4gTm8gY29kZSBjaGFuZ2UuDQppZiB5b3Ugc3Rp
bGwgb2sgZm9yIHRoaXMsIEkgd2lsbCBhZGQgUi1iIGluIG5leHQgdmVyc2lvbi4NCg0KQmVzdCBy
ZWdhcmRzDQo+IA0KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXw0KPiBMaW51eC1tZWRpYXRlayBtYWlsaW5nIGxpc3QNCj4gTGludXgtbWVkaWF0ZWtAbGlz
dHMuaW5mcmFkZWFkLm9yZw0KPiBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2xpbnV4LW1lZGlhdGVrDQoNCg==

