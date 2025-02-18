Return-Path: <linux-pci+bounces-21692-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F203A39479
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 09:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E2831889C56
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 08:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C323C1DE3BB;
	Tue, 18 Feb 2025 08:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+5vy7Uc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE04B1F473C
	for <linux-pci@vger.kernel.org>; Tue, 18 Feb 2025 08:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739865818; cv=none; b=VfmtmpGg6ExOVtajgN21N1vS28pP/lIIB3NErxs1CM09ClJVQ0q/nL693ywDnB7nZ0av7g53KcZhGlSd8y3OHjlBiVee9Bvz0Mvey4vtkYlJEjPGH1WFiETdvpncO3+IpGMptiIKekKBT+oFwq2hlLrzTsLEiqPp1k4Wzn0u9u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739865818; c=relaxed/simple;
	bh=5npPDbdklZTMxIuYU+YzLoHL7NSkD8C4EhxSob5tgKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HvnsfgvAD3pJtIAZU8rrLmPTs/CxR1JyOckhntsn0jlcY86EjqvjcKB0WewXXvlzy9LRIIPJJjGdxnaDWYkq7DIELZTCkcCe2UKg7MSa05FKVr3h49KfFX0i+DX2rITsQgRkNGuWlO8SU4cICq3caqMkQLfLeT1UOAdROt9ssLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i+5vy7Uc; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4398738217aso14953805e9.3
        for <linux-pci@vger.kernel.org>; Tue, 18 Feb 2025 00:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739865815; x=1740470615; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5npPDbdklZTMxIuYU+YzLoHL7NSkD8C4EhxSob5tgKo=;
        b=i+5vy7UcySGwUvfVUwMeAO5YEA0rMcUlJO0RjGXNg7TP/vdODOVVClajXK1pAuX40v
         nIsXgRh2UWvzU5Buur7B86k0BbLGQveHo5YFdm+u2TWUd7xIUidxtT+gfSipLcWmCEkE
         a3UlKQC3WL3TyxBC73AkRMCp/QBrRjWqoF1Di+KM1exvz9vsUI4kFCPjbnczd0kBxxjH
         Pbixzr7iy3fUlph5650FUjpXtteztxRBqe7QdC0O+8DPR++ZVmu90qgEGZuUFAXeSqUg
         3Mf0I9iw+cqncNCD4Tj+h7DgAChdDJ8H0yHjl+ph6rcFmQh9OyNq+tQU/qjKcMicjgEb
         4I0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739865815; x=1740470615;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5npPDbdklZTMxIuYU+YzLoHL7NSkD8C4EhxSob5tgKo=;
        b=XavN8WC33MRURZ02GcacU+B34kjtutaeHZdiafn0pIWUS1CEvVGqm0YC44sOMe5YgV
         PgXwbDp2as3O9pGU20T4kj6c+xmzLeIAE6lX5/HMNgpT6n1/+8CgN1jxWK1B1ACzVvxx
         0aWjvVf9fdnniS3EoPTA4sDo0S5N1rMXZVo/TiSRG6bhXxXFwNGE/rS0jjzsk92OHtAo
         CKVuvc0ipl9S7gf5GpGTIRl5exdm8uXBvh256dUvucggsGV38oMznnv8J9wIn7JGCj5b
         vm4TKT/aGhq5vwgX6ppFaoFa2Wgz6MJDefgmdTj2KGGIpV1dHx3EfaGHtazbLJgMF48d
         szWA==
X-Forwarded-Encrypted: i=1; AJvYcCXeIYSoa3dpxXGrcK+rEEoBbwuHhqQDyDvRgGwMmrXvujH/MBZMuB8wGPZYz6ZeegFrlp+P8pRfajQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb8xWpqQxFAnRpwQjpEqOlLq8bqUGvj33/C37hv7hZ7aVZyzB2
	yS7WMMqdz/BJi4qMbSY1jjafHQjCY3Qyo3neLFWemMAqI5Ql2NPa
X-Gm-Gg: ASbGncvh+Fq1X1xK73P8SmoJEcNtFDSdIz6tbIZZxvv1shPBnYdsLt4deNPZmHb9jqa
	dCm553nCzt5k/hh41tgz6A7xuw8Dl+DPbwAGOBq2bzFQyDnJ82oAlYxS1eocTRe+8L4J3gVKODw
	7Ie83eq23uYNLszmjtDLu2+x92fCY/XW0nvEJkPJMDYw/ssUd2LGQbRYyi0Mdcxf03h3l6WQW7o
	Zxe4f9xCukNqKBjmP20Uyg8QgeWCzhSeRLKOl7R3jQr2ylxhDInAj+mfmdTncU+F3+AjdGy/EVg
	lsuK3dyc5n1WkD0HBrFSqekpqsYYLqp2xStZWrhGn5LU
