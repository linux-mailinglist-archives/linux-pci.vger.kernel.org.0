Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF4D38AD42
	for <lists+linux-pci@lfdr.de>; Thu, 20 May 2021 13:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241955AbhETMAy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 May 2021 08:00:54 -0400
Received: from mail-oi1-f177.google.com ([209.85.167.177]:40814 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243436AbhETL7k (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 May 2021 07:59:40 -0400
Received: by mail-oi1-f177.google.com with SMTP id s19so16126100oic.7;
        Thu, 20 May 2021 04:58:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yLyT8HKwqIoyP8bPnBwfaj1QPLi9kGCwW1wjGnvD0mw=;
        b=Wd77pS53j5QvpcXGcqfXesHYB0TN/Kbz7QeXvh/e/ji11trkfEO5Qr3FnltBJ39rRI
         PUGcaurvVmpTNLqsSJTJVPN3lnXynTH6+9nfI2zWsvYpY/HBMUH2pvTiHY4NLSF34qlE
         crlqA/qq8ojOzlfE2775qxDhe7IsgR1kCQPHmgUfk/7Vl6U89vrbhwcvX5g0h1BEEANw
         YstUBJkzgobfQkZUkjQFfl4CMKgUS+pA1gQok+HtFLhLQguwloqritHdEVXZOFhXgQ45
         +7dfTahSz2E6dANAhyPgdz2aPoXHIAY8j4zryrzI/xr01byp6X45ObTJSBb3iQTg6B8s
         Pi1Q==
X-Gm-Message-State: AOAM533oZPb6DM/YKxNEghoA+3PBfh+u0WfrUU6XtlKGvnAtKsK79LGy
        0EniHAkGuwyjRaLbgladBRSj6AXEmwBdmY+c/9Ok1wJd
X-Google-Smtp-Source: ABdhPJwubbZMOuQ8dZpigcWu47+oQTsmd/fTufg7ZdyOWHd9BDhmlHRxN/B8Be6KChwZWRt3t/cZTIc2zKwTPtpezyQ=
X-Received: by 2002:aca:380a:: with SMTP id f10mr3161998oia.157.1621511897275;
 Thu, 20 May 2021 04:58:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210506173820.21876-1-Hi-Angel@yandex.ru> <20210506214842.GA1436993@bjorn-Precision-5520>
In-Reply-To: <20210506214842.GA1436993@bjorn-Precision-5520>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 20 May 2021 13:58:06 +0200
Message-ID: <CAJZ5v0iWgxdUmvs-8w2r8Dp44aV5=k-2xN4Gq2PTtz=rszH=zw@mail.gmail.com>
Subject: Re: [PATCH] PCI: don't power-off apple thunderbolt controller on s2idle
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andreas Noever <andreas.noever@gmail.com>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 6, 2021 at 11:48 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Rafael, Andreas, linux-pm]
>
> On Thu, May 06, 2021 at 08:38:20PM +0300, Konstantin Kharlamov wrote:
> > On Macbook 2013 resuming from s2idle results in external monitor no
> > longer being detected, and dmesg having errors like:
> >
> >     pcieport 0000:06:00.0: can't change power state from D3hot to D0 (config space inaccessible)
> >
> > and a stacktrace. The reason turned out that the hw that the quirk
> > powers off does not get powered on back on resume.
>
> quirk_apple_poweroff_thunderbolt() was added in 2014 by 1df5172c5c25
> ("PCI: Suspend/resume quirks for Apple thunderbolt").  It claims
> "power is automatically restored before resume," so there must be
> something special about s2idle that prevents the power-on.
>
> IIUC this change will reduce the s2idle power savings.  I would feel
> better about this if we understood what the difference was.
>
> > Thus, add a check for s2idle to the quirk, and do nothing if the suspend
> > mode is s2idle.
>
> Obviously the *hardware* hasn't changed since 1df5172c5c25.  Is s2idle
> something that wasn't tested back then, or is this problem connected
> to an s2idle change since then?  Can we identify a commit that
> introduced this problem?  That would help with backporting or stable
> tags.
>
> > Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=212767
>
> Thanks for this!  Would you mind attaching the output of
> "sudo lspci -vvv"?  If you attach any other dmesg, could you
> use "dmesg --color=never" so the log doesn't include all the
> escape characters?
>
> > Signed-off-by: Konstantin Kharlamov <Hi-Angel@yandex.ru>
> > ---
> >  drivers/pci/quirks.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index 653660e3ba9e..86fedcec37e2 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -27,6 +27,7 @@
> >  #include <linux/nvme.h>
> >  #include <linux/platform_data/x86/apple.h>
> >  #include <linux/pm_runtime.h>
> > +#include <linux/suspend.h>
> >  #include <linux/switchtec.h>
> >  #include <asm/dma.h> /* isa_dma_bridge_buggy */
> >  #include "pci.h"
> > @@ -3646,6 +3647,13 @@ static void quirk_apple_poweroff_thunderbolt(struct pci_dev *dev)
> >               return;
> >       if (pci_pcie_type(dev) != PCI_EXP_TYPE_UPSTREAM)
> >               return;
> > +
> > +     /*
> > +      * If suspend mode is s2idle, power won't get restored on resume.
> > +      */

The comment above is incorrect.

The reason to return here is because whatever is done below cannot be
undone unless the platform firmware is invoked to finalize the suspend
transition, which is what the check is about.  And this is not
specific to s2idle.

> > +     if (!pm_suspend_via_firmware())
> > +             return;
> > +
> >       bridge = ACPI_HANDLE(&dev->dev);
> >       if (!bridge)
> >               return;
> > --
> > 2.31.1
> >
