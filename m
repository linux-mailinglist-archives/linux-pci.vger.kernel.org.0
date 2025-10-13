Return-Path: <linux-pci+bounces-37869-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5E2BD1BB5
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 09:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9415E4E251F
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 07:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05E927A122;
	Mon, 13 Oct 2025 07:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="studDxyd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0r1yXJUS";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="studDxyd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0r1yXJUS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39032820B7
	for <linux-pci@vger.kernel.org>; Mon, 13 Oct 2025 07:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760339071; cv=none; b=UMpnYlmX/9ofhN+bX65B214/V0uCNn26CW9ezL4eNxCXbIaP5mKDgm/sVIYIqtTl/ohN79f86AN4CebPIOS0hVPSsPkxM/GvkTKILSK6ecS/GTG7o0vUrEW/eoDZI/9s12MUrXKHh2xZlZQkW//hkRshCTJlKpeeSLXZfPQXX3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760339071; c=relaxed/simple;
	bh=CT50q/G0l7JjhbZDkqiQz7BdoRNvFQ+kPqxXBIhUYOE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VdlOWSpZBcHgPxsCTgIEXFOULMBLwhM4HfHJ1eYDKhYrg2lDSZvFbGpzC0MgEhgNXOFCE9X8l0L6KVs/xNmBPAIliVP7hxgXpCSsL8u+FopTymrFDo8C35/yTRx5Q4Huo4r84UA3NgXd2On+zCOTEGcZYCWWfpluBALaIUwjg2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=studDxyd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0r1yXJUS; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=studDxyd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0r1yXJUS; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0A84F2116F;
	Mon, 13 Oct 2025 07:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760339068; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=O4jZ++cJ1+/PzTBjlc4vZFMri/kbLBIYc/FVqcnbnfI=;
	b=studDxydwrQPLi4RJhTe3qzf8yvsjamS4rYLdNFBCQ/o7aoeW13iBwoD5vfNSE8qUoM6va
	tCEqc6Mkx7r64bDSfzr+h/VMvg6Q/HebUuptd25uHS9uIgl9qGryuSi2tdKk1+49Cy185C
	lMm6Y/MYznA5x9lWqxh1ZfAezJG6CY8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760339068;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=O4jZ++cJ1+/PzTBjlc4vZFMri/kbLBIYc/FVqcnbnfI=;
	b=0r1yXJUSH/Lladk2s8BapKk11UXbZC8UHFSu4RO0CLFb6vfX1G5d20l04e7xleP3dZVkt1
	OByfTvnI9cIkORBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=studDxyd;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=0r1yXJUS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760339068; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=O4jZ++cJ1+/PzTBjlc4vZFMri/kbLBIYc/FVqcnbnfI=;
	b=studDxydwrQPLi4RJhTe3qzf8yvsjamS4rYLdNFBCQ/o7aoeW13iBwoD5vfNSE8qUoM6va
	tCEqc6Mkx7r64bDSfzr+h/VMvg6Q/HebUuptd25uHS9uIgl9qGryuSi2tdKk1+49Cy185C
	lMm6Y/MYznA5x9lWqxh1ZfAezJG6CY8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760339068;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=O4jZ++cJ1+/PzTBjlc4vZFMri/kbLBIYc/FVqcnbnfI=;
	b=0r1yXJUSH/Lladk2s8BapKk11UXbZC8UHFSu4RO0CLFb6vfX1G5d20l04e7xleP3dZVkt1
	OByfTvnI9cIkORBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A67A11374A;
	Mon, 13 Oct 2025 07:04:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZDZxJ3uk7GjyWAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 13 Oct 2025 07:04:27 +0000
Message-ID: <cf787bfa-2bf1-44bc-be46-fa4115319bd0@suse.de>
Date: Mon, 13 Oct 2025 09:04:27 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 2/4] PCI/VGA: Replace vga_is_firmware_default() with a
 screen info check
To: Mario Limonciello <superm1@kernel.org>, Eric Biggers <ebiggers@kernel.org>
Cc: David Airlie <airlied@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
 Daniel Dadap <ddadap@nvidia.com>
References: <20250811162606.587759-1-superm1@kernel.org>
 <20250811162606.587759-3-superm1@kernel.org> <20251012182302.GA3412@sol>
 <1be1a119-1fbd-435f-bb27-70f48d677ebf@kernel.org> <20251012184717.GB3412@sol>
 <65c24236-044c-4b65-baaa-dc0011ea69d8@kernel.org>
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
In-Reply-To: <65c24236-044c-4b65-baaa-dc0011ea69d8@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0A84F2116F
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,google.com,amd.com,ffwll.ch,linux.intel.com,kernel.org,lists.freedesktop.org,vger.kernel.org,nvidia.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 

Hi Mario,

thanks for handling this report quickly.

Am 12.10.25 um 21:06 schrieb Mario Limonciello:
[...]
>> I don't have CONFIG_SCREEN_INFO enabled, so the commit changed
>> vga_is_firmware_default() to always return false.
>
> Thanks, that definitely explains it.
>
>>
>> If DRM_AMDGPU depends on SCREEN_INFO now, it needs to select it.
>>
>> - Eric
>
> Well the question now is which driver should actually select it.
>
> Although it manifested for you in amdgpu, I don't think this is going 
> to be an amdgpu unique issue.
>
> Maybe this:
>
> diff --git a/drivers/video/fbdev/core/Kconfig 
> b/drivers/video/fbdev/core/Kconfig
> index 006638eefa41..ce2544924b0e 100644
> --- a/drivers/video/fbdev/core/Kconfig
> +++ b/drivers/video/fbdev/core/Kconfig
> @@ -5,6 +5,7 @@
>
>  config FB_CORE
>         select VIDEO
> +       select SCREEN_INFO

Let's select it from CONFIG_VGA_ARB. This will restore the old behavior 
for x86. The else branch for CONFIG_SCREEN_INFO can then go away.

Best regards
Thomas

> tristate
>
>  config FB_NOTIFY

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)



