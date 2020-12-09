Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7F252D391E
	for <lists+linux-pci@lfdr.de>; Wed,  9 Dec 2020 04:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbgLIDHc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Dec 2020 22:07:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbgLIDHb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Dec 2020 22:07:31 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72313C061794
        for <linux-pci@vger.kernel.org>; Tue,  8 Dec 2020 19:06:51 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id lt17so937786ejb.3
        for <linux-pci@vger.kernel.org>; Tue, 08 Dec 2020 19:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8AFvZy5IevjnVMOU6zN7P4dA9MmKNHlLYmheYvMwvVc=;
        b=VCeHrc0dr9kgX339cC7qkulsq0krr/xcafwkxj1skiTLZ6/3KXgaUsnTDhDv4Tnhwz
         MTS8SLN1O0oZAoepsdeB5niM7vOMGclnYbLg9sIHQDhc/Z5E9Oz5USTaQzvSxCz6oxtW
         TxmBwIvvaem6z/nwACcCJnqe02TxeDkx2+P0gAsRt8sIpX9edLRRaki/7I5qwbL1CR/Z
         EemZFdefbA8N00+QQYJtiOXUUQ4iLl9sBXVMPjH6AFnmiyle86yLpJIFZdUM/egh3QCj
         0BW9bvVSzrWebrFu3thuq0w6cl6NXl5G1vMA3VQ5zVihU//GhRT2z6nslyexycsxaslL
         dVmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8AFvZy5IevjnVMOU6zN7P4dA9MmKNHlLYmheYvMwvVc=;
        b=Hcp+KFoL8S3QIscvrbzrsjpQ7Oa+XBASEmw7NmFgLsxXQ+0f8VqGrsBr0sHAnHkYN+
         RC3HEM46Zwnu6kBSuPikWea8ewFt+oRbbyW58zXT30uZeIc2Xx/wnxkfWaGofmrwsRGH
         B/i5yHsaVlXVZzNeMtNhRG3JDUkztU0XAZbzajFPkdIcduS8NmTLcwtayEF/rtehfoiz
         FvQV2BgSYDEb7uDDaq3D5IYY6VjLQ5r1DcEWTTO0NyaG8ZMDv/Msy0qAGjd/MzyYfc0B
         rWsgYzl3CG+3run71WCj1A/IOPTDihn97I7D/lYFdd2sHRtsibLDtC2FWnAVYsD5j6u8
         1siw==
X-Gm-Message-State: AOAM533q6z5dXG7gSu8f5ZBSxIt2Iit2mtzdjs2jL7QUzTGJsLX8cxVg
        gTEIwjxTJ/iV863/Ih3yxPZRos5ZQUTorqUGFWjkFQ==
X-Google-Smtp-Source: ABdhPJzUtnkqj+yNOhhOCy3e+1NMY2uMlUDSW/4qX+FAGO719KojfcgyijbDv+uhsfz5/UdMq0VYUDVav22eZQBYxMw=
X-Received: by 2002:a17:906:edb2:: with SMTP id sa18mr327438ejb.264.1607483209942;
 Tue, 08 Dec 2020 19:06:49 -0800 (PST)
MIME-Version: 1.0
References: <20201209002418.1976362-1-ben.widawsky@intel.com>
 <20201209002418.1976362-13-ben.widawsky@intel.com> <CAPcyv4gW8H1wNVDFhSt1SFbU=mcNZFKBve4xG24rGJaJg1wQZA@mail.gmail.com>
 <20201209020433.bzsuqudbgtpbtggk@intel.com>
In-Reply-To: <20201209020433.bzsuqudbgtpbtggk@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 8 Dec 2020 19:06:46 -0800
Message-ID: <CAPcyv4j5TWX9AquGcT=jKbyxHsaJOFNd26E7eEen0+fYoMuaQg@mail.gmail.com>
Subject: Re: [RFC PATCH 12/14] cxl: Add basic debugging
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

