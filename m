Return-Path: <linux-pci+bounces-18565-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B71A9F39EF
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 20:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EDB0161658
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 19:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6447A206263;
	Mon, 16 Dec 2024 19:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DKK4U5Bg"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357D777111;
	Mon, 16 Dec 2024 19:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734377677; cv=none; b=feQXzjLYWcsJv9saLS1sqiQsBHbGLfKDVtpqWTHKjiw9V/tWTC+2s5PVHI/qJVO/a2OSZiELCfZieOeAdsEYKUwZz5Ck/P95Kdgz0K0wogBLapl3R0sPQdFXIM5ya6XMqSdZsLWMakHbyAb7nmkDvMG+r1XZDZ9l+/3ahUDOODw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734377677; c=relaxed/simple;
	bh=AbSwzQeSAAwSlPBzlMhf9FunRjlq1c0ocCOPV62VjNI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YEL2mkdsiqCxwveZVZ82vICBpJMFlVAeYcNIOlKMBqRl0U46rpo6uY0tCaO3nQLFmL82oJUNcqBfi5M8SHaQR6I8IaBdaQOzZhdvfE8XYT/5INlRGv9xP006/D13yG6J6t2yv/S5f36M0aFqxY6FT5DAOkdVFtfDIYM4Eydigsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DKK4U5Bg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B290DC4CEDF;
	Mon, 16 Dec 2024 19:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734377676;
	bh=AbSwzQeSAAwSlPBzlMhf9FunRjlq1c0ocCOPV62VjNI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DKK4U5BguR4BDjrZUP1SCauViHJZ2t9XEZhiaOBnS0XFo7qBsxqxHubDwtJzdH6hq
	 02qnmNyfPcbWiqnsI2Euf+aMaDjFTD2j5WnlZq7/LyQs1ae/9SeMjWIrtykNzhniAn
	 /y+QVErCQmq+hZT/Mq3cmLW/hQyBxRR6i5JfZaeUDq5vBD2WUCpiKtVS4eLw5skDYO
	 PYVPWABWZYg0pqVsZU0a2r+3xkAPuwd9o2YMrkTi9IR0gvemBo8TCT8zTHWpXIFaOV
	 SWsY1Ppqdw2+1iwWywgMvcA6RvcTkFBcRd9yQZI3o3PajYaGfCcsYMjnHtJkyiST6v
	 Xgnxf29Rokqjg==
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-71e2bb84fe3so2154297a34.1;
        Mon, 16 Dec 2024 11:34:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVgkDD/TrI3KgC3u0IPtBTHteI3ffNRBWBQdqgnvr5tfr8r6N7htOg7wWIhE/lLPtmECBzNY9AYHEU=@vger.kernel.org, AJvYcCW2eJV1XWzwh2piPoqLtzU2r1rOFqk9QljLGblqSDBoau8wx1VIbtIlggIoJ28AePQ4X0KGL+p6e3Ec@vger.kernel.org, AJvYcCXJXEGMQRg4pbVDc99WO75V3SqQ9QVKWeVq/Q1XpDsDeCVECN6DldNvwtzBbAjFQaBebalq4lb9sZKU+Uc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOgod3aKAaaszGcn/WeLocwJKc4FIUj5Xhh05cXX/2OmKB0Ih0
	XajYMraA7n2Ufn7IW2qE370JSfmgd8vz1NEzaUrOx6M4V7NKfBRt1OP1WpHfQ77nf61diGJq8k+
	mmsnEoIICuL60L5cwntil+2XKeYo=
X-Google-Smtp-Source: AGHT+IE0wpa+7kxEMfC5+J2Oi9KVNNrXTpOtVC/OkvKGxKPPvYOjGQeDw7sEgCsP07TGUrQWRL2YirlTvycMfVLtUBE=
X-Received: by 2002:a05:6808:3c47:b0:3e7:eda5:6b06 with SMTP id
 5614622812f47-3eba6988131mr9167034b6e.35.1734377675891; Mon, 16 Dec 2024
 11:34:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209143821.m4dahsaqeydluyf3@thinkpad> <20241212055920.GB4825@lst.de>
 <13662231.uLZWGnKmhe@rjwysocki.net> <CAPDyKFrxEjHFB6B2r7JbryYY6=E4CxX_xTmLDqO6+26E+ULz6A@mail.gmail.com>
 <20241212151354.GA7708@lst.de> <CAJZ5v0gUpDw_NjTDtHGCUnKK0C+x0nrW6mP0tHQoXsgwR2RH8g@mail.gmail.com>
 <20241214063023.4tdvjbqd2lrylb7o@thinkpad> <CAJZ5v0gLMx+tBo+MA3AQZ7qP28Z91d04oVBHVeTNcd-QD=kJZg@mail.gmail.com>
 <20241216171108.6ssulem3276rkycb@thinkpad> <CAJZ5v0j+4xjSOOy8TYE0pBuqd_GdQa683Qq0GEyJ9WAFad9Z=A@mail.gmail.com>
 <20241216175210.mnc5kp6646sq7vzm@thinkpad>
