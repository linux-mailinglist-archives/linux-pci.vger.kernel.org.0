Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B098E10124A
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2019 04:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbfKSDy5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Nov 2019 22:54:57 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:36134 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727363AbfKSDy5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Nov 2019 22:54:57 -0500
Received: by mail-pj1-f66.google.com with SMTP id cq11so2153765pjb.3;
        Mon, 18 Nov 2019 19:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:thread-topic:thread-index:date:message-id
         :references:in-reply-to:accept-language:content-language
         :content-transfer-encoding:mime-version;
        bh=24+FdTB/SGMIiuuETZOntthrIMxTet2QDlbCcXYcSI0=;
        b=VzXZzIlYNwwmJeAoEVFXkeVYBTHVQHRGvd5+0Yk/xDSqAaPeZOb2XXeT5LSWoFaH/D
         zUN02Yw6wFcn6bEhPrC8BEGTETv5r4c4aDyH724VxpfZiBLvj/PWkUaaDWOvT8be5Uub
         A/ZXeNNHkDavckNHK3bBIR7g/t2tL6qfCbgyaqUwj6B09MNGrAy3oMWS54pu4IGjy6vi
         nhQx0FLPa9t5+ZqVc3CBuKdm4PMSfKd5stIuKVVZkczgQF+IK/XN/uXAgmpIBzOIByBL
         nnGVEVpjdkc6T2x3us/Fj0qAbTqFKyDTWsQ/tZvXPlol/otxvsXVRJ3fXb1mx0uho3/Q
         4GzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:thread-topic:thread-index
         :date:message-id:references:in-reply-to:accept-language
         :content-language:content-transfer-encoding:mime-version;
        bh=24+FdTB/SGMIiuuETZOntthrIMxTet2QDlbCcXYcSI0=;
        b=VFuwQDY8SWinav6OUClKezzlxcz5qS9Aat5l1tUkDCVD7XXMH8Ylc36wTIp6l9zUCh
         8VvUuwwYZXd/8GEwYduK3fxhdIcaVw0t2JWgGFHog5hlBY5T3Gm3l4JcErYcPbLAkR5A
         CzV00a8fwJJ4/z5xl4e2vcDqML5QRlRXKSavDPdNLGfhfjUXpAU1W2vAVa/YE1ZZEAdg
         FrH7ydWyXZ1ErlXLIUDlcNBIjheU/K4uodzwjQ/3sYRMjmg7h8kzoILKsovnXSgDwVAT
         dLbyG9R2aEhIuKLe1mpwN3AqVe8RqOeuLW9CjUvUtbTkAYAiLnwdahL/2gJmR7akBtvE
         4CCQ==
X-Gm-Message-State: APjAAAWou8u2mAl4LlxkKQyM1uFjjOL5MR0ZxWh4blP4NOGTF96AVd9C
        ATmUPvPGSzHXlW9XFntuyJ/+8ATj
X-Google-Smtp-Source: APXvYqx5YcND2fwWRSsL+pXqD9YUeWO/ZrxPTS6uDB6w36vpeIiC3dgjfyt0qshkTtGQgz8vPFnkFw==
X-Received: by 2002:a17:902:bcc6:: with SMTP id o6mr13147304pls.1.1574135695643;
        Mon, 18 Nov 2019 19:54:55 -0800 (PST)
