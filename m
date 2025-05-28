Return-Path: <linux-pci+bounces-28507-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B603AC6A07
	for <lists+linux-pci@lfdr.de>; Wed, 28 May 2025 15:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E99341BC5F30
	for <lists+linux-pci@lfdr.de>; Wed, 28 May 2025 13:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C053028642F;
	Wed, 28 May 2025 13:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ugVpcmlI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901CC283FC3
	for <linux-pci@vger.kernel.org>; Wed, 28 May 2025 13:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748437805; cv=none; b=M2aWmHB8Hp1XHW6JERsqrNgPxoy+krBoIxzMv83//Y8tofAaka5ktBRVKIuV1kXKbJv3N4NuhuBrgkL+akVLoPN4KbeAhBqONSBzKAe9uXbMw9A8M8R14RdElNS8gqD3oKeAwuFvDmyOoa04zVmzs0aO3yqRua5Oo80rbWLBFiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748437805; c=relaxed/simple;
	bh=7TPZwdIPwmw4UR6wtL6uqEsrSOMS8c3M8ouvk93pX7k=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=btou1nf4WGLn2W5GJUYFOz32Oo1aubmdOFzrZmoL0P5gDPQKd7Fk6C5WDeHSWU6bH5G7N/pwBSNWAu/Gk95Dx5Vt2VI9XY6EzkKLz4Xln0opWQkIeXKtCM43msXt6+g2sJgacDOHrCif1OFJtSKkfbatml5WDfvxLduhLv/u+nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ugVpcmlI; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ad89333d603so304427366b.2
        for <linux-pci@vger.kernel.org>; Wed, 28 May 2025 06:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748437801; x=1749042601; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z9+xHaxKhbPsEc6xOO5pfmbbYaY7x26j+ttvRrojUuE=;
        b=ugVpcmlIXRsnM4PG+/0Gcz9ASEURkUx99KyqAStF3mrI0+hxIMyH+W+0yTlAlhp28a
         YHNqqeHEZcW4blvlgUZ8knoUZ0vNtinJHbzVGTErlogt2c8Ys++v6FMGVSI7BwZ+s6xu
         ThvfU0QUhpNIq3OKXk+tFRWvI4k5Sj69yYgkjvu4cLy56MYc6UUpd+fp5Oa8nO6YvRgP
         ojmmrYL74gpb46OYSnI6dinEIjNgU3TiUN6+IahUSXTLYI9jnPV5TRgk9fbK0KHopohN
         T0HrBHsD2oP48dA8OSWhYpmowpfeXSYwFKRxwI4qzii/Mil51xh2xkO9TTbTekdIhVlz
         jJgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748437801; x=1749042601;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z9+xHaxKhbPsEc6xOO5pfmbbYaY7x26j+ttvRrojUuE=;
        b=CnYMaOl/zo5H2+LRVOnDf2R/wWztVRullmsMSVvqat/DoRbfKXSqg5GrL888d9WfIZ
         /3ttirq3REJVBG+8ta80lSpmffXEpltu9fyX1CDXC+J0/2s5wQmVoheBA3erLhjiQ+1l
         5hfgB8O3IDMKCWyZtRM3oN3Jv6+NNFb+DE1vKrH2ic9Ylasz12u9bKHi2hLxffEmYCsU
         BGod+tnAfMU3QLmuSVwWX5duFfxuaRoBmzvkOjQmSTbWz0vN4csAsyQnXTbmFHjD6jI2
         AW6kgzPStZocrlwVv1PWj7/Pmlrt0+TrJvughNyLCrDBBUXacilreF5pJbwlgNFp58uy
         +FWw==
X-Forwarded-Encrypted: i=1; AJvYcCVqJzwMndGGpY3jG7dIHHLu7rTuJcdsvDMSIAwpH1HVPvdlus/cGrkAGOfAwpNwVpMBbHNli1RJJVc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtTr4XiaN4fYE3LyACeSlaCFY70ckxpxjoJF+IRYMNcplBq08b
	I74i3ZbM/8H/p/hTarF0d7Tkfxt/vr9UeaJjuUyXYlt08Hi3QPYTaYl3Ty5SOnu8vg4=
