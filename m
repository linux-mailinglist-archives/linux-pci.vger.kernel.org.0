Return-Path: <linux-pci+bounces-27285-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB76AACA1C
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 17:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD0A9983250
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 15:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25AE2281523;
	Tue,  6 May 2025 15:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rxlYUX6d"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009E3281377
	for <linux-pci@vger.kernel.org>; Tue,  6 May 2025 15:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746546615; cv=none; b=O+a0F1trMWpQsw4n4BxQBYt62zB8aaBwGkuY9gw74TS8oA3EMlfhaOnnERSJn6b1asNJpmIX7Pu/Fmwcabu9JDBTGKQfAl0C+GixSYzu1SogcF8LJ53tP7l/X1otA9H8EKAZx6e92ljBgA3opMocc3MJriGMW+6ngD6iL2SJ8TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746546615; c=relaxed/simple;
	bh=a0ZJHX/mQCA5cJy3NmjgO4KjxIyNk1OOGI3dmPp8NXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ig30IpwU2+vrQR9qDME1/IfNwaS/gw55aBcFaU4JuYsQ8XPUDhpmSc7+cOM61jTvtWXXrX+UyfDhw62F6+R/nR65T2ccWDwx095BKoG+XmseIIy9HMrJDe6QyfEofbcHg3AdiKyiEF5GOZe9FC7PIUhDRg2+iPPGe3twDX+3SQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rxlYUX6d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B8ACC4CEEF
	for <linux-pci@vger.kernel.org>; Tue,  6 May 2025 15:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746546614;
	bh=a0ZJHX/mQCA5cJy3NmjgO4KjxIyNk1OOGI3dmPp8NXs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rxlYUX6dcYAvIa0qpFxtmg5h+8dCrK9faYpt0tYdvP47/gFnJUVEXUFhzy1DuMN0F
	 tSiToQhnW9IFpsQO2BBaIaeDdpUXywUI3RpEzkBf2GHslbDzUYPwyiquRSN2o5MyOG
	 dvd7bfACwisegIQmUXarCHoRhpC1yPzCeV3WccyS9+Y+Srs94M/sr61HPzW6Dcj+rC
	 72YNaPoXpxXgF96Zoslg+kR8gl2w2KgM1JV1LUYP+nWc+2aAKsCjLEv3HGTzEpxFO5
	 +PvqODzhtaJumH8/f+fkzNwVcpU4+n2pQ2TxoNbOkWaYmmlDDEaTD79hVhBRAzpTkJ
	 WxwV5X0Py6Yhg==
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-40337dd3847so3210076b6e.0
        for <linux-pci@vger.kernel.org>; Tue, 06 May 2025 08:50:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXrkYCQEaj4EN995SlwV1y2r9gWL6/o1l5UjQuh5Jp7IDMTNKV+y/P0K4GQwORIBMzKYkQAX1sOQiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6V+Ssiot7sPkVwqWMVrd9Up640mslXwEm5JwxUqjbxDaXHJqm
	jRX/g8lofaEezFMF9bKuanCVk5itWgYnTkQJTHC6BVIR4OHX3kfLBknZWxsPang36aQD6kP6yuA
	wHAkxV9R62dIHLCf45eF8KUMWJa4=
X-Google-Smtp-Source: AGHT+IGuBh1Abxw2QZGzbCe6ezrX2bsRxjFtOz5iA0hJ55Tf1l5lnxTJCeyTCgcDVTEosFc3dXKeUeCLs8uZGSApx1o=
X-Received: by 2002:a05:6808:138d:b0:3f8:150b:f571 with SMTP id
 5614622812f47-4036ec19726mr146575b6e.21.1746546613756; Tue, 06 May 2025
 08:50:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250506041934.1409302-1-superm1@kernel.org>
