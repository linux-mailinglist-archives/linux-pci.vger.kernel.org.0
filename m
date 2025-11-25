Return-Path: <linux-pci+bounces-42074-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D39DFC86B32
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 19:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7B5024E1AAF
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 18:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707F2329386;
	Tue, 25 Nov 2025 18:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kx+xakpI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D031E5B7A
	for <linux-pci@vger.kernel.org>; Tue, 25 Nov 2025 18:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764096549; cv=none; b=A1HOfP+i+1E9U4awAYCytnwugtffyH1/3OJDKjaS8EWav6WSDFG0CPjdAmjf6yn3/x+wYc3L72maMSGViKWfnwkkL/ZEXlRAZ3vxecjXdkR5fXCGoNW/eM/MB7qZtPqRnxHhTkxT78r5Qunh4hM3cosafB5AA4AHP9bc8GF11WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764096549; c=relaxed/simple;
	bh=RZerNYDvz/Mehn/xJImaNe7+7gLzS+DuxfjigABdHyE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pH++WAHEpBWBUpaz8IoBLnPyOw2yIraCw80J2QSBcqRWPoM587xwCy64nCGiGTVEBEi0+drxFSnum4Y62xyOcsiyFgyxOxSiDmQyz7eKmDjhYL/aLB0AqMS67FkjQwZS3A6Y7GFtTySkkO8iYo9W4GyqPS0o6JHegNFyqzMtEWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kx+xakpI; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-29586626fbeso72757095ad.0
        for <linux-pci@vger.kernel.org>; Tue, 25 Nov 2025 10:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764096547; x=1764701347; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=B180bsfAm0KCHOEdxqYKNTx6S5+8jqZpdMY4dqqo0Uc=;
        b=kx+xakpIT5+EI3NY65P3X36YrONEgXLurU/Xvx9XnAGJv48P5gi9/BIc8Hhn16RiKC
         Q1XUP/WTF1efITN1/KtvnluPU08H7RNyLwFS3faP4FiS9ijrqO/3bn7MEDudIVMp+053
         y/hiJ59JMKVEKzCugPaUR4PZu2bX60Y5tJ2rMQ5Cx/wwNjPMO1MRCnjzQNbIR7MIboRY
         CpGLubEbSdFAl9BSbe9XqsQyweZqh2m8ZsToDHhbGa6zWVzhpSj7pg05OYfLnmwE+psc
         RC1AwneqG2557Xm6qOj1wtxwqqxquIWMc6qOm6mHz7PnbClIAt6agQ/2ZFOqETJBjM+q
         i4HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764096547; x=1764701347;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B180bsfAm0KCHOEdxqYKNTx6S5+8jqZpdMY4dqqo0Uc=;
        b=NxbinPZjJj8cH3pZ1xbBZHMzcysMwkxiNJQ70H5igkC/y8I0LZZnFRPYGQCMbOxewj
         UESAmsNnql+/ASqzcHj1HTh/WVXRCmxhuDqX0HzbkQ/FKUskLLvp+3N7jBzeo23FFqCU
         0qCo1GLEQSf35Hv2sSFrPTCcKiOtQf4U3da2FEkhD7NH86YGpconBUsQi/XktYHzfbej
         MCZvhWxf+0KbECTVYg7vTIHhhii9RZuYdZGeUVuuZwcNPxF7t5t1hteLsO0bzBl/nMMQ
         fDwQAleNzcLdUujxrYTnhZWfnaSHP4MEUJL/Y4n3PPM3dcrAYZz0wlBWAay0Rt6q9VqX
         FpiA==
X-Forwarded-Encrypted: i=1; AJvYcCVHtoqVOo9z19C7I3lIgJGDZiMNfenu7n3RQvBEwt4lWzOFgkki52YzsiltQ9dDp0g5VfSyL7qkBuU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5wDCoJ1grbtXs8J2r6FDI8YeWhLw/nSTvsu1BYNFjQqw1dx9X
	TY84jQ/FtbMTaAbLY46XmsI/l1CQLjvjzisJ9YiPAawJgX6C7rlOc7Rc
