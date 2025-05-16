Return-Path: <linux-pci+bounces-27874-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83AC7AB9F46
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 17:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B6211C027EB
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 15:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152451F417E;
	Fri, 16 May 2025 14:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V6xMM9Jw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2101F2BAB;
	Fri, 16 May 2025 14:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747407526; cv=none; b=ijB6i7Kcvb9mtu4+tDlj1E803NOeHIlMz2l9e4M2gg/84bAYxSqBYkqFErCMSdnPAnbyTSeF9E2OgUEfZHCsvEIef8SmRXIgWw3QMbUfAWnDUPLc33ej+vl+OeCkkkfhiZS52kxRe+njMLs62jy1vlKeXG8H7dvNzkhyqAIPmvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747407526; c=relaxed/simple;
	bh=hDbT6l8Ra4g1YkirifZKoYMzeq+3uNXkWZ7n3nMfPI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J8yScT+TKpYq0ow1gWD37zOuimhcVY5HGfNKnGfu5JZ223/p/aCd0LJ/Fm2bFluozhdAyCvPrZs05SC4ebuL68BQ5DUCAAs2YedY2USdWSGM/nlYm0mQdjw1T/TxB3e6bBKxTdaApYK1mWInummIB1RN5fCbguoZxWzPrKUfSik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V6xMM9Jw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EBECC4CEF9;
	Fri, 16 May 2025 14:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747407525;
	bh=hDbT6l8Ra4g1YkirifZKoYMzeq+3uNXkWZ7n3nMfPI8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=V6xMM9JwEfvlz1axejebsqy7HHf6Fip3sstL6Sgp+uQ/M+5YQpvGbMSj7tWa7P4Kh
	 gPzHqZct2qk6Jj2jZ3KWGdr9FkAioGUV5xb8O3uhHJ7Ij1OnApX9wR1FaMjGQIx4nQ
	 YXgkij3UEeE8qCfCiEhDzy/O//cmoJT9Bd7Ngfw6xJERTATXOmM8i0ku9jAcgUwWVz
	 vqdk6Bpuf4mnYOm84fkg3qtzwA7+IFO250Y6zuFhXuYq+2M+cxA0HCqPlXwMGYIuJg
	 pM4ZuFeofvURRluv165gKSjhz128QC86DfzOofsfFarLShF7HQr7wX4ybN/17+3L3n
	 Rwgq3d2ir+MNg==
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b26df8f44e6so1883008a12.2;
        Fri, 16 May 2025 07:58:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU0pgWrUFR+HSRruF2rRUUWD26nqwr1rZOPyPQQ332K++0NS8N+qb2825+CnAhdY3QTONBHa9+hAIw=@vger.kernel.org, AJvYcCV43CZXYypZ6nBEc2OGVuRATHydMvqqjH2EEzRb6gvzvEAJBlLE5+7bn3w1HDz/lVPCWNKx8khVn9wyjzs=@vger.kernel.org, AJvYcCWXCl5w8k4PHrY/S/VolN5ENT8+H3vb8iTg6gweqdSyn2HXAb45AyxyTH66xU6ytXCCXF1123p3JdIt@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi+lHkNqxK3CXJtsEVEKxBq5sq9UlqON8Zrm5Tlp6KYAFzR+Z+
	4/4WRNKPsbDKArxwMKZq8t87brf+DYQoEunAADEsqTgJEKNPKdGFQ+AO9vO9nk08b68O+4apNhA
	GYINWYLCf8uyHNet8CnTVHP0xVrDByEE=
X-Google-Smtp-Source: AGHT+IF5oHQ3XiAHYu26SgYpqkEnmMVmix54PXMDrlWr+tTbxJJdHTghAEF9U7opguKYaqW8+b2I34wPBroq6Ou90Xg=
X-Received: by 2002:a05:6820:1792:b0:608:3f1d:bbdb with SMTP id
 006d021491bc7-609f37ac4d0mr1916015eaf.8.1747407513779; Fri, 16 May 2025
 07:58:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250514193406.3998101-1-superm1@kernel.org> <20250514193406.3998101-2-superm1@kernel.org>
In-Reply-To: <20250514193406.3998101-2-superm1@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 16 May 2025 16:58:22 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jifqTP_eZ33nBmKPCuLWrrVF_0jNGf5CpHU6nXuK8qBw@mail.gmail.com>
X-Gm-Features: AX0GCFvRVOcB0kGKWz9Xrc6Hm7LoXkhsAklO5VHQqK_W1PeYhcRLJ3-5UfSo-D0
Message-ID: <CAJZ5v0jifqTP_eZ33nBmKPCuLWrrVF_0jNGf5CpHU6nXuK8qBw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] PM: Use hibernate flows for system power off
To: Mario Limonciello <superm1@kernel.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Alex Deucher <alexander.deucher@amd.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, 
	"open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>, 
	"open list:HIBERNATION (aka Software Suspend, aka swsusp)" <linux-pm@vger.kernel.org>, 
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	Mario Limonciello <mario.limonciello@amd.com>, AceLan Kao <acelan.kao@canonical.com>, 
	Kai-Heng Feng <kaihengf@nvidia.com>, Mark Pearson <mpearson-lenovo@squebb.ca>, 
	=?UTF-8?Q?Merthan_Karaka=C5=9F?= <m3rthn.k@gmail.com>, 
	Denis Benato <benato.denis96@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 14, 2025 at 9:34=E2=80=AFPM Mario Limonciello <superm1@kernel.o=
