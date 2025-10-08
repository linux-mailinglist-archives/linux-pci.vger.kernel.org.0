Return-Path: <linux-pci+bounces-37732-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB9BBC68F6
	for <lists+linux-pci@lfdr.de>; Wed, 08 Oct 2025 22:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C77A3AA04E
	for <lists+linux-pci@lfdr.de>; Wed,  8 Oct 2025 20:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45666284B36;
	Wed,  8 Oct 2025 20:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pfkPmK+K"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3E0279917;
	Wed,  8 Oct 2025 20:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759954835; cv=none; b=Em4sXZkJvLxTYgMfn5M4amo0yQKLn4w6uM1ri4exC5v5JNEIuKzKWQGW88XfaFqRWO9ZYhAhKHdkIlzGr/q6YlbTe94EDZEKJco2DpbO5zqMZlyo49ugLlw/uQ6csvkQ42+DlLVAxDUw2t2xtfPSX7Izu12HF7fyDf4O6eaMpu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759954835; c=relaxed/simple;
	bh=InaZjSuuLLHH0zfPs1iLx+Fl8x1DFmLfBUgVpre5xGw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=K5wQ7MGb6dFM1jPt531cbgHykzu99ljHghf8zn57jeVwxEldSvdxj2KOAepUp0oxsE9wVvw97CZsFMzYloqdZDQbyTmbro9yCp+JDCzptdtwnE9dleySMFfk6rBwSXCb3d/wDc/eGsnHcCtZGhPIWKuGEKhwkbxSQrLbdXWVLvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pfkPmK+K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 847C8C4CEE7;
	Wed,  8 Oct 2025 20:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759954834;
	bh=InaZjSuuLLHH0zfPs1iLx+Fl8x1DFmLfBUgVpre5xGw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=pfkPmK+K3/CXJPNJjma9XWt7vNHxAu00bOKjb05zM49MefOiWasvVbJ1H9KXVM4ad
	 dRcIHwXfPGHQdyFshPEiUUWMh+gUpn3vmJsRS7bBZPzEy3Kydgh52i1eXMXkAtmVJR
	 yyA9Ucc3o3WsgWIHmHjTbnwKjE3Y9IMGfSzQSQ2Kdg4ImD/OIxEYL5+TLFjU6WWpPJ
	 446npxe70i9EmToaQEqnBP1PnvJT2syyuTDt1mxrUOngm5oAte4jjHtb5KF+lmv4Qv
	 KLqaXabqTBxwJ7CJDgnwApwI4B39UJxpumzFAg/7unQ7rl7ju6qNBnSUVOSiXKO8Y0
	 K/uI4gKLnVAYg==
Date: Wed, 8 Oct 2025 15:20:33 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Nam Cao <namcao@linutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/MSI: Delete pci_msi_create_irq_domain()
Message-ID: <20251008202033.GA639047@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721063626.3026756-1-namcao@linutronix.de>

On Mon, Jul 21, 2025 at 08:36:26AM +0200, Nam Cao wrote:
> pci_msi_create_irq_domain() is unused. Delete it.
> 
> Signed-off-by: Nam Cao <namcao@linutronix.de>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

