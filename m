Return-Path: <linux-pci+bounces-19991-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B5BA1403F
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 18:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9A133AC2A7
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 17:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3169E22FDE5;
	Thu, 16 Jan 2025 17:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a5jXkGQT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B96C22FE00
	for <linux-pci@vger.kernel.org>; Thu, 16 Jan 2025 17:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737047153; cv=none; b=JOYzSQCAsJB6rz5xF3WYqe7voTW/Jh55NmFdSL3/p+PcWF0DFJ4C6T1QHz8gQjdxQ1KDYSDAsXGnOXODaQvjvEIWQjI3+4f+34dXaAiov1NBYSlANsrLC0kcJbjVrqrvpBPiXjgmYe/guV49RAriJeBo1a6GYWSYVuk10pS8WYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737047153; c=relaxed/simple;
	bh=JH3O8Xdc+dQLqOYwnXd6LfF/C+wHmOknj2Uov1tGWx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fn5gX+erF1C3NyqtYBY6Mgg7ybKb84k9ep+cv8I1b4CzcHTkPLwdczhA36yuEOaJMAGAJb0QiMxYk1hRFLGahttNnnsdK0Uidr/sMZt14wq5g/SLLv9OH1yxlAidTcX1AfmgVXfd37kN+M2gRfS4d+9BW7Nc11twZvXkEg0UlUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a5jXkGQT; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-215770613dbso15793295ad.2
        for <linux-pci@vger.kernel.org>; Thu, 16 Jan 2025 09:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737047149; x=1737651949; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bPcrn4OK1UrYaj/EJ+zDJFA/QhX3mIpIkcW9eMBa6jE=;
        b=a5jXkGQTMbu0sGqPUIOInq2h0Z/k6DpYhTBUmvfRzGQQ5/PQHW94NLss+KZCvldmVx
         AWxwORUpJc4+c7HV+jPndS3v4epfPS9e6jDs0nD9DNez7gZytIPl9zo6rTBFoF3oQ/In
         UOgGzl4v+OdcoKeG9QFAOVNwJeLFRqjp/31+7LFOocaBNcVHjOHPvdfcetba9fWj0joP
         lr0svYQkt9OmVIod3zfvYUhFVYw5KegPUI2x9yS8RYA5mPiD7At++GkCcEE9Ax6EG3FW
         ZKDXaCTaocyIlWpa8vnf88v4XX3Tqio8zTpJTr7RbxK3PtGJi8Iaar7uBbu/k1IO72ZS
         ahcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737047149; x=1737651949;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bPcrn4OK1UrYaj/EJ+zDJFA/QhX3mIpIkcW9eMBa6jE=;
        b=JvWPFFVBspi/84nKSd5SEUeLwl8/E7uWO+YCdz3KvfcmmKICEt+S5+Ocp/G//hd8UR
         v/sgftwscHK9v4t+mzfNQ9AyNo41daAFFIYQvpkIC//FM2esca5lE6XoDzCskn91jfIZ
         t8WNm3Jicj0EnWq8zZ0e1itbZF4Gb7Yw4VFiOEIAM8OJjBwhxSHE5nTFqIpgwhko/3W7
         glu3SNr685mqO2S3NPWZkNNTxOcBPCKfK99h2kypYNSxOp23hW5l4neoA6tZlFPvGZfc
         P+lYxNuH66MIq0gKlhN+9Zhq2yluGwPk4Dzu1nrEjocSjVVMGIa0Yt4n4Pe9AOy0rl7p
         6+TQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtFlTd8cmZpDJratTCGsH2QaLgon+EdhQPxfncuDgHUMRDlRJQSfZ53gHLKm38NkG5G16wrYR9grc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzaTlkYD8Z3MJwroCylNkGnCA4OHCET3fceOHfpFR3hs7zo7m4
	oRf5c5MIxBCnlHgQybNKu7L2CrYUI6QJAZSoiPThQdETOZcsh+VSR52oPMkxVf/SqJHKiXO5Usg
	=
