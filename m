Return-Path: <linux-pci+bounces-42836-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 760ABCAFC71
	for <lists+linux-pci@lfdr.de>; Tue, 09 Dec 2025 12:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 726963011AAB
	for <lists+linux-pci@lfdr.de>; Tue,  9 Dec 2025 11:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1E228643A;
	Tue,  9 Dec 2025 11:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TLV5FeBE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE99D23185D
	for <linux-pci@vger.kernel.org>; Tue,  9 Dec 2025 11:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765279892; cv=none; b=dHWvS4l6COIDhXcvxJDthLDDnJIsPYD8KGrxgqY6R57PYDKI6zAE7n5MGX6iIq4JqAwt9f6uMMCrvYZfsquGsakBND2Qsvt+P2lfYpkCVgd8zr93wNP8TPQ2gy6BwmTAm6NlpXPBlogjZHpCYhzOqBftGtIG9xWwKStExB/5xag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765279892; c=relaxed/simple;
	bh=J/IOe5CTGP3RFLifuosyft8NxWk4Yo2Zm5latyruAVs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FCe13bV9uWGKzsbuOlUhHTq80PlGcaKVcWLFA/pG6sKOEbt9ODPotg0TQEGBPsUL2gQMYzNekcwDUTx9X9y6b/ry8m2m07a80R/pi7FwPRP0TqNK8VNZ+P+lzXkkSzKAsEcu27XJLfR97YegB/6yGXBz1ejCMBlosMO1rQ93Zf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TLV5FeBE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2206C116B1
	for <linux-pci@vger.kernel.org>; Tue,  9 Dec 2025 11:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765279891;
	bh=J/IOe5CTGP3RFLifuosyft8NxWk4Yo2Zm5latyruAVs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TLV5FeBE4E/FN1VE6rmUP6hPI6odOg1TY/fc6prnPSSdzcsG1S3rFHhteDqjTUPkI
	 /25mp1jBGKTbbRRVd45vp3lKlSkL9qBtkQe/o87SZKk+fnstf8MhNPFBnKVIfCpaaG
	 Ama7d6Tk03pZH1euCt/HgKFDXRKkcUSmEIMwnQnQNfDjaJjFUb71GExM2JHZ+fSaJ8
	 us0TRDZzj7T31W/tuaXh1fKTiQykWCIDaNoylMywpMa2q+jzoltXwNp4gO23/OhBFJ
	 FTl7uemMxHoC2HstzraOkWrlDMyKT7Y6fEhYUu5FZ3XtDLM0ak89VymWb1l9rGy9zz
	 9oIjbDyZVUT+w==
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-4557b865e60so158354b6e.0
        for <linux-pci@vger.kernel.org>; Tue, 09 Dec 2025 03:31:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXK5DT10NqITN9fIgdaw+cpGaUOjU9bs9/kpgFEvRFXRQc9HYmOIc/3usZ8TxRmrb8Z/FGtunkX7oo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjMn/RDQjb3Wff/DSeJjnQ4xqL6Y8bMv6gjFR2ZWKhntoJ3neM
	1fiBjVrFL0aUotARmu439a8ypDOFlgR2M2c304NmOKh0PF0bfxTVz2veAkvrP9Fq5ly/2DaDmcV
	fttE73lz9DRu0kiztBCkLiDIX4akNwxY=
X-Google-Smtp-Source: AGHT+IGsBG1uJpRAlc5vsAML/Hp087Kg6cb5xR4T6EedaOpUEnRMdjXG61qBORELGfgV07cLQnq5NA5SuyajyvOJf00=
X-Received: by 2002:a05:6808:238a:b0:44f:6a19:433e with SMTP id
 5614622812f47-4539df3cce5mr4237855b6e.15.1765279890960; Tue, 09 Dec 2025
 03:31:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2395536.ElGaqSPkdT@rafael.j.wysocki> <ab8b770c-08e9-4cf6-bd4f-f36c951fda4c@gmx.de>
In-Reply-To: <ab8b770c-08e9-4cf6-bd4f-f36c951fda4c@gmx.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 9 Dec 2025 12:31:18 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jAH9FZrO5AvVF90zgy-0EeM+rsB6Zf8cMf+sR8=FFuDA@mail.gmail.com>
X-Gm-Features: AQt7F2p3VPpnP4yl_PF4fpf1p7sxQR7LJIHVngPgfQZ51QSxFjiMDxvnIX6VadE
Message-ID: <CAJZ5v0jAH9FZrO5AvVF90zgy-0EeM+rsB6Zf8cMf+sR8=FFuDA@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] PCI: ACPI: PM: Rework root bus wakeup notification
 setup and wakeup source registration
To: Armin Wolf <W_Armin@gmx.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	Linux PM <linux-pm@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 8, 2025 at 9:01=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wrote:
>
> Am 08.12.25 um 13:09 schrieb Rafael J. Wysocki:
>
> > Hi All,
> >
> > Patch [1/2] updates the registration of PCI root bus wakeup notificatio=
n setup
> > in order to simplify code in pci_acpi_wake_bus() and to prepare for the=
 other
