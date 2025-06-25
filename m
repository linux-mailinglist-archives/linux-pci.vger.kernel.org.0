Return-Path: <linux-pci+bounces-30627-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21042AE85B5
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 16:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ECEF170A8E
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 14:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4CE1F460B;
	Wed, 25 Jun 2025 14:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BHXJYYNm"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932F73074B2
	for <linux-pci@vger.kernel.org>; Wed, 25 Jun 2025 14:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750860528; cv=none; b=lA3/I75Lm1o6c9R1v00EdUIXtfokFEyWLZHF01pzXgVNn6Iiv5c57joypyqIbxCZu4woSS45zaDVal5SjiDnYIZY/LKnHmitOdO2BdYvs6aaJvhcBHnCc+MQX1DSRDlY2b74P/B0nLAqwlB2O8SjRVIGMuqimTJyD55qwu5JpjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750860528; c=relaxed/simple;
	bh=5m2LV3NQViC121KO9PlG+IFJdz7/D4RmJLMcY2oekcs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tOZ1x4eV8VZjDsdf09adOYnXavDaoM5L0oMD2Lr/hCRmwj5nVs9DltjO3Aery3DDw/t6xieXZbueIwIXkRicqFPTIUG68hKCRaKflqeK7E+DaHglePQHA5QnvUDco01lA8ZF7uE4nJgmO1WfTGsOps4ftdWa3fpFJA/TEB1/yUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BHXJYYNm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750860525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V4+K3avD7GoDzKHCaevIc+37/y9NZXSewwiBIBUmICw=;
	b=BHXJYYNm7JEO30nwald4idGy9zPNyQ5qFxvUXsek7QnmrJy6kwGYedvtb6dZ0G0FK4szRI
	5bUJdVigSBoMKTaZ1K3pZ5F01oMdaRWK+DYldVEMM7Ar98Qk3BuE3HwyCzz+S1+1x5hXHB
	4pNKvJrYadS+YmB9Kzxrbqf/3nGf3Hc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-ftmixwGIPYmVcncA1q8rPg-1; Wed, 25 Jun 2025 10:08:44 -0400
X-MC-Unique: ftmixwGIPYmVcncA1q8rPg-1
X-Mimecast-MFC-AGG-ID: ftmixwGIPYmVcncA1q8rPg_1750860523
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ad89c32a8a6so170262066b.3
        for <linux-pci@vger.kernel.org>; Wed, 25 Jun 2025 07:08:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750860523; x=1751465323;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V4+K3avD7GoDzKHCaevIc+37/y9NZXSewwiBIBUmICw=;
        b=C/TUne1XUG73RYBzThCe08iETWcbSgrR6Mdh/fQD1ty4CIxWHvpIsEAe+veJgzFhMo
         L0G5t18xxDE+lWtmafQq0zAQ4Hl0l99i3P4Lc+wMdaWQjySG+j7c6Yk4PkGcqLxGANlA
         cMaBxPML+Yu//gIDr350NPICy2qTWxwtqeMj7wnbguDHzdpXnKpdCQFB0s9hT9xCk/D9
         FO/ek4AQDkjLjlXTLEXL0py6vMw3bN3AH6AitAUSB+gmkfI7QfB+RzLjNvsuNL/x6iuf
         /WwgmFvav7ljv8hVzaDth9z+KW1aKXXzMh2fK4Bp/WF04sg003LHIV7nh2MthIhJwx7j
         jILA==
X-Forwarded-Encrypted: i=1; AJvYcCW3/7ihbBvb2D2xBFqhzQsRnZCyiZHWsqqC2lsC+74jZQokOZj9iV+xolJMLFefm2LUG9kcOjdOdP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YylDKhuFyXhqUxyyFyiianBkrZst18Uk2TAWTzmR+Efy01auhwS
	Yb9qFoTlAZWCrLhQbE44mLdbGveBtkrLtda/J//7TKEm40TArilyuWp+W+COFHnnL4m/tLgln+K
	id8bEbfV4XQ13QEAArIzrFWXhizqcbhN3h/qa9ftgynjahFZz64MyCPJUc/wDCw==
X-Gm-Gg: ASbGncuACXDSQlg6VFIbV+2SlIDXXqo2eB0jL6Mv3tu6uCTSPpzbcNQl8TFWLTCrTQG
	fJaUiv+TVjLN913oKBzi2kZ/EMLRyJQkB7nwYbsEZYcGxEjwMzJNDO95m1Pw0fOqW31+69XXN4S
	qopN5/6/tRpkTejIx/uCb36vrI9XA95XEDccqTV3E90rg+HTwxrlL5lld4ocvoMMizpM9rsHtr6
	s+bIwHbPH0QrMXzEY1hQwFl0ZZLUcdgeQ9uZluXbZPxrGIh+hxf6tiHNHJt0tkJYtMYy6HKpfhk
	pHMAn7iubGmyeQAPc5HKkvumW0q43woOjcig3UHPbz/ilSA1go/VbM8S6+Lw75kKRiOrm8D5ou6
	0bDH1N+WV37CuimNAqfVEnXo86k+Abh48HvA+JBnr0rIxgkIosfW8AZXGTXn4aHWYJ14yyZxlRA
	==
X-Received: by 2002:a17:907:3f16:b0:ade:9b52:4cc0 with SMTP id a640c23a62f3a-ae0d0bbff7amr10282166b.26.1750860521295;
        Wed, 25 Jun 2025 07:08:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5Qpscb/cqw9IejULOiGOs7xdQutSOhkhMnafJly1OjTfXu1ZIPsra55NDTVtRCoKZhHpE3A==
