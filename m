Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDBB2B8685
	for <lists+linux-pci@lfdr.de>; Wed, 18 Nov 2020 22:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbgKRVWH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Nov 2020 16:22:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:33962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725879AbgKRVWD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 18 Nov 2020 16:22:03 -0500
Received: from localhost (129.sub-72-107-112.myvzw.com [72.107.112.129])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74647246B8;
        Wed, 18 Nov 2020 21:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605734521;
        bh=zILhvrQoYAz7OjxdXXHg+YYLX1dSAjdTpAWhMSuGpRU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=xv0R4wDw5UYvFlKaXTZ/pwPU2S8HZLWn40RJFrpkSyCAFWD8DpTSXBOZAYe3eLAP7
         JJSHRXMgVUrN/M5bTiTK/pqfYvcwEhuMptAXowfw0lpVMBnoF/iek5Oux1hH5tBL5n
         Mbjl5XC6Tfal25K6TnVBXWDbM4kg9ezZf28q9QkY=
Date:   Wed, 18 Nov 2020 15:22:00 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
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
Message-ID: <20201118212200.GA80972@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029092453.69869-1-mika.westerberg@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 29, 2020 at 12:24:53PM +0300, Mika Westerberg wrote:
> When a PCI bridge is runtime resumed from D3cold the underlying bus is
> walked and the attached devices are runtime resumed as well. However, in
> addition to that we also generate a wakeup event for these devices even
> though this actually is not a real wakeup event coming from the
> hardware.
> 
> Normally this does not cause problems but when combined with
> /sys/power/wakeup_count like using the steps below:
> 
>   # count=$(cat /sys/power/wakeup_count)
>   # echo $count > /sys/power/wakeup_count
>   # echo mem > /sys/power/state
> 
> The system suspend cycle might get aborted at this point if a PCI bridge
> that was runtime suspended (D3cold) was runtime resumed for any reason.
> The runtime resume calls pci_wakeup_bus() and that generates wakeup
> event increasing wakeup_count.
> 
> Since this is not a real wakeup event we can prevent the above from
> happening by removing the call to pci_wakeup_event() in
> pci_wakeup_bus(). While there rename pci_wakeup_bus() to
> pci_resume_bus() to better reflect what it does.
> 
> Reported-by: Utkarsh Patel <utkarsh.h.patel@intel.com>

Is there a URL to a report on a mailing list or a bugzilla that we can
include here?  What was the actual user-visible issue?  If we can
mention it here, it may be useful to others who encounter the same
issue.  I guess maybe a system suspend fails?

> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/gpu/vga/vga_switcheroo.c |  2 +-
>  drivers/pci/pci.c                | 16 +++++-----------
>  include/linux/pci.h              |  2 +-
>  3 files changed, 7 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/vga/vga_switcheroo.c b/drivers/gpu/vga/vga_switcheroo.c
> index 087304b1a5d7..8843b078ad4e 100644
> --- a/drivers/gpu/vga/vga_switcheroo.c
> +++ b/drivers/gpu/vga/vga_switcheroo.c
> @@ -1039,7 +1039,7 @@ static int vga_switcheroo_runtime_resume(struct device *dev)
>  	mutex_lock(&vgasr_mutex);
>  	vga_switcheroo_power_switch(pdev, VGA_SWITCHEROO_ON);
>  	mutex_unlock(&vgasr_mutex);
> -	pci_wakeup_bus(pdev->bus);
> +	pci_resume_bus(pdev->bus);
>  	ret = dev->bus->pm->runtime_resume(dev);
>  	if (ret)
>  		return ret;
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 6d4d5a2f923d..b25dfa63eeb9 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1174,26 +1174,20 @@ int pci_platform_power_transition(struct pci_dev *dev, pci_power_t state)
>  }
>  EXPORT_SYMBOL_GPL(pci_platform_power_transition);
>  
> -/**
> - * pci_wakeup - Wake up a PCI device
> - * @pci_dev: Device to handle.
> - * @ign: ignored parameter
> - */
> -static int pci_wakeup(struct pci_dev *pci_dev, void *ign)
> +static int pci_resume_one(struct pci_dev *pci_dev, void *ign)
>  {
> -	pci_wakeup_event(pci_dev);

IIUC this is the critical change, and all the rest of this patch is
no-op renames.  Can you split this into two patches so the important
change is more obvious?

Then the obvious questions will be why it is safe to remove this, and
where the desired call for the real wakeup is.

>  	pm_request_resume(&pci_dev->dev);
>  	return 0;
>  }
>  
>  /**
> - * pci_wakeup_bus - Walk given bus and wake up devices on it
> + * pci_resume_bus - Walk given bus and runtime resume devices on it
>   * @bus: Top bus of the subtree to walk.
>   */
> -void pci_wakeup_bus(struct pci_bus *bus)
> +void pci_resume_bus(struct pci_bus *bus)
>  {
>  	if (bus)
> -		pci_walk_bus(bus, pci_wakeup, NULL);
> +		pci_walk_bus(bus, pci_resume_one, NULL);
>  }
>  
>  static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
> @@ -1256,7 +1250,7 @@ int pci_power_up(struct pci_dev *dev)
>  		 * may be powered on into D0uninitialized state, resume them to
>  		 * give them a chance to suspend again
>  		 */
> -		pci_wakeup_bus(dev->subordinate);
> +		pci_resume_bus(dev->subordinate);
>  	}
>  
>  	return pci_raw_set_power_state(dev, PCI_D0);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 22207a79762c..9256ef2e4327 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1271,7 +1271,7 @@ bool pci_dev_run_wake(struct pci_dev *dev);
>  void pci_d3cold_enable(struct pci_dev *dev);
>  void pci_d3cold_disable(struct pci_dev *dev);
>  bool pcie_relaxed_ordering_enabled(struct pci_dev *dev);
> -void pci_wakeup_bus(struct pci_bus *bus);
> +void pci_resume_bus(struct pci_bus *bus);
>  void pci_bus_set_current_state(struct pci_bus *bus, pci_power_t state);
>  
>  /* For use by arch with custom probe code */
> -- 
> 2.28.0
> 
