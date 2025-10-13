Return-Path: <linux-pci+bounces-37906-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9ABBD4BA6
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 18:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4204D4FACD0
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 15:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88CFB24A044;
	Mon, 13 Oct 2025 15:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0UYvG7bB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bKsqT7ro";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0UYvG7bB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bKsqT7ro"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E89230BBBB
	for <linux-pci@vger.kernel.org>; Mon, 13 Oct 2025 15:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760368766; cv=none; b=PS6JJ4hHEfKD9VrTs5xe3tdOOwnngxQKclFIP9CAlXF2sdjcK05Fx6IYs9ziUGWMIseb/whfRdBodq0F/SYPBks6Z1k2RogqjUZ2OYDGAIb3NwFHergZq3mpS7kWNOyAKnoUKHSEZOHQLc/k1fK0QSEfrkCCXpmg2ZbtfM+dRr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760368766; c=relaxed/simple;
	bh=nppjRKcSel+8WMKIgoRNqkBZ1LEu01MyMB6lbpXN4Ss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PTCG3cly/cPBvK05ua1AtV8E93463P4YyJt6utFwJRJcWPZD9VIic2KTnkhZ35MVMxOZbxDkR4dhUZp13hA3BUc8GVV0U7PWVP0aAQnAL3+IlJsj3LMFPnHW1KC7TQf+FibjsX7CxeXMK6nAOvv3W0yRyND+hTcK1nEXIgQGEbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0UYvG7bB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bKsqT7ro; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0UYvG7bB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bKsqT7ro; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 439BE21A0F;
	Mon, 13 Oct 2025 15:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760368762; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kHAePRcnBPKeyn3DzMFjKbP/0+GxEY/FQi2HZFLpJ2Y=;
	b=0UYvG7bBdxCkENKAAU+l5MfPIrwdAeZHyXrPsnbCK+LMud3ZbN6edJMjuGNWYQglZNjenu
	48XKs+UmGmKOqJB4qLXM8SI7Dtpd+BAkD8U+wCkKe2iamXRW9vHBYxbcSZtzzn+6Jlnw46
	0Lkselx4VV6wJ2k9CQkBNX5TBavyy5o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760368762;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kHAePRcnBPKeyn3DzMFjKbP/0+GxEY/FQi2HZFLpJ2Y=;
	b=bKsqT7roLH1RzHdFpDZtI748PlOiA5XH4eYEb1c8eGVI1oaTGm6rSPxdx9mySUjQ0F6YVx
	Duvi7s6BN2aoPzAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=0UYvG7bB;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=bKsqT7ro
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760368762; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kHAePRcnBPKeyn3DzMFjKbP/0+GxEY/FQi2HZFLpJ2Y=;
	b=0UYvG7bBdxCkENKAAU+l5MfPIrwdAeZHyXrPsnbCK+LMud3ZbN6edJMjuGNWYQglZNjenu
	48XKs+UmGmKOqJB4qLXM8SI7Dtpd+BAkD8U+wCkKe2iamXRW9vHBYxbcSZtzzn+6Jlnw46
	0Lkselx4VV6wJ2k9CQkBNX5TBavyy5o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760368762;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kHAePRcnBPKeyn3DzMFjKbP/0+GxEY/FQi2HZFLpJ2Y=;
	b=bKsqT7roLH1RzHdFpDZtI748PlOiA5XH4eYEb1c8eGVI1oaTGm6rSPxdx9mySUjQ0F6YVx
	Duvi7s6BN2aoPzAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4C0161374A;
	Mon, 13 Oct 2025 15:19:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oo5PEXkY7WgPTAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 13 Oct 2025 15:19:21 +0000
Message-ID: <a7870faa-9c31-435b-b043-9f3ba1cbdcee@suse.de>
Date: Mon, 13 Oct 2025 17:19:20 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/VGA: Select SCREEN_INFO
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Mario Limonciello <superm1@kernel.org>
Cc: mario.limonciello@amd.com, bhelgaas@google.com,
 Eric Biggers <ebiggers@kernel.org>, linux-pci@vger.kernel.org
