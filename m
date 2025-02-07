Return-Path: <linux-pci+bounces-20906-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E1EA2C78B
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 16:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C74B43AA41A
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 15:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FB42405F0;
	Fri,  7 Feb 2025 15:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kC0cMsnT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C4523ED54;
	Fri,  7 Feb 2025 15:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738942891; cv=none; b=Q/hzuDA68O/EntIOL7CWZZAQX7h9gyW1BYbgJYFyX8/ZFoKs5lHxWmcchP5fzhwApXoO3AIQrnvWNUNZNmORKw5SgYNgEZONj3cCLDLgRYuEbBSDiEqPGvNrRrf5osnA4B1r9w49RngiqNMWvzhHy0XXf5YUpYIWcH5zpDzp5q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738942891; c=relaxed/simple;
	bh=jzgqfcfeVfqZ1cK1I9LiYNgPFCDeHdC1YoXIE4x9p2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IsUxy0BiPW0TjTWS810wP0Ly1NJ5kzN++2uaZz6PoGXVC/wExoYHs8oGBhz4SW1bvZbQPans2dydkhukSb81AFX2wbDRTqgxgb1rNxReA6ekEBOiSew+ruQd+8MWemX4PMS0Uiyi3TlHhYGkY4qRrFlGu89mbwl8R57rvJrgnhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kC0cMsnT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EC4AC4CEE5;
	Fri,  7 Feb 2025 15:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738942891;
	bh=jzgqfcfeVfqZ1cK1I9LiYNgPFCDeHdC1YoXIE4x9p2c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kC0cMsnTUtVbSWWYcACwwGbdl/ghpLFSCsJ7DX1s+GDVC8plF3RdmeCXVtYr1lzqa
	 yWC3t2k4cPPf+COuubqWb5Hekfz94SaHElCxL53sLikgRUsc2nGldbx/XIE/Ww2VlV
	 QS0ihTkdl6jXKVb4cggMgUcTBhXUig25CiBzIjiJSKXZHOC8Az+KxJ3lksgqpCYyFJ
	 i2SZti1Pc7/xYrbRm2OqOcZFL7DuG1gBVNe2GjSeKQ2NjgOsXj/t/97iR0usbK5nIf
	 HgxZYfzE1pCsl2IDLEDfWSPW9WYFjlr5PhrvdGVHkQeO9h0/hYkGBNaUGm3ivifcvf
	 4YegQFPFOsAzA==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5fc13355a5bso1083737eaf.3;
        Fri, 07 Feb 2025 07:41:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCURf+HziPrvGUC4m44O13NYJq6Afb2MNJa2mGlyoFljNJkuYKEPtWjpQ+RxQ1aqEaXkldUaHuv/ISE=@vger.kernel.org, AJvYcCWE5dqeFn7Txn3WRf7X1Zv3IzyhYiRUru8FWFZ+Ugqu84QHa3bSiogeZ3KeJkxMI0xs9i1O1RZNx+eYqpc=@vger.kernel.org, AJvYcCWrUZNAjjHWEvbSmGyK6t2t0N0jiIAgJ1yG4rItCzBelWtzPDu+cZ+sfeJSNd4jmYWD8VUDia14TR6q@vger.kernel.org, AJvYcCX5IZe9W9MWgYAXVAVK0KvUFwi1SfLvLfYvxHbHpVBwHoZIcNONUZJivF+0wAZi7s1/89zqoOb0aG+SS+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjblNpRC8RxkytVrfmmrYZw3/2k0H1lD+BC+M6g51oGB2y0L6b
	/riDJn/MWhm4uxpQQBU0L+LoNFKZDCm0BhG5FjYVuY24nI6USnK55HsmgW2TjjXGSmhGPazbHNB
	nxjR1fDD2PHUVXCc4CTdvQXPPUoE=
X-Google-Smtp-Source: AGHT+IHRPRSDsBVMNZCUnzemgyz6Ifv/tX6iSe9DNiPMSojBjrx3KJlGvRl+GltgwRdZ8YxnwL+URQBCycC9eq3UgJE=
X-Received: by 2002:a05:6820:54b:b0:5fa:61b9:3e99 with SMTP id
 006d021491bc7-5fc5e6a6675mr2632457eaf.3.1738942890477; Fri, 07 Feb 2025
 07:41:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12619233.O9o76ZdvQC@rjwysocki.net> <1c2433d4-7e0f-4395-b841-b8eac7c25651@nvidia.com>
 <Z6YPpbRF_U0TxAbf@hovoldconsulting.com> <Z6YcjFBWAVVVANf2@hovoldconsulting.com>
