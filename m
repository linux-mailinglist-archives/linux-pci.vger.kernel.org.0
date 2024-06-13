Return-Path: <linux-pci+bounces-8765-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3F2907E8A
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 00:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8F20285AE4
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 22:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B831913A24E;
	Thu, 13 Jun 2024 22:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="clS1/oGT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8065F1369A1;
	Thu, 13 Jun 2024 22:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718316323; cv=none; b=ggMuIRgR6WhgJ0MM3juyFXxn83mq7kpmLAsrVV9Ic3N5d7eOPZlevxS8Sx5RfAMxLfbcl/PnIISNCDX3QTKv6JYlIvElMracDn6oa9eEUMzqdNki61nT2C0O15df5IyuYGim/xpCiX4opLMTGI5llMKpdWM3eRwvm51UNTX8JWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718316323; c=relaxed/simple;
	bh=4XwUUFpXGjUMAlT5fEHcgWb/wldy2nUCCkGTirUQTUA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Mi3xxDaXnj8J6cKjOA8orNdKPvzN33khyjezUiiaKzOCr+2OAL7hSwVv1DplQ+uwTmB6Kn4XZ1zzUkCJVCSd7T2EkbosZd/hrAlFqaU73FaJMGPDKrF2QZgJdm3uquV9S/OmKVLP+N8AShqnFIuo+8ItBZTcLHdAVP/AAS5xFhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=clS1/oGT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5928C2BBFC;
	Thu, 13 Jun 2024 22:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718316323;
	bh=4XwUUFpXGjUMAlT5fEHcgWb/wldy2nUCCkGTirUQTUA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=clS1/oGTP4ddRf1o/Oq/j4zXTYm1nEWAPRkpycGle57SvjaO0Md9s/NIj4BFCSBaA
	 dxjoSTMhKXu+ZhTKH6vZJod6uzsQpiCd7GcqFF/STbvvqUWmxve80NGQqr/nXlVI/I
	 in/1yxq+9lkLQAI0tpsTVeyM1BELiyBJ6ZXKCHG/34Qrvlnz8Tutj4AWJ2MEnt7zwY
	 ugg6wvkMZkVghv0d5Q/vABmYLWg8/iuf9QoS35GSpgxS19XpjFAL3ae8zVMGl0wpU8
	 8c2PAnFBv3BEe3bD/o4UXKChco6YWA7uqYE77aZutTBdw8pY+swpJ6xjKmkSqLC7Sb
	 A6AaF/hNo9rwQ==
Date: Thu, 13 Jun 2024 17:05:20 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Vidya Sagar <vidyas@nvidia.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	Gal Shalom <galshalom@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Thierry Reding <treding@nvidia.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Masoud Moshref Javadi <mmoshrefjava@nvidia.com>,
	Shahaf Shuler <shahafs@nvidia.com>,
	Vikram Sethi <vsethi@nvidia.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>,
	Jiandi An <jan@nvidia.com>, Tushar Dave <tdave@nvidia.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Krishna Thota <kthota@nvidia.com>,
	Manikanta Maddireddy <mmaddireddy@nvidia.com>,
	"sagar.tv@gmail.com" <sagar.tv@gmail.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH V3] PCI: Extend ACS configurability
Message-ID: <20240613220520.GA1085981@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612232301.GB19897@nvidia.com>

