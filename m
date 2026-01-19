Return-Path: <linux-pci+bounces-45174-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F2CD3A8B9
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 13:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B027C30635D1
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 12:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F6C32570D;
	Mon, 19 Jan 2026 12:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kk7RWiKB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C42A3254AC
	for <linux-pci@vger.kernel.org>; Mon, 19 Jan 2026 12:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768825599; cv=none; b=taOn9P0rChFonJsWZHotrCM7hmAPGTmWR501TJdbK2CNAwbPiS1jyY6WrNQz6uJ1FS23NHPv3G4wA/bYwX/6d7Qa+B5bOJ+oiISRa+pv7QKjvFSZQLm3qdlDal9xKAKpbgs3BcB2wX2yc9HXY8J2rDYaoOqjKC/K3p4uF/kY+1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768825599; c=relaxed/simple;
	bh=SSIzOzaDE7//KmY5FNsdMbqnfiMffoRKHmOuNKGOaJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z47ULuT0e11gODBYprZayu1z6t0wtOAV+7A10T41vNE9aYW7zEcAG7HhCZKd4NfvTN0OoGkHqfUtHff6uUmUPNeM33GHAMGcmW31mHgrGJFprWf2E/rmuSqCviOvv7j7/6YjdH/vfPGsTudNM5cjgTluYuB48uqCMzkPEIWwxB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kk7RWiKB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3768C2BCB2
	for <linux-pci@vger.kernel.org>; Mon, 19 Jan 2026 12:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768825598;
	bh=SSIzOzaDE7//KmY5FNsdMbqnfiMffoRKHmOuNKGOaJo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kk7RWiKB7H/bDiQh5fEfb8KgwAvcFFVb/Gti6KuNeNjhuVHp0HQvVaspsQ9t8bPQL
	 vlfZqM8ejjOTD9XcxRGSA7QZBids8ZeTZ1PUiutIB019yJrumMYah12rNKnIQlqW99
	 0Q2p4wUPIJgi2KWchzfRNUIECvpZhwb95p11XwQHygnRNnlP+91UR9/qs6eAh4boiq
	 dr/HPm3jpGa07bRuvtPAJyXP43W0eS4zJ57aSXJiATKDLMANcxi9tUSuVi5/yRg0WA
	 0u5vECjD1CDdmqvg4SZatMM9pBFbKqcsnGGV5QWw+nxranDuG6WF4fme7/qK2/GiEt
	 wdwXn8uLOEaiQ==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-40444c41a70so2058571fac.1
        for <linux-pci@vger.kernel.org>; Mon, 19 Jan 2026 04:26:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV1UX5SedVBXIzLLHdBAjqfvGqkhxNs6uKnG9ud6qsXaTGImKeKt1bfFQO2t0WpilKWyOHZmVSIPjw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz10x5lxguD7n3UE2S5GemTTmGRYGoD48oFe07ZyabpVTsiJ9+n
	Itnd8VxYfqlKf/PWcpGXZvuhNlIKh9rcpEkuUhVUH1QWL8xNukej+mkAV8VMsWK5G/X7aJTmF9i
	lZ0colMYy+ajP21MOT1rTjQxMLqF02ZI=
X-Received: by 2002:a05:6820:488d:b0:65d:441:5fbc with SMTP id
 006d021491bc7-66117a3736amr3743949eaf.79.1768825597715; Mon, 19 Jan 2026
 04:26:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260106222715.GA381397@bhelgaas> <CGME20260114094643eucas1p1a2fdc6c35dd27741c18831b34bbed0c8@eucas1p1.samsung.com>
 <0e35a4e1-894a-47c1-9528-fc5ffbafd9e2@samsung.com> <aWf4KyTSIocWTmXw@google.com>
 <61e8c93c-d096-4807-b2dd-a22657f2e06a@samsung.com> <aWrjhqC_6I2UNXC5@google.com>
 <CAJZ5v0hWt63=0yjFrbTY8zXubh-Uc6ZwAndT73VL7itMkTe81A@mail.gmail.com>
 <CAJZ5v0gKZFWzuFT=cF_Ydjpro+sXzdeZ_+B4GEfiifa-cxpbGw@mail.gmail.com> <d2c006c3-44c3-4270-b1ca-5d1a0d7f4e09@samsung.com>
