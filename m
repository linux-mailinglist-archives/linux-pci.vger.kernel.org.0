Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1772C5AB681
	for <lists+linux-pci@lfdr.de>; Fri,  2 Sep 2022 18:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236264AbiIBQ2c (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Sep 2022 12:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236404AbiIBQ23 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Sep 2022 12:28:29 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D311FD9D61;
        Fri,  2 Sep 2022 09:28:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 167D3CE3028;
        Fri,  2 Sep 2022 16:28:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 607B9C43141;
        Fri,  2 Sep 2022 16:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662136101;
        bh=lmz9qUwSGEzB4ayujza0yZCNsmt2rSFG/r0YnQbiSF8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=d7db/1FB5w6kroVR+N201UB/iOfTCnu2ZFqhOie85o0BvlKIxcTT60uUIDuOTPF5S
         biVkw84ims6vbaz5/epF29qXntoih77M2L6/itpP+PLLrQlXadRuG5w/owbgUo0MjQ
         cBFoh1Vu5E9oRaEw9x5ld7C7rNWY9qrFiiIWosEpOSUnn4MO98s4amAfJgcMf+ZbvV
         VGgUkqh/Xh11Gaa3wFEovlvfxslMNbsYfaFu67QhN2mYKhD7rY8sN3id/ys6DUeae9
         PU77N3QYCzz0rk/tJWuWnNRpei85JCuKVokk5jutwOuLjQpZO8M2dI7wFM9F5ijIQ0
         +hfyceBNq1JYA==
Received: by mail-vs1-f54.google.com with SMTP id 190so2546826vsz.7;
        Fri, 02 Sep 2022 09:28:21 -0700 (PDT)
X-Gm-Message-State: ACgBeo1ZBO9ipWgfu9xOSOXpxZichsPYMk8e7IWqRbhVSGanZzr2WULK
        o6cHS1n9vP85VILZYHQBDs5204vzZpkz1R6aNQ==
X-Google-Smtp-Source: AA6agR5HK7mEDO5WrpaKzY6AFFNuyzJ/3Ez2tbot0FncUvHNy3yDHPPnEw7bWkcYJ8cgoN+ZG2vTo6LN7lNh8RGMFAQ=
X-Received: by 2002:a67:d183:0:b0:388:82dc:7a9 with SMTP id
 w3-20020a67d183000000b0038882dc07a9mr11041016vsi.0.1662136100302; Fri, 02 Sep
 2022 09:28:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220902142202.2437658-1-daire.mcnamara@microchip.com> <20220902142202.2437658-2-daire.mcnamara@microchip.com>
In-Reply-To: <20220902142202.2437658-2-daire.mcnamara@microchip.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 2 Sep 2022 11:28:09 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+5pKyOL8eu5YhQy9pLATd_gG_D71sR8bUp1GA6kif=nA@mail.gmail.com>
Message-ID: <CAL_Jsq+5pKyOL8eu5YhQy9pLATd_gG_D71sR8bUp1GA6kif=nA@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] dt-bindings: PCI: microchip: add fabric address
 translation properties
To:     Daire McNamara <daire.mcnamara@microchip.com>
Cc:     Albert Ou <aou@eecs.berkeley.edu>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krzysztof Wilczynski <kw@linux.com>,
        PCI <linux-pci@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Cyril Jean <cyril.jean@microchip.com>,
        Padmarao Begari <padmarao.begari@microchip.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        david.abdurachmanov@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 2, 2022 at 9:22 AM <daire.mcnamara@microchip.com> wrote:
>
> From: Conor Dooley <conor.dooley@microchip.com>
>
> On PolarFire SoC both in- & out-bound address translations occur in two
> stages. The specific translations are tightly coupled to the FPGA
> designs and supplement the {dma-,}ranges properties. The first stage of
> the translation is done by the FPGA fabric & the second by the root
> port.
> Add two properties so that the translation tables in the root port's
> bridge layer can be configured to account for the translation done by
> the FPGA fabric.

I'm skeptical that ranges/dma-ranges can't handle what you need.
Anything in this area is going to need justification 'ranges doesn't
work because x, y, z...'.

>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
> ---
>  .../bindings/pci/microchip,pcie-host.yaml     | 107 ++++++++++++++++++
>  1 file changed, 107 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml b/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
> index 23d95c65acff..29bb1fe99a2e 100644
> --- a/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
> +++ b/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
> @@ -71,6 +71,113 @@ properties:
>      minItems: 1
>      maxItems: 6
>
> +  microchip,outbound-fabric-translation-ranges:
> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> +    minItems: 1
> +    maxItems: 32
> +    description: |
> +      The CPU-to-PCIe (outbound) address translation takes place in two stages.
> +      Depending on the FPGA bitstream, the outbound address translation tables
> +      in the PCIe root port's bridge layer will need to be configured to account
> +      for only its part of the overall outbound address translation.
> +
> +      The first stage of outbound address translation occurs between the CPU address
> +      and an intermediate "FPGA address". The second stage of outbound address
> +      translation occurs between this FPGA address and the PCIe address. Use this
> +      property, in conjunction with the ranges property, to divide the overall
> +      address translation into these two stages so that the PCIe address
> +      translation tables can be correctly configured.

