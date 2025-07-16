Return-Path: <linux-pci+bounces-32285-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AAAFFB07AA1
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 18:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B3211C24A6D
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 16:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716582F532B;
	Wed, 16 Jul 2025 16:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="dtKkDE5W"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0884B26E6FF;
	Wed, 16 Jul 2025 16:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752681926; cv=none; b=OHcUr6IBGv4eZPYXxOf8HZrjNj5HmyImU67jrLfCZOaZwBnqJx5oEdrpL1EEAPoyIBYiN81tSyqIJN9y8EvbCc8ERBziP5QY5qnNKurYCtSao48UicYcRuzVOiUa4iDSYVM1SBUtXNxKP7ZjR1IF8H9UYe3dZk7N5Ha/QfnzFT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752681926; c=relaxed/simple;
	bh=EZr/u7e1xpLhCtryMzeebLjO7d8cAovR1gcVTP0AVWk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PHx5M1ghsvozyO3i8NKAzjjtfGdAgarWl8pQOd/Y16Tmi/DprhM1lw7CzG0qptMMkpHLDD0dnxDAVmJG4v62+y/7/HiuaG1LaBZxXY6vRBdIxnIVuT/WvCcM6JkR9Blnx8XPa6NJfz6A4mgRzQQpSuvyWr3J6+B2pLjVceIFoWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=dtKkDE5W; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=yB8tyjuAJaeYyqQL0HTZYpbJH8nEANpuUUVJckuSIpM=;
	b=dtKkDE5WUbmnTeEv1WD8Fn9U5B4uJSXKOLwkYn16R58tZvMQrtqGeUENmsQXpr
	Qizt8AYp1JbQ7pepoemXUou+5mSi/ExSCW0gRAjvndQO5r3SgokB7hY2ZIOxp9dR
	ti1CuOeJ1Pt/+IvHJIM9gzyikGfHksYq4y/GobqqifLbs=
Received: from [IPV6:240e:b8f:919b:3100:7981:39b4:a847:709a] (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgCHGm2gzXdozBHWAw--.58886S2;
	Thu, 17 Jul 2025 00:04:50 +0800 (CST)
Message-ID: <903ea9c4-87d6-45a8-9825-4a0d45ec608f@163.com>
Date: Thu, 17 Jul 2025 00:04:48 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 3/6] PCI: Refactor capability search into common
 macros
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: lpieralisi@kernel.org, bhelgaas@google.com, mani@kernel.org,
 ilpo.jarvinen@linux.intel.com, kwilczynski@kernel.org, robh@kernel.org,
 jingoohan1@gmail.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250715224705.GA2504490@bhelgaas>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20250715224705.GA2504490@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:PigvCgCHGm2gzXdozBHWAw--.58886S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3GFyUCr1DCFy3uFy3Aw4fXwb_yoWfCF47pr
	W5J3WayrWDJF12gw1qqa18t3W2gFs7Aa9ruFW7Gwn0qryqkFn7KFyFkw1ag3W2yrs7CF1x
	Xa1qgas3C3ZIyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UwNV9UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiQxWMo2h3yP1XkwAAsX



