Return-Path: <linux-pci+bounces-33306-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1D1B18613
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 18:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5C41188A227
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 16:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066AC1DB377;
	Fri,  1 Aug 2025 16:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="YiczCgXe"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529C013B58D;
	Fri,  1 Aug 2025 16:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754067311; cv=none; b=dCl5Y4HCtrpAwOeUSkJr0Ol5LwWksL38GpqHeXu7NrdtwtJrVY7j42IsmHus0aiETIgnJ0zz9GV1L2B/q5/dwiF5aump5d4mNeQbFInuH/SK23I0VFOlFU2pKAmmvj/jzZEMqHtzGMUH8d6ucSmRMQcnWktBKtIiDTh9s54plao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754067311; c=relaxed/simple;
	bh=E1oHwcjz1UkMy5n80W7KOoeyrVlY8354cvfcN9IThP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D7uCPrPyyH+fFNV1Bsh2f6j0jWZdHfgf7JJliHRXmSOkyOB98OXHyefFvQVSh/jruHntUAnber7Zoj1pH6+yJDZwS1CjLrcDR4NUxBtto1tyKxIsAw+It3MK2o0ypRf3/TqqDvgZ7rlPt6MAjpPaSbatRRYWnnkB/QaizMcvthg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=YiczCgXe; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=ZHD4zlqBg4vyKNckG/xTKO9RRemj+oorW2za/dflA9A=;
	b=YiczCgXe8uRiXNXEQutI/0eyQsKmiCUAjO63yc6w1YHPv53KfWNx+lGGz+wZm2
	SaomrFgD5jXGiYHR2KteTkIeeGW9GVL8eJ/ahMCD8OSD3u0hd81pu3XA14b5RH9b
	1DlAOkK9y7DO67g1T1gcmEQUXo1jmcF2c7I54XQ1GQoDE=
