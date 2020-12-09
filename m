Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 674922D3892
	for <lists+linux-pci@lfdr.de>; Wed,  9 Dec 2020 03:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbgLICFR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Dec 2020 21:05:17 -0500
Received: from mga05.intel.com ([192.55.52.43]:1226 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726311AbgLICFR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Dec 2020 21:05:17 -0500
IronPort-SDR: ZHcsU2dswODrr0lkU6OXRykTsXod43gWKKw1doJBaMgn023gyO2w8e6QvefvZvtYDlzVQhULly
 n4UsVb0+Qptg==
X-IronPort-AV: E=McAfee;i="6000,8403,9829"; a="258713491"
X-IronPort-AV: E=Sophos;i="5.78,404,1599548400"; 
   d="scan'208";a="258713491"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2020 18:04:36 -0800
IronPort-SDR: pEF+4jwnPNNPZXCpXf8tnJ+XSDoPyC8r0uGqcsoJNwzexXjimlnjSlv+yS+bBbFAeqr/ZV8Ik0
 wcbmwj8smCvQ==
X-IronPort-AV: E=Sophos;i="5.78,404,1599548400"; 
   d="scan'208";a="437608882"
Received: from mlubyani-mobl2.amr.corp.intel.com (HELO intel.com) ([10.252.137.9])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2020 18:04:35 -0800
Date:   Tue, 8 Dec 2020 18:04:33 -0800
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
Subject: Re: [RFC PATCH 12/14] cxl: Add basic debugging
Message-ID: <20201209020433.bzsuqudbgtpbtggk@intel.com>
References: <20201209002418.1976362-1-ben.widawsky@intel.com>
 <20201209002418.1976362-13-ben.widawsky@intel.com>
 <CAPcyv4gW8H1wNVDFhSt1SFbU=mcNZFKBve4xG24rGJaJg1wQZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4gW8H1wNVDFhSt1SFbU=mcNZFKBve4xG24rGJaJg1wQZA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 20-12-08 17:17:36, Dan Williams wrote:
> On Tue, Dec 8, 2020 at 4:24 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
> >
> > Provide a standard debug function for use throughout the driver.
> >
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > ---
> >  drivers/cxl/cxl.h |  3 +++
> >  drivers/cxl/mem.c | 26 +++++++++++++++++++++++++-
> >  2 files changed, 28 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index 77c2dee6843c..e5afb89dab0b 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -9,6 +9,9 @@
> >  #include <linux/bitops.h>
> >  #include <linux/io.h>
> >
> > +#define cxl_debug(fmt, ...)                                                    \
> > +       pr_debug("CXL DEBUG: %s: " fmt, __func__, ##__VA_ARGS__)
> > +
> 
> This should be dev_dbg(), then you don't need the CXL DEBUG prefix. In
> fact you don't need a cxl_debug() macro at all in that case. cxl_mem
> might need a ->dev attribute for this purpose.
> 

I really like the ability to turn specific messages on and off at will. (FWIW,
__func__ is also redundant because pr_debug allows you to specify a flag to
always print the function name). While it's not very frequent events here, in
the future it likely will be and I think it can be really helpful to be able to
have that level of control.

If you want to avoid creating a new debug functionality, I'm okay with that, but
I'd really like to use pr_debug instead of dev_dbg for those messages going
forward. Once you take that step, it seems giving contributors a macro named
'cxl_debug' so they don't have to figure out when to use what, makes sense. My
mental separation is, dev_* is useful primarily for errors and initialization
debug messaging, pr_debug/trace_printk is for runtime things.

I probably should have put that in the commit message...

> >  #define CXL_SET_FIELD(value, field)                                            \
> >         ({                                                                     \
> >                 WARN_ON(!FIELD_FIT(field##_MASK, value));                      \
> > diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> > index a2cea7ac7cc6..6b2f8d3776b5 100644
> > --- a/drivers/cxl/mem.c
> > +++ b/drivers/cxl/mem.c
> > @@ -122,9 +122,12 @@ static int cxl_mem_wait_for_doorbell(struct cxl_mem *cxlm)
> >  {
> >         const int timeout = msecs_to_jiffies(2000);
> >         const unsigned long start = jiffies;
> > +       unsigned long end = start;
> >
> >         while (cxl_doorbell_busy(cxlm)) {
> > -               if (time_after(jiffies, start + timeout)) {
> > +               end = jiffies;
> > +
> > +               if (time_after(end, start + timeout)) {
> >                         /* Check again in case preempted before timeout test */
> >                         if (!cxl_doorbell_busy(cxlm))
> >                                 break;
> > @@ -133,6 +136,8 @@ static int cxl_mem_wait_for_doorbell(struct cxl_mem *cxlm)
> >                 cpu_relax();
> >         }
> >
> > +       cxl_debug("Doorbell wait took %dms",
> > +                 jiffies_to_msecs(end) - jiffies_to_msecs(start));
> >         return 0;
> >  }
> >
> > @@ -180,6 +185,8 @@ static int cxl_mem_mbox_send_cmd(struct cxl_mem *cxlm,
> >         }
> >
> >         /* #4 */
> > +       cxl_debug("Sending command to %s\n",
> > +                 dev_driver_string(&cxlm->pdev->dev));
> 
> dev_dbg() already includes dev_driver_string().
> 
> >         cxl_write_mbox_reg32(cxlm, CXLDEV_MB_CTRL_OFFSET,
> >                              CXLDEV_MB_CTRL_DOORBELL);
> >
> > @@ -308,6 +315,8 @@ static int cxl_mem_open(struct inode *inode, struct file *file)
> >         if (!cxlmd)
> >                 return -ENXIO;
> >
> > +       cxl_debug("Opened %pD\n", file);
> > +
> >         file->private_data = cxlmd;
> >
> >         return 0;
> > @@ -383,6 +392,10 @@ static int handle_mailbox_cmd_from_user(struct cxl_memdev *cxlmd,
> >                 .size_in = cmd->info.size_in,
> >                 .size_out = size_out,
> >         };
> > +       cxl_debug("Submitting command for user\n"
> > +                 "\topcode: %x\n"
> > +                 "\tsize: %zub/%zub\n",
> > +                 mbox_cmd.opcode, mbox_cmd.size_in, mbox_cmd.size_out);
> >         rc = cxl_mem_mbox_send_cmd(cxlmd->cxlm, &mbox_cmd);
> >         cxl_mem_mbox_put(cxlmd->cxlm);
> >         if (rc)
> > @@ -479,6 +492,8 @@ static long cxl_mem_ioctl(struct file *file, unsigned int cmd, unsigned long arg
> >                 u32 n_commands;
> >                 int i, j;
> >
> > +               cxl_debug("Query IOCTL\n");
> > +
> >                 if (get_user(n_commands, (u32 __user *)arg))
> >                         return -EFAULT;
> >
> > @@ -511,6 +526,8 @@ static long cxl_mem_ioctl(struct file *file, unsigned int cmd, unsigned long arg
> >                 struct cxl_mem_command c;
> >                 int rc;
> >
> > +               cxl_debug("Send IOCTL\n");
> > +
> >                 rc = cxl_validate_cmd_from_user(u, &c);
> >                 if (rc)
> >                         return rc;
> > @@ -843,6 +860,13 @@ static int cxl_mem_identify(struct cxl_mem *cxlm)
> >
> >         id = (struct cxl_mbox_identify *)mbox_cmd.payload;
> >
> > +       cxl_debug("Driver identify command\n"
> > +                 "\tFirmware Version: %s\n"
> > +                 "\tTotal Capacity: %llu (%llu persistent)\n"
> > +                 "\tLSA size: %u\n",
> > +                 id->fw_revision, id->total_capacity, id->persistent_capacity,
> > +                 id->lsa_size);
> > +
> 
> Seems not necessary for details that are published in sysfs?

I was thinking for cases where driver doesn't bind, seeing the identify
information could be useful. This is one case where dev_dbg would also serve
IMO.
