Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6E34D5415
	for <lists+linux-pci@lfdr.de>; Thu, 10 Mar 2022 23:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240275AbiCJWC1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Mar 2022 17:02:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbiCJWC0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Mar 2022 17:02:26 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDA8194A9C
        for <linux-pci@vger.kernel.org>; Thu, 10 Mar 2022 14:01:24 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id qa43so14982663ejc.12
        for <linux-pci@vger.kernel.org>; Thu, 10 Mar 2022 14:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BWdFMs6xgab+RuaIxJQnFK+7CxewzPCWBuyRE87cDO4=;
        b=otiQWDzQurWmWt5KZVMP5vALvcUFZRL5Lyy5u7rGXyvjUA/UE5OAyT77WxhZXrOUfW
         F2yUEbg/0Hvvr4e8iilpZoxL9SWKjEMqW7pKDYqNSI2va+zH1Sys6lQiBD+jRp7Hsrsx
         F+21VUjzUbSP6m9zqBBRAXpwbQq3iVPhI39IN6L1tkENuwXCz9W/78ykKA0K1C3s/ZCG
         8E84h5H7FG0nBwDvrYdmCxKstcL1hBmRvkONV1tHwMzNuWNb08IcyigrKpZotXgn9qBt
         n4Z6EAWzJ8EwActpYWMlp6sQxmfrFUGZVqN+Ns5Jo6WwonKfVwhY8XLPwYTdGASJCWUH
         8k1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BWdFMs6xgab+RuaIxJQnFK+7CxewzPCWBuyRE87cDO4=;
        b=tlhw//Ajvuk4hx/rk7Jn9wsvUQ1sAVYLPy5CLcLeAd8s9XcM1AXne5s4ElfA1cNWKM
         34QI6PGYJnXyaWJEox5kUifSSu9rz8z17v0uvV9FCNh762ZpI7Vx/SM8jpIHedB9LG4i
         YnYNAyQ7XTq+7BLQFJEhIFpwTmjN5o9bF4G88ocW3/FobH+GctYMayEujgp+l/59mzcX
         71Mhs6IIamqtQAI2ZhxH3n23pu2X6Ew/1UeeLfYme6TKSTq9m75zBRwbv0wQa2o8vSmv
         L561jU6z8HpeVNr+Yl2FC60eACbgYusIOsFnQQec2CUdGH3DvW21cryQueLQKFZEACAt
         92Ng==
X-Gm-Message-State: AOAM530iFNp75+T4/xaY14ATamY9LdkAy7ntu5w9hd2E10W1kIAUmeYJ
        Xwr+furhDt8xcNOlYyIYxEwF3IpWCZoHHA+xI4Y=
X-Google-Smtp-Source: ABdhPJwDvBt+Xjrv8DtelJF2p4vr5AqojWBHkWMILgD+gLEB2T9xhhNI9I/QaEgvnbsAFOCgK7gYRiMN/qaUMsdaB+U=
X-Received: by 2002:a17:906:dc90:b0:6da:a5b1:7879 with SMTP id
 cs16-20020a170906dc9000b006daa5b17879mr5960086ejc.433.1646949683234; Thu, 10
 Mar 2022 14:01:23 -0800 (PST)
