Return-Path: <linux-pci+bounces-13571-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B16F598772D
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2024 18:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 294CCB24EFF
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2024 16:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89BE11BC4E;
	Thu, 26 Sep 2024 16:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QKGT3/Ym"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E2953368
	for <linux-pci@vger.kernel.org>; Thu, 26 Sep 2024 16:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727366602; cv=none; b=Iew7i7rRToOqvEJkYHXRS9FoF79b6E74rT70Hu+v7L+k2cS8r0HJPa2Zc36ft5CpFhrBLtkDsYH1gvl2rhTsKSCALKh84+kUH0VdT3GTnt+Ng2k01VSx//0H9Dg0Bv8AqQgjADsP87O18utNtw5iHMeKSA2qUXwUDxX2GU/3Tbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727366602; c=relaxed/simple;
	bh=iS4XdGEXA35R7XLIj3MIc6c+NzZuiuTakb4v+rwMwRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gY9xQFxz932drig5sxmGRNsBsspPL50+ma327gZUMdI4jBxB6GuIFBBrXVXDGrlCO/05tM8rjvcGKBiKyzaqlZ3OiyxrRBtJgCDaVkw/yAhUjzOk0N/St4eKmbDz1NaQ4fL/Ppc9yo/72GU8NrB6ykBLRJgvBF4vlOkpx8jrgic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QKGT3/Ym; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727366601; x=1758902601;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=iS4XdGEXA35R7XLIj3MIc6c+NzZuiuTakb4v+rwMwRI=;
  b=QKGT3/Ymll2KFC0KXVpFU1ClxOfhURVhl6Vq9SYfCbD+mP8v2OkoQBHK
   KtORQD4m7i8pnO/PyPSe7Vj554wUpkApjRx/his+ZCwNH+VzfuXOBzeDS
   yno8cz2ry00dbpdeWlpHnzgPN6Il/KdM4eMLVwp9bXmJtSEWp7hTRhGbt
   PP+n0ecy2xmL+fLxJqMl8qaD3F+fVZc0ZEQcM8zVQJQbx4RdF15zlzQSR
   8wU7izvF+EjySqeI5w08KSSGk/DxT7Lv6+lv+mcD8oEpACKiGPtDCHkWX
   C+wOSSaD0v9eaBpy+SFTOQ7ZF/Z0ZFbs8a+U+vKE96o376j+nNv+QB9uP
   Q==;
X-CSE-ConnectionGUID: SK4PSWXxTqaZ70vucxMbWg==
X-CSE-MsgGUID: 9MbOp2IxQoqs9Va15lZqRA==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="26614154"
X-IronPort-AV: E=Sophos;i="6.11,155,1725346800"; 
   d="scan'208";a="26614154"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 09:03:21 -0700
X-CSE-ConnectionGUID: 549A197EQZ2w/i93E1GhHA==
X-CSE-MsgGUID: ZyVuzXG5ScaZLgt/y6oHpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,155,1725346800"; 
   d="scan'208";a="72359356"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by fmviesa008.fm.intel.com with SMTP; 26 Sep 2024 09:03:17 -0700
Received: by stinkbox (sSMTP sendmail emulation); Thu, 26 Sep 2024 19:03:16 +0300
Date: Thu, 26 Sep 2024 19:03:16 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: intel-gfx@lists.freedesktop.org, Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/6] PCI/PM: Respect pci_dev->skip_bus_pm in the
 .poweroff() path
Message-ID: <ZvWFxLZwRWL3DCeX@intel.com>
References: <20240925144526.2482-2-ville.syrjala@linux.intel.com>
 <20240925192842.GA9182@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240925192842.GA9182@bhelgaas>
X-Patchwork-Hint: comment

On Wed, Sep 25, 2024 at 02:28:42PM -0500, Bjorn Helgaas wrote:
> On Wed, Sep 25, 2024 at 05:45:21PM +0300, Ville Syrjala wrote:
> > From: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > 
> > On some older laptops i915 needs to leave the GPU in
> > D0 when hibernating the system, or else the BIOS
> > hangs somewhere. Currently that is achieved by calling
> > pci_save_state() ahead of time, which then skips the
> > whole pci_prepare_to_sleep() stuff.
> 
> IIUC this refers to pci_pm_suspend_noirq(), which has this:
> 
>   if (!pci_dev->state_saved) {
>     pci_save_state(pci_dev);
>     if (!pci_dev->skip_bus_pm && pci_power_manageable(pci_dev))
>       pci_prepare_to_sleep(pci_dev);
>   }
> 
> Would be good if the commit log included the name of the function
> where pci_prepare_to_sleep() is skipped.

Sure, I can amend the commit msg.

