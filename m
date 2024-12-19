Return-Path: <linux-pci+bounces-18808-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81EDE9F8344
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 19:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCCE0162200
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 18:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6661A0BE1;
	Thu, 19 Dec 2024 18:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lFjB0DWr"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E35C19C54A;
	Thu, 19 Dec 2024 18:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734632947; cv=none; b=AtW5xqMyzptLKSwkOTZV+IJUYrZ3QwMadYeDWcVSp+2kT77ibhE3RKTQMBWU/f072LUa5ZMN+yUTr4U94LD5AJNzGuLvhYuaKAlTMaUpzNp3FH9Okf8/wBQq5pLLEyzxNKyI5vaxLTLSdBGVz02QFQ766w+7LVZTAjxk/BGP9iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734632947; c=relaxed/simple;
	bh=BCbm3Hg+K4V2zuwb+AHAr04G2oJpXCU0PPk7yVPVIFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bz/DTwCXwproSSxl+aGr/70livPzA7vvXpz+VLlH1w2J50v9h+9kZQbenql2JYaRtxggODCliGniaan243slM1Ii+3Y6RKX+QqLJw4Yk9R7CHY/AuJCsBwUrW5+1A+KwGhg9qkz8pJcSCkntoLXSOhIL6sThQgfGxWR9G55jnXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lFjB0DWr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8F4BC4CEDE;
	Thu, 19 Dec 2024 18:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734632946;
	bh=BCbm3Hg+K4V2zuwb+AHAr04G2oJpXCU0PPk7yVPVIFM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lFjB0DWrn0oUjrmPSbCbLUM64kNy4vQyRhoK3wCccpkbkZ7HrM1aCg4sB96g9Uvyl
	 o5iS/JrOFvu0P1YqNKAfcT0CgHVMg3mAFZtdwBeXCqftepvWmtb2eILjM3J0+4FjHy
	 sbgATgx8rkYNIOh9BVZs9X4HlSVvNXIPyRyT+V6vpijSW7FCStP/L+lBl0s0VXnaBO
	 z2Q4fklsf0tqisR5vqqI9ukHlsD9UXrcShpEzeGOhHBsGKeGecx9I3Cwpr5gMZMMgY
	 sXbt4E9FIjKKyMdBZW5JYFSWOf5IJGaNrpLtBZDTGjEI3uSsuu8Zu9XEn6OzD8TVaU
	 Rsk57kDA3b5gw==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5f32f5b0631so675485eaf.3;
        Thu, 19 Dec 2024 10:29:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUWYqw68ZwSYDhDfbMeVLjDcR3xrmxa6y6/Rnov1nNK4cxHstQIzZ4xWqMiBnKEoLkHOGZFhmSfOVM=@vger.kernel.org, AJvYcCVeeHLJKD0SryKYy+v/eyv/Ga48VfLc/5+1YyeWJAwIMzquZ+7U0ehiVjnMXgO1tmMLc2MX60PVJao3@vger.kernel.org, AJvYcCWkyFoyBANnsPv8evsKYz79TJ9YOe0kQoAt8UoTbNNFMcw2gw+1+mim4QxPy1QkO1jBWwRAy1hL+wd0Z+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQg055dxXUjgDo+Jwjg9qBecXcC8w4NpErAztOtKR6OljdiOT0
	lX1qqxOymSAWixGjX2lqPOQOSeDLBdbWbzCnWz4q8BDtFEeUebypG6KD2oIzlCTdTgQWjFGInll
	zLIZFZMHneRZnJeKx7g8S/ce6WSw=
X-Google-Smtp-Source: AGHT+IEnxK2aGkz/nNA8SeFyKgRCAVG658hd7I7pHZi6ABVejXyVqq4N2aH+Do0mxoT6zyGzRpIGRLqwrBUCHwke/Ds=
X-Received: by 2002:a05:6820:8cc:b0:5f2:8c8:a977 with SMTP id
 006d021491bc7-5f62d1bfe94mr324695eaf.8.1734632945698; Thu, 19 Dec 2024
 10:29:05 -0800 (PST)
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
 <CAPDyKFqc+YuAyV-120Vvg7HOkhgnJ=wM53LAHTkJ6Gg5=rJumA@mail.gmail.com>
