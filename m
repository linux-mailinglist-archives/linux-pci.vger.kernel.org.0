Return-Path: <linux-pci+bounces-27504-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABEC1AB132E
	for <lists+linux-pci@lfdr.de>; Fri,  9 May 2025 14:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 132DF1BA620C
	for <lists+linux-pci@lfdr.de>; Fri,  9 May 2025 12:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700DD274642;
	Fri,  9 May 2025 12:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="WE6X6Oe6"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D2321CC43;
	Fri,  9 May 2025 12:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746793236; cv=none; b=IYjPzHr1ZkYnf/ArX8JJvLEDmZtaIeYXV8wgL2d0jUSs9P94pBzEK0cTWSbBxdC8O3Pv3+C5EEY8y5JiMrTJJwHTjkbnWadrShyqU07tVHZdUwg+FHbFpov/UMGb2LesdMcaBBsk4N6A27dcBboYtJabyM8N1chg9mXN0EXZowI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746793236; c=relaxed/simple;
	bh=Ax9T6UkoX56Blctsz+lrpfAmrwAvmcSV3HKk+zSsLyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ByPArgAzx3AazzHdfXXjc9DyulgcWPzWr4lAiyuqBHVdY5JPCE17z+qsN5tYgkwJteiqVdXvUj0axGns5jKxiymWa1Axn/IlkVMnau0CKNmmLXRc0ym5yEOfbPpK1syE5Gso0hTv5Z2YvvbNXAf669bmpZnxTbBccBMDt+aWW4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=WE6X6Oe6; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=9Szx3j0XFQEI/UBZs807hBKYHQ3bAc/qN60fFOlHrtI=;
	b=WE6X6Oe68i2pgvx5xNscRvtTNl3LlOetrwoJA5hDiunh5b9eEwaidFRfleV8n5
	v+bysff+v0rPSbJOT1Hby7e3FKVCp67ea45gyvg7e2SS/6cmVlmS44czvB2v+aia
	fsKZBlcG59+ToQhiA3BZFRmj7Ad0b8FgffcspENpFqbac=
Received: from [192.168.142.52] (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3_5EM7x1oPsfZAA--.35294S2;
	Fri, 09 May 2025 20:03:27 +0800 (CST)
Message-ID: <78abe899-e529-49e8-9a16-a2657db666e4@163.com>
Date: Fri, 9 May 2025 20:03:24 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] PCI: aardvark: Remove redundant MPS configuration
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc: lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
 heiko@sntech.de, yue.wang@amlogic.com, neil.armstrong@linaro.org,
 robh@kernel.org, jingoohan1@gmail.com, khilman@baylibre.com,
 jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-rockchip@lists.infradead.org
References: <20250506173439.292460-1-18255117159@163.com>
 <20250506173439.292460-4-18255117159@163.com>
 <20250506174110.63ayeqc4scmwjj6e@pali>
 <8a6adc24-5f40-4f22-9842-b211e1ef5008@163.com>
 <ff6abbf6-e464-4929-96e6-16e43c62db06@163.com>
 <20250507163620.53v5djmhj3ywrge2@pali>
 <oy5wlkvp7nrg65hmbn6cwjcavkeq7emu65tsh4435gxllyb437@7ai23qsmpesy>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <oy5wlkvp7nrg65hmbn6cwjcavkeq7emu65tsh4435gxllyb437@7ai23qsmpesy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3_5EM7x1oPsfZAA--.35294S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCrW8WFWktr1rAF45Kw13twb_yoWrWFykpF
	y3XF1FyFs8Jr13CFnFqa1kKry3tasrKryrXrn8Gry3AF9IqryUGFy2yr4rua47Xr1xCF1j
	yr1YqrWSvF1Yy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07URc_hUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWwdIo2gd5xbcqQAAsG



