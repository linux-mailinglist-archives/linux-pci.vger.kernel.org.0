Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C17C23FEB69
	for <lists+linux-pci@lfdr.de>; Thu,  2 Sep 2021 11:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245590AbhIBJfS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Sep 2021 05:35:18 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:41156 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S245186AbhIBJfS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Sep 2021 05:35:18 -0400
X-UUID: 85c7b912786f47d1a103bd5831e8bd65-20210902
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=ZPDQyXrInu0IQssPczuqbUdeSDCOSdcmMPprWdZX5fA=;
        b=ukqblwj6wBxjKfQ9K3+7xnfsoyB0O6uqn2flde0iLc3SJ6TQLE1O9XpQUD0OXepxMyPaaZMXY3UHBZ1tgk/V3x83glIWsq9IlPJX3vzcsgEqevi5CNtjqfz+DTwBPLoOc30fIZ9IJs7Vhqn//1Gj0gtcjyestb8P90h5A9q995Q=;
X-UUID: 85c7b912786f47d1a103bd5831e8bd65-20210902
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <chuanjia.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1573750120; Thu, 02 Sep 2021 17:34:10 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 2 Sep 2021 17:34:09 +0800
Received: from mhfsdcap04 (10.17.3.154) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 2 Sep 2021 17:34:06 +0800
Message-ID: <eb855d186d572e8a0343456bb5d76797f8f3870f.camel@mediatek.com>
Subject: Re: [PATCH v12 2/6] PCI: mediatek: Add new method to get shared
 pcie-cfg base address
From:   Chuanjia Liu <chuanjia.liu@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        "Jianjun Wang" <jianjun.wang@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>,
        PCI <linux-pci@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Thu, 2 Sep 2021 17:34:08 +0800
In-Reply-To: <CAL_Jsq+dBi-XUDJD_STP=jWw+RLkRpX1U9XsRMhqK4U1H=0FHw@mail.gmail.com>
References: <20210830214317.GA27606@bjorn-Precision-5520>
         <ccf767340afe13a6d273ad8fbc29c6bc966d6314.camel@mediatek.com>
         <CAL_Jsq+dBi-XUDJD_STP=jWw+RLkRpX1U9XsRMhqK4U1H=0FHw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVHVlLCAyMDIxLTA4LTMxIGF0IDEwOjE3IC0wNTAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
