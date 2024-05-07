Return-Path: <linux-pci+bounces-7141-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 191BA8BD8AE
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2024 02:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 808481F24876
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2024 00:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0EB5A5F;
	Tue,  7 May 2024 00:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X0TGLYjl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0330410E3
	for <linux-pci@vger.kernel.org>; Tue,  7 May 2024 00:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715042346; cv=none; b=QAhH4BDiYzhzow2+HXe/DLS3Ce+NRIIRgL0G3t+Xy4Q2nbrLnu2cylsdiI8jJxj9CapPtQXNOSqjTeiOLuHD4EvdUUsd/YXdUtiFHeIpcBFvy1dOx+Y4jrjtDrQmNkdz/7FtLLUxgZHQWHnyCwUwpLnek1BlZ4ShW02FjjmvHc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715042346; c=relaxed/simple;
	bh=XP6ty3w5OM07FnJIN8j2/GXXEh1v44S++i1skLj1GHw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X2OZIthGzEDPDxiodl3GxG0uKV+dgRuEmbvx4zmaVc6u5jGVPiOPjt+JuNdOqj3UK5SB76yU0dp3/7eu/vEx5an2ZrfBNIW6CfP//T9G8oMjwrkqTDZNG8lo6O6cn8F9mQDCMVpK2mmSPDlKwq3Fhqi8k0yppSlUq27AibV9ubg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X0TGLYjl; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715042345; x=1746578345;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XP6ty3w5OM07FnJIN8j2/GXXEh1v44S++i1skLj1GHw=;
  b=X0TGLYjlU5hnt3MWn+ML6Nnl7LAxwjAPM1A7NCYaxMAav1wMNP3hzVx9
   ppT/vXMngLLRhfEszVxjGn+QywqJlzwMrnlZw1DiT5ASL/jkfm6H6I590
   2jygqC7Y9Usnct9cKSv8Kg5GYrJS2dAdX+bUoEoHYe+bsuJxBR3SuGioy
   EXgoEiW5ct6UOvABh72OfDk7mC0U6w4fbI8anx8QISH3tQadUmv023hvg
   iYS54PNYs9vyF3H71Xb5DPNbVxJJKTpga77Zku1H5aL2/QYuL2R8GoGoi
   AohYl6mh3JmG7/RkkGx+sgdjeLyEIjynb+xsJxtTt0BG1u5i1aS54Uqml
   g==;
X-CSE-ConnectionGUID: IaxkYi8AR8OQeARzEfjOxQ==
X-CSE-MsgGUID: 742RCfNJR1WuoYHLefZdhQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="14632712"
X-IronPort-AV: E=Sophos;i="6.07,259,1708416000"; 
   d="scan'208";a="14632712"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 17:39:05 -0700
X-CSE-ConnectionGUID: gxk7sbE/SgKz0a8JaCIpag==
X-CSE-MsgGUID: lWCAbz+QSvyAiqkXRmavIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,259,1708416000"; 
   d="scan'208";a="32912289"
Received: from patelni-mobl1.amr.corp.intel.com (HELO localhost) ([10.125.162.205])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 17:39:04 -0700
Date: Mon, 6 May 2024 17:39:01 -0700
From: Nirmal Patel <nirmal.patel@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH v4] PCI: vmd: Disable MSI remap only for low MSI count
Message-ID: <20240506173901.00003ec4@linux.intel.com>
In-Reply-To: <20240426223957.GA609812@bhelgaas>
References: <20240418153121.291534-1-nirmal.patel@linux.intel.com>
	<20240426223957.GA609812@bhelgaas>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Apr 2024 17:39:57 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> I think this refers specifically to MSI-X, so use "MSI-X" in the