In-Reply-To: <20250506041934.1409302-1-superm1@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 6 May 2025 17:50:02 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jXYgLsMHyD7EQwAf47=HnU7MCpC7+Th7nnonqV-q2qJQ@mail.gmail.com>
X-Gm-Features: ATxdqUFCUoMF62TNwCTCA-lmHQBtbP_QewF7qrVsEb-o30vzpxAJEww74Wa81KM
Message-ID: <CAJZ5v0jXYgLsMHyD7EQwAf47=HnU7MCpC7+Th7nnonqV-q2qJQ@mail.gmail.com>
Subject: Re: [PATCH v3] PCI/PM: Put devices to low power state on shutdown
To: Mario Limonciello <superm1@kernel.org>
Cc: rafael@kernel.org, bhelgaas@google.com, 
	Kai-Heng Feng <kaihengf@nvidia.com>, AceLan Kao <acelan.kao@canonical.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Mark Pearson <mpearson-lenovo@squebb.ca>, 
	Denis Benato <benato.denis96@gmail.com>, =?UTF-8?Q?Merthan_Karaka=C5=9F?= <m3rthn.k@gmail.com>, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 6, 2025 at 6:19=E2=80=AFAM Mario Limonciello <superm1@kernel.or=
g> wrote:
>
> From: Kai-Heng Feng <kaihengf@nvidia.com>
>
> Some laptops wake up after poweroff when HP Thunderbolt Dock G4 is
> connected.
>
> The following error message can be found during shutdown:
> pcieport 0000:00:1d.0: AER: Correctable error message received from 0000:=
09:04.0
> pcieport 0000:09:04.0: PCIe Bus Error: severity=3DCorrectable, type=3DDat=
a Link Layer, (Receiver ID)
> pcieport 0000:09:04.0:   device [8086:0b26] error status/mask=3D00000080/=
00002000
> pcieport 0000:09:04.0:    [ 7] BadDLLP
>
> Calling aer_remove() during shutdown can quiesce the error message,
> however the spurious wakeup still happens.
>
> The issue won't happen if the device is in D3 before system shutdown, so
> putting device to low power state before shutdown to solve the issue.
>
> ACPI Spec 6.5, "7.4.2.5 System \_S4 State" says "Devices states are
> compatible with the current Power Resource states. In other words, all
> devices are in the D3 state when the system state is S4."
>
> The following "7.4.2.6 System \_S5 State (Soft Off)" states "The S5
> state is similar to the S4 state except that OSPM does not save any
> context." so it's safe to assume devices should be at D3 for S5.

That's fine as long as you assume that ->shutdown() is only used for
implementing ACPI S5, but it is not.

> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D219036
> Cc: AceLan Kao <acelan.kao@canonical.com>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Tested-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Kai-Heng Feng <kaihengf@nvidia.com>
> Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Tested-by: Denis Benato <benato.denis96@gmail.com>
> Tested-by: Merthan Karaka=C5=9F <m3rthn.k@gmail.com>
> Link: https://lore.kernel.org/r/20241208074147.22945-1-kaihengf@nvidia.co=
m
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v3:
>  * Pick up tags
>  * V2 was waiting for Rafael to review, rebase on pci/next and resend.

Is this change going to break kexec?

> ---
>  drivers/pci/pci-driver.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 0c5bdb8c2c07b..5bbe8af996390 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -510,6 +510,14 @@ static void pci_device_shutdown(struct device *dev)
>         if (drv && drv->shutdown)
>                 drv->shutdown(pci_dev);
>
> +       /*
> +        * If driver already changed device's power state, it can mean th=
e
> +        * wakeup setting is in place, or a workaround is used. Hence kee=
p it
> +        * as is.
> +        */
> +       if (!kexec_in_progress && pci_dev->current_state =3D=3D PCI_D0)
> +               pci_prepare_to_sleep(pci_dev);
> +
>         /*
>          * If this is a kexec reboot, turn off Bus Master bit on the
>          * device to tell it to not continue to do DMA. Don't touch
> --

