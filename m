Return-Path: <linux-pci+bounces-18664-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C33159F5727
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 20:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA4C516F9B5
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 19:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB9B1F9405;
	Tue, 17 Dec 2024 19:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nz9aU/21"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36B01F8ADB;
	Tue, 17 Dec 2024 19:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734464768; cv=none; b=WdUgPSDnipTdu+poeER5fAvKKEaH6cblh6CPMHn/oxsQ1GbPe/3M1KtGZJ+5cCVBHb0/59dzMU01y2VJ0ha8Qi6oafCKkA4jKVgPu8bbdXTTTV3GggElQHdti5k25UHIUf1J2YZz4rxH1l3hbojf4aLj4oMbSMX5GkEpE86uUCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734464768; c=relaxed/simple;
	bh=wyJiG/rLnKAPw4CMoQ49S9+BlufEkKww1bk1cRGlQgc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B2unY3P1Ev+3MEu1wzhdmnkmxPWPzmeaCgsKDGzdoet2ZOQZA1bfKuItBdjdoi8r4omFr9wbHXUen6q8h3YBxnIlyeeNHyEKf8QYmVIsUUj2ZGsOjr2ZfLWN3wTOktpOpteDfLqIjSC7vrQHaN+AaZdU65jyEQkUCFqx3QWZsB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nz9aU/21; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B3C7C4CEDF;
	Tue, 17 Dec 2024 19:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734464767;
	bh=wyJiG/rLnKAPw4CMoQ49S9+BlufEkKww1bk1cRGlQgc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nz9aU/21W2PnkUQQf6L9uWtVyRD+Mvw7yeG+vWC61KvhO08g7eNSiDMDUb3wU1RUa
	 IqQ/Mw6EmU/ifaqTLQ8GeATycTqsfPiuV3tZ8LJNOyBjPmut7M7Ar4uejqAjM61Gi8
	 +wX1yC5n+k+P2cZ6PjHAMwWW887hfb9ANnKpE3V1t4nNR/uAjWq38tn+sICcodwqbp
	 hhWfbZovz1S0ir0FoZsOFRtvyk1IaegmlElV4MI9qjeva3+yot1pNwgwbZN88YZirN
	 yOq3BAfurMud0MUx+YvH6YTji4sg0d/L/lPEdKItVKfOMlbhvXKUP1Rc1sFcfq2Ucb
	 pesNTi7eDaqfA==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-29fc424237bso2535102fac.0;
        Tue, 17 Dec 2024 11:46:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU3SoWfFelkm2alnLrE9B+6XDrZjaMqKChTYQPF/oik7nS4bIc4O9OMn8O5218/K7xFeYIqrr9u0ms=@vger.kernel.org, AJvYcCUfbR+PZ5xOgAqHJYBhLkBIZVtYivlJuc/8HZ9d6y92RNKlPi+buPvP0Z2xOF37Wb32a5Gv9yCEZ549E7w=@vger.kernel.org, AJvYcCUijXRVX3wbVSrq+r2X9GqvFibANY0eXZKqWDA8lPb8YvlMUjsuRoZMMcJd9Y0NagZKgQYK1Zhr4IGz@vger.kernel.org
X-Gm-Message-State: AOJu0YyzdIoeK+gyOi0PEzWWswjXCNvLNtvNAteXa9hR2X9cReqvCPsI
	ofIMPeh94ET0MnITKUnKdho1N+xP5VvzXnYvig41yqP4P4pAOYmKbWWKElR/mk2kW/JdA4peBxl
	KMJ4Qi7T11yRvMCSdORj+Fb4H1kU=
