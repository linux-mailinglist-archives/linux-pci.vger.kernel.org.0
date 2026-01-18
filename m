Return-Path: <linux-pci+bounces-45099-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15435D39495
	for <lists+linux-pci@lfdr.de>; Sun, 18 Jan 2026 12:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 666AE300F312
	for <lists+linux-pci@lfdr.de>; Sun, 18 Jan 2026 11:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE172D6E61;
	Sun, 18 Jan 2026 11:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WLNqJRid"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A7D1FF1B5
	for <linux-pci@vger.kernel.org>; Sun, 18 Jan 2026 11:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768737215; cv=none; b=X+J8CO1hAQz1nIFCpHk2DhgRGH51fYOQDTwHwl5XrkTOBoHFf4I1XUK+yMKA5QgvCted59EYCbT040jTenwKZqnBxCpKsx2HbZb6Nnj4KDH4edt+4zvjX4UjMbxgdI92GCK4ymau2B/oTgqBpAZNTgwJfJfs3h30Ul+n8fnpn2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768737215; c=relaxed/simple;
	bh=S3NdjElUJtQhr/4uxxJSWTKvokWjMPkKaDS/S/p0lyA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I/Qf1GxdwhszeSxBPdHVVgVsvb/CI8sarrret0UoYGr/RPUVn2nD3AGYcTNJCRnvQsmAobTloYzZCubv2eAlFD6uR8UsqAOkczYbUozDsKS1qId9JYRH3NUKYsGIm63SV3nF9wgiYRmd9OUWb0sapLD5tPsfu2VDJoMfsNl1axQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WLNqJRid; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33175C19425
	for <linux-pci@vger.kernel.org>; Sun, 18 Jan 2026 11:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768737215;
	bh=S3NdjElUJtQhr/4uxxJSWTKvokWjMPkKaDS/S/p0lyA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WLNqJRidt6TYmxEHHzNsraapn7CzAizp4wHYOAyDBUiyJe5DNO2woXnqRN6yVQ8Rd
	 6lpKIls7C83b8JMUEzFopjUARMp+RbSVsmYdkWbb+ToEi1wG0O7HfEJ4MylByiSVo2
	 LM+36Zyt5sO8MeFC/igwYV38zfl9llG5IZr12XnNlI1dsrrVmOobMFYmpRU3ZIRmc8
	 02nV9St6eOUjJ8jtcDIj3AnKP0OQvTOVs9EPorxi9RE9esGQnjRaFrWJF+ux6N9Sxk
	 /xiZ4vo8S9R4ze/Q+0UCzr85cDl29W3BG2IJAHG2Kl/HBMOLpA5sAu/j1P+hpp24bw
	 GgrTSBo5URVyQ==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-4045ccdd239so628491fac.2
        for <linux-pci@vger.kernel.org>; Sun, 18 Jan 2026 03:53:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWZJlneKNBDtyZ6H70kdaCsEIDHYqUrUjltXvRZMiEyQq9B5z4bM4qCmrB2LuODgTOwZYZL5wJZuh4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG3VsviFtr0x3lSlUec9cO+Yy4gfObUYX3I/WXiqwef7AQyOBf
	9SqIUgdqVsjC7jGAfn4uSKpYIg3bjZ+J1xba9OwpzItPCS9rW7/1n7cmUvBrWOWBbAwS9tt9V6l
	3FJtJm0WKGDOvsPiiVRDTJylSV+ntuf0=
X-Received: by 2002:a05:6820:606:b0:65f:6bcd:e32 with SMTP id
 006d021491bc7-661179db6ffmr3551350eaf.58.1768737214199; Sun, 18 Jan 2026
 03:53:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260106222715.GA381397@bhelgaas> <CGME20260114094643eucas1p1a2fdc6c35dd27741c18831b34bbed0c8@eucas1p1.samsung.com>
 <0e35a4e1-894a-47c1-9528-fc5ffbafd9e2@samsung.com> <aWf4KyTSIocWTmXw@google.com>
 <61e8c93c-d096-4807-b2dd-a22657f2e06a@samsung.com> <aWrjhqC_6I2UNXC5@google.com>
In-Reply-To: <aWrjhqC_6I2UNXC5@google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sun, 18 Jan 2026 12:53:21 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hWt63=0yjFrbTY8zXubh-Uc6ZwAndT73VL7itMkTe81A@mail.gmail.com>
X-Gm-Features: AZwV_QjxItLuTLLc1mPReiJ0jc1HFHAAV_QkbHDqfukYWmKdgdQRTtLi0nOghIk
Message-ID: <CAJZ5v0hWt63=0yjFrbTY8zXubh-Uc6ZwAndT73VL7itMkTe81A@mail.gmail.com>
Subject: Re: [PATCH v4] PCI/PM: Prevent runtime suspend before devices are
 fully initialized