Received: from SL2P216MB0105.KORP216.PROD.OUTLOOK.COM ([2603:1046:100:22::5])
        by smtp.gmail.com with ESMTPSA id a26sm22680898pff.155.2019.11.18.19.54.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Nov 2019 19:54:54 -0800 (PST)
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
Thread-Index: AWQ0OGFmjdSTIdogCMta/d9owysM9TAxNkYw4VMUrYCAAAsInQ==
X-MS-Exchange-MessageSentRepresentingType: 1
Date:   Tue, 19 Nov 2019 03:54:48 +0000
Message-ID: <SL2P216MB0105383DF9E286876DE65D41AA4C0@SL2P216MB0105.KORP216.PROD.OUTLOOK.COM>
References: <cover.1573784557.git.eswara.kota@linux.intel.com>
 <99a29f5a4ce18df26bd300ac6728433ec025631b.1573784557.git.eswara.kota@linux.intel.com>
 <SL2P216MB01056231B6036941BEF71738AA700@SL2P216MB0105.KORP216.PROD.OUTLOOK.COM>
 <50dabbc6-eae5-5ae5-95a0-f195c1ef7362@linux.intel.com>
 <SL2P216MB010580C028A7F88E8FB72574AA4D0@SL2P216MB0105.KORP216.PROD.OUTLOOK.COM>
 <5fc0001f-e73c-af1d-4182-d2d2448741fd@linux.intel.com>
 <SL2P216MB0105BEFFAFEAB06F408C31A2AA4C0@SL2P216MB0105.KORP216.PROD.OUTLOOK.COM>
 <32f19457-c35f-656c-e434-d52ddb38de25@linux.intel.com>
In-Reply-To: <32f19457-c35f-656c-e434-d52ddb38de25@linux.intel.com>
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

