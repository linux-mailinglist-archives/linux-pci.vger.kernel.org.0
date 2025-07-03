Return-Path: <linux-pci+bounces-31408-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 191A9AF779A
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 16:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF3817BE091
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 14:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778502EAB6A;
	Thu,  3 Jul 2025 14:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EUtQUVaT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C022EA46B;
	Thu,  3 Jul 2025 14:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751552999; cv=none; b=npNgCoDP15zhF2pTy5ZJPez5SDQycnojO8GfDTYKwaP/2iSeJR06p9OfK1+a6dO+4QV5PnFYs+9WHNY8SeewsgCURExfQjJO5atYZ3LBc3q6psEEWeWxXVJ26fQOtS9WxnjyqCGYPog7V8BfpVcuY5Z/UFRbeKiLNOtv0vcOZgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751552999; c=relaxed/simple;
	bh=Fm3qk2Sxt9oTRrrfhvZcED03yYICrUHHIb3sCtzNWN4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f71O/7tWZaI3KhAj3P6qGjqXBrR+gFILRs7Zd72VSFGluHfTIYJPNX4Zo3BJTcURyIsc49NtI/wxQVw9mTgPmqxVnY7QgUwhIVxVRQC1PJm7rQOuq/4Y/XphfEMDkj95v+6bvDfVXO5b0ObwoU+nmWxjD06vMfasVoSz8piY8bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EUtQUVaT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2C47C4AF0B;
	Thu,  3 Jul 2025 14:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751552998;
	bh=Fm3qk2Sxt9oTRrrfhvZcED03yYICrUHHIb3sCtzNWN4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EUtQUVaTKURBSPBDtNxwsZsLLGU/xuEHfm0PM0K5AWLaAr0lx8/+TnwYPfB+kyugp
	 o5d1bOfi4bMzMx2v5TNIDepiHs+lhKKtjX3PEHUE1FABzscTZA81BEJuCo0M0+oFZE
	 dOrF4zbUAof8uuDe+iZKSFilPr/iDnGR0fZS146Rn1y2CwpF2gGr8tGklAwmWHwLd/
	 H8Hc4TXVr72JEd4ApQIUdwamFnhZZ9yo02YLAo86ZBHy6BnhWR2tguDc4rTB9wd0PV
	 4ddhT8qjZhuaiqWLp/lCL2F70yOJqRDWT/21+N7ylRkXCOvzQfNM3ccrTj/VKiWXAz
	 zCMqHWcqpGzCA==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-610d87553b6so3239901eaf.2;
        Thu, 03 Jul 2025 07:29:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUGLNMn8xDXP/CdB+o+Odk4XOQAOV46qm0PqJS1QbplrnnfPrmBgEFdzHHbCkTls49lLE0olSRye9qn@vger.kernel.org, AJvYcCUHqUnwnjQcTWDKxYupZMEjwptdst7KXenxVJ6/dnVFCxiucqEGkB0rRDbtbIVnzUqGR6Ziz5sgV0Ou@vger.kernel.org, AJvYcCVyNZTU15TfF5FdZZqqWPfPv5UgNrxCng4xnRgIqT3bAJ9ox9P2FzoOKSam10x6HjjcElPMSchQgI8=@vger.kernel.org, AJvYcCX7ZX3/1EVzejOdGOeUyBz176L8EvQqGV+Xkq2MPxsJSw+F2rWb8H121B5TpD5yM3KTwImtrahC1iEK6io=@vger.kernel.org, AJvYcCXpikidFen+InVaqwdbKQ03ZBrFROJFDXIPx6jola4LQQvUlUB7DjSWzWJibLG76uWLxbxnY0O084ZUqQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzkVMhyJoCmyMy2tLcPji2GPZ/GtOf1FbXQGeXcf9gN7QNFu3Ud
	F/Q6qhlWDjKWMhMdRLKF3YTeLaTQdbjSzK60eReGB+y3+IT2KOdgVbrR4KalAAcz6xjXSUKOjOY
	QsUXW0yiZLNTGVQZjCAWxOsTEA0KFfFk=
