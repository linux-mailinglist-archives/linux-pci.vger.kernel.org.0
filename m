Return-Path: <linux-pci+bounces-21731-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A919A39CB9
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 14:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E527B1893EE9
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 13:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9DDE268C7E;
	Tue, 18 Feb 2025 13:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k/FBPtc7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFF7246348;
	Tue, 18 Feb 2025 13:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739883707; cv=none; b=U9xNU7Xm+ElKEJNtAIxzeRCL0r4cdk9kiX/Wiu+E6Fzq84HyD4ycFzKZhZgIh3oh/tRUD24ponSs7vY/zmRT0KZL+RGWjTpmnW+KOSWgt+8tWkZX7kgkNcDv/YAAC0TZXVmEz6s9SaRDWsIskIq8EtM+cWyYInnm4p+/SWLtL6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739883707; c=relaxed/simple;
	bh=2zW3eoVhp4ZhIG3Q3PxubL2zysHFAPbbePCSi0p7gLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EYbyrTHcFu5Kf2CJk29NXQIgnk/CTE2a1Hfu91er6mGJF/NN6vg4Hv3fPCSF9MIfCth0kBH3JQtuzQTgQADP0kbLjPR0emqIre5VFLS2U+qCT8uptWSDwGaMJlzthjwcc05eoOiZ6KB1gDX2g4BO68piwVvpVRtWiGNYBBawE/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k/FBPtc7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00E7DC4CEE2;
	Tue, 18 Feb 2025 13:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739883707;
	bh=2zW3eoVhp4ZhIG3Q3PxubL2zysHFAPbbePCSi0p7gLc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=k/FBPtc7gKTN/ulJ61Id3RvN4yHJ/rBllMCEizSDW9G4nklhZClvfXQgHS46pXc5D
	 VQUD45BTLZdtoBJ6WXyhIgXwNDjLONm4lYrtjZ5g6k+o9+lmq+SslVVIGAUCYhp95v
	 LHcI8RqC+jJ7y7Na6JhX4ukAxOiV2djKcmUzhLjBausOfjwuuY2VEFoWsmXMmDQpkA
	 ABzi26PnR2un3vnxRukwx00nCN1VBGmGKR/xWJLIHbz8eBowT6S77KuEXXUULG3Nst
	 nKwuAk2Bnn6CXa/xpuoDMClFri35gJaRTRHAhrfgUFpPk2cehV9IhGNSxKI17+TQ2Q
	 UZmPIh3ea4okQ==
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3f3eafbbfefso1506125b6e.1;
        Tue, 18 Feb 2025 05:01:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUAF/SX1IMkJy4WjxqDt025q19/YD2KrX1JIxag1ayj92Q+9J0yqSk4X8RcgmvN/6PG94ll4HVHCCruzKPg@vger.kernel.org, AJvYcCVXlVQ8EbL3/tgRZyVcEVV8Msz3bZBDjg1a550HKw198uQM/ItXMxclzmv7XF0CIDcDkbg/mHaOnEJc@vger.kernel.org, AJvYcCWUe6tUGNGsHHUedLbqIAvuzeRQ3X7qTTI+1DUE5+9PIzjWwOzy7egFApcdrvqb9yItNEijqAXWkrer@vger.kernel.org, AJvYcCXj4HWl3gZRCOmaUwWvoWG7imJow5tHVrRUNTPevhBcp5SkMHyzHBHeK6SyfUShGAVkghONAg90klc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE4spJPNv69Wc6ZzzFDVQ4C8z9gRXNp0nkaZUCjMga5+HAD+Kc
	AnG59jbngfq+FTpiIcAfe5UgOSadG1a9TuCx8CBTKeO2ynsX9Rh6kVA30m/nTwGkNlef8ESosHK
	W5LnolVcOtXyeQfuCs8y2bF5l3aY=
X-Google-Smtp-Source: AGHT+IHDBDFx5HY/aKrD75j0Q3mkwkH0ciUHvaut556qU7exPc826sMdc3Nnya6ssaM79G3+VHru0lnsXlzmpICLHbY=
X-Received: by 2002:a05:6808:1823:b0:3eb:5562:34ba with SMTP id
 5614622812f47-3f3eb140e3dmr6820884b6e.25.1739883706349; Tue, 18 Feb 2025
 05:01:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4966939.GXAFRqVoOG@rjwysocki.net> <2984234.e9J7NaK4W3@rjwysocki.net>
 <CAPDyKFonaX6gfHgj-OJaowUxhYZR4qQ8EZvvLHfF9AP1GvqrZw@mail.gmail.com>
In-Reply-To: <CAPDyKFonaX6gfHgj-OJaowUxhYZR4qQ8EZvvLHfF9AP1GvqrZw@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 18 Feb 2025 14:01:34 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0i6uEDj+55yYyZHgmDFh-pVZKJ8es3mB6TdV9CKQxV=2A@mail.gmail.com>
X-Gm-Features: AWEUYZnefwmZjxYnkv29ltteu1wJgKKa7v83BRsrcBFH8mIV5i0AO4DnmJq3S3Y
Message-ID: <CAJZ5v0i6uEDj+55yYyZHgmDFh-pVZKJ8es3mB6TdV9CKQxV=2A@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] PM: Block enabling of runtime PM during system suspend
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
	Bjorn Helgaas <helgaas@kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, 
	Johan Hovold <johan@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Jon Hunter <jonathanh@nvidia.com>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 1:49=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
