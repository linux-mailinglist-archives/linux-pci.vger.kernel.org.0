Return-Path: <linux-pci+bounces-30320-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 970E1AE3164
	for <lists+linux-pci@lfdr.de>; Sun, 22 Jun 2025 20:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30A97169F11
	for <lists+linux-pci@lfdr.de>; Sun, 22 Jun 2025 18:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9CA14B06C;
	Sun, 22 Jun 2025 18:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uUG/9P0i"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D1A2260C;
	Sun, 22 Jun 2025 18:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750617569; cv=none; b=sBI8u/D0o0BCvNQP4atVaAmtdpIcZOtfjohxL5/EQMI3GoUqz2ZQLMe6NBdH6Mwi21GXmyhMo5WLhb3xABIKPythRLIFliCFSsuEl2kxCpr/cghSytQW6zaSwtrgiu3xmjEL44SP0A+q86xLagI8uCIbcKGp1xjVDUW+jvnsFKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750617569; c=relaxed/simple;
	bh=5YmXLBHzOpQHj5ZBeGlUvT8XRRK5g8s3885IctS609c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JJTPAikKKxhoPo3S5eAYrdGsMlzWNDVZ5JWp7mERgYDyGPMrts1sCR6GN+nLRZ0k/r5/7NMPCrtJ4VbVrPW0+MeoRgfs4av5tAjanLjKQ0tQzcRcIleBpSKbn57oVKcyIrh1efmpgR6FttfWQlCi4XPUwzm0EWSwZSGXb+2jWU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uUG/9P0i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14F20C4CEE3;
	Sun, 22 Jun 2025 18:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750617568;
	bh=5YmXLBHzOpQHj5ZBeGlUvT8XRRK5g8s3885IctS609c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uUG/9P0iZWnmI6zz/tbR1vOyT1r8+ARcRgcsCC6QILw4cJa9Ty+ISxzVVtkDvOohW
	 +FpWXFO6vmcspSSj9uag7Fhdx4/GlFOFrtnGjqjusAFNrTAxhPEBKPtaiScUS/Bl3B
	 xrIY81ozwwvYrVMew4GJ4GjhHvKOSlOhcH+9i067p7+VE2LGfCyGDFx+E5DRQasByn
	 n0Nnm/iWNrsctlTNITXMPZk2hlfTfARftRmc+EE7kQIO5SuRm/vDijSnsaxkyoPkaQ
	 YZaC1oACsz6MOuRNeGiztxurWgncQp+FVzno+cpNqwkz42K931mWHxFi2aioP684qE
	 wCe2U8A0bNU9g==
Message-ID: <295bf182-7fed-4ffd-93a4-fb5ddf5f1bb4@kernel.org>
Date: Sun, 22 Jun 2025 13:39:26 -0500
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
 <8d4d98b6-fec5-466f-bd2c-059d702c7860@kernel.org>
 <aFeJ83O9PRUrM2Ir@wunner.de>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <aFeJ83O9PRUrM2Ir@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/21/2025 11:43 PM, Lukas Wunner wrote:
> On Sat, Jun 21, 2025 at 02:56:08PM -0500, Mario Limonciello wrote:
>> On 6/21/25 2:05 PM, Lukas Wunner wrote:
>>> In the dmesg output attached to...
>>>
>>> https://bugzilla.kernel.org/show_bug.cgi?id=220216
>>>
>>> ... the device exhibiting the refcount underflow is a PCIe port.
>>> Are you also seeing this on a PCIe port or is it a different device?
>>
>> The device with the underflow is the disconnected PCIe bridge.
>>
>> In my case it was this bridge that was downstream.
> 
> Okay, in both cases the refcount underflow occurs on a PCIe port.
> So it seems likely the gratuitous refcount decrement is in portdrv.c
> or one of the port services drivers.
> 
> Your patch changes the code path for *all* PCI devices.
> Not just PCIe ports.  Hence it's likely not the right fix.
> 
> It may fix the issue on this particular PCIe port but
> I strongly suspect it'll leak a runtime PM ref on all other devices.
> 

