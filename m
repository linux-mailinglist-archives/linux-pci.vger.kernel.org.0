Return-Path: <linux-pci+bounces-36663-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 004FAB91393
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 14:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3603424A5F
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 12:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B213093D3;
	Mon, 22 Sep 2025 12:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sd7qAck8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAB52AD20
	for <linux-pci@vger.kernel.org>; Mon, 22 Sep 2025 12:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758545449; cv=none; b=RsVibHWBqB04wrVbeWJ6D1ft2KvAGyOAbMl66fgw/Qof5zE/IIPs0YJbsP6tr+fUeod89+4GYicTZb1vN4vd3cNgJcsA5kMIhSYOMf04guzEFZDbO0xW4sAy0WyaxdoDEW1SUZLuJFbBan9zuQ9JHSzxsiwAJv3CzpwGuzlbrSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758545449; c=relaxed/simple;
	bh=lpopxTfeKK9nwMgyawU+4DnWEanmPTCaJR4h5qNJrG0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ovnHEm97rQr68bDBR1E0K2VIl764PDOJRGmetB74pQOPRQtS2OMzPHAa5h6FmmvGC0uba8cpcQYbJCDz5DF916TATYMvXk2VuotLZjgFoHYl+A+1HbRbKz3bm9CcadzVHTmgWIdxWYs6LPiAi0J79fGbwDkbbYr2qOpp3A/FuCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sd7qAck8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E6EBC16AAE
	for <linux-pci@vger.kernel.org>; Mon, 22 Sep 2025 12:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758545449;
	bh=lpopxTfeKK9nwMgyawU+4DnWEanmPTCaJR4h5qNJrG0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Sd7qAck8CXhmJEWpm1UFWeW/QCf9aY7RJ2+bXZY0RLQlGy4H6GjZchPlDMv+JvfqK
	 sMFqN4dxahup142Z5OxbhapprbP6Tr3RdElJWjtsdjmwRXqdOptkR1UIjTSdDUtKxs
	 6L6XpnAg76RgrMaAaZC1m5J5nWj6uEKDR9lta6ozYoG4t+Aeq1gTixjLPinRbioaBs
	 UeIJTy2sLmyi3WhFdbmhdNgZYeHDdBPeFdKwKQcF3yq7IUCw77fA64XskMH6FhnjC5
	 AdREgb8M2MFGP8y9F/ZNPhg6X93alunCM5nhrJ3yvpIRRg6K30V+a2lO+LtoEaIytM
	 +LsxmlRoO+cwA==
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-62adbcf4025so667932eaf.2
        for <linux-pci@vger.kernel.org>; Mon, 22 Sep 2025 05:50:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV31d/nM41xOTLmL9uLuy3laEjy1kKKP2Mt3whKveK4i5iK8Kyz4SKGeagPuAvmJVsPX1oGv/AjpY4=@vger.kernel.org
X-Gm-Message-State: AOJu0YywPPK69yxfTAQBCrKvybl/OKpZn5A4BaCHASzYhBBj8fMCDJmp
	tvMt2/+dxa9lvPIwx3GOo8A0+csszBbCqROCChbMAw1joeMauPiElALkDUrNHENIeILtp+3QgHF
	On0hKfQU/Z7L0JfcUujfsTWWoWSZQ3I0=
X-Google-Smtp-Source: AGHT+IEaNSq0P2/zvgvVh0csdNsGuoVrCyDwcZf4ZEpxG3y4MENventscB+mJeJRuFcIXn/S/FNG4bPduBbpJyth4i0=
X-Received: by 2002:a05:6808:4703:b0:439:af72:a13b with SMTP id
 5614622812f47-43d6c0faba9mr6286864b6e.6.1758545448291; Mon, 22 Sep 2025
 05:50:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6204724.lOV4Wx5bFT@rafael.j.wysocki> <3388279.44csPzL39Z@rafael.j.wysocki>
 <875xdaevab.wl-tiwai@suse.de>
In-Reply-To: <875xdaevab.wl-tiwai@suse.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 22 Sep 2025 14:50:32 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hSBDg4fD7Gy6yEX31xO-3USJG_jFps71BRJJ2f0Oh90A@mail.gmail.com>
X-Gm-Features: AS18NWCHbvmsov39JF3MuuKFmqx2CC8_RanaumRHVJhrorL1QgMM11HwPKkNNYg
Message-ID: <CAJZ5v0hSBDg4fD7Gy6yEX31xO-3USJG_jFps71BRJJ2f0Oh90A@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] PM: runtime: Add auto-cleanup macros for "resume
 and get" operations
To: Takashi Iwai <tiwai@suse.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, 
	Alex Williamson <alex.williamson@redhat.com>, Bjorn Helgaas <helgaas@kernel.org>, 
	Zhang Qilong <zhangqilong3@huawei.com>, Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 10:38=E2=80=AFAM Takashi Iwai <tiwai@suse.de> wrote=
:
>
> On Sat, 20 Sep 2025 12:54:58 +0200,
> Rafael J. Wysocki wrote:
> >
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > It is generally useful to be able to automatically drop a device's
> > runtime PM usage counter incremented by runtime PM operations that
> > resume a device and bump up its usage counter [1].
> >
> > To that end, add DEFINE_CLASS() macros allowing pm_runtime_put()
> > and pm_runtime_put_autosuspend() to be used for the auto-cleanup in
> > those cases.
> >
> > Simply put, a piece of code like below:
> >
> >       pm_runtime_get_sync(dev);
> >       .....
> >       pm_runtime_put(dev);
> >       return 0;
> >
> > can be transformed with CLASS() like:
> >
> >       CLASS(pm_runtime_get_active, pm)(dev);
> >       if (IS_ERR(pm))
> >               return PTR_ERR(pm);
> >       .....
> >       return 0;
> >
> > (note the new resume error handling).
>
> Do we still allow the code without the error check even using CLASS()?
> Although the error check should be handled, it's not mandatory for
> now.  That said, the above example could be still in a form like:
>
>         CLASS(pm_runtime_get_active, pm)(dev);
>         .....
>         return 0;
>
> while adding the proper error check is recommended?

I'd rather not encourage doing this.

While it may still produce working code in some cases, one needs to
remember that in case of a runtime resume error it will be running
without a runtime PM reference it has attempted to acquire.

