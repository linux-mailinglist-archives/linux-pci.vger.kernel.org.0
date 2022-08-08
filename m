Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 793CF58CBC2
	for <lists+linux-pci@lfdr.de>; Mon,  8 Aug 2022 18:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236560AbiHHQB3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Aug 2022 12:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234936AbiHHQB1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Aug 2022 12:01:27 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF83662C9;
        Mon,  8 Aug 2022 09:01:23 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id t1so13324156lft.8;
        Mon, 08 Aug 2022 09:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=KCdKLyqTlG066ZeCv0sxUfnd7G76kitH0w8aoKTryoM=;
        b=jp0qgnDUPI7BW5eHgw72FGK682EZRUuUuW+EgnR3wMILOf2hpllet+t1y4BHGhQV1T
         Vr5jnVYAghQBtgmos3IgDJnj8SmHIxCROLE9EaNToL/rSQ6eeK+2d5QnoMBLy/JSnUiv
         YeIlheY/NIbVIAWZlYgh8uzq15wP4Of6PYYqjPkMex0sd+ESJO0d1pnVNBJHz5iWsGxA
         OzU9NwlrWR/YJapZyyKgl2TI4l9L4DnycujDrarW2XgXiGxsMuiVPv6bCqqZvPnzuW6a
         mQIDPHw9q8F2Lyut07DSu5y/IUICkZ01B62KNxuwCytS6H4VTB7IKScbh2GDPgddR9pd
         t1ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=KCdKLyqTlG066ZeCv0sxUfnd7G76kitH0w8aoKTryoM=;
        b=pb69KXaMKauvZbExQ+kJ+QbVHRf+KUwNZnnVQhMtpwV1ku3+0iBHsVW3LlhFaQzhdJ
         FRcqnU4q3Dj0reeTESUyx/HylxUxNoxcFcLE6pNqnTu+jb0cAZehRJ89YvBkTQEbjwYi
         9bfrB4ILJ2JVax/hTrqMIs1s/8g5vOwYBL3w8WczI63oMsMu2s9rWXpuVqmGVlxLe1G4
         EFMgh5XHJZDPGhHPejrZEkABrgvdVmstcNA0Ptqc7tUg89oLhhDaiGb5PGBMHooNAZl0
         pb2gXbs2RhSnhztqGdubai6+6QAIOLK71atlwTlZXe/X4GQQ9+JsJfMj6umDT0LUyKlM
         pqYQ==
X-Gm-Message-State: ACgBeo1EzVkzJrwRj6r1ZlNzn4vZVW7NrvmiEw4Z72X5hzlMU99t2sjZ
        +vxcmfD6gqclpMvjNfYHaeJ6GnRZ3VgjwQ==
X-Google-Smtp-Source: AA6agR5FDKBtyrihHH2mVl6B3sl2LWGnk1HLM3d2mWjViKW6hmPuwo4lBEvsQ8Y0fEAT8uZT6YhkRg==
X-Received: by 2002:a05:6512:22d3:b0:48c:df73:d0a4 with SMTP id g19-20020a05651222d300b0048cdf73d0a4mr2471990lfu.584.1659974481912;
        Mon, 08 Aug 2022 09:01:21 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id a10-20020a2eb54a000000b0025e4d1197bdsm1396484ljn.124.2022.08.08.09.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 09:01:21 -0700 (PDT)
Date:   Mon, 8 Aug 2022 19:01:18 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 12/17] dt-bindings: PCI: dwc: Add Baikal-T1 PCIe Root
 Port bindings
Message-ID: <20220808160118.m5ka7o7gdhei2yzl@mobilestation>
References: <20220728143427.13617-1-Sergey.Semin@baikalelectronics.ru>
 <20220728143427.13617-13-Sergey.Semin@baikalelectronics.ru>
 <20220801181311.GA1266390-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801181311.GA1266390-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 01, 2022 at 12:13:11PM -0600, Rob Herring wrote:
