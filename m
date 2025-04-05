Return-Path: <linux-pci+bounces-25327-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D69CCA7CA3F
	for <lists+linux-pci@lfdr.de>; Sat,  5 Apr 2025 18:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0F5C7A763A
	for <lists+linux-pci@lfdr.de>; Sat,  5 Apr 2025 16:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9F21537DA;
	Sat,  5 Apr 2025 16:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="j8gemYBm"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-24.smtpout.orange.fr [80.12.242.24])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA2F2C9D;
	Sat,  5 Apr 2025 16:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743870390; cv=none; b=Jr2sF2foBmw7Xunwjq7N54+WCFKClm5/Fji1KQvxNDM2nBiTvr1YlTmmkjXrewrWOlNhbaJoiQb/G6JQAJfYijcPaYnFZbhFfQHWB1qMTpew9zDjvVAv7vW5JD6SBbrfRpdOC9I0YcK8Yjk8HoqWXzQJHX1WtuyONtu0yGmk1VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743870390; c=relaxed/simple;
	bh=mYq9OKULKeqOBXMkGiEw/GWMKLrP18Gu6bJE+ZmUXSc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=WwuHZlAZe4ofbH6AKxGPnJn4O/pVqtDEqaei9EpY9ZRPPqfN1NXJaG2n5jiPPKfueLBMYxdfBC4KC871pS8rOyYvcQ/iq5QE/0s0DfCoiJ0vL8wJPckxvai78zRv/n9YpqAyTywmEzVsVA3g1UzatJfGcIqgg5TsWcF8ygDb6GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=j8gemYBm; arc=none smtp.client-ip=80.12.242.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id 16CiuEOpJD5XP16Cmu4Amd; Sat, 05 Apr 2025 18:17:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1743869834;
	bh=8Tm1DIxWvLsvP/29X659pawW7f1pRJuuvMiLNwxibuU=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=j8gemYBm8JtPHPA7uomST3S3QhTXO4w27OLLk1fo+KAcX82J+2aGxS1LeG+35vnmK
	 KMBzVt/l4DCVx7fvL3tMLPkGNBozNS2Io13ZSXOcd1J3vomsnpqSDTfaxsh+F/b4hE
	 rJeRs1mXEThSToV18LvV+LXhjp7Q/4KhT6hHMKmKq0ycoP1+V8bHE5It3REhLzoofz
	 maWgJiWYUrifkiQOieg2X526e1oMx8q3E/q2BE6pi9KsLvx/NYbI8EwSq+yPbbgXR7
	 5rMS/gsaNcksVOD9+K3u6nfzoewaYfSKaSHVHqme/3/oc62+o7Sd/YRXxqniFPmiQn
	 w3mk6KfEgQwEA==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Sat, 05 Apr 2025 18:17:14 +0200
X-ME-IP: 90.11.132.44
Message-ID: <da261a4c-6c27-454f-b21d-af1814b58b91@wanadoo.fr>
Date: Sat, 5 Apr 2025 18:17:08 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pci: tegra194: Fix debugfs cleanup for !CONFIG_PCIEASPM
To: 18255117159@163.com
References: <20250405152818.GA107831@bhelgaas>
 <c52ac489-51e9-4803-bf64-2bb6cfbf30bf@163.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: bhelgaas@google.com, jonathanh@nvidia.com, kw@linux.com,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-tegra@vger.kernel.org, lpieralisi@kernel.org,
 manivannan.sadhasivam@linaro.org, robh@kernel.org, thierry.reding@gmail.com
In-Reply-To: <c52ac489-51e9-4803-bf64-2bb6cfbf30bf@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 05/04/2025 à 17:49, Hans Zhang a écrit :
> 
> 
> On 2025/4/5 23:28, Bjorn Helgaas wrote:
>> Follow subject line capitalization convention.
>>
>> On Sat, Apr 05, 2025 at 10:54:59PM +0800, Hans Zhang wrote:
>>> When CONFIG_PCIEASPM is disabled, debugfs entries are not created, but
>>> tegra_pcie_dw_remove() and tegra_pcie_dw_shutdown() unconditionally call
>>> debugfs_remove_recursive(), leading to potential NULL pointer 
>>> operations.
>>>
>>> Introduce deinit_debugfs() to wrap debugfs_remove_recursive(), which is
>>> stubbed for !CONFIG_PCIEASPM. Use this function during removal/ 
>>> shutdown to
>>> ensure debugfs cleanup only occurs when entries were initialized.
>>>
>>> This prevents kernel warnings and instability when ASPM support is
>>> disabled.
>>
>> This looks like there should be a Fixes: tag to connect this to the
>> commit that introduced the problem.
> 
> Hi Bjorn,
> 
> Thanks your for reply. Will add.
> 
> Fixes: bb617cbd8151 (PCI: tegra194: Clean up the exit path for Endpoint 
> mode)
> 
>>
>> If this is something that broke with the v6.15 merge window, we should
>> include this in v6.15 via pci/for-linus.  If this broke earlier, we
>> would have to decide whether pci/for-linus is still appropriate or a
>> stable tag.
>>
> 
> The original code that introduced the unconditional 
> `debugfs_remove_recursive()` calls was actually merged in an earlier cycle.
> 
>> We did merge some debugfs things for v6.15, but I don't see anything
>> specific to pcie-tegra194.c, so I'm confused about why this fix would
>> be in pcie-tegra194.c instead of some more generic place.
>>
> 
> The Tegra194 driver conditionally initializes pcie->debugfs based on 
> CONFIG_PCIEASPM. When ASPM is disabled, pcie->debugfs remains 
> uninitialized, but tegra_pcie_dw_remove() and tegra_pcie_dw_shutdown() 
> unconditionally call debugfs_remove_recursive(), leading to a NULL 

debugfs IS initialized, because it is in a structure allocated with 
devm_kzalloc().

And debugfs functions handle such cases.

CJ

> pointer dereference. This is specific to the Tegra194 implementation, as 
> other drivers or core PCI code may already guard debugfs cleanup against 
> uninitialized states through different mechanisms.
> 
> Best regards,
> Hans
> 
> 
> 


