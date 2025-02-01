Return-Path: <linux-pci+bounces-20621-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B48AA2490C
	for <lists+linux-pci@lfdr.de>; Sat,  1 Feb 2025 13:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AC0B7A27DF
	for <lists+linux-pci@lfdr.de>; Sat,  1 Feb 2025 12:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB46019CC20;
	Sat,  1 Feb 2025 12:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RMhrRqAI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA79AD39;
	Sat,  1 Feb 2025 12:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738413359; cv=none; b=LS4DNrMbhBPd4AcstRSgfcEwgzvLwzEiRpps4S0ROhf/R80+v0Yr+P2HnChcoknAzweU5cX6JcdF9NEJcvtktlNs09Xee5uQ3RJYvG7tgNAmMDsuU19KTPKnvUiqBXIZlSVDVyJEfh9IUo0hVu8Fu7lsL0k+Scv8W0BwieP2VU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738413359; c=relaxed/simple;
	bh=RgMmX8KiM6ihpw0PWKKTKRNdVYUqPLP5yB825c9Ru9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rQLS/xRqEB8Dl7x04bpYC5kpr7o7weeyFJCk+JtEKIXu252mqw39500OrY/QV6WJn1/7zhnC9WnocOzhLus+KCe9PZxkfd2DpJH5nyHEiIMb4eQL9cMzUxa06pQj23lpvjM5V/ZmuG4jZNgzDTSmvdRkMK9GG7M5jho9nUmV1+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RMhrRqAI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EB93C4CEE5;
	Sat,  1 Feb 2025 12:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738413359;
	bh=RgMmX8KiM6ihpw0PWKKTKRNdVYUqPLP5yB825c9Ru9U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RMhrRqAIEHavSF8Gd9xYEbhejT6MF1E5nzxupPB3LvbxVp6cANnvyJ/pooEiPFgnj
	 58IoYxu+JXVNxQpCIyP37DJw+u8IJoVRJwHRCYuK9QDgHvhSfKd2UpDMHY2tSo+g1n
	 VzvEA+8zJbbWBCJaHpAFAy2oCQ8d6o1QtD0xuVZTqzFw/2ZEMo04gk48iScd4ApGzE
	 XHChdjwyvwdXvKmNwzKqyR6xxj675D0Bi9wDpcTqV1+s0Vc4gbJtU8G1w8SXFr0jRE
	 4G8sNkksFU8bKWsSgccJkFlMiXLvy2DBU11USmKG/GCzm6rdSUmIu9GzYkUFMJl8Kc
	 WviaXFf3T9EWw==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2a3d8857a2bso1513035fac.1;
        Sat, 01 Feb 2025 04:35:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVYH+7TyzR20EEXz0C2paQ0Skm/Qy/M3iVkeqeVda85nKguFEdIEsLywnvNRQ8/U8ohtN1+L90y0kYh@vger.kernel.org, AJvYcCVxLGjoCQfHuTbD7u11EyqSB4UC7dx2Jq3Yxkfkf5vEn6ngEl34LCX5PL2kCbcKhbpWTf2vzzsT5U4=@vger.kernel.org, AJvYcCWXvWj5i7dOTV2SwgysVOeUDqSoCX4axUKZWMDpqta9npf0GzgdMUy5q3RrrSg63z2IFr4ZofN/k8chTmo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBrCdj7NneFroRiWFU0Vt2MXNxtrNsbTjftvhN3/5JLQgzY4Br
	CK8PLFCBLTQQBnx5GDUQAtsuuZf7PiPzQnxybNRWRs8pj+95eSMnBkROWbXdyNLU2MOhAj/pE7Y
	7ALREGjaJWnzgktxrwG2dtcS6ZRw=
