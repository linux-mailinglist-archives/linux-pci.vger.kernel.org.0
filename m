Return-Path: <linux-pci+bounces-38021-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 231F9BD8289
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 10:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 295C84F96EE
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 08:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED14930F55C;
	Tue, 14 Oct 2025 08:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="2JuWwC7Z";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bA/j8gN5";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uF9Fv27x";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nmXvmFIp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93E530F551
	for <linux-pci@vger.kernel.org>; Tue, 14 Oct 2025 08:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760430285; cv=none; b=nNAoa+5FIEupDbah0LwKZbrsb8iikST2N9otUWIr9c3SaOs0/H41so35RTypahL5igY78OKt3ioXWIc/zvp2FX9ebEsJvR3oySfLw3sW87LHpPukDd+HE3bdDFMc403gwEc39KMm/sT4Idrlh4lU3uNu/u5lF+odhlPpIPb9Zfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760430285; c=relaxed/simple;
	bh=mnOa/9t5Ts0GH+gx4fSWKB68mVOf+sFjvX1Zcd/Yshw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RuJFmz+aLu/DpqNCnU2aLo7YESllKRO5lZ9ZOP5FsW3Ve47Rz+HbU/DrBvnwK+jqbjdr9abj2yVVuGIMkTbnIQboEmDzSsFx9bxOtUW0Fzr3Q7lZC+dyjGyAC+851nTCkDMdf+NDFWSFeeSmmhW9s0vP3iSF8A01/F/XGDPwP60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=2JuWwC7Z; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bA/j8gN5; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uF9Fv27x; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nmXvmFIp; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9DC8B21A3C;
	Tue, 14 Oct 2025 08:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760430275; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Hmd1h22A+ar9lTEwv7nAx0z4FUA3M7Dkt3L/hytzLN0=;
	b=2JuWwC7Z3ibej/w+StlpCKvy42Edg0Ht/uq1qFxFoGz3i4MCHi6XCFvivlykxkuSdFHtdL
	xhXOTLAX7IqXgKAAYuOmRs0BfHG3TCAq93TRRfyst2eLURPOBMWhOtSLaEwjVqUI9/aANw
	FLfnK/ASJaOJdld9icGjPb9UkRrUPzE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760430275;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Hmd1h22A+ar9lTEwv7nAx0z4FUA3M7Dkt3L/hytzLN0=;
	b=bA/j8gN54lR4CYOR/wjWZGl+S/HjqyEYE115hdYWvsSlR2SQLJJLCWprvrhOZXt0+6UUQu
	o2EWaqhKtgR+9gAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760430273; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Hmd1h22A+ar9lTEwv7nAx0z4FUA3M7Dkt3L/hytzLN0=;
	b=uF9Fv27xThfI/28v6VuK1q+QfdZwlFwCqLbrf36NNZDvdHmEV/mmG7qV5Tdru0tP9fqOSq
	NEvI/fMO2pznDYLMIC16Xo6QTAVA2WJ3ufHvVK6MmEY5/QJfl8nDWHLDIPgE7gDOV1JEQv
	i9fOppvAIcoW8cxaHuYNLLyE/HGKfko=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760430273;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Hmd1h22A+ar9lTEwv7nAx0z4FUA3M7Dkt3L/hytzLN0=;
	b=nmXvmFIpzivzZyp93DoPqefh+oL6d2ApLQEWC/qj3JeooU2kWOP5CZ9L/uBXuT3GeQQ5Y5
	g/kAL34VuM0U8HBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6D18A13A7E;
	Tue, 14 Oct 2025 08:24:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FyOJF8EI7miwDwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 14 Oct 2025 08:24:33 +0000
Message-ID: <f05a530b-c5db-4db0-8458-1ba0443e4f2a@suse.de>
Date: Tue, 14 Oct 2025 10:24:32 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] PCI/VGA: Select SCREEN_INFO on X86
To: "Mario Limonciello (AMD)" <superm1@kernel.org>,
 mario.limonciello@amd.com, bhelgaas@google.com
Cc: Eric Biggers <ebiggers@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-pci@vger.kernel.org
References: <20251013220829.1536292-1-superm1@kernel.org>
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
In-Reply-To: <20251013220829.1536292-1-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:url,suse.de:mid,suse.de:email,intel.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 



Am 14.10.25 um 00:08 schrieb Mario Limonciello (AMD):
> commit 337bf13aa9dda ("PCI/VGA: Replace vga_is_firmware_default() with
> a screen info check") introduced an implicit dependency upon SCREEN_INFO
> by removing the open coded implementation.
>
> If a user didn't have CONFIG_SCREEN_INFO set vga_is_firmware_default()
> would now return false.  SCREEN_INFO is only used on X86 so add add a
> conditional select for SCREEN_INFO to ensure that the VGA arbiter works
> as intended.
>
> Reported-by: Eric Biggers <ebiggers@kernel.org>
> Closes: https://lore.kernel.org/linux-pci/20251012182302.GA3412@sol/
> Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: 337bf13aa9dda ("PCI/VGA: Replace vga_is_firmware_default() with a screen info check")
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>   drivers/pci/Kconfig  | 1 +
>   drivers/pci/vgaarb.c | 6 ++----
>   2 files changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index 7065a8e5f9b14..f94f5d384362e 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -306,6 +306,7 @@ config VGA_ARB
>   	bool "VGA Arbitration" if EXPERT
>   	default y
>   	depends on (PCI && !S390)
> +	select SCREEN_INFO if X86

On x86 screen_info comes from [1]. On other systems it's at [2].

You can try selecting CONFIG_SYSFB instead, but that will likely run 
into trouble with CONFIG_EFI=n.

[1] 
https://elixir.bootlin.com/linux/v6.17.1/source/arch/x86/kernel/setup.c#L214
[2] 
https://elixir.bootlin.com/linux/v6.17.1/source/drivers/firmware/efi/efi-init.c#L63

I guess, the current patch should work for the use case. I'll keep in 
mind to make the screen_info state easier to select.

Best regards
Thomas

>   	help
>   	  Some "legacy" VGA devices implemented on PCI typically have the same
>   	  hard-decoded addresses as they did on ISA. When multiple PCI devices
> diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
> index b58f94ee48916..436fa7f4c3873 100644
> --- a/drivers/pci/vgaarb.c
> +++ b/drivers/pci/vgaarb.c
> @@ -556,10 +556,8 @@ EXPORT_SYMBOL(vga_put);
>   
>   static bool vga_is_firmware_default(struct pci_dev *pdev)
>   {
> -#ifdef CONFIG_SCREEN_INFO
> -	struct screen_info *si = &screen_info;
> -
> -	return pdev == screen_info_pci_dev(si);
> +#if defined CONFIG_X86
> +	return pdev == screen_info_pci_dev(&screen_info);
>   #else
>   	return false;
>   #endif

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)



