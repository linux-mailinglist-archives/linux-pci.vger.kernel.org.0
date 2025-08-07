Return-Path: <linux-pci+bounces-33568-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0DAB1DB96
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 18:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22E74188F3B8
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 16:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A2226E71E;
	Thu,  7 Aug 2025 16:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P5sSS+2O"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA4C26E705;
	Thu,  7 Aug 2025 16:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754583923; cv=none; b=YkWTsMuIwwhjaZJGhzuatVLcMVw/JlTUTCg4zjCb7RB36kQ9tQjkEO085l9MGTXCbJ2oy2001XtapF1K5Gg7K1uqVpE+Qi3WzR27f7B6KC8e5y2Pib9ctuwzDrDnKn/9BAljEpWhtUPwi0A7aMbOE3vbAUJDYymYKiHp19O/gLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754583923; c=relaxed/simple;
	bh=BudXXcTDGTwxVD8ktjRz+4NV9TJy0IkwNxbBa3LWQks=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=CT2wAi0jff3+7cFcFlMHvl2BK9EVrG9aQcLDUT4olyRJ1i/jOCleUkolUABFeroCF6pxAEwAJFGqRIoBVcUC9lxFkcjFY8oobYiny8qH57qek0fGh509jT24NXlwqdfBQM64dMylo0kX8f1aIEIJ1BjedkGo56ObkfYVbwsk9rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P5sSS+2O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9EEBC4CEEB;
	Thu,  7 Aug 2025 16:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754583923;
	bh=BudXXcTDGTwxVD8ktjRz+4NV9TJy0IkwNxbBa3LWQks=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=P5sSS+2OTaPHfKQ7mMNN/uSkilMMoN7DDZ7CND1CGKyvRJE85TL0J6gTIlABwqnSA
	 NQXDcKFq5gydWUbE51EneYcRKby3Lu1TIymbHRfnZ/HY4R90XkkumVfQZmjF8JFOlh
	 p2Qab2ZgAcxuHDjL72Zpd+sWhiUwVpXPsOiREIQ8FDJr254F5p2hC15CZ38aLUu6Br
	 9boLOT1C0N4HuvQwpmyLVj0YwF248CMixT7+SS6YtmqBuw02RE06jDW5VVe2hGqbsS
	 SHroNrEgmVyO4DJBAuwbtd1QXtnPtQCt6nFke40HU1txhdHAketkb22ynmYr6gHKU2
	 NtateoowuMeEw==
Date: Thu, 7 Aug 2025 11:25:21 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>, Marc Zyngier <maz@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Jonathan Cameron <Jonathan.Cameron@huwei.com>,
	Nicolin Chen <nicolinc@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Chen Wang <unicorn_wang@outlook.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH 2/4] PCI/MSI: Add startup/shutdown support for per device
 MSI[X] domains
Message-ID: <20250807162521.GA50955@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807112326.748740-3-inochiama@gmail.com>

In subject, s/MSI[X]// and s/support for/for/

The "MSI[X]" notation really isn't used anywhere else, and we already
include "PCI/MSI" in the prefix, so I don't think we need it again.

On Thu, Aug 07, 2025 at 07:23:23PM +0800, Inochi Amaoto wrote:
> As The RISC-V PLIC can not apply affinity setting without calling
> irq_enable(), it will make the interrupt unavaible when using as
> an underlying irq chip for MSI controller.

s/As The/As the/
s/unavaible/unavailable/
s/irq chip/IRQ chip/

> Introduce the irq_startup/irq_shutdown for PCI domain template with
> new MSI domain flag. This allow the PLIC can be properly configurated
> when calling irq_startup().

Maybe something like:

  Implement .irq_startup() and .irq_shutdown() for the PCI MSI and
  MSI-X templates.  For chips that specify MSI_FLAG_PCI_MSI_STARTUP_PARENT, 
  these startup and shutdown the parent as well, which allows ...

s/This allow/This allows/
s/can be properly configurated/to be configured/

Evidently PLIC depends on this "parent" connection, but that isn't
explained at all in the commit log.

> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> ---
>  drivers/pci/msi/irqdomain.c | 52 +++++++++++++++++++++++++++++++++++++
>  include/linux/msi.h         |  2 ++
>  2 files changed, 54 insertions(+)
> 
> diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
> index 0938ef7ebabf..f0d18cadbe20 100644
> --- a/drivers/pci/msi/irqdomain.c
> +++ b/drivers/pci/msi/irqdomain.c
> @@ -148,6 +148,23 @@ static void pci_device_domain_set_desc(msi_alloc_info_t *arg, struct msi_desc *d
>  	arg->hwirq = desc->msi_index;
>  }
>  
> +static __always_inline void cond_shutdown_parent(struct irq_data *data)

