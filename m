Return-Path: <linux-pci+bounces-25331-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1BCA7CA69
	for <lists+linux-pci@lfdr.de>; Sat,  5 Apr 2025 19:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0EBA3B4873
	for <lists+linux-pci@lfdr.de>; Sat,  5 Apr 2025 17:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85DE71624E9;
	Sat,  5 Apr 2025 17:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Yrg8cb0h"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-20.smtpout.orange.fr [80.12.242.20])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E6C1547FF;
	Sat,  5 Apr 2025 17:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743872685; cv=none; b=QrJFI7p4tklVFJ+vdCOfhoTnqgX4/J8igr8my4FnUoM7LwHOSTuoffTflKpFr3rxeGBEXKV/AZ3hZsZIg0R9QwOS84SEh8FUo43fS7GqNcj3IBQ/4BV8vRD28+vUKgXeoP3hyeROzY4pzM0xKRSiRaRt51U9cE7emrDDcCbnYBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743872685; c=relaxed/simple;
	bh=x6vJorC7CCB06TsHXSak2CLHvj10aucshsXOu6l/5LQ=;
	h=Message-ID:Date:MIME-Version:Subject:References:From:To:Cc:
	 In-Reply-To:Content-Type; b=YD3Ym2v+Z37C30xWS2TKCl6Ju4JSMT6zTg4cAy2utPCWeHv8LvRBbTF6MMuMyxh1b22lFgX6MXoTsQTsSS8totnOztGdpd/++1FvNK/DF10hurf/dvxjyTLgxVF/+IIUPn6jaG+gdjqGJ6SW7WZq1/YicmuJdOEi9clF94Zqlpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=Yrg8cb0h; arc=none smtp.client-ip=80.12.242.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id 16weujbtUB4qz16whugCaF; Sat, 05 Apr 2025 19:04:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1743872680;
	bh=0pn3FlBiCPwJnTvXthRIxPP8fbFuHWesKZt8cTu3Qlo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To;
	b=Yrg8cb0hgmqiMiJQZjbsltBQpElSa1erz6auxeo5Dhl+urBMDlUY1LK2FruJxsbqI
	 HdLZsWZRyX/OW6SsIH3LL4oc38tj55pn0Y9ZIdyaTkZfPO4ygKrygBtwIXC+MWv0hF
	 +B4GbOTiLzGoyAzhPgGUd9H1zm9cZ2AhhYRH80BQv7qsCkHPSKf86NCN+nNodkH9KS
	 uVySt530mupOsMa4eUMMMYWy40xhuBf3u/q56hcKTqif2OUOqcuPJAnWoNpmfPRMq3
	 cSL8eaVIzwVr/DKaUv8fajGNpe8WIwWXWyjZK9x6UrcyBHqCPzNjfxIxl4bo0w6VYi
	 VzteoWvQ/8WtQ==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Sat, 05 Apr 2025 19:04:40 +0200
X-ME-IP: 90.11.132.44
Message-ID: <c0c1476c-75a2-4d45-83a2-4751a7487892@wanadoo.fr>
Date: Sat, 5 Apr 2025 19:04:36 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pci: tegra194: Fix debugfs cleanup for !CONFIG_PCIEASPM
References: <20250405152818.GA107831@bhelgaas>
 <c52ac489-51e9-4803-bf64-2bb6cfbf30bf@163.com>
 <da261a4c-6c27-454f-b21d-af1814b58b91@wanadoo.fr>
 <fa44eac9-8986-46d2-899d-df8811131925@163.com>
 <9dcd70b1-a146-419f-aa5e-bacf52cf81e8@163.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: 18255117159@163.com
Cc: bhelgaas@google.com, jonathanh@nvidia.com, kw@linux.com,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-tegra@vger.kernel.org, lpieralisi@kernel.org,
 manivannan.sadhasivam@linaro.org, robh@kernel.org, thierry.reding@gmail.com