> On Thu, Jul 28, 2022 at 05:34:22PM +0300, Serge Semin wrote:
> > Baikal-T1 SoC is equipped with DWC PCIe v4.60a Root Port controller, which
> > link can be trained to work on up to Gen.3 speed over up to x4 lanes. The
> > controller is supposed to be fed up with four clock sources: DBI
> > peripheral clock, AXI application Tx/Rx clocks and external PHY/core
> > reference clock generating the 100MHz signal. In addition to that the
> > platform provide a way to reset each part of the controller:
> > sticky/non-sticky bits, host controller core, PIPE interface, PCS/PHY and
> > Hot/Power reset signal. The Root Port controller is equipped with multiple
> > IRQ lines like MSI, system AER, PME, HP, Bandwidth change, Link
> > equalization request and eDMA ones. The registers space is accessed over
> > the DBI interface. There can be no more than four inbound or outbound iATU
> > windows configured.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > 
> > ---
> > 
> > Changelog v2:
> > - Rename 'syscon' property to 'baikal,bt1-syscon'.
> > - Fix the 'compatible' property definition to being more specific about
> >   what strings are supposed to be used. Due to that we had to add the
> >   select property to evaluate the schema against the Baikal-T1 PCIe DT
> >   nodes only.
> > ---
> >  .../bindings/pci/baikal,bt1-pcie.yaml         | 154 ++++++++++++++++++
> >  1 file changed, 154 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pci/baikal,bt1-pcie.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/baikal,bt1-pcie.yaml b/Documentation/devicetree/bindings/pci/baikal,bt1-pcie.yaml
> > new file mode 100644
> > index 000000000000..23bd1d0aa5c5
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/baikal,bt1-pcie.yaml
> > @@ -0,0 +1,154 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/pci/baikal,bt1-pcie.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Baikal-T1 PCIe Root Port Controller
> > +
> > +maintainers:
> > +  - Serge Semin <fancer.lancer@gmail.com>
> > +
> > +description:
> > +  Embedded into Baikal-T1 SoC Root Complex controller. It's based on the
> > +  DWC RC PCIe v4.60a IP-core, which is configured to have just a single Root
> > +  Port function and is capable of establishing the link up to Gen.3 speed
> > +  on x4 lanes. It doesn't have embedded clock and reset control module, so
> > +  the proper interface initialization is supposed to be performed by software.
> > +
> > +select:
> > +  properties:
> > +    compatible:
> > +      contains:
> > +        const: baikal,bt1-pcie
> > +
> > +  required:
> > +    - compatible
> > +
> > +allOf:
> > +  - $ref: /schemas/pci/snps,dw-pcie.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - const: baikal,bt1-pcie
> > +      - const: snps,dw-pcie-4.60a
> > +      - const: snps,dw-pcie
> 

> Again, these fallbacks simply aren't useful.

Ok. I give up. You are the boss. I'll drop them =)

> 
> > +
> > +  reg:
> > +    description:
> > +      DBI, DBI2 and at least 4KB outbound iATU-capable region.
> 

> 'iATU-capable region' means config space? That's not very clear.

No 'iATU-capable region' means the region, which can be used as a
source address for the iATU engine. In general it can be used for any
accesses (IO, MEM, CFG). But the DW PCIe driver will indeed use it for
the config-space accesses.

IMO the 'config' reg space is kind of virtual. Due to the outbound
iATU capability the driver could use any free outbound iATU region it
found instead.

> 
> > +    maxItems: 3
> > +
> > +  reg-names:
> > +    minItems: 3
> > +    maxItems: 3
> > +    items:
> > +      enum: [ dbi, dbi2, config ]
> 

> Define the order. Here, and the rest.

Ok. I will, but please answer to my question, I asked you in the
previous email thread:

Serge Semin wrote:
> Rob Herring wrote:
> > ...
> > Tell me why you need random order.
>
> Because I don't see a need in constraining the order. If we get to set
> the order requirement, then why do we need to have the "*-names"
> property at all?
> IMO having "reg" with max/minItems restriction plus generic
> description and "reg-names" with possible values enumerated seems very
> suitable pattern in this case. Don't you think?

In addition to that what about optional names? How would you suggest
to handle such case without the non-ordered pattern?

