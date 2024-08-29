Return-Path: <linux-pci+bounces-12458-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56EE29651BF
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2024 23:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F17E21F21DB3
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2024 21:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C5B18C013;
	Thu, 29 Aug 2024 21:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FwICQ8xe"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C01618C011
	for <linux-pci@vger.kernel.org>; Thu, 29 Aug 2024 21:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724966558; cv=none; b=UOnFWXdoIK0ZOaiAHCxC05U1by6j4hHi7rkKpE8nrc9u9xUw9SNC/VkBRLVtpJ2+oilie4ZxxBfww4ZW6zqaR948PXNnJJj1q0XKLcFw2QHRTJeuWPWE6EZP+pSDTFTS1ycLHCF/aW+wk5e35moPM2qCI3LFlZiDaii+H0gpW/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724966558; c=relaxed/simple;
	bh=tJJb8xJ62JG9n22LbTdsYhzdsfX5j09/4pagZlvFfyo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=D1eTFnGL4CJJCctY76xvqhNKEpnf+PIb3T/ottozAvef9gWgnYNKYLyS28IbFfWlStLNcHTIn4QuFHAATd/pB7zGXyEeQ4SsS6iiiw621ubukZE23ocfiBmHNa83N7ZFFo7nQLUD9wKXr/sDx8CUS42QpYnI6O9WyriauP8bATU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FwICQ8xe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F78BC4CEC1;
	Thu, 29 Aug 2024 21:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724966557;
	bh=tJJb8xJ62JG9n22LbTdsYhzdsfX5j09/4pagZlvFfyo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=FwICQ8xePheYMiEvCVtcz8B5E5t1rnQdLov71dBzK7L7aOS9CRf7sb+3ePpF/g9W6
	 O/j6ShR4BQEQZ8pWYy+kutWyndtRnOREYWGmtx7yzL7SrgkkIUMwkzJYmHrkixSJ5R
	 GzSEfVb6SwKAYg3AxoD1sQ+UeRMXh9K+o7ZHDjANzGfWCU9ldTcUsARe0bjfPb56Uo
	 jK5NLdcvjHsl9nWbKelA9GLJ6IjlS5QnfKWuNwuwQENmcl7/U9owrcNyKR1TG8iR/W
	 pqDeXbaHDXtVxl4j7JIcsW+oeVIZ/pEigS6J6ys98NMAhFdODBBVHLuY+1piKyf63P
	 /mCpRamBj3BGg==
Date: Thu, 29 Aug 2024 16:22:35 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Tim Harvey <tharvey@gateworks.com>, Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>
Cc: linux-pci@vger.kernel.org
Subject: Re: legacy PCI device behind a bridge not getting a valid IRQ on imx
 host controller
Message-ID: <20240829212235.GA68646@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ+vNU2YVpQ=csr-O65L_pcNFWbFMvHK4XO44cbfUfPKwuw6vg@mail.gmail.com>

[+cc Richard, Lucas, maintainers of IMX6 PCI]

On Wed, Aug 28, 2024 at 02:40:33PM -0700, Tim Harvey wrote:
> Greetings,
> 
> I have a user that is using an IMX8MM SoC (dwc controller) with a
> miniPCIe card that has a PEX8112 PCI-to-PCIe bridge to a legacy PCI
> device and the device is not getting a valid interrupt.

Does pci-imx6.c support INTx at all?

I see that drivers/pci/controller/dwc/pci-imx6.c supports both host
and endpoint modes, but the only mention of "intx" is for an IMX
device in endpoint mode to raise an INTx interrupt.

A few DWC-based drivers look like they support INTx:

  dra7xx_pcie_init_irq_domain
  ks_pcie_config_intx_irq
  rockchip_pcie_init_irq_domain (the dwc/pcie-dw-rockchip.c one)
  uniphier_pcie_config_intx_irq

but most (including pci-imx6.c) don't have anything that looks like
those.

> The PCI bus looks like this:
> 00.00.0: 16c3:abcd (rev 01)
> 01:00.0: 10b5:8112
> ^^^ PEX8112 x1 Lane PCI bridge
> 02:00.0: 4ddc:1a00
> 02:01.0: 4ddc:1a00
> ^^^ PCI devices
> 
> lspci -vvv -s 02:00.0:
> 02:00.0 Communication controller: ILC Data Device Corp Device 1a00 (rev 10)
>         Subsystem: ILC Data Device Corp Device 1a00
>         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium
> >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Interrupt: pin A routed to IRQ 0
>         Region 0: Memory at 18100000 (32-bit, non-prefetchable)
> [disabled] [size=256K]
>         Region 1: Memory at 18180000 (32-bit, non-prefetchable)
> [disabled] [size=4K]
> ^^^ 'Interrupt: pin A routed to IRQ 0' is wrong
> 
> I found an old thread from 2019 on an NVidia forum [1] where the same
> thing occurred and Nvidia's solution was a patch to the dwc driver to
> call pci_fixup_irqs():
> diff --git a/drivers/pci/dwc/pcie-designware-host.c
> b/drivers/pci/dwc/pcie-designware-host.c
> index ec2e4a61aa4e..a72ba177a5fd 100644
> --- a/drivers/pci/dwc/pcie-designware-host.c
> +++ b/drivers/pci/dwc/pcie-designware-host.c
> @@ -477,6 +477,8 @@ int dw_pcie_host_init(struct pcie_port *pp)
>         if (pp->ops->scan_bus)
>                 pp->ops->scan_bus(pp);
> 
> +       pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
> +
>         pci_bus_size_bridges(bus);
>         pci_bus_assign_resources(bus);
> 
> Since that time the pci/dwc drivers have changed quite a bit;
> pci_fixup_irqs() was changed to pci_assign_irq() called now from
> pcie_device_probe() and dw_pcie_host_init() calls commit init
> functions.
> 
> While I don't have the particular card in hand described above yet to
> test with, I did manage to reproduce this on an imx6dl soc (same dwc
> controller and driver) connected to a TI XIO2001 with an Intel I210
> behind it and see the exact same issue.
> 
> Does anyone understand why legacy PCI interrupt mapping behind a
> bridge isn't working here?
> 
> Best regards,
> 
> Tim
> [1] https://forums.developer.nvidia.com/t/xavier-not-routing-pci-interrupts-across-pex8112-bridge/78556

