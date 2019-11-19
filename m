Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1A4B10115C
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2019 03:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfKSCd1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Nov 2019 21:33:27 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42805 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbfKSCd0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Nov 2019 21:33:26 -0500
Received: by mail-pf1-f196.google.com with SMTP id s5so11342284pfh.9;
        Mon, 18 Nov 2019 18:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:thread-topic:thread-index:date:message-id
         :references:in-reply-to:accept-language:content-language
         :content-transfer-encoding:mime-version;
        bh=IbnJ0Ogg4bvtysxvAUVXUl17l2NgDmEwpQLHRAXuZ+c=;
        b=a/Ks4M/+a1nFzrCG2qtfmNoO/svzj/4eYp7vvNovapW2PixeRSskRm+x5lUkWPKhRe
         OFpaBxjE1yVoaKuyv3UvuFgjG+R29ceCdXBfB925sMS0SQZZi4aGmDIFOoWgR73OaMjP
         EZzqtykKet2nGUmI/BJWs0bM6KrBsHteBnd0Sl8ZgmoUoRJ+QJLBDRUrk23JNjymVtBw
         qKJE7cUQVeFXAUuiJ1rhrnN24AIjm0qEdPG+g9PIF7RqxHSMRYwrCjKoFFz5XCHBK4S5
         B83jWeNOW4vzxazKRzBDO5/yDaEkwZaZJL0tyAD6Qb0GGq8y4pxSv4/FKkYuzCrBRQFV
         jbDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:thread-topic:thread-index
         :date:message-id:references:in-reply-to:accept-language
         :content-language:content-transfer-encoding:mime-version;
        bh=IbnJ0Ogg4bvtysxvAUVXUl17l2NgDmEwpQLHRAXuZ+c=;
        b=NQorUXfG36IqOpkdCxRqFwAOXYTTC4/L/kVc9zu7FTmKnuJFEykqkD9c23kuXHa0Ig
         v/Vqz6ABlGIn04yFwVA5u4fdHxVtv8ZTlpojOoYGcTOHjRYB0E/wNxLAQGaff3dGmDHF
         uvmFXwEljDmy1atNGmSE3rO/BeqQjAYhLkSCrFxHuQFiUWoBvV0IcZqj26/ufuBofA/S
         HooowOJOOHD6gLI3FJtoRGt1r7FvQnsG73PGLQtNqMdZg4NCzTN70okRH7xNgHpsAFmP
         qroXszO9Gp90Q0fVgAJHJdbcfxxTvIq/O0XwKATfxtxnjjbixuZmdgN84IMu+0W2GGBQ
         9Erw==
X-Gm-Message-State: APjAAAW9ITtpa4upaPNfC8cdlXbIfP04Wef6Pv3zwz7wY89V6ykHFoPB
        0/+TEwFvsXtTOvRbMQ+99Z4=
X-Google-Smtp-Source: APXvYqy7xEqUDzXIYmUpQKzes+rEpkwZr5rsFq9x6OUU/R+UxQltXV3aV+/vI8Lsz4qii0SDcA9aig==
X-Received: by 2002:a62:86cc:: with SMTP id x195mr2876099pfd.199.1574130805622;
        Mon, 18 Nov 2019 18:33:25 -0800 (PST)
