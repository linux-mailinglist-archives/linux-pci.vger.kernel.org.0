Return-Path: <linux-pci+bounces-20574-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C84D0A22D87
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jan 2025 14:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30E0F165F16
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jan 2025 13:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16FB1E2613;
	Thu, 30 Jan 2025 13:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pjnRDida"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BEE819;
	Thu, 30 Jan 2025 13:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738243161; cv=none; b=kyZyyVACoo8kgThXrDF++IqbSCZgUW2GQRnzxMrkYAAC0kAXp2ZOKEzbvQsrjERAUL39q9D7TvJaFQjzKEzbzMGabHzSQyt6Rx3HW4gt2eTCKYPK+4uz4rGh+TNf+pH1NPJKeDLEIDfr6Jv0Gcklqg0IVKtS7sZMJ0sdJwtYmZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738243161; c=relaxed/simple;
	bh=d0fQXsgYaqdw22vo14ZJcic4Yd0EFPXGVcjLVtYasCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EhfS/2dqwzbWnYm6y89L+6ewIHT8v/aR1kKoBXSSZAEpMQdr6Z/jSsILvBvOZf7+84orT0M+l49yCFax31g+Nlr5smOUVAa/TAtsC3Je6aFKFB2UuZL1TmF1DZH02HGHXPOWSoY8JDRwsDN/EUVSE+FTXISJL6W2pm9+vRcJazg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pjnRDida; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCC94C4CEE0;
	Thu, 30 Jan 2025 13:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738243160;
	bh=d0fQXsgYaqdw22vo14ZJcic4Yd0EFPXGVcjLVtYasCs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pjnRDidavSlir7nsvL3qUhkCstiFPh3TgABu9pVx09NH+Gz+ZJehgGznftu27JA/r
	 XuQRCSHfTEG5RFrv+FVRTlD8Ywjll5Mn6fjXIVz23JRex9UoAjhD2NuswAZaP/bzxU
	 UMdZi1F0tUOz4cLtEpt2eSf7mdM9NymWAn6cp2jIFuWtqL4CinaFRruOFuKiaEtfle
	 +mbdTxnVtBNnXu4MtjQpns+IQE9eBvML/9jvC+mwdBikNLTrBRLzPlOr2WYtAZzgBg
	 mYQtDmk0s959TGdOmEEa19qQvgdq7ID12oe0jJqOUCcQxMgUdbjHbK/qYcLhB8yPMn
	 2qUlCMB9ugtFA==
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-71deb3745easo159443a34.3;
        Thu, 30 Jan 2025 05:19:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVonIp/ght7llnadQtljcFtPJF9dSwcA6G18zidmzI2DXrsHsMoQv9jJkxYprIfgxQRyqIJCa0pUXE=@vger.kernel.org, AJvYcCWndxXSSIJDb1lj0gvd29gjDHNUcvWJVB9zDaMlYzCLdE8Mv+eFpbnEeyNUoC2D+4wSJOCP3WLBQIeXna8=@vger.kernel.org, AJvYcCXNlOPnnIYV6AldN4/4i8gsbTcziqAul1QALthCQrqxJ7MNTEm++belhWUK/vqgvY41GoSQ9wOmoe4g@vger.kernel.org
X-Gm-Message-State: AOJu0YyygsIg1QCcZO+W/yy1bRg6q9KbIBMGCiWbipVDj4YNInfT6Qxm
	mTnDUrI/8NhEmm+Bot9BDIc8WuRPmG1CFfnrf9ceTy12i73//pyh601ClS3oSD0yBqtvQH15L5b
	T7C9uUHeZGyjSZFJJAhIu0NxxPT4=
X-Google-Smtp-Source: AGHT+IHaApAH2151fdQMr2K/rWXcq1IdxdXfRWxi2MmSzy1jmhyjcfQCMBVbsYm7hN21Oljw+1RbMonmbAllyu9MA+o=
X-Received: by 2002:a05:6870:4e07:b0:288:563b:e48d with SMTP id
 586e51a60fabf-2b32f03426dmr4140022fac.10.1738243159985; Thu, 30 Jan 2025
 05:19:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12619233.O9o76ZdvQC@rjwysocki.net> <CAPDyKFpc5p3sXZ6LfdVgt8jR5ZbsQExTgeyMNA-PzcWs5A9U0A@mail.gmail.com>
 <CAJZ5v0gvQjp_P-5Ww7iN1cGiiMJ6tvLLnPpkTQNk++KhoRe=GA@mail.gmail.com>
 <CAPDyKFrBO+r8qYRrhoFZN21__8RuR61ofbsGQZbA=pyQbti5CA@mail.gmail.com>
 <CAJZ5v0jTutgKeXtg3YLR1Onw9gOmvHudHamVVgMxEsieNDXViw@mail.gmail.com> <CAPDyKFpmNPhyV3YoBFu7KnW04550DQgqzGHAbGLLqp7=TggVtw@mail.gmail.com>
