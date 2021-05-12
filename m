Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A20E437B60F
	for <lists+linux-pci@lfdr.de>; Wed, 12 May 2021 08:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbhELG12 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 May 2021 02:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhELG1Z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 May 2021 02:27:25 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C076EC061574
        for <linux-pci@vger.kernel.org>; Tue, 11 May 2021 23:26:17 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id gx5so33229956ejb.11
        for <linux-pci@vger.kernel.org>; Tue, 11 May 2021 23:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eZph6vZCeocTuzKG6y9b76I8yFtudZcd2OypTzYn49o=;
        b=SaCKSUKHZrBfpiR50uzyFl7Dcnil+75doAIOF0hDdJfdY0FV4r6MPQiv98ochwenwz
         UB5Zxiix04UbKIE3veBvQT78+FgnExR717wCgfuStOgCPUkk5+2ZORi5D4Wz+O+sFqr/
         m9cslLJkXn4Tuf2x+WyDb8I1HPuZ4r6HjrGeKXlO3VtDNUBxmKdKP2idoQh5kVxf5c1A
         fO/82IK46yiHuWw8w+RaMbF3ZdJh62pdPia69vu4Fqm1AbRrlR57RPE5T3T8a86mLIUL
         FHSJYa0c+1nlvVDBscJ5UlXligQ07lra6nk3ZoIL7FnDoZOiuCiSyW3UchPkcxrf1Nlx
         HMfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eZph6vZCeocTuzKG6y9b76I8yFtudZcd2OypTzYn49o=;
        b=JPqf19IkRwv8q4BOb9YaZYoN1GO9lo7Xz++bzu10i80acfCA3aP+/Ln5kQfGqnn/Kk
         1sxmc+P4UcDYvHYKzfvIk15D8dhQlCQJIhlmTUgyiVHZiVmeY1OP9HYVbOzPoFrsZq35
         gln3NK4CW/ukK5N2wC8k+Lap6bT/VitQfXdnTtZ7eSpu5aD6ydqcGirWdGLTG8IHe+6y
         zL3upndmvczYCkxUD0akZccW82lwA7ITNgl4JR2bKJLRfO6aIQEVNR7P5e/9Zjf7MM5C
         2BHBVdbIPsDdGc8+lZbwsY7TBEXX44qHFr0TUCVbAL2cj4zFz8m/OC7IzafnSd3H/0Gf
         cCYQ==
X-Gm-Message-State: AOAM533Q1hI/I6RzXvQ0tWYaGWjpWIYK+jotAYNkewQBt3GZK5nfKJWq
        bTzs7Jxjtng1Gs7kOW3Aul7YABqaBJQSxwFFVnMyug==
X-Google-Smtp-Source: ABdhPJwXag0pPO9pwMrHYQZ0mD+M3sbcCs4CpWNo3K2BPsmAxmLpSwNXo6czlXkargXWqAmaR22EDxvgl61A2Nh9Ys0=
X-Received: by 2002:a17:906:1d0a:: with SMTP id n10mr18702521ejh.341.1620800776385;
 Tue, 11 May 2021 23:26:16 -0700 (PDT)
MIME-Version: 1.0
References: <162042787450.1202325.5718541949681409566.stgit@dwillia2-desk3.amr.corp.intel.com>
 <162042788555.1202325.7566057227479911213.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20210510161708.000040df@Huawei.com>
In-Reply-To: <20210510161708.000040df@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 11 May 2021 23:26:06 -0700
Message-ID: <CAPcyv4i3Ak=_Tr0Hx35KYqB1a7_=mDthZi3krj_B_xt+uVeX-g@mail.gmail.com>
Subject: Re: [PATCH 2/8] cxl/mem: Introduce 'struct cxl_regs' for "composable"
 CXL devices
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[ add Christoph ]

