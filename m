Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 703D6570AA4
	for <lists+linux-pci@lfdr.de>; Mon, 11 Jul 2022 21:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbiGKTVs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Jul 2022 15:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbiGKTVr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Jul 2022 15:21:47 -0400
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E9677483;
        Mon, 11 Jul 2022 12:21:46 -0700 (PDT)
Received: by mail-io1-f51.google.com with SMTP id n7so5860523ioo.7;
        Mon, 11 Jul 2022 12:21:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LQBkw/1t1jsiyMxxLEya+9sUfa3+KmfgQx3Z4P2Cfzw=;
        b=ZFbZ983KHoTGyUUsmTciXpA4TgqDkOjJEsYd4xBbA5H+KWB80vf+CyZ6wQN+s6xEHE
         bdHFJ+KebCx8YOK8UNk5GuJ5nSscbs22deOIJbTYMcCYKWWzMwf0esjljvb24HQO7T3n
         PdrCgSydHqOK2OWXabLLvTs3lKgf0FMG1Tx2hn/Vy/nQrrab3hul0pq59hP2CBM5nDRb
         86qTGbvs/QlENRGO0kyf0yaQIIvBsSWdciaw+aXpv6pEcyIJWJHguaGlDESLRS3jFWu+
         Rh70tZWyQM1BPkEI4tM2uTlhtkgH2PfIN43XHRVU4jU6BMULwRgH3fUwH+ZFEFzPRvc3
         fq7w==
X-Gm-Message-State: AJIora8TdC5tS74NPvcmhLddLki0ItJROuAx8e0bS3j/2R/rHSmq/Fr2
        YlHwGaHD9nc4vbx7xXHTRQ==
X-Google-Smtp-Source: AGRyM1tG+hKg3apN6v6YBT3QwrDKQ5b9vYwXaX7DWyX1W0rGWMj5NNifv4hhEu+WzdEpQ5nRy+B76Q==
X-Received: by 2002:a05:6638:2052:b0:33b:c087:6aa1 with SMTP id t18-20020a056638205200b0033bc0876aa1mr11546621jaj.122.1657567305667;
        Mon, 11 Jul 2022 12:21:45 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id u14-20020a02230e000000b0033197f42be0sm3182580jau.157.2022.07.11.12.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 12:21:45 -0700 (PDT)
Received: (nullmailer pid 126689 invoked by uid 1000);
        Mon, 11 Jul 2022 19:21:43 -0000
Date:   Mon, 11 Jul 2022 13:21:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     bhelgaas@google.com, lpieralisi@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, kw@linux.com, kishon@ti.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com,
        Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH V4 1/9] dt-bindings: pci: tegra: Convert to json-schema
Message-ID: <20220711192143.GA111260-robh@kernel.org>
References: <20220707081301.29961-1-vidyas@nvidia.com>
 <20220707081301.29961-2-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220707081301.29961-2-vidyas@nvidia.com>
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

On Thu, Jul 07, 2022 at 01:42:53PM +0530, Vidya Sagar wrote:
> Convert the Tegra194 PCIe bindings from the free-form text format to
> json-schema.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
> V4:
> * Addressed review comments from Krzysztof and Rob
> 
> V3:
> * New patch in this series. Added as part of addressing Rob's review
>   comment to convert the existing .txt file to .yaml schema
> 
>  .../bindings/pci/nvidia,tegra194-pcie-ep.yaml | 228 ++++++++++++++++
>  .../bindings/pci/nvidia,tegra194-pcie.txt     | 245 -----------------
>  .../bindings/pci/nvidia,tegra194-pcie.yaml    | 257 ++++++++++++++++++
>  .../devicetree/bindings/pci/snps,dw-pcie.yaml |   2 +-
>  4 files changed, 486 insertions(+), 246 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.yaml
>  delete mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt
>  create mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml

[...]

> diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml
> new file mode 100644
> index 000000000000..5d7cb56c86a2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml
> @@ -0,0 +1,257 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/nvidia,tegra194-pcie.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NVIDIA Tegra194 (and later) PCIe controller (Synopsys DesignWare Core based)
> +
> +maintainers:
> +  - Thierry Reding <thierry.reding@gmail.com>
> +  - Jon Hunter <jonathanh@nvidia.com>
> +  - Vidya Sagar <vidyas@nvidia.com>
> +
> +description: |
> +  This PCIe controller is based on the Synopsis Designware PCIe IP and thus
> +  inherits all the common properties defined in snps,dw-pcie.yaml. Some of the
> +  controller instances are dual mode where in they can work either in root port
> +  mode or endpoint mode but one at a time.
> +
> +  see nvidia,tegra194-pcie-ep.yaml for details on the endpoint mode device tree
> +  bindings.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - nvidia,tegra194-pcie
> +
> +  reg:
> +    items:
> +      - description: controller's application logic registers
> +      - description: configuration registers
> +      - description: iATU and DMA registers. This is where the iATU (internal
> +          Address Translation Unit) registers of the PCIe core are made
> +          available for software access.
> +      - description: The aperture where the root port's own configuration
> +          registers are available.
> +
> +  reg-names:
> +    items:
> +      - const: appl
> +      - const: config
> +      - const: atu_dma
> +      - const: dbi
> +
> +  interrupts:
> +    items:
> +      - description: controller interrupt
> +      - description: MSI interrupt
> +
> +  interrupt-names:
> +    items:
> +      - const: intr
> +      - const: msi
> +
> +  clocks:
> +    items:
> +      - description: module clock
> +
> +  clock-names:
> +    items:
> +      - const: core
> +
> +  resets:
> +    items:
> +      - description: APB bus interface reset
> +      - description: module reset
> +
> +  reset-names:
> +    items:
> +      - const: apb
> +      - const: core
> +
> +  phys:
> +    minItems: 1
> +    maxItems: 8
> +
> +  phy-names:
> +    minItems: 1
> +    items:
> +      - const: p2u-0
> +      - const: p2u-1
> +      - const: p2u-2
> +      - const: p2u-3
> +      - const: p2u-4
> +      - const: p2u-5
> +      - const: p2u-6
> +      - const: p2u-7
> +
> +  power-domains:
> +    maxItems: 1
> +    description: |
> +      A phandle to the node that controls power to the respective PCIe
> +      controller and a specifier name for the PCIe controller.
> +
> +      specifiers are defined in "include/dt-bindings/power/tegra194-powergate.h" file.
> +
> +  interconnects:
> +    items:
> +      - description: memory read client
> +      - description: memory write client
> +
> +  interconnect-names:
> +    items:
> +      - const: dma-mem # read
> +      - const: write
> +
> +  dma-coherent: true
> +
> +  nvidia,bpmp:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description: |
> +      Must contain a pair of phandle to BPMP controller node followed by
> +      controller ID. Following are the controller IDs for each controller:
> +
> +        0: C0
> +        1: C1
> +        2: C2
> +        3: C3
> +        4: C4
> +        5: C5
> +    items:
> +      - items:
> +          - description: phandle to BPMP controller node
> +          - description: PCIe controller ID
> +            maximum: 5
> +
> +  nvidia,update-fc-fixup:
> +    description: |
> +      This is a boolean property and needs to be present to improve performance
> +      when a platform is designed in such a way that it satisfies at least one
> +      of the following conditions thereby enabling root port to exchange
> +      optimum number of FC (Flow Control) credits with downstream devices:
> +
> +        1. If C0/C4/C5 run at x1/x2 link widths (irrespective of speed and MPS)
> +        2. If C0/C1/C2/C3/C4/C5 operate at their respective max link widths and
> +          a) speed is Gen-2 and MPS is 256B
> +          b) speed is >= Gen-3 with any MPS
> +
> +    $ref: /schemas/types.yaml#/definitions/flag
> +
> +  nvidia,aspm-cmrt-us:
> +    description: Common Mode Restore Time for proper operation of ASPM to be
> +      specified in microseconds
> +
> +  nvidia,aspm-pwr-on-t-us:
> +    description: Power On time for proper operation of ASPM to be specified in
> +      microseconds
> +
> +  nvidia,aspm-l0s-entrance-latency-us:
> +    description: ASPM L0s entrance latency to be specified in microseconds
> +
> +  vddio-pex-ctl-supply:
> +    description: A phandle to the regulator supply for PCIe side band signals.
> +
> +  vpcie3v3-supply:
> +    description: A phandle to the regulator node that supplies 3.3V to the slot
> +      if the platform has one such slot. (Ex:- x16 slot owned by C5 controller
> +      in p2972-0000 platform).
> +
> +  vpcie12v-supply:
> +    description: A phandle to the regulator node that supplies 12V to the slot
> +      if the platform has one such slot. (Ex:- x16 slot owned by C5 controller
> +      in p2972-0000 platform).
> +
> +allOf:
> +  - $ref: /schemas/pci/pci-bus.yaml#

Already referenced by this:

