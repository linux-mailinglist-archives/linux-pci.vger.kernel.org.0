Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD5B320B4D2
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jun 2020 17:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729669AbgFZPjJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Jun 2020 11:39:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:55770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726613AbgFZPjI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 26 Jun 2020 11:39:08 -0400
Received: from localhost (mobile-166-170-222-206.mycingular.net [166.170.222.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 301B720773;
        Fri, 26 Jun 2020 15:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593185948;
        bh=wZ7OWTnSecrf7D07hrerdFH+pIDkkrkHI6TyZ43C4OY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=g+vts0eFjefmiqi5onoMJ/9l7FfnI3aXem80MtyFtg3iWBMJ9Pxzbs+jX51NtgM1d
         lDmnxfa0+90uxMSnkCRI7WY1RQX10VnnsNMFX772+BALvhnuJ/QUoHrzS/1jK+ejmS
         zW9ol5x3OCMJmeDo2ax7nCIXEZUKlV8kq98qK4u0=
Date:   Fri, 26 Jun 2020 10:39:06 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Rajat Jain <rajatja@google.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, Raj Ashok <ashok.raj@intel.com>,
        lalithambika.krishnakumar@intel.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Prashant Malani <pmalani@google.com>,
        Benson Leung <bleung@google.com>,
        Todd Broch <tbroch@google.com>,
        Alex Levin <levinale@google.com>,
        Mattias Nissler <mnissler@google.com>,
        Rajat Jain <rajatxjain@gmail.com>,
        Bernie Keany <bernie.keany@intel.com>,
        Aaron Durbin <adurbin@google.com>,
        Diego Rivas <diegorivas@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Furquan Shaikh <furquan@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Christian Kellner <christian@kellner.me>,
        Alex Williamson <alex.williamson@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        oohall@gmail.com
Subject: Re: [PATCH 1/2] pci: Add pci device even if the driver failed to
 attach
Message-ID: <20200626153906.GA2897118@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626002710.110200-1-rajatja@google.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Nit: when you update these patches, can you run "git log --oneline
drivers/pci/bus.c" and make your subject lines match the convention?
E.g.,

  PCI: Add device even if driver attach failed

On Thu, Jun 25, 2020 at 05:27:09PM -0700, Rajat Jain wrote:
> device_attach() returning failure indicates a driver error
> while trying to probe the device. In such a scenario, the PCI
> device should still be added in the system and be visible to
> the user.

Nit: please wrap logs to fill 75 characters.  "git log" adds 4 spaces
at the beginning, so 75+4 still fits nicely in 80 columns without
wrapping.

> This patch partially reverts:
> commit ab1a187bba5c ("PCI: Check device_attach() return value always")
> 
> Signed-off-by: Rajat Jain <rajatja@google.com>
> ---
>  drivers/pci/bus.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index 8e40b3e6da77d..3cef835b375fd 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -322,12 +322,8 @@ void pci_bus_add_device(struct pci_dev *dev)
>  
>  	dev->match_driver = true;
>  	retval = device_attach(&dev->dev);
> -	if (retval < 0 && retval != -EPROBE_DEFER) {
> +	if (retval < 0 && retval != -EPROBE_DEFER)
>  		pci_warn(dev, "device attach failed (%d)\n", retval);
> -		pci_proc_detach_device(dev);
> -		pci_remove_sysfs_dev_files(dev);

Thanks for catching my bug!

> -		return;
> -	}
>  
>  	pci_dev_assign_added(dev, true);
>  }
> -- 
> 2.27.0.212.ge8ba1cc988-goog
> 
