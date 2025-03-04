Return-Path: <linux-pci+bounces-22836-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D573AA4DF1D
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 14:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6969188919F
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 13:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662DF2045A6;
	Tue,  4 Mar 2025 13:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uF27mMa8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221DC204581
	for <linux-pci@vger.kernel.org>; Tue,  4 Mar 2025 13:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741094621; cv=none; b=LsBl5zbv2ow4vvRv6XlPjp2zGUf4FlMN+ryJ1Ra+WjL7qq4IitRormGUMbM7peFquQ6jiBLnSQZgxKOhOwIk1DggBTpxR78f6IM3bmFA3E7zxkXZ8AcjTdtasyewvAdcdewbKi4ygXB3jfS8jOtpkJRfzsqDUgP5lKhFzCCfPe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741094621; c=relaxed/simple;
	bh=5exBqg+g3LwAxr0cRYQgj6QpsuhD1o4/SLkedIgmOAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FSeOOzZwkOdXlPCpk0BnszuGzjZtGsMfD8YskP4Jiqvsk2uE//vofnlm/JLMOTI7d48LaOLNtf+0XRGa4JeakT7jHkJBLLnhvnWlp8Q5oiI8j/Z9ERH3Wtz83T7u7Mz8ph5SIzRbbuGEI5rzbjIqj/TV4r62O8g6kxDc3ByRzdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uF27mMa8; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2fea78afde5so7473244a91.2
        for <linux-pci@vger.kernel.org>; Tue, 04 Mar 2025 05:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741094618; x=1741699418; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TLlTP2P3XVTmbCA005xe5iSQnM5C5Obm8aC/eQv5+yw=;
        b=uF27mMa8BQoDwBunf6GteE0z7obroqPUwrBlViYhn8i0Cnork6Fh66iSmtix6JoPjU
         hDOXYmnnObsDHD3UgNeJAkqMYOuyCXnsOL/A2A9/2Sk1ETHcNUfAt16BQIWMUr1bAQ8K
         lHl/jQM6enZ2zCQYrZtqEuHGKvRUJdFDLXuKWh4itYUcZ/2zdKoIj2lxttLGqp2UZd6T
         ioRX8xzu72oj+jEu5RY/8Ad962Cs+uXcgto4uN7SbgI7A2UWIV7jrl7qMs5j0CWSpbnj
         cwgAKEQAgk65MQf32kyfdc3QmVcZhEt3po2M6mOqdg9j5J3zFbCCoI1lZ56x++tcdLuy
         q4fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741094618; x=1741699418;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TLlTP2P3XVTmbCA005xe5iSQnM5C5Obm8aC/eQv5+yw=;
        b=V5xFwH8CfARHg1z/gHjSlOCOFmiLgAISmot9gHjpjOBHWiZoAx+qHbQYspEsnEGACG
         emmyxdo6DchPSyrsqc/KR0l5oJL9zbtnePLM5KSPdyKm5i/BlwLa7U7cxTff6ftymyt1
         2VOTvmB9b3B2OsVUujJKOlmKayuLvjHrDPQaJUspBvw1WkvPV4a8brt+WtipCEIezv5r
         s8gG3RE4vSKqNjTOIwHXI3Xetbkpz/a3/k55/BIPrwXwpz8VksUoX71NBwhEZ0IZCQ0n
         Neq7ZwrlTNpaJpqShQWpVh8TxiP9QGybnNATg0CC7Gbhno1mwqnXnppb0QES4DyEBRCf
         AhJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQnuWQIiVFCCrKD0Ul7HTE8Dx0VCxokawlOGYYIT123dea07AVqBgsBIhDU5QpGa7p4FCK+bdwRko=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyye4/YF3yJlfwtyy+y/evQI6prBjEv+16vDFU6HyBMGxCTjyJx
	WqslHjPbhiInI1/6k7JUQ1Zzo15YBZD8E8rjhVsoBYOpKUk6SmIcbYvX3mnM1Q==
