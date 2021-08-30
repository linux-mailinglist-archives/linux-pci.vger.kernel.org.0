Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4394E3FB989
	for <lists+linux-pci@lfdr.de>; Mon, 30 Aug 2021 17:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237716AbhH3P7P (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Aug 2021 11:59:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:33672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237735AbhH3P7H (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Aug 2021 11:59:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3DCB460FD8;
        Mon, 30 Aug 2021 15:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630339093;
        bh=94GQfHWUxtTHx/+l6i92UggNWHytvmlkl4wPKFJaFiE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cMntF844dTL/rBrW/ozl8hJNGnQz4nclR45Brpr02jajmhmvqC4IN8OgKXFVrm+5i
         CliEBSD4+ZH97rJ4duZf6NbUTy8eDU15/4ZBNbjc5EjEMG8TP7E7e8uQEI3kkRneIW
         s23es8i1wM3B2UefnCRh7Axf/kEIv95kqQNaRxtXza/CwIfRD7t0i9QD04yUMUFjNt
         VLwg0SKtc8IrlMHp+IfYQtJSp3clNh7eSwYgNUinPvyxgv/9ZlRXNMtFeRvc7gfF0/
         Cd+QgH70JfVHOup9sHF9+Qj4JoFH1WERT5E/3SbKy11j7hhvSfof9m5S+sy0VFvc8N
         F1JlcbPHnvjLA==
Received: by mail-ej1-f46.google.com with SMTP id e21so32110789ejz.12;
        Mon, 30 Aug 2021 08:58:13 -0700 (PDT)
X-Gm-Message-State: AOAM533F3ta3mAooAkUXpQ+IQY/dw9t5R/AnK42t1rroEUvUDl7y7f4x
        +Uz4tKB7WA7giXcxGVJEjm6g1r/WsizXFkHRrQ==
X-Google-Smtp-Source: ABdhPJxdn0w1vnkBGUjO5dciyQYkquk0ijWzCAVg0wdsn4z3j1+X4UTTETS+FmnItD7/WXsSw60BVGvHjQN32sYA9ac=
X-Received: by 2002:a17:906:25db:: with SMTP id n27mr25255293ejb.108.1630339091824;
 Mon, 30 Aug 2021 08:58:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210827171534.62380-1-mark.kettenis@xs4all.nl>
 <20210827171534.62380-5-mark.kettenis@xs4all.nl> <87pmtvcgec.wl-maz@kernel.org>
In-Reply-To: <87pmtvcgec.wl-maz@kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 30 Aug 2021 10:57:59 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJC+FxiynFkkcB0amp3s4agsio5ggCrYiPbqoXroAJV4Q@mail.gmail.com>
Message-ID: <CAL_JsqJC+FxiynFkkcB0amp3s4agsio5ggCrYiPbqoXroAJV4Q@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] arm64: apple: Add PCIe node
To:     Marc Zyngier <maz@kernel.org>
Cc:     Mark Kettenis <mark.kettenis@xs4all.nl>,
        devicetree@vger.kernel.org,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Mark Kettenis <kettenis@openbsd.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Hector Martin <marcan@marcan.st>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Jim Quinlan <jim2101024@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Saenz Julienne <nsaenzjulienne@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        PCI <linux-pci@vger.kernel.org>,
        "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 30, 2021 at 6:37 AM Marc Zyngier <maz@kernel.org> wrote:
>
> Hi Mark,
>
> On Fri, 27 Aug 2021 18:15:29 +0100,
> Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
> >
> > From: Mark Kettenis <kettenis@openbsd.org>
> >
> > Add node corresponding to the apcie,t8103 node in the
> > Apple device tree for the Mac mini (M1, 2020).
> >
> > Clock references and DART (IOMMU) references are left out at the
> > moment and will be added once the appropriate bindings have been
> > settled upon.
> >
> > Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
> > ---
> >  arch/arm64/boot/dts/apple/t8103.dtsi | 63 ++++++++++++++++++++++++++++
> >  1 file changed, 63 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/apple/t8103.dtsi b/arch/arm64/boot/dts/apple/t8103.dtsi
> > index 503a76fc30e6..6e4677bdef44 100644
> > --- a/arch/arm64/boot/dts/apple/t8103.dtsi
> > +++ b/arch/arm64/boot/dts/apple/t8103.dtsi
> > @@ -214,5 +214,68 @@ pinctrl_smc: pinctrl@23e820000 {
> >                                    <AIC_IRQ 396 IRQ_TYPE_LEVEL_HIGH>,
> >                                    <AIC_IRQ 397 IRQ_TYPE_LEVEL_HIGH>;
> >               };
> > +
> > +             pcie0: pcie@690000000 {
> > +                     compatible = "apple,t8103-pcie", "apple,pcie";
> > +                     device_type = "pci";
> > +
> > +                     reg = <0x6 0x90000000 0x0 0x1000000>,
> > +                           <0x6 0x80000000 0x0 0x4000>,
> > +                           <0x6 0x81000000 0x0 0x8000>,
> > +                           <0x6 0x82000000 0x0 0x8000>,
> > +                           <0x6 0x83000000 0x0 0x8000>;
> > +                     reg-names = "config", "rc", "port0", "port1", "port2";
> > +
> > +                     interrupt-parent = <&aic>;
> > +                     interrupts = <AIC_IRQ 695 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <AIC_IRQ 698 IRQ_TYPE_LEVEL_HIGH>,
> > +                                  <AIC_IRQ 701 IRQ_TYPE_LEVEL_HIGH>;
> > +
> > +                     msi-controller;
> > +                     msi-parent = <&pcie0>;
> > +                     msi-ranges = <&aic AIC_IRQ 704 IRQ_TYPE_EDGE_RISING 32>;
> > +
> > +                     bus-range = <0 3>;
> > +                     #address-cells = <3>;
> > +                     #size-cells = <2>;
> > +                     ranges = <0x43000000 0x6 0xa0000000 0x6 0xa0000000 0x0 0x20000000>,
> > +                              <0x02000000 0x0 0xc0000000 0x6 0xc0000000 0x0 0x40000000>;
> > +
> > +                     pinctrl-0 = <&pcie_pins>;
> > +                     pinctrl-names = "default";
> > +
> > +                     pci@0,0 {
> > +                             device_type = "pci";
> > +                             reg = <0x0 0x0 0x0 0x0 0x0>;
> > +                             reset-gpios = <&pinctrl_ap 152 0>;
> > +                             max-link-speed = <2>;
> > +
> > +                             #address-cells = <3>;
> > +                             #size-cells = <2>;
> > +                             ranges;
> > +                     };
> > +
> > +                     pci@1,0 {
> > +                             device_type = "pci";
> > +                             reg = <0x800 0x0 0x0 0x0 0x0>;
> > +                             reset-gpios = <&pinctrl_ap 153 0>;
> > +                             max-link-speed = <2>;
> > +
> > +                             #address-cells = <3>;
> > +                             #size-cells = <2>;
> > +                             ranges;
> > +                     };
> > +
> > +                     pci@2,0 {
> > +                             device_type = "pci";
> > +                             reg = <0x1000 0x0 0x0 0x0 0x0>;
> > +                             reset-gpios = <&pinctrl_ap 33 0>;
> > +                             max-link-speed = <1>;
> > +
> > +                             #address-cells = <3>;
> > +                             #size-cells = <2>;
> > +                             ranges;
> > +                     };
> > +             };
> >       };
> >  };
>
> I have now implemented the MSI change on the Linux driver side, and it
> works nicely. So thumbs up from me on this front.
>
> I am now looking at the interrupts provided by each port:
> (1) a bunch of port-private interrupts (link up/down...)
> (2) INTx interrupts

