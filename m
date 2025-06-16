Return-Path: <linux-pci+bounces-29835-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D990ADA93B
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 09:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CA2118932A0
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 07:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D062191F7E;
	Mon, 16 Jun 2025 07:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="iezvBOJe";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="b9eZR9cr";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="G4APABAP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="eLleJHuY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7901E1A17
	for <linux-pci@vger.kernel.org>; Mon, 16 Jun 2025 07:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750058488; cv=none; b=gXRYjMa9RfyjeoUGqN8dYpDzEojNO/GYm/ha91Nof7orF0GUqSaPemsMDMdVIr+vyN9o3vuiKno9YBB5VA7Dh/Ek5j+gz3YmFKIYpAHIxGhjNcCToO5DHuWuDF9V6BuYx6nfZTgU4l7u80cZ7ejfkEiHcRX2wAD/Tj9raM6ee/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750058488; c=relaxed/simple;
	bh=gopUaSb/zporLLFNJivhCIxVk7eExtBUqMa80lLw57w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pqSC9mhCEkEvqLKJWk8Gm6UxgUq6XatyiV5EMIfvF86jhBkNkW3bn3k+2TvinJV4BUVeDt38hv8eSPjkDjFoU82PWzat8J2rPAHk+aEJW+ozgecMznAixZxJH61We44c4szELXAlyK/qQLrqswR0EPnnUVpT0Hp1G2sJE3udWiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=iezvBOJe; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=b9eZR9cr; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=G4APABAP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=eLleJHuY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EBD76211F8;
	Mon, 16 Jun 2025 07:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1750058485; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=vGO8Mryx/3E7eCL1JMfrXQE6AFYS5wMzuzurEIEpy6U=;
	b=iezvBOJewHghqvXEjTAz5hiyHRH3yIfwXAzl1eT2uJtBNIsLrQfY6bTNXzP/w445bG2Znj
	riis4GL4j9tNDux8F9TO6BrAARNfcVaBq8Ag9cUTypJ5cV/YcBG9BKjT0Q/QhWxXX3EIV2
	JaLU0di131wFD/XPbbWbXKX8uoHsaUM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1750058485;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=vGO8Mryx/3E7eCL1JMfrXQE6AFYS5wMzuzurEIEpy6U=;
	b=b9eZR9crZINK45TBUhsY26q0kL7nLuhMN0pEBROhFHyfLBziQhMpLIwRLjVywcTh7K4l+G
	3mkS5YZd/Ailw1AA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=G4APABAP;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=eLleJHuY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1750058484; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=vGO8Mryx/3E7eCL1JMfrXQE6AFYS5wMzuzurEIEpy6U=;
	b=G4APABAPQf2vyGs4NEP26wbYtYwadJVS56IA+KoKLjbA6ukIG2//HdAVqpNlYyI9BFIFxo
	2baQAo03HZHgonLm/PDoP2dvxmXL7Ly/DP1OzQXGr/Qbxk9JgTPwxNWiqHuykMUV6vjqZ+
	D5pICyqwxhpnugmEzK8sIUkSZ0DYeBA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1750058484;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=vGO8Mryx/3E7eCL1JMfrXQE6AFYS5wMzuzurEIEpy6U=;
	b=eLleJHuYidexqJOtrDHO5IJxeDCE+aEGAPbs2e7pYmh9FBghISj1QJ/0j5MUg4KkkOVhwk
	dXrHx1XkrauueHCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AA4F013A6B;
	Mon, 16 Jun 2025 07:21:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MjNdKPTFT2icIgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 16 Jun 2025 07:21:24 +0000
Message-ID: <a5196c49-2c4c-40ab-950d-0180ebd983d4@suse.de>
Date: Mon, 16 Jun 2025 09:21:24 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/VGA: Look at all PCI display devices in VGA arbiter
To: David Airlie <airlied@redhat.com>
Cc: Mario Limonciello <superm1@kernel.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Bjorn Helgaas <helgaas@kernel.org>, mario.limonciello@amd.com,
 bhelgaas@google.com, linux-pci@vger.kernel.org,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20250613190718.GA968774@bhelgaas>
 <3a0a7aeb-436d-442a-bede-9e760a69fa47@kernel.org>
 <20250613151929.3c944c3c.alex.williamson@redhat.com>
 <7d491f5f-5af6-47ce-9950-975e33f706bb@kernel.org>
 <bc0a3ac2-c86c-43b8-b83f-edfdfa5ee184@suse.de>
 <CAMwc25oTD8+75NB1mo_93-14U_ZsEEMoUaKZLpu-MBszusFRBw@mail.gmail.com>
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
In-Reply-To: <CAMwc25oTD8+75NB1mo_93-14U_ZsEEMoUaKZLpu-MBszusFRBw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,bootlin.com:url];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: EBD76211F8
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -4.51

Hi

Am 16.06.25 um 08:50 schrieb David Airlie:
[...]
>>>>
>>>> It's also a bit concerning that we're making a policy decision here
>>>> that the integrated graphics is the "boot VGA" device, among two
>>>> non-VGA devices.  I think vgaarb has a similar legacy policy decision
>>>> for VGA devices that it's stuck with, but it's not clear to me that
>>>> reiterating the policy selection here is still correct.  Thanks,
>>>>
>>>> Alex
>>> I'm with you there. That's actually exactly why the first swing at
>>> this was with a patch to userspace.
>>>
>>> https://gitlab.freedesktop.org/xorg/lib/libpciaccess/-/merge_requests/37
>> I second Alex' point. I acked the patch purely on my understanding of
>> how it does this, but as I noted, I'd also prefer to solve this in user
>> space. I think we should push back on this change.
>>
> If we are solving this in userspace I think fixing it in libpciaccess
> is probably also the wrong place, which leaves open where is the right
> place?

Why is libpciaccess the wrong place? I see that the boot display is not 
necessarily on the PCI bus. But if its not handled in libpciaccess, 
should it rather go into Xorg directly?


>
> To be honest the what GPU is driving the display at boot hint should
> come from the kernel, since it knows already, whether boot_vga is the
> best method of doing that is open to questions.

The proposed user-space patch looks way less intrusive than the kernel 
change.

>
> It might be better to have a bit somewhere on the drm device that shows this.
>
> hello new UAPI.

In the kernel, there's already video_is_primary_device. [1] On x86, it 
looks at vga_default_device(), on other architectures, it looks at 
firmware settings. If there's no default vga on x86, it could do more 
heuristics to figure out the boot display. The result can be exported by 
a boot_display file via sysfs. video_is_primary_device() is currently 
used by fbcon. Any changes to the helper would likely benefit fbcon as well.

Best regards
Thomas

[1] 
https://elixir.bootlin.com/linux/v6.15.2/source/include/asm-generic/video.h#L28

>
> Dave.
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)


