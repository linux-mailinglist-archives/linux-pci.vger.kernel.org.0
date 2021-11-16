Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF0BD453CDA
	for <lists+linux-pci@lfdr.de>; Wed, 17 Nov 2021 00:48:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbhKPXv2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Nov 2021 18:51:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:60878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229791AbhKPXv2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 16 Nov 2021 18:51:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3DAB163212;
        Tue, 16 Nov 2021 23:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637106510;
        bh=89Gw/QpSxelDge5mILQRkG25txK3rPQfa34js5dTPpA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=LbXIjVtg/r6S6l4z899U9m80RkhHY0+bLHQ70If2zvmMHGEx9gxNMBU7gEGdDU9Kp
         J9ftJp4NorEIwAu6PUuoAJetCSqOa3jfBTiNn402FCC798cRGUlXtMtsZf3ZeWQ4ay
         hvlGz20o+PPV3NVEqobpXz0/VpAP8tzaThEz6FsvmYYy+/QIMRvpbOmP0KwNW1vQJO
         fwesVFx/VV0V2zXtJvZBJZBJNO/qrocfCnWSbBKIa29OGMucmypt8VvLecmuFZljBu
         15c4pqcJmpp0jfaoZ+nsZ2q/PU3G6aTBeWKV1Fw9ra7FftcSzilvL2YxuawhXo/GYr
         POsj5cumrp9qg==
Date:   Tue, 16 Nov 2021 17:48:29 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     ira.weiny@intel.com
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 3/5] cxl/pci: Add DOE Auxiliary Devices
Message-ID: <20211116234829.GA1691301@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211105235056.3711389-4-ira.weiny@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 05, 2021 at 04:50:54PM -0700, ira.weiny@intel.com wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> CXL devices have DOE mailboxes.  Create auxiliary devices which can be
> driven by the generic DOE auxiliary driver.

I admit to not being thrilled about joining the elite group of six
users of auxiliary_device_init(), and I don't know exactly what
benefits the auxiliary devices have.

Based on the ECN, it sounds like any PCI device can have DOE
capabilities, so I suspect the support for it should be in
drivers/pci/, not drivers/cxl/.  I don't really see anything
CXL-specific below.

What do these DOE capabilities look like in lspci?  I don't see any
support in the current version (which looks like it's a year old).

> Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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
> +
> +#define CXL_DOE_PROTOCOL_COMPLIANCE 0
> +#define CXL_DOE_PROTOCOL_TABLE_ACCESS 2

None of these are used here, so they belong in a different patch.

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
> +
> +	auxiliary_device_delete(adev);
> +	auxiliary_device_uninit(adev);
> +}
> +
> +static DEFINE_IDA(cxl_doe_adev_ida);
> +static void __doe_dev_release(struct auxiliary_device *adev)

Why the "__" prefix?  I don't see any similar name that requires
disambiguation.

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

This enables the device to perform DMA, which doesn't seem to have
anything to do with the rest of this code.  Can it go somewhere near
something to do with DMA?

> +		rc = devm_add_action_or_reset(dev,
> +					      cxl_mem_free_irq_vectors,
> +					      pdev);
> +		if (rc)
> +			return rc;
> +	}
> +
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
> +
> +		pos = pci_find_next_ext_capability(pdev, pos, PCI_EXT_CAP_ID_DOE);

So we get an auxiliary device for every instance of a DOE capability?
I think the commit log should mention something about how many are
created (e.g., "one per DOE capability"), how they are named, whether
they appear in sysfs, how drivers bind to them, etc.

I assume there needs to be some coordination between possible multiple
users of a DOE capability?  How does that work?

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
> -- 
> 2.28.0.rc0.12.gb6a658bd00c9
> 
