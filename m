Return-Path: <linux-pci+bounces-25236-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0522A7A2D0
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 14:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD6E03B61A1
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 12:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3367224BC14;
	Thu,  3 Apr 2025 12:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Ni8jksu1"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3424624CEE1;
	Thu,  3 Apr 2025 12:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743683146; cv=none; b=H5gzFF2/amXhzvyP5OjLBztPaiYemaWVdyL0LL2386/gmWbbfS0Kg/VGRFYPDoGm+bvDOT3LTQlhDiTRNJQnw+G4NNaM+3og6+eqhT67UnKRGafrvSV6ojfJ2bRL2/lMHrdN4StsP5lUG5yvFYg2wHJNUi0jKXSEoDX4Mys7GxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743683146; c=relaxed/simple;
	bh=aYvnp3rjcHqgeu5q1Bg/myMR5Oa1l+xmSrX96Y1n/rY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r1bbNUJNzhOvESfpJrpF2MGvmh/dm5AEvv4/KiTiHwHy14KJGgOVISRN5DPWaIcf/34Y5usagLhAeCpXehX4aAK/yJsTVXLazV+Laa6x5GR1HWbm2/GqHtUgBISOoBWynKSeutoYXSq3zd0WuTlqSBah0GQq1ClgQFXifNWJN+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Ni8jksu1; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=YOVGxu+Pa9F9S2YKMRxxQPidaydp1+plrOXzivuJhgI=;
	b=Ni8jksu1UeXcQ5bdgkbl4cNlxi682KXN1OSfRg7bgdinuMZSU3nbasnbFf0Zqw
	Nsu6dSF5P0KlCyYq86PYsFrVz1yyl3bV7WXPkttOHNUNSFZkGGFd/4vvVT3P1rXx
	f3c+xIBjCz7TKrbTFPG+srxW6HDzQ8bxb0cMxPulOsyRE=
Received: from [192.168.60.52] (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wCH3Jb6fe5nIXo0Dw--.40417S2;
	Thu, 03 Apr 2025 20:24:27 +0800 (CST)
Message-ID: <f77f60a0-72d2-4a9c-864e-bd8c4ea8a514@163.com>
Date: Thu, 3 Apr 2025 20:24:25 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v7 2/5] PCI: Refactor capability search functions to eliminate
 code duplication
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: lpieralisi@kernel.org, bhelgaas@google.com, kw@linux.com,
 manivannan.sadhasivam@linaro.org, robh@kernel.org, jingoohan1@gmail.com,
 thomas.richard@bootlin.com, linux-pci@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <20250402042020.48681-1-18255117159@163.com>
 <20250402042020.48681-3-18255117159@163.com>
 <8b693bfc-73e0-2956-2ba3-1bfd639660b6@linux.intel.com>
 <c6706073-86b0-445a-b39f-993ac9b054fa@163.com>
 <bf6f0acb-9c48-05de-6d6d-efb0236e2d30@linux.intel.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <bf6f0acb-9c48-05de-6d6d-efb0236e2d30@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCH3Jb6fe5nIXo0Dw--.40417S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXw1fXr18KF1xWw1UCF17Jrb_yoW5tF4kpF
	WUJF12krW8GF1UtF4qqay09r1aqas7tFyxGr48C3sIvF9FkasYvFy3Kr15Wr1SgrWDWF1x
	Za1FgF9xCa4FyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Ul0PhUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOh0ko2fufCM1IQAAsi



On 2025/4/3 17:15, Ilpo Järvinen wrote:
>>> I don't like how 1 & 2 patches are split into two. IMO, they mostly belong
>>> together. However, (IMO) you can introduce the new all-size config space
>>> accessor in a separate patch before the combined patch.
>>>
>>
>> Ok. I'll change it to the following. The rest I'll combine into a patch.
>>
>> diff --git a/drivers/pci/access.c b/drivers/pci/access.c
>> index b123da16b63b..bb2e26c2eb81 100644
>> --- a/drivers/pci/access.c
>> +++ b/drivers/pci/access.c
>> @@ -85,6 +85,23 @@ EXPORT_SYMBOL(pci_bus_write_config_byte);
>>   EXPORT_SYMBOL(pci_bus_write_config_word);
>>   EXPORT_SYMBOL(pci_bus_write_config_dword);
>>
>> +
> 
> Extra newline
> 