On Mon, May 10, 2021 at 8:19 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Fri, 7 May 2021 15:51:25 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
>
> > CXL MMIO register blocks are organized by device type and capabilities.
> > There are Component registers, Device registers (yes, an ambiguous
> > name), and Memory Device registers (a specific extension of Device
> > registers).
> >
> > It is possible for a given device instance (endpoint or port) to
> > implement register sets from multiple of the above categories.
> >
> > The driver code that enumerates and maps the registers is type specific
> > so it is useful to have a dedicated type and helpers for each block
> > type.
> >
> > At the same time, once the registers are mapped the origin type does not
> > matter. It is overly pedantic to reference the register block type in
> > code that is using the registers.
> >
> > In preparation for the endpoint driver to incorporate Component registers
> > into its MMIO operations reorganize the registers to allow typed
> > enumeration + mapping, but anonymous usage. With the end state of
> > 'struct cxl_regs' to be:
> >
> > struct cxl_regs {
> >       union {
> >               struct {
> >                       CXL_DEVICE_REGS();
> >               };
> >               struct cxl_device_regs device_regs;
> >       };
> >       union {
> >               struct {
> >                       CXL_COMPONENT_REGS();
> >               };
> >               struct cxl_component_regs component_regs;
> >       };
> > };
> >
> > With this arrangement the driver can share component init code with
> > ports, but when using the registers it can directly reference the
> > component register block type by name without the 'component_regs'
> > prefix.
> >
> > So, map + enumerate can be shared across drivers of different CXL
> > classes e.g.:
> >
> > void cxl_setup_device_regs(struct device *dev, void __iomem *base,
> >                          struct cxl_device_regs *regs);
> >
> > void cxl_setup_component_regs(struct device *dev, void __iomem *base,
> >                             struct cxl_component_regs *regs);
> >
> > ...while inline usage in the driver need not indicate where the
> > registers came from:
> >
> > readl(cxlm->regs.mbox + MBOX_OFFSET);
> > readl(cxlm->regs.hdm + HDM_OFFSET);
> >
> > ...instead of:
> >
> > readl(cxlm->regs.device_regs.mbox + MBOX_OFFSET);
> > readl(cxlm->regs.component_regs.hdm + HDM_OFFSET);
> >
> > This complexity of the definition in .h yields improvement in code
> > readability in .c while maintaining type-safety for organization of
> > setup code. It prepares the implementation to maintain organization in
> > the face of CXL devices that compose register interfaces consisting of
> > multiple types.
> >
> > Given that this new container is named 'regs' rename the common register
> > base pointer @base, and fixup the kernel-doc for the missing @cxlmd
> > description.
> >
> > Reviewed-by: Ben Widawsky <ben.widawsky@intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>
> I'm not a huge fan of the trickery in here and wonder if it'll come back
> to bite.  However, given the strongest argument against I can think of
> is that it might well confuse static analyzers, is not very strong,
> and it does make for more readable code...

The "come back to bite" I have been bracing for is from Christoph as
he wanted more justification for this approach. I added that, but he
has not commented on that update.

> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

I'll proceed with the hope that the more readable .c justifies the
less readable .h which is in the spirit of other hackery that Linux
hides in header files.

Christoph, I'll copy you on v4 which will be a rebase to -rc1 and
addressing Jonathan's patch5 comments, but until then here's the whole
patch quoted below.

