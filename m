Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8733A369F
	for <lists+linux-pci@lfdr.de>; Thu, 10 Jun 2021 23:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbhFJVtX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Jun 2021 17:49:23 -0400
Received: from mail-pg1-f173.google.com ([209.85.215.173]:44758 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbhFJVtQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Jun 2021 17:49:16 -0400
Received: by mail-pg1-f173.google.com with SMTP id y11so794756pgp.11
        for <linux-pci@vger.kernel.org>; Thu, 10 Jun 2021 14:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AJs/cT5NX+2FDUFvId1l7Kc3TXMWDpEYoHdOsouzksQ=;
        b=qt+ead1dpPehI1T5qsG5/K7kRcoEFivS2+uaUcY7vuViQv0RH0NSckTMApvmkmpfy3
         MSeU6L3/lZGxtV1+wM0rjM/sFZTWD1qLTfqMbfFY6+gb7qluXN457ArpGBeguwrxotXZ
         dX+oCsG2JGUDcP/PsR+aqWJOltAOyTXiledbk1bgmbpoCtE7+9dlysUQxkgwRFo0Lk4V
         4SyyYTscPpk2ag+eNx5ymuzMweehOIjJECU1PcrI/02sihH6MbYBGyv3r+UfE4bF+5C/
         OJsL+JvJUPcpheguSU2G6zrfisM9nbiQw4AkOWUiHtZXrNWfQoIk/cLO7oY3cDEiAlry
         HxNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AJs/cT5NX+2FDUFvId1l7Kc3TXMWDpEYoHdOsouzksQ=;
        b=mKyXWPJfADgJTTpUMmBT6ZVfZhDxsQayWkDVJvf3V9nvM5gYJD3NiTRcPZwnpOXDg+
         akgPsLs3GH6UECBpqQowkc6VFIN2HPwh7UQBlorDeMp5wMzZ67WxOMDse7mr6Gt98Cvz
         D1ZNBFmaukhCIFeLdSnGsgYS6O1fHaPDJJ0QOglaPxTe8apsR1m/ho0bg9lol8wiJnkF
         oPFrxIC59YCLP8SzCcMYMX54/jsvD4djNZbvgR80HYs7qxh20wYwvhN8wI66eAKDVmsF
         WNM1uwhqjtJn1Me0212ZveEOQX7Co7/9mcWHZkvKspJrbdEdhoaYnMX5OK0Z2wGSPkxp
         ZaKw==
X-Gm-Message-State: AOAM530gMx8tEAPmrhdWFbvezJajIYwiKoFogB282YXBzp87+SRl6xSt
        teWT+9Nzz56NrEsl2iXiej7IyGwlcEsh+yMaxn7EUQ==
X-Google-Smtp-Source: ABdhPJw6aCpnw3vy6bs/B6otg+eaAICy3pMz41TJiuZ6mEVa2AJYQ/PUh8nokA/EkyCO6DsJwhdpodCz680Gqaf0UQ4=
X-Received: by 2002:a63:5c4a:: with SMTP id n10mr424342pgm.279.1623361579694;
 Thu, 10 Jun 2021 14:46:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210524133938.2815206-1-Jonathan.Cameron@huawei.com> <20210524133938.2815206-4-Jonathan.Cameron@huawei.com>
In-Reply-To: <20210524133938.2815206-4-Jonathan.Cameron@huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 10 Jun 2021 14:46:08 -0700
Message-ID: <CAPcyv4hJ3e0jwTbfvg_bWvLdvk=4VO+b3JsQRj=CMezrfoEDbA@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] cxl/mem: Add CDAT table reading from DOE
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Linux PCI <linux-pci@vger.kernel.org>, linux-cxl@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Chris Browy <cbrowy@avery-design.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Fangjian <f.fangjian@huawei.com>, Linuxarm <linuxarm@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 24, 2021 at 6:42 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> This patch provides a sysfs binary attribute to allow dumping of the whole
> table.
>
> Binary dumping is modeled on /sys/firmware/ACPI/tables/
>
> The ability to dump this table will be very useful for emulation of real
> devices once they become available as QEMU CXL type 3 device emulation will
> be able to load this file in.
>
> This does not support table updates at runtime. It will always provide
> whatever was there when first cached. Handling of table updates can be
> implemented later.
>
> Once we have more users, this code can move out to driver/cxl/cdat.c or
> similar.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/cxl/Kconfig |   1 +
>  drivers/cxl/cxl.h   |  21 ++++++
>  drivers/cxl/mem.c   | 174 ++++++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/mem.h   |   6 ++
>  4 files changed, 202 insertions(+)
>
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index 97dc4d751651..26cad9fa29f7 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -15,6 +15,7 @@ if CXL_BUS
>
>  config CXL_MEM
>         tristate "CXL.mem: Memory Devices"
> +       select PCI_DOE
>         help
>           The CXL.mem protocol allows a device to act as a provider of
>           "System RAM" and/or "Persistent Memory" that is fully coherent
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index d49e0cb679fa..e649a286aace 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -7,6 +7,7 @@
>  #include <linux/bitfield.h>
>  #include <linux/bitops.h>
>  #include <linux/io.h>
> +#include <linux/pci-doe.h>
>
>  /* CXL 2.0 8.2.8.1 Device Capabilities Array Register */
>  #define CXLDEV_CAP_ARRAY_OFFSET 0x0
> @@ -69,5 +70,25 @@ struct cxl_regs {
>  void cxl_setup_device_regs(struct device *dev, void __iomem *base,
>                            struct cxl_device_regs *regs);
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

Looks like this got picked up from a rebase... they're now decoder
flags, but no need to include them in the CDAT patch.

> +
> +#define CXL_DOE_PROTOCOL_COMPLIANCE 0
> +#define CXL_DOE_PROTOCOL_TABLE_ACCESS 2
> +
> +/* Common to request and response */
> +#define CXL_DOE_TABLE_ACCESS_3_CODE GENMASK(7, 0)
> +#define   CXL_DOE_TABLE_ACCESS_3_CODE_READ 0
> +#define CXL_DOE_TABLE_ACCESS_3_TYPE GENMASK(15, 8)
> +#define   CXL_DOE_TABLE_ACCESS_3_TYPE_CDAT 0
> +#define CXL_DOE_TABLE_ACCESS_3_ENTRY_HANDLE GENMASK(31, 16)
> +
>  extern struct bus_type cxl_bus_type;
>  #endif /* __CXL_H__ */
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index c5fdf2c57181..4224d1de311e 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -14,6 +14,7 @@
>  #include "pci.h"
>  #include "cxl.h"
>  #include "mem.h"
> +#include "cdat.h"
>
>  /**
>   * DOC: cxl mem
> @@ -926,6 +927,85 @@ static int cxl_mem_setup_mailbox(struct cxl_mem *cxlm)
>         return 0;
>  }
>
> +#define CDAT_DOE_REQ(entry_handle)                                     \
> +       (FIELD_PREP(CXL_DOE_TABLE_ACCESS_REQ_CODE,                      \
> +                   CXL_DOE_TABLE_ACCESS_REQ_CODE_READ) |               \
> +        FIELD_PREP(CXL_DOE_TABLE_ACCESS_TABLE_TYPE,                    \
> +                   CXL_DOE_TABLE_ACCESS_TABLE_TYPE_CDATA) |            \
> +        FIELD_PREP(CXL_DOE_TABLE_ACCESS_ENTRY_HANDLE, (entry_handle)))
> +
> +static ssize_t cdat_get_length(struct pci_doe *doe)
> +{
> +       u32 cdat_request_pl = CDAT_DOE_REQ(0);
> +       u32 cdat_response_pl[32];
> +       struct pci_doe_exchange ex = {
> +               .vid = PCI_DVSEC_VENDOR_ID_CXL,
> +               .protocol = CXL_DOE_PROTOCOL_TABLE_ACCESS,
> +               .request_pl = &cdat_request_pl,
> +               .request_pl_sz = sizeof(cdat_request_pl),
> +               .response_pl = cdat_response_pl,
> +               .response_pl_sz = sizeof(cdat_response_pl),
> +       };
> +
> +       ssize_t rc;
> +
> +       rc = pci_doe_exchange_sync(doe, &ex);
> +       if (rc < 0)
> +               return rc;
> +       if (rc < 1)
> +               return -EIO;
> +
> +       return cdat_response_pl[1];
> +}
> +
> +static int cdat_to_buffer(struct pci_doe *doe, u32 *buffer, size_t length)
> +{
> +       int entry_handle = 0;
> +       int rc;
> +
> +       do {
> +               u32 cdat_request_pl = CDAT_DOE_REQ(entry_handle);
> +               u32 cdat_response_pl[32];
> +               struct pci_doe_exchange ex = {
> +                       .vid = PCI_DVSEC_VENDOR_ID_CXL,
> +                       .protocol = CXL_DOE_PROTOCOL_TABLE_ACCESS,
> +                       .request_pl = &cdat_request_pl,
> +                       .request_pl_sz = sizeof(cdat_request_pl),
> +                       .response_pl = cdat_response_pl,
> +                       .response_pl_sz = sizeof(cdat_response_pl),
> +               };
> +               size_t entry_dw;
> +               u32 *entry;
> +
> +               rc = pci_doe_exchange_sync(doe, &ex);
> +               if (rc < 0)
> +                       return rc;
> +
> +               entry = cdat_response_pl + 1;

I think:

entry = &cdat_response_pl[1];

...is less ambiguous, otherwise you need to backtrack and remember
that cdat_response_pl is an array not a struct. Perhaps a comment or a
symbol name for "1" would help here too?


> +               entry_dw = rc / sizeof(u32);
> +               /* Skip Header */
> +               entry_dw -= 1;
> +               entry_dw = min(length / 4, entry_dw);

sometimes sizeof(u32) sometimes "4"?

> +               memcpy(buffer, entry, entry_dw * sizeof(u32));
> +               length -= entry_dw * sizeof(u32);

Why not keep entry_dw in bytes, it seems this conversion to a word
count is causing more trouble than it is worth above.

> +               buffer += entry_dw;
> +               entry_handle = FIELD_GET(CXL_DOE_TABLE_ACCESS_ENTRY_HANDLE, cdat_response_pl[0]);
> +
> +       } while (entry_handle != 0xFFFF);

