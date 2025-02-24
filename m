Return-Path: <linux-pci+bounces-22180-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9326DA41939
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 10:34:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFE133A28A0
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 09:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154EA1C8620;
	Mon, 24 Feb 2025 09:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YMdCxeed"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C4A1FF7D8
	for <linux-pci@vger.kernel.org>; Mon, 24 Feb 2025 09:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740389433; cv=none; b=b6R5ZN5F1P40DDNAygNgUYJKDAPk2P94cca1hULe5DN5wKwd8sGfhFzdv0e0AHbfSahW0A4UNpKnos4WaT6KXH20u9ZGwpsf2XDBmBK9G1FRP1xQFGvUBMmzI048rjtAo+riCcRrvB2oX16LCUkbwE9C7ZPDPxyOipwEjiXflSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740389433; c=relaxed/simple;
	bh=RkmdnKSjkVRb0/gJqeWied9iqH51QdUxUlxtE01kQAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sPPm1rocFRfi9ekXChKV9eXS/LB9j99zVCTBATozeP/VfMc1BkouXQLGPHGIxieU+rUaegd596JOv6zwcf7K6zGz+wR2d591ugVNqd+TE+u2dwdUgse3i72u7wBG/havhDRlSsrUjsekPFIy8MJayusdaU8CSUl1TlLkplXiWrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YMdCxeed; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2fbfe16cc39so8349041a91.3
        for <linux-pci@vger.kernel.org>; Mon, 24 Feb 2025 01:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740389430; x=1740994230; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=B8933hcHHMfIdzCWt+4/Qg0KBD9H6ZcSHRKwPgYW79Q=;
        b=YMdCxeedUhb7lGTKUt+PZxz/bYQ7pTDRw4pbcDzlKjUyWZdvuEAH6wCKKRHTi0k7wx
         BBxJUFrnFNH6ftiwM+Jo+i+O4ROz6L8ETuW/6ksW+2SNP5qXa9ddmZMOdUpRFip4QvhM
         Yi2U5uJJGlZ1qOa2+eJE36LQqPMPtqLDNqv6MM5RMPFKtONRgOoNIIsx48aZZqQe3je0
         rr9jK56yxVyDXvHhspEqe+qTL9kqeqTmGoy4SIC556u4SwkApW44OUXUjIOUdOf2mnai
         nG5R+xt/VpDq7fornID6Eqaaszt250woUcdVubI4ZrLGZnrOfx6tAw6dUj6NgPwe4XXP
         k0Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740389430; x=1740994230;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B8933hcHHMfIdzCWt+4/Qg0KBD9H6ZcSHRKwPgYW79Q=;
        b=KQd8f8rfoBVIuKdmXCYkr4UNLk8VzdogEIbicwQxCg6bvQBLr/BstHChj6xuOm2Qh0
         9US2XFTC6aBVMiHVNvug/Vw0BqbAAVuUFqCglDOCUTQlLLM0QVhwRlnbTc0SZbW6czYS
         nuYj0zPGVuwvhRGwlC1rMN7scnsNRnnmSelVWaabiyh0AEGiV1a5Gyd0Zq43x1H5IUWb
         RUM1UI31iezNEjc7aLiAEdkc2krCg3A/F83NlPq44pcPvTVhrrQocqYzBg8bL9JJCcXC
         mfINlsoK+8ukqJm4HdI6URz5JfH3XshbNl8l929hVlYlItVfpO+iSb+Xy/C3++xaqxVg
         4UKw==
X-Forwarded-Encrypted: i=1; AJvYcCUnZRFQlsnkTjqiMC1A0rz9ePFpacd7Bw68b/gTZGhBSZOR7lTxCQwmCe3WmQjkPyZG3zXxQIO2skY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQdX6DL4ifvdRlZMeDFzOng8aGB73lecu/hlAblGsdkBCDr46q
	VPDsNjjjJusa9kVh3CKD8uTr8+TAI+JW0iTEgycWUF2xvxRKs6tyMWh/GUmcww==
X-Gm-Gg: ASbGncuZBQj7KEF542e66qI9m5i+sZJhQ+liK8h2EBNxl7GsxvVPLEhXONuPdcQpn1W
	tJ0G/fYajmWuN2IkBQO5ienHQoXVno4fXQ9qyYtCn92Cul4XiqqyYfRXSC3ToDsenTLA/sFNHuh
	GVOveA56Y1s5QalYns1vd3xq2QtQsEypP8+KqgfFDMv0EMmCJYGLtwrrFrkiS22JloWCVA129gr
	/hdogh0a8gvGRjFAmSJAv/F7ygszXv05I9UPzd95Y0dSEyni+i1Zq13U7aPzWFEM4B0GkNj+pOO
	tCJDQyood0QYedXBTmU4IY/bjpL3L6TDnjTi
