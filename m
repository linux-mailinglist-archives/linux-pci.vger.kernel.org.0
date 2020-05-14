Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19D231D413C
	for <lists+linux-pci@lfdr.de>; Fri, 15 May 2020 00:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbgENWlf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 May 2020 18:41:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:46174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728313AbgENWlf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 14 May 2020 18:41:35 -0400
Received: from localhost (mobile-166-175-190-200.mycingular.net [166.175.190.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0A2A2065C;
        Thu, 14 May 2020 22:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589496094;
        bh=IjzmQx+HWa7b7Wx6H1iHnRYh3o17Ce8clVcaTLEjs/Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=TOea4ygC94+bo9zd3zqtKUqyQaarlb5vGfNizN5JCpKP+veBacQnXG9zrlMyBvxFr
         B1nHEf9V3wF0jv03h4jnUeL1aDhqmqw7kcF+3v21CLg7MHaS3hXO3hFU/4TIPPYv0s
         Xdd8Agkw7zmIUa44Oe5Bn3XheMKnF0tltZ8hAuLs=
Date:   Thu, 14 May 2020 17:41:32 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI: Do not use pcie_get_speed_cap() to determine
 when to start waiting
Message-ID: <20200514224132.GA476999@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514133043.27429-1-mika.westerberg@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 14, 2020 at 04:30:43PM +0300, Mika Westerberg wrote:
> Kai-Heng Feng reported that it takes long time (>1s) to resume
> Thunderbolt connected PCIe devices from both runtime suspend and system
> sleep (s2idle).
> 
> These PCIe downstream ports the second link capability (PCI_EXP_LNKCAP2)
> announces support for speeds > 5 GT/s but it is then capped by the
> second link control (PCI_EXP_LNKCTL2) register to 2.5 GT/s. This
> possiblity was not considered in pci_bridge_wait_for_secondary_bus() so
> it ended up waiting for 1100 ms as these ports do not support active
> link layer reporting either.

I don't think PCI_EXP_LNKCTL2 is relevant here.  I think the lack of
Data Link Layer Link Active is just a chip erratum.  Is that
documented anywhere?

> PCIe spec 5.0 section 6.6.1 mandates that we must wait minimum of 100 ms
> before sending configuration request to the device below, if the port
> does not support speeds > 5 GT/s, and if it does we first need to wait
> for the data link layer to become active before waiting for that 100 ms.
> 
> PCIe spec 5.0 section 7.5.3.6 further says that all downstream ports
> that support speeds > 5 GT/s must support active link layer reporting so
> instead of looking for the speed we can check for the active link layer
> reporting capability and determine how to wait based on that (as they go
> hand in hand).
> 
> While there restructure the code a bit so that the delay is always
> issued in pci_bridge_wait_for_secondary_bus() by passing value of 0 to
> pcie_wait_for_link_delay().
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206837
> Reported-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
> v2: Restructured the code a bit so that it should be more readable now
> 
> Previous version can be found here:
> 
>   https://lore.kernel.org/linux-pci/20200514123105.GW2571@lahna.fi.intel.com/
> 
> @Kai-heng, since this patch is slightly different than what you tried, I
> wonder if you could check that it still solves the and does not break
> anything? I tested it myself but it would be nice to get your Tested-by to
> make sure it still works.
> 
>  drivers/pci/pci.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 595fcf59843f..590c73dc7e0d 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4660,7 +4660,8 @@ static int pci_pm_reset(struct pci_dev *dev, int probe)
>   * pcie_wait_for_link_delay - Wait until link is active or inactive
>   * @pdev: Bridge device
>   * @active: waiting for active or inactive?
> - * @delay: Delay to wait after link has become active (in ms)
> + * @delay: Delay to wait after link has become active (in ms). Specify %0
> + *	   for no delay.
>   *
>   * Use this to wait till link becomes active or inactive.
>   */
> @@ -4701,7 +4702,7 @@ static bool pcie_wait_for_link_delay(struct pci_dev *pdev, bool active,
>  		msleep(10);
>  		timeout -= 10;
>  	}

I think maybe the code above (not included in the context here) should
say:

  if (!pdev->link_active_reporting) {
    msleep(timeout + delay);
    return true;
  }

to match the rest of 4827d63891b6 ("PCI/PM: Add
pcie_wait_for_link_delay()").  What do you think?  If you agree, I'd
make that a separate patch because it's not related to the current
fix.

> -	if (active && ret)
> +	if (active && ret && delay)
>  		msleep(delay);
>  	else if (ret != active)
>  		pci_info(pdev, "Data Link Layer Link Active not %s in 1000 msec\n",
> @@ -4822,17 +4823,21 @@ void pci_bridge_wait_for_secondary_bus(struct pci_dev *dev)
>  	if (!pcie_downstream_port(dev))
>  		return;
>  
> -	if (pcie_get_speed_cap(dev) <= PCIE_SPEED_5_0GT) {
> -		pci_dbg(dev, "waiting %d ms for downstream link\n", delay);
> -		msleep(delay);
> -	} else {
> -		pci_dbg(dev, "waiting %d ms for downstream link, after activation\n",
> -			delay);
> -		if (!pcie_wait_for_link_delay(dev, true, delay)) {
> +	/*
> +	 * Since PCIe spec mandates that all downstream ports that support
> +	 * speeds greater than 5 GT/s must support data link layer active
> +	 * reporting so if it is supported we poll for the link to become
> +	 * active before issuing the mandatory delay.
> +	 */
> +	if (dev->link_active_reporting) {
> +		pci_dbg(dev, "waiting for link to train\n");
> +		if (!pcie_wait_for_link_delay(dev, true, 0)) {
>  			/* Did not train, no need to wait any further */
>  			return;
>  		}
>  	}
> +	pci_dbg(child, "waiting %d ms to become accessible\n", delay);
> +	msleep(delay);

Nice solution, I like this a lot.

>  	if (!pci_device_is_present(child)) {
>  		pci_dbg(child, "waiting additional %d ms to become accessible\n", delay);
> -- 
> 2.26.2
> 
