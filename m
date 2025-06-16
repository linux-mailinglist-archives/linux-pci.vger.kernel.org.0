Return-Path: <linux-pci+bounces-29856-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7BDDADAF30
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 13:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 900E13B554D
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 11:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6175B2E6D2F;
	Mon, 16 Jun 2025 11:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="EpaTJ6q9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D03A2E92B9
	for <linux-pci@vger.kernel.org>; Mon, 16 Jun 2025 11:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750074915; cv=none; b=IQIjT/9mpr92b9YvGt2OrDCT96+QioiZVS14ACS6UmfbTS0TPZNiUC9iM0JFGeYnjTBK0UI7sg3JF16Okaow91yZUwE11rgUel5+7jP18vIh5en6hmiBCz502JL3DTQMSrAJGd/8FgmkgzbXw0D1ee5ZXRE7sbWLFgah4+oFHJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750074915; c=relaxed/simple;
	bh=WgKeawMisw/Efv2J/i8lFJ6lgOODC7vIgf6RMqudR50=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jFXTz0+2sfpnhZG8IK0/6/k1eEq5WyUYAyz+asWtLOv53QIuRgkxR/y6o+jo8E6fo/wNRpT2E+arZJkLKZbElgIsCleZ37wiFzkYAHjMLZ0sijp0Y/eWd3XxQALt3dddrtkJnBMseF7OfIilMYDNnF8Sqs93kxOwNItQFo3oDM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=EpaTJ6q9; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from [192.168.0.104] (unknown [123.112.65.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id C73223F92A;
	Mon, 16 Jun 2025 11:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1750074910;
	bh=iVIabaIh+bJ7uD3ySb/2UkU+jGQ0Mj04F/VKfC2DVOc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=EpaTJ6q9sLjD53HYKK0DDiKWUn6B4GNvALChImF3opN3fZcji7SYJiVNXXyH/wzru
	 BHZk6QWc3ht0cgYW66Y9TI7Zip4fRL857D9YioF5QN/ZgPaI0sIq6FVqNxDiVdspbd
	 +dwSC4huHgcgVB5SaZSrvRaVQzUuuh2BHhU8P/JneapISRV/FakK+a1J8GKGaQoRUa
	 xHEcma/s3xrOxytC44dIU2xVn9K7stV7F3kv22dkw90tVNNMWygZ+ksCf3ySoFRdzP
	 Q4MiY48/0r+Qq8yjN48vvoFegr91fSR5A3dj3khD7bdC/tM15ROwftbFsFZD3Pbu4Y
	 spzhzFMt6MgxA==
Message-ID: <371da708-3520-41af-8c1f-c8c3d53710ee@canonical.com>
Date: Mon, 16 Jun 2025 19:55:03 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: Disable RRS polling for Intel SSDPE2KX020T8 nvme
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
 raphael.norwitz@nutanix.com, alay.shah@nutanix.com,
 suresh.gumpula@nutanix.com, ilpo.jarvinen@linux.intel.com,
 Nirmal Patel <nirmal.patel@linux.intel.com>,
 Jonathan Derrick <jonathan.derrick@linux.dev>
References: <20250612164821.GA870964@bhelgaas>
Content-Language: en-US
From: Hui Wang <hui.wang@canonical.com>
In-Reply-To: <20250612164821.GA870964@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 6/13/25 00:48, Bjorn Helgaas wrote:
> [+cc VMD folks]
>
> On Wed, Jun 11, 2025 at 06:14:42PM +0800, Hui Wang wrote:
>> Prior to commit d591f6804e7e ("PCI: Wait for device readiness with
>> Configuration RRS"), this Intel nvme [8086:0a54] works well. Since
>> that patch is merged to the kernel, this nvme stops working.
>>
>> Through debugging, we found that commit introduces the RRS polling in
>> the pci_dev_wait(), for this nvme, when polling the PCI_VENDOR_ID, it
>> will return ~0 if the config access is not ready yet, but the polling
>> expects a return value of 0x0001 or a valid vendor_id, so the RRS
>> polling doesn't work for this nvme.
> Sorry for breaking this, and thanks for all your work in debugging
> this!  Issues like this are really hard to track down.
>
> I would think we would have heard about this earlier if the NVMe
> device were broken on all systems.  Maybe there's some connection with
> VMD?  From the non-working dmesg log in your bug report
> (https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2111521/+attachment/5879970/+files/dmesg-60.txt):
>
>    DMI: ASUSTeK COMPUTER INC. ESC8000 G4/Z11PG-D24 Series, BIOS 5501 04/17/2019
>    vmd 0000:d7:05.5: PCI host bridge to bus 10000:00
>    pci 10000:00:02.0: [8086:2032] type 01 class 0x060400 PCIe Root Port
>    pci 10000:00:02.0: PCI bridge to [bus 01]
>    pci 10000:00:02.0: bridge window [mem 0xf8000000-0xf81fffff]: assigned
>    pci 10000:01:00.0: [8086:0a54] type 00 class 0x010802 PCIe Endpoint
>    pci 10000:01:00.0: BAR 0 [mem 0x00000000-0x00003fff 64bit]
>
>    <I think vmd_enable_domain() calls pci_reset_bus() here>

Yes, and the pci_dev_wait() is called here. With the RRS polling, will 
get a ~0 from PCI_VENDOR_ID, then will get 0xfffffff when configuring 
the BAR0 subsequently. With the original polling method, it will get 
enough delay in the pci_dev_wait(), so nvme works normally.

The line "[   10.193589] hhhhhhhhhhhhhhhhhhhhhhhhhhhh dev->device = 0a54 
id = ffffffff" is output from pci_dev_wait(), please refer to 
https://launchpadlibrarian.net/798708446/LP2111521-dmesg-test9.txt

>
>    pci 10000:01:00.0: BAR 0 [mem 0xf8010000-0xf8013fff 64bit]: assigned
>    pci 10000:01:00.0: BAR 0: error updating (high 0x00000000 != 0xffffffff)
>    pci 10000:01:00.0: BAR 0 [mem 0xf8010000-0xf8013fff 64bit]: assigned
>    pci 10000:01:00.0: BAR 0: error updating (0xf8010004 != 0xffffffff)
>    nvme nvme0: pci function 10000:01:00.0
>    nvme 10000:01:00.0: enabling device (0000 -> 0002)
>
> Things I notice:
>
>    - The 10000:01:00.0 NVMe device is behind a VMD bridge
>
>    - We successfully read the Vendor & Device IDs (8086:0a54)
>
>    - The NVMe device is uninitialized.  We successfully sized the BAR,
>      which included successful config reads and writes.  The BAR
>      wasn't assigned by BIOS, which is normal since it's behind VMD.
>
>    - We allocated space for BAR 0 but the config writes to program the
>      BAR failed.  The read back from the BAR was 0xffffffff; probably a
>      PCIe error, e.g., the NVMe device didn't respond.
>
>    - The device *did* respond when nvme_probe() enabled it: the
>      "enabling device (0000 -> 0002)" means pci_enable_resources() read
>      PCI_COMMAND and got 0x0000.
>
>    - The dmesg from the working config doesn't include the "enabling
>      device" line, which suggests that pci_enable_resources() saw
>      PCI_COMMAND_MEMORY (0x0002) already set and didn't bother setting
>      it again.  I don't know why it would already be set.
>     
> d591f6804e7e really only changes pci_dev_wait(), which is used after
> device resets.  I think vmd_enable_domain() resets the VMD Root Ports
> after pci_scan_child_bus(), and maybe we're not waiting long enough
> afterwards.
>
> My guess is that we got the ~0 because we did a config read too soon
> after reset and the device didn't respond.  The Root Port would time
> out, log an error, and synthesize ~0 data to complete the CPU read
> (see PCIe r6.0, sec 2.3.2 implementation note).
>
> It's *possible* that we waited long enough but the NVMe device is
> broken and didn't respond when it should have, but my money is on a
> software defect.
>
> There are a few pci_dbg() calls about these delays; can you set
> CONFIG_DYNAMIC_DEBUG=y and boot with dyndbg="file drivers/pci/* +p" to
> collect that output?  Please also collect the "sudo lspci -vv" output
> from a working system.

Already passed the testing request to bug reporters, wait for their 
feedback.

https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2111521/comments/55

Thanks,

Hui.


>
> Bjorn

