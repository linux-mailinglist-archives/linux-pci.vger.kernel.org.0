Return-Path: <linux-pci+bounces-16070-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 203B69BD585
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 19:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 794BDB20E56
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 18:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A061E907E;
	Tue,  5 Nov 2024 18:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jr0bXlD+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759E61E47B6;
	Tue,  5 Nov 2024 18:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730833143; cv=none; b=XjLPeEo2Oy904wH3xi75uOaqYIr2AMWBQVNhKtgtRCBX7aNjcCKYlKUklurRWOw3GugMV75jVs444waM1UoeUunpeaAVH82zVOsBX7Rx85AOrCFusYuvDRJhhWySwdLKhh9qdka7DKTthylByPKnaua7gy8baZcVTWFQnkDtcwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730833143; c=relaxed/simple;
	bh=3zdgXCPPKSD1xfYxWDmC/EUuKY/QlMHd4XNXizG5HRI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=H+GEmQzBgPyDsthBbfvLbG8NHALqstYKQyQr8x9P7SGgY5dWOhiZIrHG/5aF7xYwKQu1A20YRf077Zyt+9irbvkxMoXxEtMrJObxwtKb0xeMepNuIBwg/Tn+5CeYhhNJlFZQDi49LP0KIqKL6YR41as0sNsiPtjwqc0WrWrEMM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jr0bXlD+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23D7DC4CED3;
	Tue,  5 Nov 2024 18:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730833143;
	bh=3zdgXCPPKSD1xfYxWDmC/EUuKY/QlMHd4XNXizG5HRI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=jr0bXlD+Y7HkfD1pk02WZCFcYoAvd8GiC4vkRusK24T0PRzsD9KtF4hLRr5dZO9IS
	 bZ/PrWY8eNQO8dhzBPBmrX7B2+720xztPGp0PAN2fcSeGaeoJ4cmFse9ffXMcQyuQT
	 LUyC9h64eAWM1D4/uuhY5lhIK4WmDegV9FCVjBhZ+FBZxZEcffibZWdudJqwO7wYIE
	 fLcqtO4IUQNZhsQXQRX9US6uT7ZRxD7LVQEdjtpipSJFLtchuwTMojzr7UFWhHoQ/y
	 M2ESLiYty9uLngtbi49nBOXsywBwIYGtepxOoGuG7rQEbubfbKELjJEaC5elt1CHIO
	 NlTFRHAzxjVkw==
Date: Tue, 5 Nov 2024 12:59:01 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Lizhi Hou <lizhi.hou@amd.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 6/6] PCI: of: Create device-tree root bus node
Message-ID: <20241105185901.GA1479626@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104172001.165640-7-herve.codina@bootlin.com>

