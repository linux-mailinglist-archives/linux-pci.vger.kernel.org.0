Return-Path: <linux-pci+bounces-27295-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B93DAAACE0A
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 21:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9E681C08929
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 19:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FB43B1AB;
	Tue,  6 May 2025 19:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qyk8Lgko"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159984B1E5C
	for <linux-pci@vger.kernel.org>; Tue,  6 May 2025 19:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746559834; cv=none; b=cPfK99yNzvR3Mqo74efHYAQpRocqt2RxZclzshwIuMWeUcO/d89YPu88IZR2o7iXtPWCZ9wbuuDhAvC7FdyH8YZSqLfaEkUXFeypVOh+SOn2KIFzQYeMcm5wglKhEfHVpKVdmHV2xL3fOgPsmSIqBMkJCWnPR7s6l/kNccAm+w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746559834; c=relaxed/simple;
	bh=jKIW3LeFOgJ4s7LHOlb7+8gsnJrDe9aB1sJkzn4NrXY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xfx3iAy6XW9R8RSLReBGo5HW3G8V03zdGPjCfCUlcyzx89XHDSbBqxHdn50eHPdbUqeth5jd99wBjKt4JtDf3BXVe+/nOrsg82djrWJiI/9UkHZqGk9ctxrKQ07a6FWhDHlxquLatSeIFk1vHPAwpNeG1tTsIN57mvwW/yUvOqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qyk8Lgko; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 910BDC4CEED
	for <linux-pci@vger.kernel.org>; Tue,  6 May 2025 19:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746559833;
	bh=jKIW3LeFOgJ4s7LHOlb7+8gsnJrDe9aB1sJkzn4NrXY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Qyk8LgkotNtOZNWBbRhWaKsuNkRbkeyzjdmRYjixr3K+1iIw2T5aJasf1wr1Sn/xV
	 Xv2ylojxFpv99G0v7SqV8KQOauF+fFrQBG2b/FtJZrNKtPN/hWNUvgpgrzXr8cLGhC
	 J8RHvaFIlLaTRzsHjTgGzPYV49G2BSv5PYgjxNc8sjv/a/Ou6coyX4x9p5wHWV+xlf
	 DkDWAktQcqBwia/g8J5yyFgT1+EZdIgCdZ1d4kGaFKSdDG06lAgduRfIJ+5O8oA97B
	 Q2pHq/ygGGeE9iKQVl587YFnVAfkLvxfveRUY53tApZitDt7SmDVOy3fkDspa+HNQG
	 je7ANM9zp1M+A==
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6060a70ba80so3142639eaf.2
        for <linux-pci@vger.kernel.org>; Tue, 06 May 2025 12:30:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW0ZkWC2323GRHD7jpzE9vJe0+bjUMvrbX2tRn41lWoQW/ehurBirm759YAWB8MdAm8JE3IDrzwfdY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRVi2u02xSe3Ni/GJqCnbWABdQJg5jMxEK0BxDdauCqJ5tnOwL
	4+utULVwg3IGSRnWmIV14M7jNIaZD1Is7fYk5SHxKfEKORJcRw16eKNThPtrt/U2NwBz+4HqFx1
	psSyGUXevk8GDqyzc83KuM0ZUIYM=
X-Google-Smtp-Source: AGHT+IFoC8ZBn67gruQODBy3o5EyDmKOn8pzM3SEAaL0zqODB+ZFeMYeXNQ20Z84NqUs4q2NDFj/QqmUVRHaySuIr3w=
X-Received: by 2002:a05:6870:e9a3:b0:2b8:e4b9:47a3 with SMTP id
 586e51a60fabf-2db5bef6421mr312074fac.22.1746559832901; Tue, 06 May 2025
 12:30:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250506041934.1409302-1-superm1@kernel.org> <CAJZ5v0jXYgLsMHyD7EQwAf47=HnU7MCpC7+Th7nnonqV-q2qJQ@mail.gmail.com>
 <68fdf9e1-8f27-46a6-a8a2-11ffb84726c9@kernel.org>
In-Reply-To: <68fdf9e1-8f27-46a6-a8a2-11ffb84726c9@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 6 May 2025 21:30:20 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g8uYM2RE+VteviK_1zCxk-rRV=JQMcnF4Gvr6frEn4iA@mail.gmail.com>
X-Gm-Features: ATxdqUGLxEkqb57Op2RMOUBT_9UWMdm0w1RS_myHt3ocp0_hnL6iOsBF5nGujKQ
Message-ID: <CAJZ5v0g8uYM2RE+VteviK_1zCxk-rRV=JQMcnF4Gvr6frEn4iA@mail.gmail.com>
Subject: Re: [PATCH v3] PCI/PM: Put devices to low power state on shutdown
To: Mario Limonciello <superm1@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Kai-Heng Feng <kaihengf@nvidia.com>, bhelgaas@google.com, 
	AceLan Kao <acelan.kao@canonical.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, Denis Benato <benato.denis96@gmail.com>, 
	=?UTF-8?Q?Merthan_Karaka=C5=9F?= <m3rthn.k@gmail.com>, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 6, 2025 at 7:32=E2=80=AFPM Mario Limonciello <superm1@kernel.or=
