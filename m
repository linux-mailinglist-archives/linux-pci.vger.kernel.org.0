Return-Path: <linux-pci+bounces-20170-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4823A176A9
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jan 2025 05:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 466351889551
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jan 2025 04:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F0A1898F2;
	Tue, 21 Jan 2025 04:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VW2dy8VR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56E8145B27
	for <linux-pci@vger.kernel.org>; Tue, 21 Jan 2025 04:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737434904; cv=none; b=RAP6f4ECsVmA7m3fDaYIUEG+l49aEE3GqqldLUF4Efxe49z5NCCb678gUYhYFiN6gEUDtu2PYhgoBgQ3FqmZT1RVwTERNRKbulqYQgHlR6LjCcbrXZo/IpLa1iASI5opjdnRNVM5ldXDzJEmLB2QAWgjzZUCntQ5XIE9Uc4Y1fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737434904; c=relaxed/simple;
	bh=iugmiBi4Nu5GUdjehZM7U8SlW1j7zYNp2RNePT3DREo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hFBHxDdCZasRJ18+lCkaZWJvEBV9TBB4OdTjMiXT61Pl+Va7idVHtOdjRCN77BWzxU5V94QflaufgNEvkKt3a4wzbWjj89PInr8pxPnNm4sVkttP2xJBu/cVv9AZuZ1PGooQxgqeaVYuqiMctbJ0iJ2HId3rDFcXJmr9XYw9OeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VW2dy8VR; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2163b0c09afso93146065ad.0
        for <linux-pci@vger.kernel.org>; Mon, 20 Jan 2025 20:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737434901; x=1738039701; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=H9imLqriaTYMdYMbatrCGSoMuaWKbl/cwaLiP5VT4gE=;
        b=VW2dy8VRwcyxSNQHEwEF9KSIqL0DY5iJh4JGEoom0jaozj8bBtnVLJEt0AMnaBPu3r
         X5RRelivoFdPP7Az0n2xLHTYa+IFLplDDiuCAlxJrfrPlPyZOyCBZKzA/VZh0Yd6CzH4
         7ziY6ejLB0QGf9k/wLv38F60YrUJUDCBnxNfehZ6wDCEER4E37Grf7UO+b/7LjbJWZDN
         YCf+t7FK9VCKG5NsQvypWuLXyfyqR+tES4le242XykVgtbibeN9eyksWN62jmhdogo4p
         iKRM3qyxLBxi27rSULYl4VK5Wh2DZVenXRGGkROIOwSjlHjWsOaCy6fHeTU4f97nsyV/
         hVwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737434901; x=1738039701;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H9imLqriaTYMdYMbatrCGSoMuaWKbl/cwaLiP5VT4gE=;
        b=IMkk18rX9BDcLJ0+RtazD+2bWrz4PQP61BKGEmNSed7rRqZNAJrq4aysFkQbYezFW/
         LliO/LaWI+YXU4DDmbr/hLPvlZYwhXZPtqUMpn3bvyacUbE4UJ9ngE3ALp1gWqDZR6dU
         tLaoeJ1sHvNZzNXXbpbDREC4yyaetVhT9QmWknZGyuawX6HUBPX04/Ba6biKMZMP5yH2
         uShTG3rFCkpvh+Gq4ZseCG4M0pfXrlEjMZfBYqTAgCTLRE5K+e8o9ldzp4+x6a0dtsWZ
         rEqAakptshD831T2dV/ELYMCUcNQHu41eFq48dIy13rr13okCwmdSRXJhDX1AkRVuFOR
         P83g==
X-Forwarded-Encrypted: i=1; AJvYcCUYD08B4nFkRFTtCdtWeCgHLSjwuZVL7XUXzm87KhnxegiLtIknuTXQ0UHkUk8UX+BsYwwFctZ0W7c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmpMb6VCM1jwuCuPO3TiSk2i4OLeD58yhIy5PJxWMQ8LrPZJLm
	ZxBkgqLH/uyQAQ4GRrQAg2GuWSJQKnLz8kRXsRLTEeeO3iNRJ54iuE4TMw6c6Q==
