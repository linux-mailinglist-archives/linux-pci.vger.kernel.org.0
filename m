Return-Path: <linux-pci+bounces-35850-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BCE2B51FF9
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 20:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08AB11C83D7A
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 18:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DDBF338F55;
	Wed, 10 Sep 2025 18:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p2Vz9JtB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18708275B1A
	for <linux-pci@vger.kernel.org>; Wed, 10 Sep 2025 18:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757527875; cv=none; b=j9YchP9LFIEm4l1SamXGPlgWiOmqgtE41kX80N7eCGty1pUI/n2+pAJe76uUHeFjaY8HOeefO8FMjsbmvIRZzDkA2g4zgULJEeySslthYfCFgBWilH4OTzd8lj+oXL0NvO4jiToiD08N4EfIjus7GCgSHlrXKRWsm/yCT1Uu964=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757527875; c=relaxed/simple;
	bh=S8HMTlK93t3B+OAQYTeNw7WY0mVBtqh39tE/WiUkVq4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NprQfwPrpE8gdV9lNI1M/fk1CZLAJmAQdj2R10NLQzUxkU/Bn0atufVfTVd0sqXK4k9xIM7ePsulZgXbnTiTPdTwITI9nuSTEdYzyu+cOPwNl51jCKbg47rmP6se9MeHRGuFPAREtFPsso+SSj9keFrCQCeIhYmBCblRBm2oaq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p2Vz9JtB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 813EAC4CEEB
	for <linux-pci@vger.kernel.org>; Wed, 10 Sep 2025 18:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757527874;
	bh=S8HMTlK93t3B+OAQYTeNw7WY0mVBtqh39tE/WiUkVq4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=p2Vz9JtB4qPLclMWf8U9cL6BZJPwrrEjmTF7pjDqy7TJhQEpJoz7E6htuRAUX9OrW
	 DiEnvhGV4Pf5JcVJbsGZ3Iou4RUQhPUyTy3dvMhLKD6kkt5oIGFUb/dH2o1n89TwZ1
	 ot3at3Vx09CfEzDi1pjhTbxu8z0RYe1rmS5FLfrHIpYHHGYwJkAAQZICQOXzj6j70K
	 pSbW9NH6vU6raSqbesVBrcLKQTECX/HFmsTV+Rz/F7IWRY9Stf/f4Cx4bTKktTOHGr
	 Y93XRjP5SWy5o9lIvV8vpY1tz7iYOG9/1R4P6LHUz6g1OcppORIK5VcFeQYCa33mMM
	 Uyjv12hSjcKAg==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-62182f350ddso2614777eaf.3
        for <linux-pci@vger.kernel.org>; Wed, 10 Sep 2025 11:11:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW0MLKEtFOiDT9VmNTccE8Nhyc6RGkin0E0o0mH4P/HoI5C7lHBv7ecGqoaa2EpF8dDGah26BJ2GWI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhgchTnun1XbiGaflTHD8HHMWZL0XlDIx1GBd+VFpGcyGiTg3o
	iKp/I1dXbYSPPJQhUVP7QRcNMObBuJxP45YHcyIYE9zLDnKtR2aCp6MgRETXO67rX6tbJTWEz5E
	HYibU7H3zC6ERfv+wdgeVxdohthC3e1c=
X-Google-Smtp-Source: AGHT+IGTSm11zpaMRBfmHdnY6TJXz12/bD9ev/202AUUsQjxBvHebprp+336DjRDm9VySYnrqJj3CUtw6WEC0dMU5gM=
X-Received: by 2002:a05:6820:4305:b0:621:a8cc:3a64 with SMTP id
 006d021491bc7-621a8cc3e9bmr1525050eaf.2.1757527873889; Wed, 10 Sep 2025
 11:11:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909191619.2580169-1-superm1@kernel.org>
