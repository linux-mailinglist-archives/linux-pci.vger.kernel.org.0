Return-Path: <linux-pci+bounces-20547-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E883A220F8
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2025 16:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4E1C164E85
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2025 15:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D391B4235;
	Wed, 29 Jan 2025 15:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F11ESCrh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23ED7224EA;
	Wed, 29 Jan 2025 15:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738166116; cv=none; b=UYKB2uCDaR1N1YwyWXy3ycGWChDDn2/nt1vfYxKoE4sDSjBuEIbHu6ezG1Q71y2ZLir197Fn6EC1U/pOefjKraAE7efkv0f6GBH/DM5biUUAjbPeiFZxhMCxuQh8z08pW9XhD4qm3KxqnmhBOBaQ1SZNh9k8bxQTw72MQAx8P8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738166116; c=relaxed/simple;
	bh=TRusJsC7yOpUSz+Rj6As3McnrV9DLgmT4AzMRFyJD1Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GSNeSqWOcnIl9svWgwK5h3pkbuw46+yESHyEOLv+uLJ/QJ1j2hM55F/TyYhYBp4wq0szb32VJW0+oCBK7s9UFd86G+vttR6C4vbqHGeYJkMM74EOaRGjeIUN2KYZ4QOngFe/y0bSPKj6uKgLAF9+PKzG0TY3JQKfPsFuXgECyE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F11ESCrh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 956A5C4AF09;
	Wed, 29 Jan 2025 15:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738166115;
	bh=TRusJsC7yOpUSz+Rj6As3McnrV9DLgmT4AzMRFyJD1Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=F11ESCrhsv06fj3PAKToVlgRxAXEstzDhqZdYJHpBikTFnrRnZpYsxB66DZsI3Aa7
	 vbZSJrRkFaPhfWLaf+iCqPOEQ9IE1pdNx9r+pLwI06mARf8KTYWboukpk0/GhfUZbJ
	 AppnQ7iaCn6OwnkbEFrV9BBvaKrr60SWA9eXO/YnMAe2lNDn+VPJW6TbolPMrm7Mfx
	 GJt44HsSbWuSMJGxRix9Ai2GSvXsBkeKchIVhNrUVr3BWEqOM7iDuSiLdyxKO7XBC8
	 1pe5PjEZXhPSrWZJlPeLpKSNMB8STc9j9GHIQF+eBPgsBFkedsXiX8QjSjosJqvyQN
	 ijAvVkvkOoRAQ==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2b1a9cbfc8dso1949015fac.2;
        Wed, 29 Jan 2025 07:55:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX1ekuZL+H3vEJZKI9GrzXB33o/3pyap4s0wKFO/cyj5t+te8S1+rTAa4QGY2HXzgETOtYiOiVZXB+uQe8=@vger.kernel.org, AJvYcCX8w9oYyIow4u/do9mAWo+qBRULeczHGB5Sk9DM4vmYva2uIBxDodXptZoQJxahpgNJ1edJcl41zZw=@vger.kernel.org, AJvYcCXlWc4KzH8q00GWY5f8g5/QweCFNWkdid28phT9RphMHSvJXpVngfkDqp29hhusFjDuP/uKWbTydcBU@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/qEkf/ecVwjv9niJ6ZvhcqtxITVpv2feAc3Yoa6VRANSpW2Qm
	8korUGD8kTNYRE5FUgF1EZAmA/S8pvb34AHQ7ZQeoG0zCnKXEonwNJXVfmQ9a/Sp0TJtC9LMri4
	fP42x0zWG9doyBkdNdWwGGzMxAbk=
X-Google-Smtp-Source: AGHT+IG7RrkhL3/SJMXffsyZHBix+YSkiKIRakRmTJoWP1Z0mst7YVnatg0QmAW9hHhSjCW8skZlE6OTJsPeB6meU6c=
X-Received: by 2002:a05:6870:7e8b:b0:29e:719b:7837 with SMTP id
 586e51a60fabf-2b32f04a90bmr1854201fac.13.1738166114825; Wed, 29 Jan 2025
 07:55:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12619233.O9o76ZdvQC@rjwysocki.net> <CAPDyKFpc5p3sXZ6LfdVgt8jR5ZbsQExTgeyMNA-PzcWs5A9U0A@mail.gmail.com>
