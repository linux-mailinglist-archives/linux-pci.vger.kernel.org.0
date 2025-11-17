Return-Path: <linux-pci+bounces-41425-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 31968C64FF2
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 16:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D5632360D99
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 15:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C3329C343;
	Mon, 17 Nov 2025 15:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tPz+N3bJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DB3275844
	for <linux-pci@vger.kernel.org>; Mon, 17 Nov 2025 15:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763394953; cv=none; b=oLB5+xcgXymBgu6ap+6vcqNNFdRNxGlvo0ClEDhIloPsl36XC7tJksRxamlkJfZtSFTvBPh9HmXJ3AomwJJgyKpl54GpiiWc8WvTyBH6KbypHcTgqYmxMbMhdJ2l551qbCCRwcBP8ww2Fg8L1ebqNmEOXTRPOnCDoYMLU+qL6tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763394953; c=relaxed/simple;
	bh=Dj2C81+fNpKqpih8JD4QNDfaSqcowdVorOf6htRUsUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fAxazzyGb8F2kuXKckLc8g38UliNd44H1/SuwYcg2xcDMIu9jwRAaX4oOg6lkXdwiCFsb9urUCsbMJE+U6jOS4AyETMqkMbpK125FKTVUJkui3HHOlsqmw7EyIDk2iR/vdsRw+6ScD+VNCr6lEWXG64vg/9Yu+cJnCi5wVs2hD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tPz+N3bJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25532C19421;
	Mon, 17 Nov 2025 15:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763394952;
	bh=Dj2C81+fNpKqpih8JD4QNDfaSqcowdVorOf6htRUsUc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tPz+N3bJV3R9cXXK60xGcQcKkn50XgtWRtcjESmbWD/9g2GM0xayFnx516ObM49wI
	 a8CGUHsNEyuOGqLQd/WpW2r1T6V0IoCWnePL8LarwcNT+3uE/gQae4JUqtEj1PUggn
	 P/blvmyg7lZZR0atlozGH4OfvQNP+mHHMLxHxJ4zEmB2lgSYxLOHILAhD8oHHUGi5F
	 D4VtgPB6W6EXzaMVcqfqtNKlg8I+6y/5LALeTnOvbMtqqgtQejUodm2QmYoyBtpUZM
	 cjSUQvmfuuuxqvHBXLeuLQnEPkWrcLerV+VjSoj885ucJSYelEjOlXAedvPU2JFcf7
	 BTSzGWLCuDK1A==
Message-ID: <37a1f3c4-1440-4506-8e9f-a35127fcc7fc@kernel.org>
Date: Mon, 17 Nov 2025 09:55:51 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/VGA: Don't assume the only VGA device on a system is
 `boot_vga`
To: Bjorn Helgaas <helgaas@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>
Cc: mario.limonciello@amd.com, bhelgaas@google.com,
 Aaron Erhardt <aer@tuxedocomputers.com>, linux-pci@vger.kernel.org
References: <20251117154455.GA2457991@bhelgaas>
Content-Language: en-US
From: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
In-Reply-To: <20251117154455.GA2457991@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/17/2025 9:44 AM, Bjorn Helgaas wrote:
> On Mon, Nov 17, 2025 at 08:25:05AM +0100, Thomas Zimmermann wrote:
>> Am 17.11.25 um 06:20 schrieb Mario Limonciello:
>>> On 10/29/25 2:38 PM, Mario Limonciello wrote:
>>>> On 10/29/25 2:34 PM, Bjorn Helgaas wrote:
>>>>> On Wed, Oct 29, 2025 at 01:59:33PM -0500, Mario Limonciello
>>>>> (AMD) wrote:
>>>>>> Some systems ship with multiple display class devices but not all
>>>>>> of them are VGA devices. If the "only" VGA device on the system is not
>>>>>> used for displaying the image on the screen marking it as `boot_vga`
>>>>>> because nothing was found is totally wrong.
>>>>>>
>>>>>> This behavior actually leads to mistakes of the wrong device being
>>>>>> advertised to userspace and then userspace can make
>>>>>> incorrect decisions.
>>>>>>
>>>>>> As there is an accurate `boot_display` sysfs file stop lying about
>>>>>> `boot_vga` by assuming if nothing is found it's the right device.
>>>>>>
>>>>>> Reported-by: Aaron Erhardt <aer@tuxedocomputers.com>
>>>>>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220712
>>>>>> Tested-by: Aaron Erhardt <aer@tuxedocomputers.com>
>>>>>> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
>>>>>
>>>>> Do we need a Fixes: here?  A stable cc?
>>>>>
>>>>> The bugzilla suggests this might be a regression and hence v6.18
>>>>> material?
>>>>
>>>> Yeah I think you're right, we should add these two tags and this
>>>> should go to 6.18 if it's a reasonable change.
>>>>
>>>> Cc: stable@vger.kernel.org
>>>> Fixes: ad90860bd10ee ("fbcon: Use screen info to find primary device")
>>>>
>>>> But let's also make sure Thomas Zimmermann agrees with this change.
>>>
>>> ping?
>>
>> Sorry, this fell though the cracks. I can see that this backfires, but still
>>
>> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
>>
>> because the overall logic of detecting the boot-up VGA is questionable. It
>> picks the first possible candidate instead of looking at all devices before
>> making the decision. If we see regressions from the patch here, this would
>> be the place to fix it.
> 
> One problem is that it's hard to know when we've looked at all the
> devices.  I don't think we currently have a special hook for VGA after
> boot-time enumeration.

I fail to understand why this fallback was even there in the first 
place.  How can we have a VGA device that doesn't have IO or MEM enabled?

It seemed like it was specifically (37114e4d1547e) for hot added 
devices, but that sounds like faulty logic to me.  The whole point of it 
is the device that displayed the boot image - which shouldn't be hot added.
> 
>>>>>> ---
>>>>>>    drivers/pci/vgaarb.c | 7 -------
>>>>>>    1 file changed, 7 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
>>>>>> index 436fa7f4c3873..baa242b140993 100644
>>>>>> --- a/drivers/pci/vgaarb.c
>>>>>> +++ b/drivers/pci/vgaarb.c
>>>>>> @@ -652,13 +652,6 @@ static bool vga_is_boot_device(struct
>>>>>> vga_device *vgadev)
>>>>>>            return true;
>>>>>>        }
>>>>>> -    /*
>>>>>> -     * Vgadev has neither IO nor MEM enabled.  If we
>>>>>> haven't found any
>>>>>> -     * other VGA devices, it is the best candidate so far.
>>>>>> -     */
>>>>>> -    if (!boot_vga)
>>>>>> -        return true;
>>>>>> -
>>>>>>        return false;
>>>>>>    }
>>>>>> -- 
>>>>>> 2.43.0
>>>>>>
>>>>
>>>>
>>>
>>
>> -- 
>> --
>> Thomas Zimmermann
>> Graphics Driver Developer
>> SUSE Software Solutions Germany GmbH
>> Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
>> GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)
>>
>>


