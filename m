Return-Path: <linux-pci+bounces-41364-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A57ADC62B5A
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 08:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 00026350BEC
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 07:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2143F156661;
	Mon, 17 Nov 2025 07:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hf/zaDiP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JSOl7iL0";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hm36GJXK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+AKsyHCU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089A9FBF6
	for <linux-pci@vger.kernel.org>; Mon, 17 Nov 2025 07:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763364311; cv=none; b=urNF5lUSp8d6rTfngL/6rwC/mgMHVK1jR18DwJPeEHZVIAnaekC52rjBxdz/x4p1HMY4UqdkI/mj/QynK7IV7wvo2Gap92z3ejUHw4N5rPdQx6MCHQaA5wLZrNkVmS0CCwov0tKAlpBTODjW5p4aE4gVmIpPvhztMD+prM5XwRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763364311; c=relaxed/simple;
	bh=dUPVDPDRP3NNUt88ZfA+zvPXiA5WQJIBmxnHj+xmdMY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eklFOT0DO1hOUc4iQ+wqdhE6cxPmkS2sYAEHd5O2iUsesOelL3zmm3n8/RFYJeqOPR1a2jyQ2gDXCL70hOUYWUtmUExrN5p+s3acBwJ6MKfNfZ38SbKJ4p6tnvt+eOQs1DA5RzMc5g8WU2qHCSV2eHBmCPt1PdJhubjNajf49Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hf/zaDiP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JSOl7iL0; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hm36GJXK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+AKsyHCU; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DFE25211F8;
	Mon, 17 Nov 2025 07:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763364306; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xvvBd8QK4XVRfEaq/PkpsjYeplILL5dLxZSS6uyILuI=;
	b=hf/zaDiPkG6XqS44eAu0FMiGGtbHOoQwegvRJVXc15sMDc/d4VSlB65Kwh8MqzRFwh10vD
	oDw0HRfIGxP7novIlogGZ/PzPDFERYfGpTSTrV8IzT9RSfvF8MzIlA/9Ev+5sudlDcNgha
	GniWXaGQTK4FmAvxThHlJ3Eimkhgpco=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763364306;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xvvBd8QK4XVRfEaq/PkpsjYeplILL5dLxZSS6uyILuI=;
	b=JSOl7iL0DbDWwCBNuj3tCot9//7doVksTLbK0RqCKXo6szHkOEnNrsvKyCr/pc4V0wIz06
	mkff0Myq2aUAIOAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763364305; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xvvBd8QK4XVRfEaq/PkpsjYeplILL5dLxZSS6uyILuI=;
	b=hm36GJXK971978mz6GFQ9mOpyoIwUMFSlaNi8LgfHnxxrzwZ9dqpKjOx4d2UXJJdxfIpKz
	7K2TYKjgNVDJgqeop9lYvcTWnhe76a4njn6ey0EorVaRxSCT70qIRPV+GkoEDw9XVAMySb
	+9d8kyMdozay/xdElSOvF36sR5htzvU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763364305;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xvvBd8QK4XVRfEaq/PkpsjYeplILL5dLxZSS6uyILuI=;
	b=+AKsyHCUJjIEuQANniinyIgHnQb+4jjuinDWJ57SSywAKNKqyESDfzWNJUqL2rIxpqtvlI
	HISdu37ZPU8MJ4AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B0C963EA61;
	Mon, 17 Nov 2025 07:25:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MqW0KdHNGmlBHAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 17 Nov 2025 07:25:05 +0000
Message-ID: <50f7af87-8a04-44aa-87e8-f236102b71b8@suse.de>
Date: Mon, 17 Nov 2025 08:25:05 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/VGA: Don't assume the only VGA device on a system is
 `boot_vga`
To: Mario Limonciello <superm1@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>
Cc: mario.limonciello@amd.com, bhelgaas@google.com,
 Aaron Erhardt <aer@tuxedocomputers.com>, linux-pci@vger.kernel.org
References: <20251029193455.GA1576217@bhelgaas>
 <546c998b-a740-4cc9-8f9c-21c8d2db7c3e@kernel.org>
 <ab9a68fa-bd4e-4c76-afab-b4b7c1713574@kernel.org>
