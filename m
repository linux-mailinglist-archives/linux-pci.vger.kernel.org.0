Return-Path: <linux-pci+bounces-42874-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A074CB1AEE
	for <lists+linux-pci@lfdr.de>; Wed, 10 Dec 2025 02:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA15A3135C98
	for <lists+linux-pci@lfdr.de>; Wed, 10 Dec 2025 01:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C33D233721;
	Wed, 10 Dec 2025 01:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wr4zfoJ1"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265C223D7F0
	for <linux-pci@vger.kernel.org>; Wed, 10 Dec 2025 01:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765331800; cv=none; b=I2UK+r+QgwcnHqr3t89dEnvsUTkjVg+puI/3mHSd9F1zXa9Qe1fWNBLipzs/LQwIUjH/b1WYbmelqgGjsdaFPnhggQvqLERlZCBle1Kpydyn6rP4nmXXPpOPvD/Ufg5bnIxGYDqNXS3oaOZeorQ6PVEv6hKb0OTwOW30c90i1K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765331800; c=relaxed/simple;
	bh=X4DJeGka0bu9RIKgKWMUJEI7buygestyhQMN3mRduqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DMds1dXKFV4heNYVs2V4Bue0ZolyftZ+AZ2HmH/WZDwlsGvoA2CAP0aa6NQRrZqlyDxkvovxNkIRbqJZd8j7mUhaRTchijQgHMPCriTsuqyG4f4smCjPkI9hWIsEDJ+c6mxxCi9fxm6owG61ZM/atM/lfPHEXpsHJL7sjHIbxZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wr4zfoJ1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3392C19423
	for <linux-pci@vger.kernel.org>; Wed, 10 Dec 2025 01:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765331799;
	bh=X4DJeGka0bu9RIKgKWMUJEI7buygestyhQMN3mRduqA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Wr4zfoJ10i1/Nm2mLDBrH6HkszeMZLY9sRh8p0wqogXK0nNtD5OIydlN107B9lzN6
	 /H6rL6l4i6kaeJ/sFUvE8kX2zfDIknjK+OdN0Yc2NgRc+8c87+0XeAmBOyB9rysLge
	 ZaRQBNbzKrmivnBtJTKzkcnEKFvRisczreW2Alwi6oy3s5hGN8qftKJrdk9FDP0Tij
	 hFETWRqdoWZX06DaDQ4h9lfjY4e3T2NKRoI8p0jbycgWlAMCAF5es1Lw/Lvxf8WXfg
	 d1iP8Te0Dg2jhKoJhcSqdTkARKdyzWrhqmPHUwvjsfgiKG9XU4YhaeAzn4ocy3C3/R
	 SqnVVhBtEycVA==
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-45090ef26c6so1867639b6e.2
        for <linux-pci@vger.kernel.org>; Tue, 09 Dec 2025 17:56:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXZG5W6wNJFMnyCHDLPxJiZ90vYXxpF0IZnu5Ffsn485YA7TDGX2qEDZGyZY7dHvo5k9c93EqXBC0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8D2CzS9lKl2OOlcAYfykZbk5vYgK9TfzjABVdrCVU8sP2EZrJ
	cjK2Ltvyf0wJkQcZAG8HHDjH3mO5LKiGGAFpM0MIePowiiGslfzdPdTxRxopSpf0qMpjOKsdT59
	3yQsfOcEjzYFeLovApNFV6nqmH79efE4=
X-Google-Smtp-Source: AGHT+IG/ZLGI/rhGVj2C1m7vvSVnbJrWDnoH75WeI4uetKadw0Oo6KCLlcHazzHyMTAmDC/8cjOQW1pj87b5UKX/YlE=
X-Received: by 2002:a05:6808:1701:b0:43f:5619:ce72 with SMTP id
 5614622812f47-45586345bb2mr621771b6e.4.1765331799091; Tue, 09 Dec 2025
 17:56:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2395536.ElGaqSPkdT@rafael.j.wysocki> <ab8b770c-08e9-4cf6-bd4f-f36c951fda4c@gmx.de>
 <CAJZ5v0jAH9FZrO5AvVF90zgy-0EeM+rsB6Zf8cMf+sR8=FFuDA@mail.gmail.com>
 <168f173d-0d1a-49b0-9461-72f8fb0fc701@gmx.de> <99b0d755-3e18-4bba-b8e7-ab344e6c2592@gmx.de>
 <CAJZ5v0ijOF+nRZrjnub9uqa_Pu54etmudWUUNWmNgiogVAwxFQ@mail.gmail.com> <2ec8cf4c-62b2-4448-b4d6-563f519fd947@gmx.de>
