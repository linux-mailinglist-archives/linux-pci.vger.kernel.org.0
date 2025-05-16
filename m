Return-Path: <linux-pci+bounces-27896-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A486FABA3D6
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 21:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D9FAA0209A
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 19:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E856222579E;
	Fri, 16 May 2025 19:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NIiYRMCB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB8EEEBA;
	Fri, 16 May 2025 19:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747424007; cv=none; b=O0tCFVMBUeCqK0dpQTmRFrQ9/E2ZWw4niHsOMSjk2inXzqaneUidM533h1Dk7wDY5GQufHMCpKszGbliHtIBEjjXgSrDR6Q78hShTfL2ZjDkRzhOpYRWsG3+yY54tk0uPGxYREKQht/PyZ5Usxe4uNtOJCSyXsClGWPuICE/HMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747424007; c=relaxed/simple;
	bh=sccI53fPqFZZzNQqVmK+EE/oIeQR01e/22d3c05Pjic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bZgSAiQ9JU7ptLuqXs7DAs4PFKkPJdSiMnuTG7riLP6HKarXBd0eYVfFc6o3gJm1DhOSaEhv+DENAsqNo7QXvFFxfNDVDK4fiy3d520Pw7Sw6L47vSH4jkrJuUKt9e7uNqmsgbDFBxboutET2IMCmga/Nd1AMd+IGZ/Vi7bDGpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NIiYRMCB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBCEDC4CEE4;
	Fri, 16 May 2025 19:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747424007;
	bh=sccI53fPqFZZzNQqVmK+EE/oIeQR01e/22d3c05Pjic=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NIiYRMCBb8IXbczp39jbWPPCafdCLMAt5StngHoNs5tiOpFVCUH3PL7v/5I+H+IWs
	 C977U4ipALgtrwT/eA8nivNnDILFJYfm0dqgObnnkct4IjBQhFcRREUvxD2BoTpD4K
	 RfRE7r5zvLO4umt3rp/yh+gfapqKqxNFTD8w3g6bcR5ZVI234Dh1dk+99Nr/3Rrel2
	 GfqVpna+D42rn5RMybR2HpEgZy1PdpekjZO0zPKfwBUXlVkGHI6l44Xrb93LLqnnMi
	 pd/oh2mn1JEYSV6Mt2DYgH1RRfgjFonePuYpPyS1pSmOAtdBdPQQpyJfeVd2bj2vcT
	 yuExqVabve3KA==
Message-ID: <d77b51a6-24a0-4b24-b3f8-c6de8809b686@kernel.org>
Date: Fri, 16 May 2025 14:33:24 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] PM: Use hibernate flows for system power off
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>,
 "open list:HIBERNATION (aka Software Suspend, aka swsusp)"
 <linux-pm@vger.kernel.org>,
 "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>,
 AceLan Kao <acelan.kao@canonical.com>, Kai-Heng Feng <kaihengf@nvidia.com>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 =?UTF-8?Q?Merthan_Karaka=C5=9F?= <m3rthn.k@gmail.com>,
 Denis Benato <benato.denis96@gmail.com>
References: <20250514193406.3998101-1-superm1@kernel.org>
 <20250514193406.3998101-2-superm1@kernel.org>
 <CAJZ5v0jifqTP_eZ33nBmKPCuLWrrVF_0jNGf5CpHU6nXuK8qBw@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <CAJZ5v0jifqTP_eZ33nBmKPCuLWrrVF_0jNGf5CpHU6nXuK8qBw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/16/2025 9:58 AM, Rafael J. Wysocki wrote:
> On Wed, May 14, 2025 at 9:34 PM Mario Limonciello <superm1@kernel.org> wrote:
>>
>> From: Mario Limonciello <mario.limonciello@amd.com>
>>
>> When the system is powered off the kernel will call device_shutdown()
>> which will issue callbacks into PCI core to wake up a device and call
>> it's shutdown() callback.  This will leave devices in ACPI D0 which can
>> cause some devices to misbehave with spurious wakeups and also leave some
>> devices on which will consume power needlessly.
>>
>> The issue won't happen if the device is in D3 before system shutdown, so
>> putting device to low power state before shutdown solves the issue.
>>
>> ACPI Spec 6.5, "7.4.2.5 System \_S4 State" says "Devices states are
>> compatible with the current Power Resource states. In other words, all
>> devices are in the D3 state when the system state is S4."
>>
>> The following "7.4.2.6 System \_S5 State (Soft Off)" states "The S5
>> state is similar to the S4 state except that OSPM does not save any
>> context." so it's safe to assume devices should be at D3 for S5.
>>
>> To accomplish this, modify the PM core to call all the device hibernate
>> callbacks when turning off the system when the kernel is compiled with
>> hibernate support. If compiled without hibernate support or hibernate fails
>> fall back into the previous shutdown flow.
>>
>> Cc: AceLan Kao <acelan.kao@canonical.com>
>> Cc: Kai-Heng Feng <kaihengf@nvidia.com>
>> Cc: Mark Pearson <mpearson-lenovo@squebb.ca>
>> Cc: Merthan Karakaş <m3rthn.k@gmail.com>
>> Tested-by: Denis Benato <benato.denis96@gmail.com>
>> Link: https://lore.kernel.org/linux-pci/20231213182656.6165-1-mario.limonciello@amd.com/
>> Link: https://lore.kernel.org/linux-pci/20250506041934.1409302-1-superm1@kernel.org/
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>> v2:
>>   * Handle failures to hibernate (fall back to shutdown)
>>   * Don't use dedicated events
>>   * Only allow under CONFIG_HIBERNATE_CALLBACKS
>> ---
>>   kernel/reboot.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/kernel/reboot.c b/kernel/reboot.c
>> index ec087827c85cd..52f5e6e36a6f8 100644
>> --- a/kernel/reboot.c
>> +++ b/kernel/reboot.c
>> @@ -13,6 +13,7 @@
>>   #include <linux/kexec.h>
>>   #include <linux/kmod.h>
>>   #include <linux/kmsg_dump.h>
>> +#include <linux/pm.h>
>>   #include <linux/reboot.h>
>>   #include <linux/suspend.h>
>>   #include <linux/syscalls.h>
>> @@ -305,6 +306,17 @@ static void kernel_shutdown_prepare(enum system_states state)
>>                  (state == SYSTEM_HALT) ? SYS_HALT : SYS_POWER_OFF, NULL);
>>          system_state = state;
>>          usermodehelper_disable();
>> +#ifdef CONFIG_HIBERNATE_CALLBACKS
>> +       if (dpm_suspend_start(PMSG_HIBERNATE))
>> +               goto resume_devices;
> 
> A failure of one device may trigger a cascade of failures when trying
> to resume devices and it is not even necessary to resume the ones that
> have been powered off successfully.

Right it "shouldn't" be necessary, but I wanted to make sure that we had 
a clean (expected) slate going into device_shutdown().

Otherwise drivers might not have been prepared to go right from 
poweroff() to shutdown() callbacks.

> 
> IMV this should just ignore errors during the processing of devices,
> so maybe introduce PMSG_POWEROFF for it?

Hmm - I guess it depends upon the failures that occurred.  I'll start 
plumbing a new message and see how it looks.

I don't "think" we can safely call dpm_suspend_end() if 
dpm_suspend_start() failed though.

> 
> It should also ignore wakeup events that occur while devices are powered off.
> 
>> +       if (dpm_suspend_end(PMSG_HIBERNATE))
>> +               goto resume_devices;
>> +       return;
>> +
>> +resume_devices:
>> +       pr_emerg("Failed to power off devices, using shutdown instead.\n");
>> +       dpm_resume_end(PMSG_RESTORE);
> 
> Unfortunately, PMSG_RESTORE is not the right resume action for
> PMSG_HIBERNATE because it may not power-up things (some drivers assume
> that the restore kernel will power-up devices and so they don't do it
> in "restore" callbacks).
> 
> I do realize that hibernation uses it to reverse PMSG_HIBERNATE, but
> it should not do that either.  That may be fixed later, though.
> 
>> +#endif
>>          device_shutdown();
>>   }
>>   /**
>> --
> 
> I'd prefer to get back to this series after the 6.16 merge window
> starts.  It is sort of last minute for 6.16 and it is far from ready
> IMV.

Sure, I'll get a start on your feedback above and submit a fixed up 
version after the merge window.

