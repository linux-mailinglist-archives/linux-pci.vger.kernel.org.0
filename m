Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD26037FFC0
	for <lists+linux-pci@lfdr.de>; Thu, 13 May 2021 23:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233424AbhEMVV6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 May 2021 17:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbhEMVV6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 May 2021 17:21:58 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C2DC06174A
        for <linux-pci@vger.kernel.org>; Thu, 13 May 2021 14:20:47 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id f18so5088997qko.7
        for <linux-pci@vger.kernel.org>; Thu, 13 May 2021 14:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wZOK6jXFL4VfBbxRN3Gyol/GRGXYnH9ZqWZPQUCK/vU=;
        b=ERkTalcomV8g7CELNOWW17v3v60GnywD0RuQQ8oBJ6B7gDiopk5H0G7jw0Ttr+7Nr+
         q2FV6BSS8CZlnfI6q6/TE1a8E1ODsZyZlr/V2M9wPQNqX3nlwCrXbIWPeQy2FGERWMyO
         OCZFuG1ljrenAXOfMgETMJt49ucnmzm5g/Tol4E0y9JTvPZlQWkyxq60WbhVwUAO5Eod
         OZvID5vf4fBVZuGxwFM759PMwRIhL873+8P/lFfq9cbDMbd3LD4apn/dxbNdgvEy5gGW
         QEk6P5QmmjpEd4XuChtTtG9enk0GiPSZxdv9Q320cVodCmU+cNzncKLw7Gyux7o9O/Do
         8WAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wZOK6jXFL4VfBbxRN3Gyol/GRGXYnH9ZqWZPQUCK/vU=;
        b=mYxt5jTdRM1AFulhZx5yIGLe3V8un+gBMK0SEjDmjHs7Yvy9FKryPko7BzQg3OcpRU
         y7pJ6alMxXFoniY9Lib2Yujq+2a1EzAPtczw0L6FS18Mxgj6OIBTmkgwP1f1fuV0o2v0
         QiAzcQxi/p89JkQ5ruPlh61bzl5gb2oZhHpSuRKLovhj4CfaGdVW+t4+NGJ1gqmRaWGn
         ObVL6LzADC61JDDrkNjdfPRPj8bOO8KlEL1WeVacN5TFdvwXmAQFsG6RodPXVxvaK7Ty
         l6n+PnId7nq1yszJZQjNWraQnIaF4BUf4O2YxtSLgS/2V2Jd1BAhBEOP6gnopc+DbCXz
         5vMA==
X-Gm-Message-State: AOAM531aMn20V7qWTqYOzifFYiUa3hCithomRpWTosNeuFwvdLSgdfbe
        e5is2KEpWVdJdjv4yYeovz8a96DDxlXEr03Qaaf4eQ==
X-Google-Smtp-Source: ABdhPJwkbwB6YVFBA0WjvHiJYl4N52PwXiqS9Yp4AlhIHVu3P1oMq6b0rAsfiy2G+Z/T0mvYFOZVEoSlj+ZZ2dnU7rc=
X-Received: by 2002:a37:7d41:: with SMTP id y62mr40748866qkc.8.1620940847158;
 Thu, 13 May 2021 14:20:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210419165451.2176200-1-Jonathan.Cameron@huawei.com>
 <20210419165451.2176200-3-Jonathan.Cameron@huawei.com> <20210506215934.GJ1904484@iweiny-DESK2.sc.intel.com>
 <20210511175006.00007861@Huawei.com>
