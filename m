Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 417C7298DEC
	for <lists+linux-pci@lfdr.de>; Mon, 26 Oct 2020 14:30:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1780075AbgJZNar (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Oct 2020 09:30:47 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44913 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1780071AbgJZNaq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Oct 2020 09:30:46 -0400
Received: by mail-pg1-f194.google.com with SMTP id o3so6059931pgr.11;
        Mon, 26 Oct 2020 06:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:thread-topic:thread-index:date:message-id
         :references:in-reply-to:accept-language:content-language
         :content-transfer-encoding:mime-version;
        bh=bw06RF8opfZrnVp16GJxHsaxiwU6f+GI++IAs++GX/Y=;
        b=pXg2Ikps2a2Au7+hpMUpVQNjod8cr4kjii3ciW6OrcFaSL3DqXVQaA9iV6OGq5eBZl
         GBSTHdIztH3jYIYkIsytkL0HuHT2ZSqV4aZnd3GT1PA8yqaDTdS2KA5YQHRbUNQzHlSf
         /0ofFd4JGJG2tYXu/2CFRHqqI7cFDcxC0tN0rcQd2O7PGfeosvuceB/7g/MYkDjT05Lo
         uLW1D+vh7l+G7NPtfWfPOGEWjsNyyoL//fjBshdgAb8q+UHYvLa7CEoxFW1Z4AY2m7N3
         pQfHCIaf4RCDrtHybXRBkP2u5qO3Zyi5j9+jRoTnR9y5lbopJOgAaUxAImRB1rCIUkRM
         6GMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:thread-topic:thread-index
         :date:message-id:references:in-reply-to:accept-language
         :content-language:content-transfer-encoding:mime-version;
        bh=bw06RF8opfZrnVp16GJxHsaxiwU6f+GI++IAs++GX/Y=;
        b=b5+S6UY4P2XsakKs1cIJZUreLQ3FY/+vOUvHQ+TN800wbHmkm+lDX53wdvE5JAd/gi
         76db13Z4aBj9Nnx3sW+pCeoafWB05TBSRl2j5vJ3ZMPlHjlWry2ckBJuNM/I6o6erqKd
         dsh6bpjyvgbFznAbdcoPb5Go0C0UW9ow0RX6EDWD9k2i6krW8JFV9ajSecncWEjfIpUw
         QiPPfpfJGu60ZDPRyXiJfTXWMlg8EgcHTaWRUV39dNxh+Q8crVXPheh0fX9Lq1gJREHK
         iFaGwLY9L/o0/t6FOPSDkqFDCXMQUngxM3mhHdABaQtTkAw/F5QqH16gjzTta9L29bre
         qyfw==
X-Gm-Message-State: AOAM530UjM0PDdgTSB642pBZDbHy5ywALDncqjIgxFiUIhlxorJKUqBw
        E7DhmGvH0pw+RyUVxBLMjkI=
X-Google-Smtp-Source: ABdhPJwjSetJEVXZGIQMxLkr5pXFBeiZ2DOzdZScRmQqF5to2sxh+TRFRu6A41Jt7s+6OhVfIq4jTg==
X-Received: by 2002:a62:54:0:b029:152:3212:f622 with SMTP id 81-20020a6200540000b02901523212f622mr13429407pfa.46.1603719045019;
        Mon, 26 Oct 2020 06:30:45 -0700 (PDT)
Received: from SLXP216MB0477.KORP216.PROD.OUTLOOK.COM ([2603:1046:100:9::5])
        by smtp.gmail.com with ESMTPSA id m13sm12431851pjl.45.2020.10.26.06.30.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Oct 2020 06:30:43 -0700 (PDT)
From:   Jingoo Han <jingoohan1@gmail.com>
To:     Vidya Sagar <vidyas@nvidia.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "amurray@thegoodpenguin.co.uk" <amurray@thegoodpenguin.co.uk>,
        "robh@kernel.org" <robh@kernel.org>,
        "treding@nvidia.com" <treding@nvidia.com>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kthota@nvidia.com" <kthota@nvidia.com>,
        "mmaddireddy@nvidia.com" <mmaddireddy@nvidia.com>,
        "sagar.tv@gmail.com" <sagar.tv@gmail.com>,
        Han Jingoo <jingoohan1@gmail.com>
Subject: Re: [PATCH 2/2] PCI: dwc: Add support to configure for ECRC
Thread-Topic: [PATCH 2/2] PCI: dwc: Add support to configure for ECRC
Thread-Index: AQHWqqDjcEvvIfJZ20eYN0/hpzWvqamoy1qzgACqbwCAAG1Vvw==
X-MS-Exchange-MessageSentRepresentingType: 1
Date:   Mon, 26 Oct 2020 13:30:39 +0000
Message-ID: <SLXP216MB04779FE1F5D9EF958D834563AA190@SLXP216MB0477.KORP216.PROD.OUTLOOK.COM>
References: <20201025073113.31291-1-vidyas@nvidia.com>
 <20201025073113.31291-3-vidyas@nvidia.com>
 <SLXP216MB0477AAC31DF68862BE5BC3EEAA180@SLXP216MB0477.KORP216.PROD.OUTLOOK.COM>
 <ccec2428-0efe-101c-11be-28766738951d@nvidia.com>
In-Reply-To: <ccec2428-0efe-101c-11be-28766738951d@nvidia.com>
Accept-Language: ko-KR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-Exchange-Organization-SCL: -1
X-MS-TNEF-Correlator: 
X-MS-Exchange-Organization-RecordReviewCfmType: 0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DQoNCu+7v09uIDEwLzI2LzIwLCAyOjU5IEFNLCBWaWR5YSBTYWdhciB3cm90ZToNCj4gDQo+IE9u
IDEwLzI2LzIwMjAgMjoxOSBBTSwgSmluZ29vIEhhbiB3cm90ZToNCj4gPiBFeHRlcm5hbCBlbWFp
bDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cw0KPiA+IA0KPiA+IA0K
PiA+IE9uIDEwLzI1LzIwLCAzOjMxIEFNLCBWaWR5YSBTYWdhciB3cm90ZToNCj4gPj4NCj4gPj4g
RGVzaWduV2FyZSBjb3JlIGhhcyBhIFRMUCBkaWdlc3QgKFREKSBvdmVycmlkZSBiaXQgaW4gb25l
IG9mIHRoZSBjb250cm9sDQo+ID4+IHJlZ2lzdGVycyBvZiBBVFUuIFRoaXMgYml0IGFsc28gbmVl
ZHMgdG8gYmUgcHJvZ3JhbW1lZCBmb3IgcHJvcGVyIEVDUkMNCj4gPj4gZnVuY3Rpb25hbGl0eS4g
VGhpcyBpcyBjdXJyZW50bHkgaWRlbnRpZmllZCBhcyBhbiBpc3N1ZSB3aXRoIERlc2lnbldhcmUN
Cj4gPj4gSVAgdmVyc2lvbiA0LjkwYS4gVGhpcyBwYXRjaCBkb2VzIHRoZSByZXF1aXJlZCBwcm9n
cmFtbWluZyBpbiBBVFUgdXBvbg0KPiA+PiBxdWVyeWluZyB0aGUgc3lzdGVtIHBvbGljeSBmb3Ig
RUNSQy4NCj4gPj4NCj4gPj4gU2lnbmVkLW9mZi1ieTogVmlkeWEgU2FnYXIgPHZpZHlhc0Budmlk
aWEuY29tPg0KPiA+PiAtLS0NCj4gPj4gICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ll
LWRlc2lnbndhcmUuYyB8IDggKysrKysrLS0NCj4gPj4gICBkcml2ZXJzL3BjaS9jb250cm9sbGVy
L2R3Yy9wY2llLWRlc2lnbndhcmUuaCB8IDIgKysNCj4gPj4gICAyIGZpbGVzIGNoYW5nZWQsIDgg
aW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPj4NCj4gPj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS5jIGIvZHJpdmVycy9wY2kv
Y29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLmMNCj4gPj4gaW5kZXggYjVlNDM4YjcwY2Q1
Li44MTBkY2JkYmU4NjkgMTAwNjQ0DQo+ID4+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIv
ZHdjL3BjaWUtZGVzaWdud2FyZS5jDQo+ID4+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIv
ZHdjL3BjaWUtZGVzaWdud2FyZS5jDQo+ID4+IEBAIC0yNDUsNyArMjQ1LDcgQEAgc3RhdGljIHZv
aWQgZHdfcGNpZV9wcm9nX291dGJvdW5kX2F0dV91bnJvbGwoc3RydWN0IGR3X3BjaWUgKnBjaSwg
dTggZnVuY19ubywNCj4gPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBsb3dlcl8z
Ml9iaXRzKHBjaV9hZGRyKSk7DQo+ID4+ICAgICAgICBkd19wY2llX3dyaXRlbF9vYl91bnJvbGwo
cGNpLCBpbmRleCwgUENJRV9BVFVfVU5SX1VQUEVSX1RBUkdFVCwNCj4gPj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB1cHBlcl8zMl9iaXRzKHBjaV9hZGRyKSk7DQo+ID4+IC0gICAg
IHZhbCA9IHR5cGUgfCBQQ0lFX0FUVV9GVU5DX05VTShmdW5jX25vKTsNCj4gPj4gKyAgICAgdmFs
ID0gdHlwZSB8IFBDSUVfQVRVX0ZVTkNfTlVNKGZ1bmNfbm8pIHwgcGNpLT50ZCA8PCBQQ0lFX0FU
VV9URF9TSElGVDsNCj4gPj4gICAgICAgIHZhbCA9IHVwcGVyXzMyX2JpdHMoc2l6ZSAtIDEpID8N
Cj4gPj4gICAgICAgICAgICAgICAgdmFsIHwgUENJRV9BVFVfSU5DUkVBU0VfUkVHSU9OX1NJWkUg
OiB2YWw7DQo+ID4+ICAgICAgICBkd19wY2llX3dyaXRlbF9vYl91bnJvbGwocGNpLCBpbmRleCwg
UENJRV9BVFVfVU5SX1JFR0lPTl9DVFJMMSwgdmFsKTsNCj4gPj4gQEAgLTI5NSw3ICsyOTUsOCBA
QCBzdGF0aWMgdm9pZCBfX2R3X3BjaWVfcHJvZ19vdXRib3VuZF9hdHUoc3RydWN0IGR3X3BjaWUg
KnBjaSwgdTggZnVuY19ubywNCj4gPj4gICAgICAgIGR3X3BjaWVfd3JpdGVsX2RiaShwY2ksIFBD
SUVfQVRVX1VQUEVSX1RBUkdFVCwNCj4gPj4gICAgICAgICAgICAgICAgICAgICAgICAgICB1cHBl
cl8zMl9iaXRzKHBjaV9hZGRyKSk7DQo+ID4+ICAgICAgICBkd19wY2llX3dyaXRlbF9kYmkocGNp
LCBQQ0lFX0FUVV9DUjEsIHR5cGUgfA0KPiA+PiAtICAgICAgICAgICAgICAgICAgICAgICAgUENJ
RV9BVFVfRlVOQ19OVU0oZnVuY19ubykpOw0KPiA+PiArICAgICAgICAgICAgICAgICAgICAgICAg
UENJRV9BVFVfRlVOQ19OVU0oZnVuY19ubykgfA0KPiA+PiArICAgICAgICAgICAgICAgICAgICAg
ICAgcGNpLT50ZCA8PCBQQ0lFX0FUVV9URF9TSElGVCk7DQo+ID4+ICAgICAgICBkd19wY2llX3dy
aXRlbF9kYmkocGNpLCBQQ0lFX0FUVV9DUjIsIFBDSUVfQVRVX0VOQUJMRSk7DQo+ID4+DQo+ID4+
ICAgICAgICAvKg0KPiA+PiBAQCAtNTY1LDYgKzU2Niw5IEBAIHZvaWQgZHdfcGNpZV9zZXR1cChz
dHJ1Y3QgZHdfcGNpZSAqcGNpKQ0KPiA+PiAgICAgICAgZGV2X2RiZyhwY2ktPmRldiwgImlBVFUg
dW5yb2xsOiAlc1xuIiwgcGNpLT5pYXR1X3Vucm9sbF9lbmFibGVkID8NCj4gPj4gICAgICAgICAg
ICAgICAgImVuYWJsZWQiIDogImRpc2FibGVkIik7DQo+ID4+DQo+ID4+ICsgICAgIGlmIChwY2kt
PnZlcnNpb24gPT0gMHg0OTBBKQ0KPiA+PiArICAgICAgICAgICAgIHBjaS0+dGQgPSBwY2llX2lz
X2VjcmNfZW5hYmxlZCgpOw0KPiA+PiArDQo+ID4+ICAgICAgICBpZiAocGNpLT5saW5rX2dlbiA+
IDApDQo+ID4+ICAgICAgICAgICAgICAgIGR3X3BjaWVfbGlua19zZXRfbWF4X3NwZWVkKHBjaSwg
cGNpLT5saW5rX2dlbik7DQo+ID4+DQo+ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250
cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUuaCBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdj
L3BjaWUtZGVzaWdud2FyZS5oDQo+ID4+IGluZGV4IDIxZGQwNjgzMWI1MC4uZDM0NzIzZTQyZTc5
IDEwMDY0NA0KPiA+PiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2ln
bndhcmUuaA0KPiA+PiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2ln
bndhcmUuaA0KPiA+PiBAQCAtOTAsNiArOTAsNyBAQA0KPiA+PiAgICNkZWZpbmUgUENJRV9BVFVf
VFlQRV9JTyAgICAgICAgICAgICAweDINCj4gPj4gICAjZGVmaW5lIFBDSUVfQVRVX1RZUEVfQ0ZH
MCAgICAgICAgICAgMHg0DQo+ID4+ICAgI2RlZmluZSBQQ0lFX0FUVV9UWVBFX0NGRzEgICAgICAg
ICAgIDB4NQ0KPiA+PiArI2RlZmluZSBQQ0lFX0FUVV9URF9TSElGVCAgICAgICAgICAgIDgNCj4g
Pj4gICAjZGVmaW5lIFBDSUVfQVRVX0ZVTkNfTlVNKHBmKSAgICAgICAgICAgKChwZikgPDwgMjAp
DQo+ID4+ICAgI2RlZmluZSBQQ0lFX0FUVV9DUjIgICAgICAgICAgICAgICAgIDB4OTA4DQo+ID4+
ICAgI2RlZmluZSBQQ0lFX0FUVV9FTkFCTEUgICAgICAgICAgICAgICAgICAgICAgQklUKDMxKQ0K
PiA+PiBAQCAtMjc2LDYgKzI3Nyw3IEBAIHN0cnVjdCBkd19wY2llIHsNCj4gPj4gICAgICAgIGlu
dCAgICAgICAgICAgICAgICAgICAgIG51bV9sYW5lczsNCj4gPj4gICAgICAgIGludCAgICAgICAg
ICAgICAgICAgICAgIGxpbmtfZ2VuOw0KPiA+PiAgICAgICAgdTggICAgICAgICAgICAgICAgICAg
ICAgbl9mdHNbMl07DQo+ID4+ICsgICAgIGJvb2wgICAgICAgICAgICAgICAgICAgIHRkOyAgICAg
LyogVExQIERpZ2VzdCAoZm9yIEVDUkMgcHVycG9zZSkgKi8NCj4gPiANCj4gPiBJZiBwb3NzaWJs
ZSwgZG9uJ3QgYWRkIGEgbmV3IHZhcmlhYmxlIHRvICdkd19wY2llJyBzdHJ1Y3R1cmUuDQo+ID4g
UGxlYXNlIGZpbmQgYSB3YXkgdG8gc2V0IFREIGJpdCB3aXRob3V0IGFkZGluZyBhIG5ldyB2YXJp
YWJsZSB0byAnZHdfcGNpZScgc3RydWN0dXJlJy4NCj4NCj4gSSBjYW4gdXNlIHBjaWVfaXNfZWNy
Y19lbmFibGVkKCkgZGlyZWN0bHkgaW4gcGxhY2Ugb2YgcGNpLT50ZC4gVGhhdCANCj4gc2hvdWxk
IGJlIGZpbmUgcmlnaHQ/IEJUVywgY3VyaW91cyB0byBrbm93IGlmIHRoZXJlIGlzIGFueSBzcGVj
aWZpYyANCj4gcmVhc29uIGJlaGluZCBhc2tpbmcgbm90IHRvIGFkZCBhbnkgbmV3IHZhcmlhYmxl
cyB0byAnZHdfcGNpZScgc3RydWN0dXJlPw0KPg0KDQpWaWNlIHZlcnNhLCB3aGF0IGlzIHRoZSBy
ZWFzb24gdG8gYWRkIGEgbmV3IHZhcmlhYmxlICd0ZCcgdG8gJ2R3X3BjaWUnIHN0cnVjdHVyZT8N
Ckl0IGlzIG5vdCBnb29kIHRvIGFkZCBhIG5ldyB2YXJpYWJsZSB0byB0aGUgZ2xvYmFsIHN0cnVj
dHVyZSB3aXRob3V0IGFueSBzcGVjaWZpYyByZWFzb24uDQoNCg0KPiA+IA0KPiBCZXN0IHJlZ2Fy
ZHMsDQo+IEppbmdvbyBIYW4NCj4gDQo+PiAgIH07DQo+Pg0KPj4gICAjZGVmaW5lIHRvX2R3X3Bj
aWVfZnJvbV9wcChwb3J0KSBjb250YWluZXJfb2YoKHBvcnQpLCBzdHJ1Y3QgZHdfcGNpZSwgcHAp
DQo+PiAtLQ0KPj4gMi4xNy4xDQo+IA0K
