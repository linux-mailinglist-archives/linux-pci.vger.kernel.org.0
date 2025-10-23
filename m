Return-Path: <linux-pci+bounces-39128-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB3AC0055C
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 11:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6C253B06C9
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 09:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970D0309EE5;
	Thu, 23 Oct 2025 09:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dP9LsCas"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7001C3090C9
	for <linux-pci@vger.kernel.org>; Thu, 23 Oct 2025 09:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761212512; cv=none; b=hfsVDwW9CNeRjfQuqcEij4Zht6exhskTpgDRdG50cW5HDv6BNUAftEo/xDykPt8lb+ghnNnt6oLOgahtGuKZ2Ke1KzrixRtAMtVE0ioa5moqIhVSqvhg/6Lqkv0wY/cACfjHZKVVBxg0XW4oD3TJzSHRE7j2xK+xZ3AaGlZMZJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761212512; c=relaxed/simple;
	bh=x39im17yCpKlBZK/OHzKxjKDvrvbrR9VUmbw5G3Mn5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nlez+ZeDZEMlynLPcfI88eIRt4edcY3+hL0Zk/ce1GqykcZW57lQgdmadD1pJmtmohRdwF0LiIUYGWoUOSbhebl65CkQGNYT/HK2LAtOIFDihXr8LJqNUU5GYrGcE/nooNc89hQmSfeCKQYsbOkGIzYTso/fd51xVE+VTXitnds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dP9LsCas; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18E3BC4CEFD
	for <linux-pci@vger.kernel.org>; Thu, 23 Oct 2025 09:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761212512;
	bh=x39im17yCpKlBZK/OHzKxjKDvrvbrR9VUmbw5G3Mn5Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dP9LsCas8r39cetxoBMH1TYsC96yxmMVIvM/r3khzXhORq95c4D/IDRstcDghULeV
	 l9c/3ytfXNKbI17fEA+6f0I2OmT3ixJnG0XnZmoJwIQKo2lu6XPL4mY9X4ue2CZbIM
	 Ju28DsF64+CgWglBJpsNsYalbHMnij/yExBbeghbEeohWPFdfRGTpqEZEnvDIU0Xn9
	 e4eW7pxBbZOdCTsBWOjt4Kdz0Xbmlr1nxS3COtzwpfUF9/oOKWYxjziTVe1pf8/fij
	 8bCvbwqEw+5gGEJjlbJspMwB8pdkdHhY0gVy9CZL/kUVCx24dYRxxEHpW0MRtFcdcw
	 HraksUPBlOs7g==
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-443ac891210so283727b6e.1
        for <linux-pci@vger.kernel.org>; Thu, 23 Oct 2025 02:41:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVhn0WXJ2tUWn3cyTi/yeTZ5Dsq7MyO3kSC7yYJQPtqgKMGFBqLGFOHYoJ+XrK/ERqJCMQ3SfjLjpc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWFO4bTA0eREwPpF7nqC0bDj9JcCccBiQ1D39KuRHo1sVPh0HX
	eDeKVKa5cBf5PRwmryJgm9O2hQ38zPc89Y0qTSMXf6sXiWfTMBKfbu5CSgL6jtOAIm4n1iMq6+T
	IfLaeSsPjXUkwlUYCZ4TXwWA2NJIEXfY=
X-Google-Smtp-Source: AGHT+IHx6vGcGv+vrMCHVYpCy9BVAaGKKr2CW9FBcS0RiH5DcbhljvnheCDcmlpQzXIY6wqKg6m4mu4Ybp34n+1tPz8=
X-Received: by 2002:a05:6808:190d:b0:442:9a9f:daa9 with SMTP id
 5614622812f47-443a314f730mr11086008b6e.45.1761212511413; Thu, 23 Oct 2025
 02:41:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022141434.v3.1.I60a53c170a8596661883bd2b4ef475155c7aa72b@changeid>
In-Reply-To: <20251022141434.v3.1.I60a53c170a8596661883bd2b4ef475155c7aa72b@changeid>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 23 Oct 2025 11:41:38 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ieBdfuu_OF5YQsgsgy_L3H-UkVvn+kk45UFDfJSBtj0g@mail.gmail.com>
X-Gm-Features: AS18NWDdb53hqfTM27k2OD16kpBKtv8BqC3y9LRdXe9K1AoiTPRwUbDpxSMcJ78
Message-ID: <CAJZ5v0ieBdfuu_OF5YQsgsgy_L3H-UkVvn+kk45UFDfJSBtj0g@mail.gmail.com>
Subject: Re: [PATCH v3] PCI/PM: Prevent runtime suspend before devices are
 fully initialized
To: Brian Norris <briannorris@chromium.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Lukas Wunner <lukas@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 11:15=E2=80=AFPM Brian Norris <briannorris@chromium=
.org> wrote:
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
> design [**], this can be overridden by user space policy via
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
> [**] The relationship between pm_runtime_forbid(), pm_runtime_allow(),
> /sys/.../power/control, and the runtime PM usage counter can be subtle.
> It appears that the intention of pm_runtime_forbid() /
> pm_runtime_allow() is twofold:
>
> 1. Allow the user to disable runtime_pm (force device to always be
>    powered on) through sysfs.
> 2. Allow the driver to start with runtime_pm disabled (device forced
>    on) and user space could later enable runtime_pm.
>
> This conclusion comes from reading `Documentation/power/runtime_pm.rst`,
> specifically the section starting "The user space can effectively
> disallow".
>
> This means that while pm_runtime_forbid() does technically increase the
> runtime PM usage counter, this usage counter is not a guarantee of
> functional correctness, because sysfs can decrease that count again.
>
> Link: https://lore.kernel.org/all/20251016155335.1.I60a53c170a8596661883b=
d2b4ef475155c7aa72b@changeid/
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> Cc: <stable@vger.kernel.org>
> Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
> ---
>
> Changes in v3:
>  * Add Link to initial discussion
>  * Add Rafael's Reviewed-by
>  * Add lengthier footnotes about forbid vs allow vs sysfs
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

Actually, I think that the two statements above can be moved too.

The pm_runtime_forbid() call doesn't matter until runtime PM is
enabled and it is better to do pm_runtime_set_active() right before
enabling runtime PM.

> -       pm_runtime_enable(&dev->dev);
>  }
>
>  static unsigned long pci_ea_flags(struct pci_dev *dev, u8 prop)
> --