> 
> If there's a general requirement to leave all devices in D0 when
> hibernating, it would be nice to have have some documentation like an
> ACPI spec reference.

No, IIRC the ACPI spec even says that you must (or at least
should) put devices into D3. But the buggy BIOS on some old
laptops keels over when you do that. Hence we need this quirk.

> Or if this is some i915-specific thing, maybe a pointer to history
> like a lore or bugzilla reference.

The two relevant commits I can find are:

commit 54875571bbfd ("drm/i915: apply the PCI_D0/D3 hibernation
workaround everywhere on pre GEN6")
commit ab3be73fa7b4 ("drm/i915: gen4: work around hang during
hibernation")

> 
> > It feels to me that this approach could lead to unintended
> > side effects as it causes the pci code to deviate from the
> > standard path in various ways. In order to keep i915
> > behaviour more standard it seems preferrable to use
> > pci_dev->skip_bus_pm here. Duplicate the relevant logic
> > from pci_pm_suspend_noirq() in pci_pm_poweroff_noirq().
> > 
> > It also looks like the current code is may put the parent
> > bridge into D3 despite leaving the device in D0. Though
> > perhaps the host bridge (which is where the integrated
> > GPU lives) always has subordinates, which would make
> > this a non-issue for i915. But maybe this could be a
> > problem for other devices. Utilizing skip_bus_pm will
> > make the behaviour of leaving the bridge in D0 a bit
> > more explicit if nothing else.
> 
> s/is may/may/
> 
> Rewrap to fill 75 columns.  Could apply to all patches in the series.
> 
> Will need an ack from Rafael, author of:
> 
>   d491f2b75237 ("PCI: PM: Avoid possible suspend-to-idle issue")
>   3e26c5feed2a ("PCI: PM: Skip devices in D0 for suspend-to-idle")
> 
> which added .skip_bus_pm and its use in pci_pm_suspend_noirq().
> 
> IIUC this is a cleanup that doesn't fix any known problem?  The
> overall diffstat doesn't make it look like a simplification, although
> it might certainly be cleaner somehow:

My main concern is that using pci_save_state() might cause the pci
code to deviate from the normal path in more ways than just skipping
the D0->D3 transition. And then we might end up constantly chasing
after driver/pci changes in order to match its behaviour.

Not to mention that having the pci_save_state() in the driver code
is clearly confusing a bunch of our developers.

> 
> > drivers/gpu/drm/i915/i915_driver.c | 121 +++++++++++++++++++----------
> > drivers/pci/pci-driver.c           |  16 +++-
> > 2 files changed, 94 insertions(+), 43 deletions(-)
> 
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > Cc: linux-pci@vger.kernel.org
> > Cc: intel-gfx@lists.freedesktop.org
> > Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > ---
> >  drivers/pci/pci-driver.c | 16 +++++++++++++++-
> >  1 file changed, 15 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> > index f412ef73a6e4..ef436895939c 100644
> > --- a/drivers/pci/pci-driver.c
> > +++ b/drivers/pci/pci-driver.c
> > @@ -1142,6 +1142,8 @@ static int pci_pm_poweroff(struct device *dev)
> >  	struct pci_dev *pci_dev = to_pci_dev(dev);
> >  	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
> >  
> > +	pci_dev->skip_bus_pm = false;
> > +
> >  	if (pci_has_legacy_pm_support(pci_dev))
> >  		return pci_legacy_suspend(dev, PMSG_HIBERNATE);
> >  
> > @@ -1206,9 +1208,21 @@ static int pci_pm_poweroff_noirq(struct device *dev)
> >  			return error;
> >  	}
> >  
> > -	if (!pci_dev->state_saved && !pci_has_subordinate(pci_dev))
> > +	if (!pci_dev->state_saved && !pci_dev->skip_bus_pm &&
> > +	    !pci_has_subordinate(pci_dev))
> >  		pci_prepare_to_sleep(pci_dev);
> >  
> > +	if (pci_dev->current_state == PCI_D0) {
> > +		pci_dev->skip_bus_pm = true;
> > +		/*
> > +		 * Per PCI PM r1.2, table 6-1, a bridge must be in D0 if any
> > +		 * downstream device is in D0, so avoid changing the power state
> > +		 * of the parent bridge by setting the skip_bus_pm flag for it.
> > +		 */
> > +		if (pci_dev->bus->self)
> > +			pci_dev->bus->self->skip_bus_pm = true;
> > +	}
> > +
> >  	/*
> >  	 * The reason for doing this here is the same as for the analogous code
> >  	 * in pci_pm_suspend_noirq().
> > -- 
> > 2.44.2
> > 

-- 
Ville Syrjälä
Intel

