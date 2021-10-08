Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD93C427383
	for <lists+linux-pci@lfdr.de>; Sat,  9 Oct 2021 00:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243534AbhJHWRl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Oct 2021 18:17:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:58928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231830AbhJHWRk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 Oct 2021 18:17:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 530F461038;
        Fri,  8 Oct 2021 22:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633731344;
        bh=yRweD7oxpNUXR1CZJlYZjkU/WfsQ0LO0he/zDigAXHc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=jThzx4lZbKYaBrtN34K22GDVGpyfz4R8hBiK0vQrqI5Ka8Pk5v3tUxpyXEt/6K6ft
         eLnkCSTmDqgqeBR8Pnf4a73uJRwyXH0b9FgAl+BDNnHaspjc39E+abIY9fciYnrVJD
         yf/HzIwr+4iIVgXB5Yi6Co8qIrQXQsVF2K/IXgUJKRHP5TkyrfGsSJFcf/J8OyWxkh
         cKBS8YSnTwFMGi2/IqFA7cpuINdi9nPZBlZ24NVBT7vXGZifQkAV9AEBrKkV/HMya9
         4IuZwW1LN0GMqsyNVuLBahZHWrUv62yzfhMVFLmp6ZUecGX4x6jP4ZfT5uLZKMU6s5
         +24X16l5jEBlA==
Date:   Fri, 8 Oct 2021 17:15:43 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Correct misspelled and remove duplicated words
Message-ID: <20211008221543.GA1384344@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211006233827.147328-1-kw@linux.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 06, 2021 at 11:38:27PM +0000, Krzysztof Wilczyński wrote:
> Correct a number of misspelled words and remove any words that were
> duplicated in the PCI tree.  No change to functionality intended.
> 
> Signed-off-by: Krzysztof Wilczyński <kw@linux.com>

Applied to pci/misc for v5.16, thanks!