X-Google-Smtp-Source: AGHT+IEJN65jnqoUm5qKhxy6agNk8T9r7w4H2Q+RaZ1R8d53sbh1tSUPnZ90YzUfvrdsz7qclSKbPLHvNXiMBqJfdSA=
X-Received: by 2002:a05:6871:5b2a:b0:287:471:41eb with SMTP id
 586e51a60fabf-2a7b2ff375bmr54024fac.6.1734464766657; Tue, 17 Dec 2024
 11:46:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <13662231.uLZWGnKmhe@rjwysocki.net> <CAPDyKFrxEjHFB6B2r7JbryYY6=E4CxX_xTmLDqO6+26E+ULz6A@mail.gmail.com>
 <20241212151354.GA7708@lst.de> <CAJZ5v0gUpDw_NjTDtHGCUnKK0C+x0nrW6mP0tHQoXsgwR2RH8g@mail.gmail.com>
 <20241214063023.4tdvjbqd2lrylb7o@thinkpad> <CAJZ5v0gLMx+tBo+MA3AQZ7qP28Z91d04oVBHVeTNcd-QD=kJZg@mail.gmail.com>
 <20241216171108.6ssulem3276rkycb@thinkpad> <CAJZ5v0j+4xjSOOy8TYE0pBuqd_GdQa683Qq0GEyJ9WAFad9Z=A@mail.gmail.com>
 <20241216175210.mnc5kp6646sq7vzm@thinkpad> <CAJZ5v0grRdTYaamSnKSF-HyMmCHDEZ4haLo+ziSBxhDg1PbjRQ@mail.gmail.com>
 <20241217052632.lbncjto5xibdkc4c@thinkpad>
In-Reply-To: <20241217052632.lbncjto5xibdkc4c@thinkpad>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 17 Dec 2024 20:45:55 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gjrBUgejwBz1vv6P83oZiYu8AuDMs47ZAFJoNhMaMdpQ@mail.gmail.com>
Message-ID: <CAJZ5v0gjrBUgejwBz1vv6P83oZiYu8AuDMs47ZAFJoNhMaMdpQ@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: Shutdown the device if D3Cold is allowed by the user
To: manivannan.sadhasivam@linaro.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Christoph Hellwig <hch@lst.de>, Ulf Hansson <ulf.hansson@linaro.org>, 
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, Bjorn Helgaas <helgaas@kernel.org>, kbusch@kernel.org, 
	axboe@kernel.dk, sagi@grimberg.me, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, andersson@kernel.org, 
	konradybcio@kernel.org, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 6:26=E2=80=AFAM <manivannan.sadhasivam@linaro.org> =
wrote:
>
> On Mon, Dec 16, 2024 at 08:34:24PM +0100, Rafael J. Wysocki wrote:
>
> [...]
>
> > > There is also a case where some devices like
> > > (Laptops made out of Qcom SCX Gen3 SoCs) require all the PCIe devices=
 to be
> > > powered down in order for the SoC to reach its low power state (CX po=
wer
> > > collapse in Qcom terms). If not, the SoC would continue to draw more =
power
> > > leading to battery draining quickly. This platform is supported in up=
stream and
> > > we keep the PCIe interconnect voted during suspend as the NVMe driver=
 is
> > > expecting the device to retain its state during resume. Because of th=
is
> > > requirement, this platform is not reaching SoC level low power state =
with
> > > upstream kernel.
> >
> > OK, now all of this makes sense and that's why you really want NVMe
> > devices to end up in some form of PCI D3 in suspend-to-idle.
> >
> > Would D3hot be sufficient for this platform or does it need to be
> > D3cold?  If the latter, what exactly is the method by which they are
> > put into D3cold?
> >
>
> D3Cold is what preferred. Earlier the controller driver used to transitio=
n the
> device into D3Cold by sending PME_Turn_Off, turning off refclk, regulator=
s
> etc... Now we have a new framework called 'pwrctrl' that handles the
> clock/regulators supplied to the device. So both controller and pwrctrl d=
rivers
> need to work in a tandem to put the device into D3Cold.
>
> Once the PCIe client driver (NVMe in this case) powers down the device, t=
hen
> controller/pwrctrl drivers will check the PCIe device state and transitio=
n the
> device into D3Cold. This is a TODO btw.
>
> But right now there is no generic D3Cold handling available for DT platfo=
rms. I
> am hoping to fix that too once this NVMe issue is handled.

There's no generic D3cold handling for PCIe devices at all AFAICS.  At
least, I'm not aware of any standard way to do it.  Yes, there are
vendor-specific conventions that may even be followed by multiple
vendors, but not much beyond that.

