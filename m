Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2DB64F1CF4
	for <lists+linux-pci@lfdr.de>; Mon,  4 Apr 2022 23:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382416AbiDDV3i (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Apr 2022 17:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380465AbiDDUOb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Apr 2022 16:14:31 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC8332ED6
        for <linux-pci@vger.kernel.org>; Mon,  4 Apr 2022 13:12:34 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id g22so12497359edz.2
        for <linux-pci@vger.kernel.org>; Mon, 04 Apr 2022 13:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=V+yE8jLxkve1ycY7ollAQEd3VziDOT8vd+4R3TOSpbg=;
        b=OLs6xoYA4azTSgRSrq4v7blms3aQdtUaHcxyMyL8tmK6seAHgH8KKjSYDUZUweA11F
         ZA1QxmoF/tEf8Jy1at/dA/oOS10vMVrxA3edlTR3T1pLyr+wnsQuGMauvVlXS+BKdJUw
         FGV5UYKfrhJNxB8iGZPrKAvDV2rZDJvSbobcR1QP5H4QuYmTv+YhAO30Lhv1+AayCOlh
         f5GTRppYjyGQy4TkSQ7QaDPMllmESU3tlx0vViHt5BvWKHFmrnlWfW42CyngvmPlrnvr
         Vacea4chpWcnd1MCnGcr2hh+YUljWyC3tJJ5LV5+ZtthsEZDU+Uy1jCX3Wqkz3RoLADS
         DL9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=V+yE8jLxkve1ycY7ollAQEd3VziDOT8vd+4R3TOSpbg=;
        b=51BdY6uOs3ZREyb17DevDq55N275VHru0jhMPzvbkhCqTyJVQDA6gmX782Ec603Q62
         AnbH/VemG7hOmT8Hoicv9iyo/iH0gv0nKcXZH3Hgagp0PThiLbsamt99wtjrSXwlv3Vh
         2azgWr0IjuYr9ZhOpR0j0VGBwaJ+qQ178rSj+SHzSfwlEauZdXtcLsBO10YLdQfzrAxv
         OxDuOgepnJZ325QIcWCYU1/LLIVyJNCcUHCYJhzGlSVSewPf7FkqaUolPW1P+rZTgKhZ
         g6xUZ3n/JrcHsnRO5ud2Umc4IQQRPlI6UUbvoB4kh2TS+ad25nbpY/nn5+J0Cf5ElYaq
         dfDw==
X-Gm-Message-State: AOAM531wIiOzNOV+43fgQRU+Sl4EnIe75/jg8VMM0icLwSXottwlR4+5
        hQzy1v6b4Du4MV5qZ+HPP3YYAoGzi+2lp80TqR0=
X-Google-Smtp-Source: ABdhPJwLQSsjwV/yCGkvtGLrACwf698x+5JCN+kImLYfiA604auGyL0FSg+vaHZ7Ltq+ZN7NkoF6+LDmludfA0kPOHI=
X-Received: by 2002:aa7:de93:0:b0:418:d700:662a with SMTP id
 j19-20020aa7de93000000b00418d700662amr1939013edv.107.1649103149333; Mon, 04
 Apr 2022 13:12:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220222162355.32369-1-Frank.Li@nxp.com> <CAHrpEqTFP7SUgoTFq5Dn2-rOrAL_DCX97nRww7o_xnDJ+zDmtw@mail.gmail.com>
 <CAHrpEqTTuJhK5-kB7Q2SLt3uTvcef+ehDUA8v_f1-Zna1UN+CQ@mail.gmail.com>
In-Reply-To: <CAHrpEqTTuJhK5-kB7Q2SLt3uTvcef+ehDUA8v_f1-Zna1UN+CQ@mail.gmail.com>
From:   Zhi Li <lznuaa@gmail.com>
Date:   Mon, 4 Apr 2022 15:12:17 -0500
Message-ID: <CAHrpEqRBEp=201oc4qv7YT68u+KH5EaaG=Ln_Y5ypmKagWM6Qg@mail.gmail.com>
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

T24gVGh1LCBNYXIgMTAsIDIwMjIgYXQgNDowNyBQTSBaaGkgTGkgPGx6bnVhYUBnbWFpbC5jb20+
IHdyb3RlOg0KPg0KPiBPbiBUaHUsIE1hciAxMCwgMjAyMiBhdCA0OjAxIFBNIFpoaSBMaSA8bHpu
dWFhQGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBPbiBUdWUsIEZlYiAyMiwgMjAyMiBhdCAx
MDoyNCBBTSBGcmFuayBMaSA8RnJhbmsuTGlAbnhwLmNvbT4gd3JvdGU6DQo+ID4gPg0KPiA+ID4g
VGhpcyBpbXBsZW1lbnQgTlRCIGZ1bmN0aW9uIGZvciBQQ0llIEVQIHRvIFJDIGNvbm5lY3Rpb25z
Lg0KPiA+ID4gVGhlIGV4aXN0ZWQgbnRiIGVwZiBuZWVkIHR3byBQQ0kgRVBzIGFuZCB0d28gUENJ
IEhvc3QuDQo+ID4gPg0KPiA+ID4gVGhpcyBqdXN0IG5lZWQgRVAgdG8gUkMgY29ubmVjdGlvbnMu
DQo+ID4gPg0KPiA+ID4gICAgIOKUjOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUkCAgICAgICAgIOKUjOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUkA0KPiA+ID4gICAgIOKUgiAgICAgICAgICAgIOKUgiAgICAgICAgIOKU
giAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICDilIINCj4gPiA+ICAgICDilJzi
lIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilKQgICAgICAgICDilIIgICAgICAg
ICAgICAgICAgICAgICAg4pSM4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSkDQo+ID4gPiAgICAg4pSCIE5UQiAgICAgICAg4pSCICAgICAgICAg4pSCICAgICAgICAg
ICAgICAgICAgICAgIOKUgiBOVEIgICAgICAgICAg4pSCDQo+ID4gPiAgICAg4pSCIE5ldERldiAg
ICAg4pSCICAgICAgICAg4pSCICAgICAgICAgICAgICAgICAgICAgIOKUgiBOZXREZXYgICAgICAg
4pSCDQo+ID4gPiAgICAg4pSc4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSk
ICAgICAgICAg4pSCICAgICAgICAgICAgICAgICAgICAgIOKUnOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUpA0KPiA+ID4gICAgIOKUgiBOVEIgICAgICAgIOKUgiAg
ICAgICAgIOKUgiAgICAgICAgICAgICAgICAgICAgICDilIIgTlRCICAgICAgICAgIOKUgg0KPiA+
ID4gICAgIOKUgiBUcmFuc2ZlciAgIOKUgiAgICAgICAgIOKUgiAgICAgICAgICAgICAgICAgICAg
ICDilIIgVHJhbnNmZXIgICAgIOKUgg0KPiA+ID4gICAgIOKUnOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUpCAgICAgICAgIOKUgiAgICAgICAgICAgICAgICAgICAgICDilJzi
lIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilKQNCj4gPiA+ICAgICDi
lIIgICAgICAgICAgICDilIIgICAgICAgICDilIIgICAgICAgICAgICAgICAgICAgICAg4pSCICAg
ICAgICAgICAgICDilIINCj4gPiA+ICAgICDilIIgIFBDSSBOVEIgICDilIIgICAgICAgICDilIIg
ICAgICAgICAgICAgICAgICAgICAg4pSCICAgICAgICAgICAgICDilIINCj4gPiA+ICAgICDilIIg
ICAgRVBGICAgICDilIIgICAgICAgICDilIIgICAgICAgICAgICAgICAgICAgICAg4pSCICAgICAg
ICAgICAgICDilIINCj4gPiA+ICAgICDilIIgICBEcml2ZXIgICDilIIgICAgICAgICDilIIgICAg
ICAgICAgICAgICAgICAgICAg4pSCIFBDSSBWaXJ0dWFsICDilIINCj4gPiA+ICAgICDilIIgICAg
ICAgICAgICDilIIgICAgICAgICDilJzilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilIDilIDilIDilJAgICAgICDilIIgTlRCIERyaXZlciAgIOKUgg0KPiA+ID4gICAgIOKUgiAg
ICAgICAgICAgIOKUgiAgICAgICAgIOKUgiBQQ0kgRVAgTlRCICAgIOKUguKXhOKUgOKUgOKUgOKU
gOKWuuKUgiAgICAgICAgICAgICAg4pSCDQo+ID4gPiAgICAg4pSCICAgICAgICAgICAg4pSCICAg
ICAgICAg4pSCICBGTiBEcml2ZXIgICAg4pSCICAgICAg4pSCICAgICAgICAgICAgICDilIINCj4g
PiA+ICAgICDilJzilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilKQgICAgICAg
ICDilJzilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilKQgICAg
ICDilJzilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilKQNCj4gPiA+
ICAgICDilIIgICAgICAgICAgICDilIIgICAgICAgICDilIIgICAgICAgICAgICAgICDilIIgICAg
ICDilIIgICAgICAgICAgICAgIOKUgg0KPiA+ID4gICAgIOKUgiAgUENJIEJVUyAgIOKUgiDil4Ti
lIDilIDilIDilIDilIDilrog4pSCICBQQ0kgRVAgQlVTICAg4pSCICAgICAg4pSCICBWaXJ0dWFs
IFBDSSDilIINCj4gPiA+ICAgICDilIIgICAgICAgICAgICDilIIgIFBDSSAgICDilIIgICAgICAg
ICAgICAgICDilIIgICAgICDilIIgICAgIEJVUyAgICAgIOKUgg0KPiA+ID4gICAgIOKUlOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUmCAgICAgICAgIOKUlOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUtOKUgOKUgOKUgOKUgOKUgOKUgOKU
tOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUmA0KPiA+ID4gICAg
ICAgICBQQ0kgUkMgICAgICAgICAgICAgICAgICAgICAgICBQQ0kgRVANCj4gPiA+DQo+ID4gPg0K
PiA+ID4NCj4gPiA+IEZyYW5rIExpICg0KToNCj4gPiA+ICAgUENJOiBkZXNpZ253YXJlLWVwOiBB
bGxvdyBwY2lfZXBjX3NldF9iYXIoKSB1cGRhdGUgaW5ib3VuZCBtYXAgYWRkcmVzcw0KPiA+ID4g
ICBOVEI6IGVwZjogQWxsb3cgbW9yZSBmbGV4aWJpbGl0eSBpbiB0aGUgbWVtb3J5IEJBUiBtYXAg
bWV0aG9kDQo+ID4gPiAgIFBDSTogZW5kcG9pbnQ6IFN1cHBvcnQgTlRCIHRyYW5zZmVyIGJldHdl
ZW4gUkMgYW5kIEVQDQo+ID4gPiAgIERvY3VtZW50YXRpb246IFBDSTogQWRkIHNwZWNpZmljYXRp
b24gZm9yIHRoZSBQQ0kgdk5UQiBmdW5jdGlvbiBkZXZpY2UNCj4gPiA+DQo+ID4NCj4NCj4gVXBk
YXRlIG50YiBtYWlsIGxpc3QNCg0KRnJpZW5kbHkgcGluZyENCg0KRnJhbmsgTGkNCg0KPg0KPiA+
DQo+ID4gPiAgRG9jdW1lbnRhdGlvbi9QQ0kvZW5kcG9pbnQvaW5kZXgucnN0ICAgICAgICAgIHwg
ICAgMiArDQo+ID4gPiAgLi4uL1BDSS9lbmRwb2ludC9wY2ktdm50Yi1mdW5jdGlvbi5yc3QgICAg
ICAgIHwgIDEyNiArKw0KPiA+ID4gIERvY3VtZW50YXRpb24vUENJL2VuZHBvaW50L3BjaS12bnRi
LWhvd3RvLnJzdCB8ICAxNjcgKysNCj4gPiA+ICBkcml2ZXJzL250Yi9ody9lcGYvbnRiX2h3X2Vw
Zi5jICAgICAgICAgICAgICAgfCAgIDQ4ICstDQo+ID4gPiAgLi4uL3BjaS9jb250cm9sbGVyL2R3
Yy9wY2llLWRlc2lnbndhcmUtZXAuYyAgIHwgICAxMCArLQ0KPiA+ID4gIGRyaXZlcnMvcGNpL2Vu
ZHBvaW50L2Z1bmN0aW9ucy9LY29uZmlnICAgICAgICB8ICAgMTEgKw0KPiA+ID4gIGRyaXZlcnMv
cGNpL2VuZHBvaW50L2Z1bmN0aW9ucy9NYWtlZmlsZSAgICAgICB8ICAgIDEgKw0KPiA+ID4gIGRy
aXZlcnMvcGNpL2VuZHBvaW50L2Z1bmN0aW9ucy9wY2ktZXBmLXZudGIuYyB8IDE0MjQgKysrKysr
KysrKysrKysrKysNCj4gPiA+ICA4IGZpbGVzIGNoYW5nZWQsIDE3NzUgaW5zZXJ0aW9ucygrKSwg
MTQgZGVsZXRpb25zKC0pDQo+ID4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24v
UENJL2VuZHBvaW50L3BjaS12bnRiLWZ1bmN0aW9uLnJzdA0KPiA+ID4gIGNyZWF0ZSBtb2RlIDEw
MDY0NCBEb2N1bWVudGF0aW9uL1BDSS9lbmRwb2ludC9wY2ktdm50Yi1ob3d0by5yc3QNCj4gPiA+
ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9wY2kvZW5kcG9pbnQvZnVuY3Rpb25zL3BjaS1l
cGYtdm50Yi5jDQo+ID4gPg0KPiA+ID4gLS0NCj4gPiA+IDIuMjQuMC5yYzENCj4gPiA+DQo=
