Return-Path: <linux-pci+bounces-18786-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 119889F8024
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 17:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BB14164497
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 16:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85625226551;
	Thu, 19 Dec 2024 16:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U3PLoSlT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10F2225798
	for <linux-pci@vger.kernel.org>; Thu, 19 Dec 2024 16:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734626556; cv=none; b=Wz2dCqAIyuIwgROp1Fp+fwbudQXktKk/ch6i6p7WFHDmcpLmti17odOzvSElBiGYtJzRGggnmnbXwWXtll15PFIGEnAzTZvf/OFKU8SzSp4gLfEgDU98OkCYjz0vvsFN7ygfmD57LxxRXVDL3MfgtZPxRAWl4iszc/fHakOb8As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734626556; c=relaxed/simple;
	bh=4+2MbWXTLDuW300kM9oDJmqk6YTJDVPl25JtfhnApVQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cv1c5afRQ5kSSaaseG6/hpMxAj5dBsw3eVXF4ObUhIyWT7HiX7FW9yr21JJH9HSPGojPIjUhBRdFujx7Kzxz4MwrLcOb1P58+B82qbWan9Ge3URCNl7d4UadAJUx50HReMoChOGTE1/O+gf6aNLgLP+T0IEyvrDE4dep6JqVrzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U3PLoSlT; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6ef66a7ac14so21141437b3.0
        for <linux-pci@vger.kernel.org>; Thu, 19 Dec 2024 08:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734626553; x=1735231353; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aN9R4Ho7CMfSjQSJU3b8ryQQC0vctVzUU9BCCfcwEmE=;
        b=U3PLoSlTz+dZeV8H/OsH4nfCWM/RC7qxGOYDDPYtW1GOrBwf7um8lDVXUsUdno8TcV
         y5n51YC74SLzzGXgRKmylYOL0kPsSi9daWMXMix6KoLopobuY35EPCtzgXFLhveRpnS0
         xrxPG0HSVrV4bCN5eAw2qaBkmpgD6n/AApCHb1NNTVRcpX4xV0WBxOFcP5ZSto5ays8m
         AA3qx75qihAp4/DU/JAe2JJ9ouwA0h2zn49yEW+b30cR1Ynqho9ja9rJAn9tFUSzKDWC
         I1IzugcFjEiIidSD1h2EdpmMku1WupBlO+JZd4h++qM6YfViEyShtIbgES4pCKIjd2Ef
         d7kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734626553; x=1735231353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aN9R4Ho7CMfSjQSJU3b8ryQQC0vctVzUU9BCCfcwEmE=;
        b=bNhMPSNrX53v4QA0Eh8+dPHvtyDBhDC0otyRaXlmr99DTJ2pqwAxFoSunriZFQwdNG
         StywvsRTJ2Ch4DwCUUzLWY8xhb+0qfgJpM19X4ndyB1mCGiY7vlAufmU6sRke8SCDqYy
         /ca8z6UK6yZq3/CkqdVJTGD5bCEY/BJtgmSbNSTGcvOkHZjyqAXI1ofTo8bxewSHs5RB
         t+Y/7kdz0LTY0OceIAFbjUQr7LrEEfOLrHLNxKYNAitvwXkrD7T09qg4MKFedfGYM2sq
         eoUG5YQtYiBObDmuO2wgzQ1jxWHTknVqwohyho4UIM5+0HvGnIWlToKK8seJcZ25M2m7
         Nz7g==
X-Forwarded-Encrypted: i=1; AJvYcCUAXcqO7MyOGNpldtj9iKC2dJSKZbL6LfojLVPqsL41SagFRbiC7//YZ2kmIzj/HjJc8L8PZvruBfM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsJmtDKMRyYGySfwakSUSbtIxaurmW99gWnh9nc6TS6pmt90Rn
	5v/uQPMUdCUSuqRoO8Kx0CZ4fBay4kTHyVZrT4u3kYQ/idx+eOdFy8gA+cuK2xdS35U4yuEJgKm
	L036WehjNwmkOv2sj4XE3LzuZevd8QGHPU0NYjA==