Thanks, I see your point.

> 
>>> So the refcount decrement happens in pcie_portdrv_probe() and
>>> the refcount increment happens in pcie_portdrv_remove().
>>> Both times it's conditional on pci_bridge_d3_possible().
>>> Does that return a different value on probe versus remove?
> 
> Could you please answer this?

I did this check and yes specifically on this PCIe port with the 
underflow the d3 possible lookup returns false during 
pcie_portdrv_remove().  It returns true during pcie_portdrv_probe().

> 
> 
>>> Does any of the port service drivers decrement the refcount
>>> once too often?  I've just looked through pciehp but cannot
>>> find anything out of the ordinary.
>>>
>>> Looking through recent changes, 002bf2fbc00e and bca84a7b93fd
>>> look like potential candidates causing a regression, but the
>>> former is for AER (which isn't used in the dmesg attached to
>>> the bugzilla) and the latter touches suspend on system sleep,
>>> not runtime suspend.
>>>
>>> Can you maybe instrument the pm_runtime_{get,put}*() functions
>>> with a printk() and/or dump_stack() to see where a gratuitous
>>> refcount decrement occurs?
>>
>> That's exactly what I did to conclude this call was an extra one.
>>
>> Here's the drop to 0:
> 
> The drop to 0 is uninteresting.  You need to record *all*
> refcount increments/decrements so that we can see where the
> gratuitous one occurs.  It happens earlier than the drop to 0.
> 
> However, please first check whether the pci_bridge_d3_possible()
> return value changes on probe versus remove of the PCIe port
> in question.  If it does, then that's the root cause and there's
> no need to look any further.
> 

That was a great hypothesis that's spot on.

Just for posterity this was all the increment/decrement calls that I saw 
happen.

pci 0000:02:04.0: inc usage cnt from 0, caller: pci_pm_init+0x84/0x2d0
pci 0000:02:04.0: inc usage cnt from 1, caller: 
pci_scan_bridge_extend+0x6d/0x710
pci 0000:02:04.0: dec usage cnt from 2, caller: 
pci_scan_bridge_extend+0x19e/0x710
pci 0000:02:04.0: inc usage cnt from 1, caller: 
pci_scan_bridge_extend+0x6d/0x710
pci 0000:02:04.0: dec usage cnt from 2, caller: 
pci_scan_bridge_extend+0x19e/0x710
pcieport 0000:02:04.0: inc usage cnt from 1, caller: 
local_pci_probe+0x2d/0xa0
pcieport 0000:02:04.0: inc usage cnt from 2, caller: 
__device_attach+0x9c/0x1b0
pcieport 0000:02:04.0: inc usage cnt from 3, caller: 
__driver_probe_device+0x5c/0x150
pcieport 0000:02:04.0: dec usage cnt from 4, caller: 
__driver_probe_device+0x9a/0x150
pcieport 0000:02:04.0: dec usage cnt from 3, caller: 
__device_attach+0x145/0x1b0
pcieport 0000:02:04.0: dec usage cnt from 2, caller: 
pcie_portdrv_probe+0x19d/0x6d0
pcieport 0000:02:04.0: dec usage cnt from 1, caller: 
pcie_portdrv_probe+0x1a5/0x6d0
pcieport 0000:02:04.0: inc usage cnt from 0, caller: 
device_release_driver_internal+0xac/0x200
pcieport 0000:02:04.0: dec usage cnt from 1, caller: 
device_release_driver_internal+0x197/0x200
pcieport 0000:02:04.0: inc usage cnt from 0, caller: 
pci_device_remove+0x2d/0xb0
pcieport 0000:02:04.0: dec usage cnt from 0, caller: 
pci_device_remove+0x7e/0xb0
pcieport 0000:02:04.0: Runtime PM usage cnt underflow!

What's your suggestion on what to actually do here then?