In-Reply-To: <CAPDyKFpmNPhyV3YoBFu7KnW04550DQgqzGHAbGLLqp7=TggVtw@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 30 Jan 2025 14:19:08 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iYHBeMra_ba-1Ht4xoPGsyt7gg05RtGxoa_gG91s1xEA@mail.gmail.com>
X-Gm-Features: AWEUYZmtyfD-QjORpGH8sT5RY4RaUd5cb129O2vvjWcJUTrONPCuwcwwF2sdMz0
Message-ID: <CAJZ5v0iYHBeMra_ba-1Ht4xoPGsyt7gg05RtGxoa_gG91s1xEA@mail.gmail.com>
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

On Thu, Jan 30, 2025 at 12:11=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.or=
g> wrote:
>
> On Wed, 29 Jan 2025 at 17:58, Rafael J. Wysocki <rafael@kernel.org> wrote=
:
> >
> > On Wed, Jan 29, 2025 at 5:42=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro=
.org> wrote:
> > >
> > > On Wed, 29 Jan 2025 at 16:55, Rafael J. Wysocki <rafael@kernel.org> w=
rote:
> > > >
> > > > On Wed, Jan 29, 2025 at 12:53=E2=80=AFPM Ulf Hansson <ulf.hansson@l=
inaro.org> wrote:
> > > > >
> > > > > On Tue, 28 Jan 2025 at 20:24, Rafael J. Wysocki <rjw@rjwysocki.ne=
t> wrote:
> > > > > >
> > > > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > > >
> > > > > > Commit 6e176bf8d461 ("PM: sleep: core: Do not skip callbacks in=
 the
> > > > > > resume phase") overlooked the case in which the parent of a dev=
ice with
> > > > > > DPM_FLAG_SMART_SUSPEND set did not use that flag and could be r=
untime-
> > > > > > suspended before a transition into a system-wide sleep state.  =
In that
> > > > > > case, if the child is resumed during the subsequent transition =
from
> > > > > > that state into the working state, its runtime PM status will b=
e set to
> > > > > > RPM_ACTIVE, but the runtime PM status of the parent will not be=
 updated
> > > > > > accordingly, even though the parent will be resumed too, becaus=
e of the
> > > > > > dev_pm_skip_suspend() check in device_resume_noirq().
> > > > > >
> > > > > > Address this problem by tracking the need to set the runtime PM=
 status
> > > > > > to RPM_ACTIVE during system-wide resume transitions for devices=
 with
> > > > > > DPM_FLAG_SMART_SUSPEND set and all of the devices depended on b=
y them.
> > > > > >
> > > > > > Fixes: 6e176bf8d461 ("PM: sleep: core: Do not skip callbacks in=
 the resume phase")
> > > > > > Closes: https://lore.kernel.org/linux-pm/Z30p2Etwf3F2AUvD@hovol=
dconsulting.com/
> > > > > > Reported-by: Johan Hovold <johan@kernel.org>
> > > > > > Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.=
org>
> > > > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > > > ---
> > > > > >  drivers/base/power/main.c |   29 ++++++++++++++++++++---------
> > > > > >  include/linux/pm.h        |    1 +
> > > > > >  2 files changed, 21 insertions(+), 9 deletions(-)
> > > > > >
> > > > > > --- a/drivers/base/power/main.c
> > > > > > +++ b/drivers/base/power/main.c
> > > > > > @@ -656,13 +656,15 @@
> > > > > >          * so change its status accordingly.
> > > > > >          *
> > > > > >          * Otherwise, the device is going to be resumed, so set=
 its PM-runtime
> > > > > > -        * status to "active", but do that only if DPM_FLAG_SMA=
RT_SUSPEND is set
> > > > > > -        * to avoid confusing drivers that don't use it.
> > > > > > +        * status to "active" unless its power.set_active flag =
is clear, in
> > > > > > +        * which case it is not necessary to update its PM-runt=
ime status.
> > > > > >          */
> > > > > > -       if (skip_resume)
> > > > > > +       if (skip_resume) {
> > > > > >                 pm_runtime_set_suspended(dev);
> > > > > > -       else if (dev_pm_skip_suspend(dev))
> > > > > > +       } else if (dev->power.set_active) {
> > > > > >                 pm_runtime_set_active(dev);
> > > > > > +               dev->power.set_active =3D false;
> > > > > > +       }
> > > > > >
> > > > > >         if (dev->pm_domain) {
> > > > > >                 info =3D "noirq power domain ";
> > > > > > @@ -1189,18 +1191,24 @@
> > > > > >         return PMSG_ON;
> > > > > >  }
> > > > > >
> > > > > > -static void dpm_superior_set_must_resume(struct device *dev)
> > > > > > +static void dpm_superior_set_must_resume(struct device *dev, b=
ool set_active)
> > > > > >  {
> > > > > >         struct device_link *link;
> > > > > >         int idx;
> > > > > >
> > > > > > -       if (dev->parent)
> > > > > > +       if (dev->parent) {
> > > > > >                 dev->parent->power.must_resume =3D true;
> > > > > > +               if (set_active)
> > > > > > +                       dev->parent->power.set_active =3D true;
> > > > > > +       }
> > > > > >
> > > > > >         idx =3D device_links_read_lock();
> > > > > >
> > > > > > -       list_for_each_entry_rcu_locked(link, &dev->links.suppli=
ers, c_node)
> > > > > > +       list_for_each_entry_rcu_locked(link, &dev->links.suppli=
ers, c_node) {
> > > > > >                 link->supplier->power.must_resume =3D true;
> > > > > > +               if (set_active)
> > > > > > +                       link->supplier->power.set_active =3D tr=
ue;
> > > > >
> > > > > If I understand correctly, the suppliers are already handled when=
 the
> > > > > pm_runtime_set_active() is called for consumers, so the above sho=
uld
> > > > > not be needed.
> > > >
> > > > It is needed because pm_runtime_set_active() doesn't cause the sett=
ing
> > > > to propagate to the parent's/suppliers of the suppliers AFAICS.
> > >
> > > Hmm, even if that sounds reasonable, I don't think it's a good idea a=
s
> > > it may introduce interesting propagation problems between drivers.
> > >
> > > For example, consider that Saravana is trying to enable runtime PM fo=
r
> > > fw_devlinks. It would mean synchronization issues for the runtime PM
> > > status, all over the place.
> >
> > What synchronization issues?
>
> Changing the runtime PM status for a parent/supplier that doesn't have
> DPM_FLAG_SMART_SUSPEND, is likely to confuse their drivers.

I'm not sure why though.

> You also removed that part of the comment a few lines above, in
> device_resume_noirq(). I am not sure I understand why?

Not removed, but replaced.

The set_active flag is only set for devices with
DPM_FLAG_SMART_SUSPEND set and devices depended on by them.  Also, it
is only set for devices whose must_resume is set, which for devices
with DPM_FLAG_SMART_SUSPEND means that they literally must be resumed.
Consequently, the devices depended on by them also must be resumed.

> >
> > > That said, is even consumer/suppliers part of the problem we are
> > > trying to solve?
> >
> > They are in general.
> >
> > It's just that stuff that was runtime-suspended prior to a system-wide
> > suspend may need to be resumed and marked as RPM_ACTIVE during
> > system-wide resume because one of the devices wants/needs to be
> > resumed then.
> >
> > If this turns out to be problematic, the problem will need to be
> > addressed, but for now I'm not seeing why there would be a problem.
> >
> > > >
> > > > > That said, maybe we instead allow parent/child to work in the sim=
ilar
> > > > > way as for consumer/suppliers, when pm_runtime_set_active() is ca=
lled
> > > > > for the child. In other words, when pm_runtime_set_active() is ca=
lled
> > > > > for a child and the parent is runtime PM enabled, let's runtime r=
esume
> > > > > it too, as we do for suppliers. Would that work, you think?
> > > >
> > > > The parent is not runtime-PM enabled when this happens.
> > >
> > > That sounds really weird to me.
> > >
> > > Does that mean that the parent has not been system resumed either?
> >
> > Yes.
> >
> > It hasn't been resumed yet, but it is known that it will be resumed.
> >
> > > If so, isn't that really the root cause for this problem,
> >
> > No, it is not.
> >
> > > or what am I missing?
> >
> > Essentially, what I said above.
> >
> > If a device that was suspended prior to a system-wide suspend
> > wants/needs to be resumed during the subsequent system-wide resume,
> > and it was runtime-PM-enabled before the suspend transition, it needs
> > to (a) be runtime-PM-enabled during the subsequent system-wide resume
> > transition and (b) it also needs to be marked as RPM_ACTIVE because in
> > fact it is not suspended any more.  The existing code before the patch
> > takes care of this for the device itself, but not for the devices it
> > depends on which also need to be resumed (which happens) and marked as
> > RPM_ACTIVE (which doesn't happen) and the patch just makes sure that
> > the latter will happen.
>
> Thanks for clarifying!
>
> >
> > Actually, what happens now is that the actual state of the parent
> > during the system-wide resume, right before re-enabling runtime PM for
> > it, does not match its runtime PM status which is still RPM_SUSPENDED.
> > That's what is fixed here and it applies to the parent as well as to
> > all of the other devices depended on by the child and the parent.
>
> Well, unfortunately I don't think it will work to call
> pm_runtime_set_active() for parents/suppliers like this.

As stated above, if a device with DPM_FLAG_SMART_SUSPEND has
power.must_resume set, it must be resumed.  Therefore, all of the
devices depended on by it must be resumed (literally, they need to be
powered up and configured to work).  This is already a rule without
the patch.

Accordingly, they all effectively will be "active" and so their
runtime PM status must reflect this.

I don't see anything that cannot work, but I see why it is broken
without this patch.

> I think we need the drivers for the parents/suppliers to be in
> agreement with the behaviour of DPM_FLAG_SMART_SUSPEND to allow the
> propagation. Not sure how to best achieve this though.

It would be good to actually identify the cases in which it may not
work and they can be fixed on top of this patch.

