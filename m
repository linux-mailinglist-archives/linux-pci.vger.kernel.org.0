Return-Path: <linux-pci+bounces-33334-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE904B18F31
	for <lists+linux-pci@lfdr.de>; Sat,  2 Aug 2025 17:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48347189CD18
	for <lists+linux-pci@lfdr.de>; Sat,  2 Aug 2025 15:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5332723ED5B;
	Sat,  2 Aug 2025 15:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Yok6GSQO"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371FB15C158;
	Sat,  2 Aug 2025 15:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754148255; cv=none; b=L6wbDfvxukC4GSU6yN5//bcY2nTYtt7cgScDt4JTqA338YI/uREo7f/xXiWrElRz/GiM0drSSgs5S+ZLRNunpPrzR0nw9lpeHLg9uOgkEUrUf6TZ4+44sawGFRMUXvHFhoSbhM/YT7v59U4qd3KuB/UJuMS0ohqqJtIyTNSAmOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754148255; c=relaxed/simple;
	bh=7SwuS0e5Mm7qBSNVIoorKKIp0KpAUiVnT7Ez9QhYRNM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J5GNzxOydWkiT+LxacETc8K6H2QxlEG4a48UlS7wTaavMShSEVHBab+vmog9us8BsiJRIpRG4JnBo+4ne9t6uh1hNhAH6xn9QvVvtwsrK0iOVyFYybaIOaiH4iWj1DFLDQMlHbmiF9gOB0TWYS8JdIXpwZ71sSvf3CIs4DSHhLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Yok6GSQO; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=qo72/01PN/hdR6lvl9jgxOqtELAkEE3dNJ7kNf8Dy4s=;
	b=Yok6GSQOtap/8Ngzi0apy2swWSbV1qpuj+qp3AdJdU4SAABisbK5frg3ZxuONE
	nd5ZVFyeeI8YI7SCkXjOf630uRWc0CmXXbABArWQidGrC2H//ouJOjPrM9RulPvu
	AK4EGTMJKi8FEgDNhPOflGYmmWhOJ+F3dbmikNzqIXYQg=
Received: from [IPV6:240e:b8f:919b:3100:ecd9:c243:2a5f:12dd] (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wAXprp2LY5oEFSLJQ--.61565S2;
	Sat, 02 Aug 2025 23:23:35 +0800 (CST)
Message-ID: <d2240ab0-5d91-4b41-945f-e29b40f7b7f4@163.com>
Date: Sat, 2 Aug 2025 23:23:34 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: Fix endianness issues in pci_bus_read_config()
To: Keith Busch <kbusch@kernel.org>
Cc: Gerd Bayer <gbayer@linux.ibm.com>, Manivannan Sadhasivam
 <mani@kernel.org>, Hans Zhang <hans.zhang@cixtech.com>,
 Arnd Bergmann <arnd@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
 bhelgaas@google.com, Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 jingoohan1@gmail.com, =?UTF-8?Q?Krzysztof_Wilczy=C2=B4nski?=
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
 <659b8389-16a7-423b-a231-5489c7cc0da9@163.com> <aI0CupiFvyOvgNQY@kbusch-mbp>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <aI0CupiFvyOvgNQY@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wAXprp2LY5oEFSLJQ--.61565S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WF4DGw1UuFy7KFWkXryrJFb_yoW8AFWrpF
	y5ta18tF4kJrySvw1vq34vq3WSvanrKayDAr9xu3sIv3Z0yw1FvFyjgFy2qrWYga1kuF48
	Zw43JFW3Cw1qyaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UtuciUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWw6do2iOJ0KXvAAAsD



On 2025/8/2 02:08, Keith Busch wrote:
> On Sat, Aug 02, 2025 at 12:54:27AM +0800, Hans Zhang wrote:
>> As I mentioned in my reply to Mani's email, the data ultimately read here is
>> also a forced type conversion.
>>
>> #define PCI_OP_READ(size, type, len) \
>> int noinline pci_bus_read_config_##size \
>> 	(struct pci_bus *bus, unsigned int devfn, int pos, type *value)	\
>> {									\
>> 	unsigned long flags;						\
>> 	u32 data = 0;							\
>> 	int res;							\
>> 									\
>> 	if (PCI_##size##_BAD)						\
>> 		return PCIBIOS_BAD_REGISTER_NUMBER;			\
>> 									\
>> 	pci_lock_config(flags);						\
>> 	res = bus->ops->read(bus, devfn, pos, len, &data);		\
>> 	if (res)							\
>> 		PCI_SET_ERROR_RESPONSE(value);				\
>> 	else								\
>> 		*value = (type)data;					\
>> 	pci_unlock_config(flags);					\
>> 									\
>> 	return res;							\
>> }
>>
>> And this function. Could it be that I misunderstood something?
> 
> The above macro retains the caller's type for "value". If the caller
> passes a "u8 *", the value is deferenced as a u8.

Dear Keith,

In this macro definition, bus->ops->read needs to ensure the byte order 
of the read, as Lukas mentioned; otherwise, there is also a big-endian 
issue at this location.

> 
> The function below promotes everything to a u32 pointer and deferences
> it as such regardless of what type the user passed in.

I searched and learned that readb/readw/readl automatically handle byte 
order, so there is no big-endian order issue.

>   
>> int pci_generic_config_read(struct pci_bus *bus, unsigned int devfn,
>> 			    int where, int size, u32 *val)
>> {
>> 	void __iomem *addr;
>>
>> 	addr = bus->ops->map_bus(bus, devfn, where);
>> 	if (!addr)
>> 		return PCIBIOS_DEVICE_NOT_FOUND;
>>
>> 	if (size == 1)
>> 		*val = readb(addr);
>> 	else if (size == 2)
>> 		*val = readw(addr);
>> 	else
>> 		*val = readl(addr);
>>
>> 	return PCIBIOS_SUCCESSFUL;
>> }


Best regards,
Hans