> +  - $ref: /schemas/pci/snps,dw-pcie.yaml#
> +
> +unevaluatedProperties: false
> +
> +required:

> +  - compatible
> +  - reg
> +  - reg-names

Already required by snps,dw-pcie.yaml.

> +  - interrupts
> +  - interrupt-names
> +  - interrupt-map
> +  - interrupt-map-mask
> +  - clocks
> +  - clock-names
> +  - resets
> +  - reset-names
> +  - power-domains
> +  - bus-range

Should not be required. 0-0xff is the default.

> +  - ranges

Already required by pci-bus.yaml

> +  - vddio-pex-ctl-supply
> +  - num-lanes
> +  - phys
> +  - phy-names
> +  - nvidia,bpmp
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/tegra194-clock.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/power/tegra194-powergate.h>
> +    #include <dt-bindings/reset/tegra194-reset.h>
> +
> +    bus@0 {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +        ranges = <0x0 0x0 0x0 0x8 0x0>;
> +
> +        pcie@14180000 {
> +            compatible = "nvidia,tegra194-pcie";
> +            power-domains = <&bpmp TEGRA194_POWER_DOMAIN_PCIEX8B>;
> +            reg = <0x0 0x14180000 0x0 0x00020000>, /* appl registers (128K)      */
> +                  <0x0 0x38000000 0x0 0x00040000>, /* configuration space (256K) */
> +                  <0x0 0x38040000 0x0 0x00040000>, /* iATU_DMA reg space (256K)  */
> +                  <0x0 0x38080000 0x0 0x00040000>; /* DBI reg space (256K)       */
> +            reg-names = "appl", "config", "atu_dma", "dbi";
> +
> +            #address-cells = <3>;
> +            #size-cells = <2>;
> +            device_type = "pci";
> +            num-lanes = <8>;
> +            linux,pci-domain = <0>;
> +
> +            pinctrl-names = "default";
> +            pinctrl-0 = <&pex_rst_c5_out_state>, <&clkreq_c5_bi_dir_state>;
> +
> +            clocks = <&bpmp TEGRA194_CLK_PEX0_CORE_0>;
> +            clock-names = "core";
> +
> +            resets = <&bpmp TEGRA194_RESET_PEX0_CORE_0_APB>,
> +                     <&bpmp TEGRA194_RESET_PEX0_CORE_0>;
> +            reset-names = "apb", "core";
> +
> +            interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>, /* controller interrupt */
> +                         <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>; /* MSI interrupt */
> +            interrupt-names = "intr", "msi";
> +
> +            #interrupt-cells = <1>;
> +            interrupt-map-mask = <0 0 0 0>;
> +            interrupt-map = <0 0 0 0 &gic GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
> +
> +            nvidia,bpmp = <&bpmp 0>;
> +
> +            supports-clkreq;
> +            nvidia,aspm-cmrt-us = <60>;
> +            nvidia,aspm-pwr-on-t-us = <20>;
> +            nvidia,aspm-l0s-entrance-latency-us = <3>;
> +
> +            bus-range = <0x0 0xff>;
> +            ranges = <0x81000000 0x0  0x38100000 0x0  0x38100000 0x0 0x00100000>, /* downstream I/O */
> +                     <0x82000000 0x0  0x38200000 0x0  0x38200000 0x0 0x01e00000>, /* non-prefetch memory */
> +                     <0xc2000000 0x18 0x00000000 0x18 0x00000000 0x4 0x00000000>; /* prefetchable memory */
> +
> +            vddio-pex-ctl-supply = <&vdd_1v8ao>;
> +            vpcie3v3-supply = <&vdd_3v3_pcie>;
> +            vpcie12v-supply = <&vdd_12v_pcie>;
> +
> +            phys = <&p2u_hsio_2>, <&p2u_hsio_3>, <&p2u_hsio_4>,
> +                   <&p2u_hsio_5>;
> +            phy-names = "p2u-0", "p2u-1", "p2u-2", "p2u-3";
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> index c90e5e2d25f6..7e0bf941fbfe 100644
> --- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> @@ -35,7 +35,7 @@ properties:
>      maxItems: 5
>      items:
>        enum: [ dbi, dbi2, config, atu, app, elbi, mgmt, ctrl, parf, cfg, link,
> -              ulreg, smu, mpu, apb, phy ]
> +              ulreg, smu, mpu, apb, phy, appl, atu_dma ]

I'd put 'appl' next to 'app' and 'atu_dma' next to 'atu'.

With those fixes,

Reviewed-by: Rob Herring <robh@kernel.org>


Rob
