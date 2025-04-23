Return-Path: <linux-pci+bounces-26610-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD65A9987F
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 21:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B757920D1C
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 19:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B8727FD75;
	Wed, 23 Apr 2025 19:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yf59RCfV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6B925C834
	for <linux-pci@vger.kernel.org>; Wed, 23 Apr 2025 19:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745436627; cv=none; b=O2omB+4D/evFtoWaqNWd6V9gOuZuG8ZoHLRxB85QSL7jKXzprc2S8n4/j9z4slxohgCUhiF0IfqHSW9Ueo265NTj74W6dYs1rCGrFgUBZcwXWLIfeTF01kd5EVrEMgt5r4k+e8WNewcxIvS7hAOr+h4k5tYOevJ3MYDuFqWejus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745436627; c=relaxed/simple;
	bh=K8gj4LFyrG3bdwsRzFbna0TT9+J9IN9GMyh6OHH5Li4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jzlzX6z/u0ip/I6bpivrIdTTuUTStx74s6uhf27zxUi7Q8DS60AK9afVDBQVssEajtWG5+I02os5/o6IMwiAZdnW5XMmMpsxtxX5ZtpCwTtO7MEib11KYbnwi3E/I4j8XRVXZyy1ctNrUI0QGFY3wIU4z2CK6OyNLdS76oPX4gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yf59RCfV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37369C4CEEA
	for <linux-pci@vger.kernel.org>; Wed, 23 Apr 2025 19:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745436627;
	bh=K8gj4LFyrG3bdwsRzFbna0TT9+J9IN9GMyh6OHH5Li4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Yf59RCfVIbXqRrFROtJf/+dxatHu30wFlTAEpnvybJosJiC88sQrTL87iCP6ly4xh
	 vix56xj2LWvviBqv41tyJCqvcVgPwZ9AF0V6bWUwf28Izlm7KYgFylNhdY3dRZqd3F
	 A4OKW1s4p7Gu/poK3QFStgYxDWisFUiORWzXuIduPnUlk3fPTa8edefcVnIJ7FGg1t
	 MhFe6i+5vk1c0yZV9NKi2JOmMh1G3rlObhKk2s6tGgJLueBMP7asFtfNb7HZX7iT3x
	 W4BGDJJhdG9SwOQ0Wt9TZ2sPa1VfAM17tRLe/A44r2b3QrInx/cpAv9VIf/ycC1jqB
	 ubsSXUEaSNelg==
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3fbaa18b810so55426b6e.2
        for <linux-pci@vger.kernel.org>; Wed, 23 Apr 2025 12:30:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUG0s524BkqDIWDEzt5I5BS97VnQfzKw63zQ01+nt396PsEym34cS07F0p350oJTx61VmL/SOOQ9bo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1fXetsD0X2Xt8saQVl4xJn8WMWkT1xV3n+/TkW50EoJZqKnLr
	DoI06HJM8JIC2GOkXcYn/Zr6btFAA7y4zHJqoQMYFwdRghUyeK5CZOhZxEO1PFGYth/rK2oFJmh
	B88U4Lk9D/ErTbVFsmKLglk7E2V4=
X-Google-Smtp-Source: AGHT+IE6nS81N00iDrWwEmyAowDENtg906Z18l+nrMhkA/qWaXEVcNL7r1QNipZSXSWwYjoLWRtLpim+ea5LD+n0QQ0=
X-Received: by 2002:a05:6870:c98f:b0:29e:766d:e969 with SMTP id
 586e51a60fabf-2d526a496b0mr13216054fac.10.1745436626501; Wed, 23 Apr 2025
 12:30:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250422133944.1940679-1-superm1@kernel.org> <f7831afa-6dd0-461a-8c3a-0b5095fb69eb@intel.com>
In-Reply-To: <f7831afa-6dd0-461a-8c3a-0b5095fb69eb@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 23 Apr 2025 21:30:15 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gtYciTe0LPu8d+wrCD01y0p-eNO1Qu269ucqdCG-gpTA@mail.gmail.com>
X-Gm-Features: ATxdqUFmbZ6CYzDbycAAi3xu4Vx3UQNI5-OftCC-ZA3ZnS_0dBviPKGuqGZ6X_c
Message-ID: <CAJZ5v0gtYciTe0LPu8d+wrCD01y0p-eNO1Qu269ucqdCG-gpTA@mail.gmail.com>
Subject: Re: [PATCH] PCI: Explicitly put devices into D0 when initializing
To: Mario Limonciello <superm1@kernel.org>
Cc: mario.limonciello@amd.com, bhelgaas@google.com, 
	huang.ying.caritas@gmail.com, stern@rowland.harvard.edu, 
	linux-pci@vger.kernel.org, linux-pm@kernel.vger.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 23, 2025 at 9:12=E2=80=AFPM Wysocki, Rafael J
<rafael.j.wysocki@intel.com> wrote:
>
>
> On 4/22/2025 3:38 PM, Mario Limonciello wrote:
> > From: Mario Limonciello <mario.limonciello@amd.com>
> >
> > AMD BIOS team has root caused an issue that NVME storage failed to come
> > back from suspend to a lack of a call to _REG when NVME device was prob=
ed.
> >
> > commit 112a7f9c8edbf ("PCI/ACPI: Call _REG when transitioning D-states"=
)
> > added support for calling _REG when transitioning D-states, but this on=
ly
> > works if the device actually "transitions" D-states.
> >
> > commit 967577b062417 ("PCI/PM: Keep runtime PM enabled for unbound PCI
> > devices") added support for runtime PM on PCI devices, but never actual=
ly
> > 'explicitly' sets the device to D0.
> >
> > To make sure that devices are in D0 and that platform methods such as
> > _REG are called, explicitly set all devices into D0 during initializati=
on.
> >
> > Fixes: 967577b062417 ("PCI/PM: Keep runtime PM enabled for unbound PCI =
devices")
> > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > ---
> > Note: an earlier internal version of this attempted to do this in local=
_pci_probe()
> > but this doesn't affect PCI root ports and we need _REG called on the r=
oot ports too.
> >
> >   drivers/pci/pci.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 53a070394739a..cd87c8370dede 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -3266,6 +3266,7 @@ void pci_pm_init(struct pci_dev *dev)
> >       pci_read_config_word(dev, PCI_STATUS, &status);
> >       if (status & PCI_STATUS_IMM_READY)
> >               dev->imm_ready =3D 1;
> > +     pci_set_power_state(dev, PCI_D0);
>
> I'd rather not do this after enabling runtime PM, but at the same time
> doing it before setting up PM would be rather unsafe.
>
> I'd move the pm_runtime_forbid(), pm_runtime_set_active(), and
> pm_runtime_enable() sequence of calls after the pci_set_power_state()
> call above.

Also, I think that pci_pm_power_up_and_verify_state() would be more
suitable for this initial power up because power_state is already 0 at
this point and this case is analogous  to post-resume.