In-Reply-To: <CAPDyKFqc+YuAyV-120Vvg7HOkhgnJ=wM53LAHTkJ6Gg5=rJumA@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 19 Dec 2024 19:28:53 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gVCjhqLhNz-e7J4nZ05gJO9yYbRaNVuFdQRtO6JbTGfA@mail.gmail.com>
Message-ID: <CAJZ5v0gVCjhqLhNz-e7J4nZ05gJO9yYbRaNVuFdQRtO6JbTGfA@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: Shutdown the device if D3Cold is allowed by the user
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Christoph Hellwig <hch@lst.de>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Bjorn Helgaas <helgaas@kernel.org>, kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, andersson@kernel.org, konradybcio@kernel.org, 
	Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2024 at 5:42=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
>
> On Thu, 19 Dec 2024 at 13:45, Rafael J. Wysocki <rafael@kernel.org> wrote=
:
> >
> > On Thu, Dec 19, 2024 at 9:02=E2=80=AFAM Manivannan Sadhasivam
> > <manivannan.sadhasivam@linaro.org> wrote:
> > >
> > > On Tue, Dec 17, 2024 at 08:45:55PM +0100, Rafael J. Wysocki wrote:
> > > > On Tue, Dec 17, 2024 at 6:26=E2=80=AFAM <manivannan.sadhasivam@lina=
ro.org> wrote:
> > > > >
> > > > > On Mon, Dec 16, 2024 at 08:34:24PM +0100, Rafael J. Wysocki wrote=
:
> > > > >
> > > > > [...]
> > > > >
> > > > > > > There is also a case where some devices like
> > > > > > > (Laptops made out of Qcom SCX Gen3 SoCs) require all the PCIe=
 devices to be
> > > > > > > powered down in order for the SoC to reach its low power stat=
e (CX power
> > > > > > > collapse in Qcom terms). If not, the SoC would continue to dr=
aw more power
> > > > > > > leading to battery draining quickly. This platform is support=
ed in upstream and
> > > > > > > we keep the PCIe interconnect voted during suspend as the NVM=
e driver is
> > > > > > > expecting the device to retain its state during resume. Becau=
se of this
> > > > > > > requirement, this platform is not reaching SoC level low powe=
r state with
> > > > > > > upstream kernel.
> > > > > >
> > > > > > OK, now all of this makes sense and that's why you really want =
NVMe
> > > > > > devices to end up in some form of PCI D3 in suspend-to-idle.
> > > > > >
> > > > > > Would D3hot be sufficient for this platform or does it need to =
be
> > > > > > D3cold?  If the latter, what exactly is the method by which the=
y are
> > > > > > put into D3cold?
> > > > > >
> > > > >
> > > > > D3Cold is what preferred. Earlier the controller driver used to t=
ransition the
> > > > > device into D3Cold by sending PME_Turn_Off, turning off refclk, r=
egulators
> > > > > etc... Now we have a new framework called 'pwrctrl' that handles =
the
> > > > > clock/regulators supplied to the device. So both controller and p=
wrctrl drivers
> > > > > need to work in a tandem to put the device into D3Cold.
> > > > >
> > > > > Once the PCIe client driver (NVMe in this case) powers down the d=
evice, then
> > > > > controller/pwrctrl drivers will check the PCIe device state and t=
ransition the
> > > > > device into D3Cold. This is a TODO btw.
> > > > >
> > > > > But right now there is no generic D3Cold handling available for D=
T platforms. I
> > > > > am hoping to fix that too once this NVMe issue is handled.
> > > >
> > > > There's no generic D3cold handling for PCIe devices at all AFAICS. =
 At