g> wrote:
>
> On 5/6/2025 10:50 AM, Rafael J. Wysocki wrote:
> > On Tue, May 6, 2025 at 6:19=E2=80=AFAM Mario Limonciello <superm1@kerne=
l.org> wrote:
> >>
> >> From: Kai-Heng Feng <kaihengf@nvidia.com>
> >>
> >> Some laptops wake up after poweroff when HP Thunderbolt Dock G4 is
> >> connected.
> >>
> >> The following error message can be found during shutdown:
> >> pcieport 0000:00:1d.0: AER: Correctable error message received from 00=
00:09:04.0
> >> pcieport 0000:09:04.0: PCIe Bus Error: severity=3DCorrectable, type=3D=
Data Link Layer, (Receiver ID)
> >> pcieport 0000:09:04.0:   device [8086:0b26] error status/mask=3D000000=
80/00002000
> >> pcieport 0000:09:04.0:    [ 7] BadDLLP
> >>
> >> Calling aer_remove() during shutdown can quiesce the error message,
> >> however the spurious wakeup still happens.
> >>
> >> The issue won't happen if the device is in D3 before system shutdown, =
so
> >> putting device to low power state before shutdown to solve the issue.
> >>
> >> ACPI Spec 6.5, "7.4.2.5 System \_S4 State" says "Devices states are
> >> compatible with the current Power Resource states. In other words, all
> >> devices are in the D3 state when the system state is S4."
> >>
> >> The following "7.4.2.6 System \_S5 State (Soft Off)" states "The S5
> >> state is similar to the S4 state except that OSPM does not save any
> >> context." so it's safe to assume devices should be at D3 for S5.
> >
> > That's fine as long as you assume that ->shutdown() is only used for
> > implementing ACPI S5, but it is not.
>
> I suppose you're meaning things like:
>
> kernel_restart_prepare()
> ->device_shutdown()
> ->->each device's shutdown() CB
> ->->each driver's shutdown() CB
>
> Is there somewhere "better" to do this so it's truly only tied to S5?

On systems that use ACPI reboot is also a flavor of S5, but what about
systems that have PCI, but don't use ACPI?

The change you are proposing is going to affect more systems than just
the ones having the problem described in the patch changelog, so it is
kind of risky and breaking reboot is a big deal.

> >
> >> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D219036
> >> Cc: AceLan Kao <acelan.kao@canonical.com>
> >> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> >> Tested-by: Mario Limonciello <mario.limonciello@amd.com>
> >> Signed-off-by: Kai-Heng Feng <kaihengf@nvidia.com>
> >> Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> >> Tested-by: Denis Benato <benato.denis96@gmail.com>
> >> Tested-by: Merthan Karaka=C5=9F <m3rthn.k@gmail.com>
> >> Link: https://lore.kernel.org/r/20241208074147.22945-1-kaihengf@nvidia=
.com
> >> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >> ---
> >> v3:
> >>   * Pick up tags
> >>   * V2 was waiting for Rafael to review, rebase on pci/next and resend=
.
> >
> > Is this change going to break kexec?
>
> There is an explicit check in the below code for kexec_in_progress, so
> my expectation was that kexec kept working.  I didn't explicitly test
> this myself when I tested KH's change before sending it again.
>
> KH, Did you double check that on your side?
>
> >
> >> ---
> >>   drivers/pci/pci-driver.c | 8 ++++++++
> >>   1 file changed, 8 insertions(+)
> >>
> >> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> >> index 0c5bdb8c2c07b..5bbe8af996390 100644
> >> --- a/drivers/pci/pci-driver.c
> >> +++ b/drivers/pci/pci-driver.c
> >> @@ -510,6 +510,14 @@ static void pci_device_shutdown(struct device *de=
v)
> >>          if (drv && drv->shutdown)
> >>                  drv->shutdown(pci_dev);
> >>
> >> +       /*
> >> +        * If driver already changed device's power state, it can mean=
 the
> >> +        * wakeup setting is in place, or a workaround is used. Hence =
keep it
> >> +        * as is.
> >> +        */
> >> +       if (!kexec_in_progress && pci_dev->current_state =3D=3D PCI_D0=
)
> >> +               pci_prepare_to_sleep(pci_dev);
> >> +
> >>          /*
> >>           * If this is a kexec reboot, turn off Bus Master bit on the
> >>           * device to tell it to not continue to do DMA. Don't touch
> >> --
>