On Mon, Nov 04, 2024 at 06:20:00PM +0100, Herve Codina wrote:
> PCI devices device-tree nodes can be already created. This was
> introduced by commit 407d1a51921e ("PCI: Create device tree node for
> bridge").

I guess 407d1a51921e creates device tree nodes for bridges, including
Root Ports, which are enumerated as PCI-to-PCI bridges, right?

> In order to have device-tree nodes related to PCI devices attached on
> their PCI root bus, a root bus device-tree node is needed. This root bus
> node will be used as the parent node of the first level devices scanned
> on the bus.
>
> On non device-tree based system (such as ACPI), a device-tree node for
> the PCI root bus does not exist.  ...

I'm wondering if "root bus" is the right description for this patch
and whether "PCI host bridge" might be more accurate.  The bus itself
doesn't really have a physical counterpart other than being the
secondary side of a PCI host bridge where the primary side is some
kind of CPU bus.

An ACPI namespace doesn't include a "root bus" object, but it *does*
include a PCI host bridge (PNP0A03) object, which is where any address
translation between the CPU bus and the PCI hierarchy is described.

I suspect this patch is adding a DT node that corresponds to the
PNP0A03 host bridge object, and the "ranges" property of the new node
will describe the mapping from the CPU address space to the PCI
address space.

> Indeed, this component is not described
> in a device-tree used at boot.

But maybe I'm on the wrong track, because obviously PCI host
controllers *are* described in DTs used at boot.

> The device-tree PCI root bus node creation needs to be done at runtime.
> This is done in the same way as for the creation of the PCI device
> nodes. I.e. node and properties are created based on computed
> information done by the PCI core.

See address translation question below.

> +void of_pci_make_root_bus_node(struct pci_bus *bus)
> +{
> +	struct device_node *np = NULL;
> +	struct of_changeset *cset;
> +	const char *name;
> +	int ret;
> +
> +	/*
> +	 * If there is already a device tree node linked to this device,
> +	 * return immediately.
> +	 */
> +	if (pci_bus_to_OF_node(bus))
> +		return;
> +
> +	/* Check if there is a DT root node to attach this created node */
> +	if (!of_root) {
> +		pr_err("of_root node is NULL, cannot create PCI root bus node");
> +		return;
> +	}
> +
> +	name = kasprintf(GFP_KERNEL, "pci-root@%x,%x", pci_domain_nr(bus),
> +			 bus->number);

Should this be "pci%d@%x,%x" to match the typical descriptions of PCI
host bridges in DT?

> +static int of_pci_root_bus_prop_ranges(struct pci_bus *bus,
> +				       struct of_changeset *ocs,
> +				       struct device_node *np)
> +{
> +	struct pci_host_bridge *bridge = to_pci_host_bridge(bus->bridge);
> +	struct resource_entry *window;
> +	unsigned int ranges_sz = 0;
> +	unsigned int n_range = 0;
> +	struct resource *res;
> +	int n_addr_cells;
> +	u32 *ranges;
> +	u64 val64;
> +	u32 flags;
> +	int ret;
> +
> +	n_addr_cells = of_n_addr_cells(np);
> +	if (n_addr_cells <= 0 || n_addr_cells > 2)
> +		return -EINVAL;
> +
> +	resource_list_for_each_entry(window, &bridge->windows) {
> +		res = window->res;
> +		if (!of_pci_is_range_resource(res, &flags))
> +			continue;
> +		n_range++;
> +	}
> +
> +	if (!n_range)
> +		return 0;
> +
> +	ranges = kcalloc(n_range,
> +			 (OF_PCI_ADDRESS_CELLS + OF_PCI_SIZE_CELLS +
> +			  n_addr_cells) * sizeof(*ranges),
> +			 GFP_KERNEL);
> +	if (!ranges)
> +		return -ENOMEM;
> +
> +	resource_list_for_each_entry(window, &bridge->windows) {
> +		res = window->res;
> +		if (!of_pci_is_range_resource(res, &flags))
> +			continue;
> +
> +		/* PCI bus address */
> +		val64 = res->start;
> +		of_pci_set_address(NULL, &ranges[ranges_sz], val64, 0, flags, false);
> +		ranges_sz += OF_PCI_ADDRESS_CELLS;
> +
> +		/* Host bus address */
> +		if (n_addr_cells == 2)
> +			ranges[ranges_sz++] = upper_32_bits(val64);
> +		ranges[ranges_sz++] = lower_32_bits(val64);

IIUC this sets both the parent address (the host bus (CPU) physical
address) and the child address (PCI bus address) to the same value.

I think that's wrong because these addresses need not be identical.

I think the parent address should be the res->start value, and the
child address should be "res->start - window->offset", similar to
what's done by pcibios_resource_to_bus().

> +		/* Size */
> +		val64 = resource_size(res);
> +		ranges[ranges_sz] = upper_32_bits(val64);
> +		ranges[ranges_sz + 1] = lower_32_bits(val64);
> +		ranges_sz += OF_PCI_SIZE_CELLS;
> +	}
> +
> +	ret = of_changeset_add_prop_u32_array(ocs, np, "ranges", ranges, ranges_sz);
> +	kfree(ranges);
> +	return ret;
> +}

