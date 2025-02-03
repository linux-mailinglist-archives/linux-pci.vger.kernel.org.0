Return-Path: <linux-pci+bounces-20671-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F49A26192
	for <lists+linux-pci@lfdr.de>; Mon,  3 Feb 2025 18:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F7F87A26D8
	for <lists+linux-pci@lfdr.de>; Mon,  3 Feb 2025 17:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445B420C497;
	Mon,  3 Feb 2025 17:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UeGplCNi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A7520B808
	for <linux-pci@vger.kernel.org>; Mon,  3 Feb 2025 17:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738604468; cv=none; b=qD+1jWol/1SF+QGulZ+P71t7uGhq0oVtLhiZBdDXKxCFtMyy1MqlmvTRdY9xLlOup1pu0pM5jAoW3zgyCKmHBTgO2U49N19mHKHXOcsL/Z9R5DEeoFtrlm2WxVC59q2gLJtr7KUA56ARB0MoY6RAk/w2j3nz6iP3gT/X0at+7u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738604468; c=relaxed/simple;
	bh=qx6SzSl1pzndZQJN1qARrzkmtmUMKuAOM17ZDLIwPLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C4fpLXjRVgqN+8wATC9nhFjmg/mfmnc2juBtABxlfsSKG5I9tAQTszSbPE6RyRsNmWOqwb+yBrxqey0JdeTVCIOZz/eHojRrNpkx3dXgU1yX55YUVB8Bysb0ml2IZyKAdpEZvVu89e861+z8JAx76TMuoTYk/YBT97haNKrzCqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UeGplCNi; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2163dc5155fso82622215ad.0
        for <linux-pci@vger.kernel.org>; Mon, 03 Feb 2025 09:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738604465; x=1739209265; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Jc4txm5k91aOH0PDpEgnd/B3XO8sxa1Y0noFk72AFGo=;
        b=UeGplCNioTN+XSdOYoaVZ4ztGut4qm8Ciix1w2T562l9kEYakmf1SbQYX5S1nqnO/A
         1yoeK861u8NKq5yGbDz9/nM9Hhaqr0HBWekN1w8Eex55RCHcfQG+66LdpcKkqPb+vk7d
         HKRbASMfsFuu/NJ2u99XH4il1fowaobKK5KiQP6x1xYVB7B0KElYnUa/ZF1bm4YUoGVZ
         bLK8ROS8/oAXYkkqrcRwhpXh48wkkPWp8HvFANR63lQu7O15K+pU23APYdMiYCwZUMwu
         eHbUKfgHzhIV7/Datqkz37M+/2RbxGBPTCNsaEKKo60/zOdwXBCM/jBBIeAi/kpgctJe
         w9ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738604465; x=1739209265;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jc4txm5k91aOH0PDpEgnd/B3XO8sxa1Y0noFk72AFGo=;
        b=rLMhFJjz5bdfRlr3mrjc3by8gKm+36nH7/qFVC8+VJLtraLdkhAeHdTGpoIjH5gUYC
         qrW3rtcXtum/Bo45TQBhx7TqJBOpPHIO6Sk+IFhO9sJsOtTmiXHD94q/YG7/5MzTvTiq
         Ckn88j916LwcKfa3+ooymieOPErtlzV/dmBMaGXBGB4KRK0xHunlU3e0M2nvlX+IRwQH
         pFlvNEK3/MrqYr0T+2+GunbsxCC2V6pwX/XHR9anS15cAiHy1YwY9R4VWBVyC7RRzl5K
         5Z7AchlTsD/SHQA9tn04txdHkF8ogQCRvEeueFMlhyiMXjcrL3l8rVa0fOyP/76wGHYD
         ZJqA==
