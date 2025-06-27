Return-Path: <linux-pci+bounces-30918-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 775B2AEB612
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 13:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 272867A41E3
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 11:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F35229ACFC;
	Fri, 27 Jun 2025 11:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nTn3TdKn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B457280CF6;
	Fri, 27 Jun 2025 11:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751022893; cv=none; b=YwnrF+lJpIphD5TX8JvI6JLunWbjNH9fKB2kEWjjZrw2U5v4PpZRtVRbXvkBmiWa8bTq52xiNbAnp1RYb2Axl7dYYb+zi7Q2nYHhCK8s5U1fYte/HRIO5fAD5YVuflshKUZsbY796eyUbeLxZywMIGDp6w4lM5E4e+oKQOr8i5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751022893; c=relaxed/simple;
	bh=LlNXjuxd1lLlCWM3y57Dwt1ibKE5jXZxaa8JZNOTkUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dLFD37TSsPgse8gUbqfNytjVV4yCql4JicoRxDlUAn8BuJ/GYvpyB1G12hy0WRZYwlYY7eMya/4911f3zxDnAn8a4Q91HJ2pFt1M1Eo8IXdJ6rOugt9sPHd+MLNlcJ+vwzyP2cUlgHO/DYk3dCXWJFh85G47cRjGohOkajeYG4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nTn3TdKn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D23C5C4CEE3;
	Fri, 27 Jun 2025 11:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751022892;
	bh=LlNXjuxd1lLlCWM3y57Dwt1ibKE5jXZxaa8JZNOTkUA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nTn3TdKnMGd7f0uDS9+uSuOk0qitc5hQft4SstpYXZBragL13VQesT5i+Uxd1Nmi4
	 /eD5fhpqkSMqHc0bcG7KxtKCLsuWU53SdixMEPzx5K/cdHOyqRlVV6mvFLNEyQzlTk
	 4gBeF5RRzNmIZYy7CpNzHZvOTMp55+sox/pN3AqmvdwSphzUGFF86FNWukX3KiVRAF
	 Aih/7RxcBD83zyGAkf6kYLz4G8sUyLRnTBgiB/xdhUFLkjYqDPDReXIOXdGSWOqRyt
	 Bm1jPk5RaC2n9gHQuf8YuIWcw7vacVqXWzqfose/mJ+W9l0wBriZbmcojdrT/dH9cG
	 /Js/QzYmdALiw==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-60efc773b5fso1032530eaf.3;
        Fri, 27 Jun 2025 04:14:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVgwA29g+q4dOIk2iuUw6vU+fLeKdfE6LTE0qtOGlvCk9n6SKWkiMKXGK2VhdnZyhyJmBGYqb38Vjcy@vger.kernel.org, AJvYcCXwg9uBf+cMEIHfO/2qCVRSkbdXHvzsPbcuXPneEz/G6jkCnIiyh17yS2HcpSj8XFqkdF3joEeuT0Lg@vger.kernel.org
X-Gm-Message-State: AOJu0YxhY862FuKCMeZRaq1uTAG+ARd/bLLabc+43sybV0OMAjxMPOca
	MgtvzftStwOchzicOI0+lta6KbKSBdsoCyK7scIj5vtHdKU9yC+67Xd80aUE+8wEC2/X+PBiuL+
	C5Zh7Y+/yFXwQN5O3jeQ/KvZuESayqtU=
X-Google-Smtp-Source: AGHT+IFQVxX4WH/Cb65IXJpVCKwU7owSN3U3ENrl3vl2gB3cUZovGm8T4mZsyKFPeotBV4rWHfsHm+od3VTYBzpCPms=
X-Received: by 2002:a05:6820:180c:b0:611:b85f:b159 with SMTP id
 006d021491bc7-611b9015d61mr1942787eaf.1.1751022892079; Fri, 27 Jun 2025
 04:14:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5015172.GXAFRqVoOG@rjwysocki.net> <2336655.iZASKD2KPV@rjwysocki.net>
 <CAJZ5v0h4AMFfyBugjBwQOV=xY-Hq5kL_vB7Gwrj06N8vo6GQtg@mail.gmail.com>
