Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F32820B34D
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jun 2020 16:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728919AbgFZOOw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Jun 2020 10:14:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:55240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728489AbgFZOOw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 26 Jun 2020 10:14:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 846AE207D8;
        Fri, 26 Jun 2020 14:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593180891;
        bh=sN7O78kWzaOfq2AFXfpw7hyMcqTy+eQ7YRaBapD4TOA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QPTW8Ha/GJwy4+4ATZKyZWys7YBBw2w+XeJ3gJ+SKOdkBIpGe1i89ZF3PpifMyqzp
         Vm7LTL3lB7Ehx+qB5TJgKkf/RfiaLyeDNj9qe83EhBY/hsBlo5vfiPfOxqWWEwWR0X
         YX4VeveYm+UNgv2CnUv3OtOSldNj5orTIL8912ZM=
Date:   Fri, 26 Jun 2020 16:14:46 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
        Alex Williamson <alex.williamson@redhat.com>, oohall@gmail.com
Subject: Re: [PATCH 1/2] pci: Add pci device even if the driver failed to
 attach
Message-ID: <20200626141446.GA4141629@kroah.com>
References: <20200626002710.110200-1-rajatja@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626002710.110200-1-rajatja@google.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 25, 2020 at 05:27:09PM -0700, Rajat Jain wrote:
> device_attach() returning failure indicates a driver error
> while trying to probe the device. In such a scenario, the PCI
> device should still be added in the system and be visible to
> the user.
> 
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
> -		return;
> -	}

Nice catch, sysfs stuff shouldn't be dependant if a driver is bound to a
device or not.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
