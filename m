Return-Path: <linux-pci+bounces-44046-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21926CF5098
	for <lists+linux-pci@lfdr.de>; Mon, 05 Jan 2026 18:42:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BFDFC30D8AEF
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jan 2026 17:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F9A31B13B;
	Mon,  5 Jan 2026 17:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="liIZlzFh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A20E2E65D;
	Mon,  5 Jan 2026 17:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767634535; cv=none; b=o4QBTnYeOha+mZf1IzXgRQcUVKpZqoiRbYCx2QiyETBpshZFQMH3JZKO3wpHRIxfcg5NuK8PA0UvyNQac4aXpugrLnVotATQAaeASlsc3yBj4RSx3t8yJgrh2m8NhNLq5rdrsx9er15DhyL6C1esBDMDLoX45ZzU8xshvAY4pgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767634535; c=relaxed/simple;
	bh=hRDqJrql8dctEWP20Bj6GrBkP/6rK2t9UtbGS9Tl++I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=k8DEfi0Ly1ebOsu4LsbKvBIg6Nt+77SlfWUO/Jfxc/yFA6Yvrr7d1njXZCGiJ3waGmWgdjgUb64VPD9X8cagKhlTa0LJUIy3R237VoXH+i4TXGJfeqXbOw4meZrgjgy1ZVvkA3731vAQhckppzD7blJYpvb1OLhsV0cGz2WwDzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=liIZlzFh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 034C6C116D0;
	Mon,  5 Jan 2026 17:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767634535;
	bh=hRDqJrql8dctEWP20Bj6GrBkP/6rK2t9UtbGS9Tl++I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=liIZlzFhR9hQE/xJKCJAxhlo6ZD+9klal2OD/fPnl0tnPPOmGWCvjlUk49eulgzVd
	 tgXv/z2EoaboHYtvkORhUCs7wGU5MhwzrFIsTGRKsYpUgUZ4Q2uDx9xTybyFhtF7oT
	 kmPp+MAwvzGI9gfRQIrBMjuNYuXy4giW1ZKeVQWMh9+8BUdHRjWr0raqrzQcadpqpx
	 vk5jbBJut7BR4a1r3e+bP+sbrcyrquLaBtE7/tEJWqDi/qwauyxwy2sZg9ADWV7zZ5
	 vY6BWqS1xKewfo2q0klPQ0kvTSh5NmkFdf5r2g/UX06MEl/nmcWx0WuM0y40fb36UK
	 JN1rNMDUMa2Mw==
Date: Mon, 5 Jan 2026 11:35:33 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>, Marc Zyngier <maz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 4/7] PCI/MSI: Make the pci_msi_map_rid_ctlr_node()
 interface firmware agnostic
Message-ID: <20260105173533.GA322546@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251218-gicv5-host-acpi-v2-4-eec76cd1d40b@kernel.org>

On Thu, Dec 18, 2025 at 11:14:30AM +0100, Lorenzo Pieralisi wrote:
> To support booting with OF and ACPI seamlessly, GIC ITS parent code
> requires the PCI/MSI irqdomain layer to implement a function to retrieve
> an MSI controller fwnode and map an RID in a firmware agnostic way
> (ie pci_msi_map_rid_ctlr_node()).
> 
> Convert pci_msi_map_rid_ctlr_node() to an OF agnostic interface
> (fwnode_handle based) and update the GIC ITS MSI parent code to reflect
> the pci_msi_map_rid_ctlr_node() change.
> 
> Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Marc Zyngier <maz@kernel.org>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

I assume this series will be merged via some non-PCI tree.  Let me
know if you need anything else.

