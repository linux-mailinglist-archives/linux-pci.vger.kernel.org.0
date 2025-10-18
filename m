Return-Path: <linux-pci+bounces-38580-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DD6BECE99
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 13:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25AF619C0F93
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 11:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785B624DD00;
	Sat, 18 Oct 2025 11:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PgOGKuAs"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5302E199252
	for <linux-pci@vger.kernel.org>; Sat, 18 Oct 2025 11:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760786851; cv=none; b=HrvUVyx5PNoJtHpvJUH1qWIGHwwxPhyZvmsR4ojKrR4Zmenm+ZT256slWfhK/xjMrNFpezaO+UrD4wapMKbQZlydkdOjMsSIQ5gL6mNLDt3+4JXbZukyrDrxn1ImTVL4ymFtDv0uNt12Jc8/V++GD2okIks2Ju5jvTCJH8l3ScE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760786851; c=relaxed/simple;
	bh=gf3HoOxKt4m1NqIGatZeeHhS1uuAWLXIJ3lR3WwC8o4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ui6gB9FO/6yuwKnWZ52qNm2gxheyUk+8ClUumilBUeHNVLgtfzgVljZ0qZKfziK0THIkaUNcNVPtnihh+ICpuQ6fEgdP4ksjmnKGQMHuZnGWCGlmaz+iwXsDX33oA78Ri3gKiIH0wLMtrzsGcu/M6Xgm9mXD8R23mPoYfuCcGL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PgOGKuAs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7841C4CEFE
	for <linux-pci@vger.kernel.org>; Sat, 18 Oct 2025 11:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760786850;
	bh=gf3HoOxKt4m1NqIGatZeeHhS1uuAWLXIJ3lR3WwC8o4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PgOGKuAsorU61nUkU7lKixF2L5wpvtfPfzAGKcOwOXy9CQt/I0q12M6XeZWDpLtyW
	 93rifESjc4MA+/E+hW9TP6FNEoeWHFWvjONj6qlDF+6OkRLPIwF0n/8+RgFTWUW81V
	 xjZ/0NizBg46kz+FJCof8/iobP8ewoe6Y7RxoQK/TslpoBLDeu4R8RlYGD1tPtejAt
	 ptygb4YCvlhTslcj2KVDxLx1o1xL6UgJ6tnm8Wh8LYSiQOSONA9ldiCrcnf1fPeKkc
	 LU6TaHZqEQMaRk8tJAkDrJx2Q67sr+QwxBvB1vKDDDqZybg6mx84ln/4BUBF3nWFtz
	 W6fyUmHwl+Jfg==
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7c280b71af9so501986a34.2
        for <linux-pci@vger.kernel.org>; Sat, 18 Oct 2025 04:27:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUni4OLYXkpCPGevt7n1Den4ueEzkyVsQ/m96taU3ltF6EB7NAHS32e5Q2YnW/NtInKBz+NFn54mSM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiikJvcwP/JgV1h0uvXaauVU0AxqMw9l/syxykwXejUpRx0KLa
	OZcTH9phD3+3Mk57pvGuooDQRx3hn+KkrMPhQSEM6IzL5pN9QdgHWhf55lH9Kt6Oe4C1DnIasxV
	hG0dC9k+7qqSNlb2U4bqQX4BjmV7D8DY=
X-Google-Smtp-Source: AGHT+IEqtAjX7bGgXFLTiXHINPUgRACxPa5e5SbtFa0/3L8xX27Do+XIrKmU1uLH+LDyENKH88LxrEs2OHkNKCwG2EE=
X-Received: by 2002:a05:6808:1a16:b0:43d:43a5:ccaf with SMTP id
 5614622812f47-443a2fb214amr2650331b6e.43.1760786850233; Sat, 18 Oct 2025
 04:27:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017122123.v2.1.I60a53c170a8596661883bd2b4ef475155c7aa72b@changeid>
