Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 862FBF304F
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2019 14:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388856AbfKGNoc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Nov 2019 08:44:32 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:41233 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730980AbfKGNoc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Nov 2019 08:44:32 -0500
Received: from 79.184.254.83.ipv4.supernova.orange.pl (79.184.254.83) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id 12ad8148bb496b03; Thu, 7 Nov 2019 14:44:30 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] PCI: Introduce pcie_wait_for_link_delay()
Date:   Thu, 07 Nov 2019 14:44:29 +0100
Message-ID: <12302896.6UPH59xr33@kreacher>
In-Reply-To: <20191107121847.24781-2-mika.westerberg@linux.intel.com>
References: <20191107121847.24781-1-mika.westerberg@linux.intel.com> <20191107121847.24781-2-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thursday, November 7, 2019 1:18:46 PM CET Mika Westerberg wrote:
> This is otherwise similar to pcie_wait_for_link() but allows passing
> custom activation delay in milliseconds.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

No issues found:

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/pci/pci.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index ecc775793c3c..7083adc07f5c 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4588,14 +4588,17 @@ static int pci_pm_reset(struct pci_dev *dev, int probe)
>  
>  	return pci_dev_wait(dev, "PM D3hot->D0", PCIE_RESET_READY_POLL_MS);
>  }
> +
>  /**
> - * pcie_wait_for_link - Wait until link is active or inactive
> + * pcie_wait_for_link_delay - Wait until link is active or inactive
>   * @pdev: Bridge device
>   * @active: waiting for active or inactive?
> + * @delay: Delay to wait after link has become active (in ms)
>   *
>   * Use this to wait till link becomes active or inactive.
>   */
> -bool pcie_wait_for_link(struct pci_dev *pdev, bool active)
> +static bool pcie_wait_for_link_delay(struct pci_dev *pdev, bool active,
> +				     int delay)
>  {
>  	int timeout = 1000;
>  	bool ret;
> @@ -4632,13 +4635,25 @@ bool pcie_wait_for_link(struct pci_dev *pdev, bool active)
>  		timeout -= 10;
>  	}
>  	if (active && ret)
> -		msleep(100);
> +		msleep(delay);
>  	else if (ret != active)
>  		pci_info(pdev, "Data Link Layer Link Active not %s in 1000 msec\n",
>  			active ? "set" : "cleared");
>  	return ret == active;
>  }
>  
> +/**
> + * pcie_wait_for_link - Wait until link is active or inactive
> + * @pdev: Bridge device
> + * @active: waiting for active or inactive?
> + *
> + * Use this to wait till link becomes active or inactive.
> + */
> +bool pcie_wait_for_link(struct pci_dev *pdev, bool active)
> +{
> +	return pcie_wait_for_link_delay(pdev, active, 100);
> +}
> +
>  void pci_reset_secondary_bus(struct pci_dev *dev)
>  {
>  	u16 ctrl;
> 




