Return-Path: <linux-pci+bounces-16141-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 418CB9BF0CC
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 15:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C72391F2167F
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 14:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95252036E5;
	Wed,  6 Nov 2024 14:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QWM3DzDB"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B180C202620;
	Wed,  6 Nov 2024 14:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730904840; cv=none; b=Zsldk1aIMCgMViqk8n9RXjSgBLsLtXp4cVTh22fu38nBpYeKuIZkyU2Y2uTpQLa1X1jhaZQLBOuxHdK1YrBgfOTZnJTYfwh5hl5RDnJPg7k+MH5UbeVpz8+65aS+tqLhpmFCPx1PSN/gpNs450H925wzbO3IO2DfCYWtAd2s25k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730904840; c=relaxed/simple;
	bh=zYe5NkW/hxPpF8TUsu1Nvg27u9i54/19PVn4G/0LMUA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PEnSsnfklN0GR7nMml8oBuOmf8PskNGbasn3IPwhnV7XzqKn34hXPYL60fwmzb8d+ljH4xPXorqISk0u6yQ4uTr1aI53I963eTyBwMbo46+ndATqt1QMvJYUmWXYtiWMPYSBgWi9x0rFai78AgU1TZ7Oij5dDAbeug6qMIdzDzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QWM3DzDB; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CC0B824000A;
	Wed,  6 Nov 2024 14:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730904836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=knAYkoTuftyB6SKb9FMRTQyX6kLDlPlZevUIKrFm4vQ=;
	b=QWM3DzDBC8cttduL3mSWj1EcxRYDkRfdfZWGELdtup94zcvzDKWpfoLQZeSNn/m79nIPCI
	OLe6IHRh4yUViVOWK6PEXP2o/o/FGAFoX6v1vc7rNMvEUJ8AikLMmGFIfA8SsD0TwGP0c+
	F2R0ZJFHWrGzbNRZ2h6R6mG34B3cdxlv/J/fG4fcPoJXIfskYPDp6oW+ZvJnm2NsjSRskx
	UyW9ruV0jl5pzfcBek/slq2az5MwdtERojUoC6O8+9tPoqhH0vqDDVEIY8qtAKj4aiuUEu
	mj9vmAFVIT5sswfvymQK4DrgUWZIoI+EqZPpSRlaVzuu7Cl0vWvnzwsHPC688g==
Date: Wed, 6 Nov 2024 15:53:53 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Rob Herring <robh@kernel.org>, Saravana Kannan
 <saravanak@google.com>, Bjorn Helgaas <bhelgaas@google.com>, Lizhi Hou
 <lizhi.hou@amd.com>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-pci@vger.kernel.org, Allan Nielsen
 <allan.nielsen@microchip.com>, Horatiu Vultur
 <horatiu.vultur@microchip.com>, Steen Hegelund
 <steen.hegelund@microchip.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 6/6] PCI: of: Create device-tree root bus node
Message-ID: <20241106155353.4ffd3825@bootlin.com>
In-Reply-To: <20241105185901.GA1479626@bhelgaas>
References: <20241104172001.165640-7-herve.codina@bootlin.com>
	<20241105185901.GA1479626@bhelgaas>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

