Return-Path: <linux-pci+bounces-2915-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7237845432
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 10:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 078931C2592D
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 09:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA3B15B984;
	Thu,  1 Feb 2024 09:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mlCbJshU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874884D9F4;
	Thu,  1 Feb 2024 09:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706780175; cv=none; b=IUnY32Sf0zrmDgBv+z0qPg5jH6GK+MZ7Y4OfNIi4pVxLapwZnVi6Ds46Kp+L6530pdI1JjZAaTQN92aXI9n7YYshGtnTbj6aEtU52mB5eYq7WISi0tYMFr5JaVFpsBzYqL8M2JDqZqDIyBhXmqwijAnc0NAeLp97424NUpFwfhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706780175; c=relaxed/simple;
	bh=mDE6VJ8DhRRfEQyPHRAPoOs3sRJP6GQ0yAKIbQgDNBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jpr82hxcBC4Zb6MR14Few0318exBRPWqWCWPsBbhPsTb2gS8ijozRSnAgeTRBQnjzF7Lc2X/s4BMXv/KKPMKx9FySu8OdMzGZhbXCMjXvFOGF8911eXglRZp21h3Wnxs5NiQgWACNiGjI2hhWSH5w730oGC8VMgoDHmw+zSDJC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mlCbJshU; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706780173; x=1738316173;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mDE6VJ8DhRRfEQyPHRAPoOs3sRJP6GQ0yAKIbQgDNBs=;
  b=mlCbJshUUkif4ugz92BFBhXXxDZKFZHV0hk31YcpZygQOTVlo0ElPCOs
   I9eSFLmVRWKxVndjonZ5cnqajk4uowb8J+CfrUkDmUeOKmFuW3p3ma7zv
   Z5/AsSCkLNHNX5Iv0osfgv72Wfdm3EDdXiIsRtLDt8MyjvtMYLRd37mbd
   Cmz3R1eENFou3+p3o19BBNNLhZVpzwoLZ7NzG4viBpTgucUKhSACEs61B
   /LZWHfA0m7pViP8+TsYvDa4QAi6Zz2OA7NFAh/+P0WuFySHjMvOKflyRj
   e7n/ecJk4p3GgUVZVGsT7PAmvEwfvCTTsa8BLWhoCkv7YiYWJZAhK4tPT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="11224962"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="11224962"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 01:36:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="30548770"
Received: from sgruszka-mobl.ger.corp.intel.com (HELO localhost) ([10.252.41.120])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 01:36:11 -0800
Date: Thu, 1 Feb 2024 10:36:07 +0100
From: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [RFC] PCI/AER: Block runtime suspend when handling errors
Message-ID: <ZbtmB2GXPIwW1fLl@linux.intel.com>
References: <20240123090016.281252-1-stanislaw.gruszka@linux.intel.com>
 <20240130001436.GA488226@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130001436.GA488226@bhelgaas>

On Mon, Jan 29, 2024 at 06:14:36PM -0600, Bjorn Helgaas wrote:
> On Tue, Jan 23, 2024 at 10:00:16AM +0100, Stanislaw Gruszka wrote:
> > PM runtime can be done simultaneously with AER error handling.
> > Avoid that by using pm_runtime_get_sync() just after pci_dev_get()
> > and pm_runtime_put() just before pci_dev_put() in AER recovery
> > procedures.
> 
> I guess there must be a general rule here, like "PCI core must use
> pm_runtime_get_sync() whenever touching the device asynchronously,
> i.e., when it's doing something unrelated to a call from the driver"?

Clear rules would be nice, that's for sure.

> Probably would apply to all subsystem cores, not just PCI.

If they have something similar like AER.

> > I'm not sure about DPC case since I do not see get/put there. It
> > just call pci_do_recovery() from threaded irq dcd_handler().
> > I think pm_runtime* should be added to this handler as well.
> 
> s/dcd_handler/dpc_handler/
>
> I'm guessing the "threaded" part really doesn't matter; just the fact
> that this is in response to an interrupt, not something directly
> called by a driver?

Yes. I added "threaded" just to emphasis that it's safe to add sleeping
functions there. In context of possible solution, not related to
the problem itself.
 
> > pm_runtime_get_sync() will increase dev->power.usage_count counter to
> > prevent any rpm actives. When there is suspending pending, it will wait
> > for it and do the rpm resume. Not sure if that problem, on my testing
> > I did not encounter issues with that.
> 
> Sorry, I didn't catch your meaning here.
I tired to write two things:

First, pm_runtime_get_sync() after exit prevents possibility of
runtime suspend, so we are sure device will not be powered off

Second, if during pm_runtime_get_sync(), there is pending attempt
to suspend device, it will be synchronized and device will
be resumed. This can be problematic as device is in error state.
But at least from software perspective we should end in device
being in active state and then we can perform reset of it.

[ Third scenario, i.e device is suspended, and device has to be resumed
by pm_runtime_get_sync() can not really happen, because we can not
get error from disabled device. ]

