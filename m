Return-Path: <linux-pci+bounces-25602-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A02A8342A
	for <lists+linux-pci@lfdr.de>; Thu, 10 Apr 2025 00:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38D374462F7
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 22:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB86121B9F2;
	Wed,  9 Apr 2025 22:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nbnw4RMl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02EE21B9F0;
	Wed,  9 Apr 2025 22:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744238709; cv=none; b=dYjVR9VwF2L39kjDFiF5bk5OZHYtz9ozBbs3+OTKuK4WeRjlREEV7MYwOrd1CvSPPEO+0/c93yYDjI1aOH/rn6yJhUYJhr3aoWAMoSgOPeqQr1YM8PM980KJ5Ta0gvXXDc2b8NJqsL4p7KLpFv57LOMyBrKfY+IV4vjsbJJMb78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744238709; c=relaxed/simple;
	bh=zCUD012UtR9OFmMAHU6saDApQ76XDpflVQ4NOMuRe+s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=IyevzWmmOcEIT3LQlD7cSLit6u7tlEfK72+3x3OoMaJsDq6cWjRtXX28gG0srvl5XRyD1cEiDP0nRL35BNidaM7CicHu0JP2fFU2UJFKpabzdKrD5pDMUVG3szaSmd0ZmiG/FM8zQUQUPmkbf8RVyHWqhP0nUBOw+594NJLsUk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nbnw4RMl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2D32C4CEE2;
	Wed,  9 Apr 2025 22:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744238709;
	bh=zCUD012UtR9OFmMAHU6saDApQ76XDpflVQ4NOMuRe+s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=nbnw4RMlZTmDbfLlO6SAAXkrvPnckubKEud1dlVN/U1ssO2mqr5IxLJd7xd3Qjw6O
	 A2WCCcaK++oAER2dqCFdMN1Qo53XMU72XTj6HWBcenFW3Uxl7wL5nT/D5ykig3RWUL
	 +QF7DjQF3nEwvv3ezPuPjYB9AeaDTWdo4IcsO2jRDB3ydDPGXG6DI4AJXVF55vvGjx
	 FBLv6Olq66zUdQZESDqMcfxRmq38cooVGiFcCJVip9/y6YjvkBJd59VHRq0w2EIuUB
	 bII42ACCHN+0VQVTqzlwfO6WGPl2v71YanQFsGDwbYunv8Dr5Wn3zVv3GHImZB/NxB
	 SFRqym3Z1zW/g==
Date: Wed, 9 Apr 2025 17:45:07 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manikandan Karunakaran Pillai <mpillai@cadence.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>,
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH 6/7] PCI: cadence: Add callback functions for Root Port
 and EP controller
Message-ID: <20250409224507.GA300150@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH2PPF4D26F8E1CD797FF6A6A2698036717A2A12@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>

[+cc Frank for .cpu_addr_fixup()]

On Thu, Mar 27, 2025 at 11:42:27AM +0000, Manikandan Karunakaran Pillai wrote:
> Add support for the second generation PCIe controller by adding
> the required callback functions. Update the common functions for
> endpoint and Root port modes. Invoke the relevant callback functions
> for platform probe of PCIe controller using the callback functions

Pick "second generation" or "HPA" and use it consistently so we can
keep this all straight.

s/endpoint/Endpoint/
s/Root port/Root Port/

Add period again.

> @@ -877,7 +877,7 @@ int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
>  	set_bit(0, &ep->ob_region_map);
>  
>  	if (ep->quirk_detect_quiet_flag)
> -		cdns_pcie_detect_quiet_min_delay_set(&ep->pcie);
> +		pcie->ops->pcie_detect_quiet_min_delay_set(&ep->pcie);

Maybe the quirk check should go inside .pcie_detect_quiet_min_delay()?
Just an idea, maybe that wouldn't help.

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
> +	regval = cdns_pcie_hpa_readl(pcie, REG_BANK_AXI_SLAVE, CDNS_PCIE_HPA_AT_LINKDOWN);
> +	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE, CDNS_PCIE_HPA_AT_LINKDOWN,
> +			     (regval & GENMASK(0, 0)));
> +
> +	desc1 = 0;
> +	ctrl0 = 0;
> +	/*

Blank line before comment.  You could make this a single-line comment,
e.g.,

  /* Update Output registers for AXI region 0. */

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
> +	/*

Again.

> +	 * The bus number was already set once for all in desc1 by
> +	 * cdns_pcie_host_init_address_translation().

This comment sounds like you only support the root bus and a single
other bus.  But you're not actually setting the *bus number* here;
you're setting up either a Type 0 access (for the Root Port's
secondary bus) or a Type 1 access (for anything else, e.g. things
below a switch).

> +	 */
> +	if (busn == bridge->busnr + 1)

The Root Port's secondary bus number need not be the Root Port's bus
number + 1.  It *might* be, and since you said the current design only
has a single Root Port, it probably *will* be, but that secondary bus
number is writable and can be changed either by the PCI core or by the
user via setpci.  So you shouldn't assume this.  If/when a design
supports more than one Root Port, that assumption will certainly be
broken.

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
> +
> +	return rc->cfg_base + (where & 0xfff);
> +}

> +++ b/drivers/pci/controller/cadence/pcie-cadence.c
> @@ -5,9 +5,49 @@
>  
>  #include <linux/kernel.h>
>  #include <linux/of.h>
> -

Spurious change, keep this blank line.

>  #include "pcie-cadence.h"
>  
> +bool cdns_pcie_linkup(struct cdns_pcie *pcie)

Static unless needed elsewhere.  I can't tell whether it is because I
can't download or apply the whole series.

