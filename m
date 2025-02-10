Return-Path: <linux-pci+bounces-21098-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEDC5A2F518
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 18:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5C86188A420
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 17:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3971255E5E;
	Mon, 10 Feb 2025 17:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WfQMXk6z"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B76255E59;
	Mon, 10 Feb 2025 17:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739208112; cv=none; b=d/hQdvHiC/AEuNkO/20ikBVxRAai6HHVCGHPD4nMK/erJk+bMYIbs8iwLU78qzMCo+VIacPsLI5KfNAe4gZ8juxP+y0YL016Y/8Zob1Ju6zUe1hAOIgPJfqbE7u+Dbsg61JX1DbAIBNS/tS/dMUMF2FC5QFoeAYq/CIzWJMJ17Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739208112; c=relaxed/simple;
	bh=rhTozKKf5bBO80KSwU3CbD1Ipk4DGfxB/eeQiuxI3Yk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R/UjqgdNy9eeInuc0C8VjhC4bqxLSQj4nQnWbl2DOlRw4GU8vTQuNkQYCoVbffYBoLF5Db7bi7exyZJsNBndD9Y2EaMH0o7TPOQT8juTKHljSM/G/Vye8gjMVV36z2NFqj7r7mucfej7RSb3I9G4iBtLPnOFFOjcLJTyQqojglo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WfQMXk6z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37215C4CED1;
	Mon, 10 Feb 2025 17:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739208112;
	bh=rhTozKKf5bBO80KSwU3CbD1Ipk4DGfxB/eeQiuxI3Yk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WfQMXk6zpPxhjHnNX00pwJ0MF5vYnKRLI3RCoY0H51rCyhL5wrUQZGOEkSSmdBeka
	 WDGD99Z2WSjN0x3oQCKkqzcO8CDkHFtyUU4qjsDA6OZ6c9zDLFNsIIm7mMKjgl+dUl
	 eHCpnCvbRDT8KwyXQXX/dqHqXgmEHCW2DnK7OkQwtTNohTMxG6pDPCxvwXti+PAPYj
	 eVhrMu4/rc5Wew0pEmlTHYAmg6XBfi+G9PMd5iTWUSlCAACZs4IMCJuo80jrnStOpD
	 wPRadLUccFF4bom8D/XXRyPrqyycOWb8ix46jZr9YHIhSDpBB9f6X1659+rY8s5aBO
	 bXgo8WT0yMk9g==
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3f3ba3d0433so441069b6e.2;
        Mon, 10 Feb 2025 09:21:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUMm+W18s3sKVhY1seCG5wsHG82M1eL75O1iCaxIPT40g3MSQHV6W+994WYSbC8sBc+IFPVmkaQTcE=@vger.kernel.org, AJvYcCXGX/eR2nrpEhlPk5N/OQdwulRL5JMxwN1tlLSrzHsgCVvYnaOruvvrOKEVj4wlEBRJi2HspVsZOF5yG1E=@vger.kernel.org, AJvYcCXVyHFhXI8XRa3veWGEjVxGVKTNlQws/vBA2hCdacfEmWAcNPe3M4d6CRM4N2BeEi9O+U5D9wWRnn8P@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+jUPyKEDTPy5uLYp5Cl+0LtvbzdWFmxxfSU+T8lKQ3mpaTAzB
	Mph9512CcHTmW+jXoTm/oDVbaSTdXFMD3rvzUdYEe0F6Cm7GN277Y5eTlO3QaI3YVpG2rjERX5b
	FhZxPjDwvRAqdKJMgEu744PrlT9Q=
X-Google-Smtp-Source: AGHT+IFd60NsPYdDb9B3WRxPCwZDX2qdtQ5cYFR/6EHKAxd5i9I4JF7UWV5wXUJQ6acxL986I9gUE9+bmycEa39rSw0=
X-Received: by 2002:a05:6808:3c8a:b0:3eb:4681:a895 with SMTP id
 5614622812f47-3f3921f0b9cmr9884888b6e.7.1739208111574; Mon, 10 Feb 2025
 09:21:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6137505.lOV4Wx5bFT@rjwysocki.net> <Z6nHYtn5TEJlTQZs@hovoldconsulting.com>
