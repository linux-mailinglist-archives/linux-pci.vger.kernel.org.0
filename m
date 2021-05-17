Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF47D386B50
	for <lists+linux-pci@lfdr.de>; Mon, 17 May 2021 22:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240577AbhEQUXV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 May 2021 16:23:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:41196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239033AbhEQUXU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 May 2021 16:23:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ADF4E6112F;
        Mon, 17 May 2021 20:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621282920;
        bh=nOa2NGTuYLGt5JuGWpbxWdf/pm/IA/1XRIK4Sc9jdeA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mOm5ZhSy90RztTGHtGGc9Pj9PEXPc54jsjjO/sV+UCjGNO+Hg8f++NPWXVNH4mSq2
         Iq80kJf7llZoyD3tkR0YM8IqIpuabtRo12EPnYfGZ0KYaR23s3pLxMVGD/U8JglhVJ
         hIFbTxZWclrbITwcVNZbqfZQIfFighHGMgYLfllcvAFhJGFRn1PKmrr+hxRfIwQDCw
         Ejzf0ZHHUNOZ524bGlr/bGIEzT7tqIlY8WbzI9H5yQb3gmNYnVVQABFS+jnQLC3ydF
         DMgaCnf9dP/YbTKZEyUG87xCyK9/+y07GLdckWUHvWtFqdcnNOSB/EY43i/nWexYX5
         cAbP/1yhsfFBA==
Received: by mail-qk1-f171.google.com with SMTP id v8so7164922qkv.1;
        Mon, 17 May 2021 13:22:00 -0700 (PDT)
X-Gm-Message-State: AOAM532yNoi57qN9FTlLiiBJaf3ktUV+vaskEoamitSrbEq8C0PjH86a
        hz0t/OtZy8HTWCya5t0C+tj7J7KID7E+BPuGng==
X-Google-Smtp-Source: ABdhPJzrgLJsFGdLKGAguC4UHvSEPsx328jM21r2jbP9iLj8g6MzJsu1dldI31VzZkNrR/zBe5DALlPFc3ff9/C9Q6c=
X-Received: by 2002:a05:620a:945:: with SMTP id w5mr1696841qkw.68.1621282919825;
 Mon, 17 May 2021 13:21:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210516211851.74921-1-mark.kettenis@xs4all.nl>
 <20210516211851.74921-2-mark.kettenis@xs4all.nl> <CAL_Jsq+k5Bp6_BY2UD6HbKVXv=mzcqg9f_H4w=GWMm2rThxJbQ@mail.gmail.com>
 <5612d97ef71da187@bloch.sibelius.xs4all.nl>
In-Reply-To: <5612d97ef71da187@bloch.sibelius.xs4all.nl>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 17 May 2021 15:21:48 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+4C9oKpG=H5rux1ND26ph5LA4Z3VnyxVGFJxwSqzmsWQ@mail.gmail.com>
Message-ID: <CAL_Jsq+4C9oKpG=H5rux1ND26ph5LA4Z3VnyxVGFJxwSqzmsWQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: pci: Add DT bindings for apple,pcie
To:     Mark Kettenis <mark.kettenis@xs4all.nl>
Cc:     devicetree@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mark Kettenis <kettenis@openbsd.org>,
        Hector Martin <marcan@marcan.st>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 17, 2021 at 2:41 PM Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
>
> > From: Rob Herring <robh+dt@kernel.org>
> > Date: Mon, 17 May 2021 09:16:49 -0500
>
> Hi Rob,
>
> Thanks for taking a look.  Below are some further explanations and
> questions.  I'll probably wait to collect a bit more feedback before
> re-rolling this series.
>
> > On Sun, May 16, 2021 at 4:19 PM Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
> > >
> > > From: Mark Kettenis <kettenis@openbsd.org>
> > >
> > > The Apple PCIe host controller is a PCIe host controller with
> > > multiple root ports present in Apple ARM SoC platforms, including
> > > various iPhone and iPad devices and the "Apple Silicon" Macs.
> >
> > All the cover letter will be lost in the git history. Please mention
> > some details like this is a DWC controller here. I disagree that you
> > can't use the DWC binding. You can use it and extend it with what's
> > needed here. And that way, we could move from generic ECAM to an
> > actual driver in the OS if needed (hopefully not). More below.
>
> Should I mention the DWC heritage in the description of the device in
> the DT schema or in the commit message of the schema?  Or both?

Probably in the schema is best.

> Note that it looks as if Apple has replaced most of the DWC logic in
> the controller with their own logic.  The DWC ATU isn't there, not in
> its original form nor in its newer "unrolled" form.  The MSI logic is
> Apple's own as well.  As such, none of the properties specified in
> Documentation/devicetree/bindings/pci/designware-pcie.txt that aren't
> specified by /schemas/pci/pci-bus.yaml apply.  That said, the binding
> doesn't deliberately deviate from the DWC binding either.

