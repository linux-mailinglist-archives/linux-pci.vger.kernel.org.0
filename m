Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99B7454A1D2
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jun 2022 23:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbiFMVyP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jun 2022 17:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348019AbiFMVyA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jun 2022 17:54:00 -0400
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58719205EE;
        Mon, 13 Jun 2022 14:53:59 -0700 (PDT)
Received: by mail-il1-f179.google.com with SMTP id u2so5292291iln.2;
        Mon, 13 Jun 2022 14:53:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kNvsDOdNrfDqt3EuOYydygCH1LOxGWNGFKSpTH09Uqs=;
        b=k/b8ZVJIsrFywf1G+aJk6rZaAvGkq2e+I4F+a/JfXTVzwX2faRy+iKd8FIFEuRu7K+
         D2gCmEaeleooodqlXS4SZ31kKlK6FuLP7aEHOilDJuB+0tu3KtQJAT+5WFJnmS0SH+ss
         yUD0/7pF5XftF2hly05ID+03lOFfOLPkuls1XbP2Eg6/fEW7qz5/jifYRPN6kb5PtRlZ
         svkU4OD7YKgPUhNBmPO8szVNtlqWLh2Ql4yYfBeO/15LoMvM2/ZlGzLMO+NHr9driTYK
         gOTfJ1rWvSHiBJ6HQmrMJLuitxvZduomjjDUzVUnoZcZZUlnYLtHyxa4v4KH+fQWlZsi
         Gbmw==
X-Gm-Message-State: AJIora+Sut1ZAjZWWiTmaJVwy3YQz1qSu8Jtc71hFEWpM8Pf4Lm6lRBk
        Qy4Qlp2oLRoNpj81r/MaEEq0h9weiQ==
X-Google-Smtp-Source: AGRyM1tY2Kuf4G7eBZ1ePPacUd02zzR8e9qZkmbltUfOdHLl+CROZ8ae5h0o6TcthJZCMw2Fyjyb6Q==
X-Received: by 2002:a05:6e02:17c8:b0:2d4:dfae:edf4 with SMTP id z8-20020a056e0217c800b002d4dfaeedf4mr1110869ilu.8.1655157238594;
        Mon, 13 Jun 2022 14:53:58 -0700 (PDT)
Received: from robh.at.kernel.org ([69.39.28.171])
        by smtp.gmail.com with ESMTPSA id b10-20020a02380a000000b00332268fb7b3sm4038553jaa.21.2022.06.13.14.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 14:53:58 -0700 (PDT)
Received: (nullmailer pid 160888 invoked by uid 1000);
        Mon, 13 Jun 2022 21:53:57 -0000
Date:   Mon, 13 Jun 2022 15:53:57 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
        krzk+dt@kernel.org, geert+renesas@glider.be, magnus.damm@gmail.com,
        marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 2/7] dt-bindings: PCI: renesas: Add R-Car Gen4 PCIe
 Endpoint
Message-ID: <20220613215357.GC87830-robh@kernel.org>
References: <20220613115712.2831386-1-yoshihiro.shimoda.uh@renesas.com>
 <20220613115712.2831386-3-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613115712.2831386-3-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 13, 2022 at 08:57:07PM +0900, Yoshihiro Shimoda wrote:
> Document bindings for Renesas R-Car Gen4 and R-Car S4-8 (R8A779F0)
> PCIe endpoint module.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  .../bindings/pci/rcar-gen4-pci-ep.yaml        | 111 ++++++++++++++++++
>  1 file changed, 111 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml
> new file mode 100644
> index 000000000000..654efdb3a51e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml
> @@ -0,0 +1,111 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2022 Renesas Electronics Corp.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/rcar-gen4-pci-ep.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas R-Car Gen4 PCIe Endpoint
> +
> +maintainers:
> +  - Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> +
> +allOf:
> +  - $ref: snps,dw-pcie-ep.yaml#
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: renesas,r8a779f0-pcie-ep   # R-Car S4-8
> +      - const: renesas,rcar-gen4-pcie-ep  # R-Car Gen4
> +      - const: snps,dw-pcie-ep

Drop the last entry. Not all that useful...

> +
> +  reg:
> +    maxItems: 4
> +
> +  reg-names:
> +    items:
> +      - const: dbi
> +      - const: atu
> +      - const: appl
> +      - const: addr_space
> +
> +  interrupts:
> +    maxItems: 6
> +
> +  interrupt-names:
> +    items:
> +      - const: msi
> +      - const: err
> +      - const: fatal
> +      - const: nonfatal
> +      - const: lp
> +      - const: vndmsg
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 2
> +
> +  clock-names:
> +    items:
> +      - const: pcie
> +      - const: pcie_bus
> +

> +  num-ib-windows: true
> +
> +  num-ob-windows: true

Deprecated. These are detected at runtime.

> +
> +  max-link-speed: true
> +
> +  num-lanes: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - interrupts
> +  - resets
> +  - power-domains
> +  - clocks
> +  - clock-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/r8a779f0-cpg-mssr.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/power/r8a779f0-sysc.h>
> +
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        pcie0_ep: pcie-ep@e65d0000 {
> +            compatible = "renesas,r8a779f0-pcie-ep", "renesas,rcar-gen4-pcie-ep",
> +                         "snps,dw-pcie-ep";
> +            reg = <0 0xe65d0000 0 0x1000>, <0 0xe65d1000 0 0x1000>,
> +                  <0 0xe65d3000 0 0x2000>, <0 0xfe000000 0 0x400000>;
> +            reg-names = "dbi", "atu", "appl", "addr_space";
> +            interrupts = <GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 418 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 419 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 420 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 421 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>;
> +            interrupt-names = "msi", "err", "fatal", "nonfatal", "lp", "vndmsg";
> +            clocks = <&cpg CPG_MOD 624>, <&pcie_bus_clk>;
> +            clock-names = "pcie", "pcie_bus";
> +            power-domains = <&sysc R8A779F0_PD_ALWAYS_ON>;
> +            resets = <&cpg 624>;
> +            num-lanes = <2>;
> +            max-link-speed = <2>;
> +            num-ib-windows = <16>;
> +            num-ob-windows = <16>;
> +        };
> +    };
> -- 
> 2.25.1
> 
