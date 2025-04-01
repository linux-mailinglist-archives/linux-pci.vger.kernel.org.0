Return-Path: <linux-pci+bounces-25066-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08556A77BF5
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 15:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 376E83A7405
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 13:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA6C1D619D;
	Tue,  1 Apr 2025 13:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="cmxBPdnA"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207583FBB3;
	Tue,  1 Apr 2025 13:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743513682; cv=none; b=EU77TBee5C3V62egqmsI+KLHAtEavqpk0FLPT1I0c5B2LniZNR83OJjP/AtDTRYpAqI5CR49Dl4KGDIPzpqrZAZSFDt6XpI8NwlmwyxB26UshTOxuImNApWhYq8qQyrDGWCsg6ZXy6y+c5ejkIgrD0CysTrJSifbNsI563AOIW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743513682; c=relaxed/simple;
	bh=Mu2L341tZr6mzV39ohk9TsULrZxBNbcclT7n/FiqNl8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jDYVYZjQNgC44wnf5ejJBbMk0FgM7Vnwf78GjbSzxYqaThxH3TfafYevEtYtZ4DKuvl1kTWZC9lEoJVFXNWudWR5TIADCcLMw5ZjWEKMhgZC4TwqodiwBrgqUfPKINVunYdTAR1jFVsg/sulFwjdBiiLP9qwRS17jMIDytR1Sc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=cmxBPdnA; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=x4wufpRNYlQT14df1bjE/JAJkFG6toAele7W3MVOaIo=;
	b=cmxBPdnAceVezsTlq5OjoCRVa2vZMOFbJZl/BOB9mZy4JBjeEQjXGGIGAwcKex
	fGoMCRqBb5GfFJ4D1tc23cMkPYGrL4m2KbcuWKpuEfbmDWkbU2Tvf9m09+OQWw3M
	eWgwNnRHAFco3sxklaAsFk40x24ELIpCZnyd5I4OSdVxY=
Received: from [192.168.71.89] (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wBXeGoj6OtnUkRVDQ--.6386S2;
	Tue, 01 Apr 2025 21:20:35 +0800 (CST)
Message-ID: <418498a1-e2c0-4453-a69d-dabe0ee0e5f6@163.com>
Date: Tue, 1 Apr 2025 21:20:34 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v6 3/5] PCI: cadence: Use common PCI host bridge APIs for
 finding the capabilities
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Bjorn Helgaas <bhelgaas@google.com>, lpieralisi@kernel.org, kw@linux.com,
 robh@kernel.org, jingoohan1@gmail.com, thomas.richard@bootlin.com,
 linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <20250323164852.430546-1-18255117159@163.com>
 <20250323164852.430546-4-18255117159@163.com>
 <f467056d-8d4a-9dab-2f0a-ca589adfde53@linux.intel.com>
 <d370b69a-3b70-4e3b-94a3-43e0bc1305cd@163.com>
 <a3462c68-ec1b-0b1a-fee7-612bd1109819@linux.intel.com>
 <3d9b2fa9-98bf-4f47-aa76-640a4f82cb2f@163.com>
 <26dcba54-93c1-dda4-c5e2-e324e9d50b09@linux.intel.com>
 <f2725090-e199-493d-9ae3-e807d65f647b@163.com>
 <de6ce71c-ba82-496e-9c72-7c9c61b37906@163.com>
 <ddabf340-a00f-75b1-2b6b-d9ab550a984f@linux.intel.com>
 <9118fcc0-e5a5-40f2-be4b-7e06b4b20601@163.com>
 <b279863e-8d8c-4c14-98ad-c19d26c69146@163.com>
 <0e493832-6292-10d7-6f87-ed190059c999@linux.intel.com>
 <95d9f7d9-6569-4252-a54d-cbe38ade706b@163.com>
 <fc6bec19-fb1e-bff0-8676-ba2c1ca860df@linux.intel.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <fc6bec19-fb1e-bff0-8676-ba2c1ca860df@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBXeGoj6OtnUkRVDQ--.6386S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3GF4xGryfJFy5tF4rKrW3ZFb_yoW7Xr1Dpr
	45XFyFyrWkJr17K34qqa17Ka42q3ykA3WDu3W3G34UZrWqkF1xKFy2kr4YgrW2qr4kJr1F
	vF1qvas8GFnIyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UKiiDUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDwQho2fqaJoYOAADsV



On 2025/4/1 00:39, Ilpo Järvinen wrote:
>>>> +			read_cfg((priv), (devfn), __pos, 2, (u32 *)&__ent); \
>>>> +     \
>>>> +			__id = __ent & 0xff;                                \
>>>> +			if (__id == 0xff)                                   \
>>>> +				break;                                      \
>>>> +			if (__id == (cap)) {                                \
>>>> +				__found_pos = __pos;                        \
>>>> +				break;                                      \
>>>> +			}                                                   \
>>>> +			__pos = (__ent >> 8);                               \
>>>
>>> I'd add these into uapi/linux/pci_regs.h:
>>
>> This means that you will submit, and I will submit after you?
>> Or should I submit this series of patches together?
> 
> I commented these cleanup opportunities so that you could add them to
> your series. If I'd immediately start working on area/lines you're working
> with, it would just trigger conflicts so it's better the original author
> does the improvements within the series he/she is working with. It's a lot
> less work for the maintainer that way :-).
> 

Hi Ilpo,

Thanks your for reply. Thank you so much for your comments.

