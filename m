Return-Path: <linux-pci+bounces-28874-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 353C5ACCACF
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 17:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2C063A4C26
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 15:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67A3240604;
	Tue,  3 Jun 2025 15:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="eqbtvJoM"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E87523F419;
	Tue,  3 Jun 2025 15:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748966175; cv=none; b=r9moW7FWZpd6ooAwC7Qxj8EqLQkuCa4XSc58Qo7GRlG6w9tVbgO/ildd1UGDu5dmewWSEygf6PBixjvMr68Z9jHzOMaw5u/CVqWAbmOENFWTuH/2fz7rxnXONbBEBm5jEhosBHWg5wAX76mXOlZJ4Y8rmi3qiLu89AkHydkMRAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748966175; c=relaxed/simple;
	bh=FSdx0jgVmlGQHfR6McdT0UC6fg/m3xH9/Ng932OThRY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LtKx2wvaVWHVyUwla+zqONNq/LoB5ZPGvZwRWJn+IeB7+IUK3RetbslqrvoJhLcVSpU/hR50gLAJNbELOKMLADegkNb///VxZTsdgMwkXl8sIcnGVIn+az23/D5veHUbzLwnb7+EgYU8BWm4ohEgBI5MCdFRh6i8mZltf5aJFf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=eqbtvJoM; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=g8w0GihKn9TF4gRbxN/DHUKGmxq5uy9Aj7RG/b62tDY=;
	b=eqbtvJoMeWIlOgPGP6e8jTUUFS+Cc9pkU0551OA+d8g0dG0oOL4vfEtCpmwB/c
	3XSAHC6OCrqgsS1aoo6h6wb6Ah6il1Wcs2KcSlcubAl9FvriPvragVdZjI6z+xsU
	ZiD4SGrhkvkFEBD64lxoNdr8KISNYGo+JaM6a8eL7o5XQ=
Received: from [192.168.71.94] (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgD3Hz_vGj9o3hriBA--.18789S2;
	Tue, 03 Jun 2025 23:55:28 +0800 (CST)
Message-ID: <62b35061-ca77-40ce-b10b-709dd862285e@163.com>
Date: Tue, 3 Jun 2025 23:55:27 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 3/6] PCI: Refactor capability search into common
 macros
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: lpieralisi@kernel.org, bhelgaas@google.com,
 manivannan.sadhasivam@linaro.org, kw@linux.com, cassel@kernel.org,
 robh@kernel.org, jingoohan1@gmail.com, linux-pci@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <20250514161258.93844-1-18255117159@163.com>
 <20250514161258.93844-4-18255117159@163.com>
 <cb70dfc1-d576-110b-66f2-173e9bdf86dd@linux.intel.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <cb70dfc1-d576-110b-66f2-173e9bdf86dd@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgD3Hz_vGj9o3hriBA--.18789S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3WFyUWF4xtr1UXrW8JFyrJFb_yoWfCFW5pr
	y5A3WayrWUJF12gwnFqa1Uta4aqan7JFWxurW7Gwn8XFyqkFn7KFyFkr1agFy2yrZ7uF1x
	Xan0qF93C3Z0yFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UIiihUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOgdho2g-EXSq6AABsO



On 2025/6/3 17:38, Ilpo Järvinen wrote:
> On Thu, 15 May 2025, Hans Zhang wrote:
> 
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
>> infinite loops in corrupted config space.  However, the
>> PCI_FIND_NEXT_CAP_TTL macro already enforces a TTL limit internally.
> 
> PCI_FIND_NEXT_CAP_TTL()

Dear Ilpo,

Will change.

> 
>> Removing redundant ttl handling simplifies the interface while maintaining
>> the safety guarantee. This aligns with the macro's design intent of
>> encapsulating TTL management.
>>
>> Signed-off-by: Hans Zhang <18255117159@163.com>
>> ---
>> Changes since v11:
>> - Add #include <linux/bitfield.h>, solve the compilation warnings caused by the subsequent patch calls.
>>
>> Changes since v10:
>> - Remove #include <uapi/linux/pci_regs.h>.
>> - The patch commit message were modified.
>>
>> Changes since v9:
>> - None
>>
>> Changes since v8:
>> - The patch commit message were modified.
>> ---
>>   drivers/pci/pci.c | 69 +++++--------------------------------
>>   drivers/pci/pci.h | 86 +++++++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 95 insertions(+), 60 deletions(-)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 27d2adb18a30..271d922abdcc 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -9,7 +9,6 @@
>>    */
>>   
>>   #include <linux/acpi.h>
>> -#include <linux/align.h>
>>   #include <linux/kernel.h>
>>   #include <linux/delay.h>
>>   #include <linux/dmi.h>
>> @@ -425,35 +424,16 @@ static int pci_dev_str_match(struct pci_dev *dev, const char *p,
>>   }
>>   
>>   static u8 __pci_find_next_cap_ttl(struct pci_bus *bus, unsigned int devfn,
>> -				  u8 pos, int cap, int *ttl)
>> +				  u8 pos, int cap)
>>   {
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
>> +	return PCI_FIND_NEXT_CAP_TTL(pci_bus_read_config, pos, cap, bus,
>> +				     devfn);
>>   }

