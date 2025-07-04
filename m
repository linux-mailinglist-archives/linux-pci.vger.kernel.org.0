Return-Path: <linux-pci+bounces-31488-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9D8AF8563
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jul 2025 04:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14DBB58065F
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jul 2025 02:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485F713B7A3;
	Fri,  4 Jul 2025 02:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hkT6XxXa"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E4A2869E;
	Fri,  4 Jul 2025 02:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751594493; cv=none; b=qxKHJyy84qHxHvzwqlmYBg9yxBatrOc/3UQwXUel9ZfKt/eoTh+QpVnHp8rDzhTybkeEBquaMqh2d/IqtCrzRptBchqP6AFJLsmwFKPEDHVEsARuVYcCf+RWbK0pzaCa0/Y/bKddir3kN/SeDp5ju4jobUJK8E7uzRr2C3LcLC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751594493; c=relaxed/simple;
	bh=bOYiwreUJd6fupghKK4N1Ov79oxyIiLE7aijDZhysuo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JqUtZHXG0CoJnwFfd7kWLVFBGysnbGSlL4BteQKd5tENnGB551OVTB9CkLnkI2aOO5QAgTGtgFIZ0uIuhaO5Q64+lfqol8nYb1NZfOhMFjavPADcDzFh4oUNzHUBEiT1Jx/36om+M/5Kb9TLniK9o/DH/XJ9YN9R9f2sdTAT8hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hkT6XxXa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9390DC4CEE3;
	Fri,  4 Jul 2025 02:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751594492;
	bh=bOYiwreUJd6fupghKK4N1Ov79oxyIiLE7aijDZhysuo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hkT6XxXaM+qLqZ/3aN9wdEephOGUKE6kkqGZMAEWEgdc1TTY/L69D4WqUyWr7Nbxc
	 Y95DZlsS+lZBDLlJaNCATZ0IgyVLyvhtQDle6KE9JbY5lE4cPFIczsZc7wZF2FUbH2
	 rqUe0BXglbQA8Wx/nZZn6HlZlNtINB6SWw/9MbITS571lQQgWMQ3A1iFi13iv0wLSn
	 NKq2KHwUTb17SyaP32hsHnQMOhx8WSffRIWv0NgGpgaPci4MSQNCxDGntkM+0kRElN
	 +m4tAlN53C9n7HRIGewrKAFpT0udTf4CVlzaVP5i/ZVA8z+zfKhmLkCobJ1r7VqUUK
	 pF0Fx9/E7iWHA==
Message-ID: <8fda8cf1-1291-422e-bb63-094e38c47b7b@kernel.org>
Date: Thu, 3 Jul 2025 22:01:30 -0400
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/5] Improvements to S5 power consumption
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>,
 "open list:HIBERNATION (aka Software Suspend, aka swsusp)"
 <linux-pm@vger.kernel.org>,
 "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>,
 "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
 "open list:SCSI SUBSYSTEM" <linux-scsi@vger.kernel.org>,
 "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20250616175019.3471583-1-superm1@kernel.org>
 <CAJZ5v0jc-tjs_a+RCzu6bvrbfhv5QHqsWx-zKjH0wpisiJciKA@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <CAJZ5v0jc-tjs_a+RCzu6bvrbfhv5QHqsWx-zKjH0wpisiJciKA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/3/25 10:29, Rafael J. Wysocki wrote:
> On Mon, Jun 16, 2025 at 7:50 PM Mario Limonciello <superm1@kernel.org> wrote:
>>
>> From: Mario Limonciello <mario.limonciello@amd.com>
>>
>> A variety of issues both in function and in power consumption have been
>> raised as a result of devices not being put into a low power state when
>> the system is powered off.
>>
>> There have been some localized changes[1] to PCI core to help these issues,
>> but they have had various downsides.
>>
>> This series instead tries to use the S4 flow when the system is being
>> powered off.  This lines up the behavior with what other operating systems
>> do as well.  If for some reason that fails or is not supported, unwind and
>> do the previous S5 flow that will wake all devices and run their shutdown()
>> callbacks.
> 
> I actually like this approach, but I think that it is risky.

Yeah; it does touch a lot of areas.

> 
> It also requires more work/review from other people.

I view patches 3-5 as being dependent upon patch 1, so until we have 
agreement on that one the others might not make a lot of sense.

Bjorn,

Can you take a look at patch 2?

> 
> I'll be sending some comments on the individual patches going forward,
> but I think the earliest it can go in is after 6.17-rc1 (given it is
> reviewed properly till then).

Thanks!

> 
> Thanks!
> 
>> v3->v4:
>>   * Fix LKP robot failure
>>   * Rebase on v6.16-rc2
>>
>> Previous submissions [1]:
>> Link: https://lore.kernel.org/linux-pm/CAJZ5v0hrKEJa8Ad7iiAvQ3d_0ysVhzZcXSYc5kkL=6vtseF+bg@mail.gmail.com/T/#m91e4eae868a7405ae579e89b135085f4906225d2
>> Link: https://lore.kernel.org/linux-pci/20250506041934.1409302-1-superm1@kernel.org/
>> Link: https://lore.kernel.org/linux-pci/20231213182656.6165-1-mario.limonciello@amd.com/ (v1)
>> Link: https://lore.kernel.org/linux-pm/20250514193406.3998101-1-superm1@kernel.org/ (v2)
>> Link: https://lore.kernel.org/linux-pm/20250609024619.407257-1-superm1@kernel.org/ (v3)
>>
>> Mario Limonciello (5):
>>    PM: Use hibernate flows for system power off
>>    PCI: Put PCIe ports with downstream devices into D3 at hibernate
>>    drm/amd: Avoid evicting resources at S5
>>    scsi: Add PM_EVENT_POWEROFF into suspend callbacks
>>    usb: sl811-hcd: Add PM_EVENT_POWEROFF into suspend callbacks
>>
>>   drivers/base/power/main.c                  |  7 ++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  4 +
>>   drivers/pci/pci-driver.c                   | 94 ++++++++++++++--------
>>   drivers/scsi/mesh.c                        |  1 +
>>   drivers/scsi/stex.c                        |  1 +
>>   drivers/usb/host/sl811-hcd.c               |  1 +
>>   include/linux/pm.h                         |  3 +
>>   include/trace/events/power.h               |  3 +-
>>   kernel/reboot.c                            |  6 ++
>>   9 files changed, 86 insertions(+), 34 deletions(-)
>>
>> --
>> 2.43.0
>>


