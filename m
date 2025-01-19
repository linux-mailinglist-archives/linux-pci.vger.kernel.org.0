Return-Path: <linux-pci+bounces-20114-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE9BA16199
	for <lists+linux-pci@lfdr.de>; Sun, 19 Jan 2025 13:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 943867A2124
	for <lists+linux-pci@lfdr.de>; Sun, 19 Jan 2025 12:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A09D1B041A;
	Sun, 19 Jan 2025 12:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CzVjT1la"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7E51DFD8
	for <linux-pci@vger.kernel.org>; Sun, 19 Jan 2025 12:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737289445; cv=none; b=bf+NTW58CgId6tounCwobop3EgFoSXI6wFfdpL6rW6i0Isi1k1GUWhzLX/U8Y1aTn6ybgfwk+uIzjDTAXviFNbqT7MX63Oz50GjPH7ixLRgyC/5JYdCQ9V5lJTYUncav+10VqOxBTjxlfgHoJCbroYRVcmGQm83JfNDBhWMWt1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737289445; c=relaxed/simple;
	bh=w13kqS+lBbIiBPGX8yjRSvHt+GUTvV8lmLkerMXfa0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u8B+nf57YJRRewO66Kvq2XLZlfis0idlurncNTZBkWiJhcb36ZwP2s1KhUfER2lgj4kt2XGBmgma12FhEkdIgy+KVfftxbpz9Wq8pmzncehI4v3Hqxlfm0n3jIwxNS6OK0ViuFM3/GyagvxafHjgxv/XUr6ljk4D/B7IwI3/aaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CzVjT1la; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2f42992f608so4994166a91.0
        for <linux-pci@vger.kernel.org>; Sun, 19 Jan 2025 04:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737289443; x=1737894243; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZZSuDJrfL4csxPwdTtRVca8OzgYxjKHdWPdCI/f9wuc=;
        b=CzVjT1la6HN9Go+ayPBfTxgtvK2SnX8gjj9xMp3HdqRVjCyRq45mVNSoxAHfVD71+g
         Wmn/yFl5eRZ6pQyJRYnncgZ2USm1h+4UcfeRaqO3T+VGsqwB1Nt+uQxBDDLLBHPbCQAF
         iiNNNuOwyhPKNdEzZAj30hWu6RDLBLUjLDWVqlrPo0J7qrCmKcTF0B2lksylaU5Hj6DZ
         E1Bqh95+9gM/vV4H5q3fUsNsPIJ12NiIIwFg7DUjF8B1Oadbgl9azpxY6e1VlTtt4U1C
         giUoRCJfOuZ0hIcKFVCbFCfAVrG/fq2EftHV7rK3HuzTQz4Kr1QE+OvNCizdJ0LFcuPa
         CWYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737289443; x=1737894243;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZZSuDJrfL4csxPwdTtRVca8OzgYxjKHdWPdCI/f9wuc=;
        b=mf3djobWE6fgvnZKXnLOYcEt4RQ2GhFNXqyb0U9Fpey2M2WmQcd+3az6CVMYh+oMsj
         uxW019YWbhuVD89iOVr7R4/80tOWk5fwgv/zxFMD7TC90tBfZ1KiNYa+40vx/u2VFis/
         ddqheoZrw7X3Yj2fX/WaBTBro/5gU6j/gDhvx1v4u6SmQ1djNWRQtmkLUIhFKW2itEe0
         gzXdL/LIpiwd0PbAhtR1O5JxNIlqNuA53V5JM8FVQhZuWcbRd4ZGbtQhwSC4qN5xAaZG
         lNXeB+wXifvmPHnE40bLemxXuEQuwpZ4fhbYpYlcafLeUNgw7SpyFaHKDda2p968AqJn
         3GTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlPkDMAgXjHz7kY4S57yxmWiDBFSfA/XhFmDLfZrIe3RWtkxGA31M9f4QaIu5wAa9FM1hWTPMMf1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcFamYhY8nXWY++PkYNsZSxBE0QRTKjhDKDJBSzWiEX4eewNDb
	3995SS6oi7donupDPhDjzZQg2uLYMSS93YGKQWvVbCxthUdfe9sW2EDF5PKeJw==