... after writing this I realized that is not true, as we can do
recovery for several devices on subordinate bus, some of them can
be rpm suspended, I presume. Need to think more about this case.

> IIUC, you can reproduce the
> problem with the simultaneous aer_inject and rpm suspend/resume, and
> this patch fixes it.

Yes.

> But there's some other scenario where you *don't* see the problem?

For example there are no runtime pm related race conditions with
.probe, .remove , (system) .suspend, .resume. All of those have 
proper synchronization with runtime pm in the device core.

> > I tested with igc device by doing simultaneous aer_inject and 
> > rpm suspend/resume via /sys/bus/pci/devices/PCI_ID/power/control
> > and can reproduce: 
> > 
> > [  853.253938] igc 0000:02:00.0: not ready 65535ms after bus reset; giving up
> > [  853.253973] pcieport 0000:00:1c.2: AER: Root Port link has been reset (-25)
> > [  853.253996] pcieport 0000:00:1c.2: AER: subordinate device reset failed
> > [  853.254099] pcieport 0000:00:1c.2: AER: device recovery failed
> > [  853.254178] igc 0000:02:00.0: Unable to change power state from D3hot to D0, device inaccessible
> 
> Drop the timestamps; they don't add to understanding the problem.

Ok.

Regards
Stanislaw
> 
> > The problem disappears when applied this patch.
> > 
> > Signed-off-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
> > ---
> >  drivers/pci/pcie/aer.c | 8 ++++++++
> >  drivers/pci/pcie/edr.c | 3 +++
> >  2 files changed, 11 insertions(+)
> > 
> > diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> > index 42a3bd35a3e1..9b56460edc76 100644
> > --- a/drivers/pci/pcie/aer.c
> > +++ b/drivers/pci/pcie/aer.c
> > @@ -23,6 +23,7 @@
> >  #include <linux/kernel.h>
> >  #include <linux/errno.h>
> >  #include <linux/pm.h>
> > +#include <linux/pm_runtime.h>
> >  #include <linux/init.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/delay.h>
> > @@ -813,6 +814,7 @@ static int add_error_device(struct aer_err_info *e_info, struct pci_dev *dev)
> >  {
> >  	if (e_info->error_dev_num < AER_MAX_MULTI_ERR_DEVICES) {
> >  		e_info->dev[e_info->error_dev_num] = pci_dev_get(dev);
> > +		pm_runtime_get_sync(&dev->dev);
> >  		e_info->error_dev_num++;
> >  		return 0;
> >  	}
> > @@ -1111,6 +1113,8 @@ static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
> >  {
> >  	cxl_rch_handle_error(dev, info);
> >  	pci_aer_handle_error(dev, info);
> > +
> > +	pm_runtime_put(&dev->dev);
> >  	pci_dev_put(dev);
> >  }
> >  
> > @@ -1143,6 +1147,8 @@ static void aer_recover_work_func(struct work_struct *work)
> >  			       PCI_SLOT(entry.devfn), PCI_FUNC(entry.devfn));
> >  			continue;
> >  		}
> > +		pm_runtime_get_sync(&pdev->dev);
> > +
> >  		pci_print_aer(pdev, entry.severity, entry.regs);
> >  		/*
> >  		 * Memory for aer_capability_regs(entry.regs) is being allocated from the
> > @@ -1159,6 +1165,8 @@ static void aer_recover_work_func(struct work_struct *work)
> >  		else if (entry.severity == AER_FATAL)
> >  			pcie_do_recovery(pdev, pci_channel_io_frozen,
> >  					 aer_root_reset);
> > +
> > +		pm_runtime_put(&pdev->dev);
> >  		pci_dev_put(pdev);
> >  	}
> >  }
> > diff --git a/drivers/pci/pcie/edr.c b/drivers/pci/pcie/edr.c
> > index 5f4914d313a1..bd96babd7249 100644
> > --- a/drivers/pci/pcie/edr.c
> > +++ b/drivers/pci/pcie/edr.c
> > @@ -10,6 +10,7 @@
> >  
> >  #include <linux/pci.h>
> >  #include <linux/pci-acpi.h>
> > +#include <linux/pm_runtime.h>
> >  
> >  #include "portdrv.h"
> >  #include "../pci.h"
> > @@ -169,6 +170,7 @@ static void edr_handle_event(acpi_handle handle, u32 event, void *data)
> >  		return;
> >  	}
> >  
> > +	pm_runtime_get_sync(&edev->dev);
> >  	pci_dbg(pdev, "Reported EDR dev: %s\n", pci_name(edev));
> >  
> >  	/* If port does not support DPC, just send the OST */
> > @@ -209,6 +211,7 @@ static void edr_handle_event(acpi_handle handle, u32 event, void *data)
> >  		acpi_send_edr_status(pdev, edev, EDR_OST_FAILED);
> >  	}
> >  
> > +	pm_runtime_put(&edev->dev);
> >  	pci_dev_put(edev);
> >  }
> >  
> > -- 
> > 2.34.1
> > 
> 

