Return-Path: <linux-pci+bounces-36679-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7553CB919E3
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 16:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 648B84E24BD
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 14:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1EC1EB5C2;
	Mon, 22 Sep 2025 14:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QSJ5KxWn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D2D1DF980
	for <linux-pci@vger.kernel.org>; Mon, 22 Sep 2025 14:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758550616; cv=none; b=T4ZxgnmExgIOqv9iPMe0yps5J0dtmUPEar31+TJWi4EJbgnBT0g9ubfidZXNgL1aqKlyz1cWXKTGCdjGdxmYRT+hi2GxjM8nhZuDyvrAFbi3ihj/5Cujpp82AQUP7DJfouUgeQe8V/xvgIOa0scShac3kny8XdsvIMovjVhkoNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758550616; c=relaxed/simple;
	bh=p3VFPh6zlqMPmTv7B8WmCD9EeY5W5Y5bNLdM/OEKTHA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=urGudsfVq+5ySXcuTVg98ZcBylnVtjsRN1gKPpwy+exI6w0E7n+J+qyNjHYF846KAm0mP20OdqlhKNAaOk8X1CtCwOScnEfvU67VufcescLscBHkeNeV8+PDctkvxvyPjsVStcVbnJDoUeZMDpTnY+urncke6b8NvI/nrzjAXBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QSJ5KxWn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B102C116B1
	for <linux-pci@vger.kernel.org>; Mon, 22 Sep 2025 14:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758550616;
	bh=p3VFPh6zlqMPmTv7B8WmCD9EeY5W5Y5bNLdM/OEKTHA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QSJ5KxWnDGVuXQVsLeNgRxIi2vUmRhnv5Cs84C7HJIe5EV0YN+jdS4POIR51uSLMD
	 q7aoDVLdSieVi/Ysg0lBmAkGi63s8Wz671LYAOaK0kd0Evbdyt9kpuDQSa18KoRNLL
	 DpBUkQyCXx6Hr+6c8Tt8hZM/xR+97mD6d768Ca6Inze88xda7DQeVoevqumd6NP4iE
	 qh5oG0ZwnzVk1wdC1lUojasyewc6+9NrL8nqZLbjBH/FAjrIMNTl/nqhDOHuJPjSJ/
	 u62ale+XrMb4DFjWFaXwTeu8e9rundsQV8cMqUd3QELrJhswlrhepShs1hfF0QlZQt
	 2dp9h2xCEeLWw==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-61bd4e002afso957199eaf.2
        for <linux-pci@vger.kernel.org>; Mon, 22 Sep 2025 07:16:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVU5qlEpb7DY1WJkOyeKek2qVX9olY8UnDcUChSRjA1YHZCiuAs660TyOV0q8+NjLzkiBjeXAM4mCA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxglG4upjOTRMc9guPhumVcykh2Np1DQU1ROuABxH9WTMY3V0iu
	sJWEG+Zifp7N+KCPHZdx4lv8Cox9c+KqbOmbseKYF27zPymEbGcrzenxmqxpRxDIE0sc2G8RTGn
	uAHoet0aT3mjaV+OfYY554qCSf1jZW2Y=
X-Google-Smtp-Source: AGHT+IETiCQcLSU3PeDydQh7rifOkZY2/e69xVa4uqUWHyP8lQ5K6Dq6B4mRaVxu42sWCzafFCDFQD9SXsgOIheAy8k=
X-Received: by 2002:a05:6820:1caa:b0:624:b767:e1c4 with SMTP id
 006d021491bc7-62724df2f3bmr7336347eaf.0.1758550615446; Mon, 22 Sep 2025
 07:16:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6204724.lOV4Wx5bFT@rafael.j.wysocki> <3388279.44csPzL39Z@rafael.j.wysocki>
 <875xdaevab.wl-tiwai@suse.de> <CAJZ5v0hSBDg4fD7Gy6yEX31xO-3USJG_jFps71BRJJ2f0Oh90A@mail.gmail.com>
 <87348eobnv.wl-tiwai@suse.de> <CAJZ5v0iwNuFxiu3x3-fWO9dkLUq_=c3H=G2OgFmPfVguw0U4Sw@mail.gmail.com>
 <87zfammvgs.wl-tiwai@suse.de>
