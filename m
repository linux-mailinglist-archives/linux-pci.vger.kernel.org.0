Return-Path: <linux-pci+bounces-5138-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC8D88B5E6
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 01:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EB3A1C35FF7
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 00:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DADE81370;
	Tue, 26 Mar 2024 00:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AjGGSlMI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C09A139E
	for <linux-pci@vger.kernel.org>; Tue, 26 Mar 2024 00:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711412267; cv=none; b=sbp/MbrpI+dIzhSbKF3m87iC7m/Nv18gZgMg37KtuvyVIbb9r+ogLGIRJR3Aks0zuexr3UwuEUH6ncAO0r1qNEargynEMzc5Bx5JAMJrwfSWclMepy3Jc5RG2dav3mQztOZi1muhDjPpMfQFZVmzpSR1Chn1AYGT6RjFPTpTYeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711412267; c=relaxed/simple;
	bh=sMuKmT73QKnlaZ6xLktud5+OOpNmU2xPN1kHwQfUFUk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qA91cbW+/bIACMKTm95FKwNdbbMibf/K7IBeeOxkmRX2cNi7JMrpvWPiFv1iOCNymTjCGY3v5crdGpV/o8/dRz8LO4MA7xMmnLnxZ3pMKnED2K8EtWfls/p9SxbOt+brhPHTWA1Gz98ZOKyzj/ryRY+ZeYTng6WNlec9/xq+CVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AjGGSlMI; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711412266; x=1742948266;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sMuKmT73QKnlaZ6xLktud5+OOpNmU2xPN1kHwQfUFUk=;
  b=AjGGSlMISIUL1g0apvMsp/PisPRvSWcF5MtdTyqKS6D4dLfrZ37cyTUB
   Ycys0CZkYtSW3MrVWa+Qea4D94IXWKby5GN+1Hx28GX1Bigh5aybdjDzR
   6lTlcJqM2BzJefM6u8wyha58N78Apz1LSV/mH8Ve54ZyCy0BrfXNTKZO5
   VDFX3cuvcNGcfJEm7/Ezgx08x0xheLfhuPZsXME929+k+P2vAh3ioLywJ
   1JPCtjGUk0qy1l3jut0LuISlYtHuQjVy2MRqOcneswAq374W7/xTPpWjl
   yigV0wosMBzpUDJ/TsqE5gLgNpBoeu34gKw810eW/WyitlyhK5uFoJ92l
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="6553459"
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000"; 
   d="scan'208";a="6553459"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 17:17:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000"; 
   d="scan'208";a="15682703"
Received: from patelni-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.52.108])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 17:17:44 -0700
Date: Mon, 25 Mar 2024 17:17:43 -0700
From: Nirmal Patel <nirmal.patel@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>, Kai-Heng Feng
 <kai.heng.feng@canonical.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 linux-pci@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] PCI: vmd: Enable Hotplug based on BIOS setting on
 VMD rootports
Message-ID: <20240325171743.000013e6@linux.intel.com>
In-Reply-To: <20240322233637.GA1385969@bhelgaas>
References: <7f37506e-4849-4c7d-b76c-27b02b7453af@intel.com>
	<20240322233637.GA1385969@bhelgaas>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Mar 2024 18:36:37 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Fri, Mar 22, 2024 at 03:43:27PM -0700, Paul M Stillwell Jr wrote:
> > On 3/22/2024 2:37 PM, Bjorn Helgaas wrote:  
> > > On Fri, Mar 22, 2024 at 01:57:00PM -0700, Nirmal Patel wrote:  
> > > > On Fri, 15 Mar 2024 09:29:32 +0800
> > > > Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
> > > > ...  
> > >   
> > > > > If there's an official document on intel.com, it can make
> > > > > many things clearer and easier.
> > > > > States what VMD does and what VMD expect OS to do can be
> > > > > really helpful. Basically put what you wrote in an official
> > > > > document.  
> > > > 
> > > > Thanks for the suggestion. I can certainly find official VMD
> > > > architecture document and add that required information to
> > > > Documentation/PCI/controller/vmd.rst. Will that be okay?  
> > > 
> > > I'd definitely be interested in whatever you can add to illuminate
> > > these issues.
> > >   
> > > > I also need your some help/suggestion on following alternate
> > > > solution. We have been looking at VMD HW registers to find some
> > > > empty registers. Cache Line Size register offset OCh is not
> > > > being used by VMD. This is the explanation in PCI spec 5.0
> > > > section 7.5.1.1.7: "This read-write register is implemented for
> > > > legacy compatibility purposes but has no effect on any PCI
> > > > Express device behavior." Can these registers be used for
> > > > passing _OSC settings from BIOS to VMD OS driver?
> > > > 
> > > > These 8 bits are more than enough for UEFI VMD driver to store
> > > > all _OSC flags and VMD OS driver can read it during OS boot up.
> > > > This will solve all of our issues.  
> > > 
> > > Interesting idea.  I think you'd have to do some work to separate
> > > out the conventional PCI devices, where PCI_CACHE_LINE_SIZE is
> > > still relevant, to make sure nothing breaks.  But I think we
> > > overwrite it in some cases even for PCIe devices where it's
> > > pointless, and it would be nice to clean that up.  
> > 
> > I think the suggestion here is to use the VMD devices Cache Line
> > Size register, not the other PCI devices. In that case we don't
> > have to worry about conventional PCI devices because we aren't
> > touching them.  
> 
> Yes, but there is generic code that writes PCI_CACHE_LINE_SIZE for
> every device in some cases.  If we wrote the VMD PCI_CACHE_LINE_SIZE,
> it would obliterate whatever you want to pass there.
> 
> Bjorn
Our initial testing showed no change in value by overwrite from pci. The
registers didn't change in Host as well as in Guest OS when some data
was written from BIOS. I will perform more testing and also make sure
to write every register just in case.

Thanks for the response.

-nirmal


