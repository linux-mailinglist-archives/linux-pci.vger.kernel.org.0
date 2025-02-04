Return-Path: <linux-pci+bounces-20715-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33123A27CF2
	for <lists+linux-pci@lfdr.de>; Tue,  4 Feb 2025 21:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9B53188569C
	for <lists+linux-pci@lfdr.de>; Tue,  4 Feb 2025 20:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2269D219E8D;
	Tue,  4 Feb 2025 20:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="esxRRf7J"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vs1-f65.google.com (mail-vs1-f65.google.com [209.85.217.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A9919E83E;
	Tue,  4 Feb 2025 20:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738702535; cv=none; b=Q464FgrP2iZOjZfuTk7O2j01GWRr3j3+l1BVKrOjGUFNFoFGfC++x/PKTHxYYMgQbcGNpdcCJKHtqkDkB31h2ejPE9XcIKrG5yRxKedEB9Fi1EPVWcFwOnLGv1rLMC+coGEyoZ2L7b3RH9VuRYnZjESGc7HnQy4FWcTx0VOc1Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738702535; c=relaxed/simple;
	bh=9uPL0qxNb9CrM3Y4XQ9gIIAhvN/HcmU5umHnEBZR01o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kCuFwBm2GgwpW7YiDCcJJRGfshM+9QH4AeE+WkPVN5l5S07fcOPKiMJkS8F3DfhBl64kzkcs9A5ZoG1056CgPdRkX244T0r5U73sQG6Aw9rwOm38fPOuB7Tr8udAzuFYbeTrpG3BjpvT1Clce2Mmz9nwv8j2XlM8Rxp06S59U+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=esxRRf7J; arc=none smtp.client-ip=209.85.217.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f65.google.com with SMTP id ada2fe7eead31-4b68cb2abacso1478118137.3;
        Tue, 04 Feb 2025 12:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738702532; x=1739307332; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zTCETWuenCPfTsTS6IKmsAT2A+DQq6leOPyP3G0VVZk=;
        b=esxRRf7J4BMiJJQSVXHFro3IkGQMJHDeXS7EEH10vTN/tLLkKuFhBtpJz9wp1NJ+my
         6lbxbQAre7xdJlIB4+3mSRBIQ9yc/lARFWYGSqAknDfr733tE1vF9ABUUUIQoDegUcr9
         0mS8x9Aw8BSQKDe9AvaH3lKOYZOd3RzyDv3sfKHY+ehfpML/NHEZ4Sg6pp7BbneVEAU5
         5QyeUqSxLMFhGSfyfrvJgHe7RPqC6E5wa1pnPbOxeBm2ytkpTMRrZto7qU6lWKuZ2Ehm
         nu6m98UG4eC/3fRerzEiUVEOFJwQjWt9ZHUr2KA9HXGJ/RiYnq+8JETkyJsuuDyqbO4C
         tHLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738702532; x=1739307332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zTCETWuenCPfTsTS6IKmsAT2A+DQq6leOPyP3G0VVZk=;
        b=FmenMAeZog4o/0SIVMQ7sijDA/OQujcmexWmvzPToCxzWSoW4H7ZUrkPrQWx+GMCkj
         ry7AEa72ltu4Fs2LGMzkKAEvluO/FGg+NfZjGgcBW9R+kLwAqAR6XPqMus7GDP8POl9i
         SiiOIiElOzKbaG1iUdzW2ZYMFgJmdagXR5XoZCSWAs+hjhH2SqnB7smPPqzpCjEJWAXA
         fPOpo1EYIoxnQB+zNG3mul4Ja9vuawnYExDx0lhc/Trt/Bgv1MuoTSrV8h1eisuAgH34
         qYoKVvhCrnHa5hRNt5DYwBaw4AtfQ/wCZerLKcKTjNxhotE7luZxGcp8CbBADEHpPPH/
         8I/Q==
X-Forwarded-Encrypted: i=1; AJvYcCV2q22cTcbe+s3AdeUmyYzBTJPVH60qUe3pc1kRhS6ks+xxfmxjtWMUF9csZdeLOr8DhSgNNO4Dvs/W@vger.kernel.org, AJvYcCVk5wS0rUmi4T7JX3pehrUQ/4l1P92WVRnqMoBqZSLNFFZ7EQWVrTYFsV++wObdMBxjgShHKWm4ikQiGfA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh5a8WI8I+I8gyrRGz1f4sDuNnF9pBoMjKxeIrfHyodet0qKcJ
	QZjc6SuBAth7DxTiDP5za6vuCDip2qv3lrbzKaLhLE1KxXUwPEgSzshfDg7JRrjm6DKfHQgHkh1
	7DnYiqFOEbDcfdgznyuTpmBa/X6E=
X-Gm-Gg: ASbGncsru5DVFg5OHkSMajUVwB0gVoDu0LwYAD/bDtuNdXdr6P6kv27PYRVQlZ5k52g
	+BA67oXFifVbRv2ISkgSTOguf764+Yqr07R19MHaEC018AFS978b53agv7laGr99KyhsZGy0=
X-Google-Smtp-Source: AGHT+IFgNdA2eMSvbE5qs1+/LLxIm+NRf+3nrEGDFA2JN3tHC3zxmSYUAxMusx/gOyeh5B3hGD4knGM6DM7/KO4MXrk=
X-Received: by 2002:a05:6102:cd3:b0:4b2:5c4b:b0aa with SMTP id
 ada2fe7eead31-4ba47a69fd7mr520366137.17.1738702530635; Tue, 04 Feb 2025
 12:55:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250131152913.2507-1-ilpo.jarvinen@linux.intel.com> <20250204203936.GA860339@bhelgaas>
In-Reply-To: <20250204203936.GA860339@bhelgaas>
From: =?UTF-8?B?TmlrbMSBdnMgS2/EvGVzxYZpa292cw==?= <pinkflames.linux@gmail.com>
Date: Tue, 4 Feb 2025 22:55:14 +0200
X-Gm-Features: AWEUYZkRWaVV7RRfgdR9N6JqE99A0X3DQIEjRllWzNWGGLvnwBRDnCcvSOUyRJQ
Message-ID: <CAG+bWs0519=xxxsSSFTpqMyaApM_W4STwfXoaONAuv31akTJ-w@mail.gmail.com>
Subject: Re: [PATCH 1/1] PCI/ASPM: Fix L1SS saving
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jian-Hong Pan <jhp@endlessos.org>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I'm the person who first reported this issue. The most obvious reason
to a layman such as myself would be the simple fact that desktop
platforms by default do not enable L1SS in their EFI/BIOS
configurations.
Meaning only weirdoes such as myself who tinker with EFI and kernel
settings [while looking at a power meter readings] would ever
encounter this on a desktop system.

I don't know about portable devices but perhaps they rely on their
embedded controllers instead of exposing L1SS to the OS, too? Just
guessing.

That being said, it's possible my layman intuition is very wrong. If
so, sorry about the noise.

Cheers,
Nikl=C4=81vs Ko=C4=BCes=C5=86ikovs

P.S. Sorry, if reply to all was the wrong GMail button to press.

otrd., 2025. g. 4. febr., plkst. 22:39 =E2=80=94 lietot=C4=81js Bjorn Helga=
as
(<helgaas@kernel.org>) rakst=C4=ABja:
>
> [+cc Rafael]
>
> On Fri, Jan 31, 2025 at 05:29:13PM +0200, Ilpo J=C3=A4rvinen wrote:
> > The commit 1db806ec06b7 ("PCI/ASPM: Save parent L1SS config in
> > pci_save_aspm_l1ss_state()") aimed to perform L1SS config save for both
> > the Upstream Port and its upstream bridge when handling an Upstream
> > Port, which matches what the L1SS restore side does. However,
> > parent->state_saved can be set true at an earlier time when the
> > upstream bridge saved other parts of its state.
>
> So I guess the scenario is that we got here because some driver called
> pci_save_state(pdev):
>
>   pci_save_state
>     dev->state_saved =3D true                <--
>     pci_save_pcie_state
>       pci_save_aspm_l1ss_state
>         if (pcie_downstream_port(pdev))
>           return
>         # save pdev L1SS state here
>         if (parent->state_saved)           <--
>           return
>         # save parent L1SS state here
>
> and the problem is that we previously called pci_save_state(parent),
> which set "parent->state_saved =3D true" but did not save its L1SS state
> because pci_save_aspm_l1ss_state() is a no-op for Downstream Ports,
> right?
>
> But I would think this would be a very common situation because
> pcie_portdrv_probe() calls pci_save_state() for Downstream Ports when
> pciehp, AER, PME, etc, are enabled, and this would happen before the
> pci_save_state() calls from Endpoint drivers.
>
> So I'm a little surprised that this didn't blow up for everybody
> immediately.  Is there something that makes this unusual?
>
> > Then later when
> > attempting to save the L1SS config while handling the Upstream Port,
> > parent->state_saved is true in pci_save_aspm_l1ss_state() resulting in
> > early return and skipping saving bridge's L1SS config because it is
> > assumed to be already saved. Later on restore, junk is written into
> > L1SS config which causes issues with some devices.
> >
> > Remove parent->state_saved check and unconditionally save L1SS config
> > also for the upstream bridge from an Upstream Port which ought to be
> > harmless from correctness point of view. With the Upstream Port check
> > now present, saving the L1SS config more than once for the bridge is no
> > longer a problem (unlike when the parent->state_saved check got
> > introduced into the fix during its development).
> >
> > Fixes: 1db806ec06b7 ("PCI/ASPM: Save parent L1SS config in pci_save_asp=
m_l1ss_state()")
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D219731
> > Reported-by: Nikl=C4=81vs Ko=C4=BCes=C5=86ikovs <pinkflames.linux@gmail=
.com>
> > Tested-by: Nikl=C4=81vs Ko=C4=BCes=C5=86ikovs <pinkflames.linux@gmail.c=
om>
> > Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> >  drivers/pci/pcie/aspm.c | 3 ---
> >  1 file changed, 3 deletions(-)
> >
> > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > index e0bc90597dca..da3e7edcf49d 100644
> > --- a/drivers/pci/pcie/aspm.c
> > +++ b/drivers/pci/pcie/aspm.c
> > @@ -108,9 +108,6 @@ void pci_save_aspm_l1ss_state(struct pci_dev *pdev)
> >       pci_read_config_dword(pdev, pdev->l1ss + PCI_L1SS_CTL2, cap++);
> >       pci_read_config_dword(pdev, pdev->l1ss + PCI_L1SS_CTL1, cap++);
> >
> > -     if (parent->state_saved)
> > -             return;
> > -
> >       /*
> >        * Save parent's L1 substate configuration so we have it for
> >        * pci_restore_aspm_l1ss_state(pdev) to restore.
> >
> > base-commit: 72deda0abee6e705ae71a93f69f55e33be5bca5c
> > --
> > 2.39.5
> >

