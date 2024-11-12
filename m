Return-Path: <linux-pci+bounces-16598-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C42489C6347
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 22:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 527BC1F23982
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 21:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B4E21A4A3;
	Tue, 12 Nov 2024 21:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EiP7BQL/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC8B215018;
	Tue, 12 Nov 2024 21:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731446457; cv=none; b=nhSahuZ6Vt3X5+vCY+7fVam7JukiTVHYI0r1nsl/MalWhoxVb5dru5vO/BNGjgOTdi+/l5xrL4hfF6y9vDfMJUL+YYqEdHhLflz4drgjfmNia/1VqTMETGidFe0SumDZmFXghOnh8FJyoiKdmIRp1Nt+Sfme6nlmhggzqv0R8a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731446457; c=relaxed/simple;
	bh=IFMZFZBhCUNYubCEPHGSu+s7QSSDpO5QvnNKF/M3GBk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=cgOeJFec+2xyoWhBcmWzo4319DBAyXYUq0XqohP28NHI6sx6wCDhWAe5YXfWXXy68yxaWTx5YSVYL8l9ejavqSXwZ25OEM0KvxobIyEHTOUDSajWOUdK9MSsnzMSChsIilydkncyFV6mLgH5s20t2gIooe7Dn8uqBpMqfjnEbjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EiP7BQL/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9F14C4CECD;
	Tue, 12 Nov 2024 21:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731446456;
	bh=IFMZFZBhCUNYubCEPHGSu+s7QSSDpO5QvnNKF/M3GBk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=EiP7BQL/7uLAyNeuD0fnQfqRAeBkMgGuHkg9XAN4B4CEMfAc2ZydJdiOQPGH1oZZf
	 pku+3Z/JMt/27JrCJL7jvZpy6e3QxaBo5HLBXdMbSg3v7UT41aBRGkYHMPTB8qaQGW
	 3ucBaaQYU+u5F0IzLn5kfy4eWJpIrJLLON/A9/OFLQNH7aG8rIaltjhIDcphYNF/zK
	 j3+/dIKSGClBSVdLEejcdedTcUu5fz4oHbliAgGYs80FuIpnbKJmvhNNaGSw9/4LQi
	 JJTrnWyTZL39Qe91uDyDMz7PPif+ks4J/vEu/ycuPSsv7TKlxLBWi8HboP3j7mMMxQ
	 s05gy9gBpCLqw==
Date: Tue, 12 Nov 2024 15:20:55 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Chen Wang <unicornxw@gmail.com>
Cc: kw@linux.com, u.kleine-koenig@baylibre.com, aou@eecs.berkeley.edu,
	arnd@arndb.de, bhelgaas@google.com, unicorn_wang@outlook.com,
	conor+dt@kernel.org, guoren@kernel.org, inochiama@outlook.com,
	krzk+dt@kernel.org, lee@kernel.org, lpieralisi@kernel.org,
	manivannan.sadhasivam@linaro.org, palmer@dabbelt.com,
	paul.walmsley@sifive.com, pbrobinson@gmail.com, robh@kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org,
	chao.wei@sophgo.com, xiaoguang.xing@sophgo.com,
	fengchun.li@sophgo.com
Subject: Re: [PATCH 2/5] PCI: sg2042: Add Sophgo SG2042 PCIe driver
Message-ID: <20241112212055.GA1859446@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5051f2375ff6218e7d44ce0c298efd5f9ee56964.1731303328.git.unicorn_wang@outlook.com>

On Mon, Nov 11, 2024 at 01:59:56PM +0800, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
> 
> Add support for PCIe controller in SG2042 SoC. The controller
> uses the Cadence PCIe core programmed by pcie-cadence*.c. The
> PCIe controller will work in host mode only.

> +++ b/drivers/pci/controller/cadence/Kconfig
> @@ -67,4 +67,15 @@ config PCI_J721E_EP
>  	  Say Y here if you want to support the TI J721E PCIe platform
>  	  controller in endpoint mode. TI J721E PCIe controller uses Cadence PCIe
>  	  core.
> +
> +config PCIE_SG2042
> +	bool "Sophgo SG2042 PCIe controller (host mode)"
> +	depends on ARCH_SOPHGO || COMPILE_TEST
> +	depends on OF
> +	select PCIE_CADENCE_HOST
> +	help
> +	  Say Y here if you want to support the Sophgo SG2042 PCIe platform
> +	  controller in host mode. Sophgo SG2042 PCIe controller uses Cadence
> +	  PCIe core.

