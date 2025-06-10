Return-Path: <linux-pci+bounces-29327-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 599A0AD39FE
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 15:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D67D57A4BAD
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 13:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E9A29290A;
	Tue, 10 Jun 2025 13:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lmbNeVBN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2109230273;
	Tue, 10 Jun 2025 13:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749563602; cv=none; b=ooUC/anXkjsXyGcmNgF902ZxbrBJKqZwcq0+EJvZZMY9Fis+oawZu+BnFgBkZuXK/S0glfAQoKRpxULnIP/yuopggPc7Q84qyK7nGxyj/6PQPaZOb4x9DlLtJOulI1s4wBd1wP8WCOy9AQWdP/BzPUjaHTJ8m5ga2P7tzYyn9mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749563602; c=relaxed/simple;
	bh=GDJ2tbirdbQbVlTGL0ro92+V7GGG0Y4Axu7+11ZpRjw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=doyyAHNgpOI9wGxokl/n2rHUfrLXp/Xbxv3sv8a5L/LcIEdyY2TqVPwEG0dLtSbFbdoMfHC+skndmPGUYhFSL5LahS5Aj9kImhAyoCff5XqvgQxbC/vRQmBS4kW+JPPxvtEp/DYlTWWHRsTMVcIQfptmSjSslamwDppebqbKjGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lmbNeVBN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FA3AC4CEF8;
	Tue, 10 Jun 2025 13:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749563602;
	bh=GDJ2tbirdbQbVlTGL0ro92+V7GGG0Y4Axu7+11ZpRjw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lmbNeVBNA9KNIv+8r01QrJ6D/l1lYD5viwtH2ctNLGarkebullcxZvNj718JtZ78z
	 gQGd99jZAmee4YQO+OQLUtcLTvDu2fSxwO3Nr5+L+mi0s+BlGRwozGuDdsSDbr/Fix
	 e1vcSoOotvE3vboitCW2UNK9qRHuNvgKFDGZ5rrxVnNWc1hs8CW4Aw4w4jN6qC9ckm
	 xyApW//vso4/v9XIQ0JE20rzjWq54MbphJVTECgUfXZ0cfJSH0SOsaVN9QvNVzoH1H
	 MpPf54VJpNtGjrZ4deOKiRGTbg4OSUFngs9DQkftIQyTsV2wu3Sdl6cffU9g/lAB1D
	 5gCwQz0L4e+jg==
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-408d7e2b040so3498256b6e.2;
        Tue, 10 Jun 2025 06:53:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUHSVxxGY9xjLGYUngKl4oI5Tm/zOOvguRw8O4Ag5j2+Lf3PVeKE60oW7Yurl4c8JFOo+Da11fQFMOI0DM=@vger.kernel.org, AJvYcCW/xiASctJZGE6D3Bj/aRE5SF7d1FxVAORg0Pl+xz7fGNqivdK+IpdaJCDJkbcR7/BIbex8AnwIwbc=@vger.kernel.org, AJvYcCXlE3FD+q6NtpWHEXbYxDBrO3NQ8Tsw8FZZJZJ9+YzLKlGHwIpCiwSWabMeKtChmsaPtpKUdWLz9Q2s@vger.kernel.org
X-Gm-Message-State: AOJu0Yw20lcMMwXjHgQ9oH5+SntGd6UWwAPWEqxiL6zhahkQg52T61ej
	f9mE2YQP99NuF8s4CgOuKH7qqGhYP5OQiWLj7glDA4oDtonqk4dfQcA17TrJEBznwh8Jh32YP7o
	TWLPmqaGlEXEzEga/DxEMv0tY8o/u63s=
X-Google-Smtp-Source: AGHT+IGlNTm1MJzJLTbHG3wEHuIscIF8KXjzQciWMa4RxMmJgnM9lw9oVJuqGWgDvGaBH6XwQMx0M0UA5YwVtdH3dTQ=
X-Received: by 2002:a05:6808:f06:b0:40a:5598:7b8e with SMTP id
 5614622812f47-40a56b4d5e8mr1648521b6e.19.1749563601266; Tue, 10 Jun 2025
 06:53:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <fea86161-2c47-4b0f-ac07-b3f9b0f10a03@kernel.org>
 <aC2UzG-eycjqYQep@black.fi.intel.com> <CAJZ5v0gRFwKhq21ima3kT0zzFLk4=47ivvzJqARksV7nYHTJAQ@mail.gmail.com>
 <CAJZ5v0h9--jFVBtQ5F7Gee3Cy8P3TeSLdiHEWykQ=EsZdoffmg@mail.gmail.com>
 <aDnpfKvLwRZsKxhH@black.fi.intel.com> <CAJZ5v0gjA2B4AnaYpfYpaNDo49k4LM2FGSrPFFuOCJ62bCMmkA@mail.gmail.com>
 <aEBpdwMfxp5M4Hxr@black.fi.intel.com> <CAJZ5v0hhoh0Fqnph6ZcbyZBj1Wp0t8UqnLr27TAVW31ZyKPL3Q@mail.gmail.com>
 <aEGDL0IF10QX3Abr@black.fi.intel.com> <CAJZ5v0hJbKEJKRKv67bcQaHbL7h5e_WDGNPg4BA_P4JY-mk_nw@mail.gmail.com>
 <aEg2vzf6tn4j96LG@black.fi.intel.com>