On Wed, Jun 12, 2024 at 08:23:01PM -0300, Jason Gunthorpe wrote:
> On Wed, Jun 12, 2024 at 04:29:03PM -0500, Bjorn Helgaas wrote:
> > [+cc Alex since VFIO entered the conversation; thread at
> > https://lore.kernel.org/r/20240523063528.199908-1-vidyas@nvidia.com]
> > 
> > On Mon, Jun 10, 2024 at 08:38:49AM -0300, Jason Gunthorpe wrote:
> > > On Fri, Jun 07, 2024 at 02:30:55PM -0500, Bjorn Helgaas wrote:
> > > > "Correctly" is not quite the right word here; it's just a fact that
> > > > the ACS settings determined at boot time result in certain IOMMU
> > > > groups.  If the user desires different groups, it's not that something
> > > > is "incorrect"; it's just that the user may have to accept less
> > > > isolation to get the desired IOMMU groups.
> > > 
> > > That is not quite accurate.. There are HW configurations where ACS
> > > needs to be a certain way for the HW to work with P2P at all. It isn't
> > > just an optimization or the user accepts something, if they want P2P
> > > at all they must get a ACS configuration appropriate for their system.
> > 
> > The current wording of "For iommu_groups to form correctly, the ACS
> > settings in the PCIe fabric need to be setup early" suggests that the
> > way we currently configure ACS is incorrect in general, regardless of
> > P2PDMA.
> 
> Yes, I'd agree with this. We don't have enough information to
> configurate it properly in the kernel in an automatic way. We don't
> know if pairs of devices even have SW enablement to do P2P in the
> kernel and we don't accurately know what issues the root complex
> has. All of this information goes into choosing the right ACS bits.
> 
> > But my impression is that there's a trade-off between isolation and
> > the ability to do P2PDMA, and users have different requirements, and
> > the preference for less isolation/more P2PDMA is no more "correct"
> > than a preference for more isolation/less P2PDMA.
> 
> Sure, that makes sense
>  
> > Maybe something like this:
> > 
> >   PCIe ACS settings determine how devices are put into iommu_groups.
> >   The iommu_groups in turn determine which devices can be passed
> >   through to VMs and whether P2PDMA between them is possible.  The
> >   iommu_groups are built at enumeration-time and are currently static.
> 
> Not quite, the iommu_groups don't have alot to do with the P2P. Even
> devices in the same kernel group can still have non working P2P.
> 
> Maybe:
> 
>  PCIe ACS settings control the level of isolation and the possible P2P
>  paths between devices. With greater isolation the kernel will create
>  smaller iommu_groups and with less isolation there is more HW that
>  can achieve P2P transfers. From a virtualization perspective all
>  devices in the same iommu_group must be assigned to the same VM as
>  they lack security isolation.
> 
>  There is no way for the kernel to automatically know the correct
>  ACS settings for any given system and workload. Existing command line
>  options allow only for large scale change, disabling all
>  isolation, but this is not sufficient for more complex cases.
> 
>  Add a kernel command-line option to directly control all the ACS bits
>  for specific devices, which allows the operator to setup the right
>  level of isolation to achieve the desired P2P configuration. The
>  definition is future proof, when new ACS bits are added to the spec
>  the open syntax can be extended.
> 
>  ACS needs to be setup early in the kernel boot as the ACS settings
>  effect how iommu_groups are formed. iommu_group formation is a one
>  time event during initial device discovery, changing ACS bits after
>  kernel boot can result in an inaccurate view of the iommu_groups
>  compared to the current isolation configuration.
>  
>  ACS applies to PCIe Downstream Ports and multi-function devices.
>  The default ACS settings are strict and deny any direct traffic
>  between two functions. This results in the smallest iommu_group the
>  HW can support. Frequently these values result in slow or
>  non-working P2PDMA.
> 
>  ACS offers a range of security choices controlling how traffic is
>  allowed to go directly between two devices. Some popular choices:
>    - Full prevention
>    - Translated requests can be direct, with various options
>    - Asymetric direct traffic, A can reach B but not the reverse
>    - All traffic can be direct
>  Along with some other less common ones for special topologies.
> 
>  The intention is that this option would be used with expert knowledge
>  of the HW capability and workload to achieve the desired
>  configuration.

That all sounds good.  IIUC the current default is full prevention (I
guess you said that a few paragraphs up).

It's unfortunate that this requires so much expert knowledge to use,
but I guess we don't really have a good alternative.  The only way I
can think of to help would be some kind of white paper or examples in
Documentation/PCI/.

Bjorn