In-Reply-To: <CAJZ5v0h4AMFfyBugjBwQOV=xY-Hq5kL_vB7Gwrj06N8vo6GQtg@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 27 Jun 2025 13:14:40 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h1F-N3-Ue5OqUPoORDtR=qwknX-yDNuqxbogEjidxooQ@mail.gmail.com>
X-Gm-Features: Ac12FXya15hOE4Ngrfdl2VtlXT84PHm_94erZvkil5gb3JYjBEpALp5Mz78nYbs
Message-ID: <CAJZ5v0h1F-N3-Ue5OqUPoORDtR=qwknX-yDNuqxbogEjidxooQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] PM: Check power.needs_force_resume in pm_runtime_force_suspend()
To: Linux PM <linux-pm@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	Linux PCI <linux-pci@vger.kernel.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 27, 2025 at 12:52=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.o=
rg> wrote:
>
> On Thu, Jun 26, 2025 at 8:15=E2=80=AFPM Rafael J. Wysocki <rjw@rjwysocki.=
net> wrote:
> >
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Add a power.needs_force_resume check to pm_runtime_force_suspend() so
> > it need not rely on the runtime PM status of the device when deciding
> > whether or not to return early.
> >
> > With the new check in place, pm_runtime_force_suspend() will also skip
> > devices with the runtime PM status equal to RPM_ACTIVE if they have
> > power.needs_force_resume set, so it won't need to change the RPM
> > status of the device to RPM_SUSPENDED in addition to setting
> > power.needs_force_resume in the case when pm_runtime_need_not_resume()
> > return false.
> >
> > This allows the runtime PM status update to be removed from
> > pm_runtime_force_resume(), so the runtime PM status remains unchanged
> > between the pm_runtime_force_suspend() and pm_runtime_force_resume()
> > calls.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > v1 -> v2: Corresponds to patch [2/9] (that was posted as [0/9] by mista=
ke) in v1.
> >
> > ---
> >  drivers/base/power/runtime.c |   21 ++++++++-------------
> >  1 file changed, 8 insertions(+), 13 deletions(-)
> >
> > --- a/drivers/base/power/runtime.c
> > +++ b/drivers/base/power/runtime.c
> > @@ -1973,7 +1973,7 @@
> >         int ret;
> >
> >         pm_runtime_disable(dev);
> > -       if (pm_runtime_status_suspended(dev))
> > +       if (pm_runtime_status_suspended(dev) || dev->power.needs_force_=
resume)
> >                 return 0;
> >
> >         callback =3D RPM_GET_CALLBACK(dev, runtime_suspend);
> > @@ -1988,15 +1988,16 @@
> >         /*
> >          * If the device can stay in suspend after the system-wide tran=
sition
> >          * to the working state that will follow, drop the children cou=
nter of
> > -        * its parent, but set its status to RPM_SUSPENDED anyway in ca=
se this
> > -        * function will be called again for it in the meantime.
> > +        * its parent and the usage counters of its suppliers.  Otherwi=
se, set
> > +        * power.needs_force_resume to let pm_runtime_force_resume() kn=
ow that
> > +        * the device needs to be taken care of and to prevent this fun=
ction
> > +        * from handling the device again in case the device is passed =
to it
> > +        * once more subsequently.
> >          */
> > -       if (pm_runtime_need_not_resume(dev)) {
> > +       if (pm_runtime_need_not_resume(dev))
> >                 pm_runtime_set_suspended(dev);
> > -       } else {
> > -               __update_runtime_status(dev, RPM_SUSPENDED);
> > +       else
> >                 dev->power.needs_force_resume =3D true;
> > -       }
>
> I kind of see that this change may confuse other things looking at the
> PM runtime status to determine whether or not the device needs to be
> suspended that possibly run after pm_runtime_force_suspend().
>
> I'm also not quite sure why I thought that this patch would be
> necessary in this series because the [5/9] should just work without
> it.
>
> Please disregard it unless you see why it is needed here.

Well, not quite.

It is needed, but not at this point.  That is,patch [5/9] will work
without it, but then it is needed for the PCI and ACPI PM to work with
pm_runtime_force_suspend().

Namely, say DPM_FLAG_SMART_SUSPEND is set and
pm_runtime_force_suspend() is used as a driver callback in the
"suspend" phase.  The PCI PM sets strict_midlayer, so
pm_runtime_force_suspend() runs the driver runtime PM callback
directly, but power still needs to be removed from the device.
However, pci_pm_suspend_noirq() checks dev_pm_skip_suspend() and it
will bail out if the device is RPM_SUSPENDED.

I guess I should reorder the patches and add the above bit of
explanation to the changelog of the $subject one.

If you can review patches [2-3/9] from this series, I'll be able to go
ahead with the first half of it and the rest can be resent separately.

Sorry for the confusion!

> >
> >         return 0;
> >
> > @@ -2029,12 +2030,6 @@
> >         if (!dev->power.needs_force_resume)
> >                 goto out;
> >
> > -       /*
> > -        * The value of the parent's children counter is correct alread=
y, so
> > -        * just update the status of the device.
> > -        */
> > -       __update_runtime_status(dev, RPM_ACTIVE);
> > -
> >         callback =3D RPM_GET_CALLBACK(dev, runtime_resume);
> >
> >         dev_pm_disable_wake_irq_check(dev, false);
> >
> >
> >
> >

