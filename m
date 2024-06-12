Return-Path: <linux-pci+bounces-8693-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B81905DA2
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 23:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DCEFB21AC0
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 21:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A24E85923;
	Wed, 12 Jun 2024 21:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C0o45hQd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD270839FD;
	Wed, 12 Jun 2024 21:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718227746; cv=none; b=Qd5FZMPCW/oLAP+sxGHkK5f/lm2KikDSvyq7k+IieSSv4scUrCmk+lg09HxMn2dzOz1I8KImgHCqw+Y+2NfEk5XEWnfgjKEdwr9pSL4RcuNIKSz+fODvr9ElmBXSijaZFevGOy2Nj0c9DbmI+sHsFE+EVKB/Ndd83NkSCZlGgqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718227746; c=relaxed/simple;
	bh=/bnOscMoOnT73ooLq69T6EdwvMHqQhIB2Om/pcqfCbs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Gw41OOy2LGzwsuu4tsqcTPXNfJ0UZOuiOfPDgvF/zg1ZsJQ4TbRAqk4mB88O1dpSU9bsxSA6YQF8d2uK1EXoEAA/Er1DLPd1Hx3WYRxqJta0movFkz3xI4QeJc9YaX3y53clMWGYi5HVvjvzwT4FnYmreC1yJ67+4IS4krJ1Ckg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C0o45hQd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BD67C116B1;
	Wed, 12 Jun 2024 21:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718227745;
	bh=/bnOscMoOnT73ooLq69T6EdwvMHqQhIB2Om/pcqfCbs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=C0o45hQdfV22llhx/2+h0zqBKM/QNlJWQv5Ftr6xDlRQzByjvi15+xchXc1ru1/Mg
	 nUwtWI35sDqS7VZtdVJo0PU6JV4/8U5QfR2jXYDfCGqsMIIpWZ4SfFpw4AmmLXEpOO
	 k1BJqBImSJ3Pg5CWaEtaO7dVV8303MJU0G1iTG0iXXvpl5FRtedzVNzioRhDSAcA5y
	 1L/CU9+j707Wx1UCycia3NWmXvnOKyKtr4u260lP57b8Qq5sX38ctdQbI8uREUkJ8l
	 MrslPGf2vEHCzbYWe3cF4kFpHG7omdyGRAUCV+Bky0KIyIheBKQzkZMyAMsIMuVGMO
	 0zHklkmWmSZzA==
Date: Wed, 12 Jun 2024 16:29:03 -0500
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
Message-ID: <20240612212903.GA1037897@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610113849.GO19897@nvidia.com>

[+cc Alex since VFIO entered the conversation; thread at
https://lore.kernel.org/r/20240523063528.199908-1-vidyas@nvidia.com]

On Mon, Jun 10, 2024 at 08:38:49AM -0300, Jason Gunthorpe wrote:
> On Fri, Jun 07, 2024 at 02:30:55PM -0500, Bjorn Helgaas wrote:
> > "Correctly" is not quite the right word here; it's just a fact that
> > the ACS settings determined at boot time result in certain IOMMU
> > groups.  If the user desires different groups, it's not that something
> > is "incorrect"; it's just that the user may have to accept less
> > isolation to get the desired IOMMU groups.
> 
> That is not quite accurate.. There are HW configurations where ACS
> needs to be a certain way for the HW to work with P2P at all. It isn't
> just an optimization or the user accepts something, if they want P2P
> at all they must get a ACS configuration appropriate for their system.

The current wording of "For iommu_groups to form correctly, the ACS
settings in the PCIe fabric need to be setup early" suggests that the
way we currently configure ACS is incorrect in general, regardless of
P2PDMA.

But my impression is that there's a trade-off between isolation and
the ability to do P2PDMA, and users have different requirements, and
the preference for less isolation/more P2PDMA is no more "correct"
than a preference for more isolation/less P2PDMA.

The kernel-parameters doc mentions the reduced isolation idea, but I
think we need a little more guidance for users.  It's probably too
much detail for kernel-parameters, but the commit log would be a good
place.

Maybe something like this:

  PCIe ACS settings determine how devices are put into iommu_groups.
  The iommu_groups in turn determine which devices can be passed
  through to VMs and whether P2PDMA between them is possible.  The
  iommu_groups are built at enumeration-time and are currently static.

  Add a kernel command-line option to change ACS settings for specific
  devices, which allows more devices to be put in the same
  iommu_group, at the cost of reduced isolation between them.

  ACS applies to PCIe Downstream Ports and multi-function devices.
  The default ACS settings are XXX and cause devices below an
  ACS-capable port to be put in an iommu_group isolated from P2PDMA
  from outside the group.

  Disabling ACS XXX at a port allows ... downstream devices to be
  included in the same iommu_group as ...

  [I don't know exactly how this works, so please make it make sense].

