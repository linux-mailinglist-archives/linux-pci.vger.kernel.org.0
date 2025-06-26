Return-Path: <linux-pci+bounces-30696-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6DDAE9A56
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 11:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C204E3AC0D4
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 09:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B383C29E115;
	Thu, 26 Jun 2025 09:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ScBbOi07"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B6415539A;
	Thu, 26 Jun 2025 09:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750930887; cv=none; b=mUiTUONG+Hu3SZhEGIYCo99jLkjHuWjZT/sujJuSA2PV0Xn1ybhXu22RiW1BHEQuyxsWzAN01V6Ygw81aDxrMu2PAdo0hSUxvL63cb3IAK36V3yYfuBrt9Q2xSIhsYHAFL+u2g0FMsaTsZiLpwpgYijm/A5M9O2CCcZgOAv4sKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750930887; c=relaxed/simple;
	bh=kXlWtFJHYGZXpfxU2XTeWX5St19iKLmVxqcz6yj4hsI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eB4qGHjMVmBhMXrQhYOMASgxPVI7wL1Lu6r//cIc1s8nbQDbGx7bq1T85y7nreTfbpkIZQ/izwtuxIzFLb9/Q8y/OpKO1DFl8ZWkPDDXNTNr43Ef/sRjzsKDONViDF+iLBNmMax1+/0NfCPGKKcE2GiLLrbCWATQIRujfDqbaT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ScBbOi07; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B32AC4CEF4;
	Thu, 26 Jun 2025 09:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750930887;
	bh=kXlWtFJHYGZXpfxU2XTeWX5St19iKLmVxqcz6yj4hsI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ScBbOi07yuPICS41cWr23Z8x2Dj6pCzsY3pt4nv7xT5ANvkI/acXnHtiY+7hQGpXy
	 DOBY0yVLXK7EIyR+Nl2j4tFeG/azHDbmgSDDSxqjctSEh3TQjTO4ix81yX4SSAFmR8
	 YqaEejf66EIH2my6g0Hg5n23aGExiRYHLE9Fq4udNfCuR7RKI+vrnyaI5vugjrdg81
	 NbctxnOxn97CxC1xPM3VIbGkknseMAVMTq/xKhyTfFv4rSMIY/yixJUSkCTTYr2QZe
	 CZI5kh6vFcWDRO2sO2iz7vTkGBnBgWsESpZVMVNJBBBJiHqbCHHFPMX9ajqzwRmkFg
	 QI/jxC941Nmsg==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-611998766c0so441024eaf.1;
        Thu, 26 Jun 2025 02:41:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU0aVubtXBluevkUkXfhG/FCNHWmBpY9UhQKoQrA0XvGD+O9dOvEmBfWjZ9UmWE8zGviY2K19yQsJHZ@vger.kernel.org, AJvYcCUbC4Z2E/6qJCJReW2ZqKgqj22qSQVp6K/sk7A2ziKHN6Nw/ops524+zR4Awn7UiGcfR0NP3/35uxk=@vger.kernel.org, AJvYcCVFSl/W1OOcfjbzb35OQIXCHqlWMWTL/U3FO9jri/PF73CG2dQwnUT1XV5WDEcovU2Zo+gnEHDXI13nXENI@vger.kernel.org, AJvYcCWeGMsPTEPZpLtlkRBHHwdt+TY2XqYnuSuUXmvuDTpobaw8vj+4cpUjDgnGvtobKn9IZuW787Xmk88t@vger.kernel.org
X-Gm-Message-State: AOJu0YyST7/uH6ZVsazOhAOfyMoZa+YtaJvaC89+DRWFqTNVwPUKbSq0
	peiP9p/xSk4CwrOzJM1l7yCGAzn2ibnk20+nWeH3eC9BON38/S+ob0VKoH3ALgVl/VE3TImaNzH
	1eYm/r54ub62V8Vf6AxAwPff28dm4eMI=
X-Google-Smtp-Source: AGHT+IFFwcMnbazn9ld0BJf02w2SGzFl4BsPLD6/WVI+cKUPMvArB0HpKkLKr9h1POnuYo1bzegPrS6Er7Okr8detwA=
X-Received: by 2002:a05:6820:907:b0:611:b1b0:2adf with SMTP id
 006d021491bc7-611b1b02e35mr448886eaf.1.1750930886224; Thu, 26 Jun 2025
 02:41:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <22759968.EfDdHjke4D@rjwysocki.net> <2045419.usQuhbGJ8B@rjwysocki.net>
 <CAPDyKFq8ea+YogkAExUOBc2TEqi1z9WZswqgP29bLbursFUApg@mail.gmail.com>
