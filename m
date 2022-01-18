Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B782492B34
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jan 2022 17:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236672AbiARQ2z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Jan 2022 11:28:55 -0500
Received: from mail-qk1-f181.google.com ([209.85.222.181]:39680 "EHLO
        mail-qk1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233718AbiARQ2z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jan 2022 11:28:55 -0500
Received: by mail-qk1-f181.google.com with SMTP id s12so18759077qkg.6;
        Tue, 18 Jan 2022 08:28:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zP8L8fhnqG8IFgjyIHhSYZxPQQSDZzQ8mdDTBDJ1P4c=;
        b=j2TRKbfNIFBTLDF5nm2nlLy0tKR34cNStc6oAqJeQ1i5+v0K/b/Z29GnHwMnLLwtal
         U40DhxaJUieDKxagZA3/CRoT6MXndYpWwyeGN2H6V9DiVD6DrUsfC+HaGa65d0sl8joY
         MGVmLh0WEGs2Mxe1+KQm6nyWIcRedrMH4eUR10J2NlnKxh8VlAwUCNqiEwmSOm6Jtm1a
         7E8Bvfzo2ehASPVhjsIrFvJlT6EGzRFDpRVe5xk4n3v3mcJOqYFqPlj8NU5LC+58ol1p
         6bQ9YXnl7Q/HUacy5l3SMptHxToJz/XD82uWcuJaatR/9CHQTyin+pP368YRoK/zbQEG
         ZaQA==
X-Gm-Message-State: AOAM533RDk+5X3SKNUNnMXFj4aK2poZEcIRefdszWgYwXgrOKTLnnxTa
        5txGKYgo/SmDzDqArIIR/BJ+mtx2eYpkELFDf8Y=
X-Google-Smtp-Source: ABdhPJx/Z+mWVRKCY+I/DhyUvpbgdg1lD/rUDhEer9YG4+mZC5nlG5mLcnUakfM1Z2WcmUXwWmDyL5+LX8epoNDMQ6E=
X-Received: by 2002:a05:620a:1a97:: with SMTP id bl23mr18985232qkb.621.1642523334245;
 Tue, 18 Jan 2022 08:28:54 -0800 (PST)
MIME-Version: 1.0
References: <cadbd4eb-40bb-1fa8-1e00-dc95dab62295@gmail.com>
In-Reply-To: <cadbd4eb-40bb-1fa8-1e00-dc95dab62295@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 18 Jan 2022 17:28:43 +0100
Message-ID: <CAJZ5v0gH3xK3g01S0CLe235QTF6=A0EB+Zwuv50=WaJaRsCT+w@mail.gmail.com>
Subject: Re: [PATCH] PCI: Forbid RPM on ACPI systems before 5.0 only
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 17, 2022 at 11:52 AM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>
> Currently PCI core forbids RPM and requires opt-in from userspace,
> apart from few drivers calling pm_runtime_allow(). Reason is that some
> early ACPI PM implementations conflict with RPM, see [0].
> Note that as of today pm_runtime_forbid() is also called for non-ACPI
> systems. Maybe it's time to allow RPM per default for non-ACPI systems
> and recent enough ACPI versions. Let's allow RPM from ACPI 5.0 which
> was published in 2011.
>
> [0] https://lkml.org/lkml/2020/11/17/1548
>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/pci/pci.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 428afd459..26e3a500c 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3101,7 +3101,12 @@ void pci_pm_init(struct pci_dev *dev)
>         u16 status;
>         u16 pmc;
>
> -       pm_runtime_forbid(&dev->dev);
> +#ifdef CONFIG_ACPI
> +       /* Some early ACPI PM implementations conflict with RPM. */
> +       if (acpi_gbl_FADT.header.revision > 0 &&
> +           acpi_gbl_FADT.header.revision < 5)
> +               pm_runtime_forbid(&dev->dev);
> +#endif

Well, there are two things here.

First, there were systems in which ACPI PM was not ready for changing
power states in the S0 system state (ie. run-time) and it was assuming
that power states would only be changed during transitions to sleep
states (S1 - S4) and to S5.  This can be covered by the ACPI revicion
check, but I'm not sure if ACPI 5.0 is the right one.  Why ACPI 5 and
not ACPI 6, for instance?

Second, there were PCI devices without ACPI PM where the PCI standard
PM didn't work correctly.  This is not related to ACPI at all and I'm
not sure why the ACPI revision check would be sufficient to cover
these cases.

>         pm_runtime_set_active(&dev->dev);
>         pm_runtime_enable(&dev->dev);
>         device_enable_async_suspend(&dev->dev);
> --
> 2.34.1
>
