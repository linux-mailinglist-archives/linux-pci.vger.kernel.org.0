Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23F8E2FDE4
	for <lists+linux-pci@lfdr.de>; Thu, 30 May 2019 16:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbfE3Odm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 May 2019 10:33:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48496 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726250AbfE3Odl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 May 2019 10:33:41 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8DBEB7EBAE;
        Thu, 30 May 2019 14:33:41 +0000 (UTC)
Received: from x1.home (ovpn-116-22.phx2.redhat.com [10.3.116.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2E90310027B6;
        Thu, 30 May 2019 14:33:36 +0000 (UTC)
Date:   Thu, 30 May 2019 08:33:35 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        myron.stowe@redhat.com, bodong@mellanox.com, eli@mellanox.com,
        laine@redhat.com
Subject: Re: [PATCH] PCI: Return error if cannot probe VF
Message-ID: <20190530083335.4f16a9bc@x1.home>
In-Reply-To: <20190530134727.GM28250@google.com>
References: <155672991496.20698.4279330795743262888.stgit@gimli.home>
        <20190530134727.GM28250@google.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 30 May 2019 14:33:41 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 30 May 2019 08:47:27 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Wed, May 01, 2019 at 11:00:16AM -0600, Alex Williamson wrote:
> > Commit 0e7df22401a3 ("PCI: Add sysfs sriov_drivers_autoprobe to control
> > VF driver binding") allows the user to specify that drivers for VFs of
> > a PF should not be probed, but it actually causes pci_device_probe() to
> > return success back to the driver core in this case.  Therefore by all
> > sysfs appearances the device is bound to a driver, the driver link from
> > the device exists as does the device link back from the driver, yet the
> > driver's probe function is never called on the device.  We also fail to
> > do any sort of cleanup when we're prohibited from probing the device,
> > the irq setup remains in place and we even hold a device reference.
> > 
> > Instead, abort with errno before any setup or references are taken when
> > pci_device_can_probe() prevents us from trying to probe the device.
> > 
> > Fixes: 0e7df22401a3 ("PCI: Add sysfs sriov_drivers_autoprobe to control VF driver binding")
> > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>  
> 
> Applied to pci/enumeration for v5.3, thanks!
> 
> The scenario you describe, Laine, indeed sounds cumbersome.  If you
> want to propose an alternate or additional patch to address that, or
> if you think Alex's patch will make it harder to clean up that
> scenario, I'm all ears.  But it seems like Alex's patch is an
> improvement even if it leaves some problems unsolved.

Hi Bjorn,

It's probably deeper in your queue, but I've posted:

https://patchwork.kernel.org/patch/10937577/

which allows devices with a driver_override to always probe.  I think
it gives us the more desirable usage model.  Thanks,

Alex


> > ---
> > 
> > This issue is easily tested by disabling sriov_drivers_autoprobe and
> > creating VFs:
> > 
> > # echo 0 > sriov_drivers_autoprobe
> > # echo 3 > sriov_numvfs
> > # readlink -f virtfn*/driver
> > /sys/bus/pci/drivers/iavf
> > /sys/bus/pci/drivers/iavf
> > /sys/bus/pci/drivers/iavf
> > (yet no netdevs exist for these VFs)
> > 
> > The semantics of this autoprobe disabling are a bit strange for the
> > user as well, I suppose it works if we force a bind through a driver's
> > bind attribute, but tools like libvirt and driverctl expect to bind
> > devices by setting the driver_override and then pushing the device
> > through driver_probe on the bus.  Is the intention of disabling
> > "autoprobe" that a driver_override should still work?  Otherwise the
> > user needs to set the driver_override for each VF, re-enable
> > sriov_drivers_autoprobe on the PF, and then probe the VFs.  Thus maybe
> > pci_device_can_probe() should allow probes of the driver_override
> > driver?  Thanks,
> > 
> > Alex
> > 
> >  drivers/pci/pci-driver.c |   13 +++++++------
> >  1 file changed, 7 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> > index 71853befd435..da7b82e56c83 100644
> > --- a/drivers/pci/pci-driver.c
> > +++ b/drivers/pci/pci-driver.c
> > @@ -414,6 +414,9 @@ static int pci_device_probe(struct device *dev)
> >  	struct pci_dev *pci_dev = to_pci_dev(dev);
> >  	struct pci_driver *drv = to_pci_driver(dev->driver);
> >  
> > +	if (!pci_device_can_probe(pci_dev))
> > +		return -ENODEV;
> > +
> >  	pci_assign_irq(pci_dev);
> >  
> >  	error = pcibios_alloc_irq(pci_dev);
> > @@ -421,12 +424,10 @@ static int pci_device_probe(struct device *dev)
> >  		return error;
> >  
> >  	pci_dev_get(pci_dev);
> > -	if (pci_device_can_probe(pci_dev)) {
> > -		error = __pci_device_probe(drv, pci_dev);
> > -		if (error) {
> > -			pcibios_free_irq(pci_dev);
> > -			pci_dev_put(pci_dev);
> > -		}
> > +	error = __pci_device_probe(drv, pci_dev);
> > +	if (error) {
> > +		pcibios_free_irq(pci_dev);
> > +		pci_dev_put(pci_dev);
> >  	}
> >  
> >  	return error;
> >   

