Return-Path: <linux-pci+bounces-20550-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7987A2226C
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2025 17:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBE8818891AF
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2025 16:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F8A1DF99B;
	Wed, 29 Jan 2025 16:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ipJROHSe"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FEC1AD403;
	Wed, 29 Jan 2025 16:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738169921; cv=none; b=O581QSwXqBSowTvXoIrOferh1JrGophiI///rLkkdi/u38Wvu070iRAChGjoBNTXIMLsc47xKsn+a6Sk+iimKhZrvtChiAoKOm/53cKel5kTjqIo3gwhq27So7qaeC70vhch8aVtOY8ZO9weaurIZHGowKAPCmromIgdjRNvyfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738169921; c=relaxed/simple;
	bh=qaxUN+/Y/uwHhbiXfnVR6P6P/xRg6IOiDfx03zNeL/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=skMzazRdqkOghXGuTamAj4C7etaq+Dl4dLzK8DD6L08wvpw1FJYivD10VaNZ6O3U5ywWjbWjxZT+QruyZtPCv4XZ961364IZOqE3jCjVYQOkTFnBhkawMxqfvcZQ2w26kkMSMoUOoshI7Q/4WVefgn7GkhFiWcWQ3CFhRIDnPik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ipJROHSe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CDFEC4CED1;
	Wed, 29 Jan 2025 16:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738169920;
	bh=qaxUN+/Y/uwHhbiXfnVR6P6P/xRg6IOiDfx03zNeL/4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ipJROHSeiFO7p/TzGg4QA8AaEuQG7ugmr6JD7iF5B6CLbXZOMWvD3rVd7UAjRbR1j
	 ck8Bkq759HSsNviMzBA78URVQ9O+a9IQVuUkGeb1Kim1TP5EnH+CqZRh6UWrRf7NQ6
	 U/S9Pq1oXE2Y/lDePRG/rHknOYIXCulk1lhF08CtX42gfcmAzWN42bpvukudONSocn
	 7CnbcF/R216z1HAAJ2ccYXNCiW3kmZIdzIR8GHgUcjX263K9aopW7DNOnVGGKQ8sYM
	 nzvdjUCXxMNtUyD3yCoTSCHSz1luhR8x41KynENfSQNRuxwmdFPoRIOHS/2WHzvs4U
	 vw+rEZEsrFO+w==
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3f1c94936c5so506836b6e.1;
        Wed, 29 Jan 2025 08:58:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW8IZxHhYz87+sz2rf1Qa8OIyH7ee0P7gslA8JJw5J2sJhlvh5YTvnvNBpcfAcuEbgmqun/zKCxBsqAk94=@vger.kernel.org, AJvYcCWa8ckxnLa87iLWAJmX9Z1tu9ICKlCiy9HUIH4rH3cZo+6VlQdA1BIMBuAsZY/a8p7pmGpgnxmT6bE=@vger.kernel.org, AJvYcCXkrB+MWpJc3zNvIQIKPKXtfstR70tnOnKL6W0xYPCCGYis64wt2fq4qADtlTcs9wMajpG8jtt21XHD@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2D4dboLf9qDSXq85JiRupd6F0siu2agA54hzmwdfPMHdtBWXT
	65pigbWTxwlqpos/ZiYKGj2KqgvkEwMEEcaz/f5gNz3zeDi5DN3hPFycWItPNsSM0KvPu6prjvz
	HMkzowJipCKobAFeQE7XKNBpq5Jk=
X-Google-Smtp-Source: AGHT+IFvXrlhL1uR98OSW+elA8MvVsTtI0kiMCzp6MNetwKUR4K11du3MyoasJ0464MBpvkhZkWGnI1HQQJ0dIXz/lc=
X-Received: by 2002:a05:6808:3990:b0:3eb:615a:eccf with SMTP id
 5614622812f47-3f330e71152mr16188b6e.10.1738169919812; Wed, 29 Jan 2025
 08:58:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12619233.O9o76ZdvQC@rjwysocki.net> <CAPDyKFpc5p3sXZ6LfdVgt8jR5ZbsQExTgeyMNA-PzcWs5A9U0A@mail.gmail.com>
 <CAJZ5v0gvQjp_P-5Ww7iN1cGiiMJ6tvLLnPpkTQNk++KhoRe=GA@mail.gmail.com> <CAPDyKFrBO+r8qYRrhoFZN21__8RuR61ofbsGQZbA=pyQbti5CA@mail.gmail.com>
