Return-Path: <linux-pci+bounces-5347-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75380890746
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 18:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0452B25E92
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 17:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E953381726;
	Thu, 28 Mar 2024 17:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LGGjU7Xc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232DC1E52A;
	Thu, 28 Mar 2024 17:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711647344; cv=none; b=FguE7+hbhffl1Vk6czGTSB9o5Fyg0P3ZJ7HEivIyYvDUHxHUaoXlZsBA+ffMi2yQicHK0EdewBDfRqi6aHzAyFKUFtTG7fFCMDxmk2u+84rOdFLB2gw+uWKjnSxa1fizJ4Fb+FZBtHxCh1MnhCh91KC5aooa8qfXChmAsLp7JPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711647344; c=relaxed/simple;
	bh=Z6LtNmZpB1Fb5bjk7s35b8IwmrHHuOCaViUaiTjixbM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KkfsnmoaPVseEPPswBH/ES+hfLTxyxkUKyx2FLrkc121r0aNheKRlaPfkoyS9LzGG2QyolcHRo9QvBwhHOHMw4nwe9n15DEE9PnsMGMe+Mqq7Xr7rXtnoN6TwswEUXvPNim5TuSsL7AzKN9/rH5XMbuafRZmLWR3QkoFs90HMG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LGGjU7Xc; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4149529f410so11699695e9.3;
        Thu, 28 Mar 2024 10:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711647341; x=1712252141; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DtcCyBt35iR2tF5iRIFRqssmEdaEf6eUOKFjr00aC1c=;
        b=LGGjU7Xcq2Em1kHC0AbShFzI+otjWsNVQZgng+7gaoYgYQjTuJRBxE9+hhn+Jn5ZlT
         jNvmc+CPmvPHRe7AAfNGHoRT/XnwpmJIfxPZhCRARxJ3yyw4KHsPHgG+y4se8PUYtT+H
         BKx63+JbbI+WYGH1HkdpstpS+hqFZh9vrtWaWxTvg6a0LJdNkm5HM25emukaa/jzo3tz
         wjgPMdYvLxtg5kVDcg2B5mOszYQqaAIGisKs9kFlol4wxsAtZzM5smJ9MjLUGncnfkvQ
         8Q6DAjUOkNJwUVOQzvPo47DeTtDy9f6nUP/q06Y4pKrnAM2BJzJcstBVhaZXUTdZqxXv
         NeKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711647341; x=1712252141;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DtcCyBt35iR2tF5iRIFRqssmEdaEf6eUOKFjr00aC1c=;
        b=jQbUyfoaQO7xd7U4T2qD5xc1aV+xQ3eeYwtZylTq4wBebhWjYlus/vVsEm18jKodRJ
         /6Rimz9aJYGKU2c4wbXMGk9b5/ahwGSYFU8oM2eRyzYZgr0tmf0ba0zfSgucW0Ro0Zax
         72ri0mL0DxN1Nb6nkQ7EBeS4YcSkBW25A6pVKgwoJkbUQV4baJf5ekJJ2K9ys3Tr6fTR
         aARMxGJXy2rGcNLvszNzqV7IqITn9gepSzuQMU3HS9Rw+RI9GlxM3NHyBN4PPmHbg+aw
         gMHk6WewVr2faKyMbG7iXwrbGAOv6HCcHNjdpNI1nmuaBihzqHRYlhGiKkYR38Zl9xpP
         idMA==
X-Forwarded-Encrypted: i=1; AJvYcCVpA04iZEw7Nbp4pL97PujJy8YT6z/wfElrJ4Lv1CaslXntL0IM3GY0hBA7atLjt45lf5DtOKRiPXx1SrX002BK//i/ph7n
X-Gm-Message-State: AOJu0Yza7bpiXpGJCUpwtU8gVsIF4OOZ0kY7K7QGTCfHRaMi4nigOP9s
	QZFw/y25sTL6tM8Mp0LA0e86gUx6k4azqRpQP5+XYlgmQsfsB//uQMRKc02n
X-Google-Smtp-Source: AGHT+IGgd+6J2xktYTxV2RMOXtP75Ls0T9rFhKjDR4cHYrRWFvJrxd07Pc7jGpBgseYtDurrT0RTOQ==
X-Received: by 2002:a05:600c:4506:b0:412:d68c:8229 with SMTP id t6-20020a05600c450600b00412d68c8229mr7333wmo.39.1711647341083;
        Thu, 28 Mar 2024 10:35:41 -0700 (PDT)