X-Forwarded-Encrypted: i=1; AJvYcCVb9kNCVYqxGRsviH4Ws6r6ilZhKbnu9Aitx7pwf1jo84Rhnk5WW2OLNdrcNCy8e8aJGTHXVrBizxo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqZboEDMptMfYeDBgXarbvAerdiWezJdHEz45mqe62zdv/pwjN
	8NR6rwcqixeTsf4w9CKeIqZCfbhc4JIt8QuA/KnCw+qrx14PHRLEmwwgffXO1g==
X-Gm-Gg: ASbGnctJeCzyA9j+ipEwhSynGg4HdCAEC5rGdcEV5/uSX3akVaOajfXMSs6Fu7vrNZH
	MKVhHxGoOj3dMbgkPQhkBRf8yJcPbsVsmJSaeg+uXVcNWV4+0yTpQW1iAl+T6fmCTbaI3R29PqJ
	GlQn/BkYghKkTa7F+ufoalTldCS3vsrWq8TZyUKlmKxYkAPYF/kql7Mzk5Qre7uIE70DvtKBLn+
	METcqua0sL3MmxP8/RvdPjS/UfiWiWvPeyyaHkfYVFPZ/Zzen6MT2gtirpbr9ndL5pPt7FnKYQY
	F1ZXV2H+zi2em1IiuYf3Dn9dIw==
X-Google-Smtp-Source: AGHT+IEXuhXDfLQheB0CwwJea+oShjMxbR0KS/ste/5V1usvYDbgkRviKo/xEnR44zqlAv99bR2jyQ==
X-Received: by 2002:a05:6a00:2908:b0:726:64a5:5f67 with SMTP id d2e1a72fcca58-72fd0c03db4mr31901545b3a.12.1738604465518;
        Mon, 03 Feb 2025 09:41:05 -0800 (PST)
