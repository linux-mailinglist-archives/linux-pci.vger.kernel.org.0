Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F47513810
	for <lists+linux-pci@lfdr.de>; Thu, 28 Apr 2022 17:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349034AbiD1PVY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Apr 2022 11:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349006AbiD1PVM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Apr 2022 11:21:12 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B2CB715C;
        Thu, 28 Apr 2022 08:17:38 -0700 (PDT)
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KpzgV0FtLz67wM8;
        Thu, 28 Apr 2022 23:14:46 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Thu, 28 Apr 2022 17:17:35 +0200
Received: from localhost (10.202.226.42) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 28 Apr
 2022 16:17:34 +0100
Date:   Thu, 28 Apr 2022 16:17:33 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V8 05/10] cxl/pci: Create DOE auxiliary driver
Message-ID: <20220428161733.000020c1@Huawei.com>
In-Reply-To: <YmnOK12AKqo5CAmF@iweiny-server>
References: <20220414203237.2198665-1-ira.weiny@intel.com>
        <20220414203237.2198665-6-ira.weiny@intel.com>
        <20220427184345.000076b1@Huawei.com>
        <YmnOK12AKqo5CAmF@iweiny-server>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhreml719-chm.china.huawei.com (10.201.108.70) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 28 Apr 2022 07:48:00 -0700
ira.weiny@intel.com wrote:

