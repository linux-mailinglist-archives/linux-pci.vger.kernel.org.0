Return-Path: <linux-pci+bounces-35853-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0CF5B52036
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 20:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA56B5636C7
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 18:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F2A26FA77;
	Wed, 10 Sep 2025 18:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ajblWDlc"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909FF272E7B
	for <linux-pci@vger.kernel.org>; Wed, 10 Sep 2025 18:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757528607; cv=none; b=cUi0mSbtuQEcVeQTPkYztJCs43I/WsVoTIJmhhJdGnm1xlV0FiGu6ZfvT+MBqgZxoLGIrWKT80Es5p+RYqxQRAfCu73qUAQD4hISOcG9Au5vJ2m1xH1IyucHjjIfzQIIpVxOYjesuTMbVJ+BKJ79hvrwUMOpYyRf6UoBIfsVlvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757528607; c=relaxed/simple;
	bh=+xIR3asJwN5hgErdxA5RKk8TysQZx223OPFxmTPM6wk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A4iCfWxfNmihjk2ciiodf/Jv9obYmMt5eLMq3ijtqjXN8U4r1KEenUTp9Zg11EoJ3yExk78eyb8TlfSr4VUjNka3ZR4YzREMLDuuvHF9g0pPYFLYIBm/n5bkcXU2vegvD5eMB6epyeJcQDgLPWBCN5rJkLsF7S+WjHT5XOPQVh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ajblWDlc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35077C4CEFB
	for <linux-pci@vger.kernel.org>; Wed, 10 Sep 2025 18:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757528607;
	bh=+xIR3asJwN5hgErdxA5RKk8TysQZx223OPFxmTPM6wk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ajblWDlcgnGiwv4b+87zSHaRuScxCB1stcp55whAoZulzhoBh1esX9XyuQoyzBH5Q
	 4GSK+7JtMnuab6uFkuxlZrsgsLsvVBtEuklUFt3xFi95QVTELfNpDebmtYBcLBlo75
	 0vv4KhNHLZDuIuayscRphfTdctDipKeB2p8aoUoq+xNNkPdksAqsuQLongju4KCmvU
	 tVrb4MUmP6333fqMik7fkJ244k29ltCTwuXSc+MPNLVCGYMGTwaVtf+GWlbvt6GbGK
	 jXawRaKAw7vuXbicbM3OsEnJrgvSWwmWMoqlNA+iI02ZC8N3GYfl/+CP19p/Comtxu
	 OMTqecchv6uKw==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-61ea79c1e91so1914628eaf.3
        for <linux-pci@vger.kernel.org>; Wed, 10 Sep 2025 11:23:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXu7mFa0hvpVUnhTzg3CgvavZDPvLSNnleBZBOxASCrQR4kowj4izRhis0ilGYQhYuIMQ3a4aFQu0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzmQ2/jrhMTc0Bbke75A0sKAXzmZT42NmnFbVojtDBpiF4/sQx
	+fE5xj6jWj4EB0NNfrH6ABe2lmdNYgrpDEClBG4RZkW5JaiQvT2UuwzkFmPczsgrEOHxstMF/Jh
	pn/Du1CKVofzG43kyiQtt62EMqvLtEAY=
X-Google-Smtp-Source: AGHT+IHuJvNxF2V1tX1VXNeWzG5+F8V+ZGBMwM/IMnADUgJ2KlwC42wDx0ddU1lVmFJOq6s4hYUdpYwCoggap1Mbof4=
X-Received: by 2002:a05:6820:828:b0:620:7998:64aa with SMTP id
 006d021491bc7-621789fd31cmr7712178eaf.1.1757528606440; Wed, 10 Sep 2025
 11:23:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909191619.2580169-1-superm1@kernel.org> <CAJZ5v0jZaP41CC_2Q4NfKZWB8VazJbmiOtv55i3QDngh_3YGOw@mail.gmail.com>
 <b013c9bb-cf7c-424e-9ab0-8136bb9dc744@kernel.org>
In-Reply-To: <b013c9bb-cf7c-424e-9ab0-8136bb9dc744@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 10 Sep 2025 20:23:10 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jHKp7c7dSQMZr5tmQOV6=fHOygTf-YG6Gx9YmurA9cTA@mail.gmail.com>
X-Gm-Features: Ac12FXxP4R30XoZ1EAQoBcb1zrTQS_kNI4CD1-JlFf5ha5_0hv061p7vj9zUCZE
Message-ID: <CAJZ5v0jHKp7c7dSQMZr5tmQOV6=fHOygTf-YG6Gx9YmurA9cTA@mail.gmail.com>
Subject: Re: [PATCH v7 00/12] Improvements to S5 power consumption
To: Mario Limonciello <superm1@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
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

