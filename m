Return-Path: <linux-pci+bounces-25692-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FCC8A866FB
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 22:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95FD2447EBE
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 20:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB8D268C48;
	Fri, 11 Apr 2025 20:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pNa8x/j0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C23487BF;
	Fri, 11 Apr 2025 20:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744403062; cv=none; b=tSk1hhG7sdOchm2aewdaHw0sk2b12VVT83DoPn4Y1I/T/2q3OEjF6X3WsBGS4lMHRCPyhDYIeMokUS7AVhhKsF0ZfVLn/zAjZT/tOBUDSU9S7B//DbtUHSpKGyN62+OdTsKDAL9luOQ4QpQQRwiNbottj6muy74RAE0vl1rliUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744403062; c=relaxed/simple;
	bh=PyXWUrj+zWeoFk2WMmLXCwEJUBjoSy9DXUucWu3r8oo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WOEyDC3HJjJ8a7KAOt0s4mIzYeuLW8v9ZKC4a6q5DjIpiIVL50jjShWW1lXvY1zevVdfKqF4se1MJU/OB001V3GrFIINjQs8s1jb6OwbUJPHijXU8BhwSPhIZBQliraTCHamK/aRYeEGunQDDJlQPR2d8VU4w37mNXi4eO76pmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pNa8x/j0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 288A3C4CEE2;
	Fri, 11 Apr 2025 20:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744403061;
	bh=PyXWUrj+zWeoFk2WMmLXCwEJUBjoSy9DXUucWu3r8oo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pNa8x/j00q7VpffdAC6gWVq4fDq1kSUnK82QRaN2n8wZoNVgG+xvffs78N1nVYwK/
	 RY51v/kH/5wZD4h9AMwA2WD7ZuU9GctZ1E++9/RZfzzRb2q7OccoptVS35itqfnrw/
	 7HAAZpc+beosgYaJCmDCkMBDfGVR+xwCKb/zbOhiA8n5KWfDjNIl0mSpMTkkTQJCGH
	 0XB52f3kneo+qaYx+qi9Yfw2NLXMnXRZ14S8eG/WP7esn8zsfWooHY4vnqhzAhd7rM
	 KOyiwWk4Ucn62JUYKvnWQwcyDW+/fKdZD7r5EqUuwshGHjSZ+Qxpx6qlGdoETEk+q9
	 ulyC3OGcD+EvA==
Date: Fri, 11 Apr 2025 15:24:20 -0500
From: Rob Herring <robh@kernel.org>
To: hans.zhang@cixtech.com
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	manivannan.sadhasivam@linaro.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Manikandan K Pillai <mpillai@cadence.com>
Subject: Re: [PATCH v3 5/6] PCI: cadence: Add callback functions for RP and
 EP controller
Message-ID: <20250411202420.GA3793660-robh@kernel.org>
References: <20250411103656.2740517-1-hans.zhang@cixtech.com>
 <20250411103656.2740517-6-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250411103656.2740517-6-hans.zhang@cixtech.com>

