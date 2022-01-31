Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6694A532B
	for <lists+linux-pci@lfdr.de>; Tue,  1 Feb 2022 00:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbiAaXZJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Jan 2022 18:25:09 -0500
Received: from mga11.intel.com ([192.55.52.93]:9145 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229519AbiAaXZJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 31 Jan 2022 18:25:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643671509; x=1675207509;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1vDoarDPWwF0kZS0T6AI+s35dInLmtiPrhZoO0Wd/vc=;
  b=nNcf+5SIE9DOfW3YiZaXtxraLy2UHyRaMCNGkr4o+KkCo7wd/XVRTZOv
   Xy045P3ohjzz7BisMm1keImubmdVCiXlp0umvivZi9HEbZqUwZdN41ZX0
   Rn9N2hkwQJWOKjEC9sxMvlG54oZaXmSkgVldwUKW/OS98r6trK1sg2mb2
   LIN+C69tS6vuYKvobcppOkaSv6Rhy/4UEo59tm2Wwl1TPFYZzKDqaTf0G
   hkyfClUI8o/pY1BmZWxifTn7z580YV2qQmVj+zVwR8fp7kCENP78ykDVr
   7tooCU0YKlg6hYY5+s5gtc2yvNKgmMDmNh13mSrlZkGMj73yVjFcIrDJJ
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="245165181"
X-IronPort-AV: E=Sophos;i="5.88,332,1635231600"; 
   d="scan'208";a="245165181"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 15:25:09 -0800
X-IronPort-AV: E=Sophos;i="5.88,332,1635231600"; 
   d="scan'208";a="522839637"
Received: from sssheth-mobl1.amr.corp.intel.com (HELO intel.com) ([10.252.130.247])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 15:25:08 -0800
Date:   Mon, 31 Jan 2022 15:25:07 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>
Subject: Re: [PATCH v3 02/40] cxl/pci: Implement Interface Ready Timeout
Message-ID: <20220131232507.jz4tsjk4uzcunnre@intel.com>
References: <164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com>
 <164298412919.3018233.12491722885382120190.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20220131222101.tckwbcxheuuorkiq@intel.com>
 <CAPcyv4gGMsUbJ=Cu8U0B2Znz6+jE6PcDCALNfxJzvAHZZccVvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4gGMsUbJ=Cu8U0B2Znz6+jE6PcDCALNfxJzvAHZZccVvQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 22-01-31 15:11:05, Dan Williams wrote:
> On Mon, Jan 31, 2022 at 2:21 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
> >
> > On 22-01-23 16:28:49, Dan Williams wrote:
> > > From: Ben Widawsky <ben.widawsky@intel.com>
> > >
> > > The original driver implementation used the doorbell timeout for the
> > > Mailbox Interface Ready bit to piggy back off of, since the latter does
> > > not have a defined timeout. This functionality, introduced in commit
> > > 8adaf747c9f0 ("cxl/mem: Find device capabilities"), needs improvement as
> > > the recent "Add Mailbox Ready Time" ECN timeout indicates that the
> > > mailbox ready time can be significantly longer that 2 seconds.
> > >
> > > While the specification limits the maximum timeout to 256s, the cxl_pci
> > > driver gives up on the mailbox after 60s. This value corresponds with
> > > important timeout values already present in the kernel. A module
> > > parameter is provided as an emergency override and represents the
> > > default Linux policy for all devices.
> > >
> > > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > [djbw: add modparam, drop check_device_status()]
> > > Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > > ---
> > >  drivers/cxl/pci.c |   35 +++++++++++++++++++++++++++++++++++
> > >  1 file changed, 35 insertions(+)
> > >
> > > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > > index 8dc91fd3396a..ed8de9eac970 100644
> > > --- a/drivers/cxl/pci.c
> > > +++ b/drivers/cxl/pci.c
> > > @@ -1,7 +1,9 @@
> > >  // SPDX-License-Identifier: GPL-2.0-only
> > >  /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
> > >  #include <linux/io-64-nonatomic-lo-hi.h>
> > > +#include <linux/moduleparam.h>
> > >  #include <linux/module.h>
> > > +#include <linux/delay.h>
> > >  #include <linux/sizes.h>
> > >  #include <linux/mutex.h>
> > >  #include <linux/list.h>
> > > @@ -35,6 +37,20 @@
> > >  /* CXL 2.0 - 8.2.8.4 */
> > >  #define CXL_MAILBOX_TIMEOUT_MS (2 * HZ)
> > >
> > > +/*
> > > + * CXL 2.0 ECN "Add Mailbox Ready Time" defines a capability field to
> > > + * dictate how long to wait for the mailbox to become ready. The new
> > > + * field allows the device to tell software the amount of time to wait
> > > + * before mailbox ready. This field per the spec theoretically allows
> > > + * for up to 255 seconds. 255 seconds is unreasonably long, its longer
> > > + * than the maximum SATA port link recovery wait. Default to 60 seconds
> > > + * until someone builds a CXL device that needs more time in practice.
> > > + */
> > > +static unsigned short mbox_ready_timeout = 60;
> > > +module_param(mbox_ready_timeout, ushort, 0600);
> >
> > Any reason not to make it 0644?
> >
> 
> Are there any tooling scenarios where this information is usable by non-root?

Just for ease of debug. If I get a bug report with this, first thing I'm going
to do is ask for the timeout value. Perhaps it's expected the person who filed
the bug will have root access.

> 
> > > +MODULE_PARM_DESC(mbox_ready_timeout,
> > > +              "seconds to wait for mailbox ready status");
> > > +
> > >  static int cxl_pci_mbox_wait_for_doorbell(struct cxl_dev_state *cxlds)
> > >  {
> > >       const unsigned long start = jiffies;
> > > @@ -281,6 +297,25 @@ static int cxl_pci_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *c
> > >  static int cxl_pci_setup_mailbox(struct cxl_dev_state *cxlds)
> > >  {
> > >       const int cap = readl(cxlds->regs.mbox + CXLDEV_MBOX_CAPS_OFFSET);
> > > +     unsigned long timeout;
> > > +     u64 md_status;
> > > +
> > > +     timeout = jiffies + mbox_ready_timeout * HZ;
> > > +     do {
> > > +             md_status = readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
> > > +             if (md_status & CXLMDEV_MBOX_IF_READY)
> > > +                     break;
> > > +             if (msleep_interruptible(100))
> > > +                     break;
> > > +     } while (!time_after(jiffies, timeout));
> >
> > Just pointing out the [probably] obvious. If the user specifies a zero second
> > timeout, the code will still wait 100ms.
> 
> Sure, is that going to be a problem in practice? I expect the
> overwhelming common case is that the mailbox is already ready by this
> point, so it's a zero-wait.
> 

No problem I can see in practice.

> >
> > > +
> > > +     if (!(md_status & CXLMDEV_MBOX_IF_READY)) {
> > > +             dev_err(cxlds->dev,
> > > +                     "timeout awaiting mailbox ready, device state:%s%s\n",
> > > +                     md_status & CXLMDEV_DEV_FATAL ? " fatal" : "",
> > > +                     md_status & CXLMDEV_FW_HALT ? " firmware-halt" : "");
> > > +             return -EIO;
> > > +     }
> > >
> > >       cxlds->mbox_send = cxl_pci_mbox_send;
> > >       cxlds->payload_size =
> > >
