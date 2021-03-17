Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC53B33E67A
	for <lists+linux-pci@lfdr.de>; Wed, 17 Mar 2021 02:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbhCQB4L (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Mar 2021 21:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhCQBz6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Mar 2021 21:55:58 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E9FC06175F
        for <linux-pci@vger.kernel.org>; Tue, 16 Mar 2021 18:55:57 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id x21so366468eds.4
        for <linux-pci@vger.kernel.org>; Tue, 16 Mar 2021 18:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5JA7JjsS1pLItx+M40F03cWCF+SOlb+Ygr9DpXI7TGg=;
        b=UL7VUFkG6g6dGNrnYxUu5HpkZqFzsUfEGuaw2xDB+M9UJ8TNJCJ07gjIF75ImcwPzn
         wk3TgqAEQZ2wUgls1afmo1QichXRv1M4DfahuuO9xe7qAiRZL+C+xsQNgdHkJUTKtWBi
         277fzpRAOvnUIMPhISL3tpbT5sTqSM1kiiBDJF8zXINUXiQWr0an0NBE6njIz33cK/7W
         jlc2HHh6bJGvG3QdNp+MEPmIjLL49meS6l6L8LUDt8FMX17JD18f/wvV2O9tT/CFBl9e
         KHmlzjlCMWGeUhYy36IWDFWTK/Eh3YzRdCCzloK7po7bshb855Ri9tjodC09ZrDwFpy8
         0mEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5JA7JjsS1pLItx+M40F03cWCF+SOlb+Ygr9DpXI7TGg=;
        b=pw3p2ZPwy+Pcz9ZKMI7xpwqfSdxlHljXBbSTj+NjJjmYZGgDkVFU/y3gNU8Iwn9FzV
         7LC+lko6RyEgdzzOUZ2wqbB1Aw4z3OvTIJHAEI9WCfP59ZKV3iwsKPBS7I5XPeMoxAJS
         QoqiUYAHJvUPu8etU6j3UGaf1Zv853jkccJlYLhZfs4AyjnQu9+rne5ctQjPJnFcccF1
         9+yy1/Pyl+ZTSgUsFO8ai/IsCbequFLh+9YVe8gY/HQndjGh6t2rVlEpxYdN2mFO4aT2
         J23QtmIZRDzoBZyj3ONCHtc2Mv6La3EO6fupQ1XeMHXndsUdMDhCVqOQflZfq/XKsfVF
         CWyw==
X-Gm-Message-State: AOAM532/G6WZsOF5pMxlQjzvK9JcHXPeBOQpkLnkukGPZB27AwN+oLJ7
        YgVcbdgM3f8UhzUVM3KIoIl5Qm4+pefXljciCvI9AA==
X-Google-Smtp-Source: ABdhPJynDuRtSN4fNF1hH9yrhj86H8T+jexZ+hRk5gq5670+9Bw2Ux0iYK/c1+6naHhfjkmFGLyyEThE4hUfrks3QqY=
X-Received: by 2002:a05:6402:4301:: with SMTP id m1mr40593749edc.210.1615946155997;
 Tue, 16 Mar 2021 18:55:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210310180306.1588376-1-Jonathan.Cameron@huawei.com> <20210310180306.1588376-3-Jonathan.Cameron@huawei.com>
In-Reply-To: <20210310180306.1588376-3-Jonathan.Cameron@huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 16 Mar 2021 18:55:48 -0700
Message-ID: <CAPcyv4hZd3K_rE18J+38vje-JTJU3GKV+K879dUtmDgLbJKW5g@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] cxl/mem: Add CDAT table reading from DOE
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Linuxarm <linuxarm@huawei.com>, Fangjian <f.fangjian@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 10, 2021 at 10:08 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> This patch simply provides some debug print outs of the entries
> at probe time + a sysfs binary attribute to allow dumping of the
> whole table.
>
> Binary dumping is modelled on /sys/firmware/ACPI/tables/
>
> The ability to dump this table will be very useful for emulation of
> real devices once they become available as QEMU CXL type 3 device
> emulation will be able to load this file in.
>

