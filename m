Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3998D3119F4
	for <lists+linux-pci@lfdr.de>; Sat,  6 Feb 2021 04:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbhBFDYx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Feb 2021 22:24:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:43880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232516AbhBFDV4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 5 Feb 2021 22:21:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1197560C3D;
        Fri,  5 Feb 2021 21:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612562241;
        bh=ZN48Ca5F36yaf5Drs7x+C/29r4xyz8+M1y9jXHdbi24=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=nAY41uOB3KikAGegz2nWmDV69PPAzAYy+ERiEx8Qb53sk+fWwA2JhgIP65ysw1XM6
         P6Go38C8VoIMQYjqjOm6d5kYhctDXJn4YnRx3d1zH45JSDWN6MchYsgcsS/XK0T4eE
         uhdPxyKlzZNDDVvQqP+fuy/brUD1J7ADC172BhA9JWSNDjvMab2ouNWAa2WuFAEo7q
         IN9KmPJyiXSvKCxB9YuQO2QutSwa1w2Sv4ZrespGhDGPz+b+drFIp3cMW7k4XtsdzH
         2UT7EUqyovINJ+VeSjRlH45K11zEAPjyNGv0NKuQwLx82L41Qm2x2G9n0iU4MxjLi+
         xez5xCE2ixOaQ==
Date:   Fri, 5 Feb 2021 15:57:18 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Nirmal Patel <nirmal.patel@intel.com>,
        Kapil Karkra <kapil.karkra@intel.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 2/2] PCI: vmd: Disable MSI/X remapping when possible
Message-ID: <20210205215718.GA202474@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210204190906.38515-3-jonathan.derrick@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 04, 2021 at 12:09:06PM -0700, Jon Derrick wrote:
> VMD will retransmit child device MSI/X using its own MSI/X table and
> requester-id. This limits the number of MSI/X available to the whole
> child device domain to the number of VMD MSI/X interrupts.
> 
> Some VMD devices have a mode where this remapping can be disabled,
> allowing child device interrupts to bypass processing with the VMD MSI/X
> domain interrupt handler and going straight the child device interrupt
> handler, allowing for better performance and scaling. The requester-id
> still gets changed to the VMD endpoint's requester-id, and the interrupt
> remapping handlers have been updated to properly set IRTE for child
> device interrupts to the VMD endpoint's context.
> 
> Some VMD platforms have existing production BIOS which rely on MSI/X
> remapping and won't explicitly program the MSI/X remapping bit. This
> re-enables MSI/X remapping on unload.

Trivial comments below.  Would you mind using "MSI-X" instead of
"MSI/X" so it matches the usage in the PCIe specs?  Several mentions
above (including subject) and below.

> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> ---
>  drivers/pci/controller/vmd.c | 60 ++++++++++++++++++++++++++++--------
>  1 file changed, 48 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index 5e80f28f0119..a319ce49645b 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -59,6 +59,13 @@ enum vmd_features {
>  	 * be used for MSI remapping
>  	 */
>  	VMD_FEAT_OFFSET_FIRST_VECTOR		= (1 << 3),
> +
> +	/*
> +	 * Device can bypass remapping MSI/X transactions into its MSI/X table,
> +	 * avoding the requirement of a VMD MSI domain for child device

s/avoding/avoiding/

> +	 * interrupt handling

Maybe a period at the end of the sentence.

> +	 */
> +	VMD_FEAT_BYPASS_MSI_REMAP		= (1 << 4),
>  };
>  
>  /*
> @@ -306,6 +313,15 @@ static struct msi_domain_info vmd_msi_domain_info = {
>  	.chip		= &vmd_msi_controller,
>  };
>  
> +static void vmd_enable_msi_remapping(struct vmd_dev *vmd, bool enable)
> +{
> +	u16 reg;
> +
> +	pci_read_config_word(vmd->dev, PCI_REG_VMCONFIG, &reg);
> +	reg = enable ? (reg & ~0x2) : (reg | 0x2);

Would be nice to have a #define for 0x2.

> +	pci_write_config_word(vmd->dev, PCI_REG_VMCONFIG, reg);
> +}
> +
>  static int vmd_create_irq_domain(struct vmd_dev *vmd)
>  {
>  	struct fwnode_handle *fn;
> @@ -325,6 +341,13 @@ static int vmd_create_irq_domain(struct vmd_dev *vmd)
>  
>  static void vmd_remove_irq_domain(struct vmd_dev *vmd)
>  {
> +	/*
> +	 * Some production BIOS won't enable remapping between soft reboots.
> +	 * Ensure remapping is restored before unloading the driver.
> +	 */
> +	if (!vmd->msix_count)
> +		vmd_enable_msi_remapping(vmd, true);
> +
>  	if (vmd->irq_domain) {
>  		struct fwnode_handle *fn = vmd->irq_domain->fwnode;
>  
> @@ -679,15 +702,31 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  
>  	sd->node = pcibus_to_node(vmd->dev->bus);
>  
> -	ret = vmd_create_irq_domain(vmd);
> -	if (ret)
> -		return ret;
> -
>  	/*
> -	 * Override the irq domain bus token so the domain can be distinguished
> -	 * from a regular PCI/MSI domain.
> +	 * Currently MSI remapping must be enabled in guest passthrough mode
> +	 * due to some missing interrupt remapping plumbing. This is probably
> +	 * acceptable because the guest is usually CPU-limited and MSI
> +	 * remapping doesn't become a performance bottleneck.
>  	 */
> -	irq_domain_update_bus_token(vmd->irq_domain, DOMAIN_BUS_VMD_MSI);
> +	if (!(features & VMD_FEAT_BYPASS_MSI_REMAP) || offset[0] || offset[1]) {
> +		ret = vmd_alloc_irqs(vmd);
> +		if (ret)
> +			return ret;
> +
> +		vmd_enable_msi_remapping(vmd, true);
> +
> +		ret = vmd_create_irq_domain(vmd);
> +		if (ret)
> +			return ret;
> +
> +		/*
> +		 * Override the irq domain bus token so the domain can be
> +		 * distinguished from a regular PCI/MSI domain.
> +		 */
> +		irq_domain_update_bus_token(vmd->irq_domain, DOMAIN_BUS_VMD_MSI);
> +	} else {
> +		vmd_enable_msi_remapping(vmd, false);
> +	}
>  
>  	pci_add_resource(&resources, &vmd->resources[0]);
>  	pci_add_resource_offset(&resources, &vmd->resources[1], offset[0]);
> @@ -753,10 +792,6 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  	if (features & VMD_FEAT_OFFSET_FIRST_VECTOR)
>  		vmd->first_vec = 1;
>  
> -	err = vmd_alloc_irqs(vmd);
> -	if (err)
> -		return err;
> -
>  	spin_lock_init(&vmd->cfg_lock);
>  	pci_set_drvdata(dev, vmd);
>  	err = vmd_enable_domain(vmd, features);
> @@ -825,7 +860,8 @@ static const struct pci_device_id vmd_ids[] = {
>  		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP,},
>  	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_28C0),
>  		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW |
> -				VMD_FEAT_HAS_BUS_RESTRICTIONS,},
> +				VMD_FEAT_HAS_BUS_RESTRICTIONS |
> +				VMD_FEAT_BYPASS_MSI_REMAP,},
>  	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x467f),
>  		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
>  				VMD_FEAT_HAS_BUS_RESTRICTIONS |
> -- 
> 2.27.0
> 
