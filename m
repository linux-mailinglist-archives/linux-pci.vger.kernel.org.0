Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA9362CA59
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 21:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233106AbiKPUNG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 15:13:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiKPUNE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 15:13:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24120663C5;
        Wed, 16 Nov 2022 12:13:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B28FE61F7D;
        Wed, 16 Nov 2022 20:13:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5AB5C433D6;
        Wed, 16 Nov 2022 20:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668629582;
        bh=Pi6wjUcbqjzrm5rZ0MG9tAGYOVsJroIZr+otGIdZfTE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=uXjA45MZUC8eKO8OfdfyyKaepiT6aIESKtdk55q0nnLmFWcBL3OusNvc8GC5vsChW
         IcBWT1Cklxu1bYLFEOo7S4AQtFILhS12/nH9pIP0n6hp1dMUW8gYndqZwm6JA8BSD1
         UGqp0cXYmdNMtpi2DFTjOaC4JLpxp7ynqhFshvbcqfSCxxVlnj5h7Jo3sjjDOVdFFw
         uu8UouR8AjJdxuAtCr+QnzJY6w0Yb5Tax2pd5bOEBAgukC99A5kaH1gV1lszGbRZLv
         JsL40WMnue5XxAEO63/ei/YK0PwT7aAlVk0nu1Y7C+kWhF4zPdrQtNX5Y5vmmrOlbk
         DyHLuuP0a8nSQ==
Date:   Wed, 16 Nov 2022 14:13:00 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ashok Raj <ashok.raj@intel.com>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: Re: [patch 23/33] PCI/MSI: Split MSIX descriptor setup
Message-ID: <20221116201300.GA1133493@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111135206.577311313@linutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Spelled "MSI-X" elsewhere (subject line).

On Fri, Nov 11, 2022 at 02:58:47PM +0100, Thomas Gleixner wrote:
> The upcoming mechanism to allocate MSI-X vectors after enabling MSI-X needs
> to share some of the MSI-X descriptor setup.
> 
> The regular descriptor setup on enable has the following code flow:
> 
>     1) Allocate descriptor
>     2) Setup descriptor with PCI specific data
>     3) Insert descriptor
>     4) Allocate interrupts which in turn scans the inserted
>        descriptors
> 
> This cannot be easily changed because the PCI/MSI code needs to handle the
> legacy architecture specific allocation model and the irq domain model
> where quite some domains have the assumption that the above flow is how it
> works.
> 
> Ideally the code flow should look like this:
> 
>    1) Invoke allocation at the MSI core
>    2) MSI core allocates descriptor
>    3) MSI core calls back into the irq domain which fills in
>       the domain specific parts
> 
> This could be done for underlying parent MSI domains which support
> post-enable allocation/free but that would create significantly different
> code pathes for MSI/MSI-X enable.
> 
> Though for dynamic allocation which wants to share the allocation code with
> the upcoming PCI/IMS support its the right thing to do.

s/its/it's/

> Split the MSIX descriptor setup into the preallocation part which just sets

MSI-X

> the index and fills in the horrible hack of virtual IRQs and the real PCI
> specific MSI-X setup part which solely depends on the index in the
> descriptor. This allows to provide a common dynami allocation interface at

dynamic

> the MSI core level for both PCI/MSI-X and PCI/IMS.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Typos below.

