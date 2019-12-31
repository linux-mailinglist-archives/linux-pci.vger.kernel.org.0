Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8090A12D97C
	for <lists+linux-pci@lfdr.de>; Tue, 31 Dec 2019 15:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfLaOb3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Dec 2019 09:31:29 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36780 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbfLaOb3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Dec 2019 09:31:29 -0500
Received: by mail-ot1-f65.google.com with SMTP id 19so38010017otz.3;
        Tue, 31 Dec 2019 06:31:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aNGy9k3GjPpQw+gLldMaMw00/W7LQuR5voB3/IzYKmU=;
        b=A4s+RdqrRThC+T8F0yWQ21ggg3gg5MZoJMepfyKSDYu70vhsvbV5vZFHehBEMdCrXA
         4WgxthNWd8yZ8qgrqyt0DPc0ZK/FOshI/9y9aI9/RNhNhA3SUVSWMKkjxBQ7fnDu5gw2
         jpn2HLbUf5Xh8vvd5CvNZyHSnEWzzQBelE2t0gfTS0Spy1iGjfxvyXz6LIk5SUm250Px
         N7WJ8cP5KdJH5EQk5XArItk/N4S2Jpay3TB1sfM1i/K3JWMEx21HqXDh4nz440/1cSLT
         2Rr9vDQ0Ceo43zRFHEGYjwN5hyGdgyqUGfGdo4TL0AxgrUOHreVXRb3btWI07q977OtA
         Gyaw==
X-Gm-Message-State: APjAAAU1lWrxkuFtbsLHtSlc98l0MMI9iEvIx8m7OaU4mpyr2TplUav/
        6ccRVGTAAstVjCJ9Dvr6iMMwCI7zti/P7sL/zMM=
X-Google-Smtp-Source: APXvYqyRede9nj6QX/J+h2iPj3015tGZi4SSxVB405gFFdOzF7lG31k2iCzmQCt8rAqZ0PIbsv+1WWhJh/5VIYtn99c=
X-Received: by 2002:a9d:8f1:: with SMTP id 104mr75063793otf.107.1577802688662;
 Tue, 31 Dec 2019 06:31:28 -0800 (PST)
MIME-Version: 1.0
References: <20191116005240.15722-1-robh@kernel.org> <20191116005240.15722-3-robh@kernel.org>
 <CAMuHMdX20LvK2o1cZJ8q83Q08JQzH6L07gmqBm0V0xSc5GHk4A@mail.gmail.com>
 <CAL_Jsq+24qYqN6u1o93gkGm13GZeSRQM4uor0170HeFbLdU-xQ@mail.gmail.com> <CAMuHMdXBVyutji67Ladvoh3NhrPNTYfAKS4pmOQcOouZGokYvQ@mail.gmail.com>
In-Reply-To: <CAMuHMdXBVyutji67Ladvoh3NhrPNTYfAKS4pmOQcOouZGokYvQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 31 Dec 2019 15:31:17 +0100
Message-ID: <CAMuHMdU0K3n4CandL2RKrVmzmbBMt2Mw3WWM4JZoZcK3h8yZNA@mail.gmail.com>
Subject: Re: [PATCH 3/3] dt-bindings: PCI: Convert generic host binding to DT schema
To:     Rob Herring <robh@kernel.org>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Will Deacon <will@kernel.org>,
        David Daney <david.daney@cavium.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,

On Tue, Dec 31, 2019 at 9:23 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Tue, Dec 31, 2019 at 12:30 AM Rob Herring <robh@kernel.org> wrote:
> > On Thu, Dec 12, 2019 at 7:41 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Sat, Nov 16, 2019 at 1:53 AM Rob Herring <robh@kernel.org> wrote:
> > > > Convert the generic PCI host binding to DT schema. The derivative Juno,
> > > > PLDA XpressRICH3-AXI, and Designware ECAM bindings all just vary in
> > > > their compatible strings. The simplest way to convert those to
> > > > schema is just add them into the common generic PCI host schema.
> > > >
> > > > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > > > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > > Cc: Andrew Murray <andrew.murray@arm.com>
> > > > Cc: Zhou Wang <wangzhou1@hisilicon.com>
> > > > Cc: Will Deacon <will@kernel.org>
> > > > Cc: David Daney <david.daney@cavium.com>
> > > > Signed-off-by: Rob Herring <robh@kernel.org>
> > >
> > > > index 515b2f9542e5..000000000000
> > > > --- a/Documentation/devicetree/bindings/pci/designware-pcie-ecam.txt
> > > > +++ /dev/null
> > >
> > > > -Example:
> > > > -
> > > > -    pcie1: pcie@7f000000 {
> > > > -        compatible = "socionext,synquacer-pcie-ecam", "snps,dw-pcie-ecam";
> > > > -        device_type = "pci";
> > > > -        reg = <0x0 0x7f000000 0x0 0xf00000>;
> > > > -        bus-range = <0x0 0xe>;
> > > > -        #address-cells = <3>;
> > > > -        #size-cells = <2>;
> > > > -        ranges = <0x1000000 0x00 0x00010000 0x00 0x7ff00000 0x0 0x00010000>,
> > > > -                 <0x2000000 0x00 0x70000000 0x00 0x70000000 0x0 0x0f000000>,
> > > > -                 <0x3000000 0x3f 0x00000000 0x3f 0x00000000 0x1 0x00000000>;
> > > > -
> > > > -        #interrupt-cells = <0x1>;
> > > > -        interrupt-map-mask = <0x0 0x0 0x0 0x0>;
> > >
> > > An all-zeroes interrupt-map-mask seems to be very common on embedded
> > > SoCs, where all devices are mapped to a single interrupt.
> >
> > Indeed.
> >
> > > However, schemas/pci/pci-bus.yaml says:
> > >
> > >   interrupt-map-mask:
> > >     items:
> > >       - description: PCI high address cell
> > >         minimum: 0
> > >         maximum: 0xf800
> > >       - description: PCI mid address cell
> > >         const: 0
> > >       - description: PCI low address cell
> > >         const: 0
> > >       - description: PCI IRQ cell
> > >         minimum: 1
> > >         maximum: 7
> > >
> > > and thus complains about an all-zeroes mask, e.g.
> > >
> > >     arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dt.yaml:
> > > pcie@fe000000: interrupt-map-mask:0:3: 0 is less than the minimum of 1
> >
> > Now fixed.
>
> Thank you, confirmed.

And with latest renesas-drivers, I started seeing:

    arch/arm/boot/dts/r8a7791-koelsch.dt.yaml: pci@ee0d0000:
interrupt-map:0: [0, 0, 0, 1] is too short
    arch/arm/boot/dts/r8a7791-koelsch.dt.yaml: pci@ee0d0000:
interrupt-map:1: [5, 0, 113, 4] is too short
    arch/arm/boot/dts/r8a7791-koelsch.dt.yaml: pci@ee0d0000:
interrupt-map:2: [2048, 0, 0, 1] is too short
    arch/arm/boot/dts/r8a7791-koelsch.dt.yaml: pci@ee0d0000:
interrupt-map:3: [5, 0, 113, 4] is too short
    arch/arm/boot/dts/r8a7791-koelsch.dt.yaml: pci@ee0d0000:
interrupt-map:4: [4096, 0, 0, 2] is too short
    arch/arm/boot/dts/r8a7791-koelsch.dt.yaml: pci@ee0d0000:
interrupt-map:5: [5, 0, 113, 4] is too short

Looks like interrupt-map is split incorrectly: shouldn't each entry have 8
cells?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
