Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B44B513741
	for <lists+linux-pci@lfdr.de>; Thu, 28 Apr 2022 16:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234704AbiD1OvR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Apr 2022 10:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbiD1OvQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Apr 2022 10:51:16 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15CFCB0D12;
        Thu, 28 Apr 2022 07:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651157281; x=1682693281;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6+8IBvhFxht3+3o1jN6x7624NVhd4E7nSa5XJA9XIto=;
  b=MnXtsfjuKPo4I0vk8NroWQ/KYwwGMhcwsqW4RYzPdDMWYv5GKriIbffI
   Ze7KxDPGK/gpm8GUCfAbjW0XFqUTN/6w+8R6dxrEicK+0o6VzojPG/dqa
   qtGSN1s480DRueZraL1hk9WFbWm8qJ0UMH7EWGTdJbP6TRoTdYwSMtQxw
   sLYg5THgoUa6SdPqoeAV1RxLJNkWzWUGQJzFzVWmS/gu9Kbe6OpBai57m
   MiLk7Qrfq79PBG2tt3RLluKXI/OjdPM54f7288W4cosQnOa7BYrYjRxwz
   VhkPZDv33jRB/rBjtvnSB2pszLTIg6IHSJoDKERq/AfKuMMZ3pJZBwiFF
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10330"; a="248242960"
X-IronPort-AV: E=Sophos;i="5.91,295,1647327600"; 
   d="scan'208";a="248242960"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 07:48:00 -0700
X-IronPort-AV: E=Sophos;i="5.91,295,1647327600"; 
   d="scan'208";a="731506741"
Received: from iweiny-server.sc.intel.com (HELO localhost) ([172.25.222.75])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 07:48:00 -0700
Date:   Thu, 28 Apr 2022 07:48:00 -0700
From:   ira.weiny@intel.com
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH V8 05/10] cxl/pci: Create DOE auxiliary driver
Message-ID: <YmnOK12AKqo5CAmF@iweiny-server>
References: <20220414203237.2198665-1-ira.weiny@intel.com>
 <20220414203237.2198665-6-ira.weiny@intel.com>
 <20220427184345.000076b1@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427184345.000076b1@Huawei.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 27, 2022 at 06:43:45PM +0100, Jonathan Cameron wrote:
> On Thu, 14 Apr 2022 13:32:32 -0700
> ira.weiny@intel.com wrote:
> 
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > CXL kernel drivers optionally need to access DOE mailbox capabilities.
> > Access to mailboxes for things such as CDAT, SPDM, and IDE are needed by
> > the kernel while other access is designed towards user space usage.  An
> > example of this is for CXL Compliance Testing (see CXL 2.0 14.16.4
> > Compliance Mode DOE) which offers a mechanism to set different test
> > modes for a device.
> > 
> > There is no anticipated need for the kernel to share an individual
> > mailbox with user space.  Thus developing an interface to marshal access
> > between the kernel and user space for a single mailbox is unnecessary
> > overhead.  However, having the kernel relinquish some mailboxes to be
> > controlled by user space is a reasonable compromise to share access to
> > the device.
> > 
> > The auxiliary bus provides an elegant solution for this.  Each DOE
> > capability is given its own auxiliary device.  This device is controlled
> > by a kernel driver by default which restricts access to the mailbox.
> > Unbinding the driver from a single auxiliary device (DOE mailbox
> > capability) frees the mailbox for user space access.  This architecture
> > also allows a clear picture on which mailboxes are kernel controlled vs
> > not.
> > 
> > Create a driver for the DOE auxiliary devices.  The driver uses the PCI
> > DOE core to manage the mailbox.
> > 
> > User space must be prevented from unbinding the driver state when the
> > DOE auxiliary driver is being accessed by the kernel.  Add a read write
> > lock to the DOE auxiliary device to protect the driver data portion.
> > 
> > Finally, flag the driver module to be preloaded by device creation to
> > ensure the driver is attached when iterating the DOE capabilities.
> > 
> > User space access can be obtained by unbinding the driver from that
> > device.  For example:
> > 
> > $ ls -l /sys/bus/auxiliary/drivers
> > total 0
> > drwxr-xr-x 2 root root 0 Mar 24 10:45 cxl_doe.cxl_doe_drv
> > 
> > $ ls -l /sys/bus/auxiliary/drivers/cxl_doe.cxl_doe_drv/cxl_pci*
> > lrwxrwxrwx 1 root root 0 Mar 24 10:53 /sys/bus/auxiliary/drivers/cxl_doe.cxl_doe_drv/cxl_pci.doe.0 -> ../../../../devices/pci0000:bf/0000:bf:00.0/0000:c0:00.0/cxl_pci.doe.0
> > lrwxrwxrwx 1 root root 0 Mar 24 10:53 /sys/bus/auxiliary/drivers/cxl_doe.cxl_doe_drv/cxl_pci.doe.1 -> ../../../../devices/pci0000:bf/0000:bf:01.0/0000:c1:00.0/cxl_pci.doe.1
> > lrwxrwxrwx 1 root root 0 Mar 24 10:53 /sys/bus/auxiliary/drivers/cxl_doe.cxl_doe_drv/cxl_pci.doe.2 -> ../../../../devices/pci0000:35/0000:35:00.0/0000:36:00.0/cxl_pci.doe.2
> > lrwxrwxrwx 1 root root 0 Mar 24 10:53 /sys/bus/auxiliary/drivers/cxl_doe.cxl_doe_drv/cxl_pci.doe.3 -> ../../../../devices/pci0000:35/0000:35:01.0/0000:37:00.0/cxl_pci.doe.3
> > lrwxrwxrwx 1 root root 0 Mar 24 10:53 /sys/bus/auxiliary/drivers/cxl_doe.cxl_doe_drv/cxl_pci.doe.3 -> ../../../../devices/pci0000:35/0000:35:01.0/0000:37:00.0/cxl_pci.doe.4
> > lrwxrwxrwx 1 root root 0 Mar 24 10:53 /sys/bus/auxiliary/drivers/cxl_doe.cxl_doe_drv/cxl_pci.doe.5 -> ../../../../devices/pci0000:bf/0000:bf:00.0/0000:c0:00.0/cxl_pci.doe.5
> > lrwxrwxrwx 1 root root 0 Mar 24 10:53 /sys/bus/auxiliary/drivers/cxl_doe.cxl_doe_drv/cxl_pci.doe.6 -> ../../../../devices/pci0000:35/0000:35:01.0/0000:37:00.0/cxl_pci.doe.6
> > lrwxrwxrwx 1 root root 0 Mar 24 10:53 /sys/bus/auxiliary/drivers/cxl_doe.cxl_doe_drv/cxl_pci.doe.7 -> ../../../../devices/pci0000:bf/0000:bf:01.0/0000:c1:00.0/cxl_pci.doe.7
> > 
> > $ echo "cxl_pci.doe.4" > /sys/bus/auxiliary/drivers/cxl_doe.cxl_doe_drv/unbind
> > 
> > $ ls -l /sys/bus/auxiliary/drivers/cxl_doe.cxl_doe_drv/cxl_pci*
> > lrwxrwxrwx 1 root root 0 Mar 24 10:53 /sys/bus/auxiliary/drivers/cxl_doe.cxl_doe_drv/cxl_pci.doe.0 -> ../../../../devices/pci0000:bf/0000:bf:00.0/0000:c0:00.0/cxl_pci.doe.0
> > lrwxrwxrwx 1 root root 0 Mar 24 10:53 /sys/bus/auxiliary/drivers/cxl_doe.cxl_doe_drv/cxl_pci.doe.1 -> ../../../../devices/pci0000:bf/0000:bf:01.0/0000:c1:00.0/cxl_pci.doe.1
> > lrwxrwxrwx 1 root root 0 Mar 24 10:53 /sys/bus/auxiliary/drivers/cxl_doe.cxl_doe_drv/cxl_pci.doe.2 -> ../../../../devices/pci0000:35/0000:35:00.0/0000:36:00.0/cxl_pci.doe.2
> > lrwxrwxrwx 1 root root 0 Mar 24 10:53 /sys/bus/auxiliary/drivers/cxl_doe.cxl_doe_drv/cxl_pci.doe.3 -> ../../../../devices/pci0000:35/0000:35:01.0/0000:37:00.0/cxl_pci.doe.3
> > lrwxrwxrwx 1 root root 0 Mar 24 10:53 /sys/bus/auxiliary/drivers/cxl_doe.cxl_doe_drv/cxl_pci.doe.5 -> ../../../../devices/pci0000:bf/0000:bf:00.0/0000:c0:00.0/cxl_pci.doe.5
> > lrwxrwxrwx 1 root root 0 Mar 24 10:53 /sys/bus/auxiliary/drivers/cxl_doe.cxl_doe_drv/cxl_pci.doe.6 -> ../../../../devices/pci0000:35/0000:35:01.0/0000:37:00.0/cxl_pci.doe.6
> > lrwxrwxrwx 1 root root 0 Mar 24 10:53 /sys/bus/auxiliary/drivers/cxl_doe.cxl_doe_drv/cxl_pci.doe.7 -> ../../../../devices/pci0000:bf/0000:bf:01.0/0000:c1:00.0/cxl_pci.doe.7
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> Hi Ira,
> 
> A few minor comments inline.
> With those cleaned up

