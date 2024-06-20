Return-Path: <linux-pci+bounces-9050-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0119115C8
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2024 00:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85B9C1C20B84
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2024 22:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7204A6F2F1;
	Thu, 20 Jun 2024 22:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BItZ1V8U"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306CF36126
	for <linux-pci@vger.kernel.org>; Thu, 20 Jun 2024 22:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718923297; cv=none; b=sCmQ6SMhhCtLfHpNTcQ4RximcSX03HBx8y6qRpZYAFun3NnXB7HKTGt1bC5AKO+wnQ9G6DXx9ZI4p8dB8G1sat7/+CvmKDyHTev/vTLovWHKZ6T9Qldo+oPK5TnC6UIcNMmWUmQU6gnvDGZjyLW3/acZFRJA1mZoozzbPCwmOu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718923297; c=relaxed/simple;
	bh=SXIWZlb1KPxMCgPV5kff6lWkOxtaqf2pg3MsRAUkMIY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FfhbpTRydoax3Qrf0gH2ZfxW/fCciiK1oqoca0grXsSoNoTAU7JmUIVWB1hudHPkuWuYhCz3txvOATC85BO5soJoTVbZM3b/jzllQCJQ/yFq2sfLzDMs+LpO6HvT87lCaXnkKv6O8DPx0DdrqU0bVXtdKrbapZHHfEBkxUgVEMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BItZ1V8U; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718923296; x=1750459296;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SXIWZlb1KPxMCgPV5kff6lWkOxtaqf2pg3MsRAUkMIY=;
  b=BItZ1V8UrhqlBA7o6lTsPWvy1ynErSUI+sfi/WwcsoZiz4lypGTYZZGi
   MTwH+oPB7S+uXcFANAKDUsJ8eQ7oneAKzo0x27bXl3dqDGkBYTCgjoeW4
   yfAw1yy6/ekNTrHMfMEGJcnE7ownu7ssWSk0UOPyCHy9jTgSN8+K4cKcj
   vRSUKGUAQyE8N4qZIiB+eUouPwoBZ8aPsmgkiN8/W8O9LAsZA+R7xumuD
   v9jCRpwMIWz19WZvSVosxihqoaDLwlQStHVKCZm1pHVMyPYOL/6ikI1m2
   6+WmX8qWTfhOgUDc7vA/c+NQD2XGmrtcbCcLmbJUQ+wAInZiYEtcJa9oI
   Q==;
X-CSE-ConnectionGUID: gUb9JApOTlSoWoi1xuT45w==
X-CSE-MsgGUID: 0vbKLCUTS1aJtctnMTNKtg==
X-IronPort-AV: E=McAfee;i="6700,10204,11109"; a="15916308"
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="15916308"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 15:41:36 -0700
X-CSE-ConnectionGUID: XqqyK30yTkKY7zzP/7JeIg==
X-CSE-MsgGUID: xIU2FZ9aR7in+gCuZcaDLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="47351259"
Received: from patelni-mobl1.amr.corp.intel.com (HELO localhost) ([10.124.83.158])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 15:41:35 -0700
Date: Thu, 20 Jun 2024 15:41:33 -0700
From: Nirmal Patel <nirmal.patel@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>,
 linux-pci@vger.kernel.org
Subject: Re: [PATCH v3] PCI: vmd: always enable host bridge hotplug support
 flags
Message-ID: <20240620154133.000069b7@linux.intel.com>
In-Reply-To: <20240502225608.GA1553882@bhelgaas>
References: <bafed3eb-f698-41fa-867c-bfec87e429a4@intel.com>
 <20240502225608.GA1553882@bhelgaas>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 2 May 2024 17:56:08 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Thu, May 02, 2024 at 03:38:00PM -0700, Paul M Stillwell Jr wrote:
> > On 5/2/2024 3:08 PM, Bjorn Helgaas wrote:  
> > > On Mon, Apr 08, 2024 at 11:39:27AM -0700, Paul M Stillwell Jr
> > > wrote:  
> > > > Commit 04b12ef163d1 ("PCI: vmd: Honor ACPI _OSC on PCIe
> > > > features") added code to copy the _OSC flags from the root
> > > > bridge to the host bridge for each vmd device because the AER
> > > > bits were not being set correctly which was causing an AER
> > > > interrupt storm for certain NVMe devices.
> > > > 
> > > > This works fine in bare metal environments, but causes problems
> > > > when the vmd driver is run in a hypervisor environment. In a
> > > > hypervisor all the _OSC bits are 0 despite what the underlying
> > > > hardware indicates. This is a problem for vmd users because if
> > > > vmd is enabled the user *always* wants hotplug support enabled.
> > > > To solve this issue the vmd driver always enables the hotplug
> > > > bits in the host bridge structure for each vmd.
> > > > 
> > > > Fixes: 04b12ef163d1 ("PCI: vmd: Honor ACPI _OSC on PCIe
> > > > features") Signed-off-by: Nirmal Patel
> > > > <nirmal.patel@linux.intel.com> Signed-off-by: Paul M Stillwell
> > > > Jr <paul.m.stillwell.jr@intel.com> ---
> > > >   drivers/pci/controller/vmd.c | 10 ++++++++--
> > > >   1 file changed, 8 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/pci/controller/vmd.c
> > > > b/drivers/pci/controller/vmd.c index 87b7856f375a..583b10bd5eb7
> > > > 100644 --- a/drivers/pci/controller/vmd.c
> > > > +++ b/drivers/pci/controller/vmd.c
> > > > @@ -730,8 +730,14 @@ static int vmd_alloc_irqs(struct vmd_dev
> > > > *vmd) static void vmd_copy_host_bridge_flags(struct
> > > > pci_host_bridge *root_bridge, struct pci_host_bridge
> > > > *vmd_bridge) {
> > > > -	vmd_bridge->native_pcie_hotplug =
> > > > root_bridge->native_pcie_hotplug;
> > > > -	vmd_bridge->native_shpc_hotplug =
> > > > root_bridge->native_shpc_hotplug;
> > > > +	/*
> > > > +	 * there is an issue when the vmd driver is running
> > > > within a hypervisor
> > > > +	 * because all of the _OSC bits are 0 in that case.
> > > > this disables
> > > > +	 * hotplug support, but users who enable VMD in their
> > > > BIOS always want
> > > > +	 * hotplug suuport so always enable it.
> > > > +	 */
> > > > +	vmd_bridge->native_pcie_hotplug = 1;
> > > > +	vmd_bridge->native_shpc_hotplug = 1;  
> > > 
> > > Deferred for now because I think we need to figure out how to set
> > > all these bits the same, or at least with a better algorithm than
> > > "here's what we want in this environment."
> > > 
> > > Extended discussion about this at
> > > https://lore.kernel.org/r/20240417201542.102-1-paul.m.stillwell.jr@intel.com
> > >  
> > 
> > That's ok by me. I thought where we left it was that if we could
> > find a solution to the Correctable Errors from the original issue
> > that maybe we could revert 04b12ef163d1.
> > 
> > I'm not sure I would know if a patch that fixes the Correctable
> > Errors comes in... We have a test case we would like to test
> > against that was pre 04b12ef163d1 (BIOS has AER disabled and we
> > hotplug a disk which results in AER interrupts) so we would be
> > curious if the issues we saw before goes away with a new patch for
> > Correctable Errors.  
> 
> My current theory is that there's some issue with that particular
> Samsung NVMe device that causes the Correctable Error flood.  Kai-Heng
> says they happen even with VMD disabled.
> 
> And there are other reports that don't seem to involve VMD but do
> involve this NVMe device ([144d:a80a]):
> 
>   https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1852420
>   https://forums.unraid.net/topic/113521-constant-errors-on-logs-after-nvme-upgrade/
>   https://forums.unraid.net/topic/118286-nvme-drives-throwing-errors-filling-logs-instantly-how-to-resolve/
>   https://forum.proxmox.com/threads/pve-kernel-panics-on-reboots.144481/
>   https://www.eevblog.com/forum/general-computing/linux-mint-21-02-clone-replace-1tb-nvme-with-a-2tb-nvme/
> 
> NVMe has weird power management stuff, so it's always possible we're
> doing something wrong in a driver.
> 
> But I think we really need to handle Correctable Errors better by:
> 
>   - Possibly having drivers mask errors if they know about defects
>   - Making the log messages less alarming, e.g.,  a single line report
>   - Rate-limiting them so they're never overwhelming
>   - Maybe automatically masking them in the PCI core to avoid
> interrupts
> 
> > > >   	vmd_bridge->native_aer = root_bridge->native_aer;
> > > >   	vmd_bridge->native_pme = root_bridge->native_pme;
> > > >   	vmd_bridge->native_ltr = root_bridge->native_ltr;
> > > > -- 
> > > > 2.39.1
> > > >   
> > >   
> >   

Hi Bjorn,

Do we still expect to get this patch accepted?

Based on the previous comments, even with AER fixed we will still have
an issue in Guest OS of disabling all the features which will require
making adjustments and/or removing 04b12ef163d1.

Is it possible to accept this patch and add necessary changes
when AER fix is available?

Thanks
-nirmal

