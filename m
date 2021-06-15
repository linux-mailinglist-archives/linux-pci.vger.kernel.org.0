Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 727DC3A7C96
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jun 2021 12:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbhFOLCB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Jun 2021 07:02:01 -0400
Received: from mail-oo1-f54.google.com ([209.85.161.54]:46716 "EHLO
        mail-oo1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbhFOLCB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Jun 2021 07:02:01 -0400
Received: by mail-oo1-f54.google.com with SMTP id x22-20020a4a62160000b0290245cf6b7feeso3396246ooc.13;
        Tue, 15 Jun 2021 03:59:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bsBJrLb93VKfHFYFesZs7eVUN/2dYudWk/UbQKmXLDs=;
        b=tcRkvZyofvHHqMN6BKliXmwenlPlaInvj7RLusWZY3SiKFX3NpZT9iZef8lXYwbOZC
         d8/gLJktc9jcGJBR3DbeC0q+7LNKoQu7E/a0RYiU6824pGokedxPGC+WyU0QUNKekM7X
         E22YHnjJhoq8R12ig+sOf1fjLaxtkRGbopojTJKx9ZCN7yWazAZGOAbqYPfzyx8NHY3o
         jF7nbC7iqvIffoi3JfY///0h86yMKyqKpdGpO0a4wcSO4bHWLZeYmhvkFppsyydhUnmK
         DmjB6P6usmm5Ss4dDaCSPDoO3BA2LdK1Evp4LM/F2Vc1KbW46lB5VADizNFrgbVHuAcO
         kxrQ==
X-Gm-Message-State: AOAM530KYr7emDvmEfULWP7Y9a//f6cX4/DOCDYBhY1vurMbtp9FG+Lx
        Ati6Qyqhqcw7W5rB5wlYLYGrd2qzueCuzotwpnE=
X-Google-Smtp-Source: ABdhPJyqmtQd46xewpgrpojbZXfK0OyOCB1DdOHTZvDJtuNu84lNS+GuhAgMiWW1+vfmjGg7nomKadtBUlLjCt4JRKs=
X-Received: by 2002:a4a:a9c8:: with SMTP id h8mr17223431oon.1.1623754796827;
 Tue, 15 Jun 2021 03:59:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210615102555.6035-1-hdegoede@redhat.com> <20210615102555.6035-2-hdegoede@redhat.com>
In-Reply-To: <20210615102555.6035-2-hdegoede@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 15 Jun 2021 12:59:44 +0200
Message-ID: <CAJZ5v0hJ0-U7-rMApDF72xVO2PQEdbzWtVkrOQVp4xnxGHoyuA@mail.gmail.com>
Subject: Re: [RFC 1/1] PCI/ACPI: Make acpi_pci_root_validate_resources()
 reject IOMEM resources which start at address 0
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 15, 2021 at 12:26 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> On some Lenovo laptops the base-addrsss of some PCI devices is left
> at 0 at boot:
>
> [    0.283145] pci 0000:00:15.0: [8086:34e8] type 00 class 0x0c8000
> [    0.283217] pci 0000:00:15.0: reg 0x10: [mem 0x00000000-0x00000fff 64bit]
> [    0.285117] pci 0000:00:15.1: [8086:34e9] type 00 class 0x0c8000
> [    0.285189] pci 0000:00:15.1: reg 0x10: [mem 0x00000000-0x00000fff 64bit]
>
> There is a _CRS method for these devices, which simply returns the
> configured 0 address. This is causing the PCI core to not assign
> memory to these PCI devices and is causing these errors:
>
> [    0.655335] pci 0000:00:15.0: BAR 0: no space for [mem size 0x00001000 64bit]
> [    0.655337] pci 0000:00:15.0: BAR 0: failed to assign [mem size 0x00001000 64bit]
> [    0.655339] pci 0000:00:15.1: BAR 0: no space for [mem size 0x00001000 64bit]
> [    0.655340] pci 0000:00:15.1: BAR 0: failed to assign [mem size 0x00001000 64bit]
>
> This happens specifically for the designware I2C PCI devices on these
> laptops, causing I2C-HID attached touchpads/touchscreens to not work.
>
> Booting with nocrs on these devices results in the kernel itself
> assigning memory to these devices, fixing things:
>
> [    0.355716] pci 0000:00:15.0: BAR 0: assigned [mem 0x29c000000-0x29c000fff 64bit]
> [    0.355783] pci 0000:00:15.1: BAR 0: assigned [mem 0x29c001000-0x29c001fff 64bit]
>
> At least the following models are known to be affected by this (but there
> might be more):
>
> Lenovo IdeaPad 3 15IIL05 81WE
> Lenovo IdeaPad 5 14IIL05 81YH
>
> Add an extra check for the base-address being 0 to
> acpi_pci_root_validate_resources() and reject IOMEM resources where this
> is the case, to fix this issue.
>
> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1871793
> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1868899
> BugLink: https://bugs.launchpad.net/ubuntu/+source/linux-signed-hwe/+bug/1878279
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Note we could instead add the known to be affected models to the
> pci_crs_quirks table in arch/x86/pci/acpi.c, but it is likely that more
> systems are affected and a more generic fix seems better in general.

Also, a memory resource starting at 0 is not usable in Linux anyway
AFAICS, at least on x86.

> ---
>  drivers/acpi/pci_root.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index dcd593766a64..6cd2ca551005 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -686,6 +686,13 @@ static void acpi_pci_root_validate_resources(struct device *dev,
>                 if (!(res1->flags & type))
>                         goto next;
>
> +               if ((type & IORESOURCE_MEM) && res1->start == 0) {
> +                       dev_info(dev, "host bridge window %pR (ignored, start address not set)\n",
> +                                res1);

Makes sense to me (small nit: I wouldn't break the like above).

> +                       free = true;
> +                       goto next;
> +               }
> +
>                 /* Exclude non-addressable range or non-addressable portion */
>                 end = min(res1->end, root->end);
>                 if (end <= res1->start) {
> --
