Return-Path: <linux-pci+bounces-38440-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 48EBFBE7DE7
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 11:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E970335C7A6
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 09:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8EA2D8776;
	Fri, 17 Oct 2025 09:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S6jaivmL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1002D9EFE
	for <linux-pci@vger.kernel.org>; Fri, 17 Oct 2025 09:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760694328; cv=none; b=DT1G1OwjOm7eKUGOM3QcMKNBYENg68QYqX3U0gTcbaZetTPqctn6jU1ixXlisWSU6fTG0Q2CBlJsqds7UDd73hIrgZdXbieKHGnGBja5jdHPYaFz2Nv3kMzcH2fiBofjaYoOO9kg1Z3AgumELrhJCYyrCr9LixNT/X5gb0YlsVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760694328; c=relaxed/simple;
	bh=XtO9sRQeiqTEF3Mgx59O+0CfGSoNUdMMWG3uX2sJANc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pv/Xjecr28/STvIJSbsyPaFIrK/aKue9hg7i9FIZrBa7oZ5HBiX8J7zH2pfqVnqGkZiysRHICcftJCkuZWIDcqEC2R3+7eDZGoORPm0CTjvHfgsgXPGfk7Cae1NGYEueYGFpAKh1TbxmsVT4RG34ernPsj0r4MB1cg1wVcl3ueE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S6jaivmL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FD11C113D0
	for <linux-pci@vger.kernel.org>; Fri, 17 Oct 2025 09:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760694327;
	bh=XtO9sRQeiqTEF3Mgx59O+0CfGSoNUdMMWG3uX2sJANc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=S6jaivmL21W3j9X94Ug/vZPu9YmbLoyjEWgbaxTo4XE3WKXOrTeDKG9vdkTCgYWYg
	 shWpjWn0BvJn0wMWGjEyrwPTD6mgziEtD6Vu0fQ7BSQUyHRBCn4z64q4iaGDdl5JjV
	 qX6v0jC5yfFkeobv8NlBtsBLIY/cF2YO+yAtgiZLj4j3IJgMjkNuAIX5ONUZdHTm+M
	 k368bR6By5fuuf1IVbEXp3ZbfMak4TdHOpL9YTKzWt1eyPsCcH4Yet+7u6fk8WhWCo
	 /9aKX7oKI9Shy7eB72Zh0w03pAVA9CVlmurErvgqjX9yNvyWcMZQRD4dYRwD8MmubZ
	 vRPt4q+c6lBNg==
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-43f554ed252so950800b6e.0
        for <linux-pci@vger.kernel.org>; Fri, 17 Oct 2025 02:45:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWhJrY3rVNs6Jd2Zb2QfJwdwUgha4MYPjEgyu/30lgUEVL40ElnxFr56s+7HwoFWdFNeIBR8/f+Vqw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwahTuySEG5RXG1kVewja2p5mS18e+2z0K5J7UZ/rGs6nHQt1XQ
	nyQvlBEo6t5jydA24KviAvfm9Iwi+Y/3YpMvEWDaed0D3bOLCZK5BHa0u+nprO2cSHgJV8zQXwa
	bbgPTM9X0fFnmoVMjzKCF3XcLaD3V0Yw=
X-Google-Smtp-Source: AGHT+IH4eFtUZLBxcwh2xQ/mf6nJ2K1x5Ot8Mr4XTPJHIaP3cRmxN8m7Qjq/x+6o55VptzdO3OZu5M8S/8tYsiUSlRE=
X-Received: by 2002:a05:6808:6d82:b0:441:c8af:291d with SMTP id
 5614622812f47-443a30953d3mr1270420b6e.42.1760694326867; Fri, 17 Oct 2025
 02:45:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016155335.1.I60a53c170a8596661883bd2b4ef475155c7aa72b@changeid>
In-Reply-To: <20251016155335.1.I60a53c170a8596661883bd2b4ef475155c7aa72b@changeid>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 17 Oct 2025 11:45:14 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iFa3_UFkA920Ogn0YAYLq4CjnAD_VjLsmxQxrfm5HEBw@mail.gmail.com>
X-Gm-Features: AS18NWAfxBP4Jux50tLr0QwuvERSlU0IAnFqGNafXGnfCBKno1UvlTv43pvyLKQ
Message-ID: <CAJZ5v0iFa3_UFkA920Ogn0YAYLq4CjnAD_VjLsmxQxrfm5HEBw@mail.gmail.com>
Subject: Re: [PATCH] PCI/PM: Prevent runtime suspend before devices are fully initialized
To: Brian Norris <briannorris@chromium.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 1:28=E2=80=AFAM Brian Norris <briannorris@chromium.=
org> wrote:
>
> PCI devices are created via pci_scan_slot() and similar, and are
> promptly configured for runtime PM (pci_pm_init()). They are initially
> prevented from suspending by way of pm_runtime_forbid(); however, it's
> expected that user space may override this via sysfs [1].
>
> Now, sometime after initial scan, a PCI device receives its BAR
> configuration (pci_assign_unassigned_bus_resources(), etc.).
>
> If a PCI device is allowed to suspend between pci_scan_slot() and
> pci_assign_unassigned_bus_resources(), then pci-driver.c will
> save/restore incorrect BAR configuration for the device, and the device
> may cease to function.
>
> This behavior races with user space, since user space may enable runtime
> PM [1] as soon as it sees the device, which may be before BAR
> configuration.
>
> Prevent suspending in this intermediate state by holding a runtime PM
> reference until the device is fully initialized and ready for probe().
>
> [1] echo auto > /sys/bus/pci/devices/.../power/control
>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
>
>  drivers/pci/bus.c | 7 +++++++
>  drivers/pci/pci.c | 6 ++++++
>  2 files changed, 13 insertions(+)
>
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index f26aec6ff588..227a8898acac 100644
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
> @@ -375,6 +376,12 @@ void pci_bus_add_device(struct pci_dev *dev)
>                 put_device(&pdev->dev);
>         }
>
> +       /*
> +        * Now that resources are assigned, drop the reference we grabbed=
 in
> +        * pci_pm_init().
> +        */
> +       pm_runtime_put_noidle(&dev->dev);
> +
>         if (!dn || of_device_is_available(dn))
>                 pci_dev_allow_binding(dev);
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b14dd064006c..06a901214f2c 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3226,6 +3226,12 @@ void pci_pm_init(struct pci_dev *dev)
>         pci_pm_power_up_and_verify_state(dev);
>         pm_runtime_forbid(&dev->dev);
>         pm_runtime_set_active(&dev->dev);
> +       /*
> +        * We cannot allow a device to suspend before its resources are
> +        * configured. Otherwise, we may allow saving/restoring unexpecte=
d BAR
> +        * configuration.
> +        */
> +       pm_runtime_get_noresume(&dev->dev);
>         pm_runtime_enable(&dev->dev);

So runtime PM should not be enabled here, should it?

>  }
>
> --

