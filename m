Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2D4C993F0
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2019 14:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725783AbfHVMiB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Aug 2019 08:38:01 -0400
Received: from zimbra2.kalray.eu ([92.103.151.219]:41878 "EHLO
        zimbra2.kalray.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729052AbfHVMiB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Aug 2019 08:38:01 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id CD98627E65B3;
        Thu, 22 Aug 2019 14:37:59 +0200 (CEST)
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id T1iT1EPvEIoG; Thu, 22 Aug 2019 14:37:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 5F90927E666C;
        Thu, 22 Aug 2019 14:37:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 5F90927E666C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
        s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1566477479;
        bh=aQw9A1g9cI3XUpS8jFSOKdXpFdrtxIkLZL7+5zjNWQw=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=bQHqxiTtjUjcVlq87ck/i4HrMC1cZMLAPt+wSXhifDKwGWfkWyiK0QMj0Ccm0I7Ds
         /X+oCb+mrqw0cibbGWNAJFWQc9HwmLCJjsM/56f4SjAh0j9rHZjf0FeW7fVN++WNpa
         NsIsiNgvL+3xhuq6V2A6+dRgRq8xl4PNEhh9Vyg8=
X-Virus-Scanned: amavisd-new at zimbra2.kalray.eu
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id woZOGyPyypH8; Thu, 22 Aug 2019 14:37:59 +0200 (CEST)
Received: from zimbra2.kalray.eu (zimbra2.kalray.eu [192.168.40.202])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 47D0927E65B3;
        Thu, 22 Aug 2019 14:37:59 +0200 (CEST)
Date:   Thu, 22 Aug 2019 14:37:59 +0200 (CEST)
From:   Marta Rybczynska <mrybczyn@kalray.eu>
To:     Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org, Bjorn Helgaas <helgaas@kernel.org>,
        linux@yadro.com, Srinath Mannam <srinath.mannam@broadcom.com>
Message-ID: <1907682156.57687176.1566477479224.JavaMail.zimbra@kalray.eu>
In-Reply-To: <20190816165101.911-2-s.miroshnichenko@yadro.com>
References: <20190816165101.911-1-s.miroshnichenko@yadro.com> <20190816165101.911-2-s.miroshnichenko@yadro.com>
Subject: Re: [PATCH v5 01/23] PCI: Fix race condition in
 pci_enable/disable_device()
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.40.202]
X-Mailer: Zimbra 8.8.12_GA_3794 (ZimbraWebClient - FF57 (Linux)/8.8.12_GA_3794)
Thread-Topic: Fix race condition in pci_enable/disable_device()
Thread-Index: O9C5qKK+P1vDneELlQbdEqY2P5q12A==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



----- On 16 Aug, 2019, at 18:50, Sergey Miroshnichenko s.miroshnichenko@yadro.com wrote:

> This is a yet another approach to fix an old [1-2] concurrency issue, when:
> - two or more devices are being hot-added into a bridge which was
>   initially empty;
> - a bridge with two or more devices is being hot-added;
> - during boot, if BIOS/bootloader/firmware doesn't pre-enable bridges.
> 
> The problem is that a bridge is reported as enabled before the MEM/IO bits
> are actually written to the PCI_COMMAND register, so another driver thread
> starts memory requests through the not-yet-enabled bridge:
> 
> CPU0                                        CPU1
> 
> pci_enable_device_mem()                     pci_enable_device_mem()
>   pci_enable_bridge()                         pci_enable_bridge()
>     pci_is_enabled()
>       return false;
>     atomic_inc_return(enable_cnt)
>     Start actual enabling the bridge
>     ...                                         pci_is_enabled()
>     ...                                           return true;
>     ...                                     Start memory requests <-- FAIL
>     ...
>     Set the PCI_COMMAND_MEMORY bit <-- Must wait for this
> 
> Protect the pci_enable/disable_device() and pci_enable_bridge(), which is
> similar to the previous solution from commit 40f11adc7cd9 ("PCI: Avoid race
> while enabling upstream bridges"), but adding a per-device mutexes and
> preventing the dev->enable_cnt from from incrementing early.
> 
> CC: Srinath Mannam <srinath.mannam@broadcom.com>
> CC: Marta Rybczynska <mrybczyn@kalray.eu>
> Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
> 
> [1]
> https://lore.kernel.org/linux-pci/1501858648-22228-1-git-send-email-srinath.mannam@broadcom.com/T/#u
>    [RFC PATCH v3] pci: Concurrency issue during pci enable bridge
> 
> [2]
> https://lore.kernel.org/linux-pci/744877924.5841545.1521630049567.JavaMail.zimbra@kalray.eu/T/#u
>    [RFC PATCH] nvme: avoid race-conditions when enabling devices
> ---
> drivers/pci/pci.c   | 26 ++++++++++++++++++++++----
> drivers/pci/probe.c |  1 +
> include/linux/pci.h |  1 +
> 3 files changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 1b27b5af3d55..e7f8c354e644 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1645,6 +1645,8 @@ static void pci_enable_bridge(struct pci_dev *dev)
> 	struct pci_dev *bridge;
> 	int retval;
> 
> +	mutex_lock(&dev->enable_mutex);
> +
> 	bridge = pci_upstream_bridge(dev);
> 	if (bridge)
> 		pci_enable_bridge(bridge);
> @@ -1652,6 +1654,7 @@ static void pci_enable_bridge(struct pci_dev *dev)
> 	if (pci_is_enabled(dev)) {
> 		if (!dev->is_busmaster)
> 			pci_set_master(dev);
> +		mutex_unlock(&dev->enable_mutex);
> 		return;
> 	}
> 

This code is used by numerous drivers and when we've seen that issue I was wondering
if there are some use-cases when this (or pci_disable_device) is called with interrupts
disabled. It seems that it shouldn't be, but a BUG_ON or error when someone calls
it this way would be helpful when debugging.

Marta
