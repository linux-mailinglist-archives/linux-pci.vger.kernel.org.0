Return-Path: <linux-pci+bounces-39194-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A194C0310C
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 20:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AD1819C19AD
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 18:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10C7347FF0;
	Thu, 23 Oct 2025 18:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V2ofiRzG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC38A28504D
	for <linux-pci@vger.kernel.org>; Thu, 23 Oct 2025 18:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761245391; cv=none; b=HNZ/Uk/m0Hjagp+hdkzyNkAxtIIPCT/igYtVaBXzMJAMckPF5fSfqCFPJOeK0hP/xKBeDNXQc62cNrLr3Ofeav2Igt+1/q0whyFJnHVGmNpT8MuopSWlBfRA1b569UI82e0p/S8MqLeSv4sMqguIAiJrvBdiB3hrIBchu8Q3KV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761245391; c=relaxed/simple;
	bh=oJWCuKDT0P4tu/ba/OfqGEObTs1ISTjVk56GTCEffoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UZYkbhjH7Grid/trBRy8Xz8AIxHIQtu1BgNtTbWX0KacWVXpj59PQHwpgUCxSDs+bHEq1xR+L5cre/HFh7usuYLggXYNdx+POY4C9gyq0aVoBAhZtpmQRxriT6eM+sEvX00v6dWibNzXiiHQGUqswtUURhI70udIjyDfCyg4qNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V2ofiRzG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C3FEC4CEE7
	for <linux-pci@vger.kernel.org>; Thu, 23 Oct 2025 18:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761245391;
	bh=oJWCuKDT0P4tu/ba/OfqGEObTs1ISTjVk56GTCEffoc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=V2ofiRzGpIzSXbVk4opwUf2oyDkEwUUEvDqoNyGFtwQm+lP45r69CnCcfUT2otdsL
	 txuyYxWSP3YVV7VE/pKPrHf4pkWJMGLSrv/+swcEirHrOn2BVYIBJn0w+xNvL9HEZo
	 zH0GVU5g3Hw0sFzkuDAaxjM2Nrl4q3rr+glNSDJJlvpkVPq8B+aADCGNh+lzpEJRVJ
	 xJnR09q47qogxxSrMII80BepXYIP3s7Q9E+HNpPTB3QF9YHU5mtTUGVFINPsaW8+ge
	 maINy2GpM/k+3jlBnnu/94Krja/zOKpi6llULF+JOOosBL1wiUXHy9euwGh7k5SsAl
	 KxyvqwijK4Tmg==
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-444d3df546bso578452b6e.0
        for <linux-pci@vger.kernel.org>; Thu, 23 Oct 2025 11:49:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXpxVKC8SpA6n4XW30xuqrU7Lb2HjQ+KuVI1E48ngMC/wzydw3nzAw5aceoUrgmVi1m8lDN4Kp5zp4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlvLrdW6UYBIW9flYJ2CXYEysoSRsTTBqFsXEJSzcv8WydW8hJ
	Tzlj4X3xZU4juqiMYyknUSsoKNw2tXqHoSr83p264SgICUJ6/lq/HhR/j9XjzNkQWygD1XYH8Jq
	fGFj0w3zLTiegIgMbfOP1v0ytOt5UmSM=
X-Google-Smtp-Source: AGHT+IGTbrlbbzKKAepv9FX2gBKdg78DsE/Ry/3XNBvmf3P5I1PojBxIrqmS7xqya0vT063F5wfJ3A3t0N0foRjm5AQ=
X-Received: by 2002:a05:6808:181e:b0:438:430b:3dce with SMTP id
 5614622812f47-443a2dfa130mr11846007b6e.10.1761245390710; Thu, 23 Oct 2025
 11:49:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022141434.v3.1.I60a53c170a8596661883bd2b4ef475155c7aa72b@changeid>
 <CAJZ5v0ieBdfuu_OF5YQsgsgy_L3H-UkVvn+kk45UFDfJSBtj0g@mail.gmail.com>
 <aPp1UWdc2rmafZr-@google.com> <aPp3JLWtqFMjZheY@google.com>
