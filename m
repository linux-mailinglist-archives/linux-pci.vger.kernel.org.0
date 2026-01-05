Return-Path: <linux-pci+bounces-44012-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 23539CF37EA
	for <lists+linux-pci@lfdr.de>; Mon, 05 Jan 2026 13:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CDDF73036CB9
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jan 2026 12:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BACD433A70B;
	Mon,  5 Jan 2026 12:21:21 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E014933A707;
	Mon,  5 Jan 2026 12:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767615681; cv=none; b=MMcM8/bLfqdMoGw7pi2MJ990do7cJi+J0lBy28Ernhzh/6CTsq8De503cvNwji27KUilI5qcBBGMXTJ6mgs/gkPSzBmckZXXpSH3n7h/zqtvKMGgWSxOwvi9P6XMhWjV8QajKplD3jxKiMfOEY4HXa/NnwXtPG6wwhPv433Lqf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767615681; c=relaxed/simple;
	bh=QhILN9GfG7+4f4OsPbYpKLmWP4QoSZzQlL1umHljmwk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LbtrelqlKP0fTmHhi3bLterfh4+VxoYlO/IjUN+VLL4XyuuA5g7LhzUpigBo24Qm3rj+BiBQXvGO0FSuxw8s/2JpzYwzlUl278RjIuYQ0XViUV1hAdy2p+80D5qP2Htpd9VYT4cEbJRt5ejstx1HsjQFXtORXXzzljxo7D9B2vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dlD004KnWzJ46bf;
	Mon,  5 Jan 2026 20:20:16 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id EA91C4056B;
	Mon,  5 Jan 2026 20:21:16 +0800 (CST)
Received: from localhost (10.48.157.23) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 5 Jan
 2026 12:21:16 +0000
Date: Mon, 5 Jan 2026 12:21:14 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Robert Moore <robert.moore@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>, Marc
 Zyngier <maz@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	<linux-acpi@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 4/7] PCI/MSI: Make the pci_msi_map_rid_ctlr_node()
 interface firmware agnostic
Message-ID: <20260105122114.000035e8@huawei.com>
In-Reply-To: <20251218-gicv5-host-acpi-v2-4-eec76cd1d40b@kernel.org>
References: <20251218-gicv5-host-acpi-v2-0-eec76cd1d40b@kernel.org>
	<20251218-gicv5-host-acpi-v2-4-eec76cd1d40b@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Thu, 18 Dec 2025 11:14:30 +0100
Lorenzo Pieralisi <lpieralisi@kernel.org> wrote:

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
Hi Lorenzo,

A few minor comments inline.  All in the 'up to you' category.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> ---

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

I haven't read on but my assumption is of_node is never used for anything else.
I'd make that explicit by not having the local variable.
	if (irq_domain_get_of_node(domain))

Might even be worth a comment to say this is just checking of is in use for the
domain in general?

> +		struct device_node *msi_ctlr_node = NULL;
> +
> +		rid = of_msi_xlate(&pdev->dev, &msi_ctlr_node, rid);
> +		if (msi_ctlr_node)

Do you need the protection? Ultimately that depends on whether
setting *node = NULL on failure to match is a problem.
It's a bit subtle, but if your new code matches behavior of old code
then *node was always NULL at entry to this function so setting it
to NULL again (which is what happens if ms_ctrl_node == NULL) should
be fine.

Maybe it's all a bit subtle though so perhaps the check is worth having.

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


