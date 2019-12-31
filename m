Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC4C212DA7C
	for <lists+linux-pci@lfdr.de>; Tue, 31 Dec 2019 18:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbfLaRKR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Dec 2019 12:10:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:43794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbfLaRKQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 31 Dec 2019 12:10:16 -0500
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5AAB32072A;
        Tue, 31 Dec 2019 17:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577812215;
        bh=9SMntzLYZSCITDiUzcS3hISr6WMy3qn7X/h3j6OU4Qc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=b3kH9kq8iQBxxwwnbslf/RQoBPaAH7KalcINiF6SGY9kfkX5jgxuJixwRsv19L2in
         U+vY9eoA5Z+rdbU6wyiC1YVg3viIXQfnV4sx6sq+8mIJG1scZzqZcPXDIjXLufdk0D
         uS2grmVUgBX2IP8eA1UfxdLrRQtDN/riKzV7ryg8=
Received: by mail-qk1-f172.google.com with SMTP id d71so20778391qkc.0;
        Tue, 31 Dec 2019 09:10:15 -0800 (PST)
X-Gm-Message-State: APjAAAUrku1x1ucBJUfg3Hompy6Izr7zGcl6tj1XlRKKqUwp1Ib60mXI
        qorCqoxry4sQ3NE+jgLJTQpTM6GPNbUY/3Jt8Q==
X-Google-Smtp-Source: APXvYqwLimTMaz+kZhvvaVCp1az9M0YRkljYLZ0oF0alrJs6tu1P729MhgsWG1UmDx+ec6NxCG9N6Dzk3ciWQseu4l8=
X-Received: by 2002:a05:620a:1eb:: with SMTP id x11mr60808461qkn.254.1577812214428;
 Tue, 31 Dec 2019 09:10:14 -0800 (PST)
MIME-Version: 1.0
References: <20191116005240.15722-1-robh@kernel.org> <20191116005240.15722-3-robh@kernel.org>
 <CAMuHMdX20LvK2o1cZJ8q83Q08JQzH6L07gmqBm0V0xSc5GHk4A@mail.gmail.com>
 <CAL_Jsq+24qYqN6u1o93gkGm13GZeSRQM4uor0170HeFbLdU-xQ@mail.gmail.com>
 <CAMuHMdXBVyutji67Ladvoh3NhrPNTYfAKS4pmOQcOouZGokYvQ@mail.gmail.com> <CAMuHMdU0K3n4CandL2RKrVmzmbBMt2Mw3WWM4JZoZcK3h8yZNA@mail.gmail.com>
In-Reply-To: <CAMuHMdU0K3n4CandL2RKrVmzmbBMt2Mw3WWM4JZoZcK3h8yZNA@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 31 Dec 2019 10:10:03 -0700
X-Gmail-Original-Message-ID: <CAL_JsqLOtT478wXZv8hshvpsdHESnDCNuwDBNj264tNu-oyVUQ@mail.gmail.com>
Message-ID: <CAL_JsqLOtT478wXZv8hshvpsdHESnDCNuwDBNj264tNu-oyVUQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] dt-bindings: PCI: Convert generic host binding to DT schema
To:     Geert Uytterhoeven <geert@linux-m68k.org>
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

