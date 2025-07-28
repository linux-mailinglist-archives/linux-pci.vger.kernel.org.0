Return-Path: <linux-pci+bounces-33027-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCA3B13708
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 10:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D189E17857B
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 08:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9912367C4;
	Mon, 28 Jul 2025 08:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cachyos.org header.i=@cachyos.org header.b="gL/9WQ/q"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.ptr1337.dev (mail.ptr1337.dev [202.61.224.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134C43398B;
	Mon, 28 Jul 2025 08:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.224.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753692847; cv=none; b=ahXgubNIUyR3s9sJ0zKVKIbOdTgy9l7htXQ7smpAftQTBtcDiPYco5Ho8KjyBlzpX24B2J2D+Mxd4GL3zSphiycFBeiTa3Mv6ZYcRKL9GZssuOCqNQN6mgwWq2VRBJd33QOB5XknehIjmvY6czM2ZCz4vZGq+dONu/pdK1wj4RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753692847; c=relaxed/simple;
	bh=B0IJjL98PhPeCgMKI5R+ISp5vmenYly7y+1rdHXxrI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pk8y9aZ1CbVQN6LzrCdhlTGeYz0/wqTtinZmYDq9KuJae5uvX8e2kYmloNfzYM+9EjAHOAcg6ZTl4xis4FOimj7DvRY2V3UDbPZhtTkwHh4gntDGotvL0di7teARakQcLOnzAAmc/3CxxDgtmuYOHLAKDHN/b9ecsUE1Ce9Ypk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cachyos.org; spf=pass smtp.mailfrom=cachyos.org; dkim=pass (2048-bit key) header.d=cachyos.org header.i=@cachyos.org header.b=gL/9WQ/q; arc=none smtp.client-ip=202.61.224.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cachyos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cachyos.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 05FAE2842E3;
	Mon, 28 Jul 2025 10:45:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cachyos.org; s=dkim;
	t=1753692331; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=hZAZQxcJny2MJlnbj6INcbeqX5pbA4FFdFvh2PmI64w=;
	b=gL/9WQ/qCqbdu8zR86gU47Fb4JEBykEZI3fYcn9RWlJ1FkRil9jRegxpKVtlMVHiuCRkvD
	eUN8qjcTZbRYiOkvX4mdgh/LxFAr5+8+kF7N59rXBpMN6Ij4pFM7K0toI9/17YaGKGKaib
	TRUqRWvjhzvFhphSevh08vs5VWbN3+rSK8oTR33/pl3tDKExtUZjXzo2iLkcAc7fqbskIw
	LuRqFnwnfmC9KGst5fDt6aVyRY9/lqAnz1lnsj7VqV6WWNJBP5H76boU0TjPx4UuuMwu9R
	DCIWav85qzoBaQQMN29prltn9IdsIgfcfFXvyThIPqE17s2r92h8R/Qfq6plxQ==
Message-ID: <d9a1ed6d-05bb-440d-afa9-cb30315bd02d@cachyos.org>
Date: Mon, 28 Jul 2025 15:45:25 +0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/5] Improvements to S5 power consumption
To: Mario Limonciello <superm1@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>, Bjorn Helgaas <bhelgaas@google.com>
Cc: "open list:RADEON and AMDGPU DRM DRIVERS"
 <amd-gfx@lists.freedesktop.org>,
 "open list:HIBERNATION (aka Software Suspend, aka swsusp)"
 <linux-pm@vger.kernel.org>,
 "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>,
 "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
 "open list:SCSI SUBSYSTEM" <linux-scsi@vger.kernel.org>,
 "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20250616175019.3471583-1-superm1@kernel.org>
Content-Language: en-US
From: Eric Naim <dnaim@cachyos.org>
In-Reply-To: <20250616175019.3471583-1-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 6/17/25 00:50, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> A variety of issues both in function and in power consumption have been
> raised as a result of devices not being put into a low power state when
> the system is powered off.
> 
> There have been some localized changes[1] to PCI core to help these issues,
> but they have had various downsides.
> 
> This series instead tries to use the S4 flow when the system is being
> powered off.  This lines up the behavior with what other operating systems
> do as well.  If for some reason that fails or is not supported, unwind and
> do the previous S5 flow that will wake all devices and run their shutdown()
> callbacks.
> 

Hi Mario,

I've been running this series on CachyOS since 6.16-rc3 and have no issues.

Feel free to add

Tested-by: Eric Naim <dnaim@cachyos.org>

-- 
Regards,
  Eric
> v3->v4:
>  * Fix LKP robot failure
>  * Rebase on v6.16-rc2
> 
> Previous submissions [1]:
> Link: https://lore.kernel.org/linux-pm/CAJZ5v0hrKEJa8Ad7iiAvQ3d_0ysVhzZcXSYc5kkL=6vtseF+bg@mail.gmail.com/T/#m91e4eae868a7405ae579e89b135085f4906225d2
> Link: https://lore.kernel.org/linux-pci/20250506041934.1409302-1-superm1@kernel.org/
> Link: https://lore.kernel.org/linux-pci/20231213182656.6165-1-mario.limonciello@amd.com/ (v1)
> Link: https://lore.kernel.org/linux-pm/20250514193406.3998101-1-superm1@kernel.org/ (v2)
> Link: https://lore.kernel.org/linux-pm/20250609024619.407257-1-superm1@kernel.org/ (v3)
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

