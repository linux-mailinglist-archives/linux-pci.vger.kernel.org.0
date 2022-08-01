Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF43E587042
	for <lists+linux-pci@lfdr.de>; Mon,  1 Aug 2022 20:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233286AbiHASNQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Aug 2022 14:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbiHASNP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Aug 2022 14:13:15 -0400
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1223D26C6;
        Mon,  1 Aug 2022 11:13:14 -0700 (PDT)
Received: by mail-il1-f181.google.com with SMTP id s16so2265549ilp.3;
        Mon, 01 Aug 2022 11:13:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=j9dit8EqlWhA+Rr+GJY5510B6cmCqLCKgNOXN9P6uiM=;
        b=g8nQZ1BPkX1lxBLXzzF9tLiYNS8AWv8vmeSkpRN39CJsP3CN2UhZwf0ZJKXm5SarFk
         xuFdroBl/f9yoqVl7goFTN+1pYbYTDV/QvTVxkACTOxYPtdgiuk2VvMdtLg/UyYTTcfS
         U50W3j0GSVT6ubgxdVx4IzYERIEmzNy9vxF5ni8f37d4seikOJisPH8JLlJiWmJv4Lha
         jdjZdY7ggcrL89a5sVp3pLPZCmu7IeKE2To+CuTxS6d1awE5b5mv05tq7WmhbL6gUsq/
         TOXkLPG17VVPIdEJVWRO5nfhtOIE/z2je0LWiH5ZLPkM7SIE0OTx6lzW1R1YvpiJPhN9
         2vlw==
X-Gm-Message-State: ACgBeo0V4qjRFLpc63yBmCd9KZBAmkuY7F1lRawcy67HPntee9/jrIFf
        TweHwr8UaUzaSUFMxM/FYw==
X-Google-Smtp-Source: AA6agR5C9PX1B7eebFsRwDF+jj5DM2vHaWnHure64vtNN+g1MnF9pk2wwrqQ/RR8MEbUiTuAqhqUVA==
X-Received: by 2002:a92:c26d:0:b0:2de:bfd7:17e with SMTP id h13-20020a92c26d000000b002debfd7017emr1403981ild.156.1659377593211;
        Mon, 01 Aug 2022 11:13:13 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id g14-20020a05663810ee00b003423f7b779csm4718055jae.41.2022.08.01.11.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 11:13:12 -0700 (PDT)
Received: (nullmailer pid 1278505 invoked by uid 1000);
        Mon, 01 Aug 2022 18:13:11 -0000
Date:   Mon, 1 Aug 2022 12:13:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 12/17] dt-bindings: PCI: dwc: Add Baikal-T1 PCIe Root
 Port bindings
Message-ID: <20220801181311.GA1266390-robh@kernel.org>
References: <20220728143427.13617-1-Sergey.Semin@baikalelectronics.ru>
 <20220728143427.13617-13-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220728143427.13617-13-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 28, 2022 at 05:34:22PM +0300, Serge Semin wrote:
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
> +      - const: snps,dw-pcie

Again, these fallbacks simply aren't useful.

> +
> +  reg:
> +    description:
> +      DBI, DBI2 and at least 4KB outbound iATU-capable region.

'iATU-capable region' means config space? That's not very clear.

> +    maxItems: 3
> +
> +  reg-names:
> +    minItems: 3
> +    maxItems: 3
> +    items:
> +      enum: [ dbi, dbi2, config ]

Define the order. Here, and the rest.

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

These are deprecated. Don't add them for a new binding.


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
