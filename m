Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DDC8100954
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2019 17:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfKRQkj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Nov 2019 11:40:39 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34157 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbfKRQkj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Nov 2019 11:40:39 -0500
Received: by mail-pg1-f195.google.com with SMTP id z188so9904145pgb.1;
        Mon, 18 Nov 2019 08:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:thread-topic:thread-index:date:message-id
         :references:in-reply-to:accept-language:content-language
         :content-transfer-encoding:mime-version;
        bh=p5SywVCocMd9ya0JNpOso+/ORGB190xCpItnE3UfFD4=;
        b=bgFCWKf0IKfiULDsstu31UWnHtJoqJomHuu1G3gq5upSK3KmFK4XxAaYmyAAj0Di2R
         2PUWpMOIdbsGDSynQc2F46VvAgC133ol/WKFDplaM2ELD69gXEseQNN0JqGqo6lWregU
         oDjy9pX+VZy9t74jraPiUKoYnWYtI4ITS1BoEjACXKVvbBLilaCG2JZrEkRO0NShceNH
         W5n4LXHqZqUXU5tc6289VOugyawukkGAY1xzM4FRxGw9mc+ExrQJEzTbghznB80jqMuM
         RrVycOJkfMdomHiSavZri/ZuYHeVv7Jm3HIxr5TcUyX1IeuWf95aAi8NeN0vEZnSgUOT
         oxPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:thread-topic:thread-index
         :date:message-id:references:in-reply-to:accept-language
         :content-language:content-transfer-encoding:mime-version;
        bh=p5SywVCocMd9ya0JNpOso+/ORGB190xCpItnE3UfFD4=;
        b=VqpLbB7vUlnxfoMvmK9EU2aw1ysmtS+Z9nxmc558uQvjU3YlGXS6SXSWmwMPT8+PS8
         H5EruMXokimNWjYIJwYPlE8EEjtWOfYWcA8zNbfP7ji9pNUIdM4OZFvSg2aZqdI/QZF1
         aukhUZZ0XTZh9TVZQOd64CEaI+5moQw3cTjCyyH2N4Xlp2vBFzP1fmSCy8eP33menhcb
         CeMUc4vzmidXFn5VVoDcybZl5YbUozoeqYp4KxFjKYdCEPLCf4KRH2G+697+Seg6RwCv
         c/X5m7vhwE3beAShYR/SIScrfOqQ5U6vnLxQ7sU5lUcdhE0tP0X1avkDcRMBp9fmKRbz
         NKHA==
X-Gm-Message-State: APjAAAVmm/tfIBqX22ucBOoGkgET8OfQP3amwYX8209WFCdkioipqgFk
        7Kx0vNZ7LgIq1n9Ut9HG2Zg=
X-Google-Smtp-Source: APXvYqwMPGnZ0XoXqmgSHLgeU0V5LjHi2upXPsRYLXlfrilJofUC5QCwXzqRXLrTnbk44JsRa+qLzg==
X-Received: by 2002:a65:4ccf:: with SMTP id n15mr238992pgt.248.1574095238249;
        Mon, 18 Nov 2019 08:40:38 -0800 (PST)
Received: from SL2P216MB0105.KORP216.PROD.OUTLOOK.COM ([2603:1046:100:22::5])
        by smtp.gmail.com with ESMTPSA id d7sm23979171pfc.180.2019.11.18.08.40.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Nov 2019 08:40:36 -0800 (PST)
From:   Jingoo Han <jingoohan1@gmail.com>
To:     Dilip Kota <eswara.kota@linux.intel.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "andrew.murray@arm.com" <andrew.murray@arm.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "martin.blumenstingl@googlemail.com" 
        <martin.blumenstingl@googlemail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "andriy.shevchenko@intel.com" <andriy.shevchenko@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "cheol.yong.kim@intel.com" <cheol.yong.kim@intel.com>,
        "chuanhua.lei@linux.intel.com" <chuanhua.lei@linux.intel.com>,
        "qi-ming.wu@intel.com" <qi-ming.wu@intel.com>,
        Han Jingoo <jingoohan1@gmail.com>
