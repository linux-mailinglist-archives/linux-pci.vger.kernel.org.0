Return-Path: <linux-pci+bounces-3123-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81BD884A7D0
	for <lists+linux-pci@lfdr.de>; Mon,  5 Feb 2024 22:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E709291F95
	for <lists+linux-pci@lfdr.de>; Mon,  5 Feb 2024 21:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255E8482FD;
	Mon,  5 Feb 2024 20:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qv3k5tOT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645B712883C;
	Mon,  5 Feb 2024 20:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707163913; cv=none; b=TrN5fgCdCnmbZHcYk4vbGQFWYnpX5CNmOIMVa9vGWGbxUntRbVHVl9u/QEqU+ucKzI1DavdMz9KP2b0RO9J7iIex9cp7n6nY1i741MO7hcq9TVQ4QEYAoc7/+ME42vpWJyEpxFrZGJcGvFs2lZqwcw6rkHGEQ/h0H8gQTCPduqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707163913; c=relaxed/simple;
	bh=uWZISSb6UUEmeVSZKhEDphqB5Yyr7UXl927wI8zD6I8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h9fO+4dfrWt7vqxBPUYPtYwib7cYjitqJiO7MTP8N3ejAuTdCmp0kxRYBl7iJLRdKzeaePr/BryTJQ0Nxs/tv/kcVOEdrdNBrR2+16yLj5qKGA1zaWDdjWKBYdAC4ipwXeTClxmzfou+zBjM6MHjuokUDs0YQCFUOKx8B9ZVIwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qv3k5tOT; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707163912; x=1738699912;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=uWZISSb6UUEmeVSZKhEDphqB5Yyr7UXl927wI8zD6I8=;
  b=Qv3k5tOTrWl4IV8WjHHTIU4R2BBhfON7C+xh3EUJgKp+CDwxMMNu3ve+
   OcnrheWqhcvRZenB3KzzVxrKo4aZ8aupWpyh4+/LnlYTllfZvkk6dNlYN
   0M8PBC1l4E8YeWy8GjhzX094PG4wWSkFlefIrug//Sa6sP5dGP8N6iTXK
   Jtmm1MR4U/j6m38W95hUtdtqhzikQycqx9wb6WiVarVe9g6eM0NUJGAgq
   pl4dprbNZXb1yOJ9URCWh4UTObqoV1PWkYKH+gPPzR9uCG/+L5ogYJv3M
   yxNBC/Gglgn8kB+aiVPQKhFWlt2IDhJ0z1sDb2KinRYfG685K/QmC//PZ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="4479514"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="4479514"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 12:11:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="5417128"
Received: from sgruszka-mobl.ger.corp.intel.com (HELO localhost) ([10.252.41.223])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 12:11:48 -0800
Date: Mon, 5 Feb 2024 20:19:29 +0100
From: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [RFC] PCI/AER: Block runtime suspend when handling errors
Message-ID: <ZcE0wWb6/CGFTKi/@linux.intel.com>
References: <20240123090016.281252-1-stanislaw.gruszka@linux.intel.com>
 <20240130001436.GA488226@bhelgaas>
 <ZbtmB2GXPIwW1fLl@linux.intel.com>
 <CAJZ5v0gsojXKwQk4CL9ZpENcFs7X9pywfwNG-_ech5_G8pHRVw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gsojXKwQk4CL9ZpENcFs7X9pywfwNG-_ech5_G8pHRVw@mail.gmail.com>

On Thu, Feb 01, 2024 at 03:10:35PM +0100, Rafael J. Wysocki wrote:
> On Thu, Feb 1, 2024 at 10:36 AM Stanislaw Gruszka
> <stanislaw.gruszka@linux.intel.com> wrote:
> >
> > On Mon, Jan 29, 2024 at 06:14:36PM -0600, Bjorn Helgaas wrote:
> > > On Tue, Jan 23, 2024 at 10:00:16AM +0100, Stanislaw Gruszka wrote:
> > > > PM runtime can be done simultaneously with AER error handling.
> > > > Avoid that by using pm_runtime_get_sync() just after pci_dev_get()
> > > > and pm_runtime_put() just before pci_dev_put() in AER recovery
> > > > procedures.
> > >
> > > I guess there must be a general rule here, like "PCI core must use
> > > pm_runtime_get_sync() whenever touching the device asynchronously,
> > > i.e., when it's doing something unrelated to a call from the driver"?
> >
> > Clear rules would be nice, that's for sure.
> >
> > > Probably would apply to all subsystem cores, not just PCI.
> >
> > If they have something similar like AER.
> >
> > > > I'm not sure about DPC case since I do not see get/put there. It
> > > > just call pci_do_recovery() from threaded irq dcd_handler().
> > > > I think pm_runtime* should be added to this handler as well.
> > >
> > > s/dcd_handler/dpc_handler/
> > >
> > > I'm guessing the "threaded" part really doesn't matter; just the fact
> > > that this is in response to an interrupt, not something directly
> > > called by a driver?
> >
> > Yes. I added "threaded" just to emphasis that it's safe to add sleeping
> > functions there. In context of possible solution, not related to
> > the problem itself.
> >
> > > > pm_runtime_get_sync() will increase dev->power.usage_count counter to
> > > > prevent any rpm actives. When there is suspending pending, it will wait
> > > > for it and do the rpm resume. Not sure if that problem, on my testing
> > > > I did not encounter issues with that.
> > >
> > > Sorry, I didn't catch your meaning here.
> > I tired to write two things:
> >
> > First, pm_runtime_get_sync() after exit prevents possibility of
> > runtime suspend, so we are sure device will not be powered off
> >
> > Second, if during pm_runtime_get_sync(), there is pending attempt
> > to suspend device, it will be synchronized and device will
> > be resumed.
> 
> Not exactly.  pm_runtime_get_sync() will resume the device
> synchronously no matter what.
> 
> > This can be problematic as device is in error state.
> 
> If this is a real possibility (I mean, device in a low-power state and
> in an error state at the same time), it would be better to call
> __pm_runtime_disable(dev, false) instead of pm_runtime_get_sync(), as
> that would prevent runtime PM from changing the device state.

__pm_runtime_disable(dev, false) does not work as reliable in my
test as pm_runtime_get_sync(), the

igc 0000:02:00.0: Unable to change power state from D3hot to D0, device inaccessible

message disappears, but sill have:

igc 0000:02:00.0: not ready 65535ms after bus reset; giving up
pcieport 0000:00:1c.2: AER: Root Port link has been reset (-25)
pcieport 0000:00:1c.2: AER: subordinate device reset failed
pcieport 0000:00:1c.2: AER: device recovery fail

> > But at least from software perspective we should end in device
> > being in active state and then we can perform reset of it.
> 
> I'm not sure about this.  It may be better to power-cycle the device
> in D3hot instead of attempting to put it into D0 beforehand.

Me nigher, but in pci_reset_function() and similar resetting 
procedures we always call pci_dev_save_and_disable() before
actual reset and it set device in D0, so I think it's ok to do so.

Regards
Stanislaw

