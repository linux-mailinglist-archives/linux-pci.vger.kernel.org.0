Return-Path: <linux-pci+bounces-30702-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B28CAE9AF1
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 12:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC0E617C41A
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 10:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7102C21D3DB;
	Thu, 26 Jun 2025 10:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DvkBjQ7a"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4017F21A444;
	Thu, 26 Jun 2025 10:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750932799; cv=none; b=G5bxbyyUYOD3IJ1ClqP9z/d0hVx37RdQ+Q+brcub9q8e8nesHarxXe+N5aR7MPnR1+co8dNlpJhifK2+Sac1TvdNube3xr+wL02IaZck3lhl2tsF930pth8hS8L9Uhi/YFWrSvIC4b/1zfFLQ266QnVxxqsDcPLyxONylFz1QFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750932799; c=relaxed/simple;
	bh=H3Hm8ZwhG9stnp9URv+WVSn+KcRnfYN98pKgcSAUiNc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d+fzX12eC0JqFGZIpJCqotvGLO+gKu5nwCY//eyr2jrl7fS1Ps6RPhzXgsdBDH5MbvpPfY7/RFtRlsHebEV3RfC78h4n7cDTT+Bkgw1dWJH3JkMliBZN+NH5EflPuk2u6acE0LXOrDfcXFXzmjpwdI7i2lWHZC/vZTzSt/nduVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DvkBjQ7a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D322FC4CEEE;
	Thu, 26 Jun 2025 10:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750932798;
	bh=H3Hm8ZwhG9stnp9URv+WVSn+KcRnfYN98pKgcSAUiNc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DvkBjQ7ahSIoOADN2NmitD8McDEZktbk/DI2+1z5CsnABCFzdLmMkTRFH5XmGTSlh
	 4TCNR8Ow1PgBWzzwEvyTIQDEtcHInnkSMD9935CBnPthrOJ30PMAFOdzG268rxD+Qq
	 ZcBfxciOTh77AZCGwTcEaSEtb9HmHldLIkT6jFprxnN7uz2YUcHeKB7qDQmNV1/Ign
	 ZwUJYFk79X8ap2xhpAxDbKl38acfV/FHM8S912RdEOpiD307WvsSlZDgLLhA37NEgE
	 AY7RrQVZ7mR4mxOKXLHyfTM3zDuLlo7q+63o4WgvddMVISddMQ443RAh+KIwSu5GKH
	 rAoe/uqAGGJFA==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6119b103132so558094eaf.1;
        Thu, 26 Jun 2025 03:13:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU9o1jaBdwHsOoHJVY1V7b0k9/3Xyt/CHqg/SGvye7nKjTSzrXYTcJk15/LGE9UJS56pJ1UHx8F/+SY@vger.kernel.org, AJvYcCV4KEOWiud24TS+9ZxMWfbamccDhouGTh/68CZIj8CMudEELUj8S2oauYXRDe3qX2UfufvXWBgkrH0=@vger.kernel.org, AJvYcCVz2CnuPmt6XS/1MhY6uBOyk0e4/OTI/kQqOntULxlmXv0cqerhiDhypwdqf1XPsSV2z22wHuYvqDxR+zkY@vger.kernel.org, AJvYcCXCF1eMLB1j9jlA0Scn/OnFYboK49TfCFwhpGUwPCoCt0XJJQFheMa+jZ+SfNZJq0L4n66rhKmWOVBV@vger.kernel.org
X-Gm-Message-State: AOJu0YwrmYmYRjTOdxU6geRe8+qZVaj4DJ2zYQEx7PAhmPE7adwOLyrq
	h3l4mSo+48gxJv802NHbktqKMGwEr/KyHAKf5iP3RubQkVvpgwopG4TtxLoKbnjTH6isUTxzyya
	iVF5if+WVBr3aq5u/KCpqfUzRjHv7wU8=
X-Google-Smtp-Source: AGHT+IGmhhhTDTjzyUv7QYbeYPIjCPkSILNhAIbvZ55Xi9zhPPB+Su9YIRAsDQyg5mxjTNENArO3f70aGbVVhe2zxHM=
X-Received: by 2002:a4a:e908:0:b0:611:3e54:8d0a with SMTP id
 006d021491bc7-611aaedb632mr2107247eaf.1.1750932798132; Thu, 26 Jun 2025
 03:13:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <22759968.EfDdHjke4D@rjwysocki.net> <2045419.usQuhbGJ8B@rjwysocki.net>
 <CAPDyKFq8ea+YogkAExUOBc2TEqi1z9WZswqgP29bLbursFUApg@mail.gmail.com>
 <CAJZ5v0h-9UnvhrQ7YaaYPG5CktwV-i+ZeqAri8OhJQb4TVp82w@mail.gmail.com> <CAPDyKFoW5ag69LBnxvP5oGH1VAErBn17CAOzh=MX2toxAHwLxA@mail.gmail.com>
In-Reply-To: <CAPDyKFoW5ag69LBnxvP5oGH1VAErBn17CAOzh=MX2toxAHwLxA@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 26 Jun 2025 12:13:06 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jx643Os_hvAwoOvYbP3VPhAhgWBqQJk+Rp8zn=w49w9Q@mail.gmail.com>
X-Gm-Features: Ac12FXzA6Z2qh0lnHk5PDayOdrQi_SOG4nvj4QW4gomZsHlPCKtdeNrrZ7uMipg
Message-ID: <CAJZ5v0jx643Os_hvAwoOvYbP3VPhAhgWBqQJk+Rp8zn=w49w9Q@mail.gmail.com>
Subject: Re: [PATCH v1 4/9] PM: Move pm_runtime_force_suspend/resume() under CONFIG_PM_SLEEP
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux ACPI <linux-acpi@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 12:05=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.or=
g> wrote:
>
> On Thu, 26 Jun 2025 at 11:41, Rafael J. Wysocki <rafael@kernel.org> wrote=
:
> >
> > On Thu, Jun 26, 2025 at 11:38=E2=80=AFAM Ulf Hansson <ulf.hansson@linar=
o.org> wrote:
> > >
> > > On Wed, 25 Jun 2025 at 21:25, Rafael J. Wysocki <rjw@rjwysocki.net> w=
rote:
> > > >
> > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > >
> > > > Since pm_runtime_force_suspend/resume() and pm_runtime_need_not_res=
ume()
> > > > are only used during system-wide PM transitions, there is no reason=
 to
> > > > compile them in if CONFIG_PM_SLEEP is unset.
> > > >
> > > > Accordingly, move them all under CONFIG_PM_SLEEP and make the stati=
c
> > > > inline stubs for pm_runtime_force_suspend/resume() return an error
> > > > to indicate that they should not be used outside CONFIG_PM_SLEEP.
> > > >
> > >
> > > Just realized that there seems to be some drivers that actually make
> > > use of pm_runtime_force_suspend() from their ->remove() callbacks.
> > >
> > > To not break them, we probably need to leave this code to stay under =
CONFIG_PM.
> >
> > OK, pm_runtime_force_suspend() need not be under CONFIG_PM_SLEEP.
> > That's not the case for the other two functions though AFAICS.
>
> Right, but maybe better to keep them to avoid confusion?

There really is no point holding pm_runtime_need_not_resume() outside
CONFIG_PM_SLEEP and pm_runtime_force_resume() really should not be
used anywhere outside system resume flows.

> At least the corresponding flag is needed.

What flag do you mean?  If pm_runtime_force_suspend() does not go
under CONFIG_PM_SLEEP, needs_force_resume will not go under it either
(so I'll drop the next patch altogether).

Cheers, Rafael