Is there a functional reason why we need __always_inline?

If not, it seems like this annotation is just clutter, and the compiler
will probably inline it all by itself.

> +{
> +	struct msi_domain_info *info = data->domain->host_data;
> +
> +	if (unlikely(info->flags & MSI_FLAG_PCI_MSI_STARTUP_PARENT))
> +		irq_chip_shutdown_parent(data);
> +}
> +
> +static __always_inline unsigned int cond_startup_parent(struct irq_data *data)
> +{
> +	struct msi_domain_info *info = data->domain->host_data;
> +
> +	if (unlikely(info->flags & MSI_FLAG_PCI_MSI_STARTUP_PARENT))
> +		return irq_chip_startup_parent(data);
> +	return 0;
> +}
> +
>  static __always_inline void cond_mask_parent(struct irq_data *data)
>  {
>  	struct msi_domain_info *info = data->domain->host_data;
> @@ -164,6 +181,23 @@ static __always_inline void cond_unmask_parent(struct irq_data *data)
>  		irq_chip_unmask_parent(data);
>  }
>  
> +static void pci_irq_shutdown_msi(struct irq_data *data)
> +{
> +	struct msi_desc *desc = irq_data_get_msi_desc(data);
> +
> +	pci_msi_mask(desc, BIT(data->irq - desc->irq));
> +	cond_shutdown_parent(data);
> +}
> +
> +static unsigned int pci_irq_startup_msi(struct irq_data *data)
> +{
> +	struct msi_desc *desc = irq_data_get_msi_desc(data);
> +	unsigned int ret = cond_startup_parent(data);
> +
> +	pci_msi_unmask(desc, BIT(data->irq - desc->irq));
> +	return ret;
> +}
> +
>  static void pci_irq_mask_msi(struct irq_data *data)
>  {
>  	struct msi_desc *desc = irq_data_get_msi_desc(data);
> @@ -194,6 +228,8 @@ static void pci_irq_unmask_msi(struct irq_data *data)
>  static const struct msi_domain_template pci_msi_template = {
>  	.chip = {
>  		.name			= "PCI-MSI",
> +		.irq_startup		= pci_irq_startup_msi,
> +		.irq_shutdown		= pci_irq_shutdown_msi,
>  		.irq_mask		= pci_irq_mask_msi,
>  		.irq_unmask		= pci_irq_unmask_msi,
>  		.irq_write_msi_msg	= pci_msi_domain_write_msg,
> @@ -210,6 +246,20 @@ static const struct msi_domain_template pci_msi_template = {
>  	},
>  };
>  
> +static void pci_irq_shutdown_msix(struct irq_data *data)
> +{
> +	pci_msix_mask(irq_data_get_msi_desc(data));
> +	cond_shutdown_parent(data);
> +}
> +
> +static unsigned int pci_irq_startup_msix(struct irq_data *data)
> +{
> +	unsigned int ret = cond_startup_parent(data);
> +
> +	pci_msix_unmask(irq_data_get_msi_desc(data));
> +	return ret;
> +}
> +
>  static void pci_irq_mask_msix(struct irq_data *data)
>  {
>  	pci_msix_mask(irq_data_get_msi_desc(data));
> @@ -234,6 +284,8 @@ EXPORT_SYMBOL_GPL(pci_msix_prepare_desc);
>  static const struct msi_domain_template pci_msix_template = {
>  	.chip = {
>  		.name			= "PCI-MSIX",
> +		.irq_startup		= pci_irq_startup_msix,
> +		.irq_shutdown		= pci_irq_shutdown_msix,
>  		.irq_mask		= pci_irq_mask_msix,
>  		.irq_unmask		= pci_irq_unmask_msix,
>  		.irq_write_msi_msg	= pci_msi_domain_write_msg,
> diff --git a/include/linux/msi.h b/include/linux/msi.h
> index e5e86a8529fb..3111ba95fbde 100644
> --- a/include/linux/msi.h
> +++ b/include/linux/msi.h
> @@ -568,6 +568,8 @@ enum {
>  	MSI_FLAG_PARENT_PM_DEV		= (1 << 8),
>  	/* Support for parent mask/unmask */
>  	MSI_FLAG_PCI_MSI_MASK_PARENT	= (1 << 9),
> +	/* Support for parent startup/shutdown */
> +	MSI_FLAG_PCI_MSI_STARTUP_PARENT	= (1 << 10),
>  
>  	/* Mask for the generic functionality */
>  	MSI_GENERIC_FLAGS_MASK		= GENMASK(15, 0),
> -- 
> 2.50.1
> 

