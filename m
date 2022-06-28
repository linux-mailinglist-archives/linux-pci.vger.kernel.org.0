Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6457F55DFC2
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jun 2022 15:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345484AbiF1MUE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jun 2022 08:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbiF1MUD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jun 2022 08:20:03 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C63A1D0D1;
        Tue, 28 Jun 2022 05:20:02 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id i18so21939577lfu.8;
        Tue, 28 Jun 2022 05:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MVzgUGxdhgem/6VaBvLoYmVpdRnW/LkWA6EcAAYvS3A=;
        b=mHSZFx9Rl0emaEhg2qXFWI0s/dZuSL5F86yqhQ9wUFOz3mLCbPAX275Mp8mjLsfPws
         n4oMhwGrA8MXRO1CEkq2N2HV8Goczm9TmMOzfG9OsrKJpe3nyqAD1+uooDvkyyUONxAg
         N2b7S5hUEDhNzYwdEbAiAA0I610ZyhbL1qhjFcsUNB2iD5LnOuQcp107fX+tW2OZki10
         DxPke2euRluKJnjA1BNb8M1UjudIkyPFmogfv71KzO6GB7E3TvrD/1Hv1zewrlNQi2qJ
         2N2cYEvumaWPTmVOWFHNelLqVTm4xSCTqM2QzDm4PXnIyMrm3FFXM/qxvn/HoIqOLwY/
         At1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MVzgUGxdhgem/6VaBvLoYmVpdRnW/LkWA6EcAAYvS3A=;
        b=GCpS38P+c7W99ZOUH7nUD/4S8fOZurkrlfuOEKBKcfQjJUxO4QHkWfkUmTL/7U6Rsr
         i4mwj3n7MKA0EEjW0cUE2gkOKPHOaF69X0VgVn/r68/FAtYvlVu08mKT8x3PCNMmjHwX
         ztBQqJDcQBLhyRtM07KB8szMehBGAAYLUH0+06QAdPU51O9Pm5pO4VRZ6fC6emRqv3xP
         eRaROzlHsM++kWOXfJn9GTpFoRk8TST+3n2Dj2ohIuC3fJ7d8OKmItmzu+sFIzQHEncy
         LG7hbJnyvWy+kkjK5QDQNAQ59smmvcXHjVgZ2OaP5xke2Eg8dofpkMXEr/DEpaYg+2xB
         iidg==
X-Gm-Message-State: AJIora/3pbd++3IVhnN8IUCYEfW8/Rlxs8AkEQwr6zlNs/YeCbM+BoIV
        qNZnD5rUYSEPvl+IkBdUrS4=
X-Google-Smtp-Source: AGRyM1tJI7E5B+LFtRN0Gxm7YtSBUrPmXSjDeZIhzEbiotIykgoE+xQGuSQRzw8A2xTB076W2EpDyQ==
X-Received: by 2002:a05:6512:2508:b0:480:f1cb:64a5 with SMTP id be8-20020a056512250800b00480f1cb64a5mr11885619lfb.0.1656418800372;
        Tue, 28 Jun 2022 05:20:00 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id j14-20020a2e850e000000b0025a6e20abe9sm1767718lji.130.2022.06.28.05.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 05:19:59 -0700 (PDT)
Date:   Tue, 28 Jun 2022 15:19:57 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 12/17] dt-bindings: PCI: dwc: Add Baikal-T1 PCIe Root
 Port bindings
Message-ID: <20220628121957.76wz5mofqizugwn6@mobilestation>
References: <20220610085706.15741-1-Sergey.Semin@baikalelectronics.ru>
 <20220610085706.15741-13-Sergey.Semin@baikalelectronics.ru>
 <20220615163712.GA1400328-robh@kernel.org>
 <20220619200355.zuixe3hqebpif4kv@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220619200355.zuixe3hqebpif4kv@mobilestation>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Rob,
Could you please get your attention back to this this thread?

-Sergey

