Return-Path: <linux-pci+bounces-20081-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD5F1A158D1
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jan 2025 22:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9E991691CE
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jan 2025 21:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E955A1A9B23;
	Fri, 17 Jan 2025 21:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hevc3Kru"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBEB187550;
	Fri, 17 Jan 2025 21:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737148166; cv=none; b=Mt/vdGcTFDjmB3e37Nl4OANkjujmRcY7XnNCmsR2VJb/SlAs0VA/hYx5r7339GjA6PC2oOPhXHFmEHJSmlgV3Xk2Ml0ic4InVyI6iuj/Q3w0h2S/Yrth2ArdKPCNX3gB/N9tjWq0UCz+So0N2g8sPs1iCwe9AMYzjKZ+2731cug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737148166; c=relaxed/simple;
	bh=4Is8QelbwFU8d+ZO0MSklxbN2XAMUsDBbZ4pDM87e6w=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=NXBNc3pyhxTEOWdXtUyfeHI0uQxEtpuSE7NzihyYKvISoqwDEzHI+gQWzA+ZmvIWEuRPWNNITZE8H+lcrG5J7bHWaH0j3ZpBhFBkVNN3ti0yBQ4zat23y2eSmhSoIaQZaDu7oSAkf3Q/meQseMLROimDbPLHoyUjAkxsyBaKdqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hevc3Kru; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737148165; x=1768684165;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=4Is8QelbwFU8d+ZO0MSklxbN2XAMUsDBbZ4pDM87e6w=;
  b=hevc3KruuTiA4G0y5VojefRWM0tUbR41SLEmQ810xstg0J3RSF0oU7Tw
   QZn/sLiHwgK1DsiyVYKt1Iw0EPbmoi+4XWBa2GnIwC1q5yRDTIXDfwf2y
   GLUYNLTaQWNge22faskbxTDItWY1r0KbUSF4BMbzYYKRGlZT/7frTw2Ht
   UzmRHFSa+ItXd9Rs62/qSIF24Uv4+VV94Wd5MsznvoZ+pswBcTtKxdL9k
   atObm/yKa/fvMa83ij0BlCcI21vrKMAvxjSRbJBfi1MdWct6IGB+H2JZj
   niFRXyWE64PV0injZOE55ZOXQG/btg0U/NJgK/rxTj2f0/vZQaf1pvVL0
   A==;
X-CSE-ConnectionGUID: c2aOfimnTam54Tujz9BXoQ==
X-CSE-MsgGUID: P0GMW1rkTWGHcvL/L8O+Hw==
X-IronPort-AV: E=McAfee;i="6700,10204,11318"; a="25190182"
X-IronPort-AV: E=Sophos;i="6.13,213,1732608000"; 
   d="scan'208";a="25190182"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2025 13:09:24 -0800
X-CSE-ConnectionGUID: BDeCYmMaQZGXJnjpCzP9ng==
X-CSE-MsgGUID: V+j/0/fKSHC0V/Pg8ws2ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="136797179"
Received: from sj-2308-osc3.sj.altera.com ([10.244.138.69])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2025 13:09:24 -0800
Date: Fri, 17 Jan 2025 13:09:23 -0800 (PST)
From: matthew.gerlach@linux.intel.com
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org, bhelgaas@google.com, 
    krzk+dt@kernel.org, conor+dt@kernel.org, dinguyen@kernel.org, 
    joyce.ooi@intel.com, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
    linux-kernel@vger.kernel.org, matthew.gerlach@altera.com, 
    "D M, Sharath Kumar" <sharath.kumar.d.m@intel.com>
Subject: Re: [PATCH v3 5/5] PCI: altera: Add Agilex support
In-Reply-To: <eaa5dd6b-e9bb-42a1-d249-b4ee1d97613@linux.intel.com>
Message-ID: <e3d0e811-cc52-ae92-38b0-4082b03c80c9@linux.intel.com>
References: <20250108165909.3344354-1-matthew.gerlach@linux.intel.com> <20250108165909.3344354-6-matthew.gerlach@linux.intel.com> <20250116170541.sszekk76qhvleay6@thinkpad> <eaa5dd6b-e9bb-42a1-d249-b4ee1d97613@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-54476699-1737148164=:1878230"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-54476699-1737148164=:1878230
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT



