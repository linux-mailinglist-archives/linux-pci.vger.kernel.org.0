Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68B2E5150FD
	for <lists+linux-pci@lfdr.de>; Fri, 29 Apr 2022 18:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378665AbiD2QmI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Apr 2022 12:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235788AbiD2QmI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Apr 2022 12:42:08 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72E6DA6C7;
        Fri, 29 Apr 2022 09:38:48 -0700 (PDT)
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KqdQy5NW9z67xBy;
        Sat, 30 Apr 2022 00:36:10 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 29 Apr 2022 18:38:46 +0200
Received: from localhost (10.81.206.67) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 17:38:45 +0100
Date:   Fri, 29 Apr 2022 17:38:43 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V8 04/10] cxl/pci: Create auxiliary devices for each DOE
 mailbox
Message-ID: <20220429173843.00006dcd@Huawei.com>
In-Reply-To: <YmsCfHf/HMuqBkTk@iweiny-server>
References: <20220414203237.2198665-1-ira.weiny@intel.com>
        <20220414203237.2198665-5-ira.weiny@intel.com>
        <20220427181942.00003492@Huawei.com>
        <YmsCfHf/HMuqBkTk@iweiny-server>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.206.67]
X-ClientProxiedBy: lhreml720-chm.china.huawei.com (10.201.108.71) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 28 Apr 2022 14:09:38 -0700
ira.weiny@intel.com wrote:

> On Wed, Apr 27, 2022 at 06:19:42PM +0100, Jonathan Cameron wrote:
> > On Thu, 14 Apr 2022 13:32:31 -0700
> > ira.weiny@intel.com wrote:
> >   
> > > From: Ira Weiny <ira.weiny@intel.com>
> > > 
> > > CXL kernel drivers optionally need to access DOE mailbox capabilities.
> > > Access to mailboxes for things such as CDAT, SPDM, and IDE are needed by
> > > the kernel while other access is designed towards user space usage.  An
> > > example of this is for CXL Compliance Testing (see CXL 2.0 14.16.4
> > > Compliance Mode DOE) which offers a mechanism to set different test
> > > modes for a device.
> > > 
> > > There is no anticipated need for the kernel to share an individual
> > > mailbox with user space.  Thus developing an interface to marshal access
> > > between the kernel and user space for a single mailbox is unnecessary
> > > overhead.  However, having the kernel relinquish some mailboxes to be
> > > controlled by user space is a reasonable compromise to share access to
> > > the device.
> > > 
> > > The auxiliary bus provides an elegant solution for this.  Each DOE
> > > capability is given its own auxiliary device.  This device is controlled
> > > by a kernel driver by default which restricts access to the mailbox.
> > > Unbinding the driver from a single auxiliary device (DOE mailbox
> > > capability) frees the mailbox for user space access.  This architecture
> > > also allows a clear picture on which mailboxes are kernel controlled vs
> > > not.
> > > 
> > > Iterate each DOE mailbox capability and create auxiliary bus devices.
> > > Follow on patches will define a driver for the newly created devices.
> > > 
> > > sysfs shows the devices.
> > > 
> > > $ ls -l /sys/bus/auxiliary/devices/
> > > total 0
> > > lrwxrwxrwx 1 root root 0 Mar 24 10:47 cxl_pci.doe.0 -> ../../../devices/pci0000:bf/0000:bf:00.0/0000:c0:00.0/cxl_pci.doe.0
> > > lrwxrwxrwx 1 root root 0 Mar 24 10:47 cxl_pci.doe.1 -> ../../../devices/pci0000:bf/0000:bf:01.0/0000:c1:00.0/cxl_pci.doe.1
> > > lrwxrwxrwx 1 root root 0 Mar 24 10:47 cxl_pci.doe.2 -> ../../../devices/pci0000:35/0000:35:00.0/0000:36:00.0/cxl_pci.doe.2
> > > lrwxrwxrwx 1 root root 0 Mar 24 10:47 cxl_pci.doe.3 -> ../../../devices/pci0000:35/0000:35:01.0/0000:37:00.0/cxl_pci.doe.3
> > > lrwxrwxrwx 1 root root 0 Mar 24 10:47 cxl_pci.doe.4 -> ../../../devices/pci0000:35/0000:35:00.0/0000:36:00.0/cxl_pci.doe.4
> > > lrwxrwxrwx 1 root root 0 Mar 24 10:47 cxl_pci.doe.5 -> ../../../devices/pci0000:bf/0000:bf:00.0/0000:c0:00.0/cxl_pci.doe.5
> > > lrwxrwxrwx 1 root root 0 Mar 24 10:47 cxl_pci.doe.6 -> ../../../devices/pci0000:35/0000:35:01.0/0000:37:00.0/cxl_pci.doe.6
> > > lrwxrwxrwx 1 root root 0 Mar 24 10:47 cxl_pci.doe.7 -> ../../../devices/pci0000:bf/0000:bf:01.0/0000:c1:00.0/cxl_pci.doe.7
> > > 
> > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>  
> > 
> > I'm not 100% happy with effectively having one solution for CXL
> > and probably a different one for DOEs on switch ports
> > (which I just hacked into a port service driver to convince
> > myself there was at least one plausible way of doing that) but if
> > this effectively separates the two discussions then I guess I can
> > live with it for now ;)  
> 
> I took some time this morning to mull this over and talk to Dan...
> 
> :-(
> 
> Truthfully the aux driver does very little except provide a way for admins to
> trigger the driver to stop/start accessing the Mailbox.
> 
> I suppose a simple sysfs interface could be done to do the same?
> 
> I'll let Dan weigh in here.

I wonder if best short term option is to not provide a means of
removing it at all (separate from the PCI driver that is).
Then we can take our time to decide on the interface if we ever
get much demand for one.

> 
> > 
> > Once this is merged we can start the discussion about how to
> > handle switch ports with DOEs both for CDAT and SPDM.  
> 
> I'm ok with that too.  However, I was thinking that this was not a user ABI.
> But it really is.  If user space starts writing script to unbind drivers and
> then we drop the aux driver support it will break them...
> 
> > 
> > I'll send out an RFC that is so hideous it will get people to
> > suggestion how to do it better!  
> 
> I think I'd like to see that.

Fair enough. It may muddy the waters a bit :( I'll send an RFC
next week.  I've not looked at how the CXL region code etc would
actually get to the latency / bandwidth info from the driver yet
it just goes as far as reading a CDAT length. I also want to actually
hook up some decent switch CDAT emulation in the QEMU code
(right now it's giving the same default table as for a type 3 device).

I just hope we don't bikeshed around the RFC in a fashion that slows
this series moving forwards.

> 
> > Currently it starts and
> > stops the mailbox 3 times in the registration path and I think
> > it's more luck than judgement that is landing me with the right
> > MSI.
> > 
> > Anyhow, this looks good to me.
> > 
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
> 
> Thanks!
> 
> The good news is that the main support for the algorithm is now just part of
> the pci core as library functions.  I think this discussion is a pretty
> light lift to move the calls to those around...

Absolutely - one nasty bit of code that seems to be almost agreed on -
definite progress!

Jonathan

> 
> Ira
> 
> > 
> >   
> > > 
> > > ---
> > > Changes from V7:
> > > 	Minor code clean ups
> > > 	Rebased on cxl-pending
> > > 
> > > Changes from V6:
> > > 	Move all the auxiliary device stuff to the CXL layer
> > > 
> > > Changes from V5:
> > > 	Split the CXL specific stuff off from the PCI DOE create
> > > 	auxiliary device code.
> > > ---
> > >  drivers/cxl/Kconfig  |   1 +
> > >  drivers/cxl/cxlpci.h |  21 +++++++
> > >  drivers/cxl/pci.c    | 127 +++++++++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 149 insertions(+)
> > > 
> > > diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> > > index f64e3984689f..ac0f5ca95431 100644
> > > --- a/drivers/cxl/Kconfig
> > > +++ b/drivers/cxl/Kconfig
> > > @@ -16,6 +16,7 @@ if CXL_BUS
> > >  config CXL_PCI
> > >  	tristate "PCI manageability"
> > >  	default CXL_BUS
> > > +	select AUXILIARY_BUS
> > >  	help
> > >  	  The CXL specification defines a "CXL memory device" sub-class in the
> > >  	  PCI "memory controller" base class of devices. Device's identified by
> > > diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> > > index 329e7ea3f36a..2ad8715173ce 100644
> > > --- a/drivers/cxl/cxlpci.h
> > > +++ b/drivers/cxl/cxlpci.h
> > > @@ -2,6 +2,7 @@
> > >  /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
> > >  #ifndef __CXL_PCI_H__
> > >  #define __CXL_PCI_H__
> > > +#include <linux/auxiliary_bus.h>
> > >  #include <linux/pci.h>
> > >  #include "cxl.h"
> > >  
> > > @@ -72,4 +73,24 @@ static inline resource_size_t cxl_regmap_to_base(struct pci_dev *pdev,
> > >  }
> > >  
> > >  int devm_cxl_port_enumerate_dports(struct cxl_port *port);
> > > +
> > > +/**
> > > + * struct cxl_doe_dev - CXL DOE auxiliary bus device
> > > + *
> > > + * @adev: Auxiliary bus device
> > > + * @pdev: PCI device this belongs to
> > > + * @cap_offset: Capability offset
> > > + * @use_irq: Set if IRQs are to be used with this mailbox
> > > + *
> > > + * This represents a single DOE mailbox device.  CXL devices should create this
> > > + * device and register it on the Auxiliary bus for the CXL DOE driver to drive.
> > > + */
> > > +struct cxl_doe_dev {
> > > +	struct auxiliary_device adev;
> > > +	struct pci_dev *pdev;
> > > +	int cap_offset;
> > > +	bool use_irq;
> > > +};
> > > +#define DOE_DEV_NAME "doe"
> > > +
> > >  #endif /* __CXL_PCI_H__ */
> > > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > > index e7ab9a34d718..41a6f3eb0a5c 100644
> > > --- a/drivers/cxl/pci.c
> > > +++ b/drivers/cxl/pci.c
> > > @@ -8,6 +8,7 @@
> > >  #include <linux/mutex.h>
> > >  #include <linux/list.h>
> > >  #include <linux/pci.h>
> > > +#include <linux/pci-doe.h>
> > >  #include <linux/io.h>
> > >  #include "cxlmem.h"
> > >  #include "cxlpci.h"
> > > @@ -564,6 +565,128 @@ static void cxl_dvsec_ranges(struct cxl_dev_state *cxlds)
> > >  	info->ranges = __cxl_dvsec_ranges(cxlds, info);
> > >  }
> > >  
> > > +static void cxl_pci_free_irq_vectors(void *data)
> > > +{
> > > +	pci_free_irq_vectors(data);
> > > +}
> > > +
> > > +static DEFINE_IDA(pci_doe_adev_ida);
> > > +
> > > +static void cxl_pci_doe_dev_release(struct device *dev)
> > > +{
> > > +	struct auxiliary_device *adev = container_of(dev,
> > > +						struct auxiliary_device,
> > > +						dev);
> > > +	struct cxl_doe_dev *doe_dev = container_of(adev, struct cxl_doe_dev,
> > > +						   adev);
> > > +
> > > +	ida_free(&pci_doe_adev_ida, adev->id);
> > > +	kfree(doe_dev);
> > > +}
> > > +
> > > +static void cxl_pci_doe_destroy_device(void *ad)
> > > +{
> > > +	auxiliary_device_delete(ad);
> > > +	auxiliary_device_uninit(ad);
> > > +}
> > > +
> > > +/**
> > > + * cxl_pci_create_doe_devices - Create auxiliary bus DOE devices for all DOE
> > > + *				mailboxes found
> > > + *
> > > + * @pci_dev: The PCI device to scan for DOE mailboxes
> > > + *
> > > + * There is no coresponding destroy of these devices.  This function associates
> > > + * the DOE auxiliary devices created with the pci_dev passed in.  That
> > > + * association is device managed (devm_*) such that the DOE auxiliary device
> > > + * lifetime is always less than or equal to the lifetime of the pci_dev.
> > > + *
> > > + * RETURNS: 0 on success -ERRNO on failure.
> > > + */
> > > +static int cxl_pci_create_doe_devices(struct pci_dev *pdev)
> > > +{
> > > +	struct device *dev = &pdev->dev;
> > > +	bool use_irq = true;
> > > +	int irqs = 0;
> > > +	u16 off = 0;
> > > +	int rc;
> > > +
> > > +	pci_doe_for_each_off(pdev, off)
> > > +		irqs++;
> > > +	pci_info(pdev, "Found %d DOE mailbox's\n", irqs);
> > > +
> > > +	/*
> > > +	 * Allocate enough vectors for the DOE's
> > > +	 */
> > > +	rc = pci_alloc_irq_vectors(pdev, irqs, irqs, PCI_IRQ_MSI |
> > > +						     PCI_IRQ_MSIX);
> > > +	if (rc != irqs) {
> > > +		pci_err(pdev,
> > > +			"Not enough interrupts for all the DOEs; use polling\n");
> > > +		use_irq = false;
> > > +		/* Some got allocated; clean them up */
> > > +		if (rc > 0)
> > > +			cxl_pci_free_irq_vectors(pdev);
> > > +	} else {
> > > +		/*
> > > +		 * Enabling bus mastering is require for MSI/MSIx.  It could be
> > > +		 * done later within the DOE initialization, but as it
> > > +		 * potentially has other impacts keep it here when setting up
> > > +		 * the IRQ's.
> > > +		 */
> > > +		pci_set_master(pdev);
> > > +		rc = devm_add_action_or_reset(dev,
> > > +					      cxl_pci_free_irq_vectors,
> > > +					      pdev);
> > > +		if (rc)
> > > +			return rc;
> > > +	}
> > > +
> > > +	pci_doe_for_each_off(pdev, off) {
> > > +		struct auxiliary_device *adev;
> > > +		struct cxl_doe_dev *new_dev;
> > > +		int id;
> > > +
> > > +		new_dev = kzalloc(sizeof(*new_dev), GFP_KERNEL);
> > > +		if (!new_dev)
> > > +			return -ENOMEM;
> > > +
> > > +		new_dev->pdev = pdev;
> > > +		new_dev->cap_offset = off;
> > > +		new_dev->use_irq = use_irq;
> > > +
> > > +		/* Set up struct auxiliary_device */
> > > +		adev = &new_dev->adev;
> > > +		id = ida_alloc(&pci_doe_adev_ida, GFP_KERNEL);
> > > +		if (id < 0) {
> > > +			kfree(new_dev);
> > > +			return -ENOMEM;
> > > +		}
> > > +
> > > +		adev->id = id;
> > > +		adev->name = DOE_DEV_NAME;
> > > +		adev->dev.release = cxl_pci_doe_dev_release;
> > > +		adev->dev.parent = dev;
> > > +
> > > +		if (auxiliary_device_init(adev)) {
> > > +			cxl_pci_doe_dev_release(&adev->dev);
> > > +			return -EIO;
> > > +		}
> > > +
> > > +		if (auxiliary_device_add(adev)) {
> > > +			auxiliary_device_uninit(adev);
> > > +			return -EIO;
> > > +		}
> > > +
> > > +		rc = devm_add_action_or_reset(dev, cxl_pci_doe_destroy_device,
> > > +					      adev);
> > > +		if (rc)
> > > +			return rc;
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >  static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> > >  {
> > >  	struct cxl_register_map map;
> > > @@ -630,6 +753,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> > >  	if (rc)
> > >  		return rc;
> > >  
> > > +	rc = cxl_pci_create_doe_devices(pdev);
> > > +	if (rc)
> > > +		return rc;
> > > +
> > >  	cxl_dvsec_ranges(cxlds);
> > >  
> > >  	cxlmd = devm_cxl_add_memdev(cxlds);  
> >   

