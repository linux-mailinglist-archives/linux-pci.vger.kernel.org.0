Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACFDCD6077
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2019 12:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731487AbfJNKp0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Oct 2019 06:45:26 -0400
Received: from foss.arm.com ([217.140.110.172]:40298 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731305AbfJNKp0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 14 Oct 2019 06:45:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42078337;
        Mon, 14 Oct 2019 03:45:25 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AD6B33F718;
        Mon, 14 Oct 2019 03:45:24 -0700 (PDT)
Date:   Mon, 14 Oct 2019 11:45:23 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     bhelgaas@google.com, lorenzo.pieralisi@arm.com, treding@nvidia.com,
        jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        linux-pci@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH] PCI: Add CRS timeout for pci_device_is_present()
Message-ID: <20191014104522.GR42880@e119886-lin.cambridge.arm.com>
References: <20191005182129.32538-1-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191005182129.32538-1-vidyas@nvidia.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Oct 05, 2019 at 11:51:29PM +0530, Vidya Sagar wrote:
> Adds a 60 seconds timeout to consider CRS (Configuration request Retry
> Status) from a downstream device when Vendor ID read is attempted by
> an upstream device. This helps to work with devices that return CRS
> during system resume. This also makes pci_device_is_present() consistent
> with the probe path where 60 seconds timeout is already being used.

This looks like a good idea.

> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
>  drivers/pci/pci.c   | 3 ++-
>  drivers/pci/pci.h   | 2 ++
>  drivers/pci/probe.c | 2 +-
>  3 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 95dc78ebdded..3ab9f6d3c8a6 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5905,7 +5905,8 @@ bool pci_device_is_present(struct pci_dev *pdev)
>  
>  	if (pci_dev_is_disconnected(pdev))
>  		return false;
> -	return pci_bus_read_dev_vendor_id(pdev->bus, pdev->devfn, &v, 0);
> +	return pci_bus_read_dev_vendor_id(pdev->bus, pdev->devfn, &v,
> +					  PCI_CRS_TIMEOUT);
>  }
>  EXPORT_SYMBOL_GPL(pci_device_is_present);
>  
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 3f6947ee3324..aa25c5fdc6a5 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -4,6 +4,8 @@
>  
>  #include <linux/pci.h>
>  
> +#define PCI_CRS_TIMEOUT		(60 * 1000)	/* 60 sec*/
> +

This has the same value as PCIE_RESET_READY_POLL_MS defined in pci.c, when
I look at how PCIE_RESET_READY_POLL_MS is used, it seems that we have two
nearly identical ways to handle the same thing.

pci_dev_wait - this seems to be specifically used for handling SV CRS when
reading the vendor ID.

pci_dev_wait - this seems to be used after FLR, AF_FLR, bus reset and D3-D0,
in all the use-cases the timeout is 60 seconds. This function waits for
the function to return a non-CRS completion - however it doesn't rely on
the SV value of 0x0001.

What is the reason that pci_dev_wait polls on PCI_COMMAND instead of a SV
CRS value? (Is this a hack to gain some CPU time on RC's without SV? I.e.
rather than the hardware retrying, it just gives up allowing us to retry).

Is there any reason why these two functions can be combined?

>  #define PCI_FIND_CAP_TTL	48
>  
>  #define PCI_VSEC_ID_INTEL_TBT	0x1234	/* Thunderbolt */
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 7c5d68b807ef..6e44a03283c8 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2258,7 +2258,7 @@ static struct pci_dev *pci_scan_device(struct pci_bus *bus, int devfn)
>  	struct pci_dev *dev;
>  	u32 l;
>  
> -	if (!pci_bus_read_dev_vendor_id(bus, devfn, &l, 60*1000))
> +	if (!pci_bus_read_dev_vendor_id(bus, devfn, &l, PCI_CRS_TIMEOUT))

Should you also fix up acpiphp_add_context in drivers/pci/hotplug/acpiphp_glue.c
to use PCI_CRS_TIMEOUT?

Thanks,

Andrew Murray

>  		return NULL;
>  
>  	dev = pci_alloc_dev(bus);
> -- 
> 2.17.1
> 
