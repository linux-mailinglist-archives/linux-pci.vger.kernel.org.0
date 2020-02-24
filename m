Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65E0316A86C
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2020 15:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgBXOey (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Feb 2020 09:34:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:47268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727803AbgBXOex (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 24 Feb 2020 09:34:53 -0500
Received: from localhost (52.sub-174-234-140.myvzw.com [174.234.140.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB98A20828;
        Mon, 24 Feb 2020 14:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582554892;
        bh=W6kuyk+ZexlPQqz1Y2ESk0asCrC2HL338zsAXCXP1nc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=SgxTU184UhE7sRP6uqafIWldtoXSYBFgyjilOfUG1Ht1PxiWFF28khancglSApP3E
         yRQxL1a3osOLQEqHHHNOh+cpKy2VLJDSV0VhATuU+E679grWnGr47Y2EQjp0bsGKVz
         vqUsKQHMgVu4miS4SNWWCH+Pd82txXrv1zv0rTCw=
Date:   Mon, 24 Feb 2020 08:34:50 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Stanislav Spassov <stanspas@amazon.com>
Cc:     linux-pci@vger.kernel.org, Stanislav Spassov <stanspas@amazon.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan H =?iso-8859-1?Q?=2E_Sch=F6nherr?= <jschoenh@amazon.de>,
        Wei Wang <wawei@amazon.de>, Ashok Raj <ashok.raj@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Sinan Kaya <okaya@kernel.org>, Rajat Jain <rajatja@google.com>
Subject: Re: [PATCH 2/3] PCI: Introduce per-device reset_ready_poll override
Message-ID: <20200224143450.GA219843@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200223122057.6504-3-stanspas@amazon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Ashok, Alex, Sinan, Rajat]

On Sun, Feb 23, 2020 at 01:20:56PM +0100, Stanislav Spassov wrote:
> From: Stanislav Spassov <stanspas@amazon.de>
> 
> A broken device may never become responsive after reset, hence the need
> for a timeout. However, waiting for too long can have unintended side
> effects such as triggering hung task timeouts for processes waiting on
> a lock held during the reset. Locks that are shared across multiple
> devices, such as VFIO's per-bus reflck, are especially problematic,
> because a single broken VF can cause hangs for processes working with
> other VFs on the same bus.
> 
> To allow lowering the global default post-reset timeout, while still
> accommodating devices that require more time, this patch introduces
> a per-device override that can be configured via a quirk.
> 
> Signed-off-by: Stanislav Spassov <stanspas@amazon.de>
> ---
>  drivers/pci/pci.c   | 19 ++++++++++++++-----
>  drivers/pci/probe.c |  2 ++
>  include/linux/pci.h |  1 +
>  3 files changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index db9b58ab6c68..a554818968ed 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1033,8 +1033,17 @@ void pci_wakeup_bus(struct pci_bus *bus)
>  		pci_walk_bus(bus, pci_wakeup, NULL);
>  }
>  
> -static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
> +static int pci_dev_get_reset_ready_poll_ms(struct pci_dev *dev)
>  {
> +	if (dev->reset_ready_poll_ms >= 0)
> +		return dev->reset_ready_poll_ms;
> +
> +	return pcie_reset_ready_poll_ms;
> +}
> +
> +static int pci_dev_wait(struct pci_dev *dev, char *reset_type)
> +{
> +	int timeout = pci_dev_get_reset_ready_poll_ms(dev);

I like the factoring out of the timeout, since all callers of
pci_dev_wait() supply the same value.  That could be its own separate
preliminary patch, e.g., simply

  -static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
  +static int pci_dev_wait(struct pci_dev *dev, char *reset_type)
   {
  +  int timeout = PCIE_RESET_READY_POLL_MS;
  ...
  -	return pci_dev_wait(dev, "FLR", PCIE_RESET_READY_POLL_MS);
  +	return pci_dev_wait(dev, "FLR");

I'm a little wary of "lowering the global default post-reset timeout"
because that's not safe in general.  For example, a hot-added device
that is completely spec compliant regarding post-reset timing may not
work correctly if we've lowered a global timeout.

>  	int delay = 1;
>  	u32 id;
>  
> @@ -4518,7 +4527,7 @@ int pcie_flr(struct pci_dev *dev)
>  	 */
>  	msleep(100);
>  
> -	return pci_dev_wait(dev, "FLR", pcie_reset_ready_poll_ms);
> +	return pci_dev_wait(dev, "FLR");
>  }
>  EXPORT_SYMBOL_GPL(pcie_flr);
>  
> @@ -4563,7 +4572,7 @@ static int pci_af_flr(struct pci_dev *dev, int probe)
>  	 */
>  	msleep(100);
>  
> -	return pci_dev_wait(dev, "AF_FLR", pcie_reset_ready_poll_ms);
> +	return pci_dev_wait(dev, "AF_FLR");
>  }
>  
>  /**
> @@ -4608,7 +4617,7 @@ static int pci_pm_reset(struct pci_dev *dev, int probe)
>  	pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, csr);
>  	pci_dev_d3_sleep(dev);
>  
> -	return pci_dev_wait(dev, "PM D3hot->D0", pcie_reset_ready_poll_ms);
> +	return pci_dev_wait(dev, "PM D3hot->D0");
>  }
>  
>  /**
> @@ -4838,7 +4847,7 @@ int pci_bridge_secondary_bus_reset(struct pci_dev *dev)
>  {
>  	pcibios_reset_secondary_bus(dev);
>  
> -	return pci_dev_wait(dev, "bus reset", pcie_reset_ready_poll_ms);
> +	return pci_dev_wait(dev, "bus reset");
>  }
>  EXPORT_SYMBOL_GPL(pci_bridge_secondary_bus_reset);
>  
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 512cb4312ddd..eeb79a45d504 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2166,6 +2166,8 @@ struct pci_dev *pci_alloc_dev(struct pci_bus *bus)
>  	if (!dev)
>  		return NULL;
>  
> +	dev->reset_ready_poll_ms = -1;
> +
>  	INIT_LIST_HEAD(&dev->bus_list);
>  	dev->dev.type = &pci_dev_type;
>  	dev->bus = pci_bus_get(bus);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 3840a541a9de..049a41b9412b 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -468,6 +468,7 @@ struct pci_dev {
>  	size_t		romlen;		/* Length if not from BAR */
>  	char		*driver_override; /* Driver name to force a match */
>  
> +	int		reset_ready_poll_ms;
>  	unsigned long	priv_flags;	/* Private flags for the PCI driver */
>  };