Reorder to keep these menu items in alphabetical order by vendor.

> +++ b/drivers/pci/controller/cadence/pcie-sg2042.c

> + * SG2042 PCIe controller supports two ways to report MSI:
> + * - Method A, the PICe controller implements an MSI interrupt controller inside,
> + *   and connect to PLIC upward through one interrupt line. Provides
> + *   memory-mapped msi address, and by programming the upper 32 bits of the
> + *   address to zero, it can be compatible with old pcie devices that only
> + *   support 32-bit msi address.
> + * - Method B, the PICe controller connects to PLIC upward through an
> + *   independent MSI controller "sophgo,sg2042-msi" on the SOC. The MSI
> + *   controller provides multiple(up to 32) interrupt sources to PLIC.
> + *   Compared with the first method, the advantage is that the interrupt source
> + *   is expanded, but because for SG2042, the msi address provided by the MSI
> + *   controller is fixed and only supports 64-bit address(> 2^32), it is not
> + *   compatible with old pcie devices that only support 32-bit msi address.
> + * Method A & B can be configured in DTS with property "sophgo,internal-msi",
> + * default is Method B.

s/PICe/PCIe/ (multiple)
s/msi/MSI/ (multiple)
s/pcie/PCIe/ (multiple)

Wrap comment (and code below) to fit in 80 columns.  Add blank lines
between paragraphs.

> +#define SG2042_CDNS_PLAT_CPU_TO_BUS_ADDR	0xCFFFFFFFFF

Remove (see below).

