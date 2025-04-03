Return-Path: <linux-pci+bounces-25235-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0EFA7A2C4
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 14:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C019E3B152F
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 12:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5621424C664;
	Thu,  3 Apr 2025 12:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="b095BoVU"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9D21519A7;
	Thu,  3 Apr 2025 12:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743683005; cv=none; b=YKP/zJ1Ckd/8hxVHJrbylJwLIim+rEytck0bSgirzc5iQlzuiE2OPaegeItIPnDsSGSwVeHKf8zB49xKBSx0iBljjRg6/jiaNUlgUL83apCW6MlCm5ZmT/97wAxfbjbceIr4KZt/6XIkLT0XJZs8bZ/fECf6jj4FD5Tq35KXdss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743683005; c=relaxed/simple;
	bh=dTsk6jVV77kmc52ANl2APXx3BgqrXor8y0sjiAJh9Ec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PR9Djnb5Yxr2WBmDxXYGE/dtQ5aIeHCwJ9De6MDxNnUyoYwu+MYpreiZ/SUnfK2/vBCQapHi6a3a05B0NebPSzKDaX/am14ID011sTcX4IZG75Fkde4VEeHH/tDJneQ0zdT+ndpWSYQOChHz4M4c7EgeDYKNFVHYO6u4U6gMOjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=b095BoVU; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=jzTFYbRyxfLAxh1qRBREFMy7wKyLY9dTmew/M4yIJEo=;
	b=b095BoVUCOumXO/TaLxXkY1zpZ2ZYpyuOa+tDwCKzryNAA8DfXlLJboOL/OM6F
	qZoWQ4ZZL3AyxwLLNTkhtWhjPNdOLDRVys3xWJ0F5zXEc+mHr75JVAArfug504K4
	+UH0M3RRH1rJDOtB9eZU4qZkceA1XC2/Hp5rgoh6SK3SE=
