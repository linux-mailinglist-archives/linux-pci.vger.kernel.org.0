Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67DFC413543
	for <lists+linux-pci@lfdr.de>; Tue, 21 Sep 2021 16:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233519AbhIUOZS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Sep 2021 10:25:18 -0400
Received: from mail-oi1-f180.google.com ([209.85.167.180]:35714 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233587AbhIUOZR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Sep 2021 10:25:17 -0400
Received: by mail-oi1-f180.google.com with SMTP id r26so29904980oij.2;
        Tue, 21 Sep 2021 07:23:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P3b2jcfDbA2RMzWspcDxsQ8EfzdIgm88kRmi16zOKlw=;
        b=WULpk8jYyspTEByHRnSC2Ztz7j1U8Iq3/QEmjzp0Ud+hxIPdWsWz+D/ChYKvdV+tJb
         fqNIlo4zLrgcEZZZ4emCChUP0P61eEkGoGpIFIT5W2xAAZc0WCz5dNiicbaVklx5NhXH
         nfh72AxU0kh1nM+6z9v5grJG5t48BZBhRNt/vZqtVb051hYaGA3sMtcUIH0nTiQEn5gl
         xhdh0otAUmEXHU+j84n32/v5FH9+O9E+w2gNa9ZMD1dalJzuSIm4z+SrH6WWI5iZkP2T
         1/ASSgz/HSb1RSAUzbJ7VnQuGcgdIUEioxziBrnwfW7RcXejFZpf9mlGYoXkGF2gExkR
         vHkQ==
X-Gm-Message-State: AOAM531PdUvFS1R3mlCs6JDMf20lrypg0f6UewvigXxqFC138c0VUvNO
        UJZndeV6HoWCOQHhiXV09Nepc++Lf2uCiSIQpog=
X-Google-Smtp-Source: ABdhPJzf5nipsndEIxk+EpwoHUJsQvwNMTHnGbodOvtQwDvXh+YzqvzGOP8SfHoDQX9setnok5msn6HpzyMmEl4suf8=
X-Received: by 2002:a54:4f89:: with SMTP id g9mr3870082oiy.71.1632234228818;
 Tue, 21 Sep 2021 07:23:48 -0700 (PDT)
MIME-Version: 1.0
References: <8003272.NyiUUSuA9g@kreacher> <1798761.CQOukoFCf9@kreacher>
 <CAHp75VdoFwH2sQT6dwz4BCorkgJgmYEBHq-+YpT18HZx2cpmrA@mail.gmail.com>
 <CAJZ5v0iRviZkLzRP0t2f4q5oY9y6CxRotDnyBVBt-QBt-uYReQ@mail.gmail.com> <CAHp75VdE3gNXy+p=8iyqyY0Ja+AHjv6zFEGwWJSXQwz+A0X1TQ@mail.gmail.com>
In-Reply-To: <CAHp75VdE3gNXy+p=8iyqyY0Ja+AHjv6zFEGwWJSXQwz+A0X1TQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 21 Sep 2021 16:23:37 +0200
Message-ID: <CAJZ5v0jxVfqraab7zO2t3LoZecasV+gy5HRfjjacVDut2OscUw@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] PCI: PM: x86: Drop Intel MID PCI PM support
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        x86 Maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Len Brown <len.brown@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 21, 2021 at 2:17 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Mon, Sep 20, 2021 at 1:57 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > On Sun, Sep 19, 2021 at 10:32 PM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Sun, Sep 19, 2021 at 9:01 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> ...
>
> > > > I am going to post patches removing the rest of MID support from arch/x86/
> > > > and elsewhere, but that is still quite a bit of stuff and I don't want this
> > > > simple PCI PM series to depend on that work.
> > >
> > > This is still being used by MID with ACPI assisted (*) support.
> > > Hence, not ack.
> > >
> > > *) ACPI layer is provided by U-Boot and can't fulfill all possible
> > > features that ACPI may use in the Linux kernel.
> >
> > OK, good to know.
> >
> > I'm not sure how this PCI PM stuff works with ACPI.
>
> It doesn't that is the point. The PCI is very interesting there and
> what I meant is that the ACPI implementation I have provided via
> U-Boot does not cover these.

That's OK.  It just means that these devices are not power-manageable
via ACPI on the platforms in question, but the MID PCI PM code is
present in the kernel, so we don't need analogous code in AML in the
ACPI tables.

My point is that something like the v2 of this patch series
(https://lore.kernel.org/linux-acpi/1800633.tdWV9SEqCh@kreacher/T/#m1ec249724a5ad5ad358b0ed8e149e3926934955d)
is needed to prevent ACPI from overtaking the PM for the PCI devices
on the platform once we've decided to use the MID PM for them.

Now, if it is necessary to use ACPI PM for some devices and the MID PM
for other devices on the same platform, the latter needs to grow a
meaningful "power manageable" function that needs to be used in the
code as appropriate.

> If you have any hints/ideas how it may be handled, I am all ears!
