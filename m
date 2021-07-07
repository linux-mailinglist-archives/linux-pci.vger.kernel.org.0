Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 126FF3BF08D
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jul 2021 21:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232930AbhGGT5Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Jul 2021 15:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbhGGT5Z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Jul 2021 15:57:25 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C75C06175F
        for <linux-pci@vger.kernel.org>; Wed,  7 Jul 2021 12:54:44 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id j199so3232270pfd.7
        for <linux-pci@vger.kernel.org>; Wed, 07 Jul 2021 12:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=acPssYyJkYRZ5l6K/T6/hcBt/2q8D6RkPE04ZGYzuUs=;
        b=E5uy5MslTE41zWq6b5S2KbnVkxqxiaRwbVF4Vy6cpWM/YP4CxEXr5+dFMSpf/nqQ8+
         7nK+mfPmqq0FRZqP0IjDi5E56EgyI2oyk/VuP9yQgMws58c9pnBMdtC3M01f/Yf6cP/Z
         LEAL78R7f+JVMagUa6Oqrjn6ljWzmJE2+fHB4wlH+l0tgb2fsreT4/BV+LXm/XtyLGJD
         xVucTlF6O7w33mDWvlW1tHJq5UryBhg3bu3vCjOCZKvVo6K9ggqsFt06GX1Yc8kqS5MG
         99ZURqYbLy0iVLPnTREYqXLZUpsL7rz3ccXucqone4gxs0W62diAHI5Wsm+vrTV4VDl5
         hY4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=acPssYyJkYRZ5l6K/T6/hcBt/2q8D6RkPE04ZGYzuUs=;
        b=pN0wXPPAqPm631TbWUpBQSwtLyuXmoi6R7S7J7U4Co4c51HiJzDMFRaLz3cBnNJ086
         QpdczDR4PL7MiPQgNrXSKcuyjvCXIlirOQK4GimE2qlKliRbC61GYzRTs3XfoBtlkGQR
         PFgF7cwFchTJu0ST2KbG3FEvsbHP/6BGVsaG1+gAbnpmOplLaKo7NIX2ma494FiOCUhc
         JKffzE45p+XeYvrnSjCFuLHe78Tswvdfqewf9/XBsX/kmC/1TH/Eot4YrYV1Z2u34LQ5
         UzPGGIkOfwal2f8z9sbSrT94UAzUEUF42EPfXPfu/TtGTruJOoKatcg6KntQN3sAGa3z
         /6Rw==
X-Gm-Message-State: AOAM531DVjZp1esbj2SGQ5hJqbwYuGdi+6k5VNVvLHQTJOIR3ZwMeLk0
        hxCFth1Vya5EkMIXwmPbMD111Dek484NAPNYn85HQw==
X-Google-Smtp-Source: ABdhPJy6wVdiTqOKpkwIGhiqcJLqxxH0ie3iTWCcfS4GubAN/QU35K0OENF/vZ5XDM3fEl8JhCyxYnN9lZqmW6yhuAg=
X-Received: by 2002:a65:6248:: with SMTP id q8mr28290636pgv.279.1625687684305;
 Wed, 07 Jul 2021 12:54:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210524133938.2815206-1-Jonathan.Cameron@huawei.com>
 <20210524133938.2815206-3-Jonathan.Cameron@huawei.com> <CAPcyv4gBORHzouArX-Fsnhew+ZYur8pp9ySJQGwrOBrGuv+-ZQ@mail.gmail.com>
In-Reply-To: <CAPcyv4gBORHzouArX-Fsnhew+ZYur8pp9ySJQGwrOBrGuv+-ZQ@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 7 Jul 2021 12:54:33 -0700
Message-ID: <CAPcyv4i2ukD4ZQ_KfTaKXLyMakpSk=Y3_QJGV2P_PLHHVkPwFw@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] PCI/DOE: Add Data Object Exchange support
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Linux PCI <linux-pci@vger.kernel.org>, linux-cxl@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Chris Browy <cbrowy@avery-design.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Fangjian <f.fangjian@huawei.com>, Linuxarm <linuxarm@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 10, 2021 at 1:06 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Mon, May 24, 2021 at 6:41 AM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > Introduced in a PCI ECN [1], DOE provides a config space based mailbox with
> > standard protocol discovery.  Each mailbox is accessed through a DOE
> > Extended Capability.
> >
> > A device may have 1 or more DOE mailboxes, each of which is allowed to
> > support any number of protocols (some DOE protocol specifications apply
> > additional restrictions).  A given protocol may be supported on more than
> > one DOE mailbox on a given function.
> >
> > If a driver wishes to access any number of DOE instances / protocols it
> > makes a single call to pci_doe_register_all() which will find available
> > DOEs, create the required infrastructure and cache the protocols they
> > support.  pci_doe_find() can then retrieve a pointer to an appropriate DOE
> > instance.
> >
> > A synchronous interface is provided in pci_doe_exchange_sync() to perform a
> > single query / response exchange.
> >
> > Testing conducted against QEMU using:
> >
> > https://lore.kernel.org/qemu-devel/1619454964-10190-1-git-send-email-cbrowy@avery-design.com/
>
> Nice.
>
> I was hoping that by now QEMU upstream would have given us some
> indication that this useful work that has a chance of being merged. I
> fear it's only us CXL practitioner's that care. Perhaps the PCI IDE
> support will get them to move on at least the DOE patches?
>
> >
> > [1] https://members.pcisig.com/wg/PCI-SIG/document/14143
> >     Data Object Exchange (DOE) - Approved 12 March 2020
> >
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> The core logic of this looks good to me. The interfaces for other code
> to make use of this I feel can lean heavier on existing mechanics. A
> few points come to mind:
>
> - Does this need to support anything more than queue depth 1? I know
> the specification seems to allow for some overlapping and queueing,
> but I don't think there are any use cases that are precluded if the
> max number of tasks in flight for a given DOE is one.
>
> - Once its queue depth 1 then the list of tasks can be replaced with a
> wait_queue_head_t where submitters wait for the previous task to
> finish.
>
> - This appears to be the prototypical scenario for deploying the new
> auxiliary bus facility. Rather than custom code device-like facilities
> (lists and parents etc) in 'struct pci_doe' just make pci_doe a device
> directly (auxiliary-device) and separate the infrastructure that
> drives that device to a driver (auxiliary-driver). That makes the
> lifetime management more idiomatic, allows for user space to have
> typical driver-binding controls to manage kernel-user DOE conflicts,
> and it allows for typical driver services like devm.

Hi Jonathan,

Are you waiting on me to take a shot at refactoring the DOE driver
into this proposed auxiliary device/driver organization? I am happy to
do that if you've moved on to looking at the kernel-side SPDM
implementation [1].

I would expect DOE,  SPDM, and IDE would be a useful topic to discuss
at the the Plumbers PCI Microconference assuming we do not solve all
the open issues before September.

[1]: https://lore.kernel.org/r/20210629132520.00000d1f@Huawei.com
