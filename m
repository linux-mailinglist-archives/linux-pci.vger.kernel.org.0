Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78CA8549DB5
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jun 2022 21:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349553AbiFMT3x (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jun 2022 15:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351517AbiFMT3S (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jun 2022 15:29:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51DD579B1;
        Mon, 13 Jun 2022 10:53:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 632EDB811A9;
        Mon, 13 Jun 2022 17:53:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10B49C3411F;
        Mon, 13 Jun 2022 17:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655142835;
        bh=Ktwx9XBB9r85V2qC6XiDsWVveebdN5oRGmm8T5DQj2w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=arwFvXiGWyFV96Jpi7LUf8i3mJFtgaI3cpsXnHiPpFLsNe9h79VUNm5hFnBosyTHY
         3eoYtTpcec6F6slx41SIaOmJfS6IDUC161Op8/tl6+KPG8iLZzUTzlTRm3WV2tFKE7
         Ull20bBH08NNn0xD1Pmn2QDl/eerAQyEwt4XqNMI3E3WHPElSdA4Fhhf/NduPcJ81x
         rVUXKDE8I+FAogtWyawEYiVKjWAomiVzho8MBCzA9Itx2Eoq+IaSjxBFim2UBIww22
         S1H1l83oWYE7HG5YfjQCtwsGXLs83L/Xhe+nzRaLqG+rExI/NUZWT1EeBQkdK/4P+L
         wg0hpSnZmzKsw==
Received: by mail-vs1-f53.google.com with SMTP id x187so6680140vsb.0;
        Mon, 13 Jun 2022 10:53:54 -0700 (PDT)
X-Gm-Message-State: AJIora/O8VZVnUnm5B2z31oH7Bm47A0mdBW4lFyjb0HLgLYOutHfzRyh
        jsFv5zNqKUGXVkFfe36FQSE7+dzdsOFi0hRf/Q==
X-Google-Smtp-Source: AGRyM1tKd/ZYDEQ9BFFbwDeRHHbnN7ks9nFRlfNc2DWzcyYQ565D/VLADk2i5/ALN76vTg7JR6NKMkFpVrQDGJHk/54=
X-Received: by 2002:a67:d38c:0:b0:349:d028:c8ea with SMTP id
 b12-20020a67d38c000000b00349d028c8eamr294686vsj.6.1655142833950; Mon, 13 Jun
 2022 10:53:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220613115712.2831386-1-yoshihiro.shimoda.uh@renesas.com> <20220613115712.2831386-2-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <20220613115712.2831386-2-yoshihiro.shimoda.uh@renesas.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 13 Jun 2022 11:53:42 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK71KHCPksJSq+RE2xvP_QDresT8K2mNPMcEpekAjjbyw@mail.gmail.com>
Message-ID: <CAL_JsqK71KHCPksJSq+RE2xvP_QDresT8K2mNPMcEpekAjjbyw@mail.gmail.com>
Subject: Re: [PATCH 1/7] dt-bindings: PCI: renesas: Add R-Car Gen4 PCIe Host
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Wilczynski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        PCI <linux-pci@vger.kernel.org>, devicetree@vger.kernel.org,
        "open list:MEDIA DRIVERS FOR RENESAS - FCP" 
        <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 13, 2022 at 5:57 AM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
>
> Document bindings for Renesas R-Car Gen4 and R-Car S4-8 (R8A779F0)
> PCIe host module.
>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  .../bindings/pci/rcar-gen4-pci-host.yaml      | 104 ++++++++++++++++++
>  1 file changed, 104 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
>
> diff --git a/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
> new file mode 100644
> index 000000000000..8caa9824d6ca
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
> @@ -0,0 +1,104 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2022 Renesas Electronics Corp.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/rcar-gen4-pci-host.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas R-Car Gen4 PCIe Host
> +
> +maintainers:
> +  - Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> +
> +allOf:
> +  - $ref: snps,dw-pcie.yaml#
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: renesas,r8a779f0-pcie   # R-Car S4-8
> +      - const: renesas,rcar-gen4-pcie  # R-Car Gen4
> +      - const: snps,dw-pcie
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
> +  clocks:
> +    maxItems: 2
> +
> +  clock-names:
> +    items:
> +      - const: pcie
> +      - const: pcie_bus
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - power-domains
> +
> +unevaluatedProperties: false
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
> +        pcie: pcie@e65d0000 {
> +            compatible = "renesas,r8a779f0-pcie", "renesas,rcar-gen4-pcie",
> +                         "snps,dw-pcie";
> +            reg = <0 0xe65d0000 0 0x3000>, <0 0xe65d3000 0 0x2000>,
> +                  <0 0xe65d6200 0 0x0e00>, <0 0xe65d7000 0 0x1000>,
> +                  <0 0xfe000000 0 0x10000>;
> +            reg-names = "dbi", "atu", "app", "phy", "config";

'phy' should probably be a separate node.

> +            #address-cells = <3>;
> +            #size-cells = <2>;
> +            bus-range = <0x00 0xff>;
> +            device_type = "pci";
> +            ranges =  <0x81000000 0 0x00000000 0 0xfe000000 0 0x00010000

Same address for i/o as your config space?

Each ranges entry should have <>.

> +                       0x82000000 0 0x30000000 0 0x30000000 0 0x10000000>;
> +            dma-ranges = <0x42000000 0 0x40000000 0 0x40000000 0 0x80000000>;
> +            interrupts = <GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 418 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 419 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 420 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 421 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>;
> +            interrupt-names = "msi", "err", "fatal", "nonfatal", "lp", "vndmsg";
> +            #interrupt-cells = <1>;
> +            interrupt-map-mask = <0 0 0 7>;
> +            interrupt-map = <0 0 0 1 &gic GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH
> +                             0 0 0 2 &gic GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH
> +                             0 0 0 3 &gic GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH
> +                             0 0 0 4 &gic GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH>;

Bracket each entry.

> +            clocks = <&cpg CPG_MOD 624>, <&pcie_bus_clk>;
> +            clock-names = "pcie", "pcie_bus";

This doesn't look like clock names that the DW block has. It's kind of
a mess already, but don't add to it.

> +            power-domains = <&sysc R8A779F0_PD_ALWAYS_ON>;
> +            resets = <&cpg 624>;
> +            num-lanes = <2>;
> +            snps,enable-cdm-check;
> +            max-link-speed = <2>;
> +        };
> +    };
> --
> 2.25.1
>
