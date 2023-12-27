Return-Path: <linux-pci+bounces-1447-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0305681EFF4
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 17:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3449A1C2182B
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 16:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29CA045BE0;
	Wed, 27 Dec 2023 16:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RDUSz3x7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B5145957;
	Wed, 27 Dec 2023 16:01:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E58BDC433C8;
	Wed, 27 Dec 2023 16:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703692906;
	bh=7a+WYRcymZpVJwO2xqRNQ9oKeNvlyPKazAZWNEeClp4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RDUSz3x7DMcbqrF+oP0YkyMUhLwNJJxE/Dz4TDUif8Y+lpEMUwb5QUzgGDUjLbwYH
	 ER3L2Dp84YwnNioNSnTedOYugjwvxlvbhqFjyKvpIvUfrA6qZWaF/5VmFL1mlxUMzz
	 i5aRWIbwA4UQZLqe+eVhkHh9QwOSousYdOvFejTqFva3AdeT7TyGDYnHAS6XmfXawK
	 7wF+PujrT784ySN0YF+40/zR5yAftS5ZJYZLtnkot3wW/UipZILEw88Ka2YQV86flL
	 BLRVuP+nZd37/cT+wdAN4SElBwPp09z2XTol3qjgweuz4oVfhBhRR961NRT/glKFQw
	 1qb76U0TsIzCA==
Date: Wed, 27 Dec 2023 17:01:38 +0100
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Minda Chen <minda.chen@starfivetech.com>
Cc: Conor Dooley <conor@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
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
Subject: Re: [PATCH v13 12/21] PCI: microchip: Add request_event_irq()
 callback function
Message-ID: <ZYxKYhVycTOfbDTI@lpieralisi>
References: <20231214072839.2367-1-minda.chen@starfivetech.com>
 <20231214072839.2367-13-minda.chen@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214072839.2367-13-minda.chen@starfivetech.com>

On Thu, Dec 14, 2023 at 03:28:30PM +0800, Minda Chen wrote:
> PolarFire implements specific PCIe interrupts except PLDA local interrupt.

Please explain to me what you want to say here.

> For lack of MSI controller, these interrupts have to be added to global
> event field. PolarFire PCIe driver also register additional interrupt
> symbol name.

And here.

> PolarFire PCIe contain total 28 interrupts event while PLDA contain 13
> local interrupts event, interrupt to event num mapping is different.

It "is different" in different platforms ? Is that correct ?

> So add a callback function to support different IRQ register function.
> Also Add PLDA default handler function, which will be moved to pcie-
> plda-host.c in moving codes patch.

As I said before, a patch is a single self-contained change, don't
refer to other patches, they may or may not be merged or even exist
by the time this one hits mainline.

Lorenzo

> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  .../pci/controller/plda/pcie-microchip-host.c | 31 ++++++++++++++++---
>  drivers/pci/controller/plda/pcie-plda.h       |  5 +++
>  2 files changed, 32 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c b/drivers/pci/controller/plda/pcie-microchip-host.c
> index 7b3f4f74745d..624e4e2e97d3 100644
> --- a/drivers/pci/controller/plda/pcie-microchip-host.c
> +++ b/drivers/pci/controller/plda/pcie-microchip-host.c
> @@ -643,6 +643,11 @@ static irqreturn_t mc_event_handler(int irq, void *dev_id)
>  	return IRQ_HANDLED;
>  }
>  
> +static irqreturn_t plda_event_handler(int irq, void *dev_id)
> +{
> +	return IRQ_HANDLED;
> +}
> +
>  static void plda_handle_event(struct irq_desc *desc)
>  {
>  	struct plda_pcie_rp *port = irq_desc_get_handler_data(desc);
> @@ -804,6 +809,17 @@ static int mc_pcie_init_clks(struct device *dev)
>  	return 0;
>  }
>  
> +static int mc_request_event_irq(struct plda_pcie_rp *plda, int event_irq,
> +				int event)
> +{
> +	return devm_request_irq(plda->dev, event_irq, mc_event_handler,
> +				0, event_cause[event].sym, plda);
> +}
> +
> +static const struct plda_event mc_event = {
> +	.request_event_irq = mc_request_event_irq,
> +};
> +
>  static int plda_pcie_init_irq_domains(struct plda_pcie_rp *port)
>  {
>  	struct device *dev = port->dev;
> @@ -905,7 +921,9 @@ static void mc_disable_interrupts(struct mc_pcie *port)
>  	writel_relaxed(GENMASK(31, 0), bridge_base_addr + ISTATUS_HOST);
>  }
>  
> -static int plda_init_interrupts(struct platform_device *pdev, struct plda_pcie_rp *port)
> +static int plda_init_interrupts(struct platform_device *pdev,
> +				struct plda_pcie_rp *port,
> +				const struct plda_event *event)
>  {
>  	struct device *dev = &pdev->dev;
>  	int irq;
> @@ -929,8 +947,13 @@ static int plda_init_interrupts(struct platform_device *pdev, struct plda_pcie_r
>  			return -ENXIO;
>  		}
>  
> -		ret = devm_request_irq(dev, event_irq, mc_event_handler,
> -				       0, event_cause[i].sym, port);
> +		if (event->request_event_irq)
> +			ret = event->request_event_irq(port, event_irq, i);
> +		else
> +			ret = devm_request_irq(dev, event_irq,
> +					       plda_event_handler,
> +					       0, NULL, port);
> +
>  		if (ret) {
>  			dev_err(dev, "failed to request IRQ %d\n", event_irq);
>  			return ret;
> @@ -984,7 +1007,7 @@ static int mc_platform_init(struct pci_config_window *cfg)
>  		return ret;
>  
>  	/* Address translation is up; safe to enable interrupts */
> -	ret = plda_init_interrupts(pdev, &port->plda);
> +	ret = plda_init_interrupts(pdev, &port->plda, &mc_event);
>  	if (ret)
>  		return ret;
>  
> diff --git a/drivers/pci/controller/plda/pcie-plda.h b/drivers/pci/controller/plda/pcie-plda.h
> index e3d35cef9894..28ed1374e1de 100644
> --- a/drivers/pci/controller/plda/pcie-plda.h
> +++ b/drivers/pci/controller/plda/pcie-plda.h
> @@ -121,6 +121,11 @@ struct plda_pcie_rp {
>  	int num_events;
>  };
>  
> +struct plda_event {
> +	int (*request_event_irq)(struct plda_pcie_rp *pcie,
> +				 int event_irq, int event);
> +};
> +
>  void plda_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
>  			    phys_addr_t axi_addr, phys_addr_t pci_addr,
>  			    size_t size);
> -- 
> 2.17.1
> 

