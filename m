Return-Path: <linux-pci+bounces-41360-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE18C6263D
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 06:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABA823B459C
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 05:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276D42F83DE;
	Mon, 17 Nov 2025 05:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aR7Xh+bw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018982459ED
	for <linux-pci@vger.kernel.org>; Mon, 17 Nov 2025 05:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763356816; cv=none; b=sLJcoG2TqjCMI5wulbx5pI5vofyUBB5elrSQ3o5p0ISvuPwK1x+RRtUpJ0/uUYG3gb4D8TK1h4MEIQrOhwGEDILGAPEhdPtX6tr/IIbeHlkLi3phIrbPAuADsNeWpEhdi/ahEpWVxopB70J2SbjOZyxhYff11qZ/YsyYYQUPeFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763356816; c=relaxed/simple;
	bh=RzCk3NX7y4lDeWH2d85kbNJGqzftNNMqTjyb/RyUcFc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=gmAyLQ5Pk/1/uzxFoFVheaV8KXO7D+7yWl1woTOJubpcApmACmokFB6WRHNZKfkNGd65xqloA0jkEaTqQ7bcXhxi0pZ6hwQ86sOObeZvUpPFr0UC7jDK46DOAzal4IVOU+/gr/HKfRD6XiQQI8wLUxfbjImGzYPdmWNngPSpoTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aR7Xh+bw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9C72C19422;
	Mon, 17 Nov 2025 05:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763356815;
	bh=RzCk3NX7y4lDeWH2d85kbNJGqzftNNMqTjyb/RyUcFc=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=aR7Xh+bwmKtDHzCmwPsCcaF/0fqKm3vrjSUlJjJGXXNYjZZUGSNvONk1CsuDl2KZi
	 wUGe4HwXPDH89fvfB7zmNC4/VVR2rmrfzItv7y8Sxews+WX3ECVaUfPm0RVUmvElKr
	 ELFLKsXflP3smCeMfVFmjkh9TjkE4tfvpFpMW+zb0oUXjuLEgSwIWIUG1svLOKmmzj
	 ziOKD8E208Lmlx8rPoJPgnIvVEh2t5prRv4VOe6IG/6m9S5hRo+5fICakywbLQCGff
	 8aHLj8aEdIKAbqKT70077LWjG/3andhUvgltWS43RENznkdvNsouVXNEjMPqmwvCxj
	 HEHbwQZFkzB7Q==
Message-ID: <ab9a68fa-bd4e-4c76-afab-b4b7c1713574@kernel.org>
Date: Sun, 16 Nov 2025 23:20:10 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/VGA: Don't assume the only VGA device on a system is
 `boot_vga`
From: Mario Limonciello <superm1@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>
Cc: mario.limonciello@amd.com, bhelgaas@google.com,
 Aaron Erhardt <aer@tuxedocomputers.com>, linux-pci@vger.kernel.org
References: <20251029193455.GA1576217@bhelgaas>
 <546c998b-a740-4cc9-8f9c-21c8d2db7c3e@kernel.org>
Content-Language: en-US
In-Reply-To: <546c998b-a740-4cc9-8f9c-21c8d2db7c3e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/29/25 2:38 PM, Mario Limonciello wrote:
> +Thomas
> 
> On 10/29/25 2:34 PM, Bjorn Helgaas wrote:
>> On Wed, Oct 29, 2025 at 01:59:33PM -0500, Mario Limonciello (AMD) wrote:
>>> Some systems ship with multiple display class devices but not all
>>> of them are VGA devices. If the "only" VGA device on the system is not
>>> used for displaying the image on the screen marking it as `boot_vga`
>>> because nothing was found is totally wrong.
>>>
>>> This behavior actually leads to mistakes of the wrong device being
>>> advertised to userspace and then userspace can make incorrect decisions.
>>>
>>> As there is an accurate `boot_display` sysfs file stop lying about
>>> `boot_vga` by assuming if nothing is found it's the right device.
>>>
>>> Reported-by: Aaron Erhardt <aer@tuxedocomputers.com>
>>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220712
>>> Tested-by: Aaron Erhardt <aer@tuxedocomputers.com>
>>> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
>>
>> Do we need a Fixes: here?  A stable cc?
>>
>> The bugzilla suggests this might be a regression and hence v6.18
>> material?
> 
> Yeah I think you're right, we should add these two tags and this should 
> go to 6.18 if it's a reasonable change.
> 
> Cc: stable@vger.kernel.org
> Fixes: ad90860bd10ee ("fbcon: Use screen info to find primary device")
> 
> But let's also make sure Thomas Zimmermann agrees with this change.
> 

ping?

>>
>>> ---
>>>   drivers/pci/vgaarb.c | 7 -------
>>>   1 file changed, 7 deletions(-)
>>>
>>> diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
>>> index 436fa7f4c3873..baa242b140993 100644
>>> --- a/drivers/pci/vgaarb.c
>>> +++ b/drivers/pci/vgaarb.c
>>> @@ -652,13 +652,6 @@ static bool vga_is_boot_device(struct vga_device 
>>> *vgadev)
>>>           return true;
>>>       }
>>> -    /*
>>> -     * Vgadev has neither IO nor MEM enabled.  If we haven't found any
>>> -     * other VGA devices, it is the best candidate so far.
>>> -     */
>>> -    if (!boot_vga)
>>> -        return true;
>>> -
>>>       return false;
>>>   }
>>> -- 
>>> 2.43.0
>>>
> 
> 


