Return-Path: <linux-pci+bounces-28136-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC33AABE33F
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 20:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4BC81BA3840
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 18:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285E926C390;
	Tue, 20 May 2025 18:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="toSS6erc"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0877485;
	Tue, 20 May 2025 18:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747767391; cv=none; b=Spm1PIl9d7btwEZUSDMP0VlHoBtZ79EB6KlbfMhyAQWXHA4E7Lw10wemgCqrjlTi9lx0UD9lOAPO6d/PeWbLiQJNK11U1ehix8vMKOTvGNQlb1Cfi39PLxc0XXckrgSKRWKjs+x/z1iVqnaTknnm1xgtafV/suZgqp0WcxBUuto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747767391; c=relaxed/simple;
	bh=OENKUQyaM4BuN8bH8ns8/4Vc0ap1To6lcfFetFEiQpE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lW5ywajwG5jXlDtn8WZryPOaeS3S+OcegHVS/mX9vy65eSvogt294XTrJfWouvfFo3xmTjRqBmDsbVNFd7/rfzRjxQgwbhN/iVCanl68sm+5Q4kF98oxEr8usgwBWc9b5qlm719RZ/hQWhahHANS79IRj7p5BXEJYt/aZDRCUGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=toSS6erc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72E60C4CEE9;
	Tue, 20 May 2025 18:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747767390;
	bh=OENKUQyaM4BuN8bH8ns8/4Vc0ap1To6lcfFetFEiQpE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=toSS6ercj5WRjD98Zc7wTxVi5L6qtlGRqxjfkXLBenxUqpBwAkyEIv2xSKOghXPDW
	 TiET+7Z+UnzkKDgC1+zd1/Ue+33pUekIqSbU3giAuU9cQpJICElyixiq21zNM3I8+F
	 QolHaPiu/Ma1e6nPeSIr0REJdZW3kaqWVarAmEw+bV2vZ1QMmNi45UbDva89JwX+a+
	 BneDwdClHjLrw6paEzdqmL7yJkGZ8tZDbmzgGp4ItUDK4IGPPeGgjigr+t61ncyYP7
	 zptDG+/Iiw08i+jPeme52P8IjMux+ThIanPnnH7YYdqtiSpLZpe2D7oTDlIxzOTpxH
	 A5kIAle9kuurw==
Message-ID: <fea86161-2c47-4b0f-ac07-b3f9b0f10a03@kernel.org>
Date: Tue, 20 May 2025 13:56:28 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] PCI: Prevent power state transition of erroneous
 device
To: Raag Jadav <raag.jadav@intel.com>
Cc: Denis Benato <benato.denis96@gmail.com>, rafael@kernel.org,
 mahesh@linux.ibm.com, oohall@gmail.com, bhelgaas@google.com,
 linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
 lukas@wunner.de, aravind.iddamsetty@linux.intel.com,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20250519102808.4130271-1-raag.jadav@intel.com>
 <aCsK743YSuahPtnH@black.fi.intel.com>
 <85ed0b91-c84f-4d24-8e19-a8cb3ba02b14@gmail.com>
 <aCxP6vQ8Ep9LftPv@black.fi.intel.com>
 <a8c83435-4c91-495c-950c-4d12b955c54c@kernel.org>
 <aCyj9nbnIRet93O-@black.fi.intel.com>
 <552d75b2-2736-419f-887e-ce2692616578@kernel.org>
 <ee1117cf-6367-4e9a-aa85-ccfc6c63125d@gmail.com>
 <6f23d82c-10cc-4d70-9dce-41978b05ec9a@kernel.org>
 <aCzNL9uXGbBSdF2S@black.fi.intel.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <aCzNL9uXGbBSdF2S@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/20/2025 1:42 PM, Raag Jadav wrote:
> On Tue, May 20, 2025 at 12:39:12PM -0500, Mario Limonciello wrote:
>> On 5/20/2025 12:22 PM, Denis Benato wrote:
>>> On 5/20/25 17:49, Mario Limonciello wrote:
>>>> On 5/20/2025 10:47 AM, Raag Jadav wrote:
>>>>> On Tue, May 20, 2025 at 10:23:57AM -0500, Mario Limonciello wrote:
>>>>>> On 5/20/2025 4:48 AM, Raag Jadav wrote:
>>>>>>> On Mon, May 19, 2025 at 11:42:31PM +0200, Denis Benato wrote:
>>>>>>>> On 5/19/25 12:41, Raag Jadav wrote:
>>>>>>>>> On Mon, May 19, 2025 at 03:58:08PM +0530, Raag Jadav wrote:
>>>>>>>>>> If error status is set on an AER capable device, most likely either the
>>>>>>>>>> device recovery is in progress or has already failed. Neither of the
>>>>>>>>>> cases are well suited for power state transition of the device, since
>>>>>>>>>> this can lead to unpredictable consequences like resume failure, or in
>>>>>>>>>> worst case the device is lost because of it. Leave the device in its
>>>>>>>>>> existing power state to avoid such issues.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Raag Jadav <raag.jadav@intel.com>
>>>>>>>>>> ---
>>>>>>>>>>
>>>>>>>>>> v2: Synchronize AER handling with PCI PM (Rafael)
>>>>>>>>>> v3: Move pci_aer_in_progress() to pci_set_low_power_state() (Rafael)
>>>>>>>>>>         Elaborate "why" (Bjorn)
>>>>>>>>>> v4: Rely on error status instead of device status
>>>>>>>>>>         Condense comment (Lukas)
>>>>>>>>> Since pci_aer_in_progress() is changed I've not included Rafael's tag with
>>>>>>>>> my understanding of this needing a revisit. If this was a mistake, please
>>>>>>>>> let me know.
>>>>>>>>>
>>>>>>>>> Denis, Mario, does this fix your issue?
>>>>>>>>>
>>>>>>>> Hello,
>>>>>>>>
>>>>>>>> Unfortunately no, I have prepared a dmesg but had to remove the bootup process because it was too long of a few kb: https://pastebin.com/1uBEA1FL
>>>>>>>
>>>>>>> Thanks for the test. It seems there's no hotplug event this time around
>>>>>>> and endpoint device is still intact without any PCI related failure.
>>>>>>>
>>>>>>> Also,
>>>>>>>
>>>>>>> amdgpu 0000:09:00.0: PCI PM: Suspend power state: D3hot
>>>>>>>
>>>>>>> Which means whatever you're facing is either not related to this patch,
>>>>>>> or at best exposed some nasty side-effect that's not handled correctly
>>>>>>> by the driver.
>>>>>>>
>>>>>>> I'd say amdgpu folks would be of better help for your case.
>>>>>>>
>>>>>>> Raag
>>>>>>
>>>>>> So according to the logs Denis shared with v4
>>>>>> (https://pastebin.com/1uBEA1FL) the GPU should have been going to BOCO. This
>>>>>> stands for "Bus off Chip Off"
>>>>>>
>>>>>> amdgpu 0000:09:00.0: amdgpu: Using BOCO for runtime pm
>>>>>>
>>>>>> If it's going to D3hot - that's not going to be BOCO, it should be going to
>>>>>> D3cold.
>>>>>
>>>>> Yes, because upstream port is in D0 for some reason (might be this patch
>>>>> but not sure) and so will be the root port.
>>>>>
>>>>> pcieport 0000:07:00.0: PCI PM: Suspend power state: D0
>>>>> pcieport 0000:07:00.0: PCI PM: Skipped
>>>>>
>>>>> and my best guess is the driver is not able to cope with the lack of D3cold.
>>>>
>>>> Yes; if the driver is configured to expect BOCO (D3cold) if it doesn't get it, chaos ensues.
>>>>
>>>> I guess let's double check the behavior with CONFIG_PCI_DEBUG to verify this patch is what is changing that upstream port behavior.
>>>
>>>
>>> This is the very same exact kernel, minus the patch in question:  https://pastebin.com/rwMYgG7C
>>>
>>>
>>> Both previous kernel and this one have CONFIG_PCI_DEBUG=y.
>>>
>>> Removed the initial bootup sequence to be able to use pastebin.
>>
>> Thanks - this confirms that the problem is the root port not going to D3.
>> This new log shows:
>>
>> pcieport 0000:07:00.0: PCI PM: Suspend power state: D3hot
>>
>> So I feel we should fixate on solving that.
> 
> Which means what you're looking for is error flag being set somewhere in
> the hierarchy that is preventing suspend.

Is the issue perhaps that this is now gated on both correctable and 
uncorrectable errors?

Perhaps should *correctable errors* be emitted with a warning and the 
*uncorrectable errors* be fatal?

> 
> But regardless of it, my understanding is that root port suspend depends
> on a lot of factors (now errors flags being one of them with this patch)
> and endpoint driver can't possibly enforce or guarantee it - the best it
> can do is try.
> 
> What's probably needed is D3cold failure handling on driver side, but I'm
> no PCI PM expert and perhaps Rafael can comment on it.
> 
> Raag

 From the driver perspective it does have expectations that the parts 
outside the driver did the right thing.  If the driver was expecting the 
root port to be powered down at suspend and it wasn't there are hardware 
components that didn't power cycle and that's what we're seeing here.



