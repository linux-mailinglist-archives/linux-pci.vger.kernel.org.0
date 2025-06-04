Return-Path: <linux-pci+bounces-28998-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE060ACE443
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 20:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2E3E7A489D
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 18:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700AE19E819;
	Wed,  4 Jun 2025 18:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f0g3rxno"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A49D139D;
	Wed,  4 Jun 2025 18:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749061187; cv=none; b=rtlNBtmbIdwQyOGr675SEEBOCQlxXYTT56x7AxVHJAM8pDAn4duICDvZzMgPlotuJl5gO2YiZf4i8CVEDBwi21nCY+3wD3T9P/PN/7yE3Pz2kP0BrbY8qzlHlRRXnq6OVsW9jGTTvVYgeqsZvrk/XZUTH6XHkJBZxlGDqzbZsRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749061187; c=relaxed/simple;
	bh=HEARLMHSlGAJvxpt66oclxxZn67jUYESwoOn9OnHHSs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CtSwjND4/QOzzRC/PA2bXbaHXwwlWzvELx91F/L68u3wECVPQA8ShilPypZzZgEsoTTPKpMgLdSH+jyQU9xkfCDj/qhPzV+rj7yCNGfLHuZ0vjtqGqj6djc0kmmCVmfsUMrueY8b4sWl3J0xJGJ0jma/KuGxiHwZgu8IizUP1Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f0g3rxno; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A080BC4CEF3;
	Wed,  4 Jun 2025 18:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749061186;
	bh=HEARLMHSlGAJvxpt66oclxxZn67jUYESwoOn9OnHHSs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=f0g3rxnon+OGy8uW/iBIcJwV9YE3hO0oHNm6DDZ55HCCz/LTH/+bD0xMJF6BurkaC
	 /Rr9eRIrxbTkEJGbzLfmQBNf+cUNufZb7M47RX0Xik1voyeJTnBbwDHWSaTRxU5brb
	 44/UFu9+0KAecoLEoobh5H18cmwR9thpc0TMefFNW66Y2Uz0uA4rjJB65IMMktbAYm
	 RpEpzRYzxTSZMTJUiZjEsk2vuZ8DMG1h9i+FewdeKvrnr72COBjhF2fe74JMn6F3nE
	 iiA7ouEZFfzRDUqFmY8vZ+PsMs4/NU7j8MljD036etrx2sshzectjBaMg58McQOCzR
	 dpgcLnHOwVK2A==
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-4079f80ff0fso756345b6e.1;
        Wed, 04 Jun 2025 11:19:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUdulboepyeNAsfLnsrRsxPhPj4e2bXg1ZX7X1XM7cwUI8I/Grp61WhZj1kFMuVxIlwZ5hpYTUuhgo/@vger.kernel.org, AJvYcCV32YbPn0K+dU1u4JAudf9Yw9nnzdkqIvnWHhVc5bNOTIEWPXIm4C/NL2kNAWGcpSCmtowbMWn4Ir7QcvA=@vger.kernel.org, AJvYcCWTp99GqPAB4tEE0KojuxgX6Rxu614IOZuzN1kcLH8cTz2OqivXJR7Q1EsvdXSfm7bATupQ5wLi42E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFtlkVBWjuOZNTTGyL/dp4rZfRxjq463YVPLMqxsTqQJ5bp3uB
	Ffdck9MbQaywCdsLOTc+vaZBKdE7TlEQ9633jX/yiFgNPQ4025VloKXYUHe9eKTHiLLLCJ5ghwc
	q2grQK91Ia24Rgisuv59XLBgmbHUnd8I=