On 2025/5/9 15:08, Manivannan Sadhasivam wrote:
> On Wed, May 07, 2025 at 06:36:20PM +0200, Pali Rohár wrote:
>> On Wednesday 07 May 2025 23:06:51 Hans Zhang wrote:
>>> On 2025/5/7 23:03, Hans Zhang wrote:
>>>> On 2025/5/7 01:41, Pali Rohár wrote:
>>>>> On Wednesday 07 May 2025 01:34:39 Hans Zhang wrote:
>>>>>> The Aardvark PCIe controller enforces a fixed 512B payload size via
>>>>>> PCI_EXP_DEVCTL_PAYLOAD_512B, overriding hardware capabilities and PCIe
>>>>>> core negotiations.
>>>>>>
>>>>>> Remove explicit MPS overrides (PCI_EXP_DEVCTL_PAYLOAD and
>>>>>> PCI_EXP_DEVCTL_PAYLOAD_512B). MPS is now determined by the PCI core
>>>>>> during device initialization, leveraging root port configurations and
>>>>>> device-specific capabilities.
>>>>>>
>>>>>> Aligning Aardvark with the unified MPS framework ensures consistency,
>>>>>> avoids artificial constraints, and allows the hardware to operate at
>>>>>> its maximum supported payload size while adhering to PCIe
>>>>>> specifications.
>>>>>>
>>>>>> Signed-off-by: Hans Zhang <18255117159@163.com>
>>>>>> ---
>>>>>>    drivers/pci/controller/pci-aardvark.c | 2 --
>>>>>>    1 file changed, 2 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/pci/controller/pci-aardvark.c
>>>>>> b/drivers/pci/controller/pci-aardvark.c
>>>>>> index a29796cce420..d8852892994a 100644
>>>>>> --- a/drivers/pci/controller/pci-aardvark.c
>>>>>> +++ b/drivers/pci/controller/pci-aardvark.c
>>>>>> @@ -549,9 +549,7 @@ static void advk_pcie_setup_hw(struct
>>>>>> advk_pcie *pcie)
>>>>>>        reg = advk_readl(pcie, PCIE_CORE_PCIEXP_CAP + PCI_EXP_DEVCTL);
>>>>>>        reg &= ~PCI_EXP_DEVCTL_RELAX_EN;
>>>>>>        reg &= ~PCI_EXP_DEVCTL_NOSNOOP_EN;
>>>>>> -    reg &= ~PCI_EXP_DEVCTL_PAYLOAD;
>>>>>>        reg &= ~PCI_EXP_DEVCTL_READRQ;
>>>>>> -    reg |= PCI_EXP_DEVCTL_PAYLOAD_512B;
>>>>>>        reg |= PCI_EXP_DEVCTL_READRQ_512B;
>>>>>>        advk_writel(pcie, reg, PCIE_CORE_PCIEXP_CAP + PCI_EXP_DEVCTL);
>>>>>> -- 
>>>>>> 2.25.1
>>>>>>
>>>>>
>>>>> Please do not remove this code. It is required part of the
>>>>> initialization of the aardvark PCI controller at the specific phase,
>>>>> as defined in the Armada 3700 Functional Specification.
>>>>>
>>>>> There were reported more issues with those Armada PCIe controllers for
>>>>> which were already sent patches to mailing list in last 5 years. But
>>>>> unfortunately not all fixes were taken / applied yet.
>>>>
>>>> Hi Pali,
>>>>
>>>> I replied to you in version v2.
>>>>
>>>> Is the maximum MPS supported by Armada 3700 512 bytes?
>>
>> IIRC yes, 512-byte mode is supported. And I think in past I was testing
>> some PCIe endpoint card which required 512-byte long payload and did not
>> worked in 256-byte long mode (not sure if the card was not able to split
>> transaction or something other was broken, it is quite longer time).
>>
>>>> What are the default values of DevCap.MPS and DevCtl.MPS?
>>
>> Do you mean values in the PCI-to-PCI bridge device of PCIe Root Port
>> type?
>>
>> Aardvark controller does not have the real HW PCI-to-PCI bridge device.
>> There is only in-kernel emulation drivers/pci/pci-bridge-emul.c which
>> create fake kernel PCI device in the hierarchy to make kernel and
>> userspace happy. Yes, this is deviation from the PCIe standard but well,
>> buggy HW is also HW.
>>
>> And same applies for the pci-mvebu.c driver for older Marvell PCIe HW.
>>
> 
> Oh. Then this patch is not going to change the MPS setting of the root bus. But
> that also means that there is a deviation in what the PCI core expects for a
> root port and what is actually programmed in the hw.
> 
> Even in this MPS case, if the PCI core decides to scale down the MPS value of
> the root port, then it won't be changed in the hw and the hw will continue to
> work with 512B? Shouldn't the controller driver change the hw values based on
> the values programmed by PCI core of the emul bridge?
> 
> But until that is fixed, this patch should be dropped.
> 

Dear Mani,

I will drop this patch in the next version.

Best regards,
Hans


