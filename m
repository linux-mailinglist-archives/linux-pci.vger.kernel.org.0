Return-Path: <linux-pci+bounces-27391-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A433AAE72C
	for <lists+linux-pci@lfdr.de>; Wed,  7 May 2025 18:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35CE2B20453
	for <lists+linux-pci@lfdr.de>; Wed,  7 May 2025 16:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66EF228C5B0;
	Wed,  7 May 2025 16:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="U5n41a6s"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7107628C2D9;
	Wed,  7 May 2025 16:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746636527; cv=none; b=QwI8SOGEPfnTBBDY2rVX7u5sg2DS7XR10GDRWV1LtNoj/DodaQSRQFbygGrIcOwietafp6FemsT91ozxhvk13Df5FkZ+uLI1oLlz0NBU4s0WZAKzQmaDnI6B/txr9R0wqF+KWZGNFN8733jGwjcHII69I1kvhrto1D5UpRCln+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746636527; c=relaxed/simple;
	bh=V7SF7M97q+1MYK6Hkfl9CybNPto1Pxcqsg0UIAI2GTA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u4ZhcWhEk8QpwyXUU/kUQpv2rsqU7DBOZFCZx8LJZ4trDDPYq9GChznJBrM09TaviV3WyeuUy/Wika6nvbgQkkPC9BeVv9NIcHuz2dbOM9A7hbHs3/h9UTykhi7fevRNjlPe8TllVC0lfoUbjnPbKMJPN9UzxtUm/X7GJO+EIUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=U5n41a6s; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=RFAmY2MKwdKHgLamuSXh1FUsHEdiYUg60MVKfaCdvoY=;
	b=U5n41a6szOt5DII0T5tNRMzSMBxAfvlaz7pd1kkkbJQ2ygpLyNRh27HYXcZSTV
	vL8FjA4B20MJ+/DYgoFSxHnELfuqfrOYDHt+LR6BaaIlcLzRs1vHuc9uQrgVItEt
	HkQ4DKQp6KKOhl81obXX6BAhTMMyYo+1zuMMJh3NJO6oU=
Received: from [192.168.71.93] (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wCnwFuQjhtonhXNFA--.39420S2;
	Thu, 08 May 2025 00:47:13 +0800 (CST)
Message-ID: <b364eed2-047d-4c74-9f30-45291305bc4b@163.com>
Date: Thu, 8 May 2025 00:47:12 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] PCI: aardvark: Remove redundant MPS configuration
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
 Niklas Cassel <cassel@kernel.org>
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
 <ff6abbf6-e464-4929-96e6-16e43c62db06@163.com>
 <20250507163620.53v5djmhj3ywrge2@pali>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20250507163620.53v5djmhj3ywrge2@pali>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCnwFuQjhtonhXNFA--.39420S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxuryxWFW7uF13Gw1kGr1fXrb_yoWruF4fpF
	W3XF4rAF47Jr15CF1Iq3Wvkry5tasrKry5XrZ8G343AF9Iqa45JFy2yr4rua47Xr4SkF12
	yry5XrWIvFn0yaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Um38nUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOgRGo2gbjGJKowAAsv



