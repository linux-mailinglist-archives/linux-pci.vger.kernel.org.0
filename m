Return-Path: <linux-pci+bounces-31272-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90416AF5AD1
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 16:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FC991C25DC0
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 14:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B862BDC3B;
	Wed,  2 Jul 2025 14:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CU8U4zrg"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDE52BDC09;
	Wed,  2 Jul 2025 14:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751465693; cv=none; b=J/1VpdpxTnpyZS9st9Q3RRzQUOIukqiSQ+gnmDuJsJJ+ZwlLOKzi/z6bYdUMDITcl8nHT2FwcarC2Zyocfh5wSYhNpZuzmTZAxNmh/b6KVDVffNhxDFz7MmDkaB2Z4Q7dfBHHaZxSXTpWhd5DARgsbdHGpdfoVQn139rysnRlkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751465693; c=relaxed/simple;
	bh=cprrfdfnU9GFDLUmsyw/iJaU4waUiVKSI0/qOUtlZWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MFY//nACPORmjBtLr8tgkhUM8gUufmXMlL3iwMfAsYF2lIDm4Gp4SNZw8COaibf32Nsye0arcX2hKOwZaQX9F3Ftq/dP8bCY9dHKDZlmXFBeEbnREL4F0iqlnKQPtfqGzv9pItky0XMRgGg0nU8a0Qu4PtpOKjkmA4GObCQdqI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CU8U4zrg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7D1EC4CEED;
	Wed,  2 Jul 2025 14:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751465692;
	bh=cprrfdfnU9GFDLUmsyw/iJaU4waUiVKSI0/qOUtlZWQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CU8U4zrgdeOOrMqsBqjl8oN28O7OcNV/P6D01cs7aHG6F7ElIR2/cSzbuEEyOVhU2
	 +reIKaSU69qgR0WZl/X/ANpmKRT+okQj2Ly6Q3TsZf3gce4X1qjPYImKzqkrnd2HC/
	 YxsGOzHVeY0S5Q+W5zXaX/2ShboY3qvtgseNqEN8ATsOcecLSjPPQ5cEjoj1T1xYhc
	 VC3XmAIXIcQeGibL8OCprYAwmrIQOGehD/aNXyj6rebrX2TRws+YmXvSuGoQHBNruy
	 LDn1n7W5YVVmVkJxvZhCzhiz+BaVB6o/qXC2VIO6I90r0cSRGSIw+W/dAbnUM0Q0/Y
	 ZOgbGQZUB+ONA==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6118b000506so1655420eaf.0;
        Wed, 02 Jul 2025 07:14:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUxu/QJ2AukRvYTJ1zOzJtL/ZvH1iWDrFAG52Oq75ZAAOjutXtBRLTI7+2J3HfY4qg/AK4w3mDPawhF6bHA@vger.kernel.org, AJvYcCV3lRs+IGlViacqBr6sDsiGSdI+AAEE48cW4a1fgeAy+Lv9prqMgz3/bP0sZfaqMSroLI2fuKhLbAM=@vger.kernel.org, AJvYcCVNSGl+dAiLB1kBYPWCTByUwdvmOFmNm2sNcG26sIPvdqYCl+cLkJAYjtq1sOh7rElsLhA6Z8PTKzUZ@vger.kernel.org, AJvYcCVhrHqIL9O6XPHFXGBTb0ZP0rN93rj7aBmKg3Cg7fpYsjqHeRhWfnEcsJx5tiredb5YEVajljxtfDZm@vger.kernel.org
X-Gm-Message-State: AOJu0YyVau6FaZEFz0cSeVM8QWPMZo4Vcu1qF5QPhmvERCZ33nDhfF2E
	BIGKvVN7zH6AI7nmhmbOs/J3FMffmvDRC3K26Sc9Lf8QeKrhJkOnU7USr51RaWK8elRbDUH4km+
	all0ix2lt7bLAzsjxR75Y7eIq0eQK2EM=
X-Google-Smtp-Source: AGHT+IEQO+KXDVZLq6/myG09rxbBy9SiNjHPGLbzpRLxLdOAI4nqsRB01fCB2AilRBxPlGh/izIPC0xuI9X8tQrQ0l4=
X-Received: by 2002:a05:6820:8c5:b0:611:e30a:f9c7 with SMTP id
 006d021491bc7-612010ace40mr2343538eaf.7.1751465691971; Wed, 02 Jul 2025
 07:14:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5018768.GXAFRqVoOG@rjwysocki.net> <CAPDyKFp35SjpQmEQ02u7ZbsaFftaett_rBBf-7hbsBpGWH08hw@mail.gmail.com>
In-Reply-To: <CAPDyKFp35SjpQmEQ02u7ZbsaFftaett_rBBf-7hbsBpGWH08hw@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 2 Jul 2025 16:14:40 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iDGb5KgE0pWKME5sL6wGE-nVOswqcs6K1uTTXB6zZBng@mail.gmail.com>
X-Gm-Features: Ac12FXzx7QK9Gzgzo2obLKRzjthdFPV8AyJTMHoK965542I2TdIqjRdZ2IHt05U
Message-ID: <CAJZ5v0iDGb5KgE0pWKME5sL6wGE-nVOswqcs6K1uTTXB6zZBng@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] PM: Reconcile different driver options for runtime
 PM integration with system sleep
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	Linux PCI <linux-pci@vger.kernel.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 4:12=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org>=
 wrote:
