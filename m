Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C627454655
	for <lists+linux-pci@lfdr.de>; Wed, 17 Nov 2021 13:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236481AbhKQM0j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Nov 2021 07:26:39 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4101 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233318AbhKQM0i (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Nov 2021 07:26:38 -0500
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HvMSV36msz688Mv;
        Wed, 17 Nov 2021 20:19:54 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.20; Wed, 17 Nov 2021 13:23:38 +0100
Received: from localhost (10.52.125.109) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Wed, 17 Nov
 2021 12:23:37 +0000
Date:   Wed, 17 Nov 2021 12:23:35 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 3/5] cxl/pci: Add DOE Auxiliary Devices
Message-ID: <20211117122335.00000b35@Huawei.com>
In-Reply-To: <20211116234829.GA1691301@bhelgaas>
References: <20211105235056.3711389-4-ira.weiny@intel.com>
        <20211116234829.GA1691301@bhelgaas>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.125.109]
X-ClientProxiedBy: lhreml713-chm.china.huawei.com (10.201.108.64) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 16 Nov 2021 17:48:29 -0600
Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Fri, Nov 05, 2021 at 04:50:54PM -0700, ira.weiny@intel.com wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > CXL devices have DOE mailboxes.  Create auxiliary devices which can be
> > driven by the generic DOE auxiliary driver.  
> 
> I admit to not being thrilled about joining the elite group of six
> users of auxiliary_device_init(), and I don't know exactly what
> benefits the auxiliary devices have.

One for Dan...

> 
> Based on the ECN, it sounds like any PCI device can have DOE
> capabilities, so I suspect the support for it should be in
> drivers/pci/, not drivers/cxl/.  I don't really see anything
> CXL-specific below.

Agreed though how it all gets tied together isn't totally clear
to me yet. The messy bit is interrupts given I don't think we have
a model for enabling those anywhere other than in individual PCI drivers.

