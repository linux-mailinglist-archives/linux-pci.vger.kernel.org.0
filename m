Return-Path: <linux-pci+bounces-45188-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2E8D3B016
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 17:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 571213044995
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 16:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84A129B795;
	Mon, 19 Jan 2026 16:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d9sTMRec"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57A028D8F1
	for <linux-pci@vger.kernel.org>; Mon, 19 Jan 2026 16:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768839044; cv=none; b=WA9viV5yV4GoKO9VaL/lw+ZePAoy0pJmdNhy6hXIerPosP/R3vawr+cmGegxPkc6tztH4NMfWzeGbTai1QviUni+ia3ZmVj0srM2DXxq34bZaDGsUZcEDSxqzY1Q0OEaPbjhiVb1b6NxCJykR/KX56VMpzjXmRRUGoYM4NekDo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768839044; c=relaxed/simple;
	bh=xojvTFzwpY+4N5Z8neU2E8/iFj7GHyaguBJW+DTwJy8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qu3ZAaT6Kv874YzJpxagW6UD1dS2RUsN/EwK8QAQyec1E87++vFcEPfPZNayVwu/e8wukxNbFBH7y0SFyD/t+QqMOPuH2EyXatGYXqn/sxQVwlu8Sgxqj1k1XOtPR/EsHHMUwFvyvUhkeEmqniwcMok/D6ebCn4Aism80P8OmTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d9sTMRec; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 786A4C19425
	for <linux-pci@vger.kernel.org>; Mon, 19 Jan 2026 16:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768839044;
	bh=xojvTFzwpY+4N5Z8neU2E8/iFj7GHyaguBJW+DTwJy8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=d9sTMRecQoXPn0XmphhL4iwgEPP4PGEwrPzBkHph2NMzzpnvB3RdTQJ4CMte97HVe
	 PlunS80rwQ5dwvt28qMhlufXayHM9MXBfsDpy6i6fkdWbvgYorFkV3HxhJOjOGU3UH
	 42LeZcepc+i2HEuZSjuO7hcIasWI73TlNGFZRJGJjsN3Ln0a7xFJ9AR0peJwHuPNCZ
	 lL95ikM3Xe4uS1wXpI3Nv0yN/Pug5NocglxKUodhqht9MqXOmkxGAxn4oyg85QPaRA
	 D8qhRcuhgjOs/ay0WNA/Pm1DBLKUaoDNjfLm1P7ntRZRmpZnBpxNyhAidW9JBX29HY
	 vHEwhup1Ymy6Q==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-40438380b88so2769712fac.3
        for <linux-pci@vger.kernel.org>; Mon, 19 Jan 2026 08:10:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX7NJTtTWHA5XF1bT8R6VgQ/C2n+wls6MhT8lcIaDb1hqrkd0qHokFizjF+xtBx3abwkooRqOEKDXo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqM28rz/NCqdl18webgBhHg8mAIRJ4pWtTGG4+Tpuspmjo/Ewt
	6RfhL12y6owPTom7sMIxfnmcbeked0VT0apUuQQflKZOz1G/HxlNTGoepsJXDL2XmEMGcs2UVZ0
	5xe2RtkAhL1EbFig1Nv1NyHulCwDCVNM=
X-Received: by 2002:a05:687c:12d:b0:3f5:4172:21 with SMTP id
 586e51a60fabf-4044c65c1ddmr5361229fac.58.1768839043584; Mon, 19 Jan 2026
 08:10:43 -0800 (PST)
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
 <CAJZ5v0gKZFWzuFT=cF_Ydjpro+sXzdeZ_+B4GEfiifa-cxpbGw@mail.gmail.com>
 <d2c006c3-44c3-4270-b1ca-5d1a0d7f4e09@samsung.com> <CAJZ5v0j=TM6DoGbW1agbiHUbq46G7pyd25E=ih2at7dvYr83Sg@mail.gmail.com>
 <6e0c511f-1127-4a35-a40c-0161de0ec752@samsung.com>
