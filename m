Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F35D5507B0F
	for <lists+linux-pci@lfdr.de>; Tue, 19 Apr 2022 22:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354699AbiDSUkO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Apr 2022 16:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239482AbiDSUkN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Apr 2022 16:40:13 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0AF40910;
        Tue, 19 Apr 2022 13:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1650400612;
        bh=nM0QsTSHImhNtVCVh89StLB1opnXuQrH2wxHbxs6XBA=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=jlyq4cgfBSJ4vunKDweFSvyh6F+sz/1pWDI8nWlS2T5qoPZ/gQtIC6+Ye+o/sScRf
         g//fgUsnJiPBhtDydIvFTqhFGWbXFR/+aDIGbMMXSTHIqidt2gtI9xPgWN6SsxzpCN
         cZD9et57ilv4zaI0FBOMIok+7FiBnQ0Uya/fT9LY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [217.61.157.75] ([217.61.157.75]) by web-mail.gmx.net
 (3c-app-gmx-bap70.server.lan [172.19.172.170]) (via HTTP); Tue, 19 Apr 2022
 22:36:52 +0200
MIME-Version: 1.0
Message-ID: <trinity-a5ae4007-e6e3-4869-80ad-3783109b6d4c-1650400612809@3c-app-gmx-bap70>
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
Subject: Aw: Re:  Re: [RFC/RFT 1/6] dt-bindings: phy: rockchip: add pcie3
 phy
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 19 Apr 2022 22:36:52 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <fce0337a-0c71-a040-0a01-f20b55eb568b@linaro.org>
References: <20220416135458.104048-1-linux@fw-web.de>
 <20220416135458.104048-2-linux@fw-web.de>
 <38e60bb2-123b-09cf-d6ef-3a07c6984108@linaro.org>
 <trinity-597cf8a3-2ad4-41e6-b3c9-b949f8610533-1650390552136@3c-app-gmx-bap70>
 <fce0337a-0c71-a040-0a01-f20b55eb568b@linaro.org>
Content-Transfer-Encoding: quoted-printable
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:d+JalmBOvkG+YH4MOQOkbx3eTQ2qApoH5tRGPenjf/+CeM71isw7OUzKyPe4EElMEu30I
 n1hHGWuB1hCWR+uDaSdbMODVWktm3iz2jGAJGr5mn7zJLMz0mzQvMXCHDgzU4xFk4dZ9ylxWzU20
 DyKz0CEbS9RbL/l9Yb43oH4oXZAZL9hdoeUOAyffh/soksKY64KrMqXpmQEy0934hkbo//AEb62N
 Jd62VcWdi4rt5KCeZ36p4THT6foA93C8Ir6FnjdcK+ZWFUHuqUngydOhL8Q90mGPkpgDI4/2gleH
 S4=
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZubA9Isagu8=:g1UKhN7ZZOPpy3NgvxOKYG
 TaIs/BuV7xBn/Uwcas94HfhBFosJo964g2O8GgtMrlTfVs+q+/FCqMzuVkEtcMIkonaHl0R6T
 FPnbM6RFIVNG3MQHhTt8KWC5xCU0nTCVIhnLqQuQXpJ9Y6vx/PleEFxPjyQm1DOeKS0tARhFW
 zZDMzrLH1MyJ3a2B3dNdfUZ/B5vaTH5z7hSjw+GwQcjy5Ss1sijCmcsGHkSC0UDj5Ps218d44
 G3IOU6Zmj75XY9Nwixg0v+LuFU8Yxj6jYmv5KxDtvrwfAhkOJxZnx8SmrUIPPSOXjB1XtZ2MR
 IlgVmjUqmrahKIDqGVVwY8BmsFckQ5mHcZIu0peU25XccWCha45KFCE6lwaDQNec/rft3iQzH
 R1S99JaVjnlzXHpGCIobf8h9omxA/dFP3BaNEwT4BDol7bXSguDsmyn1P53PmpO6Ag+zXio/7
 VCj/LpaPCMPln/uLr57TJ6PzlLsbf4u1mQAQoDYV55jFYQXou/UwE/Y9gTsQf8Yvc0VAn7yJh
 YjOEJZPD2m1jWz8Sx0HXJeds0urOmP7tNlEgDBk9vzmEwP1xJygu1YP5QV3hutrZ5MZiQ/P02
 xuZZsBMp7JaPhWZbuBdlMMRaF+1IJOzUg4rXnYGhM+p03SDaUPkNbhU81bGmyjXN7J3wy9JgK
 orhyw61hDebw77Jn0D6E+yJBstjbXs1hHOubfGdT+4AnqJPfJjtymlpWCmon0CQXE4WcGRjUd
 UFanqQGFulfOyG+e2GZPj2COnvRICnVGcRlmuSaXpH0CZF9G6jpscQcn/iQ8U8cTxqUHwikOp
 IMbQN0W
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> Gesendet: Dienstag, 19=2E April 2022 um 21:43 Uhr
> Von: "Krzysztof Kozlowski" <krzysztof=2Ekozlowski@linaro=2Eorg>
> An: "Frank Wunderlich" <frank-w@public-files=2Ede>
> Cc: "Frank Wunderlich" <linux@fw-web=2Ede>, linux-rockchip@lists=2Einfra=
dead=2Eorg, "Kishon Vijay Abraham I" <kishon@ti=2Ecom>, "Vinod Koul" <vkoul=
@kernel=2Eorg>, "Rob Herring" <robh+dt@kernel=2Eorg>, "Krzysztof Kozlowski"=
 <krzk+dt@kernel=2Eorg>, "Heiko Stuebner" <heiko@sntech=2Ede>, "Lorenzo Pie=