On 2025/5/8 00:36, Pali Rohár wrote:
> On Wednesday 07 May 2025 23:06:51 Hans Zhang wrote:
>> On 2025/5/7 23:03, Hans Zhang wrote:
>>> On 2025/5/7 01:41, Pali Rohár wrote:
>>>> On Wednesday 07 May 2025 01:34:39 Hans Zhang wrote:
>>>>> The Aardvark PCIe controller enforces a fixed 512B payload size via
>>>>> PCI_EXP_DEVCTL_PAYLOAD_512B, overriding hardware capabilities and PCIe
>>>>> core negotiations.
>>>>>
>>>>> Remove explicit MPS overrides (PCI_EXP_DEVCTL_PAYLOAD and
>>>>> PCI_EXP_DEVCTL_PAYLOAD_512B). MPS is now determined by the PCI core
>>>>> during device initialization, leveraging root port configurations and
>>>>> device-specific capabilities.
>>>>>
>>>>> Aligning Aardvark with the unified MPS framework ensures consistency,
>>>>> avoids artificial constraints, and allows the hardware to operate at
>>>>> its maximum supported payload size while adhering to PCIe
>>>>> specifications.
>>>>>
>>>>> Signed-off-by: Hans Zhang <18255117159@163.com>
>>>>> ---
>>>>>    drivers/pci/controller/pci-aardvark.c | 2 --
>>>>>    1 file changed, 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/pci/controller/pci-aardvark.c
>>>>> b/drivers/pci/controller/pci-aardvark.c
>>>>> index a29796cce420..d8852892994a 100644
>>>>> --- a/drivers/pci/controller/pci-aardvark.c
>>>>> +++ b/drivers/pci/controller/pci-aardvark.c
>>>>> @@ -549,9 +549,7 @@ static void advk_pcie_setup_hw(struct
>>>>> advk_pcie *pcie)
>>>>>        reg = advk_readl(pcie, PCIE_CORE_PCIEXP_CAP + PCI_EXP_DEVCTL);
>>>>>        reg &= ~PCI_EXP_DEVCTL_RELAX_EN;
>>>>>        reg &= ~PCI_EXP_DEVCTL_NOSNOOP_EN;
>>>>> -    reg &= ~PCI_EXP_DEVCTL_PAYLOAD;
>>>>>        reg &= ~PCI_EXP_DEVCTL_READRQ;
>>>>> -    reg |= PCI_EXP_DEVCTL_PAYLOAD_512B;
>>>>>        reg |= PCI_EXP_DEVCTL_READRQ_512B;
>>>>>        advk_writel(pcie, reg, PCIE_CORE_PCIEXP_CAP + PCI_EXP_DEVCTL);
>>>>> -- 
>>>>> 2.25.1
>>>>>
>>>>
>>>> Please do not remove this code. It is required part of the
>>>> initialization of the aardvark PCI controller at the specific phase,
>>>> as defined in the Armada 3700 Functional Specification.
>>>>
>>>> There were reported more issues with those Armada PCIe controllers for
>>>> which were already sent patches to mailing list in last 5 years. But
>>>> unfortunately not all fixes were taken / applied yet.
>>>
>>> Hi Pali,
>>>
>>> I replied to you in version v2.
>>>
>>> Is the maximum MPS supported by Armada 3700 512 bytes?
> 
> IIRC yes, 512-byte mode is supported. And I think in past I was testing
> some PCIe endpoint card which required 512-byte long payload and did not
> worked in 256-byte long mode (not sure if the card was not able to split
> transaction or something other was broken, it is quite longer time).
> 
>>> What are the default values of DevCap.MPS and DevCtl.MPS?
> 
> Do you mean values in the PCI-to-PCI bridge device of PCIe Root Port
> type?
> 
> Aardvark controller does not have the real HW PCI-to-PCI bridge device.
> There is only in-kernel emulation drivers/pci/pci-bridge-emul.c which
> create fake kernel PCI device in the hierarchy to make kernel and
> userspace happy. Yes, this is deviation from the PCIe standard but well,
> buggy HW is also HW.
> 
> And same applies for the pci-mvebu.c driver for older Marvell PCIe HW.
> 
>>> Because the default value of DevCtl.MPS is not 512 bytes, it needs to be
>>> configured here, right?
>>>
>>> If it's my guess, RK3588 also has the same requirements as you, just
>>> like the first patch I submitted.
>>>
>>> Please take a look at the communication history:
>>> https://patchwork.kernel.org/project/linux-pci/patch/20250416151926.140202-1-18255117159@163.com/
>> And this:
>> https://patchwork.kernel.org/project/linux-pci/patch/20250425095708.32662-2-18255117159@163.com/
> 
> These changes are referring the to root ports PCI devices, which are not
> applicable for aardvark PCIe controller.
> 
>>>
>>> Please test it using patch 1/3 of this series. If there are any
>>> problems, please let me know.
>>>
>>>
>>> Best regards,
>>> Hans
>>
> 
> Sorry, but I stopped doing any testing of the aardvark driver with the
> mainline kernel after PCI maintainers stopped taking fixes for the
> driver and stopped responding.
> 
> I'm not going to debug same issues again, which I have analyzed,
> prepared fixes, sent patches and see no progress there.
> 
> Seems that there is a status quo, and I'm not going to change it.

Dear Niklas,

Do you have any opinion on Pali's reply? Should patch 3/3 be discarded?

Beat regards,
Hans


