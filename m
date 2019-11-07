Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9447EF3BB0
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2019 23:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfKGWq4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Nov 2019 17:46:56 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34184 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbfKGWq4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Nov 2019 17:46:56 -0500
Received: by mail-oi1-f195.google.com with SMTP id l202so3565738oig.1;
        Thu, 07 Nov 2019 14:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=amQWDmlGdEk6VIZvnzvC3PXl4QjX449VLWxbEA+kkns=;
        b=hX/QIOjtVkzlExtn1LqyXrmyI9I9vZhyZHkCpvmC5Ale44vry7ayGIKDeCOW9S9eWE
         JpeUDWKn0dzomnJvGQC6UlsW56ZHBQcAFlz9OGRK5JKMmF8OQJCvygqW3vGmRflED+jd
         7TVoAMvk/E/hCIVf+TF4Rw15L3pIjoLxe6vzgKi3MMKtHJGRkQ4P3udSwk7lQ/KkFi1q
         4+JwIHOVSXZPmO22hcGzdgMMwdD5dIgcqbDpY2MUuiExDnrRclHY9cxPzrywI1OJf+je
         DHDOJuou1WQXs1iIbJn26gQ/7aneup7yHphtwjJ2VHCPP00fXPXSMgDrk47Jvp42ikcP
         rLIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=amQWDmlGdEk6VIZvnzvC3PXl4QjX449VLWxbEA+kkns=;
        b=kv5ry7P3CeYs2IUNiDHYP1YoOzaU5l4sYTVpZH8hQ6mfcbT9GSwEydPgovRgDYiOJr
         KpbZxreDfnrxM6Uj86w1jiJtXy1AarpWdyKUVH+8BQGPYLY8aUBobu8a8xuS3llDdkES
         1AvF2EuW/P5r82gi+UuqXvN5TjIVchPhHRTH4+/V1LrusDy2QODYKnujW2/mb1+nQLW9
         wJEPYnofNSil0K5wKeEkbGl68xkUOQ6AyLgZd7C4JHdIQKiIyYyoi1WriIydc3duL0SH
         mETUV88V7JmxobhLVdynCwkGc6TA7mEyiuz7hPETg5iJM1PeajhsiYVH8yFm+qoJKfuK
         pN8g==
X-Gm-Message-State: APjAAAXBlZqSjuNjvVcn+ckiUScICr1+JHxC3Sy2bvqnTJmcz2mokQXk
        XGRY7qgn3NGZinFGDMFGQL49QPWyChzozKXEgfY=
X-Google-Smtp-Source: APXvYqy7X5y3xi+caVjj34JWeqvFAD42ny9HBvVuYNQgKnsmmxiFAbNuD/jPPDzS6BjPiNY4G/MO7hwzdru7pOmcrd8=
X-Received: by 2002:aca:2303:: with SMTP id e3mr5878670oie.162.1573166814674;
 Thu, 07 Nov 2019 14:46:54 -0800 (PST)
MIME-Version: 1.0
References: <20191106193609.19645-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20191106193609.19645-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdVZwgVnq2kwjNJQHfvUH0sk6M7Hz-AJR82jMOsCNfW9wQ@mail.gmail.com>
 <CA+V-a8swtOUaxKnCdiTV5wvvxLEJ6XdODL=7bvQmFKY0zQTj2w@mail.gmail.com> <CAMuHMdXkbWkQgswMNL7Dw7_jucH+MsuAW+-CjoGVYsm=tjShRw@mail.gmail.com>
In-Reply-To: <CAMuHMdXkbWkQgswMNL7Dw7_jucH+MsuAW+-CjoGVYsm=tjShRw@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 7 Nov 2019 22:46:28 +0000
Message-ID: <CA+V-a8sS4gX8o__R_pHK2Otb=s_aAWbtvDLfOhAQAJb77Jz_Sw@mail.gmail.com>
Subject: Re: [PATCH 3/5] PCI: rcar: Add R-Car PCIe endpoint device tree bindings
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
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

