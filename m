Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B16B4217F5
	for <lists+linux-pci@lfdr.de>; Mon,  4 Oct 2021 21:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234763AbhJDTxp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Oct 2021 15:53:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:46696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234691AbhJDTxo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 Oct 2021 15:53:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 79BF4610A5;
        Mon,  4 Oct 2021 19:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633377115;
        bh=ftIISwj5VomvNZxJNk+YRaZbhRwimc0N+dZ0U1M/kNM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JvNxsoxP0lBgAXvh4kDSdCWDVFWoqH3CZyIVwRdbN7aUKBCGwK7qvedJ1TbprIUUQ
         9e2LPSbyQhdhMwzdvy58yqhrF29wamamie7tgj+7gVfOGNMZClu+Sv/99vbJDKuEu1
         kCnTurgGjhCYj4/fl3VdxWRl9gUZmC3TGJj/w1U+C3JzL5Gyadwt/XoJ9L1Iqd9ZEv
         HTgjjhAaxCbNiD7bpQyiSk/AtOyUOgMvrLPeyHtWlTB8ybVbh/qhvBTCfJRnOv56O7
         hDD6u3Q6FfDaOBP+lSTJygSjbFTQhKX6reAE/WBze8Py/cG5+fLKY0TRvJmVkrKvyk
         rKZP2qmbV2ZUw==
Received: by mail-ed1-f49.google.com with SMTP id b8so34757224edk.2;
        Mon, 04 Oct 2021 12:51:55 -0700 (PDT)
X-Gm-Message-State: AOAM533mAr1R6PLSK+klJbK2lH6IHC4oAtROvH9D6g815cN0hi/EgK4b
        6NUXVxDRntLjUBmlPlZElF0xR/ycz7LT6KZukw==
X-Google-Smtp-Source: ABdhPJzSaN7S7ALG3yUJraf/vtQi93nFDytVl2mghUeFAx99vVF0KnNziH2QYzN9Y4g3zdY/aY6ClGPdGsHoEzYDI9c=
X-Received: by 2002:a17:906:7217:: with SMTP id m23mr19125282ejk.466.1633377114021;
 Mon, 04 Oct 2021 12:51:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210929163847.2807812-1-maz@kernel.org> <20211004083845.GA22336@lpieralisi>
In-Reply-To: <20211004083845.GA22336@lpieralisi>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 4 Oct 2021 14:51:39 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+4FF9QYy87aYhJ-AS78qyHp0NkLrL492+WmdyWj-NKaw@mail.gmail.com>
Message-ID: <CAL_Jsq+4FF9QYy87aYhJ-AS78qyHp0NkLrL492+WmdyWj-NKaw@mail.gmail.com>
Subject: Re: [PATCH v5 00/14] PCI: Add support for Apple M1
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Marc Zyngier <maz@kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Stan Skowronek <stan@corellium.com>,
        Mark Kettenis <kettenis@openbsd.org>,
        Sven Peter <sven@svenpeter.dev>,
        Hector Martin <marcan@marcan.st>,
        Robin Murphy <Robin.Murphy@arm.com>,
        Joey Gouly <joey.gouly@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 4, 2021 at 3:38 AM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Wed, Sep 29, 2021 at 05:38:33PM +0100, Marc Zyngier wrote:
> > This is v5 of the series adding PCIe support for the M1 SoC. Not a lot
> > has changed this time around, and most of what I was saying in [1] is
> > still valid.
> >
> > Very little has changed code wise (a couple of bug fixes). The series
> > however now carries a bunch of DT updates so that people can actually
> > make use of PCIe on an M1 box (OK, not quite, you will still need [2],
> > or whatever version replaces it). The corresponding bindings are
> > either already merged, or queued for 5.16 (this is the case for the
> > PCI binding).
> >
> > It all should be in a state that makes it mergeable (yeah, I said that
> > last time... I mean it this time! ;-).
> >
> > As always, comments welcome.
> >
> >       M.
> >
> > [1] https://lore.kernel.org/r/20210922205458.358517-1-maz@kernel.org
> > [2] https://lore.kernel.org/r/20210921222956.40719-2-joey.gouly@arm.com
> >
> > Alyssa Rosenzweig (2):
> >   PCI: apple: Add initial hardware bring-up
> >   PCI: apple: Set up reference clocks when probing
> >
> > Marc Zyngier (10):
> >   irqdomain: Make of_phandle_args_to_fwspec generally available
> >   of/irq: Allow matching of an interrupt-map local to an interrupt
> >     controller
> >   PCI: of: Allow matching of an interrupt-map local to a PCI device
> >   PCI: apple: Add INTx and per-port interrupt support
> >   PCI: apple: Implement MSI support
> >   iommu/dart: Exclude MSI doorbell from PCIe device IOVA range
> >   PCI: apple: Configure RID to SID mapper on device addition
> >   arm64: dts: apple: t8103: Add PCIe DARTs
> >   arm64: dts: apple: t8103: Add root port interrupt routing
> >   arm64: dts: apple: j274: Expose PCI node for the Ethernet MAC address
> >
> > Mark Kettenis (2):
> >   arm64: apple: Add pinctrl nodes
> >   arm64: apple: Add PCIe node
> >
> >  MAINTAINERS                              |   7 +
> >  arch/arm64/boot/dts/apple/t8103-j274.dts |  23 +
> >  arch/arm64/boot/dts/apple/t8103.dtsi     | 203 ++++++
> >  drivers/iommu/apple-dart.c               |  27 +
> >  drivers/of/irq.c                         |  17 +-
> >  drivers/pci/controller/Kconfig           |  17 +
> >  drivers/pci/controller/Makefile          |   1 +
> >  drivers/pci/controller/pcie-apple.c      | 822 +++++++++++++++++++++++
> >  drivers/pci/of.c                         |  10 +-
> >  include/linux/irqdomain.h                |   4 +
> >  kernel/irq/irqdomain.c                   |   6 +-
> >  11 files changed, 1127 insertions(+), 10 deletions(-)
> >  create mode 100644 drivers/pci/controller/pcie-apple.c
>
> I have applied (with very minor log changes) patches [1-9] to
> pci/apple for v5.16, I expect the dts changes to go via the
> arm-soc tree separately, please let me know if that works for you.

FYI, I pushed patches 1-3 to kernelCI and didn't see any regressions.
I am a bit worried about changes to the DT interrupt parsing and
ancient platforms (such as PowerMacs). Most likely there wouldn't be
any report until -rc1 or months later on those old systems.

Rob