X-Gm-Gg: ASbGncuq4TSMyAC5mP7jr0INRr4Hk8hhVK3yt8bEYMblEayff6lwUy2HqTWBfjQzYLP
	Uh+5kO83QtzJNnnpEiXSqLflCYRCWFgmftSPaGKPO3RfFOjgYwtVvdcLpiIjlZrcZycixCGUOcA
	UP9DAayfB9UscOR/JmZWHyPo/1WVOtlg2rj1nqHCs84B7TZ8gO109fCKP/xpIcY1OuDpbpJaMKA
	R3v7zGmhoSslQW9oMO4WDoFv6WlYhH339qvPtNvZ7klXRu3gb20AivwtWSk9vnGP84HjalzxEpK
	+jsuM/VDo2/Quy5r3xWPjtosJJLaQBT4hVwOWvXYn3E0IimZbe4YnSlpz3s=
X-Google-Smtp-Source: AGHT+IF8B/2tTVv6HqhSsoLN2fJLeFE0SP+vAc3O6/hAnJNPKIqcmwJjUw3s8noqz2W7TfqWl20+fw==
X-Received: by 2002:a17:907:9616:b0:ad2:2e5c:89c5 with SMTP id a640c23a62f3a-ad85b13879amr1623882266b.20.1748437800581;
        Wed, 28 May 2025 06:10:00 -0700 (PDT)
Received: from [192.168.0.14] ([79.115.63.75])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad8a1b5bd07sm105387766b.176.2025.05.28.06.09.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 May 2025 06:10:00 -0700 (PDT)
Message-ID: <30da0c82-ef21-4089-b71c-8444314035e0@linaro.org>
Date: Wed, 28 May 2025 14:09:58 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 24/25] PCI: Perform reset_resource() and build fail list
 in sync
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 =?UTF-8?Q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>,
 Igor Mammedov <imammedo@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 William McVicker <willmcvicker@google.com>
References: <20241216175632.4175-1-ilpo.jarvinen@linux.intel.com>
 <20241216175632.4175-25-ilpo.jarvinen@linux.intel.com>
 <5f103643-5e1c-43c6-b8fe-9617d3b5447c@linaro.org>
 <8f281667-b4ef-9385-868f-93893b9d6611@linux.intel.com>
 <3a47fc82-dc21-46c3-873d-68e713304af3@linaro.org>
 <6e4b340b-a239-4550-b091-139c3724a54c@linaro.org>
