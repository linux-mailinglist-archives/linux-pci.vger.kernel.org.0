Return-Path: <linux-pci+bounces-33305-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F738B18603
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 18:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 909C5188DC39
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 16:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548A01C1AB4;
	Fri,  1 Aug 2025 16:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="G0Tg2Wsm"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A5419F11B;
	Fri,  1 Aug 2025 16:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754066916; cv=none; b=SnqEONWu49rwclvi3VSPUguQTHbhYrWD71pdDt7Fgg8wL+AsTRyZKnxb0sQWIhrg3KjFEgfbQVVW1chThuYaK3Cdq1OSxXLaY2gdO42pg5uC5SbCndVB5BCnI4hmXj1CB6DtmVStXoNapChWlynviYslsymkmDLktSjGh8JKZfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754066916; c=relaxed/simple;
	bh=ER9+A0AQoiNiR8H7LAXm3gGnSWm591ietRBP/qtDclg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sfQIX1okwNfQgHrtb1Ax/kDgTDgCEz8gtDxALv4GritSnzl8qUyOBIlf2+bLTHevOij076Hd0+8GUeodCqyb2KfQkfZ5pfhOm+Q12lMsCnneW/dxLk8dldixD57ZXtMHs0XSnozIb2iO3HjBWXW7SCvuccUWkxSRecVUek6hzuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=G0Tg2Wsm; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=EuM2jIdoJNNlb/WdA0ZGl2UlMubVd2wOiR6EDWunrvU=;
	b=G0Tg2WsmgYqUNWajbdw3ELSQGqEYioLEoLoGp2OvqbxGXYqvPg5xuaX74lYWuP
	2Y5dp3q576p42YLrB3VOks/ZUzkmS7MyR0IGyRhRhSvpKaWnIlLefJkFXCEdHNjT
	M88bEu0msBjo0xmwaDqZGTrwrTpfV9qAu3mj9/t3qSTTY=
