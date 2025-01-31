Return-Path: <linux-pci+bounces-20580-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A100CA23BC6
	for <lists+linux-pci@lfdr.de>; Fri, 31 Jan 2025 11:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90DC63A96A6
	for <lists+linux-pci@lfdr.de>; Fri, 31 Jan 2025 10:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E149616F8F5;
	Fri, 31 Jan 2025 10:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I5a9PqjS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D012C14B08E
	for <linux-pci@vger.kernel.org>; Fri, 31 Jan 2025 10:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738317720; cv=none; b=cXceRrtFxn6fDA7cyQE7lrvPNyTKYn7POmG7/5sHwAEFuups2CceXGMHmv1zZLH2iL5PuOVg+4MCc6rBa9dTbAmMEaufOdmU8OgOaew9mzPNKqBmROAZ/oA72c7nIHMoz7Nmpo6XyazrCIaB6Xo4tdS89HS+sagRLxeieTiMAhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738317720; c=relaxed/simple;
	bh=qBmWxHPyt4GHn+FiS9ceSYpS6oMpB1Pu/XcSqyTfHcs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R/fJBgsRMuZkm61i4dHgMwuZLWqxrq6vmzG75gIPybxS251Qk0/6Zlu9mzLOvINpR2vQK0IRm3Qpw/nGCzf46O/zYpk+qMvB+dJLitml/8pGP1wmCrAsu4q23mDxyoR+YQid3V2nGML3ngtziWc7+mtLMnjDn2HEYdUGdOtKIR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I5a9PqjS; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e4a6b978283so4077874276.0
        for <linux-pci@vger.kernel.org>; Fri, 31 Jan 2025 02:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738317718; x=1738922518; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UNPItEyi98SQiBBEgcMLg4G92zZVZL1hhECBq/slwds=;
        b=I5a9PqjSL/mn1hwKL7T0H/hkpplDF09KQZ5jizKcfXwWQSKkRGgAvJqehf3kKMFBlF
         98n3Ncucis2aiL6G0MsjVpJm0/SacrZD8Hy+4ZSy8NqvDCdPCDy0MA+yz2mtC9tA+Hye
         P9RAJVZYmDZkEllSdICVoRI61ePOpiZGKKkxuK/P2quH6eq0qPiDENUPRUPrKrXhXnzg
         yy1R3Aat2JrQFqxmtWZYVXXhATLJDoPFFQP8RWWkAWp5bRLHh1msBTKpj+8wET9sidxI
         4H5yhuIjDauGAiiJaRCoF+UiKCq7N4JKPnI47QcOoZvF1evOvH+OTHN6OlSDgRHRs8Xz
         fAwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738317718; x=1738922518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UNPItEyi98SQiBBEgcMLg4G92zZVZL1hhECBq/slwds=;
        b=lfl8kQtLvRmur0fEEfV1opXyBc2xl0mdeQdCzzYNp50P2DNJ/nVtkAFYjgalrnDpl3
         uEvBTfKzrFHLfRSyoSqWe9B9x+lPFrt+26E8HAfU6Je1k5wuTAp4EjpxlBPN1jS6dCAo
         V2/mDVpe7nQn/Fudx4x3gW4rwVmFjLOB8UBM6O49uqva70Kg9v8nvK+7HI1Fh1X/Yntl
         JwqCqKkFGDkd+9Y1i7Qn2sHjUdzaqvwMuigZ1/auBl3lNtHagmCB3HNG6cMf5GWl6Zb7
         6qKT6L7/Ke8e0tWkLIsz+UWxCCFEBEihFaZ21BWK8sJYPMMJBTgYiwydHQvjaJI9sFIy
         tEMw==
X-Forwarded-Encrypted: i=1; AJvYcCXDrTbCZ1BCeyFVY0GCvz05mJ06lt8WUkD9FGnmzUcsUCB/NU6tkxxPrG4l7wHJMsC3QDT4BUKJnoM=@vger.kernel.org
X-Gm-Message-State: AOJu0YySFVVMasgVW3swziJHReEp/GORuae+eJbdvwfAGmkEZm0X25h5
	Zk9rnkS/SOX8Fm+lgYcKnqq8Jsti7CO8ObEPKkDJsBbKOQZ4C8Jzgx7GsC6BKu20mHtEaPjHDmo
	UhOfyTiMAVcRSedIqjTIHKUdK30z2FHdbGogXDg==
