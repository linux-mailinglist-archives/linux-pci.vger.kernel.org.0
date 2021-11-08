Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7ED844800F
	for <lists+linux-pci@lfdr.de>; Mon,  8 Nov 2021 14:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236570AbhKHNMH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Nov 2021 08:12:07 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4069 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238803AbhKHNMG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Nov 2021 08:12:06 -0500
Received: from fraeml736-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Hnrvd0MCLz67ykV;
        Mon,  8 Nov 2021 21:05:49 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml736-chm.china.huawei.com (10.206.15.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Mon, 8 Nov 2021 14:09:20 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Mon, 8 Nov
 2021 13:09:19 +0000
Date:   Mon, 8 Nov 2021 13:09:18 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <ben.widawsky@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 3/5] cxl/pci: Add DOE Auxiliary Devices
Message-ID: <20211108130918.00004d76@Huawei.com>
In-Reply-To: <20211105235056.3711389-4-ira.weiny@intel.com>
References: <20211105235056.3711389-1-ira.weiny@intel.com>
        <20211105235056.3711389-4-ira.weiny@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml754-chm.china.huawei.com (10.201.108.204) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 5 Nov 2021 16:50:54 -0700
<ira.weiny@intel.com> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> CXL devices have DOE mailboxes.  Create auxiliary devices which can be
> driven by the generic DOE auxiliary driver.

I'd like Bjorn's input on the balance here between what is done
in cxl/pci.c and what should be in the PCI core code somewhere.

The tricky bit preventing this being done entirely as part of 
PCI device instantiation is the interrupts.

> 
> Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Mostly new code, so not sure I should really be listed on this
one but I don't mind either way.

A few comments inline but overall this ended up nice and clean.

> 
> ---
> Changes from V4:
> 	Make this an Auxiliary Driver rather than library functions
> 	Split this out into it's own patch
> 	Base on the new cxl_dev_state structure
> 
> Changes from Ben
> 	s/CXL_DOE_DEV_NAME/DOE_DEV_NAME/
> ---
>  drivers/cxl/Kconfig |   1 +
>  drivers/cxl/cxl.h   |  13 +++++
>  drivers/cxl/pci.c   | 120 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 134 insertions(+)
> 
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index 67c91378f2dd..9d53720bea07 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -16,6 +16,7 @@ if CXL_BUS
>  config CXL_MEM
>  	tristate "CXL.mem: Memory Devices"
>  	default CXL_BUS
> +	select PCI_DOE_DRIVER
>  	help
>  	  The CXL.mem protocol allows a device to act as a provider of
>  	  "System RAM" and/or "Persistent Memory" that is fully coherent
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 5e2e93451928..f1241a7f2b7b 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -75,6 +75,19 @@ static inline int cxl_hdm_decoder_count(u32 cap_hdr)
>  #define CXLDEV_MBOX_BG_CMD_STATUS_OFFSET 0x18
>  #define CXLDEV_MBOX_PAYLOAD_OFFSET 0x20
>  
> +/*
> + * Address space properties derived from:
> + * CXL 2.0 8.2.5.12.7 CXL HDM Decoder 0 Control Register
> + */
> +#define CXL_ADDRSPACE_RAM   BIT(0)
> +#define CXL_ADDRSPACE_PMEM  BIT(1)
> +#define CXL_ADDRSPACE_TYPE2 BIT(2)
> +#define CXL_ADDRSPACE_TYPE3 BIT(3)
> +#define CXL_ADDRSPACE_MASK  GENMASK(3, 0)

Stray.

> +
> +#define CXL_DOE_PROTOCOL_COMPLIANCE 0
> +#define CXL_DOE_PROTOCOL_TABLE_ACCESS 2
> +
>  #define CXL_COMPONENT_REGS() \
>  	void __iomem *hdm_decoder
>  
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 8dc91fd3396a..df524b74f1d2 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -6,6 +6,7 @@
>  #include <linux/mutex.h>
>  #include <linux/list.h>
>  #include <linux/pci.h>
> +#include <linux/pci-doe.h>
>  #include <linux/io.h>
>  #include "cxlmem.h"
>  #include "pci.h"
> @@ -471,6 +472,120 @@ static int cxl_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>  	return rc;
>  }
>  
> +static void cxl_mem_free_irq_vectors(void *data)
> +{
> +	pci_free_irq_vectors(data);
> +}
> +
> +static void cxl_destroy_doe_device(void *ad)
> +{
> +	struct auxiliary_device *adev = ad;
Local variable doesn't add anything, just pass it directly
into the functions as a void *.

> +
> +	auxiliary_device_delete(adev);
> +	auxiliary_device_uninit(adev);

Both needed?  These are just wrappers around
put_device() and device_del()

Normally after device_add() suceeded we only ever call device_del()
as per the docs for device_add()
https://elixir.bootlin.com/linux/latest/source/drivers/base/core.c#L3277

> +}
> +
> +static DEFINE_IDA(cxl_doe_adev_ida);
> +static void __doe_dev_release(struct auxiliary_device *adev)
> +{
> +	struct pci_doe_dev *doe_dev = container_of(adev, struct pci_doe_dev,
> +						   adev);
> +
> +	ida_free(&cxl_doe_adev_ida, adev->id);
> +	kfree(doe_dev);
> +}
> +
> +static void cxl_doe_dev_release(struct device *dev)
> +{
> +	struct auxiliary_device *adev = container_of(dev,
> +						struct auxiliary_device,
> +						dev);
> +	__doe_dev_release(adev);
> +}
> +
> +static int cxl_setup_doe_devices(struct cxl_dev_state *cxlds)