So each port has an independent INTx space? Is that even something PCI
defines or comprehends?

> Given that the programming is per-port, I've implemented this as a
> per-port interrupt controller.
>
> (1) is dead easy to implement, and doesn't require any DT description.
> (2) is unfortunately exposing the limits of my DT knowledge, and I'm
> not clear how to model it. I came up with the following:
>
>         port00: pci@0,0 {
>                 device_type = "pci";
>                 reg = <0x0 0x0 0x0 0x0 0x0>;
>                 reset-gpios = <&pinctrl_ap 152 0>;
>                 max-link-speed = <2>;
>
>                 #address-cells = <3>;
>                 #size-cells = <2>;
>                 ranges;
>
>                 interrupt-controller;
>                 #interrupt-cells = <1>;
>                 interrupt-parent = <&port00>;
>                 interrupt-map-mask = <0 0 0 7>;
>                 interrupt-map = <0 0 0 1 &port00 0>,
>                                 <0 0 0 2 &port00 1>,
>                                 <0 0 0 3 &port00 2>,
>                                 <0 0 0 4 &port00 3>;

IIRC, I don't think the DT IRQ code handles a node having both
'interrupt-controller' and 'interrupt-map' properties. I think that's
why some PCI host bridge nodes have child interrupt-controller nodes.
I don't really like that work-around, so if the above can be made to
work, I'd be happy to see it. But the DT IRQ code is some ancient code
for ancient platforms (PowerMacs being one of them).

>         };
>
> which vaguely seem to do the right thing for the devices behind root
> ports, but doesn't seem to work for INTx generated by the root ports
> themselves. Any clue? Alternatively, I could move it to something
> global to the whole PCIe controller, but that doesn't seem completely
> right.
>
> It also begs the question whether the per-port interrupt to the AIC
> should be moved into each root port, should my per-port approach hold
> any water.

I tend to think per-port is the right thing to do. However, the child
nodes are PCI devices, so that creates some restrictions. Such as the
per port registers are in the host address space, not the PCI address
space, so we can't move the registers into the child nodes. The
interrupts may be okay. Certainly, being an 'interrupt-controller'
without having an 'interrupts' property for an non root interrupt
controller is odd.

Rob
