Return-Path: <linux-pci+bounces-26827-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF6AA9DCEA
	for <lists+linux-pci@lfdr.de>; Sat, 26 Apr 2025 21:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B29C1890F34
	for <lists+linux-pci@lfdr.de>; Sat, 26 Apr 2025 19:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B46E1D88AC;
	Sat, 26 Apr 2025 19:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jseHWeQW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0051C5D44;
	Sat, 26 Apr 2025 19:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745695454; cv=none; b=pBSknP+ZlVN+UQ+C27KjFbjIVFGsY/zTTdQf9GMSyn8IGLqLvAbJYDRVdKK2aE7ZtwMDnxvxZsvBjFx061OEREbMzHqr8x67zgrtYOrLcDE/Q8NFxDjsxxaujlBYxgb2StoD2MGK66yMGP/47H2XzIRhavbL94IwgfsceH8YbHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745695454; c=relaxed/simple;
	bh=+Xi76UVkojEdHo4/jL+5DRNqxAQtWyjq/d/qkkRCVa4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XVJ1AJdEkxICZekYf9vFKN7dWEE9FfwZGe3LHf7bIwLWS0y+jRKYtyK7FYcjPa9/pJG/a9rFGpjBivJZcL856x3FiXrh4bltmdD6nxKw8iIx7fLcD2fPRe2k1BvnT/pKOYqa0DPI6RH3e9JY1B28RzAgmy+ISoepq3eQbvoC+3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jseHWeQW; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745695452; x=1777231452;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=+Xi76UVkojEdHo4/jL+5DRNqxAQtWyjq/d/qkkRCVa4=;
  b=jseHWeQWmHTR40t1EyRHqrUXo66NYh23x+/5CHmKsuiC2cxB7EsxKLHA
   XDn+mAtBUpHtRMWHy94ae/uecpx4A9hyovhoqsYYldHupnJv1vbvLPa/C
   9pbvxLlEhSEN6il0pqZGUulM+2rp9COYZitJ90ZDN1z0aACZNDLKLJfin
   Ym2uhp952g3nzNtzX4qZPNthJgG+uEINLxpXOSSbCcbydaZL6EmyJ2qsn
   14/yV6v063alzsVjkBmYCgapd6DP20CFYUlna8cQiBmiw1yl4xbuWIQwY
   cwt5qgiNJS5StDowohvFTavXDmgL25aUBqaTlhEnJuSWO3NKBZG4CifRd
   Q==;
X-CSE-ConnectionGUID: kaupLwP6SwedVBMTkC/98w==
X-CSE-MsgGUID: E7QIkSmdR4+9QGQI52JMbg==
X-IronPort-AV: E=McAfee;i="6700,10204,11415"; a="51130514"
X-IronPort-AV: E=Sophos;i="6.15,242,1739865600"; 
   d="scan'208";a="51130514"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2025 12:24:12 -0700
X-CSE-ConnectionGUID: vAm0TX87Rz+x+L2g5vX44g==
X-CSE-MsgGUID: HvWmwnpsRRqybx9FTPs1oA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,242,1739865600"; 
   d="scan'208";a="137980432"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2025 12:24:09 -0700
Date: Sat, 26 Apr 2025 22:24:06 +0300
From: Raag Jadav <raag.jadav@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, mahesh@linux.ibm.com,
	oohall@gmail.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
	lukas@wunner.de, aravind.iddamsetty@linux.intel.com
Subject: Re: [PATCH v2] PCI/PM: Avoid suspending the device with errors
Message-ID: <aA0y1vWSG_FQYi1F@black.fi.intel.com>
References: <20250422135341.2780925-1-raag.jadav@intel.com>
 <20250422194537.GA380850@bhelgaas>
 <aAnILntDM4xwaoPX@black.fi.intel.com>
 <CAJZ5v0ifgqzqP8N+NXJ=UVZ434SiyzgZjn1EuWy4HTT4TKOGWg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0ifgqzqP8N+NXJ=UVZ434SiyzgZjn1EuWy4HTT4TKOGWg@mail.gmail.com>

On Thu, Apr 24, 2025 at 12:59:55PM +0200, Rafael J. Wysocki wrote:
> On Thu, Apr 24, 2025 at 7:12 AM Raag Jadav <raag.jadav@intel.com> wrote:
> >
> > On Tue, Apr 22, 2025 at 02:45:37PM -0500, Bjorn Helgaas wrote:
> > > On Tue, Apr 22, 2025 at 07:23:41PM +0530, Raag Jadav wrote:
> > > > If an error is triggered before or during system suspend, any bus level
> > > > power state transition will result in unpredictable behaviour by the
> > > > device with failed recovery. Avoid suspending such a device and leave
> > > > it in its existing power state.
> > > >
> > > > This only covers the devices that rely on PCI core PM for their power
> > > > state transition.
> > > >
> > > > Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> > > > ---
> > > >
> > > > v2: Synchronize AER handling with PCI PM (Rafael)
> > > >
> > > > More discussion on [1].
> > > > [1] https://lore.kernel.org/all/CAJZ5v0g-aJXfVH+Uc=9eRPuW08t-6PwzdyMXsC6FZRKYJtY03Q@mail.gmail.com/
> > >
> > > Thanks for the pointer, but the commit log for this patch needs to be
> > > complete in itself.  "Unpredictable behavior" is kind of hand-wavy and
> > > doesn't really help understand the problem.
> > >
> > > >  drivers/pci/pci-driver.c |  3 ++-
> > > >  drivers/pci/pcie/aer.c   | 11 +++++++++++
> > > >  include/linux/aer.h      |  2 ++
> > > >  3 files changed, 15 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> > > > index f57ea36d125d..289a1fa7cb2d 100644
> > > > --- a/drivers/pci/pci-driver.c
> > > > +++ b/drivers/pci/pci-driver.c
> > > > @@ -884,7 +884,8 @@ static int pci_pm_suspend_noirq(struct device *dev)
> > > >             }
> > > >     }
> > > >
> > > > -   if (!pci_dev->state_saved) {
> > > > +   /* Avoid suspending the device with errors */
> > > > +   if (!pci_aer_in_progress(pci_dev) && !pci_dev->state_saved) {
> > >
> > > This looks potentially racy, since hardware can set bits in
> > > PCI_EXP_DEVSTA at any time.
> >
> > Which is why it's placed in ->suspend_noirq() callback. Can it still race?
> 
> With the hardware?  Yes.

Any thoughts on potential side effects and how to address them?

Raag