X-Gm-Gg: ASbGncuGFz8hUhO8rWoZ4B+Q0Y9OzDkpSjwZOBxyCZNFb7AEqy0CsuVc1IAhGYOa2En
	LT2B/MTsT7WOaa880qb/VXtAtNgjXvqlzjfxABOh3O1wkNL1NyifRB8QRmu4D4nOJqHlLmECPL1
	bd+RhM3yKTGTh3IKE8LEk4xrQRj7fXAk8yyMsbDfNH6Xn7AUSb2OG1KFE4j5BeumAATPWBAnHuS
	fQy1uLZA5WM6ONygD65O+uaNw1+OCwjkS2gz5vD/tzlkBMkI6U1BNEVGp2TpQ26F6L8BiwdJm+h
	u/mUKaKfRZHk+E41GF4DtcFV2baL6rWaEgUVAo4EjRJxNBtgLwBhsJQ=
X-Google-Smtp-Source: AGHT+IFMeZVELRprfuR+EiAkja4sPs3u2QLDI6r7lV0L0BlmHmwjzHepDD17gKbhj9zMyt8n3ICamw==
X-Received: by 2002:a17:90b:240d:b0:2fe:e0a9:49d4 with SMTP id 98e67ed59e1d1-2fee0a94d63mr17480327a91.2.1741094618284;
        Tue, 04 Mar 2025 05:23:38 -0800 (PST)