>
> > ---
> >  drivers/cxl/cxl.h |   32 ++++++++++++++++++++++++++++++++
> >  drivers/cxl/mem.c |   44 ++++++++++++++++++++++++--------------------
> >  drivers/cxl/mem.h |   13 +++++--------
> >  3 files changed, 61 insertions(+), 28 deletions(-)
> >
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index 2e3bdacb32e7..1f3434f89ef2 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -34,5 +34,37 @@
> >  #define CXLDEV_MBOX_BG_CMD_STATUS_OFFSET 0x18
> >  #define CXLDEV_MBOX_PAYLOAD_OFFSET 0x20
> >
> > +/*
> > + * CXL_DEVICE_REGS - Common set of CXL Device register block base pointers
> > + * @status: CXL 2.0 8.2.8.3 Device Status Registers
> > + * @mbox: CXL 2.0 8.2.8.4 Mailbox Registers
> > + * @memdev: CXL 2.0 8.2.8.5 Memory Device Registers
> > + */
> > +#define CXL_DEVICE_REGS() \
> > +     void __iomem *status; \
> > +     void __iomem *mbox; \
> > +     void __iomem *memdev
> > +
> > +/* See note for 'struct cxl_regs' for the rationale of this organization */
> > +struct cxl_device_regs {
> > +     CXL_DEVICE_REGS();
> > +};
> > +
> > +/*
> > + * Note, the anonymous union organization allows for per
> > + * register-block-type helper routines, without requiring block-type
> > + * agnostic code to include the prefix. I.e.
> > + * cxl_setup_device_regs(&cxlm->regs.dev) vs readl(cxlm->regs.mbox).
> > + * The specificity reads naturally from left-to-right.
> > + */
> > +struct cxl_regs {
> > +     union {
> > +             struct {
> > +                     CXL_DEVICE_REGS();
> > +             };
> > +             struct cxl_device_regs device_regs;
> > +     };
> > +};
> > +
> >  extern struct bus_type cxl_bus_type;
> >  #endif /* __CXL_H__ */
> > diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> > index 45871ef65152..6951243d128e 100644
> > --- a/drivers/cxl/mem.c
> > +++ b/drivers/cxl/mem.c
> > @@ -31,7 +31,7 @@
> >   */
> >
> >  #define cxl_doorbell_busy(cxlm)                                                \
> > -     (readl((cxlm)->mbox_regs + CXLDEV_MBOX_CTRL_OFFSET) &                  \
> > +     (readl((cxlm)->regs.mbox + CXLDEV_MBOX_CTRL_OFFSET) &                  \
> >        CXLDEV_MBOX_CTRL_DOORBELL)
> >
> >  /* CXL 2.0 - 8.2.8.4 */
> > @@ -271,7 +271,7 @@ static void cxl_mem_mbox_timeout(struct cxl_mem *cxlm,
> >  static int __cxl_mem_mbox_send_cmd(struct cxl_mem *cxlm,
> >                                  struct mbox_cmd *mbox_cmd)
> >  {
> > -     void __iomem *payload = cxlm->mbox_regs + CXLDEV_MBOX_PAYLOAD_OFFSET;
> > +     void __iomem *payload = cxlm->regs.mbox + CXLDEV_MBOX_PAYLOAD_OFFSET;
> >       u64 cmd_reg, status_reg;
> >       size_t out_len;
> >       int rc;
> > @@ -314,12 +314,12 @@ static int __cxl_mem_mbox_send_cmd(struct cxl_mem *cxlm,
> >       }
> >
> >       /* #2, #3 */
> > -     writeq(cmd_reg, cxlm->mbox_regs + CXLDEV_MBOX_CMD_OFFSET);
> > +     writeq(cmd_reg, cxlm->regs.mbox + CXLDEV_MBOX_CMD_OFFSET);
> >
> >       /* #4 */
> >       dev_dbg(&cxlm->pdev->dev, "Sending command\n");
> >       writel(CXLDEV_MBOX_CTRL_DOORBELL,
> > -            cxlm->mbox_regs + CXLDEV_MBOX_CTRL_OFFSET);
> > +            cxlm->regs.mbox + CXLDEV_MBOX_CTRL_OFFSET);
> >
> >       /* #5 */
> >       rc = cxl_mem_wait_for_doorbell(cxlm);
> > @@ -329,7 +329,7 @@ static int __cxl_mem_mbox_send_cmd(struct cxl_mem *cxlm,
> >       }
> >
> >       /* #6 */
> > -     status_reg = readq(cxlm->mbox_regs + CXLDEV_MBOX_STATUS_OFFSET);
> > +     status_reg = readq(cxlm->regs.mbox + CXLDEV_MBOX_STATUS_OFFSET);
> >       mbox_cmd->return_code =
> >               FIELD_GET(CXLDEV_MBOX_STATUS_RET_CODE_MASK, status_reg);
> >
> > @@ -339,7 +339,7 @@ static int __cxl_mem_mbox_send_cmd(struct cxl_mem *cxlm,
> >       }
> >
> >       /* #7 */
> > -     cmd_reg = readq(cxlm->mbox_regs + CXLDEV_MBOX_CMD_OFFSET);
> > +     cmd_reg = readq(cxlm->regs.mbox + CXLDEV_MBOX_CMD_OFFSET);
> >       out_len = FIELD_GET(CXLDEV_MBOX_CMD_PAYLOAD_LENGTH_MASK, cmd_reg);
> >
> >       /* #8 */
> > @@ -400,7 +400,7 @@ static int cxl_mem_mbox_get(struct cxl_mem *cxlm)
> >               goto out;
> >       }
> >
> > -     md_status = readq(cxlm->memdev_regs + CXLMDEV_STATUS_OFFSET);
> > +     md_status = readq(cxlm->regs.memdev + CXLMDEV_STATUS_OFFSET);
> >       if (!(md_status & CXLMDEV_MBOX_IF_READY && CXLMDEV_READY(md_status))) {
> >               dev_err(dev, "mbox: reported doorbell ready, but not mbox ready\n");
> >               rc = -EBUSY;
> > @@ -868,7 +868,7 @@ static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
> >       int cap, cap_count;
> >       u64 cap_array;
> >
> > -     cap_array = readq(cxlm->regs + CXLDEV_CAP_ARRAY_OFFSET);
> > +     cap_array = readq(cxlm->base + CXLDEV_CAP_ARRAY_OFFSET);
> >       if (FIELD_GET(CXLDEV_CAP_ARRAY_ID_MASK, cap_array) !=
> >           CXLDEV_CAP_ARRAY_CAP_ID)
> >               return -ENODEV;
> > @@ -881,25 +881,25 @@ static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
> >               u16 cap_id;
> >
> >               cap_id = FIELD_GET(CXLDEV_CAP_HDR_CAP_ID_MASK,
> > -                                readl(cxlm->regs + cap * 0x10));
> > -             offset = readl(cxlm->regs + cap * 0x10 + 0x4);
> > -             register_block = cxlm->regs + offset;
> > +                                readl(cxlm->base + cap * 0x10));
> > +             offset = readl(cxlm->base + cap * 0x10 + 0x4);
> > +             register_block = cxlm->base + offset;
> >
> >               switch (cap_id) {
> >               case CXLDEV_CAP_CAP_ID_DEVICE_STATUS:
> >                       dev_dbg(dev, "found Status capability (0x%x)\n", offset);
> > -                     cxlm->status_regs = register_block;
> > +                     cxlm->regs.status = register_block;
> >                       break;
> >               case CXLDEV_CAP_CAP_ID_PRIMARY_MAILBOX:
> >                       dev_dbg(dev, "found Mailbox capability (0x%x)\n", offset);
> > -                     cxlm->mbox_regs = register_block;
> > +                     cxlm->regs.mbox = register_block;
> >                       break;
> >               case CXLDEV_CAP_CAP_ID_SECONDARY_MAILBOX:
> >                       dev_dbg(dev, "found Secondary Mailbox capability (0x%x)\n", offset);
> >                       break;
> >               case CXLDEV_CAP_CAP_ID_MEMDEV:
> >                       dev_dbg(dev, "found Memory Device capability (0x%x)\n", offset);
> > -                     cxlm->memdev_regs = register_block;
> > +                     cxlm->regs.memdev = register_block;
> >                       break;
> >               default:
> >                       dev_dbg(dev, "Unknown cap ID: %d (0x%x)\n", cap_id, offset);
> > @@ -907,11 +907,11 @@ static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
> >               }
> >       }
> >
> > -     if (!cxlm->status_regs || !cxlm->mbox_regs || !cxlm->memdev_regs) {
> > +     if (!cxlm->regs.status || !cxlm->regs.mbox || !cxlm->regs.memdev) {
> >               dev_err(dev, "registers not found: %s%s%s\n",
> > -                     !cxlm->status_regs ? "status " : "",
> > -                     !cxlm->mbox_regs ? "mbox " : "",
> > -                     !cxlm->memdev_regs ? "memdev" : "");
> > +                     !cxlm->regs.status ? "status " : "",
> > +                     !cxlm->regs.mbox ? "mbox " : "",
> > +                     !cxlm->regs.memdev ? "memdev" : "");
> >               return -ENXIO;
> >       }
> >
> > @@ -920,7 +920,7 @@ static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
> >
> >  static int cxl_mem_setup_mailbox(struct cxl_mem *cxlm)
> >  {
> > -     const int cap = readl(cxlm->mbox_regs + CXLDEV_MBOX_CAPS_OFFSET);
> > +     const int cap = readl(cxlm->regs.mbox + CXLDEV_MBOX_CAPS_OFFSET);
> >
> >       cxlm->payload_size =
> >               1 << FIELD_GET(CXLDEV_MBOX_CAP_PAYLOAD_SIZE_MASK, cap);
> > @@ -980,7 +980,7 @@ static struct cxl_mem *cxl_mem_create(struct pci_dev *pdev, u32 reg_lo,
> >
> >       mutex_init(&cxlm->mbox_mutex);
> >       cxlm->pdev = pdev;
> > -     cxlm->regs = regs + offset;
> > +     cxlm->base = regs + offset;
> >       cxlm->enabled_cmds =
> >               devm_kmalloc_array(dev, BITS_TO_LONGS(cxl_cmd_count),
> >                                  sizeof(unsigned long),
> > @@ -1495,6 +1495,10 @@ static __init int cxl_mem_init(void)
> >       dev_t devt;
> >       int rc;
> >
> > +     /* Double check the anonymous union trickery in struct cxl_regs */
> > +     BUILD_BUG_ON(offsetof(struct cxl_regs, memdev) !=
> > +                  offsetof(struct cxl_regs, device_regs.memdev));
> > +
> >       rc = alloc_chrdev_region(&devt, 0, CXL_MEM_MAX_DEVS, "cxl");
> >       if (rc)
> >               return rc;
> > diff --git a/drivers/cxl/mem.h b/drivers/cxl/mem.h
> > index 616bb6fd721f..f4d89e816a89 100644
> > --- a/drivers/cxl/mem.h
> > +++ b/drivers/cxl/mem.h
> > @@ -53,10 +53,9 @@ struct cxl_memdev {
> >  /**
> >   * struct cxl_mem - A CXL memory device
> >   * @pdev: The PCI device associated with this CXL device.
> > - * @regs: IO mappings to the device's MMIO
> > - * @status_regs: CXL 2.0 8.2.8.3 Device Status Registers
> > - * @mbox_regs: CXL 2.0 8.2.8.4 Mailbox Registers
> > - * @memdev_regs: CXL 2.0 8.2.8.5 Memory Device Registers
> > + * @base: IO mappings to the device's MMIO
> > + * @cxlmd: Logical memory device chardev / interface
> > + * @regs: Parsed register blocks
> >   * @payload_size: Size of space for payload
> >   *                (CXL 2.0 8.2.8.4.3 Mailbox Capabilities Register)
> >   * @mbox_mutex: Mutex to synchronize mailbox access.
> > @@ -67,12 +66,10 @@ struct cxl_memdev {
> >   */
> >  struct cxl_mem {
> >       struct pci_dev *pdev;
> > -     void __iomem *regs;
> > +     void __iomem *base;
> >       struct cxl_memdev *cxlmd;
> >
> > -     void __iomem *status_regs;
> > -     void __iomem *mbox_regs;
> > -     void __iomem *memdev_regs;
> > +     struct cxl_regs regs;
> >
> >       size_t payload_size;
> >       struct mutex mbox_mutex; /* Protects device mailbox and firmware */
> >
>
