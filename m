Return-Path: <linux-pci+bounces-18562-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB349F397D
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 20:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1108188C742
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 19:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70BC20766B;
	Mon, 16 Dec 2024 19:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="evCvRQpT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783841CD213;
	Mon, 16 Dec 2024 19:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734376221; cv=none; b=U9aIQUUyqyE3R3swDBAorjxTBiWxpIGXbc0QryH+xAOYgxrIM9E28FTxWgnc1UT65G0XgUQjU3fSq+xY05DYnP0hZ+oCNU+9+yAKVf+bUB87YzGAWRHE0mQ5hyt0O++swppa0uhdyUf1s2f07d49Nk6Y40mMUCdX6I0PoRwz8g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734376221; c=relaxed/simple;
	bh=qeYHwULuvIS8IOi5OkxWsi2QR2qYDfzPIJmQKUyh6FM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gKmmw4IXg58bHyrd5Zj/VgJQHxoRTk/gDO7BruyQBJgyeQMRHn4h52oV9jWGaWhPl3COtkUmXyM+Z4Ir4SQ321IGRQIPl98slR0EcNc1cz6zBTwg7ncmAUQVQ26tsd+xgg72voiz6FhPN9uokoz5yAwaS8Co5idDccc/WKD/1ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=evCvRQpT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16786C4CEDD;
	Mon, 16 Dec 2024 19:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734376221;
	bh=qeYHwULuvIS8IOi5OkxWsi2QR2qYDfzPIJmQKUyh6FM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=evCvRQpTS0zks6AjRvM+fshukuAwu5HI4Xyg5uISYDIcRm669qGpnazk5HWkd4ClL
	 yQHsbIu/Xlzpd3Acmm4N0WyDJY8OhnMWwG2IKgSR0YtmntaPa0H31ELwm31jb4HGXy
	 JNuL4hBMIw6ufvawmu7gn47NYuEzbD4SEGoIGoi/ZIpbYe18VlkQUxZNOHmyxEeZ5k
	 Dg+l8u/pCkeBzf4/B0mb/pRUXbfj1ab/O3dFESxNJmFlPkuYsDPPFwamiOTLgSCcax
	 xbrClSp+dY/EXqrxCol8MmDEX0fz7aaV/X54M8TX43F+1rMmrWFSkrtOQjG6vDN1Rr
	 kooxsSqWfecFQ==
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3ebb2d8dac4so1501164b6e.0;
        Mon, 16 Dec 2024 11:10:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVrrC2E6IWpR3BjXR5DJ2iiKETD67YBqwWvp/Af6wVRJDzZa4uBMZQT6EqujtLD5oQI+T24PJF64DbI3AU=@vger.kernel.org, AJvYcCWNhQPx6c55KVCRWpOeZZ1EsXL6iWfN5uuOrb/JRpHzFa1iHmlzOoV3/c9d0Y4vmOUyRl4+m90jlX17@vger.kernel.org, AJvYcCWxcasZwSnM4KrP7IzVS3jdI7E+DW5cVK25egqpjXpwqkEGCqFZKtaltAMtKxjBRn1iM0q3Oo4G8AY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCmv9D366/hAVW78cdFObFmekUWobbt5flsJoYBVKfa4g0rihA
	55riFd+Lv/pNdNWXzlCoeqaak326Ly9m2rc1MKQpLUgIlktC7P+3+q1bNWsaiiM7RstgMuhqKXs
	eUTnWfCk/6MJSuDX5e5Wv92VBOK0=
X-Google-Smtp-Source: AGHT+IEtKuUcyShfRdoQ6ZVPEaQjiY5/nPcB9LIM8bKSgRsRQ5zSt7I5tDEKwVaMyBFzeZP4GURKyXnod0Il+Bz/kOQ=
X-Received: by 2002:a05:6808:2384:b0:3ea:431c:4f70 with SMTP id
 5614622812f47-3eba65cb9e1mr7328003b6e.0.1734376220324; Mon, 16 Dec 2024
 11:10:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212055920.GB4825@lst.de> <13662231.uLZWGnKmhe@rjwysocki.net>
 <CAPDyKFrxEjHFB6B2r7JbryYY6=E4CxX_xTmLDqO6+26E+ULz6A@mail.gmail.com>
 <20241212151354.GA7708@lst.de> <CAJZ5v0gUpDw_NjTDtHGCUnKK0C+x0nrW6mP0tHQoXsgwR2RH8g@mail.gmail.com>
 <20241214063023.4tdvjbqd2lrylb7o@thinkpad> <20241216162303.GA26434@lst.de>
 <CAJZ5v0g8CdGgWA7e6TXpUjYNkU1zX46Rz3ELiun42MayoN0osA@mail.gmail.com>
 <20241216164830.36lpu6gfnapsdar4@thinkpad> <CAJZ5v0hxnYere19wXbua6zWEDRDgSPeJgSECugtwfgTP-UN8Bw@mail.gmail.com>
 <20241216173945.s5y4dsyzhi5fo4ey@thinkpad>