> 
> > +
> > +  interrupts:
> > +    description:
> > +      MSI, AER, PME, Hot-plug, Link Bandwidth Management, Link Equalization
> > +      request and eight Read/Write eDMA IRQ lines are available.
> > +    maxItems: 14
> > +
> > +  interrupt-names:
> > +    minItems: 14
> > +    maxItems: 14
> > +    items:
> > +      oneOf:
> > +        - pattern: '^dma[0-7]$'
> > +        - enum: [ msi, aer, pme, hp, bw_mg, l_eq ]
> > +
> > +  clocks:
> > +    description:
> > +      DBI (attached to the APB bus), AXI-bus master and slave interfaces
> > +      are fed up by the dedicated application clocks. A common reference
> > +      clock signal is supposed to be attached to the corresponding Ref-pad
> > +      of the SoC. It will be redistributed amongst the controller core
> > +      sub-modules (pipe, core, aux, etc).
> > +    minItems: 4
> > +    maxItems: 4
> > +
> > +  clock-names:
> > +    minItems: 4
> > +    maxItems: 4
> > +    items:
> > +      enum: [ dbi, mstr, slv, ref ]
> > +
> > +  resets:
> > +    description:
> > +      A comprehensive controller reset logic is supposed to be implemented
> > +      by software, so almost all the possible application and core reset
> > +      signals are exposed via the system CCU module.
> > +    minItems: 9
> > +    maxItems: 9
> > +
> > +  reset-names:
> > +    minItems: 9
> > +    maxItems: 9
> > +    items:
> > +      enum: [ mstr, slv, pwr, hot, phy, core, pipe, sticky, non-sticky ]
> > +
> > +  baikal,bt1-syscon:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description:
> > +      Phandle to the Baikal-T1 System Controller DT node. It's required to
> > +      access some additional PM, Reset-related and LTSSM signals.
> > +
> > +  num-lanes:
> > +    maximum: 4
> > +
> > +  max-link-speed:
> > +    maximum: 3
> > +
> 
> > +  num-ob-windows:
> > +    const: 4
> > +
> > +  num-ib-windows:
> > +    const: 4
> 

> These are deprecated. Don't add them for a new binding.

Ok.

-Sergey

> 
> 
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - reg-names
> > +  - interrupts
> > +  - interrupt-names
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    pcie@1f052000 {
> > +      compatible = "baikal,bt1-pcie", "snps,dw-pcie-4.60a", "snps,dw-pcie";
> > +      device_type = "pci";
> > +      reg = <0x1f052000 0x1000>, <0x1f053000 0x1000>, <0x1bdbf000 0x1000>;
> > +      reg-names = "dbi", "dbi2", "config";
> > +      #address-cells = <3>;
> > +      #size-cells = <2>;
> > +      ranges = <0x81000000 0 0x00000000 0x1bdb0000 0 0x00008000>,
> > +               <0x82000000 0 0x20000000 0x08000000 0 0x13db0000>;
> > +      bus-range = <0x0 0xff>;
> > +
> > +      interrupts = <0 80 4>, <0 81 4>, <0 82 4>, <0 83 4>,
> > +                   <0 84 4>, <0 85 4>, <0 86 4>, <0 87 4>,
> > +                   <0 88 4>, <0 89 4>, <0 90 4>, <0 91 4>,
> > +                   <0 92 4>, <0 93 4>;
> > +      interrupt-names = "dma0", "dma1", "dma2", "dma3", "dma4", "dma5", "dma6",
> > +                        "dma7", "msi", "aer", "pme", "hp", "bw_mg", "l_eq";
> > +
> > +      clocks = <&ccu_sys 1>, <&ccu_axi 6>, <&ccu_axi 7>, <&clk_pcie>;
> > +      clock-names = "dbi", "mstr", "slv", "ref";
> > +
> > +      resets = <&ccu_axi 6>, <&ccu_axi 7>, <&ccu_sys 7>, <&ccu_sys 10>,
> > +               <&ccu_sys 4>, <&ccu_sys 6>, <&ccu_sys 5>, <&ccu_sys 8>,
> > +               <&ccu_sys 9>;
> > +      reset-names = "mstr", "slv", "pwr", "hot", "phy", "core", "pipe",
> > +                    "sticky", "non-sticky";
> > +
> > +      reset-gpios = <&port0 0 1>;
> > +
> > +      num-lanes = <4>;
> > +      max-link-speed = <3>;
> > +    };
> > +...
> > -- 
> > 2.35.1
> > 
> > 
