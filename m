Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD3F7110D3
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2019 02:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbfEBA7A (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 May 2019 20:59:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38084 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726126AbfEBA7A (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 1 May 2019 20:59:00 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 58568309175F;
        Thu,  2 May 2019 00:59:00 +0000 (UTC)
Received: from vhost2.laine.org (ovpn-116-83.phx2.redhat.com [10.3.116.83])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B45C07E397;
        Thu,  2 May 2019 00:58:52 +0000 (UTC)
Subject: Re: [PATCH] PCI: Return error if cannot probe VF
To:     Alex Williamson <alex.williamson@redhat.com>,
        linux-pci@vger.kernel.org
Cc:     bhelgaas@google.com, linux-kernel@vger.kernel.org,
        myron.stowe@redhat.com, bodong@mellanox.com, eli@mellanox.com
References: <155672991496.20698.4279330795743262888.stgit@gimli.home>
From:   Laine Stump <laine@redhat.com>
Message-ID: <73b2057d-bae4-3780-18c3-5c999c633b74@redhat.com>
Date:   Wed, 1 May 2019 20:58:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <155672991496.20698.4279330795743262888.stgit@gimli.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Thu, 02 May 2019 00:59:00 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 5/1/19 1:00 PM, Alex Williamson wrote:
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
> driver?  


IMO, while the autoprobe feature is well intentioned, the current 
semantics are cumbersome at best. Not only do consumers need to set 
sriov_drivers_autoprobe=1 before setting driver_override=vfio-pci and 
reprobing the device in order to make it assignable to a vm with vfio, 
but prior to doing any of that they will also need to retrieve the 
original setting of autoprobe, save it off somewhere, and then after the 
vm is finished with the device, they will need to restore the saved 
value before removing driver_override and reprobing the device. It makes 
much more sense to me that the autoprobe setting be ignored if 
driver_override is set (if someone has gone to the trouble of setting 
driver_override, then it's pretty obvious that they really do want the 
device bound to that driver).



>Thanks,
> 
> Alex
> 
>   drivers/pci/pci-driver.c |   13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 71853befd435..da7b82e56c83 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -414,6 +414,9 @@ static int pci_device_probe(struct device *dev)
>   	struct pci_dev *pci_dev = to_pci_dev(dev);
>   	struct pci_driver *drv = to_pci_driver(dev->driver);
>   
> +	if (!pci_device_can_probe(pci_dev))
> +		return -ENODEV;
> +
>   	pci_assign_irq(pci_dev);
>   
>   	error = pcibios_alloc_irq(pci_dev);
> @@ -421,12 +424,10 @@ static int pci_device_probe(struct device *dev)
>   		return error;
>   
>   	pci_dev_get(pci_dev);
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
>   	}
>   
>   	return error;
> 