X-Gm-Gg: ASbGnctODwOoB3y0yr5u1k76ARcM59BCuUWAWHrA8O2M2dRDQS47Ib0gEY5aEBwsM9a
	Alom2oQD/3Lkb8qw+wzPWUQR/5/q94vuLH8Xs66KxBBmhdMgCyRyjogPlVxRAaoRSErfObkbHUe
	im82s2VUAQj9DIqXSs0dZA2Xfi6zIeQjmFqnkrtHsQ0zdGv1XFD7n5mL2rI6tk2LX9Aqx/smDee
	vbfSya0v9MzdqXXydKAmLicMqs1RgDPzu7tOZWX4PU36A0/jQGeevW5oWNjh9/5qJRumyZD3rUO
	RucWyBA=
X-Google-Smtp-Source: AGHT+IFRBPCd43VP7zidhVvQJ/c8SujHFXdH8/uXhE1rSVfQtPuzNX2HL1fRJkHS5sC98X/TzLkf0A==
X-Received: by 2002:a17:902:eccc:b0:20b:8a71:b5c1 with SMTP id d9443c01a7336-21c352c7d0fmr260887915ad.1.1737434900886;
        Mon, 20 Jan 2025 20:48:20 -0800 (PST)
Received: from thinkpad ([117.213.102.234])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2d3ad0b1sm69017835ad.144.2025.01.20.20.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 20:48:20 -0800 (PST)
Date: Tue, 21 Jan 2025 10:18:13 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, jingoohan1@gmail.com,
	michal.simek@amd.com, bharat.kumar.gogada@amd.com
Subject: Re: [PATCH v7 3/3] PCI: amd-mdb: Add AMD MDB Root Port driver
Message-ID: <20250121044813.3pdtyumzbakjwsax@thinkpad>
References: <20250119224305.4016221-1-thippeswamy.havalige@amd.com>
 <20250119224305.4016221-4-thippeswamy.havalige@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250119224305.4016221-4-thippeswamy.havalige@amd.com>

On Mon, Jan 20, 2025 at 04:13:05AM +0530, Thippeswamy Havalige wrote:
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
> ---
>  drivers/pci/controller/dwc/Kconfig        |  11 +
>  drivers/pci/controller/dwc/Makefile       |   1 +
>  drivers/pci/controller/dwc/pcie-amd-mdb.c | 436 ++++++++++++++++++++++
>  3 files changed, 448 insertions(+)
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
> index 000000000000..ef1ac757d41c
> --- /dev/null
> +++ b/drivers/pci/controller/dwc/pcie-amd-mdb.c
> @@ -0,0 +1,436 @@
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
> +		IMR(PM_PME_RCVD)	|		\
> +		IMR(PME_TO_ACK_RCVD)	|		\
> +		IMR(MISC_CORRECTABLE)	|		\
> +		IMR(NONFATAL)		|		\
> +		IMR(FATAL)				\
> +	)
> +
> +/**
> + * struct amd_mdb_pcie - PCIe port information
> + * @pci: DesignWare PCIe controller structure
> + * @slcr: MDB System Level Control and Status Register (SLCR) Base
> + * @intx_domain: INTx IRQ domain pointer
> + * @mdb_domain: MDB IRQ domain pointer
> + */
> +struct amd_mdb_pcie {
> +	struct dw_pcie			pci;
> +	void __iomem			*slcr;
> +	struct irq_domain		*intx_domain;
> +	struct irq_domain		*mdb_domain;
> +};
> +
> +static const struct dw_pcie_host_ops amd_mdb_pcie_host_ops = {
> +};
> +
> +static inline u32 pcie_read(struct amd_mdb_pcie *pcie, u32 reg)

No need of 'inline' keyword in .c files. Compiler will inline the function on
its own when required.

But I'd prefer to use the {readl/writel}_relaxed directly instead of a wrapper.

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
> +	raw_spin_lock_irqsave(&port->lock, flags);
> +

Remove the newline here and add it before raw_spin_lock_irqsave().

> +	val = pcie_read(pcie, AMD_MDB_TLP_IR_STATUS_MISC);
> +	pcie_write(pcie, (val & (~mask)), AMD_MDB_TLP_IR_STATUS_MISC);
> +