X-Gm-Gg: ASbGncuB4padlcAqNTpWqCJeOocQ8B2todMZcMepjP6Ke6Lwa68AUMnO/MzpeZi1OcC
	cdn5n+Ouhb3PbBcf678CIhcj7ie4GM/ElcUv0BdU=
X-Google-Smtp-Source: AGHT+IF5KATZAWGgPbMMAlYzdkenHUmfZ1YjUynCYtdBojAeGI8W4V/K3rTvXEVrPfIYBteiodOM2DMDyTh9CidFkHs=
X-Received: by 2002:a05:690c:9a8b:b0:6ef:e572:cd6f with SMTP id
 00721157ae682-6f3e2a87259mr35303837b3.7.1734626552569; Thu, 19 Dec 2024
 08:42:32 -0800 (PST)
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
 <20241219080217.fr2ukr7sk4a7hfmo@thinkpad> <CAJZ5v0hByaAAaYGhAvstwtfa-JP6JRQCbWCZrTsRGWEHHyRKdA@mail.gmail.com>
In-Reply-To: <CAJZ5v0hByaAAaYGhAvstwtfa-JP6JRQCbWCZrTsRGWEHHyRKdA@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 19 Dec 2024 17:41:56 +0100
Message-ID: <CAPDyKFqc+YuAyV-120Vvg7HOkhgnJ=wM53LAHTkJ6Gg5=rJumA@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: Shutdown the device if D3Cold is allowed by the user
To: Christoph Hellwig <hch@lst.de>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Bjorn Helgaas <helgaas@kernel.org>, kbusch@kernel.org, 
	axboe@kernel.dk, sagi@grimberg.me, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, andersson@kernel.org, 
	konradybcio@kernel.org, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 19 Dec 2024 at 13:45, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Dec 19, 2024 at 9:02=E2=80=AFAM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > On Tue, Dec 17, 2024 at 08:45:55PM +0100, Rafael J. Wysocki wrote:
> > > On Tue, Dec 17, 2024 at 6:26=E2=80=AFAM <manivannan.sadhasivam@linaro=
.org> wrote:
> > > >
> > > > On Mon, Dec 16, 2024 at 08:34:24PM +0100, Rafael J. Wysocki wrote:
> > > >
> > > > [...]
> > > >
> > > > > > There is also a case where some devices like
> > > > > > (Laptops made out of Qcom SCX Gen3 SoCs) require all the PCIe d=
evices to be
> > > > > > powered down in order for the SoC to reach its low power state =
(CX power
> > > > > > collapse in Qcom terms). If not, the SoC would continue to draw=
 more power
> > > > > > leading to battery draining quickly. This platform is supported=
 in upstream and
> > > > > > we keep the PCIe interconnect voted during suspend as the NVMe =
driver is
> > > > > > expecting the device to retain its state during resume. Because=
 of this
> > > > > > requirement, this platform is not reaching SoC level low power =
state with
> > > > > > upstream kernel.
> > > > >
> > > > > OK, now all of this makes sense and that's why you really want NV=
Me
> > > > > devices to end up in some form of PCI D3 in suspend-to-idle.
> > > > >
> > > > > Would D3hot be sufficient for this platform or does it need to be
> > > > > D3cold?  If the latter, what exactly is the method by which they =
are
> > > > > put into D3cold?
> > > > >
> > > >
> > > > D3Cold is what preferred. Earlier the controller driver used to tra=
nsition the
> > > > device into D3Cold by sending PME_Turn_Off, turning off refclk, reg=
ulators
> > > > etc... Now we have a new framework called 'pwrctrl' that handles th=
e
> > > > clock/regulators supplied to the device. So both controller and pwr=
ctrl drivers
> > > > need to work in a tandem to put the device into D3Cold.
> > > >
> > > > Once the PCIe client driver (NVMe in this case) powers down the dev=
ice, then
> > > > controller/pwrctrl drivers will check the PCIe device state and tra=
nsition the
> > > > device into D3Cold. This is a TODO btw.
> > > >
> > > > But right now there is no generic D3Cold handling available for DT =
platforms. I
> > > > am hoping to fix that too once this NVMe issue is handled.
> > >
> > > There's no generic D3cold handling for PCIe devices at all AFAICS.  A=
t
> > > least, I'm not aware of any standard way to do it.  Yes, there are
> > > vendor-specific conventions that may even be followed by multiple
> > > vendors, but not much beyond that.
> > >
> >
> > Yeah, right. Atleast ACPI has its own way of handling D3Cold and that's=
 what I