In-Reply-To: <87zfammvgs.wl-tiwai@suse.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 22 Sep 2025 16:16:39 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iL9V9SC7fQ6_RGCMfUAZzCkCp0kR6zdZWbWtKZ6dQQ2w@mail.gmail.com>
X-Gm-Features: AS18NWCxsMyEXE-vLTHxPks8l77MEe4zD4P6Z-rZFfww8uT22FI3Ko4a3z3kutc
Message-ID: <CAJZ5v0iL9V9SC7fQ6_RGCMfUAZzCkCp0kR6zdZWbWtKZ6dQQ2w@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] PM: runtime: Add auto-cleanup macros for "resume
 and get" operations
To: Takashi Iwai <tiwai@suse.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, 
	Alex Williamson <alex.williamson@redhat.com>, Bjorn Helgaas <helgaas@kernel.org>, 
	Zhang Qilong <zhangqilong3@huawei.com>, Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 4:07=E2=80=AFPM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Mon, 22 Sep 2025 15:44:51 +0200,
> Rafael J. Wysocki wrote:
> >
> > On Mon, Sep 22, 2025 at 3:32=E2=80=AFPM Takashi Iwai <tiwai@suse.de> wr=
ote:
> > >
> > > On Mon, 22 Sep 2025 14:50:32 +0200,
> > > Rafael J. Wysocki wrote:
> > > >
> > > > On Mon, Sep 22, 2025 at 10:38=E2=80=AFAM Takashi Iwai <tiwai@suse.d=
e> wrote:
> > > > >
> > > > > On Sat, 20 Sep 2025 12:54:58 +0200,
> > > > > Rafael J. Wysocki wrote:
> > > > > >
> > > > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > > >
> > > > > > It is generally useful to be able to automatically drop a devic=
e's
> > > > > > runtime PM usage counter incremented by runtime PM operations t=
hat
> > > > > > resume a device and bump up its usage counter [1].
> > > > > >
> > > > > > To that end, add DEFINE_CLASS() macros allowing pm_runtime_put(=
)
> > > > > > and pm_runtime_put_autosuspend() to be used for the auto-cleanu=
p in
> > > > > > those cases.
> > > > > >
> > > > > > Simply put, a piece of code like below:
> > > > > >
> > > > > >       pm_runtime_get_sync(dev);
> > > > > >       .....
> > > > > >       pm_runtime_put(dev);
> > > > > >       return 0;
> > > > > >
> > > > > > can be transformed with CLASS() like:
> > > > > >
> > > > > >       CLASS(pm_runtime_get_active, pm)(dev);
> > > > > >       if (IS_ERR(pm))
> > > > > >               return PTR_ERR(pm);
> > > > > >       .....
> > > > > >       return 0;
> > > > > >
> > > > > > (note the new resume error handling).
> > > > >
> > > > > Do we still allow the code without the error check even using CLA=
SS()?
> > > > > Although the error check should be handled, it's not mandatory fo=
r
> > > > > now.  That said, the above example could be still in a form like:
> > > > >
> > > > >         CLASS(pm_runtime_get_active, pm)(dev);
> > > > >         .....
> > > > >         return 0;
> > > > >
> > > > > while adding the proper error check is recommended?
> > > >
> > > > I'd rather not encourage doing this.
> > > >
> > > > While it may still produce working code in some cases, one needs to
> > > > remember that in case of a runtime resume error it will be running
> > > > without a runtime PM reference it has attempted to acquire.
> > >
> > > Fair enough.  Then it'd be also good to mention that in the
> > > description, too.
> >
> > I can also add classes for the cases in which resume errors can be
> > neglected, like these:
> >
> > DEFINE_CLASS(pm_runtime_get_sync, struct device *,
> >          if (_T) pm_runtime_put(_T),
> >          ({ pm_runtime_get_sync(dev); dev; }), struct device *dev)
> >
> > DEFINE_CLASS(pm_runtime_get_sync_auto, struct device *,
> >          if (_T) pm_runtime_put_autosuspend(_T),
> >          ({ pm_runtime_get_sync(dev); dev; }), struct device *dev)
> >
> > with a comment explaining what they are for.
>
> It might be helpful, indeed, since the error handling isn't always
> straightforward, and this still allows us to convert to the
> auto-cleanup safely.  It's still worth to mention that those aren't
> recommended options, though.

Agreed.

I'll send a v3 including these changes.