Received: from thinkpad ([120.60.51.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504c5d86sm94165025ad.148.2025.03.04.05.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 05:23:37 -0800 (PST)
Date: Tue, 4 Mar 2025 18:53:29 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, michal.simek@amd.com,
	bharat.kumar.gogada@amd.com, jingoohan1@gmail.com
Subject: Re: [PATCH v15 3/3] PCI: amd-mdb: Add AMD MDB Root Port driver
Message-ID: <20250304132329.vkgfi6lqcjtulota@thinkpad>
References: <20250228093351.923615-1-thippeswamy.havalige@amd.com>
 <20250228093351.923615-4-thippeswamy.havalige@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250228093351.923615-4-thippeswamy.havalige@amd.com>

On Fri, Feb 28, 2025 at 03:03:51PM +0530, Thippeswamy Havalige wrote:
> Add support for AMD MDB (Multimedia DMA Bridge) IP core as Root Port.
> 
> The Versal2 devices include MDB Module. The integrated block for MDB along
> with the integrated bridge can function as PCIe Root Port controller at
> Gen5 32-GT/s operation per lane.
> 
> Bridge supports error and INTx interrupts and are handled using platform
> specific interrupt line in Versal2.
> 
> Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>

This version looks good to me!

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes:
> | https://lore.kernel.org/oe-kbuild-all/202502191741.xrVmEAG4-lkp@intel.
> | com/
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
> Changes in v10:
> ---------------
> - Add intx assert & deassert macros.
> - Move amd_mdb_pcie_init_port function.
> - Add kernel doc for error warning messages.
> Changes in v11:
> ---------------
> - Remove intx deassert macro & generic handler.
> - Update Kconfig description.
> - Update INTx mask macro to handle only asser bits.
> - Move INTx handler.
> - Address other review comments.
> Changes in v12:
> ---------------
> - ADD TLP_IR_DISABLE_MISC register.
> - Modify intx call back function
> Changes in v13:
> - Add kernel doc for intx_irq
> Changes in v14:
> --------------
> - Modify mask in intx_irq_mask/unmask functions.
> - Modify mask in intx_flow handler.
> Changes in v15:
> ---------------
> - Fix commit message with GT/s
> - Fix Kconfig
> - Fix alignment issues.
> - Remove pcie_read & pcie_write API's
> - Fix function return types.
> - Remove IRQF_SHARED for interrupt handler.
> - Use lock_irqsave & unlock_irqrestore at required places.
> - Remove _flow suffix for interrupt handlers.
> ---
>  drivers/pci/controller/dwc/Kconfig        |  11 +
>  drivers/pci/controller/dwc/Makefile       |   1 +
>  drivers/pci/controller/dwc/pcie-amd-mdb.c | 472 ++++++++++++++++++++++
>  3 files changed, 484 insertions(+)
>  create mode 100644 drivers/pci/controller/dwc/pcie-amd-mdb.c
> 
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index b6d6778b0698..279240960828 100644
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
> +	  Versal2 SoCs. The AMD MDB Versal2 PCIe controller is based on
> +	  DesignWare IP and therefore the driver re-uses the DesignWare core
> +	  functions to implement the driver.
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
> index 000000000000..1f302d1c009a
> --- /dev/null
> +++ b/drivers/pci/controller/dwc/pcie-amd-mdb.c
> @@ -0,0 +1,472 @@
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
> +#define AMD_MDB_TLP_IR_DISABLE_MISC		0x4CC
> +
> +#define AMD_MDB_TLP_PCIE_INTX_MASK	GENMASK(23, 16)
> +
> +#define AMD_MDB_PCIE_INTR_INTX_ASSERT(x)	BIT((x) * 2)
> +
> +/* Interrupt registers definitions */
> +#define AMD_MDB_PCIE_INTR_CMPL_TIMEOUT		15
> +#define AMD_MDB_PCIE_INTR_INTX			16
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
> +		IMR(FATAL)		|		\
> +		AMD_MDB_TLP_PCIE_INTX_MASK		\
> +	)
> +
> +/**
> + * struct amd_mdb_pcie - PCIe port information
> + * @pci: DesignWare PCIe controller structure
> + * @slcr: MDB System Level Control and Status Register (SLCR) Base
> + * @intx_domain: INTx IRQ domain pointer
> + * @mdb_domain: MDB IRQ domain pointer
> + * @intx_irq: INTx IRQ interrupt number
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
> +static void amd_mdb_intx_irq_mask(struct irq_data *data)
> +{
> +	struct amd_mdb_pcie *pcie = irq_data_get_irq_chip_data(data);
> +	struct dw_pcie *pci = &pcie->pci;
> +	struct dw_pcie_rp *port = &pci->pp;
> +	unsigned long flags;
> +	u32 val;
> +
> +	raw_spin_lock_irqsave(&port->lock, flags);
> +	val = FIELD_PREP(AMD_MDB_TLP_PCIE_INTX_MASK,
> +			 AMD_MDB_PCIE_INTR_INTX_ASSERT(data->hwirq));
> +
> +	/*
> +	 * Writing '1' to a bit in AMD_MDB_TLP_IR_DISABLE_MISC disables that
> +	 * interrupt, writing '0' has no effect.
> +	 */
> +	writel_relaxed(val, pcie->slcr + AMD_MDB_TLP_IR_DISABLE_MISC);
> +	raw_spin_unlock_irqrestore(&port->lock, flags);
> +}
> +
> +static void amd_mdb_intx_irq_unmask(struct irq_data *data)
> +{
> +	struct amd_mdb_pcie *pcie = irq_data_get_irq_chip_data(data);
> +	struct dw_pcie *pci = &pcie->pci;
> +	struct dw_pcie_rp *port = &pci->pp;
> +	unsigned long flags;
> +	u32 val;
> +
> +	raw_spin_lock_irqsave(&port->lock, flags);
> +	val = FIELD_PREP(AMD_MDB_TLP_PCIE_INTX_MASK,
> +			 AMD_MDB_PCIE_INTR_INTX_ASSERT(data->hwirq));
> +
> +	/*
> +	 * Writing '1' to a bit in AMD_MDB_TLP_IR_ENABLE_MISC enables that
> +	 * interrupt, writing '0' has no effect.
> +	 */
> +	writel_relaxed(val, pcie->slcr + AMD_MDB_TLP_IR_ENABLE_MISC);
> +	raw_spin_unlock_irqrestore(&port->lock, flags);
> +}
> +
> +static struct irq_chip amd_mdb_intx_irq_chip = {
> +	.name		= "AMD MDB INTx",
> +	.irq_mask	= amd_mdb_intx_irq_mask,
> +	.irq_unmask	= amd_mdb_intx_irq_unmask,
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
> +static irqreturn_t dw_pcie_rp_intx(int irq, void *args)
> +{
> +	struct amd_mdb_pcie *pcie = args;
> +	unsigned long val;
> +	int i, int_status;
> +
> +	val = readl_relaxed(pcie->slcr + AMD_MDB_TLP_IR_STATUS_MISC);
> +	int_status = FIELD_GET(AMD_MDB_TLP_PCIE_INTX_MASK, val);
> +
> +	for (i = 0; i < PCI_NUM_INTX; i++) {
> +		if (int_status & AMD_MDB_PCIE_INTR_INTX_ASSERT(i))
> +			generic_handle_domain_irq(pcie->intx_domain, i);
> +	}
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
> +static void amd_mdb_event_irq_mask(struct irq_data *d)
> +{
> +	struct amd_mdb_pcie *pcie = irq_data_get_irq_chip_data(d);
> +	struct dw_pcie *pci = &pcie->pci;
> +	struct dw_pcie_rp *port = &pci->pp;
> +	unsigned long flags;
> +	u32 val;
> +
> +	raw_spin_lock_irqsave(&port->lock, flags);
> +	val = BIT(d->hwirq);
> +	writel_relaxed(val, pcie->slcr + AMD_MDB_TLP_IR_DISABLE_MISC);
> +	raw_spin_unlock_irqrestore(&port->lock, flags);
> +}
> +
> +static void amd_mdb_event_irq_unmask(struct irq_data *d)
> +{
> +	struct amd_mdb_pcie *pcie = irq_data_get_irq_chip_data(d);
> +	struct dw_pcie *pci = &pcie->pci;
> +	struct dw_pcie_rp *port = &pci->pp;
> +	unsigned long flags;
> +	u32 val;
> +
> +	raw_spin_lock_irqsave(&port->lock, flags);
> +	val = BIT(d->hwirq);
> +	writel_relaxed(val, pcie->slcr + AMD_MDB_TLP_IR_ENABLE_MISC);
> +	raw_spin_unlock_irqrestore(&port->lock, flags);
> +}
> +
> +static struct irq_chip amd_mdb_event_irq_chip = {
> +	.name		= "AMD MDB RC-Event",
> +	.irq_mask	= amd_mdb_event_irq_mask,
> +	.irq_unmask	= amd_mdb_event_irq_unmask,
> +};
> +
> +static int amd_mdb_pcie_event_map(struct irq_domain *domain,
> +				  unsigned int irq, irq_hw_number_t hwirq)
> +{
> +	irq_set_chip_and_handler(irq, &amd_mdb_event_irq_chip,
> +				 handle_level_irq);
> +	irq_set_chip_data(irq, domain->host_data);
> +	irq_set_status_flags(irq, IRQ_LEVEL);
> +
> +	return 0;
> +}
> +
> +static const struct irq_domain_ops event_domain_ops = {
> +	.map = amd_mdb_pcie_event_map,
> +};
> +
> +static irqreturn_t amd_mdb_pcie_event(int irq, void *args)
> +{
> +	struct amd_mdb_pcie *pcie = args;
> +	unsigned long val;
> +	int i;
> +
> +	val = readl_relaxed(pcie->slcr + AMD_MDB_TLP_IR_STATUS_MISC);
> +	val &= ~readl_relaxed(pcie->slcr + AMD_MDB_TLP_IR_MASK_MISC);
> +	for_each_set_bit(i, &val, 32)
> +		generic_handle_domain_irq(pcie->mdb_domain, i);
> +	writel_relaxed(val, pcie->slcr + AMD_MDB_TLP_IR_STATUS_MISC);
> +
> +	return IRQ_HANDLED;
> +}
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
> +static int amd_mdb_pcie_init_port(struct amd_mdb_pcie *pcie)
> +{
> +	unsigned long val;
> +
> +	/* Disable all TLP Interrupts */
> +	writel_relaxed(AMD_MDB_PCIE_IMR_ALL_MASK,
> +		       pcie->slcr + AMD_MDB_TLP_IR_DISABLE_MISC);
> +
> +	/* Clear pending TLP interrupts */
> +	val = readl_relaxed(pcie->slcr + AMD_MDB_TLP_IR_STATUS_MISC);
> +	val &= AMD_MDB_PCIE_IMR_ALL_MASK;
> +	writel_relaxed(val, pcie->slcr + AMD_MDB_TLP_IR_STATUS_MISC);
> +
> +	/* Enable all TLP Interrupts */
> +	writel_relaxed(AMD_MDB_PCIE_IMR_ALL_MASK,
> +		       pcie->slcr + AMD_MDB_TLP_IR_ENABLE_MISC);
> +
> +	return 0;
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
> +	int err;
> +
> +	pcie_intc_node = of_get_next_child(node, NULL);
> +	if (!pcie_intc_node) {
> +		dev_err(dev, "No PCIe Intc node found\n");
> +		return -ENODEV;
> +	}
> +
> +	pcie->mdb_domain = irq_domain_add_linear(pcie_intc_node, 32,
> +						 &event_domain_ops, pcie);
> +	if (!pcie->mdb_domain) {
> +		err = -ENOMEM;
> +		dev_err(dev, "Failed to add mdb_domain\n");
> +		goto out;
> +	}
> +
> +	irq_domain_update_bus_token(pcie->mdb_domain, DOMAIN_BUS_NEXUS);
> +
> +	pcie->intx_domain = irq_domain_add_linear(pcie_intc_node, PCI_NUM_INTX,
> +						  &amd_intx_domain_ops, pcie);
> +	if (!pcie->intx_domain) {
> +		err = -ENOMEM;
> +		dev_err(dev, "Failed to add intx_domain\n");
> +		goto mdb_out;
> +	}
> +
> +	of_node_put(pcie_intc_node);
> +	irq_domain_update_bus_token(pcie->intx_domain, DOMAIN_BUS_WIRED);
> +
> +	raw_spin_lock_init(&pp->lock);
> +
> +	return 0;
> +mdb_out:
> +	amd_mdb_pcie_free_irq_domains(pcie);
> +out:
> +	of_node_put(pcie_intc_node);
> +	return err;
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
> +	/*
> +	 * In future, error reporting will be hooked to the AER subsystem.
> +	 * Currently, the driver prints a warning message to the user.
> +	 */
> +	d = irq_domain_get_irq_data(pcie->mdb_domain, irq);
> +	if (intr_cause[d->hwirq].str)
> +		dev_warn(dev, "%s\n", intr_cause[d->hwirq].str);
> +	else
> +		dev_warn_once(dev, "Unknown IRQ %ld\n", d->hwirq);
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
> +	amd_mdb_pcie_init_port(pcie);
> +
> +	pp->irq = platform_get_irq(pdev, 0);
> +	if (pp->irq < 0)
> +		return pp->irq;
> +
> +	for (i = 0; i < ARRAY_SIZE(intr_cause); i++) {
> +		if (!intr_cause[i].str)
> +			continue;
> +
> +		irq = irq_create_mapping(pcie->mdb_domain, i);
> +		if (!irq) {
> +			dev_err(dev, "Failed to map mdb domain interrupt\n");
> +			return -ENOMEM;
> +		}
> +
> +		err = devm_request_irq(dev, irq, amd_mdb_pcie_intr_handler,
> +				       IRQF_NO_THREAD, intr_cause[i].sym, pcie);
> +		if (err) {
> +			dev_err(dev, "Failed to request IRQ %d\n", irq);
> +			return err;
> +		}
> +	}
> +
> +	pcie->intx_irq = irq_create_mapping(pcie->mdb_domain,
> +					    AMD_MDB_PCIE_INTR_INTX);
> +	if (!pcie->intx_irq) {
> +		dev_err(dev, "Failed to map INTx interrupt\n");
> +		return -ENXIO;
> +	}
> +
> +	err = devm_request_irq(dev, pcie->intx_irq, dw_pcie_rp_intx,
> +			       IRQF_NO_THREAD, NULL, pcie);
> +	if (err) {
> +		dev_err(dev, "Failed to request INTx IRQ %d\n", irq);
> +		return err;
> +	}
> +
> +	/* Plug the main event handler */
> +	err = devm_request_irq(dev, pp->irq, amd_mdb_pcie_event, IRQF_NO_THREAD,
> +			       "amd_mdb pcie_irq", pcie);
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
> +	},
> +	.probe = amd_mdb_pcie_probe,
> +};
> +builtin_platform_driver(amd_mdb_pcie_driver);
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்