X-Google-Smtp-Source: AGHT+IFCA6Op++PqqRH2km1IikHe1NVa8hFE3PIzTLACmwC7fm363CBtKPH2JYLERCqtH+tpuTnVBg==
X-Received: by 2002:a05:600c:46d1:b0:439:6712:643d with SMTP id 5b1f17b1804b1-4396e6a74f2mr106246975e9.9.1739865814848;
        Tue, 18 Feb 2025 00:03:34 -0800 (PST)
Received: from [10.254.108.83] (munvpn.amd.com. [165.204.72.6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f25913f5asm14465027f8f.52.2025.02.18.00.03.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 00:03:33 -0800 (PST)
Message-ID: <97e803f4-f00e-4fb0-8ed8-714ea9960e5a@gmail.com>
Date: Tue, 18 Feb 2025 09:03:30 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: fix Sapphire PCI rebar quirk
To: Mario Limonciello <mario.limonciello@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, bhelgaas@google.com,
 linux-pci@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 Nirmoy Das <nirmoy.aiemd@gmail.com>
References: <20250217151053.420882-1-alexander.deucher@amd.com>
 <1654fb6c-e0e8-4dde-8554-7058cf73503d@amd.com>
 <CADnq5_NUEuMFsd__w1eGBWALxcQwtX7sa2Sn53vDjaxrqNuhPQ@mail.gmail.com>
 <CADnq5_NEhv-E9ZxHvxhBtFb_cBkPqMfu-nsQfEknO30tNBjA2Q@mail.gmail.com>
 <a2645312-0903-4fa9-9735-7f2a77986cb8@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <a2645312-0903-4fa9-9735-7f2a77986cb8@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Am 17.02.25 um 17:04 schrieb Mario Limonciello:
> On 2/17/2025 10:00, Alex Deucher wrote:
>> On Mon, Feb 17, 2025 at 10:45 AM Alex Deucher <alexdeucher@gmail.com> wrote:
>>>
>>> On Mon, Feb 17, 2025 at 10:38 AM Christian König
>>> <christian.koenig@amd.com> wrote:
>>>>
>>>> Am 17.02.25 um 16:10 schrieb Alex Deucher:
>>>>> There was a quirk added to add a workaround for a Sapphire
>>>>> RX 5600 XT Pulse.  However, the quirk only checks the vendor
>>>>> ids and not the subsystem ids.  The quirk really should
>>>>> have checked the subsystem vendor and device ids as now
>>>>> this quirk gets applied to all RX 5600 and it seems to
>>>>> cause problems on some Dell laptops.  Add a subsystem vendor
>>>>> id check to limit the quirk to Sapphire boards.
>>>>
>>>> That's not correct. The issue is present on all RX 5600 boards, not just the Sapphire ones.
>>>
>>> I suppose the alternative would be to disable resizing on the
>>> problematic DELL systems only.
>>
>> How about this attached patch instead?
>
> JFYI Typo in the commit message:
>
> s,casused,caused,

With that fixed feel free to add my rb. It's just that the Dell systems are unstable even without the resizing.

The resizing just makes it more likely to hit the issue because ti massively improves performance on the RX 5600 boards.

Regards,
Christian.

>
>>
>> Alex
>>
>>>
>>>>
>>>> The problems with the Dell laptops are most likely the general instability of the RX 5600 again which this quirk just make more obvious because of the performance improvement.
>>>>
>>>> Do you have a specific bug report for the Dell laptops?
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>>
>>>>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/1707
>>>
>>> ^^^ this bug report
>>>
>>> Alex
>>>
>>>
>>>>> Fixes: 907830b0fc9e ("PCI: Add a REBAR size quirk for Sapphire RX 5600 XT Pulse")
>>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>>> Cc: Christian König <christian.koenig@amd.com>
>>>>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>>>>> Cc: Nirmoy Das <nirmoy.aiemd@gmail.com>
>>>>> ---
>>>>>   drivers/pci/pci.c | 1 +
>>>>>   1 file changed, 1 insertion(+)
>>>>>
>>>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>>>>> index 225a6cd2e9ca3..dec917636974e 100644
>>>>> --- a/drivers/pci/pci.c
>>>>> +++ b/drivers/pci/pci.c
>>>>> @@ -3766,6 +3766,7 @@ u32 pci_rebar_get_possible_sizes(struct pci_dev *pdev, int bar)
>>>>>
>>>>>        /* Sapphire RX 5600 XT Pulse has an invalid cap dword for BAR 0 */
>>>>>        if (pdev->vendor == PCI_VENDOR_ID_ATI && pdev->device == 0x731f &&
>>>>> +         pdev->subsystem_vendor == 0x1da2 &&
>>>>
>>>>
>>>>
>>>>
>>>>>            bar == 0 && cap == 0x700)
>>>>>                return 0x3f00;
>>>>>
>>>>
>


