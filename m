Return-Path: <linux-pci+bounces-44056-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E47DCF5D57
	for <lists+linux-pci@lfdr.de>; Mon, 05 Jan 2026 23:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B357E30635C7
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jan 2026 22:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37132749DC;
	Mon,  5 Jan 2026 22:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UtQ84Tiu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D574C97;
	Mon,  5 Jan 2026 22:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767652239; cv=none; b=JBCvSotMhK50lFoyt3AqWGcgy8acxFaJ3quq4FsBcvzNaip3iHoiMK5EX8mS0uoGklUUghDe6+yWGFLVgAMHGrBT+I+q3rqDZpX3v2G9ePDOsnul7yjJa1qd9LZbN+Bb0118pOErTgGPJmGAHh8gWIi5yqAbiNI8KJT19fswMaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767652239; c=relaxed/simple;
	bh=UiWW5sKnV3TdKVabajZ8wVODXvkW80JQ/vWj0AzrVtU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=h1uyocSITAZ48z4gow2QPAegtbiIXzpoCOXTc2K+haliDUAuiYj0IOtJOiWt6A8WkXhJcC6ahUVDSe9/j50puDF9NIrHS0N1u7NOhvXM7xoKi/wQ8ZueWLH5LZUfG0ttnfU0yLpbA4038H9BVj7WI0z72oZE9XC4q/7e5Kdc654=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UtQ84Tiu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03EAFC116D0;
	Mon,  5 Jan 2026 22:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767652239;
	bh=UiWW5sKnV3TdKVabajZ8wVODXvkW80JQ/vWj0AzrVtU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=UtQ84TiuL3m7YnmRSmex2w2DbpG3mjB/aBs6Ej7Zp0vIA/qDPaG4+OUZ3G7aV67SS
	 0gYVe08uI7/cjdqi9Vg1d3TwPZ9mOtjUPnx2BMjnd4xpUKGy4vY0Pc2Kk3qW4ouj6/
	 feQreUNMuolrw6yTrdnu96j0iR0Z1IzB8GiOQFGMc4SakBR8zDF+OfYiIgX4T/Whd4
	 e9/UTYIT6LWXHrXHh3ru4ipKfudlH49yKN2ahl7OLbu3abZo/u/7AE7CP/PAAFx8pN
	 Hxz/2GfN4fSKB6FMojrgL4Y1QGgKOTllAsaUZNQE/E4K5oIbq34Cyv9vk9lnJhu4Gc
	 VSb0MSpNxNC4w==
Date: Mon, 5 Jan 2026 16:30:37 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: zhangsenchuan@eswincomputing.com
Cc: bhelgaas@google.com, mani@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
	robh@kernel.org, p.zabel@pengutronix.de, jingoohan1@gmail.com,
	gustavo.pimentel@synopsys.com, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	christian.bruel@foss.st.com, mayank.rana@oss.qualcomm.com,
	shradha.t@samsung.com, krishna.chundru@oss.qualcomm.com,
	thippeswamy.havalige@amd.com, inochiama@gmail.com, Frank.li@nxp.com,
	ningyu@eswincomputing.com, linmin@eswincomputing.com,
	pinkesh.vaghela@einfochips.com, ouyanghui@eswincomputing.com,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v9 2/2] PCI: eic7700: Add Eswin PCIe host controller
 driver
Message-ID: <20260105223037.GA332950@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251229113208.1893-1-zhangsenchuan@eswincomputing.com>

[+cc Niklas, list vs array of ports]

On Mon, Dec 29, 2025 at 07:32:07PM +0800, zhangsenchuan@eswincomputing.com wrote:
> From: Senchuan Zhang <zhangsenchuan@eswincomputing.com>
> 
> Add driver for the Eswin EIC7700 PCIe host controller, which is based on
> the DesignWare PCIe core, IP revision 5.96a. The PCIe Gen.3 controller
> supports a data rate of 8 GT/s and 4 channels, support INTx and MSI
> interrupts.

> +config PCIE_EIC7700
> +	tristate "Eswin EIC7700 PCIe controller"

> +/* Vendor and device ID value */
> +#define PCI_VENDOR_ID_ESWIN		0x1fe1
> +#define PCI_DEVICE_ID_ESWIN		0x2030

Usually the device name is a little more than just the vendor.  What
if Eswin ever makes a second device?

> +static int eic7700_pcie_parse_port(struct eic7700_pcie *pcie,
> +				   struct device_node *node)
> +{
> +	struct device *dev = pcie->pci.dev;
> +	struct eic7700_pcie_port *port;
> +
> +	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
> +	if (!port)
> +		return -ENOMEM;
> +
> +	port->perst = of_reset_control_get_exclusive(node, "perst");
> +	if (IS_ERR(port->perst)) {
> +		dev_err(dev, "Failed to get PERST# reset\n");
> +		return PTR_ERR(port->perst);
> +	}
> +
> +	/*
> +	 * TODO: Since the Root Port node is separated out by pcie devicetree,
> +	 * the DWC core initialization code can't parse the num-lanes attribute
> +	 * in the Root Port. Before entering the DWC core initialization code,
> +	 * the platform driver code parses the Root Port node. The EIC7700 only
> +	 * supports one Root Port node, and the num-lanes attribute is suitable
> +	 * for the case of one Root Port.
> +	 */
> +	if (!of_property_read_u32(node, "num-lanes", &port->num_lanes))
> +		pcie->pci.num_lanes = port->num_lanes;
> +
> +	INIT_LIST_HEAD(&port->list);
> +	list_add_tail(&port->list, &pcie->ports);

Niklas raised an interesting question about whether a list or an array
is the best data structure for the set of Root Ports:

  https://lore.kernel.org/r/aVvkmkd5mWPmxeiS@ryzen

Might have to iterate over the child nodes twice (once to count, again
for eic7700_pcie_parse_port()), but otherwise the array is probably
simpler code.

> +	return 0;
> +}
> +
> +static int eic7700_pcie_parse_ports(struct eic7700_pcie *pcie)
> +{
> +	struct eic7700_pcie_port *port, *tmp;
> +	struct device *dev = pcie->pci.dev;
> +	int ret;
> +
> +	for_each_available_child_of_node_scoped(dev->of_node, of_port) {
> +		ret = eic7700_pcie_parse_port(pcie, of_port);
> +		if (ret)
> +			goto err_port;
> +	}
> +
> +	return 0;
> +
> +err_port:
> +	list_for_each_entry_safe(port, tmp, &pcie->ports, list)
> +		list_del(&port->list);

Is some kind of reset_control_put() needed to match the
of_reset_control_get_exclusive() above?

> +static struct platform_driver eic7700_pcie_driver = {
> +	.probe = eic7700_pcie_probe,

This driver is tristate but has no .remove() callback.  Seems like it
should have one?

> +	.driver = {
> +		.name = "eic7700-pcie",
> +		.of_match_table = eic7700_pcie_of_match,
> +		.suppress_bind_attrs = true,
> +		.pm = &eic7700_pcie_pm,
> +		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
> +	},
> +};
> +builtin_platform_driver(eic7700_pcie_driver);