Received: from ?IPV6:2a01:c23:b9be:3500:9016:a3de:1f88:2f89? (dynamic-2a01-0c23-b9be-3500-9016-a3de-1f88-2f89.c23.pool.telefonica.de. [2a01:c23:b9be:3500:9016:a3de:1f88:2f89])
        by smtp.googlemail.com with ESMTPSA id l3-20020a5d5603000000b0033e03d37685sm2240607wrv.55.2024.03.28.10.35.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 10:35:40 -0700 (PDT)
Message-ID: <348fa275-3922-4ad1-944e-0b5d1dd3cff5@gmail.com>
Date: Thu, 28 Mar 2024 18:35:40 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] PCI: Add and use pcim_iomap_region()
To: Philipp Stanner <pstanner@redhat.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <982b02cb-a095-4131-84a7-24817ac68857@gmail.com>
 <4cf0d7710a74095a14bedc68ba73612943683db4.camel@redhat.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <4cf0d7710a74095a14bedc68ba73612943683db4.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 27.03.2024 14:20, Philipp Stanner wrote:
> On Wed, 2024-03-27 at 12:52 +0100, Heiner Kallweit wrote:
>> Several drivers use the following sequence for a single BAR:
>> rc = pcim_iomap_regions(pdev, BIT(bar), name);
>> if (rc)
>>         error;
>> addr = pcim_iomap_table(pdev)[bar];
>>
>> Let's create a simpler (from implementation and usage perspective)
>> pcim_iomap_region() for this use case.
> 
> I like that idea – in fact, I liked it so much that I wrote that
> myself, although it didn't make it vor v6.9 ^^
> 
> You can look at the code here [1]
> 
> Since my series cleans up the PCI devres API as much as possible, I'd
> argue that prefering it would be better.
> 
Thanks for the hint. I'm not in a hurry, so yes: We should refactor the
pcim API, and then add functionality.

> But maybe you could do a review, since you're now also familiar with
> the code?
> 
I'm not subscribed to linux-pci, so I missed the cover letter, but had a
look at the patches in patchwork. Few remarks:

Instead of first adding a lot of new stuff and then cleaning up, I'd
propose to start with some cleanups. E.g. patch 7 could come first,
this would already allow to remove member mwi from struct pci_devres.

By the way, in patch 7 it may be a little simpler to have the following
sequence:

rc = pci_set_mwi()
if (rc)
	error
rc = devm_add_action_or_reset(.., __pcim_clear_mwi, ..);
if (rc)
	error

This would avoid the call to devm_remove_action().

We briefly touched the point whether the proposed new function returns
NULL or an ERR_PTR. I find it annoying that often the kernel doc function
description doesn't mention whether a function returns NULL or an ERR_PTR
in the error case. So I have to look at the function code. It's also a
typical bug source.
We won't solve this in general here. But I think we should be in line
with what related functions do.
The iomap() functions typically return NULL in the error case. Therefore
I'd say any new pcim_...iomap...() function should return NULL too. 

Then you add support for mapping BAR's partially. I never had such a use
case. Are there use cases for this?
Maybe we could omit this for now, if it helps to reduce the complexity
of the refactoring.

I also have bisectability in mind, therefore my personal preference would
be to make the single patches as small as possible. Not sure whether there's
a way to reduce the size of what currently is the first patch of the series.

> Greetings,
> P.
> 
> [1] https://lore.kernel.org/all/20240301112959.21947-1-pstanner@redhat.com/
> 
> 
>>
>> Note: The check for !pci_resource_len() is included in
>> pcim_iomap(), so we don't have to duplicate it.
>>
>> Make r8169 the first user of the new function.
>>
>> I'd prefer to handle this via the PCI tree.
>>
>> Heiner Kallweit (2):
>>   PCI: Add pcim_iomap_region
>>   r8169: use new function pcim_iomap_region()
>>
>>  drivers/net/ethernet/realtek/r8169_main.c |  8 +++----
>>  drivers/pci/devres.c                      | 28
>> +++++++++++++++++++++++
>>  include/linux/pci.h                       |  2 ++
>>  3 files changed, 33 insertions(+), 5 deletions(-)
>>
> 

Heiner