Thanks!

> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> > 
> > ---
> > Changes from V7:
> > 	Now need to select PCI_DOE
> > 	Change MODULE_LICENSE to 'GPL' instead of old 'GPL v2'
> > 
> > Changes from V6:
> > 	The CXL layer now contains the driver for these auxiliary
> > 	devices.
> > 
> > Changes from V5:
> > 	Split the CXL specific stuff off from the PCI DOE create
> > 	auxiliary device code.
> > ---
> >  drivers/cxl/Kconfig           | 13 +++++
> >  drivers/cxl/Makefile          |  2 +
> >  drivers/cxl/cxlpci.h          | 13 +++++
> >  drivers/cxl/doe.c             | 90 +++++++++++++++++++++++++++++++++++
> >  drivers/cxl/pci.c             | 20 ++++++++
> >  include/uapi/linux/pci_regs.h |  1 +
> >  6 files changed, 139 insertions(+)
> >  create mode 100644 drivers/cxl/doe.c
> > 
> > diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> > index ac0f5ca95431..82f3908fa5cc 100644
> > --- a/drivers/cxl/Kconfig
> > +++ b/drivers/cxl/Kconfig
> > @@ -103,4 +103,17 @@ config CXL_SUSPEND
> >  	def_bool y
> >  	depends on SUSPEND && CXL_MEM
> >  
> > +config CXL_PCI_DOE
> > +      tristate "CXL PCI Data Object Exchange (DOE) support"
> > +      depends on CXL_PCI
> 
> Should be leading tabs not spaces.

Opps must have been a bad copy/paste.  Sorry.