In-Reply-To: <20250909191619.2580169-1-superm1@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 10 Sep 2025 20:11:01 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jZaP41CC_2Q4NfKZWB8VazJbmiOtv55i3QDngh_3YGOw@mail.gmail.com>
X-Gm-Features: Ac12FXzobk_htv7TNVqkwNPk1tfwfSSo2j8SCNAzmnpyqN6TqyM-aEdMTCWBlkc
Message-ID: <CAJZ5v0jZaP41CC_2Q4NfKZWB8VazJbmiOtv55i3QDngh_3YGOw@mail.gmail.com>
Subject: Re: [PATCH v7 00/12] Improvements to S5 power consumption
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Pavel Machek <pavel@kernel.org>, 
	Len Brown <lenb@kernel.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K . Petersen" <martin.petersen@oracle.com>, Steven Rostedt <rostedt@goodmis.org>, 
	"open list:HIBERNATION (aka Software Suspend, aka swsusp)" <linux-pm@vger.kernel.org>, 
	"open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>, 
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, 
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>, 
	"open list:SCSI SUBSYSTEM" <linux-scsi@vger.kernel.org>, 
	"open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>, 
	"open list:TRACING" <linux-trace-kernel@vger.kernel.org>, AceLan Kao <acelan.kao@canonical.com>, 
	Kai-Heng Feng <kaihengf@nvidia.com>, Mark Pearson <mpearson-lenovo@squebb.ca>, 
	=?UTF-8?Q?Merthan_Karaka=C5=9F?= <m3rthn.k@gmail.com>, 
	Eric Naim <dnaim@cachyos.org>, "Guilherme G . Piccoli" <gpiccoli@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mario,

On Tue, Sep 9, 2025 at 9:16=E2=80=AFPM Mario Limonciello (AMD)
<superm1@kernel.org> wrote:
>
> A variety of issues both in function and in power consumption have been
> raised as a result of devices not being put into a low power state when
> the system is powered off.
>
> There have been some localized changes[1] to PCI core to help these issue=
s,
> but they have had various downsides.
>
> This series instead uses the driver hibernate flows when the system is
> being powered off or halted.  This lines up the behavior with what other
> operating systems do as well.  If for some reason that fails or is not
> supported, run driver shutdown() callbacks.
>
> Rafael did mention in earlier versions of the series concerns about
> regression risk.  He was looking for thoughts from Greg who isn't against
> it but also isn't sure about how to maintain it. [1]
>
> This has been validated by me and several others in AMD
> on a variety of AMD hardware platforms. It's been validated by some
> community members on their Intel hardware. To my knowledge it has not
> been validated on non-x86.

Still, the patches need more work (see my replies to the relevant patches).

> On my development laptop I have also contrived failures in the hibernatio=
n
> callbacks to make sure that the fallback to shutdown callback works.
>
> In order to assist with potential regressions the series also includes
> documentation to help with getting a kernel log at shutdown after
> the disk is unmounted.
>
> Cc: AceLan Kao <acelan.kao@canonical.com>
> Cc: Kai-Heng Feng <kaihengf@nvidia.com>
> Cc: Mark Pearson <mpearson-lenovo@squebb.ca>
> Cc: Merthan Karaka=C5=9F <m3rthn.k@gmail.com>
> Cc: Eric Naim <dnaim@cachyos.org>
> Link: https://lore.kernel.org/linux-usb/2025090852-coma-tycoon-9f37@gregk=
h/ [1]
> ---
> v6->v7:
>  * Add documentation on how to debug a shutdown hang
>  * Adjust commit messages per feedback from Bjorn
>
> Mario Limonciello (AMD) (12):
>   PM: Introduce new PMSG_POWEROFF event
>   scsi: Add PM_EVENT_POWEROFF into suspend callbacks
>   usb: sl811-hcd: Add PM_EVENT_POWEROFF into suspend callbacks
>   USB: Pass PMSG_POWEROFF event to suspend_common()
>   PCI/PM: Disable device wakeups when halting or powering off system
>   PCI/PM: Split out code from pci_pm_suspend_noirq() into helper
>   PCI/PM: Run bridge power up actions as part of restore phase
>   PCI/PM: Use pci_power_manageable() in pci_pm_poweroff_noirq()
>   PCI: Put PCIe bridges with downstream devices into D3 at hibernate
>   drm/amd: Avoid evicting resources at S5
>   PM: Use hibernate flows for system power off
>   Documentation: power: Add document on debugging shutdown hangs

If I were you, I'd split this series into 3 parts.

The first part would be the addition of PMSG_POWEROFF just for
hibernation, which should not be objectionable (the first 4 patches
above).

The next one would be changes to allow PCI bridges to go into
D3hot/cold during the last stage of hibernation (the "power-off"
transition).  This can be justified by itself even before starting to
use the same power-off flow for the last stage of hibernation and for
system power-down.

The last one would be the hibernation/power-down integration.

Each of the above can be posted separately and arguably you need to
get the first part in before the other two and the second part in
before the third one, preferably not in the same cycle.

This way, if there are any regressions in the first two parts, there
will be at least some time to address them before the last part goes
in.

Thanks!

