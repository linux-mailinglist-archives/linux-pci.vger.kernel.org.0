Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFC9345CD92
	for <lists+linux-pci@lfdr.de>; Wed, 24 Nov 2021 20:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236178AbhKXT76 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Nov 2021 14:59:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234835AbhKXT75 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Nov 2021 14:59:57 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C56FC061574
        for <linux-pci@vger.kernel.org>; Wed, 24 Nov 2021 11:56:47 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id y7so2788620plp.0
        for <linux-pci@vger.kernel.org>; Wed, 24 Nov 2021 11:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7h1vFpWqDU2OtGi+/IyAAvPa60wlmNfJfmeOIcFNJas=;
        b=fZU5/O2Ljt1Sz3hEAyId/l093eSOYt/gB2NiOp6Big61hXRWlLdh8Q0h6Nv/HBl1Ab
         9W7LKxnc2Lvo0dSlegwrrzPDU9F2CJmRYv8hFejusk1/QA4kDdIvVBInswd/W7eaIXxq
         N6Hhs9pKo966YItoJH44ZftfZTtIIvHmQl2/s5NZAW5IeASJKz5h6LOin5Lstu8cobsx
         fP4YUOpv6CWx9+vizjkjz9cTG708XgGqv1BkqP2GVLKlmZRsy/+TEHO1RO1/D6Q447j1
         9iRVLSNlb8mqGiKC3CJjfbuQ26INyLu/18/Y6s8UKU8UX3HngtMRaBX4x+KSySLAocEm
         SJNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7h1vFpWqDU2OtGi+/IyAAvPa60wlmNfJfmeOIcFNJas=;
        b=qb0alMZ7rm/sxXzpkDarwUBKMCMp4ienJRkLbNAYvwWfI2EGAS7P/SulA9fTUBTxFE
         YrnXfK28Mf9pKBrZmsD4T0hjgQKKP/GhowGwRQluEJfOGzBOBpq57chHmQ3nxoGN6Ryp
         eM0IGVOwiZhPvkaIUm7WqZNMOxYKkf5puk/XdvPlco1AlbiTZBUts+1gEUkyp+gxx6tW
         Dq9WGLI4CuibJY6K8GRoQbLO5YOMxfUeIbTHLAOd9Tch9vUyDrIQpUli6ik6jpF8WCvi
         FFrEgcyJ35CBO0cZbNIQAZ5ZSMj40cFvmCEROEv9u+tRyzGbtcIVTBqHbu3nItBTscJZ
         is8w==
X-Gm-Message-State: AOAM530c5DvV+nhMxaH0eyJBVXt47lfI5JBgEOiiCD52VtL1GvjDwmYz
        ekSHmWXFPBdRWAhE5drU8c1lQR9+awMZ8jLLo42TmQ==
X-Google-Smtp-Source: ABdhPJwm4hikZT4Ncw6PgOI8xFXeBTXNrSc3e5vvgqHZ06VsiBRax46pSspRK5VStMh8R68zS7AtCrGoKa4Hqsd52Uc=
X-Received: by 2002:a17:90b:1e49:: with SMTP id pi9mr12278429pjb.220.1637783806957;
 Wed, 24 Nov 2021 11:56:46 -0800 (PST)
MIME-Version: 1.0
References: <20211120000250.1663391-1-ben.widawsky@intel.com>
 <20211120000250.1663391-5-ben.widawsky@intel.com> <20211122150227.00000020@Huawei.com>
 <20211122171731.2hzsmspdhgw2wyqi@intel.com> <20211122175349.00007ced@Huawei.com>
In-Reply-To: <20211122175349.00007ced@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 24 Nov 2021 11:56:36 -0800
Message-ID: <CAPcyv4in8B1otPwRNiMQ4AFYETTm-miYbw3mMjDzx=jPqhvmAQ@mail.gmail.com>
Subject: Re: [PATCH 04/23] cxl/pci: Implement Interface Ready Timeout
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>, linux-cxl@vger.kernel.org,
        Linux PCI <linux-pci@vger.kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 22, 2021 at 9:54 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Mon, 22 Nov 2021 09:17:31 -0800
> Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> > On 21-11-22 15:02:27, Jonathan Cameron wrote:
> > > On Fri, 19 Nov 2021 16:02:31 -0800
> > > Ben Widawsky <ben.widawsky@intel.com> wrote:
> > >
> > > > The original driver implementation used the doorbell timeout for the
> > > > Mailbox Interface Ready bit to piggy back off of, since the latter
> > > > doesn't have a defined timeout. This functionality, introduced in
> > > > 8adaf747c9f0 ("cxl/mem: Find device capabilities"), can now be improved
> > > > since a timeout has been defined with an ECN to the 2.0 spec.
> > > >
> > > > While devices implemented prior to the ECN could have an arbitrarily
> > > > long wait and still be within spec, the max ECN value (256s) is chosen
> > > > as the default for all devices. All vendors in the consortium agreed to
> > > > this amount and so it is reasonable to assume no devices made will
> > > > exceed this amount.
> > >
> > > Optimistic :)
> > >
> >
> > Reasonable to assume is certainly not the same as "in reality". I can soften
> > this wording.
> >
> > > >
> > > > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > > > ---
> > > > This patch did not exist in RFCv2
> > > > ---
> > > >  drivers/cxl/pci.c | 29 +++++++++++++++++++++++++++++
> > > >  1 file changed, 29 insertions(+)
> > > >
> > > > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > > > index 6c8d09fb3a17..2cef9fec8599 100644
> > > > --- a/drivers/cxl/pci.c
> > > > +++ b/drivers/cxl/pci.c
> > > > @@ -2,6 +2,7 @@
> > > >  /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
> > > >  #include <linux/io-64-nonatomic-lo-hi.h>
> > > >  #include <linux/module.h>
> > > > +#include <linux/delay.h>
> > > >  #include <linux/sizes.h>
> > > >  #include <linux/mutex.h>
> > > >  #include <linux/list.h>
> > > > @@ -298,6 +299,34 @@ static int cxl_pci_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *c
> > > >  static int cxl_pci_setup_mailbox(struct cxl_dev_state *cxlds)
> > > >  {
> > > >   const int cap = readl(cxlds->regs.mbox + CXLDEV_MBOX_CAPS_OFFSET);
> > > > + unsigned long timeout;
> > > > + u64 md_status;
> > > > + int rc;
> > > > +
> > > > + /*
> > > > +  * CXL 2.0 ECN "Add Mailbox Ready Time" defines a capability field to
> > > > +  * dictate how long to wait for the mailbox to become ready. For
> > > > +  * simplicity, and to handle devices that might have been implemented
> > >
> > > I'm not keen on the 'for simplicity' argument here.  If the device is advertising
> > > a lower value, then that is what we should use.  It's fine to wait the max time
> > > if nothing is specified.  It'll cost us a few lines of code at most unless
> > > I am missing something...
> > >
> > > Jonathan
> > >
> >
> > Let me pose it a different way, if a device advertises 1s, but for whatever
> > takes 4s to come up, should we penalize it over the device advertising 256s?
>
> Yes, because it is buggy.  A compliance test should have failed on this anyway.
>
> > The
> > way this field is defined in the spec would [IMHO] lead vendors to simply put
> > the max field in there to game the driver, so why not start off with just
> > insisting they don't?
>
> Given reading this value and getting a big number gives the implication that
> the device is meant to be really slow to initialize, I'd expect that to push
> vendors a little in the directly of putting realistic values in).
>
> Maybe we should print the value in the log to make them look silly ;)

A print message on the way to a static default timeout value is about
all a device's self reported timeout is useful.

"device not ready after waiting %d seconds, continuing to wait up to %d seconds"

It's also not clear to me that the Linux default timeout should be so
generous at 256 seconds. It might be suitable to just complain about
devices that are taking more than 60 seconds to initialize with an
option to override that timeout for odd outliers. Otherwise encourage
hardware implementations to beat the Linux timeout value to get
support out of the box.

I notice that not even libata waits more than a minute for a given
device to finish post-reset shenanigans, so might as well set 60
seconds as what the driver will tolerate out of the box.