In-Reply-To: <6e0c511f-1127-4a35-a40c-0161de0ec752@samsung.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 19 Jan 2026 17:10:32 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0h-f5kgJ-p4LqX_8fpz3T3AVqq_7S2n4b1vZdPQoF-MFA@mail.gmail.com>
X-Gm-Features: AZwV_QjcZaSlUnYJhTjJWUVJFBc_fqUs4PM7jI8f22EWDYO4JXSq9j7CUt_nGvw
Message-ID: <CAJZ5v0h-f5kgJ-p4LqX_8fpz3T3AVqq_7S2n4b1vZdPQoF-MFA@mail.gmail.com>
Subject: Re: [PATCH v4] PCI/PM: Prevent runtime suspend before devices are
 fully initialized
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Brian Norris <briannorris@chromium.org>, 
	Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-pm@vger.kernel.org, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 2:13=E2=80=AFPM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> On 19.01.2026 13:26, Rafael J. Wysocki wrote:
> > On Mon, Jan 19, 2026 at 11:01=E2=80=AFAM Marek Szyprowski
> > <m.szyprowski@samsung.com> wrote:
> >> On 18.01.2026 12:59, Rafael J. Wysocki wrote:
> >>> On Sun, Jan 18, 2026 at 12:53=E2=80=AFPM Rafael J. Wysocki <rafael@ke=
rnel.org> wrote:
> >>>> On Sat, Jan 17, 2026 at 2:19=E2=80=AFAM Brian Norris <briannorris@ch=
romium.org> wrote:
> >>>>> On Thu, Jan 15, 2026 at 12:14:49PM +0100, Marek Szyprowski wrote:
> >>>>>> On 14.01.2026 21:10, Brian Norris wrote:
> >>>>>>> On Wed, Jan 14, 2026 at 10:46:41AM +0100, Marek Szyprowski wrote:
> >>>>>>>> On 06.01.2026 23:27, Bjorn Helgaas wrote:
> >>>>>>>>> On Thu, Oct 23, 2025 at 02:09:01PM -0700, Brian Norris wrote:
> >>>>>>>>>> Today, it's possible for a PCI device to be created and
> >>>>>>>>>> runtime-suspended before it is fully initialized. When that ha=
ppens, the
> >>>>>>>>>> device will remain in D0, but the suspend process may save an
> >>>>>>>>>> intermediate version of that device's state -- for example, wi=
thout
> >>>>>>>>>> appropriate BAR configuration. When the device later resumes, =
we'll
> >>>>>>>>>> restore invalid PCI state and the device may not function.
> >>>>>>>>>>
> >>>>>>>>>> Prevent runtime suspend for PCI devices by deferring pm_runtim=
e_enable()
> >>>>>>>>>> until we've fully initialized the device.
> >>>>>>> ...
> >>>>>>>> This patch landed recently in linux-next as commit c796513dc54e
> >>>>>>>> ("PCI/PM: Prevent runtime suspend until devices are fully initia=
lized").
> >>>>>>>> In my tests I found that it sometimes causes the "pci 0000:01:00=
.0:
> >>>>>>>> runtime PM trying to activate child device 0000:01:00.0 but pare=
nt
> >>>>>>>> (0000:00:00.0) is not active" warning on Qualcomm Robotics RB5 b=
oard
> >>>>>>>> (arch/arm64/boot/dts/qcom/qrb5165-rb5.dts). This in turn causes =
a
> >>>>>>>> lockdep warning about console lock, but this is just a consequen=
ce of
> >>>>>>>> the runtime pm warning. Reverting $subject patch on top of curre=
nt
> >>>>>>>> linux-next hides this warning.
> >>>>>>>>
> >>>>>>>> Here is a kernel log:
> >>>>>>>>
> >>>>>>>> pci 0000:01:00.0: [17cb:1101] type 00 class 0xff0000 PCIe Endpoi=
nt
> >>>>>>>> pci 0000:01:00.0: BAR 0 [mem 0x00000000-0x000fffff 64bit]
> >>>>>>>> pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
> >>>>>>>> pci 0000:01:00.0: 4.000 Gb/s available PCIe bandwidth, limited b=
y 5.0
> >>>>>>>> GT/s PCIe x1 link at 0000:00:00.0 (capable of 7.876 Gb/s with 8.=
0 GT/s
> >>>>>>>> PCIe x1 link)
> >>>>>>>> pci 0000:01:00.0: Adding to iommu group 13
> >>>>>>>> pci 0000:01:00.0: ASPM: default states L0s L1
> >>>>>>>> pcieport 0000:00:00.0: bridge window [mem 0x60400000-0x604fffff]=
: assigned
> >>>>>>>> pci 0000:01:00.0: BAR 0 [mem 0x60400000-0x604fffff 64bit]: assig=
ned
> >>>>>>>> pci 0000:01:00.0: runtime PM trying to activate child device
> >>>>>>>> 0000:01:00.0 but parent (0000:00:00.0) is not active
> >>>>>>> Thanks for the report. I'll try to look at reproducing this, or a=
t least
> >>>>>>> getting a better mental model of exactly why this might fail (or,
> >>>>>>> "warn") this way. But if you have the time and desire to try thin=
gs out
> >>>>>>> for me, can you give v1 a try?
> >>>>>>>
> >>>>>>> https://lore.kernel.org/all/20251016155335.1.I60a53c170a859666188=
3bd2b4ef475155c7aa72b@changeid/
> >>>>>>>
> >>>>>>> I'm pretty sure it would not invoke the same problem.
> >>>>>> Right, this one works fine.
> >>>>>>
> >>>>>>> I also suspect v3
> >>>>>>> might not, but I'm less sure:
> >>>>>>>
> >>>>>>> https://lore.kernel.org/all/20251022141434.v3.1.I60a53c170a859666=
1883bd2b4ef475155c7aa72b@changeid/
> >>>>>> This one too, at least I was not able to reproduce any fail.
> >>>>> Thanks for testing. I'm still not sure exactly how to reproduce you=
r
> >>>>> failure, but it seems as if the root port is being allowed to suspe=
nd
> >>>>> before the endpoint is added to the system, and it remains so while=
 the
> >>>>> endpoint is about to probe. device_initial_probe() will be OK with
> >>>>> respect to PM, since it will wake up the port if needed. But this
> >>>>> particular code is not OK, since it doesn't ensure the parent devic=
e is
> >>>>> active while preparing the endpoint power state.
> >>>>>
> >>>>> I suppose one way to "solve" that is (untested):
> >>>>>
> >>>>> --- a/drivers/pci/bus.c
> >>>>> +++ b/drivers/pci/bus.c
> >>>>> @@ -380,8 +380,12 @@ void pci_bus_add_device(struct pci_dev *dev)
> >>>>>                   put_device(&pdev->dev);
> >>>>>           }
> >>>>>
> >>>>> +       if (dev->dev.parent)
> >>>>> +               pm_runtime_get_sync(dev->dev.parent);
> >>>>>           pm_runtime_set_active(&dev->dev);
> >>>>>           pm_runtime_enable(&dev->dev);
> >>>>> +       if (dev->dev.parent)
> >>>>> +               pm_runtime_put(dev->dev.parent);
> >>>>>
> >>>>>           if (!dn || of_device_is_available(dn))
> >>>>>                   pci_dev_allow_binding(dev);
> >>>>>
> >>>>> Personally, I'm more inclined to go back to v1, since it prepares t=
he
> >>>>> runtime PM status when the device is first discovered. That way, it=
s
> >>>>> ancestors are still active, avoiding these sorts of problems. I'm
> >>>>> frankly not sure of all the reasons Rafael recommended I make the
> >>>>> v1->v3->v4 changes, and now that they cause problems, I'm inclined =
to
> >>>>> question them again.
> >>>>>
> >>>>> Rafael, do you have any thoughts?
> >>>> Yeah.
> >>>>
> >>>> Move back pm_runtime_set_active(&dev->dev) back to pm_runtime_init()
> >>> Or rather leave it there to be precise, but I think you know what I m=
ean. :-)
> >>>
> >>>> because that would prevent the parent from suspending and keep
> >>>> pm_runtime_enable() here because that would prevent the device itsel=
f
> >>>> from suspending between pm_runtime_init() and this place.
> >>>>
> >>>> And I would add comments in both places.
> >> Confirmed, the following change (compared to $subject patch) fixed my =
issue:
> >>
> >> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> >> index 3ef60c2fbd89..7e2b7e452d51 100644
> >> --- a/drivers/pci/bus.c
> >> +++ b/drivers/pci/bus.c
> >> @@ -381,7 +381,6 @@ void pci_bus_add_device(struct pci_dev *dev)
> >>           }
> >>
> >>           pm_runtime_set_active(&dev->dev);
> >> -       pm_runtime_enable(&dev->dev);
> > That works too, but it would defeat the purpose of the original
> > change, so I mean the other way around.
> >
> > That is, leave the pm_runtime_enable() here and move the
> > pm_runtime_set_active() back to the other place.
>
> Okay, I mixed that. This way it works too and fixes the observed issue.
>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Cool, thanks for verifying!

