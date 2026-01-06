Return-Path: <linux-pci+bounces-44106-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 291C3CF8795
	for <lists+linux-pci@lfdr.de>; Tue, 06 Jan 2026 14:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 513993034939
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jan 2026 13:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5E330DEC0;
	Tue,  6 Jan 2026 13:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iWGCj8Vk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D614A33;
	Tue,  6 Jan 2026 13:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767705610; cv=none; b=KEnblpdNaZKwSXnJ2KZ2tTAZULQg1CJhg2yhqkR5L41SD4U6QHlay90cWMkSWYkUSgbNfC7mFGUwctOzlwOa6mDfqaXCy1N8PgbL55Qjun5p4BvJ+oC64waxRMYegO4qjsA5DFLHp4UKRCIVhmupzORJbp38WSgSdbfE+ce337U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767705610; c=relaxed/simple;
	bh=MuVRz0gF/Cpqd4cD8o89lE06Oy/dzT/jMTVa/IbLnfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H9nyqhmYUcsjWdi9Aq5dwneEIds7Tl+mpwKBDiQHx5m9CZ3oT5otYMeAja6B8knkWYUpFqGFxhqQXqqGEK4WkTMtAOjCQct3I2n5/Sw+FuyZqa+mE5NR57rRZiGeAeWR6GcIeBGsDalEYNtk4cfWAPMpUH7bkCdS4//xXnJy3iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iWGCj8Vk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5883AC116C6;
	Tue,  6 Jan 2026 13:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767705609;
	bh=MuVRz0gF/Cpqd4cD8o89lE06Oy/dzT/jMTVa/IbLnfI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iWGCj8Vkgf58gqzgwixHcGFzBvCcqx2QP8gKV6ksowmbkNibVrX3HexO75OzQf4Ff
	 YV0+hYEgvQt9/esvHxTFb85jvxJmjQ6doYerjsjacngDV5sX4T2U6dRdVXgztbErD7
	 6bn4JH5EHtkKRozGmcWSwgy5IO95pVY5h47hjYKyA/MK9Q1fOaGVo+7YBUNLbt3wyc
	 3gh97olD97OeTaQ/uZwSXJXBJ6mG1Qk2CE8Umh4wuU4sg8wtjPc5uK4GT4wyq3FwiA
	 sRZINwl74UqfjGamlZYyYCGiqKQTUwVpC5Na5ox53U08fWoZfXoToW/QIcQMDm+Azc
	 BGPs2enJFnvtQ==
Date: Tue, 6 Jan 2026 18:49:58 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: zhangsenchuan <zhangsenchuan@eswincomputing.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, bhelgaas@google.com, 
	krzk+dt@kernel.org, conor+dt@kernel.org, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, robh@kernel.org, p.zabel@pengutronix.de, jingoohan1@gmail.com, 
	gustavo.pimentel@synopsys.com, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, christian.bruel@foss.st.com, mayank.rana@oss.qualcomm.com, 
	shradha.t@samsung.com, krishna.chundru@oss.qualcomm.com, thippeswamy.havalige@amd.com, 
	inochiama@gmail.com, Frank.li@nxp.com, ningyu@eswincomputing.com, 
	linmin@eswincomputing.com, pinkesh.vaghela@einfochips.com, ouyanghui@eswincomputing.com, 
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v9 2/2] PCI: eic7700: Add Eswin PCIe host controller
 driver
Message-ID: <4f3rhkrlp3jypajh77rohqgpoujivpxq6g3o6vrt6u7u5j2atd@gd5o3vtlhapp>
References: <20260105223037.GA332950@bhelgaas>
 <3c8d6749.1f49.19b93552d97.Coremail.zhangsenchuan@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3c8d6749.1f49.19b93552d97.Coremail.zhangsenchuan@eswincomputing.com>