> 
> What do these DOE capabilities look like in lspci?  I don't see any
> support in the current version (which looks like it's a year old).

I don't think anyone has added support yet, but it would be simple to do.
Given possibility of breaking things if we actually exercise the discovery
protocol, we'll be constrained to just reporting there is a DOE instances
which is of limited use.

> 
> > Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > ---
> > Changes from V4:
> > 	Make this an Auxiliary Driver rather than library functions
> > 	Split this out into it's own patch
> > 	Base on the new cxl_dev_state structure
> > 
> > Changes from Ben
> > 	s/CXL_DOE_DEV_NAME/DOE_DEV_NAME/
> > ---
> >  drivers/cxl/Kconfig |   1 +
> >  drivers/cxl/cxl.h   |  13 +++++
> >  drivers/cxl/pci.c   | 120 ++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 134 insertions(+)
> > 
> > diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> > index 67c91378f2dd..9d53720bea07 100644
> > --- a/drivers/cxl/Kconfig
> > +++ b/drivers/cxl/Kconfig
> > @@ -16,6 +16,7 @@ if CXL_BUS
> >  config CXL_MEM
> >  	tristate "CXL.mem: Memory Devices"
> >  	default CXL_BUS
> > +	select PCI_DOE_DRIVER
> >  	help
> >  	  The CXL.mem protocol allows a device to act as a provider of
> >  	  "System RAM" and/or "Persistent Memory" that is fully coherent
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index 5e2e93451928..f1241a7f2b7b 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -75,6 +75,19 @@ static inline int cxl_hdm_decoder_count(u32 cap_hdr)
> >  #define CXLDEV_MBOX_BG_CMD_STATUS_OFFSET 0x18
> >  #define CXLDEV_MBOX_PAYLOAD_OFFSET 0x20
> >  
> > +/*
> > + * Address space properties derived from:
> > + * CXL 2.0 8.2.5.12.7 CXL HDM Decoder 0 Control Register
> > + */
> > +#define CXL_ADDRSPACE_RAM   BIT(0)
> > +#define CXL_ADDRSPACE_PMEM  BIT(1)
> > +#define CXL_ADDRSPACE_TYPE2 BIT(2)
> > +#define CXL_ADDRSPACE_TYPE3 BIT(3)
> > +#define CXL_ADDRSPACE_MASK  GENMASK(3, 0)
> > +
> > +#define CXL_DOE_PROTOCOL_COMPLIANCE 0
> > +#define CXL_DOE_PROTOCOL_TABLE_ACCESS 2  
> 
> None of these are used here, so they belong in a different patch.s
> 
> >  #define CXL_COMPONENT_REGS() \
> >  	void __iomem *hdm_decoder
> >  
> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > index 8dc91fd3396a..df524b74f1d2 100644
> > --- a/drivers/cxl/pci.c
> > +++ b/drivers/cxl/pci.c
> > @@ -6,6 +6,7 @@
> >  #include <linux/mutex.h>
> >  #include <linux/list.h>
> >  #include <linux/pci.h>
> > +#include <linux/pci-doe.h>
> >  #include <linux/io.h>
> >  #include "cxlmem.h"
> >  #include "pci.h"
> > @@ -471,6 +472,120 @@ static int cxl_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
> >  	return rc;
> >  }
> >  
> > +static void cxl_mem_free_irq_vectors(void *data)
> > +{
> > +	pci_free_irq_vectors(data);
> > +}
> > +
> > +static void cxl_destroy_doe_device(void *ad)
> > +{
> > +	struct auxiliary_device *adev = ad;
> > +
> > +	auxiliary_device_delete(adev);
> > +	auxiliary_device_uninit(adev);
> > +}
> > +
> > +static DEFINE_IDA(cxl_doe_adev_ida);
> > +static void __doe_dev_release(struct auxiliary_device *adev)  
> 
> Why the "__" prefix?  I don't see any similar name that requires
> disambiguation.
> 
> > +{
> > +	struct pci_doe_dev *doe_dev = container_of(adev, struct pci_doe_dev,
> > +						   adev);
> > +
> > +	ida_free(&cxl_doe_adev_ida, adev->id);
> > +	kfree(doe_dev);
> > +}
> > +
> > +static void cxl_doe_dev_release(struct device *dev)
> > +{
> > +	struct auxiliary_device *adev = container_of(dev,
> > +						struct auxiliary_device,
> > +						dev);
> > +	__doe_dev_release(adev);
> > +}
> > +
> > +static int cxl_setup_doe_devices(struct cxl_dev_state *cxlds)
> > +{
> > +	struct device *dev = cxlds->dev;
> > +	struct pci_dev *pdev = to_pci_dev(dev);
> > +	int irqs, rc;
> > +	u16 pos = 0;
> > +
> > +	/*
> > +	 * An implementation of a cxl type3 device may support an unknown
> > +	 * number of interrupts. Assume that number is not that large and
> > +	 * request them all.
> > +	 */
> > +	irqs = pci_msix_vec_count(pdev);
> > +	rc = pci_alloc_irq_vectors(pdev, irqs, irqs, PCI_IRQ_MSIX);
> > +	if (rc != irqs) {
> > +		/* No interrupt available - carry on */
> > +		dev_dbg(dev, "No interrupts available for DOE\n");
> > +	} else {
> > +		/*
> > +		 * Enabling bus mastering could be done within the DOE
> > +		 * initialization, but as it potentially has other impacts
> > +		 * keep it within the driver.
> > +		 */
> > +		pci_set_master(pdev);  
> 
> This enables the device to perform DMA, which doesn't seem to have
> anything to do with the rest of this code.  Can it go somewhere near
> something to do with DMA?

Needed for MSI/MSIx as well.  The driver doesn't do DMA for anything else.
Hence it's here in the interrupt enable path.

> 
> > +		rc = devm_add_action_or_reset(dev,
> > +					      cxl_mem_free_irq_vectors,
> > +					      pdev);
> > +		if (rc)
> > +			return rc;
> > +	}
> > +
> > +	pos = pci_find_next_ext_capability(pdev, pos, PCI_EXT_CAP_ID_DOE);
> > +
> > +	while (pos > 0) {
> > +		struct auxiliary_device *adev;
> > +		struct pci_doe_dev *new_dev;
> > +		int id;
> > +
> > +		new_dev = kzalloc(sizeof(*new_dev), GFP_KERNEL);
> > +		if (!new_dev)
> > +			return -ENOMEM;
> > +
> > +		new_dev->pdev = pdev;
> > +		new_dev->cap_offset = pos;
> > +
> > +		/* Set up struct auxiliary_device */
> > +		adev = &new_dev->adev;
> > +		id = ida_alloc(&cxl_doe_adev_ida, GFP_KERNEL);
> > +		if (id < 0) {
> > +			kfree(new_dev);
> > +			return -ENOMEM;
> > +		}
> > +
> > +		adev->id = id;
> > +		adev->name = DOE_DEV_NAME;
> > +		adev->dev.release = cxl_doe_dev_release;
> > +		adev->dev.parent = dev;
> > +
> > +		if (auxiliary_device_init(adev)) {
> > +			__doe_dev_release(adev);
> > +			return -EIO;
> > +		}
> > +
> > +		if (auxiliary_device_add(adev)) {
> > +			auxiliary_device_uninit(adev);
> > +			return -EIO;
> > +		}
> > +
> > +		rc = devm_add_action_or_reset(dev, cxl_destroy_doe_device, adev);
> > +		if (rc)
> > +			return rc;
> > +
> > +		if (device_attach(&adev->dev) != 1)
> > +			dev_err(&adev->dev,
> > +				"Failed to attach a driver to DOE device %d\n",
> > +				adev->id);
> > +
> > +		pos = pci_find_next_ext_capability(pdev, pos, PCI_EXT_CAP_ID_DOE);  
> 
> So we get an auxiliary device for every instance of a DOE capability?
> I think the commit log should mention something about how many are
> created (e.g., "one per DOE capability"), how they are named, whether
> they appear in sysfs, how drivers bind to them, etc.
> 
> I assume there needs to be some coordination between possible multiple
> users of a DOE capability?  How does that work?

The DOE handling implementation makes everything synchronous - so if multiple
users each may have to wait on queueing their query / responses exchanges.

The fun of non OS software accessing these is still an open question.

Jonathan

> 
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >  {
> >  	struct cxl_register_map map;
> > @@ -517,6 +632,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >  	if (rc)
> >  		return rc;
> >  
> > +	rc = cxl_setup_doe_devices(cxlds);
> > +	if (rc)
> > +		return rc;
> > +
> >  	cxlmd = devm_cxl_add_memdev(cxlds);
> >  	if (IS_ERR(cxlmd))
> >  		return PTR_ERR(cxlmd);
> > @@ -546,3 +665,4 @@ static struct pci_driver cxl_pci_driver = {
> >  MODULE_LICENSE("GPL v2");
> >  module_pci_driver(cxl_pci_driver);
> >  MODULE_IMPORT_NS(CXL);
> > +MODULE_SOFTDEP("pre: pci_doe");
> > -- 
> > 2.28.0.rc0.12.gb6a658bd00c9
> >   

