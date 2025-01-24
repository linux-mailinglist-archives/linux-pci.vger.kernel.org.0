Return-Path: <linux-pci+bounces-20339-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F80A1B799
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jan 2025 15:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E46C7A04C9
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jan 2025 14:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E6082D98;
	Fri, 24 Jan 2025 14:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TySTprhq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D3A78C6C;
	Fri, 24 Jan 2025 14:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737727853; cv=none; b=XB5SS++DU5XR/dR3y1Tx+EgOBOe58YRw38U71GXbOr9jNndHaMneYePmY4myuYIXI/XIm+uo+vlblHWfhnJNfVdqkVEJN/o1uvmBGHKfukPqQ38HyNYqUOZcfjMGTCwgO8zOBTUb2q79N9BlTHrijcQdcBoAGS+xNXKUQpSUwoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737727853; c=relaxed/simple;
	bh=jKE9lKHrjkZzP78M/SgJD68HrzGInex5tVTvPpaxYAI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=e6FCDjI4HxlKFugUJUDI9gAypr74TUVVAcWKIpOzb1xndozN2qJBUzVZKf1TlmgptSokXLksJyxmVKI9RFZYT/hCp8V9VNzqklKfqrtiRIG6kVLAO6BN9ovW9vl0rMVYx+U7jM+Y6wGlqERhbSTthX9c0ECaDG9VAhFWn3dUhCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TySTprhq; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737727852; x=1769263852;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=jKE9lKHrjkZzP78M/SgJD68HrzGInex5tVTvPpaxYAI=;
  b=TySTprhqcgtJX2P6nT7OiSFFDGrT13iZYrZzLfNrO2X7a5+hs9fP6SbM
   nfwv5aSwdBJ23N0zkkbpeJkpyms2hrEUDTJBVbmy76UsRhm9uLqmO/RWe
   Mn6uUIw79KuuS2LYwkT6VTMpsoinX3btc5+uj0R+AZ6HPEVz1LeX1op7X
   hBBMknMz1Q9Ha0q3Tlq7fHJ+KMAY1kP7VUJHgd7BIy86FFSCandNAWonw
   8JwKPYhJh7gDszaMPnPwAccblfZIuBdYyWlXzJjtXQUVQOwTfyLnexv1+
   d4X2Bb5O3CM1LpIpgk18JlGBME880gJVqtItQpB/wLq3aecvv7EZRNF4p
   A==;
X-CSE-ConnectionGUID: 1sU8w4JVSIeESXrJqguYTA==
X-CSE-MsgGUID: tpHvUMFHS2ar8S/kfPpSWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11325"; a="42187475"
X-IronPort-AV: E=Sophos;i="6.13,231,1732608000"; 
   d="scan'208";a="42187475"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2025 06:10:51 -0800
X-CSE-ConnectionGUID: WBV4gBmiTcC10zjutJY66Q==
X-CSE-MsgGUID: 7+r6j3eSQzm1EOi+EI/uJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="107628895"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.158])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2025 06:10:44 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 24 Jan 2025 16:10:41 +0200 (EET)
To: Matthew Gerlach <matthew.gerlach@linux.intel.com>
cc: lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org, 
    robh@kernel.org, bhelgaas@google.com, krzk+dt@kernel.org, 
    conor+dt@kernel.org, dinguyen@kernel.org, joyce.ooi@intel.com, 
    linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, matthew.gerlach@altera.com, 
    peter.colberg@altera.com, 
    "D M, Sharath Kumar" <sharath.kumar.d.m@intel.com>, D@web.codeaurora.org, 
    M@web.codeaurora.org
Subject: Re: [PATCH v4 5/5] PCI: altera: Add Agilex support
In-Reply-To: <20250123181932.935870-6-matthew.gerlach@linux.intel.com>
Message-ID: <f2c9061a-6a9c-4cd1-8a3f-a286a2eb30a8@linux.intel.com>
References: <20250123181932.935870-1-matthew.gerlach@linux.intel.com> <20250123181932.935870-6-matthew.gerlach@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 23 Jan 2025, Matthew Gerlach wrote:

