Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61FEF5D3C0
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jul 2019 17:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbfGBP7l (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Jul 2019 11:59:41 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34775 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbfGBP7l (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Jul 2019 11:59:41 -0400
Received: by mail-ot1-f65.google.com with SMTP id n5so17705094otk.1;
        Tue, 02 Jul 2019 08:59:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UX+GvBFC0v6ijIy6UhW+3XcFJ/I0DX5uZsKBeKdYKQc=;
        b=OLmqipUAeVHIpuQFTB8VgsRX5Ha6Oy+oXGWCJrVilHz7RDL4O4zPBINBHEGrd/xrWE
         FDaUue7qCRJtcrGzPT4hWPXIgXhZWXsQu7TGOQpu5CZMxQqlCSD9BwMk0j9PVCyhYoSB
         nSqjPNKGQdPSiRDVrV+HPz8Lps7gbWiU/WthNSCdA2+U0utUIK/2U8DvxS1mlYsN22Nt
         Olbldxq0HbV786/7DtaKkea5V3RiZy2AtC3SKnfjLA98M4w0teu0UpRX6W/KOSK646sX
         6s4FYrR1EnuVGMcTs5M6WRiQuFqDe8yUVzSQP5CcagFhVZ0yiwTGRfqE3klB/d2o8KuY
         YYAg==
X-Gm-Message-State: APjAAAWnTsqvzc5lSUou49T+AOx17T8E8qrspfFTQivuUCECGFewJnTF
        M8Q2FbGu59h7Daj6P+Uzz4sp/Lt3691vE8ITdlo=
X-Google-Smtp-Source: APXvYqw4NQyJ1uqX49Lix6ogL4V0KiZ/E2CFkNB0/ag0NAxhGfpEwvIazSLKKxNwP6jmm7UeeALEJLepAhvErmYL6yE=
X-Received: by 2002:a05:6830:1516:: with SMTP id k22mr4803148otp.189.1562083180116;
 Tue, 02 Jul 2019 08:59:40 -0700 (PDT)
MIME-Version: 1.0
References: <4976412.ihyb9sT5jY@kreacher> <6191578.xJk2HsE5MX@kreacher> <20190701161550.GA2640@lahna.fi.intel.com>
In-Reply-To: <20190701161550.GA2640@lahna.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 2 Jul 2019 17:59:28 +0200
Message-ID: <CAJZ5v0iJ4bELn+LSLgnOaUz6d31FeCV84t=VxKYHA1hLUnQ-ZQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] PM: ACPI/PCI: Resume all devices during hibernation
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans De Goede <hdegoede@redhat.com>,
        "Robert R. Howell" <RHowell@uwyo.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 1, 2019 at 6:15 PM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> On Mon, Jul 01, 2019 at 12:44:25PM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Both the PCI bus type and the ACPI PM domain avoid resuming
> > runtime-suspended devices with DPM_FLAG_SMART_SUSPEND set during
> > hibernation (before creating the snapshot image of system memory),
> > but that turns out to be a mistake.  It leads to functional issues
> > and adds complexity that's hard to justify.
> >
> > For this reason, resume all runtime-suspended PCI devices and all
> > devices in the ACPI PM domains before creating a snapshot image of
> > system memory during hibernation.
> >
> > Fixes: 05087360fd7a (ACPI / PM: Take SMART_SUSPEND driver flag into account)
> > Fixes: c4b65157aeef (PCI / PM: Take SMART_SUSPEND driver flag into account)
> > Link: https://lore.kernel.org/linux-acpi/917d4399-2e22-67b1-9d54-808561f9083f@uwyo.edu/T/#maf065fe6e4974f2a9d79f332ab99dfaba635f64c
> > Reported-by: Robert R. Howell <RHowell@uwyo.edu>
> > Tested-by: Robert R. Howell <RHowell@uwyo.edu>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > -> v2: No changes.
> >
> > ---
> >  drivers/acpi/device_pm.c |   13 +++++++------
> >  drivers/pci/pci-driver.c |   16 ++++++++--------
> >  2 files changed, 15 insertions(+), 14 deletions(-)
> >
> > Index: linux-pm/drivers/acpi/device_pm.c
> > ===================================================================
> > --- linux-pm.orig/drivers/acpi/device_pm.c
> > +++ linux-pm/drivers/acpi/device_pm.c
> > @@ -1155,13 +1155,14 @@ EXPORT_SYMBOL_GPL(acpi_subsys_resume_ear
> >  int acpi_subsys_freeze(struct device *dev)
> >  {
> >       /*
> > -      * This used to be done in acpi_subsys_prepare() for all devices and
> > -      * some drivers may depend on it, so do it here.  Ideally, however,
> > -      * runtime-suspended devices should not be touched during freeze/thaw
> > -      * transitions.
> > +      * Resume all runtime-suspended devices before creating a snapshot
> > +      * image of system memory, because the restore kernel generally cannot
> > +      * be expected to always handle them consistently and they need to be
> > +      * put into the runtime-active metastate during system resume anyway,
> > +      * so it is better to ensure that the state saved in the image will be
> > +      * alwyas consistent with that.
>
> alwyas -> always
>
> >        */
> > -     if (!dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND))
> > -             pm_runtime_resume(dev);
> > +     pm_runtime_resume(dev);
> >
> >       return pm_generic_freeze(dev);
> >  }
> > Index: linux-pm/drivers/pci/pci-driver.c
> > ===================================================================
> > --- linux-pm.orig/drivers/pci/pci-driver.c
> > +++ linux-pm/drivers/pci/pci-driver.c
> > @@ -1012,15 +1012,15 @@ static int pci_pm_freeze(struct device *
> >       }
> >
> >       /*
> > -      * This used to be done in pci_pm_prepare() for all devices and some
> > -      * drivers may depend on it, so do it here.  Ideally, runtime-suspended
> > -      * devices should not be touched during freeze/thaw transitions,
> > -      * however.
> > +      * Resume all runtime-suspended devices before creating a snapshot
> > +      * image of system memory, because the restore kernel generally cannot
> > +      * be expected to always handle them consistently and they need to be
> > +      * put into the runtime-active metastate during system resume anyway,
> > +      * so it is better to ensure that the state saved in the image will be
> > +      * alwyas consistent with that.
>
> ditto

Thanks, I'll fix these up when applying the patch.
