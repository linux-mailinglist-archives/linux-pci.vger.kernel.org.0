Return-Path: <linux-pci+bounces-28504-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F40F7AC6841
	for <lists+linux-pci@lfdr.de>; Wed, 28 May 2025 13:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9884A189E7D4
	for <lists+linux-pci@lfdr.de>; Wed, 28 May 2025 11:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE873281341;
	Wed, 28 May 2025 11:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s5i9bndD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834D9280A50
	for <linux-pci@vger.kernel.org>; Wed, 28 May 2025 11:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748431353; cv=none; b=hVxGoWODhdL7YSarlAo9s+MXxyG/I5TzdiKfNV47TOOz8lvmFGw1sdwAQ8XDzA8i0taU5+kIhyKV18jLqdxsB65OY9R5OJaGrChcF+4u9s2zDnL5GVHPWnY2VFkyRLZVOzlSxnic6/VSPalWs4bKvGLePdRtCC8Ld2gCM9NfeSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748431353; c=relaxed/simple;
	bh=dGay5GEaCgs3Evn7kiNWMaKleoTY7yUgWKtAJy1x6Pg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=RmtYypqNxEX/60aiAgii47Xq6bnycOm586CXMq+3YJdE/gc+8UJDe3g4G/QNLv8SRF/KrZcgks+qi+TxZl+twLf3UMlSICttDYjKAxGSPaYtU1P4ue+C2uLVp8BeZtCi/WGuZsqsPziZ0e2oMQlRnc8R9C0+NqJjVFtHapO8frs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s5i9bndD; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a365a6804eso2787283f8f.3
        for <linux-pci@vger.kernel.org>; Wed, 28 May 2025 04:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748431350; x=1749036150; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=x1wmNFCteFQvjcvkw+beYXhxykf9CQu5mcRPT6RwrJQ=;
        b=s5i9bndDNxnbJsRRgv9oSWwZjaVnBQUUnyVzGnBqXlLYYBx5Eavy9PS2bPhLRiec5o
         c3gBvogbu1dr5KKzbqmS/5/RooSkJTgt/hw7Fikcv3Rn/a6PnU8tDVQpKD1xau8FnwsV
         LVwII2ZYAUbjNCapzSaYk4Q7JOCgC8EVHwDozi7xqAHlg+DyIrp271GTWD7RDLUFjJam
         5EEH7S7f8NJly1lzxvnR9TMkb0uW1khxfuufFLfVOEczlyboB9zVWe9j43YkKPc8Fx58
         I6M8LymodeeglFVmerteAiDdhCmx4Xbm8ulkTBeLbimnMTfR2ihk5ePq9DLcwuRNPAx5
         5xvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748431350; x=1749036150;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x1wmNFCteFQvjcvkw+beYXhxykf9CQu5mcRPT6RwrJQ=;
        b=am70qJ0cgxCV6SABkQj9kb9THHVSdjISS6AhaUpUnmbbEApKEeJfaCZcLtOqx4zo5D
         e2NbIcRevyi2pdEWiAR1XeApCEVfZocBT7ZlUS9p/LiX3dI9hnge+JTaDgeIZ6Z9MTQ0
         MNoGc1wf9uMW35NrpHSFkmgeTgkS14Ze63IBg9lUMCIRnnXKCme+ToMSV1rUFfbchOYH
         XreTm6q4F7IfQJKysDGjZ2IEu8gR19w4UmWeETB8bqikMoTCknAY8+V0RqNaphl4foNa
         CeZ4ka0i3fQRVCFWiUJVIejVf3L5dSNXoHcx1IYfdjqJYi6oy310glAM9wjzbf6jFe29
         9WmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBcsNsBRYnPEVIs3SognI/POZ2LXPXk7FNwfE3S9g10sVIK/cvO4O0dLYg6SZHuJrNeZb1m9Itjfk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzmT+rZL7iK1A9/3pF79ViJhKO+WCB3dLPe+DRc8iQX0mGaEt0
	QU9j8h8EK4HDqIS7X/bJ08a/PLxZY/x3OVFqZd1L6G/0wAjKqy+M/c29I+ZFTEL8lZQ=
