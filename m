Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F298C26E766
	for <lists+linux-pci@lfdr.de>; Thu, 17 Sep 2020 23:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbgIQV0q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Sep 2020 17:26:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:49468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbgIQV0q (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 17 Sep 2020 17:26:46 -0400
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7EFB20870;
        Thu, 17 Sep 2020 21:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600378006;
        bh=gF+5IgcT5tyscHTKZfeKEWonoMbz0ayftxl3bZmgBbY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=b/pnKilZiL18lo6zys3sWSx17R/M9l4/H73GJicOe589bt5PVVnhi3/tnjEPIHZ0I
         qN5YCJ/1j47TWc6Ixy0YuO89HyqqnEwW1rKwou7QTpkZOYUEaRnagGOdmalCaF0XeC
         mq59Z6q2GGdrlGMmmjfWS1LXetCkWBT1aqxxn578=
Date:   Thu, 17 Sep 2020 16:26:44 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Keith Busch <kbusch@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Simplify pci_dev_reset_slot_function()
Message-ID: <20200917212644.GA1739569@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6aab5af096f7b1b3db57f6335cebba8f0fcca89.1595330431.git.lukas@wunner.de>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 21, 2020 at 01:24:51PM +0200, Lukas Wunner wrote:
> pci_dev_reset_slot_function() refuses to reset a hotplug slot if it is
> shared by multiple pci_devs.  That's the case if and only if the slot is
> occupied by a multifunction device.
> 
> Simplify the function to check the device's multifunction flag instead
> of iterating over the devices on the bus.  (Iterating over the devices
> requires holding pci_bus_sem, which the function erroneously does not
> acquire.)
> 
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: Alex Williamson <alex.williamson@redhat.com>

Applied to pci/misc for v5.10, thanks!

> ---
>  drivers/pci/pci.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 455da72..b406611 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4914,16 +4914,10 @@ static int pci_reset_hotplug_slot(struct hotplug_slot *hotplug, int probe)
>  
>  static int pci_dev_reset_slot_function(struct pci_dev *dev, int probe)
>  {
> -	struct pci_dev *pdev;
> -
> -	if (dev->subordinate || !dev->slot ||
> +	if (dev->multifunction || dev->subordinate || !dev->slot ||
>  	    dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET)
>  		return -ENOTTY;
>  
> -	list_for_each_entry(pdev, &dev->bus->devices, bus_list)
> -		if (pdev != dev && pdev->slot == dev->slot)
> -			return -ENOTTY;
> -
>  	return pci_reset_hotplug_slot(dev->slot->hotplug, probe);
>  }
>  
> -- 
> 2.27.0
> 
