Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90B5C3A7DA0
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jun 2021 13:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbhFOLyc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Jun 2021 07:54:32 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:46895 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbhFOLyc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Jun 2021 07:54:32 -0400
Received: by mail-ot1-f44.google.com with SMTP id 66-20020a9d02c80000b02903615edf7c1aso13948234otl.13;
        Tue, 15 Jun 2021 04:52:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3P84KNZxhChDSJlUnkXgk85+aNRZHsVnrInpjAO8IoE=;
        b=JZfsVKv2McjShqo1Nth+8prUi9vt5q3fWkDgX0FqokEUyUbcgO5emVzFem5VX9jWKJ
         nUWkOYCP9BemFqoZzhem+f4LXM7gZ8AENsrVZZZTdfRbIJw81/WCggoEFtu+aUPzBy2k
         +yF3qEiULSRxTKvaznUb1baszbacxGb46b45uT4QIHqjVfMBxBw5yqJsCijZ8z4RmVOB
         3xVbr7shHGsvVpuwqRvgwSDDgxQEMltu7Lq5AV73/34YaX8UcVKRYnIKQtvZwQeUAruI
         o2UKBdT4GIrWkGruYM+aKyJkpoLKIsI04Eus9ABCMJ9+JfotEyIW3ZzQGNlTZbrFiSZZ
         hOSA==
X-Gm-Message-State: AOAM532jDviX1r5oiHQcy0t4C2wnLbA6iWfvn8wDZ0ecONz1SRQ2kPx6
        cbfhA/MvsGFxvdqxpqN/TO9dQP9tKOcKOnQQVzg=
X-Google-Smtp-Source: ABdhPJz2fXPcU1aXKUwvcHG4MUmJpYPJeYWm1GcCRsG9T8oGWCKUvwF+NMBg6z6VAGGzQrSjM0tgd1XVSa9ijg6cTnI=
X-Received: by 2002:a9d:3e53:: with SMTP id h19mr17485084otg.260.1623757947043;
 Tue, 15 Jun 2021 04:52:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210615102555.6035-1-hdegoede@redhat.com> <20210615102555.6035-2-hdegoede@redhat.com>
 <CAJZ5v0hJ0-U7-rMApDF72xVO2PQEdbzWtVkrOQVp4xnxGHoyuA@mail.gmail.com> <fb26ac42-d047-5a01-1d16-0b5ea3e2eefc@redhat.com>
In-Reply-To: <fb26ac42-d047-5a01-1d16-0b5ea3e2eefc@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 15 Jun 2021 13:52:15 +0200
Message-ID: <CAJZ5v0g0yTZnFV79f_kjZb-u9CURegBg=iA9Jap9hBNn8spRPA@mail.gmail.com>
Subject: Re: [RFC 1/1] PCI/ACPI: Make acpi_pci_root_validate_resources()
 reject IOMEM resources which start at address 0
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 15, 2021 at 1:33 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 6/15/21 12:59 PM, Rafael J. Wysocki wrote:
> > On Tue, Jun 15, 2021 at 12:26 PM Hans de Goede <hdegoede@redhat.com> wrote:
> >>
> >> On some Lenovo laptops the base-addrsss of some PCI devices is left
> >> at 0 at boot:
> >>
> >> [    0.283145] pci 0000:00:15.0: [8086:34e8] type 00 class 0x0c8000
> >> [    0.283217] pci 0000:00:15.0: reg 0x10: [mem 0x00000000-0x00000fff 64bit]
> >> [    0.285117] pci 0000:00:15.1: [8086:34e9] type 00 class 0x0c8000
> >> [    0.285189] pci 0000:00:15.1: reg 0x10: [mem 0x00000000-0x00000fff 64bit]
> >>
> >> There is a _CRS method for these devices, which simply returns the
> >> configured 0 address. This is causing the PCI core to not assign
> >> memory to these PCI devices and is causing these errors:
> >>
> >> [    0.655335] pci 0000:00:15.0: BAR 0: no space for [mem size 0x00001000 64bit]
> >> [    0.655337] pci 0000:00:15.0: BAR 0: failed to assign [mem size 0x00001000 64bit]
> >> [    0.655339] pci 0000:00:15.1: BAR 0: no space for [mem size 0x00001000 64bit]
> >> [    0.655340] pci 0000:00:15.1: BAR 0: failed to assign [mem size 0x00001000 64bit]
> >>
> >> This happens specifically for the designware I2C PCI devices on these
> >> laptops, causing I2C-HID attached touchpads/touchscreens to not work.
> >>
> >> Booting with nocrs on these devices results in the kernel itself
> >> assigning memory to these devices, fixing things:
> >>
> >> [    0.355716] pci 0000:00:15.0: BAR 0: assigned [mem 0x29c000000-0x29c000fff 64bit]
> >> [    0.355783] pci 0000:00:15.1: BAR 0: assigned [mem 0x29c001000-0x29c001fff 64bit]
> >>
> >> At least the following models are known to be affected by this (but there
> >> might be more):
> >>
> >> Lenovo IdeaPad 3 15IIL05 81WE
> >> Lenovo IdeaPad 5 14IIL05 81YH
> >>
> >> Add an extra check for the base-address being 0 to
> >> acpi_pci_root_validate_resources() and reject IOMEM resources where this
> >> is the case, to fix this issue.
> >>
> >> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1871793
> >> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1868899
> >> BugLink: https://bugs.launchpad.net/ubuntu/+source/linux-signed-hwe/+bug/1878279
> >> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >> ---
> >> Note we could instead add the known to be affected models to the
> >> pci_crs_quirks table in arch/x86/pci/acpi.c, but it is likely that more
> >> systems are affected and a more generic fix seems better in general.
> >
> > Also, a memory resource starting at 0 is not usable in Linux anyway
> > AFAICS, at least on x86.
>
> Right, but I was wondering about other arches. Maybe wrap the new check in
> "#if IS_ENABLED(CONFIG_X86)" ?

That would be prudent, because all of the known affected machines are x86.

> >> ---
> >>  drivers/acpi/pci_root.c | 7 +++++++
> >>  1 file changed, 7 insertions(+)
> >>
> >> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> >> index dcd593766a64..6cd2ca551005 100644
> >> --- a/drivers/acpi/pci_root.c
> >> +++ b/drivers/acpi/pci_root.c
> >> @@ -686,6 +686,13 @@ static void acpi_pci_root_validate_resources(struct device *dev,
> >>                 if (!(res1->flags & type))
> >>                         goto next;
> >>
> >> +               if ((type & IORESOURCE_MEM) && res1->start == 0) {
> >> +                       dev_info(dev, "host bridge window %pR (ignored, start address not set)\n",
> >> +                                res1);
> >
> > Makes sense to me (small nit: I wouldn't break the like above).
> >
> >> +                       free = true;
> >> +                       goto next;
> >> +               }
> >> +
> >>                 /* Exclude non-addressable range or non-addressable portion */
> >>                 end = min(res1->end, root->end);
> >>                 if (end <= res1->start) {
> >> --
> >
>