To: Brian Norris <briannorris@chromium.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-pm@vger.kernel.org, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 17, 2026 at 2:19=E2=80=AFAM Brian Norris <briannorris@chromium.=
org> wrote:
>
> Hi Marek,
>
> On Thu, Jan 15, 2026 at 12:14:49PM +0100, Marek Szyprowski wrote:
> > On 14.01.2026 21:10, Brian Norris wrote:
> > > On Wed, Jan 14, 2026 at 10:46:41AM +0100, Marek Szyprowski wrote:
> > >> On 06.01.2026 23:27, Bjorn Helgaas wrote:
> > >>> On Thu, Oct 23, 2025 at 02:09:01PM -0700, Brian Norris wrote:
> > >>>> Today, it's possible for a PCI device to be created and
> > >>>> runtime-suspended before it is fully initialized. When that happen=
s, the
> > >>>> device will remain in D0, but the suspend process may save an
> > >>>> intermediate version of that device's state -- for example, withou=
t
> > >>>> appropriate BAR configuration. When the device later resumes, we'l=
l
> > >>>> restore invalid PCI state and the device may not function.
> > >>>>
> > >>>> Prevent runtime suspend for PCI devices by deferring pm_runtime_en=
able()
> > >>>> until we've fully initialized the device.
> > > ...
> > >> This patch landed recently in linux-next as commit c796513dc54e
> > >> ("PCI/PM: Prevent runtime suspend until devices are fully initialize=
d").
> > >> In my tests I found that it sometimes causes the "pci 0000:01:00.0:
> > >> runtime PM trying to activate child device 0000:01:00.0 but parent
> > >> (0000:00:00.0) is not active" warning on Qualcomm Robotics RB5 board
> > >> (arch/arm64/boot/dts/qcom/qrb5165-rb5.dts). This in turn causes a
> > >> lockdep warning about console lock, but this is just a consequence o=
f
> > >> the runtime pm warning. Reverting $subject patch on top of current
> > >> linux-next hides this warning.
> > >>
> > >> Here is a kernel log:
> > >>
> > >> pci 0000:01:00.0: [17cb:1101] type 00 class 0xff0000 PCIe Endpoint
> > >> pci 0000:01:00.0: BAR 0 [mem 0x00000000-0x000fffff 64bit]
> > >> pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
> > >> pci 0000:01:00.0: 4.000 Gb/s available PCIe bandwidth, limited by 5.=
0
> > >> GT/s PCIe x1 link at 0000:00:00.0 (capable of 7.876 Gb/s with 8.0 GT=
/s
> > >> PCIe x1 link)
> > >> pci 0000:01:00.0: Adding to iommu group 13
> > >> pci 0000:01:00.0: ASPM: default states L0s L1
> > >> pcieport 0000:00:00.0: bridge window [mem 0x60400000-0x604fffff]: as=
signed
> > >> pci 0000:01:00.0: BAR 0 [mem 0x60400000-0x604fffff 64bit]: assigned
> > >> pci 0000:01:00.0: runtime PM trying to activate child device
> > >> 0000:01:00.0 but parent (0000:00:00.0) is not active
> > > Thanks for the report. I'll try to look at reproducing this, or at le=
ast
> > > getting a better mental model of exactly why this might fail (or,
> > > "warn") this way. But if you have the time and desire to try things o=
ut
> > > for me, can you give v1 a try?
> > >
> > > https://lore.kernel.org/all/20251016155335.1.I60a53c170a8596661883bd2=
b4ef475155c7aa72b@changeid/
> > >
> > > I'm pretty sure it would not invoke the same problem.
> >
> > Right, this one works fine.
> >
> > > I also suspect v3
> > > might not, but I'm less sure:
> > >
> > > https://lore.kernel.org/all/20251022141434.v3.1.I60a53c170a8596661883=
bd2b4ef475155c7aa72b@changeid/
> > This one too, at least I was not able to reproduce any fail.
>
> Thanks for testing. I'm still not sure exactly how to reproduce your
> failure, but it seems as if the root port is being allowed to suspend
> before the endpoint is added to the system, and it remains so while the
> endpoint is about to probe. device_initial_probe() will be OK with
> respect to PM, since it will wake up the port if needed. But this
> particular code is not OK, since it doesn't ensure the parent device is
> active while preparing the endpoint power state.
>
> I suppose one way to "solve" that is (untested):
>
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -380,8 +380,12 @@ void pci_bus_add_device(struct pci_dev *dev)
>                 put_device(&pdev->dev);
>         }
>
> +       if (dev->dev.parent)
> +               pm_runtime_get_sync(dev->dev.parent);
>         pm_runtime_set_active(&dev->dev);
>         pm_runtime_enable(&dev->dev);
> +       if (dev->dev.parent)
> +               pm_runtime_put(dev->dev.parent);
>
>         if (!dn || of_device_is_available(dn))
>                 pci_dev_allow_binding(dev);
>
> Personally, I'm more inclined to go back to v1, since it prepares the
> runtime PM status when the device is first discovered. That way, its
> ancestors are still active, avoiding these sorts of problems. I'm
> frankly not sure of all the reasons Rafael recommended I make the
> v1->v3->v4 changes, and now that they cause problems, I'm inclined to
> question them again.
>
> Rafael, do you have any thoughts?

Yeah.

Move back pm_runtime_set_active(&dev->dev) back to pm_runtime_init()
because that would prevent the parent from suspending and keep
pm_runtime_enable() here because that would prevent the device itself
from suspending between pm_runtime_init() and this place.

And I would add comments in both places.

