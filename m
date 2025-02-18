Return-Path: <linux-pci+bounces-21730-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B40A2A39CA4
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 14:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 666783A9724
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 13:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032332500BF;
	Tue, 18 Feb 2025 13:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NopPGMoC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C5024336B;
	Tue, 18 Feb 2025 13:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739883633; cv=none; b=qsyEqR71AtjnzOPvorQRY4UvqG35+xLFYjDMG2BiqKLqLZ9pWEmLmBN+YGtn3DzU0J3t37u6135pvRLrjcHVnY4p7m/edaimApmuBYwrZ5AmUjtKl5LHps7VTJjvoO8AVA+wcOKDangElikwENO+BMA93OMgJwDAj4r9r/TunMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739883633; c=relaxed/simple;
	bh=kbbKpE1RfTW0FfgUrkW7wYjgwM+Dvgnqkuu5R4x8zM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dFBnFlWESTw7YagJg/YC3qt+oWgpHFJFVjaNy0sEAz+MTswUyOmUDKIYdA/nQGrCx8SmGDi+x9/E3yzH/HpgewiecQQ2vJaG5nk5SPlLZUGbD56+hUIZ5GtK4nFK04g5AUcm+1RHM+OIuez+1QgElXnVEvNqX+7F5UDMzuT0YO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NopPGMoC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43633C4CEE8;
	Tue, 18 Feb 2025 13:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739883633;
	bh=kbbKpE1RfTW0FfgUrkW7wYjgwM+Dvgnqkuu5R4x8zM8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NopPGMoCwbigZJ6HZiMLQPrjwz0LoDUtn26Ld3K1vgTHlI9cxOXMB82K2OFXD5zfu
	 Nbf1SZ8hhhLXib7FtEIP6r4zcLXArlq0GConyv+BUx2KD/J1gvTDSGl3vjCNBeaKlQ
	 ZXRdDPFw07Cs4qyUsFV7aHKIUf6dcqOcJPPAJ+4xy3opS6W1tZx14r/s5ewQeCmuSr
	 hckd9KBiezehK9D6y6T2WeKxeSc8EdeIWAY3H7s0yiizdVQuDsbWdndJu85ia1yt3H
	 MALgQ9ADLwR6W8f0pYr16lq4lDzNSHEqw3QO6hZaZ5Qn7T5QMfecSDxzYUIvJzw55z
	 oWFgvS+30bZ9w==
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3f3f4890596so1247495b6e.2;
        Tue, 18 Feb 2025 05:00:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUf9XUpN9PwuWu6rwl4Bo4PkxJkdOx3NF/b5XPBEfcgOPxEwa50JomUmnGZ+COTOdEuXMt+XKLLJnmypEfq@vger.kernel.org, AJvYcCUxeA9wQEg0zK5caoM0ZA6iVbeX/aPrawBnPaIvKUtCbfC9F3lEJv7HuS/wrDBUuYeO6hgeWNpoI4c=@vger.kernel.org, AJvYcCUyPOyQrggqqq1vU3CiMiTvgMWl2BO895/L2r30TP9OwYKM4wVe50g7yajImW5z5tly4NrOVPdD2aNQ@vger.kernel.org, AJvYcCXZCTqNSyfW9qu1zGDMgZsxg5GXDIuS6FPdVQ0BcV1fb+mjSaYjcILJA4sH4WssiytqaFGftZKCdW/y@vger.kernel.org
X-Gm-Message-State: AOJu0YyBqmByIq5+qFb8L+vs4hbTvC+/YmpQ6rjU3IWkbeKLbGAjrBPo
	75Mte/mpzq7F3NVCQviNpTmPlwXeUQPrmT4jMVJPOe8AxdoYLMuxLwjKuZNd+jRROWMLfYsNDhZ
	3gC5F9l8qk5zy8ENUXW4r2YV7sBQ=
X-Google-Smtp-Source: AGHT+IHLCE2CvMrhafvCUGtIRI1GLD8xe84QBTzCr+3bhdCXzTFVTMSKKucInjaJ7hfyPAYGZmL2ZakM2AxBGzsGHMo=
X-Received: by 2002:a05:6808:1314:b0:3f3:ea3f:bfa9 with SMTP id
 5614622812f47-3f3eb15a247mr7797898b6e.34.1739883632479; Tue, 18 Feb 2025
 05:00:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4966939.GXAFRqVoOG@rjwysocki.net> <2000822.PYKUYFuaPT@rjwysocki.net>
 <CAPDyKFoB0fQCabahYpx=A_Ns7vJgWYdK=rxuHk+XHVv35cFvWQ@mail.gmail.com>
