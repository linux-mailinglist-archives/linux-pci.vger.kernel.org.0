Return-Path: <linux-pci+bounces-15302-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F9A9B0335
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 14:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD9671F2195E
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 12:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DF22064F8;
	Fri, 25 Oct 2024 12:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVYBa9Ez"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2852064F5;
	Fri, 25 Oct 2024 12:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729860950; cv=none; b=atEIRmizldK/6kHsrh13cLJvsXK5ewDMb41Q0hYZ1Ps4P5c4nbVg1fuIs6fxXhDmxwjJeSyB9Zhz4OPJNIhHnql+YmPBygAVUpdKGjCWyTDUFk670YZRAsrvEZYNsbkqPALc9EiBWOTT7GZhTweAKD0S1wKXSXnPYjKL1g+lSzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729860950; c=relaxed/simple;
	bh=VuURla6Mec8xyC4nB0W2kKTylYH+N2vYdKLc8DUUPWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZNilQ9CSJjb5fEMBQWIi8Lz3j90yjHojIfK+tY1AonTM08ysIPfYnG4SDQDdz2odPRxOh3Tkvs16O6lyVsP4a826JH0JSP0YE5LS3fMFiu/xDbs7PNZxgD/8lFmOvKiQLJliGsfROIwAXIGT4NodhgFNUbAoPdbchg0BU+o+H/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MVYBa9Ez; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7ea6f99e6eeso114146a12.1;
        Fri, 25 Oct 2024 05:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729860948; x=1730465748; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2mpopKe0kCq4c6SWTmzVvbk0KW/W7H/olvg6DZS09/0=;
        b=MVYBa9EzJln2pyzE86t3FnzV6Y95DZVhf8eNVWoetMJuBKgWQ9QAzWZPt5H+CsdYWh
         Sn+G+HycJP286csIFTV6tYqYe276zn1TECCls7+JedRvU5nGKMwplNBCvqU496xBdt2K
         PyTvgEzOxlOFLxIoHGyNKW7SQ280syP5DPlJirGUgtl+NXIj2X6N+0TYquZZ6GxTpUfr
         UXcEj39vnhaYfKFHKa3QiewGe1klGvfeTsmnZRq1Ms7s/pilpU3n1s8OtmwEpNMl2072
         Z6tGe9PAFJWAAsthOBzN8mzmX/FJOrTfp/xdIWx6XmwAaPaX+cELQSbvdNkb4if9mURV
         cL8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729860948; x=1730465748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2mpopKe0kCq4c6SWTmzVvbk0KW/W7H/olvg6DZS09/0=;
        b=mlI3tLCyn9esyk+K0S6OBVX58AnZpp6ZH1BKzZjNUvVnNphbgCEWANcAtp4UEVnBHN
         v5UKHpSOIfltD/HuW8wQc4ruz1nGSey7OXPglg7Yi0wJ+IqizLNrPQ3e7IjKh/cfTwXw
         6E76whVLOQQzaENCw6/oKRP60je1B8kxxFm/K99qH9BVXAtyiAVT2ZVbLEsR8ChryMpt
         0S7X/JNNImL9uWXqa04k+6STNrgyh6VEypfjyrJOBGZCT2/7JTLOMzX1f+vhg/7ehQQH
         C9LyVfWgP+qVuZR6ECsPt3vAZw1WJXovpcy2JbDojJQqDzYEqwylvjcRK6Rm8hyI/yH4
         P1lw==
X-Forwarded-Encrypted: i=1; AJvYcCWJTyeTyshcEHaoGnsTAs5REv43VBlQ5WvwKHoamQEVJNJmFWlOVs7yFQDYVviE9Abar87sFdMiH2fr5kA=@vger.kernel.org, AJvYcCWM+OKY6iyAf2kdbyUcDMHni7WU6zFG4e6bocGKIVAvNsLpmVxbo2nYQS5zmJmy1QFmyY/Pdnjn0aan@vger.kernel.org
X-Gm-Message-State: AOJu0YwpX0gpkmkPmTZZND+kx53om93eQxBNWMmfM5pEAyF8mn8OAM+D
	kJ3oMsHAPJJvwOOGhq++UMMzVnXDGTtDfR4dTo2bBaEsZwuJpMi29yGhM+bxHuHqOgONpFkhEk9
	JerevUancJqnc3Jnc4T6JJZQcipE=
