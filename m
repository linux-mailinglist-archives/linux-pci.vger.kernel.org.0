Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC99A4153EB
	for <lists+linux-pci@lfdr.de>; Thu, 23 Sep 2021 01:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238481AbhIVXeT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Sep 2021 19:34:19 -0400
Received: from sibelius.xs4all.nl ([83.163.83.176]:56277 "EHLO
        sibelius.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238480AbhIVXeS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Sep 2021 19:34:18 -0400
Received: from localhost (bloch.sibelius.xs4all.nl [local])
        by bloch.sibelius.xs4all.nl (OpenSMTPD) with ESMTPA id f6097b85;
        Thu, 23 Sep 2021 01:32:45 +0200 (CEST)
Date:   Thu, 23 Sep 2021 01:32:45 +0200 (CEST)
From:   Mark Kettenis <mark.kettenis@xs4all.nl>
To:     Marc Zyngier <maz@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, bhelgaas@google.com, robh+dt@kernel.org,
        lorenzo.pieralisi@arm.com, kw@linux.com, alyssa@rosenzweig.io,
        stan@corellium.com, kettenis@openbsd.org, sven@svenpeter.dev,
        marcan@marcan.st, Robin.Murphy@arm.com, kernel-team@android.com
In-Reply-To: <20210922205458.358517-1-maz@kernel.org> (message from Marc
        Zyngier on Wed, 22 Sep 2021 21:54:48 +0100)
Subject: Re: [PATCH v4 00/10] PCI: Add support for Apple M1
References: <20210922205458.358517-1-maz@kernel.org>
Message-ID: <56147a3cb0fae762@bloch.sibelius.xs4all.nl>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> From: Marc Zyngier <maz@kernel.org>
> Date: Wed, 22 Sep 2021 21:54:48 +0100
> 
> This is v4 of the series adding PCIe support for the M1 SoC. Not a lot
> has changed this time around, and most of what I was saying in [1] is
> still valid.
> 
> The most important change is that the driver now probes for the number
> of RID-SID mapping registers instead of assuming 64 entries. The rest
> is a bunch of limited cleanups and minor fixes.
> 
> This should now be in a state that makes it mergeable, although I
> expect that some of the clock bits may have to be adapted (I haven't
> followed the recent developments on that front).

The current understanding is that the M1 SoC really only has power
domains.  Fortunately power domains are handled automagically by the
Linux kernel (and U-Boot) so this driver doesn't have to worry about
this.

I already changed the 4/4 diff of my DT bindings series to add a
"power-domains" property instead of a "clocks" property.  So once
marcan's power manager driver lands everything should just work.  Some
coordination on the patch that changes the DT itself is probably
required.  But we could simply leave out the "power-domains" property
until the power manager driver lands as m1n1 currently already turns
on the power domain.

Cheers,

Mark

> As always, comments welcome.
> 
> [1] https://lore.kernel.org/r/20210913182550.264165-1-maz@kernel.org
> 
> Alyssa Rosenzweig (2):
>   PCI: apple: Add initial hardware bring-up
>   PCI: apple: Set up reference clocks when probing
> 
> Marc Zyngier (8):
>   irqdomain: Make of_phandle_args_to_fwspec generally available
>   of/irq: Allow matching of an interrupt-map local to an interrupt
>     controller
>   PCI: of: Allow matching of an interrupt-map local to a PCI device
>   PCI: apple: Add INTx and per-port interrupt support
>   arm64: apple: t8103: Add root port interrupt routing
>   PCI: apple: Implement MSI support
>   iommu/dart: Exclude MSI doorbell from PCIe device IOVA range
>   PCI: apple: Configure RID to SID mapper on device addition
> 
>  MAINTAINERS                          |   7 +
>  arch/arm64/boot/dts/apple/t8103.dtsi |  33 +-
>  drivers/iommu/apple-dart.c           |  27 +
>  drivers/of/irq.c                     |  17 +-
>  drivers/pci/controller/Kconfig       |  17 +
>  drivers/pci/controller/Makefile      |   1 +
>  drivers/pci/controller/pcie-apple.c  | 826 +++++++++++++++++++++++++++
>  drivers/pci/of.c                     |  10 +-
>  include/linux/irqdomain.h            |   4 +
>  kernel/irq/irqdomain.c               |   6 +-
>  10 files changed, 935 insertions(+), 13 deletions(-)
>  create mode 100644 drivers/pci/controller/pcie-apple.c
> 
> -- 
> 2.30.2
> 
> 