Received: from SL2P216MB0105.KORP216.PROD.OUTLOOK.COM ([2603:1046:100:22::5])
        by smtp.gmail.com with ESMTPSA id e17sm24573380pgt.89.2019.11.18.18.33.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Nov 2019 18:33:24 -0800 (PST)
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
Thread-Index: ATJjYTU2O06nkFcUdbgFWwCO5zAaLzA1ODAwxPSEdACAABLD/g==
X-MS-Exchange-MessageSentRepresentingType: 1
Date:   Tue, 19 Nov 2019 02:33:18 +0000
Message-ID: <SL2P216MB0105BEFFAFEAB06F408C31A2AA4C0@SL2P216MB0105.KORP216.PROD.OUTLOOK.COM>
References: <cover.1573784557.git.eswara.kota@linux.intel.com>
 <99a29f5a4ce18df26bd300ac6728433ec025631b.1573784557.git.eswara.kota@linux.intel.com>
 <SL2P216MB01056231B6036941BEF71738AA700@SL2P216MB0105.KORP216.PROD.OUTLOOK.COM>
 <50dabbc6-eae5-5ae5-95a0-f195c1ef7362@linux.intel.com>
 <SL2P216MB010580C028A7F88E8FB72574AA4D0@SL2P216MB0105.KORP216.PROD.OUTLOOK.COM>
 <5fc0001f-e73c-af1d-4182-d2d2448741fd@linux.intel.com>
In-Reply-To: <5fc0001f-e73c-af1d-4182-d2d2448741fd@linux.intel.com>
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