Received: from [IPV6:240e:b8f:919b:3100:ecd9:c243:2a5f:12dd] (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wDnn5VD8YxoofS4Iw--.19322S2;
	Sat, 02 Aug 2025 00:54:29 +0800 (CST)
Message-ID: <659b8389-16a7-423b-a231-5489c7cc0da9@163.com>
Date: Sat, 2 Aug 2025 00:54:27 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: Fix endianness issues in pci_bus_read_config()
To: Gerd Bayer <gbayer@linux.ibm.com>, Manivannan Sadhasivam
 <mani@kernel.org>, Hans Zhang <hans.zhang@cixtech.com>
Cc: Arnd Bergmann <arnd@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
 bhelgaas@google.com, Alexander Gordeev <agordeev@linux.ibm.com>,
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
 <06f16b1a55eede3dc3e0bf31ff14eca89ab6f009.camel@linux.ibm.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <06f16b1a55eede3dc3e0bf31ff14eca89ab6f009.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wDnn5VD8YxoofS4Iw--.19322S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJw18XFy3AryrGFWfAryxKrg_yoWrtr1fpF
	W5Aayjyr48tr1ayrn2va18Xw1jyFn7tF4UZF1fG342vFn0yr1SqryjgF4agr1jqw48XF18
	Z39YgFZ7Cw1DAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UulksUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOgyco2iM6Nr5SgAAss



On 2025/8/1 19:30, Gerd Bayer wrote:
> On Fri, 2025-08-01 at 16:24 +0530, Manivannan Sadhasivam wrote:
> 
> <--- snip --->
> 
>>>>>>> The pci_bus_read_config() interface itself may have been a
>>>>>>> mistake, can't the callers just use the underlying helpers
>>>>>>> directly?
>>>>>>>
>>>>>>
>>>>>> They can! Since the callers of this API is mostly the macros, we can easily
>>>>>> implement the logic to call relevant accessors based on the requested size.
>>>>>>
>>>>>> Hans, could you please respin the series based the feedback since the series is
>>>>>> dropped for 6.17.
>>>>>>
>>>>>
>>>>> Dear all,
>>>>>
>>>>> I am once again deeply sorry for the problems that occurred in this series.
>>>>> I only test pulling the ARM platform.
>>>>>
>>>>> Thank you very much, Gerd, for reporting the problem.
> 
> no worries!
> 
>>>>> Thank you all for your discussions and suggestions for revision.
>>>>>
>>>>> Hi Mani,
>>>>>
>>>>> Geert provided a solution. My patch based on this is as follows. Please
>>>>> check if there are any problems.
>>>>> https://lore.kernel.org/linux-pci/CAMuHMdVwFeV46oCid_sMHjXfP+yyGTpBfs9t3uaa=wRxNcSOAQ@mail.gmail.com/
>>>>>
>>>>> Also, please ask Gerd to help test whether it works properly. Thank you very
>>>>> much.
>>>>>
> 
> I found Geert's proposal intriguing for a quick resolution of the
> issue. Yet, I have not tried that proposal, though.
> 

Hi Gerd,

As I mentioned in my reply to Mani's email, the data ultimately read 
here is also a forced type conversion.

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

And this function. Could it be that I misunderstood something?

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

> Instead I spent some more cycles on Lukas' and Mani's question about
> the value of the pci_bus_read_config() helper. So I changed
> PCI_FIND_NEXT_CAP and PCI_FIND_NEXT_EXT_CAP to use size-aware versions
> of read_cfg accessor functions like this:
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index ac954584d991..9e2f75ede95f 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -109,17 +109,17 @@ int pci_bus_read_config(void *priv, unsigned int
> devfn, int where, u32 size,
>   ({
> \
>          int __ttl = PCI_FIND_CAP_TTL;
> \
>          u8 __id, __found_pos = 0;
> \
> -       u32 __pos = (start);
> \
> -       u32 __ent;
> \
> +       u8 __pos = (start);
> \
> +       u16 __ent;
> \
>                                                                        
> \
> -       read_cfg(args, __pos, 1, &__pos);
> \
> +       read_cfg##_byte(args, __pos, &__pos);
> \
>                                                                        
> \
>          while (__ttl--) {
> \
>                  if (__pos < PCI_STD_HEADER_SIZEOF)
> \
>                          break;
> \
>                                                                        
> \
>                  __pos = ALIGN_DOWN(__pos, 4);
> \
> -               read_cfg(args, __pos, 2, &__ent);
> \
> +               read_cfg##_word(args, __pos, &__ent);
> \
>                                                                        
> \
>                  __id = FIELD_GET(PCI_CAP_ID_MASK, __ent);
> \
>                  if (__id == 0xff)
> \
> @@ -158,7 +158,7 @@ int pci_bus_read_config(void *priv, unsigned int
> devfn, int where, u32 size,
>                                                                        
> \
>          __ttl = (PCI_CFG_SPACE_EXP_SIZE - PCI_CFG_SPACE_SIZE) / 8;
> \
>          while (__ttl-- > 0 && __pos >= PCI_CFG_SPACE_SIZE) {
> \
> -               __ret = read_cfg(args, __pos, 4, &__header);
> \
> +               __ret = read_cfg##_dword(args, __pos, &__header);
> \
>                  if (__ret != PCIBIOS_SUCCESSFUL)
> \
>                          break;
> \
>                                                                        
> \
> 
> 
> This fixes the issue for s390's use-cases. With that
> pci_bus_read_config() becomes unused - and could be removed in further
> refinements.
>                                                                        
> However, this probably breaks your dwc and cdns use-cases. I think,
> with the accessor functions for dwc and cadence changed to follow the
> {_byte|_word|_dword} naming pattern they could be used straight out of
> PCI_FIND_NEXT_{EXT_}CAP, too. Then, dw_pcie_read_cfg() and
> cdns_pcie_read_cfg become obsolete as well.
> 
> Thoughts?

In my opinion, it's no problem. I can provide the corresponding function 
of {_byte / _word / _dword}. But it is necessary to know Bjorn, Mani, 
Arnd, Lukas... Their viewpoints or suggestions.

Best regards,
Hans