Received: from thinkpad ([120.60.129.34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe6a1a773sm8823217b3a.166.2025.02.03.09.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 09:41:05 -0800 (PST)
Date: Mon, 3 Feb 2025 23:11:00 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, jingoohan1@gmail.com,
	michal.simek@amd.com, bharat.kumar.gogada@amd.com
Subject: Re: [PATCH v8 3/3] PCI: amd-mdb: Add AMD MDB Root Port driver
Message-ID: <20250203174100.uohiowulqtlkjp32@thinkpad>
References: <20250129113029.64841-1-thippeswamy.havalige@amd.com>
 <20250129113029.64841-4-thippeswamy.havalige@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250129113029.64841-4-thippeswamy.havalige@amd.com>

On Wed, Jan 29, 2025 at 05:00:29PM +0530, Thippeswamy Havalige wrote:
> Add support for AMD MDB (Multimedia DMA Bridge) IP core as Root Port.
> 
> The Versal2 devices include MDB Module. The integrated block for MDB along
> with the integrated bridge can function as PCIe Root Port controller at
> Gen5 32-Gb/s operation per lane.
> 
> Bridge supports error and legacy interrupts and are handled using platform
> specific interrupt line in Versal2.
> 
> Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> ---
> changes in v2:
> -------------
> - Update Gen5 speed in the patch description.
> - Modify Kconfig file.
> - Update string _leg_ to intx.
> - Get platform structure through automic variables.
> - Remove _rp_ in function.
> Changes in v3:
> --------------
> -None.
> Changes in v4:
> --------------
> -None.
> Changes in v5:
> --------------
> -None.
> Changes in v6:
> --------------
> - Remove pdev automatic variable.
> - Update register name to slcr.
> - Fix whitespace.
> - remove Spurious extra line.
> - Update Legacy to INTx.
> - Add space before (SLCR).
> - Update menuconfig description.
> Changes in v7:
> --------------
> - None.
> Changes in v8:
> --------------
> - Remove inline keyword.
> - Fix indentations.
> - Add AMD MDB prefix to interrupt names.
> - Remove Kernel doc.
> - Fix return types.
> - Modify dev_warn to dev_warn_once.
> - Add Intx handler & callbacks.
> ---
>  drivers/pci/controller/dwc/Kconfig        |  11 +
>  drivers/pci/controller/dwc/Makefile       |   1 +
>  drivers/pci/controller/dwc/pcie-amd-mdb.c | 476 ++++++++++++++++++++++
>  3 files changed, 488 insertions(+)
>  create mode 100644 drivers/pci/controller/dwc/pcie-amd-mdb.c
> 
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index b6d6778b0698..61d119646749 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -27,6 +27,17 @@ config PCIE_AL
>  	  required only for DT-based platforms. ACPI platforms with the
>  	  Annapurna Labs PCIe controller don't need to enable this.
>  
> +config PCIE_AMD_MDB
> +	bool "AMD MDB Versal2 PCIe Host controller"
> +	depends on OF || COMPILE_TEST
> +	depends on PCI && PCI_MSI
> +	select PCIE_DW_HOST
> +	help
> +	  Say Y here if you want to enable PCIe controller support on AMD
> +	  Versal2 SoCs. The AMD MDB Versal2 PCIe controller is based on DesignWare
> +	  IP and therefore the driver re-uses the Designware core functions to
> +	  implement the driver.
> +
>  config PCI_MESON
>  	tristate "Amlogic Meson PCIe controller"
>  	default m if ARCH_MESON
> diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
> index a8308d9ea986..ae27eda6ec5e 100644
> --- a/drivers/pci/controller/dwc/Makefile
> +++ b/drivers/pci/controller/dwc/Makefile
> @@ -3,6 +3,7 @@ obj-$(CONFIG_PCIE_DW) += pcie-designware.o
>  obj-$(CONFIG_PCIE_DW_HOST) += pcie-designware-host.o
>  obj-$(CONFIG_PCIE_DW_EP) += pcie-designware-ep.o
>  obj-$(CONFIG_PCIE_DW_PLAT) += pcie-designware-plat.o
> +obj-$(CONFIG_PCIE_AMD_MDB) += pcie-amd-mdb.o
>  obj-$(CONFIG_PCIE_BT1) += pcie-bt1.o
>  obj-$(CONFIG_PCI_DRA7XX) += pci-dra7xx.o
>  obj-$(CONFIG_PCI_EXYNOS) += pci-exynos.o
> diff --git a/drivers/pci/controller/dwc/pcie-amd-mdb.c b/drivers/pci/controller/dwc/pcie-amd-mdb.c
> new file mode 100644
> index 000000000000..94b83fa649ae
> --- /dev/null
> +++ b/drivers/pci/controller/dwc/pcie-amd-mdb.c
> @@ -0,0 +1,476 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * PCIe host controller driver for AMD MDB PCIe Bridge
> + *
> + * Copyright (C) 2024-2025, Advanced Micro Devices, Inc.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/gpio.h>
> +#include <linux/interrupt.h>
> +#include <linux/irqdomain.h>
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/of_device.h>
> +#include <linux/pci.h>
> +#include <linux/platform_device.h>
> +#include <linux/resource.h>
> +#include <linux/types.h>
> +
> +#include "pcie-designware.h"
> +
> +#define AMD_MDB_TLP_IR_STATUS_MISC		0x4C0
> +#define AMD_MDB_TLP_IR_MASK_MISC		0x4C4
> +#define AMD_MDB_TLP_IR_ENABLE_MISC		0x4C8
> +
> +#define AMD_MDB_PCIE_IDRN_SHIFT			16
> +
> +/* Interrupt registers definitions */
> +#define AMD_MDB_PCIE_INTR_CMPL_TIMEOUT		15
> +#define AMD_MDB_PCIE_INTR_INTA_ASSERT		16
> +#define AMD_MDB_PCIE_INTR_INTB_ASSERT		18
> +#define AMD_MDB_PCIE_INTR_INTC_ASSERT		20
> +#define AMD_MDB_PCIE_INTR_INTD_ASSERT		22
> +#define AMD_MDB_PCIE_INTR_PM_PME_RCVD		24
> +#define AMD_MDB_PCIE_INTR_PME_TO_ACK_RCVD	25
> +#define AMD_MDB_PCIE_INTR_MISC_CORRECTABLE	26
> +#define AMD_MDB_PCIE_INTR_NONFATAL		27
> +#define AMD_MDB_PCIE_INTR_FATAL			28
> +
> +#define IMR(x) BIT(AMD_MDB_PCIE_INTR_ ##x)
> +#define AMD_MDB_PCIE_IMR_ALL_MASK			\
> +	(						\
> +		IMR(CMPL_TIMEOUT)	|		\
> +		IMR(INTA_ASSERT)	|		\
> +		IMR(INTB_ASSERT)	|		\
> +		IMR(INTC_ASSERT)	|		\
> +		IMR(INTD_ASSERT)	|		\
> +		IMR(PM_PME_RCVD)	|		\
> +		IMR(PME_TO_ACK_RCVD)	|		\
> +		IMR(MISC_CORRECTABLE)	|		\
> +		IMR(NONFATAL)		|		\
> +		IMR(FATAL)				\
> +	)
> +
> +#define AMD_MDB_TLP_PCIE_INTX_MASK	GENMASK(23, 16)
> +
> +/**
> + * struct amd_mdb_pcie - PCIe port information
> + * @pci: DesignWare PCIe controller structure
> + * @slcr: MDB System Level Control and Status Register (SLCR) Base
> + * @intx_domain: INTx IRQ domain pointer
> + * @mdb_domain: MDB IRQ domain pointer

intx_irq is not defined.

> + */
> +struct amd_mdb_pcie {
> +	struct dw_pcie			pci;
> +	void __iomem			*slcr;
> +	struct irq_domain		*intx_domain;
> +	struct irq_domain		*mdb_domain;
> +	int				intx_irq;
> +};
> +
> +static const struct dw_pcie_host_ops amd_mdb_pcie_host_ops = {
> +};
> +
> +static inline u32 pcie_read(struct amd_mdb_pcie *pcie, u32 reg)

'inline' keyword is not removed.

Also, why are you insisting of keeping this wrapper? It literally adds 0 value.

> +{
> +	return readl_relaxed(pcie->slcr + reg);
> +}
> +
> +static inline void pcie_write(struct amd_mdb_pcie *pcie,
> +			      u32 val, u32 reg)
> +{
> +	writel_relaxed(val, pcie->slcr + reg);
> +}
> +
> +static void amd_mdb_mask_intx_irq(struct irq_data *data)
> +{
> +	struct amd_mdb_pcie *pcie = irq_data_get_irq_chip_data(data);
> +	struct dw_pcie *pci = &pcie->pci;
> +	struct dw_pcie_rp *port = &pci->pp;
> +	unsigned long flags;
> +	u32 mask, val;
> +
> +	mask = BIT(data->hwirq + AMD_MDB_PCIE_IDRN_SHIFT);
> +
> +	raw_spin_lock_irqsave(&port->lock, flags);
> +	val = pcie_read(pcie, AMD_MDB_TLP_IR_MASK_MISC);
> +	pcie_write(pcie, (val & (~mask)), AMD_MDB_TLP_IR_ENABLE_MISC);
> +	raw_spin_unlock_irqrestore(&port->lock, flags);
> +}
> +
> +static void amd_mdb_unmask_intx_irq(struct irq_data *data)
> +{
> +	struct amd_mdb_pcie *pcie = irq_data_get_irq_chip_data(data);
> +	struct dw_pcie *pci = &pcie->pci;
> +	struct dw_pcie_rp *port = &pci->pp;
> +	unsigned long flags;
> +	u32 mask;
> +	u32 val;
> +
> +	mask = BIT(data->hwirq + AMD_MDB_PCIE_IDRN_SHIFT);
> +
> +	raw_spin_lock_irqsave(&port->lock, flags);
> +	val = pcie_read(pcie, AMD_MDB_TLP_IR_MASK_MISC);
> +	pcie_write(pcie, (val | mask), AMD_MDB_TLP_IR_ENABLE_MISC);
> +	raw_spin_unlock_irqrestore(&port->lock, flags);
> +}
> +
> +static struct irq_chip amd_mdb_intx_irq_chip = {
> +	.name		= "AMD MDB INTx",
> +	.irq_mask	= amd_mdb_mask_intx_irq,
> +	.irq_unmask	= amd_mdb_unmask_intx_irq,
> +};
> +
> +/**
> + * amd_mdb_pcie_intx_map - Set the handler for the INTx and mark IRQ
> + * as valid

Make use of 80 column width.

> + * @domain: IRQ domain
> + * @irq: Virtual IRQ number
> + * @hwirq: HW interrupt number
> + *
> + * Return: Always returns 0.
> + */
> +static int amd_mdb_pcie_intx_map(struct irq_domain *domain,
> +				 unsigned int irq, irq_hw_number_t hwirq)
> +{
> +	irq_set_chip_and_handler(irq, &amd_mdb_intx_irq_chip,
> +				 handle_level_irq);
> +	irq_set_chip_data(irq, domain->host_data);
> +	irq_set_status_flags(irq, IRQ_LEVEL);
> +
> +	return 0;
> +}
> +
> +/* INTx IRQ Domain operations */
> +static const struct irq_domain_ops amd_intx_domain_ops = {
> +	.map = amd_mdb_pcie_intx_map,
> +};
> +
> +static int amd_mdb_pcie_init_port(struct amd_mdb_pcie *pcie)
> +{
> +	int val;
> +
> +	/* Disable all TLP Interrupts */
> +	pcie_write(pcie, pcie_read(pcie, AMD_MDB_TLP_IR_ENABLE_MISC) &
> +		   ~AMD_MDB_PCIE_IMR_ALL_MASK,
> +		   AMD_MDB_TLP_IR_ENABLE_MISC);
> +
> +	/* Clear pending TLP interrupts */
> +	pcie_write(pcie, pcie_read(pcie, AMD_MDB_TLP_IR_STATUS_MISC) &
> +		   AMD_MDB_PCIE_IMR_ALL_MASK,
> +		   AMD_MDB_TLP_IR_STATUS_MISC);
> +
> +	/* Enable all TLP Interrupts */
> +	val = pcie_read(pcie, AMD_MDB_TLP_IR_ENABLE_MISC);
> +	pcie_write(pcie, (val | AMD_MDB_PCIE_IMR_ALL_MASK),
> +		   AMD_MDB_TLP_IR_ENABLE_MISC);

Why can't you just do,

	pcie_write(pcie, AMD_MDB_PCIE_IMR_ALL_MASK, AMD_MDB_TLP_IR_ENABLE_MISC);

> +
> +	return 0;
> +}
> +
> +static irqreturn_t amd_mdb_pcie_event_flow(int irq, void *args)
> +{
> +	struct amd_mdb_pcie *pcie = args;
> +	unsigned long val;
> +	int i;
> +
> +	val = pcie_read(pcie, AMD_MDB_TLP_IR_STATUS_MISC);
> +	val &= ~pcie_read(pcie, AMD_MDB_TLP_IR_MASK_MISC);
> +	for_each_set_bit(i, &val, 32)
> +		generic_handle_domain_irq(pcie->mdb_domain, i);
> +	pcie_write(pcie, val, AMD_MDB_TLP_IR_STATUS_MISC);

Again, it is a good practice to clear the interrupts before processing them. If
there are any technical reason to not do so, please explain. Your reply in the
previous version didn't add much value.

> +
> +	return IRQ_HANDLED;
> +}
> +

[...]

> +static int amd_mdb_add_pcie_port(struct amd_mdb_pcie *pcie,

add_pcie_port() is not logically correct as you are not adding any port (root
port). Maybe reword it to amd_mdb_pcie_init()?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