In-Reply-To: <aEg2vzf6tn4j96LG@black.fi.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 10 Jun 2025 15:53:10 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iiPVWpWdAHJkzWCHGrUj5i5b8nN9G2_CAWUarc3Ryskg@mail.gmail.com>
X-Gm-Features: AX0GCFt1DJuKCDDLF1YZtYJEqDUDoWmGYoIQ_uYGBns574F1-3Lp1yAjBKBrINQ
Message-ID: <CAJZ5v0iiPVWpWdAHJkzWCHGrUj5i5b8nN9G2_CAWUarc3Ryskg@mail.gmail.com>
Subject: Re: [PATCH v4] PCI: Prevent power state transition of erroneous device
To: Raag Jadav <raag.jadav@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Mario Limonciello <superm1@kernel.org>, 
	Denis Benato <benato.denis96@gmail.com>, mahesh@linux.ibm.com, oohall@gmail.com, 
	bhelgaas@google.com, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ilpo.jarvinen@linux.intel.com, lukas@wunner.de, 
	aravind.iddamsetty@linux.intel.com, 
	"amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2025 at 3:44=E2=80=AFPM Raag Jadav <raag.jadav@intel.com> w=
rote:
>
> On Thu, Jun 05, 2025 at 02:26:05PM +0200, Rafael J. Wysocki wrote:
> > On Thu, Jun 5, 2025 at 1:44=E2=80=AFPM Raag Jadav <raag.jadav@intel.com=
> wrote:
> > > On Wed, Jun 04, 2025 at 08:19:34PM +0200, Rafael J. Wysocki wrote:
> > > > On Wed, Jun 4, 2025 at 5:43=E2=80=AFPM Raag Jadav <raag.jadav@intel=
.com> wrote:
> > > > > On Fri, May 30, 2025 at 07:49:26PM +0200, Rafael J. Wysocki wrote=
:
> > > > > > On Fri, May 30, 2025 at 7:23=E2=80=AFPM Raag Jadav <raag.jadav@=
intel.com> wrote:
> > > > > > > On Fri, May 23, 2025 at 05:23:10PM +0200, Rafael J. Wysocki w=
rote:
> > > > > > > > On Wed, May 21, 2025 at 1:27=E2=80=AFPM Rafael J. Wysocki <=
rafael@kernel.org> wrote:
> > > > > > > > > On Wed, May 21, 2025 at 10:54=E2=80=AFAM Raag Jadav <raag=
.jadav@intel.com> wrote:
> > > > > > > > > > On Tue, May 20, 2025 at 01:56:28PM -0500, Mario Limonci=
ello wrote:
> > > > > > > > > > > On 5/20/2025 1:42 PM, Raag Jadav wrote:
> > > > > > > > > > > > On Tue, May 20, 2025 at 12:39:12PM -0500, Mario Lim=
onciello wrote:
> > > > >
> > > > > ...
> > > > >
> > > > > > > > > > > From the driver perspective it does have expectations=
 that the parts outside
> > > > > > > > > > > the driver did the right thing.  If the driver was ex=
pecting the root port
> > > > > > > > > > > to be powered down at suspend and it wasn't there are=
 hardware components
> > > > > > > > > > > that didn't power cycle and that's what we're seeing =
here.
> > > > > > > > > >
> > > > > > > > > > Which means the expectation set by the driver is the op=
posite of the
> > > > > > > > > > purpose of this patch, and it's going to fail if any ki=
nd of error is
> > > > > > > > > > detected under root port during suspend.
> > > > > > > > >
> > > > > > > > > And IMV this driver's expectation is questionable at leas=
t.
> > > > > > > > >
> > > > > > > > > There is no promise whatsoever that the device will alway=
s be put into
> > > > > > > > > D3cold during system suspend.
> > > > > > > >
> > > > > > > > For instance, user space may disable D3cold for any PCI dev=
ice via the
> > > > > > > > d3cold_allowed attribute in sysfs.
> > > > > > > >
> > > > > > > > If the driver cannot handle this, it needs to be fixed.
> > > > > > >
> > > > > > > Thanks for confirming. So should we consider this patch to be=
 valid
> > > > > > > and worth moving forward?
> > > > > >
> > > > > > It doesn't do anything that would be invalid in principle IMV.
> > > > > >
> > > > > > You need to consider one more thing, though: It may be necessar=
y to
> > > > > > power-cycle the device in order to kick it out of the erroneous=
 state
> > > > > > and the patch effectively blocks this if I'm not mistaken.
> > > > > >
> > > > > > But admittedly I'm not sure if this really matters.
> > > > >
> > > > > Wouldn't something like bus reset (SBR) be more predictable?
> > > >
> > > > Maybe.
> > > >
> > > > The device state is most likely inconsistent in that case, so it de=
pends.
> > >
> > > My limited understanding is that if SBR doesn't help, at that point a=
ll
> > > bets are off including PMCSR configuration and probably a cold boot i=
s
> > > needed.
> >
> > I'm not talking about PMCSR, I'm talking about power removal (D3cold).
> > This should be equivalent to a cold boot for the particular device
> > except that cold boot would also reset the hierarchy above it.
>
> Sure. But for D3cold we rely on everything else under root port to also
> be suspended, which we can't predict while in endpoint suspend path. And
> with that we're back to "no guarantees" problem, which was the case eithe=
r
> way. The patch might just prevent any further damage than what's already
> done.

Fair enough.

