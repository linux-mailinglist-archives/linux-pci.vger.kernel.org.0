Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C840426E717
	for <lists+linux-pci@lfdr.de>; Thu, 17 Sep 2020 23:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgIQVHk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Sep 2020 17:07:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:45288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbgIQVHj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 17 Sep 2020 17:07:39 -0400
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C34F421D43;
        Thu, 17 Sep 2020 21:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600376859;
        bh=EQfUDBlhoRI9gRaVYZ1s7QariAtSeMuaOPBzIMSUefI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=h55bVcPK5wlw1XqUHjIaiVvo4YLqIR/+GTNV8v4pxebwLamTJB8KLFHlr0Q/QLh+e
         MYfFVtPnWKydSAsGMB2N/VqtU3xyGJ6qSGOUtpNdWaVOFnkCCE5GcoS18FfysXb3gv
         63YDnzGnnvSSBsSF/LORkXVgRmO3FoIjciRCuW+U=
Date:   Thu, 17 Sep 2020 16:07:37 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linuxarm@huawei.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Peter Wu <peter@lekensteyn.nl>
Subject: Re: [PATCH] PCI: Make sure the bus bridge powered on when scanning
 bus
Message-ID: <20200917210737.GA1732082@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596022223-4765-1-git-send-email-yangyicong@hisilicon.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Mika, Rafael, Peter]

On Wed, Jul 29, 2020 at 07:30:23PM +0800, Yicong Yang wrote:
> When the bus bridge is runtime suspended, we'll fail to rescan
> the devices through sysfs as we cannot access the configuration
> space correctly when the bridge is in D3hot.
> It can be reproduced like:
> 
> $ echo 1 > /sys/bus/pci/devices/0000:80:00.0/0000:81:00.1/remove
> $ echo 1 > /sys/bus/pci/devices/0000:80:00.0/pci_bus/0000:81/rescan
>
> 0000:80:00.0 is root port and is runtime suspended and we cannot
> get 0000:81:00.1 after rescan.
> 
> Make bridge powered on when scanning the child bus, by adding
> pm_runtime_get_sync()/pm_runtime_put() in pci_scan_child_bus_extend().
> 
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
>  drivers/pci/probe.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 2f66988..5bb502b 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2795,6 +2795,14 @@ static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
>  
>  	dev_dbg(&bus->dev, "scanning bus\n");
>  
> +	/*
> +	 * Make sure the bus bridge is powered on, otherwise we may not be
> +	 * able to scan the devices as we may fail to access the configuration
> +	 * space of subordinates.
> +	 */
> +	if (bus->self)
> +		pm_runtime_get_sync(&bus->self->dev);

I think if we do this, we should be able to remove the call from
pci_scan_bridge() added by d963f6512e15 ("PCI: Power on bridges before
scanning new devices"), right?

The reason we need it here is because there are two paths to
pci_scan_child_bus_extend() and only one of them calls
pm_runtime_get_sync():

  pci_scan_bridge_extend
    pm_runtime_get_sync
    pci_scan_child_bus_extend

  pci_scan_child_bus
    pci_scan_child_bus_extend

If we move the pm_runtime_get_sync() from pci_scan_bridge_extend() to
pci_scan_child_bus_extend(), both paths should be safe.

>  	/* Go find them, Rover! */
>  	for (devfn = 0; devfn < 256; devfn += 8) {
>  		nr_devs = pci_scan_slot(bus, devfn);
> @@ -2907,6 +2915,9 @@ static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
>  		}
>  	}
>  
> +	if (bus->self)
> +		pm_runtime_put(&bus->self->dev);

I would probably do this:

  struct pci_dev *bridge = bus->self;

  if (bridge)
    pm_runtime_get_sync(&bridge->dev);
  ...
  if (bridge)
    pm_runtime_put(&bridge->dev);

>  	/*
>  	 * We've scanned the bus and so we know all about what's on
>  	 * the other side of any bridges that may be on this bus plus
> -- 
> 2.8.1
> 
