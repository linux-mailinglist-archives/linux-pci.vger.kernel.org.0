Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F3B509157
	for <lists+linux-pci@lfdr.de>; Wed, 20 Apr 2022 22:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382080AbiDTUZO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Apr 2022 16:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350611AbiDTUZN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Apr 2022 16:25:13 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649D42E9D2
        for <linux-pci@vger.kernel.org>; Wed, 20 Apr 2022 13:22:26 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id y10so5811776ejw.8
        for <linux-pci@vger.kernel.org>; Wed, 20 Apr 2022 13:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0DTChLKEaC7rwwyVknKc61wzteWf9dysaz/otxFJdEo=;
        b=nlnwYMIWIY1162rct070pJaOPuL+lJ7s4NorIyWqdxUWSADGDtJANx7E/Z3zF0pxsI
         zM12/StJqfntZbmSWjn4bmwHDuLAMOkr7gRxn3wxCo5UYrW/xDT95I8E+PCmhUXN1paR
         n7G4rAqlarMu5Dx1t4COKmbYiYSeiw8HfTqk8f0sBQTlOfwp3ggAiMO40uzy3ZoTVG+Z
         wmQ8GBvhPI45RXEvS1YsrzhjGVVzEHY0RByM3J9DM8pr/mH7PjJaAYS0W0sOJE1u+NQ1
         BqHv9fh/lFsjI2mPOySbh8NjyjwY7AdSX1hYWrazdajanzlwIzh+ZUG5OYIbT7vDzlEf
         UGAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0DTChLKEaC7rwwyVknKc61wzteWf9dysaz/otxFJdEo=;
        b=ym5YE+vrI0d+G5PFKUznisfL+joOx0uxRb/iItTqKfHuEiMkjvqdunlLZtXz+2CwND
         gnJkopdQAB8jP6hJc3+u/vBYhayMRsYLjwfTm7UjGKH5GqpB3hMh82OPIAq38Ef5xr3Y
         QcOK3yd1CmnOgj5MGEv7HB28vUDGifBY0+VIegRN1Nqn5S4Z0G/GOp1iH9PVd9rSpOAa
         oA78G6UEtZPscWyI8fLJW0XgHz0SJ9bvyQXPQwD3vEZyFGoA188WHsol9CX82QP/0q8q
         fVCDO/2p+Vw4TG5DCYfTiwdUA7FW4JDmH1hFmUaxQWWqjQdFC6Vz1I2UmvM3iyhOS6lP
         8EiA==
X-Gm-Message-State: AOAM5327krASHe70lpLDTJjWeDLSckDPtcet9YOb8PuKaRshLHzLA+xL
        jRmcEg4b83wo4EFxVPWQLZcp+n7vnYA7kTNA58I=
X-Google-Smtp-Source: ABdhPJwf/RFXfv0Y0A+3eeyY+r7FdklUkgenlRxTrG32uYUqU+oaXIrYaJVA9TRKvTVnRFPEYVC0Gaj2CQeTZrAUnp4=
X-Received: by 2002:a17:906:6a1c:b0:6eb:d76c:e835 with SMTP id
 qw28-20020a1709066a1c00b006ebd76ce835mr21142939ejc.15.1650486144778; Wed, 20
 Apr 2022 13:22:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220222162355.32369-1-Frank.Li@nxp.com> <fa2ab3cf-1508-bbeb-47af-8b2d47904b20@ti.com>
 <CAHrpEqT2zwWiiiTUDAu9JNPXmzP1zELF7YDERWjdOohGMFRBnA@mail.gmail.com>
In-Reply-To: <CAHrpEqT2zwWiiiTUDAu9JNPXmzP1zELF7YDERWjdOohGMFRBnA@mail.gmail.com>
From:   Zhi Li <lznuaa@gmail.com>
Date:   Wed, 20 Apr 2022 15:22:13 -0500
Message-ID: <CAHrpEqSceNNQNAzCwbfiJc2Zk9fYCo5KqKmLZqHAG-7teSqF0Q@mail.gmail.com>
Subject: Re: [PATCH V2 0/4] NTB function for PCIe RC to EP connection
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Frank Li <Frank.Li@nxp.com>, Bjorn Helgaas <helgaas@kernel.org>,
        lorenzo.pieralisi@arm.com, kw@linux.com,
        Jingoo Han <jingoohan1@gmail.com>,
        gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVHVlLCBBcHIgNSwgMjAyMiBhdCAxMDozNSBBTSBaaGkgTGkgPGx6bnVhYUBnbWFpbC5jb20+