X-Gm-Gg: ASbGnctYW0zVUK8PGjVTKAyqF//N80+LJBX8G3qzfUF8dKxtHi21KA1RR4qpztPIwtW
	QYVGJrPvybOHa71wcye9FcnrDEaP1JY4WBjAUf7sNDrYqd8H1zF8a7lnI5tDJCcsm6BS8TBkhNC
	gZvNmu5u9zTMTFx81DUQDFvsQgZjVIzjy9QIj3iGBbYDF/i8yOCUfJrBafNeg0jAkvv+AJCfU+0
	D0SQgozuAZL5cTErT7kXnl7kmWTnvCCdJH7WHJT/nFobDZ7GGgjoQXrMAfhWJysZelYELMp6xMu
	HZZfqt5WUuiiVRE0e0d+JtCAV736jw8+CA8hOOp7wwhFABFoCJcr2mOrdAc=
X-Google-Smtp-Source: AGHT+IHu2BF42kNiuIy1z+5pAukmZK8j1poSZ6IXSr+HxLW4ZC3Ou+VtHvrYEWOPGd4uoBcNJEAYGw==
X-Received: by 2002:a05:6000:2505:b0:3a3:6e62:d8e8 with SMTP id ffacd0b85a97d-3a4cb4a9776mr12850388f8f.55.1748431349621;
        Wed, 28 May 2025 04:22:29 -0700 (PDT)
Received: from [192.168.0.14] ([79.115.63.75])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4eacd78ddsm1217811f8f.77.2025.05.28.04.22.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 May 2025 04:22:29 -0700 (PDT)
Message-ID: <3a47fc82-dc21-46c3-873d-68e713304af3@linaro.org>
Date: Wed, 28 May 2025 12:22:27 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: Re: [PATCH 24/25] PCI: Perform reset_resource() and build fail list
 in sync
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
Content-Language: en-US
In-Reply-To: <8f281667-b4ef-9385-868f-93893b9d6611@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 5/6/25 4:53 PM, Ilpo Järvinen wrote:
> On Tue, 6 May 2025, Tudor Ambarus wrote:
> 
>> Hi!
>>
>> On 12/16/24 5:56 PM, Ilpo Järvinen wrote:
>>> Resetting resource is problematic as it prevent attempting to allocate
>>> the resource later, unless something in between restores the resource.
>>> Similarly, if fail_head does not contain all resources that were reset,
>>> those resource cannot be restored later.
>>>
>>> The entire reset/restore cycle adds complexity and leaving resources
>>> into reseted state causes issues to other code such as for checks done
>>> in pci_enable_resources(). Take a small step towards not resetting
>>> resources by delaying reset until the end of resource assignment and
>>> build failure list (fail_head) in sync with the reset to avoid leaving
>>> behind resources that cannot be restored (for the case where the caller
>>> provides fail_head in the first place to allow restore somewhere in the
>>> callchain, as is not all callers pass non-NULL fail_head).
>>>
>>> The Expansion ROM check is temporarily left in place while building the
>>> failure list until the upcoming change which reworks optional resource
>>> handling.
>>>
>>> Ideally, whole resource reset could be removed but doing that in a big
>>> step would make the impact non-tractable due to complexity of all
>>> related code.
>>>
>>> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>>
>> I'm hitting the BUG_ON(!list_empty(&add_list)); in
>> pci_assign_unassigned_bus_resources() [1] with 6.15-rc5 and the the
>> pixel6 downstream pcie driver.
>>
>> I saw the thread where "a34d74877c66 PCI: Restore assigned resources
>> fully after release" fixes things for some other cases, but it's not the
>> case here.
>>
>> Reverting the following patches fixes the problem:
>> a34d74877c66 PCI: Restore assigned resources fully after release
>> 2499f5348431 PCI: Rework optional resource handling
>> 96336ec70264 PCI: Perform reset_resource() and build fail list in sync
> 
> So it's confirmed that you needed to revert also this last commit 
> 96336ec70264, not just the rework change?

