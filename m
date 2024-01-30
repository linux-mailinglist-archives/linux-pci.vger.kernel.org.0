Return-Path: <linux-pci+bounces-2749-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 220D1841765
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 01:15:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A375C282E3D
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 00:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52AE2F2D;
	Tue, 30 Jan 2024 00:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EmPFQL83"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80F533CC4;
	Tue, 30 Jan 2024 00:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706573678; cv=none; b=dTn/a5V3d8yuVmQdFIov0z0hpdhsDfUFp471CSHZ3IRwuQL/zOpyFg+kIA/jg4wERcr8X2IPqNYNN83vfjvo6riXbJcjt0zeblIAj3BH0nnjLsgfZTOT2Q+f2AlCkJmfqC9HL/CDzBw7vxEzn5o+pzsRwILdl7xzTtblgiBQYoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706573678; c=relaxed/simple;
	bh=V3Szgd6mAQG1ZhPQ3NrVXBfiwPaXNxU5t+WMiXVPJ68=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=XlPdfxlf4AKjSCugVRAebRq61nxmQIx1ngnn2Q25Kk7IP8XUBMgsGIFS7UJCcr657u6xsvS5GndBXBmmQOmOJnWPxZ7/yVX2eZN9CqH/F2QdlgEXSn4uMxIR5L4bgxigjuwp8GC0EAp2rMx4ajKKUy6XRe+JMgYkUkg/lU1Ceyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EmPFQL83; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FF32C433F1;
	Tue, 30 Jan 2024 00:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706573678;
	bh=V3Szgd6mAQG1ZhPQ3NrVXBfiwPaXNxU5t+WMiXVPJ68=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=EmPFQL83yKl/w8/E6UFtuSUmnL1Ygrv5hIjMh49URoZlmCY+zJN6Y7c4Y744ueo4+
	 YP/sZ+MhVnZJD2wJ4kWe/8/dbloz56MRvRJT7HMhP/nRT/Tcm6ql4SIo6bkq/rCqof
	 EzD9FqF92qR7nrWDN6pMrShjkOl9xf5OnJWh+g+txzalatMkW7rY1eLfXv5FF7/jvc
	 rM6L13JL0YUSJJDwKCZxkY1oJ2LitlfKVd59wTooQ6tLRSo5YnikaU7icaHnp76hQ5
	 9BuC1Z+UiMfeYZBaEWw0jghO5vqfeaO3ui0hP+Z5l8Ikaw7skBKH/K5smfpiO4Lj7s
	 ohsCf82A6CcZQ==
Date: Mon, 29 Jan 2024 18:14:36 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [RFC] PCI/AER: Block runtime suspend when handling errors
Message-ID: <20240130001436.GA488226@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123090016.281252-1-stanislaw.gruszka@linux.intel.com>

On Tue, Jan 23, 2024 at 10:00:16AM +0100, Stanislaw Gruszka wrote:
> PM runtime can be done simultaneously with AER error handling.
> Avoid that by using pm_runtime_get_sync() just after pci_dev_get()
> and pm_runtime_put() just before pci_dev_put() in AER recovery
> procedures.

I guess there must be a general rule here, like "PCI core must use
pm_runtime_get_sync() whenever touching the device asynchronously,
i.e., when it's doing something unrelated to a call from the driver"?

Probably would apply to all subsystem cores, not just PCI.

> I'm not sure about DPC case since I do not see get/put there. It
> just call pci_do_recovery() from threaded irq dcd_handler().
> I think pm_runtime* should be added to this handler as well.

s/dcd_handler/dpc_handler/

I'm guessing the "threaded" part really doesn't matter; just the fact
that this is in response to an interrupt, not something directly
called by a driver?

> pm_runtime_get_sync() will increase dev->power.usage_count counter to
> prevent any rpm actives. When there is suspending pending, it will wait
> for it and do the rpm resume. Not sure if that problem, on my testing
> I did not encounter issues with that.

Sorry, I didn't catch your meaning here.  IIUC, you can reproduce the
problem with the simultaneous aer_inject and rpm suspend/resume, and
this patch fixes it.

