Return-Path: <linux-pci+bounces-9099-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B37E4912F46
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2024 23:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F2141F22E41
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2024 21:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F95F17B404;
	Fri, 21 Jun 2024 21:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OPE10jga"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C11D16D310
	for <linux-pci@vger.kernel.org>; Fri, 21 Jun 2024 21:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719004606; cv=none; b=JVxWzPv3TEBqtnBuBWKV9BssHNhQnzJHfebpgxbubJSlB9FG2eq5AStJ3QYbbwUsWLtwTVz8YKM2iLNRU5rVFbKOe3ph8f9CVURIXwYBoooz3Lj9mOFyi/zhC1vFcqhNw09zbnnOfKqqvM14kXPrHc5Oc8vUknVMZddagOHB2cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719004606; c=relaxed/simple;
	bh=t0MB4HkhyTuk6P8SpYCu87zWrzT5rMQkxIacS6g8dU4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=mGEtRlt0+2PSQWx1c6M2YlwxS9lHd+TrQ59UrBItcTPgG5HDpIWmcQaswFhALqxC+zW7txD7uk3p1197/3IzNLPc3SKSulcYLwDlcwm+TYJtOdB9kUTOgw6QHEx03mj9SkCL2hO8AwH9zhnValq/qpMzZBADW/qVnazAQGG21yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OPE10jga; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70787C2BBFC;
	Fri, 21 Jun 2024 21:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719004605;
	bh=t0MB4HkhyTuk6P8SpYCu87zWrzT5rMQkxIacS6g8dU4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=OPE10jgaQ8dLBnEsJ0sbFOWRUdr9yuAABJt2DWMvEf3A0UwmKjFl4ezRCAU/yuoy/
	 ygtroximAb42GPzInOjf4X3DGHvmOpCCvkdnCzfAZQJEZF5HEqPUie4gb5+O8uduo2
	 LcsygC11NTisHRJl3on6GJICeaz+EbVuY86Uk9ZPp92uq2rzoMN5W5avvs8++B05LV
	 AfWm7h0TmwSQJ1YlZ2JsdJusuNjgjOJbJwMo2P+I9W7Enz/UKzPujXYlV47XCGH6Kt
	 jmYb02w1G8lGaz/z0GNs5adcxt+R/4fhPf6ZbQx7maRQQZRf0AkgeqyBHTWtPQPPo5
	 OTTjumIUNF+iA==
Date: Fri, 21 Jun 2024 16:16:43 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Nirmal Patel <nirmal.patel@linux.intel.com>
Cc: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v3] PCI: vmd: always enable host bridge hotplug support
 flags
Message-ID: <20240621211643.GA1406072@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620154133.000069b7@linux.intel.com>