> ---
>  drivers/pci/controller/pci-xgene-msi.c | 2 +-
>  drivers/pci/controller/pcie-brcmstb.c  | 2 +-
>  drivers/pci/controller/pcie-iproc.c    | 2 +-
>  drivers/pci/endpoint/pci-epc-core.c    | 2 +-
>  drivers/pci/endpoint/pci-epf-core.c    | 4 ++--
>  drivers/pci/hotplug/acpiphp_glue.c     | 2 +-
>  drivers/pci/hotplug/cpqphp_ctrl.c      | 4 ++--
>  drivers/pci/hotplug/ibmphp.h           | 4 ++--
>  drivers/pci/hotplug/shpchp_hpc.c       | 2 +-
>  drivers/pci/pci-driver.c               | 2 +-
>  drivers/pci/pcie/aer.c                 | 2 +-
>  drivers/pci/quirks.c                   | 2 +-
>  12 files changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-xgene-msi.c b/drivers/pci/controller/pci-xgene-msi.c
> index b7a8e062fcc5..c50ff279903c 100644
> --- a/drivers/pci/controller/pci-xgene-msi.c
> +++ b/drivers/pci/controller/pci-xgene-msi.c
> @@ -302,7 +302,7 @@ static void xgene_msi_isr(struct irq_desc *desc)
>  
>  	/*
>  	 * MSIINTn (n is 0..F) indicates if there is a pending MSI interrupt
> -	 * If bit x of this register is set (x is 0..7), one or more interupts
> +	 * If bit x of this register is set (x is 0..7), one or more interrupts
>  	 * corresponding to MSInIRx is set.
>  	 */
>  	grp_select = xgene_msi_int_read(xgene_msi, msi_grp);
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index cc30215f5a43..1fc7bd49a7ad 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -145,7 +145,7 @@
>  #define BRCM_INT_PCI_MSI_LEGACY_NR	8
>  #define BRCM_INT_PCI_MSI_SHIFT		0
>  
> -/* MSI target adresses */
> +/* MSI target addresses */
>  #define BRCM_MSI_TARGET_ADDR_LT_4GB	0x0fffffffcULL
>  #define BRCM_MSI_TARGET_ADDR_GT_4GB	0xffffffffcULL
>  
> diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
> index 30ac5fbefbbf..36b9d2c46cfa 100644
> --- a/drivers/pci/controller/pcie-iproc.c
> +++ b/drivers/pci/controller/pcie-iproc.c
> @@ -249,7 +249,7 @@ enum iproc_pcie_reg {
>  
>  	/*
>  	 * To hold the address of the register where the MSI writes are
> -	 * programed.  When ARM GICv3 ITS is used, this should be programmed
> +	 * programmed.  When ARM GICv3 ITS is used, this should be programmed
>  	 * with the address of the GITS_TRANSLATER register.
>  	 */
>  	IPROC_PCIE_MSI_ADDR_LO,
> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> index ecbb0fb3b653..38621558d397 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
> @@ -700,7 +700,7 @@ EXPORT_SYMBOL_GPL(pci_epc_linkup);
>  /**
>   * pci_epc_init_notify() - Notify the EPF device that EPC device's core
>   *			   initialization is completed.
> - * @epc: the EPC device whose core initialization is completeds
> + * @epc: the EPC device whose core initialization is completed
>   *
>   * Invoke to Notify the EPF device that the EPC device's initialization
>   * is completed.
> diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
> index 8aea16380870..9ed556936f48 100644
> --- a/drivers/pci/endpoint/pci-epf-core.c
> +++ b/drivers/pci/endpoint/pci-epf-core.c
> @@ -224,7 +224,7 @@ EXPORT_SYMBOL_GPL(pci_epf_add_vepf);
>   *   be removed
>   * @epf_vf: the virtual EP function to be removed
>   *
> - * Invoke to remove a virtual endpoint function from the physcial endpoint
> + * Invoke to remove a virtual endpoint function from the physical endpoint
>   * function.
>   */
>  void pci_epf_remove_vepf(struct pci_epf *epf_pf, struct pci_epf *epf_vf)
> @@ -432,7 +432,7 @@ EXPORT_SYMBOL_GPL(pci_epf_destroy);
>  /**
>   * pci_epf_create() - create a new PCI EPF device
>   * @name: the name of the PCI EPF device. This name will be used to bind the
> - *	  the EPF device to a EPF driver
> + *	  EPF device to a EPF driver
>   *
>   * Invoke to create a new PCI EPF device by providing the name of the function
>   * device.
> diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
> index f031302ad401..12f4b351be67 100644
> --- a/drivers/pci/hotplug/acpiphp_glue.c
> +++ b/drivers/pci/hotplug/acpiphp_glue.c
> @@ -22,7 +22,7 @@
>   *    when the bridge is scanned and it loses a refcount when the bridge
>   *    is removed.
>   *  - When a P2P bridge is present, we elevate the refcount on the subordinate
> - *    bus. It loses the refcount when the the driver unloads.
> + *    bus. It loses the refcount when the driver unloads.
>   */
>  
>  #define pr_fmt(fmt) "acpiphp_glue: " fmt
> diff --git a/drivers/pci/hotplug/cpqphp_ctrl.c b/drivers/pci/hotplug/cpqphp_ctrl.c
> index 1b26ca0b3701..ed7b58eb64d2 100644
> --- a/drivers/pci/hotplug/cpqphp_ctrl.c
> +++ b/drivers/pci/hotplug/cpqphp_ctrl.c
> @@ -519,7 +519,7 @@ static struct pci_resource *do_bridge_resource_split(struct pci_resource **head,
>   * @head: list to search
>   * @size: size of node to find, must be a power of two.
>   *
> - * Description: This function sorts the resource list by size and then returns
> + * Description: This function sorts the resource list by size and then
>   * returns the first node of "size" length that is not in the ISA aliasing
>   * window.  If it finds a node larger than "size" it will split it up.
>   */
> @@ -1202,7 +1202,7 @@ static u8 set_controller_speed(struct controller *ctrl, u8 adapter_speed, u8 hp_
>  
>  	mdelay(5);
>  
> -	/* Reenable interrupts */
> +	/* Re-enable interrupts */
>  	writel(0, ctrl->hpc_reg + INT_MASK);
>  
>  	pci_write_config_byte(ctrl->pci_dev, 0x41, reg);
> diff --git a/drivers/pci/hotplug/ibmphp.h b/drivers/pci/hotplug/ibmphp.h
> index e90a4ebf6550..0399c60d2ec1 100644
> --- a/drivers/pci/hotplug/ibmphp.h
> +++ b/drivers/pci/hotplug/ibmphp.h
> @@ -352,7 +352,7 @@ struct resource_node {
>  	u32 len;
>  	int type;		/* MEM, IO, PFMEM */
>  	u8 fromMem;		/* this is to indicate that the range is from
> -				 * from the Memory bucket rather than from PFMem */
> +				 * the Memory bucket rather than from PFMem */
>  	struct resource_node *next;
>  	struct resource_node *nextRange;	/* for the other mem range on bus */
>  };
> @@ -736,7 +736,7 @@ struct controller {
>  
>  int ibmphp_init_devno(struct slot **);	/* This function is called from EBDA, so we need it not be static */
>  int ibmphp_do_disable_slot(struct slot *slot_cur);
> -int ibmphp_update_slot_info(struct slot *);	/* This function is called from HPC, so we need it to not be be static */
> +int ibmphp_update_slot_info(struct slot *);	/* This function is called from HPC, so we need it to not be static */
>  int ibmphp_configure_card(struct pci_func *, u8);
>  int ibmphp_unconfigure_card(struct slot **, int);
>  extern const struct hotplug_slot_ops ibmphp_hotplug_slot_ops;
> diff --git a/drivers/pci/hotplug/shpchp_hpc.c b/drivers/pci/hotplug/shpchp_hpc.c
> index 9e3b27744305..bd7557ca4910 100644
> --- a/drivers/pci/hotplug/shpchp_hpc.c
> +++ b/drivers/pci/hotplug/shpchp_hpc.c
> @@ -295,7 +295,7 @@ static int shpc_write_cmd(struct slot *slot, u8 t_slot, u8 cmd)
>  	mutex_lock(&slot->ctrl->cmd_lock);
>  
>  	if (!shpc_poll_ctrl_busy(ctrl)) {
> -		/* After 1 sec and and the controller is still busy */
> +		/* After 1 sec and the controller is still busy */
>  		ctrl_err(ctrl, "Controller is still busy after 1 sec\n");
>  		retval = -EBUSY;
>  		goto out;
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 2761ab86490d..df3bd7b40542 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -576,7 +576,7 @@ static int pci_pm_reenable_device(struct pci_dev *pci_dev)
>  {
>  	int retval;
>  
> -	/* if the device was enabled before suspend, reenable */
> +	/* if the device was enabled before suspend, re-enable */
>  	retval = pci_reenable_device(pci_dev);
>  	/*
>  	 * if the device was busmaster before the suspend, make it busmaster
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 9784fdcf3006..9fa1f97e5b27 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -57,7 +57,7 @@ struct aer_stats {
>  	 * "as seen by this device". Note that this may mean that if an
>  	 * end point is causing problems, the AER counters may increment
>  	 * at its link partner (e.g. root port) because the errors will be
> -	 * "seen" by the link partner and not the the problematic end point
> +	 * "seen" by the link partner and not the problematic end point
>  	 * itself (which may report all counters as 0 as it never saw any
>  	 * problems).
>  	 */
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 4537d1ea14fd..881c5d7c3d02 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -2700,7 +2700,7 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA,
>   * then the device can't use INTx interrupts. Tegra's PCIe root ports don't
>   * generate MSI interrupts for PME and AER events instead only INTx interrupts
>   * are generated. Though Tegra's PCIe root ports can generate MSI interrupts
> - * for other events, since PCIe specificiation doesn't support using a mix of
> + * for other events, since PCIe specification doesn't support using a mix of
>   * INTx and MSI/MSI-X, it is required to disable MSI interrupts to avoid port
>   * service drivers registering their respective ISRs for MSIs.
>   */
> -- 
> 2.33.0
> 
