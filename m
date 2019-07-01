Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE8E5C0F6
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2019 18:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfGAQP4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Jul 2019 12:15:56 -0400
Received: from mga06.intel.com ([134.134.136.31]:41527 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726863AbfGAQP4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 1 Jul 2019 12:15:56 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Jul 2019 09:15:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,440,1557212400"; 
   d="scan'208";a="184279656"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 01 Jul 2019 09:15:50 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 01 Jul 2019 19:15:50 +0300
Date:   Mon, 1 Jul 2019 19:15:50 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans De Goede <hdegoede@redhat.com>,
        "Robert R. Howell" <RHowell@uwyo.edu>
Subject: Re: [PATCH v2 1/5] PM: ACPI/PCI: Resume all devices during
 hibernation
Message-ID: <20190701161550.GA2640@lahna.fi.intel.com>
References: <4976412.ihyb9sT5jY@kreacher>
 <6191578.xJk2HsE5MX@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6191578.xJk2HsE5MX@kreacher>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 01, 2019 at 12:44:25PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Both the PCI bus type and the ACPI PM domain avoid resuming
> runtime-suspended devices with DPM_FLAG_SMART_SUSPEND set during
> hibernation (before creating the snapshot image of system memory),
> but that turns out to be a mistake.  It leads to functional issues
> and adds complexity that's hard to justify.
> 
> For this reason, resume all runtime-suspended PCI devices and all
> devices in the ACPI PM domains before creating a snapshot image of
> system memory during hibernation.
> 
> Fixes: 05087360fd7a (ACPI / PM: Take SMART_SUSPEND driver flag into account)
> Fixes: c4b65157aeef (PCI / PM: Take SMART_SUSPEND driver flag into account)
> Link: https://lore.kernel.org/linux-acpi/917d4399-2e22-67b1-9d54-808561f9083f@uwyo.edu/T/#maf065fe6e4974f2a9d79f332ab99dfaba635f64c
> Reported-by: Robert R. Howell <RHowell@uwyo.edu>
> Tested-by: Robert R. Howell <RHowell@uwyo.edu>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> -> v2: No changes.
> 
> ---
>  drivers/acpi/device_pm.c |   13 +++++++------
>  drivers/pci/pci-driver.c |   16 ++++++++--------
>  2 files changed, 15 insertions(+), 14 deletions(-)
> 
> Index: linux-pm/drivers/acpi/device_pm.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/device_pm.c
> +++ linux-pm/drivers/acpi/device_pm.c
> @@ -1155,13 +1155,14 @@ EXPORT_SYMBOL_GPL(acpi_subsys_resume_ear
>  int acpi_subsys_freeze(struct device *dev)
>  {
>  	/*
> -	 * This used to be done in acpi_subsys_prepare() for all devices and
> -	 * some drivers may depend on it, so do it here.  Ideally, however,
> -	 * runtime-suspended devices should not be touched during freeze/thaw
> -	 * transitions.
> +	 * Resume all runtime-suspended devices before creating a snapshot
> +	 * image of system memory, because the restore kernel generally cannot
> +	 * be expected to always handle them consistently and they need to be
> +	 * put into the runtime-active metastate during system resume anyway,
> +	 * so it is better to ensure that the state saved in the image will be
> +	 * alwyas consistent with that.

alwyas -> always

>  	 */
> -	if (!dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND))
> -		pm_runtime_resume(dev);
> +	pm_runtime_resume(dev);
>  
>  	return pm_generic_freeze(dev);
>  }
> Index: linux-pm/drivers/pci/pci-driver.c
> ===================================================================
> --- linux-pm.orig/drivers/pci/pci-driver.c
> +++ linux-pm/drivers/pci/pci-driver.c
> @@ -1012,15 +1012,15 @@ static int pci_pm_freeze(struct device *
>  	}
>  
>  	/*
> -	 * This used to be done in pci_pm_prepare() for all devices and some
> -	 * drivers may depend on it, so do it here.  Ideally, runtime-suspended
> -	 * devices should not be touched during freeze/thaw transitions,
> -	 * however.
> +	 * Resume all runtime-suspended devices before creating a snapshot
> +	 * image of system memory, because the restore kernel generally cannot
> +	 * be expected to always handle them consistently and they need to be
> +	 * put into the runtime-active metastate during system resume anyway,
> +	 * so it is better to ensure that the state saved in the image will be
> +	 * alwyas consistent with that.

ditto

>  	 */
> -	if (!dev_pm_smart_suspend_and_suspended(dev)) {
> -		pm_runtime_resume(dev);
> -		pci_dev->state_saved = false;
> -	}
> +	pm_runtime_resume(dev);
> +	pci_dev->state_saved = false;
>  
>  	if (pm->freeze) {
>  		int error;
> 
> 
> 
