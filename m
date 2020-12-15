Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8D892DB63A
	for <lists+linux-pci@lfdr.de>; Tue, 15 Dec 2020 23:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbgLOWDz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Dec 2020 17:03:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727841AbgLOWDy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Dec 2020 17:03:54 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE48DC0613D3
        for <linux-pci@vger.kernel.org>; Tue, 15 Dec 2020 14:03:13 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id j16so281429edr.0
        for <linux-pci@vger.kernel.org>; Tue, 15 Dec 2020 14:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=88RfhIDxtWsqTLkiq1JeMI1Yvs1fSb9kN7oNIhvQbgA=;
        b=c+D1Xm89PUqaTKVmB5h/KRlIEekcdwXVwvbs0vyshWdvFbROH0cEwDHdR2ONzjbQq4
         NuD68AnSe2jHsL/5o0U1AUhFpWo/83V8uFGx0dvwGJ2ORea21WcN9yecwNjwcxBJXuq0
         QRzVBuvTSu2bNvB7PhfORsZOmOg2+Lq48MjqmtqWAX3Obz4xHhOxY0dRBsCendpFAYY8
         M6LcJevzPqFNPps4jT48omK3TyJwOKSUsCsoeu3F6qq9HSOdiQwfnQrFBU0WkM4Ge9Mf
         kJcM9mkMNQQFYk2saouAPgZpJo24LiKmRo3AHzngUxPJz2EQ+2fpuydFz2ManYNmgq2R
         rUqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=88RfhIDxtWsqTLkiq1JeMI1Yvs1fSb9kN7oNIhvQbgA=;
        b=qgpixGZn8kpwosMJ95YEXwzLnhXYJ5WKpblcoBNpi/57IJcUg5a6F6zK4KDmmNRHrW
         wYR/8uIelv38+BCZcC+5360xR5aHqkRhaoZmb7eeiNPfsPjufY6g/nHDH9SuptxzK23A
         HZihA6BK0EteMx01UYqGJWNuGT0ufuN05q3DYMFQ65HOJJvRUbiTcTHDm9inHaHsznTC
         f99tH7jKXNe+pai6Y6sbQ7QPKnCz9W7gT0KbsVQTgqEWkh/OsYz/n2DtUlBp4m2l0mNz
         lb26oqFkDuixKcs1WY62w+nlq9vyiO9MO+XDm6YZh+AeyUUMo/e9Lj+7mpDi0ltihOFO
         r1Zg==
X-Gm-Message-State: AOAM530MulcdKBcfbm4Xn6eb1HhVXJbcv56cxngjCYbETOiOlAe+3X1T
        GV0Cci8TOpukhNGf197LWKHJdrQgiaslIYr+F1JpsQ==
X-Google-Smtp-Source: ABdhPJyLfWo4AriZfgQWLPGpkmCgFQjjZY0qZa/g6CcWLjjnAFNuuVMcU8MCSfVn8uq7EQRsHe2hVjGYMFKplEL5cjo=
X-Received: by 2002:aa7:cdc3:: with SMTP id h3mr4224123edw.52.1608069792396;
 Tue, 15 Dec 2020 14:03:12 -0800 (PST)
MIME-Version: 1.0
References: <20201209002418.1976362-1-ben.widawsky@intel.com>
 <20201209002418.1976362-11-ben.widawsky@intel.com> <CAPcyv4j+ixVgEo5q2OhV4kdkBZbnohZj3KDovReQJjPBsREugw@mail.gmail.com>
 <20201215214351.jvxk32gfa44buvcy@intel.com>
In-Reply-To: <20201215214351.jvxk32gfa44buvcy@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 15 Dec 2020 14:03:00 -0800
Message-ID: <CAPcyv4hVnz14rHLfA9f1Y0V=U96dYJ8i9+Z+ht=+kNG5aCrgeg@mail.gmail.com>
Subject: Re: [RFC PATCH 10/14] cxl/mem: Add send command
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