Will delete __pci_find_next_cap_ttl function.

>>   
>>   static u8 __pci_find_next_cap(struct pci_bus *bus, unsigned int devfn,
>>   			      u8 pos, int cap)
>>   {
>> -	int ttl = PCI_FIND_CAP_TTL;
>> -
>> -	return __pci_find_next_cap_ttl(bus, devfn, pos, cap, &ttl);
>> +	return __pci_find_next_cap_ttl(bus, devfn, pos, cap);
>>   }
> 
> Please just get rid of the ttl variant, use PCI_FIND_NEXT_CAP_TTL()
> directly here, and adjust the other callers of the ttl variable to call
> this one instead.
> 

Will change.

>>   
>>   u8 pci_find_next_capability(struct pci_dev *dev, u8 pos, int cap)
>> @@ -554,42 +534,11 @@ EXPORT_SYMBOL(pci_bus_find_capability);
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
>> @@ -649,7 +598,7 @@ EXPORT_SYMBOL_GPL(pci_get_dsn);
>>   
>>   static u8 __pci_find_next_ht_cap(struct pci_dev *dev, u8 pos, int ht_cap)
>>   {
>> -	int rc, ttl = PCI_FIND_CAP_TTL;
>> +	int rc;
>>   	u8 cap, mask;
>>   
>>   	if (ht_cap == HT_CAPTYPE_SLAVE || ht_cap == HT_CAPTYPE_HOST)
>> @@ -658,7 +607,7 @@ static u8 __pci_find_next_ht_cap(struct pci_dev *dev, u8 pos, int ht_cap)
>>   		mask = HT_5BIT_CAP_MASK;
>>   
>>   	pos = __pci_find_next_cap_ttl(dev->bus, dev->devfn, pos,

Will use PCI_FIND_NEXT_CAP_TTL().

>> -				      PCI_CAP_ID_HT, &ttl);
>> +				      PCI_CAP_ID_HT);
>>   	while (pos) {
>>   		rc = pci_read_config_byte(dev, pos + 3, &cap);
>>   		if (rc != PCIBIOS_SUCCESSFUL)
>> @@ -669,7 +618,7 @@ static u8 __pci_find_next_ht_cap(struct pci_dev *dev, u8 pos, int ht_cap)
>>   
>>   		pos = __pci_find_next_cap_ttl(dev->bus, dev->devfn,

Will use PCI_FIND_NEXT_CAP_TTL().

>>   					      pos + PCI_CAP_LIST_NEXT,
>> -					      PCI_CAP_ID_HT, &ttl);
>> +					      PCI_CAP_ID_HT);
>>   	}
>>   
>>   	return 0;
>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>> index 5e1477d6e254..f9cf45026e6e 100644
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
>> @@ -91,6 +93,90 @@ bool pcie_cap_has_rtctl(const struct pci_dev *dev);
>>   int pci_bus_read_config(void *priv, unsigned int devfn, int where, u32 size,
>>   			u32 *val);
>>   
>> +/* Standard Capability finder */
>> +/**
>> + * PCI_FIND_NEXT_CAP_TTL - Find a PCI standard capability
>> + * @read_cfg: Function pointer for reading PCI config space
>> + * @start: Starting position to begin search
>> + * @cap: Capability ID to find
>> + * @args: Arguments to pass to read_cfg function
>> + *
>> + * Iterates through the capability list in PCI config space to find
>> + * the specified capability. Implements TTL (time-to-live) protection
> 
> to find @cap.

Will change.

> 
>> + * against infinite loops.
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
>> + * @read_cfg: Function pointer for reading PCI config space
>> + * @start: Starting position to begin search (0 for initial search)
>> + * @cap: Extended capability ID to find
>> + * @args: Arguments to pass to read_cfg function
>> + *
>> + * Searches the extended capability space in PCI config registers
>> + * for the specified capability. Implements TTL protection against
> 
> for @cap.

Will change.

Best regards,
Hans

> 
>> + * infinite loops using a calculated maximum search count.
>> + *
>> + * Returns: Position of the capability if found, 0 otherwise.
>> + */
>> +#define PCI_FIND_NEXT_EXT_CAPABILITY(read_cfg, start, cap, args...)		\
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
>>
> 