I needed to revert 96336ec70264 as well otherwise the build fails.
> 
>> In the working case the add_list list is empty throughout the entire
>> body of pci_assign_unassigned_bus_resources().
>>
>> In the failing case __pci_bus_size_bridges() leaves the add_list not
>> empty and __pci_bus_assign_resources() does not consume the list, thus
>> the BUG_ON. The failing case contains an extra print that's not shown
>> when reverting the blamed commits:
>> [   13.951185][ T1101] pcieport 0000:00:00.0: bridge window [mem
>> 0x00100000-0x001fffff] to [bus 01-ff] add_size 100000 add_align 100000
>>
>> I've added some prints trying to describe the code path, see
>> https://paste.ofcode.org/Aeu2YBpLztc49ZDw3uUJmd#
>>
>> Failing case:
>> [   13.944231][ T1101] pci 0000:01:00.0: [144d:a5a5] type 00 class
>> 0x000000 PCIe Endpoint
>> [   13.944412][ T1101] pci 0000:01:00.0: BAR 0 [mem
>> 0x00000000-0x000fffff 64bit]
>> [   13.944532][ T1101] pci 0000:01:00.0: ROM [mem 0x00000000-0x0000ffff
>> pref]
>> [   13.944649][ T1101] pci 0000:01:00.0: enabling Extended Tags
>> [   13.944844][ T1101] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
>> [   13.945015][ T1101] pci 0000:01:00.0: 15.752 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x2 link at 0000:00:00.0 (capable of
>> 31.506 Gb/s with 16.0 GT/s PCIe x2 link)
>> [   13.950616][ T1101] __pci_bus_size_bridges: before pbus_size_mem.
>> list empty? 1
>> [   13.950784][ T1101] pbus_size_mem: 2. list empty? 1
>> [   13.950886][ T1101] pbus_size_mem: 1 list empty? 0
>> [   13.950982][ T1101] pbus_size_mem: 3. list empty? 0
>> [   13.951082][ T1101] pbus_size_mem: 4. list empty? 0
>> [   13.951185][ T1101] pcieport 0000:00:00.0: bridge window [mem
>> 0x00100000-0x001fffff] to [bus 01-ff] add_size 100000 add_align 100000
>> [   13.951448][ T1101] __pci_bus_size_bridges: after pbus_size_mem. list
>> empty? 0
>> [   13.951643][ T1101] pci_assign_unassigned_bus_resources: before
>> __pci_bus_assign_resources -> list empty? 0
>> [   13.951924][ T1101] pcieport 0000:00:00.0: bridge window [mem
>> 0x40000000-0x401fffff]: assigned
>> [   13.952248][ T1101] pci_assign_unassigned_bus_resources: after
>> __pci_bus_assign_resources -> list empty? 0
>> [   13.952634][ T1101] ------------[ cut here ]------------
>> [   13.952818][ T1101] kernel BUG at drivers/pci/setup-bus.c:2514!
>> [   13.953045][ T1101] Internal error: Oops - BUG: 00000000f2000800 [#1]
>>  SMP
>> ...
>> [   13.976086][ T1101] Call trace:
>> [   13.976206][ T1101]  pci_assign_unassigned_bus_resources+0x110/0x114 (P)
>> [   13.976462][ T1101]  pci_rescan_bus+0x28/0x48
>> [   13.976628][ T1101]  exynos_pcie_rc_poweron
>>
>> Working case:
>> [   13.786961][ T1120] pci 0000:01:00.0: [144d:a5a5] type 00 class
>> 0x000000 PCIe Endpoint
>> [   13.787136][ T1120] pci 0000:01:00.0: BAR 0 [mem
>> 0x00000000-0x000fffff 64bit]
>> [   13.787280][ T1120] pci 0000:01:00.0: ROM [mem 0x00000000-0x0000ffff
>> pref]
>> [   13.787541][ T1120] pci 0000:01:00.0: enabling Extended Tags
>> [   13.787808][ T1120] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
>> [   13.787988][ T1120] pci 0000:01:00.0: 15.752 Gb/s available PCIe
>> bandwidth, limited by 8.0 GT/s PCIe x2 link at 0000:00:00.0 (capable of
>> 31.506 Gb/s with 16.0 GT/s PCIe x2 link)
>> [   13.795279][ T1120] __pci_bus_size_bridges: before pbus_size_mem.
>> list empty? 1
>> [   13.795408][ T1120] pbus_size_mem: 2. list empty? 1
>> [   13.795495][ T1120] pbus_size_mem: 2. list empty? 1
>> [   13.795577][ T1120] __pci_bus_size_bridges: after pbus_size_mem. list
>> empty? 1
>> [   13.795692][ T1120] pci_assign_unassigned_bus_resources: before
>> __pci_bus_assign_resources -> list empty? 1
>> [   13.795849][ T1120] pcieport 0000:00:00.0: bridge window [mem
>> 0x40000000-0x401fffff]: assigned
>> [   13.796072][ T1120] pci_assign_unassigned_bus_resources: after
>> __pci_bus_assign_resources -> list empty? 1
>> [   13.796662][ T1120] cpif: s5100_poweron_pcie: DBG: MSI sfr not set
>> up, yet(s5100_pdev is NULL)
>> [   13.796666][ T1120] cpif: register_pcie: s51xx_pcie_init start
>>
>>
>> Any hints are welcomed. Thanks,
>> ta
> 
> Hi and thanks for the report.

Hi! Thanks for the help. I've been out of office for the last 2 weeks,
sorry for the delayed reply.

> 
> The interesting part occurs inside reassign_resources_sorted() where most 
> items are eliminated from realloc_head by the list_del().
> 
> My guess is that somehow, the change in 96336ec70264 from !res->flags
> to the more complicated check somehow causes this. If the new check 
> doesn't match and subsequently, no match is found from the head list, the 
> loop will do continue and not remove the entry from realloc_head.

I added a print right there and it seems it's something else. See below.
> 
> But it's hard to confirm without knowing what that resources realloc_head 
> contains. Perhaps if you print the resources that are processed around 
> that part of the code in reassign_resources_sorted(), comparing the log 
> from the reverted code with the non-working case might help to understand 
> what is different there and why. To understand better what is in the head 
> list, it would be also useful to know from which device the resources were 
> added into the head list in pdev_sort_resources().
> 

I added the suggested prints
(https://paste.ofcode.org/DgmZGGgS6D36nWEzmfCqMm) on top of v6.15 with
the downstream PCIe pixel driver and I obtain the following. Note that
all added prints contain "tudor" for differentiation.

[   15.211179][ T1107] pci 0001:01:00.0: [144d:a5a5] type 00 class
0x000000 PCIe Endpoint
[   15.212248][ T1107] pci 0001:01:00.0: BAR 0 [mem
0x00000000-0x000fffff 64bit]
[   15.212775][ T1107] pci 0001:01:00.0: ROM [mem 0x00000000-0x0000ffff
pref]
[   15.213195][ T1107] pci 0001:01:00.0: enabling Extended Tags
[   15.213720][ T1107] pci 0001:01:00.0: PME# supported from D0 D3hot
D3cold
[   15.214035][ T1107] pci 0001:01:00.0: 15.752 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x2 link at 0001:00:00.0 (capable of
31.506 Gb/s with 16.0 GT/s PCIe x2 link)
[   15.222286][ T1107] pci 0001:01:00.0: tudor: 1: pbus_size_mem: BAR 0
[mem 0x00000000-0x000fffff 64bit] list empty? 1
[   15.222813][ T1107] pci 0001:01:00.0: tudor: 1: pbus_size_mem: ROM
[mem 0x00000000-0x0000ffff pref] list empty? 1
[   15.224429][ T1107] pci 0001:01:00.0: tudor: 2: pbus_size_mem: ROM
[mem 0x00000000-0x0000ffff pref] list empty? 0
[   15.224750][ T1107] pcieport 0001:00:00.0: bridge window [mem
0x00100000-0x001fffff] to [bus 01-ff] add_size 100000 add_align 100000

[   15.225393][ T1107] tudor : pci_assign_unassigned_bus_resources:
before __pci_bus_assign_resources -> list empty? 0
[   15.225594][ T1107] pcieport 0001:00:00.0: tudor:
pdev_sort_resources: bridge window [mem 0x00100000-0x001fffff] resource
added in head list
[   15.226078][ T1107] pcieport 0001:00:00.0: bridge window [mem
0x40000000-0x401fffff]: assigned
[   15.226419][ T1107] tudor : pci_assign_unassigned_bus_resources:
after __pci_bus_assign_resources -> list empty? 0
[   15.226442][ T1107] ------------[ cut here ]------------
[   15.227587][ T1107] kernel BUG at drivers/pci/setup-bus.c:2522!
[   15.227813][ T1107] Internal error: Oops - BUG: 00000000f2000800 [#1]
 SMP
...
[   15.251570][ T1107] Call trace:
[   15.251690][ T1107]  pci_assign_unassigned_bus_resources+0x110/0x114 (P)
[   15.251945][ T1107]  pci_rescan_bus+0x28/0x48

I obtain the following output when using the same prints adapted
(https://paste.ofcode.org/37w7RnKkPaCxyNhi5yhZPbZ) and with the blamed
commits reverted:
a34d74877c66 PCI: Restore assigned resources fully after release
2499f5348431 PCI: Rework optional resource handling
96336ec70264 PCI: Perform reset_resource() and build fail list in sync

[   15.200456][ T1102] pci 0000:01:00.0: [144d:a5a5] type 00 class
0x000000 PCIe Endpoint
[   15.200632][ T1102] pci 0000:01:00.0: BAR 0 [mem
0x00000000-0x000fffff 64bit]
[   15.200755][ T1102] pci 0000:01:00.0: ROM [mem 0x00000000-0x0000ffff
pref]
[   15.200876][ T1102] pci 0000:01:00.0: enabling Extended Tags
[   15.201075][ T1102] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
[   15.201254][ T1102] pci 0000:01:00.0: 15.752 Gb/s available PCIe
bandwidth, limited by 8.0 GT/s PCIe x2 link at 0000:00:00.0 (capable of
31.506 Gb/s with 16.0 GT/s PCIe x2 link)
[   15.206555][ T1102] pci 0000:01:00.0: tudor: 1: pbus_size_mem: BAR 0
[mem 0x00000000-0x000fffff 64bit] list empty? 1
[   15.206737][ T1102] pci 0000:01:00.0: tudor: 1: pbus_size_mem: ROM
[mem 0x00000000-0x0000ffff pref] list empty? 1
[   15.206901][ T1102] tudor : pci_assign_unassigned_bus_resources:
before __pci_bus_assign_resources -> list empty? 1
[   15.207072][ T1102] pcieport 0000:00:00.0: tudor:
pdev_sort_resources: bridge window [mem 0x00100000-0x002fffff] resource
added in head list
[   15.207396][ T1102] pcieport 0000:00:00.0: bridge window [mem
0x40000000-0x401fffff]: assigned
[   15.208165][ T1102] tudor : pci_assign_unassigned_bus_resources:
after __pci_bus_assign_resources -> list empty? 1
[   15.208783][ T1102] cpif: s5100_poweron_pcie: DBG: MSI sfr not set
up, yet(s5100_pdev is NULL)
[   15.208786][ T1102] cpif: register_pcie: s51xx_pcie_init start

> In any case, that BUG_ON() seems a bit drastic action for what might be 
> just a single resource allocation failure so it should be downgraded to:
> 
> if (WARN_ON(!list_empty(&add_list))
> 	free_list(&add_list);
> 	
> ... or WARN_ON_ONCE().

I saw your patch doing this, the phone now boots, but obviously I still
see the WARN, so maybe there's still something to be fixed.

Thanks!
ta

