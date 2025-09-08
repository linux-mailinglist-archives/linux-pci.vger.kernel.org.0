Return-Path: <linux-pci+bounces-35693-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88323B49BF2
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 23:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A98B3B30F4
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 21:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1AD32DC32A;
	Mon,  8 Sep 2025 21:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PFeX6TWc"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2992D0605;
	Mon,  8 Sep 2025 21:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757366974; cv=none; b=Fn8DMgPBAv4ut4Pd/QZFM2k/JhY3iWkrNYMvP5ahgW3DDlW6Uht6z90LkXozVxCl7HLxRmh+5O2qJehHao24zh/lMo9IqW+nBkaYyGlGssDBXXk5tzLWAJjtumGa7eOPThh35ysJy79ZvMFDFWWoFyvnpmyIN8s16bnCGg5TeVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757366974; c=relaxed/simple;
	bh=87wlmjfVun7NR0uXFTKy2v0Rn6aPtdZ5ax/ntG+OQ74=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eKgkAPMMiXfU6MZYFA3726GMpi29NMNMDGbwpWRSCbP0bmTtn9p+9V0wGhzsFCOtsWcfNB4IZ9jFRX8iWwJBbhizTg2YrrkSmJJv4EVVeCDQuqKRV8dDShSS7mljS1tlsgJUA0ImAOLFwZR7H2VHXBIlFun4/1a6InBZsaYnlnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PFeX6TWc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95A18C4CEF1;
	Mon,  8 Sep 2025 21:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757366974;
	bh=87wlmjfVun7NR0uXFTKy2v0Rn6aPtdZ5ax/ntG+OQ74=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PFeX6TWcJhdqbGjqqWHVVSKz+GAjCOmHknq9gmovlenesRXhiMgtd7/R7M7M5nVoB
	 GUDEOMeJ1GETn/+1CwUmBh1jGlAff603Ju2gYPjuQ/hai2oWd6SU1I805L3OFJb+1k
	 5m8LOG3MpqaDF5mDSJVHqr+SK30kZ2HiflYlAGtpqvppcTw8bxO5O0Nr80F5Z7CMil
	 ZG5CJ9uExNdEv7hj/x9wDaxbGdC0Ce6sCTO4p2u+9iC34FBt6A9iIXBWmVSFvQHGiR
	 tTn5qvCQBdG06bXOEOjiu9IL+Sza0s8RJpoaGnQ01287LEJ2JK7ENnTv6IGjztz/Wn
	 cgR9REFmx8mZw==
Message-ID: <48a85be6-7aee-48f1-8fdf-2b6f544e42e9@kernel.org>
Date: Mon, 8 Sep 2025 16:29:32 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] PCI/PM: Skip resuming to D0 if disconnected
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
 linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>,
 Lukas Wunner <lukas@wunner.de>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, "Rafael J . Wysocki" <rafael@kernel.org>
References: <20250908210358.GA1464207@bhelgaas>
Content-Language: en-US
From: "Mario Limonciello (kernel.org)" <superm1@kernel.org>
In-Reply-To: <20250908210358.GA1464207@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/8/2025 4:03 PM, Bjorn Helgaas wrote:
> On Mon, Aug 11, 2025 at 11:35:10AM -0500, Mario Limonciello (AMD) wrote:
>> When a USB4 dock is unplugged the PCIe bridge it's connected to will
>> issue a "Link Down" and "Card not detected event". The PCI core will
>> treat this as a surprise hotplug event and unconfigure all downstream
>> devices. This involves setting the device error state to
>> `pci_channel_io_perm_failure` which pci_dev_is_disconnected() will check.
> 
> There's nothing special about USB4 here, right?  I guess the same
> happens with any surprise hotplug remove?

Correct.

> 
> pciehp_unconfigure_device() does the pci_dev_set_io_state(dev,
> pci_channel_io_perm_failure) part on everything that got removed, so
> that part is pretty straightforward.
> 
>> It doesn't make sense to runtime resume disconnected devices to D0 and
>> report the (expected) error, so bail early.
> 
> Can you include a hint about where the runtime resume happens?  It
> seems unintuitive to power up removed devices.