X-Gm-Gg: ASbGncs50td8aq8CgcrDvwUe4zu9X6mpSyWsqs/7HwSuNQ4DnG8N6/PAqkowiTZfDF9
	RQwit4JSqq1qYOr1u63dvKP8gUaQhLzRKZ1+0Iwm1Z1qf7ocg7ZzQsI1m0KGVhVeex63zlYhBh6
	pNecQYHH1Bfh5lPCj8br15BmYKC5YZcJClgRNKEi5f32bW+CETvubT7KH5MyaoMigrKIJrOGQ/p
	7p9hwEAb+nVKumdQHUHytyWHUoHlfbOrf+C1W8+eyiH5lXtn1re+Tx1LDHF2v0/FbJgvHZVZcGM
	UMc5JKyCqSjVon1sS1MySB/F2BIRcQmVOShCqbG1+bfFusD/XNPT13qYOL9Kzp6xTUu9ROOjzDs
	nWcJKL3VTvEXVH05uRlrOiXiQAjzpVs1AspK5Zh+8RujbHG6gcRYzEWuGtp/3jzoi75Q4iq9GU8
	ZGX5qib9VEtnyw8Im20EoR0XIeyMwrceCB6Ofr1mm2iXJchF12kR9Zp+9vJMbvfruDbDj2UQ==
X-Google-Smtp-Source: AGHT+IEHwXTrThqGk3VyGl80wkEw3hS0XTPFJR89BJSGGZ22O9IDSsq3WzbZDrhlts4nyHjl7Newiw==
X-Received: by 2002:a17:903:1ae6:b0:297:c71d:851c with SMTP id d9443c01a7336-29b6bf3bd5dmr169811045ad.36.1764096546551;
        Tue, 25 Nov 2025 10:49:06 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bd7604de9f8sm16865768a12.19.2025.11.25.10.49.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Nov 2025 10:49:05 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <52bb4a29-4bd9-443f-a16a-c58db31562e2@roeck-us.net>
Date: Tue, 25 Nov 2025 10:49:03 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 02/13] PCI: Add devres helpers for iomap table
 [resulting in backtraces on HPPA]
To: Philipp Stanner <pstanner@redhat.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Bjorn Helgaas <bhelgaas@google.com>, Sam Ravnborg <sam@ravnborg.org>,
 dakr@redhat.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-parisc@vger.kernel.org, Helge Deller <deller@gmx.de>
References: <20240613115032.29098-1-pstanner@redhat.com>
 <20240613115032.29098-3-pstanner@redhat.com>
 <16cd212f-6ea0-471d-bf32-34f55d7292fe@roeck-us.net>
 <414bc2c721bfc60b8b8a1b7d069ff0fc9b3e5283.camel@redhat.com>
 <6c749a78-2c98-45a8-b9d4-47f79b56c918@roeck-us.net>
 <6e43c821658de1f388de99aac9cbbbbfdccb7ffd.camel@redhat.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <6e43c821658de1f388de99aac9cbbbbfdccb7ffd.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/25/25 08:28, Philipp Stanner wrote:
> On Tue, 2025-11-25 at 08:12 -0800, Guenter Roeck wrote:
>> On 11/25/25 07:48, Philipp Stanner wrote:
>>> On Sun, 2025-11-23 at 08:42 -0800, Guenter Roeck wrote:
>>>> Hi,
>>>>
>>>> On Thu, Jun 13, 2024 at 01:50:15PM +0200, Philipp Stanner wrote:
>>>>> The pcim_iomap_devres.table administrated by pcim_iomap_table() has its
>>>>> entries set and unset at several places throughout devres.c using manual
>>>>> iterations which are effectively code duplications.
>>>>>
>>>>> Add pcim_add_mapping_to_legacy_table() and
>>>>> pcim_remove_mapping_from_legacy_table() helper functions and use them where
>>>>> possible.
>>>>>
>>>>> Link: https://lore.kernel.org/r/20240605081605.18769-4-pstanner@redhat.com
>>>>> Signed-off-by: Philipp Stanner <pstanner@redhat.com>
>>>>> [bhelgaas: s/short bar/int bar/ for consistency]
>>>>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>>>>> ---
>>>>>    drivers/pci/devres.c | 77 +++++++++++++++++++++++++++++++++-----------
>>>>>    1 file changed, 58 insertions(+), 19 deletions(-)
>>>>>
>>>>> diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
>>>>> index f13edd4a3873..845d6fab0ce7 100644
>>>>> --- a/drivers/pci/devres.c
>>>>> +++ b/drivers/pci/devres.c
>>>>> @@ -297,6 +297,52 @@ void __iomem * const *pcim_iomap_table(struct pci_dev *pdev)
>>>>>    }
>>>>>    EXPORT_SYMBOL(pcim_iomap_table);
>>>>>    
>>>>> +/*
>>>>> + * Fill the legacy mapping-table, so that drivers using the old API can
>>>>> + * still get a BAR's mapping address through pcim_iomap_table().
>>>>> + */
>>>>> +static int pcim_add_mapping_to_legacy_table(struct pci_dev *pdev,
>>>>> +					    void __iomem *mapping, int bar)
>>>>> +{
>>>>> +	void __iomem **legacy_iomap_table;
>>>>> +
>>>>> +	if (bar >= PCI_STD_NUM_BARS)
>>>>> +		return -EINVAL;
>>>>> +
>>>>> +	legacy_iomap_table = (void __iomem **)pcim_iomap_table(pdev);
>>>>> +	if (!legacy_iomap_table)
>>>>> +		return -ENOMEM;
>>>>> +
>>>>> +	/* The legacy mechanism doesn't allow for duplicate mappings. */
>>>>> +	WARN_ON(legacy_iomap_table[bar]);
>>>>> +
>>>>
>>>> Ever since this patch has been applied, I see this warning on all hppa
>>>> (parisc) systems.
>>>>
>>>> [    0.978177] WARNING: CPU: 0 PID: 1 at drivers/pci/devres.c:473 pcim_add_mapping_to_legacy_table.part.0+0x54/0x80
>>>> [    0.978850] Modules linked in:
>>>> [    0.979277] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.18.0-rc6-64bit+ #1 NONE
>>>> [    0.979519] Hardware name: 9000/785/C3700
>>>> [    0.979715]
>>>> [    0.979768]      YZrvWESTHLNXBCVMcbcbcbcbOGFRQPDI
>>>> [    0.979886] PSW: 00001000000001000000000000001111 Not tainted
>>>> [    0.980006] r00-03  000000000804000f 00000000414e10a0 0000000040acb300 00000000434b1440
>>>> [    0.980167] r04-07  00000000414a78a0 0000000000029000 0000000000000000 0000000043522000
>>>> [    0.980314] r08-11  0000000000000000 0000000000000008 0000000000000000 00000000434b0de8
>>>> [    0.980461] r12-15  00000000434b11b0 000000004156a8a0 0000000043c655a0 0000000000000000
>>>> [    0.980608] r16-19  000000004016e080 000000004019e7d8 0000000000000030 0000000043549780
>>>> [    0.981106] r20-23  0000000020000000 0000000000000000 000000000800000e 0000000000000000
>>>> [    0.981317] r24-27  0000000000000000 000000000800000f 0000000043522260 00000000414a78a0
>>>> [    0.981480] r28-31  00000000436af480 00000000434b1680 00000000434b14d0 0000000000027000
>>>> [    0.981641] sr00-03  0000000000000000 0000000000000000 0000000000000000 0000000000000000
>>>> [    0.981805] sr04-07  0000000000000000 0000000000000000 0000000000000000 0000000000000000
>>>> [    0.981972]
>>>> [    0.982024] IASQ: 0000000000000000 0000000000000000 IAOQ: 0000000040acb31c 0000000040acb320
>>>> [    0.982185]  IIR: 03ffe01f    ISR: 0000000000000000  IOR: 00000000436af410
>>>> [    0.982322]  CPU:        0   CR30: 0000000043549780 CR31: 0000000000000000
>>>> [    0.982458]  ORIG_R28: 00000000434b16b0
>>>> [    0.982548]  IAOQ[0]: pcim_add_mapping_to_legacy_table.part.0+0x54/0x80
>>>> [    0.982733]  IAOQ[1]: pcim_add_mapping_to_legacy_table.part.0+0x58/0x80
>>>> [    0.982871]  RP(r2): pcim_add_mapping_to_legacy_table.part.0+0x38/0x80
>>>> [    0.983100] Backtrace:
>>>> [    0.983439]  [<0000000040acba1c>] pcim_iomap+0xc4/0x170
>>>> [    0.983577]  [<0000000040ba3e4c>] serial8250_pci_setup_port+0x8c/0x168
>>>> [    0.983725]  [<0000000040ba7588>] setup_port+0x38/0x50
>>>> [    0.983837]  [<0000000040ba7d94>] pci_hp_diva_setup+0x8c/0xd8
>>>> [    0.983957]  [<0000000040baa47c>] pciserial_init_ports+0x2c4/0x358
>>>> [    0.984088]  [<0000000040baa8bc>] pciserial_init_one+0x31c/0x330
>>>> [    0.984214]  [<0000000040abfab4>] pci_device_probe+0x194/0x270
>>>>
>>>> Looking into serial8250_pci_setup_port():
>>>>
>>>>           if (pci_resource_flags(dev, bar) & IORESOURCE_MEM) {
>>>>                   if (!pcim_iomap(dev, bar, 0) && !pcim_iomap_table(dev))
>>>>                           return -ENOMEM;
>>>
>>> Strange. From the code I see here the WARN_ON in
>>> pcim_add_mapping_to_legacy_table() should not fire. I suspect that it's
>>> actually triggered somewhere else.
>>>
>>
>> pcim_iomap() calls pcim_add_mapping_to_legacy_table() which triggers the traceback.
>> The caller uses the returned error to determine that it needs to call pcim_iomap_table()
>> instead. As you point out below, that may not be necessary, but then it is already
>> too late and the warning was triggered.
>>
>>>>
>>>> This suggests that the failure is expected. I can see that pcim_iomap_table()
>>>> is deprecated, and that one is supposed to use pcim_iomap() instead. However,
>>>> pcim_iomap() _is_ alrady used, and I don't see a function which lets the
>>>> caller replicate what is done above (attach multiple serial ports to the
>>>> same PCI bar).
>>>
>>> Is serial8250_pci_setup_port() invoked in a loop somewhere? Where does
>>> the "attach multiple" happen?
>>>
>>
>> It is called for multiple serial ports, each of which are in the same bar but
>> with different offset into the bar.
>>
>>>>
>>>> How would you suggest to fix the problem ?
>>>
>>> I suggest you try to remove the `&& pcim_iomap_table(dev)` from above
>>> to see if that's really the cause. pcim_iomap() already creates the
>>> table, and if it succeeds the table has been created with absolute
>>> certainty. The entries will also be present. So the table-check is
>>> surplus.
>>>
>>
>> How would that fix anything ? The warning would still be triggered from the
>> failed call to pcim_iomap() for the 2nd and subsequent serial port on the
>> same bar.
> 
> OK, I failed to see that it's really pcim_iomap() which is called
> multiple times for the same bar.
> 
> The warning itself is harmless, so it's not urgent.
> Cleanup is always done through devres callbacks, one per resource. The
> table is not used for that, just for accessors of existing mappings. So
> at first glance I think that removing the WARN_ON would be OK. I'd like
> to hear Bjorn's opinion on that, though.
> 
> Maybe you could investigate removing pcim_iomap_table() from this
> driver, obtaining the mappings directly from calls to pcim_iomap().

serial8250_pci_setup_port() is an API function. It is called from several
drivers. Its callers have no means to pass "This is the first request for
this bar", and at least for some of the callers this would not be easy
to accomplish unless one changes and adds complexity to all that calling
code.

> Calling it multiple times for the same BAR is valid, it's just the
> table which complains. Since you are the first party I ever hear from
> about that WARN_ON. So with this driver ported one could argue that
> removing it is justified..
> 

Maybe the reason for that is that there are more and more pointless
backtraces in the kernel. That only results in people ignoring them.
I do see some more, but then I notice that such warnings proliferate,
and feedback such as "The warning itself is harmless" doesn't really
encourage me doing that.

> Another possiblity could be to switch to unmanaged PCI. Use pci_iomap()
> and pci_enable_device() etc.
> 
> In case you have lots of spare cycles, the cleanest way would be to
> remove the legacy table altogether. To do so, one would have to port
> all users of pcim_iomap_table(). I have worked on that for a while and
> have removed many of them. The most difficult remaining users are AFAIR
> in drivers/ata/
> 

Sorry, "spare cycles" is not exactly something that happens in my life.

Guenter