T24gTW9uLCBBdWcgMzAsIDIwMjEgYXQgMTA6MzEgUE0gQ2h1YW5qaWEgTGl1IDwNCj4gY2h1YW5q
aWEubGl1QG1lZGlhdGVrLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gT24gTW9uLCAyMDIxLTA4LTMw
IGF0IDE2OjQzIC0wNTAwLCBCam9ybiBIZWxnYWFzIHdyb3RlOg0KPiA+ID4gT24gTW9uLCBBdWcg
MzAsIDIwMjEgYXQgMDM6MDk6NDRQTSArMDgwMCwgQ2h1YW5qaWEgTGl1IHdyb3RlOg0KPiA+ID4g
PiBPbiBGcmksIDIwMjEtMDgtMjcgYXQgMTE6NDYgLTA1MDAsIEJqb3JuIEhlbGdhYXMgd3JvdGU6
DQo+ID4gPiA+ID4gT24gTW9uLCBBdWcgMjMsIDIwMjEgYXQgMTE6Mjc6NTZBTSArMDgwMCwgQ2h1
YW5qaWEgTGl1IHdyb3RlOg0KPiA+ID4gPiA+ID4gQEAgLTk5NSw2ICsxMDA0LDE0IEBAIHN0YXRp
YyBpbnQNCj4gPiA+ID4gPiA+IG10a19wY2llX3N1YnN5c19wb3dlcnVwKHN0cnVjdA0KPiA+ID4g
PiA+ID4gbXRrX3BjaWUgKnBjaWUpDQo+ID4gPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAg
ICByZXR1cm4gUFRSX0VSUihwY2llLT5iYXNlKTsNCj4gPiA+ID4gPiA+ICAgICAgICAgfQ0KPiA+
ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiArICAgICAgIGNmZ19ub2RlID0gb2ZfZmluZF9jb21wYXRp
YmxlX25vZGUoTlVMTCwgTlVMTCwNCj4gPiA+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAibWVkaWF0ZWssZ2VuZXJpDQo+ID4gPiA+ID4gPiBjLQ0KPiA+
ID4gPiA+ID4gcGNpZWNmZyIpOw0KPiA+ID4gPiA+ID4gKyAgICAgICBpZiAoY2ZnX25vZGUpIHsN
Cj4gPiA+ID4gPiA+ICsgICAgICAgICAgICAgICBwY2llLT5jZmcgPQ0KPiA+ID4gPiA+ID4gc3lz
Y29uX25vZGVfdG9fcmVnbWFwKGNmZ19ub2RlKTsNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBPdGhl
ciBkcml2ZXJzIGluIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvIHVzZQ0KPiA+ID4gPiA+IHN5c2Nv
bl9yZWdtYXBfbG9va3VwX2J5X3BoYW5kbGUoKSAoajcyMWUsIGRyYTd4eCwga2V5c3RvbmUsDQo+
ID4gPiA+ID4gbGF5ZXJzY2FwZSwgYXJ0cGVjNikgb3Igc3lzY29uX3JlZ21hcF9sb29rdXBfYnlf
Y29tcGF0aWJsZSgpDQo+ID4gPiA+ID4gKGlteDYsDQo+ID4gPiA+ID4ga2lyaW4sIHYzLXNlbWkp
Lg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IFlvdSBzaG91bGQgZG8gaXQgdGhlIHNhbWUgd2F5IHVu
bGVzcyB0aGVyZSdzIGEgbmVlZCB0byBiZQ0KPiA+ID4gPiA+IGRpZmZlcmVudC4NCj4gPiA+ID4g
DQo+ID4gPiA+IEkgaGF2ZSB1c2VkIHBoYW5kbGUsIGJ1dCBSb2Igc3VnZ2VzdGVkIHRvIHNlYXJj
aCBmb3IgdGhlIG5vZGUNCj4gPiA+ID4gYnkNCj4gPiA+ID4gY29tcGF0aWJsZS4NCj4gPiA+ID4g
VGhlIHJlYXNvbiB3aHkgc3lzY29uX3JlZ21hcF9sb29rdXBfYnlfY29tcGF0aWJsZSgpIGlzIG5v
dA0KPiA+ID4gPiB1c2VkIGhlcmUgaXMgdGhhdCB0aGUgcGNpZWNmZyBub2RlIGlzIG9wdGlvbmFs
LCBhbmQgdGhlcmUgaXMgbm8NCj4gPiA+ID4gbmVlZCB0bw0KPiA+ID4gPiByZXR1cm4gZXJyb3Ig
d2hlbiB0aGUgbm9kZSBpcyBub3Qgc2VhcmNoZWQuDQo+ID4gPiANCj4gPiA+IEhvdyBhYm91dCB0
aGlzPw0KPiA+ID4gDQo+ID4gPiAgIHJlZ21hcCA9IHN5c2Nvbl9yZWdtYXBfbG9va3VwX2J5X2Nv
bXBhdGlibGUoIm1lZGlhdGVrLGdlbmVyaWMtDQo+ID4gPiBwY2llY2ZnIik7DQo+ID4gPiAgIGlm
ICghSVNfRVJSKHJlZ21hcCkpDQo+ID4gPiAgICAgcGNpZS0+Y2ZnID0gcmVnbWFwOw0KPiANCj4g
KzENCj4gDQo+ID4gDQo+ID4gSGkgQmpvcm4sDQo+ID4gDQo+ID4gV2UgbmVlZCB0byBkZWFsIHdp
dGggdGhyZWUgc2l0dWF0aW9ucw0KPiA+IDEpIE5vIGVycm9yDQo+ID4gMikgVGhlIGVycm9yIG9m
IHRoZSBub2RlIG5vdCBmb3VuZCwgZG9uJ3QgZG8gYW55dGhpbmcNCj4gPiAzKSBPdGhlciBlcnJv
cnMsIHJldHVybiBlcnJvcnMNCj4gPiANCj4gPiBJIGd1ZXNzIHlvdSBtZWFuDQo+ID4gDQo+ID4g
cmVnbWFwID0gc3lzY29uX3JlZ21hcF9sb29rdXBfYnlfY29tcGF0aWJsZSgibWVkaWF0ZWssZ2Vu
ZXJpYy0NCj4gPiBwY2llY2ZnIik7DQo+ID4gICBpZiAoIUlTX0VSUihyZWdtYXApKQ0KPiA+ICAg
ICAgIHBjaWUtPmNmZyA9IHJlZ21hcDsNCj4gPiAgIGVsc2UgaWYgKElTX0VSUihyZWdtYXApICYm
IFBUUl9FUlIocmVnbWFwKSAhPSAtRU5PREVWKQ0KPiANCj4gWW91IGFscmVhZHkga25vdyAgSVNf
RVJSIGlzIHRydWUgaGVyZS4NCj4gDQo+ID4gICAgICAgcmV0dXJuIFBUUl9FUlIocmVnbWFwKTsN
Cj4gDQo+IHN5c2Nvbl9yZWdtYXBfbG9va3VwX2J5X2NvbXBhdGlibGVfb3B0aW9uYWwgaXMgdGhl
IGZ1bmN0aW9uIHlvdSBhcmUNCj4gbG9va2luZyBmb3IuIFRoZSBfb3B0aW9uYWwgZmxhdm9yIGRv
ZXNuJ3QgZXhpc3QsIHNvIGNyZWF0ZSBpdC4gVGhlcmUNCj4gaXMgb25lIGZvciB0aGUgcGhhbmRs
ZSBsb29rdXAuDQo+IA0KPiA+IA0KPiA+IEknbSBub3Qgc3VyZSBpZiB3ZSBuZWVkIHRoaXMsIGl0
IHNlZW1zIGEgbGl0dGxlIHdlaXJkIGFuZCB0aGVyZSBhcmUNCj4gPiBtYW55IGRyaXZlcnMgaW4g
b3RoZXIgc3Vic3lzdGVtcyB0aGF0IHVzZSBzeXNjb25fbm9kZV90b19yZWdtYXAoKS4NCj4gDQo+
IFlvdSBhcmUgaW1wbGVtZW50aW5nIHRoZSBleGFjdCBzYW1lIHNlcXVlbmNlIHRoYXQNCj4gc3lz
Y29uX3JlZ21hcF9sb29rdXBfYnlfY29tcGF0aWJsZSgpIGRvZXMsIHNvIGNsZWFybHkgeW91IHNo
b3VsZCBiZQ0KPiB1c2luZyBpdC4gVGhlIG9uZSBkaWZmZXJlbmNlIGlzIHlvdSBmb3Jnb3QgdGhl
IG9mX25vZGVfcHV0KCkuDQoNCkhpLFJvYg0KVGhhbmtzIGZvciB5b3VyIGV4cGxhbmF0aW9uLiBZ
b3UncmUgcmlnaHQuIA0KTm93IEkgdW5kZXJzdGFuZCB1c2Ugc3lzY29uX3JlZ21hcF9sb29rdXBf
YnlfY29tcGF0aWJsZSgpIGlzIGEgYmV0dGVyDQp3YXkuIEknbGwgZm9sbG93IHlvdXIgYWR2aWNl
DQogDQpyZWdtYXAgPSBzeXNjb25fcmVnbWFwX2xvb2t1cF9ieV9jb21wYXRpYmxlKCJtZWRpYXRl
ayxnZW5lcmljLQ0KcGNpZWNmZyIpOw0KaWYgKCFJU19FUlIocmVnbWFwKSkNCglwY2llLT5jZmcg
PSByZWdtYXA7DQplbHNlIGlmIChQVFJfRVJSKHJlZ21hcCkgIT0gLUVOT0RFVikNCglyZXR1cm4g
UFRSX0VSUihyZWdtYXApOw0KDQpCZXN0IHJlZ2FyZHMNCkNodWFuamlhDQogDQo+IA0KPiBSb2IN
Cj4gDQo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+
IExpbnV4LW1lZGlhdGVrIG1haWxpbmcgbGlzdA0KPiBMaW51eC1tZWRpYXRla0BsaXN0cy5pbmZy
YWRlYWQub3JnDQo+IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8v
bGludXgtbWVkaWF0ZWsNCg==