Received: from [192.168.60.52] (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wCnX6dvfe5nWSc0Dw--.58961S2;
	Thu, 03 Apr 2025 20:22:09 +0800 (CST)
Message-ID: <a0483c8d-3cd4-4da2-aca5-586379870e3a@163.com>
Date: Thu, 3 Apr 2025 20:22:07 +0800
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
 <6075b776-d2be-49d3-8321-e6af66781709@163.com>
 <9e9a68b1-8c3a-6132-d4fc-9f7b0b2d3e3a@linux.intel.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <9e9a68b1-8c3a-6132-d4fc-9f7b0b2d3e3a@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCnX6dvfe5nWSc0Dw--.58961S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXw13XF48Kr17Kryftw1kKrg_yoW5uFyxpr
	yUC3WayrWkJr17tw1Iqa4jgwnFqF92yayq934UG3W8JFyvyF1xGrWYkr129FyfZws5GF1U
	X34j9as3GFsIyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UL4SwUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOh4ko2fufCMlEQAAsB



On 2025/4/3 17:10, Ilpo Järvinen wrote:
>>>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>>>> index 2e9cf26a9ee9..f705b8bd3084 100644
>>>> --- a/drivers/pci/pci.h
>>>> +++ b/drivers/pci/pci.h
>>>> @@ -89,6 +89,87 @@ bool pcie_cap_has_lnkctl(const struct pci_dev *dev);
>>>>    bool pcie_cap_has_lnkctl2(const struct pci_dev *dev);
>>>>    bool pcie_cap_has_rtctl(const struct pci_dev *dev);
>>>>    +/* Standard Capability finder */
>>>> +/**
>>>> + * PCI_FIND_NEXT_CAP_TTL - Find a PCI standard capability
>>>> + * @read_cfg: Function pointer for reading PCI config space
>>>> + * @start: Starting position to begin search
>>>> + * @cap: Capability ID to find
>>>> + * @args: Arguments to pass to read_cfg function
>>>> + *
>>>> + * Iterates through the capability list in PCI config space to find
>>>> + * the specified capability. Implements TTL (time-to-live) protection
>>>> + * against infinite loops.
>>>> + *
>>>> + * Returns: Position of the capability if found, 0 otherwise.
>>>> + */
>>>> +#define PCI_FIND_NEXT_CAP_TTL(read_cfg, start, cap, args...)
>>>> \
>>>> +({									\
>>>> +	u8 __pos = (start);						\
>>>> +	int __ttl = PCI_FIND_CAP_TTL;					\
>>>> +	u16 __ent;							\
>>>> +	u8 __found_pos = 0;						\
>>>> +	u8 __id;							\
>>>> +									\
>>>> +	read_cfg(args, __pos, 1, (u32 *)&__pos);			\
>>>> +									\
>>>> +	while (__ttl--) {						\
>>>> +		if (__pos < PCI_STD_HEADER_SIZEOF)			\
>>>> +			break;						\
>>>> +		__pos = ALIGN_DOWN(__pos, 4);				\
>>>> +		read_cfg(args, __pos, 2, (u32 *)&__ent);		\
>>>> +		__id = FIELD_GET(PCI_CAP_ID_MASK, __ent);		\
>>>> +		if (__id == 0xff)					\
>>>> +			break;						\
>>>> +		if (__id == (cap)) {					\
>>>> +			__found_pos = __pos;				\
>>>> +			break;						\
>>>> +		}							\
>>>> +		__pos = FIELD_GET(PCI_CAP_LIST_NEXT_MASK, __ent);	\
>>>
>>> Could you please separate the coding style cleanups into own patch that
>>> is before the actual move patch. IMO, all those cleanups can be in the
>>> same patch.
>>>
>>
>> Hi Ilpo,
>>
>> Thanks your for reply. I don't understand. Is it like this?
> 
> Add a patch before the first patch which does only the cleanups to
> __pci_find_next_cap_ttl(). The patch that creates PCI_FIND_NEXT_CAP_TTL()
> and converts its PCI core users (most of the patches 1&2) is to be based
> on top of that cleanup patch.
> 

Hi Ilpo,

Thank you so much for your patience in explaining it to me.

>> #define PCI_FIND_NEXT_CAP_TTL(read_cfg, start, cap, args...)		\
>> ({									\
>> 	int __ttl = PCI_FIND_CAP_TTL;					\
>> 	u8 __id, __found_pos = 0;					\
>> 	u8 __pos = (start);						\
>> 	u16 __ent;							\
>> 									\
>> 	read_cfg(args, __pos, 1, (u32 *)&__pos);			\
>> 									\
>> 	while (__ttl--) {						\
>> 		if (__pos < PCI_STD_HEADER_SIZEOF)			\
>> 			break;						\
>> 									\
>> 		__pos = ALIGN_DOWN(__pos, 4);				\
>> 		read_cfg(args, __pos, 2, (u32 *)&__ent);		\
>> 									\
>> 		__id = FIELD_GET(PCI_CAP_ID_MASK, __ent);		\
>> 		if (__id == 0xff)					\
>> 			break;						\
>> 									\
>> 		if (__id == (cap)) {					\
>> 			__found_pos = __pos;				\
>> 			break;						\
>> 		}							\
>> 									\
>> 		__pos = FIELD_GET(PCI_CAP_LIST_NEXT_MASK, __ent);	\
>> 	}								\
>> 	__found_pos;							\
>> })
>>
>>> You also need to add #includes for the defines you now started to use.
>>>
>>
>> Is that what you mean?
>>
>> +#include <linux/bitfield.h>
>> +#include <linux/align.h>
>> +#include <uapi/linux/pci_regs.h>
> 
> Almost, including pci_regs.h is not strictly necessary as linux/pci.h will
> always pull that one in (not that it would hurt).
> 
> Also, sort the includes alphabetically.
> 

OK，will change.

Best regards,
Hans


