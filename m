Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEB23512CBA
	for <lists+linux-pci@lfdr.de>; Thu, 28 Apr 2022 09:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245320AbiD1H30 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Apr 2022 03:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245284AbiD1H3Y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Apr 2022 03:29:24 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27C2340C9;
        Thu, 28 Apr 2022 00:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1651130723;
        bh=Kl1D0qKBLbFcGmM/inCOM/LMhQnD3kUx2fRwBIfJFbY=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ICgj3U0KsWCdSyk+4KTl7+UbbH7ZgeuOkjZprYn96+3lI1AwcRvsBXO6wd+8qZwPn
         OoIxHHuNiq00mTWpDdxVNnQJovYajWGc5SsfcuWwvgRNldnbn6R5FYiuIV/k+QG89n
         mi1e9wXTuqQiOIvz8GUyBD6Pzj3qw9SOqaQH/XoM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [217.61.145.42] ([217.61.145.42]) by web-mail.gmx.net
 (3c-app-gmx-bs20.server.lan [172.19.170.72]) (via HTTP); Thu, 28 Apr 2022
 09:25:23 +0200
MIME-Version: 1.0
Message-ID: <trinity-fcca248f-cb76-474a-8227-5b7188140bdf-1651130723782@3c-app-gmx-bs20>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Frank Wunderlich <linux@fw-web.de>,
        linux-rockchip@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Jonker <jbx6244@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: Aw: Re: [RFC/RFT v2 05/11] dt-bindings: pci: add bifurcation option
 to Rockchip DesignWare binding
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 28 Apr 2022 09:25:23 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <ea6ccec6-81a3-b22d-46db-c31a9f1e85f3@linaro.org>
References: <20220426132139.26761-1-linux@fw-web.de>
 <20220426132139.26761-6-linux@fw-web.de>
 <ea6ccec6-81a3-b22d-46db-c31a9f1e85f3@linaro.org>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:HuS/IQbWns2B9KbVmd+JXXePQOBTI5r+4oLrCZnL6JqsyIeqTqsBN/vkAMd357JlnYgtg
 43YoCUDaepjA+gR16+vK2qsTsr2Ggk+GAdPHRIuTT25wO9OaXXFxzSpRFegBlZVrQWK5MXoEqjar
 iAZeNn9SgywJLlkDgT8y3fRThCDpGCk0BET0WAB96yokouxCOXHKnW6UZMTKzC+794JlErXjecwE
 nOvCkWakPUTT8Eb4neasYEGg6txE7h/DJplgMSgezg5PWQ445EzyGytjG9rvZ2t5gA53hlGPPTCu
 CQ=
X-UI-Out-Filterresults: notjunk:1;V03:K0:+DhlrGzejX0=:H7ejG4ksVlR2OD+2AK78pX
 NEn5mlQjnBf4smxMBlFQljTTDT4W3WRU9Ox9sJ9xtSepQmURcyZ9dmRz33TNfj4pKUQQnPHR2
 vJnr0pZHyzisgYrhozVIiPpQqDuK2Bm1g6wmUJEqNtkyvZMY1dJt50oY03g5hDHAh2Z68clXs
 DEdgI9Q/rkGwXhaXXcmeWNR/yePzdnuglPIrJEqnIHu+WgpAcGYOT33sD8fxQOTKuGAhFUqVt
 LGWzfBaGSHbQ7IAtL1cp5Os9cpbM5CWuUNUywoyNUW1mdZg6EO+tuRk8H/X0m3DgcfVfTFV5y
 cdPM7M2+up0OIiVi1YuXUDrlfvppcNs5wmn5N/G5Mfoso5J3BnSqaAqu5IqW1MIkTFmZGnKHa
 Otv3ngNV4/PnY0rspfKTYZBgtwvuFKESVSOjs/lbachHn9LL2mmrmjqiwmxlqPwDQq6W2mMFj
 2G5UtIxST1Y+5IHo0OXbSF0FwTXVwj2xMOBMDnDDUvGazu2xqLQFng8dzLnoGzVRr+m/srdOe
 VCKBW4yNmX6U7tZ6W98QE14hn0R3gL4mWd6fSv9VGrE/O3HWP7rotqrVcDnMJ77F51RbKfNqP
 JGdLo6lSN+nH7fuKzXYoDWU6JZD6FzyP72acErlUg0aLbF3UMNr+zZl7cdp/284bXNlZL5dLr
 Fv6ERQriyiaZQ3BjuTQXJE5gIAslsj3d81qC8t6yyYFfqDWY+1bGH+38N9CmUIJixJkboSc4C
 Mfqgom7Fv+w2Sh75SuR8v4crb79c6PkMGRAqpOJ8pdoZpebtchSZP90ENTVBfg3f5Enz/F/N4
 0aXBOMR
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi
> Gesendet: Donnerstag, 28. April 2022 um 08:37 Uhr
> Von: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
> On 26/04/2022 15:21, Frank Wunderlich wrote:
> > From: Frank Wunderlich <frank-w@public-files.de>
> >
> > Add bifurcation property for splitting PCIe lanes.
> >
> > Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> > ---
> >  Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.ya=
ml b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> > index bc0a9d1db750..a992970e8b85 100644
> > --- a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> > +++ b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> > @@ -74,6 +74,8 @@ properties:
> >    reset-names:
> >      const: pipe
> >
> > +  bifurcation: true
> > +
>
> Does not look like standard property. Is it already defined somewhere?
> All non-standard properties need vendor, type and description.

have removed vendor-prefix from v1>v2 based on suggestion this can be usef=
ul for other vendors too.

but last 3 patches of this series replacing bifurcation property (which is=
 only bool) by the more useful lane-map (left alone for discussion, will b=
e squashed if the right way is found).

i guess same here, description+type needed, but how to describe an array o=
f int in yaml? do you know any examples?

regards Frank
