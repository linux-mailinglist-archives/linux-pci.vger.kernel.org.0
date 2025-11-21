Return-Path: <linux-pci+bounces-41896-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E79C7BA67
	for <lists+linux-pci@lfdr.de>; Fri, 21 Nov 2025 21:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11C1F3A6C05
	for <lists+linux-pci@lfdr.de>; Fri, 21 Nov 2025 20:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D5C30277A;
	Fri, 21 Nov 2025 20:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GIDqRIAe"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2863002D8
	for <linux-pci@vger.kernel.org>; Fri, 21 Nov 2025 20:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763757359; cv=none; b=LhBUZyg219CF6xZsR0o8wddY6/ygh3nfrOx43byX3wQ4r2jhEG16TdZXceYztQWzcDJS5qIv2uPfpEEW/i+VQU8TxNE3idRiWTn6SovZGK7vzwZjv8w+5lz0KHMOgpy5Br/g25N/uhyTr0cxBlz/dbhDyk8VHgfdMqdX07z00ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763757359; c=relaxed/simple;
	bh=meSktXQNs/zDvTr1rLs7LeQfxQysPHSbGkzQDId9XMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FhUzeFsRFQ5SjwbXfC/is2fZLS/N8aJaURXI5/Ppjs7lSDZRsrNSbNtZoRsNuy8yiFFZSPSxySDVGTB6389Wo++UoNc5Wr1b3CMftoNI5qvG2QUIqRMJgijsyWDAQ/WFCwYt1DmeOCFJolx2MbdjOTCyPiIeHvxcGmfuioGJlyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GIDqRIAe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 120F3C19423
	for <linux-pci@vger.kernel.org>; Fri, 21 Nov 2025 20:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763757359;
	bh=meSktXQNs/zDvTr1rLs7LeQfxQysPHSbGkzQDId9XMY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GIDqRIAeWCLUdym8Wrp+ILSVdv2LpkMXpn0ppo5qMOFJZ1oZaxiKDGg8iPM0FJY1s
	 xTWonD8QTxzg+NoawORzto1WVHmzTaefcu6CspzqLaIyzwaxWJHh25II1oOIaDUIl6
	 1Gv99d5j9mN0iRUZR9qsmaDeXgeI67gIGIdZRp5mhT+ooUS+9sAXl8x8iCyIEtWww2
	 X2tSjzMAm8MVVq7huy4kmvK3DvxgkoZW8hmO+4gf5ak+DyuAu6ykC33HVejuDy6dAf
	 fIFGOhB9dq4OTO2bOYWqzyTQ+/yo3YA9ORfBTLAd7tw9EH+5bLrhk5diw3++qmfF6X
	 dnnJ+5gDm7D4g==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-656b0bd47b8so504043eaf.0
        for <linux-pci@vger.kernel.org>; Fri, 21 Nov 2025 12:35:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXAJB1aHcZpI6O2ORT/iX+1R5kCmNw5NWBJRGG8R+11N9f2Nk9ja+9TtmqH7oaxOJ1h1CIjKJ+Q338=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyjNa7Rr2wcZJVTmvp6gCu4ncGbll8Hl9c7iM18Vp+PPRgTBUe
	u8NmoQYNLyLA3P2WaIXu15QEetwIjCARIXoQsDbDWXgbmrjbvXosZEqPO2PwChfpYFb7cYwDEFG
	pIKW6Wyd17bShBPLoxnj4v413MwupfuU=
X-Google-Smtp-Source: AGHT+IEGV1wW0AyQ4uV5rOeWs+mu0pohToH8QfmqGgzcM1nDvWFgodvXp8dfzsS7PUq8QlplylLWmLPmTb2ii+XtGZ8=
X-Received: by 2002:a05:6820:4d57:10b0:657:7289:b1dc with SMTP id
 006d021491bc7-65792596028mr1028369eaf.6.1763757357967; Fri, 21 Nov 2025
 12:35:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251120-thermal-device-v1-0-bbdad594d57a@gmx.de>
In-Reply-To: <20251120-thermal-device-v1-0-bbdad594d57a@gmx.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 21 Nov 2025 21:35:47 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jOPrBcozzJMsB1eE12MuZRWDAV-+=jfrhJbi=S0p5J9Q@mail.gmail.com>
X-Gm-Features: AWmQ_bmY4Rgl1Z4nj5ks6gNTVnBjHocEaNjk9D0MQSLHqvtZo8fqobTCygtTNLc
Message-ID: <CAJZ5v0jOPrBcozzJMsB1eE12MuZRWDAV-+=jfrhJbi=S0p5J9Q@mail.gmail.com>
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

On Thu, Nov 20, 2025 at 4:41=E2=80=AFAM Armin Wolf <W_Armin@gmx.de> wrote:
>
> Drivers registering thermal zone/cooling devices are currently unable
> to tell the thermal core what parent device the new thermal zone/
> cooling device should have, potentially causing issues with suspend
> ordering

This is one potential class of problems that may arise, but I would
like to see a real example of this.

As it stands today, thermal_class has no PM callbacks, so there are no
callback execution ordering issues with devices in that class and what
other suspend/resume ordering issues are there?

Also, the suspend and resume of thermal zones is handled via PM
notifiers.  Is there a problem with this?

> and making it impossible for user space applications to
> associate a given thermal zone device with its parent device.

Why does user space need to know the parent of a given cooling device
or thermal zone?

> This patch series aims to fix this issue by extending the functions
> used to register thermal zone/cooling devices to also accept a parent
> device pointer. The first six patches convert all functions used for
> registering cooling devices, while the functions used for registering
> thermal zone devices are converted by the remaining two patches.
>
> I tested this series on various devices containing (among others):
> - ACPI thermal zones
> - ACPI processor devices
> - PCIe cooling devices
> - Intel Wifi card
> - Intel powerclamp
> - Intel TCC cooling

What exactly did you do to test it?

> I also compile-tested the remaining affected drivers, however i would
> still be happy if the relevant maintainers (especially those of the
> mellanox ethernet switch driver) could take a quick glance at the
> code and verify that i am using the correct device as the parent
> device.

I think that the above paragraph is not relevant any more?

> This work is also necessary for extending the ACPI thermal zone driver
> to support the _TZD ACPI object in the future.

I'm still unsure why _TZD support requires the ability to set a
thermal zone parent device.

> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
> Armin Wolf (8):
>       thermal: core: Allow setting the parent device of cooling devices
>       thermal: core: Set parent device in thermal_of_cooling_device_regis=
ter()
>       ACPI: processor: Stop creating "device" sysfs link

That link is not to the cooling devices' parent, but to the ACPI
device object (a struct acpi_device) that corresponds to the parent.
The parent of the cooling device should be the processor device, not
its ACPI companion, so I'm not sure why there would be a conflict.

>       ACPI: fan: Stop creating "device" sysfs link
>       ACPI: video: Stop creating "device" sysfs link

Analogously in the above two cases AFAICS.

The parent of a cooling device should be a "physical" device object,
like a platform device or a PCI device or similar, not a struct
acpi_device (which in fact is not a device even).

>       thermal: core: Set parent device in thermal_cooling_device_register=
()
>       ACPI: thermal: Stop creating "device" sysfs link

And this link is to the struct acpi_device representing the thermal zone it=
self.

>       thermal: core: Allow setting the parent device of thermal zone devi=
ces

I'm not sure if this is a good idea, at least until it is clear what
the role of a thermal zone parent device should be.