In-Reply-To: <20241216173945.s5y4dsyzhi5fo4ey@thinkpad>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 16 Dec 2024 20:10:09 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hhruAS_b739FTo_63=h=U5zbH5M5jWco8pq+KwVY5UcA@mail.gmail.com>
Message-ID: <CAJZ5v0hhruAS_b739FTo_63=h=U5zbH5M5jWco8pq+KwVY5UcA@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: Shutdown the device if D3Cold is allowed by the user
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Christoph Hellwig <hch@lst.de>, Ulf Hansson <ulf.hansson@linaro.org>, 
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, Bjorn Helgaas <helgaas@kernel.org>, kbusch@kernel.org, 
	axboe@kernel.dk, sagi@grimberg.me, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, andersson@kernel.org, 
	konradybcio@kernel.org, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 6:39=E2=80=AFPM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Mon, Dec 16, 2024 at 06:28:55PM +0100, Rafael J. Wysocki wrote:
> > On Mon, Dec 16, 2024 at 5:48=E2=80=AFPM Manivannan Sadhasivam
> > <manivannan.sadhasivam@linaro.org> wrote:
> > >
> > > On Mon, Dec 16, 2024 at 05:42:30PM +0100, Rafael J. Wysocki wrote:
> > > > On Mon, Dec 16, 2024 at 5:23=E2=80=AFPM Christoph Hellwig <hch@lst.=
de> wrote:
> > > > >
> > > > > On Sat, Dec 14, 2024 at 12:00:23PM +0530, Manivannan Sadhasivam w=
rote:
> > > > > > We need a PM core API that tells the device drivers when it is =
safe to powerdown
> > > > > > the devices. The usecase here is with PCIe based NVMe devices b=
ut the problem is
> > > > > > applicable to other devices as well.
> > > > >
> > > > > Maybe I'm misunderstanding things, but I think the important part=
 is
> > > > > to indicate when a suspend actually MUST put the device into D3. =
 Because
> > > > > doing that should always be safe, but not always optimal.
> > > >
> > > > I'm not aware of any cases when a device must be put into D3cold
> > > > (which I think is what you mean) during system-wide suspend.
> > > >
> > > > Suspend-to-idle on x86 doesn't require this, at least not for
> > > > correctness.  I don't think any platforms using DT require it eithe=
r.
> > > >
> > >
> > > On suspend-to-idle, yes D3Cold doesn't make sense,
> >
> > Why?
> >
>
> Because there is no requirement to remove power during S2Idle, isn't it?

There is no requirement, but there is a reason that I've already
mentioned: A device in D3cold causes a system in s2idle use less
energy.

I think this reason is good enough.

> From Documentation/admin-guide/pm/sleep-states.rst:
>
> 'This is a generic, pure software, light-weight variant of system suspend=
'.

Sure.  Which basically means that platform firmware is not involved
(at least not as much as in the ACPI S3 case) and CPUs are managed in
a more lightweight way.

The power states of devices are what they are.

Moreover, the whole idea of suspend-to-idle is to re-use the
suspend-to-RAM (ACPI S3, basically) control flow, along with the
handling of devices.  The devices handled differently are exceptions,
not a rule.

> > > but on suspend-to-ram it is pretty much required.
> >
> > Well, I know for a fact that on x86 platforms ACPI S3 does not require
> > putting devices into D3cold in general.
> >
> > Why is it required for NVMe?
> >
>
> But ACPI code currently calls pm_set_suspend_via_firmware() for S3 suspen=
d. And
> that causes NVMe to be powered down because of pm_suspend_via_firmware() =
check.

That's how the driver is designed, but is it actually required to be
designed this way?

> > > That applies to DT as well.
> >
> > Again, why?
>
> On DT systems if firmware supports both S2Idle and S2R, devices can be ke=
pt in
> low power state during S2Idle and powered down during S2R.
>
> The problem comes if the firmware only supports the former state.

I don't get it, sorry.

Firmware support for suspend-to-idle is not required, at least in
principle, so I'm not sure what you mean by firmware support for it.
I'm also not sure how S2R is supported by firmware on DT systems, so
care to explain?

In any case, I don't see why in principle devices need to be handled
differently depending on what flavor of system suspend in used at any
given time.