X-Google-Smtp-Source: AGHT+IETPNEbQmNEnmo7eepKnCD9va+98QbDghNLEv6/+wzGxkNSrWBTfzSjL082zcsi+BOlYUmeQoHZKnSEwWrJuWc=
X-Received: by 2002:a05:6870:7d8e:b0:29e:4d0e:a2b6 with SMTP id
 586e51a60fabf-2b32f056aa4mr9510761fac.10.1738413358150; Sat, 01 Feb 2025
 04:35:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12619233.O9o76ZdvQC@rjwysocki.net> <CAPDyKFpc5p3sXZ6LfdVgt8jR5ZbsQExTgeyMNA-PzcWs5A9U0A@mail.gmail.com>
 <CAJZ5v0gvQjp_P-5Ww7iN1cGiiMJ6tvLLnPpkTQNk++KhoRe=GA@mail.gmail.com>
 <CAPDyKFrBO+r8qYRrhoFZN21__8RuR61ofbsGQZbA=pyQbti5CA@mail.gmail.com>
 <CAJZ5v0jTutgKeXtg3YLR1Onw9gOmvHudHamVVgMxEsieNDXViw@mail.gmail.com>
 <CAPDyKFpmNPhyV3YoBFu7KnW04550DQgqzGHAbGLLqp7=TggVtw@mail.gmail.com>
 <CAJZ5v0iYHBeMra_ba-1Ht4xoPGsyt7gg05RtGxoa_gG91s1xEA@mail.gmail.com> <CAPDyKFqkqOXD0oVZoOFR4O6ucqLS4n85_S4SNPvPAc6hfaELgw@mail.gmail.com>
In-Reply-To: <CAPDyKFqkqOXD0oVZoOFR4O6ucqLS4n85_S4SNPvPAc6hfaELgw@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sat, 1 Feb 2025 13:35:47 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jAEJ7DPS4yarwL5Nx_8EVNR0XepjnsCdNuM4pF=Cw9bg@mail.gmail.com>
X-Gm-Features: AWEUYZmoiyPGi_H9u0_JWhgECfp7HjJdmTWVS63Vge6ROEPYWqrLo-ASsOl7WsI
Message-ID: <CAJZ5v0jAEJ7DPS4yarwL5Nx_8EVNR0XepjnsCdNuM4pF=Cw9bg@mail.gmail.com>
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