DQoNCu+7v09uIDExLzE4LzE5LCAxMDoxNSBQTSwgRGlsaXAgS290YSB3cm90ZToNCj5PbiAxMS8x
OS8yMDE5IDEwOjMzIEFNLCBKaW5nb28gSGFuIHdyb3RlOg0KPj4gT24gMTEvMTgvMTksIDg6MjYg
UE0sIERpbGlwIEtvdGEgd3JvdGU6DQo+Pj4gT24gMTEvMTkvMjAxOSAxMjo0MCBBTSwgSmluZ29v
IEhhbiB3cm90ZToNCj4+Pj4g77u/T24gMTEvMTgvMTksIDI6NTggQU0sIERpbGlwIEtvdGEgd3Jv
dGU6DQo+Pj4+DQo+Pj4+PiBPbiAxMS8xNi8yMDE5IDQ6NDAgQU0sIEppbmdvbyBIYW4gd3JvdGU6
DQo+Pj4+Pj4gT24gMTEvMTQvMTksIDk6MzEgUE0sIERpbGlwIEtvdGEgd3JvdGU6DQo+Pj4+Pj4N
Cj4+Pj4+Pj4gQWRkIHN1cHBvcnQgdG8gUENJZSBSQyBjb250cm9sbGVyIG9uIEludGVsIEdhdGV3
YXkgU29Dcy4NCj4+Pj4+Pj4gUENJZSBjb250cm9sbGVyIGlzIGJhc2VkIG9mIFN5bm9wc3lzIERl
c2lnbldhcmUgUENJZSBjb3JlLg0KPj4+Pj4+Pg0KPj4+Pj4+PiBJbnRlbCBQQ0llIGRyaXZlciBy
ZXF1aXJlcyBVcGNvbmZpZ3VyZSBzdXBwb3J0LCBGYXN0IFRyYWluaW5nDQo+Pj4+Pj4+IFNlcXVl
bmNlIGFuZCBsaW5rIHNwZWVkIGNvbmZpZ3VyYXRpb25zLiBTbyBhZGRpbmcgdGhlIHJlc3BlY3Rp
dmUNCj4+Pj4+Pj4gaGVscGVyIGZ1bmN0aW9ucyBpbiB0aGUgUENJZSBEZXNpZ25XYXJlIGZyYW1l
d29yay4NCj4+Pj4+Pj4gSXQgYWxzbyBwcm9ncmFtcyBoYXJkd2FyZSBhdXRvbm9tb3VzIHNwZWVk
IGR1cmluZyBzcGVlZA0KPj4+Pj4+PiBjb25maWd1cmF0aW9uIHNvIGRlZmluaW5nIGl0IGluIHBj
aV9yZWdzLmguDQo+Pj4+Pj4+DQo+Pj4+Pj4+IFNpZ25lZC1vZmYtYnk6IERpbGlwIEtvdGEgPGVz
d2FyYS5rb3RhQGxpbnV4LmludGVsLmNvbT4NCj4+Pj4+Pj4gUmV2aWV3ZWQtYnk6IEFuZHJldyBN
dXJyYXkgPGFuZHJldy5tdXJyYXlAYXJtLmNvbT4NCj4+Pj4+Pj4gQWNrZWQtYnk6IEd1c3Rhdm8g
UGltZW50ZWwgPGd1c3Rhdm8ucGltZW50ZWxAc3lub3BzeXMuY29tPg0KPj4+Pj4+PiAtLS0NCj4+
Pj4+PiBbLi4uLi5dDQo+Pj4+Pj4NCj4+Pj4+Pj4gICAgIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIv
ZHdjL0tjb25maWcgICAgICAgICAgIHwgIDEwICsNCj4+Pj4+Pj4gICAgIGRyaXZlcnMvcGNpL2Nv
bnRyb2xsZXIvZHdjL01ha2VmaWxlICAgICAgICAgIHwgICAxICsNCj4+Pj4+Pj4gICAgIGRyaXZl
cnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS5jIHwgIDU3ICsrKw0KPj4+Pj4+
PiAgICAgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLmggfCAgMTIg
Kw0KPj4+Pj4+PiAgICAgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1pbnRlbC1ndy5j
ICAgfCA1NDIgKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+Pj4+Pj4+ICAgICBpbmNsdWRl
L3VhcGkvbGludXgvcGNpX3JlZ3MuaCAgICAgICAgICAgICAgICB8ICAgMSArDQo+Pj4+Pj4+ICAg
ICA2IGZpbGVzIGNoYW5nZWQsIDYyMyBpbnNlcnRpb25zKCspDQo+Pj4+Pj4+ICAgICBjcmVhdGUg
bW9kZSAxMDA2NDQgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1pbnRlbC1ndy5jDQo+
Pj4+Pj4+DQo+Pj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9L
Y29uZmlnIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvS2NvbmZpZw0KPj4+Pj4+PiBpbmRl
eCAwYmE5ODhiNWI1YmMuLmZiNmQ0NzQ0NzdkZiAxMDA2NDQNCj4+Pj4+Pj4gLS0tIGEvZHJpdmVy
cy9wY2kvY29udHJvbGxlci9kd2MvS2NvbmZpZw0KPj4+Pj4+PiArKysgYi9kcml2ZXJzL3BjaS9j
b250cm9sbGVyL2R3Yy9LY29uZmlnDQo+Pj4+Pj4+IEBAIC04Miw2ICs4MiwxNiBAQCBjb25maWcg
UENJRV9EV19QTEFUX0VQDQo+Pj4+Pj4+ICAgICAJICBvcmRlciB0byBlbmFibGUgZGV2aWNlLXNw
ZWNpZmljIGZlYXR1cmVzIFBDSV9EV19QTEFUX0VQIG11c3QgYmUNCj4+Pj4+Pj4gICAgIAkgIHNl
bGVjdGVkLg0KPj4+Pj4+PiAgICAgDQo+Pj4+Pj4+ICtjb25maWcgUENJRV9JTlRFTF9HVw0KPj4+
Pj4+PiArCWJvb2wgIkludGVsIEdhdGV3YXkgUENJZSBob3N0IGNvbnRyb2xsZXIgc3VwcG9ydCIN
Cj4+Pj4+Pj4gKwlkZXBlbmRzIG9uIE9GICYmIChYODYgfHwgQ09NUElMRV9URVNUKQ0KPj4+Pj4+
PiArCXNlbGVjdCBQQ0lFX0RXX0hPU1QNCj4+Pj4+Pj4gKwloZWxwDQo+Pj4+Pj4+ICsJICBTYXkg
J1knIGhlcmUgdG8gZW5hYmxlIFBDSWUgSG9zdCBjb250cm9sbGVyIHN1cHBvcnQgb24gSW50ZWwN
Cj4+Pj4+Pj4gKwkgIEdhdGV3YXkgU29Dcy4NCj4+Pj4+Pj4gKwkgIFRoZSBQQ0llIGNvbnRyb2xs
ZXIgdXNlcyB0aGUgRGVzaWduV2FyZSBjb3JlIHBsdXMgSW50ZWwtc3BlY2lmaWMNCj4+Pj4+Pj4g
KwkgIGhhcmR3YXJlIHdyYXBwZXJzLg0KPj4+Pj4+PiArDQo+Pj4+Pj4gUGxlYXNlIGFkZCB0aGlz
IGNvbmZpZyBhbHBoYWJldGljYWwgb3JkZXIhDQo+Pj4+Pj4gU28sIHRoaXMgY29uZmlnIHNob3Vs
ZCBiZSBhZnRlciAnY29uZmlnIFBDSV9JTVg2Jy4NCj4+Pj4+PiBUaGVyZSBpcyBubyByZWFzb24g
dG8gcHV0IHRoaXMgY29uZmlnIGF0IHRoZSBmaXJzdCBwbGFjZS4NCj4+Pj4+Pg0KPj4+Pj4+PiAg
ICAgY29uZmlnIFBDSV9FWFlOT1MNCj4+Pj4+Pj4gICAgIAlib29sICJTYW1zdW5nIEV4eW5vcyBQ
Q0llIGNvbnRyb2xsZXIiDQo+Pj4+Pj4+ICAgICAJZGVwZW5kcyBvbiBTT0NfRVhZTk9TNTQ0MCB8
fCBDT01QSUxFX1RFU1QNCj4+Pj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xs
ZXIvZHdjL01ha2VmaWxlIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvTWFrZWZpbGUNCj4+
Pj4+Pj4gaW5kZXggYjMwMzM2MTgxZDQ2Li45OWRiODNjZDJmMzUgMTAwNjQ0DQo+Pj4+Pj4+IC0t
LSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL01ha2VmaWxlDQo+Pj4+Pj4+ICsrKyBiL2Ry
aXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL01ha2VmaWxlDQo+Pj4+Pj4+IEBAIC0zLDYgKzMsNyBA
QCBvYmotJChDT05GSUdfUENJRV9EVykgKz0gcGNpZS1kZXNpZ253YXJlLm8NCj4+Pj4+Pj4gICAg
IG9iai0kKENPTkZJR19QQ0lFX0RXX0hPU1QpICs9IHBjaWUtZGVzaWdud2FyZS1ob3N0Lm8NCj4+
Pj4+Pj4gICAgIG9iai0kKENPTkZJR19QQ0lFX0RXX0VQKSArPSBwY2llLWRlc2lnbndhcmUtZXAu
bw0KPj4+Pj4+PiAgICAgb2JqLSQoQ09ORklHX1BDSUVfRFdfUExBVCkgKz0gcGNpZS1kZXNpZ253
YXJlLXBsYXQubw0KPj4+Pj4+PiArb2JqLSQoQ09ORklHX1BDSUVfSU5URUxfR1cpICs9IHBjaWUt
aW50ZWwtZ3cubw0KPj4+Pj4+IERpdHRvLg0KPj4+Pj4gUENJRV9JTlRFTF9HVyB3b3VsZG50IGNv
bWUgYWZ0ZXIgUENJX0lNWDYsIHRoZSBjb21wbGV0ZSBNYWtlZmlsZSBhbmQNCj4+Pj4+IEtjb25m
aWcgYXJlIG5vdCBpbiBvcmRlciwoIFBDSV8qIGFuZCBQQ0lFXyogYXJlIG5vdCBpbiBhbnkgb3Jk
ZXIpLiBTbyBpDQo+Pj4+PiBqdXN0IGZvbGxvd2VkIFBDSUVfRFcgYW5kIHBsYWNlZCBQQ0lFX0lO
VEVMX0dXIGFmdGVyIFBDSUVfRFcgYXMgSSBpcw0KPj4+Pj4gYWZ0ZXIgRCAoYW5kIGkgc2VlIFBD
SV8qIGltbWVkaWF0ZWx5IGFmdGVyIHRoZSBQQ0lFX0RXKiwgc28gaSBwbGFjZWQNCj4+Pj4+IFBD
SUVfSU5URUxfR1cgYWZ0ZXIgUENJRV9EVyogYW5kIGJlZm9yZSBQQ0lfKikuDQo+Pj4+IEhleSwg
YWx0aG91Z2ggc29tZSBvZiB0aGVtIGFyZSBub3QgaW4gb3JkZXIsIHlvdSBkb24ndCBoYXZlIGEg
cmlnaHQgdG8gZG8gc28uDQo+Pj4+IElmIHNvbWUgcGVvcGxlIGRvIG5vdCBmb2xsb3cgdGhlIGxh
dywgaXQgZG9lcyBub3QgbWVhbiB0aGF0IHlvdSBjYW4gYnJlYWsgdGhlIGxhdy4NCj4+Pj4gQW55
d2F5LCBpZiB5b3UgZG9uJ3QgZm9sbG93IGFuIGFscGhhYmV0aWNhbCBvcmRlciwgbXkgYW5zd2Vy
IGlzIE5BQ0suDQo+Pj4+IEFsc28sIG90aGVyIHBlb3BsZSBvciBJIHdpbGwgc2VuZCBhIHBhdGNo
IHRvIGZpeCB0aGUgb3JkZXIgb2Ygb3RoZXIgZHJpdmVycy4NCj4+PiBJIGFtIG5vdCBhZ2FpbnN0
IGZvbGxvd2luZyB0aGUgb3JkZXIuIEkga2VwdCBQQ0lFX0lOVEVMX0dXIGFmdGVyDQo+Pj4gUENJ
RV9EVyogYnkgY2hlY2tpbmcgdGhlIGJlc3QgcG9zc2libGUgb3JkZXIuDQo+Pj4gQXMgcGVyIHRo
ZSBhbHBoYWJldGljYWwgb3JkZXIsIGkgc2VlIGFsbCBDT05GSUdfUENJRV8qIGNvbWVzIGZpcnN0
IGFuZA0KPj4+IENPTkZJR19QQ0lfKiBmb2xsb3dzLiBTbywgYnkgZm9sbG93aW5nIHRoaXMsIGkg
cGxhY2VkIFBDSUVfSU5URUxfR1cNCj4+PiBhZnRlciBQQ0lFX0RXKiAoZm9yIHRoZSBzYW1lIHJl
YXNvbiBQQ0lFX0lOVEVMX0dXIGNhbm5vdCBiZSBwbGFjZWQgYWZ0ZXINCj4+PiBQQ0lfSU1YNiku
DQo+Pj4gRXZlbiBhZnRlciByZS1vcmRlcmluZyB0aGUgS2NvbmZpZyBhbmQgTWFrZWZpbGUsIHN0
aWxsIFBDSUVfSU5URUxfR1cNCj4+PiBjb21lcyBhZnRlciBQQ0lFX0RXX1BMQVQoIGFuZCBQQ0lF
X0hJU0lfU1RCKS4NCj4+IEFyZSB5b3Uga2lkZGluZyBtZT8NCj4+DQo+PiBNb3N0IFBDSUVfKiBk
cml2ZXJzIGFyZSBsb2NhdGVkIGFmdGVyIFBDSV8qLiBMb29rIGF0IFBDSUVfUUNPTSwgUENJRV9B
Uk1BREFfOEssDQo+PiBQQ0lFX0FSVFBFQzYsIFBDSUVfS0lSSU4sIFBDSUVfSElTSV9TVEIsIFBD
SUVfVEVHUkExOTQsIFBDSUVfVU5JUEhJRVIsIFBDSUVfQUwuDQo+T2ssIFNvIHRoZSB1bmRlcnN0
YW5kaW5nIGlzIFBDSUVfRFcqIHdpbGwgYmUgYXQgdG9wIGFzIHRoZXkgYXJlIA0KPmZyYW1ld29y
ayBhbmQgdGhlbiBjb21lcyBDT05GSUdfUENJXyosIENPTkZJR19QQ0lFXyouDQoNClllcywgcmln
aHQuDQpBaCwgSSB3aWxsIGV4cGxhaW4gdGhlIG9yZGVyIG9mIEtjb25maWcgb3B0aW9ucyBpbiB0
aGUgZHdjIGRpcmVjdG9yeS4NClRoZSBvcmRlciBpcyBQQ0lFX0RXLCBQQ0lfKiwgYW5kIFBDSUVf
KiBhcyBiZWxvdy4NCg0KMS4gQ29tbW9uIEZyYW1ld29ya3M6DQogICAgVGhlc2Ugb3B0aW9ucyBh
cmUgdXNlZCBieSBvdGhlciBjb250cm9sbGVyIGRyaXZlcnMuDQogICAgZS5nLiwgUENJRV9EVywg
UENJRV9EV19IT1NULCBQQ0lFX0RXX0VQLg0KDQoyLiBQQ0lfKiBjb250cm9sbGVyIGRyaXZlcnM6
DQogICAgUENJXyogd2FzIHVzZWQgZWFybGllciB0aGFuIFBDSUVfKi4gSWYgYSBjaGlwIHZlbmRv
cidzIGNvbnRyb2xsZXJzIHByb3ZpZGUNCiAgICBib3RoIGNvbnZlbnRpb25hbCBQQ0kgYW5kIFBD
SSBFeHByZXNzLCBvciBvbmx5IGNvbnZlbnRpb25hbCBQQ0ksIFBDSV8qIGNhbg0KICAgIGJlIHVz
ZWQuIEZvciBleGFtcGxlLCB0aGUgcmVhc29uIFBDSV9FWFlOT1Mgd2FzIGNob3NlbiBpbnN0ZWFk
IG9mDQogICAgUENJRV9FWFlOT1MsIGlzIHRoYXQgRVhZTk9TIGhhZCBjb250cm9sbGVycyB0byBz
dXBwb3J0IGVpdGhlciBjb252ZW50aW9uYWwNCiAgICBQQ0kgb3IgUENJIEV4cHJlc3MuDQoNCjMu
IFBDSUVfKiBjb250cm9sbGVyIGRyaXZlcnMNCiAgICBJZiBhIGNvbnRyb2xsZXIgY2FuIHN1cHBv
cnQgb25seSBQQ0kgRXhwcmVzcywgbm90IGNvbnZlbnRpb25hbCBQQ0ksDQogICAgUENJRV8qIGlz
IHRoZSBwcm9wZXIgbmFtaW5nLg0KDQpUaGVuLCB3aXRoaW4gUENJXyogb3IgUENJRV8qIGNhdGVn
b3JpZXMsIGVhY2ggY29udHJvbGxlciBvcHRpb24gc2hvdWxkIGJlDQppbiBhbiBhbHBoYWJldGlj
YWwgb3JkZXIgZm9yIHRoZSByZWFkYWJpbGl0eS4gQWxzbywgb3RoZXIgcGVyc29uIG9yIEkgd2ls
bA0Kc2VuZCBhIHBhdGNoIHRvIGZpeCBvcmRlcnMuIChlLmcuLCBQQ0lFX1FDT00sIFBDSUVfQUws
IGV0Yy4pDQoNCj4+IFB1dCBQQ0lFX0lOVEVMX0dXIGJldHdlZW4gUENJRV9BUlRQRUM2X0VQIGFu
ZCBQQ0lFX0tJUklOLg0KPg0KPk9rLiBJIHdpbGwgdXBkYXRlIGluIHRoZSBuZXh0IHBhdGNoIHZl
cnNpb24uDQoNCk9rLCB0aGFuayB5b3UuDQoNCkJlc3QgcmVnYXJkcywNCkppbmdvbyBIYW4NCg0K
DQo=
