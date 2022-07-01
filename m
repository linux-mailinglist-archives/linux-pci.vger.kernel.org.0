Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10C7056365A
	for <lists+linux-pci@lfdr.de>; Fri,  1 Jul 2022 17:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbiGAO7n (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Jul 2022 10:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbiGAO7k (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Jul 2022 10:59:40 -0400
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41F4201BD;
        Fri,  1 Jul 2022 07:59:38 -0700 (PDT)
Received: by mail-io1-f52.google.com with SMTP id v185so2480356ioe.11;
        Fri, 01 Jul 2022 07:59:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xu+P4Q62nutzZf+Rl9lZfw5Oy5BYC9vJtwWW2G8JMtI=;
        b=xQCK2fOz+4oQP96aimGF2wUWb/AyfOmSBATXvgMUi5pKoakNQumHbPlZfrNdjmYZ3K
         eEX2J2Ejeal/PFPQ4chWYschGJQuCI5ap1rFm1JMd+wN+9pvMhuFamMUc/gMwkKnJ50b
         kdHYGfI1orvfn2cYEaSTuEdSq5njH/LNoBWBn/neQ1OQ+16buiR2raoaTlshwxgSoBod
         gCV/ykUAFu4uCw+JG/tbt/XfbxFOpaP5VaoDzOC1TTGgVFpk08EMEK/EBtr1NLM0DG8w
         szMfAFipVtq32lQEvwPWTftbVbV6qswPmbH35miMUVRWhvU+XeW2S2CXlED82y2kOsx/
         Hj0A==
X-Gm-Message-State: AJIora+CwGCFXbkcsQuDQPA9zGbb7kJl7zCzQCI4Njh9KAMK+Pzx9a2n
        5wNwiJICuGZO+0k4eFJv6g==
X-Google-Smtp-Source: AGRyM1sE4L+XsTva9NAy1+DPv+2HN9dza8pwRbxDFitxEyhLGS6h/MwZ6PxwrZp5ckfa5Lyu5uczoQ==
X-Received: by 2002:a05:6638:138f:b0:33c:b862:7f45 with SMTP id w15-20020a056638138f00b0033cb8627f45mr9091773jad.36.1656687576129;
        Fri, 01 Jul 2022 07:59:36 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id x13-20020a026f0d000000b0033e9caf8f9csm860948jab.43.2022.07.01.07.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 07:59:35 -0700 (PDT)
Received: (nullmailer pid 929152 invoked by uid 1000);
        Fri, 01 Jul 2022 14:59:33 -0000
Date:   Fri, 1 Jul 2022 08:59:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <fancer.lancer@gmail.com>
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
Message-ID: <20220701145933.GB804716-robh@kernel.org>
References: <20220610085706.15741-1-Sergey.Semin@baikalelectronics.ru>
 <20220610085706.15741-13-Sergey.Semin@baikalelectronics.ru>
 <20220615163712.GA1400328-robh@kernel.org>
 <20220619200355.zuixe3hqebpif4kv@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220619200355.zuixe3hqebpif4kv@mobilestation>
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

Ah, right. However, we generally haven't done this elsewhere and you 
aren't special.

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

Experience has shown these are not useful. Drop it. Anything in the PCI 
core would probably use the RP VID/PID.

Furthermore, there is no guarantee that you won't match and bind to the 
dw_plat_pcie_driver instead. The kernel has no mechanism to bind to the 
best match (which is further complicated with modules).


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

Tell me why you need random order.


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

If that's what the h/w has...

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

Yes, and that means don't use in new users.

> Can't I still use them here to signify the number of iATU windows?

No.

Rob
