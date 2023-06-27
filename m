Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5AF073FD9E
	for <lists+linux-pci@lfdr.de>; Tue, 27 Jun 2023 16:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbjF0OTk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Jun 2023 10:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjF0OTj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Jun 2023 10:19:39 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3780E74;
        Tue, 27 Jun 2023 07:19:37 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b699a2fe86so45879171fa.3;
        Tue, 27 Jun 2023 07:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687875576; x=1690467576;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DfLJWM1h+r2fz/FrGrblPiH2XYx5v1TUXif5QJyXgRE=;
        b=nm+7mQKMEyoqcrirXa1lpri9J+NQjK7axqmZJUQdhWW5HbKcQWj7tKf+VdWSVe6FYE
         ZE7zXSDa+7Euw9TK706CY6nxn+reMksrcECRmkJ8TgOc1TwR8QsrJ2cLBP379XZAgtCa
         ZirljovqBqu5jfUZeKvbc2L/dd/Za1IAKgk049pvR6Qmcyfex3Jo2dFk5Hop8X6dYeph
         OSRUegDjqLcapwRG7rbHpqtxkaGZF9mt4UPy/bH+ORbECJo9YxUtCiN7mpZZF0+BSxQS
         KsQ8O3cWI4sLc484B/7ag5jpMXTJ17Lrbhg3RbQQKUknP9+Nlh1jjnUKxhkO2kAw70gz
         RJuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687875576; x=1690467576;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DfLJWM1h+r2fz/FrGrblPiH2XYx5v1TUXif5QJyXgRE=;
        b=MfnxF0UXOVqBgKb3ZmfD1jjdjq/jxIdC+1ZciBjJ4Vsk4Dn8i7b5nOkrdQv4v3p0VF
         bVh2SCQYc1ZzR13vKzuOuHc5k1MkFAa07D0ubThEkkMmnrVJtz5Fwupkuo1LqhRu5RDx
         2QY7/1y1QTpSOBqY8+4WB662/NNZdjklgBolkQXwkee9auuC3MDevSqvCy8ivDgNEBzv
         4bJFPiBdMGtA7qOgXktwbli1c0saM0Z/PKOZNqg/e0WXhgKkYPsWCzsdacnTruCDO5va
         64SUervT6ZOIfqcqoz7S57QzqMMTWKOcu0KP3D5Zbdhk30zDkssHUVDEX7geAeRipgdR
         mgtw==
X-Gm-Message-State: AC+VfDwtlwiYjiSzkvYDgimrus51dnasIJGLirp2ySnzmEQWFPPr4OM9
        RBzp/4xVnMILVeq/qMknsR8=
X-Google-Smtp-Source: ACHHUZ4unxU9mVyPjX85SmR3z4DLEpFOkvFzVKGizGK/iTAuIUTx25vGzfPrnowDBLMBpJVRCtPpMw==
X-Received: by 2002:a05:6512:39d3:b0:4fb:5dd5:715c with SMTP id k19-20020a05651239d300b004fb5dd5715cmr5486832lfu.4.1687875575662;
        Tue, 27 Jun 2023 07:19:35 -0700 (PDT)
Received: from mobilestation ([109.194.233.142])
        by smtp.gmail.com with ESMTPSA id f24-20020a19ae18000000b004f76388c0a6sm1520816lfc.236.2023.06.27.07.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 07:19:34 -0700 (PDT)
Date:   Tue, 27 Jun 2023 17:19:32 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
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
Subject: Re: [PATCH v1 1/4] dt-bindings: PCI: dwc: rockchip: Fix
 interrupt-names issue
Message-ID: <xfvpi67vvobt4hjnzlcghtshdfs7xakptsdj5tu4badmfbxddq@mgajg77uymeh>
References: <20230616170022.76107-1-sebastian.reichel@collabora.com>
 <20230616170022.76107-2-sebastian.reichel@collabora.com>
 <n5vgfnqicq3ndgqtcp3yjurbdn76vucj6zyjhlpjbdwoquv2la@5g5kv5gceyd7>
 <CAL_Jsq+=kBrujhLW_KNRWpj+DQJbnXrA=RS3La5ekbJtji+xiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_Jsq+=kBrujhLW_KNRWpj+DQJbnXrA=RS3La5ekbJtji+xiQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 27, 2023 at 07:48:29AM -0600, Rob Herring wrote:
> On Tue, Jun 27, 2023 at 6:27 AM Serge Semin <fancer.lancer@gmail.com> wrote:
> >
> > On Fri, Jun 16, 2023 at 07:00:19PM +0200, Sebastian Reichel wrote:
> > > The RK356x (and RK3588) have 5 ganged interrupts. For example the
> > > "legacy" interrupt combines "inta/intb/intc/intd" with a register
> > > providing the details.
> > >
> > > Currently the binding is not specifying these interrupts resulting
> > > in a bunch of errors for all rk356x boards using PCIe.
> > >
> > > Fix this by specifying the interrupts and add them to the example
> > > to prevent regressions.
> > >
> > > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > > ---
> > >  .../bindings/pci/rockchip-dw-pcie.yaml         | 18 ++++++++++++++++++
> > >  .../devicetree/bindings/pci/snps,dw-pcie.yaml  | 15 ++++++++++++++-
> > >  2 files changed, 32 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> > > index 24c88942e59e..98e45d2d8dfe 100644
> > > --- a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> > > +++ b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> > > @@ -56,6 +56,17 @@ properties:
> > >        - const: pclk
> > >        - const: aux
> > >
> > > +  interrupts:
> > > +    maxItems: 5
> > > +
> > > +  interrupt-names:
> > > +    items:
> > > +      - const: sys
> > > +      - const: pmc
> > > +      - const: msg
> > > +      - const: legacy
> > > +      - const: err
> > > +
> > >    msi-map: true
> > >
> > >    num-lanes: true
> > > @@ -98,6 +109,7 @@ unevaluatedProperties: false
> > >
> > >  examples:
> > >    - |
> > > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > >
> > >      bus {
> > >          #address-cells = <2>;
> > > @@ -117,6 +129,12 @@ examples:
> > >                            "aclk_dbi", "pclk",
> > >                            "aux";
> > >              device_type = "pci";
> > > +            interrupts = <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>,
> > > +                         <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>,
> > > +                         <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>,
> > > +                         <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>,
> > > +                         <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>;
> > > +            interrupt-names = "sys", "pmc", "msg", "legacy", "err";
> > >              linux,pci-domain = <2>;
> > >              max-link-speed = <2>;
> > >              msi-map = <0x2000 &its 0x2000 0x1000>;
> > > diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> > > index 1a83f0f65f19..9f605eb297f5 100644
> > > --- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> > > +++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> > > @@ -193,9 +193,22 @@ properties:
> > >            oneOf:
> > >              - description: See native "app" IRQ for details
> > >                enum: [ intr ]
> >
> > The IRQs below are either combined version of the already defined IRQs
> > or just the generic DW PCIe IRQs but named differently. Moreover I
> > don't see kernel using any of them except the "legacy" interrupt. What
> > about converting the dts files to using the already defined names instead
> > of extending the already over-diverged DT-bindings?
> > Rob, Krzysztof?
> 

> If there's not a dependency on the names, then we can get away with
> changing them. Otherwise, it's an ABI issue to change them. Supporting
> both names in the driver partially mitigates that, but isn't worth
> carrying that IMO.

DW Rockchip LLDD only looks for the "legacy" IRQ name. The rest of
them are left unused by both LLDD and the DW PCIe core driver. So from
the kernel point of view ABI is defined for "legacy" name only.

Even "msi"/"msg" IRQ name left unused which is normally responsible
for signaling MSI TLPs caught by the iMSI-RX engine. (Most likely
MSI packets passes through the PCI<->System bus bridge and gets
detected by the system GIC.)

-Serge(y)

> 
> Will drop this one from my tree. Seems patches 2 and 3 aren't
> dependent on this one.
> 
> Rob
