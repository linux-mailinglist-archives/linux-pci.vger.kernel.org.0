Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 572702A6B85
	for <lists+linux-pci@lfdr.de>; Wed,  4 Nov 2020 18:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730906AbgKDRUS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Nov 2020 12:20:18 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:42020 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbgKDRUS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Nov 2020 12:20:18 -0500
Received: by mail-oi1-f196.google.com with SMTP id w145so17265961oie.9;
        Wed, 04 Nov 2020 09:20:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QEgtaOk4Lm7njaeuUYPIlzlOOaGGZwPV3+RIUaq3hFo=;
        b=FCkitBjH/UkpIhTM50sTNUJ6lsz1WVY0WFHYAVezGgicX87EBT8o2Kqn96p90O2Ftf
         G0l+THTSV1F7gOVhBBxo6oFGENtRysB6wqlt0TEneUZGA8AACPVeBmrNZMGDMqpxxeBV
         hbqsDqerTZhNKCju0Ry1aYBBoC9mfi4a/F+zxvDzhMdGHcct1p8m2vl1h8hLRWwxk40C
         YA0d7wfCCjCPhm9+0HRMc/mq6N8SIwent6GkZ1+U62IKHUXxMw6jSalIJWKtORERC88I
         cEtUO0XgU1socBpgYV3wUhkQ/QZ0p662yk+fw6S5zYXcH+kNVuXJLC3I+4i4ekNkpsSO
         rrUg==
X-Gm-Message-State: AOAM5302IVqXxHoaaO6CXRO0rbZyHM6jIEJqL22J+F317x7XWPtaZVAR
        8rH42SS4u7+k2Yrm0wGvbpuFbHXUvCSbco+gOBk=
X-Google-Smtp-Source: ABdhPJz9Abdd4/FrS49dRn7/l3S4TzmmUp3Tzqz1SpLe0sjmqSLkwv667jITZaISuklJVE4/8adcEtwNKHOBQOLz5Ik=
X-Received: by 2002:aca:30d7:: with SMTP id w206mr3205561oiw.69.1604510417420;
 Wed, 04 Nov 2020 09:20:17 -0800 (PST)
MIME-Version: 1.0
References: <20201103211259.GA265488@bjorn-Precision-5520> <c92703e3-c964-b4a6-e3df-c4c0c28b44c1@gmail.com>
 <6e392d099bd8aaba14223aa770361dbdeeab271b.camel@perches.com>
 <6d888eb0-bfc5-28ff-c62f-9e769f77bc1f@gmail.com> <57b77f3a36f56e2ae7ab8fe367865b5412d4e11f.camel@perches.com>
In-Reply-To: <57b77f3a36f56e2ae7ab8fe367865b5412d4e11f.camel@perches.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 4 Nov 2020 18:20:06 +0100
Message-ID: <CAJZ5v0j3rboB1RmsEsuKJB38GwJDF-HjUMVZo=eTjWNMQRknRw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: Remove trailing whitespace
To:     Joe Perches <joe@perches.com>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 4, 2020 at 6:13 PM Joe Perches <joe@perches.com> wrote:
>
> On Wed, 2020-11-04 at 16:48 +0100, Maximilian Luz wrote:
> > On 11/4/20 6:13 AM, Joe Perches wrote:
> >
> > [...]
> >
> > > > Yes. I scanned drivers/acpi for trailing whitespaces after I noticed a
> > > > couple of them. I did not explicitly scan for other stuff like spaces
> > > > where there should be tabs, mostly because I haven't found a quick and
> > > > reliable solution for that. I only noticed an inconsistent indentation
> > > > when committing, so I fixed that too.
> > >
> > > You could try:
> > >
> > > $ git ls-files -- 'drivers/acpi/*.[ch]' | \
> > >    xargs ./scripts/checkpatch.pl -f --fix-inplace --types=CODE_INDENT
> >
> > Thanks, that indeed looks like a decent solution.
> >
> > > Right now that produces:
> > > ---
> >
> > [...]
> >
> > > diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
> []
> > > @@ -89,7 +89,7 @@ struct acpi_ac {
> > >   #define to_acpi_ac(x) power_supply_get_drvdata(x)
> > >
> > >
> > >   /* --------------------------------------------------------------------------
> > > -                               AC Adapter Management
> > > +                          AC Adapter Management
> > >      -------------------------------------------------------------------------- */
> >
> > I'm not too sure about the comments, but I can find the time to look
> > over the output and adjust that if that's something you'd want me to do.
>
> Up to you.  I hardly looked at the output.
>
> I'd generally prefer to use a single line comment like
>
> /* AC Adapter Management */
>
> but I don't know how often that dashed block is used in ACPI.
>
> grep seems to show the texts are not correctly centered so it seems like
> it was done by hand and not that some automation tool was used to create
> those blocks.
>
> Maybe a separate patch could be done to change those if desired.

If anyone has a problem with them.

> But not by me.
>
> As far as I know, acpi was once autogenerated from a common source tree
> and whitespace changes were once frowned on, but maybe that's changed or
> or perhaps that's only for files in drivers/acpi/acpica/.

The latter.