On 2025/7/16 06:47, Bjorn Helgaas wrote:
> On Sun, Jun 08, 2025 at 12:14:02AM +0800, Hans Zhang wrote:
>> The PCI Capability search functionality is duplicated across the PCI core
>> and several controller drivers. The core's current implementation requires
>> fully initialized PCI device and bus structures, which prevents controller
>> drivers from using it during early initialization phases before these
>> structures are available.
>>
>> Move the Capability search logic into a header-based macro that accepts a
>> config space accessor function as an argument. This enables controller
>> drivers to perform Capability discovery using their early access
>> mechanisms prior to full device initialization while sharing the
>> Capability search code.
>>
>> Convert the existing PCI core Capability search implementation to use this
>> new macro. Controller drivers can later use the same macros with their
>> early access mechanisms while maintaining the existing protection against
>> infinite loops through preserved TTL checks.
>>
>> The ttl parameter was originally an additional safeguard to prevent
>> infinite loops in corrupted config space. However, the
>> PCI_FIND_NEXT_CAP_TTL() macro already enforces a TTL limit internally.
>> Removing redundant ttl handling simplifies the interface while maintaining
>> the safety guarantee. This aligns with the macro's design intent of
>> encapsulating TTL management.
> 
> This is a big gulp, but I think I like it :)  It really enables some
> nice cleanups later.
> 
>> -static u8 __pci_find_next_cap_ttl(struct pci_bus *bus, unsigned int devfn,
>> -				  u8 pos, int cap, int *ttl)
>> -{
>> -	u8 id;
>> -	u16 ent;
>> -
>> -	pci_bus_read_config_byte(bus, devfn, pos, &pos);
>> -
>> -	while ((*ttl)--) {
>> -		if (pos < PCI_STD_HEADER_SIZEOF)
>> -			break;
>> -		pos = ALIGN_DOWN(pos, 4);
>> -		pci_bus_read_config_word(bus, devfn, pos, &ent);
>> -
>> -		id = FIELD_GET(PCI_CAP_ID_MASK, ent);
>> -		if (id == 0xff)
>> -			break;
>> -		if (id == cap)
>> -			return pos;
>> -		pos = FIELD_GET(PCI_CAP_LIST_NEXT_MASK, ent);
>> -	}
>> -	return 0;
>> -}
>> -
>>   static u8 __pci_find_next_cap(struct pci_bus *bus, unsigned int devfn,
>>   			      u8 pos, int cap)
>>   {
>> -	int ttl = PCI_FIND_CAP_TTL;
>> -
>> -	return __pci_find_next_cap_ttl(bus, devfn, pos, cap, &ttl);
>> +	return PCI_FIND_NEXT_CAP_TTL(pci_bus_read_config, pos, cap, bus, devfn);
>>   }
>>   
>>   u8 pci_find_next_capability(struct pci_dev *dev, u8 pos, int cap)
>> @@ -554,42 +527,11 @@ EXPORT_SYMBOL(pci_bus_find_capability);
>>    */
>>   u16 pci_find_next_ext_capability(struct pci_dev *dev, u16 start, int cap)
>>   {
>> -	u32 header;
>> -	int ttl;
>> -	u16 pos = PCI_CFG_SPACE_SIZE;
>> -
>> -	/* minimum 8 bytes per capability */
>> -	ttl = (PCI_CFG_SPACE_EXP_SIZE - PCI_CFG_SPACE_SIZE) / 8;
>> -
>>   	if (dev->cfg_size <= PCI_CFG_SPACE_SIZE)
>>   		return 0;
>>   
>> -	if (start)
>> -		pos = start;
>> -
>> -	if (pci_read_config_dword(dev, pos, &header) != PCIBIOS_SUCCESSFUL)
>> -		return 0;
>> -
>> -	/*
>> -	 * If we have no capabilities, this is indicated by cap ID,
>> -	 * cap version and next pointer all being 0.
>> -	 */
>> -	if (header == 0)
>> -		return 0;
>> -
>> -	while (ttl-- > 0) {
>> -		if (PCI_EXT_CAP_ID(header) == cap && pos != start)
>> -			return pos;
>> -
>> -		pos = PCI_EXT_CAP_NEXT(header);
>> -		if (pos < PCI_CFG_SPACE_SIZE)
>> -			break;
>> -
>> -		if (pci_read_config_dword(dev, pos, &header) != PCIBIOS_SUCCESSFUL)
>> -			break;
>> -	}
>> -
>> -	return 0;
>> +	return PCI_FIND_NEXT_EXT_CAPABILITY(pci_bus_read_config, start, cap,
>> +					    dev->bus, dev->devfn);
>>   }
>>   EXPORT_SYMBOL_GPL(pci_find_next_ext_capability);
>>   
>> @@ -649,7 +591,7 @@ EXPORT_SYMBOL_GPL(pci_get_dsn);
>>   
>>   static u8 __pci_find_next_ht_cap(struct pci_dev *dev, u8 pos, int ht_cap)
>>   {
>> -	int rc, ttl = PCI_FIND_CAP_TTL;
>> +	int rc;
>>   	u8 cap, mask;
>>   
>>   	if (ht_cap == HT_CAPTYPE_SLAVE || ht_cap == HT_CAPTYPE_HOST)
>> @@ -657,8 +599,8 @@ static u8 __pci_find_next_ht_cap(struct pci_dev *dev, u8 pos, int ht_cap)
>>   	else
>>   		mask = HT_5BIT_CAP_MASK;
>>   
>> -	pos = __pci_find_next_cap_ttl(dev->bus, dev->devfn, pos,
>> -				      PCI_CAP_ID_HT, &ttl);
>> +	pos = PCI_FIND_NEXT_CAP_TTL(pci_bus_read_config, pos,
>> +				    PCI_CAP_ID_HT, dev->bus, dev->devfn);
>>   	while (pos) {
>>   		rc = pci_read_config_byte(dev, pos + 3, &cap);
>>   		if (rc != PCIBIOS_SUCCESSFUL)
>> @@ -667,9 +609,10 @@ static u8 __pci_find_next_ht_cap(struct pci_dev *dev, u8 pos, int ht_cap)
>>   		if ((cap & mask) == ht_cap)
>>   			return pos;
>>   
>> -		pos = __pci_find_next_cap_ttl(dev->bus, dev->devfn,
>> -					      pos + PCI_CAP_LIST_NEXT,
>> -					      PCI_CAP_ID_HT, &ttl);
>> +		pos = PCI_FIND_NEXT_CAP_TTL(pci_bus_read_config,
>> +					    pos + PCI_CAP_LIST_NEXT,
>> +					    PCI_CAP_ID_HT, dev->bus,
>> +					    dev->devfn);
>>   	}
>>   
>>   	return 0;
>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>> index e7d31ed56731..46fb6b5a854e 100644
>> --- a/drivers/pci/pci.h
>> +++ b/drivers/pci/pci.h
>> @@ -2,6 +2,8 @@
>>   #ifndef DRIVERS_PCI_H
>>   #define DRIVERS_PCI_H
>>   
>> +#include <linux/align.h>
>> +#include <linux/bitfield.h>
>>   #include <linux/pci.h>
>>   
>>   struct pcie_tlp_log;
>> @@ -93,6 +95,89 @@ bool pcie_cap_has_rtctl(const struct pci_dev *dev);
>>   int pci_bus_read_config(void *priv, unsigned int devfn, int where, u32 size,
>>   			u32 *val);
>>   
>> +/* Standard Capability finder */
>> +/**
>> + * PCI_FIND_NEXT_CAP_TTL - Find a PCI standard capability
> 
> I don't think "_TTL" is relevant in the macro name here.  I see it
> copied the previous __pci_find_next_cap_ttl() name; "ttl" *was*
> relevant there, but it isn't anymore.
> 

Dear Bjorn,

Thank you very much for your reply.

The _TTL suffix will be removed.


> I would like this a lot better if it could be implemented as a
> function, but I assume it has to be a macro for some varargs reason.
> 

Yes. The macro definitions used in combination with the previous review 
opinions of Ilpo.

>> + * @read_cfg: Function pointer for reading PCI config space
>> + * @start: Starting position to begin search
>> + * @cap: Capability ID to find
>> + * @args: Arguments to pass to read_cfg function
>> + *
>> + * Iterates through the capability list in PCI config space to find
>> + * @cap. Implements TTL (time-to-live) protection against infinite loops.
>> + *
>> + * Returns: Position of the capability if found, 0 otherwise.
>> + */
>> +#define PCI_FIND_NEXT_CAP_TTL(read_cfg, start, cap, args...)		\
>> +({									\
>> +	int __ttl = PCI_FIND_CAP_TTL;					\
>> +	u8 __id, __found_pos = 0;					\
>> +	u8 __pos = (start);						\
>> +	u16 __ent;							\
>> +									\
>> +	read_cfg(args, __pos, 1, (u32 *)&__pos);			\
>> +									\
>> +	while (__ttl--) {						\
>> +		if (__pos < PCI_STD_HEADER_SIZEOF)			\
>> +			break;						\
> 
> I guess this is just lifted directly from __pci_find_next_cap_ttl(),
> but wow, I wish it weren't quite *so* subtle.  Totally fine though.
> 
> Maybe this could be split into one patch for standard capabilities and
> a second for extended capabilities, just so the connection between
> this and __pci_find_next_cap_ttl() would be clearer.
> 

I will split the two patches.

>> +									\
>> +		__pos = ALIGN_DOWN(__pos, 4);				\
>> +		read_cfg(args, __pos, 2, (u32 *)&__ent);		\
>> +									\
>> +		__id = FIELD_GET(PCI_CAP_ID_MASK, __ent);		\
>> +		if (__id == 0xff)					\
>> +			break;						\
>> +									\
>> +		if (__id == (cap)) {					\
>> +			__found_pos = __pos;				\
>> +			break;						\
>> +		}							\
>> +									\
>> +		__pos = FIELD_GET(PCI_CAP_LIST_NEXT_MASK, __ent);	\
>> +	}								\
>> +	__found_pos;							\
>> +})
>> +
>> +/* Extended Capability finder */
>> +/**
>> + * PCI_FIND_NEXT_EXT_CAPABILITY - Find a PCI extended capability
> 
> Can this be named similarly to the above?  PCI_FIND_NEXT_CAP_TTL() and
> PCI_FIND_NEXT_EXT_CAPABILITY() seem needlessly different.

No problem at all.


> PCI_FIND_NEXT_CAP() and PCI_FIND_NEXT_EXT_CAP()?

Will change.

> 
>> + * @read_cfg: Function pointer for reading PCI config space
>> + * @start: Starting position to begin search (0 for initial search)
>> + * @cap: Extended capability ID to find
>> + * @args: Arguments to pass to read_cfg function
>> + *
>> + * Searches the extended capability space in PCI config registers
>> + * for @cap. Implements TTL protection against infinite loops using
>> + * a calculated maximum search count.
>> + *
>> + * Returns: Position of the capability if found, 0 otherwise.
>> + */
>> +#define PCI_FIND_NEXT_EXT_CAPABILITY(read_cfg, start, cap, args...)		\
> 
> It would be *really* nice if you could make this fit nicely in 80
> columns as PCI_FIND_NEXT_CAP_TTL() does.
> 

Will change.

Best regards,
Hans

>> +({										\
>> +	u16 __pos = (start) ?: PCI_CFG_SPACE_SIZE;				\
>> +	u16 __found_pos = 0;							\
>> +	int __ttl, __ret;							\
>> +	u32 __header;								\
>> +										\
>> +	__ttl = (PCI_CFG_SPACE_EXP_SIZE - PCI_CFG_SPACE_SIZE) / 8;		\
>> +	while (__ttl-- > 0 && __pos >= PCI_CFG_SPACE_SIZE) {			\
>> +		__ret = read_cfg(args, __pos, 4, &__header);			\
>> +		if (__ret != PCIBIOS_SUCCESSFUL)				\
>> +			break;							\
>> +										\
>> +		if (__header == 0)						\
>> +			break;							\
>> +										\
>> +		if (PCI_EXT_CAP_ID(__header) == (cap) && __pos != start) {	\
>> +			__found_pos = __pos;					\
>> +			break;							\
>> +		}								\
>> +										\
>> +		__pos = PCI_EXT_CAP_NEXT(__header);				\
>> +	}									\
>> +	__found_pos;								\
>> +})
>> +
>>   /* Functions internal to the PCI core code */
>>   
>>   #ifdef CONFIG_DMI
>> -- 
>> 2.25.1
>>