In-Reply-To: <2ec8cf4c-62b2-4448-b4d6-563f519fd947@gmx.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 10 Dec 2025 02:56:27 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0h5jWx4vvxTXus80290zu7OjQY_FobLFHqYF205WadDOQ@mail.gmail.com>
X-Gm-Features: AQt7F2pOCjJu2JoGgngTZpYCDvO4wsUKi9Q1dLDEly8-PkeomzKbOct6nkRsgzI
Message-ID: <CAJZ5v0h5jWx4vvxTXus80290zu7OjQY_FobLFHqYF205WadDOQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] PCI: ACPI: PM: Rework root bus wakeup notification
 setup and wakeup source registration
To: Armin Wolf <W_Armin@gmx.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	Linux PM <linux-pm@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 10, 2025 at 1:29=E2=80=AFAM Armin Wolf <W_Armin@gmx.de> wrote:
>
> Am 09.12.25 um 23:18 schrieb Rafael J. Wysocki:
>
> > On Tue, Dec 9, 2025 at 11:00=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wro=
te:
> >> Am 09.12.25 um 14:56 schrieb Armin Wolf:
> >>
> >>> Am 09.12.25 um 12:31 schrieb Rafael J. Wysocki:
> >>>
> >>>> On Mon, Dec 8, 2025 at 9:01=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> w=
rote:
> >>>>> Am 08.12.25 um 13:09 schrieb Rafael J. Wysocki:
> >>>>>
> >>>>>> Hi All,
> >>>>>>
> >>>>>> Patch [1/2] updates the registration of PCI root bus wakeup
> >>>>>> notification setup
> >>>>>> in order to simplify code in pci_acpi_wake_bus() and to prepare fo=
r
> >>>>>> the other
> >>>>>> change.  This is not expected to affect functionality.
> >>>>>>
> >>>>>> Patch [2/2] modifies the ACPI PM notifier registration to add
> >>>>>> wakeup sources
> >>>>>> under devices that are going to be affected by wakeup handling
> >>>>>> instead of
> >>>>>> registering them under ACPI companions of those devices (rationale
> >>>>>> explained
> >>>>>> in the patch changelog).  This will change the sysfs layout (wakeu=
p
> >>>>>> source
> >>>>>> devices associated with PCI wakeup are now going to appear under
> >>>>>> PCI devices
> >>>>>> and the host bridge device), but it is not expected to affect user
> >>>>>> space
> >>>>>> adversely.
> >>>>>>
> >>>>>> Thanks!
> >>>>> I tested both patches, and the sysfs layout changes as expected:
> >>>>>
> >>>>> $ readlink /sys/class/wakeup/wakeup*/device
> >>>>> ../../../device:00
> >>>>> ../../../device:1a
> >>>>> ../../../device:1f
> >>>>> ../../../device:20
> >>>>> ../../../0000:00:08.1
> >>>>> ../../../device:36
> >>>>> ../../../device:31
> >>>>> ../../../device:32
> >>>>> ../../../device:3c
> >>>>> ../../../0000:01:00.0
> >>>>> ../../../device:3d
> >>>>> ../../../PNP0C02:00
> >>>>> ../../../0000:02:00.0
> >>>>> ../../../device:3e
> >>>>> ../../../device:3f
> >>>>> ../../../device:46
> >>>>> ../../../0000:04:00.0
> >>>>> ../../../device:47
> >>>>> ../../../0000:05:00.0
> >>>>> ../../../device:57
> >>>>> ../../../0000:05:08.0
> >>>>> ../../../device:59
> >>>>> ../../../device:01
> >>>>> ../../../0000:05:09.0
> >>>>> ../../../device:5b
> >>>>> ../../../0000:05:0a.0
> >>>>> ../../../device:5d
> >>>>> ../../../0000:05:0b.0
> >>>>> ../../../device:5f
> >>>>> ../../../0000:05:0c.0
> >>>>> ../../../device:74
> >>>>> ../../../0000:05:0d.0
> >>>>> ../../../device:5a
> >>>>> ../../../device:3a
> >>>>> ../../../device:5c
> >>>>> ../../../device:60
> >>>>> ../../../device:75
> >>>>> ../../../LNXVIDEO:00
> >>>>> ../../../device:22
> >>>>> ../../../PNP0C02:02
> >>>>> ../../../device:25
> >>>>> ../../../device:2b
> >>>>> ../../../device:24
> >>>>> ../../../device:37
> >>>>> ../../../0000:00:01.1
> >>>>> ../../../PNP0A08:00
> >>>>> ../../../LNXPWRBN:00
> >>>>> ../../../AMDI0010:00
> >>>>> ../../../AMDI0030:00
> >>>>> ../../../00:02
> >>>>> ../../../alarmtimer.0.auto
> >>>>> ../../../PNP0C0C:00
> >>>>> ../../../0000:0b:00.0
> >>>>> ../../../AMDIF031:00
> >>>>> ../../../PNP0C14:00
> >>>>> ../../../device:0a
> >>>>> ../../../PNP0C14:01
> >>>>> ../../../PNP0C14:02
> >>>>> ../../../PNP0C14:03
> >>>>> ../../../0000:0e:00.3
> >>>>> ../../../0000:0e:00.4
> >>>>> ../../../0000:0f:00.0
> >>>>> ../../../5-2
> >>>>> ../../../1-5.3
> >>>>> ../../hidpp_battery_0
> >>>>> ../../../device:44
> >>>>> ../../../0000:00:02.1
> >>>>> ../../../device:76
> >>>>> ../../../device:0b
> >>>>>
> >>>>> turns into:
> >>>>>
> >>>>> $ readlink /sys/class/wakeup/wakeup*/device
> >>>>> ../../../0000:00:00.0
> >>>>> ../../../0000:00:04.0
> >>>>> ../../../0000:00:08.0
> >>>>> ../../../0000:00:08.1
> >>>>> ../../../0000:00:08.1
> >>>>> ../../../0000:00:08.3
> >>>>> ../../../0000:00:14.0
> >>>>> ../../../0000:00:14.3
> >>>>> ../../../0000:01:00.0
> >>>>> ../../../0000:01:00.0
> >>>>> ../../../0000:02:00.0
> >>>>> ../../../0000:00:00.2
> >>>>> ../../../0000:02:00.0
> >>>>> ../../../0000:03:00.0
> >>>>> ../../../0000:03:00.1
> >>>>> ../../../0000:04:00.0
> >>>>> ../../../0000:04:00.0
> >>>>> ../../../0000:05:00.0
> >>>>> ../../../0000:05:00.0
> >>>>> ../../../0000:05:08.0
> >>>>> ../../../0000:05:08.0
> >>>>> ../../../0000:05:09.0
> >>>>> ../../../0000:00:01.0
> >>>>> ../../../0000:05:09.0
> >>>>> ../../../0000:05:0a.0
> >>>>> ../../../0000:05:0a.0
> >>>>> ../../../0000:05:0b.0
> >>>>> ../../../0000:05:0b.0
> >>>>> ../../../0000:05:0c.0
> >>>>> ../../../0000:05:0c.0
> >>>>> ../../../0000:05:0d.0
> >>>>> ../../../0000:05:0d.0
> >>>>> ../../../0000:08:00.0
> >>>>> ../../../0000:00:01.1
> >>>>> ../../../0000:09:00.0
> >>>>> ../../../0000:0b:00.0
> >>>>> ../../../0000:0c:00.0
> >>>>> ../../../0000:0e:00.0
> >>>>> ../../../0000:0e:00.1
> >>>>> ../../../0000:0e:00.2
> >>>>> ../../../0000:0e:00.3
> >>>>> ../../../0000:0e:00.4
> >>>>> ../../../0000:0e:00.6
> >>>>> ../../../0000:0f:00.0
> >>>>> ../../../0000:00:01.1
> >>>>> ../../../pci0000:00
> >>>>> ../../../LNXPWRBN:00
> >>>>> ../../../AMDI0010:00
> >>>>> ../../../AMDI0030:00
> >>>>> ../../../00:02
> >>>>> ../../../alarmtimer.0.auto
> >>>>> ../../../PNP0C0C:00
> >>>>> ../../../0000:0b:00.0
> >>>>> ../../../AMDIF031:00
> >>>>> ../../../PNP0C14:00
> >>>>> ../../../0000:00:02.0
> >>>>> ../../../PNP0C14:01
> >>>>> ../../../PNP0C14:02
> >>>>> ../../../PNP0C14:03
> >>>>> ../../../0000:0e:00.3
> >>>>> ../../../0000:0e:00.4
> >>>>> ../../../0000:0f:00.0
> >>>>> ../../../5-2
> >>>>> ../../../1-5.3
> >>>>> ../../hidpp_battery_0
> >>>>> ../../../0000:00:02.1
> >>>>> ../../../0000:00:02.1
> >>>>> ../../../0000:00:02.2
> >>>>> ../../../0000:00:03.0
> >>>>>
> >>>>> The remaining ACPI devices are likely caused by device drivers base=
d
> >>>>> upon struct acpi_driver.
> >>>>> I was unable to test the wakeup itself since suspend is currently
> >>>>> broken due to issues with
> >>>>> cpuidle,
> >>>> Have you reported those?  What cpuidle driver is involved?
> >>>>
> >>>> If you happen to be using the ACPI idle driver, there is a regressio=
n
> >>>> between 6.18-rc7 and final 6.18 due to a missing revert, but final
> >>>> 6.18 should be as expected.
> >>> If i remember correctly the official 6.18 kernel was not affected by
> >>> this, i used the the bleeding-edge
> >>> branch when building the test kernel.
> >>>
> >>> I will do some further debugging once i am back home.
> >>>
> >>> Thanks,
> >>> Armin Wolf
> >>>
> >> Well, it turned out that the cpuidle driver was not involved in this, =
i just got confused
> >> by a separate stacktrace caused by the hid-roccat driver (i already re=
ported that).
> >>
> >> This seems to be the real issue:
> >>
> >> [  514.910759] ACPI Error: Aborting method \M402 due to previous error=
 (AE_AML_LOOP_TIMEOUT) (20250807/psparse-529)
> >> [  514.910810] ACPI Error: Aborting method \_SB.PCI0.GPP0.M241 due to =
previous error (AE_AML_LOOP_TIMEOUT) (20250807/psparse-529)
> >> [  514.910890] ACPI Error: Aborting method \_SB.PCI0.GPP0.M237._OFF du=
e to previous error (AE_AML_LOOP_TIMEOUT) (20250807/psparse-529)
> > It looks like there is a problem with turning a power resource off.
> >
> >> Sleeping itself works, it just takes a long time for the machine to ac=
tually suspend due to the timeout.
> >> I attached the acpidump of the affected machine in case you are intere=
sted.
> >>
> >> Since 6.18 is not affected by this i will wait till 6.19-rc1 is releas=
ed before i start debugging this issue.
> >> Do you think that this approach is OK?
> > It should be fine although you may as well check my pm-6.19-rc1,
> > acpi-6.19-rc1 and thermal-6.19-rc1 tags on top of 6.18.  If the
> > problem is in one of them, it should be possible to find it quicker
> > than by dealing with the entire 6.19-rc1.
>
> I tested all three tags atop of 6.18, and all can suspend just fine. I wi=
ll thus wait for 6.19-rc1
> before doing any further debugging.

Sounds reasonable to me.