In-Reply-To: <aPp3JLWtqFMjZheY@google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 23 Oct 2025 20:49:39 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i1O+ox2ewjm+op95=tWK1YK0fV5e_NPrRVknn7qaCKyA@mail.gmail.com>
X-Gm-Features: AS18NWAiHos08EG1ibzdglEn1Gxibb9xHxipY2M4LXksnbSrcYkxfciFNumCsFg
Message-ID: <CAJZ5v0i1O+ox2ewjm+op95=tWK1YK0fV5e_NPrRVknn7qaCKyA@mail.gmail.com>
Subject: Re: [PATCH v3] PCI/PM: Prevent runtime suspend before devices are
 fully initialized
To: Brian Norris <briannorris@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Lukas Wunner <lukas@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 8:42=E2=80=AFPM Brian Norris <briannorris@chromium.=
org> wrote:
>
> Hi again,
>
> On Thu, Oct 23, 2025 at 11:34:57AM -0700, Brian Norris wrote:
> > On Thu, Oct 23, 2025 at 11:41:38AM +0200, Rafael J. Wysocki wrote:
> > > On Wed, Oct 22, 2025 at 11:15=E2=80=AFPM Brian Norris <briannorris@ch=
romium.org> wrote:
> > > >
> > > > Today, it's possible for a PCI device to be created and
> > > > runtime-suspended before it is fully initialized. When that happens=
, the
> > > > device will remain in D0, but the suspend process may save an
> > > > intermediate version of that device's state -- for example, without
> > > > appropriate BAR configuration. When the device later resumes, we'll
> > > > restore invalid PCI state and the device may not function.
> > > >
> > > > Prevent runtime suspend for PCI devices by deferring pm_runtime_ena=
ble()
> > > > until we've fully initialized the device.
> > > >
> > > > More details on how exactly this may occur:
> > > >
> > > > 1. PCI device is created by pci_scan_slot() or similar
> > > > 2. As part of pci_scan_slot(), pci_pm_init() enables runtime PM; th=
e
> > > >    device starts "active" and we initially prevent (pm_runtime_forb=
id())
> > > >    suspend -- but see [*] footnote
> > > > 3. Underlying 'struct device' is added to the system (device_add())=
;
> > > >    runtime PM can now be configured by user space
> > > > 4. PCI device receives BAR configuration
> > > >    (pci_assign_unassigned_bus_resources(), etc.)
> > > > 5. PCI device is added to the system in pci_bus_add_device()
> > > >
> > > > The device may potentially suspend between #3 and #4.
> > > >
> > > > [*] By default, pm_runtime_forbid() prevents suspending a device; b=
ut by
> > > > design [**], this can be overridden by user space policy via
> > > >
> > > >   echo auto > /sys/bus/pci/devices/.../power/control
> > > >
> > > > Thus, the above #3/#4 sequence is racy with user space (udev or
> > > > similar).
> > > >
> > > > Notably, many PCI devices are enumerated at subsys_initcall time an=
d so
> > > > will not race with user space. However, there are several scenarios
> > > > where PCI devices are created later on, such as with hotplug or whe=
n
> > > > drivers (pwrctrl or controller drivers) are built as modules.
> > > >
> > > > [**] The relationship between pm_runtime_forbid(), pm_runtime_allow=
(),
> > > > /sys/.../power/control, and the runtime PM usage counter can be sub=
tle.
> > > > It appears that the intention of pm_runtime_forbid() /
> > > > pm_runtime_allow() is twofold:
> > > >
> > > > 1. Allow the user to disable runtime_pm (force device to always be
> > > >    powered on) through sysfs.
> > > > 2. Allow the driver to start with runtime_pm disabled (device force=
d
> > > >    on) and user space could later enable runtime_pm.
> > > >
> > > > This conclusion comes from reading `Documentation/power/runtime_pm.=
rst`,
> > > > specifically the section starting "The user space can effectively
> > > > disallow".
> > > >
> > > > This means that while pm_runtime_forbid() does technically increase=
 the