Sounds like you need 2 levels of ranges/dma-ranges.

/ {
    fpga-bus {
        ranges = ...
        dma-ranges = ...
        pcie@... {
            ranges = ...
            dma-ranges = ...
        };
    };
};

> +
> +      If this property is present, one entry is required per range. This is so
> +      FPGA designers can choose to route different address ranges through different
> +      Fabric Interface Controllers and other logic as they see fit.
> +
> +      If this property is not present, the entire address translation
> +      in any ranges property is attempted by the root port driver via its outbound
> +      address translation tables.
> +
> +      Each element in this property has three components. The first is a
> +      PCIe address, the second is an FPGA address, and the third is a size.
> +      These properties may be 32 or 64 bit values.
> +
> +      In operation, the driver will expect a one-to-one correspondance between
> +      range properties and this property.  For each pair of range and
> +      outbound-fabric-translation-range properties, the root port driver will
> +      subtract the FPGA address in this property from the CPU address in the
> +      corresponding range property and use the remainder to program its
> +      outbound address translation tables.
> +
> +      For each range, take its PCIe address and size - these are the PCIe
> +      address & size for the element. The FPGA address is derived from a given
> +      FPGA fabric design and is the address delivered by that FPGA fabric
> +      design to the Core Complex. For a trivial configuration, it is likely to be the
> +      lower 32 bits of the PCIe address in the range property and the upper
> +      bits of the base address of the Fabric Interface Controller the design uses.
> +      Otherwise, it is tightly coupled with the data path configured in the
> +      FPGA fabric between the root port and the Core Complex.
> +
> +      For more information on the tables, see Section 1.3.3,
> +      "PCIe/AXI4 Address Translation" of the PolarFire SoC PCIe User Guide:
> +      https://www.microsemi.com/document-portal/doc_download/1245812-polarfire-fpga-and-polarfire-soc-fpga-pci-express-user-guide
> +
> +    items:
> +      minItems: 3
> +      maxItems: 6
> +
> +  microchip,inbound-fabric-translation-ranges:
> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> +    minItems: 1
> +    maxItems: 32
> +    description: |
> +      The PCIe-to-CPU (inbound) address translation takes place in two stages.
> +      Depending on the FPGA bitstream, the inbound address translation tables
> +      in the PCIe root port's bridge layer will need to be configured to account
> +      for only its part of the overall inbound address translation.
> +
> +      The first stage of address translation occurs between the PCIe address and
> +      an intermediate FPGA address. The second stage of address translation
> +      occurs between the FPGA address and the CPU address. Use this property
> +      in conjunction with the dma-ranges property to divide the address
> +      translation into these two stages.
> +
> +      If this property is present, one entry is required per dma-range. This is so
> +      FPGA designers can choose to route different address ranges through different
> +      Fabric Interface Controllers and other logic as they see fit.
> +
> +      If this property is not present, the entire address translation
> +      in any dma-ranges property is attempted by the root port driver via its
> +      inbound address translation tables.
> +
> +      Each element in this property has three components. The first is a
> +      PCIe address, the second is an FPGA address, and the third is a size.
> +      These properties may be 32 or 64 bit values.
> +
> +      In operation, the driver will expect a one-to-one correspondance between
> +      dma-range properties and this property.  For each pair of dma-range and
> +      inbound-fabric-translation-range properties, the root port driver will
> +      subtract the FPGA address in this property from the CPU address in the
> +      corresponding dma-range property and use the remainder to program its
> +      inbound address translation tables.
> +
> +      From each dma-range, take its PCIe address and size - these are the PCIe
> +      address & size for the element. The FPGA address is derived from a given
> +      FPGA fabric design and is the address delivered by that FPGA fabric
> +      design to the Core Complex. For a trivial configuration, this property
> +      is unlikely to be required (i.e. no fabric translation on the inbound
> +      interface).  Otherwise, it is tightly coupled with the inbound data path
> +      configured in the FPGA fabric between the root port and the Core Complex.
> +      It is expected that more than one translation range may be added to
> +      an FPGA fabric design, e.g. to deliver data to cached or non-cached
> +      DDR.
> +
> +      For more information on the tables, see Section 1.3.3,
> +      "PCIe/AXI4 Address Translation" of the PolarFire SoC PCIe User Guide:
> +      https://www.microsemi.com/document-portal/doc_download/1245812-polarfire-fpga-and-polarfire-soc-fpga-pci-express-user-guide
> +
> +    items:
> +      minItems: 4
> +      maxItems: 7
> +
>    msi-controller:
>      description: Identifies the node as an MSI controller.
>
> --
> 2.25.1
>
