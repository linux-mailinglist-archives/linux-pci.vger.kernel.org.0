Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03E1F2943CA
	for <lists+linux-pci@lfdr.de>; Tue, 20 Oct 2020 22:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409404AbgJTUXD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Oct 2020 16:23:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:55760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409395AbgJTUXD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Oct 2020 16:23:03 -0400
Received: from localhost (170.sub-72-107-125.myvzw.com [72.107.125.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E78F22247;
        Tue, 20 Oct 2020 20:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603225382;
        bh=2hnesLcpm3R76sy9b11vA1g23v/WgZDpcGHN6Rt8i9Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=K/XQw6tBLbVRMO+ydKudJvg24LQ01pLrnQGt1cgLEC9Hb9AAFhyUquS2vV+ueo/5j
         oTzueb0V+OD4Cusyt5hkqoQo+kbn+m8n5cBy11xHHQ7vGz0qsBZaQFjyxs9ra11oBf
         shnwjnYt5tatymD0WaEs5Pi1krUxRQOkucT4wB2E=
Date:   Tue, 20 Oct 2020 15:23:00 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrzej Jakowski <andrzej.jakowski@linux.intel.com>,
        Sushma Kalakota <sushmax.kalakota@intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH 6/6] PCI: vmd: Disable MSI/X remapping when possible
Message-ID: <20201020202300.GA394066@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728194945.14126-7-jonathan.derrick@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 28, 2020 at 01:49:45PM -0600, Jon Derrick wrote:
> VMD will retransmit child device MSI/X using its own MSI/X table and
> requester-id. This limits the number of MSI/X available to the whole
> child device domain to the number of VMD MSI/X interrupts. Some VMD
> devices have a mode where this remapping can be disabled, allowing child
> device interrupts to bypass processing with the VMD MSI/X domain
> interrupt handler and going straight the child device interrupt handler,
> allowing for better performance and scaling. The requester-id still gets
> changed to the VMD endpoint's requester-id, and the interrupt remapping
> handlers have been updated to properly set IRTE for child device
> interrupts to the VMD endpoint's context.
> 
> Some VMD platforms have existing production BIOS which rely on MSI/X
> remapping and won't explicitly program the MSI/X remapping bit. This
> re-enables MSI/X remapping on unload.
> 
> Disabling MSI/X remapping is only available for Icelake Server and
> client VMD products.

I'm trying to button up the PCI pull request.  I'm updating Lorenzo's
pci/vmd branch for other reasons, and I notice it still contains this
commit: 67b219dc3a6d ("PCI: vmd: Disable MSI/X remapping when
possible").

I want to remove "MSI/X" from the commit log and comments of that
commit because I don't know what "MSI/X" means.

Should I replace it with "MSI" or "MSI-X" or "MSI/MSI-X"?  Something
else?  When possible, I want to use exactly the same terminology as
the PCIe spec to avoid ambiguity.

It talks about "MSI/X table", which makes me think it should be
"MSI-X", since plain MSI does not have a table.

> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> ---
>  drivers/pci/controller/vmd.c | 58 +++++++++++++++++++++++++++++++-----
>  1 file changed, 50 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index 3214d785fa5d..e8cde2c390b9 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -53,6 +53,12 @@ enum vmd_features {
>  	 * vendor-specific capability space
>  	 */
>  	VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP	= (1 << 2),
> +
> +	/*
> +	 * Device remaps MSI/X transactions into its MSI/X table and requires
> +	 * VMD MSI domain for child device interrupt handling
> +	 */
> +	VMD_FEAT_REMAPS_MSI			= (1 << 3),
>  };
>  
>  /*
> @@ -298,6 +304,15 @@ static struct msi_domain_info vmd_msi_domain_info = {
>  	.chip		= &vmd_msi_controller,
>  };
>  
> +static void vmd_enable_msi_remapping(struct vmd_dev *vmd, bool enable)
> +{
> +	u16 reg;
> +
> +	pci_read_config_word(vmd->dev, PCI_REG_VMCONFIG, &reg);
> +	reg = enable ? (reg & ~0x2) : (reg | 0x2);
> +	pci_write_config_word(vmd->dev, PCI_REG_VMCONFIG, reg);
> +}
> +
>  static int vmd_create_irq_domain(struct vmd_dev *vmd)
>  {
>  	struct fwnode_handle *fn;
> @@ -318,6 +333,13 @@ static int vmd_create_irq_domain(struct vmd_dev *vmd)
>  
>  static void vmd_remove_irq_domain(struct vmd_dev *vmd)
>  {
> +	/*
> +	 * Some production BIOS won't enable remapping between soft reboots.
> +	 * Ensure remapping is restored before unloading the driver
> +	 */
> +	if (!vmd->msix_count)
> +		vmd_enable_msi_remapping(vmd, true);
> +
>  	if (vmd->irq_domain) {
>  		struct fwnode_handle *fn = vmd->irq_domain->fwnode;
>  
> @@ -606,6 +628,27 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  			return ret;
>  	}
>  
> +	/*
> +	 * Currently MSI remapping must be enabled in guest passthrough mode
> +	 * due to some missing interrupt remapping plumbing. This is probably
> +	 * acceptable because the guest is usually CPU-limited and MSI
> +	 * remapping doesn't become a performance bottleneck.
> +	 */
> +	if (features & VMD_FEAT_REMAPS_MSI || offset[0] || offset[1]) {
> +		ret = vmd_alloc_irqs(vmd);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	/*
> +	 * Disable remapping for performance if possible based on if VMD IRQs
> +	 * had been allocated.
> +	 */
> +	if (vmd->msix_count)
> +		vmd_enable_msi_remapping(vmd, true);
> +	else
> +		vmd_enable_msi_remapping(vmd, false);
> +
>  	/*
>  	 * Certain VMD devices may have a root port configuration option which
>  	 * limits the bus range to between 0-127, 128-255, or 224-255
> @@ -674,9 +717,11 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  
>  	sd->node = pcibus_to_node(vmd->dev->bus);
>  
> -	ret = vmd_create_irq_domain(vmd);
> -	if (ret)
> -		return ret;
> +	if (vmd->msix_count) {
> +		ret = vmd_create_irq_domain(vmd);
> +		if (ret)
> +			return ret;
> +	}
>  
>  	pci_add_resource(&resources, &vmd->resources[0]);
>  	pci_add_resource_offset(&resources, &vmd->resources[1], offset[0]);
> @@ -738,10 +783,6 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  	    dma_set_mask_and_coherent(&dev->dev, DMA_BIT_MASK(32)))
>  		return -ENODEV;
>  
> -	err = vmd_alloc_irqs(vmd);
> -	if (err)
> -		return err;
> -
>  	spin_lock_init(&vmd->cfg_lock);
>  	pci_set_drvdata(dev, vmd);
>  	err = vmd_enable_domain(vmd, (unsigned long) id->driver_data);
> @@ -809,7 +850,8 @@ static SIMPLE_DEV_PM_OPS(vmd_dev_pm_ops, vmd_suspend, vmd_resume);
>  
>  static const struct pci_device_id vmd_ids[] = {
>  	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_201D),
> -		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP,},
> +		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
> +				VMD_FEAT_REMAPS_MSI,},
>  	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_28C0),
>  		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW |
>  				VMD_FEAT_HAS_BUS_RESTRICTIONS,},
> -- 
> 2.27.0
> 