> > > > runtime PM usage counter, this usage counter is not a guarantee of
> > > > functional correctness, because sysfs can decrease that count again=
.
> > > >
> > > > Link: https://lore.kernel.org/all/20251016155335.1.I60a53c170a85966=
61883bd2b4ef475155c7aa72b@changeid/
> > > > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > > > Cc: <stable@vger.kernel.org>
> > > > Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
> > > > ---
> > > >
> > > > Changes in v3:
> > > >  * Add Link to initial discussion
> > > >  * Add Rafael's Reviewed-by
> > > >  * Add lengthier footnotes about forbid vs allow vs sysfs
> > > >
> > > > Changes in v2:
> > > >  * Update CC list
> > > >  * Rework problem description
> > > >  * Update solution: defer pm_runtime_enable(), instead of trying to
> > > >    get()/put()
> > > >
> > > >  drivers/pci/bus.c | 3 +++
> > > >  drivers/pci/pci.c | 1 -
> > > >  2 files changed, 3 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> > > > index f26aec6ff588..fc66b6cb3a54 100644
> > > > --- a/drivers/pci/bus.c
> > > > +++ b/drivers/pci/bus.c
> > > > @@ -14,6 +14,7 @@
> > > >  #include <linux/of.h>
> > > >  #include <linux/of_platform.h>
> > > >  #include <linux/platform_device.h>
> > > > +#include <linux/pm_runtime.h>
> > > >  #include <linux/proc_fs.h>
> > > >  #include <linux/slab.h>
> > > >
> > > > @@ -375,6 +376,8 @@ void pci_bus_add_device(struct pci_dev *dev)
> > > >                 put_device(&pdev->dev);
> > > >         }
> > > >
> > > > +       pm_runtime_enable(&dev->dev);
> > > > +
> > > >         if (!dn || of_device_is_available(dn))
> > > >                 pci_dev_allow_binding(dev);
> > > >
> > > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > > index b14dd064006c..f792164fa297 100644
> > > > --- a/drivers/pci/pci.c
> > > > +++ b/drivers/pci/pci.c
> > > > @@ -3226,7 +3226,6 @@ void pci_pm_init(struct pci_dev *dev)
> > > >         pci_pm_power_up_and_verify_state(dev);
> > > >         pm_runtime_forbid(&dev->dev);
> > > >         pm_runtime_set_active(&dev->dev);
> > >
> > > Actually, I think that the two statements above can be moved too.
> > >
> > > The pm_runtime_forbid() call doesn't matter until runtime PM is
> > > enabled and it is better to do pm_runtime_set_active() right before
> > > enabling runtime PM.
> >
> > Ehh, sure, I can do that I suppose. That signs me up for fixing some
> > excessive Documentation/ that spells out exactly what goes on in
> > pci_pm_init() for some reason, but I can do that too :)
>
> Hmm, never mind, I think I agreed with you too soon.
>
> It should be ok to move pm_runtime_set_active(), but I believe moving
> pm_runtime_forbid() would introduce a similar race condition problem to
> the bug I'm resolving -- pci_bus_add_device() is run after device_add(),
> and so user space might already see the device and try to configure
> power/control. If we forbid() after that point, user space would be
> confused.
>
> Documentation/power/runtime_pm.rst even calls this out:
>
>   "It should be noted, however, that if the user space has already
>   intentionally changed the value of /sys/devices/.../power/control to
>   "auto" to allow the driver to power manage the device at run time, the
>   driver may confuse it by using pm_runtime_forbid() this way."
>
> So I'd rather not make this change.

OK, fair enough, so leave the pm_runtime_forbid() as is, but
pm_runtime_set_active() should really be done right prior to enabling.

