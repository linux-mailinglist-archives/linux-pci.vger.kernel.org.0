Return-Path: <linux-pci+bounces-35366-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB01CB41CD9
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 13:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97DA91713F5
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 11:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F342F8BF1;
	Wed,  3 Sep 2025 11:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kalyoq8L"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851CA6BB5B;
	Wed,  3 Sep 2025 11:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756898072; cv=none; b=pbDh/idD6hXVSvZWHdseErqur5lGAaNdIubmyX9bixEaiIMOTp0AiR6TWm8MrEL02bMWGIrA0Sj3b5v+rLfWH79ndKEdV75b3VhmVcuwFC/x1srCFSXpWO47XJA75os9Wpa/Q/zcHfp3ti0bKgkKrHz8nqTQ0Ppuk2wXcXkWMZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756898072; c=relaxed/simple;
	bh=vm2XwpR6G5MsEs9Dn0NTqtZEBq4V49QV1VyjT2uiFhE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mm/phWZVxEilPI2pNLnZ02n9jXBbhzN3azb5xsbtuDPPK913r6Fm6UZh20p3Nk9XB5wkmOrEzXJ1c+TNFZy2nQenUHMrvjp7QqO7/8rzDO3uPCv2+DPtc0joWPhlqQENFUEsXv5ZCgEo/wO7/YfuZqx3b4c9nd/S5kBJTZU1hec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kalyoq8L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0628EC4AF0B;
	Wed,  3 Sep 2025 11:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756898072;
	bh=vm2XwpR6G5MsEs9Dn0NTqtZEBq4V49QV1VyjT2uiFhE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kalyoq8LVQW7m3mKRob6fOKRe//8tQVSnrsGtI4fcNKOcDAc/PfD9KCXn3KIowLVC
	 VsfuNWiPnZYImatY7gJ89l3u9uDxVhbbEnddnYAT+KElOAH2mmVXquFpg5m5NTNYbV
	 lEHaYSVlHITD9qR2fWWrlIw5ON7duo6dxtj/8kDhnDtUUfn4iBiM/KFzFWi9BpEGcc
	 sNQ/6Uwq+8jaHqoRGWnaAJCOp5Tsq1WYxScT17K6B3cJ8hgZ7sQ3p8ymRvNNyO0sRU
	 i3xKVKOB29SoKQonPzRIUP7KdR+UjBGdMtoq7KtijJFN8qvJoZDtJwNVr9vkV6oxB3
	 pXmG/OM4XQAyw==
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-74542b1b2bcso6298184a34.3;
        Wed, 03 Sep 2025 04:14:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCULhJp9th0FDfiBrr8HiFjQYmx/1wGq6PbpICiVhHfLVhwg4pWhyxeQvEOVwCMQUMqBIYiU3Omt/7M=@vger.kernel.org, AJvYcCVviN7VZRTxgVVTKzRvE6u0/i6H0483bRGRF1yAGcycWflJKgKkXs4SzlkHu5kuZ0uPF3GbeU3ZYJE=@vger.kernel.org, AJvYcCX2BDL1w4X8M8hrbLxO/fbXzJGzSOvqjqV+lq17VUZOL+ZfmrZsGmiWk/4VIvRD9sivuQCI4bYVlDfk@vger.kernel.org, AJvYcCXJEpvmJ7007DoT8FeecimNcMsr1ChaxSb+L2aXtv7uG7gkw3Y4e3hzmz8y1m6LELZxrlOgyLyuci1YiG48ZQjpK4sn@vger.kernel.org, AJvYcCXZUlXpzV/xESgMaAZR3/zw+wLvwYuzQU+5qyvIPw6tBbbkuahRo9QbpW9ZvZGriop0Q2EP/s8+RrIGxQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5PzwNcJsGUepV+pM7xZyPDqLW6GQMolo0/iZhOcnq2SSwcr7r
	k7gl12uoGLr/NZ+jaxIKAPBVJiHLRVNNWYRfAYS9dyUM722sbu6CPgV+Z1oiZZkUKn1A00u8hT8
	SB1uc1DWymCY9OG6oJ3+RslNSGNwf25Q=
X-Google-Smtp-Source: AGHT+IFYtjUdNN091mPJ/megBC3ceMzIS6ZlVy0m6f3KXcMJbRJK/ufd2TNnsBvKPVbrcFu/dkcLveR5ZqO+tEUHKi0=
X-Received: by 2002:a05:6830:258f:b0:741:c51c:9d9 with SMTP id
 46e09a7af769-74569d79ca2mr6941662a34.1.1756898071379; Wed, 03 Sep 2025
 04:14:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818020101.3619237-1-superm1@kernel.org> <29e61472-5f41-4e76-9b5b-f3e106d6a629@kernel.org>
