Return-Path: <linux-pci+bounces-42224-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9AEC8FE77
	for <lists+linux-pci@lfdr.de>; Thu, 27 Nov 2025 19:22:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5ABF64E32C5
	for <lists+linux-pci@lfdr.de>; Thu, 27 Nov 2025 18:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33593009FC;
	Thu, 27 Nov 2025 18:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t5If9gO+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC783002DF
	for <linux-pci@vger.kernel.org>; Thu, 27 Nov 2025 18:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764267769; cv=none; b=IYB8G2qa5yKlBj1a8zeV+U4InytSdtzSX9zY3Nk13jxuh6HP4s3x7HB2ZsFiYGguTcQ4niheID6Ced6wpW2jBnWWpbL6hE1eB5aX15EJFPjHo72r2uxudDcSczIKBDmcG++CIlMzPcckptJaG15C8wDxqxDqXZpk6K4mNaVfcu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764267769; c=relaxed/simple;
	bh=2zh5IckA93jcXpcP2jg/bB2AVaYgRYS+ot7BWC5MT2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S8FxMWcflrWADy/KxoCPfhi/IyQxYhW4E24CgAybU0iZMz2lfSwJ68ter1wBpUgbwXBInkeUkVsuC5VSsRzKDp3rYZuybDOLcbYWggyctxdh76ppmcmPEHCSDBGMsOyQzIypX9sSEo7TXp8N67sA3a/zI7L6js1mHCxAfqSDZ0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t5If9gO+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BEB4C2BC86
	for <linux-pci@vger.kernel.org>; Thu, 27 Nov 2025 18:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764267769;
	bh=2zh5IckA93jcXpcP2jg/bB2AVaYgRYS+ot7BWC5MT2A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=t5If9gO++OOilnxFrwBrkBC309GX2ZWoD+KuNyiD5dUztBFiu96epD55nIlqdm2bE
	 I629s/i5ebpTIV1f8i9y5LxYTw1ElYOyDOS7zh8yoLRb12SJMkNSTl/k5UVdiV9Wcx
	 4pI9IStlpgObJIRTRBZMtk1aAK13fAJZM4p9nuCNWNYZMgi9MXm7gEip+9kip1t60N
	 fsKjao8brX5y0iEjBEnKN0hZgNGxRVvpYBmlN4f60tM41YnF3OOyz3ScwQfNNPuO1O
	 tD5BH4EMod/AgIyuDOrhBKsWuQJMKPloN85ij5AbiVt3+3bxe8+vH/r2iPJ0jTChzF
	 Psdd0ZmiQoKyA==
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7c75fc222c3so408196a34.0
        for <linux-pci@vger.kernel.org>; Thu, 27 Nov 2025 10:22:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWqlz9gWnQPAaCZyEF4VJUHzU5VV8DqOgnJYu9Pgh2ZZENR0PvIg465xHi1PNvDOomtAss8PeF6LJw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCoERnoYfx3U4yopn42zX8zeANSbln1nz6tX5lRSTdeHh3jAcv
	aVsMseHnmG9xUjd6llCreJ5YIQGDh4wT+04RD5WJPbJZE/ah8BQC3BjAHTCbCsFS517zw1C/CJ5
	wWYYc+cw6laPmLaUgnI9MJeFyF+A3nt0=
X-Google-Smtp-Source: AGHT+IH1bZuq2107Z9vV3tIssGfEt3HKcvXwJtichyRCHN4NG+9zrGINSBUFfZp8A6sCqAX7wGBoKCjmIoVGx2W+fiQ=
X-Received: by 2002:a05:6808:1803:b0:44d:a972:f48d with SMTP id
 5614622812f47-45115ade7bcmr8045952b6e.51.1764267768535; Thu, 27 Nov 2025
 10:22:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251120-thermal-device-v1-0-bbdad594d57a@gmx.de>
 <CAJZ5v0jOPrBcozzJMsB1eE12MuZRWDAV-+=jfrhJbi=S0p5J9Q@mail.gmail.com> <5f3ef610-4024-4ca0-a934-2649f5d25f40@gmx.de>
In-Reply-To: <5f3ef610-4024-4ca0-a934-2649f5d25f40@gmx.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 27 Nov 2025 19:22:37 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hdqY-=O5Ai6c5qjMr_pRFc+SDyV1QruM=ZeHH9Z=guSg@mail.gmail.com>
X-Gm-Features: AWmQ_bmQtAcoPswZk2AImBNuJ-60z5nmzzYc3vdfnDFN0Jddf0LEskGxktPDRCM
Message-ID: <CAJZ5v0hdqY-=O5Ai6c5qjMr_pRFc+SDyV1QruM=ZeHH9Z=guSg@mail.gmail.com>
Subject: Re: [PATCH RFC RESEND 0/8] thermal: core: Allow setting the parent
 device of thermal zone/cooling devices
To: Armin Wolf <W_Armin@gmx.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Len Brown <lenb@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-tegra@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-doc@vger.kernel.org, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org, ath10k@lists.infradead.org, 
	ath11k@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, platform-driver-x86@vger.kernel.org, 
	linux-pci@vger.kernel.org, imx@lists.linux.dev, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 22, 2025 at 3:18=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wrote:
>
> Am 21.11.25 um 21:35 schrieb Rafael J. Wysocki:
>
> > On Thu, Nov 20, 2025 at 4:41=E2=80=AFAM Armin Wolf <W_Armin@gmx.de> wro=
te:

[...]

> >> ---
> >> Armin Wolf (8):
> >>        thermal: core: Allow setting the parent device of cooling devic=
es
> >>        thermal: core: Set parent device in thermal_of_cooling_device_r=
egister()
> >>        ACPI: processor: Stop creating "device" sysfs link
> >
> > That link is not to the cooling devices' parent, but to the ACPI
> > device object (a struct acpi_device) that corresponds to the parent.
> > The parent of the cooling device should be the processor device, not
> > its ACPI companion, so I'm not sure why there would be a conflict.
>
>  From the perspective of the Linux device core, a parent device does not =
have to be
> a "physical" device. In the case of the ACPI processor driver, the ACPI d=
evice is used,
> so the cooling device registered by said driver belongs to the ACPI devic=
e.

Well, that's a problem.  A struct acpi_device should not be a parent
of anything other than a struct acpi_device.

> I agree that using the Linux processor device would make more sense, but =
this will require
> changes inside the ACPI processor driver.

So be it.

> As for the "device" symlink: The conflict would be a naming conflict, as =
both "device" symlinks
> (the one created by the ACPI processor driver and the one created by the =
device core) will
> be created in the same directory (which is the directory of the cooling d=
evice).

I see.

But why is the new symlink needed in the first place?  If the device
has a parent, it will appear under that parent in /sys/devices/, won't
it?

Currently, all of the thermal class devices appear under
/sys/devices/virtual/thermal/ because they have no parents and they
all get a class parent kobject under /sys/devices/virtual/, as that's
what get_device_parent() does.

If they have real parents, they will appear under those parents, so
why will the parents need to be pointed to additionally?

BTW, this means that the layout of /sys/devices/ will change when
thermal devices get real parents.  I'm not sure if this is a problem,
but certainly something to note.

> >>        ACPI: fan: Stop creating "device" sysfs link
> >>        ACPI: video: Stop creating "device" sysfs link
> > Analogously in the above two cases AFAICS.
> >
> > The parent of a cooling device should be a "physical" device object,
> > like a platform device or a PCI device or similar, not a struct
> > acpi_device (which in fact is not a device even).
>
>  From the perspective of the Linux device core, a ACPI device is a perfec=
tly valid device.

The driver core is irrelevant here.

As I said before, a struct acpi_device object should not be a parent
of anything other than a struct acpi_device object.  Those things are
not devices and they cannot be used for representing PM dependencies,
for example.

> I agree that using a platform device or PCI device is better, but this al=
ready happens
> inside the ACPI fan driver (platform device).

So it should not happen there.

> Only the ACPI video driver created a "device" sysfs link that points to t=
he ACPI device
> instead of the PCI device. I just noticed that i accidentally changed thi=
s by using the
> PCI device as the parent device for the cooling device.
>
> If you want then we can keep this change.

The PCI device should be its parent.

> >>        thermal: core: Set parent device in thermal_cooling_device_regi=
ster()
> >>        ACPI: thermal: Stop creating "device" sysfs link
> > And this link is to the struct acpi_device representing the thermal zon=
e itself.
>
> Correct, the ACPI thermal zone driver is a ACPI driver, meaning that he b=
inds to
> ACPI devices. Because of this all (thermal zone) devices created by an in=
stance of
> said driver are descendants of the ACPI device said instance is bound to.
>
> We can of course convert the ACPI thermal zone driver into a platform dri=
ver, but
> this would be a separate patch series.

If you want parents, this needs to be done first, but I'm still not
sure what the parent of a thermal zone would represent.

In the ACPI case it is kind of easy - it would be the (platform)
device corresponding to a given ThermalZone object in the ACPI
namespace - but it only has a practical meaning if that device has a
specific parent.  For example, if the corresponding ThermalZone object
is present in the \_SB scope, the presence of the thermal zone parent
won't provide any additional information.

Unfortunately, the language in the specification isn't particularly
helpful here: "Thermal zone objects should appear in the namespace
under the portion of the system that comprises the thermal zone. For
example, a thermal zone that is isolated to a docking station should
be defined within the scope of the docking station device."  To me
"the portion of the system" is not too meaningful unless it is just
one device without children.  That's why _TZD has been added AFAICS.

> >>        thermal: core: Allow setting the parent device of thermal zone =
devices
> >
> > I'm not sure if this is a good idea, at least until it is clear what
> > the role of a thermal zone parent device should be.
>
> Take a look at my explanation with the Intel Wifi driver.

I did and I think that you want the parent to be a device somehow
associated with the thermal zone, but how exactly?  What should that
be in the Wifi driver case, the PCI device or something else?

And what if the thermal zone affects multiple devices?  Which of them
(if any) would be its parent?  And would it be consistent with the
ACPI case described above?

All of that needs consideration IMV.

