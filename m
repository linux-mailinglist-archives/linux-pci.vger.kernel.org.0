Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37412410B6D
	for <lists+linux-pci@lfdr.de>; Sun, 19 Sep 2021 14:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235773AbhISMDl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 19 Sep 2021 08:03:41 -0400
Received: from rosenzweig.io ([138.197.143.207]:46608 "EHLO rosenzweig.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231956AbhISMDf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 19 Sep 2021 08:03:35 -0400
Date:   Sun, 19 Sep 2021 07:39:32 -0400
From:   Alyssa Rosenzweig <alyssa@rosenzweig.io>
To:     Marc Zyngier <maz@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Stan Skowronek <stan@corellium.com>,
        Mark Kettenis <kettenis@openbsd.org>,
        Sven Peter <sven@svenpeter.dev>,
        Hector Martin <marcan@marcan.st>,
        Robin Murphy <Robin.Murphy@arm.com>, kernel-team@android.com
Subject: Re: [PATCH v3 00/10] PCI: Add support for Apple M1
Message-ID: <YUchdKwx6Ce2KaYw@sunset>
References: <20210913182550.264165-1-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210913182550.264165-1-maz@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thanks for giving this another push, the changes look great. The series
is

	Tested-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>

On Mon, Sep 13, 2021 at 07:25:40PM +0100, Marc Zyngier wrote:
> I have resumed my earlier effort to bring the Apple-M1 into the world
> of living by equipping it with a PCIe controller driver. Huge thanks
> to Alyssa Rosenzweig for kicking it into shape and providing the first
> two versions of this series.
> 
> Much has changed since v2[2]. Mark Kettenis is doing a great job with
> the binding [0], so I have dropped that from the series, and strictly
> focused on the Linux side of thing. I am now using this binding as is,
> with the exception of a single line change, which I believe is a fix
> [1].
> 
> Supporting the per-port interrupt controller has brought in a couple
> of fixes for the core DT code.  Also, some work has gone into dealing
> with excluding the MSI page from the IOVA range, as well as
> programming the RID-to-SID mapper.
> 
> Overall, the driver is now much cleaner and most probably feature
> complete when it comes to supporting internal devices (although I
> haven't investigated things like power management). TB support is
> another story, and will require some more hacking.
> 
> This of course still depends on the clock and pinctrl drivers that are
> otherwise in flight, and will affect this driver one way or another.
> I have pushed a branch with all the dependencies (and more) at [3].
> 
> * From v2 [2]:
>   - Refactor DT parsing to match the new version of the binding
>   - Add support for INTx and port-private interrupts
>   - Signal link-up/down using interrupts
>   - Export of_phandle_args_to_fwspec
>   - Fix generic parsing of interrupt map
>   - Rationalise port setup (data structure, self discovery)
>   - Tell DART to exclude MSI doorbell from the IOVA mappings
>   - Get rid of the setup bypass if the link was found up on boot
>   - Prevent the module from being removed
>   - Program the RID-to-SID mapper on device discovery
>   - Rebased on 5.15-rc1
> 
> [0] https://lore.kernel.org/r/20210827171534.62380-1-mark.kettenis@xs4all.nl
> [1] https://lore.kernel.org/r/871r5tcwhp.wl-maz@kernel.org
> [2] https://lore.kernel.org/r/20210816031621.240268-1-alyssa@rosenzweig.io
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/log/?h=hack/m1-pcie-v3
> 
> Alyssa Rosenzweig (2):
>   PCI: apple: Add initial hardware bring-up
>   PCI: apple: Set up reference clocks when probing
> 
> Marc Zyngier (8):
>   irqdomain: Make of_phandle_args_to_fwspec generally available
>   of/irq: Allow matching of an interrupt-map local to an interrupt
>     controller
>   PCI: of: Allow matching of an interrupt-map local to a pci device
>   PCI: apple: Add INTx and per-port interrupt support
>   arm64: apple: t8103: Add root port interrupt routing
>   PCI: apple: Implement MSI support
>   iommu/dart: Exclude MSI doorbell from PCIe device IOVA range
>   PCI: apple: Configure RID to SID mapper on device addition
> 
>  MAINTAINERS                          |   7 +
>  arch/arm64/boot/dts/apple/t8103.dtsi |  33 +-
>  drivers/iommu/apple-dart.c           |  25 +
>  drivers/of/irq.c                     |  17 +-
>  drivers/pci/controller/Kconfig       |  17 +
>  drivers/pci/controller/Makefile      |   1 +
>  drivers/pci/controller/pcie-apple.c  | 818 +++++++++++++++++++++++++++
>  drivers/pci/of.c                     |  10 +-
>  include/linux/irqdomain.h            |   4 +
>  kernel/irq/irqdomain.c               |   6 +-
>  10 files changed, 925 insertions(+), 13 deletions(-)
>  create mode 100644 drivers/pci/controller/pcie-apple.c
> 
> -- 
> 2.30.2
> 
