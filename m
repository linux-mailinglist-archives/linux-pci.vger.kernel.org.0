Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D550422839
	for <lists+linux-pci@lfdr.de>; Tue,  5 Oct 2021 15:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234298AbhJENsP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Oct 2021 09:48:15 -0400
Received: from mail-oi1-f174.google.com ([209.85.167.174]:35501 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235132AbhJENsO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Oct 2021 09:48:14 -0400
Received: by mail-oi1-f174.google.com with SMTP id n64so26293186oih.2;
        Tue, 05 Oct 2021 06:46:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GZuitQsZRbIllSd5c/N0q7ztxTY7wBNZEilaLOdnQlM=;
        b=b+Rr4me7ShRBrYIYKZ+QX2dzafebnTZqEql7zZiqIYQxLBO9gO1cM+tz6pIge1gSIz
         +Fciz2VjkFtaI5n7gKWXyGSzLph1EQnT8BpHF0uLvQ4EJTajFzE6l/zF8f7qZItYSVy5
         ibE+ocJUE/Gkg3/pTU0L7xZ+U1mT1sLEaG6tVio7bEXLFU3TCgn71vg6ccHeKdbjhrN9
         co24lEs+yIVhGPxiyfDQHCtdmUvhPd2SdZaO+u8FoSsdyDgxh2VbW8hYio39Ze2c61mQ
         Govqv68NsjFJkUnTdffX35U+9yn5CHzd2wbEjyH0PYZo2jvKv9HX5xHSIh4N1lq5hKmj
         XpEg==
X-Gm-Message-State: AOAM531jXxiHJQsB2V3hJH/1PMrnaHkB8jRr+0PmZxIgLJ7I5E5Ijoj+
        eDXmjrZwfbunX88GyHYwaBzH/JyWfpfej1s6F43zDm7K
X-Google-Smtp-Source: ABdhPJzh4caxgPTPZfJujBFskJc0tB54sTnKLP19W0J4hgZFgeBFACv02d3vxyzEzxJptnVRt5FMfvM4F8BKnex7sfk=
X-Received: by 2002:aca:6009:: with SMTP id u9mr2640823oib.71.1633441583791;
 Tue, 05 Oct 2021 06:46:23 -0700 (PDT)
MIME-Version: 1.0
References: <5523582.DvuYhMxLoT@kreacher>
In-Reply-To: <5523582.DvuYhMxLoT@kreacher>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 5 Oct 2021 15:46:12 +0200
Message-ID: <CAJZ5v0gOuAoV2SNFd1m7fHAH86kpA8vTdFpVhoPzinFHs_Zqcw@mail.gmail.com>
Subject: Re: [PATCH] PCI: ACPI: Check parent pointer in acpi_pci_find_companion()
To:     Linux PCI <linux-pci@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Shanker Donthineni <sdonthineni@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 1, 2021 at 3:58 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> If acpi_pci_find_companion() is called for a device whose parent
> pointer is NULL, it will crash when attempting to get the ACPI
> companion of the parent due to a NULL pointer dereference in
> the ACPI_COMPANION() macro.
>
> This was not a problem before commit 375553a93201 ("PCI: Setup ACPI
> fwnode early and at the same time with OF") that made pci_setup_device()
> call pci_set_acpi_fwnode() and so it allowed devices with NULL parent
> pointers to be passed to acpi_pci_find_companion() which is the case
> in pci_iov_add_virtfn(), for instance.
>
> Fix this issue by making acpi_pci_find_companion() check the device's
> parent pointer upfront and bail out if it is NULL.
>
> While pci_iov_add_virtfn() can be changed to set the device's parent
> pointer before calling pci_setup_device() for it, checking pointers
> against NULL before dereferencing them is prudent anyway and looking
> for ACPI companions of virtual functions isn't really useful.
>
> Fixes: 375553a93201 ("PCI: Setup ACPI fwnode early and at the same time with OF")
> Link: https://lore.kernel.org/linux-acpi/8e4bbd5c59de31db71f718556654c0aa077df03d.camel@linux.ibm.com/
> Reported-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Tested-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Due to the lack of negative feedback I'm queuing this up for 5.15-rc5.
If there are concerns, please let me know.

> ---
>  drivers/pci/pci-acpi.c |    3 +++
>  1 file changed, 3 insertions(+)
>
> Index: linux-pm/drivers/pci/pci-acpi.c
> ===================================================================
> --- linux-pm.orig/drivers/pci/pci-acpi.c
> +++ linux-pm/drivers/pci/pci-acpi.c
> @@ -1243,6 +1243,9 @@ static struct acpi_device *acpi_pci_find
>         bool check_children;
>         u64 addr;
>
> +       if (!dev->parent)
> +               return NULL;
> +
>         down_read(&pci_acpi_companion_lookup_sem);
>
>         adev = pci_acpi_find_companion_hook ?
>
>
>
