Return-Path: <linux-pci+bounces-1446-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D99081EFEB
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 16:56:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00DFB1F22103
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 15:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3349D4597A;
	Wed, 27 Dec 2023 15:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eOCfbm9r"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125D945972;
	Wed, 27 Dec 2023 15:56:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7037AC433C8;
	Wed, 27 Dec 2023 15:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703692567;
	bh=2dDoT75kv/oEIqdjYxZYVu3NpzG/XSGl5XTfRlLCFek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eOCfbm9rrvfOib7hd9V3ikMY13DudlrtqsDVLQC3rOrVqPrRppkSzIOaCF111b1uA
	 8PUq90U+oXoV8fq0MBCjy6GOk/FxV37P41bLBVy05cdX/hgb+yhj/EB/GkludCtBur
	 E5dobc62YxFKjBNdwaYvXZiK0tCiHxvSRwRj2VN5oGXZw/ea8UZ5uS64naSt1WBpDv
	 OlRraCfBzS75S58+FNGBp1RoaTo2SKTWhTvXGKPm9iZaCYYSrvbezQLawT+WUG7Tid
	 5vL1Ttr5nnt2zKXG6Z569OoFRLNRKSUuvDxtogfwe2MafNA1zxB3tzw4aAgNf8JgvV
	 hMgttORTHzHpA==
Date: Wed, 27 Dec 2023 16:55:56 +0100
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
Subject: Re: [PATCH v13 11/21] PCI: microchip: Add num_events field to struct
 plda_pcie_rp
Message-ID: <ZYxJDIf1NDoEZkBJ@lpieralisi>
References: <20231214072839.2367-1-minda.chen@starfivetech.com>
 <20231214072839.2367-12-minda.chen@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214072839.2367-12-minda.chen@starfivetech.com>

On Thu, Dec 14, 2023 at 03:28:29PM +0800, Minda Chen wrote:
> The event num is different in other platform. For re-using interrupt
> process codes, replace macros with variable.

"The number of events is different across platforms. In order to
share interrupt processing code, add a variable that defines the
number of events so that it can be set per-platform instead of
hardcoding it".

Lorenzo

> 
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  drivers/pci/controller/plda/pcie-microchip-host.c | 8 +++++---
>  drivers/pci/controller/plda/pcie-plda.h           | 1 +
>  2 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c b/drivers/pci/controller/plda/pcie-microchip-host.c
> index 506e6eeadc76..7b3f4f74745d 100644
> --- a/drivers/pci/controller/plda/pcie-microchip-host.c
> +++ b/drivers/pci/controller/plda/pcie-microchip-host.c
> @@ -654,7 +654,7 @@ static void plda_handle_event(struct irq_desc *desc)
>  
>  	events = mc_get_events(port);
>  
> -	for_each_set_bit(bit, &events, NUM_EVENTS)
> +	for_each_set_bit(bit, &events, port->num_events)
>  		generic_handle_domain_irq(port->event_domain, bit);
>  
>  	chained_irq_exit(chip, desc);
> @@ -817,7 +817,8 @@ static int plda_pcie_init_irq_domains(struct plda_pcie_rp *port)
>  		return -EINVAL;
>  	}
>  
> -	port->event_domain = irq_domain_add_linear(pcie_intc_node, NUM_EVENTS,
> +	port->event_domain = irq_domain_add_linear(pcie_intc_node,
> +						   port->num_events,
>  						   &plda_event_domain_ops,
>  						   port);
>  	if (!port->event_domain) {
> @@ -921,7 +922,7 @@ static int plda_init_interrupts(struct platform_device *pdev, struct plda_pcie_r
>  	if (irq < 0)
>  		return -ENODEV;
>  
> -	for (i = 0; i < NUM_EVENTS; i++) {
> +	for (i = 0; i < port->num_events; i++) {
>  		event_irq = irq_create_mapping(port->event_domain, i);
>  		if (!event_irq) {
>  			dev_err(dev, "failed to map hwirq %d\n", i);
> @@ -1013,6 +1014,7 @@ static int mc_host_probe(struct platform_device *pdev)
>  
>  	bridge_base_addr = port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
>  	plda->bridge_addr = bridge_base_addr;
> +	plda->num_events = NUM_EVENTS;
>  
>  	/* Allow enabling MSI by disabling MSI-X */
>  	val = readl(bridge_base_addr + PCIE_PCI_IRQ_DW0);
> diff --git a/drivers/pci/controller/plda/pcie-plda.h b/drivers/pci/controller/plda/pcie-plda.h
> index 3deefd35fa5a..e3d35cef9894 100644
> --- a/drivers/pci/controller/plda/pcie-plda.h
> +++ b/drivers/pci/controller/plda/pcie-plda.h
> @@ -118,6 +118,7 @@ struct plda_pcie_rp {
>  	raw_spinlock_t lock;
>  	struct plda_msi msi;
>  	void __iomem *bridge_addr;
> +	int num_events;
>  };
>  
>  void plda_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
> -- 
> 2.17.1
> 