On Wed, Sep 10, 2025 at 8:19=E2=80=AFPM Mario Limonciello <superm1@kernel.o=
rg> wrote:
>
> On 9/10/25 1:11 PM, Rafael J. Wysocki wrote:
> > Hi Mario,
> >
> > On Tue, Sep 9, 2025 at 9:16=E2=80=AFPM Mario Limonciello (AMD)
> > <superm1@kernel.org> wrote:
> >>
> >> A variety of issues both in function and in power consumption have bee=
n
> >> raised as a result of devices not being put into a low power state whe=
n
> >> the system is powered off.
> >>
> >> There have been some localized changes[1] to PCI core to help these is=
sues,
> >> but they have had various downsides.
> >>
> >> This series instead uses the driver hibernate flows when the system is
> >> being powered off or halted.  This lines up the behavior with what oth=
er
> >> operating systems do as well.  If for some reason that fails or is not
> >> supported, run driver shutdown() callbacks.
> >>
> >> Rafael did mention in earlier versions of the series concerns about
> >> regression risk.  He was looking for thoughts from Greg who isn't agai=
nst
> >> it but also isn't sure about how to maintain it. [1]
> >>
> >> This has been validated by me and several others in AMD
> >> on a variety of AMD hardware platforms. It's been validated by some
> >> community members on their Intel hardware. To my knowledge it has not
> >> been validated on non-x86.
> >
> > Still, the patches need more work (see my replies to the relevant patch=
es).
>
> Yes, thanks for the review.
> >
> >> On my development laptop I have also contrived failures in the hiberna=
tion
> >> callbacks to make sure that the fallback to shutdown callback works.
> >>
> >> In order to assist with potential regressions the series also includes
> >> documentation to help with getting a kernel log at shutdown after
> >> the disk is unmounted.
> >>
> >> Cc: AceLan Kao <acelan.kao@canonical.com>
> >> Cc: Kai-Heng Feng <kaihengf@nvidia.com>
> >> Cc: Mark Pearson <mpearson-lenovo@squebb.ca>
> >> Cc: Merthan Karaka=C5=9F <m3rthn.k@gmail.com>
> >> Cc: Eric Naim <dnaim@cachyos.org>
> >> Link: https://lore.kernel.org/linux-usb/2025090852-coma-tycoon-9f37@gr=
egkh/ [1]
> >> ---
> >> v6->v7:
> >>   * Add documentation on how to debug a shutdown hang
> >>   * Adjust commit messages per feedback from Bjorn
> >>
> >> Mario Limonciello (AMD) (12):
> >>    PM: Introduce new PMSG_POWEROFF event
> >>    scsi: Add PM_EVENT_POWEROFF into suspend callbacks
> >>    usb: sl811-hcd: Add PM_EVENT_POWEROFF into suspend callbacks
> >>    USB: Pass PMSG_POWEROFF event to suspend_common()
> >>    PCI/PM: Disable device wakeups when halting or powering off system
> >>    PCI/PM: Split out code from pci_pm_suspend_noirq() into helper
> >>    PCI/PM: Run bridge power up actions as part of restore phase
> >>    PCI/PM: Use pci_power_manageable() in pci_pm_poweroff_noirq()
> >>    PCI: Put PCIe bridges with downstream devices into D3 at hibernate
> >>    drm/amd: Avoid evicting resources at S5
> >>    PM: Use hibernate flows for system power off
> >>    Documentation: power: Add document on debugging shutdown hangs
> >
> > If I were you, I'd split this series into 3 parts.
> >
> > The first part would be the addition of PMSG_POWEROFF just for
> > hibernation, which should not be objectionable (the first 4 patches
> > above).
> >
> > The next one would be changes to allow PCI bridges to go into
> > D3hot/cold during the last stage of hibernation (the "power-off"
> > transition).  This can be justified by itself even before starting to
> > use the same power-off flow for the last stage of hibernation and for
> > system power-down.
> >
> > The last one would be the hibernation/power-down integration.
> >
> > Each of the above can be posted separately and arguably you need to
> > get the first part in before the other two and the second part in
> > before the third one, preferably not in the same cycle.
> >
> > This way, if there are any regressions in the first two parts, there
> > will be at least some time to address them before the last part goes
> > in.
> >
> > Thanks!
>
> Thanks for this proposal.
>
> I do like the idea of splitting it in 3 parts to give time for
> regression control.
>
> It's getting close to the end of this cycle, would you be opposed to a
> re-spun first 4 patches for 6.18?

No, I wouldn't.

I think that they have been reviewed already.