> From: "D M, Sharath Kumar" <sharath.kumar.d.m@intel.com>
> 
> Add PCIe root port controller support for the Agilex family of chips.
> The Agilex PCIe IP has three variants that are mostly sw compatible,
> except for a couple register offsets. The P-Tile variant supports
> Gen3/Gen4 1x16. The F-Tile variant supports Gen3/Gen4 4x4, 4x8, and 4x16.
> The R-Tile variant improves on the F-Tile variant by adding Gen5 support.
> 
> To simplify the implementation of pci_ops read/write functions,
> ep_{read/write}_cfg() callbacks were added to struct altera_pci_ops
> to easily distinguish between hardware variants.
> 
> Signed-off-by: D M, Sharath Kumar <sharath.kumar.d.m@intel.com>
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> ---
> v4:
>  - Add info to commit message.
>  - Use {read/write}?_relaxed where appropriate.
>  - Use BIT(12) instead of (1 << 12).
>  - Clear IRQ before handling it.
>  - add interrupt number to unexpected IRQ messge.
> 
> v3:
>  - Remove accepted patches from patch set.
> 
> v2:
>  - Match historical style of subject.
>  - Remove unrelated changes.
>  - Fix indentation.
> ---
>  drivers/pci/controller/pcie-altera.c | 246 ++++++++++++++++++++++++++-
>  1 file changed, 237 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-altera.c b/drivers/pci/controller/pcie-altera.c
> index eb55a7f8573a..59cad9a84900 100644
> --- a/drivers/pci/controller/pcie-altera.c
> +++ b/drivers/pci/controller/pcie-altera.c
> @@ -77,9 +77,19 @@
>  #define S10_TLP_FMTTYPE_CFGWR0		0x45
>  #define S10_TLP_FMTTYPE_CFGWR1		0x44
>  
> +#define AGLX_RP_CFG_ADDR(pcie, reg)	(((pcie)->hip_base) + (reg))
> +#define AGLX_RP_SECONDARY(pcie)		\
> +	readb(AGLX_RP_CFG_ADDR(pcie, PCI_SECONDARY_BUS))
> +
> +#define AGLX_BDF_REG			0x00002004
> +#define AGLX_ROOT_PORT_IRQ_STATUS	0x14c
> +#define AGLX_ROOT_PORT_IRQ_ENABLE	0x150
> +#define CFG_AER				BIT(4)
> +
>  enum altera_pcie_version {
>  	ALTERA_PCIE_V1 = 0,
>  	ALTERA_PCIE_V2,
> +	ALTERA_PCIE_V3,
>  };
>  
>  struct altera_pcie {
> @@ -102,6 +112,11 @@ struct altera_pcie_ops {
>  			   int size, u32 *value);
>  	int (*rp_write_cfg)(struct altera_pcie *pcie, u8 busno,
>  			    int where, int size, u32 value);
> +	int (*ep_read_cfg)(struct altera_pcie *pcie, u8 busno,
> +			   unsigned int devfn, int where, int size, u32 *value);
> +	int (*ep_write_cfg)(struct altera_pcie *pcie, u8 busno,
> +			    unsigned int devfn, int where, int size, u32 value);
> +	void (*rp_isr)(struct irq_desc *desc);
>  };
>  
>  struct altera_pcie_data {
> @@ -112,6 +127,9 @@ struct altera_pcie_data {
>  	u32 cfgrd1;
>  	u32 cfgwr0;
>  	u32 cfgwr1;
> +	u32 port_conf_offset;
> +	u32 port_irq_status_offset;
> +	u32 port_irq_enable_offset;
>  };
>  
>  struct tlp_rp_regpair_t {
> @@ -131,6 +149,28 @@ static inline u32 cra_readl(struct altera_pcie *pcie, const u32 reg)
>  	return readl_relaxed(pcie->cra_base + reg);
>  }
>  
> +static inline void cra_writew(struct altera_pcie *pcie, const u32 value,
> +			      const u32 reg)
> +{
> +	writew_relaxed(value, pcie->cra_base + reg);
> +}
> +
> +static inline u32 cra_readw(struct altera_pcie *pcie, const u32 reg)
> +{
> +	return readw_relaxed(pcie->cra_base + reg);
> +}
> +
> +static inline void cra_writeb(struct altera_pcie *pcie, const u32 value,
> +			      const u32 reg)
> +{
> +	writeb_relaxed(value, pcie->cra_base + reg);
> +}
> +
> +static inline u32 cra_readb(struct altera_pcie *pcie, const u32 reg)
> +{
> +	return readb_relaxed(pcie->cra_base + reg);
> +}
> +
>  static bool altera_pcie_link_up(struct altera_pcie *pcie)
>  {
>  	return !!((cra_readl(pcie, RP_LTSSM) & RP_LTSSM_MASK) == LTSSM_L0);
> @@ -145,6 +185,15 @@ static bool s10_altera_pcie_link_up(struct altera_pcie *pcie)
>  	return !!(readw(addr) & PCI_EXP_LNKSTA_DLLLA);
>  }
>  
> +static bool aglx_altera_pcie_link_up(struct altera_pcie *pcie)
> +{
> +	void __iomem *addr = AGLX_RP_CFG_ADDR(pcie,
> +				   pcie->pcie_data->cap_offset +
> +				   PCI_EXP_LNKSTA);
> +
> +	return !!(readw_relaxed(addr) & PCI_EXP_LNKSTA_DLLLA);

This returns bool so double negations are not necessary.

> +}
> +
>  /*
>   * Altera PCIe port uses BAR0 of RC's configuration space as the translation
>   * from PCI bus to native BUS.  Entire DDR region is mapped into PCIe space
> @@ -425,6 +474,103 @@ static int s10_rp_write_cfg(struct altera_pcie *pcie, u8 busno,
>  	return PCIBIOS_SUCCESSFUL;
>  }
>  
> +static int aglx_rp_read_cfg(struct altera_pcie *pcie, int where,
> +			    int size, u32 *value)
> +{
> +	void __iomem *addr = AGLX_RP_CFG_ADDR(pcie, where);
> +
> +	switch (size) {
> +	case 1:
> +		*value = readb_relaxed(addr);
> +		break;
> +	case 2:
> +		*value = readw_relaxed(addr);
> +		break;
> +	default:
> +		*value = readl_relaxed(addr);
> +		break;
> +	}
> +
> +	/* interrupt pin not programmed in hardware, set to INTA */
> +	if (where == PCI_INTERRUPT_PIN && size == 1 && !(*value))
> +		*value = 0x01;
> +	else if (where == PCI_INTERRUPT_LINE && !(*value & 0xff00))
> +		*value |= 0x0100;
> +
> +	return PCIBIOS_SUCCESSFUL;
> +}
> +
> +static int aglx_rp_write_cfg(struct altera_pcie *pcie, u8 busno,
> +			     int where, int size, u32 value)
> +{
> +	void __iomem *addr = AGLX_RP_CFG_ADDR(pcie, where);
> +
> +	switch (size) {
> +	case 1:
> +		writeb_relaxed(value, addr);
> +		break;
> +	case 2:
> +		writew_relaxed(value, addr);
> +		break;
> +	default:
> +		writel_relaxed(value, addr);
> +		break;
> +	}
> +
> +	/*
> +	 * Monitor changes to PCI_PRIMARY_BUS register on root port
> +	 * and update local copy of root bus number accordingly.
> +	 */
> +	if (busno == pcie->root_bus_nr && where == PCI_PRIMARY_BUS)
> +		pcie->root_bus_nr = value & 0xff;
> +
> +	return PCIBIOS_SUCCESSFUL;
> +}
> +
> +static int aglx_ep_write_cfg(struct altera_pcie *pcie, u8 busno,
> +			     unsigned int devfn, int where, int size, u32 value)
> +{
> +	cra_writel(pcie, ((busno << 8) | devfn), AGLX_BDF_REG);
> +	if (busno > AGLX_RP_SECONDARY(pcie))
> +		where |= BIT(12); /* type 1 */

Add a define to replace the comment?

> +
> +	switch (size) {
> +	case 1:
> +		cra_writeb(pcie, value, where);
> +		break;
> +	case 2:
> +		cra_writew(pcie, value, where);
> +		break;
> +	default:
> +		cra_writel(pcie, value, where);
> +			break;
> +	}
> +
> +	return PCIBIOS_SUCCESSFUL;
> +}
> +
> +static int aglx_ep_read_cfg(struct altera_pcie *pcie, u8 busno,
> +			    unsigned int devfn, int where, int size, u32 *value)
> +{
> +	cra_writel(pcie, ((busno << 8) | devfn), AGLX_BDF_REG);
> +	if (busno > AGLX_RP_SECONDARY(pcie))
> +		where |= BIT(12); /* type 1 */

Same here?

-- 
 i.


