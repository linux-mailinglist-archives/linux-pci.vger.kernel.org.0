Return-Path: <linux-pci+bounces-26520-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF6CA98648
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 11:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 264B87A9507
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 09:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A27521FF57;
	Wed, 23 Apr 2025 09:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZybQc4i"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6E44A07;
	Wed, 23 Apr 2025 09:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745401544; cv=none; b=YKnFFu5uVTP/4NRRHjJcIUklvgTadXOKg/aXb0gkWQnm5ZVn14AZZpBsLvXsKF02kCmTGWvvjHglbucP5onWO7iC7TjA/uLLGirrwTj8Z90a36hcrz/Kej2bAiw2E1q3LgcklTTGpwy2MxHs9UFUZyIrDeRzPLATVRxh6nat/oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745401544; c=relaxed/simple;
	bh=pOMZ6beydJOtBsh8FcwPVCQJjavX5ZDmbl+rpOmjuZc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OBWii2nuAi5xXTRuSAYQKFGnXBFJmkxtlo+QLJ1SqJg86zUYUUWNa+4y8djWp6379OOYbcTptmUUsmz1O2vV752Q0vK003nerBDFAQ6rWUPQurB2uFuP7m6ynvzlOYbWYH2vMtboO5RiFndWuIDbhPLU5FCqVG7XIsjKN77U2C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lZybQc4i; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-73712952e1cso6055731b3a.1;
        Wed, 23 Apr 2025 02:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745401542; x=1746006342; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0qHr2D1fgR89Z1Y/9FM5Jnum6ts7ImU2zNv46BN7lDc=;
        b=lZybQc4igcJyyP+XN6HvHOTAGXsokl0PFpDvM66oqierXqoI7tPnZ04bg5zg/SmOEM
         5cu1NYwhEKUutSUPpurdsPx2ekQjYI0ibWUuTr0FxjCFYnf439Gf49jZJgNR7pMWfsYi
         ZFtcV+InMPRUPD3a+a6fe6ytJDC8LsaSnct8qjNEfId2G18Sm5oO3ENMz8U4jPHrVE0l
         JteijC2D+60uFBxZnlXkoD/ujimmLawPD2cqCRfdoMd8unE2nu014S+OinluPL+CaqH7
         C2CmwUVnEvE16hu0OL8aCakcJ1WtdKUGUJh8/ZMMVnmlBGTrvPz1s+lV5mOkldrZqBeB
         r+rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745401542; x=1746006342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0qHr2D1fgR89Z1Y/9FM5Jnum6ts7ImU2zNv46BN7lDc=;
        b=q/gMjQSDChrRbqWoZ4FoEZQ42l+tRTpSCwTJ7cLE4l5VcInm8jUmfOh4PJys34wx+V
         pTzamJ5ddbWGlI7IZGYRnEMwQl3U5dWxIoyWjbrDeH+LKFhxlh7NixaphLway29jHqgh
         iHq6Xb8I+96B7MvGjL12G/epgScon1K5S1Z/moHmiNQMijdh7WJtg122D30bV9ncEeBi
         6K/UGMYJQjD5IjsUi7ufPM0YJ+1n9CTwR9VRJOeG6FFyk18fuVgiejr1l9J7bvxzZn9Q
         T8ucx3s876lw7EXda2EmUB3JPaeoPSNoxP3s0/F59/iJLVxJ7NvubvOkyhoK3cHQtOCQ
         X0rg==
X-Forwarded-Encrypted: i=1; AJvYcCUOaaCWMZwoUhJUM7XetCK+J/ocIgAZLzqhDQmTW/OBCeunRRITH0nKfAHTPdic/UH25I4ffjqMmBuZ@vger.kernel.org, AJvYcCUPeYIWFzp9kIQ6BVu8gtuNt8wPlWlxI7V9vUvf/IjBwkgv11ZQvQAfp4dEylPfbgCYQScOhW0grSjZ@vger.kernel.org
X-Gm-Message-State: AOJu0YyD+mCJaRx9M3no2/Fr1sukxccSpkfmJ1leAH45WLZKdpeTiLwe
	vjfuhXB43MU5ZsrA0GPPk+6LrUwD4FyN1aZ16sWxsFZ+IpmgX6KQOzUM2eeVV01CLSeXBJAU+1W
	2e8fsGeoqJacloowbQ70YGiuh33pOWGiq