References: <20251013135929.913441-1-superm1@kernel.org>
 <f36a943e-73bb-97ce-83bc-56aa0e1b5267@linux.intel.com>
 <6dd53ff9-2398-4756-9c13-c082f1c01d4b@kernel.org>
 <56b866bd-d1ad-3be3-a6a6-ed726aa1f9ef@linux.intel.com>
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
In-Reply-To: <56b866bd-d1ad-3be3-a6a6-ed726aa1f9ef@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 439BE21A0F
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -4.51

Hi

Am 13.10.25 um 16:35 schrieb Ilpo Järvinen:
> On Mon, 13 Oct 2025, Mario Limonciello wrote:
>
>> On 10/13/25 9:16 AM, Ilpo Järvinen wrote:
>>> On Mon, 13 Oct 2025, Mario Limonciello (AMD) wrote:
>>>
>>>> commit 337bf13aa9dda ("PCI/VGA: Replace vga_is_firmware_default() with
>>>> a screen info check") introduced an implicit dependency upon SCREEN_INFO
>>>> by removing the open coded implementation.
>>>>
>>>> If a user didn't have CONFIG_SCREEN_INFO set vga_is_firmware_default()
>>>> would now return false.  Add a select for SCREEN_INFO to ensure that the
>>>> VGA arbiter works as intended.
>>>>
>>>> Reported-by: Eric Biggers <ebiggers@kernel.org>
>>>> Closes: https://lore.kernel.org/linux-pci/20251012182302.GA3412@sol/
>>>> Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
>>>> Fixes: 337bf13aa9dda ("PCI/VGA: Replace vga_is_firmware_default() with a
>>>> screen info check")
>>>> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
>>>> ---
>>>>    drivers/pci/Kconfig | 1 +
>>>>    1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
>>>> index 7065a8e5f9b14..c35fed47addd5 100644
>>>> --- a/drivers/pci/Kconfig
>>>> +++ b/drivers/pci/Kconfig
>>>> @@ -306,6 +306,7 @@ config VGA_ARB
>>>>    	bool "VGA Arbitration" if EXPERT
>>>>    	default y
>>>>    	depends on (PCI && !S390)
>>>> +	select SCREEN_INFO
>>>>    	help
>>>>    	  Some "legacy" VGA devices implemented on PCI typically have the same
>>>>    	  hard-decoded addresses as they did on ISA. When multiple PCI devices
>>> The commit 337bf13aa9dda ("PCI/VGA: Replace vga_is_firmware_default() with
>>> a screen info check") also changed to #ifdef CONFIG_SCREEN_INFO around the
>>> call, but that now becomes superfluous with this select, no?
>> Thanks! Will adjust.

Yes, thanks. You can no longer run into this #else.

>>
>>> Looking into the history of the ifdefs here is quite odd pattern (only
>>> the last one comes with some explanation but even that is on the vague
>>> side and fails to remove the actual now unnecessary ifdef :-/):
>>>
>>> #if defined(CONFIG_X86) -> #if defined(CONFIG_X86) -> select SCREEN_INFO
>>>
>>> Was it intentional to allow building without CONFIG_SCREEN_INFO?
>>>
>> You mean in the VGA arbiter code?  Or just in general?
> Here in the VGA arbiter. I'm just trying to understand why the #else part
> was here post-337bf13aa9dda.

The #else branch used to return false (i.e., the device is not the 
default).  But this was only used internally by fbcon for minor 
features. So it really didn't matter that much.

Now we need the default for userspace, hence we likely should have an 
#else branch at all.

Best regards
Thomas

>
>> There is a lot of
>> other places that conditionalize code on CONFIG_SCREEN_INFO.  You don't "have"
>> to build in the the VGA arbiter and presumably those are correct.
>>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)