> > change.  This is not expected to affect functionality.
> >
> > Patch [2/2] modifies the ACPI PM notifier registration to add wakeup so=
urces
> > under devices that are going to be affected by wakeup handling instead =
of
> > registering them under ACPI companions of those devices (rationale expl=
ained
> > in the patch changelog).  This will change the sysfs layout (wakeup sou=
rce
> > devices associated with PCI wakeup are now going to appear under PCI de=
vices
> > and the host bridge device), but it is not expected to affect user spac=
e
> > adversely.
> >
> > Thanks!
>
> I tested both patches, and the sysfs layout changes as expected:
>
> $ readlink /sys/class/wakeup/wakeup*/device
> ../../../device:00
> ../../../device:1a
> ../../../device:1f
> ../../../device:20
> ../../../0000:00:08.1
> ../../../device:36
> ../../../device:31
> ../../../device:32
> ../../../device:3c
> ../../../0000:01:00.0
> ../../../device:3d
> ../../../PNP0C02:00
> ../../../0000:02:00.0
> ../../../device:3e
> ../../../device:3f
> ../../../device:46
> ../../../0000:04:00.0
> ../../../device:47
> ../../../0000:05:00.0
> ../../../device:57
> ../../../0000:05:08.0
> ../../../device:59
> ../../../device:01
> ../../../0000:05:09.0
> ../../../device:5b
> ../../../0000:05:0a.0
> ../../../device:5d
> ../../../0000:05:0b.0
> ../../../device:5f
> ../../../0000:05:0c.0
> ../../../device:74
> ../../../0000:05:0d.0
> ../../../device:5a
> ../../../device:3a
> ../../../device:5c
> ../../../device:60
> ../../../device:75
> ../../../LNXVIDEO:00
> ../../../device:22
> ../../../PNP0C02:02
> ../../../device:25
> ../../../device:2b
> ../../../device:24
> ../../../device:37
> ../../../0000:00:01.1
> ../../../PNP0A08:00
> ../../../LNXPWRBN:00
> ../../../AMDI0010:00
> ../../../AMDI0030:00
> ../../../00:02
> ../../../alarmtimer.0.auto
> ../../../PNP0C0C:00
> ../../../0000:0b:00.0
> ../../../AMDIF031:00
> ../../../PNP0C14:00
> ../../../device:0a
> ../../../PNP0C14:01
> ../../../PNP0C14:02
> ../../../PNP0C14:03
> ../../../0000:0e:00.3
> ../../../0000:0e:00.4
> ../../../0000:0f:00.0
> ../../../5-2
> ../../../1-5.3
> ../../hidpp_battery_0
> ../../../device:44
> ../../../0000:00:02.1
> ../../../device:76
> ../../../device:0b
>
> turns into:
>
> $ readlink /sys/class/wakeup/wakeup*/device
> ../../../0000:00:00.0
> ../../../0000:00:04.0
> ../../../0000:00:08.0
> ../../../0000:00:08.1
> ../../../0000:00:08.1
> ../../../0000:00:08.3
> ../../../0000:00:14.0
> ../../../0000:00:14.3
> ../../../0000:01:00.0
> ../../../0000:01:00.0
> ../../../0000:02:00.0
> ../../../0000:00:00.2
> ../../../0000:02:00.0
> ../../../0000:03:00.0
> ../../../0000:03:00.1
> ../../../0000:04:00.0
> ../../../0000:04:00.0
> ../../../0000:05:00.0
> ../../../0000:05:00.0
> ../../../0000:05:08.0
> ../../../0000:05:08.0
> ../../../0000:05:09.0
> ../../../0000:00:01.0
> ../../../0000:05:09.0
> ../../../0000:05:0a.0
> ../../../0000:05:0a.0
> ../../../0000:05:0b.0
> ../../../0000:05:0b.0
> ../../../0000:05:0c.0
> ../../../0000:05:0c.0
> ../../../0000:05:0d.0
> ../../../0000:05:0d.0
> ../../../0000:08:00.0
> ../../../0000:00:01.1
> ../../../0000:09:00.0
> ../../../0000:0b:00.0
> ../../../0000:0c:00.0
> ../../../0000:0e:00.0
> ../../../0000:0e:00.1
> ../../../0000:0e:00.2
> ../../../0000:0e:00.3
> ../../../0000:0e:00.4
> ../../../0000:0e:00.6
> ../../../0000:0f:00.0
> ../../../0000:00:01.1
> ../../../pci0000:00
> ../../../LNXPWRBN:00
> ../../../AMDI0010:00
> ../../../AMDI0030:00
> ../../../00:02
> ../../../alarmtimer.0.auto
> ../../../PNP0C0C:00
> ../../../0000:0b:00.0
> ../../../AMDIF031:00
> ../../../PNP0C14:00
> ../../../0000:00:02.0
> ../../../PNP0C14:01
> ../../../PNP0C14:02
> ../../../PNP0C14:03
> ../../../0000:0e:00.3
> ../../../0000:0e:00.4
> ../../../0000:0f:00.0
> ../../../5-2
> ../../../1-5.3
> ../../hidpp_battery_0
> ../../../0000:00:02.1
> ../../../0000:00:02.1
> ../../../0000:00:02.2
> ../../../0000:00:03.0
>
> The remaining ACPI devices are likely caused by device drivers based upon=
 struct acpi_driver.
> I was unable to test the wakeup itself since suspend is currently broken =
due to issues with
> cpuidle,

Have you reported those?  What cpuidle driver is involved?

If you happen to be using the ACPI idle driver, there is a regression
between 6.18-rc7 and final 6.18 due to a missing revert, but final
6.18 should be as expected.

> but i suspect that this has nothing to do with the patch series.

Right, cpuidle is entirely orthogonal to this.

> So for the whole series:
> Reviewed-by: Armin Wolf <W_Armin@gmx.de>

Thank you!