> > > > least, I'm not aware of any standard way to do it.  Yes, there are
> > > > vendor-specific conventions that may even be followed by multiple
> > > > vendors, but not much beyond that.
> > > >
> > >
> > > Yeah, right. Atleast ACPI has its own way of handling D3Cold and that=
's what I
> > > meant.
> >
> > Well, not so simple.
> >
> > ACPI has a way to put devices into D3cold, but it is based on power
> > resources: If all of the ACPI power resources for state D3hot of the
> > given device are turned off, the device is assumed to have no power
> > which effectively means D3cold.
> >
> > Now, this basically works for platform devices, but it doesn't work
> > particularly well for PCIe devices that get their power from the bus.
> >
> > This is addressed by using a conventional approach that has not been
> > codified as a standard so far AFAICS.  The convention is to define a
> > D3hot power resource for the parent PCIe port of the device in
> > question and turn that power resource off when both the device and its
> > parent port have been programmed to go into D3hot (via PMCSR).  So the
> > flow is that the device goes into D3hot first.  Later, its parent port
> > goes into D3hot and then the D3hot power resource of the port is
> > turned off.  It usually doesn't really remove power from the port
> > (especially if this is a root port), but it turns down the PCIe link
> > from it to the device (in a platform-specific way) which effectively
> > cuts power from the device.
> >
> > On the way back, the D3hot power resource of the port is turned on
> > first and this turns the PCIe link between the port and the device up.
> >
> > > There is no such option available for DT right now. I was shoping tha=
t
> > > once this NVMe issue is resolved, then I could look into D3Cold for D=
T
> > > platforms.
> >
> > Well, consider the above.
> >
> > [cut]
> >
> > > > > >
> > > > > > I think we're getting to the bottom of the issue.
> > > > > >
> > > > > > First off, there really is no requirement to avoid putting PCI =
devices
> > > > > > into D3hot or D3cold during suspend-to-idle.  On all modern Int=
el
> > > > > > platforms, PCIe devices are put into D3(hot or cold) during
> > > > > > suspend-to-idle and I don't see why this should be any differen=
t on
> > > > > > platforms from any other vendors.
> > > > > >
> > > > > > The NVMe driver is an exception and it avoids D3(hot or cold) d=
uring
> > > > > > suspend-to-idle because of problems with some hardware or platf=
orms.
> > > > > > It might in principle allow devices to go into D3(hot or cold) =
during
> > > > > > suspend-to-idle, so long as it knows that this is going to work=
.
> > > > > >
> > > > >
> > > > > Slight correction here.
> > > > >
> > > > > NVMe driver avoids PCI PM _only_ when it wants to handle the NVMe=
 power
> > > > > state on its own, not all the time. It has some checks [1] in the=
 suspend path
> > > > > and if the platform/device passes one of the checks, it will powe=
r down the
> > > > > device.
> > > >
> > > > Yes, there is a comment in that code explaining what's going on and
> > > > that is basically "if key ingredients are missing or the firmware i=
s
> > > > going to do its thing anyway, don't bother".
> > > >
> > > > > DT platforms doesn't pass any of the checks, so the NVMe driver a=
lways manages
> > > > > the power state on its own. Unfortunately, the resultant power sa=
ving is not
> > > > > enough, so the vendors (Laptop/Automotive) using DT want NVMe to =
be powered down
> > > > > all the time. This is the first problem we are trying to solve.
> > > > >
> > > > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linu=
x.git/tree/drivers/nvme/host/pci.c#n3448
> > > >
> > > > I see.
> > > >
> > > > This cannot be done by the driver itself, though, at least not in
> > > > general.  The PCI layer needs to be involved and, if we are talking
> > > > about D3cold, the platform firmware needs to be involved either.
> > > >
> > >
> > > Right, but the device driver needs to have some idea about what state=
 PCI core
