Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6817389806
	for <lists+linux-pci@lfdr.de>; Wed, 19 May 2021 22:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbhESUhv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 May 2021 16:37:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:55240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229505AbhESUhu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 May 2021 16:37:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0EA0361353;
        Wed, 19 May 2021 20:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621456590;
        bh=hPDZ+qhFdL3l1wvU7xVmrc9Ovo2GaDsgSYaq2W7tiuc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=h+icgfG5fIC2bm1IbpxJ8ERv095myrQ0TEv7RQ6Sf7gbfsNW0VGyTHTOIiuCjYiMw
         G0Fl59Q7M9/2VGshEmzTKANvrn05Lb9HOKLPTp2F1UwZBRCyJV2sUlDIQhb2vZlVOQ
         EOv/cjOq5CLfVyYX3uqubQy5+btsPdT4c7F1VvAE4OPwoEbaesaXewazgwGDHg40AS
         Yq6m6eU2plVKWVbGeWasB2ipoW9cDWAbDVQcB3QfZhuaaXdvrZW6te81EZqa2yqxBX
         R2pKd+Q2nYsjNpYLP1XTH9loBQAz9sx4Ys7rLN1AEs/LH5djMU6ZD0c2ylZil+oX1I
         2LFFaGJ8eLTqw==
Date:   Wed, 19 May 2021 15:36:28 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     linux-mips@vger.kernel.org, tsbogend@alpha.franken.de,
        devicetree@vger.kernel.org, matthias.bgg@gmail.com,
        john@phrozen.org, bhelgaas@google.com, robh+dt@kernel.org,
        linux-staging@lists.linux.dev, gregkh@linuxfoundation.org,
        neil@brown.name, ilya.lipnitskiy@gmail.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/4] MIPS: ralink: pci: driver for Pcie controller in
 MT7621 SoCs
Message-ID: <20210519203628.GA254894@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210515124055.22225-1-sergio.paracuellos@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, May 15, 2021 at 02:40:51PM +0200, Sergio Paracuellos wrote:
> MediaTek MT7621 PCIe subsys supports single Root complex (RC)
> with 3 Root Ports. Each Root Ports supports a Gen1 1-lane Link.
> Topology is as follows:
> 
>                           MT7621 PCIe HOST Topology
> 
>                                    .-------.
>                                    |       |
>                                    |  CPU  |
>                                    |       |
>                                    '-------'
>                                        |
>                                        |
>                                        |
>                                        v
>                               .------------------.
>                   .-----------|  HOST/PCI Bridge |------------.
>                   |           '------------------'            |     Type1 
>          BUS0     |                     |                     |    Access 
>                   v                     v                     v    On Bus0
>           .-------------.        .-------------.       .-------------.
>           | VIRTUAL P2P |        | VIRTUAL P2P |       | VIRTUAL P2P |
>           |    BUS0     |        |    BUS0     |       |    BUS0     |
>           |    DEV0     |        |    DEV1     |       |    DEV2     |
>           '-------------'        '-------------'       '-------------'
>     Type0        |          Type0       |         Type0       |
>    Access   BUS1 |         Access   BUS2|        Access   BUS3|
>    On Bus1       v         On Bus2      v        On Bus3      v
>            .----------.           .----------.          .----------.
>            | Device 0 |           | Device 0 |          | Device 0 |
>            |  Func 0  |           |  Func 0  |          |  Func 0  |
>            '----------'           '----------'          '----------'
> 
> This driver has been very long time in staging and I have been cleaning
> it from its first versions where there was code kaos and PCI_LEGACY support.
> Original code came probably from openWRT based on mediatek's SDK code. There
> is no documentation at all about the mt7621 PCI subsystem.
> I have been cleaning it targeting mt7621 SoC which is the one I use in
> my GNUBee PC1 board and HiLink HLK-MT7621A evaluation board.
> 
> Now I think is clean enough to be moved into 'arch/mips/pci'.
> 
> This driver also uses already mainlined pci phy driver located in
> 'drivers/phy/ralink/phy-mt7621-pci.c'. There are two instances of
> the phy being the first one dual ported for pci0 and pci1, and the 
> second one not dual ported dedicated to pci2. Because of writing twice 
> some phy registers of the dual-ported one sometimes become in not
> confident boot cycles we have to take care of this when device link
> is checked here in controller driver. We power on the dual ported-phy
> if there is something connected in pcie0 or pcie1. In the same manner
> we have to properly disable it only if nothing is connected in of both
> pcie0 and pci1 slots.
> 
> Another thing that must be mentioned is that this driver uses IO
> in physical address 0x001e160000. IO_SPACE_LIMIT for MIPS is 0xffff
> so some generic PCI functions (like of_pci_range_to_resource) won't
> work and the resource ranges part for IO is set manually.
> 
> I had already sent binding documentation to be reviewed but I am
> include also here with the driver itself and this cover letter
> to make easy review process.
> 
> Best regards,
>     Sergio Paracuellos
> 
> Sergio Paracuellos (4):
>   dt-bindings: mt7621-pci: PCIe binding documentation for MT7621 SoCs
>   MIPS: pci: Add driver for MT7621 PCIe controller
>   staging: mt7621-pci: remove driver from staging

Generally it's better if the move can be done in one commit instead of
an add followed by a remove.

I see there are a bunch of MIPS PCI controller drivers in
arch/mips/pci/, so I see the argument for putting this one there as
well.

But most of the similar drivers are in drivers/pci/controller/, where
I think it's easier to keep them up to date with changes in the PCI
core.  Have you considered putting this one there?

>   MAINTAINERS: add myself as maintainer of the MT7621 PCI controller
>     driver
> 
>  .../bindings/pci/mediatek,mt7621-pci.yaml     | 149 ++++++++++++++++++
>  MAINTAINERS                                   |   6 +
>  arch/mips/pci/Makefile                        |   1 +
>  .../mt7621-pci => arch/mips/pci}/pci-mt7621.c |   0
>  arch/mips/ralink/Kconfig                      |   9 +-
>  drivers/staging/Kconfig                       |   2 -
>  drivers/staging/Makefile                      |   1 -
>  drivers/staging/mt7621-pci/Kconfig            |   8 -
>  drivers/staging/mt7621-pci/Makefile           |   2 -
>  drivers/staging/mt7621-pci/TODO               |   4 -
>  .../mt7621-pci/mediatek,mt7621-pci.txt        | 104 ------------
>  11 files changed, 164 insertions(+), 122 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/mediatek,mt7621-pci.yaml
>  rename {drivers/staging/mt7621-pci => arch/mips/pci}/pci-mt7621.c (100%)
>  delete mode 100644 drivers/staging/mt7621-pci/Kconfig
>  delete mode 100644 drivers/staging/mt7621-pci/Makefile
>  delete mode 100644 drivers/staging/mt7621-pci/TODO
>  delete mode 100644 drivers/staging/mt7621-pci/mediatek,mt7621-pci.txt
> 
> -- 
> 2.25.1