Certainly useful for kernel / QEMU development + debug, not
necessarily as a userspace ABI.

> Open questions:
> * No support here for table updates. Worth including these from the
>   start, or leave that complexity for later?

Depends what the kernel will do with this information. If it's just to
assign a numa node then the interface could be to override / augment
the numa node assignment, not necessarily override the entire table
data.

> * Worth logging the reported info for debug, or is the binary attribute
>   sufficient?  Larger open question of whether to expose this info to
>   userspace or not left for another day!

Of all the options I like logging the least... root-only sysfs at
least doesn't enable a functional user ABI out of the gate.

> * Where to put the CDAT file?  Is it worth a subdirectory?

I think where you have it is fine, hanging directly off the memdev. It
isn't a PCIE property, it's CXL data and the memdev is the CXL
sub-functionality of the PCIE device.

However, It helps udev scripts if userspace can't race device
visibility with attribute visibility. I.e. if it is added to the
static cxl_memdev_attribute_groups rather than a dynamic attribute
creation then there is no gap between when userspace sees the KOBJ_ADD
event and when it can access the attribute.

> * What is maximum size of the SSLBIS entry - I haven't quite managed
>   to figure that out and this is the record with largest size.
>   We could support dynamic allocation of the record size, but it
>   would add complexity that seems unnecessary.
>   It would not be compliant with the specification for a type 3 memory
>   device to report this record anyway so I'm not that worried about this
>   for now.  It will become relevant once we have support for reading
>   CDAT from CXL switches.
> * cdat.h is formatted in a similar style to pci_regs.h on basis that
>   it may well be helpful to share this header with userspace tools.
> * Move the generic parts of this out to driver/cxl/cdat.c or leave that
>   until we have other CXL drivers wishing to use this?
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/cxl/cdat.h |  79 ++++++++++++++
>  drivers/cxl/cxl.h  |  13 +++
>  drivers/cxl/mem.c  | 253 ++++++++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 344 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cxl/cdat.h b/drivers/cxl/cdat.h
> new file mode 100644
> index 000000000000..e67b18e02c35
> --- /dev/null
> +++ b/drivers/cxl/cdat.h
> @@ -0,0 +1,79 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Coherent Device Attribute table (CDAT)
> + *
> + * Specification available from UEFI.org
> + *
> + * Whilst CDAT is defined as a single table, the access via DOE maiboxes is
> + * done one entry at a time, where the first entry is the header.
> + */
> +
> +#define CXL_DOE_TABLE_ACCESS_REQ_CODE          0x000000ff
> +#define   CXL_DOE_TABLE_ACCESS_REQ_CODE_READ   0
> +#define CXL_DOE_TABLE_ACCESS_TABLE_TYPE                0x0000ff00
> +#define   CXL_DOE_TABLE_ACCESS_TABLE_TYPE_CDATA        0
> +#define CXL_DOE_TABLE_ACCESS_ENTRY_HANDLE      0xffff0000
> +
> +
> +/*
> + * CDAT entries are little endian and are read from PCI config space which
> + * is also little endian.
> + * As such, on a big endian system these will have been reversed.
> + * This prevents us from making easy use of packed structures.
> + * Style form pci_regs.h
> + */
> +
> +#define CDAT_HEADER_LENGTH_DW 3
> +#define CDAT_HEADER_DW0_LENGTH         0xFFFFFFFF
> +#define CDAT_HEADER_DW1_REVISION       0x000000FF
> +#define CDAT_HEADER_DW1_CHECKSUM       0x0000FF00
> +#define CDAT_HEADER_DW2_SEQUENCE       0xFFFFFFFF
> +
> +/* All structures have a common first DW */
> +#define CDAT_STRUCTURE_DW0_TYPE                0x000000FF
> +#define   CDAT_STRUCTURE_DW0_TYPE_DSMAS 0
> +#define   CDAT_STRUCTURE_DW0_TYPE_DSLBIS 1
> +#define   CDAT_STRUCTURE_DW0_TYPE_DSMSCIS 2
> +#define   CDAT_STRUCTURE_DW0_TYPE_DSIS 3
> +#define   CDAT_STRUCTURE_DW0_TYPE_DSEMTS 4
> +#define   CDAT_STRUCTURE_DW0_TYPE_SSLBIS 5
> +
> +#define CDAT_STRUCTURE_DW0_LENGTH      0xFFFF0000
> +
> +/* Device Scoped Memory Affinity Structure */
> +#define CDAT_DSMAS_DW1_DSMAD_HANDLE    0x000000ff
> +#define CDAT_DSMAS_DW1_FLAGS           0x0000ff00
> +#define CDAT_DSMAS_DPA_OFFSET(entry) ((u64)((entry)[3]) << 32 | (entry)[2])
> +#define CDAT_DSMAS_DPA_LEN(entry) ((u64)((entry)[5]) << 32 | (entry)[4])
> +
> +/* Device Scoped Latency and Bandwidth Information Structure */
> +#define CDAT_DSLBIS_DW1_HANDLE         0x000000ff
> +#define CDAT_DSLBIS_DW1_FLAGS          0x0000ff00
> +#define CDAT_DSLBIS_DW1_DATA_TYPE      0x00ff0000
> +#define CDAT_DSLBIS_BASE_UNIT(entry) ((u64)((entry)[3]) << 32 | (entry)[2])
> +#define CDAT_DSLBIS_DW4_ENTRY_0                0x0000ffff
> +#define CDAT_DSLBIS_DW4_ENTRY_1                0xffff0000
> +#define CDAT_DSLBIS_DW5_ENTRY_2                0x0000ffff
> +
> +/* Device Scoped Memory Side Cache Information Structure */
> +#define CDAT_DSMSCIS_DW1_HANDLE                0x000000ff
> +#define CDAT_DSMSCIS_MEMORY_SIDE_CACHE_SIZE(entry) \
> +       ((u64)((entry)[3]) << 32 | (entry)[2])
> +#define CDAT_DSMSCIS_DW4_MEMORY_SIDE_CACHE_ATTRS 0xffffffff
> +
> +/* Device Scoped Initiator Structure */
> +#define CDAT_DSIS_DW1_FLAGS            0x000000ff
> +#define CDAT_DSIS_DW1_HANDLE           0x0000ff00
> +
> +/* Device Scoped EFI Memory Type Structure */
> +#define CDAT_DSEMTS_DW1_HANDLE         0x000000ff
> +#define CDAT_DSEMTS_DW1_EFI_MEMORY_TYPE_ATTR   0x0000ff00
> +#define CDAT_DSEMTS_DPA_OFFSET(entry)  ((u64)((entry)[3]) << 32 | (entry)[2])
> +#define CDAT_DSEMTS_DPA_LENGTH(entry)  ((u64)((entry)[5]) << 32 | (entry)[4])
> +
> +/* Switch Scoped Latency and Bandwidth Information Structure */
> +#define CDAT_SSLBIS_DW1_DATA_TYPE      0x000000ff
> +#define CDAT_SSLBIS_BASE_UNIT(entry)   ((u64)((entry)[3]) << 32 | (entry)[2])
> +#define CDAT_SSLBIS_ENTRY_PORT_X(entry, i) ((entry)[4 + (i) * 2] & 0x0000ffff)
> +#define CDAT_SSLBIS_ENTRY_PORT_Y(entry, i) (((entry)[4 + (i) * 2] & 0xffff0000) >> 16)
> +#define CDAT_SSLBIS_ENTRY_LAT_OR_BW(entry, i) ((entry)[4 + (i) * 2 + 1] & 0x0000ffff)
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 6f14838c2d25..2f5a69201fc3 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -7,6 +7,7 @@
>  #include <linux/bitfield.h>
>  #include <linux/bitops.h>
>  #include <linux/io.h>
> +#include <linux/pcie-doe.h>
>
>  /* CXL 2.0 8.2.8.1 Device Capabilities Array Register */
>  #define CXLDEV_CAP_ARRAY_OFFSET 0x0
> @@ -57,10 +58,21 @@
>         (FIELD_GET(CXLMDEV_RESET_NEEDED_MASK, status) !=                       \
>          CXLMDEV_RESET_NEEDED_NOT)
>
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
>  struct cxl_memdev;
>  /**
>   * struct cxl_mem - A CXL memory device
>   * @pdev: The PCI device associated with this CXL device.
> + * @doe: Data exchange object mailbox used to read tables.
>   * @regs: IO mappings to the device's MMIO
>   * @status_regs: CXL 2.0 8.2.8.3 Device Status Registers
>   * @mbox_regs: CXL 2.0 8.2.8.4 Mailbox Registers
> @@ -75,6 +87,7 @@ struct cxl_memdev;
>   */
>  struct cxl_mem {
>         struct pci_dev *pdev;
> +       struct pcie_doe doe;

Hmm, I would have expected this to be a pointer. DOE is an optional
component of a hardware device, so it should not be a mandatory
component of a 'struct cxl_mem' instance.

>         void __iomem *regs;
>         struct cxl_memdev *cxlmd;
>
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 4597b28aeb3f..71de66bc6c54 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -12,6 +12,7 @@
>  #include <linux/io-64-nonatomic-lo-hi.h>
>  #include "pci.h"
>  #include "cxl.h"
> +#include "cdat.h"
>
>  /**
>   * DOC: cxl mem
> @@ -91,6 +92,11 @@ struct mbox_cmd {
>  #define CXL_MBOX_SUCCESS 0
>  };
>
> +struct doe_table_attr {
> +       struct bin_attribute attr;
> +       void *table;
> +};
> +
>  /**
>   * struct cxl_memdev - CXL bus object representing a Type-3 Memory Device
>   * @dev: driver core device object
> @@ -98,6 +104,7 @@ struct mbox_cmd {
>   * @cxlm: pointer to the parent device driver data
>   * @ops_active: active user of @cxlm in ops handlers
>   * @ops_dead: completion when all @cxlm ops users have exited
> + * @table_attr: attribute used to provide dumping of table
>   * @id: id number of this memdev instance.
>   */
>  struct cxl_memdev {
> @@ -106,6 +113,7 @@ struct cxl_memdev {
>         struct cxl_mem *cxlm;
>         struct percpu_ref ops_active;
>         struct completion ops_dead;
> +       struct doe_table_attr table_attr;

No, cxl_memdev attributes are statically defined and optionally
visible, see cxl_memdev_attribute_groups.

>         int id;
>  };
>
> @@ -976,13 +984,165 @@ static int cxl_mem_setup_mailbox(struct cxl_mem *cxlm)
>         return 0;
>  }
>
> +#define CDAT_DOE_REQ(entry_handle)                                     \
> +       [0] = FIELD_PREP(PCI_DOE_DATA_OBJECT_HEADER_1_VID,              \
> +                        PCI_DVSEC_VENDOR_ID_CXL) |                     \
> +             FIELD_PREP(PCI_DOE_DATA_OBJECT_HEADER_1_TYPE,             \
> +                          CXL_DOE_PROTOCOL_TABLE_ACCESS),              \
> +       [1] = FIELD_PREP(PCI_DOE_DATA_OBJECT_HEADER_2_LENGTH, 3),       \
> +       [2] = FIELD_PREP(CXL_DOE_TABLE_ACCESS_REQ_CODE,                 \
> +                        CXL_DOE_TABLE_ACCESS_REQ_CODE_READ) |          \
> +             FIELD_PREP(CXL_DOE_TABLE_ACCESS_TABLE_TYPE,               \
> +                        CXL_DOE_TABLE_ACCESS_TABLE_TYPE_CDATA) |       \
> +             FIELD_PREP(CXL_DOE_TABLE_ACCESS_ENTRY_HANDLE, (entry_handle))


I feel like this is asking for more type safety and an easier to read
definition. I.e. even though specification defines requests in terms
of arrays of dwords, there's nothing stopping the implementation from
defining something like:

struct pcie_doe_object {
    u16 vendor;
    u8 type;
    u8 reserved;
    u32 length;
    u32 payload[];
};

> +
> +static ssize_t cdat_get_length(struct pcie_doe *doe)
> +{
> +       u32 cdat_request[3] = {
> +               CDAT_DOE_REQ(0),
> +       };
> +       u32 cdat_response[32];
> +       ssize_t rc;
> +
> +       rc = pcie_doe_exchange(doe, cdat_request, sizeof(cdat_request),
> +                              cdat_response, sizeof(cdat_response));
> +       if (rc)
> +               return rc;
> +
> +       return cdat_response[3];
> +}
> +
> +static int cdat_to_buffer(struct pcie_doe *doe, u32 *buffer, size_t length)
> +{
> +       int entry_handle = 0;
> +       int rc;
> +
> +       do {
> +               u32 cdat_request[3] = {
> +                       CDAT_DOE_REQ(entry_handle)
> +               };
> +               u32 cdat_response[32];
> +               size_t entry_dw;
> +               u32 *entry;
> +
> +               rc = pcie_doe_exchange(doe, cdat_request, sizeof(cdat_request),
> +                                      cdat_response, sizeof(cdat_response));
> +               if (rc)
> +                       return rc;
> +
> +               entry = cdat_response + CDAT_HEADER_LENGTH_DW;
> +
> +               entry_dw = FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_2_LENGTH, cdat_response[1]);
> +               /* Skip Header */
> +               entry_dw -= 3;
> +               entry_dw = min(length / 4, entry_dw);
> +               memcpy(buffer, entry, entry_dw * sizeof(u32));
> +               length -= entry_dw * sizeof(u32);
> +               buffer += entry_dw;
> +               entry_handle = FIELD_GET(CXL_DOE_TABLE_ACCESS_ENTRY_HANDLE, cdat_response[2]);
> +       } while (entry_handle != 0xFFFF);
> +
> +       return 0;
> +}
> +
> +static int cdat_dump(struct pcie_doe *doe)
> +{
> +       struct pci_dev *dev = doe->pdev;
> +       int entry_handle = 0;
> +       int rc;
> +
> +       do {
> +               /* Table access is available */
> +               u32 cdat_request[3] = {
> +                       CDAT_DOE_REQ(entry_handle)
> +               };
> +               u32 cdat_response[32];
> +               u32 *entry;
> +
> +               rc = pcie_doe_exchange(doe, cdat_request, sizeof(cdat_request),
> +                                      cdat_response, sizeof(cdat_response));
> +               if (rc)
> +                       return rc;
> +
> +               entry = cdat_response + CDAT_HEADER_LENGTH_DW;
> +               if (entry_handle == 0) {
> +                       pci_info(dev,
> +                                "CDAT Header (Length=%u, Revision=%u, Checksum=0x%x, Sequence=%u\n",
> +                                entry[0],
> +                                FIELD_GET(CDAT_HEADER_DW1_REVISION, entry[1]),
> +                                FIELD_GET(CDAT_HEADER_DW1_CHECKSUM, entry[1]),
> +                                entry[2]);
> +               } else {
> +                       u8 entry_type = FIELD_GET(CDAT_STRUCTURE_DW0_TYPE, entry[0]);
> +
> +                       switch (entry_type) {
> +                       case CDAT_STRUCTURE_DW0_TYPE_DSMAS:
> +                               pci_info(dev,
> +                                        "CDAT DSMAS (handle=%u flags=0x%x, dpa(0x%llx 0x%llx)\n",
> +                                        FIELD_GET(CDAT_DSMAS_DW1_DSMAD_HANDLE, entry[1]),
> +                                        FIELD_GET(CDAT_DSMAS_DW1_FLAGS, entry[1]),
> +                                        CDAT_DSMAS_DPA_OFFSET(entry),
> +                                        CDAT_DSMAS_DPA_LEN(entry));
> +                               break;
> +                       case CDAT_STRUCTURE_DW0_TYPE_DSLBIS:
> +                               pci_info(dev,
> +                                        "CDAT DSLBIS (handle=%u flags=0x%x, ent_base=0x%llx, entry[%u %u %u])\n",
> +                                        FIELD_GET(CDAT_DSLBIS_DW1_HANDLE, entry[1]),
> +                                        FIELD_GET(CDAT_DSLBIS_DW1_FLAGS, entry[1]),
> +                                        CDAT_DSLBIS_BASE_UNIT(entry),
> +                                        FIELD_GET(CDAT_DSLBIS_DW4_ENTRY_0, entry[4]),
> +                                        FIELD_GET(CDAT_DSLBIS_DW4_ENTRY_1, entry[4]),
> +                                        FIELD_GET(CDAT_DSLBIS_DW5_ENTRY_2, entry[5]));
> +                               break;
> +                       case CDAT_STRUCTURE_DW0_TYPE_DSMSCIS:
> +                               pci_info(dev,
> +                                        "CDAT DSMSCIS (handle=%u sc_size=0x%llx attrs=0x%x)\n",
> +                                        FIELD_GET(CDAT_DSMSCIS_DW1_HANDLE, entry[1]),
> +                                        CDAT_DSMSCIS_MEMORY_SIDE_CACHE_SIZE(entry),
> +                                        FIELD_GET(CDAT_DSMSCIS_DW4_MEMORY_SIDE_CACHE_ATTRS,
> +                                                  entry[4]));
> +                               break;
> +                       case CDAT_STRUCTURE_DW0_TYPE_DSIS:
> +                               pci_info(dev,
> +                                        "CDAT DSIS (handle=%u flags=0x%x)\n",
> +                                        FIELD_GET(CDAT_DSIS_DW1_HANDLE, entry[1]),
> +                                        FIELD_GET(CDAT_DSIS_DW1_FLAGS, entry[1]));
> +                               break;
> +                       case CDAT_STRUCTURE_DW0_TYPE_DSEMTS:
> +                               pci_info(dev,
> +                                        "CDAT DSEMTS (handle=%u EFI=0x%x dpa(0x%llx 0x%llx)\n",
> +                                        FIELD_GET(CDAT_DSEMTS_DW1_HANDLE, entry[1]),
> +                                        FIELD_GET(CDAT_DSEMTS_DW1_EFI_MEMORY_TYPE_ATTR,
> +                                                  entry[1]),
> +                                        CDAT_DSEMTS_DPA_OFFSET(entry),
> +                                        CDAT_DSEMTS_DPA_LENGTH(entry));
> +                               break;
> +                       case CDAT_STRUCTURE_DW0_TYPE_SSLBIS:
> +                               pci_info(dev,
> +                                        "CDAT SSLBIS (type%u ent_base=%llu...)\n",
> +                                        FIELD_GET(CDAT_SSLBIS_DW1_DATA_TYPE,
> +                                                  entry[1]),
> +                                        CDAT_SSLBIS_BASE_UNIT(entry));
> +                               break;
> +                       }
> +               }
> +               entry_handle = FIELD_GET(CXL_DOE_TABLE_ACCESS_ENTRY_HANDLE,
> +                                        cdat_response[2]);
> +       } while (entry_handle != 0xFFFF);

I'd drop the logging in favor of the bin file.

> +
> +       return 0;
> +}
> +
>  static struct cxl_mem *cxl_mem_create(struct pci_dev *pdev, u32 reg_lo,
>                                       u32 reg_hi)
>  {
>         struct device *dev = &pdev->dev;
>         struct cxl_mem *cxlm;
>         void __iomem *regs;
> +       bool doe_use_irq;
> +       int pos = 0;
>         u64 offset;
> +       int irqs;
>         u8 bar;
>         int rc;
>
> @@ -1021,6 +1181,44 @@ static struct cxl_mem *cxl_mem_create(struct pci_dev *pdev, u32 reg_lo,
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
> +               doe_use_irq = false;
> +       } else {
> +               /*
> +                * Enabling bus mastering could be done within the DOE
> +                * initialization, but as it potentially has other impacts
> +                * keep it within the driver.
> +                */
> +               pci_set_master(pdev);
> +               doe_use_irq = true;
> +       }
> +
> +       /*
> +        * Find a DOE mailbox that supports CDAT.
> +        * Supporting other DOE protocols will require more complexity.
> +        */
> +       do {
> +               pos = pci_find_next_ext_capability(pdev, pos, PCI_EXT_CAP_ID_DOE);
> +               if (!pos)
> +                       return NULL;
> +
> +               pcie_doe_init(&cxlm->doe, pdev, pos, doe_use_irq);

I don't think the driver needs to say use-irq or not. If
pcie_doe_init() sees ->{msi,msix}_enabled then try to find the doe
irq, if not then don't...

> +       } while (pcie_doe_protocol_check(&cxlm->doe, PCI_DVSEC_VENDOR_ID_CXL,
> +                                        CXL_DOE_PROTOCOL_TABLE_ACCESS));

Feel like this search should be internal to the library the host
driver does not care which DOE instance is chosen it just cares about
CXL_DOE_PROTOCOL_TABLE_ACCESS.

> +
> +       rc = cdat_dump(&cxlm->doe);
> +       if (rc)
> +               return NULL;
> +
>         dev_dbg(dev, "Mapped CXL Memory Device resource\n");
>         return cxlm;
>  }
> @@ -1178,6 +1376,55 @@ static void cxlmdev_ops_active_release(struct percpu_ref *ref)
>         complete(&cxlmd->ops_dead);
>  }
>
> +static ssize_t cdat_table_show(struct file *filp, struct kobject *kobj,
> +                              struct bin_attribute *bin_attr, char *buf,
> +                              loff_t offset, size_t count)
> +{
> +       struct doe_table_attr *table_attr =
> +               container_of(bin_attr, struct doe_table_attr, attr);
> +
> +       return memory_read_from_buffer(buf, count, &offset, table_attr->table,
> +                                      bin_attr->size);
> +}
> +
> +static void cxl_remove_table_sysfs(void *_cxlmd)
> +{
> +       struct cxl_memdev *cxlmd = _cxlmd;
> +       struct device *dev = &cxlmd->dev;
> +
> +       sysfs_remove_bin_file(&dev->kobj, &cxlmd->table_attr.attr);
> +}
> +
> +static int cxl_add_table_sysfs(struct cxl_memdev *cxlmd)
> +{
> +       struct cxl_mem *cxlm = cxlmd->cxlm;
> +       struct device *dev = &cxlmd->dev;
> +       ssize_t cdat_length;
> +       int rc;
> +
> +       cdat_length = cdat_get_length(&cxlm->doe);
> +       if (cdat_length < 0)
> +               return cdat_length;
> +
> +       sysfs_attr_init(&cxlmd->table_attr.attr.attr);
> +       /* Updates of CDAT are not yet handled so length is fixed. */
> +       cxlmd->table_attr.attr.size = cdat_length;
> +       cxlmd->table_attr.attr.read = cdat_table_show;
> +       cxlmd->table_attr.attr.attr.name = "CDAT";
> +       cxlmd->table_attr.attr.attr.mode = 0400;
> +       cxlmd->table_attr.table = devm_kzalloc(dev->parent, cdat_length, GFP_KERNEL);
> +

This all gets fixed up when switching to static DEVICE_ATTR_ADMIN_RO()
with an ->is_visible() implementation that hides the attribute if the
table is not found.
