Return-Path: <linux-pci+bounces-18532-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0BE9F37AB
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 18:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30D5C188C09D
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 17:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFBD2066F2;
	Mon, 16 Dec 2024 17:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J6DYUyFK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016D32063EA;
	Mon, 16 Dec 2024 17:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734370566; cv=none; b=XlwsaKswuQE2gCd/6x18dG2V+4VeZAgM710BYhcSHKEEOvNt1SCIcr5/MZoBzmqwfW2PFFroZcIX0zV8jvzplDfIYk9fIktIniPCHPx65WndLRaNmiX09dBRl7G7WXN7c2bFf33sy+okveEh9TWxK3kuyPc9gFaAOZ9KBnM9D1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734370566; c=relaxed/simple;
	bh=mtdBMr7tNhTm5tnQKnSJQk8KV/APMU7FqSKGdW2EF1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cWrrPrXHxgBI84wdF9w66ggJrLRaSa4tQYXwdOGkM3BjQGgyQRFPdKJ1iSdxC5uE2a2iwlBMSaXz0kh1/KBXTLzpKMsDwtGAS2qbaqjkjU0hQEk3aIZrjwmLHO/dHBa4Jd5iR5IIjOWO5GCccukorClAe5CFGc2Xw5ci6Na1uj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J6DYUyFK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88BC0C4CEDD;
	Mon, 16 Dec 2024 17:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734370565;
	bh=mtdBMr7tNhTm5tnQKnSJQk8KV/APMU7FqSKGdW2EF1Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=J6DYUyFKwFmSuCeZ1G2ig/QZuqQ+PAsVvEhZV1Wqw9dbYvlrwOPoBkWMJmSV6Tlho
	 KL6iLGXsqaFMhlWwlhsWAfTS4CK7IO/d7rjlP9sy7GgsiUN1J5yI/IF0Tdt9ushVk+
	 GtewzCeIkSeroyFcxki/ia8oBoxFqJFVvW/33z0Xxk6shB5czkgtGu2CYoffjD6oIw
	 oepAktQRSBWLXws4R/Amjv1Lsw/WnJgPeD0Fyn2TFm88NBnfKLR9O8AFkiizzjrTWJ
	 dVJnev+an2Nr1TxmpJiwU+pfIkxpCrU3WALmCenn1NdZYiAflGtQOlmolO5XI5CC+1
	 veP3ALgWrnjmA==
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3eb7ca55c3bso2342322b6e.3;
        Mon, 16 Dec 2024 09:36:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUbXw1nDbzxSDFRo5FevG4p1qeBxOsglOTBYGutNuzFnPPHBnAGc+Qxf+Qm9CB2LkLn+Up/yBAckpIh@vger.kernel.org, AJvYcCVMxY+JgTi8zaObTTHiJtKsHFwwzxeR23JoKs9+Udm3SDtUvdo4hEZgNatkX01Jlfalk3n1NEt3ccg=@vger.kernel.org, AJvYcCX/8awacS/6Nqitf0hQAD0FHlrOc/Ok+3uwJdR/JRqgjAlC+B9K3G/xIWjW8rO4/3eFAPc6gEel8VNvoUg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMv2uL296gUELL0SB5IOGzXWEjiEzHoB48PCJw+2K62erA78ZE
	jKvDfgqokvwZ6REXaOeJoTkUTjkxHIIUh5AwwEVmSrZAodTh971JLSR/HEG7hSddAyok4Mh9jFq
	RxXKZxFagRHv1dm2G6Z5ImS1RzNk=
X-Google-Smtp-Source: AGHT+IEbVrASnafFcVFMGA0wT8oALyCI8rLtv4AL+WE3KAycZh/58Ko9EcvLePanwDOjC2JGlwrk2XQ8h15EvvUChSg=
X-Received: by 2002:a05:6808:201e:b0:3ea:f809:5c25 with SMTP id
 5614622812f47-3ebc9ef2cacmr383027b6e.43.1734370564848; Mon, 16 Dec 2024
 09:36:04 -0800 (PST)
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
 <20241214063023.4tdvjbqd2lrylb7o@thinkpad> <CAJZ5v0gLMx+tBo+MA3AQZ7qP28Z91d04oVBHVeTNcd-QD=kJZg@mail.gmail.com>
 <20241216171108.6ssulem3276rkycb@thinkpad>
