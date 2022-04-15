Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D40B502FBB
	for <lists+linux-pci@lfdr.de>; Fri, 15 Apr 2022 22:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352120AbiDOUZD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Apr 2022 16:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351984AbiDOUZC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Apr 2022 16:25:02 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 971E1DCE03;
        Fri, 15 Apr 2022 13:22:32 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id bn33so10537295ljb.6;
        Fri, 15 Apr 2022 13:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sHIVtALfyJ80+cLs2FBf7tRjXDYT52TNO4pbMd+Okr0=;
        b=CTadgWcPRBxJkDslympuQMZSLjrSGEASJZigyfidacBChnqJI8WlghQteaAP9dBwOt
         vfmQexD02KQ2rnHlV1+vUkiByFsgh9ZsoDVUUUW7ZPNGC1v9GVtcqeRl0+jp/VfS1r9r
         UljB1lxgvLcELsLm47a8pQ/tt11o64bw8xCUGWDN/yWsWmWIwAyD4A52N7llooOOEc10
         rsJZfFgAGfjErvXDmspHgrMCrIGqMQliBXPWdXJI6jrAq/6eGG73iun9WYl5cE+5Qnig
         dhnnlABqy3+dPeZX1Y+ongr+L0n6+qT8KzYt4wWxe5XuIl8TLMMach2PeVETg09CePzQ
         B0Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sHIVtALfyJ80+cLs2FBf7tRjXDYT52TNO4pbMd+Okr0=;
        b=0aNLT0B/Va9NZ0MwdKqRsq/2fbkgnKbz4JRu/O7ljtKqbC1ORRDMqRUH+425ss27M5
         uefOH6EHfevvLP2SbPzT70LMM1sfKZc8QKb2eLsrBeyLKhc79RmjQkus0l46hvw+HLtx
         DyZziRnTkmTe5t5RpNzrjRHGMfk9cOrFAb1Kqot7xmdptVh5vp9Bb6gFmp9asPobwnkG
         1ATx3ZnoVMqVMEiNqYuUaqE92jKRIOFEOKo0lA2bkVQ0OJk2kZjObXsIMOxrCHOV9jB9
         7vTeN9urNTgRYF/uoYSZzQD0fEuR3MLMmKG8uqbzvquiT4IL0P0RHcQGVeCChBkLcoSl
         x5NA==
X-Gm-Message-State: AOAM532rL8gmW7ism9c/LYxQbJhUUuZaiBM4YrLkhWlc4t6yBpVHLYmE
        3FQdGTo5acAXRp49R8eRlAo=
X-Google-Smtp-Source: ABdhPJx/PmAunYu02iwEZBI9EZLbg1PMv/qV5q5HkG/UCxVx/kLpqzhl8EcIMLoR0rlFqET9eP+sHg==
X-Received: by 2002:a05:651c:992:b0:24b:99c:35c with SMTP id b18-20020a05651c099200b0024b099c035cmr436161ljq.142.1650054150646;
        Fri, 15 Apr 2022 13:22:30 -0700 (PDT)
Received: from mobilestation ([95.79.134.149])
        by smtp.gmail.com with ESMTPSA id s1-20020ac24641000000b0046d10a0bba2sm441198lfo.176.2022.04.15.13.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 13:22:29 -0700 (PDT)
Date:   Fri, 15 Apr 2022 23:22:27 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
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
Message-ID: <20220415202227.ywsezgc7mslcv5wq@mobilestation>
References: <20220324013734.18234-1-Sergey.Semin@baikalelectronics.ru>
 <20220324013734.18234-3-Sergey.Semin@baikalelectronics.ru>
 <YkJCo1PrdKlHYt8D@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkJCo1PrdKlHYt8D@robh.at.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 28, 2022 at 06:20:03PM -0500, Rob Herring wrote:
> On Thu, Mar 24, 2022 at 04:37:20AM +0300, Serge Semin wrote:
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
> > Rob, this DT-bindings most likely will fail the dt_bindings_check
> > evaluations with the "'*' is not of type 'array'" errors for the same
> > reason described in the previous patch. Let's discuss the problem there.
> > ---
> >  .../bindings/pci/baikal,bt1-pcie.yaml         | 148 ++++++++++++++++++
> >  1 file changed, 148 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pci/baikal,bt1-pcie.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/baikal,bt1-pcie.yaml b/Documentation/devicetree/bindings/pci/baikal,bt1-pcie.yaml
> > new file mode 100644
> > index 000000000000..f34438330a86
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/baikal,bt1-pcie.yaml
> > @@ -0,0 +1,148 @@
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
> > +description: |
> > +  Embedded into Baikal-T1 SoC Root Complex controller. It's based on the
> > +  DWC RC PCIe v4.60a IP-core, which is configured to have just a single Root
> > +  Port function and is capable of establishing the link up to Gen.3 speed
> > +  on x4 lanes. It doesn't have embedded clock and reset control module, so
> > +  the proper interface initialization is supposed to be performed by software.
> > +
> > +allOf:
> > +  - $ref: /schemas/pci/pci-bus.yaml#
> > +  - $ref: snps,dw-pcie.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    contains:
> > +      const: baikal,bt1-pcie
> > +
> > +  reg:
> > +    description:
> > +      DBI, DBI2 and at least 4KB outbound iATU-capable region are available.
> 

> outbound iATU-capable region? While configured with iATU, it's just 
> config space from a binding standpoint.

In this particular device the config-space is supposed to be mapped
over the outbound iATU region. It's a MMIO region mapped to the Source
side of the outbound iATU interface.

> 
> It's a bit more precise to do this:
> 
> items:
>   - description: DBI...
>   - description: DBI2...
>   - ...

I know, but I prefer using the reg-names property for that, while
having the 'reg' property with minItems/maxItems constraints specified.
In this case the reg property would be left unordered.

> 
> 
> > +    maxItems: 3
> 
> And then drop this.
> 
> > +
> > +  reg-names:
> > +    minItems: 3
> > +    maxItems: 3
> > +    items:
> > +      enum: [ dbi, dbi2, config ]
> 

> To enforce the order:
> 
> items:
>   - const: dbi
>   - const: dbi2
>   - const: config

Could you please explain why do you always suggest to define the ordered
X/X-names properties group? I just don't see much benefits in such
approach except that it's a bit more readable and one line shorter.

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
> 

> Can't you define the order?

Please, see my question in the previous comment.

> 
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
> 

> Again, define the order.

Could you tell me why it's better than unordered property? Really I
don't see good reason enough to define more constraints than required.

> 
> > +
> > +  syscon:
> 

> Needs a vendor prefix.

Ok.

> 
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

> These are deprecated. The driver probes for how many now.

I know that they are deprecated. But they are deprecated on the DT
node level, not in the DT schema. Here by explicitly defining these
properties I signify that there are four in- and outbound iATU
windows. Doesn't that better describe our hardware?

-Sergey

> 
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - reg-names
> > +  - interrupts
> > +  - interrupt-names
> > +  - clocks
> > +  - clock-names
> > +  - resets
> > +  - reset-names
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