> > > > > > > If the platform is using DT, then there is no entity setting
> > > > > > > pm_set_suspend_via_firmware().
> > > > > >
> > > > > > That's true and so the assumption is that in this case the hand=
ling of
> > > > > > all devices will always be the same regardless of which flavor =
of
> > > > > > system suspend is chosen by user space.
> > > > > >
> > > > >
> > > > > Right and that's why the above concern is raised.
> > > >
> > > > And it is still unclear to me what the problem with it is.
> > > >
> > > > What exactly can go wrong?
> > > >
> > > > > > > So NVMe will be kept in low power state all the
> > > > > > > time (still draining the battery).
> > > > > >
> > > > > > So what would be the problem with powering it down unconditiona=
lly?
> > > > > >
> > > > >
> > > > > I'm not sure how would you do that (by checking dev_of_node()?). =
Even so, it
> > > > > will wear out the NVMe devices if used in Android tablets etc...
> > > >
> > > > I understand the wear-out concern.
> > > >
> > > > Is there anything else?
> > > >
> > >
> > > No, that's the only concern.
> >
> > OK
> >
> > I think we're getting to the bottom of the issue.
> >
> > First off, there really is no requirement to avoid putting PCI devices
> > into D3hot or D3cold during suspend-to-idle.  On all modern Intel
> > platforms, PCIe devices are put into D3(hot or cold) during
> > suspend-to-idle and I don't see why this should be any different on
> > platforms from any other vendors.
> >
> > The NVMe driver is an exception and it avoids D3(hot or cold) during
> > suspend-to-idle because of problems with some hardware or platforms.
> > It might in principle allow devices to go into D3(hot or cold) during
> > suspend-to-idle, so long as it knows that this is going to work.
> >
>
> Slight correction here.
>
> NVMe driver avoids PCI PM _only_ when it wants to handle the NVMe power
> state on its own, not all the time. It has some checks [1] in the suspend=
 path
> and if the platform/device passes one of the checks, it will power down t=
he
> device.

Yes, there is a comment in that code explaining what's going on and
that is basically "if key ingredients are missing or the firmware is
going to do its thing anyway, don't bother".

> DT platforms doesn't pass any of the checks, so the NVMe driver always ma=
nages
> the power state on its own. Unfortunately, the resultant power saving is =
not
> enough, so the vendors (Laptop/Automotive) using DT want NVMe to be power=
ed down
> all the time. This is the first problem we are trying to solve.
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/drivers/nvme/host/pci.c#n3448

I see.

This cannot be done by the driver itself, though, at least not in
general.  The PCI layer needs to be involved and, if we are talking
about D3cold, the platform firmware needs to be involved either.

As a rule, the PCI layer reaches out to the platform firmware for help
as needed and drivers don't take part in this directly.

The NVMe driver would need to let the PCI layer take over and set the
PCI power state of the device if it wanted to get any deeper than NVMe
protocol specific power states.

In principle, this can be addressed with some kind of a driver opt-in.
That is, the NVMe driver would continue to work the way it does, but
instead of completely preventing the PCI layer from taking over, it
would opt in (the exact opt-in mechanism is TBD) for D3cold if (a) the
platform firmware provides a mechanism to do so and (b) the DT
indicates that this mechanism should be used for the given device.

> > However, there is an additional concern that putting an NVMe device
> > into D3cold every time during system suspend on Android might cause it
> > to wear out more quickly.
> >
>
> Right, this is the second problem.

Let's set this one somewhat aside for now.  We'll get back to it when
we have clarity in the above.

> > Is there anything else?
>
> We also need to consider the fact that the firmware in some platforms doe=
sn't
> support S2R. So we cannot take a decision based on S2I/S2R alone.

Right, the S2I/S2R thing is ACPI-specific.

On platforms using ACPI, pm_suspend_via_firmware() means that the
firmware is at least likely to power down the whole platform, so the
PCI layer may as well be allowed to do what it wants with the device.

> I think there are atleast a couple of ways to solve above mentioned probl=
ems:
>
> 1. Go extra mile, take account of all issues/limitations mentioned above =
and
> come up with an API. This API will provide a sane default suspend behavio=
r to
> drivers (fixing first problem) and will also allow changing the behavior
> dynamically (to fix the second problem where kernel cannot distinguish An=
droid
> vs other OS).

I don't quite follow TBH.

A "default suspend behavior" is there already and it is to allow the
PCI layer to set the device's power state (in collaboration with the
platform firmware).  Thing is, the NVMe driver doesn't always want to
rely on it.

> 2. Allow DT platforms to call pm_set_suspend_via_firmware() and make use =
of the
> existing behavior in the NVMe driver. This would only solve the first pro=
blem
> though. But would be a good start.

That would mean just letting the PCI layer always take over on the
platforms that would call pm_set_suspend_via_firmware().

There is a potential issue with doing it, which is that everybody
calling pm_suspend_via_firmware() would then assume that the platform
would be powered down by the firmware.  I'm not sure how much of an
issue that would be in practice, though.

