Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4494026891E
	for <lists+linux-pci@lfdr.de>; Mon, 14 Sep 2020 12:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgINKTl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Sep 2020 06:19:41 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:11951 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726354AbgINKTj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Sep 2020 06:19:39 -0400
X-UUID: 8070a8dc389a49bd8b984d19dcc73aaf-20200914
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=UFFhIqTpIhOC8ywBiZxNU/Fzmn0uEHIkBJSLINsLE0Q=;
        b=FScmXuDbVALdHyYP9WfqZFQx8KVyk5Iu8aIKVexmokooEG+ltCHNeKASUGS04jCjFUuopg4fHds1JO0VKfZ9CS5ROpyIirl99n+9uDLeZhXOVI3WxbiYJ5zNuhiR51+Tv9OUjd/A5T2k97OfSdmoai99UzTovgJCOCZ0SPY40Ac=;
X-UUID: 8070a8dc389a49bd8b984d19dcc73aaf-20200914
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1558188983; Mon, 14 Sep 2020 18:19:32 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by mtkmbs08n2.mediatek.inc
 (172.21.101.56) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 14 Sep
 2020 18:19:28 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 14 Sep 2020 18:19:24 +0800
Message-ID: <1600078643.2521.25.camel@mhfsdcap03>
Subject: Re: [v2,2/3] PCI: mediatek: Add new generation controller support
From:   Jianjun Wang <jianjun.wang@mediatek.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        <davem@davemloft.net>, <linux-pci@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Sj Huang <sj.huang@mediatek.com>
Date:   Mon, 14 Sep 2020 18:17:23 +0800
In-Reply-To: <1ac4ba40a031169b968e3084c132579db921033c.camel@pengutronix.de>
References: <20200910034536.30860-1-jianjun.wang@mediatek.com>
         <20200910034536.30860-3-jianjun.wang@mediatek.com>
         <1ac4ba40a031169b968e3084c132579db921033c.camel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 89BC645EE2B99813BCD4031077703FE9AC259110623EE3A7D12DBB813A2C08D72000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gRnJpLCAyMDIwLTA5LTExIGF0IDE2OjMzICswMjAwLCBQaGlsaXBwIFphYmVsIHdyb3RlOg0K
PiBIaSBKaWFuanVuLA0KPiANCj4gT24gVGh1LCAyMDIwLTA5LTEwIGF0IDExOjQ1ICswODAwLCBK
aWFuanVuIFdhbmcgd3JvdGU6DQo+ID4gTWVkaWFUZWsncyBQQ0llIGhvc3QgY29udHJvbGxlciBo
YXMgdGhyZWUgZ2VuZXJhdGlvbiBIV3MsIHRoZSBuZXcNCj4gPiBnZW5lcmF0aW9uIEhXIGlzIGFu
IGluZGl2aWR1YWwgYnJpZGdlLCBpdCBzdXBvb3J0cyBHZW4zIHNwZWVkIGFuZA0KPiA+IHVwIHRv
IDI1NiBNU0kgaW50ZXJydXB0IG51bWJlcnMgZm9yIG11bHRpLWZ1bmN0aW9uIGRldmljZXMuDQo+
ID4gDQo+ID4gQWRkIHN1cHBvcnQgZm9yIG5ldyBHZW4zIGNvbnRyb2xsZXIgd2hpY2ggY2FuIGJl
IGZvdW5kIG9uIE1UODE5Mi4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBKaWFuanVuIFdhbmcg
PGppYW5qdW4ud2FuZ0BtZWRpYXRlay5jb20+DQo+ID4gQWNrZWQtYnk6IFJ5ZGVyIExlZSA8cnlk
ZXIubGVlQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9wY2kvY29udHJvbGxl
ci9LY29uZmlnICAgICAgICAgICAgICB8ICAgMTQgKw0KPiA+ICBkcml2ZXJzL3BjaS9jb250cm9s
bGVyL01ha2VmaWxlICAgICAgICAgICAgIHwgICAgMSArDQo+ID4gIGRyaXZlcnMvcGNpL2NvbnRy
b2xsZXIvcGNpZS1tZWRpYXRlay1nZW4zLmMgfCAxMDc2ICsrKysrKysrKysrKysrKysrKysNCj4g
PiAgMyBmaWxlcyBjaGFuZ2VkLCAxMDkxIGluc2VydGlvbnMoKykNCj4gPiAgY3JlYXRlIG1vZGUg
MTAwNjQ0IGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tZWRpYXRlay1nZW4zLmMNCj4gPiAN
Cj4gWy4uLl0NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLW1l
ZGlhdGVrLWdlbjMuYyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tZWRpYXRlay1nZW4z
LmMNCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+IGluZGV4IDAwMDAwMDAwMDAwMC4uZjhj
OGJkZjg4ZDMzDQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRy
b2xsZXIvcGNpZS1tZWRpYXRlay1nZW4zLmMNCj4gWy4uLl0NCj4gPiArc3RhdGljIGludCBtdGtf
cGNpZV9wb3dlcl91cChzdHJ1Y3QgbXRrX3BjaWVfcG9ydCAqcG9ydCkNCj4gPiArew0KPiA+ICsJ
c3RydWN0IGRldmljZSAqZGV2ID0gcG9ydC0+ZGV2Ow0KPiA+ICsJaW50IGVycjsNCj4gPiArDQo+
ID4gKwlwb3J0LT5waHlfcmVzZXQgPSBkZXZtX3Jlc2V0X2NvbnRyb2xfZ2V0X29wdGlvbmFsKGRl
diwgInBoeS1yc3QiKTsNCj4gDQo+IFBsZWFzZSB1c2UgZGV2bV9yZXNldF9jb250cm9sX2dldF9v
cHRpb25hbF9leGNsdXNpdmUoKSBpbnN0ZWFkLg0KPiANCj4gPiArCWlmIChQVFJfRVJSKHBvcnQt
PnBoeV9yZXNldCkgPT0gLUVQUk9CRV9ERUZFUikNCj4gPiArCQlyZXR1cm4gUFRSX0VSUihwb3J0
LT5waHlfcmVzZXQpOw0KPiANCj4gVGhpcyBzaG91bGQgYmUNCj4gDQo+IAlpZiAoSVNfRVJSKHBv
cnQtPnBoeV9yZXNldCkpDQo+IAkJcmV0dXJuIFBUUl9FUlIocG9ydC0+cGh5X3Jlc2V0KTsNCj4g
DQo+IHRoZXJlIGlzIG5vIHJlYXNvbiB0byBjb250aW51ZSBpZiB0aGlzIHRocm93cyAtRU5PTUVN
LCBmb3IgZXhhbXBsZS4NCj4gDQo+IHJlZ2FyZHMNCj4gUGhpbGlwcA0KDQpUaGFua3MgZm9yIHlv
dXIgcmV2aWV3LCBJIHdpbGwgZml4IGl0IGluIHRoZSBuZXh0IHZlcnNpb24uDQoNCg==

