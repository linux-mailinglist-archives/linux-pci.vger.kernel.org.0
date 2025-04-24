Return-Path: <linux-pci+bounces-26678-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43390A9AB52
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 13:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0B1C3B119A
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 11:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C521E1DE5;
	Thu, 24 Apr 2025 11:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2cbMhlW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868905BAF0;
	Thu, 24 Apr 2025 11:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745492590; cv=none; b=uJ1fJL1lhh8ltCaiu4oNexvsFJhqW//F4M7qzkHZQo+c8d3tSEFwydXqhr/y+vHW7JTCwv7I2x7FNMjEwLskhzyMrXElIZ8qrq05KE0ef4WdP59bQumm0impZfFvpVXzG28W/y1KoVakxVQ3YuxwYqBIchqNjd/oOiYXwRVTbOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745492590; c=relaxed/simple;
	bh=hyV+/TI+fPXrUMs5YluLUXdPfqeyfP2h6M8iUeti5MY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pmd5RWHiZpzQUJS+EeuvKuJhEKjcr+OQt8jrFYy21ib2VU45SYBYgd5HzeTEus/w/UIvVarolm0qRXMdxfOpoO7yXeLDONhMjsM+Phvoz4671wp/iok4Ryn1GXmfpxmTCUO/O+GhIuiO/61itFVsz9OUFfThNVD9peMyfDxcQeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F2cbMhlW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D989C4CEEE;
	Thu, 24 Apr 2025 11:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745492590;
	bh=hyV+/TI+fPXrUMs5YluLUXdPfqeyfP2h6M8iUeti5MY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=F2cbMhlWSmroQr6V7U7MJeyYamhmUktI54VvxE5JAo7r92a5NOYpNbXdX8JX5VMfC
	 NlKP0uQgt6sBltNXg+JM/40C96ktw4X+gneJpkL7goachiUefdtSiocDh0NY8I2lTD
	 SsuUj5zi+GsN44Gbj9XMG068QVcBslAdsdMjq+thgI+TrAxPV374GK79xko/Dt+78C
	 AbgMK6gJ6sKg4GQGm+c5BufC8+O+8wjlYE1orRsPXsZoHaayinLBT3PCGf3LeND+vx
	 ZWlptoRUlVWCDqDxvd4gPyqL649I1YbvjKWjH2t7hsTgTmFEoCFTHH1zSgmnY8TVHP
	 Pw23Ek+2DK6cg==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2cc82edcf49so200644fac.1;
        Thu, 24 Apr 2025 04:03:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUTA7vZ8VWgZqRsiLk6R48cXMo7J5YvxvXTBVonn8yaBwwvzLKutNMCrlubKrKQiysq+F5k1FQ4Pe0N@vger.kernel.org, AJvYcCWG5m8YGbyQEAQEBOsgOvpONHO4thtlYBvvUHcOUGsRcz5UbnVKZI15LA49y7HmOOHeL+DfZz/e+9pEEMo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD2K7GWSW/Qfm9cZnJE+QVsHKT4DrpgpIh/qBTnDKoAh9C/hjT
	jcyp7P3Itlg93u8sbTIUQ+ESHUAqgttApaP+8T1m7uADJ7d6mM/Osa4LfCMK4ygu1vuyktVILNa
	P9Kg5nbB2ZX0iXJDBUSGUDCvTYBs=
X-Google-Smtp-Source: AGHT+IFuQoKZgYFAaJXa+tjHxd3y8Tbv98mGDsNqE4JwXLSX7Dz+sVyptUZDaMZZaRtXOPRS1KhBxFD5PtrDST30ZPc=
X-Received: by 2002:a05:6870:b018:b0:29e:503a:7ea3 with SMTP id
 586e51a60fabf-2d96e742783mr1092286fac.36.1745492589290; Thu, 24 Apr 2025
 04:03:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250422135341.2780925-1-raag.jadav@intel.com>
 <CAJZ5v0gBxkFF-BTTsAM_LHSGq9uuWF2Fq3-jDYPkOhWK4b+qaw@mail.gmail.com> <aAnOUouuqOC3-Yb8@black.fi.intel.com>
In-Reply-To: <aAnOUouuqOC3-Yb8@black.fi.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 24 Apr 2025 13:02:58 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gQ-6ZehL5HNhFvOWDEyXdS++uaMn1AOB7whoMTKzj-ZQ@mail.gmail.com>
X-Gm-Features: ATxdqUHvg7m1RiahxQi7XF-iyjgNJFF7XEVHvOXVxSn28guFCFFwPREgNxb6bDk
Message-ID: <CAJZ5v0gQ-6ZehL5HNhFvOWDEyXdS++uaMn1AOB7whoMTKzj-ZQ@mail.gmail.com>
Subject: Re: [PATCH v2] PCI/PM: Avoid suspending the device with errors
To: Raag Jadav <raag.jadav@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, mahesh@linux.ibm.com, oohall@gmail.com, 
	bhelgaas@google.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ilpo.jarvinen@linux.intel.com, lukas@wunner.de, 
	aravind.iddamsetty@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 7:38=E2=80=AFAM Raag Jadav <raag.jadav@intel.com> w=
rote:
>
> On Wed, Apr 23, 2025 at 02:41:52PM +0200, Rafael J. Wysocki wrote:
> > On Tue, Apr 22, 2025 at 3:55=E2=80=AFPM Raag Jadav <raag.jadav@intel.co=
m> wrote:
> > >
> > > If an error is triggered before or during system suspend, any bus lev=
el
> > > power state transition will result in unpredictable behaviour by the
> > > device with failed recovery. Avoid suspending such a device and leave
> > > it in its existing power state.
> > >
> > > This only covers the devices that rely on PCI core PM for their power
> > > state transition.
> > >
> > > Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> > > ---
> > >
> > > v2: Synchronize AER handling with PCI PM (Rafael)
> > >
> > > More discussion on [1].
> > > [1] https://lore.kernel.org/all/CAJZ5v0g-aJXfVH+Uc=3D9eRPuW08t-6Pwzdy=
MXsC6FZRKYJtY03Q@mail.gmail.com/
> > >
> > >  drivers/pci/pci-driver.c |  3 ++-
> > >  drivers/pci/pcie/aer.c   | 11 +++++++++++
> > >  include/linux/aer.h      |  2 ++
> > >  3 files changed, 15 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> > > index f57ea36d125d..289a1fa7cb2d 100644
> > > --- a/drivers/pci/pci-driver.c
> > > +++ b/drivers/pci/pci-driver.c
> > > @@ -884,7 +884,8 @@ static int pci_pm_suspend_noirq(struct device *de=
v)
> > >                 }
> > >         }
> > >
> > > -       if (!pci_dev->state_saved) {
> > > +       /* Avoid suspending the device with errors */
> > > +       if (!pci_aer_in_progress(pci_dev) && !pci_dev->state_saved) {
> >
> > Apart from the potential raciness mentioned by Bjorn, doing it just
> > here is questionable because this is not the only place where the PCI
> > device power state can change.
> >
> > It would be better to catch this in pci_set_low_power_state() IMO.
>
> I'm not sure if we should prevent power state transition for the users
> that explicitly want to transition.
>
> Also, the device state can potentially be corrupted because of the errors=
,
> so we'd probably want to avoid pci_save_state() as well, which is what
> I attempted here.

But it's not what the changelog is saying.

If you want to avoid pci_save_state(), there are also other places
when it is called and then you also may want to avoid the transition
because if the state is not saved, it won't be possible to restore it.

