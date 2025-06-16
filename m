Return-Path: <linux-pci+bounces-29832-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7D3ADA869
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 08:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F78C7A14EC
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 06:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529E61DE4F6;
	Mon, 16 Jun 2025 06:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Gded2MsN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Pp+RyZpg";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HecGGd6j";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rTLaUB5D"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E471118A6C4
	for <linux-pci@vger.kernel.org>; Mon, 16 Jun 2025 06:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750056129; cv=none; b=JgTKiUNE0CFWyZYAAAUhTnJdVb3GzjIgFfzlhLftowZygkHsLrH8F6PRobdbu7tX7dKPlM8C3dqA5aPvPxxTV16ad0cXDhEMZFb7cIzlUWbLH1jR/il0CGMnseIhohL5yGl4AoYv6bRokZovwAY/ZrzIi5hhf7DSZ6sMboCOpWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750056129; c=relaxed/simple;
	bh=qT1nZe8cpMuvanZ4hX0CFWQsqlQK5yPR8ReP8nF/xGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pZc3ws0LozIdU5ZrVitA2cFjgBG8n2KNkBM1Naco2A1VlpjTJZSIoIcTabINrxsxwuXKw1mBsS9W+5mpzLAkeO2m1ohbtgvWSR16XwklzmphY/D98YS5Ig0r+tQjAhc767KCsFRsKV/MZXG3Owz12dwM3Y2jWdUfaDMtswogBDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Gded2MsN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Pp+RyZpg; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HecGGd6j; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rTLaUB5D; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E68C3211B1;
	Mon, 16 Jun 2025 06:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1750056124; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=d9Q1mpocIGDZGUNSvJRorR4bbiJ+7Fu5sc0h2h1cooY=;
	b=Gded2MsNy+8RkZby8N81aZqNSHBsmiAgFqhsJz/V0MRRRHJVIePBbB6jtGCQWecoH2TxiE
	XEs9/kQj6xgaZJv+rwc/D6vJbqM01tMBJQpEPcyPvETzuhhSCeKRLur8F8jmJkW33NWXnR
	7eb9Z78mHQ1zlGPAnwPriORTJ/TpzCc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1750056124;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=d9Q1mpocIGDZGUNSvJRorR4bbiJ+7Fu5sc0h2h1cooY=;
	b=Pp+RyZpgfyLiLkmAVUZAfC/5ntxakZzVaZx9H/5xwsO44TuTwnb0wFUdB2x5q3bZS/JhBC
	ASQ80EoJIj9Cp2Aw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=HecGGd6j;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=rTLaUB5D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1750056123; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=d9Q1mpocIGDZGUNSvJRorR4bbiJ+7Fu5sc0h2h1cooY=;
	b=HecGGd6jFRJjhK5TpRkfe5I9aYK++kvjOgEaGODsWylUPYcCjvQ/42xllA9KX4ysi48hpO
	3yPF2FAkmB/y5LvkYidOibiv0hRQGfA9ZFakBfIVUdjhW6qUIladaTwW4gZnpXv5n5sCkD
	rPUC3d8jNXauoekv8e0Yo4hW5DVC4T4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1750056123;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=d9Q1mpocIGDZGUNSvJRorR4bbiJ+7Fu5sc0h2h1cooY=;
	b=rTLaUB5DPN9prKUZjgCYM47/oNAWr25PB1HPDbZ8ErYiWLttZuI2oX5gK+Ruc3IWiyqfl2
	dNG7AnBaWKqqdyBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A04EC139E2;
	Mon, 16 Jun 2025 06:42:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zhe5Jbu8T2gIFwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 16 Jun 2025 06:42:03 +0000