> ---
>  drivers/pci/msi/msi.c |   72 +++++++++++++++++++++++++++++++-------------------
>  drivers/pci/msi/msi.h |    2 +
>  2 files changed, 47 insertions(+), 27 deletions(-)
> 
> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c
> @@ -569,34 +569,56 @@ static void __iomem *msix_map_region(str
>  	return ioremap(phys_addr, nr_entries * PCI_MSIX_ENTRY_SIZE);
>  }
>  
> -static int msix_setup_msi_descs(struct pci_dev *dev, void __iomem *base,
> -				struct msix_entry *entries, int nvec,
> -				struct irq_affinity_desc *masks)
> +/**
> + * msix_prepare_msi_desc - Prepare a half initialized MSI descriptor for operation
> + * @dev:	The PCI device for which the descriptor is prepared
> + * @desc:	The MSI descriptor for preparation
> + *
> + * This is seperate from msix_setup_msi_descs() below to handle dynamic

separate

> + * allocations for MSIX after initial enablement.

MSI-X (and again below)

> + * Ideally the whole MSIX setup would work that way, but there is no way to
> + * support this for the legacy arch_setup_msi_irqs() mechanism and for the
> + * fake irq domains like the x86 XEN one. Sigh...
> + *
> + * The descriptor is zeroed and only @desc::msi_index and @desc::affinity
> + * are set. When called from msix_setup_msi_descs() then the is_virtual
> + * attribute is initialized as well.
> + *
> + * Fill in the rest.
> + */
> +void msix_prepare_msi_desc(struct pci_dev *dev, struct msi_desc *desc)
> +{
> +	desc->nvec_used				= 1;
> +	desc->pci.msi_attrib.is_msix		= 1;
> +	desc->pci.msi_attrib.is_64		= 1;
> +	desc->pci.msi_attrib.default_irq	= dev->irq;
> +	desc->pci.mask_base			= dev->msix_base;
> +	desc->pci.msi_attrib.can_mask		= !pci_msi_ignore_mask &&
> +						  !desc->pci.msi_attrib.is_virtual;
> +
> +	if (desc->pci.msi_attrib.can_mask) {
> +		void __iomem *addr = pci_msix_desc_addr(desc);
> +
> +		desc->pci.msix_ctrl = readl(addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
> +	}
> +}
> +
> +static int msix_setup_msi_descs(struct pci_dev *dev, struct msix_entry *entries,
> +				int nvec, struct irq_affinity_desc *masks)
>  {
>  	int ret = 0, i, vec_count = pci_msix_vec_count(dev);
>  	struct irq_affinity_desc *curmsk;
>  	struct msi_desc desc;
> -	void __iomem *addr;
>  
>  	memset(&desc, 0, sizeof(desc));
>  
> -	desc.nvec_used			= 1;
> -	desc.pci.msi_attrib.is_msix	= 1;
> -	desc.pci.msi_attrib.is_64	= 1;
> -	desc.pci.msi_attrib.default_irq	= dev->irq;
> -	desc.pci.mask_base		= base;
> -
>  	for (i = 0, curmsk = masks; i < nvec; i++, curmsk++) {
>  		desc.msi_index = entries ? entries[i].entry : i;
>  		desc.affinity = masks ? curmsk : NULL;
>  		desc.pci.msi_attrib.is_virtual = desc.msi_index >= vec_count;
> -		desc.pci.msi_attrib.can_mask = !pci_msi_ignore_mask &&
> -					       !desc.pci.msi_attrib.is_virtual;
>  
> -		if (desc.pci.msi_attrib.can_mask) {
> -			addr = pci_msix_desc_addr(&desc);
> -			desc.pci.msix_ctrl = readl(addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
> -		}
> +		msix_prepare_msi_desc(dev, &desc);
>  
>  		ret = msi_insert_msi_desc(&dev->dev, &desc);
>  		if (ret)
> @@ -629,9 +651,8 @@ static void msix_mask_all(void __iomem *
>  		writel(ctrl, base + PCI_MSIX_ENTRY_VECTOR_CTRL);
>  }
>  
> -static int msix_setup_interrupts(struct pci_dev *dev, void __iomem *base,
> -				 struct msix_entry *entries, int nvec,
> -				 struct irq_affinity *affd)
> +static int msix_setup_interrupts(struct pci_dev *dev, struct msix_entry *entries,
> +				 int nvec, struct irq_affinity *affd)
>  {
>  	struct irq_affinity_desc *masks = NULL;
>  	int ret;
> @@ -640,7 +661,7 @@ static int msix_setup_interrupts(struct
>  		masks = irq_create_affinity_masks(nvec, affd);
>  
>  	msi_lock_descs(&dev->dev);
> -	ret = msix_setup_msi_descs(dev, base, entries, nvec, masks);
> +	ret = msix_setup_msi_descs(dev, entries, nvec, masks);
>  	if (ret)
>  		goto out_free;
>  
> @@ -678,7 +699,6 @@ static int msix_setup_interrupts(struct
>  static int msix_capability_init(struct pci_dev *dev, struct msix_entry *entries,
>  				int nvec, struct irq_affinity *affd)
>  {
> -	void __iomem *base;
>  	int ret, tsize;
>  	u16 control;
>  
> @@ -696,15 +716,13 @@ static int msix_capability_init(struct p
>  	pci_read_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, &control);
>  	/* Request & Map MSI-X table region */
>  	tsize = msix_table_size(control);
> -	base = msix_map_region(dev, tsize);
> -	if (!base) {
> +	dev->msix_base = msix_map_region(dev, tsize);
> +	if (!dev->msix_base) {
>  		ret = -ENOMEM;
>  		goto out_disable;
>  	}
>  
> -	dev->msix_base = base;
> -
> -	ret = msix_setup_interrupts(dev, base, entries, nvec, affd);
> +	ret = msix_setup_interrupts(dev, entries, nvec, affd);
>  	if (ret)
>  		goto out_disable;
>  
> @@ -719,7 +737,7 @@ static int msix_capability_init(struct p
>  	 * which takes the MSI-X mask bits into account even
>  	 * when MSI-X is disabled, which prevents MSI delivery.
>  	 */
> -	msix_mask_all(base, tsize);
> +	msix_mask_all(dev->msix_base, tsize);
>  	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_MASKALL, 0);
>  
>  	pcibios_free_irq(dev);
> --- a/drivers/pci/msi/msi.h
> +++ b/drivers/pci/msi/msi.h
> @@ -84,6 +84,8 @@ static inline __attribute_const__ u32 ms
>  	return (1 << (1 << desc->pci.msi_attrib.multi_cap)) - 1;
>  }
>  
> +void msix_prepare_msi_desc(struct pci_dev *dev, struct msi_desc *desc);
> +
>  /* Subsystem variables */
>  extern int pci_msi_enable;
>  
> 