> +{
> +	u32 pl_reg_val;
> +
> +	pl_reg_val = cdns_pcie_readl(pcie, CDNS_PCIE_LM_BASE);
> +	if (pl_reg_val & GENMASK(0, 0))
> +		return true;
> +	else
> +		return false;

Drop the else:

  if (pl_reg_val & GENMASK(0, 0))
    return true;

  return false;

> +}
> +
> +bool cdns_pcie_hpa_linkup(struct cdns_pcie *pcie)
> +{
> +	u32 pl_reg_val;
> +
> +	pl_reg_val = cdns_pcie_hpa_readl(pcie, REG_BANK_IP_REG, CDNS_PCIE_HPA_PHY_DBG_STS_REG0);
> +	if (pl_reg_val & GENMASK(0, 0))
> +		return true;
> +	else
> +		return false;

Ditto.

> +}
> +
> +int cdns_pcie_hpa_startlink(struct cdns_pcie *pcie)

s/cdns_pcie_hpa_startlink/cdns_pcie_hpa_start_link/

> +{
> +	u32 pl_reg_val;
> +
> +	pl_reg_val = cdns_pcie_hpa_readl(pcie, REG_BANK_IP_REG, CDNS_PCIE_HPA_PHY_LAYER_CFG0);
> +	pl_reg_val |= CDNS_PCIE_HPA_LINK_TRNG_EN_MASK;
> +	cdns_pcie_hpa_writel(pcie, REG_BANK_IP_REG, CDNS_PCIE_HPA_PHY_LAYER_CFG0, pl_reg_val);
> +	return 1;

This should return 0 for success.

> +}

> +void cdns_pcie_hpa_set_outbound_region(struct cdns_pcie *pcie, u8 busnr, u8 fn,
> +				       u32 r, bool is_io,
> +				       u64 cpu_addr, u64 pci_addr, size_t size)
> +{
> +	/*
> +	 * roundup_pow_of_two() returns an unsigned long, which is not suited
> +	 * for 64bit values.
> +	 */
> +	u64 sz = 1ULL << fls64(size - 1);
> +	int nbits = ilog2(sz);
> +	u32 addr0, addr1, desc0, desc1, ctrl0;
> +
> +	if (nbits < 8)
> +		nbits = 8;
> +
> +	/*
> +	 * Set the PCI address
> +	 */

Could be a single line comment:

  /* Set the PCI address */

like many others in this series.

> +	addr0 = CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_NBITS(nbits) |
> +		(lower_32_bits(pci_addr) & GENMASK(31, 8));
> +	addr1 = upper_32_bits(pci_addr);
> +
> +	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
> +			     CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0(r), addr0);
> +	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
> +			     CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR1(r), addr1);
> +
> +	/*
> +	 * Set the PCIe header descriptor
> +	 */
> +	if (is_io)
> +		desc0 = CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_IO;
> +	else
> +		desc0 = CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_MEM;
> +	desc1 = 0;
> +
> +	/*
> +	 * Whatever Bit [26] is set or not inside DESC0 register of the outbound
> +	 * PCIe descriptor, the PCI function number must be set into
> +	 * Bits [31:24] of DESC1 anyway.

s/Whatever/Whether/ (I think)

> +	 * In Root Complex mode, the function number is always 0 but in Endpoint
> +	 * mode, the PCIe controller may support more than one function. This
> +	 * function number needs to be set properly into the outbound PCIe
> +	 * descriptor.
> +	 *
> +	 * Besides, setting Bit [26] is mandatory when in Root Complex mode:
> +	 * then the driver must provide the bus, resp. device, number in
> +	 * Bits [31:24] of DESC1, resp. Bits[23:16] of DESC0. Like the function
> +	 * number, the device number is always 0 in Root Complex mode.
> +	 *
> +	 * However when in Endpoint mode, we can clear Bit [26] of DESC0, hence
> +	 * the PCIe controller will use the captured values for the bus and
> +	 * device numbers.
> +	 */
> +	if (pcie->is_rc) {
> +		/* The device and function numbers are always 0. */
> +		desc1 = CDNS_PCIE_HPA_AT_OB_REGION_DESC1_BUS(busnr) |
> +			CDNS_PCIE_HPA_AT_OB_REGION_DESC1_DEVFN(0);
> +		ctrl0 = CDNS_PCIE_HPA_AT_OB_REGION_CTRL0_SUPPLY_BUS |
> +			CDNS_PCIE_HPA_AT_OB_REGION_CTRL0_SUPPLY_DEV_FN;
> +	} else {
> +		/*
> +		 * Use captured values for bus and device numbers but still
> +		 * need to set the function number.
> +		 */
> +		desc1 |= CDNS_PCIE_HPA_AT_OB_REGION_DESC1_DEVFN(fn);
> +	}
> +
> +	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
> +			     CDNS_PCIE_HPA_AT_OB_REGION_DESC0(r), desc0);
> +	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
> +			     CDNS_PCIE_HPA_AT_OB_REGION_DESC1(r), desc1);
> +
> +	/*
> +	 * Set the CPU address
> +	 */
> +	if (pcie->ops->cpu_addr_fixup)
> +		cpu_addr = pcie->ops->cpu_addr_fixup(pcie, cpu_addr);

Oops, we can't add any more .cpu_addr_fixup() functions or uses.  This
must be done via the devicetree description.  If we add a new
.cpu_addr_fixup(), it may cover up defects in the devicetree.

You can see Frank Li's nice work to fix this for some of the dwc
drivers on the branch ending at 07ae413e169d ("PCI: intel-gw: Remove
intel_pcie_cpu_addr()"):

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/?h=07ae413e169d

This one is the biggest issue so far.

Bjorn

