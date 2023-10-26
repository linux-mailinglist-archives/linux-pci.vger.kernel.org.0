Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63D1B7D84B7
	for <lists+linux-pci@lfdr.de>; Thu, 26 Oct 2023 16:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234902AbjJZO3z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Oct 2023 10:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbjJZO3y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Oct 2023 10:29:54 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49961A2;
        Thu, 26 Oct 2023 07:29:51 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-507cee17b00so1412401e87.2;
        Thu, 26 Oct 2023 07:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698330590; x=1698935390; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OcqUQMLqvFMvSkNSx40kwQOwpdz0wVTfgpQiz0XbkjE=;
        b=TH0yYlN2hhSjP/E+Q+XrR8SsI5ZF+KkULaRFQ+DXZH0rw/jyC1H9gOcto5hECStQWU
         adaW37gfBWkHoPZXx+Yx/hvxkSJ29Mnj0i5nbH8O0G1Ms5yJH+FUn0jtDHSrRJUUR0El
         8hWnOrWrxXEFsHVgz5vwC75q0A/TOxMC0SROz20ZoLv6q/kGYddWA9pqw8Tx2AcVrwzS
         6uyXbXDa4V7iAq+a7BunNpV6A1P3VmtCwumhJrKf2ihpgPF78ST/Ob89WruiZqo7xF1V
         wNoX1OaQCF4tyAwTajvuyaOyeIAAmoZJ8tVefP4HX16M9y8la5eIupnwAFtHUEmctPCg
         VrRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698330590; x=1698935390;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OcqUQMLqvFMvSkNSx40kwQOwpdz0wVTfgpQiz0XbkjE=;
        b=OJJlavj1v6vwjAVlTZksac/sbmWJTHDEo7qPkhnLBmADdBU76O8T/ixNf99xjtSJzi
         NoaIWTSpzHTsXWKKAzqCEcJo5fN5YQ373EnUUOdkxmeCKxZR0sPo4CPFV51SQAI9FCnT
         gvQBdapcrYEjeUpNBM9FMu3u3HqxLmVKAjGuOaY8R4ZzrCY6LKijWY3/YGp6u+vVkIT2
         ZFgJmRZLfc4JwZVkKvUoKGUwMRHhiMnu3xgHxL0VjOR4LwyrrINQGyhNl6Cw7pA7isgL
         N8gZLUQKM7OerBdu34IZJrzcE8RhUv3kiHxj1zMEFySZYWYx/nTMsnvUKf6nmJMWf2Al
         Naaw==
X-Gm-Message-State: AOJu0YyPcBoJKvm2HsjMsx8TF7V/q+t7PolELvZFlqgfv9jiJ6m5kbQv
        pNYIo8NfuET5Z9hLZ93kN8Q=
X-Google-Smtp-Source: AGHT+IG4W6KM7EiUTq9lHS71jdk3jgu6/vPMQBbyGiHi6AGy9gc6T9FZph47UKPMCLho0Jz7f4tUOQ==
X-Received: by 2002:ac2:456e:0:b0:500:79f7:1738 with SMTP id k14-20020ac2456e000000b0050079f71738mr12829643lfm.17.1698330589625;
        Thu, 26 Oct 2023 07:29:49 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id c20-20020a056512325400b00507a387c4c4sm3034395lfr.229.2023.10.26.07.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 07:29:49 -0700 (PDT)
Date:   Thu, 26 Oct 2023 17:29:46 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     Conor Dooley <conor@kernel.org>, Niklas Cassel <nks@flawful.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Simon Xue <xxm@rock-chips.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>
Subject: Re: [PATCH v2 3/4] dt-bindings: PCI: dwc: rockchip: Add dma
 properties
Message-ID: <lrqwv3vrwwchxkfan6r3rjmza43ggk6hcbhz24eqcf7ku2mwif@a4oj5ul4hbb3>
References: <20231024151014.240695-1-nks@flawful.org>
 <20231024151014.240695-4-nks@flawful.org>
 <20231024-glacial-subpar-6eeff54fbb85@spud>
 <ZTl1ZsHvk3DDHWsm@x1-carbon>
 <ZTmAxH0AXpCN1+G+@x1-carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTmAxH0AXpCN1+G+@x1-carbon>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Niklas