Message-ID: <bc0a3ac2-c86c-43b8-b83f-edfdfa5ee184@suse.de>
Date: Mon, 16 Jun 2025 08:42:03 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/VGA: Look at all PCI display devices in VGA arbiter
To: Mario Limonciello <superm1@kernel.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Dave Airlie <airlied@redhat.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, mario.limonciello@amd.com,
 bhelgaas@google.com, linux-pci@vger.kernel.org,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20250613190718.GA968774@bhelgaas>
 <3a0a7aeb-436d-442a-bede-9e760a69fa47@kernel.org>
 <20250613151929.3c944c3c.alex.williamson@redhat.com>
 <7d491f5f-5af6-47ce-9950-975e33f706bb@kernel.org>
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
In-Reply-To: <7d491f5f-5af6-47ce-9950-975e33f706bb@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MID_RHS_MATCH_FROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: E68C3211B1
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -4.51

Hi

Am 13.06.25 um 23:29 schrieb Mario Limonciello:
> On 6/13/2025 4:19 PM, Alex Williamson wrote:
>> On Fri, 13 Jun 2025 14:31:10 -0500
>> Mario Limonciello <superm1@kernel.org> wrote:
>>
>>> On 6/13/2025 2:07 PM, Bjorn Helgaas wrote:
>>>> On Thu, Jun 12, 2025 at 10:12:14PM -0500, Mario Limonciello wrote:
>>>>> From: Mario Limonciello <mario.limonciello@amd.com>
>>>>>
>>>>> On an A+N mobile system the APU is not being selected by some desktop
>>>>> environments for any rendering tasks. This is because the neither GPU
>>>>> is being treated as "boot_vga" but that is what some environments use
>>>>> to select a GPU [1].
>>>>
>>>> What is "A+N" and "APU"?
>>>
>>> A+N is meant to refer to an AMD APU + NVIDIA dGPU.
>>> APU is an SoC that contains a lot more IP than just x86 cores.  In this
>>> context it contains both integrated graphics and display IP.
>>>
>>>>
>>>> I didn't quite follow the second sentence.  I guess you're saying some
>>>> userspace environments use the "boot_vga" sysfs file to select a GPU?
>>>> And on this A+N system, neither device has the file?
>>>
>>> Yeah.  Specifically this problem happens in Xorg that the library it
>>> uses (libpciaccess) looks for a boot_vga file.  That file isn't 
>>> found on
>>> either GPU and so Xorg picks the first GPU it finds in the PCI 
>>> heirarchy
>>> which happens to be the NVIDIA GPU.
>>>
>>>>> The VGA arbiter driver only looks at devices that report as PCI 
>>>>> display
>>>>> VGA class devices. Neither GPU on the system is a display VGA class
>>>>> device:
>>>>>
>>>>> c5:00.0 3D controller: NVIDIA Corporation Device 2db9 (rev a1)
>>>>> c6:00.0 Display controller: Advanced Micro Devices, Inc. [AMD/ATI] 
>>>>> Device 150e (rev d1)
>>>>>
>>>>> So neither device gets the boot_vga sysfs file. The 
>>>>> vga_is_boot_device()
>>>>> function already has some handling for integrated GPUs by looking 
>>>>> at the
>>>>> ACPI HID entries, so if all PCI display class devices are looked 
>>>>> at it
>>>>> actually can detect properly with this device ordering. However if 
>>>>> there
>>>>> is a different ordering it could flag the wrong device.
>>>>>
>>>>> Modify the VGA arbiter code and matching sysfs file entries to 
>>>>> examine all
>>>>> PCI display class devices. After every device is added to the 
>>>>> arbiter list
>>>>> make a pass on all devices and explicitly check whether one is 
>>>>> integrated.
>>>>>
>>>>> This will cause all GPUs to gain a `boot_vga` file, but the 
>>>>> correct device
>>>>> (APU in this case) will now show `1` and the incorrect device 
>>>>> shows `0`.
>>>>> Userspace then picks the right device as well.
>>>>
>>>> What determines whether the APU is the "correct" device?
>>>
>>> In this context is the one that is physically connected to the eDP
>>> panel.  When the "wrong" one is selected then it is used for rendering.
>>>
>>> Without this patch the net outcome ends up being that the APU display
>>> hardware drives the eDP but the desktop is rendered using the N dGPU.
>>> There is a lot of latency in doing it this way, and worse off the N 
>>> dGPU
>>> stays powered on at all times.  It never enters into runtime PM.
>>>
>>>>> Link: 
>>>>> https://github.com/robherring/libpciaccess/commit/b2838fb61c3542f107014b285cbda097acae1e12 
>>>>> [1]
>>>>> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
>>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>>> ---
>>>>> RFC->v1:
>>>>>    * Add tag
>>>>>    * Drop unintended whitespace change
>>>>>    * Use vgaarb_dbg instead of vgaarb_info
>>>>> ---
>>>>>    drivers/pci/pci-sysfs.c |  2 +-
>>>>>    drivers/pci/vgaarb.c    | 48 
>>>>> +++++++++++++++++++++++++++--------------
>>>>>    include/linux/pci.h     | 15 +++++++++++++
>>>>>    3 files changed, 48 insertions(+), 17 deletions(-)
>>>>>
>>>>> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
>>>>> index 268c69daa4d57..c314ee1b3f9ac 100644
>>>>> --- a/drivers/pci/pci-sysfs.c
>>>>> +++ b/drivers/pci/pci-sysfs.c
>>>>> @@ -1707,7 +1707,7 @@ static umode_t 
>>>>> pci_dev_attrs_are_visible(struct kobject *kobj,
>>>>>        struct device *dev = kobj_to_dev(kobj);
>>>>>        struct pci_dev *pdev = to_pci_dev(dev);
>>>>>    -    if (a == &dev_attr_boot_vga.attr && pci_is_vga(pdev))
>>>>> +    if (a == &dev_attr_boot_vga.attr && pci_is_display(pdev))
>>>>>            return a->mode;
>>>>>           return 0;
>>>>> diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
>>>>> index 78748e8d2dbae..0eb1274d52169 100644
>>>>> --- a/drivers/pci/vgaarb.c
>>>>> +++ b/drivers/pci/vgaarb.c
>>>>> @@ -140,6 +140,7 @@ void vga_set_default_device(struct pci_dev *pdev)
>>>>>        if (vga_default == pdev)
>>>>>            return;
>>>>>    +    vgaarb_dbg(&pdev->dev, "selecting as VGA boot device\n");
>>>>
>>>> I guess this is essentially a move of the vgaarb_info() message from
>>>> vga_arbiter_add_pci_device() to here?  If so, I think I would preserve
>>>> the _info() level.  Including non-VGA devices is fairly subtle and I
>>>> don't think we need to discard potentially useful information about
>>>> what we're doing.
>>>
>>> Thanks - that was my original RFC before I sent this as PATCH but 
>>> Thomas
>>> had suggested to decrease to debug.  I'll restore in the next spin.
>>>
>>>>>        pci_dev_put(vga_default);
>>>>>        vga_default = pci_dev_get(pdev);
>>>>>    }
>>>>> @@ -751,6 +752,31 @@ static void 
>>>>> vga_arbiter_check_bridge_sharing(struct vga_device *vgadev)
>>>>>            vgaarb_info(&vgadev->pdev->dev, "no bridge control 
>>>>> possible\n");
>>>>>    }
>>>>>    +static
>>>>> +void vga_arbiter_select_default_device(void)
>>>>
>>>> Signature on one line.
>>>
>>> Ack
>>>
>>>>> +{
>>>>> +    struct pci_dev *candidate = vga_default_device();
>>>>> +    struct vga_device *vgadev;
>>>>> +
>>>>> +    list_for_each_entry(vgadev, &vga_list, list) {
>>>>> +        if (vga_is_boot_device(vgadev)) {
>>>>> +            /* check if one is an integrated GPU, use that if so */
>>>>> +            if (candidate) {
>>>>> +                if (vga_arb_integrated_gpu(&candidate->dev))
>>>>> +                    break;
>>>>> +                if (vga_arb_integrated_gpu(&vgadev->pdev->dev)) {
>>>>> +                    candidate = vgadev->pdev;
>>>>> +                    break;
>>>>> +                }
>>>>> +            } else
>>>>> +                candidate = vgadev->pdev;
>>>>> +        }
>>>>> +    }
>>>>> +
>>>>> +    if (candidate)
>>>>> +        vga_set_default_device(candidate);
>>>>> +}
>>>>
>>>> It looks like this is related to the integrated GPU code in
>>>> vga_is_boot_device().  Can this be done by updating the logic there,
>>>> so it's more clear what change this patch makes?
>>>>
>>>> It seems like this patch would change the selection in a way that
>>>> makes some of the vga_is_boot_device() comments obsolete. E.g., "We
>>>> select the default VGA device in this order"?  Or "we use the *last*
>>>> [integrated GPU] because that was the previous behavior"?
>>>>
>>>> The end of vga_is_boot_device() mentions non-legacy (non-VGA) devices,
>>>> but I don't remember now how we ever got there because
>>>> vga_arb_device_init() and pci_notify() only call
>>>> vga_arbiter_add_pci_device() for VGA devices.
>>>
>>> Sure I'll review the comments and update.  As for moving the logic I
>>> didn't see an obvious way to do this.  This code is "tie-breaker" code
>>> in the case that two GPUs are otherwise ranked equally.
>>>
>>>>>    /*
>>>>>     * Currently, we assume that the "initial" setup of the system 
>>>>> is not sane,
>>>>>     * that is, we come up with conflicting devices and let the 
>>>>> arbiter's
>>>>> @@ -816,23 +842,17 @@ static bool 
>>>>> vga_arbiter_add_pci_device(struct pci_dev *pdev)
>>>>>            bus = bus->parent;
>>>>>        }
>>>>>    -    if (vga_is_boot_device(vgadev)) {
>>>>> -        vgaarb_info(&pdev->dev, "setting as boot VGA device%s\n",
>>>>> -                vga_default_device() ?
>>>>> -                " (overriding previous)" : "");
>>>>> -        vga_set_default_device(pdev);
>>>>> -    }
>>>>> -
>>>>>        vga_arbiter_check_bridge_sharing(vgadev);
>>>>>           /* Add to the list */
>>>>>        list_add_tail(&vgadev->list, &vga_list);
>>>>>        vga_count++;
>>>>> -    vgaarb_info(&pdev->dev, "VGA device added: 
>>>>> decodes=%s,owns=%s,locks=%s\n",
>>>>> +    vgaarb_dbg(&pdev->dev, "VGA device added: 
>>>>> decodes=%s,owns=%s,locks=%s\n",
>>>>
>>>> Looks like an unrelated change.
>>>
>>> Yeah it was going with the theme from Thomas' comment to decrease to
>>> debug.  I'll put it back to info.
>>>
>>>>> vga_iostate_to_str(vgadev->decodes),
>>>>>            vga_iostate_to_str(vgadev->owns),
>>>>>            vga_iostate_to_str(vgadev->locks));
>>>>>    +    vga_arbiter_select_default_device();
>>>>>        spin_unlock_irqrestore(&vga_lock, flags);
>>>>>        return true;
>>>>>    fail:
>>>>> @@ -1499,8 +1519,8 @@ static int pci_notify(struct notifier_block 
>>>>> *nb, unsigned long action,
>>>>>           vgaarb_dbg(dev, "%s\n", __func__);
>>>>>    -    /* Only deal with VGA class devices */
>>>>> -    if (!pci_is_vga(pdev))
>>>>> +    /* Only deal with display devices */
>>>>> +    if (!pci_is_display(pdev))
>>>>>            return 0;
>>>>
>>>> Are there any other pci_is_vga() users that might want
>>>> pci_is_display() instead?  virtio_gpu_pci_quirk()?
>>>
>>> +AlexW for comments on potential virtio changes here.
>>
>> I can't comment on virtio_gpu, Cc +Gerd for that.
>>
>> I do however take issue with the premise of this patch.  The VGA
>> arbiter is for adjusting VGA routing.  If neither device is VGA, why
>> are they registering with the VGA arbiter and what sense does it make
>> to create a boot_vga sysfs attribute of a non-VGA device?
>>
>> It seems like we're trying to adapt the kernel to create a facade for
>> userspace when userspace should be falling back to some other means of
>> determining a primary graphical device.  For instance, is there
>> something in UEFI that could indicate the console?  ACPI?  DT?
>>
>> It's also a bit concerning that we're making a policy decision here
>> that the integrated graphics is the "boot VGA" device, among two
>> non-VGA devices.  I think vgaarb has a similar legacy policy decision
>> for VGA devices that it's stuck with, but it's not clear to me that
>> reiterating the policy selection here is still correct.  Thanks,
>>
>> Alex
>
> I'm with you there. That's actually exactly why the first swing at 
> this was with a patch to userspace.
>
> https://gitlab.freedesktop.org/xorg/lib/libpciaccess/-/merge_requests/37

I second Alex' point. I acked the patch purely on my understanding of 
how it does this, but as I noted, I'd also prefer to solve this in user 
space. I think we should push back on this change.

Best regards
Thomas

>
>>
>>>
>>> If there are sensible changes they should be another patch, and also
>>> I'll split the creation of pci_is_display() helper to it's own patch.
>>>>>        /*
>>>>> @@ -1548,12 +1568,8 @@ static int __init vga_arb_device_init(void)
>>>>>           /* Add all VGA class PCI devices by default */
>>>>>        pdev = NULL;
>>>>> -    while ((pdev =
>>>>> -        pci_get_subsys(PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
>>>>> -                   PCI_ANY_ID, pdev)) != NULL) {
>>>>> -        if (pci_is_vga(pdev))
>>>>> -            vga_arbiter_add_pci_device(pdev);
>>>>> -    }
>>>>> +    while ((pdev = pci_get_base_class(PCI_BASE_CLASS_DISPLAY, 
>>>>> pdev)))
>>>>> +        vga_arbiter_add_pci_device(pdev);
>>>>
>>>> I guess pci_get_base_class(PCI_BASE_CLASS_DISPLAY) is sort of a source
>>>> code optimization and this one-line change would be equivalent?
>>>>
>>>>     -        if (pci_is_vga(pdev))
>>>>     +        if (pci_is_display(pdev))
>>>>                 vga_arbiter_add_pci_device(pdev);
>>>>
>>>> If so, I think I prefer the one-liner because then everything in this
>>>> file would use pci_is_display() and we wouldn't have to figure out the
>>>> equivalent-ness of pci_get_base_class(PCI_BASE_CLASS_DISPLAY).
>>>
>>> pci_get_base_class() is a search function.  It only really makese sense
>>> for iterating.
>>>
>>>
>>>>>        pr_info("loaded\n");
>>>>>        return rc;
>>>>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>>>>> index 05e68f35f3923..e77754e43c629 100644
>>>>> --- a/include/linux/pci.h
>>>>> +++ b/include/linux/pci.h
>>>>> @@ -744,6 +744,21 @@ static inline bool pci_is_vga(struct pci_dev 
>>>>> *pdev)
>>>>>        return false;
>>>>>    }
>>>>>    +/**
>>>>> + * pci_is_display - Check if a PCI device is a display controller
>>>>> + * @pdev: Pointer to the PCI device structure
>>>>> + *
>>>>> + * This function determines whether the given PCI device corresponds
>>>>> + * to a display controller. Display controllers are typically used
>>>>> + * for graphical output and are identified based on their class 
>>>>> code.
>>>>> + *
>>>>> + * Return: true if the PCI device is a display controller, false 
>>>>> otherwise.
>>>>> + */
>>>>> +static inline bool pci_is_display(struct pci_dev *pdev)
>>>>> +{
>>>>> +    return (pdev->class >> 16) == PCI_BASE_CLASS_DISPLAY;
>>>>> +}
>>>>
>>>> Could use in vga_switcheroo_client_probe_defer(), IS_GFX_DEVICE(),
>>>> vfio_pci_is_intel_display(), i915_gfx_present(), get_bound_vga().
>>>> Arguable whether it's worth changing them, but I guess it's nice to
>>>> test for the same thing the same way.
>>>>
>>>> Bjorn
>>>
>>> Sure - this makes a stronger argument to add pci_is_display helper in
>>> it's own patch instead of with this one.  I'll intend to have the first
>>> patch introduce the helper and replace all existing users with it.
>>>
>>
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)