In-Reply-To: <CAPDyKFpc5p3sXZ6LfdVgt8jR5ZbsQExTgeyMNA-PzcWs5A9U0A@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 29 Jan 2025 16:55:03 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gvQjp_P-5Ww7iN1cGiiMJ6tvLLnPpkTQNk++KhoRe=GA@mail.gmail.com>
X-Gm-Features: AWEUYZkzksNRSXB2L6PD7xNJqCc3L3Cy-BJSdtEu1i8R1oAgdoS-pRhe5JAQfnM
Message-ID: <CAJZ5v0gvQjp_P-5Ww7iN1cGiiMJ6tvLLnPpkTQNk++KhoRe=GA@mail.gmail.com>
Subject: Re: [PATCH v1] PM: sleep: core: Synchronize runtime PM status of
 parents and children
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
	Bjorn Helgaas <helgaas@kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, 
	Johan Hovold <johan@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Kevin Xie <kevin.xie@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 29, 2025 at 12:53=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.or=
g> wrote:
>
> On Tue, 28 Jan 2025 at 20:24, Rafael J. Wysocki <rjw@rjwysocki.net> wrote=
:
> >
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Commit 6e176bf8d461 ("PM: sleep: core: Do not skip callbacks in the
> > resume phase") overlooked the case in which the parent of a device with
> > DPM_FLAG_SMART_SUSPEND set did not use that flag and could be runtime-
> > suspended before a transition into a system-wide sleep state.  In that
> > case, if the child is resumed during the subsequent transition from
> > that state into the working state, its runtime PM status will be set to
> > RPM_ACTIVE, but the runtime PM status of the parent will not be updated
> > accordingly, even though the parent will be resumed too, because of the
> > dev_pm_skip_suspend() check in device_resume_noirq().
> >
> > Address this problem by tracking the need to set the runtime PM status
> > to RPM_ACTIVE during system-wide resume transitions for devices with
> > DPM_FLAG_SMART_SUSPEND set and all of the devices depended on by them.
> >
> > Fixes: 6e176bf8d461 ("PM: sleep: core: Do not skip callbacks in the res=
ume phase")
> > Closes: https://lore.kernel.org/linux-pm/Z30p2Etwf3F2AUvD@hovoldconsult=
ing.com/
> > Reported-by: Johan Hovold <johan@kernel.org>
> > Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/base/power/main.c |   29 ++++++++++++++++++++---------
> >  include/linux/pm.h        |    1 +
> >  2 files changed, 21 insertions(+), 9 deletions(-)
> >
> > --- a/drivers/base/power/main.c
> > +++ b/drivers/base/power/main.c
> > @@ -656,13 +656,15 @@
> >          * so change its status accordingly.
> >          *
> >          * Otherwise, the device is going to be resumed, so set its PM-=
runtime
> > -        * status to "active", but do that only if DPM_FLAG_SMART_SUSPE=
ND is set
> > -        * to avoid confusing drivers that don't use it.
> > +        * status to "active" unless its power.set_active flag is clear=
, in
> > +        * which case it is not necessary to update its PM-runtime stat=
us.
> >          */
> > -       if (skip_resume)
> > +       if (skip_resume) {
> >                 pm_runtime_set_suspended(dev);
> > -       else if (dev_pm_skip_suspend(dev))
> > +       } else if (dev->power.set_active) {
> >                 pm_runtime_set_active(dev);
> > +               dev->power.set_active =3D false;
> > +       }
> >
> >         if (dev->pm_domain) {
> >                 info =3D "noirq power domain ";
> > @@ -1189,18 +1191,24 @@
> >         return PMSG_ON;
> >  }
> >
> > -static void dpm_superior_set_must_resume(struct device *dev)
> > +static void dpm_superior_set_must_resume(struct device *dev, bool set_=
active)
> >  {
> >         struct device_link *link;
> >         int idx;
> >
> > -       if (dev->parent)
> > +       if (dev->parent) {
> >                 dev->parent->power.must_resume =3D true;
> > +               if (set_active)
> > +                       dev->parent->power.set_active =3D true;
> > +       }
> >
> >         idx =3D device_links_read_lock();
> >
> > -       list_for_each_entry_rcu_locked(link, &dev->links.suppliers, c_n=
ode)
> > +       list_for_each_entry_rcu_locked(link, &dev->links.suppliers, c_n=
ode) {
> >                 link->supplier->power.must_resume =3D true;
> > +               if (set_active)
> > +                       link->supplier->power.set_active =3D true;
>
> If I understand correctly, the suppliers are already handled when the
> pm_runtime_set_active() is called for consumers, so the above should
> not be needed.

It is needed because pm_runtime_set_active() doesn't cause the setting
to propagate to the parent's/suppliers of the suppliers AFAICS.

> That said, maybe we instead allow parent/child to work in the similar
> way as for consumer/suppliers, when pm_runtime_set_active() is called
> for the child. In other words, when pm_runtime_set_active() is called
> for a child and the parent is runtime PM enabled, let's runtime resume
> it too, as we do for suppliers. Would that work, you think?

The parent is not runtime-PM enabled when this happens.

