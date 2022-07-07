Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92A5D56ABBD
	for <lists+linux-pci@lfdr.de>; Thu,  7 Jul 2022 21:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236019AbiGGTUA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Jul 2022 15:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236221AbiGGTT7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Jul 2022 15:19:59 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56E811159;
        Thu,  7 Jul 2022 12:19:57 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id f39so32788803lfv.3;
        Thu, 07 Jul 2022 12:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=R/mTei+s1rrYZN+hisGGIikjU30EAyUwl8VC2G6/aAE=;
        b=OsmaE5/5MhoxfJpQh2eDZK9CDDCuK8blIKUwX5YWpCckoNb3PXhKMCH2QoiO3rscy8
         thWbUtoYRfVEqVVuG6qgMyV2mqXkEiKvHfcJwAeHmsht5SYTf+/8mC5/XhkL6mzr5atG
         vjGQzEU3gJGk5xZy2lvh3nd/M5DpbSJubwee/BpWB4y1db+gMFPWQ4CCoIwmhcI0uz25
         lnQ+6e3CH3A883TOYKoYii4KQpzgBjm+rXWYDDclPhjLYyFYCtsZon15q2bHx/OjWtjD
         B8KPYvfkLsv3EyUjw4hgOweniEn25SJRFXnsEy2fDmBfoEb07yFxS719oIth01M7B+BD
         M7FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R/mTei+s1rrYZN+hisGGIikjU30EAyUwl8VC2G6/aAE=;
        b=EYC5T0X+5SnnO4fbjtRMGE0OCV6hXnT9SGq7+tagn1/zWxjfCzs7dacIqNeEu2xc8j
         zpVFQySIm/qqZkM9sQo9D/wGp443WaWkN9tLZ2KW88Y0MlDDTTE504kZONfVt3RId72C
         52rh//t4GbaBXiToGcAqtZqNVzDxBsiCDM9p7dVU0hvH1U9+u6W5urTHsTdAaDoNS0IL
         06asPn/fRZ0jV47sJt9oaaStRSq3jFbukUMd5IpPoVsHcpuH5qYGl33n433TosZUUahf
         tUItpDPQtWLyPE61DWZk+ZTrcgk7DbAqkn0mS83d0UtOKwFoS+haJyyzuca/H9KR0h5h
         F2tA==
X-Gm-Message-State: AJIora8j+IsasMKGhdNrf2DKPTp65XBW6Q9l3t3ntHCMzUpbo9Nqnd9d
        tJuQHSjyB7nOploxvxlrWxc7l5JYVQsRCA==
X-Google-Smtp-Source: AGRyM1sOW5LRZBvXAgSpR2nSg71/k8gzEgy5T/lk0W6o0v/zOTrUfbznk8kK7YjbIK9l2QQZN6ePeA==
X-Received: by 2002:a05:6512:3491:b0:47f:6c96:c7d0 with SMTP id v17-20020a056512349100b0047f6c96c7d0mr29884768lfr.579.1657221595960;
        Thu, 07 Jul 2022 12:19:55 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id s5-20020a05651c200500b0025d33ef2623sm518549ljo.61.2022.07.07.12.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 12:19:54 -0700 (PDT)
Date:   Thu, 7 Jul 2022 22:19:52 +0300
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
Message-ID: <20220707191952.zqaws3ayttmpao4d@mobilestation>
References: <20220610085706.15741-1-Sergey.Semin@baikalelectronics.ru>
 <20220610085706.15741-13-Sergey.Semin@baikalelectronics.ru>
 <20220615163712.GA1400328-robh@kernel.org>
 <20220619200355.zuixe3hqebpif4kv@mobilestation>
 <20220701145933.GB804716-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220701145933.GB804716-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 01, 2022 at 08:59:33AM -0600, Rob Herring wrote:
> On Sun, Jun 19, 2022 at 11:03:55PM +0300, Serge Semin wrote:
> > On Wed, Jun 15, 2022 at 10:37:12AM -0600, Rob Herring wrote:
> > > On Fri, Jun 10, 2022 at 11:57:00AM +0300, Serge Semin wrote:
> > > > Baikal-T1 SoC is equipped with DWC PCIe v4.60a Root Port controller, which
> > > > link can be trained to work on up to Gen.3 speed over up to x4 lanes. The
> > > > controller is supposed to be fed up with four clock sources: DBI
> > > > peripheral clock, AXI application Tx/Rx clocks and external PHY/core
> > > > reference clock generating the 100MHz signal. In addition to that the
> > > > platform provide a way to reset each part of the controller:
> > > > sticky/non-sticky bits, host controller core, PIPE interface, PCS/PHY and
> > > > Hot/Power reset signal. The Root Port controller is equipped with multiple
> > > > IRQ lines like MSI, system AER, PME, HP, Bandwidth change, Link
> > > > equalization request and eDMA ones. The registers space is accessed over
> > > > the DBI interface. There can be no more than four inbound or outbound iATU
> > > > windows configured.
> > > > 
> > > > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > > > 
> > > > ---
> > > > 
> > > > Changelog v2:
> > > > - Rename 'syscon' property to 'baikal,bt1-syscon'.
> > > > - Fix the 'compatible' property definition to being more specific about
> > > >   what strings are supposed to be used. Due to that we had to add the
> > > >   select property to evaluate the schema against the Baikal-T1 PCIe DT
> > > >   nodes only.
> > > > ---
> > > >  .../bindings/pci/baikal,bt1-pcie.yaml         | 154 ++++++++++++++++++
> > > >  1 file changed, 154 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/pci/baikal,bt1-pcie.yaml
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/pci/baikal,bt1-pcie.yaml b/Documentation/devicetree/bindings/pci/baikal,bt1-pcie.yaml
> > > > new file mode 100644
> > > > index 000000000000..23bd1d0aa5c5
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/pci/baikal,bt1-pcie.yaml
> > > > @@ -0,0 +1,154 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/pci/baikal,bt1-pcie.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Baikal-T1 PCIe Root Port Controller
> > > > +
> > > > +maintainers:
> > > > +  - Serge Semin <fancer.lancer@gmail.com>
> > > > +
> > > > +description:
> > > > +  Embedded into Baikal-T1 SoC Root Complex controller. It's based on the
> > > > +  DWC RC PCIe v4.60a IP-core, which is configured to have just a single Root
> > > > +  Port function and is capable of establishing the link up to Gen.3 speed
> > > > +  on x4 lanes. It doesn't have embedded clock and reset control module, so
> > > > +  the proper interface initialization is supposed to be performed by software.
> > > > +
> > > > +select:
> > > > +  properties:
> > > > +    compatible:
> > > > +      contains:
> > > > +        const: baikal,bt1-pcie
> > > > +
> > > > +  required:
> > > > +    - compatible
> > > > +
> > > > +allOf:
> > > > +  - $ref: /schemas/pci/snps,dw-pcie.yaml#
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    items:
> > > > +      - const: baikal,bt1-pcie
> > > > +      - const: snps,dw-pcie-4.60a
> > > 
> > 
> > > Pointless, you can read the version.
> > 
> > The IP-core version CSR was first introduced in v4.70a. So by using
> > the version-based compatible string I advertise the actual IP-core
> > version.
> 

> Ah, right. However, we generally haven't done this elsewhere and you 
> aren't special.

I have a very bright example. It's DW MAC/GMAC/xGMAC device. The
device driver relies on the IP-core version while Synopsys added the
release ID CSRs in the much newer IP-cores.

> 
> > 
> > > 
> > > > +      - const: snps,dw-pcie
> > > 
> > 
> > > Pointless, because what can you do with this by itself?
> > 
> > In general many things. For instance implement some IP-core specific
> > quirks in the generic part of the PCIe subsystem, visually identify
> > the device origin, etc.
> 

> Experience has shown these are not useful. Drop it. Anything in the PCI 
> core would probably use the RP VID/PID.
> 
> Furthermore, there is no guarantee that you won't match and bind to the 
> dw_plat_pcie_driver instead. The kernel has no mechanism to bind to the 
> best match (which is further complicated with modules).

I see your point. Then as I already said in my comment to the DW
PCie DT-bindings patch of this series I'll have to split the
snps,dw-pcie.yaml schema into two:
snps,dw-pcie-common.yaml
and
snps,dw-pcie.yaml

