Return-Path: <linux-pci+bounces-18523-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5951B9F35EE
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 17:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5EB018819A8
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 16:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1AE1494CF;
	Mon, 16 Dec 2024 16:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sHg9Ez5H"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2267E59A;
	Mon, 16 Dec 2024 16:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734366293; cv=none; b=YtFSPeMLRuvDnxCIb7z46ZrfiJo9WHmtpxlSRa0feP9r9nwXL3qvwTaQeyDN7oyXmeWav02BBEcx6pRP0MUmLzzcGtvVYFiBYVmhm9lvaaOPKKS5UMt3P228IflOrksPn8EXBMhrDKG7wfO1FZXUNndjxfHHQ+lDxlkn606caz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734366293; c=relaxed/simple;
	bh=w1PTq099fUPmKOLGOwuxEQreAZ0DAFQUvgT66g5nJRU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n42UPZh9Ch5ZqFH7hhJSNhWqLyyjME7V648KqHTAho9P/BEVw66p6xaIJ7flKBC8cxKDfvw025vLl4Kq8XoQRuO6L3+CsIDkZW2EvkHpgfugav/XoxEJSVQhjfD8uCGtqk16yR8RZc3JKsFDj+jMx5u8M0vunILsCcbEWhC0VZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sHg9Ez5H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9266C4CEE4;
	Mon, 16 Dec 2024 16:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734366292;
	bh=w1PTq099fUPmKOLGOwuxEQreAZ0DAFQUvgT66g5nJRU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sHg9Ez5H6xJZ2Kx/Eip3R4CQsAKVRtfaG0D3sgMTGNWcWEdS3+glFAIzkf23C3n8H
	 vpO/2mUje6rggKFbQZRjrVkPdREbJx0964IlAT/7SbbxHausZrphrqSIH3O9uaDN1h
	 5oTTLS7MwqG8Pojn+IQ4axTyWPFM0dpWDXeeaRPi0Y+vUFExGFCvMCJt6vfcG6zmTy
	 feERB8GiMVlQUy0zUNtYBEU/Qn75HIvDXKQkftNsXektG/+AW6waHTWEikDj+TeElN
	 /Ax6UAGIbTEDTKwETgQb8eAznV55oWq36Ys/Oo/g8sPHt9EKPCi+K6B60ZICZtIeKG
	 rvnPLMKyPk9qw==
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3eb98b3b63dso1092872b6e.1;
        Mon, 16 Dec 2024 08:24:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVRciP/1IhHkUAWZcFEemMwaWre/evJZ4ijzpX9KIQtLNsoe1fnMTq1cvOjSpMnOGURQqO1is+4wng=@vger.kernel.org, AJvYcCX8x9mbCaV4qdw8IUfODc8gtP8VetyCa4B3R86IFTM135lQY2OPV8kYQ9EQaK64HxLVkbbze8ZmBRZXu/w=@vger.kernel.org, AJvYcCXjbbln8tuYyNu0LtjWD0fZ7DzpznAG3S0lLN8yvi3cFc1Ouz4ACPIvVlgE+3nNo0TNf0yoLKGYihfm@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhk5vRFl7W5W9Yb/NjyAqXV1Dfvy0JuxzRR2bnE/6WFBglTRsI
	0OaRLtYtJMxCzPt3xKvqzZst+eA/iyT5rYNoge37Ab58awVQeaJa7LyDrjq5MHG4rb5gAsnvUAF
	hJs29wFb3CT8SlIztzwSch7rw7jo=
X-Google-Smtp-Source: AGHT+IGw+iVg6bx/NQPGwiqE/iG8J0y0s8wQs5qpKioVLQuHUjKeoJ5TqgowE/h1N6vFU/jCAvbZfMokTY+o7RIH2Hc=
X-Received: by 2002:a05:6808:2205:b0:3eb:615a:ece5 with SMTP id
 5614622812f47-3eba686a831mr5106813b6e.15.1734366291846; Mon, 16 Dec 2024
 08:24:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241205232900.GA3072557@bhelgaas> <20241209143821.m4dahsaqeydluyf3@thinkpad>
 <20241212055920.GB4825@lst.de> <13662231.uLZWGnKmhe@rjwysocki.net>
 <CAPDyKFrxEjHFB6B2r7JbryYY6=E4CxX_xTmLDqO6+26E+ULz6A@mail.gmail.com>
 <20241212151354.GA7708@lst.de> <CAJZ5v0gUpDw_NjTDtHGCUnKK0C+x0nrW6mP0tHQoXsgwR2RH8g@mail.gmail.com>
 <20241214063023.4tdvjbqd2lrylb7o@thinkpad>
In-Reply-To: <20241214063023.4tdvjbqd2lrylb7o@thinkpad>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 16 Dec 2024 17:24:40 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gLMx+tBo+MA3AQZ7qP28Z91d04oVBHVeTNcd-QD=kJZg@mail.gmail.com>
Message-ID: <CAJZ5v0gLMx+tBo+MA3AQZ7qP28Z91d04oVBHVeTNcd-QD=kJZg@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: Shutdown the device if D3Cold is allowed by the user
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Christoph Hellwig <hch@lst.de>, Ulf Hansson <ulf.hansson@linaro.org>, 
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, Bjorn Helgaas <helgaas@kernel.org>, kbusch@kernel.org, 
	axboe@kernel.dk, sagi@grimberg.me, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, andersson@kernel.org, 
	konradybcio@kernel.org, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 14, 2024 at 7:30=E2=80=AFAM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Fri, Dec 13, 2024 at 03:35:15PM +0100, Rafael J. Wysocki wrote:
> > On Thu, Dec 12, 2024 at 4:14=E2=80=AFPM Christoph Hellwig <hch@lst.de> =
wrote:
> > >
> > > On Thu, Dec 12, 2024 at 01:49:15PM +0100, Ulf Hansson wrote:
> > > > Right. This seems to somewhat work for ACPI types of systems, becau=
se
> > > > ACPI is controlling the low power state for all the devices. Based =
on
> > > > the requested system wide low power state, ACPI can then decide to
> > > > call pm_set_suspend_via_firmware() or not.
> > > >
> > > > Still there is a problem with this for ACPI too.
> > > >
> > > > How does ACPI know whether it's actually a good idea to keep the NV=
Me
> > > > storage powered in s2idle (ACPI calls pm_set_suspend_via_firmware()
> > > > only for S2R and S2disk!?)? Especially when my laptop only supports
> > > > s2idle and that's what I will use when I close the lid. In this way=
,
> > > > the NMVe storage will certainly contribute to draining the battery,
> > > > especially when I won't be using my laptop for a couple of days.
> > > >
> > > > In my opinion, we need a better approach that is both flexible and
> > > > that dynamically adjusts based upon the use case.
> > >
> > > Agreed.  I'd be happy to work with the PM maintainers to do this,
> > > but I don't really know enough about the PM core to drive it
> > > (as the reply from Rafael to my mail makes pretty clear :))
> >
> > I'm here to help.
> >
> > Let me know what exactly you want to achieve and we'll see how to make =
it work.
>
> I'll try to summarize the requirement here since I started this thread:
>
> Problem statement
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> We need a PM core API that tells the device drivers when it is safe to po=
werdown
> the devices. The usecase here is with PCIe based NVMe devices but the pro=
blem is
> applicable to other devices as well.
>
> Drivers are relying on couple of options now:
>
> 1. If pm_suspend_via_firmware() returns true, then drivers will shutdown =
the
> device assuming that the firmware is going to handle the suspend. But thi=
s API
> is currently used only by ACPI. Even there, ACPI relies on S2R being supp=
orted
> by the platform and it sets pm_set_suspend_via_firmware() only when the s=
uspend
> is S2R. But if the platform doesn't support S2R (current case of most of =
the
> Qcom SoCs), then pm_suspend_via_firmware() will return false and NVMe won=
't be
> powered down draining the battery.

So my question here would be why is it not powered down always during
system-wide suspend?

Why exactly is it necessary to distinguish one case from the other
(assuming that we are talking about system-wide suspend only)?

There are drivers that use pm_suspend_via_firmware() to check whether
or not something special needs to be done to the device because if
"false" is returned, the platform firmware is not going to remove
power from it.

However, you seem to be talking about the opposite, so doing something
special to the device if "true" is returned.  I'm not sure why this is
necessary.

> If the platform is using DT, then there is no entity setting
> pm_set_suspend_via_firmware().

That's true and so the assumption is that in this case the handling of
all devices will always be the same regardless of which flavor of
system suspend is chosen by user space.

> So NVMe will be kept in low power state all the
> time (still draining the battery).

So what would be the problem with powering it down unconditionally?

> There were attempts to set this flag from
> PSCI [1], but there were objections on setting this flag when PSCI_SUSPEN=
D is
> not supported by the platform (again, the case with Qcom SoCs). Even if t=
his
> approach succeeds, then there are concerns that if the platform is used i=
n an
> OS like Android where the S2Idle cycle is far more high, NVMe will wear o=
ut
> very quickly.

I see.

> So this is where the forthcoming API need to "dynamically adjusts
> based upon the use case" as quoted by Ulf in his previous reply. One way =
to
> achieve would be by giving the flexibility to the userspace to choose the
> suspend state (if platform has options to select). UFS does something sim=
ilar
> with 'spm_lvl' [2] sysfs attribute that I believe Android userspace itsel=
f makes
> use of.

Before we're talking about APIs, let's talk about the desired behavior.

It looks like there are cases in which you'd want to turn the device
off completely (say put it into D3cold in the PCI terminology) and
there are cases in which you'd want it to stay in a somewhat-powered
low-power state.

It is unclear to me what they are at this point.

> 2. Making use of pm_suspend_target_state to differentiate between suspend=
 states
> and powering down the devices only during PM_SUSPEND_MEM (S2R). But this =
also
> suffers from the same issue as mentioned above (when platform doesn't sup=
port
> S2R).
>
> TLDR: We need a PM core API that that sets a sane default suspend state f=
or the
> platform and also allows dynamically changing/overriding the state (by ta=
king
> inputs from userspace etc...). This API should also forbid override, if t=
he
> platform has limitations (like if it requires powering down the devices a=
ll the
> time (x13s laptops)). Finally, this API would be used by the device drive=
rs to
> decide when to safely power down the devices during suspend.
>
> @Ulf/others: Please chime in if you don't agree with anything I said abov=
e.

