Return-Path: <linux-pci+bounces-29028-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA742ACEF22
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jun 2025 14:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84F227A76B1
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jun 2025 12:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8BE213E90;
	Thu,  5 Jun 2025 12:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O+zn3CsB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F6817B50F;
	Thu,  5 Jun 2025 12:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749126378; cv=none; b=Xkk+LlB8xg/M4KgNaRanwjSdO7Pja3nIHuNHQZaywCfdKcnvr3kMWmxv1pb9GjOKGoWS3kJcx6/vq5VC9GNbss37MbKnjzDs/iU0PeteofL2RmJAMmTkM2g2nC7YAG1EFW/yYgTL8nZ/uvMcSzLXUSL/MIxCnLqcyFbqXeYDMEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749126378; c=relaxed/simple;
	bh=4WJhgjAnEtUFXmL2GWy4353pkE5BMV7J2KFQCgkngak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aOb6NItcKoCKCzK5z2ZFWStHtpzH151uaXgOfkKrrcVwXZ6SYJecucmttpdgSQ2Ma1pMBR7H3i8NeGHde6wA4KZXMhU9kBeaM9UEm9k62sz+dt3s8RuFjL2I5Rr9J3w8dPh7wKumKL4cAmHbXvlS6K6nlRPTDDJGVmVzwBl8t1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O+zn3CsB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0876C4CEEF;
	Thu,  5 Jun 2025 12:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749126377;
	bh=4WJhgjAnEtUFXmL2GWy4353pkE5BMV7J2KFQCgkngak=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=O+zn3CsBROu139GaMTH2Gt5k+eiWkb+LdTiPJmFaaOamXAjtOUN2p1QqF2r1/p/cn
	 VMtS9KbPYXgnkmyY91qnrOJgUuCE6Nz/jVDquP4uDqCT2YjbUyKbcmz4nmH/2V20Ia
	 SY/5Xn9zaMjMxN7RZ0rNyMrr4YqZA7KUWNYWr2+C24+Uja5xkGBMZoPPkqbyGTCFTj
	 tp2WB/UCOxYbEm+PWKaWLuoqMjdI5gGhVPdBsfOM0nK/q67r7oor+COShHn/NtCtfi
	 EOv43U2jlakyV5dKfpBsOEzzwRee6ijbSsQji6AM+0irX9rOQd8GuWZ922nqDWPZmO
	 PixHwvdpR+6Xg==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2e3e58edab5so345159fac.3;
        Thu, 05 Jun 2025 05:26:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUB03EwG6B5s5JtsmPDVWpIM+aYlQIpn6EDuLeSSyrkwSidfJAZ7Sbwtfu6UXcwDNO0HWO2Uf6JhgNwfBY=@vger.kernel.org, AJvYcCWNZDYn+dRaDAMyH5nX9UjQtiLWL7LqXbebUSFFwFZFIdz0bY2dfGPJTJPGaB5l+vUhEJpkwJNez8A=@vger.kernel.org, AJvYcCWlIfSmmBQe4UdhQb+VsjbXdOJAKra1YcaKYPiDQgZj2iDmGSzRixsqmBDO2oKgTvF5Wsf/nkwgFUJs@vger.kernel.org
X-Gm-Message-State: AOJu0Yybb8qTwfQxKVdf8gcqPJd4G/RxRDaqUTgYok24d2EVcOoNVsnu
	OeODFbAvIOU7AyKzzxzBhbaithg4WdRdJPuG20HsowBHEtVZq6jdcWbM2GorNB7+M/eO+qHfJQY
	Bau7S3OUakwVaPjwZvHOvAb1redL3vW0=
X-Google-Smtp-Source: AGHT+IEwbhB9q1U38/ArzbcpRN42CjSWVC8jtUlFCNmZf81r5ZGmE3b9Dt8Woywq+2BbQRtB4ZT/AhAYyuYovBSyi2U=
X-Received: by 2002:a05:6870:8e07:b0:2d6:2a40:fbe7 with SMTP id
 586e51a60fabf-2e9bf31d024mr4658964fac.6.1749126377202; Thu, 05 Jun 2025
 05:26:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6f23d82c-10cc-4d70-9dce-41978b05ec9a@kernel.org>
 <aCzNL9uXGbBSdF2S@black.fi.intel.com> <fea86161-2c47-4b0f-ac07-b3f9b0f10a03@kernel.org>
 <aC2UzG-eycjqYQep@black.fi.intel.com> <CAJZ5v0gRFwKhq21ima3kT0zzFLk4=47ivvzJqARksV7nYHTJAQ@mail.gmail.com>
 <CAJZ5v0h9--jFVBtQ5F7Gee3Cy8P3TeSLdiHEWykQ=EsZdoffmg@mail.gmail.com>
 <aDnpfKvLwRZsKxhH@black.fi.intel.com> <CAJZ5v0gjA2B4AnaYpfYpaNDo49k4LM2FGSrPFFuOCJ62bCMmkA@mail.gmail.com>
 <aEBpdwMfxp5M4Hxr@black.fi.intel.com> <CAJZ5v0hhoh0Fqnph6ZcbyZBj1Wp0t8UqnLr27TAVW31ZyKPL3Q@mail.gmail.com>
 <aEGDL0IF10QX3Abr@black.fi.intel.com>
