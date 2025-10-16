Return-Path: <linux-pci+bounces-38367-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3642CBE476C
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 18:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 510894E8DA0
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 16:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D028D32D0D7;
	Thu, 16 Oct 2025 16:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gx3e4bzo"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA13132D0CE
	for <linux-pci@vger.kernel.org>; Thu, 16 Oct 2025 16:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760630802; cv=none; b=gQrhCjF2HSxNTQoE6EYHvHN1xeZO12hkDpqm06WpxdSNPTGN3+0BOkDqCRnda2O8y75hCtH2qh8Kiz8mlNlXQpUycUFv8RUrDH9iDN2EEsYc/00sMm11kN75BE3pQ/2Bg9aKD9FWH2omA+jC2/yvj1CklKsZiZBzqMOeNLNsU14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760630802; c=relaxed/simple;
	bh=Hrisi8zxkOaW5XhVaLZLwZymkPWBwWZRKU/rxPnRWqk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cUIY1wTymK+rgQ29lx7VCLDzCa0DBLqmS72imckbb9c+FFXiBwjeQ00vQ3DNNBPJ0UueP12+pJu63n7M6IFfilPZPU814TGufKzuhv0enbR+5mXj2qh+cK1fe+TEHrGqAEknnyWoI0xCoxeB9CPZiqx/Py/3v8RXw+h0nz2/wX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gx3e4bzo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88755C19422
	for <linux-pci@vger.kernel.org>; Thu, 16 Oct 2025 16:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760630802;
	bh=Hrisi8zxkOaW5XhVaLZLwZymkPWBwWZRKU/rxPnRWqk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Gx3e4bzo2/dy5fsNgvEObKHmZZ/QgxCgMxKuMxfm0+jdtRo7q8fVuqp0nMBCUX9ME
	 s7g3kyUtrbplEUMKLXPdSW0L8EpjF/5htvKPY2piaO/fmh2wCNEvqGrZ8BLIU6QSaZ
	 1+h8csiJ1FB9gheVgUms0l2nD8qwQqLSRj4TVKBYBeqmJy95lTR1RaYqs2j/P7/EBt
	 sevLm+z7ns1zmungpLoNfiNWUb9jXfyhx71vufrklhRHZZNE2EIRgGOxo27AQFh9UA
	 fkpAyF8MGF0+Rrcp3VZXUPp26yIJzUdyY+M4KC9ZnnhItNRYLIEJoJ3y9jpwz/QsNI
	 2sBdUNzcbh8ug==
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7ae21804971so317463a34.0
        for <linux-pci@vger.kernel.org>; Thu, 16 Oct 2025 09:06:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXQK87D9l6XNBxpv8qlpLOJKm+RxoV6S2W+2DgHsCM8K2f7l9B7Fa2UF9F9V+U4DLxjnavTA/WpY4A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBpPVlwS5P/ZedsKYBrLLop44BzlT83OAApxrA04feTd8TGFHu
	IUbjFgbDxgKAJUK6Xo/IKhwHkp/FXPC0DArT5joso5L0Qiv3ORA8Kg4mPCpyz2FTPudB8KfNLyf
	HaCu9ckRvwABrQwh9Y1gZyUNhIGSRDtk=
X-Google-Smtp-Source: AGHT+IEV6FcNRR4ZW0YJGN/hXp78WROhL7nsspV7qW6aVCZGAonTb7rnNMyezEumYmrfn681jqhnuJA5qn9Vcrf6tb0=
X-Received: by 2002:a05:6808:4442:b0:43f:64bc:8b7e with SMTP id
 5614622812f47-443a2ed9ademr251822b6e.15.1760630801727; Thu, 16 Oct 2025
 09:06:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3925484.kQq0lBPeGt@rafael.j.wysocki> <3324926.5fSG56mABF@rafael.j.wysocki>
 <20251016133854.00003669@huawei.com> <CAJZ5v0iOgbkJbdRzgrBUaaYL+S_8BZD7XuXdK5vs2gMG3ug1KA@mail.gmail.com>
 <87ikge7v01.wl-tiwai@suse.de>