Subject: Re: [PATCH v7 2/3] dwc: PCI: intel: PCIe RC controller driver
Thread-Topic: [PATCH v7 2/3] dwc: PCI: intel: PCIe RC controller driver
Thread-Index: AWFpLjhmZ+kaqs+V1bNkFtdnCOgh+TA3NDEw5ue194CAAJG7GQ==
X-MS-Exchange-MessageSentRepresentingType: 1
Date:   Mon, 18 Nov 2019 16:40:30 +0000
Message-ID: <SL2P216MB010580C028A7F88E8FB72574AA4D0@SL2P216MB0105.KORP216.PROD.OUTLOOK.COM>
References: <cover.1573784557.git.eswara.kota@linux.intel.com>
 <99a29f5a4ce18df26bd300ac6728433ec025631b.1573784557.git.eswara.kota@linux.intel.com>
 <SL2P216MB01056231B6036941BEF71738AA700@SL2P216MB0105.KORP216.PROD.OUTLOOK.COM>
 <50dabbc6-eae5-5ae5-95a0-f195c1ef7362@linux.intel.com>
In-Reply-To: <50dabbc6-eae5-5ae5-95a0-f195c1ef7362@linux.intel.com>
Accept-Language: ko-KR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-Exchange-Organization-SCL: -1
X-MS-TNEF-Correlator: 
X-MS-Exchange-Organization-RecordReviewCfmType: 0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DQoNCu+7v09uIDExLzE4LzE5LCAyOjU4IEFNLCBEaWxpcCBLb3RhIHdyb3RlOg0KDQo+IE9uIDEx
LzE2LzIwMTkgNDo0MCBBTSwgSmluZ29vIEhhbiB3cm90ZToNCj4gPiBPbiAxMS8xNC8xOSwgOToz
MSBQTSwgRGlsaXAgS290YSB3cm90ZToNCj4gPg0KPiA+PiBBZGQgc3VwcG9ydCB0byBQQ0llIFJD
IGNvbnRyb2xsZXIgb24gSW50ZWwgR2F0ZXdheSBTb0NzLg0KPiA+PiBQQ0llIGNvbnRyb2xsZXIg
aXMgYmFzZWQgb2YgU3lub3BzeXMgRGVzaWduV2FyZSBQQ0llIGNvcmUuDQo+ID4+DQo+ID4+IElu
dGVsIFBDSWUgZHJpdmVyIHJlcXVpcmVzIFVwY29uZmlndXJlIHN1cHBvcnQsIEZhc3QgVHJhaW5p
bmcNCj4gPj4gU2VxdWVuY2UgYW5kIGxpbmsgc3BlZWQgY29uZmlndXJhdGlvbnMuIFNvIGFkZGlu
ZyB0aGUgcmVzcGVjdGl2ZQ0KPiA+PiBoZWxwZXIgZnVuY3Rpb25zIGluIHRoZSBQQ0llIERlc2ln
bldhcmUgZnJhbWV3b3JrLg0KPiA+PiBJdCBhbHNvIHByb2dyYW1zIGhhcmR3YXJlIGF1dG9ub21v
dXMgc3BlZWQgZHVyaW5nIHNwZWVkDQo+ID4+IGNvbmZpZ3VyYXRpb24gc28gZGVmaW5pbmcgaXQg
aW4gcGNpX3JlZ3MuaC4NCj4gPj4NCj4gPj4gU2lnbmVkLW9mZi1ieTogRGlsaXAgS290YSA8ZXN3
YXJhLmtvdGFAbGludXguaW50ZWwuY29tPg0KPiA+PiBSZXZpZXdlZC1ieTogQW5kcmV3IE11cnJh
eSA8YW5kcmV3Lm11cnJheUBhcm0uY29tPg0KPiA+PiBBY2tlZC1ieTogR3VzdGF2byBQaW1lbnRl
bCA8Z3VzdGF2by5waW1lbnRlbEBzeW5vcHN5cy5jb20+DQo+ID4+IC0tLQ0KPiA+IFsuLi4uLl0N
Cj4gPg0KPiA+PiAgIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL0tjb25maWcgICAgICAgICAg
IHwgIDEwICsNCj4gPj4gICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9NYWtlZmlsZSAgICAg
ICAgICB8ICAgMSArDQo+ID4+ICAgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNp
Z253YXJlLmMgfCAgNTcgKysrDQo+ID4+ICAgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNp
ZS1kZXNpZ253YXJlLmggfCAgMTIgKw0KPiA+PiAgIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdj
L3BjaWUtaW50ZWwtZ3cuYyAgIHwgNTQyICsrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+
PiAgIGluY2x1ZGUvdWFwaS9saW51eC9wY2lfcmVncy5oICAgICAgICAgICAgICAgIHwgICAxICsN
Cj4gPj4gICA2IGZpbGVzIGNoYW5nZWQsIDYyMyBpbnNlcnRpb25zKCspDQo+ID4+ICAgY3JlYXRl
IG1vZGUgMTAwNjQ0IGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtaW50ZWwtZ3cuYw0K
PiA+Pg0KPiA+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvS2NvbmZp
ZyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL0tjb25maWcNCj4gPj4gaW5kZXggMGJhOTg4
YjViNWJjLi5mYjZkNDc0NDc3ZGYgMTAwNjQ0DQo+ID4+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRy
b2xsZXIvZHdjL0tjb25maWcNCj4gPj4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2Mv
S2NvbmZpZw0KPiA+PiBAQCAtODIsNiArODIsMTYgQEAgY29uZmlnIFBDSUVfRFdfUExBVF9FUA0K
PiA+PiAgIAkgIG9yZGVyIHRvIGVuYWJsZSBkZXZpY2Utc3BlY2lmaWMgZmVhdHVyZXMgUENJX0RX
X1BMQVRfRVAgbXVzdCBiZQ0KPiA+PiAgIAkgIHNlbGVjdGVkLg0KPiA+PiAgIA0KPiA+PiArY29u
ZmlnIFBDSUVfSU5URUxfR1cNCj4gPj4gKwlib29sICJJbnRlbCBHYXRld2F5IFBDSWUgaG9zdCBj
b250cm9sbGVyIHN1cHBvcnQiDQo+ID4+ICsJZGVwZW5kcyBvbiBPRiAmJiAoWDg2IHx8IENPTVBJ
TEVfVEVTVCkNCj4gPj4gKwlzZWxlY3QgUENJRV9EV19IT1NUDQo+ID4+ICsJaGVscA0KPiA+PiAr
CSAgU2F5ICdZJyBoZXJlIHRvIGVuYWJsZSBQQ0llIEhvc3QgY29udHJvbGxlciBzdXBwb3J0IG9u
IEludGVsDQo+ID4+ICsJICBHYXRld2F5IFNvQ3MuDQo+ID4+ICsJICBUaGUgUENJZSBjb250cm9s
bGVyIHVzZXMgdGhlIERlc2lnbldhcmUgY29yZSBwbHVzIEludGVsLXNwZWNpZmljDQo+ID4+ICsJ
ICBoYXJkd2FyZSB3cmFwcGVycy4NCj4gPj4gKw0KPiA+IFBsZWFzZSBhZGQgdGhpcyBjb25maWcg
YWxwaGFiZXRpY2FsIG9yZGVyIQ0KPiA+IFNvLCB0aGlzIGNvbmZpZyBzaG91bGQgYmUgYWZ0ZXIg
J2NvbmZpZyBQQ0lfSU1YNicuDQo+ID4gVGhlcmUgaXMgbm8gcmVhc29uIHRvIHB1dCB0aGlzIGNv
bmZpZyBhdCB0aGUgZmlyc3QgcGxhY2UuDQo+ID4NCj4gPj4gICBjb25maWcgUENJX0VYWU5PUw0K
PiA+PiAgIAlib29sICJTYW1zdW5nIEV4eW5vcyBQQ0llIGNvbnRyb2xsZXIiDQo+ID4+ICAgCWRl
cGVuZHMgb24gU09DX0VYWU5PUzU0NDAgfHwgQ09NUElMRV9URVNUDQo+ID4+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9NYWtlZmlsZSBiL2RyaXZlcnMvcGNpL2NvbnRy
b2xsZXIvZHdjL01ha2VmaWxlDQo+ID4+IGluZGV4IGIzMDMzNjE4MWQ0Ni4uOTlkYjgzY2QyZjM1
IDEwMDY0NA0KPiA+PiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9NYWtlZmlsZQ0K
PiA+PiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9NYWtlZmlsZQ0KPiA+PiBAQCAt
Myw2ICszLDcgQEAgb2JqLSQoQ09ORklHX1BDSUVfRFcpICs9IHBjaWUtZGVzaWdud2FyZS5vDQo+
ID4+ICAgb2JqLSQoQ09ORklHX1BDSUVfRFdfSE9TVCkgKz0gcGNpZS1kZXNpZ253YXJlLWhvc3Qu
bw0KPiA+PiAgIG9iai0kKENPTkZJR19QQ0lFX0RXX0VQKSArPSBwY2llLWRlc2lnbndhcmUtZXAu
bw0KPiA+PiAgIG9iai0kKENPTkZJR19QQ0lFX0RXX1BMQVQpICs9IHBjaWUtZGVzaWdud2FyZS1w
bGF0Lm8NCj4gPj4gK29iai0kKENPTkZJR19QQ0lFX0lOVEVMX0dXKSArPSBwY2llLWludGVsLWd3
Lm8NCj4gPiBEaXR0by4NCj4gUENJRV9JTlRFTF9HVyB3b3VsZG50IGNvbWUgYWZ0ZXIgUENJX0lN
WDYsIHRoZSBjb21wbGV0ZSBNYWtlZmlsZSBhbmQgDQo+IEtjb25maWcgYXJlIG5vdCBpbiBvcmRl
ciwoIFBDSV8qIGFuZCBQQ0lFXyogYXJlIG5vdCBpbiBhbnkgb3JkZXIpLiBTbyBpIA0KPiBqdXN0
IGZvbGxvd2VkIFBDSUVfRFcgYW5kIHBsYWNlZCBQQ0lFX0lOVEVMX0dXIGFmdGVyIFBDSUVfRFcg
YXMgSSBpcyANCj4gYWZ0ZXIgRCAoYW5kIGkgc2VlIFBDSV8qIGltbWVkaWF0ZWx5IGFmdGVyIHRo
ZSBQQ0lFX0RXKiwgc28gaSBwbGFjZWQgDQo+IFBDSUVfSU5URUxfR1cgYWZ0ZXIgUENJRV9EVyog
YW5kIGJlZm9yZSBQQ0lfKikuDQoNCkhleSwgYWx0aG91Z2ggc29tZSBvZiB0aGVtIGFyZSBub3Qg
aW4gb3JkZXIsIHlvdSBkb24ndCBoYXZlIGEgcmlnaHQgdG8gZG8gc28uDQpJZiBzb21lIHBlb3Bs
ZSBkbyBub3QgZm9sbG93IHRoZSBsYXcsIGl0IGRvZXMgbm90IG1lYW4gdGhhdCB5b3UgY2FuIGJy
ZWFrIHRoZSBsYXcuDQpBbnl3YXksIGlmIHlvdSBkb24ndCBmb2xsb3cgYW4gYWxwaGFiZXRpY2Fs
IG9yZGVyLCBteSBhbnN3ZXIgaXMgTkFDSy4NCkFsc28sIG90aGVyIHBlb3BsZSBvciBJIHdpbGwg
c2VuZCBhIHBhdGNoIHRvIGZpeCB0aGUgb3JkZXIgb2Ygb3RoZXIgZHJpdmVycy4NCg0KDQo+IFJl
Z2FyZHMsDQo+IERpbGlwDQoNCj4NCj4gQmVzdCByZWdhcmRzLA0KPiBKaW5nb28gSGFuDQo+DQo+
PiAgIG9iai0kKENPTkZJR19QQ0lfRFJBN1hYKSArPSBwY2ktZHJhN3h4Lm8NCj4+ICAgb2JqLSQo
Q09ORklHX1BDSV9FWFlOT1MpICs9IHBjaS1leHlub3Mubw0KPj4gICBvYmotJChDT05GSUdfUENJ
X0lNWDYpICs9IHBjaS1pbXg2Lm8NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9s
bGVyL2R3Yy9wY2llLWRlc2lnbndhcmUuYyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3Bj
aWUtZGVzaWdud2FyZS5jDQo+PiBpbmRleCA4MjA0ODhkZmVhZWQuLjQ3OWUyNTA2OTVhMCAxMDA2
NDQNCj4gWy4uLi4uXQ0K