> > > is going to choose for the device. I believe that's the purpose of
> > > pci_choose_state() API. More below...
> >
> > This is not really straightforward as per the above.
> >
> > The driver would effectively need to know if the device's parent port
> > would be put into D3cold and pci_choose_state() is only about the
> > device itself.
> >
> > > > As a rule, the PCI layer reaches out to the platform firmware for h=
elp
> > > > as needed and drivers don't take part in this directly.
> > > >
> > > > The NVMe driver would need to let the PCI layer take over and set t=
he
> > > > PCI power state of the device if it wanted to get any deeper than N=
VMe
> > > > protocol specific power states.
> > > >
> > > > In principle, this can be addressed with some kind of a driver opt-=
in.
> > > > That is, the NVMe driver would continue to work the way it does, bu=
t
> > > > instead of completely preventing the PCI layer from taking over, it
> > > > would opt in (the exact opt-in mechanism is TBD) for D3cold if (a) =
the
> > > > platform firmware provides a mechanism to do so and (b) the DT
> > > > indicates that this mechanism should be used for the given device.
> > > >
> > >
> > > Ok, IIUC you are talking about something like this?
> > >
> > >         static int nvme_suspend(struct device *dev)
> > >         {
> > >                 ...
> > >
> > >                 if (pm_suspend_via_firmware() || !ctrl->npss || ... |=
|
> > >                     pci_choose_state(pdev, PMSG_SUSPEND) =3D=3D PCI_D=
3cold)
> > >                         return nvme_disable_prepare_reset(ndev, true)=
;
> > >
> > >                 /* continue using protocol specific low power state *=
/
> > >
> > >                 ...
> > >         }
> > >
> > > Here, pci_choose_state() should tell the driver if the device should =
enter
> > > D3Cold. ACPI already supports this API, now I need to add DT support =
(which is
> > > not straightforward, but doable). Since this API is already exported,=
 I think it
> > > makes perfect sense to use it here (and other drivers for similar use=
case).
> >
> > I didn't really think about using pci_choose_state() here, but it is
> > not unreasonable IMV.  It may in principle be extended to cover the
> > "port + device combo" approach described above.  I'd rather avoid
> > calling pci_choose_state() twice for the same device during one
> > transition (once in the driver and then in the PCI layer), but that
> > could be addressed by rearranging the code.
> >
> > However, I thought about adding a way for the driver to effectively
> > say "I'm fine with putting this device into power state X so long as
> > you have an indication from the platform firmware that this is OK",
> > where X would be the deepest power state allowed by the driver.
> >
> > The drawback of this is that the driver would not know whether or not
> > the device would go into state X upfront, so it would need to do its
> > own thing in case this doesn't happen.  In the NVMe driver case, this
> > would mean putting the device into a protocol low-power state before
> > returning from the suspend callback which may not be a bad idea
> > overall.
> >
> > BTW, I'm wondering what could go wrong if the
> > pm_suspend_via_firmware() check were dropped from nvme_suspend()?  The
> > driver would do some extra work on systems with ACPI S3 support, but
> > would it actually break anything?  Does anybody know?  May be worth
> > trying ...
> >
> > > > > > However, there is an additional concern that putting an NVMe de=
vice
> > > > > > into D3cold every time during system suspend on Android might c=
ause it
> > > > > > to wear out more quickly.
> > > > > >
> > > > >
> > > > > Right, this is the second problem.
> > > >
> > > > Let's set this one somewhat aside for now.  We'll get back to it wh=
en
> > > > we have clarity in the above.
> > > >
> > >
> > > Ok. I believe this could be addressed in pci_choose_state() itself if=
 required.
> >
> > Possibly.
> >
> > Unrelated notice: I will be mostly offline starting tomorrow through
> > Jan 6, 2025 and responses may be slow during that time.
>
> I didn't really find a good thread to reply to, but just decided to
> pick the current latest email to share some of my additional thoughts.
> Sorry, if it becomes confusing.
>
> I think a lot of the requirements that have been discussed need to be
> considered together (and there are possibly even more requirements
> that have not been highlighted yet), to be able to find a proper good
> solution. For example, if we just decide to always enter the deepest
> low-power state that is available, that may hurt the internal storage
> device, for *some* use cases.
>
> That said, we really need to find a good step-by-step approach, to
> avoid damaging storage devices along the road.
>
> For example, we have reported issues on (e)MMC/SD where we could end
> up too frequently powering-on/off the card during system
> suspend/resume, to potentially damage it. For eMMC (or in-fact
> non-removable cards), we have tried to mitigate the problem by
> deferring the power-on of the card during system resume, until there
> is actual I/O being requested for the card.

This is a reasonable approach and there are other possibilities.

In the particular case of NVMe, though, the question of how to
actually power it down is still open.  Until there is a clear answer
to it, the possibility of powering NVMe devices down and up too often
is not really a practical concern.

Generally, the problem of choosing suitable power states during system
suspend is not limited to storage (for instance, if the sleep time is
going to be short enough and it is known in advance, it may not be
useful to change power states of many devices because that is just
going to take too much time) and the attempts to address it have been
very limited so far.  There are many factors that come into play, like
how much energy is to be saved, how much time are suspend and resume
transitions allowed or expected to take, which devices are expected to
wake up the system from sleep, etc, and the possible device wearout is
one of them.

I kind of know where you are going with this, but I'd first like to
know what hardware and firmware interfaces are going to be used and
how and then consider problems that may arise from doing that.
Otherwise we'll end up in an endless discussion of theoretical
possibilities I'm afraid.

