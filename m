Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76E46750468
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jul 2023 12:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbjGLKaJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jul 2023 06:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjGLKaI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Jul 2023 06:30:08 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553CD106;
        Wed, 12 Jul 2023 03:30:07 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fbcbf4375dso771844e87.0;
        Wed, 12 Jul 2023 03:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689157805; x=1691749805;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JibM4f+C+jgO7J8IldglQAMCDPTs7d1S6aXmcnJhuxY=;
        b=PN0YpNFjNXYtlBBMolshKR6lCst2nYPWNAti8pn+OLmK1CG/rt9m9/yBi4xvD+ZXcO
         DOIueI8TO6RBvB1t+EJwXQ7iuYhY3QqZeyXBovPtn6yTVzBJZef5qOg17TgWGZ8lgJFI
         CF0gTnmPnJBCp7hmAODISItjeCOiNmLILuMpJPUIo9iccxp+cjK4LR2ySCCzldW7WfeP
         u+oHiFpge9ubw+Slf+Jh4pfKWNAn78l1U4ueg6aIlU4cm4okK6Lslh4qVY/xsKPdXjVH
         pxvbYwVFFDUQs3tyjwa6RnWKPL712bEb9crteWQYGEwVRkQjzXnscIcITDgvG8NYAE2R
         6bIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689157805; x=1691749805;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JibM4f+C+jgO7J8IldglQAMCDPTs7d1S6aXmcnJhuxY=;
        b=QgnrCZhXvr4ACbWTUv0YZrQdcljB1MRc67UjxXtG3SPR0qcCDal4D+F2aGi6EdmAVc
         j82HZITPFhxKPiamSGzdXEiysFYnl/GHpWIQV3AmvYxVsC3DFmiGhV6PE32PM7fAeyjw
         7sUrwhg+pBhgHFSvzS/q7Fgq5kiVFQ2Hu4hT0H96eOIr9GP4jdzKknKg2NyOBupk1wV8
         ODIKPTWXTdVCsUfk9kx/JTijtV1rP3k6YEWCNMEAsWwR/yx6V6THVKDcMKsjp/nFpi1p
         Qx7VeRZYM3KqzTZgdzRpHu6ZjWd2gOLIh5jaWV+6+Busei/a4YI6TeoFyw7I+S48bBtw
         6ijg==
X-Gm-Message-State: ABy/qLa76aCiNMVYcFeeBHDY2k9Hyt7532jq0nEretQxSMmK9OwvdOtm
        Kl5Nh7T4rnLRW4TPooO31Z4=
X-Google-Smtp-Source: APBJJlGpwOiSAFpVwXGujz8IWjbU5Mz8GK443TsMs898Xfs+ha7GqizyVmcDrXda80Ut5666yMNTuA==
X-Received: by 2002:a05:6512:3d89:b0:4f8:5e4e:52ad with SMTP id k9-20020a0565123d8900b004f85e4e52admr660218lfv.23.1689157805194;
        Wed, 12 Jul 2023 03:30:05 -0700 (PDT)
Received: from mobilestation ([85.249.22.88])
        by smtp.gmail.com with ESMTPSA id a23-20020a19f817000000b004faeedbb29dsm652185lff.64.2023.07.12.03.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 03:30:04 -0700 (PDT)
Date:   Wed, 12 Jul 2023 13:30:01 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "kishon@kernel.org" <kishon@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH v17 16/20] dt-bindings: PCI: renesas: Add R-Car Gen4 PCIe
 Endpoint
Message-ID: <ucg4tyyht44izu2z4zmvpr54gvrywwdhdsnjtzvuaqzbh3b3bb@h4qhiz3y5oom>
References: <20230705114206.3585188-1-yoshihiro.shimoda.uh@renesas.com>
 <20230705114206.3585188-17-yoshihiro.shimoda.uh@renesas.com>
 <rk52tz3tmpzg6s7szkh3u44vnr3sncgtb7535fn5alf4fj4dlh@ljmhmtjee3rw>
 <TYBPR01MB534172B437BA8146E05808C7D836A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYBPR01MB534172B437BA8146E05808C7D836A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 12, 2023 at 12:17:47AM +0000, Yoshihiro Shimoda wrote:
> Hello Serge,
> 
> > From: Serge Semin, Sent: Wednesday, July 12, 2023 6:03 AM
> > 
> > On Wed, Jul 05, 2023 at 08:42:02PM +0900, Yoshihiro Shimoda wrote:
> > > Document bindings for Renesas R-Car Gen4 and R-Car S4-8 (R8A779F0)
> > > PCIe endpoint module.
> > >
> > > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> > > Acked-by: Manivannan Sadhasivam <mani@kernel.org>
> > > ---
> > >  .../bindings/pci/rcar-gen4-pci-ep.yaml        | 106 ++++++++++++++++++
> > >  1 file changed, 106 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml
> > b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml
> > > new file mode 100644
> > > index 000000000000..4e6be856104c
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml
> > > @@ -0,0 +1,106 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +# Copyright (C) 2022-2023 Renesas Electronics Corp.
> > > +%YAML 1.2
> > > +---
> > > +$id:
> <snip URL>
> > > +$schema:
> <snip URL>
> > > +
> > > +title: Renesas R-Car Gen4 PCIe Endpoint
> > > +
> > > +maintainers:
> > > +  - Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > > +
> > > +allOf:
> > > +  - $ref: snps,dw-pcie-ep.yaml#
> > > +
> > > +properties:
> > > +  compatible:
> > > +    items:
> > > +      - const: renesas,r8a779f0-pcie-ep   # R-Car S4-8
> > > +      - const: renesas,rcar-gen4-pcie-ep  # R-Car Gen4
> > > +
> > > +  reg:
> > > +    maxItems: 6
> > > +
> > > +  reg-names:
> > > +    items:
> > > +      - const: dbi
> > > +      - const: dbi2
> > > +      - const: atu
> > > +      - const: dma
> > > +      - const: app
> > > +      - const: addr_space
> > > +
> > > +  interrupts:
> > > +    maxItems: 3
> > > +
> > > +  interrupt-names:
> > > +    items:
> > > +      - const: dma
> > > +      - const: sft_ce
> > > +      - const: app
> > > +
> > > +  power-domains:
> > > +    maxItems: 1
> > > +
> > > +  resets:
> > > +    maxItems: 1
> > > +
> > > +  clocks:
> > > +    maxItems: 2
> > > +
> > > +  clock-names:
> > > +    items:
> > > +      - const: core
> > > +      - const: ref
> > > +
> > > +  max-functions:
> > > +    maximum: 2
> > > +
> > > +  max-link-speed:
> > > +    maximum: 4
> > > +
> > > +  num-lanes:
> > > +    maximum: 4
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - reg-names
> > > +  - interrupts
> > > +  - resets
> > > +  - power-domains
> > > +  - clocks
> > > +  - clock-names
> > > +
> > > +unevaluatedProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    #include <dt-bindings/clock/r8a779f0-cpg-mssr.h>
> > > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > > +    #include <dt-bindings/power/r8a779f0-sysc.h>
> > > +
> > > +    soc {
> > > +        #address-cells = <2>;
> > > +        #size-cells = <2>;
> > > +
> > > +        pcie0_ep: pcie-ep@e65d0000 {
> > > +            compatible = "renesas,r8a779f0-pcie-ep", "renesas,rcar-gen4-pcie-ep";
> > 
> > > +            reg = <0 0xe65d0000 0 0x2000>, <0 0xe65d2800 0 0x0800>,
> > > +                  <0 0xe65d3000 0 0x2000>, <0 0xe65d5000 0 0x1200>,
> > > +                  <0 0xe65d6200 0 0x0e00>, <0 0xfe000000 0 0x400000>;
> > > +            reg-names = "dbi", "dbi2", "atu", "dma", "app", "addr_space";
> > 
> > I'll ask it once again since you didn't address my comment in v16 and
> > haven't fixed the example node in the bindings:
> 
> Thank you for your review! I'm sorry, I completely forgot about this...
> 
> > I see you defining the dbi2 space as <0 _0xe65d2800_ 0 0x0800>. But
> > sometime before you mentioned that your device has the next CSRs
> > layout:
> > ! +0x0000 : Function 0 (common address in Root port and Endpoint mode)
> >   +0x1000 : Function 1 (Endpoint mode only)
> >   +0x2000 : Shadow register for Function 0
> > ! +0x2800 : Shadow register for Function 1
> > it means the DT-bindings example node has the dbi space defined for
> > both functions meanwhile the dbi2 space defined for _function #1_ only
> > (it's 0xe65d0000 + 0x2800). So AFAICS either you have wrong space
> > defined in the example node or the node is wrong in your platform DTS
> > too and you have a malfunction end-point mode. Am I missing something?
> > In any case based on your End-point driver implementation dbi2 is
> > supposed to be defined at the 0xe65d2000 base address.
> > 
> > Am I wrong? Could you clarify this?
> 
> You're correct. So, I had investigated this topic, and then the current
> actual dtsi file has the following about the reg property:
> 
> +                       reg = <0 0xe65d0000 0 0x2000>, <0 0xe65d2000 0 0x1000>,
> +                             <0 0xe65d3000 0 0x2000>, <0 0xe65d5000 0 0x1200>,
> +                             <0 0xe65d6200 0 0x0e00>, <0 0xfe000000 0 0x400000>;
> 
> After that, the driver could not work correctly on v16 patch series.
> So, I had investigated why, and then I found this was related to
> the dbi2 offset. That's why I added a new patch [1] on v17 patch series.
> 
> [1] "[PATCH v17 07/20] PCI: dwc: endpoint: Add multiple PFs support for dbi2"
> 
> Anyway, I'll revise this dt-bindings doc too on v18 patch series.

Got it. Thanks for clarification.

-Serge(y)

> 
> Best regards,
> Yoshihiro Shimoda
> 
> > -Serge(y)
> > 
> > > +            interrupts = <GIC_SPI 417 IRQ_TYPE_LEVEL_HIGH>,
> > > +                         <GIC_SPI 418 IRQ_TYPE_LEVEL_HIGH>,
> > > +                         <GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>;
> > > +            interrupt-names = "dma", "sft_ce", "app";
> > > +            clocks = <&cpg CPG_MOD 624>, <&pcie0_clkref>;
> > > +            clock-names = "core", "ref";
> > > +            power-domains = <&sysc R8A779F0_PD_ALWAYS_ON>;
> > > +            resets = <&cpg 624>;
> > > +            num-lanes = <2>;
> > > +            max-link-speed = <4>;
> > > +            max-functions = /bits/ 8 <2>;
> > > +        };
> > > +    };
> > > --
> > > 2.25.1
> > >