> On Wed, Apr 27, 2022 at 06:43:45PM +0100, Jonathan Cameron wrote:
> > On Thu, 14 Apr 2022 13:32:32 -0700
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
> > > Create a driver for the DOE auxiliary devices.  The driver uses the PCI
> > > DOE core to manage the mailbox.
> > > 
> > > User space must be prevented from unbinding the driver state when the
> > > DOE auxiliary driver is being accessed by the kernel.  Add a read write
> > > lock to the DOE auxiliary device to protect the driver data portion.
> > > 
> > > Finally, flag the driver module to be preloaded by device creation to
> > > ensure the driver is attached when iterating the DOE capabilities.
> > > 
> > > User space access can be obtained by unbinding the driver from that
> > > device.  For example:
> > > 
> > > $ ls -l /sys/bus/auxiliary/drivers
> > > total 0
> > > drwxr-xr-x 2 root root 0 Mar 24 10:45 cxl_doe.cxl_doe_drv
> > > 
> > > $ ls -l /sys/bus/auxiliary/drivers/cxl_doe.cxl_doe_drv/cxl_pci*
> > > lrwxrwxrwx 1 root root 0 Mar 24 10:53 /sys/bus/auxiliary/drivers/cxl_doe.cxl_doe_drv/cxl_pci.doe.0 -> ../../../../devices/pci0000:bf/0000:bf:00.0/0000:c0:00.0/cxl_pci.doe.0
> > > lrwxrwxrwx 1 root root 0 Mar 24 10:53 /sys/bus/auxiliary/drivers/cxl_doe.cxl_doe_drv/cxl_pci.doe.1 -> ../../../../devices/pci0000:bf/0000:bf:01.0/0000:c1:00.0/cxl_pci.doe.1
> > > lrwxrwxrwx 1 root root 0 Mar 24 10:53 /sys/bus/auxiliary/drivers/cxl_doe.cxl_doe_drv/cxl_pci.doe.2 -> ../../../../devices/pci0000:35/0000:35:00.0/0000:36:00.0/cxl_pci.doe.2
> > > lrwxrwxrwx 1 root root 0 Mar 24 10:53 /sys/bus/auxiliary/drivers/cxl_doe.cxl_doe_drv/cxl_pci.doe.3 -> ../../../../devices/pci0000:35/0000:35:01.0/0000:37:00.0/cxl_pci.doe.3
> > > lrwxrwxrwx 1 root root 0 Mar 24 10:53 /sys/bus/auxiliary/drivers/cxl_doe.cxl_doe_drv/cxl_pci.doe.3 -> ../../../../devices/pci0000:35/0000:35:01.0/0000:37:00.0/cxl_pci.doe.4
> > > lrwxrwxrwx 1 root root 0 Mar 24 10:53 /sys/bus/auxiliary/drivers/cxl_doe.cxl_doe_drv/cxl_pci.doe.5 -> ../../../../devices/pci0000:bf/0000:bf:00.0/0000:c0:00.0/cxl_pci.doe.5
> > > lrwxrwxrwx 1 root root 0 Mar 24 10:53 /sys/bus/auxiliary/drivers/cxl_doe.cxl_doe_drv/cxl_pci.doe.6 -> ../../../../devices/pci0000:35/0000:35:01.0/0000:37:00.0/cxl_pci.doe.6
> > > lrwxrwxrwx 1 root root 0 Mar 24 10:53 /sys/bus/auxiliary/drivers/cxl_doe.cxl_doe_drv/cxl_pci.doe.7 -> ../../../../devices/pci0000:bf/0000:bf:01.0/0000:c1:00.0/cxl_pci.doe.7
> > > 
> > > $ echo "cxl_pci.doe.4" > /sys/bus/auxiliary/drivers/cxl_doe.cxl_doe_drv/unbind
> > > 
> > > $ ls -l /sys/bus/auxiliary/drivers/cxl_doe.cxl_doe_drv/cxl_pci*
> > > lrwxrwxrwx 1 root root 0 Mar 24 10:53 /sys/bus/auxiliary/drivers/cxl_doe.cxl_doe_drv/cxl_pci.doe.0 -> ../../../../devices/pci0000:bf/0000:bf:00.0/0000:c0:00.0/cxl_pci.doe.0
> > > lrwxrwxrwx 1 root root 0 Mar 24 10:53 /sys/bus/auxiliary/drivers/cxl_doe.cxl_doe_drv/cxl_pci.doe.1 -> ../../../../devices/pci0000:bf/0000:bf:01.0/0000:c1:00.0/cxl_pci.doe.1
> > > lrwxrwxrwx 1 root root 0 Mar 24 10:53 /sys/bus/auxiliary/drivers/cxl_doe.cxl_doe_drv/cxl_pci.doe.2 -> ../../../../devices/pci0000:35/0000:35:00.0/0000:36:00.0/cxl_pci.doe.2
> > > lrwxrwxrwx 1 root root 0 Mar 24 10:53 /sys/bus/auxiliary/drivers/cxl_doe.cxl_doe_drv/cxl_pci.doe.3 -> ../../../../devices/pci0000:35/0000:35:01.0/0000:37:00.0/cxl_pci.doe.3
> > > lrwxrwxrwx 1 root root 0 Mar 24 10:53 /sys/bus/auxiliary/drivers/cxl_doe.cxl_doe_drv/cxl_pci.doe.5 -> ../../../../devices/pci0000:bf/0000:bf:00.0/0000:c0:00.0/cxl_pci.doe.5
> > > lrwxrwxrwx 1 root root 0 Mar 24 10:53 /sys/bus/auxiliary/drivers/cxl_doe.cxl_doe_drv/cxl_pci.doe.6 -> ../../../../devices/pci0000:35/0000:35:01.0/0000:37:00.0/cxl_pci.doe.6
> > > lrwxrwxrwx 1 root root 0 Mar 24 10:53 /sys/bus/auxiliary/drivers/cxl_doe.cxl_doe_drv/cxl_pci.doe.7 -> ../../../../devices/pci0000:bf/0000:bf:01.0/0000:c1:00.0/cxl_pci.doe.7
> > > 
> > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>  
> > 
> > Hi Ira,
> > 
> > A few minor comments inline.
> > With those cleaned up  
> 
> Thanks!
> 
> > 
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >   
> > > 
> > > ---
> > > Changes from V7:
> > > 	Now need to select PCI_DOE
> > > 	Change MODULE_LICENSE to 'GPL' instead of old 'GPL v2'
> > > 
> > > Changes from V6:
> > > 	The CXL layer now contains the driver for these auxiliary
> > > 	devices.
> > > 
> > > Changes from V5:
> > > 	Split the CXL specific stuff off from the PCI DOE create
> > > 	auxiliary device code.
> > > ---
> > >  drivers/cxl/Kconfig           | 13 +++++
> > >  drivers/cxl/Makefile          |  2 +
> > >  drivers/cxl/cxlpci.h          | 13 +++++
> > >  drivers/cxl/doe.c             | 90 +++++++++++++++++++++++++++++++++++
> > >  drivers/cxl/pci.c             | 20 ++++++++
> > >  include/uapi/linux/pci_regs.h |  1 +
> > >  6 files changed, 139 insertions(+)
> > >  create mode 100644 drivers/cxl/doe.c
> > > 