Remove the newline here.

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
> +	raw_spin_lock_irqsave(&port->lock, flags);
> +

Same as above.

> +	val = pcie_read(pcie, AMD_MDB_TLP_IR_STATUS_MISC);
> +	pcie_write(pcie, (val | mask), AMD_MDB_TLP_IR_STATUS_MISC);
> +
> +	raw_spin_unlock_irqrestore(&port->lock, flags);
> +}
> +
> +static struct irq_chip amd_mdb_intx_irq_chip = {
> +	.name		= "INTx",

Add the 'AMD MDB' prefix.

> +	.irq_mask	= amd_mdb_mask_intx_irq,
> +	.irq_unmask	= amd_mdb_unmask_intx_irq,
> +};
> +
> +/**
> + * amd_mdb_pcie_intx_map - Set the handler for the INTx and mark IRQ
> + * as valid
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
> +/**
> + * amd_mdb_pcie_init_port - Initialize hardware
> + * @pcie: PCIe port information
> + */

This kernel doc doesn't add any value. So you can drop it.

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

Don't you need port lock here? What if the IRQ handler gets executed in a
different CPU?

> +	val &= ~pcie_read(pcie, AMD_MDB_TLP_IR_MASK_MISC);
> +	for_each_set_bit(i, &val, 32)
> +		generic_handle_domain_irq(pcie->mdb_domain, i);
> +	pcie_write(pcie, val, AMD_MDB_TLP_IR_STATUS_MISC);

Clear the IRQs before handling them.