>
> On Fri, 27 Jun 2025 at 21:29, Rafael J. Wysocki <rjw@rjwysocki.net> wrote=
:
> >
> > Hi Everyone,
> >
> > This is an update of the series the v2 of which was posted yesterday:
> >
> > https://lore.kernel.org/linux-pm/5015172.GXAFRqVoOG@rjwysocki.net/
> >
> > and the v1 is here:
> >
> > https://lore.kernel.org/linux-pm/22759968.EfDdHjke4D@rjwysocki.net/
> >
> > This update reorders the patches (again), updates the changelogs of som=
e of
> > them and changes the subject of one patch slightly.  It also adds a ker=
neldoc
> > comment to a new function in patch [5/9].
> >
> > This part of the cover letter still applies:
> >
> > "This series addresses a couple of issues related to the integration of=
 runtime
> > PM with system sleep I was talking about at the OSMP-summit 2025:
> >
> > https://lwn.net/Articles/1021332/
> >
> > Most importantly, DPM_FLAG_SMART_SUSPEND cannot be used along with
> > pm_runtime_force_suspend/resume() due to some conflicting expectations
> > about the handling of device runtime PM status between these functions
> > and the PM core.
> >
> > Also pm_runtime_force_suspend/resume() currently cannot be used in PCI
> > drivers and in drivers that collaborate with the general ACPI PM domain
> > because they both don't expect their mid-layer runtime PM callbacks to
> > be invoked during system-wide suspend and resume.
> >
> > Patch [1/9] is a preparatory cleanup changing the code to use 'true' an=
d
> > 'false' as needs_force_resume flag values for consistency."
> >
> > Patch [2/9] (which was [3/9] in v2) puts pm_runtime_force_resume() and =
one
> > other function that is only used during system sleep transitions under
> > CONFIG_PM_SLEEP.
> >
> > Patch [3/9] (which was [5/9] in v2) causes the smart_suspend flag to be=
 taken
> > into account by pm_runtime_force_resume() which allows it to resume dev=
ices
> > with smart_suspend set whose runtime PM status has been changed to RPM_=
ACTIVE
> > by the PM core at the beginning of system resume.  After this patch, dr=
ivers
> > that use pm_runtime_force_suspend/resume() can also set DPM_FLAG_SMART_=
SUSPEND
> > which may be useful, for example, if devices handled by them are involv=
ed in
> > dependency chains with other devices setting DPM_FLAG_SMART_SUSPEND.
> >
> > Since patches [1,3/9] have been reviewed already and patch [2/9] should=
 not
> > be particularly controversial, I think that patches [1-3/9] are good to=
 go.
> >
> > Patch [4/9] (which was [2/9] in v2), makes pm_runtime_reinit() clear
> > needs_force_resume in case it was set during driver remove.
> >
> > Patch [5/9] (which was [4/9] in v2) makes pm_runtime_force_suspend() ch=
eck
> > needs_force_resume along with the device's runtime PM status upfront, a=
nd bail
> > out if it is set, which allows runtime PM status updates to be eliminat=
ed from
> > both that function and pm_runtime_force_resume().  I recalled too late =
that
> > it was actually necessary for the PCI PM and ACPI PM to work with
> > pm_runtime_force_suspend() correctly after the subsequent changes and t=
hat
> > patch [3/9] did not depend on it.  I have also realized that patch [5/9=
]
> > potentially unbreaks drivers that call pm_runtime_force_suspend() from =
their
> > "remove" callbacks (see the patch changelog for a bit of an explanation=
).
> >
> > Patch [6/9] (which has not been changed since v2) makes the code for ge=
tting a
> > runtime PM callback for a device a bit more straightforward, in prepara=
tion for
> > the subsequent changes.
> >
> > Patch [7/9] introduces a new device PM flag called strict_midlayer that
> > can be set by middle layer code which doesn't want its runtime PM
> > callbacks to be used during system-wide PM transitions, like the PCI bu=
s
> > type and the ACPI PM domain, and updates pm_runtime_force_suspend/resum=
e()
> > to take that flag into account.  Its changelog has been updated since v=
2 and
> > there is a new kerneldoc comment for dev_pm_set_strict_midlayer().
> >
> > Patch [8/9] modifies the ACPI PM "prepare" and "complete" callback func=
tions,
> > used by the general ACPI PM domain and by the ACPI LPSS PM domain, to s=
et and
> > clear strict_midlayer, respectively, which allows drivers collaborating=
 with it
> > to use pm_runtime_force_suspend/resume().  The changelog of this patch =
has been
> > made a bit more precise since v2.
> >
> > That may be useful if such a driver wants to be able to work with diffe=
rent
> > PM domains on different systems.  It may want to work with the general =
ACPI PM
> > domain on systems using ACPI, or with another PM domain (or even multip=
le PM
> > domains at the same time) on systems without ACPI, and it may want to u=
se
> > pm_runtime_force_suspend/resume() as its system-wide PM callbacks.
> >
> > Patch [9/9] updates the PCI bus type to set and clear, respectively, st=
rict_midlayer
> > for all PCI devices in its "prepare" and "complete" PM callbacks, in ca=
se some
> > PCI drivers want to use pm_runtime_force_suspend/resume() in the future=
.  They
> > will still need to set DPM_FLAG_SMART_SUSPEND to avoid resuming their d=
evices during
> > system suspend, but now they may also use pm_runtime_force_suspend/resu=
me() as
> > suspend callbacks for the "regular suspend" phase of device suspend (or=
 invoke
> > these functions from their suspend callbacks).  The changelog of this p=
atch has
> > been made a bit more precise since v2, like the changelog of patch [8/9=
].
> >
> > As usual, please refer to individual patch changelogs for more details.
> >
> > Thanks!
> >
>
> For the v3 series, please add:
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Thank you!

