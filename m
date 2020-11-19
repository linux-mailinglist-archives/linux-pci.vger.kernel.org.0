Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9EE82B8CB2
	for <lists+linux-pci@lfdr.de>; Thu, 19 Nov 2020 08:58:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbgKSH6B (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Nov 2020 02:58:01 -0500
Received: from mga01.intel.com ([192.55.52.88]:13287 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725888AbgKSH6B (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 19 Nov 2020 02:58:01 -0500
IronPort-SDR: PlBXQIevBBx9w6lCzR9LrKrCQy/4TzlhHB4bO038qwkWhyi9asp5iIXN4vWYNrB3bA04P/iXYi
 0L5H1JETp/ZA==
X-IronPort-AV: E=McAfee;i="6000,8403,9809"; a="189335058"
X-IronPort-AV: E=Sophos;i="5.77,490,1596524400"; 
   d="scan'208";a="189335058"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2020 23:58:00 -0800
IronPort-SDR: xVzkT0oWBl5gxtNPc3KjVo0SZ6zNNHcawbjmwbF4Jop7mguYcZSIyCI/e1GmexMQPcvPmsXFlM
 GoisNnkN/rZg==
X-IronPort-AV: E=Sophos;i="5.77,490,1596524400"; 
   d="scan'208";a="359860469"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2020 23:57:56 -0800
Received: by lahna (sSMTP sendmail emulation); Thu, 19 Nov 2020 09:55:44 +0200
Date:   Thu, 19 Nov 2020 09:55:44 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Lukas Wunner <lukas@wunner.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Utkarsh Patel <utkarsh.h.patel@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/PM: Do not generate wakeup event when runtime
 resuming bus
Message-ID: <20201119075544.GZ2495@lahna.fi.intel.com>
References: <20201029092453.69869-1-mika.westerberg@linux.intel.com>
 <20201118212200.GA80972@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118212200.GA80972@bjorn-Precision-5520>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On Wed, Nov 18, 2020 at 03:22:00PM -0600, Bjorn Helgaas wrote:
> On Thu, Oct 29, 2020 at 12:24:53PM +0300, Mika Westerberg wrote:
> > When a PCI bridge is runtime resumed from D3cold the underlying bus is
> > walked and the attached devices are runtime resumed as well. However, in
> > addition to that we also generate a wakeup event for these devices even
> > though this actually is not a real wakeup event coming from the
> > hardware.
> > 
> > Normally this does not cause problems but when combined with
> > /sys/power/wakeup_count like using the steps below:
> > 
> >   # count=$(cat /sys/power/wakeup_count)
> >   # echo $count > /sys/power/wakeup_count
> >   # echo mem > /sys/power/state
> > 
> > The system suspend cycle might get aborted at this point if a PCI bridge
> > that was runtime suspended (D3cold) was runtime resumed for any reason.
> > The runtime resume calls pci_wakeup_bus() and that generates wakeup
> > event increasing wakeup_count.
> > 
> > Since this is not a real wakeup event we can prevent the above from
> > happening by removing the call to pci_wakeup_event() in
> > pci_wakeup_bus(). While there rename pci_wakeup_bus() to
> > pci_resume_bus() to better reflect what it does.
> > 
> > Reported-by: Utkarsh Patel <utkarsh.h.patel@intel.com>
> 
> Is there a URL to a report on a mailing list or a bugzilla that we can
> include here?  What was the actual user-visible issue?  If we can
> mention it here, it may be useful to others who encounter the same
> issue.  I guess maybe a system suspend fails?

I'm not sure if there is bugzilla entry about this. There might be a
Google partner bug but not sure if it is public.

@Utkarsh, if there is one can you share that link with Bjorn?

There are two user visible issues, first is that if you do the above
steps manually the suspend gets aborted (as the above commit log tries
to explain).

The second "user visible" issue is that the ChromeOS suspend stress test
script below fails (as it does the same steps):

  https://chromium.googlesource.com/chromiumos/platform/power_manager/+/refs/heads/master/tools/suspend_stress_test

> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > ---
> >  drivers/gpu/vga/vga_switcheroo.c |  2 +-
> >  drivers/pci/pci.c                | 16 +++++-----------
> >  include/linux/pci.h              |  2 +-
> >  3 files changed, 7 insertions(+), 13 deletions(-)
> > 
> > diff --git a/drivers/gpu/vga/vga_switcheroo.c b/drivers/gpu/vga/vga_switcheroo.c
> > index 087304b1a5d7..8843b078ad4e 100644
> > --- a/drivers/gpu/vga/vga_switcheroo.c
> > +++ b/drivers/gpu/vga/vga_switcheroo.c
> > @@ -1039,7 +1039,7 @@ static int vga_switcheroo_runtime_resume(struct device *dev)
> >  	mutex_lock(&vgasr_mutex);
> >  	vga_switcheroo_power_switch(pdev, VGA_SWITCHEROO_ON);
> >  	mutex_unlock(&vgasr_mutex);
> > -	pci_wakeup_bus(pdev->bus);
> > +	pci_resume_bus(pdev->bus);
> >  	ret = dev->bus->pm->runtime_resume(dev);
> >  	if (ret)
> >  		return ret;
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 6d4d5a2f923d..b25dfa63eeb9 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -1174,26 +1174,20 @@ int pci_platform_power_transition(struct pci_dev *dev, pci_power_t state)
> >  }
> >  EXPORT_SYMBOL_GPL(pci_platform_power_transition);
> >  
> > -/**
> > - * pci_wakeup - Wake up a PCI device
> > - * @pci_dev: Device to handle.
> > - * @ign: ignored parameter
> > - */
> > -static int pci_wakeup(struct pci_dev *pci_dev, void *ign)
> > +static int pci_resume_one(struct pci_dev *pci_dev, void *ign)
> >  {
> > -	pci_wakeup_event(pci_dev);
> 
> IIUC this is the critical change, and all the rest of this patch is
> no-op renames.  Can you split this into two patches so the important
> change is more obvious?

Sure.

> Then the obvious questions will be why it is safe to remove this, and
> where the desired call for the real wakeup is.

This is only called on runtime resume path to turn on devices below this
one. However, wakeup is only relevant on system sleep path.

For ACPI backed devices the real wakeup is handled in the
pci_acpi_wake_dev() and in case of PME it is pcie_pme_handle_request().
And then there is the pme_poll thread as well.
