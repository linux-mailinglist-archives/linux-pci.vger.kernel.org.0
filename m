Return-Path: <linux-pci+bounces-4263-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5245186CC68
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 16:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9C0D1F22A58
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 15:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB341419B5;
	Thu, 29 Feb 2024 15:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qbE142na"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42D7141995;
	Thu, 29 Feb 2024 15:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709219331; cv=none; b=ob++XbgfYLMCWtYvz0q3r2v8ZLBhRbAuhgf/cbPzSGKmRYJG99tc+/9IFO8HtvXX3rGG0wmxJpJRMNjXKB+M2twec0+8+/P01Wl+DT6+fiY3ZmXj/zEggwpc59g9+EXGtBPu5wauslAsKjyq6tQeL5RnO0j4OdYZCvxu3BH52pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709219331; c=relaxed/simple;
	bh=1Zyw6/15dc8py4UHaheILppIr29j2DVuoJ+GnLmxmI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X9XJiR3pC9M4eo+I2oYI5kOqL8g/TeCyy3VLvHFl3GyvsQopbtVY6d8G9W20DJ7ufg/uBiRgo2mV4xJwdftuYY9AzyA4/hEFWG9XA9x76yd6BYciaOQjGaGsUN7FuCe7Y3ekJkUIBzHlyaYsp2w5fkZg5PkSvb0vvmqLnHE2ILk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qbE142na; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8C5DC43394;
	Thu, 29 Feb 2024 15:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709219331;
	bh=1Zyw6/15dc8py4UHaheILppIr29j2DVuoJ+GnLmxmI0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qbE142naa92rUgW7jL/DgquUxvIA8orHcRMgUTDyddce65pfDrm5hqA2gW1XhNEW1
	 M9mhn4t1LH5FmGr+9vxIZj3lWezTgwutUTT9MFvgOEbxD3MUXBEe2+gj4i08VwWHnU
	 AZRLl0FrHrOBNbBj3B9joRiitw1QbIUaM58sENEelec+3rzJe+v9gtvOJ1DxJBcLVC
	 Q992XY0FVty+LT18+GMGFLjH+GGFEJ1RwHcuUU8sIFGQGNxQ6B3B/4vFkw5Aq7alGS
	 57Xq1IPbNKu1IcM0c12i1Q/3MttMRGg6tdlxmEibgCn3P5lMdEJsiugpx10dhXtF+l
	 hPvdF3nQRkfWg==
Date: Thu, 29 Feb 2024 16:08:43 +0100
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Minda Chen <minda.chen@starfivetech.com>
Cc: Conor Dooley <conor@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-pci@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Mason Huo <mason.huo@starfivetech.com>,
	Leyfoon Tan <leyfoon.tan@starfivetech.com>,
	Kevin Xie <kevin.xie@starfivetech.com>
Subject: Re: [PATCH v15,RESEND 22/23] PCI: starfive: Offload the NVMe timeout
 workaround to host drivers.
Message-ID: <ZeCd+xqE6x2ZFtJN@lpieralisi>
References: <20240227103522.80915-1-minda.chen@starfivetech.com>
 <20240227103522.80915-23-minda.chen@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227103522.80915-23-minda.chen@starfivetech.com>

On Tue, Feb 27, 2024 at 06:35:21PM +0800, Minda Chen wrote:
> From: Kevin Xie <kevin.xie@starfivetech.com>
> 
> As the Starfive JH7110 hardware can't keep two inbound post write in
> order all the time, such as MSI messages and NVMe completions. If the
> NVMe completion update later than the MSI, an NVMe IRQ handle will miss.

Please explain what the problem is and what "NVMe completions" means
given that you are talking about posted writes.

If you have a link to an erratum write-up it would certainly help.

This looks completely broken to me, if the controller can't guarantee
PCIe transactions ordering it is toast, there is not even a point
considering mainline merging.

> As a workaround, we will wait a while before going to the generic
> handle here.
> 
> Verified with NVMe SSD, USB SSD, R8169 NIC.
> The performance are stable and even higher after this patch.

I assume this is a joke even though it does not make me laugh.

Thanks,
Lorenzo

> 
> Signed-off-by: Kevin Xie <kevin.xie@starfivetech.com>
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> ---
>  drivers/pci/controller/plda/pcie-plda-host.c | 12 ++++++++++++
>  drivers/pci/controller/plda/pcie-plda.h      |  1 +
>  drivers/pci/controller/plda/pcie-starfive.c  |  1 +
>  3 files changed, 14 insertions(+)
> 
> diff --git a/drivers/pci/controller/plda/pcie-plda-host.c b/drivers/pci/controller/plda/pcie-plda-host.c
> index a18923d7cea6..9e077ddf45c0 100644
> --- a/drivers/pci/controller/plda/pcie-plda-host.c
> +++ b/drivers/pci/controller/plda/pcie-plda-host.c
> @@ -13,6 +13,7 @@
>  #include <linux/msi.h>
>  #include <linux/pci_regs.h>
>  #include <linux/pci-ecam.h>
> +#include <linux/delay.h>
>  
>  #include "pcie-plda.h"
>  
> @@ -44,6 +45,17 @@ static void plda_handle_msi(struct irq_desc *desc)
>  			       bridge_base_addr + ISTATUS_LOCAL);
>  		status = readl_relaxed(bridge_base_addr + ISTATUS_MSI);
>  		for_each_set_bit(bit, &status, msi->num_vectors) {
> +			/*
> +			 * As the Starfive JH7110 hardware can't keep two
> +			 * inbound post write in order all the time, such as
> +			 * MSI messages and NVMe completions.
> +			 * If the NVMe completion update later than the MSI,
> +			 * an NVMe IRQ handle will miss.
> +			 * As a workaround, we will wait a while before
> +			 * going to the generic handle here.
> +			 */
> +			if (port->msi_quirk_delay_us)
> +				udelay(port->msi_quirk_delay_us);
>  			ret = generic_handle_domain_irq(msi->dev_domain, bit);
>  			if (ret)
>  				dev_err_ratelimited(dev, "bad MSI IRQ %d\n",
> diff --git a/drivers/pci/controller/plda/pcie-plda.h b/drivers/pci/controller/plda/pcie-plda.h
> index 04e385758a2f..feccf285dfe8 100644
> --- a/drivers/pci/controller/plda/pcie-plda.h
> +++ b/drivers/pci/controller/plda/pcie-plda.h
> @@ -186,6 +186,7 @@ struct plda_pcie_rp {
>  	int msi_irq;
>  	int intx_irq;
>  	int num_events;
> +	u16 msi_quirk_delay_us;
>  };
>  
>  struct plda_event {
> diff --git a/drivers/pci/controller/plda/pcie-starfive.c b/drivers/pci/controller/plda/pcie-starfive.c
> index 9bb9f0e29565..5cfc30572b7f 100644
> --- a/drivers/pci/controller/plda/pcie-starfive.c
> +++ b/drivers/pci/controller/plda/pcie-starfive.c
> @@ -391,6 +391,7 @@ static int starfive_pcie_probe(struct platform_device *pdev)
>  
>  	plda->host_ops = &sf_host_ops;
>  	plda->num_events = PLDA_MAX_EVENT_NUM;
> +	plda->msi_quirk_delay_us = 1;
>  	/* mask doorbell event */
>  	plda->events_bitmap = GENMASK(PLDA_INT_EVENT_NUM - 1, 0)
>  			     & ~BIT(PLDA_AXI_DOORBELL)
> -- 
> 2.17.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