> ---
>  drivers/irqchip/irq-gic-its-msi-parent.c |  8 ++++----
>  drivers/pci/msi/irqdomain.c              | 22 +++++++++++++++++-----
>  include/linux/msi.h                      |  3 ++-
>  3 files changed, 23 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-gic-its-msi-parent.c b/drivers/irqchip/irq-gic-its-msi-parent.c
> index 12f45228c867..4d1ad1ee005d 100644
> --- a/drivers/irqchip/irq-gic-its-msi-parent.c
> +++ b/drivers/irqchip/irq-gic-its-msi-parent.c
> @@ -104,7 +104,7 @@ static int its_pci_msi_prepare(struct irq_domain *domain, struct device *dev,
>  static int its_v5_pci_msi_prepare(struct irq_domain *domain, struct device *dev,
>  				  int nvec, msi_alloc_info_t *info)
>  {
> -	struct device_node *msi_node = NULL;
> +	struct fwnode_handle *msi_node = NULL;
>  	struct msi_domain_info *msi_info;
>  	struct pci_dev *pdev;
>  	phys_addr_t pa;
> @@ -116,15 +116,15 @@ static int its_v5_pci_msi_prepare(struct irq_domain *domain, struct device *dev,
>  
>  	pdev = to_pci_dev(dev);
>  
> -	rid = pci_msi_map_rid_ctlr_node(pdev, &msi_node);
> +	rid = pci_msi_map_rid_ctlr_node(domain->parent, pdev, &msi_node);
>  	if (!msi_node)
>  		return -ENODEV;
>  
> -	ret = its_translate_frame_address(msi_node, &pa);
> +	ret = its_translate_frame_address(to_of_node(msi_node), &pa);
>  	if (ret)
>  		return -ENODEV;
>  
> -	of_node_put(msi_node);
> +	fwnode_handle_put(msi_node);
>  
>  	/* ITS specific DeviceID */
>  	info->scratchpad[0].ul = rid;
> diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
> index a329060287b5..3136341e802c 100644
> --- a/drivers/pci/msi/irqdomain.c
> +++ b/drivers/pci/msi/irqdomain.c
> @@ -376,23 +376,35 @@ u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pdev)
>  }
>  
>  /**
> - * pci_msi_map_rid_ctlr_node - Get the MSI controller node and MSI requester id (RID)
> + * pci_msi_map_rid_ctlr_node - Get the MSI controller fwnode_handle and MSI requester id (RID)
> + * @domain:	The interrupt domain
>   * @pdev:	The PCI device
> - * @node:	Pointer to store the MSI controller device node
> + * @node:	Pointer to store the MSI controller fwnode_handle
>   *
> - * Use the firmware data to find the MSI controller node for @pdev.
> + * Use the firmware data to find the MSI controller fwnode_handle for @pdev.
>   * If found map the RID and initialize @node with it. @node value must
>   * be set to NULL on entry.
>   *
>   * Returns: The RID.
>   */
> -u32 pci_msi_map_rid_ctlr_node(struct pci_dev *pdev, struct device_node **node)
> +u32 pci_msi_map_rid_ctlr_node(struct irq_domain *domain, struct pci_dev *pdev,
> +			      struct fwnode_handle **node)
>  {
> +	struct device_node *of_node;
>  	u32 rid = pci_dev_id(pdev);
>  
>  	pci_for_each_dma_alias(pdev, get_msi_id_cb, &rid);
>  
> -	return of_msi_xlate(&pdev->dev, node, rid);
> +	of_node = irq_domain_get_of_node(domain);
> +	if (of_node) {
> +		struct device_node *msi_ctlr_node = NULL;
> +
> +		rid = of_msi_xlate(&pdev->dev, &msi_ctlr_node, rid);
> +		if (msi_ctlr_node)
> +			*node = of_fwnode_handle(msi_ctlr_node);
> +	}
> +
> +	return rid;
>  }
>  
>  /**
> diff --git a/include/linux/msi.h b/include/linux/msi.h
> index 8003e3218c46..8ddb05d5c96a 100644
> --- a/include/linux/msi.h
> +++ b/include/linux/msi.h
> @@ -702,7 +702,8 @@ void __pci_write_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
>  void pci_msi_mask_irq(struct irq_data *data);
>  void pci_msi_unmask_irq(struct irq_data *data);
>  u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pdev);
> -u32 pci_msi_map_rid_ctlr_node(struct pci_dev *pdev, struct device_node **node);
> +u32 pci_msi_map_rid_ctlr_node(struct irq_domain *domain, struct pci_dev *pdev,
> +			      struct fwnode_handle **node);
>  struct irq_domain *pci_msi_get_device_domain(struct pci_dev *pdev);
>  void pci_msix_prepare_desc(struct irq_domain *domain, msi_alloc_info_t *arg,
>  			   struct msi_desc *desc);
> 
> -- 
> 2.50.1
> 

