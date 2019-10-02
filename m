Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B726C48CD
	for <lists+linux-pci@lfdr.de>; Wed,  2 Oct 2019 09:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbfJBHvY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Oct 2019 03:51:24 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37358 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbfJBHvY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Oct 2019 03:51:24 -0400
Received: by mail-ot1-f65.google.com with SMTP id k32so13896575otc.4;
        Wed, 02 Oct 2019 00:51:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nicjUzK1aCzTPXfkiTszftUB1bSootFU4r9Af2VZdd4=;
        b=pI8tMAzhuWe1DDEcfpzJhos0mKr4QoiPl3GM4TPtsGGoOsFWc/ZYNPvnNK7HgO4qMV
         czkhBZXxLv7EYUNU3uKl/1dn9E6qDIB1Nb9k1BJp5yk7LMkPM9iNJvaklyuDKi5ZmAns
         uznao+HE6dx67UcSxLF4/2QGDiuntb39OuD3rNGdLWDlP7KyQ4cWECwtEWESa/TL5rvW
         dWi0VOpkamIgKh1f9xgZ10tNUyozw/TKzE9g+l1Vlk+5WjBsiMrUsd3Mxw+upzscf7Kg
         ZWHiePNiwZUt1PW60PQXX5BDDuWrrBjtKwzqUj1HDDHJ9oJwL1NZy7RXVnBM1LIvTx9g
         9kUw==
X-Gm-Message-State: APjAAAWXHZCuU1YlIojzPJIrZVBJCywKa+RyeC9AZuQyIqwbdaigWAMy
        QKcaTwlpUJN5CXoCtk4UAYgCkhZ7MhkdgBwpSRc=
X-Google-Smtp-Source: APXvYqz71nTjSqBxRr4QDswp1ob5aZ+KAvXvpMiCwA5SDyyXDIdUmYP20t6SgsKoFSgzFPZdmYYH4mgWrEHkD4h0TFc=
X-Received: by 2002:a9d:6a16:: with SMTP id g22mr1570217otn.118.1570002682809;
 Wed, 02 Oct 2019 00:51:22 -0700 (PDT)
MIME-Version: 1.0
References: <CACO55tvjFPAMgz6DMGmJQ3adtJBX6yYnFRO9gVBEpMVTEBu0og@mail.gmail.com>
 <20191001193427.GA59137@google.com>
In-Reply-To: <20191001193427.GA59137@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 2 Oct 2019 09:51:10 +0200
Message-ID: <CAJZ5v0gUddEhOPqNvTboO9mL6vcxu5HeCEC+-pJMzippTiAy9Q@mail.gmail.com>
Subject: Re: [RFC PATCH] pci: prevent putting pcie devices into lower device
 states on certain intel bridges
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Karol Herbst <kherbst@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Lyude Paul <lyude@redhat.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Schmauss, Erik" <erik.schmauss@intel.com>,
        Robert Moore <robert.moore@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 1, 2019 at 9:34 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Tue, Oct 01, 2019 at 06:21:28PM +0200, Karol Herbst wrote:
> > On Tue, Oct 1, 2019 at 3:27 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Mon, Sep 30, 2019 at 06:36:12PM +0200, Karol Herbst wrote:
> > > > On Mon, Sep 30, 2019 at 6:30 PM Mika Westerberg
> > > > <mika.westerberg@linux.intel.com> wrote:
> > > > >
> > > > > On Mon, Sep 30, 2019 at 06:05:14PM +0200, Karol Herbst wrote:
> > > > > > still happens with your patch applied. The machine simply gets shut down.
> > > > > >
> > > > > > dmesg can be found here:
> > > > > > https://gist.githubusercontent.com/karolherbst/40eb091c7b7b33ef993525de660f1a3b/raw/2380e31f566e93e5ba7c87ef545420965d4c492c/gistfile1.txt
> > > > >
> > > > > Looking your dmesg:
> > > > >
> > > > > Sep 30 17:24:27 kernel: nouveau 0000:01:00.0: DRM: DCB version 4.1
> > > > > Sep 30 17:24:27 kernel: nouveau 0000:01:00.0: DRM: MM: using COPY for buffer copies
> > > > > Sep 30 17:24:27 kernel: [drm] Initialized nouveau 1.3.1 20120801 for 0000:01:00.0 on minor 1
> > > > >
> > > > > I would assume it runtime suspends here. Then it wakes up because of PCI
> > > > > access from userspace:
> > > > >
> > > > > Sep 30 17:24:42 kernel: pci_raw_set_power_state: 56 callbacks suppressed
> > > > >
> > > > > and for some reason it does not get resumed properly. There are also few
> > > > > warnings from ACPI that might be relevant:
> > > > >
> > > > > Sep 30 17:24:27 kernel: ACPI Warning: \_SB.PCI0.GFX0._DSM: Argument #4 type mismatch - Found [Buffer], ACPI requires [Package] (20190509/nsarguments-59)
> > > > > Sep 30 17:24:27 kernel: ACPI Warning: \_SB.PCI0.PEG0.PEGP._DSM: Argument #4 type mismatch - Found [Buffer], ACPI requires [Package] (20190509/nsarguments-59)
> > > >
> > > > afaik this is the case for essentially every laptop out there.
> > >
> > > I think we should look into this a little bit.
> > > acpi_ns_check_argument_types() checks the argument type and prints
> > > this message, but AFAICT it doesn't actually fix anything or prevent
> > > execution of the method, so I have no idea what happens when we
> > > actually execute the _DSM.
> >
> > I can assure you that this warning happens on every single laptop out
> > there with dual Nvidia graphics and it's essentially just a firmware
> > bug. And it never caused any issues on any of the older laptops (or
> > newest one for that matter).
>
> Rafael, do you know anything about this?

IIRC ACPICA will simply run the method with the assumption that the
AML in there will deal with the arguments properly anyway.

> If ACPI has some sort of workaround so it can execute the method correctly
> anyway, maybe we should remove or reword the warning?

I can agree that printing these warnings on a user system by default
is not very useful, at least as long as no visible functional issues
are present, but if there are such issues, it is good to know that
something fishy is going on.  For instance, while the method may
execute successfully, the result of that may not be as expected.

So maybe they should be debug level or similar.

> Or if this does prevent execution of the method, maybe we need to add
> a workaround since the problem is so prevalent in the field?

As par the above, no workarounds should be needed, but I'll let Bob
and Erik (CCed now) confirm or deny this.

A side note: please CC all discussions regarding general ACPI issues
to linux-acpi, so they can get the attention of all of the right
people (who may not subscribe linux-pci, for example).
