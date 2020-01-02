Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C690D12E421
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jan 2020 10:00:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbgABJAv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Jan 2020 04:00:51 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33104 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727842AbgABJAv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Jan 2020 04:00:51 -0500
Received: by mail-ot1-f68.google.com with SMTP id b18so34359847otp.0;
        Thu, 02 Jan 2020 01:00:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fJFkq9fgXdJc4mnZ6lqzSDTJfkkupEPzyOJabLJ6bv0=;
        b=p9REWqXekPXmYokjLl1uoSbL2yEYUA760udBkAGj7QaMc2CMdnUp3Sp7l4JN3F/L1E
         gx88GBSlLdA+b1KYILzao0whKbxsROSjfoI5Tn1mSE72r5ju6DBQZNpj8B3TtY0gX5OQ
         QEFt6W24tZmfLVj6jouITo1kJUJ16t+J+ItAQcWF7M7h2bTkZs+9BTQU2hbSxBMbpVSE
         95Rx2g+nwVAxaNmn1UJZXb6/jFKDEEBmRkKR7+hS9XWhbD/fz+QWqLPeebkFJmMwK7Cn
         IquoomnRu8APPSUQwRTBE784spVhGUOgzHg0ozjj4Kr8qEkkd6+VfZTWNdcYaLqarHpY
         1VuA==
X-Gm-Message-State: APjAAAWxe0o82Jq1isZ1o13NMwZiNc84fLncW6Z4Kweov910MnE8fgLr
        1ma176CKHPSx5Mqg6dQ1bvTRs2EYlf2urUtV/Kw=
X-Google-Smtp-Source: APXvYqyUfUGFNgz0xNB0ytdDk3m9k6lvN2rSLQrWuplzu38HrzYAPZJ4cUcexs15+gohZobI23e99dHh/W90fK4UCfA=
X-Received: by 2002:a9d:7984:: with SMTP id h4mr92750494otm.297.1577955650175;
 Thu, 02 Jan 2020 01:00:50 -0800 (PST)
MIME-Version: 1.0
References: <20191116005240.15722-1-robh@kernel.org> <20191116005240.15722-3-robh@kernel.org>
 <CAMuHMdX20LvK2o1cZJ8q83Q08JQzH6L07gmqBm0V0xSc5GHk4A@mail.gmail.com>
 <CAL_Jsq+24qYqN6u1o93gkGm13GZeSRQM4uor0170HeFbLdU-xQ@mail.gmail.com>
 <CAMuHMdXBVyutji67Ladvoh3NhrPNTYfAKS4pmOQcOouZGokYvQ@mail.gmail.com>
 <CAMuHMdU0K3n4CandL2RKrVmzmbBMt2Mw3WWM4JZoZcK3h8yZNA@mail.gmail.com> <CAL_JsqLOtT478wXZv8hshvpsdHESnDCNuwDBNj264tNu-oyVUQ@mail.gmail.com>
In-Reply-To: <CAL_JsqLOtT478wXZv8hshvpsdHESnDCNuwDBNj264tNu-oyVUQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 2 Jan 2020 10:00:39 +0100
Message-ID: <CAMuHMdUq9FD8MU2iF4FPwLND+jrD5f-h8Wnp1A3=HwHmHg+nmg@mail.gmail.com>
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

