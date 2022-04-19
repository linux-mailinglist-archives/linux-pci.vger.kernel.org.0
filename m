Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52B1C50767E
	for <lists+linux-pci@lfdr.de>; Tue, 19 Apr 2022 19:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355079AbiDSRc3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Apr 2022 13:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354598AbiDSRc2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Apr 2022 13:32:28 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B10EC56;
        Tue, 19 Apr 2022 10:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1650389348;
        bh=KwXzkV0B3f5e2tIrsLC+AOdAfv7m88ysNXObwXd6YFU=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=C3r0DjATYEqweUN70N+KSWm8s2Civ07dEeM21QTrj5r1m5ZISvnKT7EL2fK8jKQcG
         YCjlBNclMYyRmEK6ZfE9at59azUaeOCjiGBJ+iM3/boiWJlrweKhokDKsRGFHpVm44
         syEqyK5OLmSSqMe8pekmtoe+yOUERDkEvLQKcVvs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [217.61.157.75] ([217.61.157.75]) by web-mail.gmx.net
 (3c-app-gmx-bap70.server.lan [172.19.172.170]) (via HTTP); Tue, 19 Apr 2022
 19:29:08 +0200
MIME-Version: 1.0
Message-ID: <trinity-c60358c4-ebd1-47bf-91e0-9ae0beefd39f-1650389348418@3c-app-gmx-bap70>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Frank Wunderlich <linux@fw-web.de>,
        linux-rockchip@lists.infradead.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Jonker <jbx6244@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Aw: Re: [RFC/RFT 2/6] dt-bindings: soc: grf: add
 pcie30-{phy,pipe}-grf
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 19 Apr 2022 19:29:08 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <02b3fe1c-12f9-8f96-a9b5-df44ca001825@linaro.org>
References: <20220416135458.104048-1-linux@fw-web.de>
 <20220416135458.104048-3-linux@fw-web.de>
 <02b3fe1c-12f9-8f96-a9b5-df44ca001825@linaro.org>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:GSNIHIUWA/GRgjok62B+UG3JpReIUrnZJW4cJo6k+0piMPNyKFMYLVAFWEh1wrHmC12r3
 jNiJtMLDXSgz8acJ/aJzo+jHp/laJRu0OT7D+X3jpnmIx10ZRP1JqBS5CgsRVh/9IdoFFvDn3g/d
 rj15Lid9nt0dWx9ntE2Vb5tFhLn/8safPKxQPqCoi0HjiXWlBT+34uxmGYQ7RC1juT0PrxVRNTqc
 +QTAlJ8jBUmU1xE8ALgCLTfOHz6M+dTJ9/YjpIsyksZMR+MkqhSHhbwhX6bzXV0vtETyR9yddXOr
 u4=
X-UI-Out-Filterresults: notjunk:1;V03:K0:5J5RBFRzPTA=:MMjlPLuedJCMlAG5z+h8Bd
 CK5NFPEE5BVigaDy2laiQ3hRh0HImsKvp9cX2T3LIVYqMkqSsdHqKNBebEb9780iJzIt8QM/K
 y9CLpFPNgTk0uM/rfb3lgNeOPYy+VVHhEX/pWsHHxtLSpMVOZ9kppKDncbHeK2pBCqzqbBABV
 4Hq6qMPtbDPsmgM9C+lq8lfBsoCDZpGQltXuR+4tcZ0Da3h6jUHz2/UBW1FT1KHOA+laYVvMk
 Riyj53Nwe+OUPmsJs7mnYI2iLWL6L/tUaf5WEUva+1mUYPHoJRbRcCeHcRQJDSOCmqBrYAbYF
 +3s76mG4HUhtZ+cBaMiYRj3eeg8vHx0s6BybOeU3XzkVVYavGi/jCADVnpZYoCtxL4B66wO58
 gjuekbExgepHeqNRmYJS+H+5VFOiH3YJLw4pwg/Q9OAiLjfe7XWTtdNO4nAN8eI9Ed0RIRNkp
 gHPIBavKmNjNsvReK1OGzG2oGnejY7gC5GuhCvFYoAbLXF1/sndvItKF7jMz1MBMPBq8XWDD7
 1cQLVwUR/fFS0cW9+ozbdCHKY3I/95TDHgeGdXd93tAoRhBryWoYjZkSr8yFglnePJThlEqwR
 0pq235DHr7bdkoQieORurzxhhH4+Drw7BaTzq40uEnMMZMcPBhf26ZU45rosLjOpGUyJEJJM3
 YTRUlTdc5HFiT33FAqSB83j9MTWyHTmUZJVzHrHq6mSdnFZOm7XeSsY6ZzxfPpgLX1VvmxbNe
 2z7dslB3GZNBFZ3wpYcTO44+RvZB9DlwXuzmx2QQVHRT5fbtdA1uaNeTflN5aK5nvUU03Wpe+
 L6o34tm
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> Gesendet: Montag, 18. April 2022 um 17:54 Uhr
> Von: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>

> > --- a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
> > +++ b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
> > @@ -14,6 +14,8 @@ properties:
> >      oneOf:
> >        - items:
> >            - enum:
> > +              - rockchip,pcie30-phy-grf
> > +              - rockchip,pcie30-pipe-grf
>
> These are without SoC parts. Are these PCIe v3 General Register Files
> part of some PCIe spec?

imho they are shared across SoCs rk3568 and rk3588, but have only seen rk3=
568 implementation yet.
PCIe driver currently supports these 2 Soc (different offsets in the Phy-G=
RF), but can only test rk3568.

pipe-grf seems only be used for rk35688 (offset used in probe is defined f=
or this SoC), which i cannot test.

so i have left them SoC independed.

> >                - rockchip,rk3288-sgrf
> >                - rockchip,rk3566-pipe-grf
> >                - rockchip,rk3568-usb2phy-grf

regards Frank
