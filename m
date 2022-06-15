Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82B0454CED4
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jun 2022 18:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239746AbiFOQhR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jun 2022 12:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbiFOQhQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jun 2022 12:37:16 -0400
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BCF736B51;
        Wed, 15 Jun 2022 09:37:15 -0700 (PDT)
Received: by mail-io1-f47.google.com with SMTP id h8so13222202iof.11;
        Wed, 15 Jun 2022 09:37:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GdPTGF0Yowm0M6DZNo/ArXuy4fB60vvdtK+22e9Yyr0=;
        b=HW9CYGRDDnY9Rh/SoUCddTEYHYXdABGmyRF9QvxPc3mkhWaks1/zb/qlNJtNWzSM5i
         sOoK8B2mKTR2papdYWIo1gNYKmYOWErtlDN4altMgMbv+HkcsXuRjTz1oVKpXbRLVB1+
         vNnlaPwFdeuEaPmV+YoNYsRV8vBVIm074sK+9ouDabmnAdQmrPFRVEOhV9sqgAUK4MEL
         TLx/AnWqguUkTQdsIpArA2ESb1y80AGYZiDtLWH+Wqf/vUjDhw7xdH8qhUGO3HunmTTW
         7GItqc7+kKce25xpLwk+X39Vo/y42MMe8XQPU9U9e67Btf/BS3sFcB1vncjLHcyr2Wxa
         CcBg==
X-Gm-Message-State: AJIora/KRTHDRshpH1mcA0g1oR4XSLWKtICP7gHUD/pQeBh+Hbpef4Rq
        sqMvPwBr+bwpkoTZAHaq/A==
X-Google-Smtp-Source: AGRyM1vs+GCU2Pfz40cGxikf8/dmSx3FpIjYSVm2rgPu73t00o5WvCMXGV2ehmhF5cQsAeDYJhMaHg==
X-Received: by 2002:a6b:ba43:0:b0:669:a9b2:48fb with SMTP id k64-20020a6bba43000000b00669a9b248fbmr277664iof.125.1655311034285;
        Wed, 15 Jun 2022 09:37:14 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id v7-20020a92c6c7000000b002d3ecb1a58esm7124392ilm.15.2022.06.15.09.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 09:37:13 -0700 (PDT)
Received: (nullmailer pid 1406658 invoked by uid 1000);
        Wed, 15 Jun 2022 16:37:12 -0000
Date:   Wed, 15 Jun 2022 10:37:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 12/17] dt-bindings: PCI: dwc: Add Baikal-T1 PCIe Root
 Port bindings
Message-ID: <20220615163712.GA1400328-robh@kernel.org>
References: <20220610085706.15741-1-Sergey.Semin@baikalelectronics.ru>
 <20220610085706.15741-13-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610085706.15741-13-Sergey.Semin@baikalelectronics.ru>
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

On Fri, Jun 10, 2022 at 11:57:00AM +0300, Serge Semin wrote:
> Baikal-T1 SoC is equipped with DWC PCIe v4.60a Root Port controller, which
> link can be trained to work on up to Gen.3 speed over up to x4 lanes. The
> controller is supposed to be fed up with four clock sources: DBI
> peripheral clock, AXI application Tx/Rx clocks and external PHY/core
> reference clock generating the 100MHz signal. In addition to that the
> platform provide a way to reset each part of the controller:
> sticky/non-sticky bits, host controller core, PIPE interface, PCS/PHY and
> Hot/Power reset signal. The Root Port controller is equipped with multiple
> IRQ lines like MSI, system AER, PME, HP, Bandwidth change, Link
> equalization request and eDMA ones. The registers space is accessed over
> the DBI interface. There can be no more than four inbound or outbound iATU
> windows configured.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> ---
> 
> Changelog v2:
> - Rename 'syscon' property to 'baikal,bt1-syscon'.
> - Fix the 'compatible' property definition to being more specific about
>   what strings are supposed to be used. Due to that we had to add the
>   select property to evaluate the schema against the Baikal-T1 PCIe DT
>   nodes only.
> ---
>  .../bindings/pci/baikal,bt1-pcie.yaml         | 154 ++++++++++++++++++
>  1 file changed, 154 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/baikal,bt1-pcie.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/baikal,bt1-pcie.yaml b/Documentation/devicetree/bindings/pci/baikal,bt1-pcie.yaml
> new file mode 100644
> index 000000000000..23bd1d0aa5c5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/baikal,bt1-pcie.yaml
> @@ -0,0 +1,154 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/baikal,bt1-pcie.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Baikal-T1 PCIe Root Port Controller
> +
> +maintainers:
> +  - Serge Semin <fancer.lancer@gmail.com>
> +
> +description:
> +  Embedded into Baikal-T1 SoC Root Complex controller. It's based on the
> +  DWC RC PCIe v4.60a IP-core, which is configured to have just a single Root
> +  Port function and is capable of establishing the link up to Gen.3 speed
> +  on x4 lanes. It doesn't have embedded clock and reset control module, so
> +  the proper interface initialization is supposed to be performed by software.
> +
> +select:
> +  properties:
> +    compatible:
> +      contains:
> +        const: baikal,bt1-pcie
> +
> +  required:
> +    - compatible
> +
> +allOf:
> +  - $ref: /schemas/pci/snps,dw-pcie.yaml#
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: baikal,bt1-pcie
> +      - const: snps,dw-pcie-4.60a

