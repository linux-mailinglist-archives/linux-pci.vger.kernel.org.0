Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 850F745D4A6
	for <lists+linux-pci@lfdr.de>; Thu, 25 Nov 2021 07:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347393AbhKYGWc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Nov 2021 01:22:32 -0500
Received: from mga05.intel.com ([192.55.52.43]:35508 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242820AbhKYGUb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 Nov 2021 01:20:31 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10178"; a="321687343"
X-IronPort-AV: E=Sophos;i="5.87,262,1631602800"; 
   d="scan'208";a="321687343"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2021 22:17:20 -0800
X-IronPort-AV: E=Sophos;i="5.87,262,1631602800"; 
   d="scan'208";a="554528873"
Received: from akushwa1-mobl1.amr.corp.intel.com (HELO intel.com) ([10.252.143.116])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2021 22:17:19 -0800
Date:   Wed, 24 Nov 2021 22:17:18 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH 04/23] cxl/pci: Implement Interface Ready Timeout
Message-ID: <20211125061718.xarzhrm7slyjybvv@intel.com>
References: <20211120000250.1663391-1-ben.widawsky@intel.com>
 <20211120000250.1663391-5-ben.widawsky@intel.com>
 <20211122150227.00000020@Huawei.com>
 <20211122171731.2hzsmspdhgw2wyqi@intel.com>
 <20211122175349.00007ced@Huawei.com>
 <CAPcyv4in8B1otPwRNiMQ4AFYETTm-miYbw3mMjDzx=jPqhvmAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4in8B1otPwRNiMQ4AFYETTm-miYbw3mMjDzx=jPqhvmAQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21-11-24 11:56:36, Dan Williams wrote:
> On Mon, Nov 22, 2021 at 9:54 AM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > On Mon, 22 Nov 2021 09:17:31 -0800
> > Ben Widawsky <ben.widawsky@intel.com> wrote:
> >
> > > On 21-11-22 15:02:27, Jonathan Cameron wrote:
> > > > On Fri, 19 Nov 2021 16:02:31 -0800
> > > > Ben Widawsky <ben.widawsky@intel.com> wrote:
> > > >
> > > > > The original driver implementation used the doorbell timeout for the
> > > > > Mailbox Interface Ready bit to piggy back off of, since the latter
> > > > > doesn't have a defined timeout. This functionality, introduced in
> > > > > 8adaf747c9f0 ("cxl/mem: Find device capabilities"), can now be improved
> > > > > since a timeout has been defined with an ECN to the 2.0 spec.
> > > > >
> > > > > While devices implemented prior to the ECN could have an arbitrarily
> > > > > long wait and still be within spec, the max ECN value (256s) is chosen
> > > > > as the default for all devices. All vendors in the consortium agreed to
> > > > > this amount and so it is reasonable to assume no devices made will
> > > > > exceed this amount.
> > > >
> > > > Optimistic :)
> > > >
> > >
> > > Reasonable to assume is certainly not the same as "in reality". I can soften
> > > this wording.
> > >
> > > > >
> > > > > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > > > > ---
> > > > > This patch did not exist in RFCv2
> > > > > ---
> > > > >  drivers/cxl/pci.c | 29 +++++++++++++++++++++++++++++
> > > > >  1 file changed, 29 insertions(+)
> > > > >
> > > > > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > > > > index 6c8d09fb3a17..2cef9fec8599 100644
> > > > > --- a/drivers/cxl/pci.c
> > > > > +++ b/drivers/cxl/pci.c
> > > > > @@ -2,6 +2,7 @@
> > > > >  /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
> > > > >  #include <linux/io-64-nonatomic-lo-hi.h>
> > > > >  #include <linux/module.h>
> > > > > +#include <linux/delay.h>
> > > > >  #include <linux/sizes.h>
> > > > >  #include <linux/mutex.h>
> > > > >  #include <linux/list.h>
> > > > > @@ -298,6 +299,34 @@ static int cxl_pci_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *c
> > > > >  static int cxl_pci_setup_mailbox(struct cxl_dev_state *cxlds)
> > > > >  {
> > > > >   const int cap = readl(cxlds->regs.mbox + CXLDEV_MBOX_CAPS_OFFSET);
> > > > > + unsigned long timeout;
> > > > > + u64 md_status;
> > > > > + int rc;
> > > > > +
> > > > > + /*
> > > > > +  * CXL 2.0 ECN "Add Mailbox Ready Time" defines a capability field to
> > > > > +  * dictate how long to wait for the mailbox to become ready. For
> > > > > +  * simplicity, and to handle devices that might have been implemented
> > > >
> > > > I'm not keen on the 'for simplicity' argument here.  If the device is advertising
> > > > a lower value, then that is what we should use.  It's fine to wait the max time
> > > > if nothing is specified.  It'll cost us a few lines of code at most unless
> > > > I am missing something...
> > > >
> > > > Jonathan
> > > >
> > >
> > > Let me pose it a different way, if a device advertises 1s, but for whatever
> > > takes 4s to come up, should we penalize it over the device advertising 256s?
> >
> > Yes, because it is buggy.  A compliance test should have failed on this anyway.
> >
> > > The
> > > way this field is defined in the spec would [IMHO] lead vendors to simply put
> > > the max field in there to game the driver, so why not start off with just
> > > insisting they don't?
> >
> > Given reading this value and getting a big number gives the implication that
> > the device is meant to be really slow to initialize, I'd expect that to push
> > vendors a little in the directly of putting realistic values in).
> >
> > Maybe we should print the value in the log to make them look silly ;)
> 
> A print message on the way to a static default timeout value is about
> all a device's self reported timeout is useful.
> 
> "device not ready after waiting %d seconds, continuing to wait up to %d seconds"
> 
> It's also not clear to me that the Linux default timeout should be so
> generous at 256 seconds. It might be suitable to just complain about
> devices that are taking more than 60 seconds to initialize with an
> option to override that timeout for odd outliers. Otherwise encourage
> hardware implementations to beat the Linux timeout value to get
> support out of the box.
> 
> I notice that not even libata waits more than a minute for a given
> device to finish post-reset shenanigans, so might as well set 60
> seconds as what the driver will tolerate out of the box.

60s is infinity, so 4x * infinity doesn't really make much difference does it
:P?

In my opinion if we're going to pick a limit, might as well tie it to a spec
definition rather than 60s.. Perhaps 60s has some relevance I'm unaware of, but
it seems equally arbitrary to me.