T24gMTEvMTgvMTksIDg6MjYgUE0sIERpbGlwIEtvdGEgd3JvdGU6DQo+IA0KPiBPbiAxMS8xOS8y
MDE5IDEyOjQwIEFNLCBKaW5nb28gSGFuIHdyb3RlOg0KPiA+DQo+ID4g77u/T24gMTEvMTgvMTks
IDI6NTggQU0sIERpbGlwIEtvdGEgd3JvdGU6DQo+ID4NCj4gPj4gT24gMTEvMTYvMjAxOSA0OjQw
IEFNLCBKaW5nb28gSGFuIHdyb3RlOg0KPiA+Pj4gT24gMTEvMTQvMTksIDk6MzEgUE0sIERpbGlw
IEtvdGEgd3JvdGU6DQo+ID4+Pg0KPiA+Pj4+IEFkZCBzdXBwb3J0IHRvIFBDSWUgUkMgY29udHJv
bGxlciBvbiBJbnRlbCBHYXRld2F5IFNvQ3MuDQo+ID4+Pj4gUENJZSBjb250cm9sbGVyIGlzIGJh
c2VkIG9mIFN5bm9wc3lzIERlc2lnbldhcmUgUENJZSBjb3JlLg0KPiA+Pj4+DQo+ID4+Pj4gSW50
ZWwgUENJZSBkcml2ZXIgcmVxdWlyZXMgVXBjb25maWd1cmUgc3VwcG9ydCwgRmFzdCBUcmFpbmlu
Zw0KPiA+Pj4+IFNlcXVlbmNlIGFuZCBsaW5rIHNwZWVkIGNvbmZpZ3VyYXRpb25zLiBTbyBhZGRp
bmcgdGhlIHJlc3BlY3RpdmUNCj4gPj4+PiBoZWxwZXIgZnVuY3Rpb25zIGluIHRoZSBQQ0llIERl
c2lnbldhcmUgZnJhbWV3b3JrLg0KPiA+Pj4+IEl0IGFsc28gcHJvZ3JhbXMgaGFyZHdhcmUgYXV0
b25vbW91cyBzcGVlZCBkdXJpbmcgc3BlZWQNCj4gPj4+PiBjb25maWd1cmF0aW9uIHNvIGRlZmlu
aW5nIGl0IGluIHBjaV9yZWdzLmguDQo+ID4+Pj4NCj4gPj4+PiBTaWduZWQtb2ZmLWJ5OiBEaWxp
cCBLb3RhIDxlc3dhcmEua290YUBsaW51eC5pbnRlbC5jb20+DQo+ID4+Pj4gUmV2aWV3ZWQtYnk6
IEFuZHJldyBNdXJyYXkgPGFuZHJldy5tdXJyYXlAYXJtLmNvbT4NCj4gPj4+PiBBY2tlZC1ieTog
R3VzdGF2byBQaW1lbnRlbCA8Z3VzdGF2by5waW1lbnRlbEBzeW5vcHN5cy5jb20+DQo+ID4+Pj4g
LS0tDQo+ID4+PiBbLi4uLi5dDQo+ID4+Pg0KPiA+Pj4+ICAgIGRyaXZlcnMvcGNpL2NvbnRyb2xs
ZXIvZHdjL0tjb25maWcgICAgICAgICAgIHwgIDEwICsNCj4gPj4+PiAgICBkcml2ZXJzL3BjaS9j
b250cm9sbGVyL2R3Yy9NYWtlZmlsZSAgICAgICAgICB8ICAgMSArDQo+ID4+Pj4gICAgZHJpdmVy
cy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLmMgfCAgNTcgKysrDQo+ID4+Pj4g
ICAgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLmggfCAgMTIgKw0K
PiA+Pj4+ICAgIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtaW50ZWwtZ3cuYyAgIHwg
NTQyICsrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+Pj4+ICAgIGluY2x1ZGUvdWFwaS9s
aW51eC9wY2lfcmVncy5oICAgICAgICAgICAgICAgIHwgICAxICsNCj4gPj4+PiAgICA2IGZpbGVz
IGNoYW5nZWQsIDYyMyBpbnNlcnRpb25zKCspDQo+ID4+Pj4gICAgY3JlYXRlIG1vZGUgMTAwNjQ0
IGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtaW50ZWwtZ3cuYw0KPiA+Pj4+DQo+ID4+
Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL0tjb25maWcgYi9kcml2
ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9LY29uZmlnDQo+ID4+Pj4gaW5kZXggMGJhOTg4YjViNWJj
Li5mYjZkNDc0NDc3ZGYgMTAwNjQ0DQo+ID4+Pj4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxl
ci9kd2MvS2NvbmZpZw0KPiA+Pj4+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL0tj
b25maWcNCj4gPj4+PiBAQCAtODIsNiArODIsMTYgQEAgY29uZmlnIFBDSUVfRFdfUExBVF9FUA0K
PiA+Pj4+ICAgIAkgIG9yZGVyIHRvIGVuYWJsZSBkZXZpY2Utc3BlY2lmaWMgZmVhdHVyZXMgUENJ
X0RXX1BMQVRfRVAgbXVzdCBiZQ0KPiA+Pj4+ICAgIAkgIHNlbGVjdGVkLg0KPiA+Pj4+ICAgIA0K
PiA+Pj4+ICtjb25maWcgUENJRV9JTlRFTF9HVw0KPiA+Pj4+ICsJYm9vbCAiSW50ZWwgR2F0ZXdh
eSBQQ0llIGhvc3QgY29udHJvbGxlciBzdXBwb3J0Ig0KPiA+Pj4+ICsJZGVwZW5kcyBvbiBPRiAm
JiAoWDg2IHx8IENPTVBJTEVfVEVTVCkNCj4gPj4+PiArCXNlbGVjdCBQQ0lFX0RXX0hPU1QNCj4g
Pj4+PiArCWhlbHANCj4gPj4+PiArCSAgU2F5ICdZJyBoZXJlIHRvIGVuYWJsZSBQQ0llIEhvc3Qg
Y29udHJvbGxlciBzdXBwb3J0IG9uIEludGVsDQo+ID4+Pj4gKwkgIEdhdGV3YXkgU29Dcy4NCj4g
Pj4+PiArCSAgVGhlIFBDSWUgY29udHJvbGxlciB1c2VzIHRoZSBEZXNpZ25XYXJlIGNvcmUgcGx1
cyBJbnRlbC1zcGVjaWZpYw0KPiA+Pj4+ICsJICBoYXJkd2FyZSB3cmFwcGVycy4NCj4gPj4+PiAr
DQo+ID4+PiBQbGVhc2UgYWRkIHRoaXMgY29uZmlnIGFscGhhYmV0aWNhbCBvcmRlciENCj4gPj4+
IFNvLCB0aGlzIGNvbmZpZyBzaG91bGQgYmUgYWZ0ZXIgJ2NvbmZpZyBQQ0lfSU1YNicuDQo+ID4+
PiBUaGVyZSBpcyBubyByZWFzb24gdG8gcHV0IHRoaXMgY29uZmlnIGF0IHRoZSBmaXJzdCBwbGFj
ZS4NCj4gPj4+DQo+ID4+Pj4gICAgY29uZmlnIFBDSV9FWFlOT1MNCj4gPj4+PiAgICAJYm9vbCAi
U2Ftc3VuZyBFeHlub3MgUENJZSBjb250cm9sbGVyIg0KPiA+Pj4+ICAgIAlkZXBlbmRzIG9uIFNP
Q19FWFlOT1M1NDQwIHx8IENPTVBJTEVfVEVTVA0KPiA+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3BjaS9jb250cm9sbGVyL2R3Yy9NYWtlZmlsZSBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdj
L01ha2VmaWxlDQo+ID4+Pj4gaW5kZXggYjMwMzM2MTgxZDQ2Li45OWRiODNjZDJmMzUgMTAwNjQ0
DQo+ID4+Pj4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvTWFrZWZpbGUNCj4gPj4+
PiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9NYWtlZmlsZQ0KPiA+Pj4+IEBAIC0z
LDYgKzMsNyBAQCBvYmotJChDT05GSUdfUENJRV9EVykgKz0gcGNpZS1kZXNpZ253YXJlLm8NCj4g
Pj4+PiAgICBvYmotJChDT05GSUdfUENJRV9EV19IT1NUKSArPSBwY2llLWRlc2lnbndhcmUtaG9z
dC5vDQo+ID4+Pj4gICAgb2JqLSQoQ09ORklHX1BDSUVfRFdfRVApICs9IHBjaWUtZGVzaWdud2Fy
ZS1lcC5vDQo+ID4+Pj4gICAgb2JqLSQoQ09ORklHX1BDSUVfRFdfUExBVCkgKz0gcGNpZS1kZXNp
Z253YXJlLXBsYXQubw0KPiA+Pj4+ICtvYmotJChDT05GSUdfUENJRV9JTlRFTF9HVykgKz0gcGNp
ZS1pbnRlbC1ndy5vDQo+ID4+PiBEaXR0by4NCj4gPj4gUENJRV9JTlRFTF9HVyB3b3VsZG50IGNv
bWUgYWZ0ZXIgUENJX0lNWDYsIHRoZSBjb21wbGV0ZSBNYWtlZmlsZSBhbmQNCj4gPj4gS2NvbmZp
ZyBhcmUgbm90IGluIG9yZGVyLCggUENJXyogYW5kIFBDSUVfKiBhcmUgbm90IGluIGFueSBvcmRl
cikuIFNvIGkNCj4gPj4ganVzdCBmb2xsb3dlZCBQQ0lFX0RXIGFuZCBwbGFjZWQgUENJRV9JTlRF
TF9HVyBhZnRlciBQQ0lFX0RXIGFzIEkgaXMNCj4gPj4gYWZ0ZXIgRCAoYW5kIGkgc2VlIFBDSV8q
IGltbWVkaWF0ZWx5IGFmdGVyIHRoZSBQQ0lFX0RXKiwgc28gaSBwbGFjZWQNCj4gPj4gUENJRV9J
TlRFTF9HVyBhZnRlciBQQ0lFX0RXKiBhbmQgYmVmb3JlIFBDSV8qKS4NCj4gPiBIZXksIGFsdGhv
dWdoIHNvbWUgb2YgdGhlbSBhcmUgbm90IGluIG9yZGVyLCB5b3UgZG9uJ3QgaGF2ZSBhIHJpZ2h0
IHRvIGRvIHNvLg0KPiA+IElmIHNvbWUgcGVvcGxlIGRvIG5vdCBmb2xsb3cgdGhlIGxhdywgaXQg
ZG9lcyBub3QgbWVhbiB0aGF0IHlvdSBjYW4gYnJlYWsgdGhlIGxhdy4NCj4gPiBBbnl3YXksIGlm
IHlvdSBkb24ndCBmb2xsb3cgYW4gYWxwaGFiZXRpY2FsIG9yZGVyLCBteSBhbnN3ZXIgaXMgTkFD
Sy4NCj4gPiBBbHNvLCBvdGhlciBwZW9wbGUgb3IgSSB3aWxsIHNlbmQgYSBwYXRjaCB0byBmaXgg
dGhlIG9yZGVyIG9mIG90aGVyIGRyaXZlcnMuDQo+DQo+IEkgYW0gbm90IGFnYWluc3QgZm9sbG93
aW5nIHRoZSBvcmRlci4gSSBrZXB0IFBDSUVfSU5URUxfR1cgYWZ0ZXIgDQo+IFBDSUVfRFcqIGJ5
IGNoZWNraW5nIHRoZSBiZXN0IHBvc3NpYmxlIG9yZGVyLg0KPiBBcyBwZXIgdGhlIGFscGhhYmV0
aWNhbCBvcmRlciwgaSBzZWUgYWxsIENPTkZJR19QQ0lFXyogY29tZXMgZmlyc3QgYW5kIA0KPiBD
T05GSUdfUENJXyogZm9sbG93cy4gU28sIGJ5IGZvbGxvd2luZyB0aGlzLCBpIHBsYWNlZCBQQ0lF
X0lOVEVMX0dXIA0KPiBhZnRlciBQQ0lFX0RXKiAoZm9yIHRoZSBzYW1lIHJlYXNvbiBQQ0lFX0lO
VEVMX0dXIGNhbm5vdCBiZSBwbGFjZWQgYWZ0ZXIgDQo+IFBDSV9JTVg2KS4NCj4gRXZlbiBhZnRl
ciByZS1vcmRlcmluZyB0aGUgS2NvbmZpZyBhbmQgTWFrZWZpbGUsIHN0aWxsIFBDSUVfSU5URUxf
R1cgDQo+IGNvbWVzIGFmdGVyIFBDSUVfRFdfUExBVCggYW5kIFBDSUVfSElTSV9TVEIpLg0KDQpB
cmUgeW91IGtpZGRpbmcgbWU/DQoNCk1vc3QgUENJRV8qIGRyaXZlcnMgYXJlIGxvY2F0ZWQgYWZ0
ZXIgUENJXyouIExvb2sgYXQgUENJRV9RQ09NLCBQQ0lFX0FSTUFEQV84SywNClBDSUVfQVJUUEVD
NiwgUENJRV9LSVJJTiwgUENJRV9ISVNJX1NUQiwgUENJRV9URUdSQTE5NCwgUENJRV9VTklQSElF
UiwgUENJRV9BTC4NClB1dCBQQ0lFX0lOVEVMX0dXIGJldHdlZW4gUENJRV9BUlRQRUM2X0VQIGFu
ZCBQQ0lFX0tJUklOLg0KDQoNCj4gUmVnYXJkcywNCkRpbGlwDQoNCj4NCj4NCj4+IFJlZ2FyZHMs
DQo+PiBEaWxpcA0KPj4gQmVzdCByZWdhcmRzLA0KPj4gSmluZ29vIEhhbg0KPj4NCj4+PiAgICBv
YmotJChDT05GSUdfUENJX0RSQTdYWCkgKz0gcGNpLWRyYTd4eC5vDQo+Pj4gICAgb2JqLSQoQ09O
RklHX1BDSV9FWFlOT1MpICs9IHBjaS1leHlub3Mubw0KPj4+ICAgIG9iai0kKENPTkZJR19QQ0lf
SU1YNikgKz0gcGNpLWlteDYubw0KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9s
bGVyL2R3Yy9wY2llLWRlc2lnbndhcmUuYyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3Bj
aWUtZGVzaWdud2FyZS5jDQo+Pj4gaW5kZXggODIwNDg4ZGZlYWVkLi40NzllMjUwNjk1YTAgMTAw
NjQ0DQo+PiBbLi4uLi5dDQo=