Okay, there might not be much to share.

>
> > > Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
> > > ---
> > >  .../devicetree/bindings/pci/apple,pcie.yaml   | 150 ++++++++++++++++++
> > >  MAINTAINERS                                   |   1 +
> > >  2 files changed, 151 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/pci/apple,pcie.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/pci/apple,pcie.yaml b/Documentation/devicetree/bindings/pci/apple,pcie.yaml
> > > new file mode 100644
> > > index 000000000000..af3c9f64e380
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/pci/apple,pcie.yaml
> > > @@ -0,0 +1,150 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/pci/apple,pcie.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Apple PCIe host controller
> > > +
> > > +maintainers:
> > > +  - Mark Kettenis <kettenis@openbsd.org>
> > > +
> > > +description: |
> > > +  The Apple PCIe host controller is a PCIe host controller with
> > > +  multiple root ports present in Apple ARM SoC platforms, including
> > > +  various iPhone and iPad devices and the "Apple Silicon" Macs.
> > > +
> > > +allOf:
> > > +  - $ref: /schemas/pci/pci-bus.yaml#
> > > +
> > > +properties:
> > > +  compatible:
> > > +    items:
> > > +      - const: apple,t8103-pcie
> > > +      - const: apple,pcie
> > > +
> > > +  reg:
> > > +    minItems: 4
> > > +    maxItems: 6
> >
> > 6 or...
> >
> > > +  reg-names:
> > > +    minItems: 4
> > > +    maxItems: 7
> >
> > 7?
>
> Oops.  That is a leftover from when I was checking whether the schema
> would catch certain errors in the dts files.
>
> > > +    items:
> > > +      - const: ecam
> >
> > 'config'
> >
> > The difference between ECAM or not in existing devices is really just
> > the size. If you look at the addresses on other DWC bindings, the
> > config region is just an iATU window within the host's PCI address
> > range.
>
> If 'config' is a better name, sure, I can change that.  I don't think
> the config region is just a window into the host's PCI address range
> though as config space requires a nGnRnE mapping whereas the PCI
> address range requires a nGnRE mapping.  That's what the
> "nonposted-mmio" discussion was all about.
>
> > > +      - const: rc
> >
> > This would be 'dbi'?
>
> I don't think so.  As far as I can determine this registers block
> contains only Apple-specific registers and none of the registers that
> live in "Designware DBI space" on other hardware.

Humm, that's what I looked at to determine it's Designware based. I'll
have to dig thru the irc logs to remember what I looked at. It's the
'port logic' registers that I compare.

This sounds like it might be different enough that using the common
DWC driver won't ever work since the bulk of the common parts for it
are the iATU and MSI controller.

> > Also check if we need 'atu' (only if it's not at the default offset)?
>
> As far as I can tell there is no Designware ATU on the Apple hardware.
>
> > > +      - const: phy
> >
> > Should there be a separate phy node?
>
> At this point neither the U-Boot driver nor the OpenBSD driver access
> registers in this block.  Should I leave it out for now?

Probably so.

> > > +      - const: port0
> > > +      - const: port1
> > > +      - const: port2
> >
> > What's in these registers?
>
> This block contains registers that are per-port.  This includes the
> Apple-specific link control registers, the Apple-specific MSI
> registers, PCI requestor ID to IOMMU stream ID mapping registers.
>
> > > +
> > > +  ranges:
> > > +    minItems: 2
> > > +    maxItems: 2
> > > +
> > > +  interrupts:
> > > +    minItems: 3
> > > +    maxItems: 3
> >
> > Need to define what each one is.
>
> Hmm, haven't figured that out yet.  U-Boot doesn't need them and
> neither does my OpenBSD driver.  Should I leave these out for now?

Just add a note that they are unknown. It's at least useful to know there are 3.


> > > +  msi-ranges:
> > > +    description:
> > > +      A list of pairs <intid span>, where "intid" is the first
> > > +      interrupt number that can be used as an MSI, and "span" the size
> > > +      of that range.
> >
> > Hopefully, Marc Z will comment on the MSI bits. msi-map doesn't work
> > here? If we need something else, then it should be added to
> > pci-msi.txt.
>
> This was actually based on discussions I had with Marc on #asahilinux
> some time ago.  But certainly something that we need his blessing on
> ;).
>
> > One problem with this is it assumes 'intid' is one cell. It's really 2
> > for the AIC if we ignore flags (which would be another assumption that
> > we can ignore the last cell). Or maybe this belongs in the AIC
> > binding?
>
> The MSI translation defenitely happens in the PCIe host bridge.  The
> MSI target address is programmed in a per-port register and not
> translated by the IOMMU.

Then perhaps you have more than 3 interrupts and need to list out 32
more? Or am I misunderstanding that '704' is an AIC interrupt number?