X-Gm-Gg: ASbGnctm7iJn32jvtNKzc8lTCC+OH3aJH2uVadE47vkv/6ognfcgh7s+UkDv79g0RqD
	LPp3MU4+c1WLkSE5kcICu6tDGJ2IzQ4Mw4/6QvSlf+E20Xxi0Rs1GgMke7fggJQdkLVNIi/2L8n
	z5wnrmTU+MPsqK/LTcd84Z+Luy+kkbxEs9
X-Google-Smtp-Source: AGHT+IFpfmY1Az5GXq1xf6oxbNqEpWliYJhKg90q4Ws7KHV0dFSu7BVMP151kVxmfYZjNsMAQMH3W+cgaA7o2qQxImk=
X-Received: by 2002:a17:90b:524c:b0:2ff:796b:4d05 with SMTP id
 98e67ed59e1d1-3087bb53f37mr29395661a91.11.1745401541655; Wed, 23 Apr 2025
 02:45:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <62de9027-e4cd-4192-90e8-64f4c4a8fe4b@gmail.com>
 <aAc26NTVcXy1BCxU@wunner.de> <CAJZ5v0iWTd_ndpAr=q8QJC2MWSheq0UXVR6a1oyGSH063yzpFw@mail.gmail.com>
 <CAFSsGVudMV+=0M7m_LC0xuJF=spTwk-691_W=wmnuuNFxCK1AA@mail.gmail.com>
In-Reply-To: <CAFSsGVudMV+=0M7m_LC0xuJF=spTwk-691_W=wmnuuNFxCK1AA@mail.gmail.com>
From: Heiner Kallweit <hkallweit1@gmail.com>
Date: Wed, 23 Apr 2025 11:45:30 +0200
X-Gm-Features: ATxdqUFAoSELAmZhVTsUGnbgnaB12e5dtTo4kznxUVQsy0T62EMAeQdT1wsiAZ8
Message-ID: <CAFSsGVs2zGL9Ov6ixDE6doSCr6oQ=hWpg-N=3bJUMSgRQSSh+A@mail.gmail.com>
Subject: Re: Potential issue with pci_prepare_to_sleep if there's no platform
 support for D3cold transition
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <bhelgaas@google.com>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 23, 2025 at 11:32=E2=80=AFAM Heiner Kallweit <hkallweit1@gmail.=
com> wrote:
>
> On Tue, Apr 22, 2025 at 1:43=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.=
org> wrote:
> >
> > On Tue, Apr 22, 2025 at 8:28=E2=80=AFAM Lukas Wunner <lukas@wunner.de> =
wrote:
> > >
> > > [cc +=3D Rafael, linux-acpi]
> > >
> > > On Mon, Apr 21, 2025 at 10:05:59PM +0200, Heiner Kallweit wrote:
> > > > If there's no platform support for transition to D3cold, then
> > > > pci_set_power_state(dev, D3cold) still returns 0, even though
> > > > power state is transitioned to D3hot only. We called
> > > > pci_enable_wake(dev, D3cold, wakeup) before, therefore PME for
> > > > D3hot may not be enabled. Is this a bug?
> >
> > On platforms using ACPI, no it isn't.
> >
> > Internally, pci_enable_wake() evaluates _DSW and it doesn't
> > distinguish between D3hot and D3cold as per the spec.
> >
> > > > Background:
> > > > In __pci_set_power_state we have the following:
> > > >
> > > > error =3D pci_set_low_power_state(dev, PCI_D3hot, locked);
> > > > if (pci_platform_power_transition(dev, PCI_D3cold))
> > > >       return error;
> > > >
> > > > The acpi_pci_set_power_state() stub returns -ENODEV.
> > > > Therefore, if error=3D0,  __pci_set_power_state() will
> > > > return 0 if pci_platform_power_transition() fails.
> > >
> > > pci_prepare_to_sleep() calls pci_target_state() right at the top.
> > >
> > > If wakeup is supported and enabled, pci_target_state() is supposed
> > > to find the deepest power state supporting wakeup.  If D3cold doesn't
> > > support wakeup, D3hot or a shallower state is returned.
> > >
> > > Hence I don't quite understand how the scenario you're describing
> > > could occur in practice.  Are you seeing actual issues and have track=
ed
> > > them down to incorrect handling in pci_prepare_to_sleep()?
>
> On non-ACPI systems pci_target_state() just looks at the device
> capabilities. The described scenario can happen if device supports
> wake from D3cold, but platform has no means to switch a device to
> D3cold. I'm thinking of e.g. RTL8125 on ARM. Typically I don't expect
> an issue because boot-up default on these devices is to have PME wake
> from all states enabled. So it's more of a theoretical exercise at the
> moment.

I just see that pci_target_state() won't return D3cold for non-ACPI systems=
.
Therefore sorry for the noise.