X-Gm-Gg: ASbGncthtEKj7S/QhzrHv3SWXke/iHdJUDfwjOsgNMrIfTSIS85GxpDQtxvyxO7j8KT
	Ty3pwXtlYb3i5cvMwnAdH3ljWSL7/wEVBJ4VZ6TIB+py3blBJEB1jCTWqL42noSM8aconJ0apHX
	SWxkoMMvOu1C4HQgCpyeFrakpRv6PfsQfsBPLsoia0FnVLoXRvWtEYZDXZ6ZJIOKmwcZHFeQNpy
	7X5MNNCbBMMaBQ/3cfwkB3Pl8rmK9QcTx+QtDbUhouUrCSf7o15sfBu7yk5mwFR2Rs=
X-Google-Smtp-Source: AGHT+IF6Gw2XTa/ILzk2cUIRlgEvDBvhcFoNmutT6zLowan/G4rMP3530CIeCH/F9gvFOyDqG+zkqQ==
X-Received: by 2002:a05:6a21:338b:b0:1ea:f941:8d9b with SMTP id adf61e73a8af0-1eaf9418fe9mr19230274637.38.1737047149465;
        Thu, 16 Jan 2025 09:05:49 -0800 (PST)
Received: from thinkpad ([120.60.79.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dabacdc6csm225944b3a.165.2025.01.16.09.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 09:05:48 -0800 (PST)
Date: Thu, 16 Jan 2025 22:35:41 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	dinguyen@kernel.org, joyce.ooi@intel.com, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	matthew.gerlach@altera.com,
	"D M, Sharath Kumar" <sharath.kumar.d.m@intel.com>,
	D@thinkpad.smtp.subspace.kernel.org,
	M@thinkpad.smtp.subspace.kernel.org
Subject: Re: [PATCH v3 5/5] PCI: altera: Add Agilex support
Message-ID: <20250116170541.sszekk76qhvleay6@thinkpad>
References: <20250108165909.3344354-1-matthew.gerlach@linux.intel.com>
 <20250108165909.3344354-6-matthew.gerlach@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250108165909.3344354-6-matthew.gerlach@linux.intel.com>

On Wed, Jan 08, 2025 at 10:59:09AM -0600, Matthew Gerlach wrote:
> From: "D M, Sharath Kumar" <sharath.kumar.d.m@intel.com>
> 
> Add PCIe root port controller support Agilex family of chips.
> 

Please add more info about the PCIe controller in description. Like speed,
lanes, IP revision etc... Also, you are introducing ep_{read/write}_cfg()
callbacks, so they should also be described here.

> Signed-off-by: D M, Sharath Kumar <sharath.kumar.d.m@intel.com>
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> ---
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
> index eb55a7f8573a..da4ae21d661d 100644
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

No need to add inline keyword to .c files. Compiler will inline the function
anyway if needed.

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
> +	return !!(readw(addr) & PCI_EXP_LNKSTA_DLLLA);

Why this can't be readw_relaxed()?

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
> +		*value = readb(addr);

Same question as above. Why the relaxed variant is not used here?

> +		break;
> +	case 2:
> +		*value = readw(addr);
> +		break;
> +	default:
> +		*value = readl(addr);
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
> +		writeb(value, addr);
> +		break;
> +	case 2:
> +		writew(value, addr);
> +		break;
> +	default:
> +		writel(value, addr);
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
> +		where |= (1 << 12); /* type 1 */

Can you use macro definition for this?

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
> +		where |= (1 << 12); /* type 1 */

Same here.

> +
> +	switch (size) {
> +	case 1:
> +		*value = cra_readb(pcie, where);
> +		break;
> +	case 2:
> +		*value = cra_readw(pcie, where);
> +		break;
> +	default:
> +		*value = cra_readl(pcie, where);
> +		break;
> +	}
> +
> +	return PCIBIOS_SUCCESSFUL;
> +}
> +
>  static int _altera_pcie_cfg_read(struct altera_pcie *pcie, u8 busno,
>  				 unsigned int devfn, int where, int size,
>  				 u32 *value)
> @@ -437,6 +583,10 @@ static int _altera_pcie_cfg_read(struct altera_pcie *pcie, u8 busno,
>  		return pcie->pcie_data->ops->rp_read_cfg(pcie, where,
>  							 size, value);
>  
> +	if (pcie->pcie_data->ops->ep_read_cfg)
> +		return pcie->pcie_data->ops->ep_read_cfg(pcie, busno, devfn,
> +							where, size, value);

Why do you need to call both rp_read_cfg() and ep_read_cfg()? This looks wrong.

> +
>  	switch (size) {
>  	case 1:
>  		byte_en = 1 << (where & 3);
> @@ -481,6 +631,10 @@ static int _altera_pcie_cfg_write(struct altera_pcie *pcie, u8 busno,
>  		return pcie->pcie_data->ops->rp_write_cfg(pcie, busno,
>  						     where, size, value);
>  
> +	if (pcie->pcie_data->ops->ep_write_cfg)
> +		return pcie->pcie_data->ops->ep_write_cfg(pcie, busno, devfn,
> +						     where, size, value);
> +
>  	switch (size) {
>  	case 1:
>  		data32 = (value & 0xff) << shift;
> @@ -659,7 +813,30 @@ static void altera_pcie_isr(struct irq_desc *desc)
>  				dev_err_ratelimited(dev, "unexpected IRQ, INT%d\n", bit);
>  		}
>  	}
> +	chained_irq_exit(chip, desc);
> +}
> +
> +static void aglx_isr(struct irq_desc *desc)
> +{
> +	struct irq_chip *chip = irq_desc_get_chip(desc);
> +	struct altera_pcie *pcie;
> +	struct device *dev;
> +	u32 status;
> +	int ret;
> +
> +	chained_irq_enter(chip, desc);
> +	pcie = irq_desc_get_handler_data(desc);
> +	dev = &pcie->pdev->dev;
>  
> +	status = readl(pcie->hip_base + pcie->pcie_data->port_conf_offset +
> +		       pcie->pcie_data->port_irq_status_offset);
> +	if (status & CFG_AER) {
> +		ret = generic_handle_domain_irq(pcie->irq_domain, 0);
> +		if (ret)
> +			dev_err_ratelimited(dev, "unexpected IRQ\n");

It'd be good to print the IRQ number in error log.

> +	}
> +	writel(CFG_AER, (pcie->hip_base + pcie->pcie_data->port_conf_offset +
> +			 pcie->pcie_data->port_irq_status_offset));

You should clear the IRQ before handling it.

>  	chained_irq_exit(chip, desc);
>  }
>  

[...]

> -	/* clear all interrupts */
> -	cra_writel(pcie, P2A_INT_STS_ALL, P2A_INT_STATUS);
> -	/* enable all interrupts */
> -	cra_writel(pcie, P2A_INT_ENA_ALL, P2A_INT_ENABLE);
> -	altera_pcie_host_init(pcie);
> +	if (pcie->pcie_data->version == ALTERA_PCIE_V1 ||
> +	    pcie->pcie_data->version == ALTERA_PCIE_V2) {
> +		/* clear all interrupts */
> +		cra_writel(pcie, P2A_INT_STS_ALL, P2A_INT_STATUS);
> +		/* enable all interrupts */
> +		cra_writel(pcie, P2A_INT_ENA_ALL, P2A_INT_ENABLE);
> +		altera_pcie_host_init(pcie);
> +	} else if (pcie->pcie_data->version == ALTERA_PCIE_V3) {
> +		writel(CFG_AER,
> +		       pcie->hip_base + pcie->pcie_data->port_conf_offset +
> +		       pcie->pcie_data->port_irq_enable_offset);

Why altera_pcie_host_init() is not called for ALTERA_PCIE_V3?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

