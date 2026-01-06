Return-Path: <linux-pci+bounces-44083-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D2FCF7041
	for <lists+linux-pci@lfdr.de>; Tue, 06 Jan 2026 08:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC904300F31F
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jan 2026 07:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA702E0B58;
	Tue,  6 Jan 2026 07:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dC6EseTY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MBSqpv5b";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZCD1DhZK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nxaX6rrq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9665A27CCE0
	for <linux-pci@vger.kernel.org>; Tue,  6 Jan 2026 07:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767683931; cv=none; b=I/jTkdNgqyBy/tPQA4vROZ53m9Lo+QwNAv2yyHNezchW9xYZeKLr28pa/6XZesBm9zl878NgVoEMj+VOFq/Tgad8E/ETmmXOo0SovVk7gb26KPEfwUcH4hyhitOyI38Wsi3dh2DkMMzyMvnWGm4XTdPdkOSosV9hMAI0umRW93A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767683931; c=relaxed/simple;
	bh=+zMy2KE1hz0PLsDfrFsWs7v/tgwirMZ++wUG2uLOMRE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CS1p3zBaZUAC1+0i216wHXYbDNOoX4qD4XOIzjQpf8hTa9GzHotI0pKgJ0ssP3VaxeE7FH79VdKY9CJv8ZrtSbFXJxlFSUS5iLnMneJ0pdpxzs3jf86Bmr7Bj5e3NdUZLm+7KzL0P8bAQMteuzsfEusEdwtFHOjEQ36I33SUqDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dC6EseTY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MBSqpv5b; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZCD1DhZK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nxaX6rrq; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 72C7C5BCC4;
	Tue,  6 Jan 2026 07:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1767683926; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+v7QXumsb9IYfDQhX5dnrJNaJPnfQ9T9ZRuy4C7FLtA=;
	b=dC6EseTYdwVP6zWy/i5X22usAoPuvkD/UfT/yq2TCnOZz/FH/76Qs7bGukMDQxAPO2Ya7a
	rtv8y5GHZQYo9rPST6v/QBcDRpRZK3iiy1lH+IOEj0nruTnPZoNQCIYRkNjGm3Hr4jZqBR
	nVXZdNax/C/7tgAZsBcMlxebv2PWJ78=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1767683926;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+v7QXumsb9IYfDQhX5dnrJNaJPnfQ9T9ZRuy4C7FLtA=;
	b=MBSqpv5bI+GbZhvDR06HuYxEZxMPqCaSu0nIn9eRn8LaEOAOE8e4ePi5aUPriFAcdNC1yv
	AOVcnowXBwrU/xAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1767683925; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+v7QXumsb9IYfDQhX5dnrJNaJPnfQ9T9ZRuy4C7FLtA=;
	b=ZCD1DhZKJja9sCRL//N1tO0yPvJyxKmTytmwGsFKaPtt+U9ZmBpMiZ2Vf8QDjc01po0crk
	HXvpf0WLzcKsYbEe+0vsErUk1Tj+qBKdjme0oCRYb7XFfUhKkvkqmYtqbpehrSKBmHHA/G
	9L9LM0jTmnDaMLy0x21kko20QxpwZ6I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1767683925;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+v7QXumsb9IYfDQhX5dnrJNaJPnfQ9T9ZRuy4C7FLtA=;
	b=nxaX6rrq2tsfDL3kpVVr5TQ7rRbqGGpR2+6WZkP4JRDoqVJ5q00vIO7y9HKZRFHpxYnzTP
	WwfotBlix8D23XCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 47D813EA63;
	Tue,  6 Jan 2026 07:18:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gFR6D1W3XGmpdgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 06 Jan 2026 07:18:45 +0000
Message-ID: <487ed510-03cc-4054-ad6f-890b7d6c0951@suse.de>
Date: Tue, 6 Jan 2026 08:18:44 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 RESEND] PCI/VGA: Don't assume the only VGA device on a
 system is `boot_vga`
To: "Mario Limonciello (AMD)" <superm1@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>
Cc: Aaron Erhardt <aer@tuxedocomputers.com>, "Luke D . Jones"
 <luke@ljones.dev>
References: <20260106044638.52906-1-superm1@kernel.org>
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
In-Reply-To: <20260106044638.52906-1-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.27
X-Spam-Level: 
X-Spamd-Result: default: False [-4.27 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.17)[-0.868];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tuxedocomputers.com:email,suse.com:url,suse.de:email,suse.de:mid]

Hi

Am 06.01.26 um 05:46 schrieb Mario Limonciello (AMD):
> Some systems ship with multiple display class devices but not all
> of them are VGA devices. If the "only" VGA device on the system is not
> used for displaying the image on the screen marking it as `boot_vga`
> because nothing was found is totally wrong.
>
> This behavior actually leads to mistakes of the wrong device being
> advertised to userspace and then userspace can make incorrect decisions.
>
> As there is an accurate `boot_display` sysfs file stop lying about
> `boot_vga` by assuming if nothing is found it's the right device.
>
> Reported-by: Aaron Erhardt <aer@tuxedocomputers.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220712
> Tested-by: Aaron Erhardt <aer@tuxedocomputers.com>
> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: ad90860bd10ee ("fbcon: Use screen info to find primary device")
> Tested-by: Luke D. Jones <luke@ljones.dev>
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
> This was probably lost in the holiday shuffle, so resend it.

Merged now into drm-misc-fixes.

Best regards
Thomas

> v2: https://lore.kernel.org/linux-pci/20251214183602.150412-1-superm1@kernel.org/
>   drivers/pci/vgaarb.c | 7 -------
>   1 file changed, 7 deletions(-)
>
> diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
> index 436fa7f4c3873..baa242b140993 100644
> --- a/drivers/pci/vgaarb.c
> +++ b/drivers/pci/vgaarb.c
> @@ -652,13 +652,6 @@ static bool vga_is_boot_device(struct vga_device *vgadev)
>   		return true;
>   	}
>   
> -	/*
> -	 * Vgadev has neither IO nor MEM enabled.  If we haven't found any
> -	 * other VGA devices, it is the best candidate so far.
> -	 */
> -	if (!boot_vga)
> -		return true;
> -
>   	return false;
>   }
>   

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)