On Wed, Oct 25, 2023 at 08:55:33PM +0000, Niklas Cassel wrote:
> On Wed, Oct 25, 2023 at 10:07:02PM +0200, Niklas Cassel wrote:
> > Hello Conor,
> > 
> > On Tue, Oct 24, 2023 at 05:30:22PM +0100, Conor Dooley wrote:
> > > On Tue, Oct 24, 2023 at 05:10:10PM +0200, Niklas Cassel wrote:
> > > > From: Niklas Cassel <niklas.cassel@wdc.com>
> > > > 
> > > > Even though rockchip-dw-pcie.yaml inherits snps,dw-pcie.yaml
> > > > using:
> > > > 
> > > > allOf:
> > > >   - $ref: /schemas/pci/snps,dw-pcie.yaml#
> > > > 
> > > > and snps,dw-pcie.yaml does have the dma properties defined, in order to be
> > > > able to use these properties, while still making sure 'make CHECK_DTBS=y'
> > > > pass, we need to add these properties to rockchip-dw-pcie.yaml.
> > > > 
> > > > Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> > > > ---
> > > >  .../bindings/pci/rockchip-dw-pcie.yaml        | 20 +++++++++++++++++++
> > > >  1 file changed, 20 insertions(+)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> > > > index 229f8608c535..633f8e0e884f 100644
> > > > --- a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> > > > +++ b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> > > > @@ -35,6 +35,7 @@ properties:
> > > >        - description: Rockchip designed configuration registers
> > > >        - description: Config registers
> > > >        - description: iATU registers

> > > > +      - description: eDMA registers

Are you sure the eDMA regs aren't just a part of the same space as
iATU and available within the default offset DEFAULT_DBI_DMA_OFFSET?
If it is then drop separate eDMA reg, having just 'atu' will be enough.

> > > 
> > > Same here, is this just for one of the two supported models, or for
> > > both?
> > 
> > For the 3 controllers found in rk3568, this range exists for all
> > (all of the controllers were synthesized with the eDMA controller).
> > 
> > For the 5 controllers found in rk3588, this range exists for only one of them
> > (only one of the controllers was synthesized with the eDMA controller).
> > 
> > 
> > > >    interrupt-names:
> > > > +    minItems: 5
> > > >      items:
> > > >        - const: sys
> > > >        - const: pmc
> > > >        - const: msg
> > > >        - const: legacy
> > > >        - const: err

> > > > +      - const: dma0
> > > > +      - const: dma1
> > > > +      - const: dma2
> > > > +      - const: dma3
> > 

> > While all the PCIe controllers on the rk3568 have the embedded DMA controller
> > as part of the PCIe controller, they don't have separate IRQs for the eDMA.
> > (They will need to use the combined "sys" irq, so the driver will need to read
> > an additional register to see that it was an eDMA irq.)

If it's some vendor-specific register, then the best solution would be
to create a custom IRQ domain with 'sys' IRQ being a parental IRQ and
with the "dma*" IRQs being the child IRQs. Then you can re-define the
dw_pcie_edma_ops.irq_vector method (and edma.nr_irqs field), which
would return the DMA IRQs from the new sub-domain.

If it's just all the IRQs combined in a single "sys" IRQ line with no
custom way to distinguish one from another, then you can re-define the
dw_pcie_edma_ops.irq_vector method with a method returning the 'sys'
IRQ vector (don't forget to set the edma.nr_irqs field). eDMA IRQ
handler will check whether the IRQ was originated by the eDMA
controller. 

> > 

> > For the rk3588, only one of the 5 PCIe controllers have the eDMA, and that
> > controller also has dedicated IRQs for the eDMA.
> > (It should also be able to use the combined "sys" irq, but that would be less
> > efficient, and AFAICT, the driver currently only works with dedicated IRQs.)

This is a standard way of the eDMA IRQs definition. So supposedly there won't
be problem with rk3588

> 
> We could go with Sebastian's suggestion to define a 1MB range for "atu", see:
> https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bindings/pci/snps%2Cdw-pcie.yaml#L76-L85

Right, That's what I asked in my very first message.

> 
> Which would allow the driver to probe if the eDMA is there or not
> (even if this is strictly bigger than the real ATU_CAP size, the size is still
> within the PCIe core's register map).
> 
> That would solve the problem that some pcie controllers, with the exact same
> compatible, has a "dma" range while others do not.
> (All controllers would have a 1MB atu range, and none of them would have the
> dma range specified.)
> 

> However, we would still have the problem that for the exact same compatible,
> some controllers have eDMA irqs specified in interrupts, and some do not...

You can define the normal eDMA IRQs as optional for all Rockchip
controllers (or for rk3588 only). They will be auto-detected by the
DW PCIe core driver as expected if the standard eDMA IRQs are
available. But for the rk3568 you'll need to redefine the
dw_edma_chip.ops operation to have a custom irq_vector() callback as I
described above.

> 
> But perhaps having mandatory atu range (and no dma range) + optional dma irqs
> is better than mandatory atu range + optional dma range + optional dma irqs?
> (At least from a DT schema maintainability PoV.)

As I mentioned in the first message, if eDMA CSRs are available within
the standard offset PCIE_DMA_UNROLL_BASE with respect to the iATU CSRs
base, then that is a single CSRs space (selected by the DBI_CS2=1 and
CDM_SB=1 internal IP-core signals) and just 'atu' reg is supposed to
be specified.

-Serge(y)

> 
> 
> Kind regards,
> Niklas