> 
> > +      default CXL_BUS
> > +      select PCI_DOE
> > +      help
> > +        Driver for DOE auxiliary devices.
> > +
> > +	The DOE capabilities provides a simple mailbox in PCI config space that
> > +	is used for a number of different protocols useful to CXL.  The CXL PCI
> > +	subsystem creates auxiliary devices for each DOE mailbox capability
> > +	found.  This driver is required for the kernel to use these devices.
> > +
> >  endif
> > diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
> > index a78270794150..c71b7a6345fb 100644
> > --- a/drivers/cxl/Makefile
> > +++ b/drivers/cxl/Makefile
> > @@ -1,6 +1,7 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >  obj-y += core/
> >  obj-$(CONFIG_CXL_PCI) += cxl_pci.o
> > +obj-$(CONFIG_CXL_PCI_DOE) += cxl_doe.o
> >  obj-$(CONFIG_CXL_MEM) += cxl_mem.o
> >  obj-$(CONFIG_CXL_ACPI) += cxl_acpi.o
> >  obj-$(CONFIG_CXL_PMEM) += cxl_pmem.o
> > @@ -8,6 +9,7 @@ obj-$(CONFIG_CXL_PORT) += cxl_port.o
> >  
> >  cxl_mem-y := mem.o
> >  cxl_pci-y := pci.o
> > +cxl_doe-y := doe.o
> >  cxl_acpi-y := acpi.o
> >  cxl_pmem-y := pmem.o
> >  cxl_port-y := port.o
> > diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> > index 2ad8715173ce..821fe05e8289 100644
> > --- a/drivers/cxl/cxlpci.h
> > +++ b/drivers/cxl/cxlpci.h
> > @@ -79,6 +79,7 @@ int devm_cxl_port_enumerate_dports(struct cxl_port *port);
> >   *
> >   * @adev: Auxiliary bus device
> >   * @pdev: PCI device this belongs to
> > + * @driver_access: Lock the driver during access
> >   * @cap_offset: Capability offset
> >   * @use_irq: Set if IRQs are to be used with this mailbox
> >   *
> > @@ -88,9 +89,21 @@ int devm_cxl_port_enumerate_dports(struct cxl_port *port);
> >  struct cxl_doe_dev {
> >  	struct auxiliary_device adev;
> >  	struct pci_dev *pdev;
> > +	struct rw_semaphore driver_access;
> >  	int cap_offset;
> >  	bool use_irq;
> >  };
> >  #define DOE_DEV_NAME "doe"
> >  
> > +/**
> > + * struct cxl_doe_drv_state - state of the DOE Aux driver
> > + *
> > + * @doe_dev: The Auxiliary DOE device
> 
> As far as I can tell no one actually uses the doe_dev from here for anything
> so do we need it at all?

Oh wow!  Great catch.  Worse yet I never even set it.  :-(

It must have been left over cruft from development which I missed in final
review.  I think the logic was that the device goes along with the driver
state...

Yes I will remove it.

But that unfortunately begs the question does cxl_doe_drv_state even need to
exist?

I don't like returning the pci_doe_mb directly but having a struct contain a
struct is worse IMO.

So cxl_pci_doe_get_drv() and cxl_pci_doe_put_drv() are going to be
get_mb/put_mb respectively.

Can I make that change with your review by?

> 
> > + * @doe_mb: PCI DOE mailbox state
> > + */
> > +struct cxl_doe_drv_state {
> > +	struct cxl_doe_dev *doe_dev;
> > +	struct pci_doe_mb *doe_mb;
> > +};
> > +
> >  #endif /* __CXL_PCI_H__ */
> > diff --git a/drivers/cxl/doe.c b/drivers/cxl/doe.c
> > new file mode 100644
> > index 000000000000..1d3a24a77002
> > --- /dev/null
> > +++ b/drivers/cxl/doe.c
> > @@ -0,0 +1,90 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/* Copyright(c) 2022 Intel Corporation. All rights reserved. */
> > +
> > +#include <linux/pci.h>
> > +#include <linux/pci-doe.h>
> 
> Rather sparse include list given what is going on in here.
> We shouldn't rely too heavily on what comes indirectly except
> where it's really standard headers.
> 
> Probably mod_devicetable.h and some headers for auxiliary devices
> and rwsem.h at least?  

Yea I'll add to this list.

