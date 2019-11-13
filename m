Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57B91FBC38
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2019 00:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbfKMXG7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Nov 2019 18:06:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:33566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726251AbfKMXG7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Nov 2019 18:06:59 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98092206E3;
        Wed, 13 Nov 2019 23:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573686418;
        bh=mlqi9LMSsVHfSL1Hny7iTFZmiFOzZQjuUqd3ZcWXsII=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=NNmD+2/3gxl9UIoz/xcwE7gQAQkOZQ8QvE3xF0N/64a/9hnokx2A26k1gXDOb52lV
         pcgsPKNFRjfMsx0JINpHX/mpUr6yWlMrf58zLOSn9UKFLj5qie4IJaUbTTh1Yi5y3N
         a5Zq2IufAo/JdS7P3LVGiWRNqi3KuknCX52aZ+rQ=
Date:   Wed, 13 Nov 2019 17:06:55 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Frederick Lawler <fred@fredlawl.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Sinan Kaya <okaya@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] PCI: pciehp: Do not disable interrupt twice on
 suspend
Message-ID: <20191113230655.GA99849@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029170022.57528-1-mika.westerberg@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 29, 2019 at 08:00:21PM +0300, Mika Westerberg wrote:
> We try to keep PCIe hotplug ports runtime suspended when entering system
> suspend. Due to the fact that the PCIe portdrv sets NEVER_SKIP driver PM
> flag the PM core always calls system suspend/resume hooks even if the
> device is left runtime suspended. Since PCIe hotplug driver re-uses the
> same function for both it ends up disabling hotplug interrupt twice and
> the second time following is printed:
> 
>   pciehp 0000:03:01.0:pcie204: pcie_do_write_cmd: no response from device
> 
> Prevent this from happening by checking whether the device is already
> runtime suspended when system suspend hook is called.
> 
> Fixes: 9c62f0bfb832 ("PCI: pciehp: Implement runtime PM callbacks")
> Reported-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Applied both to pci/hotplug for v5.5, thanks!

If it's convenient for you, a cover letter on multi-patch series would
make a good place for responses like this that apply to the whole
series.

> ---
> No changes from previous version.
> 
>  drivers/pci/hotplug/pciehp_core.c | 25 +++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
> index b3122c151b80..56daad828c9e 100644
> --- a/drivers/pci/hotplug/pciehp_core.c
> +++ b/drivers/pci/hotplug/pciehp_core.c
> @@ -253,7 +253,7 @@ static bool pme_is_native(struct pcie_device *dev)
>  	return pcie_ports_native || host->native_pme;
>  }
>  
> -static int pciehp_suspend(struct pcie_device *dev)
> +static void pciehp_disable_interrupt(struct pcie_device *dev)
>  {
>  	/*
>  	 * Disable hotplug interrupt so that it does not trigger
> @@ -261,7 +261,19 @@ static int pciehp_suspend(struct pcie_device *dev)
>  	 */
>  	if (pme_is_native(dev))
>  		pcie_disable_interrupt(get_service_data(dev));
> +}
>  
> +#ifdef CONFIG_PM_SLEEP
> +static int pciehp_suspend(struct pcie_device *dev)
> +{
> +	/*
> +	 * If the port is already runtime suspended we can keep it that
> +	 * way.
> +	 */
> +	if (dev_pm_smart_suspend_and_suspended(&dev->port->dev))
> +		return 0;
> +
> +	pciehp_disable_interrupt(dev);
>  	return 0;
>  }
>  
> @@ -279,6 +291,7 @@ static int pciehp_resume_noirq(struct pcie_device *dev)
>  
>  	return 0;
>  }
> +#endif
>  
>  static int pciehp_resume(struct pcie_device *dev)
>  {
> @@ -292,6 +305,12 @@ static int pciehp_resume(struct pcie_device *dev)
>  	return 0;
>  }
>  
> +static int pciehp_runtime_suspend(struct pcie_device *dev)
> +{
> +	pciehp_disable_interrupt(dev);
> +	return 0;
> +}
> +
>  static int pciehp_runtime_resume(struct pcie_device *dev)
>  {
>  	struct controller *ctrl = get_service_data(dev);
> @@ -318,10 +337,12 @@ static struct pcie_port_service_driver hpdriver_portdrv = {
>  	.remove		= pciehp_remove,
>  
>  #ifdef	CONFIG_PM
> +#ifdef	CONFIG_PM_SLEEP
>  	.suspend	= pciehp_suspend,
>  	.resume_noirq	= pciehp_resume_noirq,
>  	.resume		= pciehp_resume,
> -	.runtime_suspend = pciehp_suspend,
> +#endif
> +	.runtime_suspend = pciehp_runtime_suspend,
>  	.runtime_resume	= pciehp_runtime_resume,
>  #endif	/* PM */
>  };
> -- 
> 2.23.0
> 