On Tue, Dec 8, 2020 at 6:04 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> On 20-12-08 17:17:36, Dan Williams wrote:
> > On Tue, Dec 8, 2020 at 4:24 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
> > >
> > > Provide a standard debug function for use throughout the driver.
> > >
> > > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > > ---
> > >  drivers/cxl/cxl.h |  3 +++
> > >  drivers/cxl/mem.c | 26 +++++++++++++++++++++++++-
> > >  2 files changed, 28 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > > index 77c2dee6843c..e5afb89dab0b 100644
> > > --- a/drivers/cxl/cxl.h
> > > +++ b/drivers/cxl/cxl.h
> > > @@ -9,6 +9,9 @@
> > >  #include <linux/bitops.h>
> > >  #include <linux/io.h>
> > >
> > > +#define cxl_debug(fmt, ...)                                                    \
> > > +       pr_debug("CXL DEBUG: %s: " fmt, __func__, ##__VA_ARGS__)
> > > +
> >
> > This should be dev_dbg(), then you don't need the CXL DEBUG prefix. In
> > fact you don't need a cxl_debug() macro at all in that case. cxl_mem
> > might need a ->dev attribute for this purpose.
> >
>
> I really like the ability to turn specific messages on and off at will. (FWIW,
> __func__ is also redundant because pr_debug allows you to specify a flag to
> always print the function name). While it's not very frequent events here, in
> the future it likely will be and I think it can be really helpful to be able to
> have that level of control.
>
> If you want to avoid creating a new debug functionality, I'm okay with that, but
> I'd really like to use pr_debug instead of dev_dbg for those messages going
> forward. Once you take that step, it seems giving contributors a macro named
> 'cxl_debug' so they don't have to figure out when to use what, makes sense. My
> mental separation is, dev_* is useful primarily for errors and initialization
> debug messaging, pr_debug/trace_printk is for runtime things.
>
> I probably should have put that in the commit message...

I suspect you haven't taken a look at the backed and of pr_debug() and
dev_dbg() in a while? They both use _dynamic_func_call and enjoy all
the benefits afforded by /sys/debug/dynamic_debug/control and the
"dyndbg" module option for adding __func__ and enable / disable by
line number or format message . pr_debug() and this cxl_debug() macro
are completely superseded by dev_dbg(). Even if a driver wanted a
common prefix on all prints there is the "#define dev_fmt ..."
mechanism for that.

>
> > >  #define CXL_SET_FIELD(value, field)                                            \
> > >         ({                                                                     \
> > >                 WARN_ON(!FIELD_FIT(field##_MASK, value));                      \
> > > diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> > > index a2cea7ac7cc6..6b2f8d3776b5 100644
> > > --- a/drivers/cxl/mem.c
> > > +++ b/drivers/cxl/mem.c
> > > @@ -122,9 +122,12 @@ static int cxl_mem_wait_for_doorbell(struct cxl_mem *cxlm)
> > >  {
> > >         const int timeout = msecs_to_jiffies(2000);
> > >         const unsigned long start = jiffies;
> > > +       unsigned long end = start;
> > >
> > >         while (cxl_doorbell_busy(cxlm)) {
> > > -               if (time_after(jiffies, start + timeout)) {
> > > +               end = jiffies;
> > > +
> > > +               if (time_after(end, start + timeout)) {
> > >                         /* Check again in case preempted before timeout test */
> > >                         if (!cxl_doorbell_busy(cxlm))
> > >                                 break;
> > > @@ -133,6 +136,8 @@ static int cxl_mem_wait_for_doorbell(struct cxl_mem *cxlm)
> > >                 cpu_relax();
> > >         }
> > >
> > > +       cxl_debug("Doorbell wait took %dms",
> > > +                 jiffies_to_msecs(end) - jiffies_to_msecs(start));
> > >         return 0;
> > >  }
> > >
> > > @@ -180,6 +185,8 @@ static int cxl_mem_mbox_send_cmd(struct cxl_mem *cxlm,
> > >         }
> > >
> > >         /* #4 */
> > > +       cxl_debug("Sending command to %s\n",
> > > +                 dev_driver_string(&cxlm->pdev->dev));
> >
> > dev_dbg() already includes dev_driver_string().
> >
> > >         cxl_write_mbox_reg32(cxlm, CXLDEV_MB_CTRL_OFFSET,
> > >                              CXLDEV_MB_CTRL_DOORBELL);
> > >
> > > @@ -308,6 +315,8 @@ static int cxl_mem_open(struct inode *inode, struct file *file)
> > >         if (!cxlmd)
> > >                 return -ENXIO;
> > >
> > > +       cxl_debug("Opened %pD\n", file);
> > > +
> > >         file->private_data = cxlmd;
> > >
> > >         return 0;
> > > @@ -383,6 +392,10 @@ static int handle_mailbox_cmd_from_user(struct cxl_memdev *cxlmd,
> > >                 .size_in = cmd->info.size_in,
> > >                 .size_out = size_out,
> > >         };
> > > +       cxl_debug("Submitting command for user\n"
> > > +                 "\topcode: %x\n"
> > > +                 "\tsize: %zub/%zub\n",
> > > +                 mbox_cmd.opcode, mbox_cmd.size_in, mbox_cmd.size_out);
> > >         rc = cxl_mem_mbox_send_cmd(cxlmd->cxlm, &mbox_cmd);
> > >         cxl_mem_mbox_put(cxlmd->cxlm);
> > >         if (rc)
> > > @@ -479,6 +492,8 @@ static long cxl_mem_ioctl(struct file *file, unsigned int cmd, unsigned long arg
> > >                 u32 n_commands;
> > >                 int i, j;
> > >
> > > +               cxl_debug("Query IOCTL\n");
> > > +
> > >                 if (get_user(n_commands, (u32 __user *)arg))
> > >                         return -EFAULT;
> > >
> > > @@ -511,6 +526,8 @@ static long cxl_mem_ioctl(struct file *file, unsigned int cmd, unsigned long arg
> > >                 struct cxl_mem_command c;
> > >                 int rc;
> > >
> > > +               cxl_debug("Send IOCTL\n");
> > > +
> > >                 rc = cxl_validate_cmd_from_user(u, &c);
> > >                 if (rc)
> > >                         return rc;
> > > @@ -843,6 +860,13 @@ static int cxl_mem_identify(struct cxl_mem *cxlm)
> > >
> > >         id = (struct cxl_mbox_identify *)mbox_cmd.payload;
> > >
> > > +       cxl_debug("Driver identify command\n"
> > > +                 "\tFirmware Version: %s\n"
> > > +                 "\tTotal Capacity: %llu (%llu persistent)\n"
> > > +                 "\tLSA size: %u\n",
> > > +                 id->fw_revision, id->total_capacity, id->persistent_capacity,
> > > +                 id->lsa_size);
> > > +
> >
> > Seems not necessary for details that are published in sysfs?
>
> I was thinking for cases where driver doesn't bind, seeing the identify
> information could be useful. This is one case where dev_dbg would also serve
> IMO.

There's very little that can cause bind failures after
cxl_mem_identify() succeeds. The bind failures themselves will
dev_err() the reason.
