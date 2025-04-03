Return-Path: <linux-pci+bounces-25232-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B9FA7A1B2
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 13:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F226F1886460
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 11:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D0424BBFB;
	Thu,  3 Apr 2025 11:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eyFg3Apd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD1024BBE1;
	Thu,  3 Apr 2025 11:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743678739; cv=none; b=Uc1zodBAUQO7BJ5KhHlpkQFh5wSvizAjH/+W+vnHJ9MAG837415Ps6fkOBF1FQF2X5z6Ch3/2qiadXDd8UXXx24reShk4Oo+u8dblKR7/MRLxyd2d+ehLiUu2a0mQrVUNaS+K/26+mmLv/6wlUpOuAXuXsxewIawxSNZHKeQ+ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743678739; c=relaxed/simple;
	bh=ogSVMxgN72aBuU2o0uVtAe9d36Kre0+w8LLSPnvE4g4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WMcOssW0OqssTq7pJgTf9VYqdEtVOzf9PfX2eHqbQuLIJx9BQC3jDIHCKACs67v8Vamsq8DhvZN5Mlo0EAqN6DfK40qnfAHNwJKWGuztbyXJ8FCtB60dZxLhrepj+OXH4ehEmlsgHZtzz7jyGpFaduXtVqvg31fOG62LaLDUEMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eyFg3Apd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71648C4AF09;
	Thu,  3 Apr 2025 11:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743678739;
	bh=ogSVMxgN72aBuU2o0uVtAe9d36Kre0+w8LLSPnvE4g4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eyFg3ApdtYY/FTGhhijAAfZeL++T0Jd7VjIruDSWYHyQ4fdVhX1oykQXAUn7L6MeL
	 CH4rdZwvbNCUKxvVxCTrGV0aeQDHR4N8EvU3WmVFcqiYg2ajrJj8N+WhQ12wwN9jBQ
	 aN+wCS1U3jDAmGgBKxPdPdgRyPnmwX3neP3VI+UwAc21fLxt2QwG68cTSZ07r8ymYN
	 4sd2eea/AP5M9umPa4D4iZlJlFGdcLoMjRTVWFpnjDE7UQAxWGMu70cYUE9Ly8Dp5H
	 PFr4MpN1OVVJ56whCBbMzoR5002FYIL+qafgx19TufjeHQNArkDDIHxM0T8KOPfYWA
	 7R/oHEdRJgLaQ==
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-72b82c8230aso263256a34.2;
        Thu, 03 Apr 2025 04:12:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWHNBInnTnB/aHNKlLoStaiLThSaqaDO6Ru1DhwT4f30tlKB+pZPijkOtGwrEn3guEkF8T6sDVFjWNhXng=@vger.kernel.org, AJvYcCXNiEozWSraibOExeTCVPd8AiEUIfQcKeJTxTQ7yPByGiPzcK7jMwJGJKEB0tRK7LJ4/a/Ztuwfepua@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2RZtt4tmAbI4Gn3LDPX9FdnHadXKmI3OuOsundJ64Lpn8+iNo
	iaeepg6Y9JPQCKNmRTGFcQW+wt1v4utstyPebsTG3SzEApYZGxvvHCaVnMaubqbWJSrHhCXcg+l
	L44yV8ztTXeWlU7M+x5vRt5vchiY=
X-Google-Smtp-Source: AGHT+IEZaf9Kl+KGCPc4RMkrG8ljVJ8T3vlm0+z8427y7Jf/gbdFQU7E+MxEXyI0mNiqV5fH4QQBcke9iEL9nHuImp4=
X-Received: by 2002:a05:6830:3987:b0:72b:8c5a:7294 with SMTP id
 46e09a7af769-72e2581eae7mr4265172a34.9.1743678738747; Thu, 03 Apr 2025
 04:12:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z-WHYbhu1QdjUFPR@intel.com> <Z-bICZUBN_Fk0_mM@intel.com>
 <Z-eDJUtxjzIjGlJT@black.fi.intel.com> <Z-q_n1g9wIEZc-dm@intel.com>
 <2d3f3cbe-c33d-4ded-8c19-e2bd2e76a68b@intel.com> <Z-woHnrukI7qtB4m@black.fi.intel.com>
 <CAJZ5v0j7ob4YQ9weQ6e5iVbHyRwf-6Vk2MU4r9mK11-8wD09RQ@mail.gmail.com>
 <Z-znv8D3qIcVX-p1@black.fi.intel.com> <Z-z2fz97RwX2kBya@black.fi.intel.com>
 <CAJZ5v0hpkjH_Q7V70jWpC68YQxKkmh0wpwrPrHcUwQJ6uRGrOQ@mail.gmail.com> <Z-38rPeN_j7YGiEl@black.fi.intel.com>
In-Reply-To: <Z-38rPeN_j7YGiEl@black.fi.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 3 Apr 2025 13:12:07 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g-aJXfVH+Uc=9eRPuW08t-6PwzdyMXsC6FZRKYJtY03Q@mail.gmail.com>
X-Gm-Features: AQ5f1JoF4-_5bKfDoLWHC0gguPoQcwlvzlHYOMkAxTdchA5EAu6d_gDHqIb8Rng
Message-ID: <CAJZ5v0g-aJXfVH+Uc=9eRPuW08t-6PwzdyMXsC6FZRKYJtY03Q@mail.gmail.com>
Subject: Re: [PATCH] drm/xe/d3cold: Set power state to D3Cold during s2idle/s3
To: Raag Jadav <raag.jadav@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, 
	lucas.demarchi@intel.com, rodrigo.vivi@intel.com, 
	"Nilawar, Badal" <badal.nilawar@intel.com>, intel-xe@lists.freedesktop.org, 
	anshuman.gupta@intel.com, mahesh@linux.ibm.com, oohall@gmail.com, 
	bhelgaas@google.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 3, 2025 at 5:12=E2=80=AFAM Raag Jadav <raag.jadav@intel.com> wr=
