Return-Path: <linux-pci+bounces-25332-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 080EBA7CA8A
	for <lists+linux-pci@lfdr.de>; Sat,  5 Apr 2025 19:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C2443B774E
	for <lists+linux-pci@lfdr.de>; Sat,  5 Apr 2025 17:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FA217995E;
	Sat,  5 Apr 2025 17:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="aXrl7SbA"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B720615746F;
	Sat,  5 Apr 2025 17:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743873062; cv=none; b=CxbZt9f/JEQvNEkVEiCqMX4Xdyc4KVtd8rMVUkf5ajMwQAIabvulD4l7SG222AcCvVlSa2P2epjuD8zIekYjYo44uiojerrtQ2fYhfvQAXsXluWWN7+7Gy8Or1LuDnWGiOHrHCvNHjkGOiDkrn47BLPtzTm3VojIELZhPn5hQtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743873062; c=relaxed/simple;
	bh=JqX86buw9HHooGIvsI0QsPGGPblozuLApWe0OsA9GRw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RhymAysD8pj9oYmuIQaXXsWbLddWxHRzs1YsBCF5nGQu4TV6n6H6W6kZaAALnNrGJBAGCHdbCm9lrxk3XHT2wBms6Vv2RYd3ZFTqqQXPZNS0+ekuqqfi2dAiiK/ULHXL/QHlicUoXTm4vJu2g1Q1gEsVSQUbVQhvQiOOOdIYKKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=aXrl7SbA; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=A6OD+nPI3zJQy3gtWa6Pq3ez60axHp3q2+HfcZNxkxo=;
	b=aXrl7SbA8gu2qJU8/UG8FP0vdx8c2FVx8N+Dw2v+4MDUtc9QhVXMQyO0XpzIhT
	eLjHZ1+j9YneUEr3nCoMQNAL/liaRgquVXb85DXG/4Q0iYc9UONF946Qv3X4rS5j
	sODPumDfAO6Ky02VzIidiAMn2ObBw554pftwOVMNIEoVI=