In-Reply-To: <Z6YcjFBWAVVVANf2@hovoldconsulting.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 7 Feb 2025 16:41:18 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iHjkfoh2A+hAmMCTG9_nBcJrsRYFD0Hp4ZChYUo7bFEg@mail.gmail.com>
X-Gm-Features: AWEUYZlwEPYlis9YnTvZYbPq5_yCDEI_6ZrnvegCI4YdcJhruAg5Z-3Cw5n-I5w
Message-ID: <CAJZ5v0iHjkfoh2A+hAmMCTG9_nBcJrsRYFD0Hp4ZChYUo7bFEg@mail.gmail.com>
Subject: Re: [PATCH v1] PM: sleep: core: Synchronize runtime PM status of
 parents and children
To: Johan Hovold <johan@kernel.org>
Cc: Jon Hunter <jonathanh@nvidia.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Alan Stern <stern@rowland.harvard.edu>, Bjorn Helgaas <helgaas@kernel.org>, 
	Linux PCI <linux-pci@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Kevin Xie <kevin.xie@starfivetech.com>, 
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 7, 2025 at 3:45=E2=80=AFPM Johan Hovold <johan@kernel.org> wrot=
e:
>
> On Fri, Feb 07, 2025 at 02:50:29PM +0100, Johan Hovold wrote:
>
> > Yeah, I hit something like this yesterday as well and did confirm that
> > reverting this commit makes the problem go away. Haven't had time to di=
g
> > much further.
> >
> > [  110.522368] Unable to handle kernel NULL pointer dereference at virt=
ual address 0000000000000000
>
> > [  110.855238] Call trace:
> > [  110.857861]  simple_pm_bus_runtime_suspend+0x14/0x48 (P)
> > [  110.863425]  pm_generic_runtime_suspend+0x2c/0x44
> > [  110.868362]  pm_runtime_force_suspend+0x54/0x100
> > [  110.873217]  dpm_run_callback+0xb4/0x228
> > [  110.877347]  device_suspend_noirq+0x70/0x2a8
> > [  110.881844]  dpm_noirq_suspend_devices+0xe0/0x230
> > [  110.886778]  dpm_suspend_noirq+0x24/0x98
> > [  110.890904]  suspend_devices_and_enter+0x368/0x678
> > [  110.895941]  pm_suspend+0x1b4/0x348
> > [  110.899627]  state_store+0x8c/0xfc
> > [  110.903228]  kobj_attr_store+0x18/0x2c
> > [  110.907195]  sysfs_kf_write+0x4c/0x78
> > [  110.911074]  kernfs_fop_write_iter+0x120/0x1b4
> > [  110.915735]  vfs_write+0x2ac/0x358
> > [  110.919352]  ksys_write+0x68/0xfc
> > [  110.922873]  __arm64_sys_write+0x1c/0x28
> > [  110.927002]  invoke_syscall+0x48/0x110
> > [  110.930969]  el0_svc_common.constprop.0+0x40/0xe0
> > [  110.935907]  do_el0_svc+0x1c/0x28
> > [  110.939427]  el0_svc+0x48/0x114
> > [  110.942769]  el0t_64_sync_handler+0xc8/0xcc
> > [  110.947180]  el0t_64_sync+0x198/0x19c
> > [  110.951059] Code: a9be7bfd 910003fd a90153f3 f9403c00 (f9400014)
> > [  110.957428] ---[ end trace 0000000000000000 ]---
>
> Ok, so the driver data is never set and runtime PM is never enabled for
> this simple bus device, which uses pm_runtime_force_suspend() for system
> sleep.

This is kind of confusing.  Why use pm_runtime_force_suspend() if
runtime PM is never enabled and cannot really work?

> This used to work as the runtime PM state was left at 'suspended', which
> makes pm_runtime_force_suspend() return early, but now we can end up
> with a call to the driver runtime PM ops that dereference the NULL
> driver data.

Thanks for the info!

pm_runtime_force_suspend() is a known weak point, but I had assumed
that it wouldn't be involved in dependency chains starting at devices
with DPM_FLAG_SMART_SUSPEND set.

Well, more work ...