In-Reply-To: <CAPDyKFq8ea+YogkAExUOBc2TEqi1z9WZswqgP29bLbursFUApg@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 26 Jun 2025 11:41:14 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h-9UnvhrQ7YaaYPG5CktwV-i+ZeqAri8OhJQb4TVp82w@mail.gmail.com>
X-Gm-Features: Ac12FXx4t9s1OQAcDGkW25YSbl2lqTUdJSGgwNxO3wpv-ubVObtrt96eUGaNFYE
Message-ID: <CAJZ5v0h-9UnvhrQ7YaaYPG5CktwV-i+ZeqAri8OhJQb4TVp82w@mail.gmail.com>
Subject: Re: [PATCH v1 4/9] PM: Move pm_runtime_force_suspend/resume() under CONFIG_PM_SLEEP
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	Linux PCI <linux-pci@vger.kernel.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 11:38=E2=80=AFAM Ulf Hansson <ulf.hansson@linaro.or=
g> wrote:
>
> On Wed, 25 Jun 2025 at 21:25, Rafael J. Wysocki <rjw@rjwysocki.net> wrote=
:
> >
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Since pm_runtime_force_suspend/resume() and pm_runtime_need_not_resume(=
)
> > are only used during system-wide PM transitions, there is no reason to
> > compile them in if CONFIG_PM_SLEEP is unset.
> >
> > Accordingly, move them all under CONFIG_PM_SLEEP and make the static
> > inline stubs for pm_runtime_force_suspend/resume() return an error
> > to indicate that they should not be used outside CONFIG_PM_SLEEP.
> >
>
> Just realized that there seems to be some drivers that actually make
> use of pm_runtime_force_suspend() from their ->remove() callbacks.
>
> To not break them, we probably need to leave this code to stay under CONF=
IG_PM.

OK, pm_runtime_force_suspend() need not be under CONFIG_PM_SLEEP.
That's not the case for the other two functions though AFAICS.

> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/base/power/runtime.c |    4 ++++
> >  include/linux/pm_runtime.h   |   20 ++++++++++++++------
> >  2 files changed, 18 insertions(+), 6 deletions(-)
> >
> > --- a/drivers/base/power/runtime.c
> > +++ b/drivers/base/power/runtime.c
> > @@ -1941,6 +1941,8 @@
> >         pm_request_idle(link->supplier);
> >  }
> >
> > +#ifdef CONFIG_PM_SLEEP
> > +
> >  bool pm_runtime_need_not_resume(struct device *dev)
> >  {
> >         return atomic_read(&dev->power.usage_count) <=3D 1 &&
> > @@ -2063,3 +2065,5 @@
> >         return ret;
> >  }
> >  EXPORT_SYMBOL_GPL(pm_runtime_force_resume);
> > +
> > +#endif /* CONFIG_PM_SLEEP */
> > --- a/include/linux/pm_runtime.h
> > +++ b/include/linux/pm_runtime.h
> > @@ -66,9 +66,6 @@
> >
> >  extern int pm_generic_runtime_suspend(struct device *dev);
> >  extern int pm_generic_runtime_resume(struct device *dev);
> > -extern bool pm_runtime_need_not_resume(struct device *dev);
> > -extern int pm_runtime_force_suspend(struct device *dev);
> > -extern int pm_runtime_force_resume(struct device *dev);
> >
> >  extern int __pm_runtime_idle(struct device *dev, int rpmflags);
> >  extern int __pm_runtime_suspend(struct device *dev, int rpmflags);
> > @@ -257,9 +254,6 @@
> >
> >  static inline int pm_generic_runtime_suspend(struct device *dev) { ret=
urn 0; }
> >  static inline int pm_generic_runtime_resume(struct device *dev) { retu=
rn 0; }
> > -static inline bool pm_runtime_need_not_resume(struct device *dev) {ret=
urn true; }
> > -static inline int pm_runtime_force_suspend(struct device *dev) { retur=
n 0; }
> > -static inline int pm_runtime_force_resume(struct device *dev) { return=
 0; }
> >
> >  static inline int __pm_runtime_idle(struct device *dev, int rpmflags)
> >  {
> > @@ -330,6 +324,20 @@
> >
> >  #endif /* !CONFIG_PM */
> >
> > +#ifdef CONFIG_PM_SLEEP
> > +
> > +extern bool pm_runtime_need_not_resume(struct device *dev);
> > +extern int pm_runtime_force_suspend(struct device *dev);
> > +extern int pm_runtime_force_resume(struct device *dev);
> > +
> > +#else /* !CONFIG_PM_SLEEP */
> > +
> > +static inline bool pm_runtime_need_not_resume(struct device *dev) {ret=
urn true; }
> > +static inline int pm_runtime_force_suspend(struct device *dev) { retur=
n -ENXIO; }
> > +static inline int pm_runtime_force_resume(struct device *dev) { return=
 -ENXIO; }
> > +
> > +#endif /* CONFIG_PM_SLEEP */
> > +
> >  /**
> >   * pm_runtime_idle - Conditionally set up autosuspend of a device or s=
uspend it.
> >   * @dev: Target device.
> >
> >
> >
>