> subject.
ACK.
> 
> On Thu, Apr 18, 2024 at 11:31:21AM -0400, Nirmal Patel wrote:
> > VMD MSI remapping is disabled by default for all the CPUs with 28c0
> > VMD deviceID. We used to disable remapping because drives supported
> > more vectors than the VMD so the performance was better without
> > remapping. Now with CPUs that support more than 64 (128 VMD MSIx
> > vectors for gen5) we no longer need to disable this feature.  
> 
> "because drives supported more vectors" ... I guess you are referring
> to typical devices that might be behind a VMD?  But I assume there's
> no actual requirement that those devices be "drives", right?
Yes, I am referring to PCIe device with equal or more MSI-X vectors
than VMD. If a device has lesser than minimum VMD MSI-X count (64) than
VMD will not cause any performance issue while using MSI-X remapping.
> 
> "CPUs that support more than 64 ... 128 VMD vectors"  Are we talking
> about *CPUs* that support more vectors, or *VMDs* that support more
> vectors?
> 
> I guess you probably think of CPUs here because VMD is integrated into
> the same package, right?  That would explain the "CPUs with 28c0 VMD"
> comment.  But the vmd driver doesn't care about that; it just claims a
> PCI device.
Yes, I will adjust my wordings; but I meant newer VMD which still has
same deviceID (28c0) as previous generations but it has more MSI-X
vectors.(i.e. 128)
> 
> s/MSI remapping/MSI-X remapping/ (I think?)
> s/MSIx/MSI-X/ to match spec usage.
I will make adjustments.
> 
> A reference to ee81ee84f873 ("PCI: vmd: Disable MSI-X remapping when
> possible"), which added VMD_FEAT_CAN_BYPASS_MSI_REMAP, might be
> useful because it has nice context.
> 
> IIUC this will keep MSI-X remapping enabled in more cases, e.g., on
> new devices that support more vectors.  What is the benefit of keeping
> it enabled?
Sorry I took longer to respond.

VMD MSI-X remapping was a performance bottleneck in certain
situations. Starting from 28c0, VMD has a capability to disable MSI-X
remapping and improve the I/O performance. The first iteration of 28c0
VMD HW had only 64 MSI-X vectors support while the newer iterations can
support up to 128 and VMD is no longer a bottleneck. So I thought it
would be a good idea to change it to MSI-X remapping default ON.

Also upon further testings, I noticed huge boost in performance because
of this CID patch:
https://lore.kernel.org/kvm/20240423174114.526704-5-jacob.jun.pan@linux.intel.com/T/ 

The performance boost we get from the CID patch as follow:
Kernel 6.8.8 : 1Drive: 2000, 4Drives: 2300
6.9.0-rc6 + CID + MSI-X remap Disable: 1Drive: 2700, 4Drives: 6010
6.9.0-rc6 + CID + MSI-X remap Enabled: 1Drive: 2700, 4Drives: 6100

Since there is no significant performance difference between MSI-X
enable and disable after addition of CID patch, I think we can drop this
patch for now until we see significant change in I/O performance due to
VMD's MSI-X remapping policy.

Thanks for your time.

-nirmal
> 
> The ee81ee84f873 commit log suggests two issues:
> 
>   - Number of vectors available to child domain is limited by size of
>     VMD MSI-X table.
> 
>   - Remapping means child interrupts have to go through the VMD domain
>     interrupt handler instead of going straight to the device handler.
> 
> But this commit log suggests that with more vectors, you can enable
> remapping even without a performance penalty?  Maybe the VMD domain
> interrupt handler was only needed because of vector sharing?
> 
> I'm just a little confused because this commit log doesn't say what
> the actual benefit is, other than "keeping remapping enabled", and I
> don't know enough to know why that's good.
> 
> > Note, pci_msix_vec_count() failure is translated to ENODEV per
> > typical expectations that drivers may return ENODEV when some
> > driver-known fundamental detail of the device is missing.
> > 
> > Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
> > ---
> > v1->v2: Updating commit message.
> > v2->v3: Use VMD MSI count instead of cpu count.
> > v3->v4: Updating commit message.
> > ---
> >  drivers/pci/controller/vmd.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/vmd.c
> > b/drivers/pci/controller/vmd.c index 769eedeb8802..ba63af70bb63
> > 100644 --- a/drivers/pci/controller/vmd.c
> > +++ b/drivers/pci/controller/vmd.c
> > @@ -34,6 +34,8 @@
> >  #define MB2_SHADOW_OFFSET	0x2000
> >  #define MB2_SHADOW_SIZE		16
> >  
> > +#define VMD_MIN_MSI_VECTOR_COUNT 64
> > +
> >  enum vmd_features {
> >  	/*
> >  	 * Device may contain registers which hint the physical
> > location of the @@ -807,13 +809,20 @@ static int
> > vmd_enable_domain(struct vmd_dev *vmd, unsigned long features) 
> >  	sd->node = pcibus_to_node(vmd->dev->bus);
> >  
> > +	vmd->msix_count = pci_msix_vec_count(vmd->dev);
> > +	if (vmd->msix_count < 0)
> > +		return -ENODEV;
> > +
> >  	/*
> >  	 * Currently MSI remapping must be enabled in guest
> > passthrough mode
> >  	 * due to some missing interrupt remapping plumbing. This
> > is probably
> >  	 * acceptable because the guest is usually CPU-limited and
> > MSI
> >  	 * remapping doesn't become a performance bottleneck.  
> 
> This part of the comment might need some updating.  I don't see the
> connection with guest passthrough mode in the code.
> 
> > +	 * Disable MSI remapping only if supported by VMD hardware
> > and when
> > +	 * VMD MSI count is less than or equal to minimum MSI
> > count.  
> 
> Add blank line between paragraphs or rewrap into a single paragraph.
> 
> >  	 */
> >  	if (!(features & VMD_FEAT_CAN_BYPASS_MSI_REMAP) ||
> > +	    vmd->msix_count > VMD_MIN_MSI_VECTOR_COUNT ||
> >  	    offset[0] || offset[1]) {  
> 
> I think this conditional might be easier to read if it were inverted:
> 
>   if (features & VMD_FEAT_CAN_BYPASS_MSI_REMAP) && ...) {
>     vmd_set_msi_remapping(vmd, false);
>   } else {
>     ret = vmd_alloc_irqs(vmd);
>     ...
>   }
> 
> Maybe a separate patch though.
> 
> >  		ret = vmd_alloc_irqs(vmd);
> >  		if (ret)
> > -- 
> > 2.31.1
> >   