> 
> 
> > > > +  reg:
> > > > +    description:
> > > > +      DBI, DBI2 and at least 4KB outbound iATU-capable region.
> > > > +    maxItems: 3
> > > > +
> > > > +  reg-names:
> > > > +    minItems: 3
> > > > +    maxItems: 3
> > > > +    items:
> > > > +      enum: [ dbi, dbi2, config ]
> > > 
> > 
> > > This should define the order.
> > 
> > Please, tell me why do you persist in the items being ordered? The
> > driver permits the relaxed order of the resources. Thus there is no
> > much need in such constraint. At least I can't find any.
> 

> Tell me why you need random order.

Because I don't see a need in constraining the order. If we get to set
the order requirement, then why do we need to have the "*-names"
property at all?
IMO having "reg" with max/minItems restriction plus generic
description and "reg-names" with possible values enumerated seems very
suitable pattern in this case. Don't you think?

> 
> 
> > > > +  interrupts:
> > > > +    description:
> > > > +      MSI, AER, PME, Hot-plug, Link Bandwidth Management, Link Equalization
> > > > +      request and eight Read/Write eDMA IRQ lines are available.
> > > > +    maxItems: 14
> > > > +
> > > > +  interrupt-names:
> > > > +    minItems: 14
> > > > +    maxItems: 14
> > > > +    items:
> > > > +      oneOf:
> > > > +        - pattern: '^dma[0-7]$'
> > > > +        - enum: [ msi, aer, pme, hp, bw_mg, l_eq ]
> > > 
> > 
> > > Define the order.
> > 
> > Fourteen IRQs? dma0, dma1, dma2, ..., msi, aer, ..., l_eq?
> 

> If that's what the h/w has...

Please, see my comment above. Let's settle the ordering in general
first.

> 
> > 
> > > 
> > > > +
> > > > +  clocks:
> > > > +    description:
> > > > +      DBI (attached to the APB bus), AXI-bus master and slave interfaces
> > > > +      are fed up by the dedicated application clocks. A common reference
> > > > +      clock signal is supposed to be attached to the corresponding Ref-pad
> > > > +      of the SoC. It will be redistributed amongst the controller core
> > > > +      sub-modules (pipe, core, aux, etc).
> > > > +    minItems: 4
> > > > +    maxItems: 4
> > > > +
> > > > +  clock-names:
> > > > +    minItems: 4
> > > > +    maxItems: 4
> > > > +    items:
> > > > +      enum: [ dbi, mstr, slv, ref ]
> > > > +
> > > > +  resets:
> > > > +    description:
> > > > +      A comprehensive controller reset logic is supposed to be implemented
> > > > +      by software, so almost all the possible application and core reset
> > > > +      signals are exposed via the system CCU module.
> > > > +    minItems: 9
> > > > +    maxItems: 9
> > > > +
> > > > +  reset-names:
> > > > +    minItems: 9
> > > > +    maxItems: 9
> > > > +    items:
> > > > +      enum: [ mstr, slv, pwr, hot, phy, core, pipe, sticky, non-sticky ]
> > > > +
> > > > +  baikal,bt1-syscon:
> > > > +    $ref: /schemas/types.yaml#/definitions/phandle
> > > > +    description:
> > > > +      Phandle to the Baikal-T1 System Controller DT node. It's required to
> > > > +      access some additional PM, Reset-related and LTSSM signals.
> > > > +
> > > > +  num-lanes:
> > > > +    maximum: 4
> > > > +
> > > > +  max-link-speed:
> > > > +    maximum: 3
> > > > +
> > > 
> > 
> > > > +  num-ob-windows:
> > > > +    const: 4
> > > > +
> > > > +  num-ib-windows:
> > > > +    const: 4
> > > 
> > > Remove these. They are deprecated and shouldn't be in new bindings.
> > 
> > Aren't they deprecated in the framework of the DT nodes only?
> 

> Yes, and that means don't use in new users.
> 
> > Can't I still use them here to signify the number of iATU windows?
> 
> No.

Ok.

-Sergey

> 
> Rob