Hi Ilpo,

Thanks your for reply. Will delete.

>> +int pci_bus_read_config(void *priv, unsigned int devfn, int where, u32 size,
>> +			u32 *val)
>> +{
>> +	struct pci_bus *bus = priv;
>> +	int ret;
>> +
>> +	if (size == 1)
>> +		ret = pci_bus_read_config_byte(bus, devfn, where, (u8 *)val);
>> +	else if (size == 2)
>> +		ret = pci_bus_read_config_word(bus, devfn, where, (u16 *)val);
>> +	else
>> +		ret = pci_bus_read_config_dword(bus, devfn, where, val);
>> +
>> +	return ret;
>> +}
>> +
>>   int pci_generic_config_read(struct pci_bus *bus, unsigned int devfn,
>>   			    int where, int size, u32 *val)
>>   {
>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>> index 2e9cf26a9ee9..6a7c88b9cd35 100644
>> --- a/drivers/pci/pci.h
>> +++ b/drivers/pci/pci.h
>> @@ -88,6 +88,8 @@ extern bool pci_early_dump;
>>   bool pcie_cap_has_lnkctl(const struct pci_dev *dev);
>>   bool pcie_cap_has_lnkctl2(const struct pci_dev *dev);
>>   bool pcie_cap_has_rtctl(const struct pci_dev *dev);
>> +int pci_bus_read_config(void *priv, unsigned int devfn, int where, u32 size,
>> +			u32 *val);
>>
>>   /* Functions internal to the PCI core code */
>>
>>
>>>>    }
>>>>    EXPORT_SYMBOL_GPL(pci_find_next_ext_capability);
>>>>    @@ -648,7 +614,6 @@ EXPORT_SYMBOL_GPL(pci_get_dsn);
>>>>      static u8 __pci_find_next_ht_cap(struct pci_dev *dev, u8 pos, int
>>>> ht_cap)
>>>>    {
>>>> -	int rc, ttl = PCI_FIND_CAP_TTL;
>>>>    	u8 cap, mask;
>>>>      	if (ht_cap == HT_CAPTYPE_SLAVE || ht_cap == HT_CAPTYPE_HOST)
>>>> @@ -657,7 +622,7 @@ static u8 __pci_find_next_ht_cap(struct pci_dev *dev,
>>>> u8 pos, int ht_cap)
>>>>    		mask = HT_5BIT_CAP_MASK;
>>>>      	pos = __pci_find_next_cap_ttl(dev->bus, dev->devfn, pos,
>>>> -				      PCI_CAP_ID_HT, &ttl);
>>>> +				      PCI_CAP_ID_HT);
>>>>    	while (pos) {
>>>>    		rc = pci_read_config_byte(dev, pos + 3, &cap);
>>>>    		if (rc != PCIBIOS_SUCCESSFUL)
>>>> @@ -668,7 +633,7 @@ static u8 __pci_find_next_ht_cap(struct pci_dev *dev,
>>>> u8 pos, int ht_cap)
>>>>      		pos = __pci_find_next_cap_ttl(dev->bus, dev->devfn,
>>>>    					      pos + PCI_CAP_LIST_NEXT,
>>>> -					      PCI_CAP_ID_HT, &ttl);
>>>> +					      PCI_CAP_ID_HT);
>>>
>>> This function kind of had the idea to share the ttl but I suppose that was
>>> just a final safeguard to make sure the loop will always terminate in case
>>> the config space is corrupted so the unsharing is not a big issue.
>>>
>>
>> __pci_find_next_cap_ttl
>>    // This macro definition already has ttl loop restrictions inside it.
>>    PCI_FIND_NEXT_CAP_TTL
>>
>> Do I understand that you agree to remove ttl initialization and parameter
>> passing?
> 
> Yes, I agree with it but doing anything like this (although I'd mention
> the reasoning in the changelog myself).
> 

Ok, I see. I will give the reasons.

Best regards,
Hans


