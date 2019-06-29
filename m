Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 749F45AD92
	for <lists+linux-pci@lfdr.de>; Sun, 30 Jun 2019 00:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbfF2WDH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 29 Jun 2019 18:03:07 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42639 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbfF2WDG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 29 Jun 2019 18:03:06 -0400
Received: by mail-ot1-f65.google.com with SMTP id l15so9648708otn.9;
        Sat, 29 Jun 2019 15:03:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FUpz/PJBYvLHMXt6LdH1sbpzCmvKiqzMsbmF/J4YLoQ=;
        b=UKIDm7zVFGnuwFwyxyolKXzqM0s8YtTMD1v3jedqzctOqWVT+u37jODoZUWAjUnoqq
         YW198ZaQF45YCtBtn1ETO1rtV4G2vgLdj2u2wH9MlSrDA7zuUj+UMxjuklwmT94vvO+7
         kZ82uRF7OxvonDLjqkSD1OunMS2Ytqhmctd1HU4E22BEvVP86idRNkFq7wlNsbe/npBw
         Yoxho3USJfzm2+kZG2IKKmfJitcJpgdBo41CCGFmOwcJZdL8496hnHYoTRI+XVOBg5IY
         R8llczu+FJ8grwIlhO3q2P+QXWQ0Qc39ivBODk2KgctLYrtAeD7oBxGuNWO6I80SahRl
         aCog==
X-Gm-Message-State: APjAAAVSLiLBEKXpfkR2H/po89SaHpI8Bjz9aK4EfLULm+jk+L/55pw3
        Gy+ONkYh3uiZprcAXIAXw87FxA33l3X65FflCao=
X-Google-Smtp-Source: APXvYqzWorUFIf3n5S01H4tlmbojU7clNJv0OqZ1rTVdvLW0a2GvABtXLCDFaPI0k9j91lAJyIHRchji2PbUU45yV3U=
X-Received: by 2002:a05:6830:1516:: with SMTP id k22mr13212772otp.189.1561845785457;
 Sat, 29 Jun 2019 15:03:05 -0700 (PDT)
MIME-Version: 1.0
References: <2318839.0szTqvJMZa@kreacher> <2981101.tKVHzisTAg@kreacher> <c41b5efe-049c-fc72-8697-b2ec9125a55e@redhat.com>
In-Reply-To: <c41b5efe-049c-fc72-8697-b2ec9125a55e@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sun, 30 Jun 2019 00:02:54 +0200
Message-ID: <CAJZ5v0iUOv0MYOHP7938V=6qsURBYO6B4LHqfdm_DCHH8GvfLA@mail.gmail.com>
Subject: Re: [PATCH 4/6] ACPI: LPSS: Fix ->suspend_late callbacks handling
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Robert R. Howell" <RHowell@uwyo.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Jun 29, 2019 at 1:34 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi Rafael,
>
> On 29-06-19 11:50, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > If the resume_from_noirq flag is set in dev_desc, the ->suspend_late
> > callback provided by the device driver will be invoked at the "noirq"
> > stage of system suspend, via acpi_lpss_do_suspend_late(), which is
> > incorrect.
> >
> > To fix that, drop acpi_lpss_do_suspend_late() and rearrange
> > acpi_lpss_suspend_late() to call pm_generic_suspend_late()
> > directly, before calling acpi_lpss_suspend(), in analogy with
> > acpi_subsys_suspend_late().
>
> Ah now I see the logic in your previous test-patch.
>
> I'm afraid that this is going to break things though, the calling
> of the device-driver's suspend-late method at noirq time is
> *intentional* !

But it is a bug too.

> The resume_from_noirq flag is only set for i2c controllers which
> use: drivers/i2c/busses/i2c-designware-platdrv.c as driver.
>
> This driver's suspend late method looks like this:
>
> static int dw_i2c_plat_suspend(struct device *dev)
> {
>          struct dw_i2c_dev *i_dev = dev_get_drvdata(dev);
>
>          i_dev->suspended = true;
>
>          if (i_dev->shared_with_punit)
>                  return 0;
>
>          i_dev->disable(i_dev);
>          i2c_dw_prepare_clk(i_dev, false);
>
>          return 0;
> }
>
> The i_dev->disable(i_dev) and i2c_dw_prepare_clk(i_dev, false) calls here
> will make the i2c controller non functional. But (some of) these i2c
> controllers are used by code in the _PS0  / _PS3 methods of some PCI
> devices and the PCI core calls _PS0 / _PS3 at *noirq* time, so as explained
> in the commit message which introduced acpi_lpss_do_suspend_late():
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=48402cee6889fb3fce58e95fea1471626286dc63
>
> We must not only make sure that the suspending of the i2c controller is
> ordered so that it happens after these PCI devices are suspended, we must
> also make sure that the i2c controller stays functional until the
> i2c-controller is put in the suspend-noirq state.
>
> If you really want to go this route, we must duplicate the resume_from_noirq
> flag inside drivers/i2c/busses/i2c-designware-platdrv.c, setting it
> only for acpi_lpss enumerated devices (the driver handles a whole lot more
> devices) ans then make the driver's suspend_late method a no-op and instead
> to the suspend from its suspend_noirq callback.
>
> Since pm_generic_suspend_late() is just a wrapper to call dev->driver->pm->suspend_late
> duplicating the resume_from_noirq flag inside i2c-designware-platdrv.c seems
> unproductive.
>
> Note that we have the same thing going on in acpi_lpss.c with resume_early vs
> resume_noirq, we call the resume_early callback from acpi_lpss_resume_noirq
> if the resume_from_noirq flag is set.
>
> TL;DR: the behavior you are trying to fix here is intentional and
> IMHO this patch should be dropped.

I can drop the patch, but the current code is simply incorrect.

If the driver provided a ->suspend_late callback, it wanted that
callback to be invoked during the "late" stage of suspend.  Calling it
later simply papers over a driver bug.  If invoking that callback
during the "late" stage doesn't work, the driver should have provided
a "noirq" callback instead.

> I guess we could / should do a patch adding a comment that the calling
> the drivers' suspend_late / resume_early callback at noirq time is intentional
> to avoid this confusing people in the future.

No.  We need to fix drivers doing wrong things.

Thanks!