In-Reply-To: <29e61472-5f41-4e76-9b5b-f3e106d6a629@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 3 Sep 2025 13:14:18 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hLO5xhmjniO4=rLK1JK9OM8naxXVEGuHUT3cuhRp=Atw@mail.gmail.com>
X-Gm-Features: Ac12FXzNMS5NRD7LbxBvydgvS_DdIA-2JZ6IFCfa_y9sZ_Fxqc7W0P6m00WI9xA
Message-ID: <CAJZ5v0hLO5xhmjniO4=rLK1JK9OM8naxXVEGuHUT3cuhRp=Atw@mail.gmail.com>
Subject: Re: [PATCH v6 00/11] Improvements to S5 power consumption
To: Mario Limonciello <superm1@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Danilo Krummrich <dakr@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K . Petersen" <martin.petersen@oracle.com>, Steven Rostedt <rostedt@goodmis.org>, 
	"open list:HIBERNATION (aka Software Suspend, aka swsusp)" <linux-pm@vger.kernel.org>, 
	"open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>, 
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, 
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>, 
	"open list:SCSI SUBSYSTEM" <linux-scsi@vger.kernel.org>, 
	"open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>, 
	"open list:TRACING" <linux-trace-kernel@vger.kernel.org>, AceLan Kao <acelan.kao@canonical.com>, 
	Kai-Heng Feng <kaihengf@nvidia.com>, Mark Pearson <mpearson-lenovo@squebb.ca>, 
	=?UTF-8?Q?Merthan_Karaka=C5=9F?= <m3rthn.k@gmail.com>, 
	Eric Naim <dnaim@cachyos.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 6:41=E2=80=AFAM Mario Limonciello <superm1@kernel.or=
g> wrote:
>
> On 8/17/2025 9:00 PM, Mario Limonciello (AMD) wrote:
> > A variety of issues both in function and in power consumption have been
> > raised as a result of devices not being put into a low power state when
> > the system is powered off.
> >
> > There have been some localized changes[1] to PCI core to help these iss=
ues,
> > but they have had various downsides.
> >
> > This series instead tries to use the S4 flow when the system is being
> > powered off.  This lines up the behavior with what other operating syst=
ems
> > do as well.  If for some reason that fails or is not supported, run the=
ir
> > shutdown() callbacks.
> >
> > Cc: AceLan Kao <acelan.kao@canonical.com>
> > Cc: Kai-Heng Feng <kaihengf@nvidia.com>
> > Cc: Mark Pearson <mpearson-lenovo@squebb.ca>
> > Cc: Merthan Karaka=C5=9F <m3rthn.k@gmail.com>
> > Cc: Eric Naim <dnaim@cachyos.org>
> > ---
> > v5->v6:
> >   * Fix for LKP robot issue
> >   * Some commit message changes
> >   * Rebase on 6.17-rc2
> >
> > Mario Limonciello (AMD) (11):
> >    PM: Introduce new PMSG_POWEROFF event
> >    scsi: Add PM_EVENT_POWEROFF into suspend callbacks
> >    usb: sl811-hcd: Add PM_EVENT_POWEROFF into suspend callbacks
> >    USB: Pass PMSG_POWEROFF event to suspend_common() for poweroff with =
S4
> >      flow
> >    PCI: PM: Disable device wakeups when halting system through S4 flow
> >    PCI: PM: Split out code from pci_pm_suspend_noirq() into helper
> >    PCI: PM: Run bridge power up actions as part of restore phase
> >    PCI: PM: Use pci_power_manageable() in pci_pm_poweroff_noirq()
> >    PCI: Put PCIe bridges with downstream devices into D3 at hibernate
> >    drm/amd: Avoid evicting resources at S5
> >    PM: Use hibernate flows for system power off
> >
> >   drivers/base/power/main.c                  |  7 ++
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  4 +
> >   drivers/pci/pci-driver.c                   | 99 +++++++++++++++------=
-
> >   drivers/scsi/mesh.c                        |  1 +
> >   drivers/scsi/stex.c                        |  1 +
> >   drivers/usb/core/hcd-pci.c                 | 11 ++-
> >   drivers/usb/host/sl811-hcd.c               |  1 +
> >   include/linux/pm.h                         |  5 +-
> >   include/trace/events/power.h               |  3 +-
> >   kernel/reboot.c                            |  6 ++
> >   10 files changed, 103 insertions(+), 35 deletions(-)
> >
>
> Rafael, Bjorn,
>
> Any feedback for this series?

I still have the same basic concern as before: It is an intrusive
change likely to cause regressions to occur.

It also changes the driver ABI quite dramatically because different
callbacks will now be used for system shutdown and kexec, for example,
at least on some platforms.

Frankly, I'd like to know Greg's and Danilo's opinions on the direction her=
e.

