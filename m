Return-Path: <linux-pci+bounces-44157-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D56ACFCDBF
	for <lists+linux-pci@lfdr.de>; Wed, 07 Jan 2026 10:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 892F230062E0
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jan 2026 09:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851FF2FE58F;
	Wed,  7 Jan 2026 09:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o/MtHX9x"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EFA2356A4;
	Wed,  7 Jan 2026 09:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767777838; cv=none; b=ClnmyVfrwBMHYwLljhFQREWLUlwMGqA0F9xbiB7zfVKiTig6dytF0paTIcIeXbYkxRoKzRJ+CFvS5pv+Pw5DIA8oJ+daekSitonplaQH4OC2azN0AZUhyI6hV7J2m9pFQ99KUV9Hiy5+GlcXz3ivAmx0DczgNxsCnfr5/2oDlY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767777838; c=relaxed/simple;
	bh=+6pwW5uwAPs1Ujhdl8iggTkeR5DIz6CdXvrHytl9AcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z2b0kJ85MUPs1kT8YcX/izHqZKM0Nzb1/aCGFhYnwnQSX7yGdGZxkMFOfDaS8xjYAb1Sd9vYwojhoCfVzuzdxfCqExXrEZVWxdodxiJQUWWWXR8pB5mQU6dyJR3LEu6jqEHc+9a9bc3QjkjLUYqPZIak1kLJtjDgh4/f97Ldiis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o/MtHX9x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6B21C4CEF7;
	Wed,  7 Jan 2026 09:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767777837;
	bh=+6pwW5uwAPs1Ujhdl8iggTkeR5DIz6CdXvrHytl9AcI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o/MtHX9xtq+8mIeuQ2a+CEV/EtEvcjehkZNy0F+6BDhCO2qi5rHoyAGTnniOgESHE
	 IilnvhlTtAzQVB2y8T3ZBijAcuBqaJB2AwJjtk5/DWot25uwJ+9YcnT4QuZEGzzOSe
	 py+97jd19AM7or0s1Rx0yj9R92DDWFXOXPdyEB0cPuVaow2Rsug9g+6fvxvHuF0gwG
	 ZGiuOYLbq9oQVOT2/PPR+A1x3zHTUvpqmHPE9nvlbzSIxCf0vh0IqhioksNFRRjOZ2
	 ElCudii24ZjPfc75AGA5lW+xLQjYfq2Zt6HG87JzpC123whWvhKq6aoHdC24ZXlkwv
	 nNmiJHzkFSybw==
Date: Wed, 7 Jan 2026 10:23:52 +0100
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
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
Message-ID: <aV4mKBRjeyp9eWVy@lpieralisi>
References: <20251218-gicv5-host-acpi-v2-0-eec76cd1d40b@kernel.org>
 <20251218-gicv5-host-acpi-v2-4-eec76cd1d40b@kernel.org>
 <20260105122114.000035e8@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260105122114.000035e8@huawei.com>