On Fri, 17 Jan 2025, matthew.gerlach@linux.intel.com wrote:

>
>
> On Thu, 16 Jan 2025, Manivannan Sadhasivam wrote:
>
>> On Wed, Jan 08, 2025 at 10:59:09AM -0600, Matthew Gerlach wrote:
>>> From: "D M, Sharath Kumar" <sharath.kumar.d.m@intel.com>
>>> 
>>> Add PCIe root port controller support Agilex family of chips.
>>> 
>> 
>> Please add more info about the PCIe controller in description. Like speed,
>> lanes, IP revision etc... Also, you are introducing ep_{read/write}_cfg()
>> callbacks, so they should also be described here.
>
> I will add more info about the Agilex PCIe controller and describe 
> ep_{read/write}_cfg() callbacks.
>
>> 
>>> Signed-off-by: D M, Sharath Kumar <sharath.kumar.d.m@intel.com>
>>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>> ---
>>> v3:
>>>  - Remove accepted patches from patch set.
>>> 
>>> v2:
>>>  - Match historical style of subject.
>>>  - Remove unrelated changes.
>>>  - Fix indentation.
>>> ---
>>>  drivers/pci/controller/pcie-altera.c | 246 ++++++++++++++++++++++++++-
>>>  1 file changed, 237 insertions(+), 9 deletions(-)
>>> 
>>> diff --git a/drivers/pci/controller/pcie-altera.c 
>>> b/drivers/pci/controller/pcie-altera.c
>>> index eb55a7f8573a..da4ae21d661d 100644
>>> --- a/drivers/pci/controller/pcie-altera.c
>>> +++ b/drivers/pci/controller/pcie-altera.c
>>> @@ -77,9 +77,19 @@
>>>  #define S10_TLP_FMTTYPE_CFGWR0		0x45
>>>  #define S10_TLP_FMTTYPE_CFGWR1		0x44
>>> 
>>> +#define AGLX_RP_CFG_ADDR(pcie, reg)	(((pcie)->hip_base) + (reg))
>>> +#define AGLX_RP_SECONDARY(pcie)		\
>>> +	readb(AGLX_RP_CFG_ADDR(pcie, PCI_SECONDARY_BUS))
>>> +
>>> +#define AGLX_BDF_REG			0x00002004
>>> +#define AGLX_ROOT_PORT_IRQ_STATUS	0x14c
>>> +#define AGLX_ROOT_PORT_IRQ_ENABLE	0x150
>>> +#define CFG_AER				BIT(4)
>>> +
>>>  enum altera_pcie_version {
>>>  	ALTERA_PCIE_V1 = 0,
>>>  	ALTERA_PCIE_V2,
>>> +	ALTERA_PCIE_V3,
>>>  };
>>>
>>>  struct altera_pcie {
>>> @@ -102,6 +112,11 @@ struct altera_pcie_ops {
>>>  			   int size, u32 *value);
>>>  	int (*rp_write_cfg)(struct altera_pcie *pcie, u8 busno,
>>>  			    int where, int size, u32 value);
>>> +	int (*ep_read_cfg)(struct altera_pcie *pcie, u8 busno,
>>> +			   unsigned int devfn, int where, int size, u32 
>>> *value);
>>> +	int (*ep_write_cfg)(struct altera_pcie *pcie, u8 busno,
>>> +			    unsigned int devfn, int where, int size, u32 
>>> value);
>>> +	void (*rp_isr)(struct irq_desc *desc);
>>>  };
>>>
>>>  struct altera_pcie_data {
>>> @@ -112,6 +127,9 @@ struct altera_pcie_data {
>>>  	u32 cfgrd1;
>>>  	u32 cfgwr0;
>>>  	u32 cfgwr1;
>>> +	u32 port_conf_offset;
>>> +	u32 port_irq_status_offset;
>>> +	u32 port_irq_enable_offset;
>>>  };
>>>
>>>  struct tlp_rp_regpair_t {
>>> @@ -131,6 +149,28 @@ static inline u32 cra_readl(struct altera_pcie *pcie, 
>>> const u32 reg)
>>>  	return readl_relaxed(pcie->cra_base + reg);
>>>  }
>>> 
>>> +static inline void cra_writew(struct altera_pcie *pcie, const u32 value,
>>> +			      const u32 reg)
>> 
>> No need to add inline keyword to .c files. Compiler will inline the 
>> function
>> anyway if needed.
>
> Using inline is consistent with existing cra_writel and cra_readl.
>
>> 
>>> +{
>>> +	writew_relaxed(value, pcie->cra_base + reg);
>>> +}
>>> +
>>> +static inline u32 cra_readw(struct altera_pcie *pcie, const u32 reg)
>>> +{
>>> +	return readw_relaxed(pcie->cra_base + reg);
>>> +}
>>> +
>>> +static inline void cra_writeb(struct altera_pcie *pcie, const u32 value,
>>> +			      const u32 reg)
>>> +{
>>> +	writeb_relaxed(value, pcie->cra_base + reg);
>>> +}
>>> +
>>> +static inline u32 cra_readb(struct altera_pcie *pcie, const u32 reg)
>>> +{
>>> +	return readb_relaxed(pcie->cra_base + reg);
>>> +}
>>> +
>>>  static bool altera_pcie_link_up(struct altera_pcie *pcie)
>>>  {
>>>  	return !!((cra_readl(pcie, RP_LTSSM) & RP_LTSSM_MASK) == LTSSM_L0);
>>> @@ -145,6 +185,15 @@ static bool s10_altera_pcie_link_up(struct 
>>> altera_pcie *pcie)
>>>  	return !!(readw(addr) & PCI_EXP_LNKSTA_DLLLA);
>>>  }
>>> 
>>> +static bool aglx_altera_pcie_link_up(struct altera_pcie *pcie)
>>> +{
>>> +	void __iomem *addr = AGLX_RP_CFG_ADDR(pcie,
>>> +				   pcie->pcie_data->cap_offset +
>>> +				   PCI_EXP_LNKSTA);
>>> +
>>> +	return !!(readw(addr) & PCI_EXP_LNKSTA_DLLLA);
>> 
>> Why this can't be readw_relaxed()?
>
> This can be changed to readw_relaxed().
>
>> 
>>> +}
>>> +
>>>  /*
>>>   * Altera PCIe port uses BAR0 of RC's configuration space as the 
>>> translation
>>>   * from PCI bus to native BUS.  Entire DDR region is mapped into PCIe 
>>> space
>>> @@ -425,6 +474,103 @@ static int s10_rp_write_cfg(struct altera_pcie 
>>> *pcie, u8 busno,
>>>  	return PCIBIOS_SUCCESSFUL;
>>>  }
>>> 
>>> +static int aglx_rp_read_cfg(struct altera_pcie *pcie, int where,
>>> +			    int size, u32 *value)
>>> +{
>>> +	void __iomem *addr = AGLX_RP_CFG_ADDR(pcie, where);
>>> +
>>> +	switch (size) {
>>> +	case 1:
>>> +		*value = readb(addr);
>> 
>> Same question as above. Why the relaxed variant is not used here?
>
> Yes, the relaxed variant can be used here too.
>
>> 
>>> +		break;
>>> +	case 2:
>>> +		*value = readw(addr);
>>> +		break;
>>> +	default:
>>> +		*value = readl(addr);
>>> +		break;
>>> +	}
>>> +
>>> +	/* interrupt pin not programmed in hardware, set to INTA */
>>> +	if (where == PCI_INTERRUPT_PIN && size == 1 && !(*value))
>>> +		*value = 0x01;
>>> +	else if (where == PCI_INTERRUPT_LINE && !(*value & 0xff00))
>>> +		*value |= 0x0100;
>>> +
>>> +	return PCIBIOS_SUCCESSFUL;
>>> +}
>>> +
>>> +static int aglx_rp_write_cfg(struct altera_pcie *pcie, u8 busno,
>>> +			     int where, int size, u32 value)
>>> +{
>>> +	void __iomem *addr = AGLX_RP_CFG_ADDR(pcie, where);
>>> +
>>> +	switch (size) {
>>> +	case 1:
>>> +		writeb(value, addr);
>>> +		break;
>>> +	case 2:
>>> +		writew(value, addr);
>>> +		break;
>>> +	default:
>>> +		writel(value, addr);
>>> +		break;
>>> +	}
>>> +
>>> +	/*
>>> +	 * Monitor changes to PCI_PRIMARY_BUS register on root port
>>> +	 * and update local copy of root bus number accordingly.
>>> +	 */
>>> +	if (busno == pcie->root_bus_nr && where == PCI_PRIMARY_BUS)
>>> +		pcie->root_bus_nr = value & 0xff;
>>> +
>>> +	return PCIBIOS_SUCCESSFUL;
>>> +}
>>> +
>>> +static int aglx_ep_write_cfg(struct altera_pcie *pcie, u8 busno,
>>> +			     unsigned int devfn, int where, int size, u32 
>>> value)
>>> +{
>>> +	cra_writel(pcie, ((busno << 8) | devfn), AGLX_BDF_REG);
>>> +	if (busno > AGLX_RP_SECONDARY(pcie))
>>> +		where |= (1 << 12); /* type 1 */
>> 
>> Can you use macro definition for this?
>
> Use a macro like BIT(12)?
>
>> 
>>> +
>>> +	switch (size) {
>>> +	case 1:
>>> +		cra_writeb(pcie, value, where);
>>> +		break;
>>> +	case 2:
>>> +		cra_writew(pcie, value, where);
>>> +		break;
>>> +	default:
>>> +		cra_writel(pcie, value, where);
>>> +			break;
>>> +	}
>>> +
>>> +	return PCIBIOS_SUCCESSFUL;
>>> +}
>>> +
>>> +static int aglx_ep_read_cfg(struct altera_pcie *pcie, u8 busno,
>>> +			    unsigned int devfn, int where, int size, u32 
>>> *value)
>>> +{
>>> +	cra_writel(pcie, ((busno << 8) | devfn), AGLX_BDF_REG);
>>> +	if (busno > AGLX_RP_SECONDARY(pcie))
>>> +		where |= (1 << 12); /* type 1 */
>> 
>> Same here.
>> 
>>> +
>>> +	switch (size) {
>>> +	case 1:
>>> +		*value = cra_readb(pcie, where);
>>> +		break;
>>> +	case 2:
>>> +		*value = cra_readw(pcie, where);
>>> +		break;
>>> +	default:
>>> +		*value = cra_readl(pcie, where);
>>> +		break;
>>> +	}
>>> +
>>> +	return PCIBIOS_SUCCESSFUL;
>>> +}
>>> +
>>>  static int _altera_pcie_cfg_read(struct altera_pcie *pcie, u8 busno,
>>>  				 unsigned int devfn, int where, int size,
>>>  				 u32 *value)
>>> @@ -437,6 +583,10 @@ static int _altera_pcie_cfg_read(struct altera_pcie 
>>> *pcie, u8 busno,
>>>  		return pcie->pcie_data->ops->rp_read_cfg(pcie, where,
>>>  							 size, value);
>>> 
>>> +	if (pcie->pcie_data->ops->ep_read_cfg)
>>> +		return pcie->pcie_data->ops->ep_read_cfg(pcie, busno, devfn,
>>> +							where, size, value);
>> 
>> Why do you need to call both rp_read_cfg() and ep_read_cfg()? This looks 
>> wrong.

I missed this comment in my first reply. The functions, rp_read_cfg() and 
ep_read_cfg(), are not both being called. The flow is if, else if, else.

If root port and rp_read_cfg exits
else if eq_read_cfg() exists
else perform original code path.

Matthew
>> 
>>> +
>>>  	switch (size) {
>>>  	case 1:
>>>  		byte_en = 1 << (where & 3);
>>> @@ -481,6 +631,10 @@ static int _altera_pcie_cfg_write(struct altera_pcie 
>>> *pcie, u8 busno,
>>>  		return pcie->pcie_data->ops->rp_write_cfg(pcie, busno,
>>>  						     where, size, value);
>>> 
>>> +	if (pcie->pcie_data->ops->ep_write_cfg)
>>> +		return pcie->pcie_data->ops->ep_write_cfg(pcie, busno, devfn,
>>> +						     where, size, value);
>>> +
>>>  	switch (size) {
>>>  	case 1:
>>>  		data32 = (value & 0xff) << shift;
>>> @@ -659,7 +813,30 @@ static void altera_pcie_isr(struct irq_desc *desc)
>>>  				dev_err_ratelimited(dev, "unexpected IRQ, 
>>> INT%d\n", bit);
>>>  		}
>>>  	}
>>> +	chained_irq_exit(chip, desc);
>>> +}
>>> +
>>> +static void aglx_isr(struct irq_desc *desc)
>>> +{
>>> +	struct irq_chip *chip = irq_desc_get_chip(desc);
>>> +	struct altera_pcie *pcie;
>>> +	struct device *dev;
>>> +	u32 status;
>>> +	int ret;
>>> +
>>> +	chained_irq_enter(chip, desc);
>>> +	pcie = irq_desc_get_handler_data(desc);
>>> +	dev = &pcie->pdev->dev;
>>> 
>>> +	status = readl(pcie->hip_base + pcie->pcie_data->port_conf_offset +
>>> +		       pcie->pcie_data->port_irq_status_offset);
>>> +	if (status & CFG_AER) {
>>> +		ret = generic_handle_domain_irq(pcie->irq_domain, 0);
>>> +		if (ret)
>>> +			dev_err_ratelimited(dev, "unexpected IRQ\n");
>> 
>> It'd be good to print the IRQ number in error log.
>
> Adding the IRQ number to the error log would be helpful.
>
>> 
>>> +	}
>>> +	writel(CFG_AER, (pcie->hip_base + pcie->pcie_data->port_conf_offset +
>>> +			 pcie->pcie_data->port_irq_status_offset));
>> 
>> You should clear the IRQ before handling it.
>
> Yes, the IRQ should be cleared before handling it.
>
>>
>>>  	chained_irq_exit(chip, desc);
>>>  }
>>> 
>> 
>> [...]
>> 
>>> -	/* clear all interrupts */
>>> -	cra_writel(pcie, P2A_INT_STS_ALL, P2A_INT_STATUS);
>>> -	/* enable all interrupts */
>>> -	cra_writel(pcie, P2A_INT_ENA_ALL, P2A_INT_ENABLE);
>>> -	altera_pcie_host_init(pcie);
>>> +	if (pcie->pcie_data->version == ALTERA_PCIE_V1 ||
>>> +	    pcie->pcie_data->version == ALTERA_PCIE_V2) {
>>> +		/* clear all interrupts */
>>> +		cra_writel(pcie, P2A_INT_STS_ALL, P2A_INT_STATUS);
>>> +		/* enable all interrupts */
>>> +		cra_writel(pcie, P2A_INT_ENA_ALL, P2A_INT_ENABLE);
>>> +		altera_pcie_host_init(pcie);
>>> +	} else if (pcie->pcie_data->version == ALTERA_PCIE_V3) {
>>> +		writel(CFG_AER,
>>> +		       pcie->hip_base + pcie->pcie_data->port_conf_offset +
>>> +		       pcie->pcie_data->port_irq_enable_offset);
>> 
>> Why altera_pcie_host_init() is not called for ALTERA_PCIE_V3?
>
> The V3 hardware does not need to perform a link retraining in order to 
> establish link at higher speeds.
>
>> 
>> - Mani
>
> Thank you for your feedback,
> Matthew Gerlach
>
>> 
>> -- 
>> மணிவண்ணன் சதாசிவம்
>
--8323329-54476699-1737148164=:1878230--