MIME-Version: 1.0
References: <20220222162355.32369-1-Frank.Li@nxp.com>
In-Reply-To: <20220222162355.32369-1-Frank.Li@nxp.com>
From:   Zhi Li <lznuaa@gmail.com>
Date:   Thu, 10 Mar 2022 16:01:11 -0600
Message-ID: <CAHrpEqTFP7SUgoTFq5Dn2-rOrAL_DCX97nRww7o_xnDJ+zDmtw@mail.gmail.com>
Subject: Re: [PATCH V2 0/4] NTB function for PCIe RC to EP connection
To:     Frank Li <Frank.Li@nxp.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, kishon@ti.com,
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVHVlLCBGZWIgMjIsIDIwMjIgYXQgMTA6MjQgQU0gRnJhbmsgTGkgPEZyYW5rLkxpQG54cC5j
b20+IHdyb3RlOg0KPg0KPiBUaGlzIGltcGxlbWVudCBOVEIgZnVuY3Rpb24gZm9yIFBDSWUgRVAg
dG8gUkMgY29ubmVjdGlvbnMuDQo+IFRoZSBleGlzdGVkIG50YiBlcGYgbmVlZCB0d28gUENJIEVQ
cyBhbmQgdHdvIFBDSSBIb3N0Lg0KPg0KPiBUaGlzIGp1c3QgbmVlZCBFUCB0byBSQyBjb25uZWN0
aW9ucy4NCj4NCj4gICAgIOKUjOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
kCAgICAgICAgIOKUjOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUkA0KPiAgICAg4pSCICAgICAgICAgICAg4pSCICAgICAgICAg4pSCICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIOKUgg0KPiAgICAg4pSc4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSkICAgICAgICAg4pSCICAgICAgICAgICAgICAgICAg
ICAgIOKUjOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUpA0KPiAg
ICAg4pSCIE5UQiAgICAgICAg4pSCICAgICAgICAg4pSCICAgICAgICAgICAgICAgICAgICAgIOKU
giBOVEIgICAgICAgICAg4pSCDQo+ICAgICDilIIgTmV0RGV2ICAgICDilIIgICAgICAgICDilIIg
ICAgICAgICAgICAgICAgICAgICAg4pSCIE5ldERldiAgICAgICDilIINCj4gICAgIOKUnOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUpCAgICAgICAgIOKUgiAgICAgICAgICAg
ICAgICAgICAgICDilJzilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lKQNCj4gICAgIOKUgiBOVEIgICAgICAgIOKUgiAgICAgICAgIOKUgiAgICAgICAgICAgICAgICAg
ICAgICDilIIgTlRCICAgICAgICAgIOKUgg0KPiAgICAg4pSCIFRyYW5zZmVyICAg4pSCICAgICAg
ICAg4pSCICAgICAgICAgICAgICAgICAgICAgIOKUgiBUcmFuc2ZlciAgICAg4pSCDQo+ICAgICDi
lJzilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilKQgICAgICAgICDilIIgICAg
ICAgICAgICAgICAgICAgICAg4pSc4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSkDQo+ICAgICDilIIgICAgICAgICAgICDilIIgICAgICAgICDilIIgICAgICAgICAg
ICAgICAgICAgICAg4pSCICAgICAgICAgICAgICDilIINCj4gICAgIOKUgiAgUENJIE5UQiAgIOKU
giAgICAgICAgIOKUgiAgICAgICAgICAgICAgICAgICAgICDilIIgICAgICAgICAgICAgIOKUgg0K
PiAgICAg4pSCICAgIEVQRiAgICAg4pSCICAgICAgICAg4pSCICAgICAgICAgICAgICAgICAgICAg
IOKUgiAgICAgICAgICAgICAg4pSCDQo+ICAgICDilIIgICBEcml2ZXIgICDilIIgICAgICAgICDi
lIIgICAgICAgICAgICAgICAgICAgICAg4pSCIFBDSSBWaXJ0dWFsICDilIINCj4gICAgIOKUgiAg
ICAgICAgICAgIOKUgiAgICAgICAgIOKUnOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUkCAgICAgIOKUgiBOVEIgRHJpdmVyICAg4pSCDQo+ICAgICDilIIgICAg
ICAgICAgICDilIIgICAgICAgICDilIIgUENJIEVQIE5UQiAgICDilILil4TilIDilIDilIDilIDi
lrrilIIgICAgICAgICAgICAgIOKUgg0KPiAgICAg4pSCICAgICAgICAgICAg4pSCICAgICAgICAg
4pSCICBGTiBEcml2ZXIgICAg4pSCICAgICAg4pSCICAgICAgICAgICAgICDilIINCj4gICAgIOKU
nOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUpCAgICAgICAgIOKUnOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUpCAgICAgIOKUnOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUpA0KPiAgICAg4pSCICAgICAg
ICAgICAg4pSCICAgICAgICAg4pSCICAgICAgICAgICAgICAg4pSCICAgICAg4pSCICAgICAgICAg
ICAgICDilIINCj4gICAgIOKUgiAgUENJIEJVUyAgIOKUgiDil4TilIDilIDilIDilIDilIDilrog
4pSCICBQQ0kgRVAgQlVTICAg4pSCICAgICAg4pSCICBWaXJ0dWFsIFBDSSDilIINCj4gICAgIOKU
giAgICAgICAgICAgIOKUgiAgUENJICAgIOKUgiAgICAgICAgICAgICAgIOKUgiAgICAgIOKUgiAg
ICAgQlVTICAgICAg4pSCDQo+ICAgICDilJTilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilIDilJggICAgICAgICDilJTilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilIDilIDilLTilIDilIDilIDilIDilIDilIDilLTilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilIDilIDilIDilIDilIDilJgNCj4gICAgICAgICBQQ0kgUkMgICAgICAgICAgICAgICAgICAg
ICAgICBQQ0kgRVANCj4NCj4NCj4NCj4gRnJhbmsgTGkgKDQpOg0KPiAgIFBDSTogZGVzaWdud2Fy
ZS1lcDogQWxsb3cgcGNpX2VwY19zZXRfYmFyKCkgdXBkYXRlIGluYm91bmQgbWFwIGFkZHJlc3MN
Cj4gICBOVEI6IGVwZjogQWxsb3cgbW9yZSBmbGV4aWJpbGl0eSBpbiB0aGUgbWVtb3J5IEJBUiBt
YXAgbWV0aG9kDQo+ICAgUENJOiBlbmRwb2ludDogU3VwcG9ydCBOVEIgdHJhbnNmZXIgYmV0d2Vl
biBSQyBhbmQgRVANCj4gICBEb2N1bWVudGF0aW9uOiBQQ0k6IEFkZCBzcGVjaWZpY2F0aW9uIGZv
ciB0aGUgUENJIHZOVEIgZnVuY3Rpb24gZGV2aWNlDQo+DQoNClBpbmcNCg0KPiAgRG9jdW1lbnRh
dGlvbi9QQ0kvZW5kcG9pbnQvaW5kZXgucnN0ICAgICAgICAgIHwgICAgMiArDQo+ICAuLi4vUENJ
L2VuZHBvaW50L3BjaS12bnRiLWZ1bmN0aW9uLnJzdCAgICAgICAgfCAgMTI2ICsrDQo+ICBEb2N1
bWVudGF0aW9uL1BDSS9lbmRwb2ludC9wY2ktdm50Yi1ob3d0by5yc3QgfCAgMTY3ICsrDQo+ICBk
cml2ZXJzL250Yi9ody9lcGYvbnRiX2h3X2VwZi5jICAgICAgICAgICAgICAgfCAgIDQ4ICstDQo+
ICAuLi4vcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS1lcC5jICAgfCAgIDEwICst
DQo+ICBkcml2ZXJzL3BjaS9lbmRwb2ludC9mdW5jdGlvbnMvS2NvbmZpZyAgICAgICAgfCAgIDEx
ICsNCj4gIGRyaXZlcnMvcGNpL2VuZHBvaW50L2Z1bmN0aW9ucy9NYWtlZmlsZSAgICAgICB8ICAg
IDEgKw0KPiAgZHJpdmVycy9wY2kvZW5kcG9pbnQvZnVuY3Rpb25zL3BjaS1lcGYtdm50Yi5jIHwg
MTQyNCArKysrKysrKysrKysrKysrKw0KPiAgOCBmaWxlcyBjaGFuZ2VkLCAxNzc1IGluc2VydGlv
bnMoKyksIDE0IGRlbGV0aW9ucygtKQ0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRp
b24vUENJL2VuZHBvaW50L3BjaS12bnRiLWZ1bmN0aW9uLnJzdA0KPiAgY3JlYXRlIG1vZGUgMTAw
NjQ0IERvY3VtZW50YXRpb24vUENJL2VuZHBvaW50L3BjaS12bnRiLWhvd3RvLnJzdA0KPiAgY3Jl
YXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvcGNpL2VuZHBvaW50L2Z1bmN0aW9ucy9wY2ktZXBmLXZu
dGIuYw0KPg0KPiAtLQ0KPiAyLjI0LjAucmMxDQo+DQo=
