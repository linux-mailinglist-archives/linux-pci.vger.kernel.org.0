Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CABE71D4770
	for <lists+linux-pci@lfdr.de>; Fri, 15 May 2020 09:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgEOH4P convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Fri, 15 May 2020 03:56:15 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45603 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726665AbgEOH4P (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 May 2020 03:56:15 -0400
Received: from mail-pg1-f200.google.com ([209.85.215.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jZVCW-0000dy-04
        for linux-pci@vger.kernel.org; Fri, 15 May 2020 07:56:12 +0000
Received: by mail-pg1-f200.google.com with SMTP id j21so1180693pgh.12
        for <linux-pci@vger.kernel.org>; Fri, 15 May 2020 00:56:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=dg5ovDRFp+uPqRA0ev9Ri9uYlnF4p8cZ1vOP+jQFnLM=;
        b=OwW4BjANkz/UzZ/f8kwI9RGvqRJ4bVnyyPK0IgQAnR9fPR5KYRU4DuO+FzfHQ0PFW0
         tbN3/2fuCqOJPoAwBg1zGDLT2pOuVjhRmYEBSRNv+8T5rLNeD0K7ZeyKfF63I7xtRVg6
         YBDf+2i+FMftHvcauC0Np/NB63wJPLc3JAlbL3nDyvvdCUvhAEw6O5Rk3c+LxsZA9EG0
         NOuglr37U6GOBXwTIOC/DCdwk++Nz7R9LhARM20as/aW4ZHZcypyeYpGIC3DePMtzj+b
         MUFVs+UhZCg/ZLLRHCSL85PJEcgOOZHPPyiX+lFbX351f8m2613aqEcRxygN+sUUdZxv
         ZG1A==
X-Gm-Message-State: AOAM530IM3l4r10wLGM1A/scGiQLEpUmHNGRQDZGQmBtdsd88SFbUFw9
        l8QiPHmY//aDTcOnpCypt1pTEzar1Z6fKqa5s+dnk8IVV3uMB/HN1H6lJrkjWuZMMV8Wtg4KDVr
        d8zY0UXkw79ZQfZ5AooU5huPQWGO/pgoQNAsF6w==
X-Received: by 2002:a17:90a:9202:: with SMTP id m2mr2132028pjo.109.1589529370345;
        Fri, 15 May 2020 00:56:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwPzXpuCS3atYMAGQahSiaARus9sO3POF1loZmWBgtZ11QugrDANUYXdZsDO3TG9wqJHbxWew==
X-Received: by 2002:a17:90a:9202:: with SMTP id m2mr2132009pjo.109.1589529369932;
        Fri, 15 May 2020 00:56:09 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id l9sm1305820pfd.5.2020.05.15.00.56.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 May 2020 00:56:09 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v2] PCI: Do not use pcie_get_speed_cap() to determine when
 to start waiting
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20200514133043.27429-1-mika.westerberg@linux.intel.com>
Date:   Fri, 15 May 2020 15:56:07 +0800
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pci@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <6C6E706B-5DE5-4758-AFA6-4A2963BEA8AF@canonical.com>
References: <20200514133043.27429-1-mika.westerberg@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> On May 14, 2020, at 21:30, Mika Westerberg <mika.westerberg@linux.intel.com> wrote:
> 
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
> 
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

Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Thanks!

> ---
> v2: Restructured the code a bit so that it should be more readable now
> 
> Previous version can be found here:
> 
>  https://lore.kernel.org/linux-pci/20200514123105.GW2571@lahna.fi.intel.com/
> 
> @Kai-heng, since this patch is slightly different than what you tried, I
> wonder if you could check that it still solves the and does not break
> anything? I tested it myself but it would be nice to get your Tested-by to
> make sure it still works.
> 
> drivers/pci/pci.c | 23 ++++++++++++++---------
> 1 file changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 595fcf59843f..590c73dc7e0d 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4660,7 +4660,8 @@ static int pci_pm_reset(struct pci_dev *dev, int probe)
>  * pcie_wait_for_link_delay - Wait until link is active or inactive
>  * @pdev: Bridge device
>  * @active: waiting for active or inactive?
> - * @delay: Delay to wait after link has become active (in ms)
> + * @delay: Delay to wait after link has become active (in ms). Specify %0
> + *	   for no delay.
>  *
>  * Use this to wait till link becomes active or inactive.
>  */
> @@ -4701,7 +4702,7 @@ static bool pcie_wait_for_link_delay(struct pci_dev *pdev, bool active,
> 		msleep(10);
> 		timeout -= 10;
> 	}
> -	if (active && ret)
> +	if (active && ret && delay)
> 		msleep(delay);
> 	else if (ret != active)
> 		pci_info(pdev, "Data Link Layer Link Active not %s in 1000 msec\n",
> @@ -4822,17 +4823,21 @@ void pci_bridge_wait_for_secondary_bus(struct pci_dev *dev)
> 	if (!pcie_downstream_port(dev))
> 		return;
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
> 			/* Did not train, no need to wait any further */
> 			return;
> 		}
> 	}
> +	pci_dbg(child, "waiting %d ms to become accessible\n", delay);
> +	msleep(delay);
> 
> 	if (!pci_device_is_present(child)) {
> 		pci_dbg(child, "waiting additional %d ms to become accessible\n", delay);
> -- 
> 2.26.2
> 

