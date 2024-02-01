Return-Path: <linux-pci+bounces-2954-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8A9845F75
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 19:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B5111F2BF2B
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 18:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F84D84FC1;
	Thu,  1 Feb 2024 18:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ld58gD1B"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02DD82C97
	for <linux-pci@vger.kernel.org>; Thu,  1 Feb 2024 18:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706810794; cv=none; b=hLzOKXgWXSDzPKx1zEPIKXseAvJkggXaWNnc/Vn37uQ/yGI/7cmYfdDm7ZLMmxcgnrVsY54UD2lsf7/oY2edqzchQak/mVBE+bZOfY+0gvL3S+k+4Gpp4o0vhltOM731AAvkGsYMiggCS3JTLj2gI4X6bcB3QxhojF5KKpL9B68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706810794; c=relaxed/simple;
	bh=B9BMbYwwS8fjGKUQHuzl9vczYpfrc83/IjHHBfSf3VM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=QUScBUJelFZcIngm5mloeyDrL7ikuSGBhrSYflKMyCfkHHBSQrqzDytd2YInGlXin5MoBimckmgSx90nw/RJUXFWjgsu0NgeQ/Fy6UaABnrre6irIiXe1XmD9FsX1pnZf/QCrOyzdGewb1yTt+sXdla2ykH2SiehZrRooNEPlQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ld58gD1B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B3F6C43390;
	Thu,  1 Feb 2024 18:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706810793;
	bh=B9BMbYwwS8fjGKUQHuzl9vczYpfrc83/IjHHBfSf3VM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Ld58gD1BoAyOvnUiQUyKdjC/l5i/nYRl3Lvt9wTxdGrhiSfKMiBq1FJU+DEVZduOU
	 tCX+1apdrPU5KuYrTyIpRyXqpUJmZUyLgEEHbOrWMNXiZW5677vI0w6CJ/voFjnZv1
	 AHh4N2QRf581uqBVWX7YlxkWrmoRWMoOydEomZRQgoIB2nxJZrLmrixU8mi8v94jCC
	 rytmik3339ANvNqSb4FK6Xtk4/rG4p/EHgMsq9meXt4jR6hPOlkeGXAG2WfEX8fvNh
	 aTPznf0rt1LiPqgEDt1mMI023WuHt79DVdVY4daBdr21SZJKeJ2iXPwNx+aq+4I0Jt
	 O810GHeHeva2g==
Date: Thu, 1 Feb 2024 12:06:31 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mateusz Nowicki <nowicki@posteo.net>
Cc: linux-pci@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [Question] Custom MMIO handler - is it possible?
Message-ID: <20240201180631.GA641688@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ISO68S.RPAGJSCS217U3@posteo.net>

On Thu, Feb 01, 2024 at 03:38:42PM +0000, Mateusz Nowicki wrote:
> Thanks for a quick reply Bjorn!
> 
> Actually performance is not the biggest concern.
> Mmiotrace has documented SMP race condition:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/trace/mmiotrace.rst#n135
> 
> Also playing correctly with page fault is quite a challenge. I'm trying to
> find a simpler/easier solution :)

I don't know how to make better handler for this.  Anything we do
would probably involve VM protection to catch accesses, even if that's
just in the kernel and not visible to userspace, and would probably
have the same SMP issue mentioned above.

Bjorn

> On Wed, Jan 31 2024 at 15:20:09 -06:00:00, Bjorn Helgaas
> <helgaas@kernel.org> wrote:
> > On Wed, Jan 31, 2024 at 08:42:18PM +0000, nowicki@posteo.net wrote:
> > >  Hello,
> > > 
> > >  I'm trying to implement a fake PCIe device and I'm looking for
> > > guidance (by
> > >  fake I mean fully software device).
> > > 
> > >  So far I implemented:
> > >  - fake PCIe bus with custom fake pci_ops.read & pci_ops.write
> > > functions
> > >  - fake PCIe switch
> > >  - fake PCIe endpoint
> > > 
> > >  Fake devices have implemented PCIe registers and are visible in
> > > user space
> > >  via lspci tool.
> > >  Registers can be edited via setpci tool.
> > > 
> > >  Now I'm looking for a way to implement BAR regions with custom
> > > memory
> > >  handlers. Is it even possible?
> > >  Basically I'd like to capture each MemoryWrite & MemoryRead
> > > targeted for
> > >  PCIe endpoint's BAR region and emulate NVMe registers.
> > > 
> > >  I'm in dead-end right now and I'm seeing only two options:
> > >  - generate page faults on every access to fake BAR region and
> > > execute fake
> > >  PCIe endpoint's callbacks - similar/the same as mmiotrace
> > >  - periodically scan fake BAR region for any changes
> > > 
> > >  Both solutions have drawbacks.
> > >  Is there other way to implement fake BAR region?
> > 
> > Sounds kind of cool and potentially useful to build kernel test tools.
> > 
> > Is the page fault on access option a problem because you want better
> > performance?  I assume you really *want* to know about every write and
> > possibly even every read, so a page fault seems like the way to do
> > that.
> > 
> > Maybe qemu would have some ideas?  I assume it implements some similar
> > things.
> > 
> > Bjorn
> 
> 

