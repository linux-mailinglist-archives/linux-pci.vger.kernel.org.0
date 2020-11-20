Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10FE42BA03D
	for <lists+linux-pci@lfdr.de>; Fri, 20 Nov 2020 03:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgKTCQd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Nov 2020 21:16:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgKTCQc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Nov 2020 21:16:32 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15CCAC061A04
        for <linux-pci@vger.kernel.org>; Thu, 19 Nov 2020 18:16:32 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id o9so10813964ejg.1
        for <linux-pci@vger.kernel.org>; Thu, 19 Nov 2020 18:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v6kLUxlrKe6tnwhUJzi6NamX51UgS0+NJLjXPjBDOQ8=;
        b=GTk6xKkIjTs8BkIaJ8yxh+sRqm4h1lxe4HiZV7HrxkJVdZ2s8vAY6RBoS7CCCDGVQi
         pYjr+IYWhteMFgsj46qrXE5sq7yBDi1bjQEEe4WAARjgM1HDl+kqTK2XZBltVFPS+VmE
         kwO9KM9BfxWpBay9EMMIV7TJKEDa5FWUQ99IKlzyo7agvyvXCJ4lqrQ76nMTmJkQwas9
         KuoVYRDlMQgraNYeJVD1C4FajJyymR/Y31xcE2D1242nAmjPMD9Tap0A7uhQLn+bBjTH
         C3FuvvQj20dU2J+GqSEiy8yC/4GpZ/r3bh1BcHWz0ZiUXbOguvQ+vCqOcdqbx2JH6isN
         TBAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v6kLUxlrKe6tnwhUJzi6NamX51UgS0+NJLjXPjBDOQ8=;
        b=kDDO+ey7qqeF+zXPToZB0dDLKreGQROICQgRLY6Kb0SAJEwUIhOc+0kBgHToMiYExK
         yLaTm4SSKWL0wL5OEnAfzCknUwLw1Bgv2r13ZEzjYimDd3tdxgkWwZSVrJ2Y6cOi4fXZ
         6iiROevqZC5LCQ4SexwaVnL2b01GElEO16x2v5UbQhLTxCis/9dKnUvk/VlhJSOVyH+S
         PqM50cyv16EooLAEXxTWwxjJ6lmw3BgVrJ5ifm1Vka3l7npFV2H/nw77ORix21DOnr+9
         1gGfALbFcHBCNXNVw9yTwRz3smOynJ/JGMsDm4wTkGq7aSW49H0lKg3WJJ7mVoBPOdEh
         MscA==
X-Gm-Message-State: AOAM531+NBJrMajD7CMVNz9p5Ddskok8ZlJymNOVn5O8L/mpU3sg4LAB
        nHheKQ5XeHWP7ev0svqaVKH5igZvUUGbhiHjESCD7fBojj2cKw==
X-Google-Smtp-Source: ABdhPJyOicP7FQBm83dZ9vUP5jh7FdIU6Px81J0mmc95avfiLVhwPymz2qeYoySeBILMsrvE51C9kZYWct1b+Y+MGQc=
X-Received: by 2002:a17:906:241b:: with SMTP id z27mr29560299eja.418.1605838590447;
 Thu, 19 Nov 2020 18:16:30 -0800 (PST)
MIME-Version: 1.0
References: <20201111054356.793390-1-ben.widawsky@intel.com>
 <20201111054356.793390-9-ben.widawsky@intel.com> <20201117155651.0000368b@Huawei.com>