> +
> +	return IRQ_HANDLED;
> +}
> +
> +#define _IC(x, s)[AMD_MDB_PCIE_INTR_ ## x] = { __stringify(x), s }
> +
> +static const struct {
> +	const char	*sym;
> +	const char	*str;
> +} intr_cause[32] = {
> +	_IC(CMPL_TIMEOUT,	"completion timeout"),
> +	_IC(PM_PME_RCVD,	"PM_PME message received"),
> +	_IC(PME_TO_ACK_RCVD,	"PME_TO_ACK message received"),
> +	_IC(MISC_CORRECTABLE,	"Correctable error message"),
> +	_IC(NONFATAL,		"Non fatal error message"),
> +	_IC(FATAL,		"Fatal error message"),
> +};
> +
> +static void amd_mdb_mask_event_irq(struct irq_data *d)
> +{
> +	struct amd_mdb_pcie *pcie = irq_data_get_irq_chip_data(d);
> +	struct dw_pcie *pci = &pcie->pci;
> +	struct dw_pcie_rp *port = &pci->pp;
> +	u32 val;
> +
> +	raw_spin_lock(&port->lock);

Why this lock is non-irq variant compared to amd_mdb_mask_intx_irq()?

> +	val = pcie_read(pcie, AMD_MDB_TLP_IR_STATUS_MISC);
> +	val &= ~BIT(d->hwirq);
> +	pcie_write(pcie, val, AMD_MDB_TLP_IR_STATUS_MISC);
> +	raw_spin_unlock(&port->lock);
> +}
> +
> +static void amd_mdb_unmask_event_irq(struct irq_data *d)
> +{
> +	struct amd_mdb_pcie *pcie = irq_data_get_irq_chip_data(d);
> +	struct dw_pcie *pci = &pcie->pci;
> +	struct dw_pcie_rp *port = &pci->pp;
> +	u32 val;
> +
> +	raw_spin_lock(&port->lock);

Same here.

> +	val = pcie_read(pcie, AMD_MDB_TLP_IR_STATUS_MISC);
> +	val |= BIT(d->hwirq);
> +	pcie_write(pcie, val, AMD_MDB_TLP_IR_STATUS_MISC);
> +	raw_spin_unlock(&port->lock);
> +}
> +
> +static struct irq_chip amd_mdb_event_irq_chip = {
> +	.name		= "RC-Event",

Add the 'AMD MDB' prefix.

> +	.irq_mask	= amd_mdb_mask_event_irq,
> +	.irq_unmask	= amd_mdb_unmask_event_irq,
> +};
> +
> +static int amd_mdb_pcie_event_map(struct irq_domain *domain,
> +				  unsigned int irq, irq_hw_number_t hwirq)
> +{
> +	irq_set_chip_and_handler(irq, &amd_mdb_event_irq_chip,
> +				 handle_level_irq);
> +	irq_set_chip_data(irq, domain->host_data);
> +	irq_set_status_flags(irq, IRQ_LEVEL);

newline here.

> +	return 0;
> +}
> +
> +static const struct irq_domain_ops event_domain_ops = {
> +	.map = amd_mdb_pcie_event_map,
> +};
> +
> +static void amd_mdb_pcie_free_irq_domains(struct amd_mdb_pcie *pcie)
> +{
> +	if (pcie->intx_domain) {
> +		irq_domain_remove(pcie->intx_domain);
> +		pcie->intx_domain = NULL;
> +	}
> +
> +	if (pcie->mdb_domain) {
> +		irq_domain_remove(pcie->mdb_domain);
> +		pcie->mdb_domain = NULL;
> +	}
> +}
> +
> +/**
> + * amd_mdb_pcie_init_irq_domains - Initialize IRQ domain
> + * @pcie: PCIe port information
> + * @pdev: platform device
> + * Return: '0' on success and error value on failure
> + */
> +static int amd_mdb_pcie_init_irq_domains(struct amd_mdb_pcie *pcie,
> +					 struct platform_device *pdev)
> +{
> +	struct dw_pcie *pci = &pcie->pci;
> +	struct dw_pcie_rp *pp = &pci->pp;
> +	struct device *dev = &pdev->dev;
> +	struct device_node *node = dev->of_node;
> +	struct device_node *pcie_intc_node;
> +
> +	/* Setup INTx */
> +	pcie_intc_node = of_get_next_child(node, NULL);
> +	if (!pcie_intc_node) {
> +		dev_err(dev, "No PCIe Intc node found\n");
> +		return -EINVAL;

-ENODATA

> +	}
> +
> +	pcie->mdb_domain = irq_domain_add_linear(pcie_intc_node, 32,
> +						 &event_domain_ops, pcie);
> +	if (!pcie->mdb_domain)
> +		goto out;
> +
> +	irq_domain_update_bus_token(pcie->mdb_domain, DOMAIN_BUS_NEXUS);
> +
> +	pcie->intx_domain = irq_domain_add_linear(pcie_intc_node, PCI_NUM_INTX,
> +						  &amd_intx_domain_ops, pcie);
> +	if (!pcie->intx_domain)
> +		goto mdb_out;
> +
> +	irq_domain_update_bus_token(pcie->intx_domain, DOMAIN_BUS_WIRED);
> +
> +	of_node_put(pcie_intc_node);

Move this before irq_domain_update_bus_token().

> +	raw_spin_lock_init(&pp->lock);
> +
> +	return 0;
> +mdb_out:
> +	amd_mdb_pcie_free_irq_domains(pcie);
> +out:
> +	of_node_put(pcie_intc_node);
> +	dev_err(dev, "Failed to allocate IRQ domains\n");

It is not a good practice to print error logs and return a fixed error no in
goto labels. If one more condition gets added to this function later, these all
should be moved to the respective error check. So please do so now itself even
if it adds a bit of redundancy.

The error log could be improved by stating which domain actually failed.

> +
> +	return -ENOMEM;
> +}
> +
> +static irqreturn_t amd_mdb_pcie_intr_handler(int irq, void *args)
> +{
> +	struct amd_mdb_pcie *pcie = args;
> +	struct device *dev;
> +	struct irq_data *d;
> +
> +	dev = pcie->pci.dev;
> +
> +	d = irq_domain_get_irq_data(pcie->mdb_domain, irq);
> +	if (intr_cause[d->hwirq].str)
> +		dev_warn(dev, "%s\n", intr_cause[d->hwirq].str);

Move this to dev_dbg().

> +	else
> +		dev_warn(dev, "Unknown IRQ %ld\n", d->hwirq);

dev_WARN_ONCE() to avoid spamming the log.

> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int amd_mdb_setup_irq(struct amd_mdb_pcie *pcie,
> +			     struct platform_device *pdev)
> +{
> +	struct dw_pcie *pci = &pcie->pci;
> +	struct dw_pcie_rp *pp = &pci->pp;
> +	struct device *dev = &pdev->dev;
> +	int i, irq, err;
> +
> +	pp->irq = platform_get_irq(pdev, 0);
> +	if (pp->irq < 0)
> +		return pp->irq;
> +
> +	for (i = 0; i < ARRAY_SIZE(intr_cause); i++) {
> +		if (!intr_cause[i].str)
> +			continue;
> +		irq = irq_create_mapping(pcie->mdb_domain, i);
> +		if (!irq) {
> +			dev_err(dev, "Failed to map mdb domain interrupt\n");
> +			return -ENXIO;

-ENOMEM

> +		}
> +		err = devm_request_irq(dev, irq, amd_mdb_pcie_intr_handler,
> +				       IRQF_SHARED | IRQF_NO_THREAD,
> +				       intr_cause[i].sym, pcie);

IRQ name should have the 'amd_mdb' prefix and also the domain number to uniquely
identify the interrupt belonging to each host bridge.

> +		if (err) {
> +			dev_err(dev, "Failed to request IRQ %d\n", irq);
> +			return err;
> +		}
> +	}
> +
> +	/* Plug the main event chained handler */
> +	err = devm_request_irq(dev, pp->irq, amd_mdb_pcie_event_flow,
> +			       IRQF_SHARED | IRQF_NO_THREAD, "pcie_irq", pcie);

Same as above.

> +	if (err) {
> +		dev_err(dev, "Failed to request event IRQ %d\n", pp->irq);
> +		return err;
> +	}
> +
> +	return 0;
> +}
> +
> +static int amd_mdb_add_pcie_port(struct amd_mdb_pcie *pcie,
> +				 struct platform_device *pdev)
> +{
> +	struct dw_pcie *pci = &pcie->pci;
> +	struct dw_pcie_rp *pp = &pci->pp;
> +	struct device *dev = &pdev->dev;
> +	int ret;
> +
> +	pcie->slcr = devm_platform_ioremap_resource_byname(pdev, "slcr");
> +	if (IS_ERR(pcie->slcr))
> +		return PTR_ERR(pcie->slcr);
> +
> +	ret = amd_mdb_pcie_init_irq_domains(pcie, pdev);
> +	if (ret)
> +		return ret;
> +
> +	amd_mdb_pcie_init_port(pcie);
> +
> +	ret = amd_mdb_setup_irq(pcie, pdev);
> +	if (ret) {
> +		dev_err(dev, "Failed to set up interrupts\n");
> +		goto out;
> +	}
> +
> +	pp->ops = &amd_mdb_pcie_host_ops;
> +
> +	ret = dw_pcie_host_init(pp);
> +	if (ret) {
> +		dev_err(dev, "Failed to initialize host\n");
> +		goto out;
> +	}
> +
> +	return 0;
> +
> +out:
> +	amd_mdb_pcie_free_irq_domains(pcie);
> +	return ret;
> +}
> +
> +static int amd_mdb_pcie_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct amd_mdb_pcie *pcie;
> +	struct dw_pcie *pci;
> +
> +	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
> +	if (!pcie)
> +		return -ENOMEM;
> +
> +	pci = &pcie->pci;
> +	pci->dev = dev;
> +
> +	platform_set_drvdata(pdev, pcie);
> +
> +	return amd_mdb_add_pcie_port(pcie, pdev);
> +}
> +
> +static const struct of_device_id amd_mdb_pcie_of_match[] = {
> +	{
> +		.compatible = "amd,versal2-mdb-host",
> +	},
> +	{},
> +};
> +
> +static struct platform_driver amd_mdb_pcie_driver = {
> +	.driver = {
> +		.name	= "amd-mdb-pcie",
> +		.of_match_table = amd_mdb_pcie_of_match,
> +		.suppress_bind_attrs = true,

Consider using PROBE_PREFER_ASYNCHRONOUS to speed up the probe.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

