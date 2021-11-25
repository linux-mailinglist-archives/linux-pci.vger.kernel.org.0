Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFB5E45D542
	for <lists+linux-pci@lfdr.de>; Thu, 25 Nov 2021 08:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348132AbhKYHSt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Nov 2021 02:18:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351365AbhKYHR0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Nov 2021 02:17:26 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B877C061757
        for <linux-pci@vger.kernel.org>; Wed, 24 Nov 2021 23:14:16 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id nh10-20020a17090b364a00b001a69adad5ebso5008904pjb.2
        for <linux-pci@vger.kernel.org>; Wed, 24 Nov 2021 23:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6+Ctcvzqgd82Eeo83/Mz3LR4ErS2sw37oXptlcEIdlM=;
        b=ZHPEbpV0/AhH2Yjy0G9Ne5HZNNENx2pCQGFlofl83dFwaz6ORSICDDGYfxzGv0L0Fk
         BFlPb1f+UYOtXWKwqjAMUCDBHJCre9QcSgtLM5EgSJiGckolLs9sJLhfMGO3bJfWu6oM
         yu8KAO6RWFGCQ9Sa5pNlo8QxVWDHZDQR13e1otLUm2ki1sliTq40erSAY5REyZf++LD1
         Lg2tFwZ241FYctEjjGKOL518ILEdqCxNCg7Ap+zj2+6Hd+xq+RSM44rjGrFO1C1qxvve
         exQ/IoFmQLAvXIZGSTA8RCoKEECjW/4msGDaijxUCZrYZCsOFhFX9VIFhUMysC1TY8mB
         OzaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6+Ctcvzqgd82Eeo83/Mz3LR4ErS2sw37oXptlcEIdlM=;
        b=w2FLGj4aF8IEpLwlrOVOnWBJifDhf9fbuTFiXySewz0d4zU2qtNDtQNqD96ySvu+kV
         qUAsQyF4Jfb9RoKMmrqneTxJzBO5vfH9fzh+fSnMT4npBLJCEUPl2P2fKhjgWQKli1j+
         Bd6A2eyiZBXB4XiYW6NVqdNbwbWXgd4EeyZet6roinuFEbHrJbNVbw7KPLbRSUQAkPYA
         bZb1LQFXLzOhn8v8mxqd5cvgsftmGUJa8bri1NX4kS+Ps7OxFtzW38X8i05lhwAhuTPX
         2XGO7T9UfGWeTcq0kbxfGBAZD6NSiAkqcnjYYpsxWdAMGZS8MFRbrXbTFzqAb7mtAb8t
         FjzA==
X-Gm-Message-State: AOAM530jM1gWewUs6HudrOxy8ND3WDFz1mEVbNZw8Jxs6uBT6NLCIZg5
        SurrmGzD76ZJG027T2fK7/Sqz7iI8wUm1VDzkMGGWQ==
X-Google-Smtp-Source: ABdhPJxsRuRgUioccZYLxDugX4rKvnPRYDk4yNP1g6RjHKQZb/B7KY883vmrAoigewMGPYmGvebgPqZj69umXtYT230=
X-Received: by 2002:a17:90b:1e49:: with SMTP id pi9mr4495429pjb.220.1637824455462;
 Wed, 24 Nov 2021 23:14:15 -0800 (PST)
MIME-Version: 1.0
References: <20211120000250.1663391-1-ben.widawsky@intel.com>
 <20211120000250.1663391-5-ben.widawsky@intel.com> <20211122150227.00000020@Huawei.com>
 <20211122171731.2hzsmspdhgw2wyqi@intel.com> <20211122175349.00007ced@Huawei.com>
 <CAPcyv4in8B1otPwRNiMQ4AFYETTm-miYbw3mMjDzx=jPqhvmAQ@mail.gmail.com> <20211125061718.xarzhrm7slyjybvv@intel.com>
