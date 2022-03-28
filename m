Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38DE04EA393
	for <lists+linux-pci@lfdr.de>; Tue, 29 Mar 2022 01:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbiC1XVt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Mar 2022 19:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbiC1XVt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Mar 2022 19:21:49 -0400
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACD1134;
        Mon, 28 Mar 2022 16:20:06 -0700 (PDT)
Received: by mail-oi1-f171.google.com with SMTP id q129so17365961oif.4;
        Mon, 28 Mar 2022 16:20:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Az+MY9NSlQZZNnS3o0rLrGelAp7EayLadbgOGpBV7a0=;
        b=vnGDD/vGqF7m4PbOUtfTrVazlvjE52ttDP3wkUK+x0y7s/4zRMfnzsQji0ntFdqEcx
         A0TAQJGdsPNpFn5taBS0JJMsUWfAmxvojvI2lDYHRLb6q6MDk+qvSe3s5Wf5OODEt71V
         HBz/xs3m2F3BKjA7LulETI5wMqt0+RQYlyzgeiuUn7KanqJWso8vPzeD51CsnIfOoWwT
         t43mhAHUMSDIosEWa37oGIDLhPVdCoNUb5qDCmIYo13Kmd4B7ZYESEFFQnOynSpGPiYS
         v/2WwhLlpquT1Zf7zsJ62EbY197oNL6HZcYoDBe8bF2ywfHBY0Cp9taFOoGAEySotgYA
         Y8cA==
X-Gm-Message-State: AOAM533RHwwF7xmuj1HwK4RDuno7oaH+a3+u8k2Y2wqw/1Lri5OcwJX8
        F6s6sxolepxVVv/7qeutXA==
X-Google-Smtp-Source: ABdhPJyAuKzd/h23jgh/6Vp1uLc82of3PFROtweM3HvlHdJkNRANCNS43he2n/hdyVEtd9aeKJP5eg==
X-Received: by 2002:a05:6808:170d:b0:2f7:3e70:fdb3 with SMTP id bc13-20020a056808170d00b002f73e70fdb3mr812746oib.139.1648509605211;
        Mon, 28 Mar 2022 16:20:05 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r19-20020a056830121300b005cdb11a7b85sm7761844otp.29.2022.03.28.16.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 16:20:04 -0700 (PDT)
Received: (nullmailer pid 3227660 invoked by uid 1000);
        Mon, 28 Mar 2022 23:20:03 -0000
Date:   Mon, 28 Mar 2022 18:20:03 -0500
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/16] dt-bindings: PCI: dwc: Add Baikal-T1 PCIe Root
 Port bindings
Message-ID: <YkJCo1PrdKlHYt8D@robh.at.kernel.org>
References: <20220324013734.18234-1-Sergey.Semin@baikalelectronics.ru>
 <20220324013734.18234-3-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324013734.18234-3-Sergey.Semin@baikalelectronics.ru>
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

On Thu, Mar 24, 2022 at 04:37:20AM +0300, Serge Semin wrote:
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
> Rob, this DT-bindings most likely will fail the dt_bindings_check
> evaluations with the "'*' is not of type 'array'" errors for the same
> reason described in the previous patch. Let's discuss the problem there.
> ---
>  .../bindings/pci/baikal,bt1-pcie.yaml         | 148 ++++++++++++++++++
>  1 file changed, 148 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/baikal,bt1-pcie.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/baikal,bt1-pcie.yaml b/Documentation/devicetree/bindings/pci/baikal,bt1-pcie.yaml
> new file mode 100644
> index 000000000000..f34438330a86
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/baikal,bt1-pcie.yaml
> @@ -0,0 +1,148 @@
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
> +description: |
> +  Embedded into Baikal-T1 SoC Root Complex controller. It's based on the
> +  DWC RC PCIe v4.60a IP-core, which is configured to have just a single Root
> +  Port function and is capable of establishing the link up to Gen.3 speed
> +  on x4 lanes. It doesn't have embedded clock and reset control module, so
> +  the proper interface initialization is supposed to be performed by software.
> +
> +allOf:
> +  - $ref: /schemas/pci/pci-bus.yaml#
> +  - $ref: snps,dw-pcie.yaml#
> +
> +properties:
> +  compatible:
> +    contains:
> +      const: baikal,bt1-pcie
> +
> +  reg:
> +    description:
> +      DBI, DBI2 and at least 4KB outbound iATU-capable region are available.

outbound iATU-capable region? While configured with iATU, it's just 
config space from a binding standpoint.

It's a bit more precise to do this:

items:
  - description: DBI...
  - description: DBI2...
  - ...


> +    maxItems: 3

And then drop this.

> +
> +  reg-names:
> +    minItems: 3
> +    maxItems: 3
> +    items:
> +      enum: [ dbi, dbi2, config ]

To enforce the order:

items:
  - const: dbi
  - const: dbi2
  - const: config

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

Can't you define the order?

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

Again, define the order.

> +
> +  syscon:

Needs a vendor prefix.

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

These are deprecated. The driver probes for how many now.

> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - interrupts
> +  - interrupt-names
> +  - clocks
> +  - clock-names
> +  - resets
> +  - reset-names
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
