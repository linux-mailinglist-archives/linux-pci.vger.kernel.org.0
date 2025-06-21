Return-Path: <linux-pci+bounces-30309-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D43AE2C0C
	for <lists+linux-pci@lfdr.de>; Sat, 21 Jun 2025 21:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3941E1626EA
	for <lists+linux-pci@lfdr.de>; Sat, 21 Jun 2025 19:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AFA02701C8;
	Sat, 21 Jun 2025 19:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oh1Z6peY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F88276030;
	Sat, 21 Jun 2025 19:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750535771; cv=none; b=jDeA0bT+qQSNs8mzNbek7gtuobd1EKhFJOPKqGSGi84MshjpGxm7gdGKuq/tW/0s1yUMC4tohhL6esEO+EXXYeBEnwaMKDpLRhr2UDw556WbnwyiX5CoU7Y5GuTmvo+1DxHGLQ7F1UHBObZiZDqVBO61vdiqnwFAqjSPASR0y50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750535771; c=relaxed/simple;
	bh=liul8jD0ELbuQqaxi8GGogPWb6VrjzYIu61ldrp72v4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a0IF6KQYOyFKg/LyJPqF6xOP2wMkLl92/T4J4lVt0641Dk6v/cykTY92mcB5sC49O+qjzq4AkOxTuoaZaMWiLx+UqtndmakLAz4VXHLICj3GPW/DdeytjmnCUSaoEsuf7vhh1bQIsg4/YJklO8mKVlUXRBqypkGS8iElUui9jGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oh1Z6peY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B72B4C4CEE7;
	Sat, 21 Jun 2025 19:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750535771;
	bh=liul8jD0ELbuQqaxi8GGogPWb6VrjzYIu61ldrp72v4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Oh1Z6peYNoP2LAIwKrJhaSbR49T2kkkNPz6bJRRFFEsbjse01DwmribcwiQhAvgMK
	 gNudV4n630F+0IoCpa7LAxp3FMqhHm5hnitpbCSvNQlYZdwhHy6atIdMVwvlPP4ymo
	 3QyUIUye2QiJTGKY6mMXNEUogJmY3gHWqWEdQAIgkXKWWsB41fuMupLSxPoAtDdZxl
	 6FwO7QrajCeM4KLFcgIXGw1/rr1un61VfcdkjGRrowxy9tGEEjNivJH3ezi+G3u5lF
	 viUIKCsoiMubWz9IrWy92Vxy/3NRYyE/IwHEWOMKAZY9VtuKqe0v7mwK1JhxXAMBGJ
	 yAGk48JWMWFmA==
Message-ID: <8d4d98b6-fec5-466f-bd2c-059d702c7860@kernel.org>
Date: Sat, 21 Jun 2025 14:56:08 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] PCI: Fix runtime PM usage count underflow on
 device unplug
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
 linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20250620025535.3425049-1-superm1@kernel.org>
 <20250620025535.3425049-3-superm1@kernel.org> <aFcCaw_IZr-JuUYY@wunner.de>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <aFcCaw_IZr-JuUYY@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/21/25 2:05 PM, Lukas Wunner wrote:
