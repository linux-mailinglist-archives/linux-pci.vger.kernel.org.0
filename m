Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62AA973FD2A
	for <lists+linux-pci@lfdr.de>; Tue, 27 Jun 2023 15:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbjF0Nsx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Jun 2023 09:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbjF0Nsv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Jun 2023 09:48:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9477A296B;
        Tue, 27 Jun 2023 06:48:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 230DA611AB;
        Tue, 27 Jun 2023 13:48:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BE2AC433CA;
        Tue, 27 Jun 2023 13:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687873726;
        bh=mObELhIa7cwUVV/oIDNa5An5fXRPEinl+dDJGvds3Nc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=L51bvRo3oGBkGU3bYcUoxBi7qn+NBS181faXZyiA+mjcHOLWAVCr3vgHqTrqbzGBQ
         30OTwDS0JSOAiLcEqhE4pFGIsNHahwmRQmJPtUewXfu/gR9wKpeIfXiyPraZG7Z60J
         zgf00meR3swepOPrA3FOV8I0GsUgmhpFuxJZBv2+BoNuiH4I61qnrDjmjrcKIA/JZB
         ow66V3Jogu1L9blAYv3JNW41bMhfWTVYCVmk1s2hlP8DYAH6YPqsZVIb3yHd5RIvkv
         WAvGB74OXpKMUifH2ZLpFkzPcrMrYLVBSK/iRwFRPkARZsPzEg1SpyjRevjogb2YKB
         IiiYpcBwJkMag==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2b698371937so46831491fa.3;
        Tue, 27 Jun 2023 06:48:46 -0700 (PDT)
X-Gm-Message-State: AC+VfDwgYLbMSOsduqnnP6w+mzQwyG08fmo7GhROgTZIqHk9VDUW14rO
        T4JYQwHNRGRPZBvtSxLm2hdDsTH8O/pDWrtJ/Q==
X-Google-Smtp-Source: ACHHUZ5mxTMdxMXPa9Ql9RKi9asFXmBgUnXk5or90ARb0BmcJyRwHgk8XT0HrKpFAmR/DxyxLhEgELhil1yyDDw4tUE=
X-Received: by 2002:a2e:7a06:0:b0:2b6:97e6:93f5 with SMTP id
 v6-20020a2e7a06000000b002b697e693f5mr4452783ljc.11.1687873724458; Tue, 27 Jun
 2023 06:48:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230616170022.76107-1-sebastian.reichel@collabora.com>
 <20230616170022.76107-2-sebastian.reichel@collabora.com> <n5vgfnqicq3ndgqtcp3yjurbdn76vucj6zyjhlpjbdwoquv2la@5g5kv5gceyd7>
In-Reply-To: <n5vgfnqicq3ndgqtcp3yjurbdn76vucj6zyjhlpjbdwoquv2la@5g5kv5gceyd7>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 27 Jun 2023 07:48:29 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+=kBrujhLW_KNRWpj+DQJbnXrA=RS3La5ekbJtji+xiQ@mail.gmail.com>
Message-ID: <CAL_Jsq+=kBrujhLW_KNRWpj+DQJbnXrA=RS3La5ekbJtji+xiQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] dt-bindings: PCI: dwc: rockchip: Fix
 interrupt-names issue
To:     Serge Semin <fancer.lancer@gmail.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Simon Xue <xxm@rock-chips.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 27, 2023 at 6:27=E2=80=AFAM Serge Semin <fancer.lancer@gmail.co=
m> wrote:
>
> On Fri, Jun 16, 2023 at 07:00:19PM +0200, Sebastian Reichel wrote:
> > The RK356x (and RK3588) have 5 ganged interrupts. For example the
> > "legacy" interrupt combines "inta/intb/intc/intd" with a register
> > providing the details.
> >
> > Currently the binding is not specifying these interrupts resulting
> > in a bunch of errors for all rk356x boards using PCIe.
> >
> > Fix this by specifying the interrupts and add them to the example
> > to prevent regressions.
> >
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > ---
> >  .../bindings/pci/rockchip-dw-pcie.yaml         | 18 ++++++++++++++++++
> >  .../devicetree/bindings/pci/snps,dw-pcie.yaml  | 15 ++++++++++++++-
> >  2 files changed, 32 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yam=
l b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> > index 24c88942e59e..98e45d2d8dfe 100644
> > --- a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> > +++ b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> > @@ -56,6 +56,17 @@ properties:
> >        - const: pclk
> >        - const: aux
> >
> > +  interrupts:
> > +    maxItems: 5
> > +
> > +  interrupt-names:
> > +    items:
> > +      - const: sys
> > +      - const: pmc
> > +      - const: msg
> > +      - const: legacy
> > +      - const: err
> > +
> >    msi-map: true
> >
> >    num-lanes: true
> > @@ -98,6 +109,7 @@ unevaluatedProperties: false
> >
> >  examples:
> >    - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> >
> >      bus {
> >          #address-cells =3D <2>;
> > @@ -117,6 +129,12 @@ examples:
> >                            "aclk_dbi", "pclk",
> >                            "aux";
> >              device_type =3D "pci";
> > +            interrupts =3D <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>,
> > +                         <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>,
> > +                         <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>,
> > +                         <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>,
> > +                         <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>;
> > +            interrupt-names =3D "sys", "pmc", "msg", "legacy", "err";
> >              linux,pci-domain =3D <2>;
> >              max-link-speed =3D <2>;
> >              msi-map =3D <0x2000 &its 0x2000 0x1000>;
> > diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/=
Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> > index 1a83f0f65f19..9f605eb297f5 100644
> > --- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> > +++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> > @@ -193,9 +193,22 @@ properties:
> >            oneOf:
> >              - description: See native "app" IRQ for details
> >                enum: [ intr ]
>
> The IRQs below are either combined version of the already defined IRQs
> or just the generic DW PCIe IRQs but named differently. Moreover I
> don't see kernel using any of them except the "legacy" interrupt. What
> about converting the dts files to using the already defined names instead
> of extending the already over-diverged DT-bindings?
> Rob, Krzysztof?

If there's not a dependency on the names, then we can get away with
changing them. Otherwise, it's an ABI issue to change them. Supporting
both names in the driver partially mitigates that, but isn't worth
carrying that IMO.

Will drop this one from my tree. Seems patches 2 and 3 aren't
dependent on this one.

Rob
