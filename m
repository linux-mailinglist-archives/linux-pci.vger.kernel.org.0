Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A22FF12D712
	for <lists+linux-pci@lfdr.de>; Tue, 31 Dec 2019 09:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725793AbfLaIXy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Dec 2019 03:23:54 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41921 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfLaIXy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Dec 2019 03:23:54 -0500
Received: by mail-ot1-f68.google.com with SMTP id r27so49465455otc.8;
        Tue, 31 Dec 2019 00:23:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=exbpjm8R+9VG0LXo53eXq/JhXDU32icBm8b7iAcsrrE=;
        b=i3Wxe0Y8JvJoL3QnoADXcbxDv88kne5wunme+8tkCLtTL3j2tqfyp+VwrrZebF1isY
         Brh7RO0jsJGPGoHnCMR7FQ+VylzZLWfSjPf2H0/93/PJ5a2KvZ8+6tGm96R07nrbzDwA
         JAGaKDCw+Xb4AoX325e/FlU56e38gy0UAvhXle76xejbm/9VEn/NUBi9FfQcS5RJDs0C
         QOmt0uq0bF6X5Lxvv3CRTZ49I4X6vZndAKjHY6AMcn/5Rp4waqjAncohIsma5JDXcPpB
         xEaAIm5raBYfF8pplLUEAdiKXCBQ2jd3S/uqrWtlhO8rG6SBql/rTlBAz8Dp1OPJ1ExD
         659g==
X-Gm-Message-State: APjAAAX7REPno25mLqC2Efe1F6g9brc3bOEHL0iAY8q34RF7AenoqP9W
        SiU/vr2MtoS3cZooeGXgAXkNol8ZnbwqI1r1KRA=
X-Google-Smtp-Source: APXvYqyNXKUrqWbQ3GKR/KvwCtjIAXctgLXNr5s7v9TX4B69OhYh51yZVdBnhbmzbfErcyqtCy7X45zpE7TsSY5A/m4=
X-Received: by 2002:a05:6830:2141:: with SMTP id r1mr79413312otd.39.1577780633088;
 Tue, 31 Dec 2019 00:23:53 -0800 (PST)
MIME-Version: 1.0
References: <20191116005240.15722-1-robh@kernel.org> <20191116005240.15722-3-robh@kernel.org>
 <CAMuHMdX20LvK2o1cZJ8q83Q08JQzH6L07gmqBm0V0xSc5GHk4A@mail.gmail.com> <CAL_Jsq+24qYqN6u1o93gkGm13GZeSRQM4uor0170HeFbLdU-xQ@mail.gmail.com>
In-Reply-To: <CAL_Jsq+24qYqN6u1o93gkGm13GZeSRQM4uor0170HeFbLdU-xQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 31 Dec 2019 09:23:41 +0100
Message-ID: <CAMuHMdXBVyutji67Ladvoh3NhrPNTYfAKS4pmOQcOouZGokYvQ@mail.gmail.com>
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

On Tue, Dec 31, 2019 at 12:30 AM Rob Herring <robh@kernel.org> wrote:
> On Thu, Dec 12, 2019 at 7:41 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Sat, Nov 16, 2019 at 1:53 AM Rob Herring <robh@kernel.org> wrote:
> > > Convert the generic PCI host binding to DT schema. The derivative Juno,
> > > PLDA XpressRICH3-AXI, and Designware ECAM bindings all just vary in
> > > their compatible strings. The simplest way to convert those to
> > > schema is just add them into the common generic PCI host schema.
> > >
> > > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > Cc: Andrew Murray <andrew.murray@arm.com>
> > > Cc: Zhou Wang <wangzhou1@hisilicon.com>
> > > Cc: Will Deacon <will@kernel.org>
> > > Cc: David Daney <david.daney@cavium.com>
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> >
> > > index 515b2f9542e5..000000000000
> > > --- a/Documentation/devicetree/bindings/pci/designware-pcie-ecam.txt
> > > +++ /dev/null
> >
> > > -Example:
> > > -
> > > -    pcie1: pcie@7f000000 {
> > > -        compatible = "socionext,synquacer-pcie-ecam", "snps,dw-pcie-ecam";
> > > -        device_type = "pci";
> > > -        reg = <0x0 0x7f000000 0x0 0xf00000>;
> > > -        bus-range = <0x0 0xe>;
> > > -        #address-cells = <3>;
> > > -        #size-cells = <2>;
> > > -        ranges = <0x1000000 0x00 0x00010000 0x00 0x7ff00000 0x0 0x00010000>,
> > > -                 <0x2000000 0x00 0x70000000 0x00 0x70000000 0x0 0x0f000000>,
> > > -                 <0x3000000 0x3f 0x00000000 0x3f 0x00000000 0x1 0x00000000>;
> > > -
> > > -        #interrupt-cells = <0x1>;
> > > -        interrupt-map-mask = <0x0 0x0 0x0 0x0>;
> >
> > An all-zeroes interrupt-map-mask seems to be very common on embedded
> > SoCs, where all devices are mapped to a single interrupt.
>
> Indeed.
>
> > However, schemas/pci/pci-bus.yaml says:
> >
> >   interrupt-map-mask:
> >     items:
> >       - description: PCI high address cell
> >         minimum: 0
> >         maximum: 0xf800
> >       - description: PCI mid address cell
> >         const: 0
> >       - description: PCI low address cell
> >         const: 0
> >       - description: PCI IRQ cell
> >         minimum: 1
> >         maximum: 7
> >
> > and thus complains about an all-zeroes mask, e.g.
> >
> >     arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dt.yaml:
> > pcie@fe000000: interrupt-map-mask:0:3: 0 is less than the minimum of 1
>
> Now fixed.

Thank you, confirmed.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