Received: from [192.168.71.89] (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3PlsIZPFnVxK1CA--.4162S2;
	Sun, 06 Apr 2025 01:10:33 +0800 (CST)
Message-ID: <ce8bf6d5-9783-4bb5-9aa3-1c697978084f@163.com>
Date: Sun, 6 Apr 2025 01:10:32 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pci: tegra194: Fix debugfs cleanup for !CONFIG_PCIEASPM
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: bhelgaas@google.com, jonathanh@nvidia.com, kw@linux.com,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-tegra@vger.kernel.org, lpieralisi@kernel.org,
 manivannan.sadhasivam@linaro.org, robh@kernel.org, thierry.reding@gmail.com
References: <20250405152818.GA107831@bhelgaas>
 <c52ac489-51e9-4803-bf64-2bb6cfbf30bf@163.com>
 <da261a4c-6c27-454f-b21d-af1814b58b91@wanadoo.fr>
 <fa44eac9-8986-46d2-899d-df8811131925@163.com>
 <9dcd70b1-a146-419f-aa5e-bacf52cf81e8@163.com>
 <c0c1476c-75a2-4d45-83a2-4751a7487892@wanadoo.fr>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <c0c1476c-75a2-4d45-83a2-4751a7487892@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3PlsIZPFnVxK1CA--.4162S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGryxJF4fAr4DKFy5Ar1DKFg_yoWrJrW3p3
	ykG3W5Kr4DJw15tr9ava1kAF1ft3ykAr1UX345uryIyr1vqr1rJr4Utr45uF9xur4kJF1U
	XF4Fq3W3WF15AF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jbo7NUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOhAmo2fxWvLLhQAAsf



On 2025/4/6 01:04, Christophe JAILLET wrote:
> Le 05/04/2025 à 18:47, Hans Zhang a écrit :
>>
>>
>> On 2025/4/6 00:35, Hans Zhang wrote:
>>>
>>>
>>> On 2025/4/6 00:17, Christophe JAILLET wrote:
>>>> Le 05/04/2025 à 17:49, Hans Zhang a écrit :
>>>>>
>>>>>
>>>>> On 2025/4/5 23:28, Bjorn Helgaas wrote:
>>>>>> Follow subject line capitalization convention.
>>>>>>
>>>>>> On Sat, Apr 05, 2025 at 10:54:59PM +0800, Hans Zhang wrote:
>>>>>>> When CONFIG_PCIEASPM is disabled, debugfs entries are not 
>>>>>>> created, but
>>>>>>> tegra_pcie_dw_remove() and tegra_pcie_dw_shutdown() 
>>>>>>> unconditionally call
>>>>>>> debugfs_remove_recursive(), leading to potential NULL pointer 
>>>>>>> operations.
>>>>>>>
>>>>>>> Introduce deinit_debugfs() to wrap debugfs_remove_recursive(), 
>>>>>>> which is
>>>>>>> stubbed for !CONFIG_PCIEASPM. Use this function during removal/ 
>>>>>>> shutdown to
>>>>>>> ensure debugfs cleanup only occurs when entries were initialized.
>>>>>>>
>>>>>>> This prevents kernel warnings and instability when ASPM support is
>>>>>>> disabled.
>>>>>>
>>>>>> This looks like there should be a Fixes: tag to connect this to the
>>>>>> commit that introduced the problem.
>>>>>
>>>>> Hi Bjorn,
>>>>>
>>>>> Thanks your for reply. Will add.
>>>>>
>>>>> Fixes: bb617cbd8151 (PCI: tegra194: Clean up the exit path for 
>>>>> Endpoint mode)
>>>>>
>>>>>>
>>>>>> If this is something that broke with the v6.15 merge window, we 
>>>>>> should
>>>>>> include this in v6.15 via pci/for-linus.  If this broke earlier, we
>>>>>> would have to decide whether pci/for-linus is still appropriate or a
>>>>>> stable tag.
>>>>>>
>>>>>
>>>>> The original code that introduced the unconditional 
>>>>> `debugfs_remove_recursive()` calls was actually merged in an 
>>>>> earlier cycle.
>>>>>
>>>>>> We did merge some debugfs things for v6.15, but I don't see anything
>>>>>> specific to pcie-tegra194.c, so I'm confused about why this fix would
>>>>>> be in pcie-tegra194.c instead of some more generic place.
>>>>>>
>>>>>
>>>>> The Tegra194 driver conditionally initializes pcie->debugfs based 
>>>>> on CONFIG_PCIEASPM. When ASPM is disabled, pcie->debugfs remains 
>>>>> uninitialized, but tegra_pcie_dw_remove() and 
>>>>> tegra_pcie_dw_shutdown() unconditionally call 
>>>>> debugfs_remove_recursive(), leading to a NULL 
>>>>
>>>> debugfs IS initialized, because it is in a structure allocated with 
>>>> devm_kzalloc().
>>>>
>>>> And debugfs functions handle such cases.
>>>>
>>>
>>> Oh, my mind went wrong and I didn't pay attention to devm, and I'm 
> 
> Here, what is relevant in devm_kzalloc() is not devm but the kzalloc 
> part. the "z" is for zeroing the allocated memory.
> 

Hi Christophe,

Thanks your for reply. I understand.

>>> really sorry about that.
>>>
>>> Another problem I noticed here is that currently, no matter what, 
>>> pcie->debugfs = debugfs_create_dir(name, NULL) is executed; if #if 
>>> defined(CONFIG_PCIEASPM) is valid, then pcie->debugfs = 
>>> debugfs_create_dir(name, NULL); Is it superfluous?
>>
>> Sorry, let me reply again:
>> Another problem I noticed here is that currently, no matter what, 
>> pcie-  >debugfs = debugfs_create_dir(name, NULL) is executed; if #if 
>> defined(CONFIG_PCIEASPM) is invalid, then pcie->debugfs = 
>> debugfs_create_dir(name, NULL); Is it superfluous?
> 
> AFAICT, it looks useless in this case.
> 
> I guess that moving debugfs_create_dir() and the
> name = devm_kasprintf()...
> above it, into init_debugfs() would do the trick.

That's what I was thinking. I will submit the version again in the future.

Best regards,
Hans