Shouldn't this also break out if length goes to zero?

> +
> +       return 0;
> +}
> +
> +static void cxl_mem_free_irq_vectors(void *data)
> +{
> +       pci_free_irq_vectors(data);
> +}
> +
> +static void cxl_mem_doe_unregister_all(void *data)
> +{
> +       pci_doe_unregister_all(data);
> +}
> +
>  static struct cxl_mem *cxl_mem_create(struct pci_dev *pdev, u32 reg_lo,
>                                       u32 reg_hi)
>  {
> @@ -933,6 +1013,7 @@ static struct cxl_mem *cxl_mem_create(struct pci_dev *pdev, u32 reg_lo,
>         struct cxl_mem *cxlm;
>         void __iomem *regs;
>         u64 offset;
> +       int irqs;
>         u8 bar;
>         int rc;
>
> @@ -971,6 +1052,44 @@ static struct cxl_mem *cxl_mem_create(struct pci_dev *pdev, u32 reg_lo,
>                 return NULL;
>         }
>
> +       /*
> +        * An implementation of a cxl type3 device may support an unknown
> +        * number of interrupts. Assume that number is not that large and
> +        * request them all.
> +        */
> +       irqs = pci_msix_vec_count(pdev);
> +       rc = pci_alloc_irq_vectors(pdev, irqs, irqs, PCI_IRQ_MSIX);
> +       if (rc != irqs) {
> +               /* No interrupt available - carry on */
> +               dev_dbg(dev, "No interrupts available for DOE\n");
> +       } else {
> +               /*
> +                * Enabling bus mastering could be done within the DOE
> +                * initialization, but as it potentially has other impacts
> +                * keep it within the driver.
> +                */
> +               pci_set_master(pdev);
> +               rc = devm_add_action_or_reset(dev, cxl_mem_free_irq_vectors,
> +                                              pdev);
> +               if (rc)
> +                       return NULL;
> +       }
> +
> +       /*
> +        * Find a DOE mailbox that supports CDAT.
> +        * Supporting other DOE protocols will require more complexity.
> +        */
> +       rc = pci_doe_register_all(pdev);
> +       if (rc < 0)
> +               return NULL;
> +
> +       rc = devm_add_action_or_reset(dev, cxl_mem_doe_unregister_all, pdev);
> +       if (rc)
> +               return NULL;
> +
> +       cxlm->table_doe = pci_doe_find(pdev, PCI_DVSEC_VENDOR_ID_CXL,
> +                                      CXL_DOE_PROTOCOL_TABLE_ACCESS);
> +

cxl_mem_create() is about allocating / initializing the @cxlm object.
I think the above belongs in its own hardware init function. Well the
interrupt init belongs in its own init function before
cxl_mem_create() and the DOE / CDAT registration can come sometime
later after cxl_mem_identify() succeeds. I.e. it's not until the
driver has successfully setup mailbox communications should it worry
about talking to the DOE.

>         dev_dbg(dev, "Mapped CXL Memory Device resource\n");
>         return cxlm;
>  }
> @@ -1060,6 +1179,31 @@ static ssize_t pmem_size_show(struct device *dev, struct device_attribute *attr,
>         return sysfs_emit(buf, "%#llx\n", len);
>  }
>
> +static ssize_t CDAT_read(struct file *filp, struct kobject *kobj,
> +                        struct bin_attribute *bin_attr, char *buf,
> +                        loff_t offset, size_t count)
> +{
> +       struct device *dev = kobj_to_dev(kobj);
> +       struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +
> +       return memory_read_from_buffer(buf, count, &offset, cxlmd->cdat_table,
> +                                      cxlmd->cdat_length);
> +}
> +
> +static BIN_ATTR_RO(CDAT, 0);
> +
> +static umode_t cxl_memdev_bin_attr_is_visible(struct kobject *kobj,
> +                                             struct bin_attribute *attr, int i)
> +{
> +       struct device *dev = kobj_to_dev(kobj);
> +       struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +
> +       if ((attr == &bin_attr_CDAT) && cxlmd->cdat_table)
> +               return 0400;
> +
> +       return 0;
> +}
> +
>  static struct device_attribute dev_attr_pmem_size =
>         __ATTR(size, 0444, pmem_size_show, NULL);
>
> @@ -1069,6 +1213,11 @@ static struct attribute *cxl_memdev_attributes[] = {
>         NULL,
>  };
>
> +static struct bin_attribute *cxl_memdev_bin_attributes[] = {
> +       &bin_attr_CDAT,
> +       NULL,
> +};
> +
>  static struct attribute *cxl_memdev_pmem_attributes[] = {
>         &dev_attr_pmem_size.attr,
>         NULL,
> @@ -1081,6 +1230,8 @@ static struct attribute *cxl_memdev_ram_attributes[] = {
>
>  static struct attribute_group cxl_memdev_attribute_group = {
>         .attrs = cxl_memdev_attributes,
> +       .bin_attrs = cxl_memdev_bin_attributes,
> +       .is_bin_visible = cxl_memdev_bin_attr_is_visible,
>  };
>
>  static struct attribute_group cxl_memdev_ram_attribute_group = {
> @@ -1158,6 +1309,25 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cxl_mem *cxlm)
>         return ERR_PTR(rc);
>  }
>
> +static int cxl_cache_cdat_table(struct cxl_memdev *cxlmd)
> +{
> +       struct cxl_mem *cxlm = cxlmd->cxlm;
> +       struct device *dev = &cxlmd->dev;
> +       ssize_t cdat_length;
> +
> +       if (cxlm->table_doe == NULL)
> +               return 0;
> +
> +       cdat_length = cdat_get_length(cxlm->table_doe);
> +       if (cdat_length < 0)
> +               return cdat_length;
> +
> +       cxlmd->cdat_length = cdat_length;
> +       cxlmd->cdat_table = devm_kzalloc(dev->parent, cdat_length, GFP_KERNEL);

I'm not sure how big these CDATs can get, but I don't think there is
any requirement for the memory to be contiguous, so perhaps this
should be kvzalloc() to be kind to the page allocator.

> +
> +       return cdat_to_buffer(cxlm->table_doe, cxlmd->cdat_table, cxlmd->cdat_length);
> +}
> +
>  static int cxl_mem_add_memdev(struct cxl_mem *cxlm)
>  {
>         struct cxl_memdev *cxlmd;
> @@ -1180,6 +1350,10 @@ static int cxl_mem_add_memdev(struct cxl_mem *cxlm)
>          */
>         cxlmd->cxlm = cxlm;
>
> +       rc = cxl_cache_cdat_table(cxlmd);
> +       if (rc)
> +               goto err;
> +
>         cdev = &cxlmd->cdev;
>         rc = cdev_device_add(cdev, dev);
>         if (rc)
> diff --git a/drivers/cxl/mem.h b/drivers/cxl/mem.h
> index 0a3f70316872..fb26155a8fb3 100644
> --- a/drivers/cxl/mem.h
> +++ b/drivers/cxl/mem.h
> @@ -38,12 +38,16 @@
>   * @cdev: char dev core object for ioctl operations
>   * @cxlm: pointer to the parent device driver data
>   * @id: id number of this memdev instance.
> + * @cdat_table: cache of CDAT table
> + * @cdat_length: length of cached CDAT table
>   */
>  struct cxl_memdev {
>         struct device dev;
>         struct cdev cdev;
>         struct cxl_mem *cxlm;
>         int id;
> +       void *cdat_table;
> +       size_t cdat_length;
>  };
>
>  /**
> @@ -51,6 +55,7 @@ struct cxl_memdev {
>   * @pdev: The PCI device associated with this CXL device.
>   * @base: IO mappings to the device's MMIO
>   * @cxlmd: Logical memory device chardev / interface
> + * @table_doe: Data exchange object mailbox used to read tables
>   * @regs: Parsed register blocks
>   * @payload_size: Size of space for payload
>   *                (CXL 2.0 8.2.8.4.3 Mailbox Capabilities Register)
> @@ -65,6 +70,7 @@ struct cxl_mem {
>         void __iomem *base;
>         struct cxl_memdev *cxlmd;
>
> +       struct pci_doe *table_doe;
>         struct cxl_regs regs;
>
>         size_t payload_size;
