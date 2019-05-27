Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4190E2B2A6
	for <lists+linux-pci@lfdr.de>; Mon, 27 May 2019 13:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbfE0LBt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 May 2019 07:01:49 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:60702 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbfE0LBs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 May 2019 07:01:48 -0400
Received: from 79.184.255.36.ipv4.supernova.orange.pl (79.184.255.36) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id ddc5e43952daf46d; Mon, 27 May 2019 13:01:46 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] ACPI/PCI: PM: Add missing wakeup.flags.valid checks
Date:   Mon, 27 May 2019 13:01:45 +0200
Message-ID: <1872097.3m3ZAFDl4C@kreacher>
In-Reply-To: <2091978.9z20bSIm3T@kreacher>
References: <2091978.9z20bSIm3T@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thursday, May 16, 2019 12:42:20 PM CEST Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Both acpi_pci_need_resume() and acpi_dev_needs_resume() check if the
> current ACPI wakeup configuration of the device matches what is
> expected as far as system wakeup from sleep states is concerned, as
> reflected by the device_may_wakeup() return value for the device.
> 
> However, they only should do that if wakeup.flags.valid is set for
> the device's ACPI companion, because otherwise the wakeup.prepare_count
> value for it is meaningless.
> 
> Add the missing wakeup.flags.valid checks to these functions.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/acpi/device_pm.c |    4 ++--
>  drivers/pci/pci-acpi.c   |    3 ++-
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> Index: linux-pm/drivers/pci/pci-acpi.c
> ===================================================================
> --- linux-pm.orig/drivers/pci/pci-acpi.c
> +++ linux-pm/drivers/pci/pci-acpi.c
> @@ -666,7 +666,8 @@ static bool acpi_pci_need_resume(struct
>  	if (!adev || !acpi_device_power_manageable(adev))
>  		return false;
>  
> -	if (device_may_wakeup(&dev->dev) != !!adev->wakeup.prepare_count)
> +	if (adev->wakeup.flags.valid &&
> +	    device_may_wakeup(&dev->dev) != !!adev->wakeup.prepare_count)
>  		return true;
>  
>  	if (acpi_target_system_state() == ACPI_STATE_S0)
> Index: linux-pm/drivers/acpi/device_pm.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/device_pm.c
> +++ linux-pm/drivers/acpi/device_pm.c
> @@ -952,8 +952,8 @@ static bool acpi_dev_needs_resume(struct
>  	u32 sys_target = acpi_target_system_state();
>  	int ret, state;
>  
> -	if (!pm_runtime_suspended(dev) || !adev ||
> -	    device_may_wakeup(dev) != !!adev->wakeup.prepare_count)
> +	if (!pm_runtime_suspended(dev) || !adev || (adev->wakeup.flags.valid &&
> +	    device_may_wakeup(dev) != !!adev->wakeup.prepare_count))
>  		return true;
>  
>  	if (sys_target == ACPI_STATE_S0)

Bjorn, I've assumed no concerns or objections from you regarding this one and
queued this up.

If that assumption is incorrect, please let me know.