X-Google-Smtp-Source: AGHT+IGKqgRrtyx19Ohp3Z1EI2LoOc/W9BuT9DA7/iSo9WQpIWa8l502nswOSx3IuDHZQjfc+w2NIPaPXuTzX8u35dk=
X-Received: by 2002:a05:6820:2713:b0:611:bbad:7b62 with SMTP id
 006d021491bc7-6120112a218mr4957769eaf.3.1751552997991; Thu, 03 Jul 2025
 07:29:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250616175019.3471583-1-superm1@kernel.org>
In-Reply-To: <20250616175019.3471583-1-superm1@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 3 Jul 2025 16:29:46 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jc-tjs_a+RCzu6bvrbfhv5QHqsWx-zKjH0wpisiJciKA@mail.gmail.com>
X-Gm-Features: Ac12FXyr5oPvb2c3yNjkDygXC9l6Pt_56oLkJ04HxD0-cR-THCDtscKWWn70wDY
Message-ID: <CAJZ5v0jc-tjs_a+RCzu6bvrbfhv5QHqsWx-zKjH0wpisiJciKA@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] Improvements to S5 power consumption
To: Mario Limonciello <superm1@kernel.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Alex Deucher <alexander.deucher@amd.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, 
	"open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>, 
	"open list:HIBERNATION (aka Software Suspend, aka swsusp)" <linux-pm@vger.kernel.org>, 
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K . Petersen" <martin.petersen@oracle.com>, 
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, 
	"open list:SCSI SUBSYSTEM" <linux-scsi@vger.kernel.org>, 
	"open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>, Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 7:50=E2=80=AFPM Mario Limonciello <superm1@kernel.o=
rg> wrote:
>
> From: Mario Limonciello <mario.limonciello@amd.com>
>
> A variety of issues both in function and in power consumption have been
> raised as a result of devices not being put into a low power state when
> the system is powered off.
>
> There have been some localized changes[1] to PCI core to help these issue=
s,
> but they have had various downsides.
>
> This series instead tries to use the S4 flow when the system is being
> powered off.  This lines up the behavior with what other operating system=
s
> do as well.  If for some reason that fails or is not supported, unwind an=
d
> do the previous S5 flow that will wake all devices and run their shutdown=
()
> callbacks.

I actually like this approach, but I think that it is risky.

It also requires more work/review from other people.

I'll be sending some comments on the individual patches going forward,
but I think the earliest it can go in is after 6.17-rc1 (given it is
reviewed properly till then).

Thanks!

> v3->v4:
>  * Fix LKP robot failure
>  * Rebase on v6.16-rc2
>
> Previous submissions [1]:
> Link: https://lore.kernel.org/linux-pm/CAJZ5v0hrKEJa8Ad7iiAvQ3d_0ysVhzZcX=
SYc5kkL=3D6vtseF+bg@mail.gmail.com/T/#m91e4eae868a7405ae579e89b135085f49062=
25d2
> Link: https://lore.kernel.org/linux-pci/20250506041934.1409302-1-superm1@=
kernel.org/
> Link: https://lore.kernel.org/linux-pci/20231213182656.6165-1-mario.limon=
ciello@amd.com/ (v1)
> Link: https://lore.kernel.org/linux-pm/20250514193406.3998101-1-superm1@k=
ernel.org/ (v2)
> Link: https://lore.kernel.org/linux-pm/20250609024619.407257-1-superm1@ke=
rnel.org/ (v3)
>
> Mario Limonciello (5):
>   PM: Use hibernate flows for system power off
>   PCI: Put PCIe ports with downstream devices into D3 at hibernate
>   drm/amd: Avoid evicting resources at S5
>   scsi: Add PM_EVENT_POWEROFF into suspend callbacks
>   usb: sl811-hcd: Add PM_EVENT_POWEROFF into suspend callbacks
>
>  drivers/base/power/main.c                  |  7 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  4 +
>  drivers/pci/pci-driver.c                   | 94 ++++++++++++++--------
>  drivers/scsi/mesh.c                        |  1 +
>  drivers/scsi/stex.c                        |  1 +
>  drivers/usb/host/sl811-hcd.c               |  1 +
>  include/linux/pm.h                         |  3 +
>  include/trace/events/power.h               |  3 +-
>  kernel/reboot.c                            |  6 ++
>  9 files changed, 86 insertions(+), 34 deletions(-)
>
> --
> 2.43.0
>