In-Reply-To: <d2c006c3-44c3-4270-b1ca-5d1a0d7f4e09@samsung.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 19 Jan 2026 13:26:25 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0j=TM6DoGbW1agbiHUbq46G7pyd25E=ih2at7dvYr83Sg@mail.gmail.com>
X-Gm-Features: AZwV_Qjr0d4ZRXuwqr_fC6lif0BGKq2UmHdyOHtiSe_Mso2lVi0z1WpKEY3FSh0
Message-ID: <CAJZ5v0j=TM6DoGbW1agbiHUbq46G7pyd25E=ih2at7dvYr83Sg@mail.gmail.com>
Subject: Re: [PATCH v4] PCI/PM: Prevent runtime suspend before devices are
 fully initialized
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Brian Norris <briannorris@chromium.org>, 
	Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-pm@vger.kernel.org, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 11:01=E2=80=AFAM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> On 18.01.2026 12:59, Rafael J. Wysocki wrote:
> > On Sun, Jan 18, 2026 at 12:53=E2=80=AFPM Rafael J. Wysocki <rafael@kern=
el.org> wrote:
> >> On Sat, Jan 17, 2026 at 2:19=E2=80=AFAM Brian Norris <briannorris@chro=
mium.org> wrote:
> >>> On Thu, Jan 15, 2026 at 12:14:49PM +0100, Marek Szyprowski wrote:
> >>>> On 14.01.2026 21:10, Brian Norris wrote:
> >>>>> On Wed, Jan 14, 2026 at 10:46:41AM +0100, Marek Szyprowski wrote:
> >>>>>> On 06.01.2026 23:27, Bjorn Helgaas wrote:
> >>>>>>> On Thu, Oct 23, 2025 at 02:09:01PM -0700, Brian Norris wrote:
> >>>>>>>> Today, it's possible for a PCI device to be created and
> >>>>>>>> runtime-suspended before it is fully initialized. When that happ=
ens, the
> >>>>>>>> device will remain in D0, but the suspend process may save an
> >>>>>>>> intermediate version of that device's state -- for example, with=
out
> >>>>>>>> appropriate BAR configuration. When the device later resumes, we=
'll
> >>>>>>>> restore invalid PCI state and the device may not function.
> >>>>>>>>
> >>>>>>>> Prevent runtime suspend for PCI devices by deferring pm_runtime_=
enable()
> >>>>>>>> until we've fully initialized the device.
> >>>>> ...
> >>>>>> This patch landed recently in linux-next as commit c796513dc54e
> >>>>>> ("PCI/PM: Prevent runtime suspend until devices are fully initiali=
zed").
> >>>>>> In my tests I found that it sometimes causes the "pci 0000:01:00.0=
:
> >>>>>> runtime PM trying to activate child device 0000:01:00.0 but parent
> >>>>>> (0000:00:00.0) is not active" warning on Qualcomm Robotics RB5 boa=
rd
> >>>>>> (arch/arm64/boot/dts/qcom/qrb5165-rb5.dts). This in turn causes a
> >>>>>> lockdep warning about console lock, but this is just a consequence=
 of
> >>>>>> the runtime pm warning. Reverting $subject patch on top of current
> >>>>>> linux-next hides this warning.
> >>>>>>
> >>>>>> Here is a kernel log:
> >>>>>>
> >>>>>> pci 0000:01:00.0: [17cb:1101] type 00 class 0xff0000 PCIe Endpoint
> >>>>>> pci 0000:01:00.0: BAR 0 [mem 0x00000000-0x000fffff 64bit]
> >>>>>> pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
> >>>>>> pci 0000:01:00.0: 4.000 Gb/s available PCIe bandwidth, limited by =
5.0
> >>>>>> GT/s PCIe x1 link at 0000:00:00.0 (capable of 7.876 Gb/s with 8.0 =
GT/s
> >>>>>> PCIe x1 link)
> >>>>>> pci 0000:01:00.0: Adding to iommu group 13
> >>>>>> pci 0000:01:00.0: ASPM: default states L0s L1
> >>>>>> pcieport 0000:00:00.0: bridge window [mem 0x60400000-0x604fffff]: =
assigned
> >>>>>> pci 0000:01:00.0: BAR 0 [mem 0x60400000-0x604fffff 64bit]: assigne=
d
> >>>>>> pci 0000:01:00.0: runtime PM trying to activate child device
> >>>>>> 0000:01:00.0 but parent (0000:00:00.0) is not active
> >>>>> Thanks for the report. I'll try to look at reproducing this, or at =
least
> >>>>> getting a better mental model of exactly why this might fail (or,
> >>>>> "warn") this way. But if you have the time and desire to try things=
 out
> >>>>> for me, can you give v1 a try?
> >>>>>
> >>>>> https://lore.kernel.org/all/20251016155335.1.I60a53c170a8596661883b=
d2b4ef475155c7aa72b@changeid/
> >>>>>
> >>>>> I'm pretty sure it would not invoke the same problem.
> >>>> Right, this one works fine.
> >>>>
> >>>>> I also suspect v3
> >>>>> might not, but I'm less sure:
> >>>>>
> >>>>> https://lore.kernel.org/all/20251022141434.v3.1.I60a53c170a85966618=
83bd2b4ef475155c7aa72b@changeid/
> >>>> This one too, at least I was not able to reproduce any fail.
> >>> Thanks for testing. I'm still not sure exactly how to reproduce your
> >>> failure, but it seems as if the root port is being allowed to suspend
> >>> before the endpoint is added to the system, and it remains so while t=
he
> >>> endpoint is about to probe. device_initial_probe() will be OK with
> >>> respect to PM, since it will wake up the port if needed. But this
> >>> particular code is not OK, since it doesn't ensure the parent device =
is
> >>> active while preparing the endpoint power state.
> >>>
> >>> I suppose one way to "solve" that is (untested):
> >>>
> >>> --- a/drivers/pci/bus.c
> >>> +++ b/drivers/pci/bus.c
> >>> @@ -380,8 +380,12 @@ void pci_bus_add_device(struct pci_dev *dev)
> >>>                  put_device(&pdev->dev);
> >>>          }
> >>>
> >>> +       if (dev->dev.parent)
> >>> +               pm_runtime_get_sync(dev->dev.parent);
> >>>          pm_runtime_set_active(&dev->dev);
> >>>          pm_runtime_enable(&dev->dev);
> >>> +       if (dev->dev.parent)
> >>> +               pm_runtime_put(dev->dev.parent);
> >>>
> >>>          if (!dn || of_device_is_available(dn))
> >>>                  pci_dev_allow_binding(dev);
> >>>
> >>> Personally, I'm more inclined to go back to v1, since it prepares the
> >>> runtime PM status when the device is first discovered. That way, its
> >>> ancestors are still active, avoiding these sorts of problems. I'm
> >>> frankly not sure of all the reasons Rafael recommended I make the
> >>> v1->v3->v4 changes, and now that they cause problems, I'm inclined to
> >>> question them again.
> >>>
> >>> Rafael, do you have any thoughts?
> >> Yeah.
> >>
> >> Move back pm_runtime_set_active(&dev->dev) back to pm_runtime_init()
> > Or rather leave it there to be precise, but I think you know what I mea=
n. :-)
> >
> >> because that would prevent the parent from suspending and keep
> >> pm_runtime_enable() here because that would prevent the device itself
> >> from suspending between pm_runtime_init() and this place.
> >>
> >> And I would add comments in both places.
>
> Confirmed, the following change (compared to $subject patch) fixed my iss=
ue:
>
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index 3ef60c2fbd89..7e2b7e452d51 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -381,7 +381,6 @@ void pci_bus_add_device(struct pci_dev *dev)
>          }
>
>          pm_runtime_set_active(&dev->dev);
> -       pm_runtime_enable(&dev->dev);

That works too, but it would defeat the purpose of the original
change, so I mean the other way around.

That is, leave the pm_runtime_enable() here and move the
pm_runtime_set_active() back to the other place.

>
>          if (!dn || of_device_is_available(dn))
>                  pci_dev_allow_binding(dev);
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index fae5a683cf87..22b897416025 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3201,6 +3201,7 @@ void pci_pm_init(struct pci_dev *dev)
>   poweron:
>          pci_pm_power_up_and_verify_state(dev);
>          pm_runtime_forbid(&dev->dev);
> +       pm_runtime_enable(&dev->dev);
>   }
>
>   static unsigned long pci_ea_flags(struct pci_dev *dev, u8 prop)