In-Reply-To: <20211125061718.xarzhrm7slyjybvv@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 24 Nov 2021 23:14:04 -0800
Message-ID: <CAPcyv4h8a9HD8GPJVd07471s+6RmR77Gk4B4vjgPYOE3x2gDoQ@mail.gmail.com>
Subject: Re: [PATCH 04/23] cxl/pci: Implement Interface Ready Timeout
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 24, 2021 at 10:17 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> On 21-11-24 11:56:36, Dan Williams wrote:
> > On Mon, Nov 22, 2021 at 9:54 AM Jonathan Cameron
> > <Jonathan.Cameron@huawei.com> wrote:
> > >
> > > On Mon, 22 Nov 2021 09:17:31 -0800
> > > Ben Widawsky <ben.widawsky@intel.com> wrote:
> > >
> > > > On 21-11-22 15:02:27, Jonathan Cameron wrote:
> > > > > On Fri, 19 Nov 2021 16:02:31 -0800
> > > > > Ben Widawsky <ben.widawsky@intel.com> wrote:
> > > > >
> > > > > > The original driver implementation used the doorbell timeout for the
> > > > > > Mailbox Interface Ready bit to piggy back off of, since the latter
> > > > > > doesn't have a defined timeout. This functionality, introduced in
> > > > > > 8adaf747c9f0 ("cxl/mem: Find device capabilities"), can now be improved
> > > > > > since a timeout has been defined with an ECN to the 2.0 spec.
> > > > > >
> > > > > > While devices implemented prior to the ECN could have an arbitrarily
> > > > > > long wait and still be within spec, the max ECN value (256s) is chosen
> > > > > > as the default for all devices. All vendors in the consortium agreed to
> > > > > > this amount and so it is reasonable to assume no devices made will
> > > > > > exceed this amount.
> > > > >
> > > > > Optimistic :)
> > > > >
> > > >
> > > > Reasonable to assume is certainly not the same as "in reality". I can soften
> > > > this wording.
> > > >
> > > > > >
> > > > > > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > > > > > ---
> > > > > > This patch did not exist in RFCv2
> > > > > > ---
> > > > > >  drivers/cxl/pci.c | 29 +++++++++++++++++++++++++++++
> > > > > >  1 file changed, 29 insertions(+)
> > > > > >
> > > > > > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > > > > > index 6c8d09fb3a17..2cef9fec8599 100644
> > > > > > --- a/drivers/cxl/pci.c
> > > > > > +++ b/drivers/cxl/pci.c
> > > > > > @@ -2,6 +2,7 @@
> > > > > >  /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
> > > > > >  #include <linux/io-64-nonatomic-lo-hi.h>
> > > > > >  #include <linux/module.h>
> > > > > > +#include <linux/delay.h>
> > > > > >  #include <linux/sizes.h>
> > > > > >  #include <linux/mutex.h>
> > > > > >  #include <linux/list.h>
> > > > > > @@ -298,6 +299,34 @@ static int cxl_pci_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *c
> > > > > >  static int cxl_pci_setup_mailbox(struct cxl_dev_state *cxlds)
> > > > > >  {
> > > > > >   const int cap = readl(cxlds->regs.mbox + CXLDEV_MBOX_CAPS_OFFSET);
> > > > > > + unsigned long timeout;
> > > > > > + u64 md_status;
> > > > > > + int rc;
> > > > > > +
> > > > > > + /*
> > > > > > +  * CXL 2.0 ECN "Add Mailbox Ready Time" defines a capability field to
> > > > > > +  * dictate how long to wait for the mailbox to become ready. For
> > > > > > +  * simplicity, and to handle devices that might have been implemented
> > > > >
> > > > > I'm not keen on the 'for simplicity' argument here.  If the device is advertising
> > > > > a lower value, then that is what we should use.  It's fine to wait the max time
> > > > > if nothing is specified.  It'll cost us a few lines of code at most unless
> > > > > I am missing something...
> > > > >
> > > > > Jonathan
> > > > >
> > > >
> > > > Let me pose it a different way, if a device advertises 1s, but for whatever
> > > > takes 4s to come up, should we penalize it over the device advertising 256s?
> > >
> > > Yes, because it is buggy.  A compliance test should have failed on this anyway.
> > >
> > > > The
> > > > way this field is defined in the spec would [IMHO] lead vendors to simply put
> > > > the max field in there to game the driver, so why not start off with just
> > > > insisting they don't?
> > >
> > > Given reading this value and getting a big number gives the implication that
> > > the device is meant to be really slow to initialize, I'd expect that to push
> > > vendors a little in the directly of putting realistic values in).
> > >
> > > Maybe we should print the value in the log to make them look silly ;)
> >
> > A print message on the way to a static default timeout value is about
> > all a device's self reported timeout is useful.
> >
> > "device not ready after waiting %d seconds, continuing to wait up to %d seconds"
> >
> > It's also not clear to me that the Linux default timeout should be so
> > generous at 256 seconds. It might be suitable to just complain about
> > devices that are taking more than 60 seconds to initialize with an
> > option to override that timeout for odd outliers. Otherwise encourage
> > hardware implementations to beat the Linux timeout value to get
> > support out of the box.
> >
> > I notice that not even libata waits more than a minute for a given
> > device to finish post-reset shenanigans, so might as well set 60
> > seconds as what the driver will tolerate out of the box.
>
> 60s is infinity, so 4x * infinity doesn't really make much difference does it
> :P?

1 minute is half the hung task timeout in case something accidentally
did an uninterruptible sleep on probe completion event. 4 minutes is
on the order of what it takes a large server to boot. A single device
needs as much time as a server to boot?

> In my opinion if we're going to pick a limit, might as well tie it to a spec
> definition rather than 60s.. Perhaps 60s has some relevance I'm unaware of, but
> it seems equally arbitrary to me.

4 minutes just seems an unreasonable amount of time to wait to make a
decision that something is likely broken. If the industry actually
builds devices that nominally take multiple minutes to boot it's
already going to be in the realm of something custom in terms of
application expectations for when the server is ready. I'll buy you a
beverage of your choice if someone actually builds such a thing.