On Tue, Jan 06, 2026 at 08:43:11PM +0800, zhangsenchuan wrote:
> > Subject: Re: [PATCH v9 2/2] PCI: eic7700: Add Eswin PCIe host controller driver
> > 
> > [+cc Niklas, list vs array of ports]
> > 
> > On Mon, Dec 29, 2025 at 07:32:07PM +0800, zhangsenchuan@eswincomputing.com wrote:
> > > From: Senchuan Zhang <zhangsenchuan@eswincomputing.com>
> > > 
> > > Add driver for the Eswin EIC7700 PCIe host controller, which is based on
> > > the DesignWare PCIe core, IP revision 5.96a. The PCIe Gen.3 controller
> > > supports a data rate of 8 GT/s and 4 channels, support INTx and MSI
> > > interrupts.
> > 
> > > +config PCIE_EIC7700
> > > +	tristate "Eswin EIC7700 PCIe controller"
> > 
> > > +/* Vendor and device ID value */
> > > +#define PCI_VENDOR_ID_ESWIN		0x1fe1
> > > +#define PCI_DEVICE_ID_ESWIN		0x2030
> > 
> > Usually the device name is a little more than just the vendor.  What
> > if Eswin ever makes a second device?
> 
> Okey, thanks.
> Perhaps it's a problem. Maybe PCI_DEVICE_ID_EIC7700 is better?
> 
> > 
> > > +static int eic7700_pcie_parse_port(struct eic7700_pcie *pcie,
> > > +				   struct device_node *node)
> > > +{
> > > +	struct device *dev = pcie->pci.dev;
> > > +	struct eic7700_pcie_port *port;
> > > +
> > > +	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
> > > +	if (!port)
> > > +		return -ENOMEM;
> > > +
> > > +	port->perst = of_reset_control_get_exclusive(node, "perst");
> > > +	if (IS_ERR(port->perst)) {
> > > +		dev_err(dev, "Failed to get PERST# reset\n");
> > > +		return PTR_ERR(port->perst);
> > > +	}
> > > +
> > > +	/*
> > > +	 * TODO: Since the Root Port node is separated out by pcie devicetree,
> > > +	 * the DWC core initialization code can't parse the num-lanes attribute
> > > +	 * in the Root Port. Before entering the DWC core initialization code,
> > > +	 * the platform driver code parses the Root Port node. The EIC7700 only
> > > +	 * supports one Root Port node, and the num-lanes attribute is suitable
> > > +	 * for the case of one Root Port.
> > > +	 */
> > > +	if (!of_property_read_u32(node, "num-lanes", &port->num_lanes))
> > > +		pcie->pci.num_lanes = port->num_lanes;
> > > +
> > > +	INIT_LIST_HEAD(&port->list);
> > > +	list_add_tail(&port->list, &pcie->ports);
> > 
> > Niklas raised an interesting question about whether a list or an array
> > is the best data structure for the set of Root Ports:
> > 
> >   https://lore.kernel.org/r/aVvkmkd5mWPmxeiS@ryzen
> > 
> > Might have to iterate over the child nodes twice (once to count, again
> > for eic7700_pcie_parse_port()), but otherwise the array is probably
> > simpler code.
> 
> After reading patch's comments, lists and arrays seem to be good choices,
> I don't have any particularly good ideas for the time being. Anyway, this
> is a very good patch that supports multiple Root Ports resolutions.
> 

I still prefer using lists for the reasons mentioned in that thread.

> > 
> > > +	return 0;
> > > +}
> > > +
> > > +static int eic7700_pcie_parse_ports(struct eic7700_pcie *pcie)
> > > +{
> > > +	struct eic7700_pcie_port *port, *tmp;
> > > +	struct device *dev = pcie->pci.dev;
> > > +	int ret;
> > > +
> > > +	for_each_available_child_of_node_scoped(dev->of_node, of_port) {
> > > +		ret = eic7700_pcie_parse_port(pcie, of_port);
> > > +		if (ret)
> > > +			goto err_port;
> > > +	}
> > > +
> > > +	return 0;
> > > +
> > > +err_port:
> > > +	list_for_each_entry_safe(port, tmp, &pcie->ports, list)
> > > +		list_del(&port->list);
> > 
> > Is some kind of reset_control_put() needed to match the
> > of_reset_control_get_exclusive() above?
> 
> I only considered that there is currently only one Root Port. Maybe 
> there will be multiple Root Ports in the future.
> 
> Perhaps this is the best:
> list_for_each_entry_safe(port, tmp, &pcie->ports, list){
>         if (!IS_ERR_OR_NULL(port->perst))

You don't need this check since reset_control_put() does it for you.

>             reset_control_put(port->perst);
>         list_del(&port->list);
> }
> 
> > 
> > > +static struct platform_driver eic7700_pcie_driver = {
> > > +	.probe = eic7700_pcie_probe,
> > 
> > This driver is tristate but has no .remove() callback.  Seems like it
> > should have one?
> 
> In v2 patch, I referred to Mani's comments and removed the .remove()
> callback, as follows:
> "Since this controller implements irqchip using the DWC core driver,
> it is not safe to remove it during runtime."
> https://lore.kernel.org/linux-pci/jghozurjqyhmtunivotitgs67h6xo4sb46qcycnbbwyvjcm4ek@vgq75olazmoi/
> 
> In addition, remove .remove() callback, because this driver has been 
> modified to builtin_platform_driver and does not support HotPlug, 
> therefore, the .remove() callback is not needed. Do you have any
> better suggestions?
> 

Yes, builtin_platform_driver() wouldn't allow the users to remove the module. So
remove() callback will become useless. The reason why this driver is tristate is
that it could be loaded from rootfs and not always statically built to the
kernel image.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

