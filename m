Return-Path: <linux-pci+bounces-37932-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B234DBD4FE1
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 18:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB67B5E021F
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 16:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857C417A2EC;
	Mon, 13 Oct 2025 16:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SQW8rIgK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="32IgMTUy";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SQW8rIgK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="32IgMTUy"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33DD274B3D
	for <linux-pci@vger.kernel.org>; Mon, 13 Oct 2025 16:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760371862; cv=none; b=YRD6L59OzHih14fzor2cNmVdBZukdBLS29Tv7prdvvqgfULL8VS46xWuibER8l7ygbUdif9jw4ST6XGvpldmRAYWJV5l7llW8UYanJn7y1aN4JBpTvxTNOU/NSqMGpSv3DKwpCvnqlzPLrT5KLOpbC4vJ/NTDBnlkNTAFe5eygo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760371862; c=relaxed/simple;
	bh=VdXZRhxyPNqklXw8S57HjBFocnWoik3i2xbrZAxPv4c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=InP79z+TX7cNyNUDRHtBDUdCDHAmbjRDftKUVRPYZtBGRT/UD3eJUu9NRV+zs00NUyjiBuRh8ECmJhT9JdNFyojkP42ktDEcnRGXZ42R6zsFOeH8EBZWCsovFbIq0rOEGlRgeeKRslV2gifSPWZTk61LxlRz84IQrL7EBsD1f+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SQW8rIgK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=32IgMTUy; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SQW8rIgK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=32IgMTUy; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DFEDE21AE2;
	Mon, 13 Oct 2025 16:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760371858; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GnEupam9INpXWFP2Yj6BA2KHXZeYd9+x7M1iMZGnvdE=;
	b=SQW8rIgKqwg3N1dnv+xrMwSmjukJEdsEA8xZcdYJEEnbc2+BAZeLA641lNnYcgt74QHUS1
	gEGcHKD9RBgq++bPG/UPY++uB2CLbXKATLnQhw5ssl/OGwSdNAfQRvFWhgAnpMM1ILqh1A
	W49uESUBcWBCJWrm4hq1t+rD36HpHBg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760371858;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GnEupam9INpXWFP2Yj6BA2KHXZeYd9+x7M1iMZGnvdE=;
	b=32IgMTUy3LgkT4pow+cyM14iDwbVbdYikBGcdpMsfAui9TL3eGU/ncGqr9p3LCnWpde5DP
	Y058ZL1sn1/3fLAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760371858; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GnEupam9INpXWFP2Yj6BA2KHXZeYd9+x7M1iMZGnvdE=;
	b=SQW8rIgKqwg3N1dnv+xrMwSmjukJEdsEA8xZcdYJEEnbc2+BAZeLA641lNnYcgt74QHUS1
	gEGcHKD9RBgq++bPG/UPY++uB2CLbXKATLnQhw5ssl/OGwSdNAfQRvFWhgAnpMM1ILqh1A
	W49uESUBcWBCJWrm4hq1t+rD36HpHBg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760371858;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GnEupam9INpXWFP2Yj6BA2KHXZeYd9+x7M1iMZGnvdE=;
	b=32IgMTUy3LgkT4pow+cyM14iDwbVbdYikBGcdpMsfAui9TL3eGU/ncGqr9p3LCnWpde5DP
	Y058ZL1sn1/3fLAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B85B313874;
	Mon, 13 Oct 2025 16:10:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aWO0K5Ik7WjYfgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 13 Oct 2025 16:10:58 +0000
Message-ID: <4565202b-cb53-4257-90c2-7570a5d4bcf7@suse.de>
Date: Mon, 13 Oct 2025 18:10:58 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI/VGA: Select SCREEN_INFO
To: "Mario Limonciello (AMD)" <superm1@kernel.org>,
 mario.limonciello@amd.com, bhelgaas@google.com
Cc: Eric Biggers <ebiggers@kernel.org>, linux-pci@vger.kernel.org
References: <20251013154441.1000875-1-superm1@kernel.org>
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
In-Reply-To: <20251013154441.1000875-1-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 

Hi

Am 13.10.25 um 17:44 schrieb Mario Limonciello (AMD):
> commit 337bf13aa9dda ("PCI/VGA: Replace vga_is_firmware_default() with
> a screen info check") introduced an implicit dependency upon SCREEN_INFO
> by removing the open coded implementation.
>
> If a user didn't have CONFIG_SCREEN_INFO set vga_is_firmware_default()
> would now return false.  Add a select for SCREEN_INFO to ensure that the
> VGA arbiter works as intended. Also drop the now dead code.
>
> Reported-by: Eric Biggers <ebiggers@kernel.org>
> Closes: https://lore.kernel.org/linux-pci/20251012182302.GA3412@sol/
> Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: 337bf13aa9dda ("PCI/VGA: Replace vga_is_firmware_default() with a screen info check")
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

I think we should take this patch in any case, even if it would not fix 
the reporter's problem.

Best regards
Thomas

> ---
> v2:
>   * drop dead code (Ilpo)
> ---
>   drivers/pci/Kconfig  | 1 +
>   drivers/pci/vgaarb.c | 8 +-------
>   2 files changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index 7065a8e5f9b14..c35fed47addd5 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -306,6 +306,7 @@ config VGA_ARB
>   	bool "VGA Arbitration" if EXPERT
>   	default y
>   	depends on (PCI && !S390)
> +	select SCREEN_INFO
>   	help
>   	  Some "legacy" VGA devices implemented on PCI typically have the same
>   	  hard-decoded addresses as they did on ISA. When multiple PCI devices
> diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
> index b58f94ee48916..8c8c420ff5b55 100644
> --- a/drivers/pci/vgaarb.c
> +++ b/drivers/pci/vgaarb.c
> @@ -556,13 +556,7 @@ EXPORT_SYMBOL(vga_put);
>   
>   static bool vga_is_firmware_default(struct pci_dev *pdev)
>   {
> -#ifdef CONFIG_SCREEN_INFO
> -	struct screen_info *si = &screen_info;
> -
> -	return pdev == screen_info_pci_dev(si);
> -#else
> -	return false;
> -#endif
> +	return pdev == screen_info_pci_dev(&screen_info);
>   }
>   
>   static bool vga_arb_integrated_gpu(struct device *dev)

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)