>
> On Mon, 17 Feb 2025 at 21:20, Rafael J. Wysocki <rjw@rjwysocki.net> wrote=
:
> >
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > If device_prepare() runs on a device that has never had runtime
> > PM enabled so far, it may reasonably assume that runtime PM will
> > not be enabled for that device during the system suspend-resume
> > cycle currently in progress, but this has never been guaranteed.
> >
> > To verify this assumption, make device_prepare() arrange for
> > triggering a device warning accompanied by a call trace dump if
> > runtime PM is enabled for such a device after it has returned.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/base/power/main.c    |    9 +++++++++
> >  drivers/base/power/runtime.c |   24 ++++++++++++++++++++++++
> >  include/linux/pm.h           |    1 +
> >  include/linux/pm_runtime.h   |    6 +++++-
> >  4 files changed, 39 insertions(+), 1 deletion(-)
> >
> > --- a/drivers/base/power/main.c
> > +++ b/drivers/base/power/main.c
> > @@ -1109,6 +1109,8 @@
> >         device_unlock(dev);
> >
> >  out:
> > +       /* If enabling runtime PM for the device is blocked, unblock it=
. */
> > +       pm_runtime_unblock(dev);
> >         pm_runtime_put(dev);
> >  }
> >
> > @@ -1815,6 +1817,13 @@
> >          * it again during the complete phase.
> >          */
> >         pm_runtime_get_noresume(dev);
> > +       /*
> > +        * If runtime PM is disabled for the device at this point and i=
t has
> > +        * never been enabled so far, it should not be enabled until th=
is system
> > +        * suspend-resume cycle is complete, so prepare to trigger a wa=
rning on
> > +        * subsequent attempts to enable it.
> > +        */
> > +       pm_runtime_block_if_disabled(dev);
> >
> >         if (dev->power.syscore)
> >                 return 0;
> > --- a/drivers/base/power/runtime.c
> > +++ b/drivers/base/power/runtime.c
> > @@ -1460,6 +1460,26 @@
> >  }
> >  EXPORT_SYMBOL_GPL(pm_runtime_barrier);
> >
> > +void pm_runtime_block_if_disabled(struct device *dev)
> > +{
> > +       spin_lock_irq(&dev->power.lock);
> > +
> > +       if (dev->power.disable_depth && dev->power.last_status =3D=3D R=
PM_INVALID)
> > +               dev->power.last_status =3D RPM_BLOCKED;
> > +
> > +       spin_unlock_irq(&dev->power.lock);
> > +}
> > +
> > +void pm_runtime_unblock(struct device *dev)
> > +{
> > +       spin_lock_irq(&dev->power.lock);
> > +
> > +       if (dev->power.last_status =3D=3D RPM_BLOCKED)
> > +               dev->power.last_status =3D RPM_INVALID;
> > +
> > +       spin_unlock_irq(&dev->power.lock);
> > +}
> > +
> >  void __pm_runtime_disable(struct device *dev, bool check_resume)
> >  {
> >         spin_lock_irq(&dev->power.lock);
> > @@ -1518,6 +1538,10 @@
> >         if (--dev->power.disable_depth > 0)
> >                 goto out;
> >
> > +       if (dev->power.last_status =3D=3D RPM_BLOCKED) {
> > +               dev_warn(dev, "Attempt to enabled runtime PM when it is=
 blocked\n");
>
> /s/enabled/enable
>
> > +               dump_stack();
> > +       }
> >         dev->power.last_status =3D RPM_INVALID;
> >         dev->power.accounting_timestamp =3D ktime_get_mono_fast_ns();
> >
> > --- a/include/linux/pm.h
> > +++ b/include/linux/pm.h
> > @@ -597,6 +597,7 @@
> >         RPM_RESUMING,
> >         RPM_SUSPENDED,
> >         RPM_SUSPENDING,
> > +       RPM_BLOCKED,
> >  };
> >
> >  /*
> > --- a/include/linux/pm_runtime.h
> > +++ b/include/linux/pm_runtime.h
> > @@ -77,8 +77,10 @@
> >  extern int pm_schedule_suspend(struct device *dev, unsigned int delay)=
;
> >  extern int __pm_runtime_set_status(struct device *dev, unsigned int st=
atus);
> >  extern int pm_runtime_barrier(struct device *dev);
> > +extern void pm_runtime_block_if_disabled(struct device *dev);
> > +extern void pm_runtime_unblock(struct device *dev);
> >  extern void pm_runtime_enable(struct device *dev);
> > -extern void __pm_runtime_disable(struct device *dev, bool check_resume=
);
> > +extern void __pm_runtime_disable(struct device *dev, bool regular);
>
> This looks unrelated to the $subject patch.
>
> >  extern void pm_runtime_allow(struct device *dev);
> >  extern void pm_runtime_forbid(struct device *dev);
> >  extern void pm_runtime_no_callbacks(struct device *dev);
> > @@ -271,6 +273,8 @@
> >  static inline int __pm_runtime_set_status(struct device *dev,
> >                                             unsigned int status) { retu=
rn 0; }
> >  static inline int pm_runtime_barrier(struct device *dev) { return 0; }
> > +static inline void pm_runtime_block_if_disabled(struct device *dev) {}
> > +static inline void pm_runtime_unblock(struct device *dev) {}
> >  static inline void pm_runtime_enable(struct device *dev) {}
> >  static inline void __pm_runtime_disable(struct device *dev, bool c) {}
> >  static inline void pm_runtime_allow(struct device *dev) {}
> >
> >
> >
>
> With the minor things above fixed, feel free to add:

I'll fix these in v2.

> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Thanks!