Content-Language: en-US
In-Reply-To: <6e4b340b-a239-4550-b091-139c3724a54c@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 5/28/25 12:39 PM, Tudor Ambarus wrote:
> 
> 
> On 5/28/25 12:22 PM, Tudor Ambarus wrote:
>>
>> On 5/6/25 4:53 PM, Ilpo Järvinen wrote:
>>> On Tue, 6 May 2025, Tudor Ambarus wrote:
>>>
>>>> Hi!
>>>>
>>>> On 12/16/24 5:56 PM, Ilpo Järvinen wrote:
>>>>> Resetting resource is problematic as it prevent attempting to allocate
>>>>> the resource later, unless something in between restores the resource.
>>>>> Similarly, if fail_head does not contain all resources that were reset,
>>>>> those resource cannot be restored later.
>>>>>
>>>>> The entire reset/restore cycle adds complexity and leaving resources
>>>>> into reseted state causes issues to other code such as for checks done
>>>>> in pci_enable_resources(). Take a small step towards not resetting
>>>>> resources by delaying reset until the end of resource assignment and
>>>>> build failure list (fail_head) in sync with the reset to avoid leaving
>>>>> behind resources that cannot be restored (for the case where the caller
>>>>> provides fail_head in the first place to allow restore somewhere in the
>>>>> callchain, as is not all callers pass non-NULL fail_head).
>>>>>
>>>>> The Expansion ROM check is temporarily left in place while building the
>>>>> failure list until the upcoming change which reworks optional resource
>>>>> handling.
>>>>>
>>>>> Ideally, whole resource reset could be removed but doing that in a big
>>>>> step would make the impact non-tractable due to complexity of all
>>>>> related code.
>>>>>
>>>>> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>>>> I'm hitting the BUG_ON(!list_empty(&add_list)); in
>>>> pci_assign_unassigned_bus_resources() [1] with 6.15-rc5 and the the
>>>> pixel6 downstream pcie driver.
>>>>
>>>> I saw the thread where "a34d74877c66 PCI: Restore assigned resources
>>>> fully after release" fixes things for some other cases, but it's not the
>>>> case here.
>>>>
>>>> Reverting the following patches fixes the problem:
>>>> a34d74877c66 PCI: Restore assigned resources fully after release
>>>> 2499f5348431 PCI: Rework optional resource handling
>>>> 96336ec70264 PCI: Perform reset_resource() and build fail list in sync
>>> So it's confirmed that you needed to revert also this last commit 
>>> 96336ec70264, not just the rework change?
>> I needed to revert 96336ec70264 as well otherwise the build fails.
>>>> In the working case the add_list list is empty throughout the entire
>>>> body of pci_assign_unassigned_bus_resources().
>>>>
>>>> In the failing case __pci_bus_size_bridges() leaves the add_list not
>>>> empty and __pci_bus_assign_resources() does not consume the list, thus
>>>> the BUG_ON. The failing case contains an extra print that's not shown
>>>> when reverting the blamed commits:
>>>> [   13.951185][ T1101] pcieport 0000:00:00.0: bridge window [mem
>>>> 0x00100000-0x001fffff] to [bus 01-ff] add_size 100000 add_align 100000
>>>>
>>>> I've added some prints trying to describe the code path, see
>>>> https://paste.ofcode.org/Aeu2YBpLztc49ZDw3uUJmd#
>>>>
>>>> Failing case:
>>>> [   13.944231][ T1101] pci 0000:01:00.0: [144d:a5a5] type 00 class
>>>> 0x000000 PCIe Endpoint
>>>> [   13.944412][ T1101] pci 0000:01:00.0: BAR 0 [mem
>>>> 0x00000000-0x000fffff 64bit]
>>>> [   13.944532][ T1101] pci 0000:01:00.0: ROM [mem 0x00000000-0x0000ffff
>>>> pref]
>>>> [   13.944649][ T1101] pci 0000:01:00.0: enabling Extended Tags
>>>> [   13.944844][ T1101] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
>>>> [   13.945015][ T1101] pci 0000:01:00.0: 15.752 Gb/s available PCIe
>>>> bandwidth, limited by 8.0 GT/s PCIe x2 link at 0000:00:00.0 (capable of
>>>> 31.506 Gb/s with 16.0 GT/s PCIe x2 link)
>>>> [   13.950616][ T1101] __pci_bus_size_bridges: before pbus_size_mem.
>>>> list empty? 1
>>>> [   13.950784][ T1101] pbus_size_mem: 2. list empty? 1
>>>> [   13.950886][ T1101] pbus_size_mem: 1 list empty? 0
>>>> [   13.950982][ T1101] pbus_size_mem: 3. list empty? 0
>>>> [   13.951082][ T1101] pbus_size_mem: 4. list empty? 0
>>>> [   13.951185][ T1101] pcieport 0000:00:00.0: bridge window [mem
>>>> 0x00100000-0x001fffff] to [bus 01-ff] add_size 100000 add_align 100000
>>>> [   13.951448][ T1101] __pci_bus_size_bridges: after pbus_size_mem. list
>>>> empty? 0
>>>> [   13.951643][ T1101] pci_assign_unassigned_bus_resources: before
>>>> __pci_bus_assign_resources -> list empty? 0
>>>> [   13.951924][ T1101] pcieport 0000:00:00.0: bridge window [mem
>>>> 0x40000000-0x401fffff]: assigned
>>>> [   13.952248][ T1101] pci_assign_unassigned_bus_resources: after
>>>> __pci_bus_assign_resources -> list empty? 0
>>>> [   13.952634][ T1101] ------------[ cut here ]------------
>>>> [   13.952818][ T1101] kernel BUG at drivers/pci/setup-bus.c:2514!
>>>> [   13.953045][ T1101] Internal error: Oops - BUG: 00000000f2000800 [#1]
>>>>  SMP
>>>> ...
>>>> [   13.976086][ T1101] Call trace:
>>>> [   13.976206][ T1101]  pci_assign_unassigned_bus_resources+0x110/0x114 (P)
>>>> [   13.976462][ T1101]  pci_rescan_bus+0x28/0x48
>>>> [   13.976628][ T1101]  exynos_pcie_rc_poweron
>>>>
>>>> Working case:
>>>> [   13.786961][ T1120] pci 0000:01:00.0: [144d:a5a5] type 00 class
>>>> 0x000000 PCIe Endpoint
>>>> [   13.787136][ T1120] pci 0000:01:00.0: BAR 0 [mem
>>>> 0x00000000-0x000fffff 64bit]
>>>> [   13.787280][ T1120] pci 0000:01:00.0: ROM [mem 0x00000000-0x0000ffff
>>>> pref]
>>>> [   13.787541][ T1120] pci 0000:01:00.0: enabling Extended Tags
>>>> [   13.787808][ T1120] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
>>>> [   13.787988][ T1120] pci 0000:01:00.0: 15.752 Gb/s available PCIe
>>>> bandwidth, limited by 8.0 GT/s PCIe x2 link at 0000:00:00.0 (capable of
>>>> 31.506 Gb/s with 16.0 GT/s PCIe x2 link)
>>>> [   13.795279][ T1120] __pci_bus_size_bridges: before pbus_size_mem.
>>>> list empty? 1
>>>> [   13.795408][ T1120] pbus_size_mem: 2. list empty? 1
>>>> [   13.795495][ T1120] pbus_size_mem: 2. list empty? 1
>>>> [   13.795577][ T1120] __pci_bus_size_bridges: after pbus_size_mem. list
>>>> empty? 1
>>>> [   13.795692][ T1120] pci_assign_unassigned_bus_resources: before
>>>> __pci_bus_assign_resources -> list empty? 1
>>>> [   13.795849][ T1120] pcieport 0000:00:00.0: bridge window [mem
>>>> 0x40000000-0x401fffff]: assigned
>>>> [   13.796072][ T1120] pci_assign_unassigned_bus_resources: after
>>>> __pci_bus_assign_resources -> list empty? 1
>>>> [   13.796662][ T1120] cpif: s5100_poweron_pcie: DBG: MSI sfr not set
>>>> up, yet(s5100_pdev is NULL)
>>>> [   13.796666][ T1120] cpif: register_pcie: s51xx_pcie_init start
>>>>
>>>>
>>>> Any hints are welcomed. Thanks,
>>>> ta
>>> Hi and thanks for the report.
>> Hi! Thanks for the help. I've been out of office for the last 2 weeks,
>> sorry for the delayed reply.
>>
>>> The interesting part occurs inside reassign_resources_sorted() where most 
>>> items are eliminated from realloc_head by the list_del().
>>>
>>> My guess is that somehow, the change in 96336ec70264 from !res->flags
>>> to the more complicated check somehow causes this. If the new check 
>>> doesn't match and subsequently, no match is found from the head list, the 
>>> loop will do continue and not remove the entry from realloc_head.
>> I added a print right there and it seems it's something else. See below.
>>> But it's hard to confirm without knowing what that resources realloc_head 
>>> contains. Perhaps if you print the resources that are processed around 
>>> that part of the code in reassign_resources_sorted(), comparing the log 
>>> from the reverted code with the non-working case might help to understand 
>>> what is different there and why. To understand better what is in the head 
>>> list, it would be also useful to know from which device the resources were 
>>> added into the head list in pdev_sort_resources().
>>>
>> I added the suggested prints
>> (https://paste.ofcode.org/DgmZGGgS6D36nWEzmfCqMm) on top of v6.15 with
>> the downstream PCIe pixel driver and I obtain the following. Note that
>> all added prints contain "tudor" for differentiation.
>>
>> [   15.211179][ T1107] pci 0001:01:00.0: [144d:a5a5] type 00 class
>> 0x000000 PCIe Endpoint
>> [   15.212248][ T1107] pci 0001:01:00.0: BAR 0 [mem
>> 0x00000000-0x000fffff 64bit]
>> [   15.212775][ T1107] pci 0001:01:00.0: ROM [mem 0x00000000-0x0000ffff
>> pref]
>> [   15.213195][ T1107] pci 0001:01:00.0: enabling Extended Tags
>> [   15.213720][ T1107] pci 0001:01:00.0: PME# supported from D0 D3hot
>> D3cold
>> [   15.214035][ T1107] pci 0001:01:00.0: 15.752 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x2 link at 0001:00:00.0 (capable of
>> 31.506 Gb/s with 16.0 GT/s PCIe x2 link)
>> [   15.222286][ T1107] pci 0001:01:00.0: tudor: 1: pbus_size_mem: BAR 0
>> [mem 0x00000000-0x000fffff 64bit] list empty? 1
>> [   15.222813][ T1107] pci 0001:01:00.0: tudor: 1: pbus_size_mem: ROM
>> [mem 0x00000000-0x0000ffff pref] list empty? 1
>> [   15.224429][ T1107] pci 0001:01:00.0: tudor: 2: pbus_size_mem: ROM
>> [mem 0x00000000-0x0000ffff pref] list empty? 0
>> [   15.224750][ T1107] pcieport 0001:00:00.0: bridge window [mem
>> 0x00100000-0x001fffff] to [bus 01-ff] add_size 100000 add_align 100000
>>
>> [   15.225393][ T1107] tudor : pci_assign_unassigned_bus_resources:
>> before __pci_bus_assign_resources -> list empty? 0
>> [   15.225594][ T1107] pcieport 0001:00:00.0: tudor:
>> pdev_sort_resources: bridge window [mem 0x00100000-0x001fffff] resource
>> added in head list
>> [   15.226078][ T1107] pcieport 0001:00:00.0: bridge window [mem
>> 0x40000000-0x401fffff]: assigned
>> [   15.226419][ T1107] tudor : pci_assign_unassigned_bus_resources:
>> after __pci_bus_assign_resources -> list empty? 0
>> [   15.226442][ T1107] ------------[ cut here ]------------
>> [   15.227587][ T1107] kernel BUG at drivers/pci/setup-bus.c:2522!
>> [   15.227813][ T1107] Internal error: Oops - BUG: 00000000f2000800 [#1]
>>  SMP
>> ...
>> [   15.251570][ T1107] Call trace:
>> [   15.251690][ T1107]  pci_assign_unassigned_bus_resources+0x110/0x114 (P)
>> [   15.251945][ T1107]  pci_rescan_bus+0x28/0x48
>>
>> I obtain the following output when using the same prints adapted
>> (https://paste.ofcode.org/37w7RnKkPaCxyNhi5yhZPbZ) and with the blamed
>> commits reverted:
>> a34d74877c66 PCI: Restore assigned resources fully after release
>> 2499f5348431 PCI: Rework optional resource handling
>> 96336ec70264 PCI: Perform reset_resource() and build fail list in sync
>>
>> [   15.200456][ T1102] pci 0000:01:00.0: [144d:a5a5] type 00 class
>> 0x000000 PCIe Endpoint
>> [   15.200632][ T1102] pci 0000:01:00.0: BAR 0 [mem
>> 0x00000000-0x000fffff 64bit]
>> [   15.200755][ T1102] pci 0000:01:00.0: ROM [mem 0x00000000-0x0000ffff
>> pref]
>> [   15.200876][ T1102] pci 0000:01:00.0: enabling Extended Tags
>> [   15.201075][ T1102] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
>> [   15.201254][ T1102] pci 0000:01:00.0: 15.752 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x2 link at 0000:00:00.0 (capable of
>> 31.506 Gb/s with 16.0 GT/s PCIe x2 link)
>> [   15.206555][ T1102] pci 0000:01:00.0: tudor: 1: pbus_size_mem: BAR 0
>> [mem 0x00000000-0x000fffff 64bit] list empty? 1
>> [   15.206737][ T1102] pci 0000:01:00.0: tudor: 1: pbus_size_mem: ROM
>> [mem 0x00000000-0x0000ffff pref] list empty? 1
>> [   15.206901][ T1102] tudor : pci_assign_unassigned_bus_resources:
>> before __pci_bus_assign_resources -> list empty? 1
>> [   15.207072][ T1102] pcieport 0000:00:00.0: tudor:
>> pdev_sort_resources: bridge window [mem 0x00100000-0x002fffff] resource
>> added in head list
>> [   15.207396][ T1102] pcieport 0000:00:00.0: bridge window [mem
>> 0x40000000-0x401fffff]: assigned
>> [   15.208165][ T1102] tudor : pci_assign_unassigned_bus_resources:
>> after __pci_bus_assign_resources -> list empty? 1
>> [   15.208783][ T1102] cpif: s5100_poweron_pcie: DBG: MSI sfr not set
>> up, yet(s5100_pdev is NULL)
>> [   15.208786][ T1102] cpif: register_pcie: s51xx_pcie_init start
> 
> I see my email client split the lines for the prints making the output
> very hard to read. Added the output here too:
> https://paste.ofcode.org/AEfjASQW8Z2jbMak5VkmpJ

With the following change things get back to how they were before
2499f5348431:

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 5247370010aa..1589dd8afa69 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1214,9 +1214,10 @@ static int pbus_size_mem(struct pci_bus *bus,
unsigned long mask,
 				__func__, r_name, r, list_empty(realloc_head));

 			/* Put SRIOV requested res to the optional list */
-			if (realloc_head && pci_resource_is_optional(dev, i)) {
+			if (realloc_head && pci_resource_is_iov(i)) {
 				add_align = max(pci_resource_alignment(dev, r), add_align);
-				add_to_list(realloc_head, dev, r, 0, 0 /* Don't care */);
+				resource_set_size(r, 0);
+				add_to_list(realloc_head, dev, r, r_size, 0 /* Don't care */);
 				children_add_size += r_size;
 				pci_info(dev, "tudor: 2: %s: %s %pR list empty? %d\n",
 					__func__, r_name, r, list_empty(realloc_head));
-- 
2.49.0.1238.gf8c92423fb-goog

