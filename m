Return-Path: <linux-pci+bounces-18776-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 117329F7BC1
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 13:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ABCA16B170
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 12:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6DF22576B;
	Thu, 19 Dec 2024 12:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HRHyD/TX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC0D225772;
	Thu, 19 Dec 2024 12:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734612324; cv=none; b=pVIuYAKPB4IBKs4fT9y97tcfaFpZ5BBS1N5rgcS8UuR1NBXagDXh9Y/+ThtRK/wZeo74FqvASMPukiOgkN71ecbCNgr7JTuvo/7VhS+ZYs4gKXuoZiKgJ/J6idrhHYqlK+W/c/JivUzfedLsCN1CsChVCI9GoAufvgPnxfTc2mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734612324; c=relaxed/simple;
	bh=x3JS8aCc2Q11LU+IcSY8I2nCKgmDn7njV9SrGintQzs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JEhIMJqpNWccBdRzR1MnnQKhHGHMat/uO+WcWPUjP6t2aC8bbxQbZ3k7XYUvkuE+AqIxRCw9xhdKtqxB2C/Ec2KmAS3qGp6/lyL86qvPuZ0We2c3eGSQlnb6n4tU2Fmm1cmCghtIIWSR6IlArUl61hl6xQEcrPgvfsNzVKExRjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HRHyD/TX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C00DC4CEDE;
	Thu, 19 Dec 2024 12:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734612323;
	bh=x3JS8aCc2Q11LU+IcSY8I2nCKgmDn7njV9SrGintQzs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HRHyD/TXaVxW3p56YGLig2RcVLCQwWEqmgvErM06uCOEYzq4kZ4D8E0qoieDqaDAD
	 OLP4ruhyI/Q7GoBEPzxuUfAEvFmgUvd/wZzLquWR59s6wsUANvzx3lG0DDxMTbLfAb
	 hEATwu5JCVtlPD/Rxh0ZUavGnPXqstZGCkB3fMMZb6/wHjMiVrN9px0XWhiAxbGpoF
	 ucSc/LfTtRyr+oqAwBMh2z8yuPDzGEO+oNbBolVRR1UMjgpE0UTu9hWRCpIce6MbwY
	 iRqXqNqvp8OIR47BJYUsup3s5ET42Vsb/DIEyqmUc+4MPuo+i6t9Yo9a77x69+T7rG
	 hbS0N/Wl4fJ5A==
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-71e2851de95so200203a34.0;
        Thu, 19 Dec 2024 04:45:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWx1pHw5uQwUOrRpkUAWwCmeHkcr3ENik8kJtrIGj4fZ4tkidDmm5lEZ9g8qVRA+1D32UojAcWqtPI=@vger.kernel.org, AJvYcCX0KjDBSqrngvVDkq00fP265D62v1+hg/432AWNtCldEHUsB1Kp+pzUcG3bjuOWLodFor8k046ZSaU7BbQ=@vger.kernel.org, AJvYcCXKWNTuHHb2X4pj5i6DHSOtdi1JBsdAfNFM4jQ/ilMWE+txnv1fc0OD6F15Cdu6Gb50sLjB1ZEXzOZi@vger.kernel.org
X-Gm-Message-State: AOJu0YzDBZhwO7INJteoIMbTEAUVGVlhaETr+nUn8WdtMEV3K4Eam335
	qFwaykkIVEM1+5TyGVyf/rr1zR/nYkrDJdkvPiRBt1fUzTcvfOtdh4PUgdYocLyx5GDamjEg3Nc
	Vtzj4yXDFtJfURiPXuq/AlU5iumo=
X-Google-Smtp-Source: AGHT+IEDKEHBuKz6390+8Moake0xMPcF17blN3+Y0545ojCl9qr34Az6D9ScmJrtj3fr3rhdguuKQedER7YwrZglKBQ=
X-Received: by 2002:a05:6830:6a91:b0:71d:f068:1ff3 with SMTP id
 46e09a7af769-71fc4e685ddmr1746283a34.8.1734612322712; Thu, 19 Dec 2024
 04:45:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212151354.GA7708@lst.de> <CAJZ5v0gUpDw_NjTDtHGCUnKK0C+x0nrW6mP0tHQoXsgwR2RH8g@mail.gmail.com>
 <20241214063023.4tdvjbqd2lrylb7o@thinkpad> <CAJZ5v0gLMx+tBo+MA3AQZ7qP28Z91d04oVBHVeTNcd-QD=kJZg@mail.gmail.com>
 <20241216171108.6ssulem3276rkycb@thinkpad> <CAJZ5v0j+4xjSOOy8TYE0pBuqd_GdQa683Qq0GEyJ9WAFad9Z=A@mail.gmail.com>
 <20241216175210.mnc5kp6646sq7vzm@thinkpad> <CAJZ5v0grRdTYaamSnKSF-HyMmCHDEZ4haLo+ziSBxhDg1PbjRQ@mail.gmail.com>
 <20241217052632.lbncjto5xibdkc4c@thinkpad> <CAJZ5v0gjrBUgejwBz1vv6P83oZiYu8AuDMs47ZAFJoNhMaMdpQ@mail.gmail.com>
 <20241219080217.fr2ukr7sk4a7hfmo@thinkpad>
