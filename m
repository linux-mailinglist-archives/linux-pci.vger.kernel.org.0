Return-Path: <linux-pci+bounces-10852-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0382093D8CD
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jul 2024 20:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD25F1F24032
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jul 2024 18:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B34F56B7C;
	Fri, 26 Jul 2024 18:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r2BOaxW+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F234A3BBC1;
	Fri, 26 Jul 2024 18:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722020232; cv=none; b=t6ajPzfUE791TZWUSki82auv1uGyzmDtuNcRw7+wrSpADOiBb4JNHtm+YRFTBltlcoYxxV0BTwHGdaEwSzJ7h/P8eyghW5U2+/6eHojyYdAdhh8T7FxPth84TZHSv/yAD12MdQiFgDuY6lM3dByjnByil/37G3EYX4y5mz/Zzjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722020232; c=relaxed/simple;
	bh=Uvx/6FUt2w2n0+6JKlzy90R2S4AjzIQtW71B2uzDqM4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=twflmjMkqk2clx4bJYeEOpi7TioD5gGqaA1rNeBsF+CChDZgTnpZTD8Y7VsDP40Ps87zzf+u9WnpQbhQynfCP+X4dIReZVKcMgEl1qcYOJAePoUAtcjjG5ye3IJ/tSdFdseQfc/iTSJIKYG9MUsMatNSClYJc3ON4Q4NlbKhpYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r2BOaxW+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F51DC32782;
	Fri, 26 Jul 2024 18:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722020231;
	bh=Uvx/6FUt2w2n0+6JKlzy90R2S4AjzIQtW71B2uzDqM4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=r2BOaxW+oeaI0t/luo31fVhWfq332hRgd8uSffX1taaJHF+otgFrMC8UrVgjxqpmr
	 PKw9NNvznSbSSHI2d5+UsG9WP3T0TJ8CLee4wTUdFJe43ebAINXTIFnv/bWI+Eik0b
	 z1+XANr/gsKATUGXENhm9RjB1L+FM6Q3q/c58Br+2QyUXOyDZbqE/FRGqNqbPcw2SG
	 ia0Sddm+7Ir5JFSqUiX4qlDVhcliw7mGziqECJvdciJ8TJ2Il16ZopOaJged42mNwG
	 s8P9BEPtCal2VvMeUdzWxPEtFIMXHswSsF7VkjgHtTahhHdDlk7d9s0EuIUzGu5Z4J
	 q1Y0B6F4ReeFw==
Date: Fri, 26 Jul 2024 13:57:09 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-pci@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Aleksandr Mishin <amishin@t-argos.ru>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Anup Patel <apatel@ventanamicro.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Jim Quinlan <jim2101024@gmail.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	Joyce Ooi <joyce.ooi@intel.com>,
	Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Koichiro Den <den@valinux.co.jp>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Marc Zyngier <maz@kernel.org>, Michal Simek <michal.simek@amd.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Rob Herring <robh@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>,
	Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v4 00/15] genirq/msi: Silence set affinity failed warning
Message-ID: <20240726185709.GA915987@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240723132958.41320-1-marek.vasut+renesas@mailbox.org>

On Tue, Jul 23, 2024 at 03:27:00PM +0200, Marek Vasut wrote:
> Various PCIe controllers that mux MSIs onto single IRQ line produce these
> "IRQ%d: set affinity failed" warnings when entering suspend. Remove the
> .irq_set_affinity callbacks and make sure they are NULL in all affected
> controllers, so this warning in kernel/irq/msi.c is not triggered.
> 
> This has been compile-tested only on all but the R-Car PCI controller.
> 
> The clean ups are done per-driver so they can be easily reverted in case
> they break something.
> 
> Marek Vasut (15):
>   genirq/msi: Silence set affinity failed warning
>   PCI: aardvark: Silence set affinity failed warning
>   PCI: altera-msi: Silence set affinity failed warning
>   PCI: brcmstb: Silence set affinity failed warning
>   PCI: dwc: Silence set affinity failed warning
>   PCI: mediatek-gen3: Silence set affinity failed warning
>   PCI: mediatek: Silence set affinity failed warning
>   PCI: mobiveil: Silence set affinity failed warning
>   PCI: plda: Silence set affinity failed warning
>   PCI: rcar-host: Silence set affinity failed warning
>   PCI: tegra: Silence set affinity failed warning
>   PCI: vmd: Silence set affinity failed warning
>   PCI: xilinx-nwl: Silence set affinity failed warning
>   PCI: xilinx-xdma: Silence set affinity failed warning
>   PCI: xilinx: Silence set affinity failed warning
> 
>  drivers/pci/controller/dwc/pci-keystone.c           |  7 -------
>  drivers/pci/controller/dwc/pcie-designware-host.c   | 12 +++---------
>  .../pci/controller/mobiveil/pcie-mobiveil-host.c    | 11 ++---------
>  drivers/pci/controller/pci-aardvark.c               | 10 ++--------
>  drivers/pci/controller/pci-tegra.c                  | 10 ++--------
>  drivers/pci/controller/pcie-altera-msi.c            | 11 ++---------
>  drivers/pci/controller/pcie-brcmstb.c               | 11 ++---------
>  drivers/pci/controller/pcie-mediatek-gen3.c         | 13 +++----------
>  drivers/pci/controller/pcie-mediatek.c              | 11 ++---------
>  drivers/pci/controller/pcie-rcar-host.c             | 10 ++--------
>  drivers/pci/controller/pcie-xilinx-dma-pl.c         | 11 ++---------
>  drivers/pci/controller/pcie-xilinx-nwl.c            | 11 ++---------
>  drivers/pci/controller/pcie-xilinx.c                |  9 ++-------
>  drivers/pci/controller/plda/pcie-plda-host.c        | 11 ++---------
>  drivers/pci/controller/vmd.c                        | 13 +------------
>  include/linux/msi.h                                 |  2 ++
>  kernel/irq/msi.c                                    |  2 +-
>  17 files changed, 32 insertions(+), 133 deletions(-)

Applied to pci/controller/affinity for v6.11, thank you very much for
doing this work!

I pushed this branch, but it won't show up in linux-next until after
v6.12-rc1 is tagged.

