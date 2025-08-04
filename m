Return-Path: <linux-pci+bounces-33350-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A14E2B19D92
	for <lists+linux-pci@lfdr.de>; Mon,  4 Aug 2025 10:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D7527AB144
	for <lists+linux-pci@lfdr.de>; Mon,  4 Aug 2025 08:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70BDF1DF985;
	Mon,  4 Aug 2025 08:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="e+6ibFyJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D327241673;
	Mon,  4 Aug 2025 08:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754295986; cv=none; b=XrP2sGE/2HpnMN+O+UtVhyfjehxnrGyY3Zjm6yjrZSd2DgEgqPef3elEDn34Qw3Dyn5DWTYFK+D7aY3YggUV3jZs95LsPJ8mkC64iIVeZsXvPzNR4vVhjAzJxszyePKJzNc1hCdarNO3vaSz81TEt3ihoQaZSd980myANZFMhug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754295986; c=relaxed/simple;
	bh=4nz2pQeFXCsvdMKj0bF/k07bhoSmBAiNp2ChdL1jFzo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=frUe/QE8MxWKGgTt5BfLTjmU/H8Ln4FrLLfkdOCApE8yt6SITRRlLqAfArBoewLQLvor+KXZLuRADPU9Y4XtWb90n+HfaLN2DlsMZtEEhN/FxzJxn09JQ3Pu+3QnIRBwIFP7XT0Ju0b7PTs6UF2o8Wxrmb5YV1/BzgcLYhGYWi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=e+6ibFyJ; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=hf1vje5kyoKYOcmhLP1VHV7D/dW4HdknY9UdhcGoZdM=;
	b=e+6ibFyJF1BjSOiseLpLnkNuk553jPYcnTOS2E5AGSqDF9L0hXkZZChIeIbDux
	0QhKjaqnhF2RKC1eqiFYZHeCRjFCFixMVWaciK9yGq0SPhCLqsJX6Y767k2yYx+T
	rZmHGs2rLSXhapWARp+KpSztDCRo4Qaj94jPGlTHWzk8A=
Received: from [192.168.106.52] (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wCHQqGAbpBohEodJg--.27698S2;
	Mon, 04 Aug 2025 16:25:39 +0800 (CST)
Message-ID: <f4dfc405-1841-4254-95e9-2079c183277d@163.com>
Date: Mon, 4 Aug 2025 16:25:35 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: Fix endianness issues in pci_bus_read_config()
To: Arnd Bergmann <arnd@kernel.org>, Gerd Bayer <gbayer@linux.ibm.com>,
 Manivannan Sadhasivam <mani@kernel.org>, Hans Zhang <hans.zhang@cixtech.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, bhelgaas@google.com,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 jingoohan1@gmail.com, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-next <linux-next@vger.kernel.org>,
 linux-pci@vger.kernel.org, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Rob Herring <robh@kernel.org>, Niklas Schnelle <schnelle@linux.ibm.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>
References: <20250731183944.GA3424583@bhelgaas>
 <6e34b4af-dff9-4360-b3da-c95ca7c740c9@app.fastmail.com>
 <vf65usnffqzlkgijm72nuaslxnflwrugc25vw6q6blbn2s2d2s@b35vjkowd6yc>
 <9a155e45-f723-4eec-81d3-2547bfe9a4e9@cixtech.com>
 <ofsbfhor5ah3yzvkc5g5kb4fpjlzoqkkzukctmr3f6ur4vl2e7@7zvudt63ucbk>
 <c8ffdd21-9000-40c2-9f4d-4d6318e730b5@cixtech.com>
 <cu7qdbwmnixqjce4aetr5ldwe3sqoixgq4fuzmzajzphjdywqq@yw6ojbgeqktm>
 <06f16b1a55eede3dc3e0bf31ff14eca89ab6f009.camel@linux.ibm.com>
 <06012cc6-824d-4a7d-85c9-9995ec915382@163.com>
 <74c17623-f1b5-4b28-a118-4e828e1e711a@app.fastmail.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <74c17623-f1b5-4b28-a118-4e828e1e711a@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wCHQqGAbpBohEodJg--.27698S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXFykWF4DAF45JrW7Zr1rCrg_yoW5CryDpF
	Z8Cr4Fyw45Grn2krW0v3W0q3W0qa1rtFsIkwn5X34UuFsYgr13GFWY9w4a9r1ak3y8X3WI
	vFZrKFy7G3Z0yFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jbR6wUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWxafo2iQaIvKrgAAsO



On 2025/8/4 16:03, Arnd Bergmann wrote:
> On Mon, Aug 4, 2025, at 05:06, Hans Zhang wrote:
>> On 2025/8/1 19:30, Gerd Bayer wrote:
>>> On Fri, 2025-08-01 at 16:24 +0530, Manivannan Sadhasivam wrote:
>>    }
>>
>> +#define CDNS_PCI_OP_READ(size, type, len)		\
>> +static inline int cdns_pcie_read_cfg_##size		\
>> +	(struct cdns_pcie *pcie, int where, type *val)	\
>> +{							\
>> +	if (len == 4)					\
>> +		*val = cdns_pcie_readl(pcie, where);	\
>> +	else if (len == 2)				\
>> +		*val = cdns_pcie_readw(pcie, where);	\
>> +	else if (len == 1)				\
>> +		*val = cdns_pcie_readb(pcie, where);	\
>> +	else						\
>> +		return PCIBIOS_BAD_REGISTER_NUMBER;	\
>> +							\
>> +	return PCIBIOS_SUCCESSFUL;			\
>> +}
>> +
>> +CDNS_PCI_OP_READ(byte, u8, 1)
>> +CDNS_PCI_OP_READ(word, u16, 2)
>> +CDNS_PCI_OP_READ(dword, u32, 4)
>> +
> 
> This is fine for the calling conventions, but the use of a macro
> doesn't really help readability, so I'd suggest just having
> separate inline functions if they are even needed.
> 

