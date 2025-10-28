Return-Path: <linux-pci+bounces-39528-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B13C14CAC
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 14:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DE581B25A10
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 13:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7475F34CDD;
	Tue, 28 Oct 2025 13:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WhdlgvXs"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B07379EA;
	Tue, 28 Oct 2025 13:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761657352; cv=none; b=mHMI38LNTXjMcyNnGgDkr/USomb5Zs2oZDGaUVIkSjEWPdPdDYUb2n8EbAuaJoa7SJaCnxkLW8xm95JJQOUSfegt++3gziF72ZZaCStoFMYA7o1TECY7oylpWcHr2hMm+XdwCMc8yVWR8M+GwV54lRb4s5gxVNe6peJmtY/gGSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761657352; c=relaxed/simple;
	bh=jgk53h7OSDfuZZih1qwRmh/i7Jrm083kbSCmk6tyGss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mw/Ofe7oyI6L8cA7tAF2seWGG1n6fxbbHp9EsOMbXocaDT3vOQeq5cI/RGdFiWh88pNCfK3oCN6FqLDjgDXug576gkxQCAxG558qE5aikAFF8q66txH4dgY4J8hxbxUDSx0hw60OTMk0RGXXQeEcmx6jQ0/V5iCXzZcUgsT32NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WhdlgvXs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A23DDC4CEF7;
	Tue, 28 Oct 2025 13:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761657350;
	bh=jgk53h7OSDfuZZih1qwRmh/i7Jrm083kbSCmk6tyGss=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WhdlgvXsdkUyMpn15dEY5mILwDw6umVD2N2R1lqoyLTBvGQUt1LS+lCFW4ugucwXR
	 QVUQEyu7cC58JQQi9af+CFHr54y66WWUkLSq5oCg5AHReytX/pnlllglklzBPSqYzl
	 TOf7+OoU2UrlNBHMnmsCQAhuVK0AXD1Siqj/aOerhAf1frPGCxJW0Go4vnBwt6Ej1L
	 vNNtYUkGTiVixV4KWW+fEilkg+5dyL/EYi6PyiRnBry1s08tepgdQyyRXou53TU1Kj
	 4Pyy8gRFRJuI+y3V4UtSDVCHybzDGsXPBBjAIU22c7rJENtKWcpFE6MoflnWxTOfU6
	 fP4BkjZEj+XTg==
Message-ID: <fb519d0e-9d7f-4835-964a-c21fd24b10e8@kernel.org>
Date: Tue, 28 Oct 2025 08:15:48 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 3/4] fbcon: Use screen info to find primary device
To: Aaron Erhardt <aer@tuxedocomputers.com>, David Airlie
 <airlied@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
 Daniel Dadap <ddadap@nvidia.com>
References: <20250811162606.587759-1-superm1@kernel.org>
 <20250811162606.587759-4-superm1@kernel.org>
 <e172ebf2-4b65-4781-b9e7-eb7bd4fa956a@tuxedocomputers.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <e172ebf2-4b65-4781-b9e7-eb7bd4fa956a@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/28/25 5:16 AM, Aaron Erhardt wrote:
> 
> On Mon, Aug 11, 2025 at 11:26:05AM -0500, Mario Limonciello (AMD) wrote:
>> On systems with non VGA GPUs fbcon can't find the primary GPU because
>> video_is_primary_device() only checks the VGA arbiter.
>>
>> Add a screen info check to video_is_primary_device() so that callers
>> can get accurate data on such systems.
> 
> I have a question regarding this change. To me, the function name
> video_is_primary_device() implies that there is only one primary GPU.
> I would also expect that the 'boot_display' attribute added later in
> the patch series based on this function is only set for one GPU, but
> that is not necessarily the case. Since I'm working on a user-space
> program that reads the 'boot_display' attribute, I need to know what
> behavior is intended in order to do a correct implementation.
> 
>>
>> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
>> Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
>> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
>> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
>> ---
>> v10:
>>   * Rebase on 6.17-rc1
>>   * Squash 'fbcon: Stop using screen_info_pci_dev()'
>> ---
>>   arch/x86/video/video-common.c | 25 ++++++++++++++++++++++++-
>>   1 file changed, 24 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/video/video-common.c b/arch/x86/video/video-common.c
>> index 81fc97a2a837a..e0aeee99bc99e 100644
>> --- a/arch/x86/video/video-common.c
>> +++ b/arch/x86/video/video-common.c
>> @@ -9,6 +9,7 @@
>>   
>>   #include <linux/module.h>
>>   #include <linux/pci.h>
>> +#include <linux/screen_info.h>
>>   #include <linux/vgaarb.h>
>>   
>>   #include <asm/video.h>
>> @@ -27,6 +28,11 @@ EXPORT_SYMBOL(pgprot_framebuffer);
>>   
>>   bool video_is_primary_device(struct device *dev)
>>   {
>> +#ifdef CONFIG_SCREEN_INFO
>> +	struct screen_info *si = &screen_info;
>> +	struct resource res[SCREEN_INFO_MAX_RESOURCES];
>> +	ssize_t i, numres;
>> +#endif
>>   	struct pci_dev *pdev;
>>   
>>   	if (!dev_is_pci(dev))
>> @@ -34,7 +40,24 @@ bool video_is_primary_device(struct device *dev)
>>   
>>   	pdev = to_pci_dev(dev);
>>   
>> -	return (pdev == vga_default_device());
>> +	if (!pci_is_display(pdev))
>> +		return false;
>> +
>> +	if (pdev == vga_default_device())
>> +		return true;
> 
> This can mark a VGA device as primary GPU.
> 
>> +
>> +#ifdef CONFIG_SCREEN_INFO
>> +	numres = screen_info_resources(si, res, ARRAY_SIZE(res));
>> +	for (i = 0; i < numres; ++i) {
>> +		if (!(res[i].flags & IORESOURCE_MEM))
>> +			continue;
>> +
>> +		if (pci_find_resource(pdev, &res[i]))
>> +			return true;
>> +	}
>> +#endif
> 
> And then the new code can also choose a primary GPU.
> 
>> +
>> +	return false;
>>   }
>>   EXPORT_SYMBOL(video_is_primary_device);
>>   
> 
> In particular, I have hardware that has this exact configuration where
> two GPUs are marked as primary and have a 'boot_display' attribute: the
> first one through vga_default_device(), the second one through the new
> detection method.
> 
> Is this intended?
> 
> Kind regards
> Aaron
> 

I wouldn't have expected a case like this and I think it means there is 
a logic error.

Can you please file a kernel bugzilla with details about your system and 
CC me?

dmesg and lspci -vvnn please

Also; please clarify which GPU shows something when booting up.