X-Gm-Gg: ASbGnctqYuTJ2mjqWz//0GT8+frkf+/ZWbMd5o422JXbpxVEj1Q1syQ1OnbomUuAO/Z
	lHYA2eRgAGawPXKkBgKVXhjd299sffUpP1FZE008ey2tt7fmVw0pdFd7aAOD6M663q8whqH0V0A
	==
X-Google-Smtp-Source: AGHT+IGq8M9/lR1ZKiMO+tf8yR+mmMTfufT64RjTnG/KKnQbWHBNhPOmhr63qsRaNyxywLZ/IWV+xWPpuJqTsi9uSJI=
X-Received: by 2002:a05:690c:6f08:b0:6e2:1c94:41f8 with SMTP id
 00721157ae682-6f8c199c18cmr61316827b3.10.1738317717558; Fri, 31 Jan 2025
 02:01:57 -0800 (PST)
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
 <CAPDyKFpmNPhyV3YoBFu7KnW04550DQgqzGHAbGLLqp7=TggVtw@mail.gmail.com> <CAJZ5v0iYHBeMra_ba-1Ht4xoPGsyt7gg05RtGxoa_gG91s1xEA@mail.gmail.com>
In-Reply-To: <CAJZ5v0iYHBeMra_ba-1Ht4xoPGsyt7gg05RtGxoa_gG91s1xEA@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 31 Jan 2025 11:01:21 +0100
X-Gm-Features: AWEUYZnI8RrzdQhuYe1gfwY0F5z4zjQ4LzaqkzRxe-pub1Yp6d4IRZsjMDcV4PM
Message-ID: <CAPDyKFqkqOXD0oVZoOFR4O6ucqLS4n85_S4SNPvPAc6hfaELgw@mail.gmail.com>
Subject: Re: [PATCH v1] PM: sleep: core: Synchronize runtime PM status of
 parents and children
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
	Bjorn Helgaas <helgaas@kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, 
	Johan Hovold <johan@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Kevin Xie <kevin.xie@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 30 Jan 2025 at 14:19, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Jan 30, 2025 at 12:11=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.=
org> wrote:
> >
> > On Wed, 29 Jan 2025 at 17:58, Rafael J. Wysocki <rafael@kernel.org> wro=
te:
> > >
> > > On Wed, Jan 29, 2025 at 5:42=E2=80=AFPM Ulf Hansson <ulf.hansson@lina=
ro.org> wrote:
> > > >
> > > > On Wed, 29 Jan 2025 at 16:55, Rafael J. Wysocki <rafael@kernel.org>=
 wrote:
> > > > >
> > > > > On Wed, Jan 29, 2025 at 12:53=E2=80=AFPM Ulf Hansson <ulf.hansson=
@linaro.org> wrote:
> > > > > >
> > > > > > On Tue, 28 Jan 2025 at 20:24, Rafael J. Wysocki <rjw@rjwysocki.=
net> wrote:
> > > > > > >
> > > > > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > > > >
> > > > > > > Commit 6e176bf8d461 ("PM: sleep: core: Do not skip callbacks =
in the
> > > > > > > resume phase") overlooked the case in which the parent of a d=
evice with
> > > > > > > DPM_FLAG_SMART_SUSPEND set did not use that flag and could be=
 runtime-
> > > > > > > suspended before a transition into a system-wide sleep state.=
  In that
> > > > > > > case, if the child is resumed during the subsequent transitio=
n from
> > > > > > > that state into the working state, its runtime PM status will=
 be set to
> > > > > > > RPM_ACTIVE, but the runtime PM status of the parent will not =
be updated
> > > > > > > accordingly, even though the parent will be resumed too, beca=
use of the
> > > > > > > dev_pm_skip_suspend() check in device_resume_noirq().
> > > > > > >
> > > > > > > Address this problem by tracking the need to set the runtime =
PM status
> > > > > > > to RPM_ACTIVE during system-wide resume transitions for devic=
es with
> > > > > > > DPM_FLAG_SMART_SUSPEND set and all of the devices depended on=
 by them.
> > > > > > >
> > > > > > > Fixes: 6e176bf8d461 ("PM: sleep: core: Do not skip callbacks =
in the resume phase")
> > > > > > > Closes: https://lore.kernel.org/linux-pm/Z30p2Etwf3F2AUvD@hov=
oldconsulting.com/
> > > > > > > Reported-by: Johan Hovold <johan@kernel.org>
> > > > > > > Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linar=
o.org>
> > > > > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > > > > ---
> > > > > > >  drivers/base/power/main.c |   29 ++++++++++++++++++++-------=
--
> > > > > > >  include/linux/pm.h        |    1 +
> > > > > > >  2 files changed, 21 insertions(+), 9 deletions(-)
> > > > > > >
> > > > > > > --- a/drivers/base/power/main.c
> > > > > > > +++ b/drivers/base/power/main.c
> > > > > > > @@ -656,13 +656,15 @@
> > > > > > >          * so change its status accordingly.
> > > > > > >          *
> > > > > > >          * Otherwise, the device is going to be resumed, so s=
et its PM-runtime
> > > > > > > -        * status to "active", but do that only if DPM_FLAG_S=
MART_SUSPEND is set
> > > > > > > -        * to avoid confusing drivers that don't use it.
> > > > > > > +        * status to "active" unless its power.set_active fla=
g is clear, in
> > > > > > > +        * which case it is not necessary to update its PM-ru=
ntime status.
> > > > > > >          */
> > > > > > > -       if (skip_resume)
> > > > > > > +       if (skip_resume) {
> > > > > > >                 pm_runtime_set_suspended(dev);
> > > > > > > -       else if (dev_pm_skip_suspend(dev))
> > > > > > > +       } else if (dev->power.set_active) {
> > > > > > >                 pm_runtime_set_active(dev);
> > > > > > > +               dev->power.set_active =3D false;
> > > > > > > +       }
> > > > > > >
> > > > > > >         if (dev->pm_domain) {
> > > > > > >                 info =3D "noirq power domain ";
> > > > > > > @@ -1189,18 +1191,24 @@
> > > > > > >         return PMSG_ON;
> > > > > > >  }
> > > > > > >
> > > > > > > -static void dpm_superior_set_must_resume(struct device *dev)
> > > > > > > +static void dpm_superior_set_must_resume(struct device *dev,=
 bool set_active)
> > > > > > >  {
> > > > > > >         struct device_link *link;
> > > > > > >         int idx;
> > > > > > >
> > > > > > > -       if (dev->parent)
> > > > > > > +       if (dev->parent) {
> > > > > > >                 dev->parent->power.must_resume =3D true;
> > > > > > > +               if (set_active)
> > > > > > > +                       dev->parent->power.set_active =3D tru=
e;
> > > > > > > +       }
> > > > > > >
> > > > > > >         idx =3D device_links_read_lock();
> > > > > > >
> > > > > > > -       list_for_each_entry_rcu_locked(link, &dev->links.supp=
liers, c_node)
> > > > > > > +       list_for_each_entry_rcu_locked(link, &dev->links.supp=
liers, c_node) {
> > > > > > >                 link->supplier->power.must_resume =3D true;
> > > > > > > +               if (set_active)
> > > > > > > +                       link->supplier->power.set_active =3D =
true;
> > > > > >
> > > > > > If I understand correctly, the suppliers are already handled wh=
en the
> > > > > > pm_runtime_set_active() is called for consumers, so the above s=
hould
> > > > > > not be needed.
> > > > >
> > > > > It is needed because pm_runtime_set_active() doesn't cause the se=
tting
> > > > > to propagate to the parent's/suppliers of the suppliers AFAICS.
> > > >
> > > > Hmm, even if that sounds reasonable, I don't think it's a good idea=
 as
> > > > it may introduce interesting propagation problems between drivers.
> > > >
> > > > For example, consider that Saravana is trying to enable runtime PM =
for
> > > > fw_devlinks. It would mean synchronization issues for the runtime P=
M
> > > > status, all over the place.
> > >
> > > What synchronization issues?
> >
> > Changing the runtime PM status for a parent/supplier that doesn't have
> > DPM_FLAG_SMART_SUSPEND, is likely to confuse their drivers.
>
> I'm not sure why though.
>
> > You also removed that part of the comment a few lines above, in
> > device_resume_noirq(). I am not sure I understand why?
>
> Not removed, but replaced.
>
> The set_active flag is only set for devices with
> DPM_FLAG_SMART_SUSPEND set and devices depended on by them.  Also, it
> is only set for devices whose must_resume is set, which for devices
> with DPM_FLAG_SMART_SUSPEND means that they literally must be resumed.
> Consequently, the devices depended on by them also must be resumed.
>
> > >
> > > > That said, is even consumer/suppliers part of the problem we are
> > > > trying to solve?
> > >
> > > They are in general.
> > >
> > > It's just that stuff that was runtime-suspended prior to a system-wid=
e
> > > suspend may need to be resumed and marked as RPM_ACTIVE during
> > > system-wide resume because one of the devices wants/needs to be
> > > resumed then.
> > >
> > > If this turns out to be problematic, the problem will need to be
> > > addressed, but for now I'm not seeing why there would be a problem.
> > >
> > > > >
> > > > > > That said, maybe we instead allow parent/child to work in the s=
imilar
> > > > > > way as for consumer/suppliers, when pm_runtime_set_active() is =
called
> > > > > > for the child. In other words, when pm_runtime_set_active() is =
called
> > > > > > for a child and the parent is runtime PM enabled, let's runtime=
 resume
> > > > > > it too, as we do for suppliers. Would that work, you think?
> > > > >
> > > > > The parent is not runtime-PM enabled when this happens.
> > > >
> > > > That sounds really weird to me.
> > > >
> > > > Does that mean that the parent has not been system resumed either?
> > >
> > > Yes.
> > >
> > > It hasn't been resumed yet, but it is known that it will be resumed.
> > >
> > > > If so, isn't that really the root cause for this problem,
> > >
> > > No, it is not.
> > >
> > > > or what am I missing?
> > >
> > > Essentially, what I said above.
> > >
> > > If a device that was suspended prior to a system-wide suspend
> > > wants/needs to be resumed during the subsequent system-wide resume,
> > > and it was runtime-PM-enabled before the suspend transition, it needs
> > > to (a) be runtime-PM-enabled during the subsequent system-wide resume
> > > transition and (b) it also needs to be marked as RPM_ACTIVE because i=
n
> > > fact it is not suspended any more.  The existing code before the patc=
h
> > > takes care of this for the device itself, but not for the devices it
> > > depends on which also need to be resumed (which happens) and marked a=
s
> > > RPM_ACTIVE (which doesn't happen) and the patch just makes sure that
> > > the latter will happen.
> >
> > Thanks for clarifying!
> >
> > >
> > > Actually, what happens now is that the actual state of the parent
> > > during the system-wide resume, right before re-enabling runtime PM fo=
r
> > > it, does not match its runtime PM status which is still RPM_SUSPENDED=
.
> > > That's what is fixed here and it applies to the parent as well as to
> > > all of the other devices depended on by the child and the parent.
> >
> > Well, unfortunately I don't think it will work to call
> > pm_runtime_set_active() for parents/suppliers like this.
>
> As stated above, if a device with DPM_FLAG_SMART_SUSPEND has
> power.must_resume set, it must be resumed.  Therefore, all of the
> devices depended on by it must be resumed (literally, they need to be
> powered up and configured to work).  This is already a rule without
> the patch.
>
> Accordingly, they all effectively will be "active" and so their
> runtime PM status must reflect this.

From a theoretical point of view, yes I agree.

>
> I don't see anything that cannot work, but I see why it is broken
> without this patch.

You are right that the behaviour is broken and needs to be fixed, but
I am not convinced that $subject patch is the way forward. See more
below.

>
> > I think we need the drivers for the parents/suppliers to be in
> > agreement with the behaviour of DPM_FLAG_SMART_SUSPEND to allow the
> > propagation. Not sure how to best achieve this though.
>
> It would be good to actually identify the cases in which it may not
> work and they can be fixed on top of this patch.

The problem with $subject patch is that drivers/buses are required to
check the runtime PM status, with pm_runtime_suspended(),
pm_runtime_status_suspended() or pm_runtime_active() in one of its
system suspend/resume callbacks , to synchronize it with the HW state
for its device (turn on/off clocks for example).

Certainly, we can not rely on drivers to conform to this behaviour and
there are plenty of cases where they really don't. For example, we
have drivers that only implements runtime PM support or simply don't
care about the runtime PM status during system resume, but just leaves
the device in the state it is already in.

Moreover, we have the users of pm_runtime_force_suspend|resume(),
which we also know *not* to work with DPM_FLAG_SMART_SUSPEND and thus
$subject patch too. I am less worried about these cases though, as I
believe we should be able to fix them, by taking into account the
suggested "->power.set_active flag", or something along those lines.

That said, it seems like we need another way forward.

Kind regards
Uffe

