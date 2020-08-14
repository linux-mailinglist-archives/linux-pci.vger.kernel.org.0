Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C36D3244C7A
	for <lists+linux-pci@lfdr.de>; Fri, 14 Aug 2020 18:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbgHNQKH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Aug 2020 12:10:07 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40847 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbgHNQKF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Aug 2020 12:10:05 -0400
Received: by mail-oi1-f195.google.com with SMTP id u24so7440144oic.7;
        Fri, 14 Aug 2020 09:10:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qdCjDq31doyX8Aqxb7SZq+w4kNLQ/3yNp483eCCGJy8=;
        b=TkJaL1YG8SOv4kPCUvi/TXnjRPR4xrJcxHFIAvLzUrzNXH15jDZHsHU88syLpy6jF5
         kojy9VnazFz8Od+S4UqWyuSHqYuOoFXDgr/NZaYW+FJ1weD2Qzo2RM5DO49I9Fljk1bK
         M7Q5GrJTSoStR1Kb1l7FjCOujA//rrUGxkbptuGUJihtSdKF4s+VEf0qFAM5t0DQpbbU
         KzX3AJJfajapxxpANTmD2tzQqRBHon9XXjrPrp1YVedJH/nfi7STRj/tVHoQ2jsVkB96
         Ng0cM0L+X5iXxFPzJ+QRsXATIkiAdqmHX6kk0BbWy+TcdGghT8KcXM3qws+xOkqqXxyo
         r0zA==
X-Gm-Message-State: AOAM533PUzIAGtFQ6WH3+Ie2aTwZsOreSMziNZ/+hMoKHIWGJxGYUTKl
        DMOXMNjoLUPd2DVhWC7a1Qj4ETG9waUYWerKLLw=
X-Google-Smtp-Source: ABdhPJzGeRZu+mWNvY91Mw0h5ixZ8437r1IyFtBDccXPPUwaGbuo29Q/XMmOFLTRL9xBxrO6wrcyQkY6Ow82hszy16I=
X-Received: by 2002:aca:110a:: with SMTP id 10mr1942710oir.68.1597421404150;
 Fri, 14 Aug 2020 09:10:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200813175729.15088-1-andriy.shevchenko@linux.intel.com>
 <20200813175729.15088-3-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0iDZ6UZK_WW6pvWCqsrUH3uqfjRXSoMDTsAcbXoBuMYqw@mail.gmail.com> <20200814153730.GQ1891694@smile.fi.intel.com>
In-Reply-To: <20200814153730.GQ1891694@smile.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 14 Aug 2020 18:09:53 +0200
Message-ID: <CAJZ5v0jOA30iL6AQq3BEY=N3xQdvpC0BJEcLzz2Frv+CByKhPQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/7] resource: Introduce resource_union() for
 overlapping resources
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 14, 2020 at 5:37 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Aug 14, 2020 at 05:23:07PM +0200, Rafael J. Wysocki wrote:
> > On Thu, Aug 13, 2020 at 7:57 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > Some already present users may utilize resource_union() helper.
> > > Provide it for them and for wider use in the future.
> > >
> > > Deliberately avoid min()/max() macro as they are still parts of
> > > kernel.h which is quite a burden to be included here in order
> > > to avoid circular dependencies.
>
> ...
>
> > > +       if (!resource_overlaps(r1, r2))
> > > +               return false;
> >
> > I tend to add empty lines after return statements like this to make
> > them more clearly visible.
>
> Okay!
>
> > > +       r->start = r2->start < r1->start ? r2->start : r1->start;
> > > +       r->end = r2->end > r1->end ? r2->end : r1->end;
> >
> > Well, what about using min() and max() here?
>
> I devoted one paragraph in the commit message to answer this. The kernel.h
> (which I'm planning to split at some point) is a monster which brings more pain
> than solves here. Note, this is a header file and it's quite clean from
> dependencies perspective.

But this is code duplication (even if really small) and it is not
entirely clean too.

Maybe move the definitions of min() and max() to a separate header file?