On Tue, Dec 15, 2020 at 1:44 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
[..]
> > > +static int handle_mailbox_cmd_from_user(struct cxl_memdev *cxlmd,
> > > +                                       const struct cxl_mem_command *cmd,
> > > +                                       struct cxl_send_command __user *u)
> > > +{
> > > +       struct mbox_cmd mbox_cmd;
> > > +       ssize_t payload_size;
> > > +       void *payload;
> > > +       u32 size_out;
> > > +       int rc;
> > > +
> > > +       if (get_user(size_out, &u->size_out))
> > > +               return -EFAULT;
> > > +
> > > +       payload_size = max_t(ssize_t, cmd->info.size_in, size_out);
> > > +       if (payload_size) {
> > > +               payload =
> > > +                       memdup_user(u64_to_user_ptr(u->payload), payload_size);
> >
> > Me thinks this should be vmemdup_user() for payloads that exceed the
> > kmalloc() max, and I think it would be worthwhile to clamp @size_out
> > to some maximum and not let userspace ask for gigantic payloads.
> > Return EINVAL for payloads greater than... 4MB? At least 4MB is the
> > arbitrary max that libnvdimm picked.
> >
>
> This is handled in cxl_validate_cmd_from_user() currently. The current API
> allows the user to specify as large as they like with @size_out but the kernel
> only writes out as much as the hardware returns.... More on this below [1].
[..]
> > > + *  * %-EPERM  - Protected command used by the RAW interface.
> > > + *  * %-ENOMEM - Input or output buffer wasn't large enough.
> > > + *
> > > + */
> > > +static int cxl_validate_cmd_from_user(struct cxl_send_command __user *user_cmd,
> > > +                                     struct cxl_mem_command *out_cmd)
> > > +{
> > > +       const struct cxl_command_info *info;
> > > +       struct cxl_send_command cmd;
> > > +       struct cxl_mem_command *c;
> > > +
> > > +       if (copy_from_user(&cmd, user_cmd, sizeof(cmd)))
> > > +               return -EFAULT;
> > > +
> > > +       if (cmd.id == 0 || cmd.id >= CXL_MEM_COMMAND_ID_MAX)
> > > +               return -EINVAL;
> >
> > I wonder if the "cmd.id >= CXL_MEM_COMMAND_ID_MAX" case should return
> > -ENOTTY. The command might be perfectly valid, just the kernel does
> > not have that command specified which would be the case with older
> > kernel with newer userspace.
> >
>
> I think ENOTTY could be a bit confusing here as it could be confused for the
> SEND ioctl not being present.
>
> What about ENOENT, or something else?

"No such file or directory" seems more confusing to me than
"Inappropriate I/O control operation". What version of this driver,
once it's upstream, will not support the SEND ioctl? I think it is
safe to assume that the mere fact that the driver is attached means
SEND is present.

> > > +
> > > +       c = &mem_commands[cmd.id];
> > > +       info = &c->info;
> > > +
> > > +       if (cmd.flags & CXL_MEM_COMMAND_FLAG_MASK)
> > > +               return -EINVAL;
> > > +
> > > +       if (cmd.rsvd)
> > > +               return -EINVAL;
> > > +
> > > +       /* Check the input buffer is the expected size */
> > > +       if (info->size_in >= 0 && info->size_in != cmd.size_in)
> > > +               return -ENOMEM;
> > > +
> > > +       /* Check the output buffer is at least large enough */
> > > +       if (info->size_out >= 0 && cmd.size_out < info->size_out)
> > > +               return -ENOMEM;
> > > +
> > > +       memcpy(out_cmd, c, sizeof(*c));
> >
> > Why not do the copy_from_user() directly into out_cmd to save a copy operation?
> >
>
> [1]
> cxl_validate_cmd_from_user() essentially translates a user's command into the
> internal kernel representation of the command via the lookup into the array.
> This will do things like adjust the output size or flags, to prevent userspace
> from doing nefarious things. An actual command, especially now that you had me
> remove the name[32] will be relatively small and I see the extra copy as being
> well worth being able to isolate this command sanitization.

I can buy that, but it does not answer my other question above about
cases where a valid command has size_{in,out} larger than the kmalloc
max. vmemdup_user() lets you support arbitrary command payload sizes
larger than KMALLOC_MAX_SIZE. For example, I might want to overwrite
the entire label area at once in a single write.

>
> > > +
> > > +       return 0;
> > >  }
> > >
> > >  static long cxl_mem_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> > > @@ -357,6 +471,19 @@ static long cxl_mem_ioctl(struct file *file, unsigned int cmd, unsigned long arg
> > >
> > >                         j++;
> > >                 }
> > > +
> > > +               return 0;
> > > +       } else if (cmd == CXL_MEM_SEND_COMMAND) {
> > > +               struct cxl_send_command __user *u = (void __user *)arg;
> > > +               struct cxl_memdev *cxlmd = file->private_data;
> > > +               struct cxl_mem_command c;
> > > +               int rc;
> > > +
> > > +               rc = cxl_validate_cmd_from_user(u, &c);
> > > +               if (rc)
> > > +                       return rc;
> > > +
> > > +               return handle_mailbox_cmd_from_user(cxlmd, &c, u);
> > >         }
> > >
> > >         return -ENOTTY;
> > > diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
> > > index 1d1e143f98ec..189d86a13637 100644
> > > --- a/include/uapi/linux/cxl_mem.h
> > > +++ b/include/uapi/linux/cxl_mem.h
> > > @@ -19,6 +19,7 @@ extern "C" {
> > >   */
> > >
> > >  #define CXL_MEM_QUERY_COMMANDS _IOR('C', 1, struct cxl_mem_query_commands)
> > > +#define CXL_MEM_SEND_COMMAND _IOWR('C', 2, struct cxl_send_command)
> > >
> > >  #define CXL_MEM_COMMAND_NAME_LENGTH 32
> > >
> > > @@ -48,10 +49,12 @@ extern "C" {
> > >  struct cxl_command_info {
> > >         __u32 id;
> > >  #define CXL_MEM_COMMAND_ID_INVALID 0
> > > +#define CXL_MEM_COMMAND_ID_MAX (CXL_MEM_COMMAND_ID_INVALID + 1)
> > >
> > >         __u32 flags;
> > >  #define CXL_MEM_COMMAND_FLAG_NONE 0
> > >  #define CXL_MEM_COMMAND_FLAG_TAINT BIT(0)
> >
> > I guess I missed this in the last patch, why would userspace specify a
> > taint flag? @flags is an output parameter?
> >
>
> The flag is from the kernel to userspace to let them know that using the command
> would taint the kernel.

...but they should know that by the fact that they are using the RAW
send. I.e. document it once rather than include it in the ABI. I think
a more useful flag would be to identify which commands may be blocked
because they are exclusively owned by the kernel.
