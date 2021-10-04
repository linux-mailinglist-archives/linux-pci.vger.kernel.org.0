Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAB98420766
	for <lists+linux-pci@lfdr.de>; Mon,  4 Oct 2021 10:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbhJDIkl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Oct 2021 04:40:41 -0400
Received: from foss.arm.com ([217.140.110.172]:49040 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229720AbhJDIkl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 Oct 2021 04:40:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 66FA71FB;
        Mon,  4 Oct 2021 01:38:52 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6ABC93F66F;
        Mon,  4 Oct 2021 01:38:50 -0700 (PDT)
Date:   Mon, 4 Oct 2021 09:38:45 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Stan Skowronek <stan@corellium.com>,
        Mark Kettenis <kettenis@openbsd.org>,
        Sven Peter <sven@svenpeter.dev>,
        Hector Martin <marcan@marcan.st>,
        Robin Murphy <Robin.Murphy@arm.com>,
        Joey Gouly <joey.gouly@arm.com>,
        Joerg Roedel <joro@8bytes.org>, kernel-team@android.com
Subject: Re: [PATCH v5 00/14] PCI: Add support for Apple M1
Message-ID: <20211004083845.GA22336@lpieralisi>
References: <20210929163847.2807812-1-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210929163847.2807812-1-maz@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 29, 2021 at 05:38:33PM +0100, Marc Zyngier wrote:
> This is v5 of the series adding PCIe support for the M1 SoC. Not a lot
> has changed this time around, and most of what I was saying in [1] is
> still valid.
> 
> Very little has changed code wise (a couple of bug fixes). The series
> however now carries a bunch of DT updates so that people can actually
> make use of PCIe on an M1 box (OK, not quite, you will still need [2],
> or whatever version replaces it). The corresponding bindings are
> either already merged, or queued for 5.16 (this is the case for the
> PCI binding).
> 
> It all should be in a state that makes it mergeable (yeah, I said that
> last time... I mean it this time! ;-).
> 
> As always, comments welcome.
> 
> 	M.
> 
> [1] https://lore.kernel.org/r/20210922205458.358517-1-maz@kernel.org
> [2] https://lore.kernel.org/r/20210921222956.40719-2-joey.gouly@arm.com
> 
> Alyssa Rosenzweig (2):
>   PCI: apple: Add initial hardware bring-up
>   PCI: apple: Set up reference clocks when probing
> 
> Marc Zyngier (10):
>   irqdomain: Make of_phandle_args_to_fwspec generally available
>   of/irq: Allow matching of an interrupt-map local to an interrupt
>     controller
>   PCI: of: Allow matching of an interrupt-map local to a PCI device
>   PCI: apple: Add INTx and per-port interrupt support
>   PCI: apple: Implement MSI support
>   iommu/dart: Exclude MSI doorbell from PCIe device IOVA range
>   PCI: apple: Configure RID to SID mapper on device addition
>   arm64: dts: apple: t8103: Add PCIe DARTs
>   arm64: dts: apple: t8103: Add root port interrupt routing
>   arm64: dts: apple: j274: Expose PCI node for the Ethernet MAC address
> 
> Mark Kettenis (2):
>   arm64: apple: Add pinctrl nodes
>   arm64: apple: Add PCIe node
> 
>  MAINTAINERS                              |   7 +
>  arch/arm64/boot/dts/apple/t8103-j274.dts |  23 +
>  arch/arm64/boot/dts/apple/t8103.dtsi     | 203 ++++++
>  drivers/iommu/apple-dart.c               |  27 +
>  drivers/of/irq.c                         |  17 +-
>  drivers/pci/controller/Kconfig           |  17 +
>  drivers/pci/controller/Makefile          |   1 +
>  drivers/pci/controller/pcie-apple.c      | 822 +++++++++++++++++++++++
>  drivers/pci/of.c                         |  10 +-
>  include/linux/irqdomain.h                |   4 +
>  kernel/irq/irqdomain.c                   |   6 +-
>  11 files changed, 1127 insertions(+), 10 deletions(-)
>  create mode 100644 drivers/pci/controller/pcie-apple.c

I have applied (with very minor log changes) patches [1-9] to
pci/apple for v5.16, I expect the dts changes to go via the
arm-soc tree separately, please let me know if that works for you.

Thanks,
Lorenzo