>>> I started to wonder though if the controller drivers could simply create
>>> an "early" struct pci_dev & pci_bus just so they can use the normal
>>> accessors while the real structs are not yet created. It looks not
>>> much is needed from those structs to let the accessors to work.
>>>
>>
>> Here are a few questions:
>> 1. We need to initialize some variables for pci_dev. For example,
>> dev->cfg_size needs to be initialized to 4K for PCIe.
>>
>> u16 pci_find_next_ext_capability(struct pci_dev *dev, u16 start, int cap)
>> {
>> 	......
>> 	if (dev->cfg_size <= PCI_CFG_SPACE_SIZE)
>> 		return 0;
>> 	......
>>
> 
> Sure, it would require some initialization of the struct (but not
> full init like the probe path does that does lots of setup too).
> 
>> 2. Create an "early" struct pci_dev & pci_bus for each SOC vendor (Qcom,
>> Rockchip, etc). It leads to a lot of code that feels weird.
> 
> The early pci_dev+pci_bus would be created by a helper in PCI core that
> initializes what is necessary for the supported set of early core
> functionality to work. The controller drivers themselves would just call
> that function.
> 

Ok, got it.

>> I still prefer the approach we are discussing now.
> 
> I'm not saying we should immediately head toward this new idea within this
> series because it's going to be relatively big change. But it's certainly
> something that looks worth exploring so that the current chicken-egg
> problem with controller drivers could be solved.
> 

Ok, I hope to have the opportunity to participate in the discussion 
together in the future.

>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>> index 2e9cf26a9ee9..68c111be521d 100644
>> --- a/drivers/pci/pci.h
>> +++ b/drivers/pci/pci.h
>> @@ -4,6 +4,65 @@
>>
>>   #include <linux/pci.h>
> 
> Make sure to add the necessary headers for the function/macros you're
> using so that things won't depend on the #include order in the .c file.
> 

Will do.

>>
>> +/* Ilpo: I'd add these into uapi/linux/pci_regs.h: */
>> +#define PCI_CAP_ID_MASK		0x00ff
>> +#define PCI_CAP_LIST_NEXT_MASK	0xff00
>> +
>> +/* Standard capability finder */
> 
> Capability
> 
> Always use the same capitalization as the specs do.
> 

Will change.

> You should probably write a kernel doc for this macro too.
> 

Will do.

> I'd put these macro around where pcie_cap_has_*() forward declarations
> are so that the initial define block is not split.
> 

Will change.

>> +#define PCI_FIND_NEXT_CAP_TTL(read_cfg, start, cap, args...)		\
>> +({									\
>> +	u8 __pos = (start);						\
>> +	int __ttl = PCI_FIND_CAP_TTL;					\
>> +	u16 __ent;							\
>> +	u8 __found_pos = 0;						\
>> +	u8 __id;							\
>> +									\
>> +	read_cfg(args, __pos, 1, (u32 *)&__pos);			\
>> +									\
>> +	while (__ttl--) {						\
>> +		if (__pos < PCI_STD_HEADER_SIZEOF)			\
>> +			break;						\
>> +		__pos = ALIGN_DOWN(__pos, 4);				\
>> +		read_cfg(args, __pos, 2, (u32 *)&__ent);		\
>> +		__id = FIELD_GET(PCI_CAP_ID_MASK, __ent);		\
>> +		if (__id == 0xff)					\
>> +			break;						\
>> +		if (__id == (cap)) {					\
>> +			__found_pos = __pos;				\
>> +			break;						\
>> +		}							\
>> +		__pos = FIELD_GET(PCI_CAP_LIST_NEXT_MASK, __ent);	\
>> +	}								\
>> +	__found_pos;							\
>> +})
>> +
>> +/* Extended capability finder */
>> +#define PCI_FIND_NEXT_EXT_CAPABILITY(read_cfg, start, cap, args...)	\
>> +({									\
>> +	u16 __pos = (start) ?: PCI_CFG_SPACE_SIZE;			\
>> +	u16 __found_pos = 0;						\
>> +	int __ttl, __ret;						\
>> +	u32 __header;							\
>> +									\
>> +	__ttl = (PCI_CFG_SPACE_EXP_SIZE - PCI_CFG_SPACE_SIZE) / 8;	\
>> +	while (__ttl-- > 0 && __pos >= PCI_CFG_SPACE_SIZE) {		\
>> +		__ret = read_cfg(args, __pos, 4, &__header);		\
>> +		if (__ret != PCIBIOS_SUCCESSFUL)			\
>> +			break;						\
>> +									\
>> +		if (__header == 0)					\
>> +			break;						\
>> +									\
>> +		if (PCI_EXT_CAP_ID(__header) == (cap) && __pos != start) {\
>> +			__found_pos = __pos;				\
>> +			break;						\
>> +		}							\
>> +									\
>> +		__pos = PCI_EXT_CAP_NEXT(__header);			\
>> +	}								\
>> +	__found_pos;							\
>> +})
>> +
>>   struct pcie_tlp_log;
>>
>>   /* Number of possible devfns: 0.0 to 1f.7 inclusive */
>>
>>
>> Looking forward to your latest suggestions.
> 
> This generally looked good, I didn't read with a very fine comb but just
> focused on the important bits. I'll take a more detailed look once you
> make the official submission.

Ok, I'm going to prepare the next version of patch. I hope you can 
review it again. Thank you very much


Best regards,
Hans