X-Gm-Gg: ASbGnctuKOGhUZKJec77q4FFV54kcXEQfIvgC36sDGlM3Dk2G2keZNZWBiyWSdc2MoG
	aPJ48h4csJxWEQ42tlW/fHpFGAnyslQjtVtFwb+6KsC90ZISOjrrPzRi8ZZPheTx0eFuGn1OCHQ
	RxwZowdnFI1uyRkH7rJuQOVxpow19WHaLsomHL20x0+PQdD4M0MYdc4/SVMcC2inhhlTyWzLFq+
	XPZtlUgF9W4aguv+4gVDGCEQb5m3/w6O2BZckhQewpFNE0eG4p4kAZa1BedDGIrTq6iEjxaXTne
	oCUBNw==
X-Google-Smtp-Source: AGHT+IFaNI/U2vzipJAr5YyNs2IN3u2D5+L74EF9nC37A9IjbU+RcZd6uAYCl4fwMzd8lJfalGvyUA==
X-Received: by 2002:a17:90b:534b:b0:2f6:f107:fae6 with SMTP id 98e67ed59e1d1-2f782d32397mr11435071a91.23.1737289443232;
        Sun, 19 Jan 2025 04:24:03 -0800 (PST)
Received: from thinkpad ([120.56.195.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f77619ed33sm5563566a91.23.2025.01.19.04.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2025 04:24:02 -0800 (PST)
Date: Sun, 19 Jan 2025 17:53:53 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Chen Wang <unicornxw@gmail.com>
Cc: kw@linux.com, u.kleine-koenig@baylibre.com, aou@eecs.berkeley.edu,
	arnd@arndb.de, bhelgaas@google.com, unicorn_wang@outlook.com,
	conor+dt@kernel.org, guoren@kernel.org, inochiama@outlook.com,
	krzk+dt@kernel.org, lee@kernel.org, lpieralisi@kernel.org,
	palmer@dabbelt.com, paul.walmsley@sifive.com, pbrobinson@gmail.com,
	robh@kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-riscv@lists.infradead.org, chao.wei@sophgo.com,
	xiaoguang.xing@sophgo.com, fengchun.li@sophgo.com,
	helgaas@kernel.org
Subject: Re: [PATCH v3 2/5] PCI: sg2042: Add Sophgo SG2042 PCIe driver
Message-ID: <20250119122353.v3tzitthmu5tu3dg@thinkpad>
References: <cover.1736923025.git.unicorn_wang@outlook.com>
 <ddedd8f76f83fea2c6d3887132d2fe6f2a6a02c1.1736923025.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ddedd8f76f83fea2c6d3887132d2fe6f2a6a02c1.1736923025.git.unicorn_wang@outlook.com>

On Wed, Jan 15, 2025 at 03:06:57PM +0800, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
> 
> Add support for PCIe controller in SG2042 SoC. The controller
> uses the Cadence PCIe core programmed by pcie-cadence*.c. The
> PCIe controller will work in host mode only.
> 

Please add more info about the IP. Like IP revision, PCIe Gen, lane count,
etc...

> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
> ---
>  drivers/pci/controller/cadence/Kconfig       |  13 +
>  drivers/pci/controller/cadence/Makefile      |   1 +
>  drivers/pci/controller/cadence/pcie-sg2042.c | 528 +++++++++++++++++++
>  3 files changed, 542 insertions(+)
>  create mode 100644 drivers/pci/controller/cadence/pcie-sg2042.c
> 
> diff --git a/drivers/pci/controller/cadence/Kconfig b/drivers/pci/controller/cadence/Kconfig
> index 8a0044bb3989..292eb2b20e9c 100644
> --- a/drivers/pci/controller/cadence/Kconfig
> +++ b/drivers/pci/controller/cadence/Kconfig
> @@ -42,6 +42,18 @@ config PCIE_CADENCE_PLAT_EP
>  	  endpoint mode. This PCIe controller may be embedded into many
>  	  different vendors SoCs.
>  
> +config PCIE_SG2042
> +	bool "Sophgo SG2042 PCIe controller (host mode)"
> +	depends on ARCH_SOPHGO || COMPILE_TEST
> +	depends on OF
> +	select IRQ_MSI_LIB
> +	select PCI_MSI
> +	select PCIE_CADENCE_HOST
> +	help
> +	  Say Y here if you want to support the Sophgo SG2042 PCIe platform
> +	  controller in host mode. Sophgo SG2042 PCIe controller uses Cadence
> +	  PCIe core.
> +
>  config PCI_J721E
>  	bool
>  
> @@ -67,4 +79,5 @@ config PCI_J721E_EP
>  	  Say Y here if you want to support the TI J721E PCIe platform
>  	  controller in endpoint mode. TI J721E PCIe controller uses Cadence PCIe
>  	  core.
> +

Spurious newline.

>  endmenu
> diff --git a/drivers/pci/controller/cadence/Makefile b/drivers/pci/controller/cadence/Makefile
> index 9bac5fb2f13d..4df4456d9539 100644
> --- a/drivers/pci/controller/cadence/Makefile
> +++ b/drivers/pci/controller/cadence/Makefile
> @@ -4,3 +4,4 @@ obj-$(CONFIG_PCIE_CADENCE_HOST) += pcie-cadence-host.o
>  obj-$(CONFIG_PCIE_CADENCE_EP) += pcie-cadence-ep.o
>  obj-$(CONFIG_PCIE_CADENCE_PLAT) += pcie-cadence-plat.o
>  obj-$(CONFIG_PCI_J721E) += pci-j721e.o
> +obj-$(CONFIG_PCIE_SG2042) += pcie-sg2042.o
> diff --git a/drivers/pci/controller/cadence/pcie-sg2042.c b/drivers/pci/controller/cadence/pcie-sg2042.c
> new file mode 100644
> index 000000000000..56797c2af755
> --- /dev/null
> +++ b/drivers/pci/controller/cadence/pcie-sg2042.c
> @@ -0,0 +1,528 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * pcie-sg2042 - PCIe controller driver for Sophgo SG2042 SoC
> + *
> + * Copyright (C) 2024 Sophgo Technology Inc.
> + * Copyright (C) 2024 Chen Wang <unicorn_wang@outlook.com>
> + */
> +
> +#include <linux/bits.h>
> +#include <linux/irq.h>
> +#include <linux/irqchip/chained_irq.h>
> +#include <linux/irqdomain.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/msi.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_pci.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
> +
> +#include "../../../irqchip/irq-msi-lib.h"
> +
> +#include "pcie-cadence.h"
> +
> +/*
> + * SG2042 PCIe controller supports two ways to report MSI:
> + *
> + * - Method A, the PCIe controller implements an MSI interrupt controller
> + *   inside, and connect to PLIC upward through one interrupt line.
> + *   Provides memory-mapped MSI address, and by programming the upper 32
> + *   bits of the address to zero, it can be compatible with old PCIe devices
> + *   that only support 32-bit MSI address.
> + *
> + * - Method B, the PCIe controller connects to PLIC upward through an
> + *   independent MSI controller "sophgo,sg2042-msi" on the SOC. The MSI
> + *   controller provides multiple(up to 32) interrupt sources to PLIC.
> + *   Compared with the first method, the advantage is that the interrupt
> + *   source is expanded, but because for SG2042, the MSI address provided by
> + *   the MSI controller is fixed and only supports 64-bit address(> 2^32),
> + *   it is not compatible with old PCIe devices that only support 32-bit MSI
> + *   address.
> + *
> + * Method A & B can be configured in DTS, default is Method B.

How to configure them? I can only see "sophgo,sg2042-msi" in the binding.

> + */
> +
> +#define MAX_MSI_IRQS		8
> +#define MAX_MSI_IRQS_PER_CTRL	1
> +#define MAX_MSI_CTRLS		(MAX_MSI_IRQS / MAX_MSI_IRQS_PER_CTRL)
> +#define MSI_DEF_NUM_VECTORS	MAX_MSI_IRQS
> +#define BYTE_NUM_PER_MSI_VEC	4
> +
> +#define REG_CLEAR		0x0804
> +#define REG_STATUS		0x0810
> +#define REG_LINK0_MSI_ADDR_SIZE	0x085C
> +#define REG_LINK1_MSI_ADDR_SIZE	0x080C
> +#define REG_LINK0_MSI_ADDR_LOW	0x0860
> +#define REG_LINK0_MSI_ADDR_HIGH	0x0864
> +#define REG_LINK1_MSI_ADDR_LOW	0x0868
> +#define REG_LINK1_MSI_ADDR_HIGH	0x086C
> +
> +#define REG_CLEAR_LINK0_BIT	2
> +#define REG_CLEAR_LINK1_BIT	3
> +#define REG_STATUS_LINK0_BIT	2
> +#define REG_STATUS_LINK1_BIT	3
> +
> +#define REG_LINK0_MSI_ADDR_SIZE_MASK	GENMASK(15, 0)
> +#define REG_LINK1_MSI_ADDR_SIZE_MASK	GENMASK(31, 16)
> +
> +struct sg2042_pcie {
> +	struct cdns_pcie	*cdns_pcie;
> +
> +	struct regmap		*syscon;
> +
> +	u32			link_id;
> +
> +	struct irq_domain	*msi_domain;
> +
> +	int			msi_irq;
> +
> +	dma_addr_t		msi_phys;
> +	void			*msi_virt;
> +
> +	u32			num_applied_vecs; /* used to speed up ISR */
> +

Get rid of the newline between struct members, please.

> +	raw_spinlock_t		msi_lock;
> +	DECLARE_BITMAP(msi_irq_in_use, MAX_MSI_IRQS);
> +};
> +

[...]

> +static int sg2042_pcie_setup_msi(struct sg2042_pcie *pcie,
> +				 struct device_node *msi_node)
> +{
> +	struct device *dev = pcie->cdns_pcie->dev;
> +	struct fwnode_handle *fwnode = of_node_to_fwnode(dev->of_node);
> +	struct irq_domain *parent_domain;
> +	int ret = 0;
> +
> +	if (!of_property_read_bool(msi_node, "msi-controller"))
> +		return -ENODEV;
> +
> +	ret = of_irq_get_byname(msi_node, "msi");
> +	if (ret <= 0) {
> +		dev_err(dev, "%pOF: failed to get MSI irq\n", msi_node);
> +		return ret;
> +	}
> +	pcie->msi_irq = ret;
> +
> +	irq_set_chained_handler_and_data(pcie->msi_irq,
> +					 sg2042_pcie_msi_chained_isr, pcie);
> +
> +	parent_domain = irq_domain_create_linear(fwnode, MSI_DEF_NUM_VECTORS,
> +						 &sg2042_pcie_msi_domain_ops, pcie);
> +	if (!parent_domain) {
> +		dev_err(dev, "%pfw: Failed to create IRQ domain\n", fwnode);
> +		return -ENOMEM;
> +	}
> +	irq_domain_update_bus_token(parent_domain, DOMAIN_BUS_NEXUS);
> +

The MSI controller is wired to PLIC isn't it? If so, why can't you use
hierarchial MSI domain implementation as like other controller drivers?

> +	parent_domain->flags |= IRQ_DOMAIN_FLAG_MSI_PARENT;
> +	parent_domain->msi_parent_ops = &sg2042_pcie_msi_parent_ops;
> +
> +	pcie->msi_domain = parent_domain;
> +
> +	ret = sg2042_pcie_init_msi_data(pcie);
> +	if (ret) {
> +		dev_err(dev, "Failed to initialize MSI data!\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void sg2042_pcie_free_msi(struct sg2042_pcie *pcie)
> +{
> +	struct device *dev = pcie->cdns_pcie->dev;
> +
> +	if (pcie->msi_irq)
> +		irq_set_chained_handler_and_data(pcie->msi_irq, NULL, NULL);
> +
> +	if (pcie->msi_virt)
> +		dma_free_coherent(dev, BYTE_NUM_PER_MSI_VEC * MAX_MSI_IRQS,
> +				  pcie->msi_virt, pcie->msi_phys);
> +}
> +
> +/*
> + * SG2042 only support 4-byte aligned access, so for the rootbus (i.e. to read
> + * the Root Port itself, read32 is required. For non-rootbus (i.e. to read
> + * the PCIe peripheral registers, supports 1/2/4 byte aligned access, so
> + * directly using read should be fine.
> + *
> + * The same is true for write.
> + */
> +static int sg2042_pcie_config_read(struct pci_bus *bus, unsigned int devfn,
> +				   int where, int size, u32 *value)
> +{
> +	if (pci_is_root_bus(bus))
> +		return pci_generic_config_read32(bus, devfn, where, size,
> +						 value);
> +
> +	return pci_generic_config_read(bus, devfn, where, size, value);
> +}
> +
> +static int sg2042_pcie_config_write(struct pci_bus *bus, unsigned int devfn,
> +				    int where, int size, u32 value)
> +{
> +	if (pci_is_root_bus(bus))
> +		return pci_generic_config_write32(bus, devfn, where, size,
> +						  value);
> +
> +	return pci_generic_config_write(bus, devfn, where, size, value);
> +}
> +
> +static struct pci_ops sg2042_pcie_host_ops = {
> +	.map_bus	= cdns_pci_map_bus,
> +	.read		= sg2042_pcie_config_read,
> +	.write		= sg2042_pcie_config_write,
> +};
> +
> +/* Dummy ops which will be assigned to cdns_pcie.ops, which must be !NULL. */

Because cadence code driver doesn't check for !ops? Please fix it instead. And
the fix is trivial.

> +static const struct cdns_pcie_ops sg2042_cdns_pcie_ops = {};
> +
> +static int sg2042_pcie_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	struct pci_host_bridge *bridge;
> +	struct device_node *np_syscon;
> +	struct device_node *msi_node;
> +	struct cdns_pcie *cdns_pcie;
> +	struct sg2042_pcie *pcie;
> +	struct cdns_pcie_rc *rc;
> +	struct regmap *syscon;
> +	int ret;
> +
> +	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
> +	if (!pcie)
> +		return -ENOMEM;
> +
> +	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*rc));
> +	if (!bridge) {
> +		dev_err(dev, "Failed to alloc host bridge!\n");

Use dev_err_probe() throughout the probe function.

> +		return -ENOMEM;
> +	}
> +
> +	bridge->ops = &sg2042_pcie_host_ops;
> +
> +	rc = pci_host_bridge_priv(bridge);
> +	cdns_pcie = &rc->pcie;
> +	cdns_pcie->dev = dev;
> +	cdns_pcie->ops = &sg2042_cdns_pcie_ops;
> +	pcie->cdns_pcie = cdns_pcie;
> +
> +	np_syscon = of_parse_phandle(np, "sophgo,syscon-pcie-ctrl", 0);
> +	if (!np_syscon) {
> +		dev_err(dev, "Failed to get syscon node\n");
> +		return -ENOMEM;

-ENODEV

> +	}
> +	syscon = syscon_node_to_regmap(np_syscon);

You should drop the np reference count once you are done with it.

> +	if (IS_ERR(syscon)) {
> +		dev_err(dev, "Failed to get regmap for syscon\n");
> +		return -ENOMEM;

PTR_ERR(syscon)

> +	}
> +	pcie->syscon = syscon;
> +
> +	if (of_property_read_u32(np, "sophgo,link-id", &pcie->link_id)) {
> +		dev_err(dev, "Unable to parse sophgo,link-id\n");

"Unable to parse \"sophgo,link-id\"\n"

> +		return -EINVAL;
> +	}
> +
> +	platform_set_drvdata(pdev, pcie);
> +
> +	pm_runtime_enable(dev);
> +
> +	ret = pm_runtime_get_sync(dev);

Use pm_runtime_resume_and_get().

> +	if (ret < 0) {
> +		dev_err(dev, "pm_runtime_get_sync failed\n");
> +		goto err_get_sync;
> +	}
> +
> +	msi_node = of_parse_phandle(dev->of_node, "msi-parent", 0);
> +	if (!msi_node) {
> +		dev_err(dev, "Failed to get msi-parent!\n");
> +		return -1;

-ENODATA

> +	}
> +
> +	if (of_device_is_compatible(msi_node, "sophgo,sg2042-pcie-msi")) {
> +		ret = sg2042_pcie_setup_msi(pcie, msi_node);

Same as above. np leak here.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