In-Reply-To: <20201117155651.0000368b@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 19 Nov 2020 18:16:19 -0800
Message-ID: <CAPcyv4ifDfzN=NTNZTh+xU_-b5Rm4jNOLiakQv-DPQa+6hfRaQ@mail.gmail.com>
Subject: Re: [RFC PATCH 8/9] cxl/mem: Register CXL memX devices
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>, linux-cxl@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 17, 2020 at 7:57 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Tue, 10 Nov 2020 21:43:55 -0800
> Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> > From: Dan Williams <dan.j.williams@intel.com>
> >
> > Create the /sys/bus/cxl hierarchy to enumerate memory devices
> > (per-endpoint control devices), memory address space devices (platform
> > address ranges with interleaving, performance, and persistence
> > attributes), and memory regions (active provisioned memory from an
> > address space device that is in use as System RAM or delegated to
> > libnvdimm as Persistent Memory regions).
> >
> > For now, only the per-endpoint control devices are registered on the
> > 'cxl' bus.
>
> Reviewing ABI without documentation is challenging even when it's simple
> so please add that for v2.
>
> This patch feels somewhat unpolished, but I guess it is mainly here to
> give an illustration of how stuff might fit together rather than
> any expectation of detailed review.

Yeah, this is definitely an early look in the spirit of "Release early
/ release often".