IHdyb3RlOg0KPg0KPiBPbiBUdWUsIEFwciA1LCAyMDIyIGF0IDU6MzQgQU0gS2lzaG9uIFZpamF5
IEFicmFoYW0gSSA8a2lzaG9uQHRpLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBIaSBGcmFuayBMaSwN
Cj4gPg0KPiA+IE9uIDIyLzAyLzIyIDk6NTMgcG0sIEZyYW5rIExpIHdyb3RlOg0KPiA+ID4gVGhp
cyBpbXBsZW1lbnQgTlRCIGZ1bmN0aW9uIGZvciBQQ0llIEVQIHRvIFJDIGNvbm5lY3Rpb25zLg0K
PiA+ID4gVGhlIGV4aXN0ZWQgbnRiIGVwZiBuZWVkIHR3byBQQ0kgRVBzIGFuZCB0d28gUENJIEhv
c3QuDQo+ID4NCj4gPiBBcyBJIGhhZCBlYXJsaWVyIG1lbnRpb25lZCBpbiBbMV0sIElNSE8gaWRl
YWwgc29sdXRpb24gd291bGQgYmUgYnVpbGQgb24gdmlydGlvDQo+ID4gbGF5ZXIgaW5zdGVhZCBv
ZiB0cnlpbmcgdG8gYnVpbGQgb24gTlRCIGxheWVyICh3aGljaCBpcyBzcGVjaWZpYyB0byBSQzwt
PlJDDQo+ID4gY29tbXVuaWNhdGlvbikuDQo+ID4NCj4gPiBBcmUgdGhlcmUgYW55IHNwZWNpZmlj
IHJlYXNvbnMgZm9yIG5vdCB0YWtpbmcgdGhhdCBwYXRoPw0KPg0KPiAxLiBFUCBzaWRlIHdvcmsg
YXMgdkhPU1QgbW9kZS4gIHZIb3N0IHN1cHBvc2UgYWNjZXNzIGFsbCBtZW1vcnkgb2YgdmlydHVh
bCBpby4NCj4gQnV0IHRoZXJlIGFyZSBvbmx5IG1hcCB3aW5kb3dzIG9uIHRoZSBFUCBzaWRlIHRv
IGFjY2VzcyBSQyBzaWRlDQo+IG1lbW9yeS4gWW91IGhhdmUgdG8gbW92ZQ0KPiBtYXAgd2luZG93
cyBmb3IgZWFjaCBhY2Nlc3MuICBJdCBpcyBxdWl0ZSBsb3cgZWZmaWNpZW5jeS4NCj4NCj4gMi4g
U28gZmFyIGFzIEkga25vdywgdmlydGlvIGlzIHN0aWxsIG5vdCBETUEgeWV0LiAgQ1BVIGFjY2Vz
cyBQQ0kNCj4gY2FuJ3QgZ2VuZXJhdGUgbG9uZ2VyIFBDSSBUTFAsDQo+IFNvIHRoZSBzcGVlZCBp
cyBxdWl0ZSBzbG93LiAgTlRCIGFscmVhZHkgaGFzIERNQSBzdXBwb3J0LiAgSWYgeW91IHVzZQ0K
PiBzeXN0ZW0gbGV2ZWwgRE1BLA0KPiBubyBjaGFuZ2UgaXMgbmVlZGVkIGF0IE5UQiBsZXZlbC4g
IElmIHdlIHdhbnQgdG8gdXNlIGEgUENJIGNvbnRyb2xsZXINCj4gZW1iZWRkZWQgRE1BLCAgc29t
ZSBzbWFsbA0KPiBjaGFuZ2VzIG5lZWQgaWYgYmFzZWQgb24gbXkgb3RoZXIgRGVzaWdud2FyZSBQ
Q0kgZURNQSBwYXRjaGVzLCB3aGljaA0KPiBhcmUgdW5kZXIgcmV2aWV3Lg0KPg0KPiAzLiBBbGwg
dGhlIG1ham9yIGRhdGEgdHJhbnNmZXIgb2YgTlRCIGlzIHVzaW5nIHdyaXRlLiAgQmVjYXVzZSBU
TFANCj4gd3JpdGUgbmVlZG4ndCB3YWl0IGZvciBjb21wbGV0ZSwgIHdyaXRlDQo+IHBlcmZvcm1h
bmNlIGlzIGJldHRlciB0aGFuIHJlYWRpbmcuICBPbiBvdXIgcGxhdGZvcm0sICB3cml0ZQ0KPiBw
ZXJmb3JtYW5jZSBpcyBhYm91dCAxMCUgYmV0dGVyIHRoYW4gIHJlYWQuDQo+DQo+IEZyYW5rDQoN
CkFueSBDb21tZW50cyBvciByZWplY3Rpb24/IEBLaXNob24gVmlqYXkgQWJyYWhhbSBJDQoNCmJl
c3QgcmVnYXJkcw0KRnJhbmsgTGkNCg0KPg0KPiA+DQo+ID4gVGhhbmtzLA0KPiA+IEtpc2hvbg0K
PiA+DQo+ID4gWzFdIC0+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvNDU5NzQ1ZDEtOWZlNy1l
NzkyLTM1MzItMzNlZTk1NTJiYzRkQHRpLmNvbQ0KPiA+ID4NCj4gPiA+IFRoaXMganVzdCBuZWVk
IEVQIHRvIFJDIGNvbm5lY3Rpb25zLg0KPiA+ID4NCj4gPiA+ICAgICDilIzilIDilIDilIDilIDi
lIDilIDilIDilIDilIDilIDilIDilIDilJAgICAgICAgICDilIzilIDilIDilIDilIDilIDilIDi
lIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilJANCj4gPiA+ICAgICDilIIgICAg
ICAgICAgICDilIIgICAgICAgICDilIIgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAg4pSCDQo+ID4gPiAgICAg4pSc4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSkICAgICAgICAg4pSCICAgICAgICAgICAgICAgICAgICAgIOKUjOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUpA0KPiA+ID4gICAgIOKUgiBOVEIgICAgICAgIOKU
giAgICAgICAgIOKUgiAgICAgICAgICAgICAgICAgICAgICDilIIgTlRCICAgICAgICAgIOKUgg0K
PiA+ID4gICAgIOKUgiBOZXREZXYgICAgIOKUgiAgICAgICAgIOKUgiAgICAgICAgICAgICAgICAg
ICAgICDilIIgTmV0RGV2ICAgICAgIOKUgg0KPiA+ID4gICAgIOKUnOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUpCAgICAgICAgIOKUgiAgICAgICAgICAgICAgICAgICAgICDi
lJzilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilKQNCj4gPiA+ICAg
ICDilIIgTlRCICAgICAgICDilIIgICAgICAgICDilIIgICAgICAgICAgICAgICAgICAgICAg4pSC
IE5UQiAgICAgICAgICDilIINCj4gPiA+ICAgICDilIIgVHJhbnNmZXIgICDilIIgICAgICAgICDi
lIIgICAgICAgICAgICAgICAgICAgICAg4pSCIFRyYW5zZmVyICAgICDilIINCj4gPiA+ICAgICDi
lJzilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilKQgICAgICAgICDilIIgICAg
ICAgICAgICAgICAgICAgICAg4pSc4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSkDQo+ID4gPiAgICAg4pSCICAgICAgICAgICAg4pSCICAgICAgICAg4pSCICAgICAg
ICAgICAgICAgICAgICAgIOKUgiAgICAgICAgICAgICAg4pSCDQo+ID4gPiAgICAg4pSCICBQQ0kg
TlRCICAg4pSCICAgICAgICAg4pSCICAgICAgICAgICAgICAgICAgICAgIOKUgiAgICAgICAgICAg
ICAg4pSCDQo+ID4gPiAgICAg4pSCICAgIEVQRiAgICAg4pSCICAgICAgICAg4pSCICAgICAgICAg
ICAgICAgICAgICAgIOKUgiAgICAgICAgICAgICAg4pSCDQo+ID4gPiAgICAg4pSCICAgRHJpdmVy
ICAg4pSCICAgICAgICAg4pSCICAgICAgICAgICAgICAgICAgICAgIOKUgiBQQ0kgVmlydHVhbCAg
4pSCDQo+ID4gPiAgICAg4pSCICAgICAgICAgICAg4pSCICAgICAgICAg4pSc4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSQICAgICAg4pSCIE5UQiBEcml2ZXIg
ICDilIINCj4gPiA+ICAgICDilIIgICAgICAgICAgICDilIIgICAgICAgICDilIIgUENJIEVQIE5U
QiAgICDilILil4TilIDilIDilIDilIDilrrilIIgICAgICAgICAgICAgIOKUgg0KPiA+ID4gICAg
IOKUgiAgICAgICAgICAgIOKUgiAgICAgICAgIOKUgiAgRk4gRHJpdmVyICAgIOKUgiAgICAgIOKU
giAgICAgICAgICAgICAg4pSCDQo+ID4gPiAgICAg4pSc4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSkICAgICAgICAg4pSc4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSkICAgICAg4pSc4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSkDQo+ID4gPiAgICAg4pSCICAgICAgICAgICAg4pSCICAgICAgICAg4pSC
ICAgICAgICAgICAgICAg4pSCICAgICAg4pSCICAgICAgICAgICAgICDilIINCj4gPiA+ICAgICDi
lIIgIFBDSSBCVVMgICDilIIg4peE4pSA4pSA4pSA4pSA4pSA4pa6IOKUgiAgUENJIEVQIEJVUyAg
IOKUgiAgICAgIOKUgiAgVmlydHVhbCBQQ0kg4pSCDQo+ID4gPiAgICAg4pSCICAgICAgICAgICAg
4pSCICBQQ0kgICAg4pSCICAgICAgICAgICAgICAg4pSCICAgICAg4pSCICAgICBCVVMgICAgICDi
lIINCj4gPiA+ICAgICDilJTilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilJgg
ICAgICAgICDilJTilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lLTilIDilIDilIDilIDilIDilIDilLTilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilIDilIDilJgNCj4gPiA+ICAgICAgICAgUENJIFJDICAgICAgICAgICAgICAgICAgICAgICAg
UENJIEVQDQo+ID4gPg0KPiA+ID4NCj4gPiA+DQo+ID4gPiBGcmFuayBMaSAoNCk6DQo+ID4gPiAg
IFBDSTogZGVzaWdud2FyZS1lcDogQWxsb3cgcGNpX2VwY19zZXRfYmFyKCkgdXBkYXRlIGluYm91
bmQgbWFwIGFkZHJlc3MNCj4gPiA+ICAgTlRCOiBlcGY6IEFsbG93IG1vcmUgZmxleGliaWxpdHkg
aW4gdGhlIG1lbW9yeSBCQVIgbWFwIG1ldGhvZA0KPiA+ID4gICBQQ0k6IGVuZHBvaW50OiBTdXBw
b3J0IE5UQiB0cmFuc2ZlciBiZXR3ZWVuIFJDIGFuZCBFUA0KPiA+ID4gICBEb2N1bWVudGF0aW9u
OiBQQ0k6IEFkZCBzcGVjaWZpY2F0aW9uIGZvciB0aGUgUENJIHZOVEIgZnVuY3Rpb24gZGV2aWNl
DQo+ID4gPg0KPiA+ID4gIERvY3VtZW50YXRpb24vUENJL2VuZHBvaW50L2luZGV4LnJzdCAgICAg
ICAgICB8ICAgIDIgKw0KPiA+ID4gIC4uLi9QQ0kvZW5kcG9pbnQvcGNpLXZudGItZnVuY3Rpb24u
cnN0ICAgICAgICB8ICAxMjYgKysNCj4gPiA+ICBEb2N1bWVudGF0aW9uL1BDSS9lbmRwb2ludC9w
Y2ktdm50Yi1ob3d0by5yc3QgfCAgMTY3ICsrDQo+ID4gPiAgZHJpdmVycy9udGIvaHcvZXBmL250
Yl9od19lcGYuYyAgICAgICAgICAgICAgIHwgICA0OCArLQ0KPiA+ID4gIC4uLi9wY2kvY29udHJv
bGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLWVwLmMgICB8ICAgMTAgKy0NCj4gPiA+ICBkcml2ZXJz
L3BjaS9lbmRwb2ludC9mdW5jdGlvbnMvS2NvbmZpZyAgICAgICAgfCAgIDExICsNCj4gPiA+ICBk
cml2ZXJzL3BjaS9lbmRwb2ludC9mdW5jdGlvbnMvTWFrZWZpbGUgICAgICAgfCAgICAxICsNCj4g
PiA+ICBkcml2ZXJzL3BjaS9lbmRwb2ludC9mdW5jdGlvbnMvcGNpLWVwZi12bnRiLmMgfCAxNDI0
ICsrKysrKysrKysrKysrKysrDQo+ID4gPiAgOCBmaWxlcyBjaGFuZ2VkLCAxNzc1IGluc2VydGlv
bnMoKyksIDE0IGRlbGV0aW9ucygtKQ0KPiA+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVu
dGF0aW9uL1BDSS9lbmRwb2ludC9wY2ktdm50Yi1mdW5jdGlvbi5yc3QNCj4gPiA+ICBjcmVhdGUg
bW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9QQ0kvZW5kcG9pbnQvcGNpLXZudGItaG93dG8ucnN0
DQo+ID4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvcGNpL2VuZHBvaW50L2Z1bmN0aW9u
cy9wY2ktZXBmLXZudGIuYw0KPiA+ID4NCg==