On Tue, Dec 31, 2019 at 7:31 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Rob,
>
> On Tue, Dec 31, 2019 at 9:23 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Tue, Dec 31, 2019 at 12:30 AM Rob Herring <robh@kernel.org> wrote:
> > > On Thu, Dec 12, 2019 at 7:41 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > On Sat, Nov 16, 2019 at 1:53 AM Rob Herring <robh@kernel.org> wrote:
> > > > > Convert the generic PCI host binding to DT schema. The derivative Juno,
> > > > > PLDA XpressRICH3-AXI, and Designware ECAM bindings all just vary in
> > > > > their compatible strings. The simplest way to convert those to
> > > > > schema is just add them into the common generic PCI host schema.
> > > > >
> > > > > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > > > > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > > > Cc: Andrew Murray <andrew.murray@arm.com>
> > > > > Cc: Zhou Wang <wangzhou1@hisilicon.com>
> > > > > Cc: Will Deacon <will@kernel.org>
> > > > > Cc: David Daney <david.daney@cavium.com>
> > > > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > >
> > > > > index 515b2f9542e5..000000000000
> > > > > --- a/Documentation/devicetree/bindings/pci/designware-pcie-ecam.txt
> > > > > +++ /dev/null
> > > >
> > > > > -Example:
> > > > > -
> > > > > -    pcie1: pcie@7f000000 {
> > > > > -        compatible = "socionext,synquacer-pcie-ecam", "snps,dw-pcie-ecam";
> > > > > -        device_type = "pci";
> > > > > -        reg = <0x0 0x7f000000 0x0 0xf00000>;
> > > > > -        bus-range = <0x0 0xe>;
> > > > > -        #address-cells = <3>;
> > > > > -        #size-cells = <2>;
> > > > > -        ranges = <0x1000000 0x00 0x00010000 0x00 0x7ff00000 0x0 0x00010000>,
> > > > > -                 <0x2000000 0x00 0x70000000 0x00 0x70000000 0x0 0x0f000000>,
> > > > > -                 <0x3000000 0x3f 0x00000000 0x3f 0x00000000 0x1 0x00000000>;
> > > > > -
> > > > > -        #interrupt-cells = <0x1>;
> > > > > -        interrupt-map-mask = <0x0 0x0 0x0 0x0>;
> > > >
> > > > An all-zeroes interrupt-map-mask seems to be very common on embedded
> > > > SoCs, where all devices are mapped to a single interrupt.
> > >
> > > Indeed.
> > >
> > > > However, schemas/pci/pci-bus.yaml says:
> > > >
> > > >   interrupt-map-mask:
> > > >     items:
> > > >       - description: PCI high address cell
> > > >         minimum: 0
> > > >         maximum: 0xf800
> > > >       - description: PCI mid address cell
> > > >         const: 0
> > > >       - description: PCI low address cell
> > > >         const: 0
> > > >       - description: PCI IRQ cell
> > > >         minimum: 1
> > > >         maximum: 7
> > > >
> > > > and thus complains about an all-zeroes mask, e.g.
> > > >
> > > >     arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dt.yaml:
> > > > pcie@fe000000: interrupt-map-mask:0:3: 0 is less than the minimum of 1
> > >
> > > Now fixed.
> >
> > Thank you, confirmed.
>
> And with latest renesas-drivers, I started seeing:
>
>     arch/arm/boot/dts/r8a7791-koelsch.dt.yaml: pci@ee0d0000:
> interrupt-map:0: [0, 0, 0, 1] is too short
>     arch/arm/boot/dts/r8a7791-koelsch.dt.yaml: pci@ee0d0000:
> interrupt-map:1: [5, 0, 113, 4] is too short
>     arch/arm/boot/dts/r8a7791-koelsch.dt.yaml: pci@ee0d0000:
> interrupt-map:2: [2048, 0, 0, 1] is too short
>     arch/arm/boot/dts/r8a7791-koelsch.dt.yaml: pci@ee0d0000:
> interrupt-map:3: [5, 0, 113, 4] is too short
>     arch/arm/boot/dts/r8a7791-koelsch.dt.yaml: pci@ee0d0000:
> interrupt-map:4: [4096, 0, 0, 2] is too short
>     arch/arm/boot/dts/r8a7791-koelsch.dt.yaml: pci@ee0d0000:
> interrupt-map:5: [5, 0, 113, 4] is too short
>
> Looks like interrupt-map is split incorrectly: shouldn't each entry have 8
> cells?

That must be with a current dtc which now splits the array before each
phandle. That works for phandle+args, but not *-map properties. :( I
was trying to avoid a bunch of dts updates to add brackets. I think
for now, I'll just drop the interrupt-map size constraint. It's not
all that accurate anyways as it doesn't look at cell sizes.

Rob
