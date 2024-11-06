Return-Path: <linux-pci+bounces-16147-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3505C9BF242
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 16:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA522B24979
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 15:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3051F20263F;
	Wed,  6 Nov 2024 15:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GsfRr5t5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051F420127C;
	Wed,  6 Nov 2024 15:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730908472; cv=none; b=QLirVAm/kQ2li5zq5v7PJzuMI+a9bHSHVw6JZsIV7JkjoZueWoF3B5DFhtLr8wbCqbTOaEAiimaICzwcqn5hFO1lOHNiMqO5DeAwL1li+fBPFj9XMwitLAE3SuXCeHGUuIY98s0o+PoKQSqV5gHihwVYvP7nwM/vcWJzlzIfUz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730908472; c=relaxed/simple;
	bh=/VTEQ9Za6HeRpRr9+XL5flTkFy/OC7HtpkCHpJLKrkI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ISUlleLCM1EI4nW07D0xSZjUbzjJUCz7gZgFXBVe/OYkEgNOO1LssiIOiTReM9CMSYQvqBKblcQ67ZruU+/PSZrRQGDScgW3jeMoaZf1BuWGSFzac/vuondjj6WpRG1q/+IAGXEPu+afYloHC/Bn/wB6ihbKfmWKHGl2hDWmao0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GsfRr5t5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D7E4C4CEC6;
	Wed,  6 Nov 2024 15:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730908471;
	bh=/VTEQ9Za6HeRpRr9+XL5flTkFy/OC7HtpkCHpJLKrkI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=GsfRr5t558mOF4TTNvArdlCHOHvIhFqZbNNOhL7pUqvvv4QKxfDTMa/17oEK6yb4y
	 HvdNcVJeG3ZQSlc+4q5sD1qiyNC9EVY7eq0RBHO98Zq11swYMhlnXA8jKf1nU+iQ9E
	 hy44uu+uyzS69USMwf7MElAuEQieKQ/YpWDbPtTJ2G1L9a0ci8OPyCbtPQb35TeLYT
	 QtaQQ/Kuzy+dlK35ZuPvp9weIZE3Cg/MJ0Rf4e+Lb2bhOEeLGWdGM+zcQScWMbexIG
	 ydHBXP2OgjvpNmTHQ8VHX8kUR/fgRkdPGmLAXdysisolcstvIXwh5kmlHeh4CCMH1b
	 O7UmoLp30KGCQ==
Date: Wed, 6 Nov 2024 09:54:30 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Pavan Kondeti <quic_pkondeti@quicinc.com>
Cc: Will Deacon <will@kernel.org>, Vidya Sagar <vidyas@nvidia.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Manikanta Maddireddy <mmaddireddy@nvidia.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>,
	Krishna Thota <kthota@nvidia.com>, Joerg Roedel <joro@8bytes.org>
Subject: Re: [Query] ACS enablement in the DT based boot flow
Message-ID: <20241106155430.GA1526421@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f320e311-89ba-4a92-a231-1298ecc94c0b@quicinc.com>

On Wed, Nov 06, 2024 at 11:43:30AM +0530, Pavan Kondeti wrote:
> On Thu, Jul 18, 2024 at 03:43:18PM +0530, Pavan Kondeti wrote:
> > > > The pci_request_acs() in of_iommu_configure(), which happens too late
> > > > to affect pci_enable_acs(), was added by 6bf6c24720d3 ("iommu/of:
> > > > Request ACS from the PCI core when configuring IOMMU linkage"), so I
> > > > cc'd Will and Joerg.  I don't know if that *used* to work and got
> > > > broken somehow, or if it never worked as intended.
> > > 
> > > I don't have any way to test this, but I'm supportive of having the same
> > > flow for DT and ACPI-based flows. Vidya, are you able to cook a patch?
> > > 
> > 
> > I ran into a similar observation while testing a PCI device assignment
> > to a VM. In my configuration, the virtio-iommu is enumerated over the
> > PCI transport. So, I am thinking we can't hook pci_request_acs() to an
> > IOMMU driver. Does the below patch makes sense?
> > 
> > The patch is tested with a VM and I could see ACS getting enabled and
> > separate IOMMU groups are created for the devices attached under
> > PCIe root port(s).
> > 
> > The RC/devices with ACS quirks are not suffering from this problem as we 
> > short circuit ACS capability detection checking in
> > pci_acs_enabled()->pci_dev_specific_acs_enabled() . May be this is one
> > of the reason why this was not reported/observed by some platforms with
> > DT.
> > 
> > diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> > index b908fe1ae951..0eeb7abfbcfa 100644
> > --- a/drivers/pci/of.c
> > +++ b/drivers/pci/of.c
> > @@ -123,6 +123,13 @@ bool pci_host_of_has_msi_map(struct device *dev)
> >  	return false;
> >  }
> >  
> > +bool pci_host_of_has_iommu_map(struct device *dev)
> > +{
> > +	if (dev && dev->of_node)
> > +		return of_get_property(dev->of_node, "iommu-map", NULL);
> > +	return false;
> > +}
> > +
> >  static inline int __of_pci_pci_compare(struct device_node *node,
> >  				       unsigned int data)
> >  {
> > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > index 4c367f13acdc..ea6fcdaf63e2 100644
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -889,6 +889,7 @@ static void pci_set_bus_msi_domain(struct pci_bus *bus)
> >  	dev_set_msi_domain(&bus->dev, d);
> >  }
> >  
> > +bool pci_host_of_has_iommu(struct device *dev);
> >  static int pci_register_host_bridge(struct pci_host_bridge *bridge)
> >  {
> >  	struct device *parent = bridge->dev.parent;
> > @@ -951,6 +952,9 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
> >  	    !pci_host_of_has_msi_map(parent))
> >  		bus->bus_flags |= PCI_BUS_FLAGS_NO_MSI;
> >  
> > +	if (pci_host_of_has_iommu_map(parent))
> > +		pci_request_acs();
> > +
> >  	if (!parent)
> >  		set_dev_node(bus->bridge, pcibus_to_node(bus));
> >  
> 
> I see that this problem is reproducible with the kernel tip. While preparing
> patch submission, I found there was an attempt to fix [1] this problem
> earlier but later reverted due to issues reported on linux-next. I did
> not see any follow up on the issues. I would like to resend this patch
> again as it was acked by people.

Please send the patch to the list with the appropriate commit log and
signed-off-by; see
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=v6.11

Be sure to cc anybody who reported previous issues.  It will also help
if you can explain why any issues that were previously reported are no
longer a problem.

> [1]
> https://lore.kernel.org/all/1621566204-37456-1-git-send-email-wangxingang5@huawei.com/

