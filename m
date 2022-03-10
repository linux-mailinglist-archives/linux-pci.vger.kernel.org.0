Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1EBB4D5422
	for <lists+linux-pci@lfdr.de>; Thu, 10 Mar 2022 23:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241630AbiCJWIZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Mar 2022 17:08:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbiCJWIZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Mar 2022 17:08:25 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CFB61903FE
        for <linux-pci@vger.kernel.org>; Thu, 10 Mar 2022 14:07:23 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id w4so8739880edc.7
        for <linux-pci@vger.kernel.org>; Thu, 10 Mar 2022 14:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fvPFEiPU5UyRC1KvHgTbAeXANF7Wd/3XWoxoO/Ay+ws=;
        b=TkvBCjiCd7qbRbDPY/8mmm89e4c5sf4zvZcVm5kYAC9963GbaHk8zybBiAGplD0Ouv
         ann1piuZBEMhtwQRx7N7iOdtooa1FNtv5w0niqbAE+T9lckvrMF133edKpgqVwuONoMx
         AoaIfAHjDJrF/LqyH9TGstWgekIXg7eb5rpYXCPqhseCHxo7CfoRqDZcLS/VvkV5o95d
         5yIfqBZSCGgAi1BcjYCfFZouxmlJTqYvqBILu/SElNiPx/zn0mNgcAFKi4YMbp9gaBEk
         6lBubihpVgBG/erDGJgWwtHAvZTpao9OTl2hr90a5f0aDK781LYWYC/q+BDcbIZ/SSHe
         G0kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fvPFEiPU5UyRC1KvHgTbAeXANF7Wd/3XWoxoO/Ay+ws=;
        b=Mh7DHwH94Tgw5qtsMPTo19aP+VWnByCfF5AeI0QAFdvJBYYraPbu14twfkqO0mD6rm
         EsdaaDCIaM8Ta0WVbp1vI5o6j8ntiDZGhcFdxOQcU2TcsHrx3xux0YUxntPvdra9CEnF
         jLjlJCG2J54bWolgg66HFoXMrd6gqZFgwCQX79Zj6fLryzbXVxAIeFI9R4srIRQS2MVt
         ZU4KRppmDLePRDNtBVI8T14jXsbWt91VqE2LU5Zsq40ZzynzCt91FjzLcyMpXCaBzJF3
         gsfw4clnNmnUZZ/mVGFstd8YfR+W5umRcq3FoZoUODd47eoWQTt0GC8vRn7xDpFh/TiG
         hW3w==
X-Gm-Message-State: AOAM531KFRvdHQQYgaHvOeo5P3iy4taGKaWDRokTygv4ND+d1k1fkLXT
        x05Hj54qTSFX3u6BOS4ZyiRSPe/bUyP8bgsQ2WY=
X-Google-Smtp-Source: ABdhPJyNXgXuYALQhB/UTXrFz51matLU5nxjRHmEITg9fOGOAhlQTUIeapTKYI27JtTu+tvflvkU3mDR+BGDqad9GRA=
X-Received: by 2002:a05:6402:1e89:b0:416:a641:9fe with SMTP id
 f9-20020a0564021e8900b00416a64109femr6334748edf.312.1646950041456; Thu, 10
 Mar 2022 14:07:21 -0800 (PST)
MIME-Version: 1.0
References: <20220222162355.32369-1-Frank.Li@nxp.com> <CAHrpEqTFP7SUgoTFq5Dn2-rOrAL_DCX97nRww7o_xnDJ+zDmtw@mail.gmail.com>
In-Reply-To: <CAHrpEqTFP7SUgoTFq5Dn2-rOrAL_DCX97nRww7o_xnDJ+zDmtw@mail.gmail.com>
From:   Zhi Li <lznuaa@gmail.com>
Date:   Thu, 10 Mar 2022 16:07:10 -0600
Message-ID: <CAHrpEqTTuJhK5-kB7Q2SLt3uTvcef+ehDUA8v_f1-Zna1UN+CQ@mail.gmail.com>
Subject: Re: [PATCH V2 0/4] NTB function for PCIe RC to EP connection
To:     Frank Li <Frank.Li@nxp.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, kishon@ti.com,
        lorenzo.pieralisi@arm.com, kw@linux.com,
        Jingoo Han <jingoohan1@gmail.com>,
        gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com,
        linux-pci@vger.kernel.org, ntb@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVGh1LCBNYXIgMTAsIDIwMjIgYXQgNDowMSBQTSBaaGkgTGkgPGx6bnVhYUBnbWFpbC5jb20+