In-Reply-To: <CAPDyKFoB0fQCabahYpx=A_Ns7vJgWYdK=rxuHk+XHVv35cFvWQ@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 18 Feb 2025 14:00:21 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iHsOw4_UbEWGk_-jPpc3q2K3fUXBs4T3JCooPGV10CHQ@mail.gmail.com>
X-Gm-Features: AWEUYZmyfSSE72o_hkbFbpUjcrioCcW94jhQxKsdgLG4yq5EU7gyRDuTXRiZcH4
Message-ID: <CAJZ5v0iHsOw4_UbEWGk_-jPpc3q2K3fUXBs4T3JCooPGV10CHQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] PM: sleep: Use DPM_FLAG_SMART_SUSPEND conditionally
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
	Bjorn Helgaas <helgaas@kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, 
	Johan Hovold <johan@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Jon Hunter <jonathanh@nvidia.com>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Saravana Kannan <saravanak@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 1:49=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
>
> + Saravana
>
> On Mon, 17 Feb 2025 at 21:19, Rafael J. Wysocki <rjw@rjwysocki.net> wrote=
:
> >
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > A recent discussion has revealed that using DPM_FLAG_SMART_SUSPEND
> > unconditionally is generally problematic because it may lead to
> > situations in which the device's runtime PM information is internally
> > inconsistent or does not reflect its real state [1].
> >
> > For this reason, change the handling of DPM_FLAG_SMART_SUSPEND so that
> > it is only taken into account if it is consistently set by the drivers
> > of all devices having any PM callbacks throughout dependency graphs in
> > accordance with the following rules:
> >
> >  - The "smart suspend" feature is only enabled for devices whose driver=
s
> >    ask for it (that is, set DPM_FLAG_SMART_SUSPEND) and for devices
> >    without PM callbacks unless they have never had runtime PM enabled.
> >
> >  - The "smart suspend" feature is not enabled for a device if it has no=
t
> >    been enabled for the device's parent unless the parent does not take
> >    children into account or it has never had runtime PM enabled.
> >
> >  - The "smart suspend" feature is not enabled for a device if it has no=
t
> >    been enabled for one of the device's suppliers taking runtime PM int=
o
> >    account unless that supplier has never had runtime PM enabled.
> >
> > Namely, introduce a new device PM flag called smart_suspend that is onl=
y
> > set if the above conditions are met and update all DPM_FLAG_SMART_SUSPE=
ND
> > users to check power.smart_suspend instead of directly checking the
> > latter.
> >
> > At the same time, drop the power.set_active flage introduced recently
> > in commit 3775fc538f53 ("PM: sleep: core: Synchronize runtime PM status
> > of parents and children") because it is now sufficient to check
> > power.smart_suspend along with the dev_pm_skip_resume() return value
> > to decide whether or not pm_runtime_set_active() needs to be called
> > for the device.
> >
> > Link: https://lore.kernel.org/linux-pm/CAPDyKFroyU3YDSfw_Y6k3giVfajg3NQ=
GwNWeteJWqpW29BojhQ@mail.gmail.com/  [1]
> > Fixes: 7585946243d6 ("PM: sleep: core: Restrict power.set_active propag=
ation")
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/acpi/device_pm.c  |    6 +---
> >  drivers/base/power/main.c |   63 +++++++++++++++++++++++++++++++++++--=
---------
> >  drivers/mfd/intel-lpss.c  |    2 -
> >  drivers/pci/pci-driver.c  |    6 +---
> >  include/linux/pm.h        |    2 -
> >  5 files changed, 55 insertions(+), 24 deletions(-)
> >
> > --- a/drivers/acpi/device_pm.c
> > +++ b/drivers/acpi/device_pm.c
> > @@ -1161,8 +1161,7 @@
> >   */
> >  int acpi_subsys_suspend(struct device *dev)
> >  {
> > -       if (!dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND) ||
> > -           acpi_dev_needs_resume(dev, ACPI_COMPANION(dev)))
> > +       if (!dev->power.smart_suspend || acpi_dev_needs_resume(dev, ACP=
I_COMPANION(dev)))
>
> Nitpick: Rather than checking the dev->power.smart_suspend flag
> directly here, perhaps we should provide a helper function that
> returns true when dev->power.smart_suspend is set? In this way, it's
> the PM core soley that operates on the flag.

I can add a wrapper around this, sure.

> >                 pm_runtime_resume(dev);
> >
> >         return pm_generic_suspend(dev);
> > @@ -1320,8 +1319,7 @@
> >   */
> >  int acpi_subsys_poweroff(struct device *dev)
> >  {
> > -       if (!dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND) ||
> > -           acpi_dev_needs_resume(dev, ACPI_COMPANION(dev)))
> > +       if (!dev->power.smart_suspend || acpi_dev_needs_resume(dev, ACP=
I_COMPANION(dev)))
> >                 pm_runtime_resume(dev);
> >
> >         return pm_generic_poweroff(dev);
> > --- a/drivers/base/power/main.c
> > +++ b/drivers/base/power/main.c
> > @@ -656,15 +656,13 @@
> >          * so change its status accordingly.
> >          *
> >          * Otherwise, the device is going to be resumed, so set its PM-=
runtime
> > -        * status to "active" unless its power.set_active flag is clear=
, in
> > +        * status to "active" unless its power.smart_suspend flag is cl=
ear, in
> >          * which case it is not necessary to update its PM-runtime stat=
us.
> >          */
> > -       if (skip_resume) {
> > +       if (skip_resume)
> >                 pm_runtime_set_suspended(dev);
> > -       } else if (dev->power.set_active) {
> > +       else if (dev->power.smart_suspend)
> >                 pm_runtime_set_active(dev);
> > -               dev->power.set_active =3D false;
> > -       }
> >
> >         if (dev->pm_domain) {
> >                 info =3D "noirq power domain ";
> > @@ -1282,14 +1280,8 @@
> >               dev->power.may_skip_resume))
> >                 dev->power.must_resume =3D true;
> >
> > -       if (dev->power.must_resume) {
> > -               if (dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEN=
D)) {
> > -                       dev->power.set_active =3D true;
> > -                       if (dev->parent && !dev->parent->power.ignore_c=
hildren)
> > -                               dev->parent->power.set_active =3D true;
> > -               }
> > +       if (dev->power.must_resume)
> >                 dpm_superior_set_must_resume(dev);
> > -       }
> >
> >  Complete:
> >         complete_all(&dev->power.completion);
> > @@ -1797,6 +1789,49 @@
> >         return error;
> >  }
> >
> > +static void device_prepare_smart_suspend(struct device *dev)
> > +{
> > +       struct device_link *link;
> > +       int idx;
> > +
> > +       /*
> > +        * The "smart suspend" feature is enabled for devices whose dri=
vers ask
> > +        * for it and for devices without PM callbacks unless runtime P=
M is
> > +        * disabled and enabling it is blocked for them.
> > +        *
> > +        * However, if "smart suspend" is not enabled for the device's =
parent
> > +        * or any of its suppliers that take runtime PM into account, i=
t cannot
> > +        * be enabled for the device either.
> > +        */
> > +       dev->power.smart_suspend =3D (dev->power.no_pm_callbacks ||
> > +               dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND)) =
&&
> > +               !pm_runtime_blocked(dev);
> > +
> > +       if (!dev->power.smart_suspend)
> > +               return;
> > +
> > +       if (dev->parent && !pm_runtime_blocked(dev->parent) &&
> > +           !dev->parent->power.ignore_children && !dev->parent->power.=
smart_suspend) {
> > +               dev->power.smart_suspend =3D false;
> > +               return;
> > +       }
> > +
> > +       idx =3D device_links_read_lock();
> > +
> > +       list_for_each_entry_rcu_locked(link, &dev->links.suppliers, c_n=
ode) {
> > +               if (!(link->flags | DL_FLAG_PM_RUNTIME))
> > +                       continue;
> > +
> > +               if (!pm_runtime_blocked(link->supplier) &&
> > +                   !link->supplier->power.smart_suspend) {
>
> This requires device_prepare() for all suppliers to be run before its
> consumer. Is that always the case?

Yes, it is by design.

> > +                       dev->power.smart_suspend =3D false;
> > +                       break;
> > +               }
> > +       }
> > +
> > +       device_links_read_unlock(idx);
>
> From an execution overhead point of view, did you check if the above
> code had some measurable impact on the latency for dpm_prepare()?

It didn't on my systems.

For the vast majority of devices the overhead is just checking
power.no_pm_callbacks and DPM_FLAG_SMART_SUSPEND.  For some,
pm_runtime_blocked() needs to be called which requires grabbing a
spinlock and there are only a few with power.smart_suspend set to
start with.

I'm wondering why you didn't have this concern regarding other changes
that involved walking suppliers or consumers, though.