> +static void sg2042_pcie_msi_irq_compose_msi_msg(struct irq_data *d,
> +						struct msi_msg *msg)
> +{
> +	struct sg2042_pcie *pcie = irq_data_get_irq_chip_data(d);
> +	struct device *dev = pcie->cdns_pcie->dev;
> +
> +	msg->address_lo = lower_32_bits(pcie->msi_phys) + BYTE_NUM_PER_MSI_VEC * d->hwirq;
> +	msg->address_hi = upper_32_bits(pcie->msi_phys);
> +	msg->data = 1;
> +
> +	pcie->num_applied_vecs = d->hwirq;

This looks questionable.  How do you know d->hwirq increases every
time this is called?

> +	dev_info(dev, "compose msi msg hwirq[%d] address_hi[%#x] address_lo[%#x]\n",
> +		 (int)d->hwirq, msg->address_hi, msg->address_lo);

This seems too verbose to be a dev_info().  Maybe a dev_dbg() or
remove it altogether.

> + * We use the usual two domain structure, the top one being a generic PCI/MSI
> + * domain, the bottom one being SG2042-specific and handling the actual HW
> + * interrupt allocation.
> + * At the same time, for internal MSI controller(Method A), bottom chip uses a
> + * chained handler to handle the controller's MSI IRQ edge triggered.

Add blank line between paragraphs.

> +static int sg2042_pcie_setup_msi_external(struct sg2042_pcie *pcie)
> +{
> +	struct device *dev = pcie->cdns_pcie->dev;
> +	struct device_node *np = dev->of_node;
> +	struct irq_domain *parent_domain;
> +	struct device_node *parent_np;
> +
> +	if (!of_find_property(np, "interrupt-parent", NULL)) {
> +		dev_err(dev, "Can't find interrupt-parent!\n");
> +		return -EINVAL;
> +	}
> +
> +	parent_np = of_irq_find_parent(np);
> +	if (!parent_np) {
> +		dev_err(dev, "Can't find node of interrupt-parent!\n");

Can you use some kind of %pOF format to include more information here?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/core-api/printk-formats.rst?id=v6.11#n463

> +		return -ENXIO;
> +	}
> +
> +	parent_domain = irq_find_host(parent_np);
> +	of_node_put(parent_np);
> +	if (!parent_domain) {
> +		dev_err(dev, "Can't find domain of interrupt-parent!\n");

And here?

> +		return -ENXIO;
> +	}
> +
> +	return sg2042_pcie_create_msi_domain(pcie, parent_domain);
> +}

> +static int sg2042_pcie_init_msi_data(struct sg2042_pcie *pcie)
> +{
> +	struct device *dev = pcie->cdns_pcie->dev;
> +	u32 value;
> +	int ret;
> +
> +	raw_spin_lock_init(&pcie->lock);
> +
> +	/*
> +	 * Though the PCIe controller can address >32-bit address space, to
> +	 * facilitate endpoints that support only 32-bit MSI target address,
> +	 * the mask is set to 32-bit to make sure that MSI target address is
> +	 * always a 32-bit address
> +	 */
> +	ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
> +	if (ret < 0)
> +		return ret;
> +
> +	pcie->msi_virt = dma_alloc_coherent(dev, BYTE_NUM_PER_MSI_VEC * MAX_MSI_IRQS,
> +					    &pcie->msi_phys, GFP_KERNEL);
> +	if (!pcie->msi_virt)
> +		return -ENOMEM;
> +
> +	/* Program the msi address and size */

s/msi/MSI/

> +	if (pcie->link_id == 1) {
> +		regmap_write(pcie->syscon, REG_LINK1_MSI_ADDR_LOW,
> +			     lower_32_bits(pcie->msi_phys));
> +		regmap_write(pcie->syscon, REG_LINK1_MSI_ADDR_HIGH,
> +			     upper_32_bits(pcie->msi_phys));
> +
> +		regmap_read(pcie->syscon, REG_LINK1_MSI_ADDR_SIZE, &value);
> +		value = (value & REG_LINK1_MSI_ADDR_SIZE_MASK) | MAX_MSI_IRQS;
> +		regmap_write(pcie->syscon, REG_LINK1_MSI_ADDR_SIZE, value);
> +	} else {
> +		regmap_write(pcie->syscon, REG_LINK0_MSI_ADDR_LOW,
> +			     lower_32_bits(pcie->msi_phys));
> +		regmap_write(pcie->syscon, REG_LINK0_MSI_ADDR_HIGH,
> +			     upper_32_bits(pcie->msi_phys));
> +
> +		regmap_read(pcie->syscon, REG_LINK0_MSI_ADDR_SIZE, &value);
> +		value = (value & REG_LINK0_MSI_ADDR_SIZE_MASK) | (MAX_MSI_IRQS << 16);
> +		regmap_write(pcie->syscon, REG_LINK0_MSI_ADDR_SIZE, value);
> +	}

Lot of pcie->link_id checking going on here.  Consider saving these
offsets in the struct sg2042_pcie so you don't need to test
everywhere.

> +	return 0;
> +}

> +static int sg2042_pcie_setup_msi(struct sg2042_pcie *pcie, struct platform_device *pdev)
> +{
> +	struct device *dev = pcie->cdns_pcie->dev;
> +	struct fwnode_handle *fwnode = of_node_to_fwnode(dev->of_node);
> +	struct irq_domain *parent_domain;
> +	int ret = 0;
> +
> +	parent_domain = irq_domain_create_linear(fwnode, MSI_DEF_NUM_VECTORS,
> +						 &sg2042_pcie_msi_domain_ops, pcie);
> +	if (!parent_domain) {
> +		dev_err(dev, "Failed to create IRQ domain\n");
> +		return -ENOMEM;
> +	}
> +	irq_domain_update_bus_token(parent_domain, DOMAIN_BUS_NEXUS);
> +
> +	ret = sg2042_pcie_create_msi_domain(pcie, parent_domain);
> +	if (ret) {
> +		irq_domain_remove(parent_domain);
> +		return ret;
> +	}
> +
> +	ret = sg2042_pcie_init_msi_data(pcie);
> +	if (ret) {
> +		dev_err(dev, "Failed to initialize msi data!\n");

s/msi/MSI/

> +		return ret;
> +	}
> +
> +	ret = platform_get_irq_byname(pdev, "msi");
> +	if (ret <= 0) {
> +		dev_err(dev, "failed to get MSI irq\n");
> +		return ret;
> +	}
> +	pcie->msi_irq = ret;
> +
> +	irq_set_chained_handler_and_data(pcie->msi_irq,
> +					 sg2042_pcie_msi_chained_isr, pcie);
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
> +static u64 sg2042_cdns_pcie_cpu_addr_fixup(struct cdns_pcie *pcie, u64 cpu_addr)
> +{
> +	return cpu_addr & SG2042_CDNS_PLAT_CPU_TO_BUS_ADDR;
> +}

Remove.  This translation between CPU and PCI bus addresses should be
described in the DT "ranges" property of the PCI host bridge.

See
https://lore.kernel.org/linux-pci/20241029-pci_fixup_addr-v7-3-8310dc24fb7c@nxp.com/
for a similar fix.

> +static const struct cdns_pcie_ops sg2042_cdns_pcie_ops = {
> +	.cpu_addr_fixup = sg2042_cdns_pcie_cpu_addr_fixup,
> +};
> +
> +/*
> + * SG2042 only support 4-byte aligned access, so for the rootbus (i.e. to read
> + * the PCIe controller itself, read32 is required. For non-rootbus (i.e. to read
> + * the PCIe peripheral registers, supports 1/2/4 byte aligned access, so
> + * directly use read should be fine.
> + * The same is true for write.

Add blank line between paragraphs or rewrap into a single paragraph.

> +static int sg2042_pcie_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	struct pci_host_bridge *bridge;
> +	struct device_node *np_syscon;
> +	struct cdns_pcie *cdns_pcie;
> +	struct sg2042_pcie *pcie;
> +	struct cdns_pcie_rc *rc;
> +	struct regmap *syscon;
> +	int ret;
> +
> +	if (!IS_ENABLED(CONFIG_PCIE_CADENCE_HOST))
> +		return -ENODEV;
> +
> +	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
> +	if (!pcie)
> +		return -ENOMEM;
> +
> +	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*rc));
> +	if (!bridge) {
> +		dev_err(dev, "Failed to alloc host bridge!\n");
> +		return -ENOMEM;
> +	}

Add blank line.

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
> +	}
> +	syscon = syscon_node_to_regmap(np_syscon);
> +	if (IS_ERR(syscon)) {
> +		dev_err(dev, "Failed to get regmap for syscon\n");
> +		return -ENOMEM;
> +	}
> +	pcie->syscon = syscon;
> +
> +	if (of_property_read_u32(np, "sophgo,link-id", &pcie->link_id)) {
> +		dev_err(dev, "Unable to parse link ID\n");
> +		return -EINVAL;
> +	}
> +
> +	pcie->internal_msi = 0;
> +	if (of_property_read_bool(np, "sophgo,internal-msi"))
> +		pcie->internal_msi = 1;
> +
> +	platform_set_drvdata(pdev, pcie);
> +
> +	pm_runtime_enable(dev);
> +
> +	ret = pm_runtime_get_sync(dev);
> +	if (ret < 0) {
> +		dev_err(dev, "pm_runtime_get_sync failed\n");
> +		goto err_get_sync;
> +	}
> +
> +	if (pcie->internal_msi) {
> +		ret = sg2042_pcie_setup_msi(pcie, pdev);
> +		if (ret < 0)
> +			goto err_setup_msi;
> +	} else {
> +		ret = sg2042_pcie_setup_msi_external(pcie);
> +		if (ret < 0)
> +			goto err_setup_msi;
> +	}
> +
> +	ret = cdns_pcie_init_phy(dev, cdns_pcie);
> +	if (ret) {
> +		dev_err(dev, "Failed to init phy!\n");
> +		goto err_setup_msi;
> +	}
> +
> +	ret = cdns_pcie_host_setup(rc);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to setup host!\n");
> +		goto err_host_setup;
> +	}
> +
> +	return 0;
> +
> +err_host_setup:
> +	cdns_pcie_disable_phy(cdns_pcie);
> +
> +err_setup_msi:
> +	sg2042_pcie_free_msi(pcie);
> +
> +err_get_sync:
> +	pm_runtime_put(dev);
> +	pm_runtime_disable(dev);
> +
> +	return ret;
> +}
> +
> +static void sg2042_pcie_shutdown(struct platform_device *pdev)
> +{
> +	struct sg2042_pcie *pcie = platform_get_drvdata(pdev);
> +	struct cdns_pcie *cdns_pcie = pcie->cdns_pcie;
> +	struct device *dev = &pdev->dev;
> +
> +	sg2042_pcie_free_msi(pcie);
> +
> +	cdns_pcie_disable_phy(cdns_pcie);
> +
> +	pm_runtime_put(dev);
> +	pm_runtime_disable(dev);
> +}
> +
> +static const struct of_device_id sg2042_pcie_of_match[] = {
> +	{ .compatible = "sophgo,sg2042-pcie-host" },
> +	{},
> +};
> +
> +static struct platform_driver sg2042_pcie_driver = {
> +	.driver = {
> +		.name		= "sg2042-pcie",
> +		.of_match_table	= sg2042_pcie_of_match,
> +		.pm		= &cdns_pcie_pm_ops,
> +	},
> +	.probe		= sg2042_pcie_probe,
> +	.shutdown	= sg2042_pcie_shutdown,
> +};
> +builtin_platform_driver(sg2042_pcie_driver);
> -- 
> 2.34.1
> 