> > > +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> > > +    items:
> > > +      minItems: 2
> > > +      maxItems: 2
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - reg-names
> > > +  - bus-range
> > > +  - interrupts
> > > +  - msi-controller
> > > +  - msi-parent
> > > +  - msi-ranges
> > > +
> > > +unevaluatedProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    #include <dt-bindings/interrupt-controller/apple-aic.h>
> > > +    #include <dt-bindings/pinctrl/apple.h>
> > > +
> > > +    soc {
> > > +      #address-cells = <2>;
> > > +      #size-cells = <2>;
> > > +
> > > +      pcie0: pcie@690000000 {
> > > +        compatible = "apple,t8103-pcie", "apple,pcie";
> > > +        device_type = "pci";
> > > +
> > > +        reg = <0x6 0x90000000 0x0 0x1000000>,
> > > +              <0x6 0x80000000 0x0 0x4000>,
> > > +              <0x6 0x8c000000 0x0 0x4000>,
> > > +              <0x6 0x81000000 0x0 0x8000>,
> > > +              <0x6 0x82000000 0x0 0x8000>,
> > > +              <0x6 0x83000000 0x0 0x8000>;
> > > +        reg-names = "ecam", "rc", "phy", "port0", "port1", "port2";
> > > +
> > > +        interrupt-parent = <&aic>;
> > > +        interrupts = <AIC_IRQ 695 IRQ_TYPE_LEVEL_HIGH>,
> > > +                     <AIC_IRQ 698 IRQ_TYPE_LEVEL_HIGH>,
> > > +                     <AIC_IRQ 701 IRQ_TYPE_LEVEL_HIGH>;
> > > +
> > > +        msi-controller;
> > > +        msi-parent = <&pcie0>;
> > > +        msi-ranges = <704 32>;
> > > +
> > > +        iommu-map = <0x0 &dart0 0x8000 0x100>,
> > > +                    <0x100 &dart0 0x100 0x100>,
> > > +                    <0x200 &dart1 0x200 0x100>,
> > > +                    <0x300 &dart2 0x300 0x100>;
> > > +        iommu-map-mask = <0xff00>;
> >
> > These need to be documented. You can assume they have a type already,
> > so just 'true' or any constraints.
>
> No examples of that yet, but I can try to get that right...
>
> > > +
> > > +        bus-range = <0 7>;
> > > +        #address-cells = <3>;
> > > +        #size-cells = <2>;
> > > +        ranges = <0x43000000 0x6 0xa0000000 0x6 0xa0000000 0x0 0x20000000>,
> > > +                 <0x02000000 0x0 0xc0000000 0x6 0xc0000000 0x0 0x40000000>;
> > > +
> > > +        clocks = <&pcie_core_clk>, <&pcie_aux_clk>, <&pcie_ref_clk>;
> > > +        pinctrl-0 = <&pcie_pins>;
> > > +        pinctrl-names = "default";
> > > +
> > > +        pci@0,0 {
> > > +          device_type = "pci";
> > > +          reg = <0x0 0x0 0x0 0x0 0x0>;
> > > +          reset-gpios = <&pinctrl_ap 152 0>;
> > > +          max-link-speed = <2>;
> > > +
> > > +          #address-cells = <3>;
> > > +          #size-cells = <2>;
> > > +          ranges;
> > > +        };
> > > +
> > > +        pci@1,0 {
> > > +          device_type = "pci";
> > > +          reg = <0x800 0x0 0x0 0x0 0x0>;
> > > +          reset-gpios = <&pinctrl_ap 153 0>;
> > > +          max-link-speed = <2>;
> > > +
> > > +          #address-cells = <3>;
> > > +          #size-cells = <2>;
> > > +          ranges;
> > > +        };
> > > +
> > > +        pci@2,0 {
> > > +          device_type = "pci";
> > > +          reg = <0x1000 0x0 0x0 0x0 0x0>;
> > > +          reset-gpios = <&pinctrl_ap 33 0>;
> > > +          max-link-speed = <1>;
> > > +
> > > +          #address-cells = <3>;
> > > +          #size-cells = <2>;
> > > +          ranges;
> > > +        };
> > > +      };
> > > +    };
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 7327c9b778f1..789d79315485 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -1654,6 +1654,7 @@ C:        irc://chat.freenode.net/asahi-dev
> > >  T:     git https://github.com/AsahiLinux/linux.git
> > >  F:     Documentation/devicetree/bindings/arm/apple.yaml
> > >  F:     Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
> > > +F:     Documentation/devicetree/bindings/pci/apple,pcie.yaml
> > >  F:     Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
> > >  F:     arch/arm64/boot/dts/apple/
> > >  F:     drivers/irqchip/irq-apple-aic.c
> > > --
> > > 2.31.1
> > >
> >
