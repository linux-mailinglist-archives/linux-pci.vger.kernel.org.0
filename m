Return-Path: <linux-pci+bounces-24557-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D05E8A6E244
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 19:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E9A716BF65
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 18:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C38264A75;
	Mon, 24 Mar 2025 18:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jMSHIior"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08CE263F22;
	Mon, 24 Mar 2025 18:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742840909; cv=none; b=MswyazFQVEXyizX6PfPTg8FRZuHxlGyYT/H1EZ0sNp0yFMoecQEUDlSK3XtJNbd0Tq5tyx3q474P3skHl5DD0fZctV9TE6ghEy4K5R+cVRfHV9M2QCMszLtGJBlc+JNsV3rcI6N11Awb7mOevNi6AZXYHTt9zqp79gj/G1JN8lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742840909; c=relaxed/simple;
	bh=EWIOhq8a6WrbauOCbT88senxBdzZjHc5hedq099LcUM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=tKAAzptZMe0+fQDS/3f7SrGTng850nlB40uQYdmdaMjJnTnvF39OpQ73tBypkqKArQfKhTGjXhUqJMJ92mxSIyMpixudVfK8eYYi4swIVq6OfKxoHFqDz5dEJ+9H8P7eGeiarGM4rN8Hz/PCBrpK252WqLYtLDOZSZ/PPiXjWQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jMSHIior; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B447C4CEDD;
	Mon, 24 Mar 2025 18:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742840909;
	bh=EWIOhq8a6WrbauOCbT88senxBdzZjHc5hedq099LcUM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=jMSHIior9o47tI8oJHPN6ePxVwCZYJdCO/6fFs6AZByzpgiYy/9UX5RvfW6ih0Kql
	 7gLZPoaZU0njyioZ5rfgfyA9Qqa7CIGgf9MmANlX/ud45edRowOoDEyRqDPypwFnXV
	 Ne95va5kK2vmy4HBZ1UXFULxlV6pv8SJcKnbAkwyxTmehuJ3tc4af/Rd3nNeN+4YcL
	 PD7RbLiRjbxoAZEYqlpESyh6+i5QJUD6v7X/ieViJmSs/yj3jW+6GpNETCvQCOJtFi
	 wzHySGpGscT5I9gyPQX03ua+2JdbMHj2df1SRUCxBuEApbt/oheMREFl+dm+FCdC23
	 ZOYYX+YyJ2bfw==
Date: Mon, 24 Mar 2025 13:28:27 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Frank Li <Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Niklas Cassel <cassel@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v12 05/13] PCI: dwc: Add dw_pcie_parent_bus_offset()
Message-ID: <20250324182827.GA1257218@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <j3qw4zmopulpn3iqq5wsjt6dbs4z3micoeoxkw3354txkx22ml@67ip5sfo6wwd>

On Mon, Mar 24, 2025 at 10:48:23PM +0530, Manivannan Sadhasivam wrote:
> On Sat, Mar 15, 2025 at 03:15:40PM -0500, Bjorn Helgaas wrote:
> > From: Frank Li <Frank.Li@nxp.com>
> > 
> > Return the offset from CPU physical address to the parent bus address of
> > the specified element of the devicetree 'reg' property.

> > +resource_size_t dw_pcie_parent_bus_offset(struct dw_pcie *pci,
> > +					  const char *reg_name,
> > +					  resource_size_t cpu_phy_addr)
> > +{
> 
> s/cpu_phy_addr/cpu_phys_addr/g

Fixed, thanks!

> > +	struct device *dev = pci->dev;
> > +	struct device_node *np = dev->of_node;
> > +	int index;
> > +	u64 reg_addr;
> > +
> > +	/* Look up reg_name address on parent bus */
> 
> 'parent bus' is not accurate as the below code checks for the 'reg_name' in
> current PCI controller node.

We want the address of "reg_name" on the node's primary side.  We've
been calling that the "parent bus address", I guess because it's the
address on the "parent bus" of the node.

I'm not sure what the best term is for this.  Do you have a
suggestion?

If "parent bus address" is the wrong term, maybe we need to rename
dw_pcie_parent_bus_offset() itself?  

Currently we pass in cpu_phys_addr, but this function doesn't need it
except for the debug code added later.  I would really rather have
something like this in the callers:

  pci->parent_bus_offset = pp->cfg0_base -
      dw_pcie_parent_bus_addr(pci, "config");

because then the offset is computed sort of at the same level where
it's used, and a grep for "cfg0_base" would find both the set and the
use and they would be easy to match up.

> > +	index = of_property_match_string(np, "reg-names", reg_name);
> > +
> > +	if (index < 0) {
> > +		dev_err(dev, "No %s in devicetree \"reg\" property\n", reg_name);
> 
> Both of these callers are checking for the existence of the
> 'reg_name' property before calling this API. So this check seems to
> be redundant (for now).

True, but I don't see a way to enforce the caller checks.  I don't
like the idea of calling of_property_read_reg(np, index, ...) where we
have to look the caller to verify that "index" is valid.

Bjorn

