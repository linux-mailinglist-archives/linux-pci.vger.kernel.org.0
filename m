Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E580CF4244
	for <lists+linux-pci@lfdr.de>; Fri,  8 Nov 2019 09:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730622AbfKHIhJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Nov 2019 03:37:09 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38724 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbfKHIhI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Nov 2019 03:37:08 -0500
Received: by mail-oi1-f196.google.com with SMTP id a14so4563048oid.5;
        Fri, 08 Nov 2019 00:37:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y06rTA9jyJ3Mxb7FOxzfvb/JyrQ6mJjiIx0NSmTLT3w=;
        b=AWGAXSm2c0Yspjg8qNfi6qHsKYdT1nOowipVHrrzRIY4GxtI7ot9O1Zfw5uq7Adp4D
         7KfRmLixTQMMcHFngqAPbmevJXWNkAFvVp2FGkS/uTgGnJo0jmGk7tLLqX4G/YHHLvGT
         ibBR54MlIv1+6/lMYCcfxYHazihL/v3mSsfp9o1jEqaBSAZ3sdAgc36l/8UWMZlyN8PX
         bUsafmAfcbSAcF1YsJwSH+a6wkfcIbcgwEOoJ2aaB/+QRPVOCYNHmREqkROQb8cxTlum
         jALbQIj5xwQApIVc7L1uH0gCudKUV4DxpiZIUWmmYaOehXsJ8E3KpW5Jb30VK47HvwIm
         ZIbA==
X-Gm-Message-State: APjAAAUSMGdMvDVklv3rjLryuFKYu1rOj0IhzB18+1Psp8NdeXGr7EtS
        yE2/G58kgV/i2hcCJbqH7LJI+yt+fMKEVFOHUJ0=
X-Google-Smtp-Source: APXvYqw443xjtR/GhQGqZswNAQFjWLyPmQgXA4uSDYnc1ZjfU91/njipFK4I8i0EWJx17iUi7lyKc1yYaFBEyegxbZY=
X-Received: by 2002:aca:fc92:: with SMTP id a140mr7932910oii.153.1573202227574;
 Fri, 08 Nov 2019 00:37:07 -0800 (PST)
MIME-Version: 1.0
References: <20191106193609.19645-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20191106193609.19645-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdVZwgVnq2kwjNJQHfvUH0sk6M7Hz-AJR82jMOsCNfW9wQ@mail.gmail.com>
 <CA+V-a8swtOUaxKnCdiTV5wvvxLEJ6XdODL=7bvQmFKY0zQTj2w@mail.gmail.com>
 <CAMuHMdXkbWkQgswMNL7Dw7_jucH+MsuAW+-CjoGVYsm=tjShRw@mail.gmail.com> <CA+V-a8sS4gX8o__R_pHK2Otb=s_aAWbtvDLfOhAQAJb77Jz_Sw@mail.gmail.com>
In-Reply-To: <CA+V-a8sS4gX8o__R_pHK2Otb=s_aAWbtvDLfOhAQAJb77Jz_Sw@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 8 Nov 2019 09:36:56 +0100
Message-ID: <CAMuHMdVDdweR5Mx+RLnKCkw0kb2J=AMsAPoFm8PVbxsY2u-EvA@mail.gmail.com>
Subject: Re: [PATCH 3/5] PCI: rcar: Add R-Car PCIe endpoint device tree bindings
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
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

Hi Prabhakar,

On Thu, Nov 7, 2019 at 11:46 PM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
> On Thu, Nov 7, 2019 at 8:08 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Thu, Nov 7, 2019 at 10:26 AM Lad, Prabhakar
> > <prabhakar.csengg@gmail.com> wrote:
> > > On Thu, Nov 7, 2019 at 8:44 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > On Wed, Nov 6, 2019 at 8:36 PM Lad Prabhakar <prabhakar.csengg@gmail.com> wrote:
> > > > > From: "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > >
> > > > > This patch adds the bindings for the R-Car PCIe endpoint driver.
> > > > >
> > > > > Signed-off-by: Lad, Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > >
> > > > > --- /dev/null
> > > > > +++ b/Documentation/devicetree/bindings/pci/rcar-pci-ep.txt

> > > > > +- reg: Five register ranges as listed in the reg-names property
> > > > > +- reg-names: Must include the following names
> > > > > +       - "apb-base"
> > > > > +       - "memory0"
> > > > > +       - "memory1"
> > > > > +       - "memory2"
> > > > > +       - "memory3"
> > > >
> > > > What is the purpose of the last 4 regions?
> > > > Can they be chosen by the driver, at runtime?
> > > >
> > > no the driver cannot choose them at runtime, as these are the only
> > > PCIE memory(0/1/2/3) ranges
> > > in the AXI address space where host memory can be mapped.
> >
> > Are they fixed by the PCIe hardware, i.e. could they be looked up by the
> > driver based on the compatible value?
> >
> yes they are fixed by the PCIe hardware and could be looked up by the driver
> based on the compatible value.

Thanks, so we don't need to describe them in DT.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