Pointless, you can read the version.

> +      - const: snps,dw-pcie

Pointless, because what can you do with this by itself?

> +
> +  reg:
> +    description:
> +      DBI, DBI2 and at least 4KB outbound iATU-capable region.
> +    maxItems: 3
> +
> +  reg-names:
> +    minItems: 3
> +    maxItems: 3
> +    items:
> +      enum: [ dbi, dbi2, config ]

This should define the order.

> +
> +  interrupts:
> +    description:
> +      MSI, AER, PME, Hot-plug, Link Bandwidth Management, Link Equalization
> +      request and eight Read/Write eDMA IRQ lines are available.
> +    maxItems: 14
> +
> +  interrupt-names:
> +    minItems: 14
> +    maxItems: 14
> +    items:
> +      oneOf:
> +        - pattern: '^dma[0-7]$'
> +        - enum: [ msi, aer, pme, hp, bw_mg, l_eq ]

Define the order.

> +
> +  clocks:
> +    description:
> +      DBI (attached to the APB bus), AXI-bus master and slave interfaces
> +      are fed up by the dedicated application clocks. A common reference
> +      clock signal is supposed to be attached to the corresponding Ref-pad
> +      of the SoC. It will be redistributed amongst the controller core
> +      sub-modules (pipe, core, aux, etc).
> +    minItems: 4
> +    maxItems: 4
> +
> +  clock-names:
> +    minItems: 4
> +    maxItems: 4
> +    items:
> +      enum: [ dbi, mstr, slv, ref ]
> +
> +  resets:
> +    description:
> +      A comprehensive controller reset logic is supposed to be implemented
> +      by software, so almost all the possible application and core reset
> +      signals are exposed via the system CCU module.
> +    minItems: 9
> +    maxItems: 9
> +
> +  reset-names:
> +    minItems: 9
> +    maxItems: 9
> +    items:
> +      enum: [ mstr, slv, pwr, hot, phy, core, pipe, sticky, non-sticky ]
> +
> +  baikal,bt1-syscon:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Phandle to the Baikal-T1 System Controller DT node. It's required to
> +      access some additional PM, Reset-related and LTSSM signals.
> +
> +  num-lanes:
> +    maximum: 4
> +
> +  max-link-speed:
> +    maximum: 3
> +

> +  num-ob-windows:
> +    const: 4
> +
> +  num-ib-windows:
> +    const: 4

Remove these. They are deprecated and shouldn't be in new bindings.

> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - interrupts
> +  - interrupt-names
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    pcie@1f052000 {
> +      compatible = "baikal,bt1-pcie", "snps,dw-pcie-4.60a", "snps,dw-pcie";
> +      device_type = "pci";
> +      reg = <0x1f052000 0x1000>, <0x1f053000 0x1000>, <0x1bdbf000 0x1000>;
> +      reg-names = "dbi", "dbi2", "config";
> +      #address-cells = <3>;
> +      #size-cells = <2>;
> +      ranges = <0x81000000 0 0x00000000 0x1bdb0000 0 0x00008000>,
> +               <0x82000000 0 0x20000000 0x08000000 0 0x13db0000>;
> +      bus-range = <0x0 0xff>;
> +
> +      interrupts = <0 80 4>, <0 81 4>, <0 82 4>, <0 83 4>,
> +                   <0 84 4>, <0 85 4>, <0 86 4>, <0 87 4>,
> +                   <0 88 4>, <0 89 4>, <0 90 4>, <0 91 4>,
> +                   <0 92 4>, <0 93 4>;
> +      interrupt-names = "dma0", "dma1", "dma2", "dma3", "dma4", "dma5", "dma6",
> +                        "dma7", "msi", "aer", "pme", "hp", "bw_mg", "l_eq";
> +
> +      clocks = <&ccu_sys 1>, <&ccu_axi 6>, <&ccu_axi 7>, <&clk_pcie>;
> +      clock-names = "dbi", "mstr", "slv", "ref";
> +
> +      resets = <&ccu_axi 6>, <&ccu_axi 7>, <&ccu_sys 7>, <&ccu_sys 10>,
> +               <&ccu_sys 4>, <&ccu_sys 6>, <&ccu_sys 5>, <&ccu_sys 8>,
> +               <&ccu_sys 9>;
> +      reset-names = "mstr", "slv", "pwr", "hot", "phy", "core", "pipe",
> +                    "sticky", "non-sticky";
> +
> +      reset-gpios = <&port0 0 1>;
> +
> +      num-lanes = <4>;
> +      max-link-speed = <3>;
> +    };
> +...
> -- 
> 2.35.1
> 
> 
