Return-Path: <linux-pci+bounces-39725-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 405EEC1D07E
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 20:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACF8B188DECB
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 19:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3B4358D21;
	Wed, 29 Oct 2025 19:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/Su8Lqf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98568481CD
	for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 19:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761766696; cv=none; b=X/4O/HevxgcuR3LEN0OJgDKGk/SnD2j+u6TnFfKrROx0zfNKmwnPvfv68+EFAfomFKacTizpWwzI6O9Vdgs+DuTUjAnxlG/d44LvJOpHmo9h+Ntg9r8wWA4oUuN7yqoUjXMbyfEQCYQiHPMaXIHnG08Ghi0qpDdy9xDNr+MZMto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761766696; c=relaxed/simple;
	bh=EXFvLgbOBtoF5QyqJGcZ/8tZBybYcCaxXWMdAZI2k4w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f4RN8BEzMT0m26afJ7DsGi1RlZBcifQ+wyhkKv0vRDmwCoQbZGs2QzqHKM3kjTwqMTGypgmCHiUq1vNfIipDWUc8zvxK7yFS/PwG/PJxokPH/mt0U5ooqfv9YhDpLWn9/CokFLFU22Np4s/5/u5pBGg6gX/1sXcgry1XalaNG9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V/Su8Lqf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A69FC4CEF7;
	Wed, 29 Oct 2025 19:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761766696;
	bh=EXFvLgbOBtoF5QyqJGcZ/8tZBybYcCaxXWMdAZI2k4w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=V/Su8Lqf1olHAkjUMbetjic6N01kV/5HHS71Iu9Eu3JcisTGLs8gNBOMcydg/ZKqk
	 Kfs3kfjsl2fYusm4+WW3QcCzlsC5wCSKXg5zF6nOIBhqEh5QABo8Eiia25zu/g5Ztk
	 6AjLDNqloW7W+5FqUpBV++TXnPXsoG9szHb/Ni+6Ec+2NOnPfYmEWAPCXw0SgMS0mv
	 +CqieHa6T7UCMqqoZ0GYOCcPELncV5+QibAtb6j+5uXjFm7xkUGfy8Fcmwf0+miR0C
	 r0rjS9Q0yFWpie+WephL+2Y1QDsqHigB3wDD/+2FyF551etNbkbBYIhM9Ux0zCg9MD
	 Rx8Nng6nRN8kQ==
Message-ID: <546c998b-a740-4cc9-8f9c-21c8d2db7c3e@kernel.org>
Date: Wed, 29 Oct 2025 14:38:12 -0500
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
References: <20251029193455.GA1576217@bhelgaas>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20251029193455.GA1576217@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

+Thomas

On 10/29/25 2:34 PM, Bjorn Helgaas wrote:
> On Wed, Oct 29, 2025 at 01:59:33PM -0500, Mario Limonciello (AMD) wrote:
>> Some systems ship with multiple display class devices but not all
>> of them are VGA devices. If the "only" VGA device on the system is not
>> used for displaying the image on the screen marking it as `boot_vga`
>> because nothing was found is totally wrong.
>>
>> This behavior actually leads to mistakes of the wrong device being
>> advertised to userspace and then userspace can make incorrect decisions.
>>
>> As there is an accurate `boot_display` sysfs file stop lying about
>> `boot_vga` by assuming if nothing is found it's the right device.
>>
>> Reported-by: Aaron Erhardt <aer@tuxedocomputers.com>
>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220712
>> Tested-by: Aaron Erhardt <aer@tuxedocomputers.com>
>> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> 
> Do we need a Fixes: here?  A stable cc?
> 
> The bugzilla suggests this might be a regression and hence v6.18
> material?

Yeah I think you're right, we should add these two tags and this should 
go to 6.18 if it's a reasonable change.

Cc: stable@vger.kernel.org
Fixes: ad90860bd10ee ("fbcon: Use screen info to find primary device")

But let's also make sure Thomas Zimmermann agrees with this change.

> 
>> ---
>>   drivers/pci/vgaarb.c | 7 -------
>>   1 file changed, 7 deletions(-)
>>
>> diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
>> index 436fa7f4c3873..baa242b140993 100644
>> --- a/drivers/pci/vgaarb.c
>> +++ b/drivers/pci/vgaarb.c
>> @@ -652,13 +652,6 @@ static bool vga_is_boot_device(struct vga_device *vgadev)
>>   		return true;
>>   	}
>>   
>> -	/*
>> -	 * Vgadev has neither IO nor MEM enabled.  If we haven't found any
>> -	 * other VGA devices, it is the best candidate so far.
>> -	 */
>> -	if (!boot_vga)
>> -		return true;
>> -
>>   	return false;
>>   }
>>   
>> -- 
>> 2.43.0
>>