In-Reply-To: <CAPDyKFrBO+r8qYRrhoFZN21__8RuR61ofbsGQZbA=pyQbti5CA@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 29 Jan 2025 17:58:27 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jTutgKeXtg3YLR1Onw9gOmvHudHamVVgMxEsieNDXViw@mail.gmail.com>
X-Gm-Features: AWEUYZkr-iKmQH46s-jjftIBAu31tZZjQuFbYM8a4rTD-Sjtk9eLSYyF8yZEFmw
Message-ID: <CAJZ5v0jTutgKeXtg3YLR1Onw9gOmvHudHamVVgMxEsieNDXViw@mail.gmail.com>
Subject: Re: [PATCH v1] PM: sleep: core: Synchronize runtime PM status of
 parents and children
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Alan Stern <stern@rowland.harvard.edu>, Bjorn Helgaas <helgaas@kernel.org>, 
	Linux PCI <linux-pci@vger.kernel.org>, Johan Hovold <johan@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Kevin Xie <kevin.xie@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 29, 2025 at 5:42=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
>
> On Wed, 29 Jan 2025 at 16:55, Rafael J. Wysocki <rafael@kernel.org> wrote=
:
> >
> > On Wed, Jan 29, 2025 at 12:53=E2=80=AFPM Ulf Hansson <ulf.hansson@linar=
o.org> wrote:
> > >
> > > On Tue, 28 Jan 2025 at 20:24, Rafael J. Wysocki <rjw@rjwysocki.net> w=
rote:
> > > >
> > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > >
> > > > Commit 6e176bf8d461 ("PM: sleep: core: Do not skip callbacks in the
> > > > resume phase") overlooked the case in which the parent of a device =
with
> > > > DPM_FLAG_SMART_SUSPEND set did not use that flag and could be runti=
me-
> > > > suspended before a transition into a system-wide sleep state.  In t=
hat
> > > > case, if the child is resumed during the subsequent transition from
> > > > that state into the working state, its runtime PM status will be se=
t to
> > > > RPM_ACTIVE, but the runtime PM status of the parent will not be upd=
ated
> > > > accordingly, even though the parent will be resumed too, because of=
 the
> > > > dev_pm_skip_suspend() check in device_resume_noirq().
> > > >
> > > > Address this problem by tracking the need to set the runtime PM sta=
tus
> > > > to RPM_ACTIVE during system-wide resume transitions for devices wit=
h
> > > > DPM_FLAG_SMART_SUSPEND set and all of the devices depended on by th=
em.
> > > >
> > > > Fixes: 6e176bf8d461 ("PM: sleep: core: Do not skip callbacks in the=
 resume phase")
> > > > Closes: https://lore.kernel.org/linux-pm/Z30p2Etwf3F2AUvD@hovoldcon=
sulting.com/
> > > > Reported-by: Johan Hovold <johan@kernel.org>
> > > > Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > ---
> > > >  drivers/base/power/main.c |   29 ++++++++++++++++++++---------
> > > >  include/linux/pm.h        |    1 +
> > > >  2 files changed, 21 insertions(+), 9 deletions(-)
> > > >
> > > > --- a/drivers/base/power/main.c
> > > > +++ b/drivers/base/power/main.c
> > > > @@ -656,13 +656,15 @@
> > > >          * so change its status accordingly.
> > > >          *
> > > >          * Otherwise, the device is going to be resumed, so set its=
 PM-runtime
> > > > -        * status to "active", but do that only if DPM_FLAG_SMART_S=
USPEND is set
> > > > -        * to avoid confusing drivers that don't use it.
> > > > +        * status to "active" unless its power.set_active flag is c=
lear, in
> > > > +        * which case it is not necessary to update its PM-runtime =
status.
> > > >          */
> > > > -       if (skip_resume)
> > > > +       if (skip_resume) {
> > > >                 pm_runtime_set_suspended(dev);
> > > > -       else if (dev_pm_skip_suspend(dev))
> > > > +       } else if (dev->power.set_active) {
> > > >                 pm_runtime_set_active(dev);
> > > > +               dev->power.set_active =3D false;
> > > > +       }
> > > >
> > > >         if (dev->pm_domain) {
> > > >                 info =3D "noirq power domain ";
> > > > @@ -1189,18 +1191,24 @@
> > > >         return PMSG_ON;
> > > >  }
> > > >
> > > > -static void dpm_superior_set_must_resume(struct device *dev)
> > > > +static void dpm_superior_set_must_resume(struct device *dev, bool =
set_active)
> > > >  {
> > > >         struct device_link *link;
> > > >         int idx;
> > > >
> > > > -       if (dev->parent)
> > > > +       if (dev->parent) {
> > > >                 dev->parent->power.must_resume =3D true;
> > > > +               if (set_active)
> > > > +                       dev->parent->power.set_active =3D true;
> > > > +       }
> > > >
> > > >         idx =3D device_links_read_lock();
> > > >
> > > > -       list_for_each_entry_rcu_locked(link, &dev->links.suppliers,=
 c_node)
> > > > +       list_for_each_entry_rcu_locked(link, &dev->links.suppliers,=
 c_node) {
> > > >                 link->supplier->power.must_resume =3D true;
> > > > +               if (set_active)
> > > > +                       link->supplier->power.set_active =3D true;
> > >
> > > If I understand correctly, the suppliers are already handled when the
> > > pm_runtime_set_active() is called for consumers, so the above should
> > > not be needed.
> >
> > It is needed because pm_runtime_set_active() doesn't cause the setting
> > to propagate to the parent's/suppliers of the suppliers AFAICS.
>
> Hmm, even if that sounds reasonable, I don't think it's a good idea as
> it may introduce interesting propagation problems between drivers.
>
> For example, consider that Saravana is trying to enable runtime PM for
> fw_devlinks. It would mean synchronization issues for the runtime PM
> status, all over the place.

What synchronization issues?

> That said, is even consumer/suppliers part of the problem we are
> trying to solve?

They are in general.

It's just that stuff that was runtime-suspended prior to a system-wide
suspend may need to be resumed and marked as RPM_ACTIVE during
system-wide resume because one of the devices wants/needs to be
resumed then.

If this turns out to be problematic, the problem will need to be
addressed, but for now I'm not seeing why there would be a problem.

> >
> > > That said, maybe we instead allow parent/child to work in the similar
> > > way as for consumer/suppliers, when pm_runtime_set_active() is called
> > > for the child. In other words, when pm_runtime_set_active() is called
> > > for a child and the parent is runtime PM enabled, let's runtime resum=
e
> > > it too, as we do for suppliers. Would that work, you think?
> >
> > The parent is not runtime-PM enabled when this happens.
>
> That sounds really weird to me.
>
> Does that mean that the parent has not been system resumed either?

Yes.

It hasn't been resumed yet, but it is known that it will be resumed.

> If so, isn't that really the root cause for this problem,

No, it is not.

> or what am I missing?

Essentially, what I said above.

If a device that was suspended prior to a system-wide suspend
wants/needs to be resumed during the subsequent system-wide resume,
and it was runtime-PM-enabled before the suspend transition, it needs
to (a) be runtime-PM-enabled during the subsequent system-wide resume
transition and (b) it also needs to be marked as RPM_ACTIVE because in
fact it is not suspended any more.  The existing code before the patch
takes care of this for the device itself, but not for the devices it
depends on which also need to be resumed (which happens) and marked as
RPM_ACTIVE (which doesn't happen) and the patch just makes sure that
the latter will happen.

Actually, what happens now is that the actual state of the parent
during the system-wide resume, right before re-enabling runtime PM for
it, does not match its runtime PM status which is still RPM_SUSPENDED.
That's what is fixed here and it applies to the parent as well as to
all of the other devices depended on by the child and the parent.