> On Thu, Jun 19, 2025 at 09:55:35PM -0500, Mario Limonciello wrote:
>> When a USB4 dock is unplugged the PCIe bridge it's connected to will
>> remove issue a "Link Down" and "Card not detected event". The PCI core
>> will treat this as a surprise hotplug event and unconfigure all downstream
>> devices.
>>
>> pci_stop_bus_device() will call device_release_driver(). As part of device
>> release sequence pm_runtime_put_sync() is called for the device which will
>> decrement the runtime counter to 0. After this, the device remove callback
>> (pci_device_remove()) will be called which again calls pm_runtime_put_sync()
>> but as the counter is already 0 will cause an underflow.
>>
>> This behavior was introduced in commit 967577b062417 ("PCI/PM: Keep runtime
>> PM enabled for unbound PCI devices") to prevent asymmetrical get/put from
>> probe/remove, but this misses out on the point that when releasing a driver
>> the usage count is decremented from the device core.
>>
>> Drop the extra call from pci_device_remove().
>>
>> Fixes: 967577b062417 ("PCI/PM: Keep runtime PM enabled for unbound PCI devices")
> 
> This doesn't look right.  The refcount underflow issue seems new,
> we surely haven't been doing the wrong thing since 2012.
> 
> 
>> --- a/drivers/pci/pci-driver.c
>> +++ b/drivers/pci/pci-driver.c
>> @@ -478,9 +478,6 @@ static void pci_device_remove(struct device *dev)
>>   	pci_dev->driver = NULL;
>>   	pci_iov_remove(pci_dev);
>>   
>> -	/* Undo the runtime PM settings in local_pci_probe() */
>> -	pm_runtime_put_sync(dev);
>> -
> 
> local_pci_probe() increases the refcount to keep the device in D0.
> If the driver wants to use runtime suspend, it needs to decrement
> the refcount on ->probe() and re-increment on ->remove().
> 
> In the dmesg output attached to...
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=220216
> 
> ... the device exhibiting the refcount underflow is a PCIe port.
> Are you also seeing this on a PCIe port or is it a different device?

The device with the underflow is the disconnected PCIe bridge.

In my case it was this bridge that was downstream.

pci 0000:02:04.0: [8086:15ef] type 01 class 0x060400 PCIe Switch 
Downstream Port
pci 0000:02:04.0: PCI bridge to [bus 04]
pci 0000:02:04.0: enabling Extended Tags
pci 0000:02:04.0: supports D1 D2
pci 0000:02:04.0: PME# supported from D0 D1 D2 D3hot D3cold

> 
> So the refcount decrement happens in pcie_portdrv_probe() and
> the refcount increment happens in pcie_portdrv_remove().
> Both times it's conditional on pci_bridge_d3_possible().
> Does that return a different value on probe versus remove?
> 
> Does any of the port service drivers decrement the refcount
> once too often?  I've just looked through pciehp but cannot
> find anything out of the ordinary.
> 
> Looking through recent changes, 002bf2fbc00e and bca84a7b93fd
> look like potential candidates causing a regression, but the
> former is for AER (which isn't used in the dmesg attached to
> the bugzilla) and the latter touches suspend on system sleep,
> not runtime suspend.
> 
> Can you maybe instrument the pm_runtime_{get,put}*() functions
> with a printk() and/or dump_stack() to see where a gratuitous
> refcount decrement occurs?
> 
That's exactly what I did to conclude this call was an extra one.


Here's the drop to 0:

pm_runtime: 0000:02:04.0 usage count is now 0 from 
__pm_runtime_idle+0x6f/0xd0
CPU: 7 UID: 0 PID: 196 Comm: irq/36-pciehp Not tainted 
6.16.0-rc2-00086-g4156cebf8a54 #281 PREEMPT(full) 
48d9dd361274f6fbfa98cd17f346d017a60ec738
Hardware name: Framework Laptop 13 (AMD Ryzen AI 300 Series)/FRANMGCP09, 
BIOS 03.03 03/10/2025
Call Trace:
  <TASK>
  dump_stack_lvl+0x53/0x70
  rpm_drop_usage_count+0x50/0x90
  __pm_runtime_idle+0x6f/0xd0
  device_release_driver_internal+0x197/0x200
  pci_stop_bus_device+0x6d/0x90
  pci_stop_bus_device+0x2c/0x90
  pci_stop_and_remove_bus_device+0x12/0x20
  pciehp_unconfigure_device+0x97/0x160
  pciehp_disable_slot+0x66/0x140
  pciehp_handle_presence_or_link_change+0x86/0x4b0
  pciehp_ist+0x196/0x280
  irq_thread_fn+0x20/0x60
  irq_thread+0x1ae/0x290
  ? __pfx_irq_thread_fn+0x10/0x10
  ? __pfx_irq_thread_dtor+0x10/0x10
  ? __pfx_irq_thread+0x10/0x10
  kthread+0xfb/0x260
  ? __pfx_kthread+0x10/0x10
  ret_from_fork+0x14a/0x180
  ? __pfx_kthread+0x10/0x10
  ret_from_fork_asm+0x1a/0x30
  </TASK>

And then here is a dev_WARN at the underflow case.

------------[ cut here ]------------
pcieport 0000:02:04.0: Runtime PM usage count underflow!
WARNING: CPU: 7 PID: 196 at drivers/base/power/runtime.c:1084 
rpm_drop_usage_count+0x82/0x90
Modules linked in: vivaldi_fmap aesni_intel thunderbolt(+) ccp nvme_core 
i8042 tpm_tis i2c_hid_acpi serio tpm_tis_core i2c_hid tpm libaescfb 
ecdh_generic
CPU: 7 UID: 0 PID: 196 Comm: irq/36-pciehp Not tainted 
6.16.0-rc2-00086-g4156cebf8a54 #281 PREEMPT(full) 
48d9dd361274f6fbfa98cd17f346d017a60ec738
Hardware name: Framework Laptop 13 (AMD Ryzen AI 300 Series)/FRANMGCP09, 
BIOS 03.03 03/10/2025
RIP: 0010:rpm_drop_usage_count+0x82/0x90
Code: f0 ff 87 b0 01 00 00 48 8b 5f 50 48 85 db 75 03 48 8b 1f e8 20 44 
fe ff 48 89 da 48 c7 c7 80 52 c8 a0 48 89 c6 e8 8e 3f 6e ff <0f> 0b bb 
ea ff ff ff eb 9b>
RSP: 0018:ffffd240c09e7c28 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff8997c213f430 RCX: 0000000000000027
RDX: ffff899f1dbdc288 RSI: 0000000000000001 RDI: ffff899f1dbdc280
RBP: ffff8997c29150c8 R08: 0000000000000000 R09: 0000000000000003
R10: ffffd240c09e7ab0 R11: ffff899f1e129368 R12: ffffffffa1161ca0
R13: ffff8997c2915148 R14: 0000000000000080 R15: ffff8997c1613914
FS:  0000000000000000(0000) GS:ffff899f7c175000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fbbc1357750 CR3: 0000000111245000 CR4: 0000000000b50ef0
Call Trace:
  <TASK>
  __pm_runtime_idle+0x6f/0xd0
  pci_device_remove+0x7e/0xb0
  device_release_driver_internal+0x19f/0x200
  pci_stop_bus_device+0x6d/0x90
  pci_stop_bus_device+0x2c/0x90
  pci_stop_and_remove_bus_device+0x12/0x20
  pciehp_unconfigure_device+0x97/0x160
  pciehp_disable_slot+0x66/0x140
  pciehp_handle_presence_or_link_change+0x86/0x4b0
  pciehp_ist+0x196/0x280
  irq_thread_fn+0x20/0x60
  irq_thread+0x1ae/0x290
  ? __pfx_irq_thread_fn+0x10/0x10
  ? __pfx_irq_thread_dtor+0x10/0x10
  ? __pfx_irq_thread+0x10/0x10
  kthread+0xfb/0x260
  ? __pfx_kthread+0x10/0x10
  ret_from_fork+0x14a/0x180
  ? __pfx_kthread+0x10/0x10
  ret_from_fork_asm+0x1a/0x30
  </TASK>
---[ end trace 0000000000000000 ]---