In-Reply-To: <20241219080217.fr2ukr7sk4a7hfmo@thinkpad>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 19 Dec 2024 13:45:11 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hByaAAaYGhAvstwtfa-JP6JRQCbWCZrTsRGWEHHyRKdA@mail.gmail.com>
Message-ID: <CAJZ5v0hByaAAaYGhAvstwtfa-JP6JRQCbWCZrTsRGWEHHyRKdA@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: Shutdown the device if D3Cold is allowed by the user
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Christoph Hellwig <hch@lst.de>, Ulf Hansson <ulf.hansson@linaro.org>, 
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, Bjorn Helgaas <helgaas@kernel.org>, kbusch@kernel.org, 
	axboe@kernel.dk, sagi@grimberg.me, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, andersson@kernel.org, 
	konradybcio@kernel.org, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2024 at 9:02=E2=80=AFAM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Tue, Dec 17, 2024 at 08:45:55PM +0100, Rafael J. Wysocki wrote:
> > On Tue, Dec 17, 2024 at 6:26=E2=80=AFAM <manivannan.sadhasivam@linaro.o=
rg> wrote:
> > >
> > > On Mon, Dec 16, 2024 at 08:34:24PM +0100, Rafael J. Wysocki wrote:
> > >
> > > [...]
> > >
> > > > > There is also a case where some devices like
> > > > > (Laptops made out of Qcom SCX Gen3 SoCs) require all the PCIe dev=
ices to be
> > > > > powered down in order for the SoC to reach its low power state (C=
X power
> > > > > collapse in Qcom terms). If not, the SoC would continue to draw m=
ore power
> > > > > leading to battery draining quickly. This platform is supported i=
n upstream and
> > > > > we keep the PCIe interconnect voted during suspend as the NVMe dr=
iver is
> > > > > expecting the device to retain its state during resume. Because o=
f this
> > > > > requirement, this platform is not reaching SoC level low power st=
ate with
> > > > > upstream kernel.
> > > >
> > > > OK, now all of this makes sense and that's why you really want NVMe
> > > > devices to end up in some form of PCI D3 in suspend-to-idle.
> > > >
> > > > Would D3hot be sufficient for this platform or does it need to be
> > > > D3cold?  If the latter, what exactly is the method by which they ar=
e
> > > > put into D3cold?
> > > >
> > >
> > > D3Cold is what preferred. Earlier the controller driver used to trans=
ition the
> > > device into D3Cold by sending PME_Turn_Off, turning off refclk, regul=
ators
> > > etc... Now we have a new framework called 'pwrctrl' that handles the
> > > clock/regulators supplied to the device. So both controller and pwrct=
rl drivers
> > > need to work in a tandem to put the device into D3Cold.
> > >
> > > Once the PCIe client driver (NVMe in this case) powers down the devic=
e, then
> > > controller/pwrctrl drivers will check the PCIe device state and trans=
ition the
> > > device into D3Cold. This is a TODO btw.
> > >
> > > But right now there is no generic D3Cold handling available for DT pl=
atforms. I
> > > am hoping to fix that too once this NVMe issue is handled.
> >
> > There's no generic D3cold handling for PCIe devices at all AFAICS.  At
> > least, I'm not aware of any standard way to do it.  Yes, there are
> > vendor-specific conventions that may even be followed by multiple
> > vendors, but not much beyond that.
> >
>
> Yeah, right. Atleast ACPI has its own way of handling D3Cold and that's w=
hat I
> meant.

Well, not so simple.

ACPI has a way to put devices into D3cold, but it is based on power
resources: If all of the ACPI power resources for state D3hot of the
given device are turned off, the device is assumed to have no power
which effectively means D3cold.

Now, this basically works for platform devices, but it doesn't work
particularly well for PCIe devices that get their power from the bus.

This is addressed by using a conventional approach that has not been
codified as a standard so far AFAICS.  The convention is to define a
D3hot power resource for the parent PCIe port of the device in
question and turn that power resource off when both the device and its
parent port have been programmed to go into D3hot (via PMCSR).  So the
flow is that the device goes into D3hot first.  Later, its parent port
goes into D3hot and then the D3hot power resource of the port is
turned off.  It usually doesn't really remove power from the port
(especially if this is a root port), but it turns down the PCIe link
from it to the device (in a platform-specific way) which effectively
cuts power from the device.

On the way back, the D3hot power resource of the port is turned on
first and this turns the PCIe link between the port and the device up.

> There is no such option available for DT right now. I was shoping that
> once this NVMe issue is resolved, then I could look into D3Cold for DT
> platforms.

Well, consider the above.

[cut]