X-Google-Smtp-Source: AGHT+IGbgd9yKaBYnhgfI4LpzNeuJQFZiqib7+iUQ9WKXNJrULeE0eGeCY+y8Gzg8cG4uyD5TIYTSg==
X-Received: by 2002:a17:90b:4b86:b0:2ee:ab29:1482 with SMTP id 98e67ed59e1d1-2fce86cef44mr23228868a91.16.1740389430017;
        Mon, 24 Feb 2025 01:30:30 -0800 (PST)
Received: from thinkpad ([36.255.17.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d55866f9sm173836835ad.230.2025.02.24.01.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 01:30:29 -0800 (PST)
Date: Mon, 24 Feb 2025 15:00:24 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, michal.simek@amd.com,
	bharat.kumar.gogada@amd.com, jingoohan1@gmail.com
Subject: Re: [PATCH v14 3/3] PCI: amd-mdb: Add AMD MDB Root Port driver
Message-ID: <20250224093024.q4vx2lygrc2swu3h@thinkpad>
References: <20250224073117.767210-1-thippeswamy.havalige@amd.com>
 <20250224073117.767210-4-thippeswamy.havalige@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250224073117.767210-4-thippeswamy.havalige@amd.com>

On Mon, Feb 24, 2025 at 01:01:17PM +0530, Thippeswamy Havalige wrote:
> Add support for AMD MDB (Multimedia DMA Bridge) IP core as Root Port.
> 
> The Versal2 devices include MDB Module. The integrated block for MDB along
> with the integrated bridge can function as PCIe Root Port controller at
> Gen5 32-Gb/s operation per lane.

Please use GT/s

> 
> Bridge supports error and legacy interrupts and are handled using platform
> specific interrupt line in Versal2.
> 
> Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes:
> | https://lore.kernel.org/oe-kbuild-all/202502191741.xrVmEAG4-lkp@intel.
> | com/

These tags are irrelevant.

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
> ---
>  drivers/pci/controller/dwc/Kconfig        |  11 +
>  drivers/pci/controller/dwc/Makefile       |   1 +
>  drivers/pci/controller/dwc/pcie-amd-mdb.c | 481 ++++++++++++++++++++++
>  3 files changed, 493 insertions(+)
>  create mode 100644 drivers/pci/controller/dwc/pcie-amd-mdb.c
> 
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index b6d6778b0698..882f4b558133 100644
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
> +	  DesignWare IP and therefore the driver re-uses the Designware core
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
> index 000000000000..01d27cb5a70d
> --- /dev/null
> +++ b/drivers/pci/controller/dwc/pcie-amd-mdb.c
> @@ -0,0 +1,481 @@
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

How does these values correspond to the AMD_MDB_TLP_PCIE_INTX_MASK? These values
could be: 0, 2, 4, and 6 corresponding to: 0b01010101? Looks wierd.

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
> +static inline u32 pcie_read(struct amd_mdb_pcie *pcie, u32 reg)
> +{
> +	return readl_relaxed(pcie->slcr + reg);
> +}

I think I already commented on these helpers. Please get rid of them. I don't
see any value in this new driver. Moreover, 'inline' keywords are not required.

> +
> +static inline void pcie_write(struct amd_mdb_pcie *pcie,
> +			      u32 val, u32 reg)
> +{
> +	writel_relaxed(val, pcie->slcr + reg);
> +}
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
> +	pcie_write(pcie, val, AMD_MDB_TLP_IR_DISABLE_MISC);
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
> +	 * Writing '1' to a bit in AMD_MDB_TLP_IR_ENABLE_MISC enables that interrupt.
> +	 * Writing '0' has no effect.
> +	 */
> +	pcie_write(pcie, val, AMD_MDB_TLP_IR_ENABLE_MISC);
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
> +static irqreturn_t dw_pcie_rp_intx_flow(int irq, void *args)

What does the _flow suffix mean?

> +{
> +	struct amd_mdb_pcie *pcie = args;
> +	unsigned long val;
> +	int i, int_status;
> +
> +	val = pcie_read(pcie, AMD_MDB_TLP_IR_STATUS_MISC);

You don't need port->lock here?

> +	int_status = FIELD_GET(AMD_MDB_TLP_PCIE_INTX_MASK, val);

You don't need to ack/clear the IRQ?

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
> +	u32 val;
> +
> +	raw_spin_lock(&port->lock);
> +	val = pcie_read(pcie, AMD_MDB_TLP_IR_STATUS_MISC);

This register is accessed in the IRQ handler also. So don't you need
raw_spin_lock_irq{save/restore}? 

> +	val &= ~BIT(d->hwirq);
> +	pcie_write(pcie, val, AMD_MDB_TLP_IR_STATUS_MISC);
> +	raw_spin_unlock(&port->lock);
> +}
> +
> +static void amd_mdb_event_irq_unmask(struct irq_data *d)
> +{
> +	struct amd_mdb_pcie *pcie = irq_data_get_irq_chip_data(d);
> +	struct dw_pcie *pci = &pcie->pci;
> +	struct dw_pcie_rp *port = &pci->pp;
> +	u32 val;
> +
> +	raw_spin_lock(&port->lock);

Same here

> +	val = pcie_read(pcie, AMD_MDB_TLP_IR_STATUS_MISC);
> +	val |= BIT(d->hwirq);
> +	pcie_write(pcie, val, AMD_MDB_TLP_IR_STATUS_MISC);
> +	raw_spin_unlock(&port->lock);
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
> +static irqreturn_t amd_mdb_pcie_event_flow(int irq, void *args)
> +{
> +	struct amd_mdb_pcie *pcie = args;
> +	unsigned long val;
> +	int i;
> +
> +	val = pcie_read(pcie, AMD_MDB_TLP_IR_STATUS_MISC);

Here also, no lock?

> +	val &= ~pcie_read(pcie, AMD_MDB_TLP_IR_MASK_MISC);
> +	for_each_set_bit(i, &val, 32)
> +		generic_handle_domain_irq(pcie->mdb_domain, i);
> +	pcie_write(pcie, val, AMD_MDB_TLP_IR_STATUS_MISC);
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
> +	/* Disable all TLP Interrupts */
> +	pcie_write(pcie, AMD_MDB_PCIE_IMR_ALL_MASK,
> +		   AMD_MDB_TLP_IR_DISABLE_MISC);
> +
> +	/* Clear pending TLP interrupts */
> +	pcie_write(pcie, pcie_read(pcie, AMD_MDB_TLP_IR_STATUS_MISC) &
> +		   AMD_MDB_PCIE_IMR_ALL_MASK,
> +		   AMD_MDB_TLP_IR_STATUS_MISC);
> +
> +	/* Enable all TLP Interrupts */
> +	pcie_write(pcie,  AMD_MDB_PCIE_IMR_ALL_MASK,
> +		   AMD_MDB_TLP_IR_ENABLE_MISC);
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
> +
> +	/* Setup INTx */

This comment is quite misleading. This Intc node is not specific to INTx as far
as I can see.

> +	pcie_intc_node = of_get_next_child(node, NULL);
> +	if (!pcie_intc_node) {
> +		dev_err(dev, "No PCIe Intc node found\n");
> +		return -ENODATA;

-ENODEV

> +	}
> +
> +	pcie->mdb_domain = irq_domain_add_linear(pcie_intc_node, 32,
> +						 &event_domain_ops, pcie);
> +	if (!pcie->mdb_domain) {
> +		dev_err(dev, "Failed to add mdb_domain\n");
> +		goto out;
> +	}
> +
> +	irq_domain_update_bus_token(pcie->mdb_domain, DOMAIN_BUS_NEXUS);
> +
> +	pcie->intx_domain = irq_domain_add_linear(pcie_intc_node, PCI_NUM_INTX,
> +						  &amd_intx_domain_ops, pcie);
> +	if (!pcie->intx_domain) {
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
> +
> +	return -ENOMEM;

No please. This is just asking for trouble. Please pass the relevant errno.

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
> +		irq = irq_create_mapping(pcie->mdb_domain, i);
> +		if (!irq) {
> +			dev_err(dev, "Failed to map mdb domain interrupt\n");
> +			return -ENOMEM;
> +		}
> +		err = devm_request_irq(dev, irq, amd_mdb_pcie_intr_handler,
> +				       IRQF_SHARED | IRQF_NO_THREAD,
> +				       intr_cause[i].sym, pcie);

Aren't these IRQs just part of a single IRQ? I'm wondering why do you need to
represent them individually instead of having a single IRQ handler.

Btw, you are not disposing these IRQs anywhere. Especially in error paths.

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
> +	err = devm_request_irq(dev, pcie->intx_irq,
> +			       dw_pcie_rp_intx_flow,
> +			       IRQF_SHARED | IRQF_NO_THREAD, NULL, pcie);
> +	if (err) {
> +		dev_err(dev, "Failed to request INTx IRQ %d\n", irq);
> +		return err;
> +	}
> +
> +	/* Plug the main event handler */
> +	err = devm_request_irq(dev, pp->irq, amd_mdb_pcie_event_flow,
> +			       IRQF_SHARED | IRQF_NO_THREAD, "amd_mdb pcie_irq",

Why is this a SHARED IRQ?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

