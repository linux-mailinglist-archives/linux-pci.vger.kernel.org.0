Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D41CF2B692A
	for <lists+linux-pci@lfdr.de>; Tue, 17 Nov 2020 16:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgKQP5E (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Nov 2020 10:57:04 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2122 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgKQP5D (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Nov 2020 10:57:03 -0500
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Cb9WM5GfHz67F6b;
        Tue, 17 Nov 2020 23:55:11 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 17 Nov 2020 16:57:00 +0100
Received: from localhost (10.47.31.177) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Tue, 17 Nov
 2020 15:56:59 +0000
Date:   Tue, 17 Nov 2020 15:56:51 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [RFC PATCH 8/9] cxl/mem: Register CXL memX devices
Message-ID: <20201117155651.0000368b@Huawei.com>
In-Reply-To: <20201111054356.793390-9-ben.widawsky@intel.com>
References: <20201111054356.793390-1-ben.widawsky@intel.com>
        <20201111054356.793390-9-ben.widawsky@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.31.177]
X-ClientProxiedBy: lhreml736-chm.china.huawei.com (10.201.108.87) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 10 Nov 2020 21:43:55 -0800
Ben Widawsky <ben.widawsky@intel.com> wrote:

> From: Dan Williams <dan.j.williams@intel.com>
> 
> Create the /sys/bus/cxl hierarchy to enumerate memory devices
> (per-endpoint control devices), memory address space devices (platform
> address ranges with interleaving, performance, and persistence
> attributes), and memory regions (active provisioned memory from an
> address space device that is in use as System RAM or delegated to
> libnvdimm as Persistent Memory regions).
> 
> For now, only the per-endpoint control devices are registered on the
> 'cxl' bus.

Reviewing ABI without documentation is challenging even when it's simple
so please add that for v2.

This patch feels somewhat unpolished, but I guess it is mainly here to
give an illustration of how stuff might fit together rather than
any expectation of detailed review.

So in that spirit I've just pointed out stuff that jumped out at me
during a quick read through.

Thanks,

Jonathan


> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
>  drivers/cxl/Makefile |   2 +
>  drivers/cxl/bus.c    |  35 ++++++
>  drivers/cxl/bus.h    |   8 ++
>  drivers/cxl/cxl.h    |  33 +++++
>  drivers/cxl/mem.c    | 287 ++++++++++++++++++++++++++++++++++++++++++-
>  5 files changed, 359 insertions(+), 6 deletions(-)
>  create mode 100644 drivers/cxl/bus.c
>  create mode 100644 drivers/cxl/bus.h
> 
> diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
> index 97fdffb00f2d..1cc032092852 100644
> --- a/drivers/cxl/Makefile
> +++ b/drivers/cxl/Makefile
> @@ -1,7 +1,9 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_CXL_ACPI) += cxl_acpi.o
>  obj-$(CONFIG_CXL_MEM) += cxl_mem.o
> +obj-$(CONFIG_CXL_BUS_PROVIDER) += cxl_bus.o
>  
>  ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE=CXL
>  cxl_acpi-y := acpi.o
>  cxl_mem-y := mem.o
> +cxl_bus-y := bus.o
> diff --git a/drivers/cxl/bus.c b/drivers/cxl/bus.c
> new file mode 100644
> index 000000000000..8594366955f7
> --- /dev/null
> +++ b/drivers/cxl/bus.c
> @@ -0,0 +1,35 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +// Copyright(c) 2020 Intel Corporation. All rights reserved.
> +#include <linux/device.h>
> +#include <linux/module.h>
> +
> +static struct bus_type cxl_bus_type = {
> +	.name = "cxl",
> +};
> +
> +int cxl_register(struct device *dev)
> +{
> +	int rc;
> +
> +	dev->bus = &cxl_bus_type;
> +	rc = device_add(dev);
> +	if (rc)
> +		put_device(dev);
> +	return rc;
> +}
> +EXPORT_SYMBOL_GPL(cxl_register);
> +
> +static __init int cxl_bus_init(void)
> +{
> +	return bus_register(&cxl_bus_type);
> +}
> +
> +static void cxl_bus_exit(void)
> +{
> +	bus_unregister(&cxl_bus_type);
> +}
> +
> +module_init(cxl_bus_init);
> +module_exit(cxl_bus_exit);
> +MODULE_LICENSE("GPL v2");
> +MODULE_AUTHOR("Intel Corporation");
> diff --git a/drivers/cxl/bus.h b/drivers/cxl/bus.h
> new file mode 100644
> index 000000000000..fe2bea2bbc3c
> --- /dev/null
> +++ b/drivers/cxl/bus.h
> @@ -0,0 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +// Copyright(c) 2020 Intel Corporation. All rights reserved.
> +#ifndef __CXL_BUS_H__
> +#define __CXL_BUS_H__
> +
> +int cxl_register(struct device *dev);
> +
> +#endif /* __CXL_BUS_H__ */
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index f49ab80f68bd..cef5fd9ea68b 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -3,6 +3,7 @@
>  
>  #ifndef __CXL_H__
>  #define __CXL_H__
> +#include <linux/range.h>
>  
>  /* Device */
>  #define CXLDEV_CAP_ARRAY_REG 0x0
> @@ -52,12 +53,24 @@
>  #define CXLMDEV_RESET_NEEDED_HOT 3
>  #define CXLMDEV_RESET_NEEDED_CXL 4
>  
> +struct cxl_memdev;
>  struct cxl_mem {
>  	struct pci_dev *pdev;
>  	void __iomem *regs;
> +	struct cxl_memdev *cxlmd;
>  
>  	spinlock_t mbox_lock; /* Protects device mailbox and firmware */
>  
> +	struct {
> +		struct range range;
> +	} pmem;
> +
> +	struct {
> +		struct range range;
> +	} ram;
> +
> +	char firmware_version[0x10];
> +
>  	/* Cap 0000h */
>  	struct {
>  		void __iomem *regs;
> @@ -130,4 +143,24 @@ static inline void cxl_mbox_payload_drain(struct cxl_mem *cxlm,
>  {
>  	memcpy_fromio(output, cxlm->mbox.regs + CXLDEV_MB_PAYLOAD, length);
>  }
> +
> +#define CXL_MBOX_IDENTIFY 0x4000
> +
> +struct cxl_mbox_identify {
> +	char fw_revision[0x10];
> +	__le64 total_capacity;
> +	__le64 volatile_capacity;
> +	__le64 persistent_capacity;
> +	__le64 partition_align;
> +	__le16 info_event_log_size;
> +	__le16 warning_event_log_size;
> +	__le16 failure_event_log_size;
> +	__le16 fatal_event_log_size;
> +	__le32 lsa_size;
> +	u8 poison_list_max_mer[3];
> +	__le16 inject_poison_limit;
> +	u8 poison_caps;
> +	u8 qos_telemetry_caps;
> +} __packed;
> +
>  #endif /* __CXL_H__ */
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 08913360d500..54743d196feb 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -2,11 +2,15 @@
>  // Copyright(c) 2020 Intel Corporation. All rights reserved.
>  #include <linux/sched/clock.h>
>  #include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/cdev.h>
> +#include <linux/idr.h>
>  #include <linux/pci.h>
>  #include <linux/io.h>
>  #include "acpi.h"
>  #include "pci.h"
>  #include "cxl.h"
> +#include "bus.h"
>  
>  struct mbox_cmd {
>  	u16 cmd;
> @@ -15,6 +19,53 @@ struct mbox_cmd {
>  	u16 return_code;
>  };
>  
> +/*
> + * An entire PCI topology full of devices should be enough for any
> + * config
> + */
> +#define CXL_MEM_MAX_DEVS 65536
> +
> +struct cxl_memdev {
> +	struct device dev;
> +	struct cxl_mem *cxlm;
> +	int id;
> +};
> +
> +static int cxl_mem_major;
> +static struct cdev cxl_mem_cdev;
> +static DEFINE_IDR(cxl_mem_idr);
> +static DEFINE_MUTEX(cxl_memdev_lock);

Define scope of this lock with a comment.

> +
> +static int cxl_mem_open(struct inode *inode, struct file *file)
> +{
> +	long minor = iminor(inode);
> +	struct cxl_memdev *cxlmd;
> +
> +	rcu_read_lock();
> +	cxlmd = idr_find(&cxl_mem_idr, minor);
> +	rcu_read_unlock();
> +
> +	if (!cxlmd)
> +		return -ENXIO;
> +
> +	file->private_data = cxlmd;
> +
> +	return 0;
> +}
> +
> +static long cxl_mem_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> +{
> +	return -ENOTTY;
> +}
> +
> +static const struct file_operations cxl_mem_fops = {
> +	.owner = THIS_MODULE,
> +	.open = cxl_mem_open,
> +	.unlocked_ioctl = cxl_mem_ioctl,
> +	.compat_ioctl = compat_ptr_ioctl,
> +	.llseek = noop_llseek,
> +};
> +
>  static int cxldev_wait_for_doorbell(struct cxl_mem *cxlm)
>  {
>  	u64 start, now;
> @@ -53,7 +104,7 @@ static int cxldev_wait_for_doorbell(struct cxl_mem *cxlm)
>   * Returns 0 if the doorbell transaction was successful from a protocol level.
>   * Caller should check the return code in @mbox_cmd to make sure it succeeded.
>   */
> -static int __maybe_unused cxl_mem_mbox_send_cmd(struct cxl_mem *cxlm, struct mbox_cmd *mbox_cmd)
> +static int cxl_mem_mbox_send_cmd(struct cxl_mem *cxlm, struct mbox_cmd *mbox_cmd)
>  {
>  	u64 cmd, status;
>  	int rc;
> @@ -277,10 +328,185 @@ static int cxl_mem_dvsec(struct pci_dev *pdev, int dvsec)
>  	return 0;
>  }
>  
> +static struct cxl_memdev *to_cxl_memdev(struct device *dev)
> +{
> +	return container_of(dev, struct cxl_memdev, dev);
> +}
> +
> +static void cxl_memdev_release(struct device *dev)
> +{
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +
> +	mutex_lock(&cxl_memdev_lock);
> +	idr_remove(&cxl_mem_idr, cxlmd->id);
> +	mutex_unlock(&cxl_memdev_lock);
> +
> +	kfree(cxlmd);
> +}
> +
> +static char *cxl_memdev_devnode(struct device *dev, umode_t *mode, kuid_t *uid, kgid_t *gid)
> +{
> +	return kasprintf(GFP_KERNEL, "cxl/%s", dev_name(dev));
> +}
> +
> +static ssize_t firmware_version_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +	struct cxl_mem *cxlm = cxlmd->cxlm;
> +
> +	return sprintf(buf, "%.16s\n", cxlm->firmware_version);
> +}
> +static DEVICE_ATTR_RO(firmware_version);
> +
> +static ssize_t ram_size_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +	struct cxl_mem *cxlm = cxlmd->cxlm;
> +
> +	return sprintf(buf, "%#llx\n", (unsigned long long) range_len(&cxlm->ram.range));
> +}
> +static struct device_attribute dev_attr_ram_size = __ATTR(size, 0444, ram_size_show, NULL);
> +
> +static ssize_t pmem_size_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +	struct cxl_mem *cxlm = cxlmd->cxlm;
> +
> +	return sprintf(buf, "%#llx\n", (unsigned long long) range_len(&cxlm->pmem.range));
> +}
> +static struct device_attribute dev_attr_pmem_size = __ATTR(size, 0444, pmem_size_show, NULL);
> +
> +static struct attribute *cxl_memdev_attributes[] = {
> +	&dev_attr_firmware_version.attr,
> +	NULL,
> +};
> +
> +static struct attribute *cxl_memdev_pmem_attributes[] = {
> +	&dev_attr_pmem_size.attr,

It's simple, but should still have docs in Documentation/ABI/testing/sysfs...

> +	NULL,
> +};
> +
> +static struct attribute *cxl_memdev_ram_attributes[] = {
> +	&dev_attr_ram_size.attr,
> +	NULL,
> +};
> +
> +static struct attribute_group cxl_memdev_attribute_group = {
> +	.attrs = cxl_memdev_attributes,
> +};
> +
> +static struct attribute_group cxl_memdev_ram_attribute_group = {
> +	.name = "ram",
> +	.attrs = cxl_memdev_ram_attributes,
> +};
> +
> +static struct attribute_group cxl_memdev_pmem_attribute_group = {
> +	.name = "pmem",
> +	.attrs = cxl_memdev_pmem_attributes,
> +};
> +
> +static const struct attribute_group *cxl_memdev_attribute_groups[] = {
> +	&cxl_memdev_attribute_group,
> +	&cxl_memdev_ram_attribute_group,
> +	&cxl_memdev_pmem_attribute_group,
> +	NULL,
> +};
> +
> +static const struct device_type cxl_memdev_type = {
> +	.name = "cxl_memdev",
> +	.release = cxl_memdev_release,
> +	.devnode = cxl_memdev_devnode,
> +	.groups = cxl_memdev_attribute_groups,
> +};
> +
> +static struct cxl_memdev *cxl_mem_add_memdev(struct cxl_mem *cxlm)
> +{
> +	struct pci_dev *pdev = cxlm->pdev;
> +	struct cxl_memdev *cxlmd;
> +	struct device *dev;
> +	int id, rc;
> +
> +	cxlmd = kzalloc(sizeof(*cxlmd), GFP_KERNEL);

Maybe I missed it, but I'm not seeing this freed anywhere.

> +	if (!cxlmd)
> +		return ERR_PTR(-ENOMEM);
> +
> +	cxlmd->cxlm = cxlm;
> +	cxlm->cxlmd = cxlmd;
> +
> +	mutex_lock(&cxl_memdev_lock);
> +	id = idr_alloc(&cxl_mem_idr, cxlmd, 0, CXL_MEM_MAX_DEVS, GFP_KERNEL);
> +	mutex_unlock(&cxl_memdev_lock);
> +	if (id < 0) {
> +		rc = id;
> +		goto err_idr;
> +	}
> +
> +	cxlmd->id = id;
> +
> +	dev = &cxlmd->dev;
> +
> +	device_initialize(dev);
> +	dev->parent = &pdev->dev;
> +	dev->devt = MKDEV(cxl_mem_major, id);
> +	dev->type = &cxl_memdev_type;
> +	dev_set_name(dev, "mem%d", id);

blank line here

> +	rc = cxl_register(dev);
> +	if (rc)
> +		return ERR_PTR(rc);
> +
> +	return cxlmd;
> +
> +err_idr:
> +	kfree(cxlmd);
> +
> +	return ERR_PTR(rc);
> +}
> +

...

>  static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
>  	struct cxl_mem *cxlm = ERR_PTR(-ENXIO);
>  	struct device *dev = &pdev->dev;
> +	struct cxl_memdev *cxlmd;
>  	int rc, regloc, i;
>  
>  	rc = cxl_bus_prepared(pdev);
> @@ -319,20 +545,31 @@ static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (rc)
>  		return rc;
>  
> -	/* Check that hardware "looks" okay. */
> -	rc = cxl_mem_mbox_get(cxlm);
> +	rc = cxl_mem_identify(cxlm);
>  	if (rc)
>  		return rc;
> -
> -	cxl_mem_mbox_put(cxlm);

It was kind of nice to see the flow earlier, but I'm also thinking it made
a slightly harder to read patch.  Hmm.  Maybe just drop the version earlier
in favour of a todo comment that you then do here?

>  	dev_dbg(&pdev->dev, "CXL Memory Device Interface Up\n");
> +

Nice to tidy that up by moving to earlier patch.

>  	pci_set_drvdata(pdev, cxlm);
>  
> +	cxlmd = cxl_mem_add_memdev(cxlm);
> +	if (IS_ERR(cxlmd))
> +		return PTR_ERR(cxlmd);

Given we don't actually use cxlmd perhaps a simple return value
of 0 or error would be better from cxl_mem_add_memdev()

(I guess you may have follow up patches that do something with it
 here, though it feels wrong to ever do so given it is now registered
 and hence exposed to the system).

> +
>  	return 0;
>  }
>  
>  static void cxl_mem_remove(struct pci_dev *pdev)
>  {
> +	struct cxl_mem *cxlm = pci_get_drvdata(pdev);
> +	struct cxl_memdev *cxlmd = cxlm->cxlmd;
> +
> +	device_lock(&cxlmd->dev);
> +	cxlm->cxlmd = NULL;
> +	cxlmd->cxlm = NULL;
> +	device_unlock(&cxlmd->dev);
> +
> +	device_unregister(&cxlmd->dev);

Why device_unregister last? Normally removing exposure to the
system is the first thing you do in a remove() call.
Particularly as you'll get NULL ptr dereferences if anyone
manages a sysfs read between the pointers being set to NULL above
and the device_unregister() taking away the sysfs files.



>  }
>  
>  static const struct pci_device_id cxl_mem_pci_tbl[] = {
> @@ -350,7 +587,45 @@ static struct pci_driver cxl_mem_driver = {
>  	.remove			= cxl_mem_remove,
>  };
>  
> +static __init int cxl_mem_init(void)
> +{
> +	int rc;
> +	dev_t devt;
> +
> +	rc = alloc_chrdev_region(&devt, 0, CXL_MEM_MAX_DEVS, "cxl");
> +	if (rc)
> +		return rc;
> +
> +	cxl_mem_major = MAJOR(devt);
> +
> +	cdev_init(&cxl_mem_cdev, &cxl_mem_fops);
> +	rc = cdev_add(&cxl_mem_cdev, MKDEV(cxl_mem_major, 0), CXL_MEM_MAX_DEVS);
> +	if (rc)
> +		goto err_cdev;
> +
> +	rc = pci_register_driver(&cxl_mem_driver);
> +	if (rc)
> +		goto err_driver;
> +
> +	return 0;
> +
> +err_driver:
> +	cdev_del(&cxl_mem_cdev);
> +err_cdev:
> +	unregister_chrdev_region(MKDEV(cxl_mem_major, 0), CXL_MEM_MAX_DEVS);
> +
> +	return rc;
> +}
> +
> +static __exit void cxl_mem_exit(void)
> +{
> +	pci_unregister_driver(&cxl_mem_driver);
> +	unregister_chrdev_region(MKDEV(cxl_mem_major, 0), CXL_MEM_MAX_DEVS);
> +	cdev_del(&cxl_mem_cdev);

Ordering?  cdev_dev should be before unregister_chrdev_region to match
error handling in init()

> +}
> +
>  MODULE_LICENSE("GPL v2");
>  MODULE_AUTHOR("Intel Corporation");
> -module_pci_driver(cxl_mem_driver);
> +module_init(cxl_mem_init);
> +module_exit(cxl_mem_exit);
>  MODULE_IMPORT_NS(CXL);