Dear Arnd,

Thank you very much for your reply.

Will change.

>> @@ -112,17 +110,17 @@ int pci_bus_read_config(void *priv, unsigned int
>> devfn, int where, u32 size,
>>    ({									\
>>    	int __ttl = PCI_FIND_CAP_TTL;					\
>>    	u8 __id, __found_pos = 0;					\
>> -	u32 __pos = (start);						\
>> -	u32 __ent;							\
>> +	u8 __pos = (start);						\
>> +	u16 __ent;							\
>>    									\
>> -	read_cfg(args, __pos, 1, &__pos);				\
>> +	read_cfg##_byte(args, __pos, &__pos);				\
>>    									\
>>    	while (__ttl--) {						\
>>    		if (__pos < PCI_STD_HEADER_SIZEOF)			\
>>    			break;						\
>>    									\
>>    		__pos = ALIGN_DOWN(__pos, 4);				\
>> -		read_cfg(args, __pos, 2, &__ent);			\
>> +		read_cfg##_word(args, __pos, &__ent);			\
>>    									\
>>    		__id = FIELD_GET(PCI_CAP_ID_MASK, __ent);		\
>>    		if (__id == 0xff)					\
> 
> I still don't feel great about this macro either, and suspect
> we should have a better abstraction with fixed types and a
> global function to do it, but I don't see anything obviously
> wrong here either.


Here is the history of communication with Bjorn and Ilpo. Because 
variable parameters need to be used, otherwise it will be very difficult 
to unify. I'll also think about your proposal again.


Bjorn:
https://lore.kernel.org/linux-pci/20250715224705.GA2504490@bhelgaas/
 > > I would like this a lot better if it could be implemented as a
 > > function, but I assume it has to be a macro for some varargs reason.
 > >
 >
Hans:
https://lore.kernel.org/linux-pci/903ea9c4-87d6-45a8-9825-4a0d45ec608f@163.com/
 > Yes. The macro definitions used in combination with the previous review
 > opinions of Ilpo.

Ilpo:
https://lore.kernel.org/linux-pci/d59fde6e-3e4a-248a-ae56-c35b4c6ec44c@linux.intel.com/
The other option would be to standardize the accessor interface signature
and pass the function as a pointer. One might immediately think of generic
PCI core accessors making it sound simpler than it is but here the
complication is the controller drivers want to pass some internal
structure due to lack of pci_dev so it would need to be void
*read_cfg_data. Then we'd need to deal with those voids also in some
generic PCI accessors which is a bit ugly.


Best regards,
Hans


