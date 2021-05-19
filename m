Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0601738987A
	for <lists+linux-pci@lfdr.de>; Wed, 19 May 2021 23:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbhESVUJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 May 2021 17:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbhESVUJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 May 2021 17:20:09 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD3EC06175F;
        Wed, 19 May 2021 14:18:48 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id b25so14502539oic.0;
        Wed, 19 May 2021 14:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZOtbChdXBxToRMqf8wzHNBcmP1hef8N7fN7VXXJvh1Y=;
        b=N5OruzcxQbm+vUoqVTRqVuicCog8Zs33FaA8Llj1zwCKiPRUjTDnOnZPwcL/G7PqaH
         hY+2JMVaMgoQsRX1yyZotg85j3qeM/sdn7jcSQutmf+rtn4nXPCHk2Jo4pY9BjWBC8Er
         XnQ3S6t3r/HhqpwdRxVxnDSwCUxE4RhX0r2eJGanSWSDNI9c3e9vgQ15rP0WuVmdLAoJ
         S1K7BY94iiqa0QxvvwEtJZ/bsaZTMmKT8Ki7UCLnL6fweeWxhgk8O+w5uy+eCKKXw17K
         Wbw7pAZutdZvAWDK4rKp5luyfKEYXuwfX4OvVQXmkQ22OUjzTmbTIfK6wh/cjCBLz1q7
         /+UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZOtbChdXBxToRMqf8wzHNBcmP1hef8N7fN7VXXJvh1Y=;
        b=m1+K0Uw2cz0kJOBNdfSAWA5pLxcOrZnLe2yfrSFsNFo1z4o76Al6qbXzhDbsIratq/
         f75WSjw2BA8PTN28agPIRXvxpBh1uwbeMgzopwiY3RT4Frb6DVHRNIrJEh/PfV7ydG6P
         gF+vgPmp86/NxiVwKk6ZJkJ1wK8kT02feDqSh8HvoNT64BmPCAp/o9DkAavxpHd3PCKW
         QBttofjJshVaPfINtzbLo5LqL1drarcPqXOmkFuKr8X4PHOJ3DlnJd4dcHcnt5+wj1ir
         o6/vQkju1w5MbAc+Vckk7OdxKEls87fh30fqugDmtmZ7FC7iTMQIbVTXchVmggARkDc/
         81uQ==
X-Gm-Message-State: AOAM531mglt8WZF1vLy9HWVaXzeLam67scP+38D3fLrNyVdiE6koDItd
        GeW2k27a8qhHjm3HQkgFjCYvQUSDey/aWle27zWWDmypLlLqow==
X-Google-Smtp-Source: ABdhPJz1LlSO20IL+T0lzkoFL38bGJpk72JRf/c6uyVWtY3eQX3RwkRwLhFkXZodu7j+8xJMO565zx0A5kREfIOLVuU=
X-Received: by 2002:aca:b5c4:: with SMTP id e187mr924572oif.149.1621459126929;
 Wed, 19 May 2021 14:18:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210515124055.22225-1-sergio.paracuellos@gmail.com> <20210519203628.GA254894@bjorn-Precision-5520>
In-Reply-To: <20210519203628.GA254894@bjorn-Precision-5520>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Wed, 19 May 2021 23:18:36 +0200
Message-ID: <CAMhs-H-7Ocjp6JLKcS9_hMn77H=st8JBdLXgxc+yYiypFTjrvQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] MIPS: ralink: pci: driver for Pcie controller in
 MT7621 SoCs
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "open list:MIPS" <linux-mips@vger.kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        John Crispin <john@phrozen.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-staging@lists.linux.dev,
        Greg KH <gregkh@linuxfoundation.org>,
        NeilBrown <neil@brown.name>,
        Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On Wed, May 19, 2021 at 10:36 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Sat, May 15, 2021 at 02:40:51PM +0200, Sergio Paracuellos wrote:
> > MediaTek MT7621 PCIe subsys supports single Root complex (RC)
> > with 3 Root Ports. Each Root Ports supports a Gen1 1-lane Link.
> > Topology is as follows:
> >
> >                           MT7621 PCIe HOST Topology
> >
> >                                    .-------.
> >                                    |       |
> >                                    |  CPU  |
> >                                    |       |
> >                                    '-------'
> >                                        |
> >                                        |
> >                                        |
> >                                        v
> >                               .------------------.
> >                   .-----------|  HOST/PCI Bridge |------------.
> >                   |           '------------------'            |     Type1
> >          BUS0     |                     |                     |    Access
> >                   v                     v                     v    On Bus0
> >           .-------------.        .-------------.       .-------------.
> >           | VIRTUAL P2P |        | VIRTUAL P2P |       | VIRTUAL P2P |
> >           |    BUS0     |        |    BUS0     |       |    BUS0     |
> >           |    DEV0     |        |    DEV1     |       |    DEV2     |
> >           '-------------'        '-------------'       '-------------'
> >     Type0        |          Type0       |         Type0       |
> >    Access   BUS1 |         Access   BUS2|        Access   BUS3|
> >    On Bus1       v         On Bus2      v        On Bus3      v
> >            .----------.           .----------.          .----------.
> >            | Device 0 |           | Device 0 |          | Device 0 |
> >            |  Func 0  |           |  Func 0  |          |  Func 0  |
> >            '----------'           '----------'          '----------'
> >
> > This driver has been very long time in staging and I have been cleaning
> > it from its first versions where there was code kaos and PCI_LEGACY support.
> > Original code came probably from openWRT based on mediatek's SDK code. There
> > is no documentation at all about the mt7621 PCI subsystem.
> > I have been cleaning it targeting mt7621 SoC which is the one I use in
> > my GNUBee PC1 board and HiLink HLK-MT7621A evaluation board.
> >
> > Now I think is clean enough to be moved into 'arch/mips/pci'.
> >
> > This driver also uses already mainlined pci phy driver located in
> > 'drivers/phy/ralink/phy-mt7621-pci.c'. There are two instances of
> > the phy being the first one dual ported for pci0 and pci1, and the
> > second one not dual ported dedicated to pci2. Because of writing twice
> > some phy registers of the dual-ported one sometimes become in not
> > confident boot cycles we have to take care of this when device link
> > is checked here in controller driver. We power on the dual ported-phy
> > if there is something connected in pcie0 or pcie1. In the same manner
> > we have to properly disable it only if nothing is connected in of both
> > pcie0 and pci1 slots.
> >
> > Another thing that must be mentioned is that this driver uses IO
> > in physical address 0x001e160000. IO_SPACE_LIMIT for MIPS is 0xffff
> > so some generic PCI functions (like of_pci_range_to_resource) won't
> > work and the resource ranges part for IO is set manually.
> >
> > I had already sent binding documentation to be reviewed but I am
> > include also here with the driver itself and this cover letter
> > to make easy review process.
> >
> > Best regards,
> >     Sergio Paracuellos
> >
> > Sergio Paracuellos (4):
> >   dt-bindings: mt7621-pci: PCIe binding documentation for MT7621 SoCs
> >   MIPS: pci: Add driver for MT7621 PCIe controller
> >   staging: mt7621-pci: remove driver from staging
>
> Generally it's better if the move can be done in one commit instead of
> an add followed by a remove.

I have no problem at all to just move the driver instead of add and
remove. But it is easier to review initially in this way. No other
reason but this one. So, if after review is ok, we can just move this
in the way you are pointing out here.

>
> I see there are a bunch of MIPS PCI controller drivers in
> arch/mips/pci/, so I see the argument for putting this one there as
> well.
>
> But most of the similar drivers are in drivers/pci/controller/, where
> I think it's easier to keep them up to date with changes in the PCI
> core.  Have you considered putting this one there?

Most pci drivers in 'arch/mips/pci' are still using PCI_LEGACY stuff.
In contrast mt7621-pci is using current pci generic apis but even most
of the code is generic enough, there is one remaining thing which
depends on mips architecture which is the iocu region configuration
which must be done in the driver itself. This is the only reason to
move this driver into 'arch/mips/pci' instead of
'drivers/pci/controller/'. So... I am all ears to listen to
suggestions for the proper place for this driver. Thomas, do you have
any thoughts on this?

Thanks,
    Sergio Paracuellos
>
> >   MAINTAINERS: add myself as maintainer of the MT7621 PCI controller
> >     driver
> >
> >  .../bindings/pci/mediatek,mt7621-pci.yaml     | 149 ++++++++++++++++++
> >  MAINTAINERS                                   |   6 +
> >  arch/mips/pci/Makefile                        |   1 +
> >  .../mt7621-pci => arch/mips/pci}/pci-mt7621.c |   0
> >  arch/mips/ralink/Kconfig                      |   9 +-
> >  drivers/staging/Kconfig                       |   2 -
> >  drivers/staging/Makefile                      |   1 -
> >  drivers/staging/mt7621-pci/Kconfig            |   8 -
> >  drivers/staging/mt7621-pci/Makefile           |   2 -
> >  drivers/staging/mt7621-pci/TODO               |   4 -
> >  .../mt7621-pci/mediatek,mt7621-pci.txt        | 104 ------------
> >  11 files changed, 164 insertions(+), 122 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/pci/mediatek,mt7621-pci.yaml
> >  rename {drivers/staging/mt7621-pci => arch/mips/pci}/pci-mt7621.c (100%)
> >  delete mode 100644 drivers/staging/mt7621-pci/Kconfig
> >  delete mode 100644 drivers/staging/mt7621-pci/Makefile
> >  delete mode 100644 drivers/staging/mt7621-pci/TODO
> >  delete mode 100644 drivers/staging/mt7621-pci/mediatek,mt7621-pci.txt
> >
> > --
> > 2.25.1