Pass in the struct device, or maybe even the struct pci_dev as
nothing in here is using the cxl_dev_state.

> +{
> +	struct device *dev = cxlds->dev;
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	int irqs, rc;
> +	u16 pos = 0;
> +
> +	/*
> +	 * An implementation of a cxl type3 device may support an unknown
> +	 * number of interrupts. Assume that number is not that large and
> +	 * request them all.
> +	 */
> +	irqs = pci_msix_vec_count(pdev);
> +	rc = pci_alloc_irq_vectors(pdev, irqs, irqs, PCI_IRQ_MSIX);
> +	if (rc != irqs) {
> +		/* No interrupt available - carry on */
> +		dev_dbg(dev, "No interrupts available for DOE\n");
> +	} else {
> +		/*
> +		 * Enabling bus mastering could be done within the DOE
> +		 * initialization, but as it potentially has other impacts
> +		 * keep it within the driver.
> +		 */
> +		pci_set_master(pdev);
> +		rc = devm_add_action_or_reset(dev,
> +					      cxl_mem_free_irq_vectors,
> +					      pdev);
> +		if (rc)
> +			return rc;
> +	}
> +

Above here is driver specific...
Everything from here is is generic so perhaps move it to the PCI core?
Alternatively wait until we have users that aren't CXL.

> +	pos = pci_find_next_ext_capability(pdev, pos, PCI_EXT_CAP_ID_DOE);
> +
> +	while (pos > 0) {
> +		struct auxiliary_device *adev;
> +		struct pci_doe_dev *new_dev;
> +		int id;
> +
> +		new_dev = kzalloc(sizeof(*new_dev), GFP_KERNEL);
> +		if (!new_dev)
> +			return -ENOMEM;
> +
> +		new_dev->pdev = pdev;
> +		new_dev->cap_offset = pos;
> +
> +		/* Set up struct auxiliary_device */
> +		adev = &new_dev->adev;
> +		id = ida_alloc(&cxl_doe_adev_ida, GFP_KERNEL);
> +		if (id < 0) {
> +			kfree(new_dev);
> +			return -ENOMEM;
> +		}
> +
> +		adev->id = id;
> +		adev->name = DOE_DEV_NAME;
> +		adev->dev.release = cxl_doe_dev_release;
> +		adev->dev.parent = dev;
> +
> +		if (auxiliary_device_init(adev)) {
> +			__doe_dev_release(adev);
> +			return -EIO;
> +		}
> +
> +		if (auxiliary_device_add(adev)) {
> +			auxiliary_device_uninit(adev);
> +			return -EIO;
> +		}
> +
> +		rc = devm_add_action_or_reset(dev, cxl_destroy_doe_device, adev);
> +		if (rc)
> +			return rc;
> +
> +		if (device_attach(&adev->dev) != 1)
> +			dev_err(&adev->dev,
> +				"Failed to attach a driver to DOE device %d\n",
> +				adev->id);

I wondered about this and how it would happen.
Given soft dependency only between the drivers it's possible but error or info?
I'd go with dev_info().  It is an error I'd bail out and used deferred probing
to try again when it will succeed.

> +
> +		pos = pci_find_next_ext_capability(pdev, pos, PCI_EXT_CAP_ID_DOE);
> +	}
> +
> +	return 0;
> +}
> +
>  static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
>  	struct cxl_register_map map;
> @@ -517,6 +632,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (rc)
>  		return rc;
>  
> +	rc = cxl_setup_doe_devices(cxlds);
> +	if (rc)
> +		return rc;
> +
>  	cxlmd = devm_cxl_add_memdev(cxlds);
>  	if (IS_ERR(cxlmd))
>  		return PTR_ERR(cxlmd);
> @@ -546,3 +665,4 @@ static struct pci_driver cxl_pci_driver = {
>  MODULE_LICENSE("GPL v2");
>  module_pci_driver(cxl_pci_driver);
>  MODULE_IMPORT_NS(CXL);
> +MODULE_SOFTDEP("pre: pci_doe");