In-Reply-To: <20251017122123.v2.1.I60a53c170a8596661883bd2b4ef475155c7aa72b@changeid>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sat, 18 Oct 2025 13:27:13 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ie0Jz6AJdZJx2jNSRcqRQOqMCF+gYdgemTs=rKwXD1_g@mail.gmail.com>
X-Gm-Features: AS18NWD6bHTd_vUF_qBtVIKT5NWPoUwfrydYcGt_jLLmqKDaZufr6wiJXQu2i5E
Message-ID: <CAJZ5v0ie0Jz6AJdZJx2jNSRcqRQOqMCF+gYdgemTs=rKwXD1_g@mail.gmail.com>
Subject: Re: [PATCH v2] PCI/PM: Prevent runtime suspend before devices are
 fully initialized
To: Brian Norris <briannorris@chromium.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, "Rafael J . Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	linux-pm@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 9:22=E2=80=AFPM Brian Norris <briannorris@chromium.=
org> wrote:
>
> Today, it's possible for a PCI device to be created and
> runtime-suspended before it is fully initialized. When that happens, the
> device will remain in D0, but the suspend process may save an
> intermediate version of that device's state -- for example, without
> appropriate BAR configuration. When the device later resumes, we'll
> restore invalid PCI state and the device may not function.
>
> Prevent runtime suspend for PCI devices by deferring pm_runtime_enable()
> until we've fully initialized the device.
>
> More details on how exactly this may occur:
>
> 1. PCI device is created by pci_scan_slot() or similar
> 2. As part of pci_scan_slot(), pci_pm_init() enables runtime PM; the
>    device starts "active" and we initially prevent (pm_runtime_forbid())
>    suspend -- but see [*] footnote
> 3. Underlying 'struct device' is added to the system (device_add());
>    runtime PM can now be configured by user space
> 4. PCI device receives BAR configuration
>    (pci_assign_unassigned_bus_resources(), etc.)
> 5. PCI device is added to the system in pci_bus_add_device()
>
> The device may potentially suspend between #3 and #4.
>
> [*] By default, pm_runtime_forbid() prevents suspending a device; but by
> design, this can be overridden by user space policy via
>
>   echo auto > /sys/bus/pci/devices/.../power/control
>
> Thus, the above #3/#4 sequence is racy with user space (udev or
> similar).
>
> Notably, many PCI devices are enumerated at subsys_initcall time and so
> will not race with user space. However, there are several scenarios
> where PCI devices are created later on, such as with hotplug or when
> drivers (pwrctrl or controller drivers) are built as modules.
>
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> Cc: <stable@vger.kernel.org>

Can you please add a Link: pointer to the discussion on the previous
version of the patch?

With that

Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

> ---
>
> Changes in v2:
>  * Update CC list
>  * Rework problem description
>  * Update solution: defer pm_runtime_enable(), instead of trying to
>    get()/put()
>
>  drivers/pci/bus.c | 3 +++
>  drivers/pci/pci.c | 1 -
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index f26aec6ff588..fc66b6cb3a54 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -14,6 +14,7 @@
>  #include <linux/of.h>
>  #include <linux/of_platform.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/proc_fs.h>
>  #include <linux/slab.h>
>
> @@ -375,6 +376,8 @@ void pci_bus_add_device(struct pci_dev *dev)
>                 put_device(&pdev->dev);
>         }
>
> +       pm_runtime_enable(&dev->dev);
> +
>         if (!dn || of_device_is_available(dn))
>                 pci_dev_allow_binding(dev);
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b14dd064006c..f792164fa297 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3226,7 +3226,6 @@ void pci_pm_init(struct pci_dev *dev)
>         pci_pm_power_up_and_verify_state(dev);
>         pm_runtime_forbid(&dev->dev);
>         pm_runtime_set_active(&dev->dev);
> -       pm_runtime_enable(&dev->dev);
>  }
>
>  static unsigned long pci_ea_flags(struct pci_dev *dev, u8 prop)
> --
> 2.51.0.858.gf9c4a03a3a-goog
>