On Sun, Jun 19, 2022 at 11:03:55PM +0300, Serge Semin wrote:
> On Wed, Jun 15, 2022 at 10:37:12AM -0600, Rob Herring wrote:
> > On Fri, Jun 10, 2022 at 11:57:00AM +0300, Serge Semin wrote:
> > > Baikal-T1 SoC is equipped with DWC PCIe v4.60a Root Port controller, which
> > > link can be trained to work on up to Gen.3 speed over up to x4 lanes. The
> > > controller is supposed to be fed up with four clock sources: DBI
> > > peripheral clock, AXI application Tx/Rx clocks and external PHY/core
> > > reference clock generating the 100MHz signal. In addition to that the
> > > platform provide a way to reset each part of the controller:
> > > sticky/non-sticky bits, host controller core, PIPE interface, PCS/PHY and
> > > Hot/Power reset signal. The Root Port controller is equipped with multiple
> > > IRQ lines like MSI, system AER, PME, HP, Bandwidth change, Link
> > > equalization request and eDMA ones. The registers space is accessed over
> > > the DBI interface. There can be no more than four inbound or outbound iATU
> > > windows configured.
> > > 
> > > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > > 
> > > ---
> > > 
> > > Changelog v2:
> > > - Rename 'syscon' property to 'baikal,bt1-syscon'.
> > > - Fix the 'compatible' property definition to being more specific about
> > >   what strings are supposed to be used. Due to that we had to add the
> > >   select property to evaluate the schema against the Baikal-T1 PCIe DT
> > >   nodes only.
> > > ---
> > >  .../bindings/pci/baikal,bt1-pcie.yaml         | 154 ++++++++++++++++++
> > >  1 file changed, 154 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/pci/baikal,bt1-pcie.yaml
> > > 
> > > diff --git a/Documentation/devicetree/bindings/pci/baikal,bt1-pcie.yaml b/Documentation/devicetree/bindings/pci/baikal,bt1-pcie.yaml
> > > new file mode 100644
> > > index 000000000000..23bd1d0aa5c5
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/pci/baikal,bt1-pcie.yaml
> > > @@ -0,0 +1,154 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/pci/baikal,bt1-pcie.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Baikal-T1 PCIe Root Port Controller
> > > +
> > > +maintainers:
> > > +  - Serge Semin <fancer.lancer@gmail.com>
> > > +
> > > +description:
> > > +  Embedded into Baikal-T1 SoC Root Complex controller. It's based on the
> > > +  DWC RC PCIe v4.60a IP-core, which is configured to have just a single Root
> > > +  Port function and is capable of establishing the link up to Gen.3 speed
> > > +  on x4 lanes. It doesn't have embedded clock and reset control module, so
> > > +  the proper interface initialization is supposed to be performed by software.
> > > +
> > > +select:
> > > +  properties:
> > > +    compatible:
> > > +      contains:
> > > +        const: baikal,bt1-pcie
> > > +
> > > +  required:
> > > +    - compatible
> > > +
> > > +allOf:
> > > +  - $ref: /schemas/pci/snps,dw-pcie.yaml#
> > > +
> > > +properties:
> > > +  compatible:
> > > +    items:
> > > +      - const: baikal,bt1-pcie
> > > +      - const: snps,dw-pcie-4.60a
> > 
> 
> > Pointless, you can read the version.
> 
> The IP-core version CSR was first introduced in v4.70a. So by using
> the version-based compatible string I advertise the actual IP-core
> version.
> 
> > 
> > > +      - const: snps,dw-pcie
> > 
> 
> > Pointless, because what can you do with this by itself?
> 
> In general many things. For instance implement some IP-core specific
> quirks in the generic part of the PCIe subsystem, visually identify
> the device origin, etc.
> 
> > 
> > > +
> > > +  reg:
> > > +    description:
> > > +      DBI, DBI2 and at least 4KB outbound iATU-capable region.
> > > +    maxItems: 3
> > > +
> > > +  reg-names:
> > > +    minItems: 3
> > > +    maxItems: 3
> > > +    items:
> > > +      enum: [ dbi, dbi2, config ]
> > 
> 
> > This should define the order.
> 
> Please, tell me why do you persist in the items being ordered? The
> driver permits the relaxed order of the resources. Thus there is no
> much need in such constraint. At least I can't find any.
> 
> > 
> > > +
> > > +  interrupts:
> > > +    description:
> > > +      MSI, AER, PME, Hot-plug, Link Bandwidth Management, Link Equalization
> > > +      request and eight Read/Write eDMA IRQ lines are available.
> > > +    maxItems: 14
> > > +
> > > +  interrupt-names:
> > > +    minItems: 14
> > > +    maxItems: 14
> > > +    items:
> > > +      oneOf:
> > > +        - pattern: '^dma[0-7]$'
> > > +        - enum: [ msi, aer, pme, hp, bw_mg, l_eq ]
> > 
> 
> > Define the order.
> 
> Fourteen IRQs? dma0, dma1, dma2, ..., msi, aer, ..., l_eq?
> 
> > 
> > > +
> > > +  clocks:
> > > +    description:
> > > +      DBI (attached to the APB bus), AXI-bus master and slave interfaces
> > > +      are fed up by the dedicated application clocks. A common reference
> > > +      clock signal is supposed to be attached to the corresponding Ref-pad
> > > +      of the SoC. It will be redistributed amongst the controller core
> > > +      sub-modules (pipe, core, aux, etc).
> > > +    minItems: 4
> > > +    maxItems: 4
> > > +
> > > +  clock-names:
> > > +    minItems: 4
> > > +    maxItems: 4
> > > +    items:
> > > +      enum: [ dbi, mstr, slv, ref ]
> > > +
> > > +  resets:
> > > +    description:
> > > +      A comprehensive controller reset logic is supposed to be implemented
> > > +      by software, so almost all the possible application and core reset
> > > +      signals are exposed via the system CCU module.
> > > +    minItems: 9
> > > +    maxItems: 9
> > > +
> > > +  reset-names:
> > > +    minItems: 9
> > > +    maxItems: 9
> > > +    items:
> > > +      enum: [ mstr, slv, pwr, hot, phy, core, pipe, sticky, non-sticky ]
> > > +
> > > +  baikal,bt1-syscon:
> > > +    $ref: /schemas/types.yaml#/definitions/phandle
> > > +    description:
> > > +      Phandle to the Baikal-T1 System Controller DT node. It's required to
> > > +      access some additional PM, Reset-related and LTSSM signals.
> > > +
> > > +  num-lanes:
> > > +    maximum: 4
> > > +
> > > +  max-link-speed:
> > > +    maximum: 3
> > > +
> > 
> 
> > > +  num-ob-windows:
> > > +    const: 4
> > > +
> > > +  num-ib-windows:
> > > +    const: 4
> > 
> > Remove these. They are deprecated and shouldn't be in new bindings.
> 
> Aren't they deprecated in the framework of the DT nodes only?
> Can't I still use them here to signify the number of iATU windows?
> 
> -Sergey
> 
> > 
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - reg-names
> > > +  - interrupts
> > > +  - interrupt-names
> > > +
> > > +unevaluatedProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    pcie@1f052000 {
> > > +      compatible = "baikal,bt1-pcie", "snps,dw-pcie-4.60a", "snps,dw-pcie";
> > > +      device_type = "pci";
> > > +      reg = <0x1f052000 0x1000>, <0x1f053000 0x1000>, <0x1bdbf000 0x1000>;
> > > +      reg-names = "dbi", "dbi2", "config";
> > > +      #address-cells = <3>;
> > > +      #size-cells = <2>;
> > > +      ranges = <0x81000000 0 0x00000000 0x1bdb0000 0 0x00008000>,
> > > +               <0x82000000 0 0x20000000 0x08000000 0 0x13db0000>;
> > > +      bus-range = <0x0 0xff>;
> > > +
> > > +      interrupts = <0 80 4>, <0 81 4>, <0 82 4>, <0 83 4>,
> > > +                   <0 84 4>, <0 85 4>, <0 86 4>, <0 87 4>,
> > > +                   <0 88 4>, <0 89 4>, <0 90 4>, <0 91 4>,
> > > +                   <0 92 4>, <0 93 4>;
> > > +      interrupt-names = "dma0", "dma1", "dma2", "dma3", "dma4", "dma5", "dma6",
> > > +                        "dma7", "msi", "aer", "pme", "hp", "bw_mg", "l_eq";
> > > +
> > > +      clocks = <&ccu_sys 1>, <&ccu_axi 6>, <&ccu_axi 7>, <&clk_pcie>;
> > > +      clock-names = "dbi", "mstr", "slv", "ref";
> > > +
> > > +      resets = <&ccu_axi 6>, <&ccu_axi 7>, <&ccu_sys 7>, <&ccu_sys 10>,
> > > +               <&ccu_sys 4>, <&ccu_sys 6>, <&ccu_sys 5>, <&ccu_sys 8>,
> > > +               <&ccu_sys 9>;
> > > +      reset-names = "mstr", "slv", "pwr", "hot", "phy", "core", "pipe",
> > > +                    "sticky", "non-sticky";
> > > +
> > > +      reset-gpios = <&port0 0 1>;
> > > +
> > > +      num-lanes = <4>;
> > > +      max-link-speed = <3>;
> > > +    };
> > > +...
> > > -- 
> > > 2.35.1
> > > 
> > > 