On Tue, Dec 31, 2019 at 6:10 PM Rob Herring <robh@kernel.org> wrote:
> On Tue, Dec 31, 2019 at 7:31 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Tue, Dec 31, 2019 at 9:23 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Tue, Dec 31, 2019 at 12:30 AM Rob Herring <robh@kernel.org> wrote:
> > > > On Thu, Dec 12, 2019 at 7:41 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > > On Sat, Nov 16, 2019 at 1:53 AM Rob Herring <robh@kernel.org> wrote:
> > > > > > Convert the generic PCI host binding to DT schema. The derivative Juno,
> > > > > > PLDA XpressRICH3-AXI, and Designware ECAM bindings all just vary in
> > > > > > their compatible strings. The simplest way to convert those to
> > > > > > schema is just add them into the common generic PCI host schema.
> > > > > >
> > > > > > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > > > > > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > > > > Cc: Andrew Murray <andrew.murray@arm.com>
> > > > > > Cc: Zhou Wang <wangzhou1@hisilicon.com>
> > > > > > Cc: Will Deacon <will@kernel.org>
> > > > > > Cc: David Daney <david.daney@cavium.com>
> > > > > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > > >
> > > > > > index 515b2f9542e5..000000000000
> > > > > > --- a/Documentation/devicetree/bindings/pci/designware-pcie-ecam.txt
> > > > > > +++ /dev/null
> > > > >
> > > > > > -Example:
> > > > > > -
> > > > > > -    pcie1: pcie@7f000000 {
> > > > > > -        compatible = "socionext,synquacer-pcie-ecam", "snps,dw-pcie-ecam";
> > > > > > -        device_type = "pci";
> > > > > > -        reg = <0x0 0x7f000000 0x0 0xf00000>;
> > > > > > -        bus-range = <0x0 0xe>;
> > > > > > -        #address-cells = <3>;
> > > > > > -        #size-cells = <2>;
> > > > > > -        ranges = <0x1000000 0x00 0x00010000 0x00 0x7ff00000 0x0 0x00010000>,
> > > > > > -                 <0x2000000 0x00 0x70000000 0x00 0x70000000 0x0 0x0f000000>,
> > > > > > -                 <0x3000000 0x3f 0x00000000 0x3f 0x00000000 0x1 0x00000000>;
> > > > > > -
> > > > > > -        #interrupt-cells = <0x1>;
> > > > > > -        interrupt-map-mask = <0x0 0x0 0x0 0x0>;
> > > > >
> > > > > An all-zeroes interrupt-map-mask seems to be very common on embedded
> > > > > SoCs, where all devices are mapped to a single interrupt.
> > > >
> > > > Indeed.
> > > >
> > > > > However, schemas/pci/pci-bus.yaml says:
> > > > >
> > > > >   interrupt-map-mask:
> > > > >     items:
> > > > >       - description: PCI high address cell
> > > > >         minimum: 0
> > > > >         maximum: 0xf800
> > > > >       - description: PCI mid address cell
> > > > >         const: 0
> > > > >       - description: PCI low address cell
> > > > >         const: 0
> > > > >       - description: PCI IRQ cell
> > > > >         minimum: 1
> > > > >         maximum: 7
> > > > >
> > > > > and thus complains about an all-zeroes mask, e.g.
> > > > >
> > > > >     arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dt.yaml:
> > > > > pcie@fe000000: interrupt-map-mask:0:3: 0 is less than the minimum of 1
> > > >
> > > > Now fixed.
> > >
> > > Thank you, confirmed.
> >
> > And with latest renesas-drivers, I started seeing:
> >
> >     arch/arm/boot/dts/r8a7791-koelsch.dt.yaml: pci@ee0d0000:
> > interrupt-map:0: [0, 0, 0, 1] is too short
> >     arch/arm/boot/dts/r8a7791-koelsch.dt.yaml: pci@ee0d0000:
> > interrupt-map:1: [5, 0, 113, 4] is too short
> >     arch/arm/boot/dts/r8a7791-koelsch.dt.yaml: pci@ee0d0000:
> > interrupt-map:2: [2048, 0, 0, 1] is too short
> >     arch/arm/boot/dts/r8a7791-koelsch.dt.yaml: pci@ee0d0000:
> > interrupt-map:3: [5, 0, 113, 4] is too short
> >     arch/arm/boot/dts/r8a7791-koelsch.dt.yaml: pci@ee0d0000:
> > interrupt-map:4: [4096, 0, 0, 2] is too short
> >     arch/arm/boot/dts/r8a7791-koelsch.dt.yaml: pci@ee0d0000:
> > interrupt-map:5: [5, 0, 113, 4] is too short
> >
> > Looks like interrupt-map is split incorrectly: shouldn't each entry have 8
> > cells?
>
> That must be with a current dtc which now splits the array before each
> phandle. That works for phandle+args, but not *-map properties. :( I

Ah, that explains it: renesas-drivers does include your for-next branch.
At first I was a bit puzzled, as the messages weren't introduced by a
dt-schema repo update...

> was trying to avoid a bunch of dts updates to add brackets. I think
> for now, I'll just drop the interrupt-map size constraint. It's not
> all that accurate anyways as it doesn't look at cell sizes.

Too late, I've already applied grouping to the Renesas ARM DTS files ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
