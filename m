Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 462206EB98A
	for <lists+linux-pci@lfdr.de>; Sat, 22 Apr 2023 16:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjDVOHI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 22 Apr 2023 10:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjDVOHH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 22 Apr 2023 10:07:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558821AD;
        Sat, 22 Apr 2023 07:06:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E0E8E60C5F;
        Sat, 22 Apr 2023 14:06:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5A73C433D2;
        Sat, 22 Apr 2023 14:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682172414;
        bh=KRFsq5EZh0O/wfBWGcDTB0W4vpL+eNy2oDK+z/bRiwk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iG4CgcRazTb/AEJ84uBdUfWVen0jljP3xLwn5FDl7YAShsvJSl2bc6ycDWLYxq1z2
         kEb7rkQ8UtcCV/5d5HwSf2I2SadijN2nzcpo5QLKm8FwwkH+mjAPX7Ev26EX0fcA5o
         mtMmf0NafR8c4ZSwIb+a9j5Cxjx8FD3SJHEjkgBO27h1TXZLRKYf6K/uZoWkoyyLur
         hDZpDaG+C4TBV4vImY5RXWxivmfZSAHzsgMAT4ZuSHRAB3aoBycdacvGi7xW2ThsuT
         P3Kbxf4fjH3YvSqbsMsZjA3u6C+wB+NAJ4vtM80GVxGvFS8MYqJpbnP4sOX0moAWoJ
         W6tGuGqak1isA==
Date:   Sat, 22 Apr 2023 19:36:44 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        fancer.lancer@gmail.com, lpieralisi@kernel.org, robh+dt@kernel.org,
        kw@linux.com, bhelgaas@google.com, kishon@kernel.org,
        marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v13 17/22] dt-bindings: PCI: renesas: Add R-Car Gen4 PCIe
 Host
Message-ID: <20230422140644.GN4769@thinkpad>
References: <20230418122403.3178462-1-yoshihiro.shimoda.uh@renesas.com>
 <20230418122403.3178462-18-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230418122403.3178462-18-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 18, 2023 at 09:23:58PM +0900, Yoshihiro Shimoda wrote:
> Document bindings for Renesas R-Car Gen4 and R-Car S4-8 (R8A779F0)
> PCIe host module.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> ---
>  .../bindings/pci/rcar-gen4-pci-host.yaml      | 109 ++++++++++++++++++
>  1 file changed, 109 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
> new file mode 100644
> index 000000000000..637353c3df8b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
> @@ -0,0 +1,109 @@
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
> +
> +  reg:
> +    maxItems: 6
> +
> +  reg-names:
> +    items:
> +      - const: dbi
> +      - const: dbi2
> +      - const: atu
> +      - const: dma
> +      - const: app
> +      - const: config
> +
> +  interrupts:
> +    maxItems: 4
> +
> +  interrupt-names:
> +    items:
> +      - const: msi
> +      - const: dma
> +      - const: sft_ce
> +      - const: app
> +
> +  clocks:
> +    maxItems: 1
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  max-link-speed:
> +    maximum: 4
> +
> +  num-lanes:
> +    maximum: 4
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
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
> +            compatible = "renesas,r8a779f0-pcie", "renesas,rcar-gen4-pcie";
> +            reg = <0 0xe65d0000 0 0x1000>, <0 0xe65d2000 0 0x0800>,
> +                  <0 0xe65d3000 0 0x2000>, <0 0xe65d5000 0 0x1200>,
> +                  <0 0xe65d6200 0 0x0e00>, <0 0xfe000000 0 0x400000>;
> +            reg-names = "dbi", "dbi2", "atu", "dma", "app", "config";
> +            #address-cells = <3>;
> +            #size-cells = <2>;
> +            bus-range = <0x00 0xff>;
> +            device_type = "pci";
> +            ranges = <0x81000000 0 0x00000000 0 0xfe000000 0 0x00400000
> +                      0x82000000 0 0x30000000 0 0x30000000 0 0x10000000>;

Do you actually need relocatable (0x8) flag?

- Mani

> +            dma-ranges = <0x42000000 0 0x40000000 0 0x40000000 0 0x80000000>;
> +            interrupts = <GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 417 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 418 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>;
> +            interrupt-names = "msi", "dma", "sft_ce", "app";
> +            #interrupt-cells = <1>;
> +            interrupt-map-mask = <0 0 0 7>;
> +            interrupt-map = <0 0 0 1 &gic GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH
> +                             0 0 0 2 &gic GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH
> +                             0 0 0 3 &gic GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH
> +                             0 0 0 4 &gic GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH>;
> +            clocks = <&cpg CPG_MOD 624>;
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

-- 
மணிவண்ணன் சதாசிவம்
