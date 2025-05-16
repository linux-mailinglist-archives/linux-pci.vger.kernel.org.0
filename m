Return-Path: <linux-pci+bounces-27897-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A29CAABA462
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 21:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87BAAA077A7
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 19:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED18926F46C;
	Fri, 16 May 2025 19:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="icD9cTwT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C9A192598;
	Fri, 16 May 2025 19:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747425197; cv=none; b=GRcA2uVeb9arizQKFOjIF+LusEJo8i9TalgNbP1xrCnT4f9QbKvgMY+rSz97ZbAJDQ5R0Indm9O6I8jANzPoLPlykeHFryehGr8/I7mcKJ58IeLN0Z8yoEOQ7NsxUmTffyv/zInE1PaIQDfxZ8znNZ2+a3Kw/YVagzo5nT9Uuno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747425197; c=relaxed/simple;
	bh=QQFP9I9xGbSP7aMAox64mdyWnEHDK01wUlBlFz+8IIk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yem3hHO3hlF6BEXMsktvmM+/y5R+Gwl5P01gf/UJLuG2ktvA/1VtdK3E6LgKedxQG95vuPPxiPQDPhJUCYtm3pYZUNnbgBN6lQOpuRDrCQDx30WsbrLnxRwI3t0M/QKYY7eFVckyuwBBGgWvD34DgBrX1pPuCLhQFEZtT8X369E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=icD9cTwT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28929C4AF0B;
	Fri, 16 May 2025 19:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747425197;
	bh=QQFP9I9xGbSP7aMAox64mdyWnEHDK01wUlBlFz+8IIk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=icD9cTwTL+4LP2EHR7A/ch2PUjUZvLjY/wOYIcNn9vp4OsfzaX5wObGoNwCEqCSp5
	 7fL/YmY7QaXIDK7CEa6jzq+lli4bjCglBh0Ro9M05c22FfHIab/VC48Ubzi94YHRXi
	 YxY1N4BR3EVS3/z5YZ099uPyOPmq21QPlbWI8ybRo0cyWff1wRFk58BeSbeLBMPkHF
	 fdSZjOuhmSf1n+gfYRna2xDTLfLAqzfIZg14DkniXRcEeiE/sbKHYLungIokHPMWap
	 YMY7SubZ1sfmZ6EpJ4t6P5QjLtMtcmfpAW3VzxJUzrkXsUnnjiVA0U5ant5zwnRXkE
	 yMzfoDG/4tBZg==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2cc82edcf49so230686fac.1;
        Fri, 16 May 2025 12:53:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVEvusN/lOZ7soLUtzyIOabBMHCVhmdwQul/WPeYySzROwnHYp4Nvp3UyNamPJYjI8T4IHhqdUmcVU=@vger.kernel.org, AJvYcCWcvKY0pvMEaVBnAFw8eh2nL3NFF32R/td3Eiq4oTzKV2U3UwK5zm5UCbeztUBIWwUwq6pT0kpk7Veu@vger.kernel.org, AJvYcCXzhZVl1MHwSyar9SNXAZUknG1PV+57c2vtmxJ4gj2VQD5+Z2z7ku2vYfQwjWwqxQtEVKEKIE+MOU4rSFA=@vger.kernel.org
X-Gm-Message-State: AOJu0YycZ7E1/AqjAzxw7yGZLbfW/a48ry8uaU/XXgiONuNqzeODM/JD
	LoM3BcTRPiO3JKrwOPNOn3/uI/FaxZWiZoH/K7A6YgyUTaH3F0BG+OklvhjBRQg7MYXngA57HVy
	byGdBHMqRkrmLO9+fR18IR1k5zMAyLrw=
X-Google-Smtp-Source: AGHT+IHVEU4gjatu/RMVom2ksKqHlYaJz0w2soN4yprttFQbRpMz2YGaP1tqoqkPACdW5qYoj1N9yc7K0LLBujvDxIE=
X-Received: by 2002:a05:6870:2a4c:b0:29f:97af:a1a0 with SMTP id
 586e51a60fabf-2e3c84d532amr2017577fac.24.1747425196436; Fri, 16 May 2025
 12:53:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250514193406.3998101-1-superm1@kernel.org> <20250514193406.3998101-2-superm1@kernel.org>
 <CAJZ5v0jifqTP_eZ33nBmKPCuLWrrVF_0jNGf5CpHU6nXuK8qBw@mail.gmail.com> <d77b51a6-24a0-4b24-b3f8-c6de8809b686@kernel.org>
In-Reply-To: <d77b51a6-24a0-4b24-b3f8-c6de8809b686@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 16 May 2025 21:53:05 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g_SRhQWrUYkKb6X3i1jKTeMoZvohZzq_Lpf0mM-UzUiA@mail.gmail.com>
X-Gm-Features: AX0GCFuB9LlaVI_p6ZZGmurTFqClTfA7X9euCJNdWFzYSpMo0mgCEYFiDin9G40
Message-ID: <CAJZ5v0g_SRhQWrUYkKb6X3i1jKTeMoZvohZzq_Lpf0mM-UzUiA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] PM: Use hibernate flows for system power off
To: Mario Limonciello <superm1@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Alex Deucher <alexander.deucher@amd.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, 
	"open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>, 
	"open list:HIBERNATION (aka Software Suspend, aka swsusp)" <linux-pm@vger.kernel.org>, 
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	Mario Limonciello <mario.limonciello@amd.com>, AceLan Kao <acelan.kao@canonical.com>, 
	Kai-Heng Feng <kaihengf@nvidia.com>, Mark Pearson <mpearson-lenovo@squebb.ca>, 
	=?UTF-8?Q?Merthan_Karaka=C5=9F?= <m3rthn.k@gmail.com>, 
	Denis Benato <benato.denis96@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 16, 2025 at 9:33=E2=80=AFPM Mario Limonciello <superm1@kernel.o=
