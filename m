Return-Path: <linux-pci+bounces-8479-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7B1900C79
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 21:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BCE7285BD6
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 19:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7174313A412;
	Fri,  7 Jun 2024 19:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nt8k8nv/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED32DDC9;
	Fri,  7 Jun 2024 19:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717788659; cv=none; b=jI+3SQg7yHfWQDJwcAA52/JDN1kZaeNsV4NffZDZ8mQ3QhUypaK2NCvfk/6w5bOey7AofzR+SwZ9NgT5FtozYPIpggwXwRsSXA1Y34ccW6iHoBgdlH3AswmmwOrJg38rJc/hkaHpR8IPxra8KG5R8DyV7J54D+o9zBSVX3JWKKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717788659; c=relaxed/simple;
	bh=D3j+/yjnNIGv7J2RoQZW6oh/+NmHkvPnpEUbKX+xt1I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Q7MLo0EDRgC+PhM95geJzIb0LKDUYg/WeuJxoLfviHFywdsFEmUuwmm4uY4M96VZXB9LVXdVtU2/SR92GQctVd1pBRI6WAoKhxgRkwwzKeEZriPfuKrcxyrsF9ZQpBd3pleCzdRcKiODtxFBm/If/RF36gD5BXofYYa+vM74uWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nt8k8nv/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B38BC2BBFC;
	Fri,  7 Jun 2024 19:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717788658;
	bh=D3j+/yjnNIGv7J2RoQZW6oh/+NmHkvPnpEUbKX+xt1I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=nt8k8nv/j9c0E53eFscg2s+72y2p8Z1M1saOXCrq5RBsOHkjTDdtObZlW5ALXU/Gt
	 4ShFkTj4ji1MM06yyw3B2Sn2lUlfsVi5VxNXKJLPv1pKO9t/IwPUZh1Q4OPq4gWlw2
	 TJQb9KxS1YrQwhBzH0GfcjYiNWH5N1rDv9mxqEa9YrLZyphVdtFEP7M95b3b6BEIbM
	 cVy4tFEVCOfyKRFRR6/8WxTVkK8zc4aYgL/9eJutTEuv0U2wXj3R7N9MA/F7M1kvGV
	 gL6xkER04J7inUbibhVa87LWNucBGnRkGIB4a4mgx7PhdiDJlZ+SPrVKgKxSWDtlJf
	 xjve7Ue/M7LCQ==
Date: Fri, 7 Jun 2024 14:30:55 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Vidya Sagar <vidyas@nvidia.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, "corbet@lwn.net" <corbet@lwn.net>,
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
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: Re: [PATCH V3] PCI: Extend ACS configurability
Message-ID: <20240607193055.GA855605@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH8PR12MB667431B8552D271F906F8F4BB8FF2@PH8PR12MB6674.namprd12.prod.outlook.com>

On Mon, Jun 03, 2024 at 07:50:59AM +0000, Vidya Sagar wrote:
> Hi Bjorn,
> Could you let me know if Jason's reply answers your question?
> Please let me know if you are looking for any more information.

I think we should add some of that content to the commit log.  It
needs:

  - Subject line that advertises some good thing.

  - A description of why users want this.  I have no idea what the
    actual benefit is, but I'm looking for something at the level of
    "The default ACS settings put A and B in different IOMMU groups,
    preventing P2PDMA between them.  If we disable ACS X, A and B will
    be put in the same group and P2PDMA will work".

  - A primer on how users can affect IOMMU groups by enabling/
    disabling ACS settings so they can use this without just blind
    trial and error.  A note that this is immutable except at boot
    time.

  - A pointer to the code that determines IOMMU groups based on the
    ACS settings.  Similar to the above, but more useful for
    developers.

If we assert "for iommu_groups to form correctly ...", a hint about
why/where this is so would be helpful.

"Correctly" is not quite the right word here; it's just a fact that
the ACS settings determined at boot time result in certain IOMMU
groups.  If the user desires different groups, it's not that something
is "incorrect"; it's just that the user may have to accept less
isolation to get the desired IOMMU groups.

> > -----Original Message-----
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > ...
> > 
> > On Thu, May 23, 2024 at 09:59:36AM -0500, Bjorn Helgaas wrote:
> > > [+cc iommu folks]
> > >
> > > On Thu, May 23, 2024 at 12:05:28PM +0530, Vidya Sagar wrote:
> > > > For iommu_groups to form correctly, the ACS settings in the PCIe
> > > > fabric need to be setup early in the boot process, either via the
> > > > BIOS or via the kernel disable_acs_redir parameter.
> > >
> > > Can you point to the iommu code that is involved here?  It sounds like
> > > the iommu_groups are built at boot time and are immutable after that?
> > 
> > They are created when the struct device is plugged in. pci_device_group() does the
> > logic.
> > 
> > Notably groups can't/don't change if details like ACS change after the groups are
> > setup.
> > 
> > There are alot of instructions out there telling people to boot their servers and then
> > manually change the ACS flags with set_pci or something, and these are not good
> > instructions since it defeats the VFIO group based security mechanisms.
> > 
> > > If we need per-device ACS config that depends on the workload, it
> > > seems kind of problematic to only be able to specify this at boot
> > > time.  I guess we would need to reboot if we want to run a workload
> > > that needs a different config?
> > 
> > Basically. The main difference I'd see is if the server is a VM host or running bare
> > metal apps. You can get more efficicenty if you change things for the bare metal case,
> > and often bare metal will want to turn the iommu off while a VM host often wants
> > more of it turned on.
> > 
> > > Is this the iommu usage model we want in the long term?
> > 
> > There is some path to more dynamic behavior here, but it would require separating
> > groups into two components - devices that are together because they are physically
> > sharing translation (aliases and things) from devices that are together because they
> > share a security boundary (ACS).
> > 
> > It is more believable we could dynamically change security group assigments for VFIO
> > than translation group assignment. I don't know anyone interested in this right now -
> > Alex and I have only talked about it as a possibility a while back.
> > 
> > FWIW I don't view patch as excluding more dynamisism in the future, but it is the best
> > way to work with the current state of affairs, and definitely better than set_pci
> > instructions.
> > 
> > Thanks,
> > Jason