ralisi" <lorenzo=2Epieralisi@arm=2Ecom>, "Krzysztof Wilczy=C5=84ski" <kw@li=
nux=2Ecom>, "Bjorn Helgaas" <bhelgaas@google=2Ecom>, "Philipp Zabel" <p=2Ez=
abel@pengutronix=2Ede>, "Johan Jonker" <jbx6244@gmail=2Ecom>, "Peter Geis" =
<pgwipeout@gmail=2Ecom>, "Michael Riesch" <michael=2Eriesch@wolfvision=2Ene=
t>, linux-phy@lists=2Einfradead=2Eorg, devicetree@vger=2Ekernel=2Eorg, linu=
x-arm-kernel@lists=2Einfradead=2Eorg, linux-kernel@vger=2Ekernel=2Eorg, lin=
ux-pci@vger=2Ekernel=2Eorg
> Betreff: Re: Aw: Re: [RFC/RFT 1/6] dt-bindings: phy: rockchip: add pcie3=
 phy
>
> On 19/04/2022 19:49, Frank Wunderlich wrote:
> >> The list should be strictly ordered (defined), so:
> >>   items:
> >>     - const: =2E=2E=2E
> >>     - const: =2E=2E=2E
> >>     - const: =2E=2E=2E
> >>   minItems: 1
> >>
> >> However the question is - why the clocks have different amount? Is it
> >> per different SoC implementation?
> >=20
> > i only know the rk3568, which needs the clocks defined here, don't kno=
w about rk3588 yet=2E
> > in rk3568 TPM i have the pcie-part seems missing (at least the specifi=
c register definition), so i had used the driver as i got it from the downs=
tream kernel=2E
> >=20
> > not yet looked if i find a rk3588 TPM and if this part is there as i c=
annot test it (one of the reasons this is a rfc/rft)=2E
>=20
> You can skip RK3588 compatible or define it this strictly also for that
> chip=2E

currently driver does clk_bulk initialization so i would define it like yo=
u suggested (without any SoC specific switch):

  clocks:
    minItems: 1
    maxItems: 3

  clock-names:
    items:
      - const: "refclk_m"
      - const: "refclk_n"
      - const: "pclk"

    minItems: 1

> >>> +
> >>> +  "#phy-cells":
> >>> +    const: 0
> >>> +
> >>> +  resets:
> >>> +    maxItems: 1
> >>> +
> >>> +  reset-names:
> >>> +    const: phy
> >>> +
> >>> +  rockchip,phy-grf:
> >>> +    $ref: /schemas/types=2Eyaml#/definitions/phandle
> >>> +    description: phandle to the syscon managing the phy "general re=
gister files"
> >>> +
> >>> +  rockchip,pipe-grf:
> >>> +    $ref: /schemas/types=2Eyaml#/definitions/phandle
> >>> +    description: phandle to the syscon managing the pipe "general r=
egister files"
> >>> +
> >>> +  rockchip,pcie30-phymode:
> >>> +    $ref: '/schemas/types=2Eyaml#/definitions/uint32'
> >>> +    description: |
> >>> +      use PHY_MODE_PCIE_AGGREGATION if not defined
> >>
> >> I don't understand the description=2E Do you mean here a case when th=
e
> >> variable is missing?
> >=20
> > yes, if the property is not set, then value is PHY_MODE_PCIE_AGGREGATI=
ON =3D 4
>=20
> Then just use "default: 4"
>=20
> >=20
> >>> +    minimum: 0x0
> >>> +    maximum: 0x4
> >>
> >> Please explain these values=2E Register values should not be part of
> >> bindings, but instead some logical behavior of hardware or its logic=
=2E
> >=20
> > it's a bitmask, so maybe
> >=20
> >     description: |
> >       bit0: bifurcation for port 0
> >       bit1: bifurcation for port 1
> >       bit2: aggregation
>=20
> That's good=2E I got impression you have a header with these values=2E I=
f
> yes - mention it here=2E
>=20
> >       use PHY_MODE_PCIE_AGGREGATION (4) as default
>=20
> Just use default as I wrote above=2E

so like this?

  rockchip,pcie30-phymode:
    $ref: '/schemas/types=2Eyaml#/definitions/uint32'
    description: |
      set the phy-mode for enabling bifurcation
      bit0: bifurcation for port 0
      bit1: bifurcation for port 1
      bit2: aggregation
      constants are defined in the dt-bindings/phy/phy-rockchip-pcie3=2Eh
    minimum: 0x0
    maximum: 0x4
    default: 0x4

regards Frank