In-Reply-To: <aEGDL0IF10QX3Abr@black.fi.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 5 Jun 2025 14:26:05 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hJbKEJKRKv67bcQaHbL7h5e_WDGNPg4BA_P4JY-mk_nw@mail.gmail.com>
X-Gm-Features: AX0GCFszkKfoW0b4kUz_tjavfz2i9S_MK1cS4vEFCRJbyuk-B48Ya0tiCbJ8hOg
Message-ID: <CAJZ5v0hJbKEJKRKv67bcQaHbL7h5e_WDGNPg4BA_P4JY-mk_nw@mail.gmail.com>
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

On Thu, Jun 5, 2025 at 1:44=E2=80=AFPM Raag Jadav <raag.jadav@intel.com> wr=
ote:
>
> On Wed, Jun 04, 2025 at 08:19:34PM +0200, Rafael J. Wysocki wrote:
> > On Wed, Jun 4, 2025 at 5:43=E2=80=AFPM Raag Jadav <raag.jadav@intel.com=
> wrote:
> > > On Fri, May 30, 2025 at 07:49:26PM +0200, Rafael J. Wysocki wrote:
> > > > On Fri, May 30, 2025 at 7:23=E2=80=AFPM Raag Jadav <raag.jadav@inte=
l.com> wrote:
> > > > > On Fri, May 23, 2025 at 05:23:10PM +0200, Rafael J. Wysocki wrote=
:
> > > > > > On Wed, May 21, 2025 at 1:27=E2=80=AFPM Rafael J. Wysocki <rafa=
el@kernel.org> wrote:
> > > > > > > On Wed, May 21, 2025 at 10:54=E2=80=AFAM Raag Jadav <raag.jad=
av@intel.com> wrote:
> > > > > > > > On Tue, May 20, 2025 at 01:56:28PM -0500, Mario Limonciello=
 wrote:
> > > > > > > > > On 5/20/2025 1:42 PM, Raag Jadav wrote:
> > > > > > > > > > On Tue, May 20, 2025 at 12:39:12PM -0500, Mario Limonci=
ello wrote:
> > >
> > > ...
> > >
> > > > > > > > > From the driver perspective it does have expectations tha=
t the parts outside
> > > > > > > > > the driver did the right thing.  If the driver was expect=
ing the root port
> > > > > > > > > to be powered down at suspend and it wasn't there are har=
dware components
> > > > > > > > > that didn't power cycle and that's what we're seeing here=
.
> > > > > > > >
> > > > > > > > Which means the expectation set by the driver is the opposi=
te of the
> > > > > > > > purpose of this patch, and it's going to fail if any kind o=
f error is
> > > > > > > > detected under root port during suspend.
> > > > > > >
> > > > > > > And IMV this driver's expectation is questionable at least.
> > > > > > >
> > > > > > > There is no promise whatsoever that the device will always be=
 put into
> > > > > > > D3cold during system suspend.
> > > > > >
> > > > > > For instance, user space may disable D3cold for any PCI device =
via the
> > > > > > d3cold_allowed attribute in sysfs.
> > > > > >
> > > > > > If the driver cannot handle this, it needs to be fixed.
> > > > >
> > > > > Thanks for confirming. So should we consider this patch to be val=
id
> > > > > and worth moving forward?
> > > >
> > > > It doesn't do anything that would be invalid in principle IMV.
> > > >
> > > > You need to consider one more thing, though: It may be necessary to
> > > > power-cycle the device in order to kick it out of the erroneous sta=
te
> > > > and the patch effectively blocks this if I'm not mistaken.
> > > >
> > > > But admittedly I'm not sure if this really matters.
> > >
> > > Wouldn't something like bus reset (SBR) be more predictable?
> >
> > Maybe.
> >
> > The device state is most likely inconsistent in that case, so it depend=
s.
>
> My limited understanding is that if SBR doesn't help, at that point all
> bets are off including PMCSR configuration and probably a cold boot is
> needed.

I'm not talking about PMCSR, I'm talking about power removal (D3cold).
This should be equivalent to a cold boot for the particular device
except that cold boot would also reset the hierarchy above it.