rg> wrote:
>
> From: Mario Limonciello <mario.limonciello@amd.com>
>
> When the system is powered off the kernel will call device_shutdown()
> which will issue callbacks into PCI core to wake up a device and call
> it's shutdown() callback.  This will leave devices in ACPI D0 which can
> cause some devices to misbehave with spurious wakeups and also leave some
> devices on which will consume power needlessly.
>
> The issue won't happen if the device is in D3 before system shutdown, so
> putting device to low power state before shutdown solves the issue.
>
> ACPI Spec 6.5, "7.4.2.5 System \_S4 State" says "Devices states are
> compatible with the current Power Resource states. In other words, all
> devices are in the D3 state when the system state is S4."
>
> The following "7.4.2.6 System \_S5 State (Soft Off)" states "The S5
> state is similar to the S4 state except that OSPM does not save any
> context." so it's safe to assume devices should be at D3 for S5.
>
> To accomplish this, modify the PM core to call all the device hibernate
> callbacks when turning off the system when the kernel is compiled with
> hibernate support. If compiled without hibernate support or hibernate fai=
ls
> fall back into the previous shutdown flow.
>
> Cc: AceLan Kao <acelan.kao@canonical.com>
> Cc: Kai-Heng Feng <kaihengf@nvidia.com>
> Cc: Mark Pearson <mpearson-lenovo@squebb.ca>
> Cc: Merthan Karaka=C5=9F <m3rthn.k@gmail.com>
> Tested-by: Denis Benato <benato.denis96@gmail.com>
> Link: https://lore.kernel.org/linux-pci/20231213182656.6165-1-mario.limon=
ciello@amd.com/
> Link: https://lore.kernel.org/linux-pci/20250506041934.1409302-1-superm1@=
kernel.org/
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v2:
>  * Handle failures to hibernate (fall back to shutdown)
>  * Don't use dedicated events
>  * Only allow under CONFIG_HIBERNATE_CALLBACKS
> ---
>  kernel/reboot.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/kernel/reboot.c b/kernel/reboot.c
> index ec087827c85cd..52f5e6e36a6f8 100644
> --- a/kernel/reboot.c
> +++ b/kernel/reboot.c
> @@ -13,6 +13,7 @@
>  #include <linux/kexec.h>
>  #include <linux/kmod.h>
>  #include <linux/kmsg_dump.h>
> +#include <linux/pm.h>
>  #include <linux/reboot.h>
>  #include <linux/suspend.h>
>  #include <linux/syscalls.h>
> @@ -305,6 +306,17 @@ static void kernel_shutdown_prepare(enum system_stat=
es state)
>                 (state =3D=3D SYSTEM_HALT) ? SYS_HALT : SYS_POWER_OFF, NU=
LL);
>         system_state =3D state;
>         usermodehelper_disable();
> +#ifdef CONFIG_HIBERNATE_CALLBACKS
> +       if (dpm_suspend_start(PMSG_HIBERNATE))
> +               goto resume_devices;

A failure of one device may trigger a cascade of failures when trying
to resume devices and it is not even necessary to resume the ones that
have been powered off successfully.

IMV this should just ignore errors during the processing of devices,
so maybe introduce PMSG_POWEROFF for it?

It should also ignore wakeup events that occur while devices are powered of=
f.

> +       if (dpm_suspend_end(PMSG_HIBERNATE))
> +               goto resume_devices;
> +       return;
> +
> +resume_devices:
> +       pr_emerg("Failed to power off devices, using shutdown instead.\n"=
);
> +       dpm_resume_end(PMSG_RESTORE);

Unfortunately, PMSG_RESTORE is not the right resume action for
PMSG_HIBERNATE because it may not power-up things (some drivers assume
that the restore kernel will power-up devices and so they don't do it
in "restore" callbacks).

I do realize that hibernation uses it to reverse PMSG_HIBERNATE, but
it should not do that either.  That may be fixed later, though.

> +#endif
>         device_shutdown();
>  }
>  /**
> --

I'd prefer to get back to this series after the 6.16 merge window
starts.  It is sort of last minute for 6.16 and it is far from ready
IMV.

Thanks!

