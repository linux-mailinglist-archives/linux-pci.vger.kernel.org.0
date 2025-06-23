Return-Path: <linux-pci+bounces-30333-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B07AE3367
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 03:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A2B916EA70
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 01:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CD84AEE0;
	Mon, 23 Jun 2025 01:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ovBpB65l"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75AD249EB;
	Mon, 23 Jun 2025 01:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750643225; cv=none; b=SzZTNEO6/DTuI+tHS09haUKpFXFMLxTQlNfNyu16++ntZ9E277KUrBS+iHBM14DoNSN0nJrqDXlCNQODvcMri+qng5Y1UrheUXrwUb6M/mgJsBofbKW6n4/ZThKYtZXL/L1bO4keOHmpRhJA6RL2rLUwLUG8APBVe09Rdg3KUyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750643225; c=relaxed/simple;
	bh=9K/JNnFHU/bRcV1bPmo9xcwEo+QxFRz0+qWwMxVyvcU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=pIZKLxC3LqeIT0xhdK1BPMVsURnoIXq/ZsVHlQNPhtvfbXb7KV+Iux+ONDbFEPu0ZhAN1OSXbyZ8mL1H+vjnhhyKmQA+x1EoSY7Z8x0Fi0EjePst7DxE5kSA/XJiIDUpd7fbUhf19K754sp6/cfIhRSyQpG5+sMS10Jq3mgBi98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ovBpB65l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91A58C4CEE3;
	Mon, 23 Jun 2025 01:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750643225;
	bh=9K/JNnFHU/bRcV1bPmo9xcwEo+QxFRz0+qWwMxVyvcU=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=ovBpB65lGd6q18BTSYHYs0FfMkaowoGWczDuAuAxGgXglrSWf2dz9sdcNWj838Zk1
	 qaKfRARrFZghBxYGqQplUBndapEGkjfcgIC6NG/IBl7QZ5ZNS0Px3cEnJguyyTmPov
	 cImR4g/ucjhSBeWeVlcjvh2XspwGfpTgMXifbMtk3gltSvwRGXG1sNbjg3eQBe1zQg
	 2KE+Chw3Xhx4UudmZs9+FO303fh6hi6SzbZkropsuqShZrEQOBonhtk+r9g+emD7ad
	 dS9A3HVJs8Jaxo/qd6nGxVYKAMGT8oMnUR62BkxitkP6he9sYM05re8ivNJ5hzZHJU
	 l+FU7hbDsUepw==
Message-ID: <c5950427-8a65-4659-96d1-5bb013955090@kernel.org>
Date: Sun, 22 Jun 2025 20:47:03 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] PCI: Fix runtime PM usage count underflow on
 device unplug
From: Mario Limonciello <superm1@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
 linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20250620025535.3425049-1-superm1@kernel.org>
 <20250620025535.3425049-3-superm1@kernel.org> <aFcCaw_IZr-JuUYY@wunner.de>
 <8d4d98b6-fec5-466f-bd2c-059d702c7860@kernel.org>
 <aFeJ83O9PRUrM2Ir@wunner.de>
 <295bf182-7fed-4ffd-93a4-fb5ddf5f1bb4@kernel.org>