ote:
>
> Cc: PCI maintainers
>
> On Wed, Apr 02, 2025 at 12:31:48PM +0200, Rafael J. Wysocki wrote:
> > On Wed, Apr 2, 2025 at 10:34=E2=80=AFAM Raag Jadav <raag.jadav@intel.co=
m> wrote:
> > >
> > > On Wed, Apr 02, 2025 at 10:31:16AM +0300, Raag Jadav wrote:
> > > > On Tue, Apr 01, 2025 at 09:35:49PM +0200, Rafael J. Wysocki wrote:
> > > > > On Tue, Apr 1, 2025 at 7:53=E2=80=AFPM Raag Jadav <raag.jadav@int=
el.com> wrote:
> > > >
> > > > ...
> > > >
> > > > > > That's not what I meant here. There are multiple issues at play=
.
> > > > > >
> > > > > > 1. An AER is reported[*] on root port during system suspend eve=
n before we
> > > > > >    reach any of the driver PM callback. From initial investigat=
ion it seems
> > > > > >    like a case of misbehaviour by some child device, but this i=
s a different
> > > > > >    issue entirely.
> > > > > >
> > > > > > [*] irq/120-aerdrv-145     [002] .....  1264.981023: <stack tra=
ce>
> > > > > > =3D> xe_pm_runtime_resume
> > > > > > =3D> xe_pci_runtime_resume
> > > > > > =3D> pci_pm_runtime_resume
> > > > > > =3D> __rpm_callback
> > > > > > =3D> rpm_callback
> > > > > > =3D> rpm_resume
> > > > > > =3D> __pm_runtime_resume
> > > > > > =3D> pci_pm_runtime_get_sync
> > > > > > =3D> __pci_walk_bus
> > > > > > =3D> pci_walk_bus
> > > > > > =3D> pcie_do_recovery
> > > > > > =3D> aer_process_err_devices
> > > > > > =3D> aer_isr
> > > > > >
> > > > > > 2. Setting explicit pci_set_power_state(pdev, PCI_D3cold) from =
xe_pm_suspend().
> > > > > >    Although we see many drivers do it for their case, it's quit=
e a questionable
> > > > > >    choice (atleast IMHO) to hard suspend the device from driver=
 PM callback
> > > > > >    without any regard to runtime_usage counter. It can hide pot=
ential issues
> > > > > >    like AER during system suspend (regardless of whether or not=
 it is supported
> > > > > >    by the driver, since it is supposed to keep the device activ=
e on such a
> > > > > >    catastrophic failure anyway), but I'll leave it to the exper=
ts to decide.
> > > > >
> > > > > If the driver does not set DPM_FLAG_SMART_SUSPEND, and xe doesn't=
 set
> > > > > it AFAICS (at least not in the mainline), pci_pm_suspend() will r=
esume
> > > > > the device from runtime suspend before invoking its driver's call=
back.
> > > > >
> > > > > This guarantees that the device is always RPM_ACTIVE when
> > > > > xe_pci_suspend() runs and it cannot be runtime-suspended because =
the
> > > > > core is holding a runtime PM reference on it (and so the runtime =
PM
> > > > > usage counter is always greater than zero when xe_pci_suspend() r=
uns).
> > > > >
> > > > > This means that neither xe_pci_runtime_suspend() nor
> > > > > xe_pci_runtime_resume() can run concurrently with respect to it, =
so
> > > > > xe_pci_suspend() can change the power state of the device etc. sa=
fely.
> > > >
> > > > Ah, I failed to notice that __pm_runtime_resume() is taking a spin_=
lock_irqsave().
> > > > Thanks for clearing this up.
> > >
> > > On second thought, pcie_do_recovery() can still race with xe_pci_susp=
end(),
> > > is this understanding correct?
> >
> > Yes, it can, but this is an AER issue.
> >
> > Apparently, somebody took runtime PM into account, but they failed to
> > take system suspend into account.
> >
> > There are many drivers that do PCI PM in their ->suspend() callbacks
> > and this predates pcie_do_recovery() AFAICS.  Some of them don't even
> > support runtime PM.
> >
> > > I'm assuming this is why it's much safer to do pci_save_state() and
> > > pci_prepare_to_sleep() only in ->noirq() callbacks like originally do=
ne
> > > by PCI PM, right?
> >
> > Not really, but close.
> >
> > The noirq phases were introduced because drivers often failed to
> > prevent their interrupt handlers from messing up with devices after
> > powering them down.
> >
> > Recovery is kind of like hot-add, doing any of them during system
> > suspend is a bad idea because the outcome is hard to predict.
> >
> > AER needs to be fixed.
>
> I agree it's a bad idea and should be fixed but even more unpredictable
> in such cases is resuming the device afterwards, which may or may not
> succeed depending on the fault that has happened. So perhaps just not
> let the device suspend to D3 at all?

Yes, it is better to leave the device in question in its current power
state in that case.