Here's the whole trace.  Basically as part of the base driver release 
the device is runtime resumed.

Do you want me to respin and try to incorporate a sentence or two into 
the commit text?

[   37.237841] dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stack.c:120)
[   37.237858] pci_power_up.cold+0x86/0xc1
[   37.237867] ? __pfx_pci_power_up (drivers/pci/pci.c:1360)
[   37.237876] ? prb_commit (kernel/printk/printk_ringbuffer.c:1748)
[   37.237883] ? __pfx_prb_read_valid 
(kernel/printk/printk_ringbuffer.c:2184)
[   37.237889] pci_pm_power_up_and_verify_state (drivers/pci/pci.c:1146 
drivers/pci/pci.c:1201 drivers/pci/pci.c:3206)
[   37.237897] ? __pfx_pci_pm_power_up_and_verify_state 
(drivers/pci/pci.c:3204)
[   37.237903] ? __pfx_rpm_resume (drivers/base/power/runtime.c:785)
[   37.237911] pci_pm_runtime_resume (drivers/pci/pci-driver.c:561 
drivers/pci/pci-driver.c:1349)
[   37.237918] __rpm_callback (drivers/base/power/runtime.c:406)
[   37.237923] ? __pfx__raw_spin_lock (kernel/locking/spinlock.c:153)
[   37.237932] rpm_callback (drivers/base/power/runtime.c:444)
[   37.237936] ? __pfx_pci_pm_runtime_resume (drivers/pci/pci-driver.c:1338)
[   37.237941] rpm_resume (drivers/base/power/runtime.c:943)
[   37.237946] ? __pfx_rpm_resume (drivers/base/power/runtime.c:785)
[   37.237951] ? _raw_spin_lock_irqsave 
(./include/linux/instrumented.h:96 
./include/linux/atomic/atomic-instrumented.h:1301 
./include/asm-generic/qspinlock.h:111 ./include/linux/spinlock.h:187 
./include/linux/spinlock_api_smp.h:111 kernel/locking/spinlock.c:162)
[   37.237954] ? __pfx__raw_spin_lock_irqsave 
(kernel/locking/spinlock.c:161)
[   37.237958] ? mutex_lock (./include/linux/instrumented.h:96 
./include/linux/atomic/atomic-instrumented.h:4457 
kernel/locking/mutex.c:157 kernel/locking/mutex.c:273)
[   37.237965] __pm_runtime_resume (drivers/base/power/runtime.c:1192)
[   37.237971] device_release_driver_internal (drivers/base/dd.c:1111 
(discriminator 1) drivers/base/dd.c:1252 (discriminator 1) 
drivers/base/dd.c:1297 (discriminator 1))
[   37.237978] ? pci_pme_active (drivers/pci/pci.c:2521)
[   37.237984] pci_stop_bus_device (drivers/pci/remove.c:44 
drivers/pci/remove.c:107)
[   37.237992] pci_stop_bus_device (drivers/pci/remove.c:102 
(discriminator 1))
[   37.237997] pci_stop_and_remove_bus_device (drivers/pci/remove.c:142)
[   37.238003] pciehp_unconfigure_device 
(drivers/pci/hotplug/pciehp_pci.c:124)
[   37.238011] ? __pfx_pciehp_unconfigure_device 
(drivers/pci/hotplug/pciehp_pci.c:96)
[   37.238017] ? _dev_info (drivers/base/core.c:4983)
[   37.238025] pciehp_disable_slot 
(drivers/pci/hotplug/pciehp_ctrl.c:115 
drivers/pci/hotplug/pciehp_ctrl.c:355 drivers/pci/hotplug/pciehp_ctrl.c:364)
[   37.238030] ? __pfx_pciehp_disable_slot 
(drivers/pci/hotplug/pciehp_ctrl.c:360)
[   37.238035] ? __pfx_mutex_unlock (kernel/locking/mutex.c:531)
[   37.238039] ? mutex_lock_interruptible (kernel/locking/mutex.c:992)
[   37.238047] pciehp_handle_presence_or_link_change 
(drivers/pci/hotplug/pciehp_ctrl.c:253)
[   37.238054] ? down_read (kernel/locking/rwsem.c:174 
kernel/locking/rwsem.c:182 kernel/locking/rwsem.c:257 
kernel/locking/rwsem.c:249 kernel/locking/rwsem.c:1260 
kernel/locking/rwsem.c:1274 kernel/locking/rwsem.c:1539)
[   37.238061] ? __pfx_pciehp_handle_presence_or_link_change 
(drivers/pci/hotplug/pciehp_ctrl.c:232)
[   37.238068] ? __pfx_down_read (kernel/locking/rwsem.c:1535)
[   37.238074] ? __pfx_pciehp_ist (drivers/pci/hotplug/pciehp_hpc.c:728)
[   37.238079] pciehp_ist (drivers/pci/hotplug/pciehp_hpc.c:788)
[   37.238085] ? __pfx_pciehp_ist (drivers/pci/hotplug/pciehp_hpc.c:728)
[   37.238091] irq_thread_fn (kernel/irq/manage.c:1131)
[   37.238098] irq_thread (./arch/x86/include/asm/bitops.h:206 
./arch/x86/include/asm/bitops.h:238 
./include/asm-generic/bitops/instrumented-non-atomic.h:142 
kernel/irq/manage.c:1244)
[   37.238104] ? __pfx_irq_thread_fn (kernel/irq/manage.c:1130)
[   37.238110] ? __pfx_irq_thread (kernel/irq/manage.c:1233)
[   37.238115] ? __pfx_irq_thread_dtor (kernel/irq/manage.c:1167)
[   37.238123] ? __kthread_parkme (./arch/x86/include/asm/bitops.h:206 
./arch/x86/include/asm/bitops.h:238 
./include/asm-generic/bitops/instrumented-non-atomic.h:142 
kernel/kthread.c:290)
[   37.238130] ? __pfx_irq_thread (kernel/irq/manage.c:1233)
[   37.238136] ? __pfx_irq_thread (kernel/irq/manage.c:1233)
[   37.238141] kthread (kernel/kthread.c:463)
[   37.238147] ? __pfx_kthread (kernel/kthread.c:412)
[   37.238153] ? finish_task_switch.isra.0 
(./arch/x86/include/asm/irqflags.h:42 
./arch/x86/include/asm/irqflags.h:119 kernel/sched/sched.h:1531 
kernel/sched/core.c:5105 kernel/sched/core.c:5223)
[   37.238161] ? __pfx_kthread (kernel/kthread.c:412)
[   37.238166] ret_from_fork (arch/x86/kernel/process.c:154)
[   37.238175] ? __pfx_kthread (kernel/kthread.c:412)
[   37.238180] ? __pfx_kthread (kernel/kthread.c:412)
[   37.238184] ret_from_fork_asm (arch/x86/entry/entry_64.S:258)
[   37.238192]  </TASK>

> 
>> Suggested-by: Lukas Wunner <lukas@wunner.de>
>> Reviewed-by: Lukas Wunner <lukas@wunner.de>
>> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>> Acked-by: Rafael J. Wysocki <rafael@kernel.org>
>> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
>> ---
>> v6:
>>   * rebase on v6.17-rc1
>> v5:
>>   * Pick up tags, rebase on linux-next
>>   * https://lore.kernel.org/linux-pci/20250709205948.3888045-1-superm1@kernel.org/T/#mbd784f786c50a3d1b5ab1833520995c01eae2fd2
>> ---
>>   drivers/pci/pci.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index b0f4d98036cdd..036511f5b2625 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -1374,6 +1374,11 @@ int pci_power_up(struct pci_dev *dev)
>>   		return -EIO;
>>   	}
>>   
>> +	if (pci_dev_is_disconnected(dev)) {
>> +		dev->current_state = PCI_D3cold;
>> +		return -EIO;
>> +	}
>> +
>>   	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
>>   	if (PCI_POSSIBLE_ERROR(pmcsr)) {
>>   		pci_err(dev, "Unable to change power state from %s to D0, device inaccessible\n",
>>
>> base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
>> -- 
>> 2.43.0
>>