> 
> > +
> > +#include "cxlpci.h"
> > +
> > +static void doe_destroy_mb(void *ds)
> > +{
> > +	struct cxl_doe_drv_state *doe_ds = ds;
> > +
> > +	pci_doe_destroy_mb(doe_ds->doe_mb);
> > +}
> > +
> > +static int cxl_pci_doe_probe(struct auxiliary_device *aux_dev,
> > +			     const struct auxiliary_device_id *id)
> > +{
> > +	struct cxl_doe_dev *doe_dev = container_of(aux_dev, struct cxl_doe_dev,
> > +						   adev);
> > +	struct device *dev = &aux_dev->dev;
> > +	struct cxl_doe_drv_state *doe_ds;
> > +	struct pci_doe_mb *doe_mb;
> > +
> > +	doe_ds = devm_kzalloc(dev, sizeof(*doe_ds), GFP_KERNEL);
> > +	if (!doe_ds)
> > +		return -ENOMEM;
> > +
> > +	doe_mb = pci_doe_create_mb(doe_dev->pdev, doe_dev->cap_offset,
> > +				   doe_dev->use_irq);
> > +	if (IS_ERR(doe_mb)) {
> > +		dev_err(dev, "Failed to create the DOE mailbox state machine\n");
> 
> You could use dev_err_probe() here to tidy this up a little bit.

Sure!

> 
> > +		return PTR_ERR(doe_mb);
> 
> > +	}
> > +
> > +	doe_ds->doe_mb = doe_mb;
> > +	devm_add_action_or_reset(dev, doe_destroy_mb, doe_ds);
> > +
> > +	down_write(&doe_dev->driver_access);
> > +	auxiliary_set_drvdata(aux_dev, doe_ds);
> > +	up_write(&doe_dev->driver_access);
> > +
> > +	return 0;
> > +}
> > +
> > +static void cxl_pci_doe_remove(struct auxiliary_device *aux_dev)
> > +{
> > +	struct cxl_doe_dev *doe_dev = container_of(aux_dev, struct cxl_doe_dev,
> > +						   adev);
> > +
> > +	down_write(&doe_dev->driver_access);
> > +	auxiliary_set_drvdata(aux_dev, NULL);
> 
> This confused me for a bit.  I 'think' you are doing this to be able to use
> it as a flag for whether the driver is still bound. If so, a comment would
> be useful.

Yes.

I'll add this from the commit message:

	User space must be prevented from unbinding the driver state when the
	DOE auxiliary driver is being accessed by the kernel.

> 
> > +	up_write(&doe_dev->driver_access);
> > +}
> > +
> > +static const struct auxiliary_device_id cxl_pci_doe_auxiliary_id_table[] = {
> > +	{.name = "cxl_pci." DOE_DEV_NAME, },
> > +	{},
> > +};
> > +
> > +MODULE_DEVICE_TABLE(auxiliary, cxl_pci_doe_auxiliary_id_table);
> > +
> > +struct auxiliary_driver cxl_pci_doe_auxiliary_drv = {
> > +	.name = "cxl_doe_drv",
> > +	.id_table = cxl_pci_doe_auxiliary_id_table,
> > +	.probe = cxl_pci_doe_probe,
> > +	.remove = cxl_pci_doe_remove,
> > +};
> > +
> > +static int __init cxl_pci_doe_init_module(void)
> > +{
> > +	int ret;
> > +
> > +	ret = auxiliary_driver_register(&cxl_pci_doe_auxiliary_drv);
> > +	if (ret) {
> > +		pr_err("Failed cxl_pci_doe auxiliary_driver_register() ret=%d\n",
> > +		       ret);
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static void __exit cxl_pci_doe_exit_module(void)
> > +{
> > +	auxiliary_driver_unregister(&cxl_pci_doe_auxiliary_drv);
> > +}
> > +
> > +module_init(cxl_pci_doe_init_module);
> > +module_exit(cxl_pci_doe_exit_module);
> > +MODULE_LICENSE("GPL");
> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > index 41a6f3eb0a5c..0dec1f1a3f38 100644
> > --- a/drivers/cxl/pci.c
> > +++ b/drivers/cxl/pci.c
> > @@ -590,6 +590,17 @@ static void cxl_pci_doe_destroy_device(void *ad)
> >  	auxiliary_device_uninit(ad);
> >  }
> >  
> > +static struct cxl_doe_drv_state *cxl_pci_doe_get_drv(struct cxl_doe_dev *doe_dev)
> > +{
> > +	down_read(&doe_dev->driver_access);
> > +	return auxiliary_get_drvdata(&doe_dev->adev);
> > +}
> > +
> > +static void cxl_pci_doe_put_drv(struct cxl_doe_dev *doe_dev)
> > +{
> > +	up_read(&doe_dev->driver_access);
> > +}
> > +
> >  /**
> >   * cxl_pci_create_doe_devices - Create auxiliary bus DOE devices for all DOE
> >   *				mailboxes found
> > @@ -652,6 +663,7 @@ static int cxl_pci_create_doe_devices(struct pci_dev *pdev)
> >  			return -ENOMEM;
> >  
> >  		new_dev->pdev = pdev;
> > +		init_rwsem(&new_dev->driver_access);
> >  		new_dev->cap_offset = off;
> >  		new_dev->use_irq = use_irq;
> >  
> > @@ -682,6 +694,13 @@ static int cxl_pci_create_doe_devices(struct pci_dev *pdev)
> >  					      adev);
> >  		if (rc)
> >  			return rc;
> > +
> > +		if (device_attach(&adev->dev) != 1) {
> > +			dev_err(&adev->dev,
> > +				"Failed to attach a driver to DOE device %d\n",
> > +				adev->id);
> > +			return -ENODEV;
> > +		}
> 
> Can you add a comment on why this has to be the case at this point.  Why can't
> the driver come along later?

Yes I will.

I've not really liked this aspect of the auxiliary device arch.  But I've not
convinced myself that it will work ok to leave this till later.

Putting the CDAT retry on a timer might be a better option but it would also
mean searching for the proper DOE would need to be delayed as well...

For now I'll put in a comment.

Thanks for the review!
Ira

> 
> >  	}
> >  
> >  	return 0;
> > @@ -785,6 +804,7 @@ static struct pci_driver cxl_pci_driver = {
> >  	},
> >  };
> 
> ...
> 