...


> > > diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> > > index 2ad8715173ce..821fe05e8289 100644
> > > --- a/drivers/cxl/cxlpci.h
> > > +++ b/drivers/cxl/cxlpci.h
> > > @@ -79,6 +79,7 @@ int devm_cxl_port_enumerate_dports(struct cxl_port *port);
> > >   *
> > >   * @adev: Auxiliary bus device
> > >   * @pdev: PCI device this belongs to
> > > + * @driver_access: Lock the driver during access
> > >   * @cap_offset: Capability offset
> > >   * @use_irq: Set if IRQs are to be used with this mailbox
> > >   *
> > > @@ -88,9 +89,21 @@ int devm_cxl_port_enumerate_dports(struct cxl_port *port);
> > >  struct cxl_doe_dev {
> > >  	struct auxiliary_device adev;
> > >  	struct pci_dev *pdev;
> > > +	struct rw_semaphore driver_access;
> > >  	int cap_offset;
> > >  	bool use_irq;
> > >  };
> > >  #define DOE_DEV_NAME "doe"
> > >  
> > > +/**
> > > + * struct cxl_doe_drv_state - state of the DOE Aux driver
> > > + *
> > > + * @doe_dev: The Auxiliary DOE device  
> > 
> > As far as I can tell no one actually uses the doe_dev from here for anything
> > so do we need it at all?  
> 
> Oh wow!  Great catch.  Worse yet I never even set it.  :-(
> 
> It must have been left over cruft from development which I missed in final
> review.  I think the logic was that the device goes along with the driver
> state...
> 
> Yes I will remove it.
> 
> But that unfortunately begs the question does cxl_doe_drv_state even need to
> exist?
> 
> I don't like returning the pci_doe_mb directly but having a struct contain a
> struct is worse IMO.
> 
> So cxl_pci_doe_get_drv() and cxl_pci_doe_put_drv() are going to be
> get_mb/put_mb respectively.
> 
> Can I make that change with your review by?

Yes, that's fine.

> 
> >   
> > > + * @doe_mb: PCI DOE mailbox state
> > > + */
> > > +struct cxl_doe_drv_state {
> > > +	struct cxl_doe_dev *doe_dev;
> > > +	struct pci_doe_mb *doe_mb;
> > > +};
> > > +
> > >  #endif /* __CXL_PCI_H__ */
> > > diff --git a/drivers/cxl/doe.c b/drivers/cxl/doe.c
> > > new file mode 100644
> > > index 000000000000..1d3a24a77002
> > > --- /dev/null
> > > +++ b/drivers/cxl/doe.c

...

> >   
> > > +		return PTR_ERR(doe_mb);  
> >   
> > > +	}
> > > +
> > > +	doe_ds->doe_mb = doe_mb;
> > > +	devm_add_action_or_reset(dev, doe_destroy_mb, doe_ds);
> > > +
> > > +	down_write(&doe_dev->driver_access);
> > > +	auxiliary_set_drvdata(aux_dev, doe_ds);
> > > +	up_write(&doe_dev->driver_access);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static void cxl_pci_doe_remove(struct auxiliary_device *aux_dev)
> > > +{
> > > +	struct cxl_doe_dev *doe_dev = container_of(aux_dev, struct cxl_doe_dev,
> > > +						   adev);
> > > +
> > > +	down_write(&doe_dev->driver_access);
> > > +	auxiliary_set_drvdata(aux_dev, NULL);  
> > 
> > This confused me for a bit.  I 'think' you are doing this to be able to use
> > it as a flag for whether the driver is still bound. If so, a comment would
> > be useful.  
> 
> Yes.
> 
> I'll add this from the commit message:
> 
> 	User space must be prevented from unbinding the driver state when the
> 	DOE auxiliary driver is being accessed by the kernel.

Maybe a comment here as well as setting drvdata to NULL is rather rare
as I'm fairly sure the driver core does it for you these days (but too late
for this particular use).