X-Google-Smtp-Source: AGHT+IFAPOJ193XCnyihRQUSik9FlYyJIZv/7VMnRuPjMeme+UnT3saFzOAbbpalhJ2K+qWHAxiutraJ9lBbhuwKmPw=
X-Received: by 2002:a05:6a20:6a1d:b0:1d9:6ec9:30f2 with SMTP id
 adf61e73a8af0-1d99e1a0235mr995000637.6.1729860947867; Fri, 25 Oct 2024
 05:55:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014152502.1477809-1-superm1@kernel.org> <20b48c6f-7ea9-4571-a39c-f20a9cf62319@app.fastmail.com>
 <f56c555f-7313-43ff-abe4-28fb246e31cc@nvidia.com> <CADnq5_OjfJzcOqa=NbWVw5ENvi+nmvNAZX0u_0hOvk3EVoh0bw@mail.gmail.com>
 <fd7cae9a-5ee1-4e18-915d-4115f0a6a156@nvidia.com> <CADnq5_NTBXPbW+u_AxTewH-aouLNn4gxebpzUSzsyev-VxOtcg@mail.gmail.com>
 <46b487ec-e8a6-43fb-85d5-f264618f2e5d@nvidia.com>
In-Reply-To: <46b487ec-e8a6-43fb-85d5-f264618f2e5d@nvidia.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 25 Oct 2024 08:55:36 -0400
Message-ID: <CADnq5_Mh7B8Kk144terpvV9kf2Z4xcQ0nhVakHOcDdwgd3Y1Fg@mail.gmail.com>
Subject: Re: [PATCH] PCI/VGA: Don't assume only VGA device found is the boot
 VGA device
To: Kai-Heng Feng <kaihengf@nvidia.com>
Cc: Luke Jones <luke@ljones.dev>, Mario Limonciello <superm1@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, 
	Mario Limonciello <mario.limonciello@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 3:51=E2=80=AFAM Kai-Heng Feng <kaihengf@nvidia.com>=
 wrote:
>
>
>
> On 2024/10/23 11:27 PM, Alex Deucher wrote:
> > External email: Use caution opening links or attachments
> >
> >
> > On Tue, Oct 22, 2024 at 9:27=E2=80=AFPM Kai-Heng Feng <kaihengf@nvidia.=
com> wrote:
> >>
> >>
> >>
> >> On 2024/10/22 9:04 PM, Alex Deucher wrote:
> >>> External email: Use caution opening links or attachments
> >>>
> >>>
> >>> On Tue, Oct 22, 2024 at 2:31=E2=80=AFAM Kai-Heng Feng <kaihengf@nvidi=
a.com> wrote:
> >>>>
> >>>> Hi Luke,
> >>>>
> >>>> On 2024/10/15 4:04 PM, Luke Jones wrote:
> >>>>> On Mon, 14 Oct 2024, at 5:25 PM, Mario Limonciello wrote:
> >>>>>> From: Mario Limonciello <mario.limonciello@amd.com>
> >>>>>>
> >>>>>> The ASUS GA605W has a NVIDIA PCI VGA device and an AMD PCI display=
 device.
