Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DABAE7BF9A9
	for <lists+linux-pci@lfdr.de>; Tue, 10 Oct 2023 13:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbjJJLZa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Oct 2023 07:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbjJJLZ3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Oct 2023 07:25:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA6DA4;
        Tue, 10 Oct 2023 04:25:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F247EC433C8;
        Tue, 10 Oct 2023 11:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696937128;
        bh=hcRH6Yl/XYVCsxclrsioAqWbnUxsQbUBsEyh+2QQxKQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SyN/AzO4iI3jTJFapc9qbEyPg11+hIwkZ/1IKTKFQbTlLD0bmmLbp9RsZiVITq9SN
         HjsfpLzUzsfIgs30JD4Tujaxy7aOIGVh4gzhyRRJ+veNupCiNtKxyMaERgsJybr+M7
         /H09/TZQ9KvTfPFy66Ca7bZpz6XKLAarwvyHppjk/Ql2s4pQzgU1x9cQo2fFxS3ScK
         a1iIxHNnzQvFTcKZEg0Vri8VaJ1XZJq7gCGBXgfJbF6qKdbC5Xqr0PazVQcbzTpp3r
         iq+LxQt1heLpUEd7G0AU1YZa0H2kBNcQ3zykzVdofqFYubw8swHls4cRG+OYnH+KkA
         dapSZ1fYQtLzw==
Date:   Tue, 10 Oct 2023 16:55:12 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, marek.vasut+renesas@gmail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Serge Semin <fancer.lancer@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v21 10/16] dt-bindings: PCI: renesas: Add R-Car Gen4 PCIe
 Host
Message-ID: <20231010112512.GE4884@thinkpad>
References: <20230922065331.3806925-1-yoshihiro.shimoda.uh@renesas.com>
 <20230922065331.3806925-11-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230922065331.3806925-11-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 22, 2023 at 03:53:25PM +0900, Yoshihiro Shimoda wrote:
> Document bindings for Renesas R-Car Gen4 and R-Car S4-8 (R8A779F0)
> PCIe host module.
> 
> Link: https://lore.kernel.org/linux-pci/20230825093219.2685912-15-yoshihiro.shimoda.uh@renesas.com
> Link: https://lore.kernel.org/linux-pci/20230901131711.2861283-3-yoshihiro.shimoda.uh@renesas.com
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  .../bindings/pci/rcar-gen4-pci-host.yaml      | 127 ++++++++++++++++++
>  1 file changed, 127 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
> new file mode 100644
> index 000000000000..ffb34339b637
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
> @@ -0,0 +1,127 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2022-2023 Renesas Electronics Corp.
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
> +    maxItems: 7
> +
> +  reg-names:
> +    items:
> +      - const: dbi
> +      - const: dbi2
> +      - const: atu
> +      - const: dma
> +      - const: app
> +      - const: phy
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
> +    maxItems: 2
> +
> +  clock-names:
> +    items:
> +      - const: core
> +      - const: ref
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  reset-names:
> +    items:
> +      - const: pwr
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
> +  - reg-names
> +  - interrupts
> +  - interrupt-names
> +  - clocks
> +  - clock-names
> +  - power-domains
> +  - resets
> +  - reset-names
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
> +                  <0 0xe65d6200 0 0x0e00>, <0 0xe65d7000 0 0x0400>,
> +                  <0 0xfe000000 0 0x400000>;
> +            reg-names = "dbi", "dbi2", "atu", "dma", "app", "phy", "config";
> +            interrupts = <GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 417 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 418 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>;
> +            interrupt-names = "msi", "dma", "sft_ce", "app";
> +            clocks = <&cpg CPG_MOD 624>, <&pcie0_clkref>;
> +            clock-names = "core", "ref";
> +            power-domains = <&sysc R8A779F0_PD_ALWAYS_ON>;
> +            resets = <&cpg 624>;
> +            reset-names = "pwr";
> +            max-link-speed = <4>;
> +            num-lanes = <2>;
> +            #address-cells = <3>;
> +            #size-cells = <2>;
> +            bus-range = <0x00 0xff>;
> +            device_type = "pci";
> +            ranges = <0x01000000 0 0x00000000 0 0xfe000000 0 0x00400000>,
> +                     <0x02000000 0 0x30000000 0 0x30000000 0 0x10000000>;
> +            dma-ranges = <0x42000000 0 0x00000000 0 0x00000000 1 0x00000000>;
> +            #interrupt-cells = <1>;
> +            interrupt-map-mask = <0 0 0 7>;
> +            interrupt-map = <0 0 0 1 &gic GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH>,
> +                            <0 0 0 2 &gic GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH>,
> +                            <0 0 0 3 &gic GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH>,
> +                            <0 0 0 4 &gic GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH>;

I believe these are for legacy INTx interrupts. But you are using the same IRQ
number used for MSI above. Can you clarify?

- Mani

> +            snps,enable-cdm-check;
> +        };
> +    };
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்