Content-Language: en-US
In-Reply-To: <295bf182-7fed-4ffd-93a4-fb5ddf5f1bb4@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 6/22/25 1:39 PM, Mario Limonciello wrote:
> On 6/21/2025 11:43 PM, Lukas Wunner wrote:
>> On Sat, Jun 21, 2025 at 02:56:08PM -0500, Mario Limonciello wrote:
>>> On 6/21/25 2:05 PM, Lukas Wunner wrote:
>>>> In the dmesg output attached to...
>>>>
>>>> https://bugzilla.kernel.org/show_bug.cgi?id=220216
>>>>
>>>> ... the device exhibiting the refcount underflow is a PCIe port.
>>>> Are you also seeing this on a PCIe port or is it a different device?
>>>
>>> The device with the underflow is the disconnected PCIe bridge.
>>>
>>> In my case it was this bridge that was downstream.
>>
>> Okay, in both cases the refcount underflow occurs on a PCIe port.
>> So it seems likely the gratuitous refcount decrement is in portdrv.c
>> or one of the port services drivers.
>>
>> Your patch changes the code path for *all* PCI devices.
>> Not just PCIe ports.  Hence it's likely not the right fix.
>>
>> It may fix the issue on this particular PCIe port but
>> I strongly suspect it'll leak a runtime PM ref on all other devices.
>>
> 
> Thanks, I see your point.
> 
>>
>>>> So the refcount decrement happens in pcie_portdrv_probe() and
>>>> the refcount increment happens in pcie_portdrv_remove().
>>>> Both times it's conditional on pci_bridge_d3_possible().
>>>> Does that return a different value on probe versus remove?
>>
>> Could you please answer this?
> 
> I did this check and yes specifically on this PCIe port with the 
> underflow the d3 possible lookup returns false during 
> pcie_portdrv_remove().  It returns true during pcie_portdrv_probe().
> 
>>
>>
>>>> Does any of the port service drivers decrement the refcount
>>>> once too often?  I've just looked through pciehp but cannot
>>>> find anything out of the ordinary.
>>>>
>>>> Looking through recent changes, 002bf2fbc00e and bca84a7b93fd
>>>> look like potential candidates causing a regression, but the
>>>> former is for AER (which isn't used in the dmesg attached to
>>>> the bugzilla) and the latter touches suspend on system sleep,
>>>> not runtime suspend.
>>>>
>>>> Can you maybe instrument the pm_runtime_{get,put}*() functions
>>>> with a printk() and/or dump_stack() to see where a gratuitous
>>>> refcount decrement occurs?
>>>
>>> That's exactly what I did to conclude this call was an extra one.
>>>
>>> Here's the drop to 0:
>>
>> The drop to 0 is uninteresting.  You need to record *all*
>> refcount increments/decrements so that we can see where the
>> gratuitous one occurs.  It happens earlier than the drop to 0.
>>
>> However, please first check whether the pci_bridge_d3_possible()
>> return value changes on probe versus remove of the PCIe port
>> in question.  If it does, then that's the root cause and there's
>> no need to look any further.
>>
> 
> That was a great hypothesis that's spot on.
> 
> Just for posterity this was all the increment/decrement calls that I saw 
> happen.
> 
> pci 0000:02:04.0: inc usage cnt from 0, caller: pci_pm_init+0x84/0x2d0
> pci 0000:02:04.0: inc usage cnt from 1, caller: 
> pci_scan_bridge_extend+0x6d/0x710
> pci 0000:02:04.0: dec usage cnt from 2, caller: 
> pci_scan_bridge_extend+0x19e/0x710
> pci 0000:02:04.0: inc usage cnt from 1, caller: 
> pci_scan_bridge_extend+0x6d/0x710
> pci 0000:02:04.0: dec usage cnt from 2, caller: 
> pci_scan_bridge_extend+0x19e/0x710
> pcieport 0000:02:04.0: inc usage cnt from 1, caller: 
> local_pci_probe+0x2d/0xa0
> pcieport 0000:02:04.0: inc usage cnt from 2, caller: 
> __device_attach+0x9c/0x1b0
> pcieport 0000:02:04.0: inc usage cnt from 3, caller: 
> __driver_probe_device+0x5c/0x150
> pcieport 0000:02:04.0: dec usage cnt from 4, caller: 
> __driver_probe_device+0x9a/0x150
> pcieport 0000:02:04.0: dec usage cnt from 3, caller: 
> __device_attach+0x145/0x1b0
> pcieport 0000:02:04.0: dec usage cnt from 2, caller: 
> pcie_portdrv_probe+0x19d/0x6d0
> pcieport 0000:02:04.0: dec usage cnt from 1, caller: 
> pcie_portdrv_probe+0x1a5/0x6d0
> pcieport 0000:02:04.0: inc usage cnt from 0, caller: 
> device_release_driver_internal+0xac/0x200
> pcieport 0000:02:04.0: dec usage cnt from 1, caller: 
> device_release_driver_internal+0x197/0x200
> pcieport 0000:02:04.0: inc usage cnt from 0, caller: 
> pci_device_remove+0x2d/0xb0
> pcieport 0000:02:04.0: dec usage cnt from 0, caller: 
> pci_device_remove+0x7e/0xb0
> pcieport 0000:02:04.0: Runtime PM usage cnt underflow!
> 
> What's your suggestion on what to actually do here then?
> 
> 

Actually I came up with the idea to forbid runtime PM on the service 
when it doesn't allow d3 at probe which I believe means no need to check 
again on remove.

This works cleanly for me.  LMK what you think of this.

diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index e8318fd5f6ed5..a85cd7412cf4d 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -717,6 +717,8 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
                 pm_runtime_mark_last_busy(&dev->dev);
                 pm_runtime_put_autosuspend(&dev->dev);
                 pm_runtime_allow(&dev->dev);
+       } else {
+               pm_runtime_forbid(&dev->dev);
         }

         return 0;
@@ -724,11 +726,9 @@ static int pcie_portdrv_probe(struct pci_dev *dev,

  static void pcie_portdrv_remove(struct pci_dev *dev)
  {
-       if (pci_bridge_d3_possible(dev)) {
-               pm_runtime_forbid(&dev->dev);
-               pm_runtime_get_noresume(&dev->dev);
-               pm_runtime_dont_use_autosuspend(&dev->dev);
-       }
+       pm_runtime_forbid(&dev->dev);
+       pm_runtime_get_noresume(&dev->dev);
+       pm_runtime_dont_use_autosuspend(&dev->dev);

         pcie_port_device_remove(dev);

@@ -737,11 +737,9 @@ static void pcie_portdrv_remove(struct pci_dev *dev)

  static void pcie_portdrv_shutdown(struct pci_dev *dev)
  {
-       if (pci_bridge_d3_possible(dev)) {
-               pm_runtime_forbid(&dev->dev);
-               pm_runtime_get_noresume(&dev->dev);
-               pm_runtime_dont_use_autosuspend(&dev->dev);
-       }
+       pm_runtime_forbid(&dev->dev);
+       pm_runtime_get_noresume(&dev->dev);
+       pm_runtime_dont_use_autosuspend(&dev->dev);

         pcie_port_device_remove(dev);
  }

