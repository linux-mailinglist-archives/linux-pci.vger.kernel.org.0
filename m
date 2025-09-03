Return-Path: <linux-pci+bounces-35350-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A1AB41396
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 06:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F19C680108
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 04:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6A82D3EC0;
	Wed,  3 Sep 2025 04:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s/wbSSBA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2C02D3A71;
	Wed,  3 Sep 2025 04:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756874516; cv=none; b=B+NgY05FhnMe9/GGYizIUfc2kR89n73Qit/Q3xbIKge6nxlqgdmB03IS0TtbJN51cnLTpoerHgMQy6rqFBSX1uJKWl1a/Bic9JuNo0iuiOLlkUuAN/EPitQKsSlbJAq03UrA6yL9Y+tPHui0MGRCvaFt7SGygDOZ42UDrHQIIJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756874516; c=relaxed/simple;
	bh=Ce5ETH+F6WnWDEeaq7pLglfV4JdFcr3PKEJyxp/keno=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XN1gnNkX7wy3aXifhWNBNemX2RmarO9zHhtk1Ze6t0g6gjegt/ZxAMu8qTJ6Hi/Yt/LwYqJAyhhuOmXvSkrZQx7UFXHeLf9Rr93OO5gXQrCVwHhHApvfKP981Mpzds8AMMnBpMoCYBI5jbjN4aFiDKh14WrcYF49m2VMjN3vIqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s/wbSSBA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C2AAC4CEF0;
	Wed,  3 Sep 2025 04:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756874516;
	bh=Ce5ETH+F6WnWDEeaq7pLglfV4JdFcr3PKEJyxp/keno=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=s/wbSSBARIKT8Fd9JqzskawfzifT7+BPOBAzwXDl6WBxhU410noLNvQWfHvv+Nb4Q
	 SbPcIb3hxSHQY5dHlRH7uTb7j/F/Gu7pEGr7MuO33HXsvNskDBMUab0jPLJFQsfQGn
	 DBDR9JuXyqBeBGip1IjfApmvbUcrJdSUfPe1zWbEw+SMhMPPGSNw74IL9FARn5fKmF
	 zjHgI792YdyiwMwWOpQd3S9Oo3Edup8Zqq77sQ1wl2zqgUT6OeYww9IfARtdlcDtB3
	 vOHV/VFLi6+2jqm//3XxZoeker+XP6Xe8Qrr8AEKkb368Q3fZA1sXUVv4Sn/GGGapn
	 XGwAwOPKYtzMA==
Message-ID: <29e61472-5f41-4e76-9b5b-f3e106d6a629@kernel.org>
Date: Tue, 2 Sep 2025 23:41:52 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/11] Improvements to S5 power consumption
To: "Rafael J . Wysocki" <rafael@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>
Cc: Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 "open list:HIBERNATION (aka Software Suspend, aka swsusp)"
 <linux-pm@vger.kernel.org>,
 "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>,
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
 "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
 "open list:SCSI SUBSYSTEM" <linux-scsi@vger.kernel.org>,
 "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
 "open list:TRACING" <linux-trace-kernel@vger.kernel.org>,
 AceLan Kao <acelan.kao@canonical.com>, Kai-Heng Feng <kaihengf@nvidia.com>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 =?UTF-8?Q?Merthan_Karaka=C5=9F?= <m3rthn.k@gmail.com>,
 Eric Naim <dnaim@cachyos.org>
References: <20250818020101.3619237-1-superm1@kernel.org>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20250818020101.3619237-1-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/17/2025 9:00 PM, Mario Limonciello (AMD) wrote:
> A variety of issues both in function and in power consumption have been
> raised as a result of devices not being put into a low power state when
> the system is powered off.
> 
> There have been some localized changes[1] to PCI core to help these issues,
> but they have had various downsides.
> 
> This series instead tries to use the S4 flow when the system is being
> powered off.  This lines up the behavior with what other operating systems
> do as well.  If for some reason that fails or is not supported, run their
> shutdown() callbacks.
> 
> Cc: AceLan Kao <acelan.kao@canonical.com>
> Cc: Kai-Heng Feng <kaihengf@nvidia.com>
> Cc: Mark Pearson <mpearson-lenovo@squebb.ca>
> Cc: Merthan Karakaş <m3rthn.k@gmail.com>
> Cc: Eric Naim <dnaim@cachyos.org>
> ---
> v5->v6:
>   * Fix for LKP robot issue
>   * Some commit message changes
>   * Rebase on 6.17-rc2
> 
> Mario Limonciello (AMD) (11):
>    PM: Introduce new PMSG_POWEROFF event
>    scsi: Add PM_EVENT_POWEROFF into suspend callbacks
>    usb: sl811-hcd: Add PM_EVENT_POWEROFF into suspend callbacks
>    USB: Pass PMSG_POWEROFF event to suspend_common() for poweroff with S4
>      flow
>    PCI: PM: Disable device wakeups when halting system through S4 flow
>    PCI: PM: Split out code from pci_pm_suspend_noirq() into helper
>    PCI: PM: Run bridge power up actions as part of restore phase
>    PCI: PM: Use pci_power_manageable() in pci_pm_poweroff_noirq()
>    PCI: Put PCIe bridges with downstream devices into D3 at hibernate
>    drm/amd: Avoid evicting resources at S5
>    PM: Use hibernate flows for system power off
> 
>   drivers/base/power/main.c                  |  7 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  4 +
>   drivers/pci/pci-driver.c                   | 99 +++++++++++++++-------
>   drivers/scsi/mesh.c                        |  1 +
>   drivers/scsi/stex.c                        |  1 +
>   drivers/usb/core/hcd-pci.c                 | 11 ++-
>   drivers/usb/host/sl811-hcd.c               |  1 +
>   include/linux/pm.h                         |  5 +-
>   include/trace/events/power.h               |  3 +-
>   kernel/reboot.c                            |  6 ++
>   10 files changed, 103 insertions(+), 35 deletions(-)
> 

Rafael, Bjorn,

Any feedback for this series?

Thanks,

