Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 582CC2D3855
	for <lists+linux-pci@lfdr.de>; Wed,  9 Dec 2020 02:39:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgLIBie (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Dec 2020 20:38:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbgLIBie (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Dec 2020 20:38:34 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0517AC0613D6
        for <linux-pci@vger.kernel.org>; Tue,  8 Dec 2020 17:37:54 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id k4so306149edl.0
        for <linux-pci@vger.kernel.org>; Tue, 08 Dec 2020 17:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IR/ciPzsJP2zinpYwlzKQlqBHL3lpgKHD7z7eLRGyiM=;
        b=Ufqos9qtSmc/97iCL7vJhwI6lTmVulLK6aNmclMKp3m33id+77EetJSDxjRpE3cdYc
         w/v6u9RgwyFXJ26lZj3jRGUZSyouHpbtpmlV0NsEG4OeOaPzcpeLTJT6LU54eT52YXue
         Aowsf8OC4uo52R0Dx+z+aHDXPai9SUhPQtZ7d2BNCJzNSHUBDFmLOHz9MwLjo3G0nXdq
         1hMvl6pfCfRrdrwVBoHWUWMnd2Lw2ADMzMwpNvfFrSlKCTlH6aSd1PA9Dl1AV2DsBdsQ
         WQz7jZga5F04Ajh4gvZ6pw4221o/8rQfnxLxyYmmt9pChI+4Yl+aVA03W8ssU5Fgs/it
         uHvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IR/ciPzsJP2zinpYwlzKQlqBHL3lpgKHD7z7eLRGyiM=;
        b=Xvv5R4PhHGuORFA0+FGRTGM+HOHd8c7O7P5SrB0jvYK9GJnGiUSEcTaURfeoHR0kO3
         1/8ZxK330Uw75PTbBbHrXVIept6VOuwyZLdkIi26OiGF31qQwflBps7OWtdTuUR+wrJ+
         6wisdYRncYYPDyk1VIEyykY7dQt7x9nDmClS1tShYgNa03HxAcMpdAefLckxs0vyeYdm
         fG2TMJyNdoHGvAwcbYwXvkRiArE8TXAhJSCyxVgBsz2Pp5IkbwxVR0U+b5jTq8bj2omm
         1AAAEc6ydNcLun25clmOFHReFX/bqu+akxEk9W+jRaYzF+bIX2q/GaqnwBLo/Xvk6VQT
         If5A==
X-Gm-Message-State: AOAM530f8hk/2nKS7L79Bp4tQ+yPSJMJkR6XqsKXxBWg4E7XRO0E9Iks
        unm7UHzIYusDpUkZ+yIV6CGotiLYu8cSDSupfcyngQ==
X-Google-Smtp-Source: ABdhPJwRg+5iR3ReNv65OTNw/+dy6+hweaDWvfh6iDhvDG4FZ1nRYIMkGpm7llMHdBWSJjnsjSvVhULOtHlj+ofVviQ=
X-Received: by 2002:aa7:c2d8:: with SMTP id m24mr678734edp.300.1607477872697;
 Tue, 08 Dec 2020 17:37:52 -0800 (PST)
MIME-Version: 1.0
References: <20201209002418.1976362-1-ben.widawsky@intel.com> <20201209002418.1976362-10-ben.widawsky@intel.com>
In-Reply-To: <20201209002418.1976362-10-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 8 Dec 2020 17:37:50 -0800
Message-ID: <CAPcyv4ipGMsKegzWtd+W8wr4mG7X9DtVeQYvL24Eyu1fB3AN=A@mail.gmail.com>
Subject: Re: [RFC PATCH 09/14] cxl/mem: Add basic IOCTL interface
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jon Masters <jcm@jonmasters.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 8, 2020 at 4:24 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> Add a straightforward IOCTL that provides a mechanism for userspace to
> query the supported memory device commands.
>
> Memory device commands are specified in 8.2.9 of the CXL 2.0
> specification. They are submitted through a mailbox mechanism specified
> in 8.2.8.4.
>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
>
> ---
>
> I did attempt to use the same struct for querying commands as well as
> sending commands (upcoming patch). The number of unused fields between
> the two made for a bad fit IMO.
>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
>  Documentation/cxl/memory-devices.rst |   9 +++
>  drivers/cxl/mem.c                    |  89 +++++++++++++++++++++++
>  include/uapi/linux/cxl_mem.h         | 102 +++++++++++++++++++++++++++
>  3 files changed, 200 insertions(+)
>  create mode 100644 include/uapi/linux/cxl_mem.h
>
> diff --git a/Documentation/cxl/memory-devices.rst b/Documentation/cxl/memory-devices.rst
> index 5f723c25382b..ec54674b3822 100644
> --- a/Documentation/cxl/memory-devices.rst
> +++ b/Documentation/cxl/memory-devices.rst
> @@ -32,6 +32,15 @@ CXL Memory Device
>  .. kernel-doc:: drivers/cxl/mem.c
>     :internal:
>
> +CXL IOCTL Interface
> +-------------------
> +
> +.. kernel-doc:: include/uapi/linux/cxl_mem.h
> +   :doc: UAPI
> +
> +.. kernel-doc:: include/uapi/linux/cxl_mem.h
> +   :internal:
> +
>  External Interfaces
>  ===================
>
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index bb6ea58f6c7b..2c4aadcea0e4 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -7,6 +7,7 @@
>  #include <linux/idr.h>
>  #include <linux/pci.h>
>  #include <linux/io.h>
> +#include <uapi/linux/cxl_mem.h>
>  #include "acpi.h"
>  #include "pci.h"
>  #include "cxl.h"
> @@ -73,6 +74,49 @@ static DEFINE_IDR(cxl_mem_idr);
>  /* protect cxl_mem_idr allocations */
>  static DEFINE_MUTEX(cxl_memdev_lock);
>
> +/*
> + * This table defines the supported mailboxes commands for the driver. The id is
> + * ordinal and thus gaps in this table aren't allowed. This table is made up of
> + * a UAPI structure. Non-negative values in the table will be validated against
> + * the user's input. For example, if size_in is 0, and the user passed in 1, it
> + * is an error.
> + */
> +#define CXL_CMD(_id, _flags, sin, sout, _name, _enable, op)                    \
> +       {                                                                      \
> +               { .id = CXL_MEM_COMMAND_ID_##_id,                              \
> +                 .flags = CXL_MEM_COMMAND_FLAG_##_flags,                      \
> +                 .size_in = sin,                                              \
> +                 .size_out = sout,                                            \
> +                 .name = _name },                                             \
> +                       .enable = _enable, .opcode = op                        \
> +       }

Seems the ordinality requirement could be dropped if the definition was:

#define CXL_CMD(_id, _flags, sin, sout, _name, _enable, op)                    \
       [CXL_MEM_COMMAND_ID_##_id] = {
                             \
               { .id = CXL_MEM_COMMAND_ID_##_id,                              \
...

Then command 0 and 42 could be defined out of order in the table.
Especially if we need to config-disable or deprecate commands, I think
it would be useful if this table was tolerant to being sparse.

> +
> +/**
> + * struct cxl_mem_command - Driver representation of a memory device command
> + * @info: Command information as it exists for the UAPI
> + * @opcode: The actual bits used for the mailbox protocol
> + * @enable: Whether the command is enabled. The driver may support a large set
> + *         of commands that may not be enabled. The primary reason a command
> + *         would not be enabled is for commands that are specified as optional
> + *         and the hardware doesn't support the command.
> + *
> + * The cxl_mem_command is the driver's internal representation of commands that
> + * are supported by the driver. Some of these commands may not be supported by
> + * the hardware (!@enable). The driver will use @info to validate the fields
> + * passed in by the user then submit the @opcode to the hardware.
> + *
> + * See struct cxl_command_info.
> + */
> +struct cxl_mem_command {
> +       const struct cxl_command_info info;
> +       const u16 opcode;
> +       bool enable;
> +};
> +
> +static struct cxl_mem_command mem_commands[] = {
> +       CXL_CMD(INVALID, NONE, 0, 0, "Reserved", false, 0),
> +};
> +
>  static int cxl_mem_wait_for_doorbell(struct cxl_mem *cxlm)
>  {
>         const int timeout = msecs_to_jiffies(2000);
> @@ -268,8 +312,53 @@ static int cxl_mem_open(struct inode *inode, struct file *file)
>         return 0;
>  }
>
> +static int cxl_mem_count_commands(void)
> +{
> +       int i, n = 0;
> +
> +       for (i = 0; i < ARRAY_SIZE(mem_commands); i++) {
> +               struct cxl_mem_command *c = &mem_commands[i];
> +
> +               if (c->enable)
> +                       n++;
> +       }
> +
> +       return n;
> +}
> +
>  static long cxl_mem_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>  {
> +       if (cmd == CXL_MEM_QUERY_COMMANDS) {
> +               struct cxl_mem_query_commands __user *q = (void __user *)arg;
> +               u32 n_commands;
> +               int i, j;
> +
> +               if (get_user(n_commands, (u32 __user *)arg))
> +                       return -EFAULT;
> +
> +               if (n_commands == 0)
> +                       return put_user(cxl_mem_count_commands(),
> +                                       (u32 __user *)arg);
> +
> +               for (i = 0, j = 0;
> +                    i < ARRAY_SIZE(mem_commands) && j < n_commands; i++) {
> +                       struct cxl_mem_command *c = &mem_commands[i];
> +                       const struct cxl_command_info *info = &c->info;
> +
> +                       if (!c->enable)
> +                               continue;
> +
> +                       if (copy_to_user(&q->commands[j], info, sizeof(*info)))
> +                               return -EFAULT;
> +
> +                       if (copy_to_user(&q->commands[j].name, info->name,
> +                                        strlen(info->name)))
> +                               return -EFAULT;

Not sure why this is needed, see comment below about @name in
cxl_mem_query_commands.

> +
> +                       j++;
> +               }
> +       }
> +
>         return -ENOTTY;
>  }
>
> diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
> new file mode 100644
> index 000000000000..1d1e143f98ec
> --- /dev/null
> +++ b/include/uapi/linux/cxl_mem.h
> @@ -0,0 +1,102 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/*
> + * CXL IOCTLs for Memory Devices
> + */
> +
> +#ifndef _UAPI_CXL_MEM_H_
> +#define _UAPI_CXL_MEM_H_
> +
> +#if defined(__cplusplus)
> +extern "C" {
> +#endif
> +
> +/**
> + * DOC: UAPI
> + *
> + * CXL memory devices expose UAPI to have a standard user interface.
> + * Userspace can refer to these structure definitions and UAPI formats
> + * to communicate to driver
> + */
> +
> +#define CXL_MEM_QUERY_COMMANDS _IOR('C', 1, struct cxl_mem_query_commands)
> +
> +#define CXL_MEM_COMMAND_NAME_LENGTH 32
> +
> +/**
> + * struct cxl_command_info - Command information returned from a query.
> + * @id: ID number for the command.
> + * @flags: Flags that specify command behavior.
> + *
> + *          - CXL_MEM_COMMAND_FLAG_TAINT: Using this command will taint the kernel.
> + * @size_in: Expected input size, or -1 if variable length.
> + * @size_out: Expected output size, or -1 if variable length.
> + * @name: Name describing the command.
> + *
> + * Represents a single command that is supported by both the driver and the
> + * hardware. The is returned as part of an array from the query ioctl. The
> + * following would be a command named "foobar" that takes a variable length
> + * input and returns 0 bytes of output.
> + *
> + *  - @id = 10
> + *  - @name = foobar
> + *  - @flags = 0
> + *  - @size_in = -1
> + *  - @size_out = 0
> + *
> + * See struct cxl_mem_query_commands.
> + */
> +struct cxl_command_info {
> +       __u32 id;
> +#define CXL_MEM_COMMAND_ID_INVALID 0
> +
> +       __u32 flags;
> +#define CXL_MEM_COMMAND_FLAG_NONE 0
> +#define CXL_MEM_COMMAND_FLAG_TAINT BIT(0)
> +
> +       __s32 size_in;
> +       __s32 size_out;
> +
> +       char name[32];

Why does the name for a command need to be shuffled back and forth
over the ioctl interface. Can't this be handled by a static lookup
table defined in the header?

> +};
> +
> +/**
> + * struct cxl_mem_query_commands - Query supported commands.
> + * @n_commands: In/out parameter. When @n_commands is > 0, the driver will
> + *             return min(num_support_commands, n_commands). When @n_commands
> + *             is 0, driver will return the number of total supported commands.
> + * @rsvd: Reserved for future use.
> + * @commands: Output array of supported commands. This array must be allocated
> + *            by userspace to be at least min(num_support_commands, @n_commands)
> + *
> + * Allow userspace to query the available commands supported by both the driver,
> + * and the hardware. Commands that aren't supported by either the driver, or the
> + * hardware are not returned in the query.
> + *
> + * Examples:
> + *
> + *  - { .n_commands = 0 } // Get number of supported commands
> + *  - { .n_commands = 15, .commands = buf } // Return first 15 (or less)
> + *    supported commands
> + *
> + *  See struct cxl_command_info.
> + */
> +struct cxl_mem_query_commands {
> +       /*
> +        * Input: Number of commands to return (space allocated by user)
> +        * Output: Number of commands supported by the driver/hardware
> +        *
> +        * If n_commands is 0, kernel will only return number of commands and
> +        * not try to populate commands[], thus allowing userspace to know how
> +        * much space to allocate
> +        */
> +       __u32 n_commands;
> +       __u32 rsvd;
> +
> +       struct cxl_command_info __user commands[]; /* out: supported commands */
> +};
> +
> +#if defined(__cplusplus)
> +}
> +#endif
> +
> +#endif
> --
> 2.29.2
>