On Thu, Nov 7, 2019 at 8:08 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Thu, Nov 7, 2019 at 10:26 AM Lad, Prabhakar
> <prabhakar.csengg@gmail.com> wrote:
> > On Thu, Nov 7, 2019 at 8:44 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Wed, Nov 6, 2019 at 8:36 PM Lad Prabhakar <prabhakar.csengg@gmail.com> wrote:
> > > > From: "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > >
> > > > This patch adds the bindings for the R-Car PCIe endpoint driver.
> > > >
> > > > Signed-off-by: Lad, Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >
> > > Thanks for your patch!
> > >
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/pci/rcar-pci-ep.txt
> > > > @@ -0,0 +1,43 @@
> > > > +* Renesas R-Car PCIe Endpoint Controller DT description
> > > > +
> > > > +Required properties:
> > > > +           "renesas,pcie-ep-r8a774c0" for the R8A774C0 SoC;
> > > > +           "renesas,pcie-ep-rcar-gen3" for a generic R-Car Gen3 or
> > > > +                                    RZ/G2 compatible device.
> > >
> > > Unless I'm missing something, this is for the exact same hardware block as
> > > Documentation/devicetree/bindings/pci/rcar-pci.txt?
> > > So shouldn't you amend those bindings, instead of adding new compatible
> > > values?
> > > Please remember that DT describes hardware, not software policy.
> > > So IMHO choosing between host and endpoint is purely a configuration
> > > issue, and could be indicated by the presence or lack of some DT properties.
> > > E.g. host mode requires both "bus-range" and "device_type" properties,
> > > so their absence could indicate endpoint mode.
> > >
> > yes its the same hardware block as described in the rcar-pci.txt, I
> > did think about amending it
> > but  it might turn out to be bit messy,
> >
> > required properties host ======required properties Endpoint
> > ====================||==================
> > 1: reg                                || reg
> > 2:bus-range                      || reg names
> > 3: device_type                  || resets
> > 4: ranges                          || clocks
> > 5: dma-ranges                  || clock-names
> > 6: interrupts                      ||
> > 7: interrupt-cells               ||
> > 8: interrupt-map-mask     ||
> > 9: clocks                          ||
> > 10: clock-names             ||
>
> We have a similar situation with SPI, where a controller can operate in
> master or slave mode, based on the absence or presence of the
> "spi-slave" DT property.
>
> > and if I go ahead with the same compatible string that would mean to
> > add support for endpoint
> > mode in the host driver itself. I did follow the examples of
>
> You can still have two separate drivers, binding against the same
> compatible value.  Just let the .probe() function return -ENODEV if it
> discovers (by looking at DT properties) if the node is configured for
> the other mode.
> Which brings us to my next questions: is there any code that could be
> shared between the drivers for the two modes?
>
agreed driver probe could handle depending on the DT properties.
yes there is bit of common code and the first patch of the series prepares
for handling host and endpoint mode.

> > rockchip/cadence/designware where
> > its the same hardware block but has two different binding files one
> > for host mode and other for
> > endpoint mode.
>
> Having two separate DT binding documents sounds fine to me, if unifying
> them makes things too complex.
> However, I think they should use the same compatible value, because the
> hardware block is the same, but just used in a different mode.
>
agreed.

> Rob/Mark: Any input from the DT maintainers?
>
> > > > +- reg: Five register ranges as listed in the reg-names property
> > > > +- reg-names: Must include the following names
> > > > +       - "apb-base"
> > > > +       - "memory0"
> > > > +       - "memory1"
> > > > +       - "memory2"
> > > > +       - "memory3"
> > >
> > > What is the purpose of the last 4 regions?
> > > Can they be chosen by the driver, at runtime?
> > >
> > no the driver cannot choose them at runtime, as these are the only
> > PCIE memory(0/1/2/3) ranges
> > in the AXI address space where host memory can be mapped.
>
> Are they fixed by the PCIe hardware, i.e. could they be looked up by the
> driver based on the compatible value?
>
yes they are fixed by the PCIe hardware and could be looked up by the driver
based on the compatible value.

Cheers,
--Prabhakar