In-Reply-To: <20210511175006.00007861@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 13 May 2021 14:20:38 -0700
Message-ID: <CAPcyv4j=uww+85b4AbWmoPNPry_+JLEpEnuywpdC8PonXmRmEg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 2/4] PCI/doe: Add Data Object Exchange support
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Chris Browy <cbrowy@avery-design.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Linuxarm <linuxarm@huawei.com>, Fangjian <f.fangjian@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 11, 2021 at 9:52 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Thu, 6 May 2021 14:59:34 -0700
> Ira Weiny <ira.weiny@intel.com> wrote:
>
> > On Tue, Apr 20, 2021 at 12:54:49AM +0800, Jonathan Cameron wrote:
> > > +
> > > +static int pci_doe_send_req(struct pci_doe *doe, struct pci_doe_exchange *ex)
> > > +{
> > > +   struct pci_dev *pdev = doe->pdev;
> > > +   u32 val;
> > > +   int i;
> > > +
> > > +   /*
> > > +    * Check the DOE busy bit is not set. If it is set, this could indicate
> > > +    * someone other than Linux (e.g. firmware) is using the mailbox. Note
> > > +    * it is expected that firmware and OS will negotiate access rights via
> > > +    * an, as yet to be defined method.
> > > +    */
> > > +   pci_read_config_dword(pdev, doe->cap + PCI_DOE_STATUS, &val);
> > > +   if (FIELD_GET(PCI_DOE_STATUS_BUSY, val))
> > > +           return -EBUSY;
> >
> > In discussion with Dan we believe that user space could also be issuing
> > commands and would potentially cause us to be locked out.
> >
> > We agree that firmware should be out of the way here and if it is blocking
> > the OS there is not much we can do about it.
> >
> > However, if user space is using the mailbox we need to synchronize with them
> > via pci_cfg_access_[try]lock().  This should avoid this EBUSY condition.
>
> Hi Ira, thanks for taking a look.
>
> So the question here is whether we can ever safely work with a
> userspace that is accessing the DOE.  I think the answer is no we can't.
>
> We'd have no way of knowing that userspace left the DOE in a clean state
> without resetting every time we want to use it (which can take 1 second)
> or doing significant sanity checking (can we tell if something is
> in flight?).  Note that if userspace and kernel were talking different
> protocols nothing sensible could be done to prevent them receiving each
> other's answers (unless you can rely on userspace holding the lock until
> it is done - which you can't as who trusts userspace?)

There is no ability for userpsace to lock out the kernel, only kernel
locking out userspace.

> You could do
> something horrible like back off after peeking at the protocol to see
> if it might be yours, but even that only works assuming the two are
> trying to talk different protocols (talking the same protocol isn't allowed
> but no way to enforce that using just pci_cfg_access_lock()).

Wait why isn't pci_cfg_access_lock() sufficient? The userspace DOE
transfer is halted, the kernel validates the state of DOE, does it's
work and releases the lock.

> I can't see a way to tell that the DOE might not have responded to an
> earlier request.  DOE busy indicates the write mailbox register cannot
> receive data at the moment.  If it's set then there is a message in
> flight, but if it is not set there might still be a message in flight.
> Busy only indicates if the write mailbox register can sink a request
> which doesn't in general tell us anything about the underlying state.
>
> So if userspace sent a request then quit.  Kernel driver would have
> no way of knowing if the next response was due to the request it sent
> or some earlier one (other than matching IDs)  Note you aren't allowed
> to have multiple requests for a single protocol in flight at the same
> time.  With just a lock you would have no way of preventing this.
>
> So we are back to every request the kernel sent having to be proceeded
> by an abort and potentially a 1 second delay whilst some chunk of the
> device firmware reboots.
>
> This came up in dicussion when Dan proposed the patch
> [PATCH] PCI: Allow drivers to claim exclusive access to config regions
> https://lore.kernel.org/linux-pci/161663543465.1867664.5674061943008380442.stgit@dwillia2-desk3.amr.corp.intel.com/
> Summarizing outcome of that thread.
>
> 1) Reads of DOE registers are always safe, so we shouldn't stop lspci
> and similar accessing config space.
> 2) You are on your own if any userspace writes to pci config space.
> There are loads of ways it can break the system so it doesn't make much
> sense to protect against one more.

I'm not quite as enthusiastic about Greg's assertion that "we're
already broken why not allow more breakage" as he was also the one
supportive of /dev/mem restrictions in the face of obvious collisions.
I'll circle back and say as much to Greg. My mistake was not realizing
the write dependency in the protocol, so the pushback was warranted
that the kernel does not need to block out all access.

Given that /dev/mem is optionally disabled for userspace access
outside of kernel-lockdown scenarios, I think it is reasonable to have
the kernel disable config writes to a register block and the request
of a driver.

Consider that userspace can certainly trash the system by writing to
the BAR registers, for example, but a non-malicious userspace has no
reason to do that. Unfortunately DOE has some utility for a
non-malicious userspace to access so there is a rationale to figure
out a cooperation scheme.

>
> If there is a reason to provide a userspace interface to a DOE for a
> device with a driver attached, then I would agree with Dan's suggestion
> to use a proper driver for it.
>
> Dan briefly mentioned that temporary blocking might be needed. I'm guessing
> that was to try and let userspace safely use the DOE.
>
> The driver would work fine ignoring busy entirely and would perhaps be
> less confusing as a result.  We reset the DOE at startup anyway and that
> would clear existing busy.  Any future times busy is set would have no
> impact on the flow.

If it simplifies the kernel implementation to assume single
kernel-initiator then I think that's more than enough reason to block
out userspace, and/or provide userspace a method to get into the
kernel's queue for service.