Received: from [IPV6:240e:b8f:919b:3100:ecd9:c243:2a5f:12dd] (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wCHV0a774xoRDSkIw--.11070S2;
	Sat, 02 Aug 2025 00:47:56 +0800 (CST)
Message-ID: <f28be780-445e-4823-a0c5-44c61241d93f@163.com>
Date: Sat, 2 Aug 2025 00:47:55 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: Fix endianness issues in pci_bus_read_config()
To: Manivannan Sadhasivam <mani@kernel.org>,
 Hans Zhang <hans.zhang@cixtech.com>
Cc: Arnd Bergmann <arnd@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
 Gerd Bayer <gbayer@linux.ibm.com>, bhelgaas@google.com,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 jingoohan1@gmail.com, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-next <linux-next@vger.kernel.org>,
 linux-pci@vger.kernel.org, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Rob Herring <robh@kernel.org>, Niklas Schnelle <schnelle@linux.ibm.com>,
 geert@linux-m68k.org
References: <20250731183944.GA3424583@bhelgaas>
 <6e34b4af-dff9-4360-b3da-c95ca7c740c9@app.fastmail.com>
 <vf65usnffqzlkgijm72nuaslxnflwrugc25vw6q6blbn2s2d2s@b35vjkowd6yc>
 <9a155e45-f723-4eec-81d3-2547bfe9a4e9@cixtech.com>
 <ofsbfhor5ah3yzvkc5g5kb4fpjlzoqkkzukctmr3f6ur4vl2e7@7zvudt63ucbk>
 <c8ffdd21-9000-40c2-9f4d-4d6318e730b5@cixtech.com>
 <cu7qdbwmnixqjce4aetr5ldwe3sqoixgq4fuzmzajzphjdywqq@yw6ojbgeqktm>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <cu7qdbwmnixqjce4aetr5ldwe3sqoixgq4fuzmzajzphjdywqq@yw6ojbgeqktm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wCHV0a774xoRDSkIw--.11070S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Wr1kGFWxWrWUCryxKr4Durg_yoWxJw1DpF
	W5JFW2yr4UJF13Arn2q3WFqr1Iyr9rJF1UXrn5W34UZFn0vr1FqFy0gF4YgFy0gr48JF4I
	vws0qFW3u34qyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UtuciUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWwCco2iM6bG1mgAAs3



On 2025/8/1 18:54, Manivannan Sadhasivam wrote:
> On Fri, Aug 01, 2025 at 06:06:16PM GMT, Hans Zhang wrote:
>>
>>
>> On 2025/8/1 17:47, Manivannan Sadhasivam wrote:
>>> EXTERNAL EMAIL
>>>
>>> On Fri, Aug 01, 2025 at 05:25:51PM GMT, Hans Zhang wrote:
>>>>
>>>>
>>>> On 2025/8/1 16:18, Manivannan Sadhasivam wrote:
>>>>> EXTERNAL EMAIL
>>>>>
>>>>> On Thu, Jul 31, 2025 at 09:01:17PM GMT, Arnd Bergmann wrote:
>>>>>> On Thu, Jul 31, 2025, at 20:39, Bjorn Helgaas wrote:
>>>>>>> On Thu, Jul 31, 2025 at 07:38:58PM +0200, Gerd Bayer wrote:
>>>>>>>>
>>>>>>>> -  if (size == 1)
>>>>>>>> -          return pci_bus_read_config_byte(bus, devfn, where, (u8 *)val);
>>>>>>>> -  else if (size == 2)
>>>>>>>> -          return pci_bus_read_config_word(bus, devfn, where, (u16 *)val);
>>>>>>>> -  else if (size == 4)
>>>>>>>> -          return pci_bus_read_config_dword(bus, devfn, where, val);
>>>>>>>> -  else
>>>>>>>> -          return PCIBIOS_BAD_REGISTER_NUMBER;
>>>>>>>> +  if (size == 1) {
>>>>>>>> +          rc = pci_bus_read_config_byte(bus, devfn, where, (u8 *)val);
>>>>>>>> +#if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))
>>>>>>>> +          *val = ((*val >> 24) & 0xff);
>>>>>>>> +#endif
>>>>>>>
>>>>>>> Yeah, this is all pretty ugly.  Obviously the previous code in
>>>>>>> __pci_find_next_cap_ttl() didn't need this.  My guess is that was
>>>>>>> because the destination for the read data was always the correct type
>>>>>>> (u8/u16/u32), but here we always use a u32 and cast it to the
>>>>>>> appropriate type.  Maybe we can use the correct types here instead of
>>>>>>> the casts?
>>>>>>
>>>>>> Agreed, the casts here just add more potential for bugs.
>>>>>>
>>>>>
>>>>> Ack. Missed the obvious issue during review.
>>>>>
>>>>>> The pci_bus_read_config() interface itself may have been a
>>>>>> mistake, can't the callers just use the underlying helpers
>>>>>> directly?
>>>>>>
>>>>>
>>>>> They can! Since the callers of this API is mostly the macros, we can easily
>>>>> implement the logic to call relevant accessors based on the requested size.
>>>>>
>>>>> Hans, could you please respin the series based the feedback since the series is
>>>>> dropped for 6.17.
>>>>>
>>>>
>>>> Dear all,
>>>>
>>>> I am once again deeply sorry for the problems that occurred in this series.
>>>> I only test pulling the ARM platform.
>>>>
>>>> Thank you very much, Gerd, for reporting the problem.
>>>>
>>>> Thank you all for your discussions and suggestions for revision.
>>>>
>>>> Hi Mani,
>>>>
>>>> Geert provided a solution. My patch based on this is as follows. Please
>>>> check if there are any problems.
>>>> https://lore.kernel.org/linux-pci/CAMuHMdVwFeV46oCid_sMHjXfP+yyGTpBfs9t3uaa=wRxNcSOAQ@mail.gmail.com/
>>>>
>>>> Also, please ask Gerd to help test whether it works properly. Thank you very
>>>> much.
>>>>
>>>>
>>>> If there are no issues, am I sending the new version? Can this series of
>>>> pacth 0001 be directly replaced?
>>>>
>>>
>>> What benefit does this helper provide if it simply invokes the accessors based
>>> on the requested size? IMO, the API should not return 'int' sized value if the
>>> caller has explicitly requested to read variable size from config space.
>>>
>>
>> Dear Mani,
>>
>> This newly added macro definition PCI_FIND_NEXT_CAP is derived from
>> __pci_find_next_cap_ttl. Another newly added macro definition,
>> PCI_FIND_NEXT_EXT_CAP, is derived from pci_find_next_ext_capability. The
>> first one has no return value judgment, while the second one has a judgment
>> return value. So, pci_bus_read_config is defined as having an int return
>> value.
>>
> 
> Sorry, my previous reply was not clear. I was opposed to returning 'u32 *val'
> for a variable 'size' value. The API should only return 'val' of 'size' ie. if
> size is 1, it should return 'u8 *val' and so on. It finally breaks down to
> calling the underlying accessors. So I don't see a value in having this API.

Dear Mani,

In this series, I had similar confusion before.
https://lore.kernel.org/linux-pci/4d77e199-8df8-4510-ad49-9a452a29c923@163.com/


I think there are a few pieces of code that stand out, such as:

Forced type conversion is also used here. (*value = (type)data;)


drivers/pci/access.c
#define PCI_OP_READ(size, type, len) \
int noinline pci_bus_read_config_##size \
	(struct pci_bus *bus, unsigned int devfn, int pos, type *value)	\
{									\
	unsigned long flags;						\
	u32 data = 0;							\
	int res;							\
									\
	if (PCI_##size##_BAD)						\
		return PCIBIOS_BAD_REGISTER_NUMBER;			\
									\
	pci_lock_config(flags);						\
	res = bus->ops->read(bus, devfn, pos, len, &data);		\
	if (res)							\
		PCI_SET_ERROR_RESPONSE(value);				\
	else								\
		*value = (type)data;					\
	pci_unlock_config(flags);					\
									\
	return res;							\
}


This function also uses u32 *val as its return value.

int pci_generic_config_read(struct pci_bus *bus, unsigned int devfn,
			    int where, int size, u32 *val)
{
	void __iomem *addr;

	addr = bus->ops->map_bus(bus, devfn, where);
	if (!addr)
		return PCIBIOS_DEVICE_NOT_FOUND;

	if (size == 1)
		*val = readb(addr);
	else if (size == 2)
		*val = readw(addr);
	else
		*val = readl(addr);

	return PCIBIOS_SUCCESSFUL;
}
EXPORT_SYMBOL_GPL(pci_generic_config_read);


And it's the same here.
drivers/pci/controller/dwc/pcie-designware.c
int dw_pcie_read(void __iomem *addr, int size, u32 *val)
{
	if (!IS_ALIGNED((uintptr_t)addr, size)) {
		*val = 0;
		return PCIBIOS_BAD_REGISTER_NUMBER;
	}

	if (size == 4) {
		*val = readl(addr);
	} else if (size == 2) {
		*val = readw(addr);
	} else if (size == 1) {
		*val = readb(addr);
	} else {
		*val = 0;
		return PCIBIOS_BAD_REGISTER_NUMBER;
	}

	return PCIBIOS_SUCCESSFUL;
}
EXPORT_SYMBOL_GPL(dw_pcie_read);


Mani, I'm not here to refute you. I just want to ask if there are bugs 
everywhere here?

I think it's a good idea as mentioned in Gerd's latest reply email. For 
dw_pcie_read_cfg() and cdns_pcie_read_cfg, I can delete it and provide 
the macro definition function of {_byte/_word/_dword}.

Similar to this macro definition:
PCI_OP_READ(byte, u8, 1)
PCI_OP_READ(word, u16, 2)
PCI_OP_READ(dword, u32, 4)
https://lore.kernel.org/linux-pci/06f16b1a55eede3dc3e0bf31ff14eca89ab6f009.camel@linux.ibm.com/


Best regards,
Hans