On Fri, Jan 31, 2025 at 11:02=E2=80=AFAM Ulf Hansson <ulf.hansson@linaro.or=
g> wrote:
>
> On Thu, 30 Jan 2025 at 14:19, Rafael J. Wysocki <rafael@kernel.org> wrote=
:
> >
> > On Thu, Jan 30, 2025 at 12:11=E2=80=AFPM Ulf Hansson <ulf.hansson@linar=
o.org> wrote:
> > >
> > > On Wed, 29 Jan 2025 at 17:58, Rafael J. Wysocki <rafael@kernel.org> w=
rote:
> > > >
> > > > On Wed, Jan 29, 2025 at 5:42=E2=80=AFPM Ulf Hansson <ulf.hansson@li=
naro.org> wrote:
> > > > >
> > > > > On Wed, 29 Jan 2025 at 16:55, Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
> > > > > >
> > > > > > On Wed, Jan 29, 2025 at 12:53=E2=80=AFPM Ulf Hansson <ulf.hanss=
on@linaro.org> wrote:
> > > > > > >
> > > > > > > On Tue, 28 Jan 2025 at 20:24, Rafael J. Wysocki <rjw@rjwysock=
i.net> wrote:
> > > > > > > >
> > > > > > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > > > > >
> > > > > > > > Commit 6e176bf8d461 ("PM: sleep: core: Do not skip callback=
s in the
> > > > > > > > resume phase") overlooked the case in which the parent of a=
 device with
> > > > > > > > DPM_FLAG_SMART_SUSPEND set did not use that flag and could =
be runtime-
> > > > > > > > suspended before a transition into a system-wide sleep stat=
e.  In that
> > > > > > > > case, if the child is resumed during the subsequent transit=
ion from
> > > > > > > > that state into the working state, its runtime PM status wi=
ll be set to
> > > > > > > > RPM_ACTIVE, but the runtime PM status of the parent will no=
t be updated
> > > > > > > > accordingly, even though the parent will be resumed too, be=
cause of the
> > > > > > > > dev_pm_skip_suspend() check in device_resume_noirq().
> > > > > > > >
> > > > > > > > Address this problem by tracking the need to set the runtim=
e PM status
> > > > > > > > to RPM_ACTIVE during system-wide resume transitions for dev=
ices with
> > > > > > > > DPM_FLAG_SMART_SUSPEND set and all of the devices depended =
on by them.
> > > > > > > >
> > > > > > > > Fixes: 6e176bf8d461 ("PM: sleep: core: Do not skip callback=
s in the resume phase")
> > > > > > > > Closes: https://lore.kernel.org/linux-pm/Z30p2Etwf3F2AUvD@h=
ovoldconsulting.com/
> > > > > > > > Reported-by: Johan Hovold <johan@kernel.org>
> > > > > > > > Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@lin=
aro.org>
> > > > > > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.co=
m>
> > > > > > > > ---
> > > > > > > >  drivers/base/power/main.c |   29 ++++++++++++++++++++-----=
----
> > > > > > > >  include/linux/pm.h        |    1 +
> > > > > > > >  2 files changed, 21 insertions(+), 9 deletions(-)
> > > > > > > >
> > > > > > > > --- a/drivers/base/power/main.c
> > > > > > > > +++ b/drivers/base/power/main.c
> > > > > > > > @@ -656,13 +656,15 @@
> > > > > > > >          * so change its status accordingly.
> > > > > > > >          *
> > > > > > > >          * Otherwise, the device is going to be resumed, so=
 set its PM-runtime
> > > > > > > > -        * status to "active", but do that only if DPM_FLAG=
_SMART_SUSPEND is set
> > > > > > > > -        * to avoid confusing drivers that don't use it.
> > > > > > > > +        * status to "active" unless its power.set_active f=
lag is clear, in
> > > > > > > > +        * which case it is not necessary to update its PM-=
runtime status.
> > > > > > > >          */
> > > > > > > > -       if (skip_resume)
> > > > > > > > +       if (skip_resume) {
> > > > > > > >                 pm_runtime_set_suspended(dev);
> > > > > > > > -       else if (dev_pm_skip_suspend(dev))
> > > > > > > > +       } else if (dev->power.set_active) {
> > > > > > > >                 pm_runtime_set_active(dev);
> > > > > > > > +               dev->power.set_active =3D false;
> > > > > > > > +       }
> > > > > > > >
> > > > > > > >         if (dev->pm_domain) {
> > > > > > > >                 info =3D "noirq power domain ";
> > > > > > > > @@ -1189,18 +1191,24 @@
> > > > > > > >         return PMSG_ON;
> > > > > > > >  }
> > > > > > > >
> > > > > > > > -static void dpm_superior_set_must_resume(struct device *de=
v)
> > > > > > > > +static void dpm_superior_set_must_resume(struct device *de=
v, bool set_active)
> > > > > > > >  {
> > > > > > > >         struct device_link *link;
> > > > > > > >         int idx;
> > > > > > > >
> > > > > > > > -       if (dev->parent)
> > > > > > > > +       if (dev->parent) {
> > > > > > > >                 dev->parent->power.must_resume =3D true;
> > > > > > > > +               if (set_active)
> > > > > > > > +                       dev->parent->power.set_active =3D t=
rue;
> > > > > > > > +       }
> > > > > > > >
> > > > > > > >         idx =3D device_links_read_lock();
> > > > > > > >
> > > > > > > > -       list_for_each_entry_rcu_locked(link, &dev->links.su=
ppliers, c_node)
> > > > > > > > +       list_for_each_entry_rcu_locked(link, &dev->links.su=
ppliers, c_node) {
> > > > > > > >                 link->supplier->power.must_resume =3D true;
> > > > > > > > +               if (set_active)
> > > > > > > > +                       link->supplier->power.set_active =
=3D true;
> > > > > > >
> > > > > > > If I understand correctly, the suppliers are already handled =
when the
> > > > > > > pm_runtime_set_active() is called for consumers, so the above=
 should
> > > > > > > not be needed.
> > > > > >
> > > > > > It is needed because pm_runtime_set_active() doesn't cause the =
setting
> > > > > > to propagate to the parent's/suppliers of the suppliers AFAICS.
> > > > >
> > > > > Hmm, even if that sounds reasonable, I don't think it's a good id=
ea as
> > > > > it may introduce interesting propagation problems between drivers=
.
> > > > >
> > > > > For example, consider that Saravana is trying to enable runtime P=
M for
> > > > > fw_devlinks. It would mean synchronization issues for the runtime=
 PM
> > > > > status, all over the place.
> > > >
> > > > What synchronization issues?
> > >
> > > Changing the runtime PM status for a parent/supplier that doesn't hav=
e
> > > DPM_FLAG_SMART_SUSPEND, is likely to confuse their drivers.
> >
> > I'm not sure why though.
> >
> > > You also removed that part of the comment a few lines above, in
> > > device_resume_noirq(). I am not sure I understand why?
> >
> > Not removed, but replaced.
> >
> > The set_active flag is only set for devices with
> > DPM_FLAG_SMART_SUSPEND set and devices depended on by them.  Also, it
> > is only set for devices whose must_resume is set, which for devices
> > with DPM_FLAG_SMART_SUSPEND means that they literally must be resumed.
> > Consequently, the devices depended on by them also must be resumed.
> >
> > > >
> > > > > That said, is even consumer/suppliers part of the problem we are
> > > > > trying to solve?
> > > >
> > > > They are in general.
> > > >
> > > > It's just that stuff that was runtime-suspended prior to a system-w=
ide
> > > > suspend may need to be resumed and marked as RPM_ACTIVE during
> > > > system-wide resume because one of the devices wants/needs to be
> > > > resumed then.
> > > >
> > > > If this turns out to be problematic, the problem will need to be
> > > > addressed, but for now I'm not seeing why there would be a problem.
> > > >
> > > > > >
> > > > > > > That said, maybe we instead allow parent/child to work in the=
 similar
> > > > > > > way as for consumer/suppliers, when pm_runtime_set_active() i=
s called
> > > > > > > for the child. In other words, when pm_runtime_set_active() i=
s called
> > > > > > > for a child and the parent is runtime PM enabled, let's runti=
me resume
> > > > > > > it too, as we do for suppliers. Would that work, you think?
> > > > > >
> > > > > > The parent is not runtime-PM enabled when this happens.
> > > > >
> > > > > That sounds really weird to me.
> > > > >
> > > > > Does that mean that the parent has not been system resumed either=
?
> > > >
> > > > Yes.
> > > >
> > > > It hasn't been resumed yet, but it is known that it will be resumed=
.
> > > >
> > > > > If so, isn't that really the root cause for this problem,
> > > >
> > > > No, it is not.
> > > >
> > > > > or what am I missing?
> > > >
> > > > Essentially, what I said above.
> > > >
> > > > If a device that was suspended prior to a system-wide suspend
> > > > wants/needs to be resumed during the subsequent system-wide resume,
> > > > and it was runtime-PM-enabled before the suspend transition, it nee=
ds
> > > > to (a) be runtime-PM-enabled during the subsequent system-wide resu=
me
> > > > transition and (b) it also needs to be marked as RPM_ACTIVE because=
 in
> > > > fact it is not suspended any more.  The existing code before the pa=
tch
> > > > takes care of this for the device itself, but not for the devices i=
t
> > > > depends on which also need to be resumed (which happens) and marked=
 as
> > > > RPM_ACTIVE (which doesn't happen) and the patch just makes sure tha=
t
> > > > the latter will happen.
> > >
> > > Thanks for clarifying!
> > >
> > > >
> > > > Actually, what happens now is that the actual state of the parent
> > > > during the system-wide resume, right before re-enabling runtime PM =
for
> > > > it, does not match its runtime PM status which is still RPM_SUSPEND=
ED.
> > > > That's what is fixed here and it applies to the parent as well as t=
o
> > > > all of the other devices depended on by the child and the parent.
> > >
> > > Well, unfortunately I don't think it will work to call
> > > pm_runtime_set_active() for parents/suppliers like this.
> >
> > As stated above, if a device with DPM_FLAG_SMART_SUSPEND has
> > power.must_resume set, it must be resumed.  Therefore, all of the
> > devices depended on by it must be resumed (literally, they need to be
> > powered up and configured to work).  This is already a rule without
> > the patch.
> >
> > Accordingly, they all effectively will be "active" and so their
> > runtime PM status must reflect this.
>
> From a theoretical point of view, yes I agree.
>
> >
> > I don't see anything that cannot work, but I see why it is broken
> > without this patch.
>
> You are right that the behaviour is broken and needs to be fixed, but
> I am not convinced that $subject patch is the way forward. See more
> below.
>
> >
> > > I think we need the drivers for the parents/suppliers to be in
> > > agreement with the behaviour of DPM_FLAG_SMART_SUSPEND to allow the
> > > propagation. Not sure how to best achieve this though.
> >
> > It would be good to actually identify the cases in which it may not
> > work and they can be fixed on top of this patch.
>
> The problem with $subject patch is that drivers/buses are required to
> check the runtime PM status, with pm_runtime_suspended(),
> pm_runtime_status_suspended() or pm_runtime_active() in one of its
> system suspend/resume callbacks , to synchronize it with the HW state
> for its device (turn on/off clocks for example).

Well, I'm kind of unaware of this requirement.

It clearly is not even followed by the code without the $subject patch.

The real requirement is that the runtime PM status at the point when
runtime PM is re-enabled, that is in device_resume_early(), must
reflect the current actual HW state.

> Certainly, we can not rely on drivers to conform to this behaviour and
> there are plenty of cases where they really don't. For example, we
> have drivers that only implements runtime PM support or simply don't
> care about the runtime PM status during system resume, but just leaves
> the device in the state it is already in.

Drivers that only support runtime PM are broken with respect to system
sleep ATM.  They need to be made to support system sleep or they
cannot be used on systems that use system sleep.  There may be a way
around this for system suspend/resume (see below), but not for
hibernation.

> Moreover, we have the users of pm_runtime_force_suspend|resume(),
> which we also know *not* to work with DPM_FLAG_SMART_SUSPEND and thus
> $subject patch too. I am less worried about these cases though, as I
> believe we should be able to fix them, by taking into account the
> suggested "->power.set_active flag", or something along those lines.

Yes, and that's what I'm going to do.

> That said, it seems like we need another way forward.

I still don't see why, sorry.

I guess the concern is that if a device suddenly needs to be resumed
during system resume even though it was runtime-suspended before the
preceding system suspend, there is no way to tell its driver/bus
type/etc that this is the case if they all decide to leave the device
as is, but as I have said for multiple times in this thread, leaving a
device as is during system resume may not be an option unless it is a
leaf device without any subordinates.  This has always been the case.

We'll see if there is any damage resulting from the $subject change
and we'll fix it if so.

In the future, though, I'd like to integrate system resume with
runtime PM more than it is now.  Namely, it should be possible to move
the re-enabling of runtime PM to the front of device_resume_early()
and then use pm_runtime_resume() for resuming devices whose drivers
support runtime PM (I don't see any fundamental obstacles to this).
One benefit of doing this would be that pm_runtime_resume() would
automatically trigger a runtime resume for all of the "superior"
devices, so they could be left in whatever state they had been in
before the preceding system suspend regardless of what happens to
their "subordinates".  It is likely that some kind of driver opt-in
will be needed for this or maybe the core can figure it out by itself.

It can look at what callbacks are implemented etc.  For example, if a
driver only implements :runtime_suspend() and :runtime_resume() and no
other PM callbacks, it is reasonable to assume that the devices
handled by it should be suspended and resumed with the help of the
runtime PM infrastructure even during system-wide suspend/resume (that
doesn't apply to hibernation, though).