X-Received: by 2002:a17:907:3f16:b0:ade:9b52:4cc0 with SMTP id a640c23a62f3a-ae0d0bbff7amr10276266b.26.1750860520679;
        Wed, 25 Jun 2025 07:08:40 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0a2d922c9sm362700166b.96.2025.06.25.07.08.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jun 2025 07:08:40 -0700 (PDT)
Message-ID: <98012c55-1e0d-4c1b-b650-5bb189d78009@redhat.com>
Date: Wed, 25 Jun 2025 16:08:38 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] agp/amd64: Bind to unsupported devices only if AGP is
 present
To: Ben Hutchings <ben@decadent.org.uk>, Lukas Wunner <lukas@wunner.de>
Cc: David Airlie <airlied@redhat.com>, Bjorn Helgaas <helgaas@kernel.org>,
 Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Andi Kleen <ak@linux.intel.com>, Ahmed Salem <x0rw3ll@gmail.com>,
 Borislav Petkov <bp@alien8.de>, dri-devel@lists.freedesktop.org,
 iommu@lists.linux.dev, linux-pci@vger.kernel.org
References: <f8ff40f35a9a5836d1371f60e85c09c5735e3c5e.1750497201.git.lukas@wunner.de>
 <b73fbb3e3f03d842f36e6ba2e6a8ad0bb4b904fd.camel@decadent.org.uk>
 <aFalrV1500saBto5@wunner.de>
 <279f63810875f2168c591aab0f30f8284d12fe02.camel@decadent.org.uk>
 <aFa8JJaRP-FUyy6Y@wunner.de>
 <9077aab5304e1839786df9adb33c334d10c69397.camel@decadent.org.uk>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <9077aab5304e1839786df9adb33c334d10c69397.camel@decadent.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 24-Jun-25 11:54 PM, Ben Hutchings wrote:
> On Sat, 2025-06-21 at 16:05 +0200, Lukas Wunner wrote:
>> On Sat, Jun 21, 2025 at 03:51:44PM +0200, Ben Hutchings wrote:
>>> On Sat, 2025-06-21 at 14:29 +0200, Lukas Wunner wrote:
>>>> On Sat, Jun 21, 2025 at 02:07:40PM +0200, Ben Hutchings wrote:
>>>>> On Sat, 2025-06-21 at 11:40 +0200, Lukas Wunner wrote:
>>>>>> Since commit 172efbb40333 ("AGP: Try unsupported AGP chipsets on x86-64 by
>>>>>> default"), the AGP driver for AMD Opteron/Athlon64 CPUs attempts to bind
>>>>>> to any PCI device.
>>>>>>
>>>>>> On modern CPUs exposing an AMD IOMMU, this results in a message with
>>>>>> KERN_CRIT severity:
>>>>>>
>>>>>>   pci 0000:00:00.2: Resources present before probing
>>>>>>
>>>>>> The driver used to bind only to devices exposing the AGP Capability, but
>>>>>> that restriction was removed by commit 6fd024893911 ("amd64-agp: Probe
>>>>>> unknown AGP devices the right way").
>>>>>
>>>>> That didn't remove any restriction as the probe function still started
>>>>> by checking for an AGP capability.  The change I made was that the
>>>>> driver would actually bind to devices with the AGP capability instead of
>>>>> starting to use them without binding.
>>>>
>>>> The message above would not be emitted without your change.
>>>>
>>>> The check for the AGP capability in agp_amd64_probe() is too late
>>>> to prevent the message.  That's because the message is emitted
>>>> before ->probe() is even called.
>>>
>>> I understand that.  But I don't feel that the explanation above
>>> accurately described the history here.
>>
>> So please propose a more accurate explanation.
> 
> Something like "The driver iterates over all PCI devices, checking for
> an AGP capability.  Since commit 6fd024893911 ("amd64-agp: Probe unknown
> AGP devices the right way") this is done with driver_attach() and a
> wildcard PCI ID table, and the preparation for probing the IOMMU device
> produces this error message."
> 
> Thinking about this further:
> 
> - Why *does* the IOMMU device have resources assigned but no driver
>   bound?  Is that the real bug?

Arguably yes, but I assume that this is done because the IOMMU needs
to be setup early, before any drivers probe() methods run.

Note that cbbc00be2ce3 ("iommu/amd: Prevent binding other PCI drivers
to IOMMU PCI devices") which has been reverted did effectively ban
other drivers from binding. So arguably that needs to be unreverted
and then this problem will go away.

> - If not, and there's a general problem with this promiscuous probing,
>   would it make more sense to:
>   1. Restore the search for an AGP capability in agp_amd64_init().
>   2. If and only if an AGP device is found, poke the appropriate device
>      ID into agp_amd64_pci_promisc_table and then call driver_attach().
>   ?

Lukas made me aware of this attempt to fix the KERN_CRIT msg, because
I wrote a slightly different patch to fix this:

https://lore.kernel.org/dri-devel/20250625112411.4123-1-hansg@kernel.org/

This seems like a cleaner fix to me and something which would be good
to have regardless since currently the driver_attach() call is doing
too much work because the promisc table catches an unnecessary wide
net / match matching many PCI devices which cannot be AGP capable
at all.

Regards,

Hans




> 
> Ben.
> 


