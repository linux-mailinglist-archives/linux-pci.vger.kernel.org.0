Return-Path: <linux-pci+bounces-1694-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D63824D58
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jan 2024 04:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A07F428588B
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jan 2024 03:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2611B2100;
	Fri,  5 Jan 2024 03:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="KCYrAru0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD5A538D
	for <linux-pci@vger.kernel.org>; Fri,  5 Jan 2024 03:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0B6463F2D2
	for <linux-pci@vger.kernel.org>; Fri,  5 Jan 2024 03:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1704424507;
	bh=f1cXDgk0HWr0gWI2ojjEmuBHHD309E5GX6oCK9+DTMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=KCYrAru06jlw9WmIpPyvqCBpoxB8Z26SJ3QYCRaECwITLsgyur6i+Eo2lSR6hyTN2
	 P/guCqqBF3MiUTMTsZvsf7R8dU7cPVNIDHcADAvJSgFLwKT9Zs6qojWCAIfcqHdqn8
	 PKRIzJxh7YWqVqBZujkJj0YEuQuqpzJC4365SGQ4qrWrgWhwmGIzxYPqyOXLjJpqWc
	 T6Ps+7d5Jkj+SQbAuQ2++hllPrpRBRU20NAmEEChXzggTqKNVtJPRJXOhWqhBQ3NnB
	 2t7qVe0qCrgkFASisD20TEgb7r0tyflwqwuuGWnKo2X3GrxrO2pjAiHWdL08g4q6kH
	 Fc5HQ6CgWq+qA==
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3bbde8f73bfso1235935b6e.0
        for <linux-pci@vger.kernel.org>; Thu, 04 Jan 2024 19:15:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704424506; x=1705029306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f1cXDgk0HWr0gWI2ojjEmuBHHD309E5GX6oCK9+DTMg=;
        b=xHEDUPSmTAIGZFjlJ1YItx9AMtrUNEs+Nu/vJp85II/4uLJJoSzGH4ixVoO2F35+1G
         VUDpWxhStCVgg2OxVctGCZBK0rUwHfndiawd+DLtcPL3+dUkiKuxOWjZxSLqBPciMMNN
         nNyFgPuB5PJMu0WWGODP0++9oeqrz3hONOR3UDDTLsJHxPMntUmjqn+9nRbMEihfOf7A
         +n1vwv+4wpVuX8jP/0S6RGRMhbCgRl+4PK8swEf3+OTKMF83pBcXb3E0Hpj02q8FtCRP
         FUfCedJeTOED9e2WFx+lYdrDw97AmMHIxbxO6SDv2fKRSAaqp8V6sLOTzw6HnkJZsbOY
         dpfQ==
X-Gm-Message-State: AOJu0YyniqMblhDugTCnKf6uasQCTeTB44cMUIMudvF+pi4R12getPow
	1yHYqqXpANVK2fyxTTvYmBDudsjTFPHptQhr8AEWuZlDTd7BXgZvUp5t8yAXS+zDr3cemUnyHlf
	Uu0MU56SA2H5mh6cFFYQrFCbJtImTUcmaWIG5OLYy5Gxco5pXfQwpAMsphXCE
X-Received: by 2002:a54:4593:0:b0:3bb:bf36:35ae with SMTP id z19-20020a544593000000b003bbbf3635aemr1232129oib.43.1704424506003;
        Thu, 04 Jan 2024 19:15:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6R5pS1SiK4WJpm25fFZB080mcNKHpAOKGHSuso4SnrhnsRQkDzJtxnD8fORCidjGzLNdUrz05NeUvqsx3Vlg=
X-Received: by 2002:a54:4593:0:b0:3bb:bf36:35ae with SMTP id
 z19-20020a544593000000b003bbbf3635aemr1232123oib.43.1704424505720; Thu, 04
 Jan 2024 19:15:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240101181348.GA1684058@bhelgaas> <d7e7b133-d373-e850-1f5f-deee8aa86958@linux.intel.com>
In-Reply-To: <d7e7b133-d373-e850-1f5f-deee8aa86958@linux.intel.com>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Fri, 5 Jan 2024 11:14:53 +0800
Message-ID: <CAAd53p7yASMMcRTUR6ybJzj8KUP_+7h4nvE7wQ7cm0eQR6nEBQ@mail.gmail.com>
Subject: Re: [Regression] [PCI/ASPM] [ASUS PN51] Reboot on resume attempt
 (bisect done; commit found)
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Michael Schaller <michael@5challer.de>, bhelgaas@google.com, 
	linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	regressions@lists.linux.dev, macro@orcam.me.uk, ajayagarwal@google.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, hkallweit1@gmail.com, 
	michael.a.bottini@linux.intel.com, johan+linaro@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 3, 2024 at 11:41=E2=80=AFPM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Mon, 1 Jan 2024, Bjorn Helgaas wrote:
>
> > On Mon, Dec 25, 2023 at 07:29:02PM +0100, Michael Schaller wrote:
> > > Issue:
> > > On resume from suspend to RAM there is no output for about 12 seconds=
, then
> > > shortly a blinking cursor is visible in the upper left corner on an
> > > otherwise black screen which is followed by a reboot.
> > >
> > > Setup:
> > > * Machine: ASUS mini PC PN51-BB757MDE1 (DMI model: MINIPC PN51-E1)
> > > * Firmware: 0508 (latest; also tested previous 0505)
> > > * OS: Ubuntu 23.10 (except kernel)
> > > * Kernel: 6.6.8 (also tested 6.7-rc7; config attached)
> > >
> > > Debugging summary:
> > > * Kernel 5.10.205 isn=E2=80=99t affected.
> > > * Bisect identified commit 08d0cc5f34265d1a1e3031f319f594bd1970976c a=
s
> > > cause.
> > > * PCI device 0000:03:00.0 (Intel 8265 Wifi) causes resume issues as l=
ong as
> > > ASPM is enabled (default).
> > > * The commit message indicates that a quirk could be written to mitig=
ate the
> > > issue but I don=E2=80=99t know how to write such a quirk.
> > >
> > > Confirmed workarounds:
> > > * Connect a USB flash drive (no clue why; maybe this causes a delay t=
hat
> > > lets the resume succeed)
> > > * Revert commit 08d0cc5f34265d1a1e3031f319f594bd1970976c (commit seem=
ed
> > > intentional; a quirk seems to be the preferred solution)
> > > * pcie_aspm=3Doff
> > > * pcie_aspm.policy=3Dperformance
> > > * echo 0 | sudo tee /sys/bus/pci/devices/0000:03:00.0/link/l1_aspm
> > >
> > > Debugging details:
> > > * The resume trigger (power button, keyboard, mouse) doesn=E2=80=99t =
seem to make
> > > any difference.
> > > * Double checked that the kernel is configured to *not* reboot on pan=
ic.
> > > * Double checked that there still isn't any kernel output without qui=
et and
> > > splash.
> > > * The issue doesn=E2=80=99t happen if a USB flash drive is connected.=
 The content of
> > > the flash drive doesn=E2=80=99t appear to matter. The USB port doesn=
=E2=80=99t appear to
> > > matter.
> > > * No information in any logs after the reboot. I suspect the resume f=
rom
> > > suspend to RAM isn=E2=80=99t getting far enough as that logs could be=
 written.
> > > * Kernel 5.10.205 isn=E2=80=99t affected. Kernel 5.15.145, 6.6.8 and =
6.7-rc7 are
> > > affected.
> > > * A kernel bisect has revealed the following commit as cause:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/comm=
it/?id=3D08d0cc5f34265d1a1e3031f319f594bd1970976c
> > > * The commit was part of kernel 5.20 and has been backported to 5.15.
> > > * The commit mentions that a device-specific quirk could be added in =
case of
> > > new issues.
> > > * According to sysfs and lspci only device 0000:03:00.0 (Intel 8265 W=
ifi)
> > > has ASPM enabled by default.
> > > * Disabling ASPM for device 0000:03:00.0 lets the resume from suspend=
 to RAM
> > > succeed.
> > > * Enabling ASPM for all devices except 0000:03:00.0 lets the resume f=
rom
> > > suspend to RAM succeed.
> > > * This would indicate that a quirk is missing for the device 0000:03:=
00.0
> > > (Intel 8265 Wifi) but I have no clue how to write such a quirk or how=
 to get
> > > the specifics for such a quirk.
> > > * I still have no clue how a USB flash drive plays into all this. May=
be some
> > > kind of a timing issue where the connected USB flash drive delays som=
ething
> > > long enough so that the resume succeeds. Maybe the code removed by co=
mmit
> > > 08d0cc5f34265d1a1e3031f319f594bd1970976c caused a similar delay. =C2=
=AF\_(=E3=83=84)_/=C2=AF
> >
> > Hmmm.  08d0cc5f3426 ("PCI/ASPM: Remove pcie_aspm_pm_state_change()")
> > appeared in v6.0, released Oct 2, 2022, so it's been there a while.
> >
> > But I think the best option is to revert it until this issue is
> > resolved.  Per the commit log, 08d0cc5f3426 solved two problems:
> >
> >   1) ASPM config changes done via sysfs are lost if the device power
> >      state is changed, e.g., typically set to D3hot in .suspend() and
> >      D0 in .resume().
> >
> >   2) If L1SS is restored during system resume, that restored state
> >      would be overwritten.
> >
> > Problem 2) relates to a patch that is currently reverted (a7152be79b62
> > ("Revert "PCI/ASPM: Save L1 PM Substates Capability for
> > suspend/resume""), so I don't think reverting 08d0cc5f3426 will make
> > this problem worse.
> >
> > Reverting 08d0cc5f3426 will make 1) a problem again.  But my guess is
> > ASPM changes via sysfs are fairly unusual and the device probably
> > remains functional even though it may use more power because the ASPM
> > configuration was lost.
> >
> > So unless somebody has a counter-argument, I plan to queue a revert of
> > 08d0cc5f3426 ("PCI/ASPM: Remove pcie_aspm_pm_state_change()") for
> > v6.7.
>
> Hi,
>
> I cannot understand how 1) even occurs. AFAICT, nothing
> pcie_aspm_pm_state_change() calls into overwrites link->aspm_disable that
> is the variable storing user inputs via sysfs. So how the changes via
> sysfs are lost?

Because it's states being enabled via sysfs get overwritten, not the
disabled ones.

Kai-Heng

>
> --
>  i.