>
> So in that spirit I've just pointed out stuff that jumped out at me
> during a quick read through.
>
> Thanks,
>
> Jonathan
>
>
> >
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > ---
> >  drivers/cxl/Makefile |   2 +
> >  drivers/cxl/bus.c    |  35 ++++++
> >  drivers/cxl/bus.h    |   8 ++
> >  drivers/cxl/cxl.h    |  33 +++++
> >  drivers/cxl/mem.c    | 287 ++++++++++++++++++++++++++++++++++++++++++-
> >  5 files changed, 359 insertions(+), 6 deletions(-)
> >  create mode 100644 drivers/cxl/bus.c
> >  create mode 100644 drivers/cxl/bus.h
> >
> > diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
> > index 97fdffb00f2d..1cc032092852 100644
> > --- a/drivers/cxl/Makefile
> > +++ b/drivers/cxl/Makefile
> > @@ -1,7 +1,9 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >  obj-$(CONFIG_CXL_ACPI) += cxl_acpi.o
> >  obj-$(CONFIG_CXL_MEM) += cxl_mem.o
> > +obj-$(CONFIG_CXL_BUS_PROVIDER) += cxl_bus.o
> >
> >  ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE=CXL
> >  cxl_acpi-y := acpi.o
> >  cxl_mem-y := mem.o
> > +cxl_bus-y := bus.o
> > diff --git a/drivers/cxl/bus.c b/drivers/cxl/bus.c
> > new file mode 100644
> > index 000000000000..8594366955f7
> > --- /dev/null
> > +++ b/drivers/cxl/bus.c
> > @@ -0,0 +1,35 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +// Copyright(c) 2020 Intel Corporation. All rights reserved.
> > +#include <linux/device.h>
> > +#include <linux/module.h>
> > +
> > +static struct bus_type cxl_bus_type = {
> > +     .name = "cxl",
> > +};
> > +
> > +int cxl_register(struct device *dev)
> > +{
> > +     int rc;
> > +
> > +     dev->bus = &cxl_bus_type;
> > +     rc = device_add(dev);
> > +     if (rc)
> > +             put_device(dev);
> > +     return rc;
> > +}
> > +EXPORT_SYMBOL_GPL(cxl_register);
> > +
> > +static __init int cxl_bus_init(void)
> > +{
> > +     return bus_register(&cxl_bus_type);
> > +}
> > +
> > +static void cxl_bus_exit(void)
> > +{
> > +     bus_unregister(&cxl_bus_type);
> > +}
> > +
> > +module_init(cxl_bus_init);
> > +module_exit(cxl_bus_exit);
> > +MODULE_LICENSE("GPL v2");
> > +MODULE_AUTHOR("Intel Corporation");
> > diff --git a/drivers/cxl/bus.h b/drivers/cxl/bus.h
> > new file mode 100644
> > index 000000000000..fe2bea2bbc3c
> > --- /dev/null
> > +++ b/drivers/cxl/bus.h
> > @@ -0,0 +1,8 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +// Copyright(c) 2020 Intel Corporation. All rights reserved.
> > +#ifndef __CXL_BUS_H__
> > +#define __CXL_BUS_H__
> > +
> > +int cxl_register(struct device *dev);
> > +
> > +#endif /* __CXL_BUS_H__ */
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index f49ab80f68bd..cef5fd9ea68b 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -3,6 +3,7 @@
> >
> >  #ifndef __CXL_H__
> >  #define __CXL_H__
> > +#include <linux/range.h>
> >
> >  /* Device */
> >  #define CXLDEV_CAP_ARRAY_REG 0x0
> > @@ -52,12 +53,24 @@
> >  #define CXLMDEV_RESET_NEEDED_HOT 3
> >  #define CXLMDEV_RESET_NEEDED_CXL 4
> >
> > +struct cxl_memdev;
> >  struct cxl_mem {
> >       struct pci_dev *pdev;
> >       void __iomem *regs;
> > +     struct cxl_memdev *cxlmd;
> >
> >       spinlock_t mbox_lock; /* Protects device mailbox and firmware */
> >
> > +     struct {
> > +             struct range range;
> > +     } pmem;
> > +
> > +     struct {
> > +             struct range range;
> > +     } ram;
> > +
> > +     char firmware_version[0x10];
> > +
> >       /* Cap 0000h */
> >       struct {
> >               void __iomem *regs;
> > @@ -130,4 +143,24 @@ static inline void cxl_mbox_payload_drain(struct cxl_mem *cxlm,
> >  {
> >       memcpy_fromio(output, cxlm->mbox.regs + CXLDEV_MB_PAYLOAD, length);
> >  }
> > +
> > +#define CXL_MBOX_IDENTIFY 0x4000
> > +
> > +struct cxl_mbox_identify {
> > +     char fw_revision[0x10];
> > +     __le64 total_capacity;
> > +     __le64 volatile_capacity;
> > +     __le64 persistent_capacity;
> > +     __le64 partition_align;
> > +     __le16 info_event_log_size;
> > +     __le16 warning_event_log_size;
> > +     __le16 failure_event_log_size;
> > +     __le16 fatal_event_log_size;
> > +     __le32 lsa_size;
> > +     u8 poison_list_max_mer[3];
> > +     __le16 inject_poison_limit;
> > +     u8 poison_caps;
> > +     u8 qos_telemetry_caps;
> > +} __packed;
> > +
> >  #endif /* __CXL_H__ */
> > diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> > index 08913360d500..54743d196feb 100644
> > --- a/drivers/cxl/mem.c
> > +++ b/drivers/cxl/mem.c
> > @@ -2,11 +2,15 @@
> >  // Copyright(c) 2020 Intel Corporation. All rights reserved.
> >  #include <linux/sched/clock.h>
> >  #include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/cdev.h>
> > +#include <linux/idr.h>
> >  #include <linux/pci.h>
> >  #include <linux/io.h>
> >  #include "acpi.h"
> >  #include "pci.h"
> >  #include "cxl.h"
> > +#include "bus.h"
> >
> >  struct mbox_cmd {
> >       u16 cmd;
> > @@ -15,6 +19,53 @@ struct mbox_cmd {
> >       u16 return_code;
> >  };
> >
> > +/*
> > + * An entire PCI topology full of devices should be enough for any
> > + * config
> > + */
> > +#define CXL_MEM_MAX_DEVS 65536
> > +
> > +struct cxl_memdev {
> > +     struct device dev;
> > +     struct cxl_mem *cxlm;
> > +     int id;
> > +};
> > +
> > +static int cxl_mem_major;
> > +static struct cdev cxl_mem_cdev;
> > +static DEFINE_IDR(cxl_mem_idr);
> > +static DEFINE_MUTEX(cxl_memdev_lock);
>
> Define scope of this lock with a comment.

Will do.

>
> > +
> > +static int cxl_mem_open(struct inode *inode, struct file *file)
> > +{
> > +     long minor = iminor(inode);
> > +     struct cxl_memdev *cxlmd;
> > +
> > +     rcu_read_lock();
> > +     cxlmd = idr_find(&cxl_mem_idr, minor);
> > +     rcu_read_unlock();
> > +
> > +     if (!cxlmd)
> > +             return -ENXIO;
> > +
> > +     file->private_data = cxlmd;
> > +
> > +     return 0;
> > +}
> > +
> > +static long cxl_mem_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> > +{
> > +     return -ENOTTY;
> > +}
> > +
> > +static const struct file_operations cxl_mem_fops = {
> > +     .owner = THIS_MODULE,
> > +     .open = cxl_mem_open,
> > +     .unlocked_ioctl = cxl_mem_ioctl,
> > +     .compat_ioctl = compat_ptr_ioctl,
> > +     .llseek = noop_llseek,
> > +};
> > +
> >  static int cxldev_wait_for_doorbell(struct cxl_mem *cxlm)
> >  {
> >       u64 start, now;
> > @@ -53,7 +104,7 @@ static int cxldev_wait_for_doorbell(struct cxl_mem *cxlm)
> >   * Returns 0 if the doorbell transaction was successful from a protocol level.
> >   * Caller should check the return code in @mbox_cmd to make sure it succeeded.
> >   */
> > -static int __maybe_unused cxl_mem_mbox_send_cmd(struct cxl_mem *cxlm, struct mbox_cmd *mbox_cmd)
> > +static int cxl_mem_mbox_send_cmd(struct cxl_mem *cxlm, struct mbox_cmd *mbox_cmd)
> >  {
> >       u64 cmd, status;
> >       int rc;
> > @@ -277,10 +328,185 @@ static int cxl_mem_dvsec(struct pci_dev *pdev, int dvsec)
> >       return 0;
> >  }
> >
> > +static struct cxl_memdev *to_cxl_memdev(struct device *dev)
> > +{
> > +     return container_of(dev, struct cxl_memdev, dev);
> > +}
> > +
> > +static void cxl_memdev_release(struct device *dev)
> > +{
> > +     struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> > +
> > +     mutex_lock(&cxl_memdev_lock);
> > +     idr_remove(&cxl_mem_idr, cxlmd->id);
> > +     mutex_unlock(&cxl_memdev_lock);
> > +
> > +     kfree(cxlmd);
> > +}
> > +
> > +static char *cxl_memdev_devnode(struct device *dev, umode_t *mode, kuid_t *uid, kgid_t *gid)
> > +{
> > +     return kasprintf(GFP_KERNEL, "cxl/%s", dev_name(dev));
> > +}
> > +
> > +static ssize_t firmware_version_show(struct device *dev, struct device_attribute *attr, char *buf)
> > +{
> > +     struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> > +     struct cxl_mem *cxlm = cxlmd->cxlm;
> > +
> > +     return sprintf(buf, "%.16s\n", cxlm->firmware_version);
> > +}
> > +static DEVICE_ATTR_RO(firmware_version);
> > +
> > +static ssize_t ram_size_show(struct device *dev, struct device_attribute *attr, char *buf)
> > +{
> > +     struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> > +     struct cxl_mem *cxlm = cxlmd->cxlm;
> > +
> > +     return sprintf(buf, "%#llx\n", (unsigned long long) range_len(&cxlm->ram.range));
> > +}
> > +static struct device_attribute dev_attr_ram_size = __ATTR(size, 0444, ram_size_show, NULL);
> > +
> > +static ssize_t pmem_size_show(struct device *dev, struct device_attribute *attr, char *buf)
> > +{
> > +     struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> > +     struct cxl_mem *cxlm = cxlmd->cxlm;
> > +
> > +     return sprintf(buf, "%#llx\n", (unsigned long long) range_len(&cxlm->pmem.range));
> > +}
> > +static struct device_attribute dev_attr_pmem_size = __ATTR(size, 0444, pmem_size_show, NULL);
> > +
> > +static struct attribute *cxl_memdev_attributes[] = {
> > +     &dev_attr_firmware_version.attr,
> > +     NULL,
> > +};
> > +
> > +static struct attribute *cxl_memdev_pmem_attributes[] = {
> > +     &dev_attr_pmem_size.attr,
>
> It's simple, but should still have docs in Documentation/ABI/testing/sysfs...

Agree.

>
> > +     NULL,
> > +};
> > +
> > +static struct attribute *cxl_memdev_ram_attributes[] = {
> > +     &dev_attr_ram_size.attr,
> > +     NULL,
> > +};
> > +
> > +static struct attribute_group cxl_memdev_attribute_group = {
> > +     .attrs = cxl_memdev_attributes,
> > +};
> > +
> > +static struct attribute_group cxl_memdev_ram_attribute_group = {
> > +     .name = "ram",
> > +     .attrs = cxl_memdev_ram_attributes,
> > +};
> > +
> > +static struct attribute_group cxl_memdev_pmem_attribute_group = {
> > +     .name = "pmem",
> > +     .attrs = cxl_memdev_pmem_attributes,
> > +};
> > +
> > +static const struct attribute_group *cxl_memdev_attribute_groups[] = {
> > +     &cxl_memdev_attribute_group,
> > +     &cxl_memdev_ram_attribute_group,
> > +     &cxl_memdev_pmem_attribute_group,
> > +     NULL,
> > +};
> > +
> > +static const struct device_type cxl_memdev_type = {
> > +     .name = "cxl_memdev",
> > +     .release = cxl_memdev_release,
> > +     .devnode = cxl_memdev_devnode,
> > +     .groups = cxl_memdev_attribute_groups,
> > +};
> > +
> > +static struct cxl_memdev *cxl_mem_add_memdev(struct cxl_mem *cxlm)
> > +{
> > +     struct pci_dev *pdev = cxlm->pdev;
> > +     struct cxl_memdev *cxlmd;
> > +     struct device *dev;
> > +     int id, rc;
> > +
> > +     cxlmd = kzalloc(sizeof(*cxlmd), GFP_KERNEL);
>
> Maybe I missed it, but I'm not seeing this freed anywhere.

See: cxl_memdev_release()

>
> > +     if (!cxlmd)
> > +             return ERR_PTR(-ENOMEM);
> > +
> > +     cxlmd->cxlm = cxlm;
> > +     cxlm->cxlmd = cxlmd;
> > +
> > +     mutex_lock(&cxl_memdev_lock);
> > +     id = idr_alloc(&cxl_mem_idr, cxlmd, 0, CXL_MEM_MAX_DEVS, GFP_KERNEL);
> > +     mutex_unlock(&cxl_memdev_lock);
> > +     if (id < 0) {
> > +             rc = id;
> > +             goto err_idr;
> > +     }
> > +
> > +     cxlmd->id = id;
> > +
> > +     dev = &cxlmd->dev;
> > +
> > +     device_initialize(dev);
> > +     dev->parent = &pdev->dev;
> > +     dev->devt = MKDEV(cxl_mem_major, id);
> > +     dev->type = &cxl_memdev_type;
> > +     dev_set_name(dev, "mem%d", id);
>
> blank line here

ok

>
> > +     rc = cxl_register(dev);
> > +     if (rc)
> > +             return ERR_PTR(rc);
> > +
> > +     return cxlmd;
> > +
> > +err_idr:
> > +     kfree(cxlmd);
> > +
> > +     return ERR_PTR(rc);
> > +}
> > +
>
> ...
>
> >  static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >  {
> >       struct cxl_mem *cxlm = ERR_PTR(-ENXIO);
> >       struct device *dev = &pdev->dev;
> > +     struct cxl_memdev *cxlmd;
> >       int rc, regloc, i;
> >
> >       rc = cxl_bus_prepared(pdev);
> > @@ -319,20 +545,31 @@ static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >       if (rc)
> >               return rc;
> >
> > -     /* Check that hardware "looks" okay. */
> > -     rc = cxl_mem_mbox_get(cxlm);
> > +     rc = cxl_mem_identify(cxlm);
> >       if (rc)
> >               return rc;
> > -
> > -     cxl_mem_mbox_put(cxlm);
>
> It was kind of nice to see the flow earlier, but I'm also thinking it made
> a slightly harder to read patch.  Hmm.  Maybe just drop the version earlier
> in favour of a todo comment that you then do here?

Not sure I follow, but I think you're saying don't bother with an
initial patch introducing just doing the raw cxl_mem_mbox_get() in
this path, jump straight to cxl_mem_identify()?

>
> >       dev_dbg(&pdev->dev, "CXL Memory Device Interface Up\n");
> > +
>
> Nice to tidy that up by moving to earlier patch.

Sure.

>
> >       pci_set_drvdata(pdev, cxlm);
> >
> > +     cxlmd = cxl_mem_add_memdev(cxlm);
> > +     if (IS_ERR(cxlmd))
> > +             return PTR_ERR(cxlmd);
>
> Given we don't actually use cxlmd perhaps a simple return value
> of 0 or error would be better from cxl_mem_add_memdev()
>
> (I guess you may have follow up patches that do something with it
>  here, though it feels wrong to ever do so given it is now registered
>  and hence exposed to the system).

It's not added if IS_ERR() is true, but it would be simpler to just
have cxl_mem_add_memdev() return an int since ->probe() doesn't use
it.

>
> > +
> >       return 0;
> >  }
> >
> >  static void cxl_mem_remove(struct pci_dev *pdev)
> >  {
> > +     struct cxl_mem *cxlm = pci_get_drvdata(pdev);
> > +     struct cxl_memdev *cxlmd = cxlm->cxlmd;
> > +
> > +     device_lock(&cxlmd->dev);
> > +     cxlm->cxlmd = NULL;
> > +     cxlmd->cxlm = NULL;
> > +     device_unlock(&cxlmd->dev);
> > +
> > +     device_unregister(&cxlmd->dev);
>
> Why device_unregister last? Normally removing exposure to the
> system is the first thing you do in a remove() call.
> Particularly as you'll get NULL ptr dereferences if anyone
> manages a sysfs read between the pointers being set to NULL above
> and the device_unregister() taking away the sysfs files.

Yes, the unregister should be before the invalidation in this case. In
fact I'll likely drop the invalidation or do some other
synchronization requirement for any races between the ioctl path and
the remove path.

>
>
>
> >  }
> >
> >  static const struct pci_device_id cxl_mem_pci_tbl[] = {
> > @@ -350,7 +587,45 @@ static struct pci_driver cxl_mem_driver = {
> >       .remove                 = cxl_mem_remove,
> >  };
> >
> > +static __init int cxl_mem_init(void)
> > +{
> > +     int rc;
> > +     dev_t devt;
> > +
> > +     rc = alloc_chrdev_region(&devt, 0, CXL_MEM_MAX_DEVS, "cxl");
> > +     if (rc)
> > +             return rc;
> > +
> > +     cxl_mem_major = MAJOR(devt);
> > +
> > +     cdev_init(&cxl_mem_cdev, &cxl_mem_fops);
> > +     rc = cdev_add(&cxl_mem_cdev, MKDEV(cxl_mem_major, 0), CXL_MEM_MAX_DEVS);
> > +     if (rc)
> > +             goto err_cdev;
> > +
> > +     rc = pci_register_driver(&cxl_mem_driver);
> > +     if (rc)
> > +             goto err_driver;
> > +
> > +     return 0;
> > +
> > +err_driver:
> > +     cdev_del(&cxl_mem_cdev);
> > +err_cdev:
> > +     unregister_chrdev_region(MKDEV(cxl_mem_major, 0), CXL_MEM_MAX_DEVS);
> > +
> > +     return rc;
> > +}
> > +
> > +static __exit void cxl_mem_exit(void)
> > +{
> > +     pci_unregister_driver(&cxl_mem_driver);
> > +     unregister_chrdev_region(MKDEV(cxl_mem_major, 0), CXL_MEM_MAX_DEVS);
> > +     cdev_del(&cxl_mem_cdev);
>
> Ordering?  cdev_dev should be before unregister_chrdev_region to match
> error handling in init()

Yes.

Thanks for taking a look!
