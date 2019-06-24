Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21D54505D6
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2019 11:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbfFXJey (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jun 2019 05:34:54 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:45389 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726331AbfFXJey (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Jun 2019 05:34:54 -0400
Received: from 79.184.254.216.ipv4.supernova.orange.pl (79.184.254.216) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id cf7b2722c211f831; Mon, 24 Jun 2019 11:34:50 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Frederick Lawler <fred@fredlawl.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Sinan Kaya <okaya@kernel.org>,
        Kai Heng Feng <kai.heng.feng@canonical.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: pciehp: Do not disable interrupt twice on suspend
Date:   Mon, 24 Jun 2019 11:34:50 +0200
Message-ID: <2291470.PqBgM8dDTm@kreacher>
In-Reply-To: <20190618125051.2382-1-mika.westerberg@linux.intel.com>
References: <20190618125051.2382-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tuesday, June 18, 2019 2:50:50 PM CEST Mika Westerberg wrote:
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
> Reported-by: Kai Heng Feng <kai.heng.feng@canonical.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/pci/hotplug/pciehp_core.c | 25 +++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
> index 6ad0d86762cb..3f8c13ddb3e8 100644
> --- a/drivers/pci/hotplug/pciehp_core.c
> +++ b/drivers/pci/hotplug/pciehp_core.c
> @@ -248,7 +248,7 @@ static bool pme_is_native(struct pcie_device *dev)
>  	return pcie_ports_native || host->native_pme;
>  }
>  
> -static int pciehp_suspend(struct pcie_device *dev)
> +static void pciehp_disable_interrupt(struct pcie_device *dev)
>  {
>  	/*
>  	 * Disable hotplug interrupt so that it does not trigger
> @@ -256,7 +256,19 @@ static int pciehp_suspend(struct pcie_device *dev)
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
> @@ -274,6 +286,7 @@ static int pciehp_resume_noirq(struct pcie_device *dev)
>  
>  	return 0;
>  }
> +#endif
>  
>  static int pciehp_resume(struct pcie_device *dev)
>  {
> @@ -287,6 +300,12 @@ static int pciehp_resume(struct pcie_device *dev)
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
> @@ -313,10 +332,12 @@ static struct pcie_port_service_driver hpdriver_portdrv = {
>  	.remove		= pciehp_remove,
>  
>  #ifdef	CONFIG_PM
> +#ifdef	CONFIG_PM_SLEEP
>  	.suspend	= pciehp_suspend,
>  	.resume_noirq	= pciehp_resume_noirq,
> +#endif
>  	.resume		= pciehp_resume,
> -	.runtime_suspend = pciehp_suspend,
> +	.runtime_suspend = pciehp_runtime_suspend,
>  	.runtime_resume	= pciehp_runtime_resume,
>  #endif	/* PM */
>  };
> 