But there's some other scenario where you *don't* see the problem?

> I tested with igc device by doing simultaneous aer_inject and 
> rpm suspend/resume via /sys/bus/pci/devices/PCI_ID/power/control
> and can reproduce: 
> 
> [  853.253938] igc 0000:02:00.0: not ready 65535ms after bus reset; giving up
> [  853.253973] pcieport 0000:00:1c.2: AER: Root Port link has been reset (-25)
> [  853.253996] pcieport 0000:00:1c.2: AER: subordinate device reset failed
> [  853.254099] pcieport 0000:00:1c.2: AER: device recovery failed
> [  853.254178] igc 0000:02:00.0: Unable to change power state from D3hot to D0, device inaccessible

Drop the timestamps; they don't add to understanding the problem.

> The problem disappears when applied this patch.
> 
> Signed-off-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
> ---
>  drivers/pci/pcie/aer.c | 8 ++++++++
>  drivers/pci/pcie/edr.c | 3 +++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 42a3bd35a3e1..9b56460edc76 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -23,6 +23,7 @@
>  #include <linux/kernel.h>
>  #include <linux/errno.h>
>  #include <linux/pm.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/init.h>
>  #include <linux/interrupt.h>
>  #include <linux/delay.h>
> @@ -813,6 +814,7 @@ static int add_error_device(struct aer_err_info *e_info, struct pci_dev *dev)
>  {
>  	if (e_info->error_dev_num < AER_MAX_MULTI_ERR_DEVICES) {
>  		e_info->dev[e_info->error_dev_num] = pci_dev_get(dev);
> +		pm_runtime_get_sync(&dev->dev);
>  		e_info->error_dev_num++;
>  		return 0;
>  	}
> @@ -1111,6 +1113,8 @@ static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
>  {
>  	cxl_rch_handle_error(dev, info);
>  	pci_aer_handle_error(dev, info);
> +
> +	pm_runtime_put(&dev->dev);
>  	pci_dev_put(dev);
>  }
>  
> @@ -1143,6 +1147,8 @@ static void aer_recover_work_func(struct work_struct *work)
>  			       PCI_SLOT(entry.devfn), PCI_FUNC(entry.devfn));
>  			continue;
>  		}
> +		pm_runtime_get_sync(&pdev->dev);
> +
>  		pci_print_aer(pdev, entry.severity, entry.regs);
>  		/*
>  		 * Memory for aer_capability_regs(entry.regs) is being allocated from the
> @@ -1159,6 +1165,8 @@ static void aer_recover_work_func(struct work_struct *work)
>  		else if (entry.severity == AER_FATAL)
>  			pcie_do_recovery(pdev, pci_channel_io_frozen,
>  					 aer_root_reset);
> +
> +		pm_runtime_put(&pdev->dev);
>  		pci_dev_put(pdev);
>  	}
>  }
> diff --git a/drivers/pci/pcie/edr.c b/drivers/pci/pcie/edr.c
> index 5f4914d313a1..bd96babd7249 100644
> --- a/drivers/pci/pcie/edr.c
> +++ b/drivers/pci/pcie/edr.c
> @@ -10,6 +10,7 @@
>  
>  #include <linux/pci.h>
>  #include <linux/pci-acpi.h>
> +#include <linux/pm_runtime.h>
>  
>  #include "portdrv.h"
>  #include "../pci.h"
> @@ -169,6 +170,7 @@ static void edr_handle_event(acpi_handle handle, u32 event, void *data)
>  		return;
>  	}
>  
> +	pm_runtime_get_sync(&edev->dev);
>  	pci_dbg(pdev, "Reported EDR dev: %s\n", pci_name(edev));
>  
>  	/* If port does not support DPC, just send the OST */
> @@ -209,6 +211,7 @@ static void edr_handle_event(acpi_handle handle, u32 event, void *data)
>  		acpi_send_edr_status(pdev, edev, EDR_OST_FAILED);
>  	}
>  
> +	pm_runtime_put(&edev->dev);
>  	pci_dev_put(edev);
>  }
>  
> -- 
> 2.34.1
> 

