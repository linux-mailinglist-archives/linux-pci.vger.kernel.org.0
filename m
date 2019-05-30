Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B08F52FC9D
	for <lists+linux-pci@lfdr.de>; Thu, 30 May 2019 15:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbfE3Nr3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 May 2019 09:47:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:36522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbfE3Nr3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 May 2019 09:47:29 -0400
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F55224D63;
        Thu, 30 May 2019 13:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559224048;
        bh=A92l+U2UOxsuYqmLO7ARav2xbj2vY8rqGFS+l5tOKqw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JEQOI6VMjjOTypef8/fdAzWHo0LQkUqsjccwMbVHLb/Zb68gI2R3YuCsHMo5E8qFQ
         D6CH8s56YAGHWAnDK1olI/J5jLwSV6zgbrl0S61zemvxi49hYYQG9mbiDdvlamVKFV
         XYokg6bD8XMjiMuLUKik4RqRT1ob68yRl22lVej4=
Date:   Thu, 30 May 2019 08:47:27 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        myron.stowe@redhat.com, bodong@mellanox.com, eli@mellanox.com,
        laine@redhat.com
Subject: Re: [PATCH] PCI: Return error if cannot probe VF
Message-ID: <20190530134727.GM28250@google.com>
References: <155672991496.20698.4279330795743262888.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155672991496.20698.4279330795743262888.stgit@gimli.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 01, 2019 at 11:00:16AM -0600, Alex Williamson wrote:
> Commit 0e7df22401a3 ("PCI: Add sysfs sriov_drivers_autoprobe to control
> VF driver binding") allows the user to specify that drivers for VFs of
> a PF should not be probed, but it actually causes pci_device_probe() to
> return success back to the driver core in this case.  Therefore by all
> sysfs appearances the device is bound to a driver, the driver link from
> the device exists as does the device link back from the driver, yet the
> driver's probe function is never called on the device.  We also fail to
> do any sort of cleanup when we're prohibited from probing the device,
> the irq setup remains in place and we even hold a device reference.
> 
> Instead, abort with errno before any setup or references are taken when
> pci_device_can_probe() prevents us from trying to probe the device.
> 
> Fixes: 0e7df22401a3 ("PCI: Add sysfs sriov_drivers_autoprobe to control VF driver binding")
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>

Applied to pci/enumeration for v5.3, thanks!

The scenario you describe, Laine, indeed sounds cumbersome.  If you
want to propose an alternate or additional patch to address that, or
if you think Alex's patch will make it harder to clean up that
scenario, I'm all ears.  But it seems like Alex's patch is an
improvement even if it leaves some problems unsolved.

> ---
> 
> This issue is easily tested by disabling sriov_drivers_autoprobe and
> creating VFs:
> 
> # echo 0 > sriov_drivers_autoprobe
> # echo 3 > sriov_numvfs
> # readlink -f virtfn*/driver
> /sys/bus/pci/drivers/iavf
> /sys/bus/pci/drivers/iavf
> /sys/bus/pci/drivers/iavf
> (yet no netdevs exist for these VFs)
> 
> The semantics of this autoprobe disabling are a bit strange for the
> user as well, I suppose it works if we force a bind through a driver's
> bind attribute, but tools like libvirt and driverctl expect to bind
> devices by setting the driver_override and then pushing the device
> through driver_probe on the bus.  Is the intention of disabling
> "autoprobe" that a driver_override should still work?  Otherwise the
> user needs to set the driver_override for each VF, re-enable
> sriov_drivers_autoprobe on the PF, and then probe the VFs.  Thus maybe
> pci_device_can_probe() should allow probes of the driver_override
> driver?  Thanks,
> 
> Alex
> 
>  drivers/pci/pci-driver.c |   13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 71853befd435..da7b82e56c83 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -414,6 +414,9 @@ static int pci_device_probe(struct device *dev)
>  	struct pci_dev *pci_dev = to_pci_dev(dev);
>  	struct pci_driver *drv = to_pci_driver(dev->driver);
>  
> +	if (!pci_device_can_probe(pci_dev))
> +		return -ENODEV;
> +
>  	pci_assign_irq(pci_dev);
>  
>  	error = pcibios_alloc_irq(pci_dev);
> @@ -421,12 +424,10 @@ static int pci_device_probe(struct device *dev)
>  		return error;
>  
>  	pci_dev_get(pci_dev);
> -	if (pci_device_can_probe(pci_dev)) {
> -		error = __pci_device_probe(drv, pci_dev);
> -		if (error) {
> -			pcibios_free_irq(pci_dev);
> -			pci_dev_put(pci_dev);
> -		}
> +	error = __pci_device_probe(drv, pci_dev);
> +	if (error) {
> +		pcibios_free_irq(pci_dev);
> +		pci_dev_put(pci_dev);
>  	}
>  
>  	return error;
> 
