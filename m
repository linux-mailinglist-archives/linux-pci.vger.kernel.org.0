Return-Path: <linux-pci+bounces-29944-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55EB7ADD559
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 18:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD63E406CE4
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 16:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5C92ED84B;
	Tue, 17 Jun 2025 16:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PjvrauMT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8629C2ED15A
	for <linux-pci@vger.kernel.org>; Tue, 17 Jun 2025 16:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750176362; cv=none; b=PahSbNRad5IrW6JDmrFpJFOZMWLBcGtbI2IeMQ0tFkLm1aJVH34CmeCaeC54iegfHvy9mBGAHvdwf+unuqVBJypcCrtEClOWNdE0OjZY9oM203x/Y/pbJNTlIkbR4u3iGxIGgSNPijyhzVRfXuGvK3dA+8InWvpP4kfdIaV9yaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750176362; c=relaxed/simple;
	bh=q8aCArGZca+RkksEi4yJnLYT0pMBdsfbYEmR7VmR+VI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MgHJCNF2nYCUf4svJNRfBBXYP2870dQUkd1k6AtgxmizZW1ysHHI7YzrGOoiNN1q0+V0wQaQA9fyzSQBfRIsINOPQwymlivosFbt9I0VA7RuZ1L5636HtX0YETE/2Wb0iubNNpZQYnUui9VJ1cHYlEKzdZY9B0/X9tdBCuoQex4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PjvrauMT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82657C4CEF4;
	Tue, 17 Jun 2025 16:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750176362;
	bh=q8aCArGZca+RkksEi4yJnLYT0pMBdsfbYEmR7VmR+VI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PjvrauMTwd82nIwAtWY0DvaUUd2V+9en3OPlQwsmbKrfuo+7aYWld9hfIP4KJn17b
	 +05lbS/8L1kKfnWtkTHsPfxJhTYxrR0pmyMEg4phoUVr0jgFNFfLgZA+I5vGNZfxKT
	 NDT+TnTiZ2ekMRsGcWOFOUK/R/DdXfN1+pIOu5rdMQWKtXI21Bvmy2l9yJSFgayrbb
	 nP1YM6QXBuFAg/J73+7qxPdj+V9/hXrsV1apTjs4rCysgLGeBKWERFFe69H4+l5/1h
	 /soJ2GF+GEsinV/mde7kKBTc6CUyY/eUN1ScInQlK8WGp2AvIjkqZl1OXD1hyjxh/s
	 9jaEth3XeA9oA==
Message-ID: <1b166e77-4151-426b-ab80-b4c34303ca8d@kernel.org>
Date: Tue, 17 Jun 2025 11:06:00 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/VGA: Look at all PCI display devices in VGA arbiter
To: Daniel Dadap <ddadap@nvidia.com>, Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
 Alex Williamson <alex.williamson@redhat.com>, mario.limonciello@amd.com,
 bhelgaas@google.com, Thomas Zimmermann <tzimmermann@suse.de>,
 linux-pci@vger.kernel.org, Hans de Goede <hansg@kernel.org>
References: <20250613203130.GA974345@bhelgaas>
 <5ae2fa88-7144-4dd3-9ac6-58f155b2bc36@kernel.org>
 <aEycaB9Hq5ZLMVaO@ddadap-lakeline.nvidia.com> <aE0fFIxCmauAHtNM@wunner.de>
 <aFAyzETfBySFRhQC@ddadap-lakeline.nvidia.com> <aFBs_PyM0XAZPb2z@wunner.de>
 <aFGPXDfOkjiy_6HH@ddadap-lakeline.nvidia.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <aFGPXDfOkjiy_6HH@ddadap-lakeline.nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/17/25 10:53 AM, Daniel Dadap wrote:
> On Mon, Jun 16, 2025 at 09:14:04PM +0200, Lukas Wunner wrote:
>> On Mon, Jun 16, 2025 at 10:05:48AM -0500, Daniel Dadap wrote:
>>> On Sat, Jun 14, 2025 at 09:04:52AM +0200, Lukas Wunner wrote:
>>>> On Fri, Jun 13, 2025 at 04:47:20PM -0500, Daniel Dadap wrote:
>>>>> Ideally we'd be able to actually query which GPU is connected to
>>>>> the panel at the time we're making this determination, but I don't
>>>>> think there's a uniform way to do this at the moment. Selecting the
>>>>> integrated GPU seems like a reasonable heuristic, since I'm not
>>>>> aware of any systems where the internal panel defaults to dGPU
>>>>> connection, since that would defeat the purpose of having a hybrid
>>>>> GPU system in the first place
>>>>
>>>> Intel-based dual-GPU MacBook Pros boot with the panel switched to the
>>>> dGPU by default.  This is done for Windows compatibility because Apple
>>>> never bothered to implement dynamic GPU switching on Windows.
>>>>
>>>> The boot firmware can be told to switch the panel to the iGPU via an
>>>> EFI variable, but that's not something the kernel can or should depend on.
>>>>
>>>> MacBook Pros introduced since 2013/2014 hide the iGPU if the panel is
>>>> switched to the dGPU on boot, but the kernel is now unhiding it since
>>>> 71e49eccdca6.
>>>
>>> This is good to know. Is vga_switcheroo initialized by the time the code
>>> in this patch runs? If so, maybe we should query switcheroo to determine
>>> the GPU which is connected to the panel and favor that one, then fall
>>> back to the "iGPU is probably right" heuristic otherwise.
>>
>> Right now vga_switcheroo doesn't seem to provide a function to query the
>> current mux state.
>>
>> The driver for the mux on MacBook Pros, apple_gmux.c, can be modular,
>> so may be loaded fairly late.
> 
> Yeah, that's what I was afraid of.
> 
>>
>> Personally I'm booting my MacBook Pro via EFI, so the GPU in use is
>> whatever efifb is talking to.  However it is possible to boot these
>> machines in a legacy CSM mode and I don't know what the situation
>> looks like in that case.
>>
> 
> Skimming through the code, this seems like the sort of thing that the
> existing check in vga_is_firmware_default() is testing. I'm not familiar
> enough with the relevant code to intuitively know whether it is supposed
> to work for UEFI or legacy VGA or both (I think both?).
> 
> Mario, on the affected system, what does vga_is_firmware_default() return
> on each of the GPUs? (I'd expect it to return true for the iGPU and false
> for the dGPU, but I think the (boot_vga && boot_vga->is_firmware_default)
> test would cause vga_is_boot_device() to return false if the vga_default
> is passed into it a second time. That made sense for the way that the
> function was originally called, to test if the passed-in vgadev is any
> "better" than vga_default, and from a quick skim it doesn't seem like it
> would get called multiple times in the new code either, but I worry that
> if someone else decides they need to call vga_is_boot_device() a second
> time in the future it might return a false result for vga_default.)
> 

Right "now" on an unpatched kernel it won't run 'at all' because 
vga_arb_device_init() only matches VGA class devices.

Both GPUs are not VGA compatible, which is what lead to the patch in 
this thread starting to match display class devices too.



