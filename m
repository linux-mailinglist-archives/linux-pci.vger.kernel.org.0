Return-Path: <linux-pci+bounces-13978-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A09993875
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 22:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC64A285A22
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 20:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4B21DE4F6;
	Mon,  7 Oct 2024 20:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MuEtJFG8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C02081727;
	Mon,  7 Oct 2024 20:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728333835; cv=none; b=N26Ai19jI8O4/dkj4GPSBduhKnrmBaOOG3jafBBzNXwBXvspf7EEBQ3RiNoaMSV6AKsaLtCYfdsJAHICSp6IBDw9YXIaLo3u26G5Z7xHtz/Ez8x/9scjWOKw47hZWOCC1vNxGaQVAG3ZJ0O7xjR0C6YioorZUlkxsaHm7agKELk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728333835; c=relaxed/simple;
	bh=iD6K7rerHt+BmbV3rXcVuFLHnGOchmZqRMEFAw2pqY4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=YIB8sQIXsunia5KIpAoqoe6W5r3cv/G4Wqsj+Yojad0o9lm5MidcNuQSIVvhiL8+zUySx/666FGbEND7zPNRY+0ccuY7z7UbYk/16yYe96z5F3nsempODPjIBuERgBG2wWt2X/Dssx3LvSR6FfIlPxqmG/x4YOvyb+09I2tBLXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MuEtJFG8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84766C4CEC6;
	Mon,  7 Oct 2024 20:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728333834;
	bh=iD6K7rerHt+BmbV3rXcVuFLHnGOchmZqRMEFAw2pqY4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=MuEtJFG8fnFYhq3I+Bk4unZGxAo+9VluXYLaHsTku/5Y2bn+P8Uo2Uz5FJkDINdKf
	 U21kcX3lz/UivCFWutBxUACSaFTSzIYdRx38uvHehBwhSKz+gbiFNEq+fOLnG0vSOd
	 c9I2I1czOiqX0LgL+0ur3IYS/t0122jK8xKSsaQPL9G0Jo+edye2uDHz6ob97DtUxq
	 SFjB2c0BLddatYpjraaOwwJWQcRpwUAS9Ck6IFRJ9wgw14wROgJkmOPPpLPfbaP0Gv
	 UJTU7WJ6Chq9T2EFFCRkbKqFDkbysasznOl6ueM8zt3NSsh5D7UmCX6IzleL4QtlD5
	 e4ci1Krujly3A==
Date: Mon, 7 Oct 2024 15:43:52 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Vidya Sagar <vidyas@nvidia.com>, corbet@lwn.net, bhelgaas@google.com,
	galshalom@nvidia.com, leonro@nvidia.com, jgg@nvidia.com,
	treding@nvidia.com, jonathanh@nvidia.com, mmoshrefjava@nvidia.com,
	shahafs@nvidia.com, vsethi@nvidia.com, sdonthineni@nvidia.com,
	jan@nvidia.com, tdave@nvidia.com, linux-doc@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V4] PCI: Extend ACS configurability
Message-ID: <20241007204352.GA449721@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e89107da-ac99-4d3a-9527-a4df9986e120@kernel.org>

On Wed, Sep 25, 2024 at 07:06:41AM +0200, Jiri Slaby wrote:
> On 25. 06. 24, 17:31, Vidya Sagar wrote:
> > PCIe ACS settings control the level of isolation and the possible P2P
> > paths between devices. With greater isolation the kernel will create
> > smaller iommu_groups and with less isolation there is more HW that
> > can achieve P2P transfers. From a virtualization perspective all
> > devices in the same iommu_group must be assigned to the same VM as
> > they lack security isolation.
> > 
> > There is no way for the kernel to automatically know the correct
> > ACS settings for any given system and workload. Existing command line
> > options (ex:- disable_acs_redir) allow only for large scale change,
> > disabling all isolation, but this is not sufficient for more complex cases.
> > 
> > Add a kernel command-line option 'config_acs' to directly control all the
> > ACS bits for specific devices, which allows the operator to setup the
> > right level of isolation to achieve the desired P2P configuration.
> > The definition is future proof, when new ACS bits are added to the spec
> > the open syntax can be extended.
> > 
> > ACS needs to be setup early in the kernel boot as the ACS settings
> > effect how iommu_groups are formed. iommu_group formation is a one
> > time event during initial device discovery, changing ACS bits after
> > kernel boot can result in an inaccurate view of the iommu_groups
> > compared to the current isolation configuration.
> > 
> > ACS applies to PCIe Downstream Ports and multi-function devices.
> > The default ACS settings are strict and deny any direct traffic
> > between two functions. This results in the smallest iommu_group the
> > HW can support. Frequently these values result in slow or
> > non-working P2PDMA.
> > 
> > ACS offers a range of security choices controlling how traffic is
> > allowed to go directly between two devices. Some popular choices:
> >    - Full prevention
> >    - Translated requests can be direct, with various options
> >    - Asymmetric direct traffic, A can reach B but not the reverse
> >    - All traffic can be direct
> > Along with some other less common ones for special topologies.
> > 
> > The intention is that this option would be used with expert knowledge
> > of the HW capability and workload to achieve the desired
> > configuration.
> 
> Hi,
> 
> this breaks ACS on some platforms (in 6.11). See:
> https://bugzilla.suse.com/show_bug.cgi?id=1229019

#regzbot introduced: 47c8846a ("PCI: Extend ACS configurability")
#regzbot link: https://bugzilla.suse.com/show_bug.cgi?id=1229019