> > meant.
>
> Well, not so simple.
>
> ACPI has a way to put devices into D3cold, but it is based on power
> resources: If all of the ACPI power resources for state D3hot of the
> given device are turned off, the device is assumed to have no power
> which effectively means D3cold.
>
> Now, this basically works for platform devices, but it doesn't work
> particularly well for PCIe devices that get their power from the bus.
>
> This is addressed by using a conventional approach that has not been
> codified as a standard so far AFAICS.  The convention is to define a
> D3hot power resource for the parent PCIe port of the device in
> question and turn that power resource off when both the device and its
> parent port have been programmed to go into D3hot (via PMCSR).  So the
> flow is that the device goes into D3hot first.  Later, its parent port
> goes into D3hot and then the D3hot power resource of the port is
> turned off.  It usually doesn't really remove power from the port
> (especially if this is a root port), but it turns down the PCIe link
> from it to the device (in a platform-specific way) which effectively
> cuts power from the device.
>
> On the way back, the D3hot power resource of the port is turned on
> first and this turns the PCIe link between the port and the device up.
>
> > There is no such option available for DT right now. I was shoping that
> > once this NVMe issue is resolved, then I could look into D3Cold for DT
> > platforms.
>
> Well, consider the above.
>
> [cut]
>
> > > > >
> > > > > I think we're getting to the bottom of the issue.
> > > > >
> > > > > First off, there really is no requirement to avoid putting PCI de=
vices
> > > > > into D3hot or D3cold during suspend-to-idle.  On all modern Intel
> > > > > platforms, PCIe devices are put into D3(hot or cold) during
> > > > > suspend-to-idle and I don't see why this should be any different =
on
> > > > > platforms from any other vendors.
> > > > >
> > > > > The NVMe driver is an exception and it avoids D3(hot or cold) dur=
ing
> > > > > suspend-to-idle because of problems with some hardware or platfor=
ms.
> > > > > It might in principle allow devices to go into D3(hot or cold) du=
ring
> > > > > suspend-to-idle, so long as it knows that this is going to work.
> > > > >
> > > >
> > > > Slight correction here.
> > > >
> > > > NVMe driver avoids PCI PM _only_ when it wants to handle the NVMe p=
ower
> > > > state on its own, not all the time. It has some checks [1] in the s=
uspend path
> > > > and if the platform/device passes one of the checks, it will power =
down the
> > > > device.
> > >
> > > Yes, there is a comment in that code explaining what's going on and
> > > that is basically "if key ingredients are missing or the firmware is
> > > going to do its thing anyway, don't bother".
> > >
> > > > DT platforms doesn't pass any of the checks, so the NVMe driver alw=
ays manages
> > > > the power state on its own. Unfortunately, the resultant power savi=
ng is not
> > > > enough, so the vendors (Laptop/Automotive) using DT want NVMe to be=
 powered down
