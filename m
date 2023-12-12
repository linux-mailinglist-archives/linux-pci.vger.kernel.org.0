Return-Path: <linux-pci+bounces-797-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E4880EA3E
	for <lists+linux-pci@lfdr.de>; Tue, 12 Dec 2023 12:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0FA51F217A1
	for <lists+linux-pci@lfdr.de>; Tue, 12 Dec 2023 11:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B185CD3C;
	Tue, 12 Dec 2023 11:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l4w1RbhZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FEE5CD1C;
	Tue, 12 Dec 2023 11:19:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E49EC433C8;
	Tue, 12 Dec 2023 11:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702379998;
	bh=wMeP7zt1EIlnBjj2On4ldk4xqwfR7vzMZdJCgjDqPhQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l4w1RbhZTJq1hPS1YbIpyoowbGlBrDcwQ/sNjMl99Uxkk2T1ciKbIGZDXm5lfQDcY
	 d9eT9oRncCc6Qx3KsFFwRoXuGYEwu1zZ2SNbOO70yMrbF7PisXpU1YS1SDm8Z6942o
	 icImNol6zdFl4LarMzYEvT5sQqo+68jt9AXFPEEOS9RvrSVyNsgBvBkSEij67H/FAy
	 nQdhVFJNofSX1edqYm7O0F1/4DN/bb+JepidRYnwkmRoaYbnoBRbbldXynk/nzx29j
	 C09JDqHU7P96+oO4rzc3jTx9og1bWYZN9TxwGQHKj/asfWdTrLsEnFAMwGiwy2ALsb
	 Eblv5dKN+wTRA==
Date: Tue, 12 Dec 2023 12:19:50 +0100
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
Subject: Re: [PATCH v12 15/21] PCI: microchip: Add event IRQ domain ops to
 struct plda_event
Message-ID: <ZXhB1kKpElgKx8vm@lpieralisi>
References: <20231206105839.25805-1-minda.chen@starfivetech.com>
 <20231206105839.25805-16-minda.chen@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206105839.25805-16-minda.chen@starfivetech.com>

On Wed, Dec 06, 2023 at 06:58:33PM +0800, Minda Chen wrote:
> For lack of an MSI controller, The new added PCIe interrupts have to be
> added to global interrupt event field. PolarFire event domain ops can not
> be re-used.

I don't understand what this means, please explain and I will
add it to the commit log.

> PLDA event domain ops instances will be implemented in later patch.

Future patches don't exist, each commit log is a logical change
that must make sense on its own, I will remove this sentence.

Lorenzo

> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  drivers/pci/controller/plda/pcie-microchip-host.c | 6 ++++--
>  drivers/pci/controller/plda/pcie-plda.h           | 1 +
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c b/drivers/pci/controller/plda/pcie-microchip-host.c
> index f5e7da242aec..e6dcc572b65b 100644
> --- a/drivers/pci/controller/plda/pcie-microchip-host.c
> +++ b/drivers/pci/controller/plda/pcie-microchip-host.c
> @@ -821,13 +821,15 @@ static const struct plda_event_ops mc_event_ops = {
>  };
>  
>  static const struct plda_event mc_event = {
> +	.domain_ops        = &mc_event_domain_ops,
>  	.event_ops         = &mc_event_ops,
>  	.request_event_irq = mc_request_event_irq,
>  	.intx_event        = EVENT_LOCAL_PM_MSI_INT_INTX,
>  	.msi_event         = EVENT_LOCAL_PM_MSI_INT_MSI,
>  };
>  
> -static int plda_pcie_init_irq_domains(struct plda_pcie_rp *port)
> +static int plda_pcie_init_irq_domains(struct plda_pcie_rp *port,
> +				      const struct irq_domain_ops *ops)
>  {
>  	struct device *dev = port->dev;
>  	struct device_node *node = dev->of_node;
> @@ -941,7 +943,7 @@ static int plda_init_interrupts(struct platform_device *pdev,
>  		return -EINVAL;
>  	}
>  
> -	ret = plda_pcie_init_irq_domains(port);
> +	ret = plda_pcie_init_irq_domains(port, event->domain_ops);
>  	if (ret) {
>  		dev_err(dev, "failed creating IRQ domains\n");
>  		return ret;
> diff --git a/drivers/pci/controller/plda/pcie-plda.h b/drivers/pci/controller/plda/pcie-plda.h
> index df1729095952..820ea16855b5 100644
> --- a/drivers/pci/controller/plda/pcie-plda.h
> +++ b/drivers/pci/controller/plda/pcie-plda.h
> @@ -129,6 +129,7 @@ struct plda_pcie_rp {
>  };
>  
>  struct plda_event {
> +	const struct irq_domain_ops *domain_ops;
>  	const struct plda_event_ops *event_ops;
>  	int (*request_event_irq)(struct plda_pcie_rp *pcie,
>  				 int event_irq, int event);
> -- 
> 2.17.1
> 