In-Reply-To: <20241216171108.6ssulem3276rkycb@thinkpad>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 16 Dec 2024 18:35:52 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0j+4xjSOOy8TYE0pBuqd_GdQa683Qq0GEyJ9WAFad9Z=A@mail.gmail.com>
Message-ID: <CAJZ5v0j+4xjSOOy8TYE0pBuqd_GdQa683Qq0GEyJ9WAFad9Z=A@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: Shutdown the device if D3Cold is allowed by the user
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Christoph Hellwig <hch@lst.de>, Ulf Hansson <ulf.hansson@linaro.org>, 
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, Bjorn Helgaas <helgaas@kernel.org>, kbusch@kernel.org, 
	axboe@kernel.dk, sagi@grimberg.me, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, andersson@kernel.org, 
	konradybcio@kernel.org, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 6:11=E2=80=AFPM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Mon, Dec 16, 2024 at 05:24:40PM +0100, Rafael J. Wysocki wrote:
> > On Sat, Dec 14, 2024 at 7:30=E2=80=AFAM Manivannan Sadhasivam
> > <manivannan.sadhasivam@linaro.org> wrote:
> > >
> > > On Fri, Dec 13, 2024 at 03:35:15PM +0100, Rafael J. Wysocki wrote:
> > > > On Thu, Dec 12, 2024 at 4:14=E2=80=AFPM Christoph Hellwig <hch@lst.=
de> wrote:
> > > > >
> > > > > On Thu, Dec 12, 2024 at 01:49:15PM +0100, Ulf Hansson wrote:
> > > > > > Right. This seems to somewhat work for ACPI types of systems, b=
ecause
> > > > > > ACPI is controlling the low power state for all the devices. Ba=
sed on
> > > > > > the requested system wide low power state, ACPI can then decide=
 to
> > > > > > call pm_set_suspend_via_firmware() or not.
> > > > > >
> > > > > > Still there is a problem with this for ACPI too.
> > > > > >
> > > > > > How does ACPI know whether it's actually a good idea to keep th=
e NVMe
> > > > > > storage powered in s2idle (ACPI calls pm_set_suspend_via_firmwa=
re()
> > > > > > only for S2R and S2disk!?)? Especially when my laptop only supp=
orts
> > > > > > s2idle and that's what I will use when I close the lid. In this=
 way,
> > > > > > the NMVe storage will certainly contribute to draining the batt=
ery,
> > > > > > especially when I won't be using my laptop for a couple of days=
.
> > > > > >
> > > > > > In my opinion, we need a better approach that is both flexible =
and
> > > > > > that dynamically adjusts based upon the use case.
> > > > >
> > > > > Agreed.  I'd be happy to work with the PM maintainers to do this,
> > > > > but I don't really know enough about the PM core to drive it
> > > > > (as the reply from Rafael to my mail makes pretty clear :))
> > > >
> > > > I'm here to help.
> > > >
> > > > Let me know what exactly you want to achieve and we'll see how to m=
ake it work.
> > >
> > > I'll try to summarize the requirement here since I started this threa=
d:
> > >
> > > Problem statement
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > We need a PM core API that tells the device drivers when it is safe t=
o powerdown
> > > the devices. The usecase here is with PCIe based NVMe devices but the=
 problem is
> > > applicable to other devices as well.
> > >
> > > Drivers are relying on couple of options now:
> > >
> > > 1. If pm_suspend_via_firmware() returns true, then drivers will shutd=
own the
> > > device assuming that the firmware is going to handle the suspend. But=
 this API
> > > is currently used only by ACPI. Even there, ACPI relies on S2R being =
supported
> > > by the platform and it sets pm_set_suspend_via_firmware() only when t=
he suspend
> > > is S2R. But if the platform doesn't support S2R (current case of most=
 of the
