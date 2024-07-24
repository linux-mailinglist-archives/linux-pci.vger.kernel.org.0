Return-Path: <linux-pci+bounces-10728-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E3993B40B
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 17:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAF6E1C203A8
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 15:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4B715B14F;
	Wed, 24 Jul 2024 15:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lgs+a+Gj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0202014D293;
	Wed, 24 Jul 2024 15:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721835797; cv=none; b=l7HnRuL1hC6HsgMdhnKWZkE66hCmrbqDzlajAxvz6R+b4oEIFIsoSObgZiCFtuT/pZBEcTLhfIjwgQKTPI+U7ESRcoxxUatiy0c6HlTFG+YS5Kcuu73p9hBvpAV+Wmo4KY0/wrbBg+1mQGPHPWcu1Hw/vPnhgPISQDBaGI6EuJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721835797; c=relaxed/simple;
	bh=CAUscHClM0Mm+A7tgR9qonZKiiwkl9RkhG3FCitYr3g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=EifzuOBAaXgRNm0cPFtZC/I8ubuTceLhTQOkC9TmG5RC0auom3z9zxkGhNIrLyGjUbZFSISYB2HR9FeLnJFugYnf/jsjUYJ3Z0swwuLRTlILQpU7pXEBvTNFh9eWUj7usPgR2WSqrwMP83uvHwKPX2hrIt+OKWVDJmqCUBZFcu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lgs+a+Gj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37506C32782;
	Wed, 24 Jul 2024 15:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721835796;
	bh=CAUscHClM0Mm+A7tgR9qonZKiiwkl9RkhG3FCitYr3g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Lgs+a+Gj8Z6SEL3m6Ih6tZ1yAEtVhA0Gd0o9Nsgm6NY39oGgx2+lpT3+puUYV4ewx
	 0VncHfOrm5ibiNkfpvfo4yOl14RmuPzrNvBWdCx/gYYwj/FxpG1XnbyqvIZqZGfgrN
	 QICGF1WW5OhI/rnZx6IhUVs4ZxBDXhXxR/nZcEVWx96Cmq75t+POuM7nvub19/S+Sj
	 mH87+JNrMabZAJAFNC3dHn2JV/0eAtwNjddtwjn3Xh/nFi/07VgNCKZNnvtIM4v+6W
	 1Wj8vFKn2VuaUF8nTLSDOam4hSFiSDlKJfz0KaTxGzV39mi35OtigfkFFSUsBDXg9n
	 6YaXj3FJjAjCQ==
Date: Wed, 24 Jul 2024 10:43:14 -0500
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
Message-ID: <20240724154314.GA800620@bhelgaas>
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

Happy to apply this series via the PCI tree given an ack from Thomas.

In that event I would rewrap the commit logs to fit in 75 columns and
include a note in the driver patches about what event causes the
warning.  No need to repost for that unless other changes are needed.

Thanks for doing this work!

Bjorn

