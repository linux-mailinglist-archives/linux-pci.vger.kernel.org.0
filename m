Return-Path: <linux-pci+bounces-27379-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 989CBAAE3CC
	for <lists+linux-pci@lfdr.de>; Wed,  7 May 2025 17:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEBE73BB5DB
	for <lists+linux-pci@lfdr.de>; Wed,  7 May 2025 15:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF530289E31;
	Wed,  7 May 2025 15:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="IifXHXyr"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB2D186E2E;
	Wed,  7 May 2025 15:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746630254; cv=none; b=fUUJibZc/HGzrPGxVC6RmFN7BOsbiVa79vAfXpkweN78uE1EPzjqLRHJbwqgc06IAildKGvB0c+EHpVdsmHGshIBPqFp0Nr60KcnAmBaY5PMXbV5bn4xcrhw/WNwVi7y+H0R+LLoSoTy4KtHOkjE7fuwo8C/tkRQiSmmKbXycfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746630254; c=relaxed/simple;
	bh=mck2z+Cc2oQzQc3i8rLCXJIBPXi0+xMiPta1z2MKgAo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SFnNBHfAOkfQCXH6vGH5WaaK5VaFCQhfzJZBq52TxAUArhRhV1JURI63jeerrMLHjaqCUUT5T3BzSrqFEK56qI6N4czZSoTk22IQsxnIs/6I6jaXr3rYZ4GSj8tUIMh0bKGR6ZPeejjXy9E6L69XWMjQug+4uBR/W/wrUgYiV+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=IifXHXyr; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=k0lMDpw6GGwnZ5U3YF/IzgmlQ4HTA5U+5tATXwgR3Qs=;
	b=IifXHXyregvZXX/1E3gfFkBqW6jExUqOo4AyVDKpGl62oV49Y1WVapywG1Eym0
	nh3fbwhoVuV5m0FpFuusIf+fWEg+VyLi5S3XICInGT+YLkcZ4FEbGUy4GUHrHfJI
	x02Q3cH64Wkz4T89nBMZWefke0sznXDFCS67wN0KFfCcE=
Received: from [192.168.71.93] (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wA39PQrdhto7adUFA--.13565S2;
	Wed, 07 May 2025 23:03:08 +0800 (CST)
Message-ID: <8a6adc24-5f40-4f22-9842-b211e1ef5008@163.com>
Date: Wed, 7 May 2025 23:03:07 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] PCI: aardvark: Remove redundant MPS configuration
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
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20250506174110.63ayeqc4scmwjj6e@pali>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wA39PQrdhto7adUFA--.13565S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWw4UKFWrCw4Utw4fuFW7Jwb_yoW5Xr4UpF
	W3XF4rAFWaqr15u3ZrJa1kKry5GasrKFy5Wws8GrW3CF9xK3yUGFy2kF4rCa4xJr4kKFyj
	vryaq3ySk3ZIyaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UPxhJUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDwVGo2gbdD5DtQAAsg



On 2025/5/7 01:41, Pali Rohár wrote:
> On Wednesday 07 May 2025 01:34:39 Hans Zhang wrote:
>> The Aardvark PCIe controller enforces a fixed 512B payload size via
>> PCI_EXP_DEVCTL_PAYLOAD_512B, overriding hardware capabilities and PCIe
>> core negotiations.
>>
>> Remove explicit MPS overrides (PCI_EXP_DEVCTL_PAYLOAD and
>> PCI_EXP_DEVCTL_PAYLOAD_512B). MPS is now determined by the PCI core
>> during device initialization, leveraging root port configurations and
>> device-specific capabilities.
>>
>> Aligning Aardvark with the unified MPS framework ensures consistency,
>> avoids artificial constraints, and allows the hardware to operate at
>> its maximum supported payload size while adhering to PCIe specifications.
>>
>> Signed-off-by: Hans Zhang <18255117159@163.com>
>> ---
>>   drivers/pci/controller/pci-aardvark.c | 2 --
>>   1 file changed, 2 deletions(-)
>>
>> diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
>> index a29796cce420..d8852892994a 100644
>> --- a/drivers/pci/controller/pci-aardvark.c
>> +++ b/drivers/pci/controller/pci-aardvark.c
>> @@ -549,9 +549,7 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
>>   	reg = advk_readl(pcie, PCIE_CORE_PCIEXP_CAP + PCI_EXP_DEVCTL);
>>   	reg &= ~PCI_EXP_DEVCTL_RELAX_EN;
>>   	reg &= ~PCI_EXP_DEVCTL_NOSNOOP_EN;
>> -	reg &= ~PCI_EXP_DEVCTL_PAYLOAD;
>>   	reg &= ~PCI_EXP_DEVCTL_READRQ;
>> -	reg |= PCI_EXP_DEVCTL_PAYLOAD_512B;
>>   	reg |= PCI_EXP_DEVCTL_READRQ_512B;
>>   	advk_writel(pcie, reg, PCIE_CORE_PCIEXP_CAP + PCI_EXP_DEVCTL);
>>   
>> -- 
>> 2.25.1
>>
> 
> Please do not remove this code. It is required part of the
> initialization of the aardvark PCI controller at the specific phase,
> as defined in the Armada 3700 Functional Specification.
> 
> There were reported more issues with those Armada PCIe controllers for
> which were already sent patches to mailing list in last 5 years. But
> unfortunately not all fixes were taken / applied yet.

Hi Pali,

I replied to you in version v2.

Is the maximum MPS supported by Armada 3700 512 bytes? What are the 
default values of DevCap.MPS and DevCtl.MPS?

Because the default value of DevCtl.MPS is not 512 bytes, it needs to be 
configured here, right?

If it's my guess, RK3588 also has the same requirements as you, just 
like the first patch I submitted.

Please take a look at the communication history:
https://patchwork.kernel.org/project/linux-pci/patch/20250416151926.140202-1-18255117159@163.com/

Please test it using patch 1/3 of this series. If there are any 
problems, please let me know.


Best regards,
Hans


