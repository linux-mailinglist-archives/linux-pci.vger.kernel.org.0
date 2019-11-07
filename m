Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4998AF2A90
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2019 10:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733228AbfKGJ0K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Nov 2019 04:26:10 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39918 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbfKGJ0K (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Nov 2019 04:26:10 -0500
Received: by mail-oi1-f193.google.com with SMTP id v138so1361665oif.6;
        Thu, 07 Nov 2019 01:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=svJecAxqhlBawitftrz5LXbFY8d5ATbDsx3obREbmBk=;
        b=JaRiVyVnWoErWMwSLJsT3edCIFkLrM3bw9K+3t2YOtpGSIe5jPWeSfJJ3zV3UcGXyj
         wwR2NS63eTI2jFJYHyvrY1LIrbvvYORCOjhiH8sOou1LG6PPH6s0hxYi668s+Ia/fGNp
         mD+dKjP+i/vpXdma4xZtepheZ7yutdc9rzN+mceieTuhWlkhAMrPEFb/Jt3ett6SzSg9
         ELmfrBZVVLKH9oU9mvJlKOogzz4Xf2ygwEAneNX6k9Q9/CL4uLnu6olfZ/Y8MyINIPDf
         l05fDkGxYqctkz/xtGJFKge5gK+fg8G8ZLe5jNs9w3+fRrpZp6HQVuJW4G6WswW642hk
         BRQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=svJecAxqhlBawitftrz5LXbFY8d5ATbDsx3obREbmBk=;
        b=eWvCLpGlJ2B931V8o+ejF2ZRR2cbg1lISYEndpgZJ2HzTVpWuQbR8IeuDWUjFtDd+o
         6fucU+L5TPQzoHalkxOKuWrHUWq3DW3hvU4RadKH45FcP6X1JusIKHClZVKqU3ytBsP7
         Lf6oV+qc0CifUt1nbzAW1A6tJmc2+I6eqF9MO+1Dp82LcUumI0GhMXsHe0O8GATUBj/G
         Sg76/eVBJvXJmdY6Ppd2S5uLd7NDVwdObjzqta5rMcIk4MB5vGoJQcKb+qrp1EMEz2AW
         yHTQ52Po1a2DkT+hmHGuEgmNOhSxlfBYg//Lqxzr1pDWPKt7yG02osWQXo18lVm31Zie
         Xqrw==
X-Gm-Message-State: APjAAAVOi6G9kEFp7kl8s1QvE3I/qjfTyaL3ll1VKlwF/a3T8sKOj8E9
        h25vMlN+mS/0reJgR4/SybIHS630Vv3sR252mBoSP8QtILzD0w==
X-Google-Smtp-Source: APXvYqzl/mjJb58YCZv+1rPoz9YmBODStqICfxXp/t7vlm94pbfdzMz/foObeQbkPEnjt5Qa5497EWxx2Gk87u9uMzM=
X-Received: by 2002:aca:5cc6:: with SMTP id q189mr2405318oib.101.1573118768684;
 Thu, 07 Nov 2019 01:26:08 -0800 (PST)
MIME-Version: 1.0
References: <20191106193609.19645-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20191106193609.19645-4-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdVZwgVnq2kwjNJQHfvUH0sk6M7Hz-AJR82jMOsCNfW9wQ@mail.gmail.com>
In-Reply-To: <CAMuHMdVZwgVnq2kwjNJQHfvUH0sk6M7Hz-AJR82jMOsCNfW9wQ@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 7 Nov 2019 09:25:42 +0000
Message-ID: <CA+V-a8swtOUaxKnCdiTV5wvvxLEJ6XdODL=7bvQmFKY0zQTj2w@mail.gmail.com>
Subject: Re: [PATCH 3/5] PCI: rcar: Add R-Car PCIe endpoint device tree bindings
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Murray <andrew.murray@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Geert,

Thank you for the review.

On Thu, Nov 7, 2019 at 8:44 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Wed, Nov 6, 2019 at 8:36 PM Lad Prabhakar <prabhakar.csengg@gmail.com> wrote:
> > From: "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > This patch adds the bindings for the R-Car PCIe endpoint driver.
> >
> > Signed-off-by: Lad, Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Thanks for your patch!
>
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/rcar-pci-ep.txt
> > @@ -0,0 +1,43 @@
> > +* Renesas R-Car PCIe Endpoint Controller DT description
> > +
> > +Required properties:
> > +           "renesas,pcie-ep-r8a774c0" for the R8A774C0 SoC;
> > +           "renesas,pcie-ep-rcar-gen3" for a generic R-Car Gen3 or
> > +                                    RZ/G2 compatible device.
>
> Unless I'm missing something, this is for the exact same hardware block as
> Documentation/devicetree/bindings/pci/rcar-pci.txt?
> So shouldn't you amend those bindings, instead of adding new compatible
> values?
> Please remember that DT describes hardware, not software policy.
> So IMHO choosing between host and endpoint is purely a configuration
> issue, and could be indicated by the presence or lack of some DT properties.
> E.g. host mode requires both "bus-range" and "device_type" properties,
> so their absence could indicate endpoint mode.
>
yes its the same hardware block as described in the rcar-pci.txt, I
did think about amending it
but  it might turn out to be bit messy,

required properties host ======required properties Endpoint
====================||==================
1: reg                                || reg
2:bus-range                      || reg names
3: device_type                  || resets
4: ranges                          || clocks
5: dma-ranges                  || clock-names
6: interrupts                      ||
7: interrupt-cells               ||
8: interrupt-map-mask     ||
9: clocks                          ||
10: clock-names             ||

and if I go ahead with the same compatible string that would mean to
add support for endpoint
mode in the host driver itself. I did follow the examples of
rockchip/cadence/designware where
its the same hardware block but has two different binding files one
for host mode and other for
endpoint mode.

> > +- reg: Five register ranges as listed in the reg-names property
> > +- reg-names: Must include the following names
> > +       - "apb-base"
> > +       - "memory0"
> > +       - "memory1"
> > +       - "memory2"
> > +       - "memory3"
>
> What is the purpose of the last 4 regions?
> Can they be chosen by the driver, at runtime?
>
no the driver cannot choose them at runtime, as these are the only
PCIE memory(0/1/2/3) ranges
in the AXI address space where host memory can be mapped.

> > +- resets: Must contain phandles to PCIe-related reset lines exposed by IP block
> > +- clocks: from common clock binding: clock specifiers for the PCIe controller
> > +        clock.
> > +- clock-names: from common clock binding: should be "pcie".
> > +
> > +Optional Property:
> > +- max-functions: Maximum number of functions that can be configured (default 1).
> > +
> > +Example:
> > +
> > +SoC-specific DT Entry:
> > +
> > +       pcie_ep: pcie_ep@fe000000 {
> > +               compatible = "renesas,pcie-r8a7791", "renesas,pcie-rcar-gen2";
>
> These compatible values do not match with the ones above
> (but they match with what I'd like to see ;-)
>
my bad I'll update them to reflect the above.

Cheers,
--Prabhakar

> > +               reg = <0 0xfe000000 0 0x80000>,
> > +                       <0x0 0xfe100000 0 0x100000>,
> > +                       <0x0 0xfe200000 0 0x200000>,
> > +                       <0x0 0x30000000 0 0x8000000>,
> > +                       <0x0 0x38000000 0 0x8000000>;
> > +               reg-names = "apb-base", "memory0", "memory1", "memory2", "memory3";
> > +               clocks = <&cpg CPG_MOD 319>;
> > +               clock-names = "pcie";
> > +               power-domains = <&sysc R8A774C0_PD_ALWAYS_ON>;
> > +               resets = <&cpg 319>;
> > +       };
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