I verified that pci_msi_create_irq_domain() no longer referenced in
current upstream: cd5a0afbdf80 ("Merge tag 'mailbox-v6.18' of
git://git.kernel.org/pub/scm/linux/kernel/git/jassibrar/mailbox")

Thomas, you've merged most irqdomain.c changes; let me know if you
want me to do anything.

> ---
> This is the final step in converting to the new MSI interrupt domain setup:
> deleting the old setup.
> 
> This patch depends on the driver conversion patches listed below. Most
> patches have been applied somewhere, except for the first one.
> 
> https://lore.kernel.org/lkml/cover.1752868165.git.namcao@linutronix.de/
>    -> has not been applied anywhere
> 
> https://lore.kernel.org/lkml/cover.1750861319.git.namcao@linutronix.de/
>    -> applied to powerpc/next-test
> 
> https://lore.kernel.org/linux-um/cover.1751266049.git.namcao@linutronix.de/
>    -> applied to uml/next
> 
> https://lore.kernel.org/lkml/cover.1750858083.git.namcao@linutronix.de/
>    -> applied to pci/next
> 
> https://lore.kernel.org/lkml/cover.1751875853.git.namcao@linutronix.de/
>    -> applied to netdev/net-next
> 
> https://lore.kernel.org/lkml/cover.1750860131.git.namcao@linutronix.de/
>    -> applied to tip/irq/drivers
> ---
>  drivers/pci/msi/irqdomain.c | 90 -------------------------------------
>  include/linux/msi.h         |  3 --
>  2 files changed, 93 deletions(-)
> 
> diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
> index c05152733993..926a16e80192 100644
> --- a/drivers/pci/msi/irqdomain.c
> +++ b/drivers/pci/msi/irqdomain.c
> @@ -49,96 +49,6 @@ static void pci_msi_domain_write_msg(struct irq_data *irq_data, struct msi_msg *
>  		__pci_write_msi_msg(desc, msg);
>  }
>  
> -/**
> - * pci_msi_domain_calc_hwirq - Generate a unique ID for an MSI source
> - * @desc:	Pointer to the MSI descriptor
> - *
> - * The ID number is only used within the irqdomain.
> - */
> -static irq_hw_number_t pci_msi_domain_calc_hwirq(struct msi_desc *desc)
> -{
> -	struct pci_dev *dev = msi_desc_to_pci_dev(desc);
> -
> -	return (irq_hw_number_t)desc->msi_index |
> -		pci_dev_id(dev) << 11 |
> -		((irq_hw_number_t)(pci_domain_nr(dev->bus) & 0xFFFFFFFF)) << 27;
> -}
> -
> -static void pci_msi_domain_set_desc(msi_alloc_info_t *arg,
> -				    struct msi_desc *desc)
> -{
> -	arg->desc = desc;
> -	arg->hwirq = pci_msi_domain_calc_hwirq(desc);
> -}
> -
> -static struct msi_domain_ops pci_msi_domain_ops_default = {
> -	.set_desc	= pci_msi_domain_set_desc,
> -};
> -
> -static void pci_msi_domain_update_dom_ops(struct msi_domain_info *info)
> -{
> -	struct msi_domain_ops *ops = info->ops;
> -
> -	if (ops == NULL) {
> -		info->ops = &pci_msi_domain_ops_default;
> -	} else {
> -		if (ops->set_desc == NULL)
> -			ops->set_desc = pci_msi_domain_set_desc;
> -	}
> -}
> -
> -static void pci_msi_domain_update_chip_ops(struct msi_domain_info *info)
> -{
> -	struct irq_chip *chip = info->chip;
> -
> -	BUG_ON(!chip);
> -	if (!chip->irq_write_msi_msg)
> -		chip->irq_write_msi_msg = pci_msi_domain_write_msg;
> -	if (!chip->irq_mask)
> -		chip->irq_mask = pci_msi_mask_irq;
> -	if (!chip->irq_unmask)
> -		chip->irq_unmask = pci_msi_unmask_irq;
> -}
> -
> -/**
> - * pci_msi_create_irq_domain - Create a MSI interrupt domain
> - * @fwnode:	Optional fwnode of the interrupt controller
> - * @info:	MSI domain info
> - * @parent:	Parent irq domain
> - *
> - * Updates the domain and chip ops and creates a MSI interrupt domain.
> - *
> - * Returns:
> - * A domain pointer or NULL in case of failure.
> - */
> -struct irq_domain *pci_msi_create_irq_domain(struct fwnode_handle *fwnode,
> -					     struct msi_domain_info *info,
> -					     struct irq_domain *parent)
> -{
> -	if (WARN_ON(info->flags & MSI_FLAG_LEVEL_CAPABLE))
> -		info->flags &= ~MSI_FLAG_LEVEL_CAPABLE;
> -
> -	if (info->flags & MSI_FLAG_USE_DEF_DOM_OPS)
> -		pci_msi_domain_update_dom_ops(info);
> -	if (info->flags & MSI_FLAG_USE_DEF_CHIP_OPS)
> -		pci_msi_domain_update_chip_ops(info);
> -
> -	/* Let the core code free MSI descriptors when freeing interrupts */
> -	info->flags |= MSI_FLAG_FREE_MSI_DESCS;
> -
> -	info->flags |= MSI_FLAG_ACTIVATE_EARLY | MSI_FLAG_DEV_SYSFS;
> -	if (IS_ENABLED(CONFIG_GENERIC_IRQ_RESERVATION_MODE))
> -		info->flags |= MSI_FLAG_MUST_REACTIVATE;
> -
> -	/* PCI-MSI is oneshot-safe */
> -	info->chip->flags |= IRQCHIP_ONESHOT_SAFE;
> -	/* Let the core update the bus token */
> -	info->bus_token = DOMAIN_BUS_PCI_MSI;
> -
> -	return msi_create_irq_domain(fwnode, info, parent);
> -}
> -EXPORT_SYMBOL_GPL(pci_msi_create_irq_domain);
> -
>  /*
>   * Per device MSI[-X] domain functionality
>   */
> diff --git a/include/linux/msi.h b/include/linux/msi.h
> index 77227d23ea84..0c0e59af043c 100644
> --- a/include/linux/msi.h
> +++ b/include/linux/msi.h
> @@ -703,9 +703,6 @@ void __pci_read_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
>  void __pci_write_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
>  void pci_msi_mask_irq(struct irq_data *data);
>  void pci_msi_unmask_irq(struct irq_data *data);
> -struct irq_domain *pci_msi_create_irq_domain(struct fwnode_handle *fwnode,
> -					     struct msi_domain_info *info,
> -					     struct irq_domain *parent);
>  u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pdev);
>  struct irq_domain *pci_msi_get_device_domain(struct pci_dev *pdev);
>  #else /* CONFIG_PCI_MSI */
> -- 
> 2.39.5
> 

