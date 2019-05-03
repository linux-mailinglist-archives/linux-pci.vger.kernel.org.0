Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42BC413449
	for <lists+linux-pci@lfdr.de>; Fri,  3 May 2019 22:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbfECUEl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 May 2019 16:04:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:45558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725793AbfECUEk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 3 May 2019 16:04:40 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AA49206BB;
        Fri,  3 May 2019 20:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556913879;
        bh=bqpiuHplciGYYVGXRGGsx5652IaGTS8bIlknkgj/3Wk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bF31MeNhhlnxwUgjxB340PgJUfm+LawbTZhFeBmncbZV2YSaRIXPxuhW+UVi4LtHn
         v+lAuY2ZDjoEYg6HQxlRMaU0NjHNKCORxUyiY36jjSLJd8HGPFt2pAqX3An/XaP3OQ
         tUaVelBDzQvccek3gd5VAbNoRJxrbEwXHXvBTGEg=
Date:   Fri, 3 May 2019 15:04:37 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Frederick Lawler <fred@fredlawl.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mika.westerberg@linux.intel.com, lukas@wunner.de,
        andriy.shevchenko@linux.intel.com, keith.busch@intel.com,
        mr.nuke.me@gmail.com, liudongdong3@huawei.com, thesven73@gmail.com
Subject: Re: [PATCH v2 6/9] PCI: hotplug: Prefix dmesg logs with PCIe service
 name
Message-ID: <20190503200437.GD180403@google.com>
References: <20190503035946.23608-1-fred@fredlawl.com>
 <20190503035946.23608-7-fred@fredlawl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190503035946.23608-7-fred@fredlawl.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 02, 2019 at 10:59:43PM -0500, Frederick Lawler wrote:
> Prefix dmesg logs with PCIe service name.
> 
> Signed-off-by: Frederick Lawler <fred@fredlawl.com>
> ---
>  drivers/pci/hotplug/pciehp.h      | 18 +++++++++---------
>  drivers/pci/hotplug/pciehp_core.c |  7 +++++--
>  drivers/pci/hotplug/pciehp_ctrl.c |  2 ++
>  drivers/pci/hotplug/pciehp_hpc.c  |  4 +++-
>  drivers/pci/hotplug/pciehp_pci.c  |  2 ++
>  5 files changed, 21 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
> index 506e1d923a1f..78325c8d961e 100644
> --- a/drivers/pci/hotplug/pciehp.h
> +++ b/drivers/pci/hotplug/pciehp.h
> @@ -34,27 +34,27 @@ extern bool pciehp_debug;
>  #define dbg(format, arg...)						\
>  do {									\
>  	if (pciehp_debug)						\
> -		printk(KERN_DEBUG "%s: " format, MY_NAME, ## arg);	\
> +		pr_info(format, ## arg);				\

This and

>  #define ctrl_dbg(ctrl, format, arg...)					\
>  	do {								\
>  		if (pciehp_debug)					\
> -			dev_printk(KERN_DEBUG, &ctrl->pcie->device,	\
> -					format, ## arg);		\
> +			pci_info(ctrl->pcie->port,			\
> +				 format, ## arg);			\

this are not like the others.  I think replacing the special-purpose
pciehp_debug with the generic dynamic debug thing is a good thing, but
I'd do it in a separate patch, e.g.,

  - if (pciehp_debug)
  -   printk(KERN_DEBUG ...);
  + pr_dbg(...);

And that patch should also remove the pciehp_debug module parameter
and documentation at the same time, of course.

And the commit log should include an example of how to turn on these
messages, boot with "dyndbg='...'".  I don't know what the magic
string there needs to be, so it'd be nice to have it in the commit log
and in a comment near the dbg() and ctrl_dbg() definitions.

>  	} while (0)
>  #define ctrl_err(ctrl, format, arg...)					\
> -	dev_err(&ctrl->pcie->device, format, ## arg)
> +	pci_err(ctrl->pcie->port, format, ## arg)
>  #define ctrl_info(ctrl, format, arg...)					\
> -	dev_info(&ctrl->pcie->device, format, ## arg)
> +	pci_info(ctrl->pcie->port, format, ## arg)
>  #define ctrl_warn(ctrl, format, arg...)					\
> -	dev_warn(&ctrl->pcie->device, format, ## arg)
> +	pci_warn(ctrl->pcie->port, format, ## arg)
>  
>  #define SLOT_NAME_SIZE 10
>  
> diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
> index fc5366b50e95..7e06a0f9e644 100644
> --- a/drivers/pci/hotplug/pciehp_core.c
> +++ b/drivers/pci/hotplug/pciehp_core.c
> @@ -17,6 +17,9 @@
>   *   Dely Sy <dely.l.sy@intel.com>"
>   */
>  
> +#define pr_fmt(fmt) "pciehp: " fmt
> +#define dev_fmt pr_fmt

Can these go in pciehp.h?