> >>>>>>
> >>>>>> ```
> >>>>>> 65:00.0 VGA compatible controller: NVIDIA Corporation AD106M [GeFo=
rce
> >>>>>> RTX 4070 Max-Q / Mobile] (rev a1)
> >>>>>> 66:00.0 Display controller: Advanced Micro Devices, Inc. [AMD/ATI]
> >>>>>> Strix [Radeon 880M / 890M] (rev c1)
> >>>>>> ```
> >>>>>>
> >>>>>> The fallback logic in vga_is_boot_device() flags the NVIDIA dGPU a=
s the
> >>>>>> boot VGA device, but really the eDP is connected to the AMD PCI di=
splay
> >>>>>> device.
> >>>>>>
> >>>>>> Drop this case to avoid marking the NVIDIA dGPU as the boot VGA de=
vice.
> >>>>>>
> >>>>>> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> >>>>>> Reported-by: Luke D. Jones <luke@ljones.dev>
> >>>>>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3673
> >>>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >>>>>> ---
> >>>>>>     drivers/pci/vgaarb.c | 7 -------
> >>>>>>     1 file changed, 7 deletions(-)
> >>>>>>
> >>>>>> diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
> >>>>>> index 78748e8d2dba..05ac2b672d4b 100644
> >>>>>> --- a/drivers/pci/vgaarb.c
> >>>>>> +++ b/drivers/pci/vgaarb.c
> >>>>>> @@ -675,13 +675,6 @@ static bool vga_is_boot_device(struct vga_dev=
ice *vgadev)
> >>>>>>                return true;
> >>>>>>        }
> >>>>>>
> >>>>>> -    /*
> >>>>>> -     * Vgadev has neither IO nor MEM enabled.  If we haven't foun=
d any
> >>>>>> -     * other VGA devices, it is the best candidate so far.
> >>>>>> -     */
> >>>>>> -    if (!boot_vga)
> >>>>>> -            return true;
> >>>>>> -
> >>>>>>        return false;
> >>>>>>     }
> >>>>>>
> >>>>>> --
> >>>>>> 2.43.0
> >>>>>
> >>>>> Hi Mario,
> >>>>>
> >>>>> I can verify that this does leave the `boot_vga` attribute set as 0=
 for the NVIDIA device.
> >>>>
> >>>> Does the following diff work for you?
> >>>> This variant should be less risky for most systems.
> >>>>
> >>>> diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
> >>>> index 78748e8d2dba..3fb734cb9c1b 100644
> >>>> --- a/drivers/pci/vgaarb.c
> >>>> +++ b/drivers/pci/vgaarb.c
> >>>> @@ -675,6 +675,9 @@ static bool vga_is_boot_device(struct vga_device=
 *vgadev)
> >>>>                    return true;
> >>>>            }
> >>>>
> >>>> +       if (vga_arb_integrated_gpu(&pdev->dev))
> >>>> +               return true;
> >>>> +
> >>>
> >>> The problem is that the integrated graphics does not support VGA.
> >>
> >> Right, so the check has to be used much earlier.
> >>
> >> I wonder does the integrated GFX have _DOD/_DOS while the discrete one=
 doesn't?
> >> If that's the case, vga_arb_integrated_gpu() can be used to differenti=
ate which
> >> one is the boot GFX.
> >
> > I think the problem is that the boot GPU is being conflated with vga
> > arb.  In this case the iGPU has no VGA so has no reason to be involved
> > in vga arb.  Trying to mess with any vga related resources on it could
> > be problematic.  Do higher levels of the stack look at vga arb to
> > determine the "primary" GPU?
>
> Hmm, I wonder if all those heuristic are needed for EFI based system?
>
> Can we assume that what being used by UEFI GOP is the primary GFX device?

Yes, I believe so.  The SBIOS should use the GOP device as determined
by the user preference.  I.e.., in the bios configuration you can
generally select iGPU or PEG for the primary display.

Alex

>
> Kai-Heng
>
> >
> > Alex
> >
> >>
> >> Kai-Heng
> >>
> >>>
> >>> Alex
> >>>
> >>>>            /*
> >>>>             * Vgadev has neither IO nor MEM enabled.  If we haven't =
found any
> >>>>             * other VGA devices, it is the best candidate so far.
> >>>>
> >>>>
> >>>> Kai-Heng
> >>>>
> >>>>>
> >>>>> Tested-by: Luke D. Jones <luke@ljones.dev>
> >>>>
> >>
>