> > > Qcom SoCs), then pm_suspend_via_firmware() will return false and NVMe=
 won't be
> > > powered down draining the battery.
> >
> > So my question here would be why is it not powered down always during
> > system-wide suspend?
> >
> > Why exactly is it necessary to distinguish one case from the other
> > (assuming that we are talking about system-wide suspend only)?
> >
>
> To support Android like usecase with firmware that only supports
> suspend-to-idle (Qcom platforms). This usecase is not applicable right no=
w, but
> one can't just rule out the possibility in the near future.

This doesn't explain anything to me, sorry.

> And the problem is that we need to support both Android and non-Android s=
ystems
> with same firmware :/

So what technically is the problem?

> > There are drivers that use pm_suspend_via_firmware() to check whether
> > or not something special needs to be done to the device because if
> > "false" is returned, the platform firmware is not going to remove
> > power from it.
> >
> > However, you seem to be talking about the opposite, so doing something
> > special to the device if "true" is returned.  I'm not sure why this is
> > necessary.
> >
>
> Because, since 'false' is returned, drivers like NVMe are assuming that t=
he
> platform won't remove power on all DT systems and they just keep the devi=
ces in
> low power state (not powering them down). But why would I want my NVMe in=
 DT
> based laptop to be always powered in system suspend?

Because it causes the system to use less energy when suspended.

> > > If the platform is using DT, then there is no entity setting
> > > pm_set_suspend_via_firmware().
> >
> > That's true and so the assumption is that in this case the handling of
> > all devices will always be the same regardless of which flavor of
> > system suspend is chosen by user space.
> >
>
> Right and that's why the above concern is raised.

And it is still unclear to me what the problem with it is.

What exactly can go wrong?

> > > So NVMe will be kept in low power state all the
> > > time (still draining the battery).
> >
> > So what would be the problem with powering it down unconditionally?
> >
>
> I'm not sure how would you do that (by checking dev_of_node()?). Even so,=
 it
> will wear out the NVMe devices if used in Android tablets etc...

I understand the wear-out concern.

Is there anything else?

> > > There were attempts to set this flag from
> > > PSCI [1], but there were objections on setting this flag when PSCI_SU=
SPEND is
> > > not supported by the platform (again, the case with Qcom SoCs). Even =
if this
> > > approach succeeds, then there are concerns that if the platform is us=
ed in an
> > > OS like Android where the S2Idle cycle is far more high, NVMe will we=
ar out
> > > very quickly.
> >
> > I see.
> >
> > > So this is where the forthcoming API need to "dynamically adjusts
> > > based upon the use case" as quoted by Ulf in his previous reply. One =
way to
> > > achieve would be by giving the flexibility to the userspace to choose=
 the
> > > suspend state (if platform has options to select). UFS does something=
 similar
> > > with 'spm_lvl' [2] sysfs attribute that I believe Android userspace i=
tself makes
> > > use of.
> >
> > Before we're talking about APIs, let's talk about the desired behavior.
> >
> > It looks like there are cases in which you'd want to turn the device
> > off completely (say put it into D3cold in the PCI terminology) and
> > there are cases in which you'd want it to stay in a somewhat-powered
> > low-power state.
> >
> > It is unclear to me what they are at this point.
> >
>
> I hope that my above explanation clarifies.

Sorry, but not really.

> Here is the short version of the suspend requirement across platforms:
>
> 1. D3Cold (power down) - Laptops/Automotive
> 2. D3hot (low power) - Android Tablets

Where do the above requirements come from?

> FWIW, I did receive feedback from people asking to just ignore the Androi=
d
> usecase and always power down the devices for DT platforms. But I happen =
to
> disagree with them. Let me know if I was wrong and I should not worry abo=
ut
> Android usecase as it is for the future.

I'm not sure what you mean by the "Android usecase" TBH.  Do you mean
the wear-out concern in the Android usage scenario or is there more to
it?