In-Reply-To: <87ikge7v01.wl-tiwai@suse.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 16 Oct 2025 18:06:29 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iWq=1HDHnj6_rTiK83cFiVyNimuSpLc5dYU9Tz90nqXw@mail.gmail.com>
X-Gm-Features: AS18NWAe-CiF1eQtYmrJretaU6h3MT0stuE3TFM4dIDL5Jf7RC9uiRIurDJvprE
Message-ID: <CAJZ5v0iWq=1HDHnj6_rTiK83cFiVyNimuSpLc5dYU9Tz90nqXw@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] PM: runtime: Introduce PM_RUNTIME_ACQUIRE_OR_FAIL()
 macro
To: Takashi Iwai <tiwai@suse.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux PCI <linux-pci@vger.kernel.org>, Alex Williamson <alex.williamson@redhat.com>, 
	Bjorn Helgaas <helgaas@kernel.org>, Zhang Qilong <zhangqilong3@huawei.com>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Frank Li <Frank.Li@nxp.com>, Dhruva Gole <d-gole@ti.com>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	Dan Williams <dan.j.williams@intel.com>, David Lechner <dlechner@baylibre.com>, 
	"Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 4:59=E2=80=AFPM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Thu, 16 Oct 2025 15:46:08 +0200,
> Rafael J. Wysocki wrote:
> >
> > On Thu, Oct 16, 2025 at 2:39=E2=80=AFPM Jonathan Cameron
> > <jonathan.cameron@huawei.com> wrote:
> > >
> > > On Wed, 15 Oct 2025 16:02:02 +0200
> > > "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> > >
> > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > >
> > > > There appears to be an emerging pattern in which guard
> > > > pm_runtime_active_try is used for resuming the given device and
> > > > incrementing its runtime PM usage counter if the resume has been
> > > > successful, that is followed by an ACQUIRE_ERR() check on the guard
> > > > variable and if that triggers, a specific error code is returned, f=
or
> > > > example:
> > > >
> > > >       ACQUIRE(pm_runtime_active_try, pm)(dev);
> > > >       if (ACQUIRE_ERR(pm_runtime_active_try, &pm))
> > > >               return -ENXIO
> > > >
> > > > Introduce a macro called PM_RUNTIME_ACQUIRE_OR_FAIL() representing =
the
> > > > above sequence of statements that can be used to avoid code duplica=
tion
> > > > wherever that sequence would be used.
> > > >
> > > > Use this macro right away in the PCI sysfs code where the above pat=
tern
> > > > is already present.
> > > >
> > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > ---
> > > >
> > > > Admittedly, the new macro is slightly on the edge, but it really he=
lps
> > > > reduce code duplication, so here it goes.
> > >
> > > Fully agree with the 'on the edge'.
> > >
> > > This looks somewhat like the some of the earlier attempts to come up =
with
> > > a general solution before ACQUIRE().  Linus was fairly clear on his o=
pinion of
> > > a proposal that looked a bit similar to this
> > > cond_guard(mutex_intr, return -EINTR, &mutex);
> > >
> > > https://lore.kernel.org/all/CAHk-=3Dwin7bwWhPJ=3DiuW4h-sDTqbX6v9_LJnM=
aO3KxVfPSs81bQ@mail.gmail.com/
> > >
> > > +CC a few people who might have better memories of where things went =
than I do.
> > >
> > > The solution you have here has the benefit of clarity that all it can=
 do is
> > > return the error code.
> >
> > Well, I could call the macro PM_RUNTIME_ACQUIRE_OR_RETURN_ERROR(), but
> > FAIL is just shorter. :-)
> >
> > Seriously though, the odd syntax bothers me, but it has come from
> > looking at the multiple pieces of code that otherwise would have
> > repeated exactly the same code pattern including the guard name in two
> > places and the pm variable that has no role beyond guarding.
>
> While I see the benefit of simplification, IMO, embedding a code
> flow control inside the macro argument makes it really harder to
> follow.
>
> Is the problem about the messy ACQUIRE_ERR() invocation?  If so, it
> could be replaced with something shorter (and without extra type),
> e.g. replace
>         ret =3D ACQUIRE_ERR(pm_runtime_active_try, &pm);
> with
>         ret =3D PM_RUNTIME_ACQUIRE_ERR(&pm);
>
> Since all runtime PM guard usage is to the same object, we can have a
> common macro.

Well, it's not a problem, but an observation that the code pattern is
exactly the same in all of the places that use this macro, so it
represents this exact same code pattern that otherwise will be
repeated in multiple places.

I have no problem with copy-pasting this code pattern between
different use sites, but that's something we generally avoid as a
rule, don't we?