> 
> >   
> > > +	up_write(&doe_dev->driver_access);
> > > +}
> > > +
> > > +static const struct auxiliary_device_id cxl_pci_doe_auxiliary_id_table[] = {
> > > +	{.name = "cxl_pci." DOE_DEV_NAME, },
> > > +	{},
> > > +};
> > > +
> > > +MODULE_DEVICE_TABLE(auxiliary, cxl_pci_doe_auxiliary_id_table);
> > > +
> > > +struct auxiliary_driver cxl_pci_doe_auxiliary_drv = {
> > > +	.name = "cxl_doe_drv",
> > > +	.id_table = cxl_pci_doe_auxiliary_id_table,
> > > +	.probe = cxl_pci_doe_probe,
> > > +	.remove = cxl_pci_doe_remove,
> > > +};
> > > +
> > > +static int __init cxl_pci_doe_init_module(void)
> > > +{
> > > +	int ret;
> > > +
> > > +	ret = auxiliary_driver_register(&cxl_pci_doe_auxiliary_drv);
> > > +	if (ret) {
> > > +		pr_err("Failed cxl_pci_doe auxiliary_driver_register() ret=%d\n",
> > > +		       ret);
> > > +	}
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +static void __exit cxl_pci_doe_exit_module(void)
> > > +{
> > > +	auxiliary_driver_unregister(&cxl_pci_doe_auxiliary_drv);
> > > +}
> > > +
> > > +module_init(cxl_pci_doe_init_module);
> > > +module_exit(cxl_pci_doe_exit_module);
> > > +MODULE_LICENSE("GPL");
> > > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > > index 41a6f3eb0a5c..0dec1f1a3f38 100644
> > > --- a/drivers/cxl/pci.c
> > > +++ b/drivers/cxl/pci.c
> > > @@ -590,6 +590,17 @@ static void cxl_pci_doe_destroy_device(void *ad)
> > >  	auxiliary_device_uninit(ad);
> > >  }
> > >  
> > > +static struct cxl_doe_drv_state *cxl_pci_doe_get_drv(struct cxl_doe_dev *doe_dev)
> > > +{
> > > +	down_read(&doe_dev->driver_access);
> > > +	return auxiliary_get_drvdata(&doe_dev->adev);
> > > +}
> > > +
> > > +static void cxl_pci_doe_put_drv(struct cxl_doe_dev *doe_dev)
> > > +{
> > > +	up_read(&doe_dev->driver_access);
> > > +}
> > > +
> > >  /**
> > >   * cxl_pci_create_doe_devices - Create auxiliary bus DOE devices for all DOE
> > >   *				mailboxes found
> > > @@ -652,6 +663,7 @@ static int cxl_pci_create_doe_devices(struct pci_dev *pdev)
> > >  			return -ENOMEM;
> > >  
> > >  		new_dev->pdev = pdev;
> > > +		init_rwsem(&new_dev->driver_access);
> > >  		new_dev->cap_offset = off;
> > >  		new_dev->use_irq = use_irq;
> > >  
> > > @@ -682,6 +694,13 @@ static int cxl_pci_create_doe_devices(struct pci_dev *pdev)
> > >  					      adev);
> > >  		if (rc)
> > >  			return rc;
> > > +
> > > +		if (device_attach(&adev->dev) != 1) {
> > > +			dev_err(&adev->dev,
> > > +				"Failed to attach a driver to DOE device %d\n",
> > > +				adev->id);
> > > +			return -ENODEV;
> > > +		}  
> > 
> > Can you add a comment on why this has to be the case at this point.  Why can't
> > the driver come along later?  
> 
> Yes I will.
> 
> I've not really liked this aspect of the auxiliary device arch.  But I've not
> convinced myself that it will work ok to leave this till later.
> 
> Putting the CDAT retry on a timer might be a better option but it would also
> mean searching for the proper DOE would need to be delayed as well...

Ultimately we may not need to know CDAT info at the time of driver
load, but only on either a userspace read, or setup of a region etc.
I guess in majority of cases that will all be automated though (based
on LSA contents etc).

> 
> For now I'll put in a comment.
Great,

> 
> Thanks for the review!

You are welcome.

Thanks for driving this forwards.

Jonathan

> Ira
> 
> >   
> > >  	}
> > >  
> > >  	return 0;
> > > @@ -785,6 +804,7 @@ static struct pci_driver cxl_pci_driver = {
> > >  	},
> > >  };  
> > 
> > ...
> >   