On Fri, Apr 11, 2025 at 06:36:55PM +0800, hans.zhang@cixtech.com wrote:
> From: Manikandan K Pillai <mpillai@cadence.com>
> 
> Add support for the Cadence PCIe HPA controller by adding
> the required callback functions. Update the common functions for
> RP and EP configuration. Invoke the relevant callback functions
> for platform probe of PCIe controller using the callback function.
> 
> Signed-off-by: Manikandan K Pillai <mpillai@cadence.com>
> Co-developed-by: Hans Zhang <hans.zhang@cixtech.com>
> Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
> ---
>  .../pci/controller/cadence/pcie-cadence-ep.c  |  29 +-
>  .../controller/cadence/pcie-cadence-host.c    | 271 ++++++++++++++++--
>  .../controller/cadence/pcie-cadence-plat.c    |  23 ++
>  drivers/pci/controller/cadence/pcie-cadence.c | 196 ++++++++++++-
>  drivers/pci/controller/cadence/pcie-cadence.h |  12 +
>  5 files changed, 488 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> index f3f956fa116b..f4961c760434 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> @@ -192,7 +192,7 @@ static int cdns_pcie_ep_map_addr(struct pci_epc *epc, u8 fn, u8 vfn,
>  	}
>  
>  	fn = cdns_pcie_get_fn_from_vfn(pcie, fn, vfn);
> -	cdns_pcie_set_outbound_region(pcie, 0, fn, r, false, addr, pci_addr, size);
> +	pcie->ops->set_outbound_region(pcie, 0, fn, r, false, addr, pci_addr, size);
>  
>  	set_bit(r, &ep->ob_region_map);
>  	ep->ob_addr[r] = addr;
> @@ -214,7 +214,7 @@ static void cdns_pcie_ep_unmap_addr(struct pci_epc *epc, u8 fn, u8 vfn,
>  	if (r == ep->max_regions - 1)
>  		return;
>  
> -	cdns_pcie_reset_outbound_region(pcie, r);
> +	pcie->ops->reset_outbound_region(pcie, r);
>  
>  	ep->ob_addr[r] = 0;
>  	clear_bit(r, &ep->ob_region_map);
> @@ -329,8 +329,7 @@ static void cdns_pcie_ep_assert_intx(struct cdns_pcie_ep *ep, u8 fn, u8 intx,
>  	if (unlikely(ep->irq_pci_addr != CDNS_PCIE_EP_IRQ_PCI_ADDR_LEGACY ||
>  		     ep->irq_pci_fn != fn)) {
>  		/* First region was reserved for IRQ writes. */
> -		cdns_pcie_set_outbound_region_for_normal_msg(pcie, 0, fn, 0,
> -							     ep->irq_phys_addr);
> +		pcie->ops->set_outbound_region_for_normal_msg(pcie, 0, fn, 0, ep->irq_phys_addr);
>  		ep->irq_pci_addr = CDNS_PCIE_EP_IRQ_PCI_ADDR_LEGACY;
>  		ep->irq_pci_fn = fn;
>  	}
> @@ -411,11 +410,11 @@ static int cdns_pcie_ep_send_msi_irq(struct cdns_pcie_ep *ep, u8 fn, u8 vfn,
>  	if (unlikely(ep->irq_pci_addr != (pci_addr & ~pci_addr_mask) ||
>  		     ep->irq_pci_fn != fn)) {
>  		/* First region was reserved for IRQ writes. */
> -		cdns_pcie_set_outbound_region(pcie, 0, fn, 0,
> -					      false,
> -					      ep->irq_phys_addr,
> -					      pci_addr & ~pci_addr_mask,
> -					      pci_addr_mask + 1);
> +		pcie->ops->set_outbound_region(pcie, 0, fn, 0,
> +					       false,
> +					       ep->irq_phys_addr,
> +					       pci_addr & ~pci_addr_mask,
> +					       pci_addr_mask + 1);
>  		ep->irq_pci_addr = (pci_addr & ~pci_addr_mask);
>  		ep->irq_pci_fn = fn;
>  	}
> @@ -514,11 +513,11 @@ static int cdns_pcie_ep_send_msix_irq(struct cdns_pcie_ep *ep, u8 fn, u8 vfn,
>  	if (ep->irq_pci_addr != (msg_addr & ~pci_addr_mask) ||
>  	    ep->irq_pci_fn != fn) {
>  		/* First region was reserved for IRQ writes. */
> -		cdns_pcie_set_outbound_region(pcie, 0, fn, 0,
> -					      false,
> -					      ep->irq_phys_addr,
> -					      msg_addr & ~pci_addr_mask,
> -					      pci_addr_mask + 1);
> +		pcie->ops->set_outbound_region(pcie, 0, fn, 0,
> +					       false,
> +					       ep->irq_phys_addr,
> +					       msg_addr & ~pci_addr_mask,
> +					       pci_addr_mask + 1);
>  		ep->irq_pci_addr = (msg_addr & ~pci_addr_mask);
>  		ep->irq_pci_fn = fn;
>  	}
> @@ -869,7 +868,7 @@ int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
>  	set_bit(0, &ep->ob_region_map);
>  
>  	if (ep->quirk_detect_quiet_flag)
> -		cdns_pcie_detect_quiet_min_delay_set(&ep->pcie);
> +		pcie->ops->detect_quiet_min_delay_set(&ep->pcie);
>  
>  	spin_lock_init(&ep->lock);
>  
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
> index ce035eef0a5c..c7066ea3b9e8 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
> @@ -60,10 +60,7 @@ void __iomem *cdns_pci_map_bus(struct pci_bus *bus, unsigned int devfn,
>  	/* Configuration Type 0 or Type 1 access. */
>  	desc0 = CDNS_PCIE_AT_OB_REGION_DESC0_HARDCODED_RID |
>  		CDNS_PCIE_AT_OB_REGION_DESC0_DEVFN(0);
> -	/*
> -	 * The bus number was already set once for all in desc1 by
> -	 * cdns_pcie_host_init_address_translation().
> -	 */
> +
>  	if (busn == bridge->busnr + 1)
>  		desc0 |= CDNS_PCIE_AT_OB_REGION_DESC0_TYPE_CONF_TYPE0;
>  	else
> @@ -73,12 +70,81 @@ void __iomem *cdns_pci_map_bus(struct pci_bus *bus, unsigned int devfn,
>  	return rc->cfg_base + (where & 0xfff);
>  }
>  
> +void __iomem *cdns_pci_hpa_map_bus(struct pci_bus *bus, unsigned int devfn,
> +				   int where)
> +{
> +	struct pci_host_bridge *bridge = pci_find_host_bridge(bus);
> +	struct cdns_pcie_rc *rc = pci_host_bridge_priv(bridge);
> +	struct cdns_pcie *pcie = &rc->pcie;
> +	unsigned int busn = bus->number;
> +	u32 addr0, desc0, desc1, ctrl0;
> +	u32 regval;
> +
> +	if (pci_is_root_bus(bus)) {
> +		/*
> +		 * Only the root port (devfn == 0) is connected to this bus.
> +		 * All other PCI devices are behind some bridge hence on another
> +		 * bus.
> +		 */
> +		if (devfn)
> +			return NULL;
> +
> +		return pcie->reg_base + (where & 0xfff);
> +	}
> +
> +	/*
> +	 * Clear AXI link-down status
> +	 */

That is an odd thing to do in map_bus. Also, it is completely racy 
because...

> +	regval = cdns_pcie_hpa_readl(pcie, REG_BANK_AXI_SLAVE, CDNS_PCIE_HPA_AT_LINKDOWN);
> +	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE, CDNS_PCIE_HPA_AT_LINKDOWN,
> +			     (regval & GENMASK(0, 0)));
> +

What if the link goes down again here.

> +	desc1 = 0;
> +	ctrl0 = 0;
> +
> +	/*
> +	 * Update Output registers for AXI region 0.
> +	 */
> +	addr0 = CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_NBITS(12) |
> +		CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_DEVFN(devfn) |
> +		CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_BUS(busn);
> +	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
> +			     CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0(0), addr0);
> +
> +	desc1 = cdns_pcie_hpa_readl(pcie, REG_BANK_AXI_SLAVE,
> +				    CDNS_PCIE_HPA_AT_OB_REGION_DESC1(0));
> +	desc1 &= ~CDNS_PCIE_HPA_AT_OB_REGION_DESC1_DEVFN_MASK;
> +	desc1 |= CDNS_PCIE_HPA_AT_OB_REGION_DESC1_DEVFN(0);
> +	ctrl0 = CDNS_PCIE_HPA_AT_OB_REGION_CTRL0_SUPPLY_BUS |
> +		CDNS_PCIE_HPA_AT_OB_REGION_CTRL0_SUPPLY_DEV_FN;
> +
> +	if (busn == bridge->busnr + 1)
> +		desc0 |= CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_CONF_TYPE0;
> +	else
> +		desc0 |= CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_CONF_TYPE1;
> +
> +	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
> +			     CDNS_PCIE_HPA_AT_OB_REGION_DESC0(0), desc0);
> +	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
> +			     CDNS_PCIE_HPA_AT_OB_REGION_DESC1(0), desc1);
> +	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
> +			     CDNS_PCIE_HPA_AT_OB_REGION_CTRL0(0), ctrl0);

This is also racy with the read and write functions. Don't worry, lots 
of other broken h/w like this...

Surely this new h/w supports ECAM style config accesses? If so, use 
and support that mode instead.

> +
> +	return rc->cfg_base + (where & 0xfff);
> +}
> +
>  static struct pci_ops cdns_pcie_host_ops = {
>  	.map_bus	= cdns_pci_map_bus,
>  	.read		= pci_generic_config_read,
>  	.write		= pci_generic_config_write,
>  };
>  
> +static struct pci_ops cdns_pcie_hpa_host_ops = {
> +	.map_bus	= cdns_pci_hpa_map_bus,
> +	.read           = pci_generic_config_read,
> +	.write		= pci_generic_config_write,
> +};
> +
>  static int cdns_pcie_host_training_complete(struct cdns_pcie *pcie)
>  {
>  	u32 pcie_cap_off = CDNS_PCIE_RP_CAP_OFFSET;
> @@ -154,8 +220,14 @@ static void cdns_pcie_host_enable_ptm_response(struct cdns_pcie *pcie)
>  {
>  	u32 val;
>  
> -	val = cdns_pcie_readl(pcie, CDNS_PCIE_LM_PTM_CTRL);
> -	cdns_pcie_writel(pcie, CDNS_PCIE_LM_PTM_CTRL, val | CDNS_PCIE_LM_TPM_CTRL_PTMRSEN);
> +	if (!pcie->is_hpa) {
> +		val = cdns_pcie_readl(pcie, CDNS_PCIE_LM_PTM_CTRL);
> +		cdns_pcie_writel(pcie, CDNS_PCIE_LM_PTM_CTRL, val | CDNS_PCIE_LM_TPM_CTRL_PTMRSEN);
> +	} else {
> +		val = cdns_pcie_hpa_readl(pcie, REG_BANK_IP_REG, CDNS_PCIE_HPA_LM_PTM_CTRL);
> +		cdns_pcie_hpa_writel(pcie, REG_BANK_IP_REG, CDNS_PCIE_HPA_LM_PTM_CTRL,
> +				     val | CDNS_PCIE_HPA_LM_TPM_CTRL_PTMRSEN);
> +	}
>  }
>  
>  static int cdns_pcie_host_start_link(struct cdns_pcie_rc *rc)
> @@ -340,8 +412,8 @@ static int cdns_pcie_host_bar_config(struct cdns_pcie_rc *rc,
>  		 */
>  		bar = cdns_pcie_host_find_min_bar(rc, size);
>  		if (bar != RP_BAR_UNDEFINED) {
> -			ret = cdns_pcie_host_bar_ib_config(rc, bar, cpu_addr,
> -							   size, flags);
> +			ret = pcie->ops->host_bar_ib_config(rc, bar, cpu_addr,
> +							    size, flags);
>  			if (ret)
>  				dev_err(dev, "IB BAR: %d config failed\n", bar);
>  			return ret;
> @@ -366,8 +438,7 @@ static int cdns_pcie_host_bar_config(struct cdns_pcie_rc *rc,
>  		}
>  
>  		winsize = bar_max_size[bar];
> -		ret = cdns_pcie_host_bar_ib_config(rc, bar, cpu_addr, winsize,
> -						   flags);
> +		ret = pcie->ops->host_bar_ib_config(rc, bar, cpu_addr, winsize, flags);
>  		if (ret) {
>  			dev_err(dev, "IB BAR: %d config failed\n", bar);
>  			return ret;
> @@ -408,8 +479,8 @@ static int cdns_pcie_host_map_dma_ranges(struct cdns_pcie_rc *rc)
>  	if (list_empty(&bridge->dma_ranges)) {
>  		of_property_read_u32(np, "cdns,no-bar-match-nbits",
>  				     &no_bar_nbits);
> -		err = cdns_pcie_host_bar_ib_config(rc, RP_NO_BAR, 0x0,
> -						   (u64)1 << no_bar_nbits, 0);
> +		err = pcie->ops->host_bar_ib_config(rc, RP_NO_BAR, 0x0,
> +						    (u64)1 << no_bar_nbits, 0);
>  		if (err)
>  			dev_err(dev, "IB BAR: %d config failed\n", RP_NO_BAR);
>  		return err;
> @@ -467,17 +538,159 @@ int cdns_pcie_host_init_address_translation(struct cdns_pcie_rc *rc)
>  		u64 pci_addr = res->start - entry->offset;
>  
>  		if (resource_type(res) == IORESOURCE_IO)
> -			cdns_pcie_set_outbound_region(pcie, busnr, 0, r,
> -						      true,
> -						      pci_pio_to_address(res->start),
> -						      pci_addr,
> -						      resource_size(res));
> +			pcie->ops->set_outbound_region(pcie, busnr, 0, r,
> +						       true,
> +						       pci_pio_to_address(res->start),
> +						       pci_addr,
> +						       resource_size(res));
> +		else
> +			pcie->ops->set_outbound_region(pcie, busnr, 0, r,
> +						       false,
> +						       res->start,
> +						       pci_addr,
> +						       resource_size(res));
> +
> +		r++;
> +	}
> +
> +	return cdns_pcie_host_map_dma_ranges(rc);
> +}
> +
> +int cdns_pcie_hpa_host_init_root_port(struct cdns_pcie_rc *rc)
> +{
> +	struct cdns_pcie *pcie = &rc->pcie;
> +	u32 value, ctrl;
> +
> +	/*
> +	 * Set the root complex BAR configuration register:
> +	 * - disable both BAR0 and BAR1.
> +	 * - enable Prefetchable Memory Base and Limit registers in type 1
> +	 *   config space (64 bits).
> +	 * - enable IO Base and Limit registers in type 1 config
> +	 *   space (32 bits).
> +	 */
> +
> +	ctrl = CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_DISABLED;
> +	value = CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR0_CTRL(ctrl) |
> +		CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR1_CTRL(ctrl) |
> +		CDNS_PCIE_HPA_LM_RC_BAR_CFG_PREFETCH_MEM_ENABLE |
> +		CDNS_PCIE_HPA_LM_RC_BAR_CFG_PREFETCH_MEM_64BITS |
> +		CDNS_PCIE_HPA_LM_RC_BAR_CFG_IO_ENABLE |
> +		CDNS_PCIE_HPA_LM_RC_BAR_CFG_IO_32BITS;
> +	cdns_pcie_hpa_writel(pcie, REG_BANK_IP_CFG_CTRL_REG,
> +			     CDNS_PCIE_HPA_LM_RC_BAR_CFG, value);
> +
> +	if (rc->vendor_id != 0xffff)
> +		cdns_pcie_rp_writew(pcie, PCI_VENDOR_ID, rc->vendor_id);
> +
> +	if (rc->device_id != 0xffff)
> +		cdns_pcie_rp_writew(pcie, PCI_DEVICE_ID, rc->device_id);
> +
> +	cdns_pcie_rp_writeb(pcie, PCI_CLASS_REVISION, 0);
> +	cdns_pcie_rp_writeb(pcie, PCI_CLASS_PROG, 0);
> +	cdns_pcie_rp_writew(pcie, PCI_CLASS_DEVICE, PCI_CLASS_BRIDGE_PCI);
> +
> +	return 0;
> +}
> +
> +int cdns_pcie_hpa_host_bar_ib_config(struct cdns_pcie_rc *rc,
> +				     enum cdns_pcie_rp_bar bar,
> +				     u64 cpu_addr, u64 size,
> +				     unsigned long flags)
> +{
> +	struct cdns_pcie *pcie = &rc->pcie;
> +	u32 addr0, addr1, aperture, value;
> +
> +	if (!rc->avail_ib_bar[bar])
> +		return -EBUSY;
> +
> +	rc->avail_ib_bar[bar] = false;
> +
> +	aperture = ilog2(size);
> +	addr0 = CDNS_PCIE_HPA_AT_IB_RP_BAR_ADDR0_NBITS(aperture) |
> +		(lower_32_bits(cpu_addr) & GENMASK(31, 8));
> +	addr1 = upper_32_bits(cpu_addr);
> +	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_MASTER,
> +			     CDNS_PCIE_HPA_AT_IB_RP_BAR_ADDR0(bar), addr0);
> +	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_MASTER,
> +			     CDNS_PCIE_HPA_AT_IB_RP_BAR_ADDR1(bar), addr1);
> +
> +	if (bar == RP_NO_BAR)
> +		return 0;
> +
> +	value = cdns_pcie_hpa_readl(pcie, REG_BANK_IP_CFG_CTRL_REG, CDNS_PCIE_HPA_LM_RC_BAR_CFG);
> +	value &= ~(HPA_LM_RC_BAR_CFG_CTRL_MEM_64BITS(bar) |
> +		   HPA_LM_RC_BAR_CFG_CTRL_PREF_MEM_64BITS(bar) |
> +		   HPA_LM_RC_BAR_CFG_CTRL_MEM_32BITS(bar) |
> +		   HPA_LM_RC_BAR_CFG_CTRL_PREF_MEM_32BITS(bar) |
> +		   HPA_LM_RC_BAR_CFG_APERTURE(bar, bar_aperture_mask[bar] + 2));
> +	if (size + cpu_addr >= SZ_4G) {
> +		if (!(flags & IORESOURCE_PREFETCH))
> +			value |= HPA_LM_RC_BAR_CFG_CTRL_MEM_64BITS(bar);
> +		value |= HPA_LM_RC_BAR_CFG_CTRL_PREF_MEM_64BITS(bar);
> +	} else {
> +		if (!(flags & IORESOURCE_PREFETCH))
> +			value |= HPA_LM_RC_BAR_CFG_CTRL_MEM_32BITS(bar);
> +		value |= HPA_LM_RC_BAR_CFG_CTRL_PREF_MEM_32BITS(bar);
> +	}
> +
> +	value |= HPA_LM_RC_BAR_CFG_APERTURE(bar, aperture);
> +	cdns_pcie_hpa_writel(pcie, REG_BANK_IP_CFG_CTRL_REG, CDNS_PCIE_HPA_LM_RC_BAR_CFG, value);
> +
> +	return 0;
> +}
> +
> +int cdns_pcie_hpa_host_init_address_translation(struct cdns_pcie_rc *rc)
> +{
> +	struct cdns_pcie *pcie = &rc->pcie;
> +	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(rc);
> +	struct resource *cfg_res = rc->cfg_res;
> +	struct resource_entry *entry;
> +	u64 cpu_addr = cfg_res->start;
> +	u32 addr0, addr1, desc1;
> +	int r, busnr = 0;
> +
> +	entry = resource_list_first_type(&bridge->windows, IORESOURCE_BUS);
> +	if (entry)
> +		busnr = entry->res->start;
> +
> +	/*
> +	 * Reserve region 0 for PCI configure space accesses:
> +	 * OB_REGION_PCI_ADDR0 and OB_REGION_DESC0 are updated dynamically by
> +	 * cdns_pci_map_bus(), other region registers are set here once for all.
> +	 */
> +	addr1 = 0;
> +	desc1 = CDNS_PCIE_HPA_AT_OB_REGION_DESC1_BUS(busnr);
> +	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
> +			     CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR1(0), addr1);
> +	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
> +			     CDNS_PCIE_HPA_AT_OB_REGION_DESC1(0), desc1);
> +
> +	addr0 = CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0_NBITS(12) |
> +		(lower_32_bits(cpu_addr) & GENMASK(31, 8));
> +	addr1 = upper_32_bits(cpu_addr);
> +	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
> +			     CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0(0), addr0);
> +	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
> +			     CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR1(0), addr1);
> +
> +	r = 1;
> +	resource_list_for_each_entry(entry, &bridge->windows) {
> +		struct resource *res = entry->res;
> +		u64 pci_addr = res->start - entry->offset;
> +
> +		if (resource_type(res) == IORESOURCE_IO)
> +			pcie->ops->set_outbound_region(pcie, busnr, 0, r,
> +						       true,
> +						       pci_pio_to_address(res->start),
> +						       pci_addr,
> +						       resource_size(res));
>  		else
> -			cdns_pcie_set_outbound_region(pcie, busnr, 0, r,
> -						      false,
> -						      res->start,
> -						      pci_addr,
> -						      resource_size(res));
> +			pcie->ops->set_outbound_region(pcie, busnr, 0, r,
> +						       false,
> +						       res->start,
> +						       pci_addr,
> +						       resource_size(res));
>  
>  		r++;
>  	}
> @@ -489,11 +702,11 @@ int cdns_pcie_host_init(struct cdns_pcie_rc *rc)
>  {
>  	int err;
>  
> -	err = cdns_pcie_host_init_root_port(rc);
> +	err = rc->pcie.ops->host_init_root_port(rc);
>  	if (err)
>  		return err;
>  
> -	return cdns_pcie_host_init_address_translation(rc);
> +	return rc->pcie.ops->host_init_address_translation(rc);
>  }
>  
>  int cdns_pcie_host_link_setup(struct cdns_pcie_rc *rc)
> @@ -503,7 +716,7 @@ int cdns_pcie_host_link_setup(struct cdns_pcie_rc *rc)
>  	int ret;
>  
>  	if (rc->quirk_detect_quiet_flag)
> -		cdns_pcie_detect_quiet_min_delay_set(&rc->pcie);
> +		pcie->ops->detect_quiet_min_delay_set(&rc->pcie);
>  
>  	cdns_pcie_host_enable_ptm_response(pcie);
>  
> @@ -566,8 +779,12 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
>  	if (ret)
>  		return ret;
>  
> -	if (!bridge->ops)
> -		bridge->ops = &cdns_pcie_host_ops;
> +	if (!bridge->ops) {
> +		if (pcie->is_hpa)
> +			bridge->ops = &cdns_pcie_hpa_host_ops;
> +		else
> +			bridge->ops = &cdns_pcie_host_ops;
> +	}
>  
>  	ret = pci_host_probe(bridge);
>  	if (ret < 0)
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-plat.c b/drivers/pci/controller/cadence/pcie-cadence-plat.c
> index b24176d4df1f..8d5fbaef0a3c 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-plat.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-plat.c
> @@ -43,7 +43,30 @@ static u64 cdns_plat_cpu_addr_fixup(struct cdns_pcie *pcie, u64 cpu_addr)
>  }
>  
>  static const struct cdns_pcie_ops cdns_plat_ops = {
> +	.link_up = cdns_pcie_linkup,
>  	.cpu_addr_fixup = cdns_plat_cpu_addr_fixup,
> +	.host_init_root_port = cdns_pcie_host_init_root_port,
> +	.host_bar_ib_config = cdns_pcie_host_bar_ib_config,
> +	.host_init_address_translation = cdns_pcie_host_init_address_translation,
> +	.detect_quiet_min_delay_set = cdns_pcie_detect_quiet_min_delay_set,
> +	.set_outbound_region = cdns_pcie_set_outbound_region,
> +	.set_outbound_region_for_normal_msg =
> +					    cdns_pcie_set_outbound_region_for_normal_msg,
> +	.reset_outbound_region = cdns_pcie_reset_outbound_region,
> +};
> +
> +static const struct cdns_pcie_ops cdns_hpa_plat_ops = {
> +	.start_link = cdns_pcie_hpa_startlink,
> +	.stop_link = cdns_pcie_hpa_stop_link,
> +	.link_up = cdns_pcie_hpa_linkup,
> +	.host_init_root_port = cdns_pcie_hpa_host_init_root_port,
> +	.host_bar_ib_config = cdns_pcie_hpa_host_bar_ib_config,
> +	.host_init_address_translation = cdns_pcie_hpa_host_init_address_translation,
> +	.detect_quiet_min_delay_set = cdns_pcie_hpa_detect_quiet_min_delay_set,
> +	.set_outbound_region = cdns_pcie_hpa_set_outbound_region,
> +	.set_outbound_region_for_normal_msg =
> +					    cdns_pcie_hpa_set_outbound_region_for_normal_msg,
> +	.reset_outbound_region = cdns_pcie_hpa_reset_outbound_region,

What exactly is shared between these 2 implementations. Link handling, 
config space accesses, address translation, and host init are all 
different. What's left to share? MSIs (if not passed thru) and 
interrupts? I think it's questionable that this be the same driver. 

A bunch of driver specific 'ops' is not the right direction despite 
other drivers (DWC) having that. If there are common parts, then make 
them library functions multiple drivers can call.

Rob

