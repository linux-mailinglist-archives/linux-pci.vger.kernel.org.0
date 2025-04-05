Return-Path: <linux-pci+bounces-25330-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FCBA7CA56
	for <lists+linux-pci@lfdr.de>; Sat,  5 Apr 2025 18:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEF2F3AC1D6
	for <lists+linux-pci@lfdr.de>; Sat,  5 Apr 2025 16:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D84A1547FF;
	Sat,  5 Apr 2025 16:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="l55OxA1w"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004114502A;
	Sat,  5 Apr 2025 16:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743871679; cv=none; b=OkbzTfbvsapAaTP63i7pP1m19KQZtYiiFDYLc0TFHeKDH6IukmyHhJtWljsxKKjeIR9KQyyG83DcvzoU6fL5D3sg4YTp2japBrGPwfcYmIT6WYFPCrwEL/hBiVYb3eJaIZoxsJggHWrifU7c4By0/752MJ9iJKE8uT8HBsF5tVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743871679; c=relaxed/simple;
	bh=9BGLYqTQZu2s7kzI0dsjUtxU1pnjhjkWcecnNApDEUM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=BieTnR5CPPDiuGNLpr889hvJuHJdH79hM3OtZBNW2L9qElt+dNSHBLis8jBiu0NZUyK40wBv5wt0/vkgfSjF5v7j2TUv938LuhrdfpOnSs/6D9VVd5u8xMea2MYjx3AxkFfPhTBigtEpbNhOxRNGmeckfgrB7xUi2A1vrd2g9io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=l55OxA1w; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=MDq1cM7gEdiK3Cx5k/Cw1x0umVJ9hEJWVQHhrti4x+E=;
	b=l55OxA1w3Ne6EVRXZr1+QCnc6P2cEIQqyoDUVyyljagj6H3l8gmmXUSJ2lHIum
	9yIW+UgGwmsdCJynOPksX3pLhPuvsIQ/LQaUfeLv5ckrIumqA1Ib1y1fS4am/Y5H
	EBbrg6OzyuMjCfadC6NcNI1bJrOrDWRSTURV+sq22BWv0=
Received: from [192.168.71.89] (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wCHIJWXXvFnNg2yCA--.4226S2;
	Sun, 06 Apr 2025 00:47:20 +0800 (CST)
Message-ID: <9dcd70b1-a146-419f-aa5e-bacf52cf81e8@163.com>
Date: Sun, 6 Apr 2025 00:47:19 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pci: tegra194: Fix debugfs cleanup for !CONFIG_PCIEASPM
From: Hans Zhang <18255117159@163.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: bhelgaas@google.com, jonathanh@nvidia.com, kw@linux.com,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-tegra@vger.kernel.org, lpieralisi@kernel.org,
 manivannan.sadhasivam@linaro.org, robh@kernel.org, thierry.reding@gmail.com
References: <20250405152818.GA107831@bhelgaas>
 <c52ac489-51e9-4803-bf64-2bb6cfbf30bf@163.com>
 <da261a4c-6c27-454f-b21d-af1814b58b91@wanadoo.fr>
 <fa44eac9-8986-46d2-899d-df8811131925@163.com>
Content-Language: en-US
In-Reply-To: <fa44eac9-8986-46d2-899d-df8811131925@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCHIJWXXvFnNg2yCA--.4226S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZr4UCw1kZrWrAF1UtFWUArb_yoW5ArW7p3
	ykGay5KF4DAw1ft3sa9a1kAF1ft395Zr17X345uryIyw4vvr1rXr47KF4Y9Fyfur4kGF18
	XF4Fv3WfuFn0yF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UyUDAUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDxwmo2fxWi1E5gABsU



On 2025/4/6 00:35, Hans Zhang wrote:
> 
> 
> On 2025/4/6 00:17, Christophe JAILLET wrote:
>> Le 05/04/2025 à 17:49, Hans Zhang a écrit :
>>>
>>>
>>> On 2025/4/5 23:28, Bjorn Helgaas wrote:
>>>> Follow subject line capitalization convention.
>>>>
>>>> On Sat, Apr 05, 2025 at 10:54:59PM +0800, Hans Zhang wrote:
>>>>> When CONFIG_PCIEASPM is disabled, debugfs entries are not created, but
>>>>> tegra_pcie_dw_remove() and tegra_pcie_dw_shutdown() unconditionally 
>>>>> call
>>>>> debugfs_remove_recursive(), leading to potential NULL pointer 
>>>>> operations.
>>>>>
>>>>> Introduce deinit_debugfs() to wrap debugfs_remove_recursive(), 
>>>>> which is
>>>>> stubbed for !CONFIG_PCIEASPM. Use this function during removal/ 
>>>>> shutdown to
>>>>> ensure debugfs cleanup only occurs when entries were initialized.
>>>>>
>>>>> This prevents kernel warnings and instability when ASPM support is
>>>>> disabled.
>>>>
>>>> This looks like there should be a Fixes: tag to connect this to the
>>>> commit that introduced the problem.
>>>
>>> Hi Bjorn,
>>>
>>> Thanks your for reply. Will add.
>>>
>>> Fixes: bb617cbd8151 (PCI: tegra194: Clean up the exit path for 
>>> Endpoint mode)
>>>
>>>>
>>>> If this is something that broke with the v6.15 merge window, we should
>>>> include this in v6.15 via pci/for-linus.  If this broke earlier, we
>>>> would have to decide whether pci/for-linus is still appropriate or a
>>>> stable tag.
>>>>
>>>
>>> The original code that introduced the unconditional 
>>> `debugfs_remove_recursive()` calls was actually merged in an earlier 
>>> cycle.
>>>
>>>> We did merge some debugfs things for v6.15, but I don't see anything
>>>> specific to pcie-tegra194.c, so I'm confused about why this fix would
>>>> be in pcie-tegra194.c instead of some more generic place.
>>>>
>>>
>>> The Tegra194 driver conditionally initializes pcie->debugfs based on 
>>> CONFIG_PCIEASPM. When ASPM is disabled, pcie->debugfs remains 
>>> uninitialized, but tegra_pcie_dw_remove() and 
>>> tegra_pcie_dw_shutdown() unconditionally call 
>>> debugfs_remove_recursive(), leading to a NULL 
>>
>> debugfs IS initialized, because it is in a structure allocated with 
>> devm_kzalloc().
>>
>> And debugfs functions handle such cases.
>>
> 
> Oh, my mind went wrong and I didn't pay attention to devm, and I'm 
> really sorry about that.
> 
> Another problem I noticed here is that currently, no matter what, 
> pcie->debugfs = debugfs_create_dir(name, NULL) is executed; if #if 
> defined(CONFIG_PCIEASPM) is valid, then pcie->debugfs = 
> debugfs_create_dir(name, NULL); Is it superfluous?

Sorry, let me reply again:
Another problem I noticed here is that currently, no matter what, 
pcie->debugfs = debugfs_create_dir(name, NULL) is executed; if #if 
defined(CONFIG_PCIEASPM) is invalid, then pcie->debugfs = 
debugfs_create_dir(name, NULL); Is it superfluous?

Best regards,
Hans