> > > >
> > > > I think we're getting to the bottom of the issue.
> > > >
> > > > First off, there really is no requirement to avoid putting PCI devi=
ces
> > > > into D3hot or D3cold during suspend-to-idle.  On all modern Intel
> > > > platforms, PCIe devices are put into D3(hot or cold) during
> > > > suspend-to-idle and I don't see why this should be any different on
> > > > platforms from any other vendors.
> > > >
> > > > The NVMe driver is an exception and it avoids D3(hot or cold) durin=
g
> > > > suspend-to-idle because of problems with some hardware or platforms=
.
> > > > It might in principle allow devices to go into D3(hot or cold) duri=
ng
> > > > suspend-to-idle, so long as it knows that this is going to work.
> > > >
> > >
> > > Slight correction here.
> > >
> > > NVMe driver avoids PCI PM _only_ when it wants to handle the NVMe pow=
er
> > > state on its own, not all the time. It has some checks [1] in the sus=
pend path
> > > and if the platform/device passes one of the checks, it will power do=
wn the
> > > device.
> >
> > Yes, there is a comment in that code explaining what's going on and
> > that is basically "if key ingredients are missing or the firmware is
> > going to do its thing anyway, don't bother".
> >
> > > DT platforms doesn't pass any of the checks, so the NVMe driver alway=
s manages
> > > the power state on its own. Unfortunately, the resultant power saving=
 is not
> > > enough, so the vendors (Laptop/Automotive) using DT want NVMe to be p=
owered down
> > > all the time. This is the first problem we are trying to solve.
> > >
> > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t/tree/drivers/nvme/host/pci.c#n3448
> >
> > I see.
> >
> > This cannot be done by the driver itself, though, at least not in
> > general.  The PCI layer needs to be involved and, if we are talking
> > about D3cold, the platform firmware needs to be involved either.
> >
>
> Right, but the device driver needs to have some idea about what state PCI=
 core
> is going to choose for the device. I believe that's the purpose of
> pci_choose_state() API. More below...

This is not really straightforward as per the above.

The driver would effectively need to know if the device's parent port
would be put into D3cold and pci_choose_state() is only about the
device itself.

> > As a rule, the PCI layer reaches out to the platform firmware for help
> > as needed and drivers don't take part in this directly.
> >
> > The NVMe driver would need to let the PCI layer take over and set the
> > PCI power state of the device if it wanted to get any deeper than NVMe
> > protocol specific power states.
> >
> > In principle, this can be addressed with some kind of a driver opt-in.
> > That is, the NVMe driver would continue to work the way it does, but
> > instead of completely preventing the PCI layer from taking over, it
> > would opt in (the exact opt-in mechanism is TBD) for D3cold if (a) the
> > platform firmware provides a mechanism to do so and (b) the DT
> > indicates that this mechanism should be used for the given device.
> >
>
> Ok, IIUC you are talking about something like this?
>
>         static int nvme_suspend(struct device *dev)
>         {
>                 ...
>
>                 if (pm_suspend_via_firmware() || !ctrl->npss || ... ||
>                     pci_choose_state(pdev, PMSG_SUSPEND) =3D=3D PCI_D3col=
d)
>                         return nvme_disable_prepare_reset(ndev, true);
>
>                 /* continue using protocol specific low power state */
>
>                 ...
>         }
>
> Here, pci_choose_state() should tell the driver if the device should ente=
r
> D3Cold. ACPI already supports this API, now I need to add DT support (whi=
ch is
> not straightforward, but doable). Since this API is already exported, I t=
hink it
> makes perfect sense to use it here (and other drivers for similar usecase=
).

I didn't really think about using pci_choose_state() here, but it is
not unreasonable IMV.  It may in principle be extended to cover the
"port + device combo" approach described above.  I'd rather avoid
calling pci_choose_state() twice for the same device during one
transition (once in the driver and then in the PCI layer), but that
could be addressed by rearranging the code.

However, I thought about adding a way for the driver to effectively
say "I'm fine with putting this device into power state X so long as
you have an indication from the platform firmware that this is OK",
where X would be the deepest power state allowed by the driver.

The drawback of this is that the driver would not know whether or not
the device would go into state X upfront, so it would need to do its
own thing in case this doesn't happen.  In the NVMe driver case, this
would mean putting the device into a protocol low-power state before
returning from the suspend callback which may not be a bad idea
overall.

BTW, I'm wondering what could go wrong if the
pm_suspend_via_firmware() check were dropped from nvme_suspend()?  The
driver would do some extra work on systems with ACPI S3 support, but
would it actually break anything?  Does anybody know?  May be worth
trying ...

> > > > However, there is an additional concern that putting an NVMe device
> > > > into D3cold every time during system suspend on Android might cause=
 it
> > > > to wear out more quickly.
> > > >
> > >
> > > Right, this is the second problem.
> >
> > Let's set this one somewhat aside for now.  We'll get back to it when
> > we have clarity in the above.
> >
>
> Ok. I believe this could be addressed in pci_choose_state() itself if req=
uired.

Possibly.

Unrelated notice: I will be mostly offline starting tomorrow through
Jan 6, 2025 and responses may be slow during that time.