rg> wrote:
>
> On 5/16/2025 9:58 AM, Rafael J. Wysocki wrote:
> > On Wed, May 14, 2025 at 9:34=E2=80=AFPM Mario Limonciello <superm1@kern=
el.org> wrote:
> >>
> >> From: Mario Limonciello <mario.limonciello@amd.com>
> >>
> >> When the system is powered off the kernel will call device_shutdown()
> >> which will issue callbacks into PCI core to wake up a device and call
> >> it's shutdown() callback.  This will leave devices in ACPI D0 which ca=
n
> >> cause some devices to misbehave with spurious wakeups and also leave s=
ome
> >> devices on which will consume power needlessly.
> >>
> >> The issue won't happen if the device is in D3 before system shutdown, =
so
> >> putting device to low power state before shutdown solves the issue.
> >>
> >> ACPI Spec 6.5, "7.4.2.5 System \_S4 State" says "Devices states are
> >> compatible with the current Power Resource states. In other words, all
> >> devices are in the D3 state when the system state is S4."
> >>
> >> The following "7.4.2.6 System \_S5 State (Soft Off)" states "The S5
> >> state is similar to the S4 state except that OSPM does not save any
> >> context." so it's safe to assume devices should be at D3 for S5.
> >>
> >> To accomplish this, modify the PM core to call all the device hibernat=
e
> >> callbacks when turning off the system when the kernel is compiled with
> >> hibernate support. If compiled without hibernate support or hibernate =
fails
> >> fall back into the previous shutdown flow.
> >>
> >> Cc: AceLan Kao <acelan.kao@canonical.com>
> >> Cc: Kai-Heng Feng <kaihengf@nvidia.com>
> >> Cc: Mark Pearson <mpearson-lenovo@squebb.ca>
> >> Cc: Merthan Karaka=C5=9F <m3rthn.k@gmail.com>
> >> Tested-by: Denis Benato <benato.denis96@gmail.com>
> >> Link: https://lore.kernel.org/linux-pci/20231213182656.6165-1-mario.li=
monciello@amd.com/
> >> Link: https://lore.kernel.org/linux-pci/20250506041934.1409302-1-super=
m1@kernel.org/
> >> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >> ---
> >> v2:
> >>   * Handle failures to hibernate (fall back to shutdown)
> >>   * Don't use dedicated events
> >>   * Only allow under CONFIG_HIBERNATE_CALLBACKS
> >> ---
> >>   kernel/reboot.c | 12 ++++++++++++
> >>   1 file changed, 12 insertions(+)
> >>
> >> diff --git a/kernel/reboot.c b/kernel/reboot.c
> >> index ec087827c85cd..52f5e6e36a6f8 100644
> >> --- a/kernel/reboot.c
> >> +++ b/kernel/reboot.c
> >> @@ -13,6 +13,7 @@
> >>   #include <linux/kexec.h>
> >>   #include <linux/kmod.h>
> >>   #include <linux/kmsg_dump.h>
> >> +#include <linux/pm.h>
> >>   #include <linux/reboot.h>
> >>   #include <linux/suspend.h>
> >>   #include <linux/syscalls.h>
> >> @@ -305,6 +306,17 @@ static void kernel_shutdown_prepare(enum system_s=
tates state)
> >>                  (state =3D=3D SYSTEM_HALT) ? SYS_HALT : SYS_POWER_OFF=
, NULL);
> >>          system_state =3D state;
> >>          usermodehelper_disable();
> >> +#ifdef CONFIG_HIBERNATE_CALLBACKS
> >> +       if (dpm_suspend_start(PMSG_HIBERNATE))
> >> +               goto resume_devices;
> >
> > A failure of one device may trigger a cascade of failures when trying
> > to resume devices and it is not even necessary to resume the ones that
> > have been powered off successfully.
>
> Right it "shouldn't" be necessary, but I wanted to make sure that we had
> a clean (expected) slate going into device_shutdown().
>
> Otherwise drivers might not have been prepared to go right from
> poweroff() to shutdown() callbacks.
>
> >
> > IMV this should just ignore errors during the processing of devices,
> > so maybe introduce PMSG_POWEROFF for it?
>
> Hmm - I guess it depends upon the failures that occurred.  I'll start
> plumbing a new message and see how it looks.
>
> I don't "think" we can safely call dpm_suspend_end() if
> dpm_suspend_start() failed though.

Nothing is safe at this point when dpm_suspend_start() fails, so why
not just continue.  Hopefully, it'll get to the point when power can
be turned off and then it won't matter too much anyway.