In-Reply-To: <Z6nHYtn5TEJlTQZs@hovoldconsulting.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 10 Feb 2025 18:21:40 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0j=FjPDgZfpds5xJerPLV7J-gnXLg44sqq7GTYed5N4YA@mail.gmail.com>
X-Gm-Features: AWEUYZkuaWKDl14u4YWxztP040d3hSDxp7mQDDdtySqhsTa6djVOC7PjRM_OPOw
Message-ID: <CAJZ5v0j=FjPDgZfpds5xJerPLV7J-gnXLg44sqq7GTYed5N4YA@mail.gmail.com>
Subject: Re: [PATCH v1] PM: sleep: core: Restrict power.set_active propagation
To: Johan Hovold <johan@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
	Bjorn Helgaas <helgaas@kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Kevin Xie <kevin.xie@starfivetech.com>, 
	Jon Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 10:31=E2=80=AFAM Johan Hovold <johan@kernel.org> wr=
ote:
>
> On Sat, Feb 08, 2025 at 06:54:28PM +0100, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Commit 3775fc538f53 ("PM: sleep: core: Synchronize runtime PM status of
> > parents and children") exposed an issue related to simple_pm_bus_pm_ops
> > that uses pm_runtime_force_suspend() and pm_runtime_force_resume() as
> > bus type PM callbacks for the noirq phases of system-wide suspend and
>
> Despite the name of the driver these are plain device driver PM
> callbacks (not bus PM ops).

Right, I was confused.

BTW, I still think that it is invalid to use
pm_runtime_force_suspend() and pm_runtime_force_resume() as
system-wide PM callbacks without enabling runtime PM.  The system-wide
PM callbacks should be wrappers around these checking something (eg.
dev_get_drvdata(dev)) other than dev->power.runtime_status.  It is too
fragile the current way.

> > resume.
> >
> > The problem is that pm_runtime_force_suspend() does not distinguish
> > runtime-suspended devices from devices for which runtime PM has never
> > been enabled, so if it sees a device with runtime PM status set to
> > RPM_ACTIVE, it will assume that runtime PM is enabled for that device
> > and so it will attempt to suspend it with the help of its runtime PM
> > callbacks which may not be ready for that.  As it turns out, this
> > causes simple_pm_bus_runtime_suspend() to crash due to a NULL pointer
> > dereference.
> >
> > Another problem related to the above commit and simple_pm_bus_pm_ops is
> > that setting runtime PM status of a device handled by the latter to
> > RPM_ACTIVE will actually prevent it from being resumed because
> > pm_runtime_force_resume() only resumes devices with runtime PM status
> > set to RPM_SUSPENDED.
> >
> > To mitigate these issues, do not allow power.set_active to propagate
> > beyond the parent of the device with DPM_FLAG_SMART_SUSPEND set that
> > will need to be resumed, which should be a sufficient stop-gap for the
> > time being, but they will need to be properly addressed in the future
> > because in general during system-wide resume it is necessary to resume
> > all devices in a dependency chain in which at least one device is going
> > to be resumed.
>
> So this works as long as no parent of a device with
> DPM_FLAG_SMART_SUSPEND set is using pm_runtime_force_resume().
>
> This is the case in the systems I work on, but have you
> verified that this is currently generally true? Not many drivers use
> this flag, but it all depends on what their devices' parents' drivers
> do:
>
>         drivers/acpi/acpi_tad.c
>         drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>         drivers/i2c/busses/i2c-designware-platdrv.c
>         drivers/mfd/intel-lpss.c
>         drivers/pci/pcie/portdrv.c
>         drivers/pwm/pwm-lpss-platform.c
>         drivers/soundwire/intel_auxdevice.c
>
> Most of these look like ACPI drivers so nothing that would sit directly
> on a simple-pm-bus at least.

I'm not worried about these.

Also, I have a patch series to get the power.set_active propagation
into agreement with pm_runtime_force_suspend/resume().  I'll post it
tomorrow.