On Thu, Jun 20, 2024 at 03:41:33PM -0700, Nirmal Patel wrote:
> On Thu, 2 May 2024 17:56:08 -0500
> Bjorn Helgaas <helgaas@kernel.org> wrote:
> 
> > On Thu, May 02, 2024 at 03:38:00PM -0700, Paul M Stillwell Jr wrote:
> > > On 5/2/2024 3:08 PM, Bjorn Helgaas wrote:  
> > > > On Mon, Apr 08, 2024 at 11:39:27AM -0700, Paul M Stillwell Jr
> > > > wrote:  
> > > > > Commit 04b12ef163d1 ("PCI: vmd: Honor ACPI _OSC on PCIe
> > > > > features") added code to copy the _OSC flags from the root
> > > > > bridge to the host bridge for each vmd device because the AER
> > > > > bits were not being set correctly which was causing an AER
> > > > > interrupt storm for certain NVMe devices.
> > > > > 
> > > > > This works fine in bare metal environments, but causes problems
> > > > > when the vmd driver is run in a hypervisor environment. In a
> > > > > hypervisor all the _OSC bits are 0 despite what the underlying
> > > > > hardware indicates. This is a problem for vmd users because if
> > > > > vmd is enabled the user *always* wants hotplug support enabled.
> > > > > To solve this issue the vmd driver always enables the hotplug
> > > > > bits in the host bridge structure for each vmd.
> > > > > 
> > > > > Fixes: 04b12ef163d1 ("PCI: vmd: Honor ACPI _OSC on PCIe
> > > > > features") Signed-off-by: Nirmal Patel
> > > > > <nirmal.patel@linux.intel.com> Signed-off-by: Paul M Stillwell
> > > > > Jr <paul.m.stillwell.jr@intel.com> ---
> > > > >   drivers/pci/controller/vmd.c | 10 ++++++++--
> > > > >   1 file changed, 8 insertions(+), 2 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/pci/controller/vmd.c
> > > > > b/drivers/pci/controller/vmd.c index 87b7856f375a..583b10bd5eb7
> > > > > 100644 --- a/drivers/pci/controller/vmd.c
> > > > > +++ b/drivers/pci/controller/vmd.c
> > > > > @@ -730,8 +730,14 @@ static int vmd_alloc_irqs(struct vmd_dev
> > > > > *vmd) static void vmd_copy_host_bridge_flags(struct
> > > > > pci_host_bridge *root_bridge, struct pci_host_bridge
> > > > > *vmd_bridge) {
> > > > > -	vmd_bridge->native_pcie_hotplug =
> > > > > root_bridge->native_pcie_hotplug;
> > > > > -	vmd_bridge->native_shpc_hotplug =
> > > > > root_bridge->native_shpc_hotplug;
> > > > > +	/*
> > > > > +	 * there is an issue when the vmd driver is running
> > > > > within a hypervisor
> > > > > +	 * because all of the _OSC bits are 0 in that case.
> > > > > this disables
> > > > > +	 * hotplug support, but users who enable VMD in their
> > > > > BIOS always want
> > > > > +	 * hotplug suuport so always enable it.
> > > > > +	 */
> > > > > +	vmd_bridge->native_pcie_hotplug = 1;
> > > > > +	vmd_bridge->native_shpc_hotplug = 1;  
> > > > 
> > > > Deferred for now because I think we need to figure out how to set
> > > > all these bits the same, or at least with a better algorithm than
> > > > "here's what we want in this environment."
> > > > 
> > > > Extended discussion about this at
> > > > https://lore.kernel.org/r/20240417201542.102-1-paul.m.stillwell.jr@intel.com
> > > 
> > > That's ok by me. I thought where we left it was that if we could
> > > find a solution to the Correctable Errors from the original issue
> > > that maybe we could revert 04b12ef163d1.
> > > 
> > > I'm not sure I would know if a patch that fixes the Correctable
> > > Errors comes in... We have a test case we would like to test
> > > against that was pre 04b12ef163d1 (BIOS has AER disabled and we
> > > hotplug a disk which results in AER interrupts) so we would be
> > > curious if the issues we saw before goes away with a new patch for
> > > Correctable Errors.  
> > 
> > My current theory is that there's some issue with that particular
> > Samsung NVMe device that causes the Correctable Error flood.  Kai-Heng
> > says they happen even with VMD disabled.
> > 
> > And there are other reports that don't seem to involve VMD but do
> > involve this NVMe device ([144d:a80a]):
> > 
> >   https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1852420
> >   https://forums.unraid.net/topic/113521-constant-errors-on-logs-after-nvme-upgrade/
> >   https://forums.unraid.net/topic/118286-nvme-drives-throwing-errors-filling-logs-instantly-how-to-resolve/
> >   https://forum.proxmox.com/threads/pve-kernel-panics-on-reboots.144481/
> >   https://www.eevblog.com/forum/general-computing/linux-mint-21-02-clone-replace-1tb-nvme-with-a-2tb-nvme/
> > 
> > NVMe has weird power management stuff, so it's always possible we're
> > doing something wrong in a driver.
> > 
> > But I think we really need to handle Correctable Errors better by:
> > 
> >   - Possibly having drivers mask errors if they know about defects
> >   - Making the log messages less alarming, e.g.,  a single line report
> >   - Rate-limiting them so they're never overwhelming
> >   - Maybe automatically masking them in the PCI core to avoid
> > interrupts
> > 
> > > > >   	vmd_bridge->native_aer = root_bridge->native_aer;
> > > > >   	vmd_bridge->native_pme = root_bridge->native_pme;
> > > > >   	vmd_bridge->native_ltr = root_bridge->native_ltr;

> Hi Bjorn,
> 
> Do we still expect to get this patch accepted?
> 
> Based on the previous comments, even with AER fixed we will still have
> an issue in Guest OS of disabling all the features which will require
> making adjustments and/or removing 04b12ef163d1.
> 
> Is it possible to accept this patch and add necessary changes
> when AER fix is available?

I think 04b12ef163d1 is wrong, and we shouldn't copy any of the bits
from the root port.

If vmd takes ownership of all those features, you can decide what to
do with AER, and you can disable it if you want to.

Bjorn