In-Reply-To: <9dcd70b1-a146-419f-aa5e-bacf52cf81e8@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 05/04/2025 à 18:47, Hans Zhang a écrit :
> 
> 
> On 2025/4/6 00:35, Hans Zhang wrote:
>>
>>
>> On 2025/4/6 00:17, Christophe JAILLET wrote:
>>> Le 05/04/2025 à 17:49, Hans Zhang a écrit :
>>>>
>>>>
>>>> On 2025/4/5 23:28, Bjorn Helgaas wrote:
>>>>> Follow subject line capitalization convention.
>>>>>
>>>>> On Sat, Apr 05, 2025 at 10:54:59PM +0800, Hans Zhang wrote:
>>>>>> When CONFIG_PCIEASPM is disabled, debugfs entries are not created, 
>>>>>> but
>>>>>> tegra_pcie_dw_remove() and tegra_pcie_dw_shutdown() 
>>>>>> unconditionally call
>>>>>> debugfs_remove_recursive(), leading to potential NULL pointer 
>>>>>> operations.
>>>>>>
>>>>>> Introduce deinit_debugfs() to wrap debugfs_remove_recursive(), 
>>>>>> which is
>>>>>> stubbed for !CONFIG_PCIEASPM. Use this function during removal/ 
>>>>>> shutdown to
>>>>>> ensure debugfs cleanup only occurs when entries were initialized.
>>>>>>
>>>>>> This prevents kernel warnings and instability when ASPM support is
>>>>>> disabled.
>>>>>
>>>>> This looks like there should be a Fixes: tag to connect this to the
>>>>> commit that introduced the problem.
>>>>
>>>> Hi Bjorn,
>>>>
>>>> Thanks your for reply. Will add.
>>>>
>>>> Fixes: bb617cbd8151 (PCI: tegra194: Clean up the exit path for 
>>>> Endpoint mode)
>>>>
>>>>>
>>>>> If this is something that broke with the v6.15 merge window, we should
>>>>> include this in v6.15 via pci/for-linus.  If this broke earlier, we
>>>>> would have to decide whether pci/for-linus is still appropriate or a
>>>>> stable tag.
>>>>>
>>>>
>>>> The original code that introduced the unconditional 
>>>> `debugfs_remove_recursive()` calls was actually merged in an earlier 
>>>> cycle.
>>>>
>>>>> We did merge some debugfs things for v6.15, but I don't see anything
>>>>> specific to pcie-tegra194.c, so I'm confused about why this fix would
>>>>> be in pcie-tegra194.c instead of some more generic place.
>>>>>
>>>>
>>>> The Tegra194 driver conditionally initializes pcie->debugfs based on 
>>>> CONFIG_PCIEASPM. When ASPM is disabled, pcie->debugfs remains 
>>>> uninitialized, but tegra_pcie_dw_remove() and 
>>>> tegra_pcie_dw_shutdown() unconditionally call 
>>>> debugfs_remove_recursive(), leading to a NULL 
>>>
>>> debugfs IS initialized, because it is in a structure allocated with 
>>> devm_kzalloc().
>>>
>>> And debugfs functions handle such cases.
>>>
>>
>> Oh, my mind went wrong and I didn't pay attention to devm, and I'm 

Here, what is relevant in devm_kzalloc() is not devm but the kzalloc 
part. the "z" is for zeroing the allocated memory.

>> really sorry about that.
>>
>> Another problem I noticed here is that currently, no matter what, 
>> pcie->debugfs = debugfs_create_dir(name, NULL) is executed; if #if 
>> defined(CONFIG_PCIEASPM) is valid, then pcie->debugfs = 
>> debugfs_create_dir(name, NULL); Is it superfluous?
> 
> Sorry, let me reply again:
> Another problem I noticed here is that currently, no matter what, pcie- 
>  >debugfs = debugfs_create_dir(name, NULL) is executed; if #if 
> defined(CONFIG_PCIEASPM) is invalid, then pcie->debugfs = 
> debugfs_create_dir(name, NULL); Is it superfluous?

AFAICT, it looks useless in this case.

I guess that moving debugfs_create_dir() and the
name = devm_kasprintf()...
above it, into init_debugfs() would do the trick.

CJ

> 
> Best regards,
> Hans
> 
> 
> 


