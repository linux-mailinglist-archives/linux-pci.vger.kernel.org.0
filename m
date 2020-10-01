Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EED0B280793
	for <lists+linux-pci@lfdr.de>; Thu,  1 Oct 2020 21:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730101AbgJATP6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Oct 2020 15:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729990AbgJATP5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Oct 2020 15:15:57 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA11C0613D0;
        Thu,  1 Oct 2020 12:15:57 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id f15so7368604ilj.2;
        Thu, 01 Oct 2020 12:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ykx0VFwBpOSHBUrfe0BcuppqQUC+bsqRCJaeyH9ESFI=;
        b=lJDTNAVtfXW4dpX/glZXNoudEQ2UjlPhI+J4RBsIyB+yTfGCIJUYuxthMM/gXkFeqs
         8Jobetyt/iwoDTmLhqn140BKV/0rqjsR72m6fX9X7QgbDz5xiyoESVj6gzvMWIoFFEX4
         klRq4m6MdlsB/APoX2+PA8eH+/04k5GNSoO9DPrQiqAXTBQOO16+NH/mgmXp5G7Y+Y71
         iKxCP3yrG0+8BCNTRxio46C297qeW0GbZUuL7VEywpRXJBRkw38x9bynG4OAN+A5PEm3
         oOLoB4RQt5EXNFfWLK0ev7JsMJ2pai3M4Vgi5epjSJfYPDsVqNLUccwi00Jvnmet0bGI
         jLfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ykx0VFwBpOSHBUrfe0BcuppqQUC+bsqRCJaeyH9ESFI=;
        b=XRnNM7O2qg+iOptg9Zn6Xe5UnBA6fADAbPRroRqll+rQhgahZ+3K+WF85an5zxF3it
         LE71mymf4loYeWn/wv6sP340gPbrwKCgEKZCiTcN7ZwvWAx6wykt5B3oPsSaJUI2q9Gu
         6i3SX1iR6lv96QnTbjM5oKcF1Z6z9NsE/1PjQxdT/CnOQVPzgp6+zUBsagyjSRPfrOEO
         Csb0xT9eMh+b+u/+N+Z6pWYo/zxYCTD50I9UTZLIpDkakAPIIemSEE7WNKMXeYo44LA1
         xpEAp0KQq0WNE5nib51KDepwsgaE0rg8WvsT6/QVKmC0LHFh48BtAMF2rt8BsZASxDfy
         n6SA==
X-Gm-Message-State: AOAM530+l+BzUQK5OjleBW2yZb/uqpdSYvvraJ9hI8K255+KhiUU8Q9P
        eQa+w038+IhnqzO0DMdC69RWGon/3Qb56/UGRtc=
X-Google-Smtp-Source: ABdhPJxFJi5WSCLD+Qt6CIeP5jNGPGVedcVJlffgzPTE0dhx/wokQd56dVKG7pixc+H4Zw9OZKeVHwsqKyI6YKdfhwU=
X-Received: by 2002:a92:950d:: with SMTP id y13mr3778828ilh.42.1601579756833;
 Thu, 01 Oct 2020 12:15:56 -0700 (PDT)
MIME-Version: 1.0
References: <20201001014250.26987-1-david.e.box@linux.intel.com>
 <20201001014250.26987-6-david.e.box@linux.intel.com> <CAHp75VcP58Ub=gmbRVy0TPJtntKvnQZoi3tOakxE0qsEqzGPVA@mail.gmail.com>
 <CAKgT0Udk4ZdtAisB=edcUfnBqwNFtY8K54CF+9yEF6MZL1Th6Q@mail.gmail.com> <CAHp75VcfdHWCxMcHvEoO4yTGXooX=mbc-m2kOOuBmFn-FZ70DQ@mail.gmail.com>
In-Reply-To: <CAHp75VcfdHWCxMcHvEoO4yTGXooX=mbc-m2kOOuBmFn-FZ70DQ@mail.gmail.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Thu, 1 Oct 2020 12:15:45 -0700
Message-ID: <CAKgT0UdaYzOqtSi4+8GW1Y1pRWiOud1vRPhdMjpDZTS9goxe0g@mail.gmail.com>
Subject: Re: [PATCH V7 5/5] platform/x86: Intel PMT Crashlog capability driver
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "David E. Box" <david.e.box@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 1, 2020 at 11:47 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Thu, Oct 1, 2020 at 9:33 PM Alexander Duyck
> <alexander.duyck@gmail.com> wrote:
> > On Thu, Oct 1, 2020 at 9:37 AM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Thu, Oct 1, 2020 at 4:43 AM David E. Box <david.e.box@linux.intel.com> wrote:
>
> ...
>
> > Arguably not much. I'll drop the comment.
> >
> > > > +       control &= ~(CRASHLOG_FLAG_MASK | CRASHLOG_FLAG_DISABLE);
> > >
> > > How does the second constant play any role here?
> >
> > The "control" flags are bits 28-31, while the disable flag is bit 27
> > if I recall.
>
> Okay, then it adds more confusion to the same comment here and there.
> Good you are about to drop the comment.
>
> > Specifically bit 31 is read only, bit 28 will clear bit 31, bit 29
> > will cause the crashlog to be generated and set bit 31, and bit 30 is
> > just reserved 0.
>
> Can this be added as a comment somewhere in the code?

I'll do that with the definitions themselves.

> ...
>
> > > > +       ret = intel_pmt_dev_create(entry, &pmt_crashlog_ns, parent);
> > > > +       if (!ret)
> > > > +               return 0;
>
> (2)
>
> > > > +
> > > > +       dev_err(parent, "Failed to add crashlog controls\n");
> > > > +       intel_pmt_dev_destroy(entry, &pmt_crashlog_ns);
> > > > +
> > > > +       return ret;
> > >
> > > Can we use traditional patterns?
> > > if (ret) {
> > >   ...
> > > }
> > > return ret;
> >
> > I can switch it if that is preferred.
>
> Yes, please. The (2) is really hard to parse (easy to miss ! part and
> be confused by return 0 one).
>
> ...
>
> > > Are you going to duplicate this in each driver? Consider to refactor
> > > to avoid duplication of a lot of code.
> >
> > So the issue lies in the complexity of pmt_telem_add_entry versus
> > pmt_crashlog_add_entry. Specifically I end up needing disc_res and the
> > discovery table when I go to create the controls for the crashlog
> > device. Similarly we have a third device that we plan to add called a
> > watcher which will require us to keep things split up like this so we
> > thought it best to split it up this way.
>
> Could you revisit and think how this can be deduplicated. I see at
> least one variant with a hooks (callbacks) which you supply depending
> on the driver, but the for-loop is kept in one place.

I'll see what I can do.

> ...
>
> > > > +               .name   = DRV_NAME,
> > >
> > > > +MODULE_ALIAS("platform:" DRV_NAME);
> > >
> > > I'm not sure I have interpreted this:
> > >         - Use 'raw' string instead of defines for device names
> > > correctly. Can you elaborate?
> >
> > Again I am not sure what this is in reference to. If you can point me
> > to some documentation somewhere I can take a look.
>
> Reference to your own changelog of this series!

So the issue is we have two authors so it is a matter of keeping track
of who is working on what.

So apparently that was in reference to the MFD driver which was
instantiating the devices using defines and there was only one spot
where they were being used. The reason why I was confused is because
the commit message had nothing to do with this patch and it I haven't
really done any work on the MFD driver myself. The link to the 'raw'
discussion can be found here:
https://lore.kernel.org/lkml/20200728075859.GH1850026@dell/
