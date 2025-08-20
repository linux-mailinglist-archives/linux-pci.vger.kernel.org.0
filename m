Return-Path: <linux-pci+bounces-34414-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5826B2E707
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 22:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90FAFA251BC
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 20:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F5B2D321A;
	Wed, 20 Aug 2025 20:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TJ2hdxxt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D55626F476;
	Wed, 20 Aug 2025 20:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755723280; cv=none; b=ac+WaJ8FoVuEnyAonYd8LedoRWdzQgMoUw8OtuoUOroMYJmNvhIFdE/CMikB+6N96RG//gDqBSmEeVs5V7CdQbkCwiz2Xof/Ia2q+1AEGxjYMO2WrUz34JAGbVJy2wmBmyPl/OUqEQ3U6Q0/0lf3hWCmuKa8Js+D7V7PZuPmI4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755723280; c=relaxed/simple;
	bh=zxrA1lzdoDbp7mpFSOTFUseFY73qVTIleD3IxdZWXFI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=hSq19uZO22l9Rb34S4Vt6SB1p+YYxcuyWRyZEAEpXaERyVsWDtQ/IzE9mVioI0dzoH6WLqEmUKgUkXnuYFcV1aI2X4sTiSV/C9K1jaRKXLwB56NvzT5kC32Nya9hOp8rV1wY5/PMQWhSCttdJt/4HpUha5lILy0nl9ZGp0hwtvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TJ2hdxxt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1BB5C4CEE7;
	Wed, 20 Aug 2025 20:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755723280;
	bh=zxrA1lzdoDbp7mpFSOTFUseFY73qVTIleD3IxdZWXFI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=TJ2hdxxtEZJqm0h0iSTNd0IgM5rpLn97H2CEKISb+30so02U9pShR9DpP0D45ntFT
	 UrQ5sNOnUoIOXcKdC6DOsQ6qoIDxMt/JXICFxB+LtYjgAGMmqnVEZNUXJRHTjxu7pz
	 5h2Nzn+TwK+uyMbVoJG+os9A/rAjohPbxynkguv3wEXeyU48a3oornDpU8a/SiiDNr
	 /p1cmi/gV91hsGt1CaqKOAhK+W3KeiMyXXk/MGfZGCpgnWNNw6zwySpTBpgTOz9nUc
	 r5HltNy1hstkRpoK1dEHzMGDl3x+ISkDWzXUDu6ti2TZ+k6Vstl3s61ODtW1NE+J9h
	 JizpZXTpNaoBw==
Date: Wed, 20 Aug 2025 15:54:38 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>, Marc Zyngier <maz@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Jonathan Cameron <Jonathan.Cameron@huwei.com>,
	Juergen Gross <jgross@suse.com>, Nicolin Chen <nicolinc@nvidia.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Chen Wang <unicorn_wang@outlook.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH v2 2/4] PCI/MSI: Add startup/shutdown for per device
 domains
Message-ID: <20250820205438.GA640534@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813232835.43458-3-inochiama@gmail.com>

On Thu, Aug 14, 2025 at 07:28:32AM +0800, Inochi Amaoto wrote:
> As the RISC-V PLIC can not apply affinity setting without calling
> irq_enable(), it will make the interrupt unavailble when using as
> an underlying IRQ chip for MSI controller.

s/unavailble/unavailable/ (mentioned previously)

> Implement .irq_startup() and .irq_shutdown() for the PCI MSI and
> MSI-X templates. For chips that specify MSI_FLAG_PCI_MSI_STARTUP_PARENT,
> these startup and shutdown the parent as well, which allows the
> irq on the parent chip to be enabled if the irq is not enabled
> when allocating. This is necessary for the MSI controllers which
> use PLIC as underlying IRQ chip.

s/irq/IRQ/ a couple times above

> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Thomas, I assume you'll merge this series; let me know if not.

> ---
>  drivers/pci/msi/irqdomain.c | 52 +++++++++++++++++++++++++++++++++++++
>  include/linux/msi.h         |  2 ++
>  2 files changed, 54 insertions(+)
> 
> diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
> index 0938ef7ebabf..e0a800f918e8 100644
> --- a/drivers/pci/msi/irqdomain.c
> +++ b/drivers/pci/msi/irqdomain.c
> @@ -148,6 +148,23 @@ static void pci_device_domain_set_desc(msi_alloc_info_t *arg, struct msi_desc *d
>  	arg->hwirq = desc->msi_index;
>  }
>  
> +static void cond_shutdown_parent(struct irq_data *data)
> +{
> +	struct msi_domain_info *info = data->domain->host_data;
> +
> +	if (unlikely(info->flags & MSI_FLAG_PCI_MSI_STARTUP_PARENT))
> +		irq_chip_shutdown_parent(data);
> +}
> +
> +static unsigned int cond_startup_parent(struct irq_data *data)
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

