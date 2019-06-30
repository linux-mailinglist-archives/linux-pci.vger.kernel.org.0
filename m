Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 598465AF96
	for <lists+linux-pci@lfdr.de>; Sun, 30 Jun 2019 11:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbfF3Jsa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 30 Jun 2019 05:48:30 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38977 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbfF3Jsa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 30 Jun 2019 05:48:30 -0400
Received: by mail-ot1-f66.google.com with SMTP id r21so9805493otq.6;
        Sun, 30 Jun 2019 02:48:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ia+5YNuxbLf7yeKas8RFuQW37BaaoPfsGKHUkCIHHX4=;
        b=NtaVB0VpXRnWsEBZiBa6zL/uFvZx8Ep6nLA7tVo4UvbO8wfTmhdViPxbkEbARe7/Uc
         da+KjNdakW4hC00hQz+c2zEAWzPueuG5R0WT3wh9OS/dY/W1ubrhcKK0BzCxPzyk1LC/
         kJgmeaiRvJ+ANhh5OHMMFHPA0TobnVVAkm3c3qdfQD/akFvqGUXeX6sI3sGUk6pOIBfO
         bLfiWsiixv6Z1yq1eMF3G8SrOHehb8WIsfcQ+PkMz2zCzQoAirr6nTuXPv9sTUVSihBh
         olL7Y3nhL7DR7X2jV1sJEEVh/V9g+0so20NYpeKbCvno5KLhWmb0wD1bhuNhX7uk3Ah+
         lOhQ==
X-Gm-Message-State: APjAAAXnkyg85s9OWV27ZimuY8XS49OkJ5gA4AWVKICBtTGQwC4LzSaK
        NXLbeWirCTmeoU+tsigC2i4TR5V/kJ4avgKyO38=
X-Google-Smtp-Source: APXvYqzq8GuORGm+vvnEkvz9U5Zt37mi1VhjLv45QMszdkfmZcQMs6mmM8qSYGU4zDnDOklOfhne2j1CocCX6+W7wCM=
X-Received: by 2002:a05:6830:1516:: with SMTP id k22mr14667037otp.189.1561888109369;
 Sun, 30 Jun 2019 02:48:29 -0700 (PDT)
MIME-Version: 1.0
References: <2318839.0szTqvJMZa@kreacher> <2981101.tKVHzisTAg@kreacher>
 <c41b5efe-049c-fc72-8697-b2ec9125a55e@redhat.com> <CAJZ5v0iUOv0MYOHP7938V=6qsURBYO6B4LHqfdm_DCHH8GvfLA@mail.gmail.com>
In-Reply-To: <CAJZ5v0iUOv0MYOHP7938V=6qsURBYO6B4LHqfdm_DCHH8GvfLA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sun, 30 Jun 2019 11:48:18 +0200
Message-ID: <CAJZ5v0iqnKMfWewZv=QnJHojBebuoCBuw0iO7QJ=xhAeymhY+w@mail.gmail.com>
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

On Sun, Jun 30, 2019 at 12:02 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Sat, Jun 29, 2019 at 1:34 PM Hans de Goede <hdegoede@redhat.com> wrote:
> >
> > Hi Rafael,
> >
> > On 29-06-19 11:50, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > If the resume_from_noirq flag is set in dev_desc, the ->suspend_late
> > > callback provided by the device driver will be invoked at the "noirq"
> > > stage of system suspend, via acpi_lpss_do_suspend_late(), which is
> > > incorrect.
> > >
> > > To fix that, drop acpi_lpss_do_suspend_late() and rearrange
> > > acpi_lpss_suspend_late() to call pm_generic_suspend_late()
> > > directly, before calling acpi_lpss_suspend(), in analogy with
> > > acpi_subsys_suspend_late().
> >
> > Ah now I see the logic in your previous test-patch.
> >
> > I'm afraid that this is going to break things though, the calling
> > of the device-driver's suspend-late method at noirq time is
> > *intentional* !
>
> But it is a bug too.

Well, not strictly a bug, but a departure from a clearly established convention.

What happens is that the driver provides ->suspend_late and
->resume_early, because the upper layer normally would remove power
and power up the device at those stages, respectively.  However, due
to dependencies between devices, the upper layer kind of works around
its own limitation.

That is not straightforward at all.

I will retain this setup in the current patch series, but going
forward it would be good to clean it up.  I wonder if using
non-PM-runtime device links to represent the dependencies would work
in this case.