> > > > all the time. This is the first problem we are trying to solve.
> > > >
> > > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git/tree/drivers/nvme/host/pci.c#n3448
> > >
> > > I see.
> > >
> > > This cannot be done by the driver itself, though, at least not in
> > > general.  The PCI layer needs to be involved and, if we are talking
> > > about D3cold, the platform firmware needs to be involved either.
> > >
> >
> > Right, but the device driver needs to have some idea about what state P=
CI core
> > is going to choose for the device. I believe that's the purpose of
> > pci_choose_state() API. More below...
>
> This is not really straightforward as per the above.
>
> The driver would effectively need to know if the device's parent port
> would be put into D3cold and pci_choose_state() is only about the
> device itself.
>
> > > As a rule, the PCI layer reaches out to the platform firmware for hel=
p
> > > as needed and drivers don't take part in this directly.
> > >
> > > The NVMe driver would need to let the PCI layer take over and set the
> > > PCI power state of the device if it wanted to get any deeper than NVM=
e
> > > protocol specific power states.
> > >
> > > In principle, this can be addressed with some kind of a driver opt-in=
.
> > > That is, the NVMe driver would continue to work the way it does, but
> > > instead of completely preventing the PCI layer from taking over, it
> > > would opt in (the exact opt-in mechanism is TBD) for D3cold if (a) th=
e
> > > platform firmware provides a mechanism to do so and (b) the DT
> > > indicates that this mechanism should be used for the given device.
> > >
> >
> > Ok, IIUC you are talking about something like this?
> >
> >         static int nvme_suspend(struct device *dev)
> >         {
> >                 ...
> >
> >                 if (pm_suspend_via_firmware() || !ctrl->npss || ... ||
> >                     pci_choose_state(pdev, PMSG_SUSPEND) =3D=3D PCI_D3c=
old)
> >                         return nvme_disable_prepare_reset(ndev, true);
> >
> >                 /* continue using protocol specific low power state */
> >
> >                 ...
> >         }
> >
> > Here, pci_choose_state() should tell the driver if the device should en=
ter
> > D3Cold. ACPI already supports this API, now I need to add DT support (w=
hich is
> > not straightforward, but doable). Since this API is already exported, I=
 think it
> > makes perfect sense to use it here (and other drivers for similar useca=
se).
>
> I didn't really think about using pci_choose_state() here, but it is
> not unreasonable IMV.  It may in principle be extended to cover the
> "port + device combo" approach described above.  I'd rather avoid
> calling pci_choose_state() twice for the same device during one
> transition (once in the driver and then in the PCI layer), but that
> could be addressed by rearranging the code.
>
> However, I thought about adding a way for the driver to effectively
> say "I'm fine with putting this device into power state X so long as
> you have an indication from the platform firmware that this is OK",
> where X would be the deepest power state allowed by the driver.
>
> The drawback of this is that the driver would not know whether or not
> the device would go into state X upfront, so it would need to do its
> own thing in case this doesn't happen.  In the NVMe driver case, this
> would mean putting the device into a protocol low-power state before
> returning from the suspend callback which may not be a bad idea
> overall.
>
> BTW, I'm wondering what could go wrong if the
> pm_suspend_via_firmware() check were dropped from nvme_suspend()?  The
> driver would do some extra work on systems with ACPI S3 support, but
> would it actually break anything?  Does anybody know?  May be worth
> trying ...
>
> > > > > However, there is an additional concern that putting an NVMe devi=
ce
> > > > > into D3cold every time during system suspend on Android might cau=
se it
> > > > > to wear out more quickly.
> > > > >
> > > >
> > > > Right, this is the second problem.
> > >
> > > Let's set this one somewhat aside for now.  We'll get back to it when
> > > we have clarity in the above.
> > >
> >
> > Ok. I believe this could be addressed in pci_choose_state() itself if r=
equired.
>
> Possibly.
>
> Unrelated notice: I will be mostly offline starting tomorrow through
> Jan 6, 2025 and responses may be slow during that time.

I didn't really find a good thread to reply to, but just decided to
pick the current latest email to share some of my additional thoughts.
Sorry, if it becomes confusing.

I think a lot of the requirements that have been discussed need to be
considered together (and there are possibly even more requirements
that have not been highlighted yet), to be able to find a proper good
solution. For example, if we just decide to always enter the deepest
low-power state that is available, that may hurt the internal storage
device, for *some* use cases.

That said, we really need to find a good step-by-step approach, to
avoid damaging storage devices along the road.

For example, we have reported issues on (e)MMC/SD where we could end
up too frequently powering-on/off the card during system
suspend/resume, to potentially damage it. For eMMC (or in-fact
non-removable cards), we have tried to mitigate the problem by
deferring the power-on of the card during system resume, until there
is actual I/O being requested for the card.

Kind regards
Uffe

