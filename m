Return-Path: <linux-pci+bounces-27381-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD6EAAE3E8
	for <lists+linux-pci@lfdr.de>; Wed,  7 May 2025 17:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63BA41C037BA
	for <lists+linux-pci@lfdr.de>; Wed,  7 May 2025 15:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A555D14A639;
	Wed,  7 May 2025 15:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="iZbyWhy0"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E45145B16;
	Wed,  7 May 2025 15:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746630503; cv=none; b=AGhz6JL5R97uiJFPukLS2407T/zcMMWwVwsY2ENXdcJfwvZnMQGF+0XDMLDJ4FTXelysMu0puqMh9Ue9dM7SqQLmq/Jc96S42hUlG1VgOlFIbO6FuIWZ+LqI0vsrGjl+cVAQLjHY5Ly8AcjJ02ehvmZoHOrpEAr5Y13P+SNKvwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746630503; c=relaxed/simple;
	bh=/NP8NIpxXJrdui+MUQVIE2toGmOABlmT8JV0+yPW2TU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=IgcgpGIaubqJyAgRKR5qgOvFgrIISowq/ep3GCgMFEH8tD0Rdz2PZpmCTuSr949+/L0CNQLxYDR0D3FSb5VJj18AqMiqfeCd6A8Ohe9a0ePQnTM2h0dhlJGM3VNXg4aOdKArogaiTGMT+1lZzB33sQ9bCcniV0Y/zZ1KiOGIw5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=iZbyWhy0; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=Aak4bhl7i7wNtq2KK490ptM/CCcwRR/GDiQ+3JaJM8M=;
	b=iZbyWhy0qCtoFQqwnzANJzhS41G7lBZ5OIu7giRsfv1/lfwgSi+kogsMPKGqIb
	zwUNGs4RUA+qijCGO+txyFwzDZ2kF+N2oP51+PWl7EwSVAyUYQZAtgO+546rhhnP
	sp0M+yLFIqxzMr7/JAu+5zujfjYUUBX0qS4X/41Mjs9L4=
Received: from [192.168.71.93] (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wCXGekLdxto_mATFA--.15890S2;
	Wed, 07 May 2025 23:06:52 +0800 (CST)
Message-ID: <ff6abbf6-e464-4929-96e6-16e43c62db06@163.com>
Date: Wed, 7 May 2025 23:06:51 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] PCI: aardvark: Remove redundant MPS configuration
From: Hans Zhang <18255117159@163.com>
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc: lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
 heiko@sntech.de, manivannan.sadhasivam@linaro.org, yue.wang@Amlogic.com,
 neil.armstrong@linaro.org, robh@kernel.org, jingoohan1@gmail.com,
 khilman@baylibre.com, jbrunet@baylibre.com,
 martin.blumenstingl@googlemail.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-rockchip@lists.infradead.org
References: <20250506173439.292460-1-18255117159@163.com>
 <20250506173439.292460-4-18255117159@163.com>
 <20250506174110.63ayeqc4scmwjj6e@pali>
 <8a6adc24-5f40-4f22-9842-b211e1ef5008@163.com>
Content-Language: en-US
In-Reply-To: <8a6adc24-5f40-4f22-9842-b211e1ef5008@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCXGekLdxto_mATFA--.15890S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJw1DZw1xCw45tw43Cw43Awb_yoW5Ary8pF
	W3XF4rAFWaqr15C3W7Xa1vgryYgasFkFy5W398G343AF9Igw1UGFy2kF4rua47Jr4IkF4j
	vry3t3ySv3WYyaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UBSoXUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDx9Go2gbdD5DvQABsz



On 2025/5/7 23:03, Hans Zhang wrote:
> 
> 
> On 2025/5/7 01:41, Pali Rohár wrote:
>> On Wednesday 07 May 2025 01:34:39 Hans Zhang wrote:
>>> The Aardvark PCIe controller enforces a fixed 512B payload size via
>>> PCI_EXP_DEVCTL_PAYLOAD_512B, overriding hardware capabilities and PCIe
>>> core negotiations.
>>>
>>> Remove explicit MPS overrides (PCI_EXP_DEVCTL_PAYLOAD and
>>> PCI_EXP_DEVCTL_PAYLOAD_512B). MPS is now determined by the PCI core
>>> during device initialization, leveraging root port configurations and
>>> device-specific capabilities.
>>>
>>> Aligning Aardvark with the unified MPS framework ensures consistency,
>>> avoids artificial constraints, and allows the hardware to operate at
>>> its maximum supported payload size while adhering to PCIe 
>>> specifications.
>>>
>>> Signed-off-by: Hans Zhang <18255117159@163.com>
>>> ---
>>>   drivers/pci/controller/pci-aardvark.c | 2 --
>>>   1 file changed, 2 deletions(-)
>>>
>>> diff --git a/drivers/pci/controller/pci-aardvark.c 
>>> b/drivers/pci/controller/pci-aardvark.c
>>> index a29796cce420..d8852892994a 100644
>>> --- a/drivers/pci/controller/pci-aardvark.c
>>> +++ b/drivers/pci/controller/pci-aardvark.c
>>> @@ -549,9 +549,7 @@ static void advk_pcie_setup_hw(struct advk_pcie 
>>> *pcie)
>>>       reg = advk_readl(pcie, PCIE_CORE_PCIEXP_CAP + PCI_EXP_DEVCTL);
>>>       reg &= ~PCI_EXP_DEVCTL_RELAX_EN;
>>>       reg &= ~PCI_EXP_DEVCTL_NOSNOOP_EN;
>>> -    reg &= ~PCI_EXP_DEVCTL_PAYLOAD;
>>>       reg &= ~PCI_EXP_DEVCTL_READRQ;
>>> -    reg |= PCI_EXP_DEVCTL_PAYLOAD_512B;
>>>       reg |= PCI_EXP_DEVCTL_READRQ_512B;
>>>       advk_writel(pcie, reg, PCIE_CORE_PCIEXP_CAP + PCI_EXP_DEVCTL);
>>> -- 
>>> 2.25.1
>>>
>>
>> Please do not remove this code. It is required part of the
>> initialization of the aardvark PCI controller at the specific phase,
>> as defined in the Armada 3700 Functional Specification.
>>
>> There were reported more issues with those Armada PCIe controllers for
>> which were already sent patches to mailing list in last 5 years. But
>> unfortunately not all fixes were taken / applied yet.
> 
> Hi Pali,
> 
> I replied to you in version v2.
> 
> Is the maximum MPS supported by Armada 3700 512 bytes? What are the 
> default values of DevCap.MPS and DevCtl.MPS?
> 
> Because the default value of DevCtl.MPS is not 512 bytes, it needs to be 
> configured here, right?
> 
> If it's my guess, RK3588 also has the same requirements as you, just 
> like the first patch I submitted.
> 
> Please take a look at the communication history:
> https://patchwork.kernel.org/project/linux-pci/patch/20250416151926.140202-1-18255117159@163.com/
And this:
https://patchwork.kernel.org/project/linux-pci/patch/20250425095708.32662-2-18255117159@163.com/

> 
> Please test it using patch 1/3 of this series. If there are any 
> problems, please let me know.
> 
> 
> Best regards,
> Hans


