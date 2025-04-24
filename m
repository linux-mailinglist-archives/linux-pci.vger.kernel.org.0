Return-Path: <linux-pci+bounces-26654-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E793A9A05C
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 07:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A42E31946327
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 05:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3EC19CC3A;
	Thu, 24 Apr 2025 05:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JNBdN9VG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FDE46B8;
	Thu, 24 Apr 2025 05:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745471544; cv=none; b=auT7O1FlSaQGyhMqbI4qAMiLFarLpCeyn1qYhAu8INoK1StKCa/JutFrgy5AVRObO1BL88FAw6IzcA515680ODnMNCOTHnN8PYuGsVtE3be6RV+OMhdFEDmKwv3JJadUaMzVAnslcCe4aXClo+aMUnJdGUTOC6JVASkhMUdDBPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745471544; c=relaxed/simple;
	bh=Fk9ShdsGiK8Xytvks9AI3asFePC1OQGuvSXxW8ODAXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bci4iro+rNxLzkoRk+PrSAJHLnawJVWs3IS8y++9uEvaCTqdCDEo3GomKE4VtvNWRHoPR8PNoLrxtc7WR4u+Qoeqlj7KVmB2avLeLHl8vnY7PV7EfGy+Si8tb5SDkgKle6J6Bt5G5jK49m2jmA7EaU2PnYpak235idmhEJEmda0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JNBdN9VG; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745471542; x=1777007542;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Fk9ShdsGiK8Xytvks9AI3asFePC1OQGuvSXxW8ODAXI=;
  b=JNBdN9VGL0EWTTR3WaSdrC0CPnwClwEnpAcHk0YywsvjRr5vAA8/Q+Nx
   z/HM3JKGdBDfRVXRgyv+CebFns1gGomVc0eUzwpK1D2pLVo+Y55O3y4k2
   97ilaRQC3mfoK3NcpXIq9hWjzFe3DcX5PcoNqtsvs8F6a5595u9hK5mR3
   DQRtHlKQnqAqphlx7joK0VOWPh4SzMsurMnkqSlIBJAN/g+rdXOglUBub
   LkZYIll9ZblfpKiMO2GvCKL1mYw31lmDVi7eDJu09Iw8KLbUgv7t8Yuhb
   hV2DA+u3DyRhR89z6ERkZyv0aNJRAcxjBUweQsw/r/4uNjQuvV+mVh+1s
   w==;
X-CSE-ConnectionGUID: LGDcaJgZScmqm4p5kLPEpA==
X-CSE-MsgGUID: PkKns9cbSMeml7oLExKvqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="57285042"
X-IronPort-AV: E=Sophos;i="6.15,235,1739865600"; 
   d="scan'208";a="57285042"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 22:12:20 -0700
X-CSE-ConnectionGUID: IgdT/VwoS5OHDluMdiJhVg==
X-CSE-MsgGUID: nsy8zcjSTRq5OSQexTZgQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,235,1739865600"; 
   d="scan'208";a="137504687"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 22:12:17 -0700
Date: Thu, 24 Apr 2025 08:12:14 +0300
From: Raag Jadav <raag.jadav@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: rafael@kernel.org, mahesh@linux.ibm.com, oohall@gmail.com,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
	lukas@wunner.de, aravind.iddamsetty@linux.intel.com
Subject: Re: [PATCH v2] PCI/PM: Avoid suspending the device with errors
Message-ID: <aAnILntDM4xwaoPX@black.fi.intel.com>
References: <20250422135341.2780925-1-raag.jadav@intel.com>
 <20250422194537.GA380850@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422194537.GA380850@bhelgaas>

On Tue, Apr 22, 2025 at 02:45:37PM -0500, Bjorn Helgaas wrote:
> On Tue, Apr 22, 2025 at 07:23:41PM +0530, Raag Jadav wrote:
> > If an error is triggered before or during system suspend, any bus level
> > power state transition will result in unpredictable behaviour by the
> > device with failed recovery. Avoid suspending such a device and leave
> > it in its existing power state.
> > 
> > This only covers the devices that rely on PCI core PM for their power
> > state transition.
> > 
> > Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> > ---
> > 
> > v2: Synchronize AER handling with PCI PM (Rafael)
> > 
> > More discussion on [1].
> > [1] https://lore.kernel.org/all/CAJZ5v0g-aJXfVH+Uc=9eRPuW08t-6PwzdyMXsC6FZRKYJtY03Q@mail.gmail.com/
> 
> Thanks for the pointer, but the commit log for this patch needs to be
> complete in itself.  "Unpredictable behavior" is kind of hand-wavy and
> doesn't really help understand the problem.
> 
> >  drivers/pci/pci-driver.c |  3 ++-
> >  drivers/pci/pcie/aer.c   | 11 +++++++++++
> >  include/linux/aer.h      |  2 ++
> >  3 files changed, 15 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> > index f57ea36d125d..289a1fa7cb2d 100644
> > --- a/drivers/pci/pci-driver.c
> > +++ b/drivers/pci/pci-driver.c
> > @@ -884,7 +884,8 @@ static int pci_pm_suspend_noirq(struct device *dev)
> >  		}
> >  	}
> >  
> > -	if (!pci_dev->state_saved) {
> > +	/* Avoid suspending the device with errors */
> > +	if (!pci_aer_in_progress(pci_dev) && !pci_dev->state_saved) {
> 
> This looks potentially racy, since hardware can set bits in
> PCI_EXP_DEVSTA at any time.

Which is why it's placed in ->suspend_noirq() callback. Can it still race?

Raag

