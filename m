Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46B832DB673
	for <lists+linux-pci@lfdr.de>; Tue, 15 Dec 2020 23:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbgLOWSc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Dec 2020 17:18:32 -0500
Received: from mga03.intel.com ([134.134.136.65]:64384 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727013AbgLOWSZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 Dec 2020 17:18:25 -0500
IronPort-SDR: t9AOls5jrXdUHSdkffikHQt9/KE+/6jwqMdVXJWyElARu30EGyE+irgJrVcy8z3jCwIXzDpSfR
 QiUQQTj6hJaQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9836"; a="175068859"
X-IronPort-AV: E=Sophos;i="5.78,422,1599548400"; 
   d="scan'208";a="175068859"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2020 14:17:42 -0800
IronPort-SDR: s47Gj518tXjp/XKmRwfnCnnocO60ttL60VYcDxbsYVm/p/3taO/bn59paytwD3kMyvdFDF6ujy
 LRicAmSHWHhA==
X-IronPort-AV: E=Sophos;i="5.78,422,1599548400"; 
   d="scan'208";a="368490733"
Received: from sagarbas-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.135.43])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2020 14:17:41 -0800
Date:   Tue, 15 Dec 2020 14:17:40 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
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
Subject: Re: [RFC PATCH 10/14] cxl/mem: Add send command
Message-ID: <20201215221740.symlsmzi3r6ojl6c@intel.com>
References: <20201209002418.1976362-1-ben.widawsky@intel.com>
 <20201209002418.1976362-11-ben.widawsky@intel.com>
 <CAPcyv4j+ixVgEo5q2OhV4kdkBZbnohZj3KDovReQJjPBsREugw@mail.gmail.com>
 <20201215214351.jvxk32gfa44buvcy@intel.com>
 <CAPcyv4hVnz14rHLfA9f1Y0V=U96dYJ8i9+Z+ht=+kNG5aCrgeg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4hVnz14rHLfA9f1Y0V=U96dYJ8i9+Z+ht=+kNG5aCrgeg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 20-12-15 14:03:00, Dan Williams wrote:
> On Tue, Dec 15, 2020 at 1:44 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
> [..]
> > > > +static int handle_mailbox_cmd_from_user(struct cxl_memdev *cxlmd,
> > > > +                                       const struct cxl_mem_command *cmd,
> > > > +                                       struct cxl_send_command __user *u)
> > > > +{
> > > > +       struct mbox_cmd mbox_cmd;
> > > > +       ssize_t payload_size;
> > > > +       void *payload;
> > > > +       u32 size_out;
> > > > +       int rc;
> > > > +
> > > > +       if (get_user(size_out, &u->size_out))
> > > > +               return -EFAULT;
> > > > +
> > > > +       payload_size = max_t(ssize_t, cmd->info.size_in, size_out);
> > > > +       if (payload_size) {
> > > > +               payload =
> > > > +                       memdup_user(u64_to_user_ptr(u->payload), payload_size);
> > >
> > > Me thinks this should be vmemdup_user() for payloads that exceed the
> > > kmalloc() max, and I think it would be worthwhile to clamp @size_out
> > > to some maximum and not let userspace ask for gigantic payloads.
> > > Return EINVAL for payloads greater than... 4MB? At least 4MB is the
> > > arbitrary max that libnvdimm picked.
> > >
> >
> > This is handled in cxl_validate_cmd_from_user() currently. The current API
> > allows the user to specify as large as they like with @size_out but the kernel
> > only writes out as much as the hardware returns.... More on this below [1].
> [..]
> > > > + *  * %-EPERM  - Protected command used by the RAW interface.
> > > > + *  * %-ENOMEM - Input or output buffer wasn't large enough.
> > > > + *
> > > > + */
> > > > +static int cxl_validate_cmd_from_user(struct cxl_send_command __user *user_cmd,
> > > > +                                     struct cxl_mem_command *out_cmd)
> > > > +{
> > > > +       const struct cxl_command_info *info;
> > > > +       struct cxl_send_command cmd;
> > > > +       struct cxl_mem_command *c;
> > > > +
> > > > +       if (copy_from_user(&cmd, user_cmd, sizeof(cmd)))
> > > > +               return -EFAULT;
> > > > +
> > > > +       if (cmd.id == 0 || cmd.id >= CXL_MEM_COMMAND_ID_MAX)
> > > > +               return -EINVAL;
> > >
> > > I wonder if the "cmd.id >= CXL_MEM_COMMAND_ID_MAX" case should return
> > > -ENOTTY. The command might be perfectly valid, just the kernel does
> > > not have that command specified which would be the case with older
> > > kernel with newer userspace.
> > >
> >
> > I think ENOTTY could be a bit confusing here as it could be confused for the
> > SEND ioctl not being present.
> >
> > What about ENOENT, or something else?
> 
> "No such file or directory" seems more confusing to me than
> "Inappropriate I/O control operation". What version of this driver,
> once it's upstream, will not support the SEND ioctl? I think it is
> safe to assume that the mere fact that the driver is attached means
> SEND is present.
> 

No version. I had been thinking it gets confusing with a new IOCTL, but you're
correct that it should be trivial to determine ENOTTY from Send is different
than ENOTTY from another IOCTL.

I'll change it.

> > > > +
> > > > +       c = &mem_commands[cmd.id];
> > > > +       info = &c->info;
> > > > +
> > > > +       if (cmd.flags & CXL_MEM_COMMAND_FLAG_MASK)
> > > > +               return -EINVAL;
> > > > +
> > > > +       if (cmd.rsvd)
> > > > +               return -EINVAL;
> > > > +
> > > > +       /* Check the input buffer is the expected size */
> > > > +       if (info->size_in >= 0 && info->size_in != cmd.size_in)
> > > > +               return -ENOMEM;
> > > > +
> > > > +       /* Check the output buffer is at least large enough */
> > > > +       if (info->size_out >= 0 && cmd.size_out < info->size_out)
> > > > +               return -ENOMEM;
> > > > +
> > > > +       memcpy(out_cmd, c, sizeof(*c));
> > >
> > > Why not do the copy_from_user() directly into out_cmd to save a copy operation?
> > >
> >
> > [1]
> > cxl_validate_cmd_from_user() essentially translates a user's command into the
> > internal kernel representation of the command via the lookup into the array.
> > This will do things like adjust the output size or flags, to prevent userspace
> > from doing nefarious things. An actual command, especially now that you had me
> > remove the name[32] will be relatively small and I see the extra copy as being
> > well worth being able to isolate this command sanitization.
> 
> I can buy that, but it does not answer my other question above about
> cases where a valid command has size_{in,out} larger than the kmalloc
> max. vmemdup_user() lets you support arbitrary command payload sizes
> larger than KMALLOC_MAX_SIZE. For example, I might want to overwrite
> the entire label area at once in a single write.
> 

It does need to switch to vmemdup_user(), I didn't mean to disagree there.

For posterity btw, I'll point out CXL 2.0 max is 2M for payload.

> >
> > > > +
> > > > +       return 0;
> > > >  }
> > > >
> > > >  static long cxl_mem_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> > > > @@ -357,6 +471,19 @@ static long cxl_mem_ioctl(struct file *file, unsigned int cmd, unsigned long arg
> > > >
> > > >                         j++;
> > > >                 }
> > > > +
> > > > +               return 0;
> > > > +       } else if (cmd == CXL_MEM_SEND_COMMAND) {
> > > > +               struct cxl_send_command __user *u = (void __user *)arg;
> > > > +               struct cxl_memdev *cxlmd = file->private_data;
> > > > +               struct cxl_mem_command c;
> > > > +               int rc;
> > > > +
> > > > +               rc = cxl_validate_cmd_from_user(u, &c);
> > > > +               if (rc)
> > > > +                       return rc;
> > > > +
> > > > +               return handle_mailbox_cmd_from_user(cxlmd, &c, u);
> > > >         }
> > > >
> > > >         return -ENOTTY;
> > > > diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
> > > > index 1d1e143f98ec..189d86a13637 100644
> > > > --- a/include/uapi/linux/cxl_mem.h
> > > > +++ b/include/uapi/linux/cxl_mem.h
> > > > @@ -19,6 +19,7 @@ extern "C" {
> > > >   */
> > > >
> > > >  #define CXL_MEM_QUERY_COMMANDS _IOR('C', 1, struct cxl_mem_query_commands)
> > > > +#define CXL_MEM_SEND_COMMAND _IOWR('C', 2, struct cxl_send_command)
> > > >
> > > >  #define CXL_MEM_COMMAND_NAME_LENGTH 32
> > > >
> > > > @@ -48,10 +49,12 @@ extern "C" {
> > > >  struct cxl_command_info {
> > > >         __u32 id;
> > > >  #define CXL_MEM_COMMAND_ID_INVALID 0
> > > > +#define CXL_MEM_COMMAND_ID_MAX (CXL_MEM_COMMAND_ID_INVALID + 1)
> > > >
> > > >         __u32 flags;
> > > >  #define CXL_MEM_COMMAND_FLAG_NONE 0
> > > >  #define CXL_MEM_COMMAND_FLAG_TAINT BIT(0)
> > >
> > > I guess I missed this in the last patch, why would userspace specify a
> > > taint flag? @flags is an output parameter?
> > >
> >
> > The flag is from the kernel to userspace to let them know that using the command
> > would taint the kernel.
> 
> ...but they should know that by the fact that they are using the RAW
> send. I.e. document it once rather than include it in the ABI. I think
> a more useful flag would be to identify which commands may be blocked
> because they are exclusively owned by the kernel.

I think taint is something that could change between driver versions, and even
based on the underlying device. However, since Raw command will always taint, we
can save that for another day and I will drop it from this patch.

As an example, perhaps we know device X's active firmware update is flaky - we
can make that a tainted command just for that device.