On Mon, Jan 05, 2026 at 12:21:14PM +0000, Jonathan Cameron wrote:
> On Thu, 18 Dec 2025 11:14:30 +0100
> Lorenzo Pieralisi <lpieralisi@kernel.org> wrote:
> 
> > To support booting with OF and ACPI seamlessly, GIC ITS parent code
> > requires the PCI/MSI irqdomain layer to implement a function to retrieve
> > an MSI controller fwnode and map an RID in a firmware agnostic way
> > (ie pci_msi_map_rid_ctlr_node()).
> > 
> > Convert pci_msi_map_rid_ctlr_node() to an OF agnostic interface
> > (fwnode_handle based) and update the GIC ITS MSI parent code to reflect
> > the pci_msi_map_rid_ctlr_node() change.
> > 
> > Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Marc Zyngier <maz@kernel.org>
> Hi Lorenzo,
> 
> A few minor comments inline.  All in the 'up to you' category.
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> 
> > ---
> 
> > diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
> > index a329060287b5..3136341e802c 100644
> > --- a/drivers/pci/msi/irqdomain.c
> > +++ b/drivers/pci/msi/irqdomain.c
> > @@ -376,23 +376,35 @@ u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pdev)
> >  }
> >  
> >  /**
> > - * pci_msi_map_rid_ctlr_node - Get the MSI controller node and MSI requester id (RID)
> > + * pci_msi_map_rid_ctlr_node - Get the MSI controller fwnode_handle and MSI requester id (RID)
> > + * @domain:	The interrupt domain
> >   * @pdev:	The PCI device
> > - * @node:	Pointer to store the MSI controller device node
> > + * @node:	Pointer to store the MSI controller fwnode_handle
> >   *
> > - * Use the firmware data to find the MSI controller node for @pdev.
> > + * Use the firmware data to find the MSI controller fwnode_handle for @pdev.
> >   * If found map the RID and initialize @node with it. @node value must
> >   * be set to NULL on entry.
> >   *
> >   * Returns: The RID.
> >   */
> > -u32 pci_msi_map_rid_ctlr_node(struct pci_dev *pdev, struct device_node **node)
> > +u32 pci_msi_map_rid_ctlr_node(struct irq_domain *domain, struct pci_dev *pdev,
> > +			      struct fwnode_handle **node)
> >  {
> > +	struct device_node *of_node;
> >  	u32 rid = pci_dev_id(pdev);
> >  
> >  	pci_for_each_dma_alias(pdev, get_msi_id_cb, &rid);
> >  
> > -	return of_msi_xlate(&pdev->dev, node, rid);
> > +	of_node = irq_domain_get_of_node(domain);
> > +	if (of_node) {
> 
> I haven't read on but my assumption is of_node is never used for anything else.
> I'd make that explicit by not having the local variable.
> 	if (irq_domain_get_of_node(domain))
> 
> Might even be worth a comment to say this is just checking of is in use for the
> domain in general?

Yes, I thought an explicit variable would make it clearer, don't know,
not a big deal either way I believe.

> > +		struct device_node *msi_ctlr_node = NULL;
> > +
> > +		rid = of_msi_xlate(&pdev->dev, &msi_ctlr_node, rid);
> > +		if (msi_ctlr_node)
> 
> Do you need the protection? Ultimately that depends on whether
> setting *node = NULL on failure to match is a problem.
> It's a bit subtle, but if your new code matches behavior of old code
> then *node was always NULL at entry to this function so setting it
> to NULL again (which is what happens if ms_ctrl_node == NULL) should
> be fine.
> 
> Maybe it's all a bit subtle though so perhaps the check is worth having.

As above, I thought that to help understand what the function does
assigning only if !NULL would help, you are right though.

Thanks,
Lorenzo

> > +			*node = of_fwnode_handle(msi_ctlr_node);
> > +	}
> > +
> > +	return rid;
> >  }
> >  
> >  /**
> > diff --git a/include/linux/msi.h b/include/linux/msi.h
> > index 8003e3218c46..8ddb05d5c96a 100644
> > --- a/include/linux/msi.h
> > +++ b/include/linux/msi.h
> > @@ -702,7 +702,8 @@ void __pci_write_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
> >  void pci_msi_mask_irq(struct irq_data *data);
> >  void pci_msi_unmask_irq(struct irq_data *data);
> >  u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pdev);
> > -u32 pci_msi_map_rid_ctlr_node(struct pci_dev *pdev, struct device_node **node);
> > +u32 pci_msi_map_rid_ctlr_node(struct irq_domain *domain, struct pci_dev *pdev,
> > +			      struct fwnode_handle **node);
> >  struct irq_domain *pci_msi_get_device_domain(struct pci_dev *pdev);
> >  void pci_msix_prepare_desc(struct irq_domain *domain, msi_alloc_info_t *arg,
> >  			   struct msi_desc *desc);
> > 
> 

