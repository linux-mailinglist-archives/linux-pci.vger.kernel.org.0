Return-Path: <linux-pci+bounces-25189-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EAABA79232
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 17:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2BE116BE22
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 15:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961291FC3;
	Wed,  2 Apr 2025 15:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="KWGM4J1m"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E146FFC0A;
	Wed,  2 Apr 2025 15:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743607918; cv=none; b=eOPuS5Gsv1eZytZcNrADdUABONOEiySIhPTpc1jo1qBvpTAkegsfkBuB0lNjhPt7SmG1OGmBnGIl1LDvcjTyMahoegxEwH459+3aH6g2O2mAHdfXchDmIqYDnv54qaFCBe0s2qqRyIUYBSM2msWyUQQNzKgpeDQsNYwl3np/O78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743607918; c=relaxed/simple;
	bh=ZvaC7lpXSOuI4dB4ZlU0/joC5WBCSTHIFAP5Hov+n9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=STB5Bh+j332Dku9HLAUCuGvHN7MveR1LgXfEbIMfKKg1rJ+1AhIBMvu05OM5njhriZWanBAf75/duVu8+BySJrquy/Z2oI9+SHF1UNPXjKb5iYBZdN5ItdhAo5B2Y5TJ+koX2QKYOnSMlzTmAZDEeW58BQNzwJiBke9x61R+ihQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=KWGM4J1m; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=4l39NhV8qPw2Wptk13TuozTkwyJfRxy735w154HQJj0=;
	b=KWGM4J1mEKkLeIIYNTeWY+a2WJDo9xXJ6fCGyasp8oXLKX6w2U9x2iprMzvh23
	fRlisNkFi9JkkRNTkT4fsRf4/OjssLgnnY6B1pz8U1OFHlh3u0M9EDTi+61XP36J
	t1SSubrhLSiiOTmuwSz5RmPOlKQ7LH3TVlU2cN5wnXCHE=
Received: from [192.168.71.89] (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wBnF84+WO1nveRSDg--.44645S2;
	Wed, 02 Apr 2025 23:31:11 +0800 (CST)
Message-ID: <6075b776-d2be-49d3-8321-e6af66781709@163.com>
Date: Wed, 2 Apr 2025 23:31:10 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v7 1/5] PCI: Refactor capability search into common macros
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: lpieralisi@kernel.org, bhelgaas@google.com, kw@linux.com,
 manivannan.sadhasivam@linaro.org, robh@kernel.org, jingoohan1@gmail.com,
 thomas.richard@bootlin.com, linux-pci@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <20250402042020.48681-1-18255117159@163.com>
 <20250402042020.48681-2-18255117159@163.com>
 <909653ac-7ba2-9da7-f519-3d849146f433@linux.intel.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <909653ac-7ba2-9da7-f519-3d849146f433@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBnF84+WO1nveRSDg--.44645S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3XrW3CFykXFyfZrWDZFWkJFb_yoW7Cw4xpr
	n8CF1SyrWkJF42kwn7X3WUK342gFZ7Aayq934fGw1UXFykC3WxGr4FkF1agFy2yrZrAFy5
	Xr1q93Z5CanIyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U3739UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOh4jo2ftVsIlbAAAsz



On 2025/4/2 20:42, Ilpo Järvinen wrote:
> On Wed, 2 Apr 2025, Hans Zhang wrote:
> 
>> Introduce PCI_FIND_NEXT_CAP_TTL and PCI_FIND_NEXT_EXT_CAPABILITY macros
>> to consolidate duplicate PCI capability search logic found throughout the
>> driver tree. This refactoring:
>>
>>    1. Eliminates code duplication in capability scanning routines
>>    2. Provides a standardized, maintainable implementation
>>    3. Reduces error-prone copy-paste implementations
>>    4. Maintains identical functionality to existing code
>>
>> The macros abstract the low-level capability register scanning while
>> preserving the existing PCI configuration space access patterns. They will
>> enable future conversions of multiple capability search implementations
>> across various drivers (e.g., PCI core, controller drivers) to use
>> this centralized logic.
>>
>> Signed-off-by: Hans Zhang <18255117159@163.com>
>> ---
>>   drivers/pci/pci.h             | 81 +++++++++++++++++++++++++++++++++++
>>   include/uapi/linux/pci_regs.h |  2 +
>>   2 files changed, 83 insertions(+)
>>
>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>> index 2e9cf26a9ee9..f705b8bd3084 100644
>> --- a/drivers/pci/pci.h
>> +++ b/drivers/pci/pci.h
>> @@ -89,6 +89,87 @@ bool pcie_cap_has_lnkctl(const struct pci_dev *dev);
>>   bool pcie_cap_has_lnkctl2(const struct pci_dev *dev);
>>   bool pcie_cap_has_rtctl(const struct pci_dev *dev);
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
>> + * against infinite loops.
>> + *
>> + * Returns: Position of the capability if found, 0 otherwise.
>> + */
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
> 
> Could you please separate the coding style cleanups into own patch that
> is before the actual move patch. IMO, all those cleanups can be in the
> same patch.
> 

Hi Ilpo,

Thanks your for reply. I don't understand. Is it like this?

#define PCI_FIND_NEXT_CAP_TTL(read_cfg, start, cap, args...)		\
({									\
	int __ttl = PCI_FIND_CAP_TTL;					\
	u8 __id, __found_pos = 0;					\
	u8 __pos = (start);						\
	u16 __ent;							\
									\
	read_cfg(args, __pos, 1, (u32 *)&__pos);			\
									\
	while (__ttl--) {						\
		if (__pos < PCI_STD_HEADER_SIZEOF)			\
			break;						\
									\
		__pos = ALIGN_DOWN(__pos, 4);				\
		read_cfg(args, __pos, 2, (u32 *)&__ent);		\
									\
		__id = FIELD_GET(PCI_CAP_ID_MASK, __ent);		\
		if (__id == 0xff)					\
			break;						\
									\
		if (__id == (cap)) {					\
			__found_pos = __pos;				\
			break;						\
		}							\
									\
		__pos = FIELD_GET(PCI_CAP_LIST_NEXT_MASK, __ent);	\
	}								\
	__found_pos;							\
})

> You also need to add #includes for the defines you now started to use.
> 

Is that what you mean?

+#include <linux/bitfield.h>
+#include <linux/align.h>
+#include <uapi/linux/pci_regs.h>

Best regards,
Hans

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
>> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
>> index 3445c4970e4d..a11ebbab99fc 100644
>> --- a/include/uapi/linux/pci_regs.h
>> +++ b/include/uapi/linux/pci_regs.h
>> @@ -206,6 +206,8 @@
>>   /* 0x48-0x7f reserved */
>>   
>>   /* Capability lists */
>> +#define PCI_CAP_ID_MASK		0x00ff
>> +#define PCI_CAP_LIST_NEXT_MASK	0xff00
>>   
>>   #define PCI_CAP_LIST_ID		0	/* Capability ID */
>>   #define  PCI_CAP_ID_PM		0x01	/* Power Management */
>>
> 