Content-Language: en-US
From: Thomas Zimmermann <tzimmermann@suse.de>
Autocrypt: addr=tzimmermann@suse.de; keydata=
 xsBNBFs50uABCADEHPidWt974CaxBVbrIBwqcq/WURinJ3+2WlIrKWspiP83vfZKaXhFYsdg
 XH47fDVbPPj+d6tQrw5lPQCyqjwrCPYnq3WlIBnGPJ4/jreTL6V+qfKRDlGLWFjZcsrPJGE0
 BeB5BbqP5erN1qylK9i3gPoQjXGhpBpQYwRrEyQyjuvk+Ev0K1Jc5tVDeJAuau3TGNgah4Yc
 hdHm3bkPjz9EErV85RwvImQ1dptvx6s7xzwXTgGAsaYZsL8WCwDaTuqFa1d1jjlaxg6+tZsB
 9GluwvIhSezPgnEmimZDkGnZRRSFiGP8yjqTjjWuf0bSj5rUnTGiyLyRZRNGcXmu6hjlABEB
 AAHNJ1Rob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPsLAjgQTAQgAOAIb
 AwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftODH
 AAoJEGgNwR1TC3ojx1wH/0hKGWugiqDgLNXLRD/4TfHBEKmxIrmfu9Z5t7vwUKfwhFL6hqvo
 lXPJJKQpQ2z8+X2vZm/slsLn7J1yjrOsoJhKABDi+3QWWSGkaGwRJAdPVVyJMfJRNNNIKwVb
 U6B1BkX2XDKDGffF4TxlOpSQzdtNI/9gleOoUA8+jy8knnDYzjBNOZqLG2FuTdicBXblz0Mf
 vg41gd9kCwYXDnD91rJU8tzylXv03E75NCaTxTM+FBXPmsAVYQ4GYhhgFt8S2UWMoaaABLDe
 7l5FdnLdDEcbmd8uLU2CaG4W2cLrUaI4jz2XbkcPQkqTQ3EB67hYkjiEE6Zy3ggOitiQGcqp
 j//OwE0EWznS4AEIAMYmP4M/V+T5RY5at/g7rUdNsLhWv1APYrh9RQefODYHrNRHUE9eosYb
 T6XMryR9hT8XlGOYRwKWwiQBoWSDiTMo/Xi29jUnn4BXfI2px2DTXwc22LKtLAgTRjP+qbU6
 3Y0xnQN29UGDbYgyyK51DW3H0If2a3JNsheAAK+Xc9baj0LGIc8T9uiEWHBnCH+RdhgATnWW
 GKdDegUR5BkDfDg5O/FISymJBHx2Dyoklv5g4BzkgqTqwmaYzsl8UxZKvbaxq0zbehDda8lv
 hFXodNFMAgTLJlLuDYOGLK2AwbrS3Sp0AEbkpdJBb44qVlGm5bApZouHeJ/+n+7r12+lqdsA
 EQEAAcLAdgQYAQgAIAIbDBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftOH6AAoJEGgNwR1T
 C3ojVSkIALpAPkIJPQoURPb1VWjh34l0HlglmYHvZszJWTXYwavHR8+k6Baa6H7ufXNQtThR
 yIxJrQLW6rV5lm7TjhffEhxVCn37+cg0zZ3j7zIsSS0rx/aMwi6VhFJA5hfn3T0TtrijKP4A
 SAQO9xD1Zk9/61JWk8OysuIh7MXkl0fxbRKWE93XeQBhIJHQfnc+YBLprdnxR446Sh8Wn/2D
 Ya8cavuWf2zrB6cZurs048xe0UbSW5AOSo4V9M0jzYI4nZqTmPxYyXbm30Kvmz0rYVRaitYJ
 4kyYYMhuULvrJDMjZRvaNe52tkKAvMevcGdt38H4KSVXAylqyQOW5zvPc4/sq9c=
In-Reply-To: <ab9a68fa-bd4e-4c76-afab-b4b7c1713574@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo,suse.com:url]
X-Spam-Flag: NO
X-Spam-Score: -4.30

Hi

Am 17.11.25 um 06:20 schrieb Mario Limonciello:
>
>
> On 10/29/25 2:38 PM, Mario Limonciello wrote:
>> +Thomas
>>
>> On 10/29/25 2:34 PM, Bjorn Helgaas wrote:
>>> On Wed, Oct 29, 2025 at 01:59:33PM -0500, Mario Limonciello (AMD) 
>>> wrote:
>>>> Some systems ship with multiple display class devices but not all
>>>> of them are VGA devices. If the "only" VGA device on the system is not
>>>> used for displaying the image on the screen marking it as `boot_vga`
>>>> because nothing was found is totally wrong.
>>>>
>>>> This behavior actually leads to mistakes of the wrong device being
>>>> advertised to userspace and then userspace can make incorrect 
>>>> decisions.
>>>>
>>>> As there is an accurate `boot_display` sysfs file stop lying about
>>>> `boot_vga` by assuming if nothing is found it's the right device.
>>>>
>>>> Reported-by: Aaron Erhardt <aer@tuxedocomputers.com>
>>>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220712
>>>> Tested-by: Aaron Erhardt <aer@tuxedocomputers.com>
>>>> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
>>>
>>> Do we need a Fixes: here?  A stable cc?
>>>
>>> The bugzilla suggests this might be a regression and hence v6.18
>>> material?
>>
>> Yeah I think you're right, we should add these two tags and this 
>> should go to 6.18 if it's a reasonable change.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: ad90860bd10ee ("fbcon: Use screen info to find primary device")
>>
>> But let's also make sure Thomas Zimmermann agrees with this change.
>>
>
> ping?

Sorry, this fell though the cracks. I can see that this backfires, but still

Acked-by: Thomas Zimmermann <tzimmermann@suse.de>

because the overall logic of detecting the boot-up VGA is questionable. 
It picks the first possible candidate instead of looking at all devices 
before making the decision. If we see regressions from the patch here, 
this would be the place to fix it.

Best regards
Thomas

>
>>>
>>>> ---
>>>>   drivers/pci/vgaarb.c | 7 -------
>>>>   1 file changed, 7 deletions(-)
>>>>
>>>> diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
>>>> index 436fa7f4c3873..baa242b140993 100644
>>>> --- a/drivers/pci/vgaarb.c
>>>> +++ b/drivers/pci/vgaarb.c
>>>> @@ -652,13 +652,6 @@ static bool vga_is_boot_device(struct 
>>>> vga_device *vgadev)
>>>>           return true;
>>>>       }
>>>> -    /*
>>>> -     * Vgadev has neither IO nor MEM enabled.  If we haven't found 
>>>> any
>>>> -     * other VGA devices, it is the best candidate so far.
>>>> -     */
>>>> -    if (!boot_vga)
>>>> -        return true;
>>>> -
>>>>       return false;
>>>>   }
>>>> -- 
>>>> 2.43.0
>>>>
>>
>>
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)