X-Google-Smtp-Source: AGHT+IFzTiHFsMcNwEDy6J6DzLls3gsM6anKsUoGKN8wkS7W1gW9kVqAPb6jp1/ZPEVu8ZqkTyPj+gUXdCirNDH6nRE=
X-Received: by 2002:a05:6808:22a2:b0:3f3:d699:e1a8 with SMTP id
 5614622812f47-408fac108c5mr484765b6e.13.1749061185873; Wed, 04 Jun 2025
 11:19:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <552d75b2-2736-419f-887e-ce2692616578@kernel.org>
 <ee1117cf-6367-4e9a-aa85-ccfc6c63125d@gmail.com> <6f23d82c-10cc-4d70-9dce-41978b05ec9a@kernel.org>
 <aCzNL9uXGbBSdF2S@black.fi.intel.com> <fea86161-2c47-4b0f-ac07-b3f9b0f10a03@kernel.org>
 <aC2UzG-eycjqYQep@black.fi.intel.com> <CAJZ5v0gRFwKhq21ima3kT0zzFLk4=47ivvzJqARksV7nYHTJAQ@mail.gmail.com>
 <CAJZ5v0h9--jFVBtQ5F7Gee3Cy8P3TeSLdiHEWykQ=EsZdoffmg@mail.gmail.com>
 <aDnpfKvLwRZsKxhH@black.fi.intel.com> <CAJZ5v0gjA2B4AnaYpfYpaNDo49k4LM2FGSrPFFuOCJ62bCMmkA@mail.gmail.com>
 <aEBpdwMfxp5M4Hxr@black.fi.intel.com>
In-Reply-To: <aEBpdwMfxp5M4Hxr@black.fi.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 4 Jun 2025 20:19:34 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hhoh0Fqnph6ZcbyZBj1Wp0t8UqnLr27TAVW31ZyKPL3Q@mail.gmail.com>
X-Gm-Features: AX0GCFsu9AnuhJSn72E2Tb6mBLfmajSBROpQVego6uWW9V1aoDEJzIL15ch0Xhg
Message-ID: <CAJZ5v0hhoh0Fqnph6ZcbyZBj1Wp0t8UqnLr27TAVW31ZyKPL3Q@mail.gmail.com>
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

On Wed, Jun 4, 2025 at 5:43=E2=80=AFPM Raag Jadav <raag.jadav@intel.com> wr=
ote:
>
> On Fri, May 30, 2025 at 07:49:26PM +0200, Rafael J. Wysocki wrote:
> > On Fri, May 30, 2025 at 7:23=E2=80=AFPM Raag Jadav <raag.jadav@intel.co=
m> wrote:
> > > On Fri, May 23, 2025 at 05:23:10PM +0200, Rafael J. Wysocki wrote:
> > > > On Wed, May 21, 2025 at 1:27=E2=80=AFPM Rafael J. Wysocki <rafael@k=
ernel.org> wrote:
> > > > > On Wed, May 21, 2025 at 10:54=E2=80=AFAM Raag Jadav <raag.jadav@i=
ntel.com> wrote:
> > > > > > On Tue, May 20, 2025 at 01:56:28PM -0500, Mario Limonciello wro=
te:
> > > > > > > On 5/20/2025 1:42 PM, Raag Jadav wrote:
> > > > > > > > On Tue, May 20, 2025 at 12:39:12PM -0500, Mario Limonciello=
 wrote:
>
> ...
>
> > > > > > > From the driver perspective it does have expectations that th=
e parts outside
> > > > > > > the driver did the right thing.  If the driver was expecting =
the root port
> > > > > > > to be powered down at suspend and it wasn't there are hardwar=
e components
> > > > > > > that didn't power cycle and that's what we're seeing here.
> > > > > >
> > > > > > Which means the expectation set by the driver is the opposite o=
f the
> > > > > > purpose of this patch, and it's going to fail if any kind of er=
ror is
> > > > > > detected under root port during suspend.
> > > > >
> > > > > And IMV this driver's expectation is questionable at least.
> > > > >
> > > > > There is no promise whatsoever that the device will always be put=
 into
> > > > > D3cold during system suspend.
> > > >
> > > > For instance, user space may disable D3cold for any PCI device via =
the
> > > > d3cold_allowed attribute in sysfs.
> > > >
> > > > If the driver cannot handle this, it needs to be fixed.
> > >
> > > Thanks for confirming. So should we consider this patch to be valid
> > > and worth moving forward?
> >
> > It doesn't do anything that would be invalid in principle IMV.
> >
> > You need to consider one more thing, though: It may be necessary to
> > power-cycle the device in order to kick it out of the erroneous state
> > and the patch effectively blocks this if I'm not mistaken.
> >
> > But admittedly I'm not sure if this really matters.
>
> Wouldn't something like bus reset (SBR) be more predictable?

Maybe.

The device state is most likely inconsistent in that case, so it depends.