IHdyb3RlOg0KPg0KPiBPbiBUdWUsIEZlYiAyMiwgMjAyMiBhdCAxMDoyNCBBTSBGcmFuayBMaSA8
RnJhbmsuTGlAbnhwLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBUaGlzIGltcGxlbWVudCBOVEIgZnVu
Y3Rpb24gZm9yIFBDSWUgRVAgdG8gUkMgY29ubmVjdGlvbnMuDQo+ID4gVGhlIGV4aXN0ZWQgbnRi
IGVwZiBuZWVkIHR3byBQQ0kgRVBzIGFuZCB0d28gUENJIEhvc3QuDQo+ID4NCj4gPiBUaGlzIGp1
c3QgbmVlZCBFUCB0byBSQyBjb25uZWN0aW9ucy4NCj4gPg0KPiA+ICAgICDilIzilIDilIDilIDi
lIDilIDilIDilIDilIDilIDilIDilIDilIDilJAgICAgICAgICDilIzilIDilIDilIDilIDilIDi
lIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilJANCj4gPiAgICAg4pSCICAg
ICAgICAgICAg4pSCICAgICAgICAg4pSCICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIOKUgg0KPiA+ICAgICDilJzilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lKQgICAgICAgICDilIIgICAgICAgICAgICAgICAgICAgICAg4pSM4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSkDQo+ID4gICAgIOKUgiBOVEIgICAgICAgIOKUgiAg
ICAgICAgIOKUgiAgICAgICAgICAgICAgICAgICAgICDilIIgTlRCICAgICAgICAgIOKUgg0KPiA+
ICAgICDilIIgTmV0RGV2ICAgICDilIIgICAgICAgICDilIIgICAgICAgICAgICAgICAgICAgICAg
4pSCIE5ldERldiAgICAgICDilIINCj4gPiAgICAg4pSc4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSkICAgICAgICAg4pSCICAgICAgICAgICAgICAgICAgICAgIOKUnOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUpA0KPiA+ICAgICDilIIgTlRC
ICAgICAgICDilIIgICAgICAgICDilIIgICAgICAgICAgICAgICAgICAgICAg4pSCIE5UQiAgICAg
ICAgICDilIINCj4gPiAgICAg4pSCIFRyYW5zZmVyICAg4pSCICAgICAgICAg4pSCICAgICAgICAg
ICAgICAgICAgICAgIOKUgiBUcmFuc2ZlciAgICAg4pSCDQo+ID4gICAgIOKUnOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUpCAgICAgICAgIOKUgiAgICAgICAgICAgICAgICAg
ICAgICDilJzilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilKQNCj4g
PiAgICAg4pSCICAgICAgICAgICAg4pSCICAgICAgICAg4pSCICAgICAgICAgICAgICAgICAgICAg
IOKUgiAgICAgICAgICAgICAg4pSCDQo+ID4gICAgIOKUgiAgUENJIE5UQiAgIOKUgiAgICAgICAg
IOKUgiAgICAgICAgICAgICAgICAgICAgICDilIIgICAgICAgICAgICAgIOKUgg0KPiA+ICAgICDi
lIIgICAgRVBGICAgICDilIIgICAgICAgICDilIIgICAgICAgICAgICAgICAgICAgICAg4pSCICAg
ICAgICAgICAgICDilIINCj4gPiAgICAg4pSCICAgRHJpdmVyICAg4pSCICAgICAgICAg4pSCICAg
ICAgICAgICAgICAgICAgICAgIOKUgiBQQ0kgVmlydHVhbCAg4pSCDQo+ID4gICAgIOKUgiAgICAg
ICAgICAgIOKUgiAgICAgICAgIOKUnOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUkCAgICAgIOKUgiBOVEIgRHJpdmVyICAg4pSCDQo+ID4gICAgIOKUgiAgICAg
ICAgICAgIOKUgiAgICAgICAgIOKUgiBQQ0kgRVAgTlRCICAgIOKUguKXhOKUgOKUgOKUgOKUgOKW
uuKUgiAgICAgICAgICAgICAg4pSCDQo+ID4gICAgIOKUgiAgICAgICAgICAgIOKUgiAgICAgICAg
IOKUgiAgRk4gRHJpdmVyICAgIOKUgiAgICAgIOKUgiAgICAgICAgICAgICAg4pSCDQo+ID4gICAg
IOKUnOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUpCAgICAgICAgIOKUnOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUpCAgICAgIOKUnOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUpA0KPiA+ICAgICDilIIg
ICAgICAgICAgICDilIIgICAgICAgICDilIIgICAgICAgICAgICAgICDilIIgICAgICDilIIgICAg
ICAgICAgICAgIOKUgg0KPiA+ICAgICDilIIgIFBDSSBCVVMgICDilIIg4peE4pSA4pSA4pSA4pSA
4pSA4pa6IOKUgiAgUENJIEVQIEJVUyAgIOKUgiAgICAgIOKUgiAgVmlydHVhbCBQQ0kg4pSCDQo+
ID4gICAgIOKUgiAgICAgICAgICAgIOKUgiAgUENJICAgIOKUgiAgICAgICAgICAgICAgIOKUgiAg
ICAgIOKUgiAgICAgQlVTICAgICAg4pSCDQo+ID4gICAgIOKUlOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUmCAgICAgICAgIOKUlOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUtOKUgOKUgOKUgOKUgOKUgOKUgOKUtOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUmA0KPiA+ICAgICAgICAgUENJIFJDICAgICAg
ICAgICAgICAgICAgICAgICAgUENJIEVQDQo+ID4NCj4gPg0KPiA+DQo+ID4gRnJhbmsgTGkgKDQp
Og0KPiA+ICAgUENJOiBkZXNpZ253YXJlLWVwOiBBbGxvdyBwY2lfZXBjX3NldF9iYXIoKSB1cGRh
dGUgaW5ib3VuZCBtYXAgYWRkcmVzcw0KPiA+ICAgTlRCOiBlcGY6IEFsbG93IG1vcmUgZmxleGli
aWxpdHkgaW4gdGhlIG1lbW9yeSBCQVIgbWFwIG1ldGhvZA0KPiA+ICAgUENJOiBlbmRwb2ludDog
U3VwcG9ydCBOVEIgdHJhbnNmZXIgYmV0d2VlbiBSQyBhbmQgRVANCj4gPiAgIERvY3VtZW50YXRp
b246IFBDSTogQWRkIHNwZWNpZmljYXRpb24gZm9yIHRoZSBQQ0kgdk5UQiBmdW5jdGlvbiBkZXZp
Y2UNCj4gPg0KPg0KDQpVcGRhdGUgbnRiIG1haWwgbGlzdA0KDQo+DQo+ID4gIERvY3VtZW50YXRp
b24vUENJL2VuZHBvaW50L2luZGV4LnJzdCAgICAgICAgICB8ICAgIDIgKw0KPiA+ICAuLi4vUENJ
L2VuZHBvaW50L3BjaS12bnRiLWZ1bmN0aW9uLnJzdCAgICAgICAgfCAgMTI2ICsrDQo+ID4gIERv
Y3VtZW50YXRpb24vUENJL2VuZHBvaW50L3BjaS12bnRiLWhvd3RvLnJzdCB8ICAxNjcgKysNCj4g
PiAgZHJpdmVycy9udGIvaHcvZXBmL250Yl9od19lcGYuYyAgICAgICAgICAgICAgIHwgICA0OCAr
LQ0KPiA+ICAuLi4vcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS1lcC5jICAgfCAg
IDEwICstDQo+ID4gIGRyaXZlcnMvcGNpL2VuZHBvaW50L2Z1bmN0aW9ucy9LY29uZmlnICAgICAg
ICB8ICAgMTEgKw0KPiA+ICBkcml2ZXJzL3BjaS9lbmRwb2ludC9mdW5jdGlvbnMvTWFrZWZpbGUg
ICAgICAgfCAgICAxICsNCj4gPiAgZHJpdmVycy9wY2kvZW5kcG9pbnQvZnVuY3Rpb25zL3BjaS1l
cGYtdm50Yi5jIHwgMTQyNCArKysrKysrKysrKysrKysrKw0KPiA+ICA4IGZpbGVzIGNoYW5nZWQs
IDE3NzUgaW5zZXJ0aW9ucygrKSwgMTQgZGVsZXRpb25zKC0pDQo+ID4gIGNyZWF0ZSBtb2RlIDEw
MDY0NCBEb2N1bWVudGF0aW9uL1BDSS9lbmRwb2ludC9wY2ktdm50Yi1mdW5jdGlvbi5yc3QNCj4g
PiAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vUENJL2VuZHBvaW50L3BjaS12bnRi
LWhvd3RvLnJzdA0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9wY2kvZW5kcG9pbnQv
ZnVuY3Rpb25zL3BjaS1lcGYtdm50Yi5jDQo+ID4NCj4gPiAtLQ0KPiA+IDIuMjQuMC5yYzENCj4g
Pg0K
