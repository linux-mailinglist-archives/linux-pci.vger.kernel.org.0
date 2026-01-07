Return-Path: <linux-pci+bounces-44158-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 24EA0CFCDE8
	for <lists+linux-pci@lfdr.de>; Wed, 07 Jan 2026 10:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7EF1D300EE6F
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jan 2026 09:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DD1324B32;
	Wed,  7 Jan 2026 09:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iVP/8wKa"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F1A323406;
	Wed,  7 Jan 2026 09:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767778228; cv=none; b=j0Wg/SYUBSNtpE+EJutDJQFp7yeXylNGzFs0bXQkSHYNL1OivVCPbM+XPb8EsJKLCi1x6qIyEdGKo3mzdoMH4JkS03iks+9q2Qy7IV3P3NmpWS442mVlcFBaBh7Z6bEljr7dgOjO/83ZIE/pUvVrZf6TOtJjHYZgBl+qH6timKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767778228; c=relaxed/simple;
	bh=vJCiQiX91Kz+4OSF27zEmECdRZJ4K0r0E2a+idG/6eA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F1sCnGefQ4IkOBj15juTKpdUU2fZ0fKRGc64O4ZrMD6iYUzr8Lr7qq04BeEKMxvsB3frmmCxEHPDdJ7NpIYwH/ofr2hmQkXosQCxRb+mqEqeBT494g5S1pbxxa5oisX/AzTqAh3fo5RZdxT/eT41tSN+lnxCHTgvpXfkYoRNkLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iVP/8wKa; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767778226; x=1799314226;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vJCiQiX91Kz+4OSF27zEmECdRZJ4K0r0E2a+idG/6eA=;
  b=iVP/8wKa8iC5A4FruNiziYSijHRVinQ/OGqzdQjRjpJyix1qMu7aw5oF
   NA7iK+G9EM45SxKtt09BW89Ec12tcLDyKClV704pwxLISwmmL+alnpNRi
   eW6zgweaNVlyC+GZWJsN3NoSNyhurtJC0c9Xvv+a3C4pkgDYPdzsEa+wo
   QOSFcSQIPBU261bRZMj9jpiUaab+gJSKrlLFwkY2I8tuE9ZYu23DMOjfn
   pozvdZ5Ro3InDHX31CAyULXibg4xUKB5dAa2XQt/Fp9G4qjCIUUnG3PZ+
   f6/v+k2wIBUTwbIN9IH2bkUvwbVEvLRyJC1bzVdKmSsMEd7hiLSOxtOPK
   g==;
X-CSE-ConnectionGUID: on2Xl3XtTKieO8fzaAJUMw==
X-CSE-MsgGUID: QxXbactCQm2/wIhBSxV+0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11663"; a="86560997"
X-IronPort-AV: E=Sophos;i="6.21,207,1763452800"; 
   d="scan'208";a="86560997"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 01:30:25 -0800
X-CSE-ConnectionGUID: M7htaIpHSVeC08aD1xnReg==
X-CSE-MsgGUID: bUJlVdA4QjanzLcd+bEdfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,207,1763452800"; 
   d="scan'208";a="234022481"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa001.fm.intel.com with ESMTP; 07 Jan 2026 01:30:22 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 4AF0898; Wed, 07 Jan 2026 10:30:21 +0100 (CET)
Date: Wed, 7 Jan 2026 10:30:21 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
	Dave Jiang <dave.jiang@intel.com>,
	Feng Tang <feng.tang@linux.alibaba.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andreas Noever <andreas.noever@gmail.com>,
	Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>, linux-usb@vger.kernel.org
Subject: Re: [PATCH] PCI/portdev: Disable AER for Titan Ridge 4C 2018
Message-ID: <20260107093021.GN2275908@black.igk.intel.com>
References: <e45f4544-7ff4-4e75-b8d0-3ec3480b1444@linux.intel.com>
 <20260106204801.GA374317@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260106204801.GA374317@bhelgaas>

On Tue, Jan 06, 2026 at 02:48:01PM -0600, Bjorn Helgaas wrote:
> [+cc Thunderbolt folks]
> 
> On Tue, Jan 06, 2026 at 11:00:52AM -0800, Kuppuswamy Sathyanarayanan wrote:
> > On 1/6/2026 10:20 AM, Atharva Tiwari wrote:
> > > Disable AER for Intel Titan Ridge 4C 2018
> > > (used in T2 iMacs, where the warnings appear)
> > > that generates continuous pcieport warnings. such as:
> > > 
> > > pcieport 0000:00:1c.4: AER: Correctable error message received from 0000:07:00.0
> > > pcieport 0000:07:00.0: PCIe Bus Error: severity=Correctable, type=Data Link Layer, (Receiver ID)
> > > pcieport 0000:07:00.0:   device [8086:15ea] error status/mask=00000080/00002000
> > > pcieport 0000:07:00.0:    [ 7] BadDLLP
> > > 
> > > (see: https://bugzilla.kernel.org/show_bug.cgi?id=220651)
> > > 
> > > macOS also disables AER for Thunderbolt devices and controllers in
> > > their drivers.
> > 
> > Why not disable it in BIOS or use noaer command line option?
> 
> If the kernel can figure this out by itself, we should do that so
> users don't have to debug issues and figure out how to disable in BIOS
> or use a command line option.
> 
> But if this is really a hardware issue, I would expect to see some
> reports on the web, and I can't find AER reports that mention these
> devices except this problem report.
> 
> Adding Thunderbolt folks in case they know about any errata.

I wonder if these AER messages are caused by PTM too?

Can you try the latest mainline. It has this commit:

  044b9f1a7f4f ("PCI/PTM: Enable only if device advertises relevant role")

and see if that changes anything?

> 
> > > Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
> > > ---
> > >  drivers/pci/pcie/portdrv.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
> > > index 38a41ccf79b9..5330a679fcff 100644
> > > --- a/drivers/pci/pcie/portdrv.c
> > > +++ b/drivers/pci/pcie/portdrv.c
> > > @@ -240,7 +240,9 @@ static int get_port_device_capability(struct pci_dev *dev)
> > >  	if ((pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
> > >               pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC) &&
> > >  	    dev->aer_cap && pci_aer_available() &&
> > > -	    (pcie_ports_native || host->native_aer))
> > > +	    (pcie_ports_native || host->native_aer) &&
> > > +	    !(dev->vendor == PCI_VENDOR_ID_INTEL &&
> > > +		    (dev->device >= 0x15EA && dev->device <= 0x15EC)))
> > >  		services |= PCIE_PORT_SERVICE_AER;
> > >  #endif
> > >  
> > 
> > -- 
> > Sathyanarayanan Kuppuswamy
> > Linux Kernel Developer
> > 