In-Reply-To: <20241216175210.mnc5kp6646sq7vzm@thinkpad>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 16 Dec 2024 20:34:24 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0grRdTYaamSnKSF-HyMmCHDEZ4haLo+ziSBxhDg1PbjRQ@mail.gmail.com>
Message-ID: <CAJZ5v0grRdTYaamSnKSF-HyMmCHDEZ4haLo+ziSBxhDg1PbjRQ@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: Shutdown the device if D3Cold is allowed by the user
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Christoph Hellwig <hch@lst.de>, Ulf Hansson <ulf.hansson@linaro.org>, 
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, Bjorn Helgaas <helgaas@kernel.org>, kbusch@kernel.org, 
	axboe@kernel.dk, sagi@grimberg.me, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, andersson@kernel.org, 
	konradybcio@kernel.org, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 6:52=E2=80=AFPM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Mon, Dec 16, 2024 at 06:35:52PM +0100, Rafael J. Wysocki wrote:
> > On Mon, Dec 16, 2024 at 6:11=E2=80=AFPM Manivannan Sadhasivam
> > <manivannan.sadhasivam@linaro.org> wrote:
> > >
> > > On Mon, Dec 16, 2024 at 05:24:40PM +0100, Rafael J. Wysocki wrote:
> > > > On Sat, Dec 14, 2024 at 7:30=E2=80=AFAM Manivannan Sadhasivam
> > > > <manivannan.sadhasivam@linaro.org> wrote:
> > > > >
> > > > > On Fri, Dec 13, 2024 at 03:35:15PM +0100, Rafael J. Wysocki wrote=
:
> > > > > > On Thu, Dec 12, 2024 at 4:14=E2=80=AFPM Christoph Hellwig <hch@=
lst.de> wrote:
> > > > > > >
> > > > > > > On Thu, Dec 12, 2024 at 01:49:15PM +0100, Ulf Hansson wrote:
> > > > > > > > Right. This seems to somewhat work for ACPI types of system=
s, because
> > > > > > > > ACPI is controlling the low power state for all the devices=
. Based on
> > > > > > > > the requested system wide low power state, ACPI can then de=
cide to
> > > > > > > > call pm_set_suspend_via_firmware() or not.
> > > > > > > >
> > > > > > > > Still there is a problem with this for ACPI too.
> > > > > > > >
> > > > > > > > How does ACPI know whether it's actually a good idea to kee=
p the NVMe
> > > > > > > > storage powered in s2idle (ACPI calls pm_set_suspend_via_fi=
rmware()
> > > > > > > > only for S2R and S2disk!?)? Especially when my laptop only =
supports
> > > > > > > > s2idle and that's what I will use when I close the lid. In =
this way,
> > > > > > > > the NMVe storage will certainly contribute to draining the =
battery,
> > > > > > > > especially when I won't be using my laptop for a couple of =
days.
> > > > > > > >
> > > > > > > > In my opinion, we need a better approach that is both flexi=
ble and
> > > > > > > > that dynamically adjusts based upon the use case.
> > > > > > >
> > > > > > > Agreed.  I'd be happy to work with the PM maintainers to do t=
his,
> > > > > > > but I don't really know enough about the PM core to drive it
> > > > > > > (as the reply from Rafael to my mail makes pretty clear :))
> > > > > >
> > > > > > I'm here to help.
> > > > > >
> > > > > > Let me know what exactly you want to achieve and we'll see how =
to make it work.
> > > > >
> > > > > I'll try to summarize the requirement here since I started this t=
hread:
> > > > >
> > > > > Problem statement
> > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > >
> > > > > We need a PM core API that tells the device drivers when it is sa=
fe to powerdown
> > > > > the devices. The usecase here is with PCIe based NVMe devices but=
 the problem is
> > > > > applicable to other devices as well.
> > > > >
> > > > > Drivers are relying on couple of options now:
> > > > >
> > > > > 1. If pm_suspend_via_firmware() returns true, then drivers will s=
hutdown the
> > > > > device assuming that the firmware is going to handle the suspend.=
 But this API