On Tue, 5 Nov 2024 12:59:01 -0600
Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Mon, Nov 04, 2024 at 06:20:00PM +0100, Herve Codina wrote:
> > PCI devices device-tree nodes can be already created. This was
> > introduced by commit 407d1a51921e ("PCI: Create device tree node for
> > bridge").  
> 
> I guess 407d1a51921e creates device tree nodes for bridges, including
> Root Ports, which are enumerated as PCI-to-PCI bridges, right?

It creates DT nodes for bridges and devices.

> 
> > In order to have device-tree nodes related to PCI devices attached on
> > their PCI root bus, a root bus device-tree node is needed. This root bus
> > node will be used as the parent node of the first level devices scanned
> > on the bus.
> >
> > On non device-tree based system (such as ACPI), a device-tree node for
> > the PCI root bus does not exist.  ...  
> 
> I'm wondering if "root bus" is the right description for this patch
> and whether "PCI host bridge" might be more accurate.  The bus itself
> doesn't really have a physical counterpart other than being the
> secondary side of a PCI host bridge where the primary side is some
> kind of CPU bus.

Indeed, you're right. I will rename "root bus" to "host bridge" everywhere
in the patch (description but also the code itself).

> 
> An ACPI namespace doesn't include a "root bus" object, but it *does*
> include a PCI host bridge (PNP0A03) object, which is where any address
> translation between the CPU bus and the PCI hierarchy is described.
> 
> I suspect this patch is adding a DT node that corresponds to the
> PNP0A03 host bridge object, and the "ranges" property of the new node
> will describe the mapping from the CPU address space to the PCI
> address space.

Exactly.

> 
> > Indeed, this component is not described
> > in a device-tree used at boot.  
> 
> But maybe I'm on the wrong track, because obviously PCI host
> controllers *are* described in DTs used at boot.

They are described in a device-tree used at boot on device-tree based
systems.
On x86, we are on ACPI based system -> No DT used at boot -> PCI host
controller not described in DT.

I could replace with "Indeed, this component is not described in a
device-tree used at boot because, in that case, device-tree is not
used to describe the hardware"

> 
> > The device-tree PCI root bus node creation needs to be done at runtime.
> > This is done in the same way as for the creation of the PCI device
> > nodes. I.e. node and properties are created based on computed
> > information done by the PCI core.  
> 
> See address translation question below.
> 
> > +void of_pci_make_root_bus_node(struct pci_bus *bus)
> > +{
> > +	struct device_node *np = NULL;
> > +	struct of_changeset *cset;
> > +	const char *name;
> > +	int ret;
> > +
> > +	/*
> > +	 * If there is already a device tree node linked to this device,
> > +	 * return immediately.
> > +	 */
> > +	if (pci_bus_to_OF_node(bus))
> > +		return;
> > +
> > +	/* Check if there is a DT root node to attach this created node */
> > +	if (!of_root) {
> > +		pr_err("of_root node is NULL, cannot create PCI root bus node");
> > +		return;
> > +	}
> > +
> > +	name = kasprintf(GFP_KERNEL, "pci-root@%x,%x", pci_domain_nr(bus),
> > +			 bus->number);  
> 
> Should this be "pci%d@%x,%x" to match the typical descriptions of PCI
> host bridges in DT?

What do you think I should use for the %d you proposed.
Also I supposed your "@%x,%x" is still pci_domain_nr(bus), bus->number.

> 
> > +static int of_pci_root_bus_prop_ranges(struct pci_bus *bus,
> > +				       struct of_changeset *ocs,
> > +				       struct device_node *np)
> > +{
> > +	struct pci_host_bridge *bridge = to_pci_host_bridge(bus->bridge);
> > +	struct resource_entry *window;
> > +	unsigned int ranges_sz = 0;
> > +	unsigned int n_range = 0;
> > +	struct resource *res;
> > +	int n_addr_cells;
> > +	u32 *ranges;
> > +	u64 val64;
> > +	u32 flags;
> > +	int ret;
> > +
> > +	n_addr_cells = of_n_addr_cells(np);
> > +	if (n_addr_cells <= 0 || n_addr_cells > 2)
> > +		return -EINVAL;
> > +
> > +	resource_list_for_each_entry(window, &bridge->windows) {
> > +		res = window->res;
> > +		if (!of_pci_is_range_resource(res, &flags))
> > +			continue;
> > +		n_range++;
> > +	}
> > +
> > +	if (!n_range)
> > +		return 0;
> > +
> > +	ranges = kcalloc(n_range,
> > +			 (OF_PCI_ADDRESS_CELLS + OF_PCI_SIZE_CELLS +
> > +			  n_addr_cells) * sizeof(*ranges),
> > +			 GFP_KERNEL);
> > +	if (!ranges)
> > +		return -ENOMEM;
> > +
> > +	resource_list_for_each_entry(window, &bridge->windows) {
> > +		res = window->res;
> > +		if (!of_pci_is_range_resource(res, &flags))
> > +			continue;
> > +
> > +		/* PCI bus address */
> > +		val64 = res->start;
> > +		of_pci_set_address(NULL, &ranges[ranges_sz], val64, 0, flags, false);
> > +		ranges_sz += OF_PCI_ADDRESS_CELLS;
> > +
> > +		/* Host bus address */
> > +		if (n_addr_cells == 2)
> > +			ranges[ranges_sz++] = upper_32_bits(val64);
> > +		ranges[ranges_sz++] = lower_32_bits(val64);  
> 
> IIUC this sets both the parent address (the host bus (CPU) physical
> address) and the child address (PCI bus address) to the same value.
> 
> I think that's wrong because these addresses need not be identical.
> 
> I think the parent address should be the res->start value, and the
> child address should be "res->start - window->offset", similar to
> what's done by pcibios_resource_to_bus().

I see.
I will update in the next iteration.

Thanks for your feedback.
Best regards,
Hervé