> > > > > is currently used only by ACPI. Even there, ACPI relies on S2R be=
ing supported
> > > > > by the platform and it sets pm_set_suspend_via_firmware() only wh=
en the suspend
> > > > > is S2R. But if the platform doesn't support S2R (current case of =
most of the
> > > > > Qcom SoCs), then pm_suspend_via_firmware() will return false and =
NVMe won't be
> > > > > powered down draining the battery.
> > > >
> > > > So my question here would be why is it not powered down always duri=
ng
> > > > system-wide suspend?
> > > >
> > > > Why exactly is it necessary to distinguish one case from the other
> > > > (assuming that we are talking about system-wide suspend only)?
> > > >
> > >
> > > To support Android like usecase with firmware that only supports
> > > suspend-to-idle (Qcom platforms). This usecase is not applicable righ=
t now, but
> > > one can't just rule out the possibility in the near future.
> >
> > This doesn't explain anything to me, sorry.
> >
> > > And the problem is that we need to support both Android and non-Andro=
id systems
> > > with same firmware :/
> >
> > So what technically is the problem?
> >
>
> NVMe wear out is the problem.
>
> > > > There are drivers that use pm_suspend_via_firmware() to check wheth=
er
> > > > or not something special needs to be done to the device because if
> > > > "false" is returned, the platform firmware is not going to remove
> > > > power from it.
> > > >
> > > > However, you seem to be talking about the opposite, so doing someth=
ing
> > > > special to the device if "true" is returned.  I'm not sure why this=
 is
> > > > necessary.
> > > >
> > >
> > > Because, since 'false' is returned, drivers like NVMe are assuming th=
at the
> > > platform won't remove power on all DT systems and they just keep the =
devices in
> > > low power state (not powering them down). But why would I want my NVM=
e in DT
> > > based laptop to be always powered in system suspend?
> >
> > Because it causes the system to use less energy when suspended.
> >
>
> But the NVMe driver would be still operational. Powering it down would ca=
use the
> system to use much less energy.

Yes, that's what I wanted to say, sorry for the confusion.

IIRC, there are two reasons why the NVMe driver does this:
(1) On some platforms the devices handled by it couldn't come back
from D3cold without platform firmware's help.
(2) Putting devices into D3hot alone was not sufficient to reduce
their power sufficiently and it didn't make much difference on top of
the other things done to them for this purpose.

 It avoids putting devices into D3cold (or even into D3hot for that
matter) because of the above, not because it is generally required to
do so in suspend-to-idle.  So this really is exceptional behavior and
not following a rule of some kind.

> There is also a case where some devices like
> (Laptops made out of Qcom SCX Gen3 SoCs) require all the PCIe devices to =
be
> powered down in order for the SoC to reach its low power state (CX power
> collapse in Qcom terms). If not, the SoC would continue to draw more powe=
r
> leading to battery draining quickly. This platform is supported in upstre=
am and
> we keep the PCIe interconnect voted during suspend as the NVMe driver is
> expecting the device to retain its state during resume. Because of this
> requirement, this platform is not reaching SoC level low power state with
> upstream kernel.

OK, now all of this makes sense and that's why you really want NVMe
devices to end up in some form of PCI D3 in suspend-to-idle.

Would D3hot be sufficient for this platform or does it need to be
D3cold?  If the latter, what exactly is the method by which they are
put into D3cold?

> > > > > If the platform is using DT, then there is no entity setting
> > > > > pm_set_suspend_via_firmware().
> > > >
> > > > That's true and so the assumption is that in this case the handling=
 of
> > > > all devices will always be the same regardless of which flavor of
> > > > system suspend is chosen by user space.
> > > >
> > >
> > > Right and that's why the above concern is raised.
> >
> > And it is still unclear to me what the problem with it is.
> >
> > What exactly can go wrong?
> >
> > > > > So NVMe will be kept in low power state all the
> > > > > time (still draining the battery).
> > > >
> > > > So what would be the problem with powering it down unconditionally?
> > > >
> > >
> > > I'm not sure how would you do that (by checking dev_of_node()?). Even=
 so, it
> > > will wear out the NVMe devices if used in Android tablets etc...
> >
> > I understand the wear-out concern.
> >
> > Is there anything else?
> >
>
> No, that's the only concern.

OK

I think we're getting to the bottom of the issue.

First off, there really is no requirement to avoid putting PCI devices
into D3hot or D3cold during suspend-to-idle.  On all modern Intel
platforms, PCIe devices are put into D3(hot or cold) during
suspend-to-idle and I don't see why this should be any different on
platforms from any other vendors.

The NVMe driver is an exception and it avoids D3(hot or cold) during
suspend-to-idle because of problems with some hardware or platforms.
It might in principle allow devices to go into D3(hot or cold) during
suspend-to-idle, so long as it knows that this is going to work.

However, there is an additional concern that putting an NVMe device
into D3cold every time during system suspend on Android might cause it
to wear out more quickly.

Is there anything else?

