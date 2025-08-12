Return-Path: <linux-pci+bounces-33862-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 068EFB22B11
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 16:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F239B189503A
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 14:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5CCE28DB52;
	Tue, 12 Aug 2025 14:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="hSn9NDoP"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDFB2C159B;
	Tue, 12 Aug 2025 14:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755009881; cv=none; b=AnDn7hbKdrmQ2vhAwo9f5iPpeLw/fg7K8/R5qKljuErXC6vt5++csrQ4j8wQFKAAj/n99Z7iBVT07I+qhcUR0wQNh0JCn7sDW7qjMj7wHR8qaHp4cYHCt+RlXysQYrnZK2bMUPxt524jJHkLT7k4SsrT+S6kVtLgZ/Z0ErRAzMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755009881; c=relaxed/simple;
	bh=xuGaNBZVtuATaDvw043eDtsOmUQ4CSlU6fJHQ6dnGP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EWm6lakr/kdCYPmA5NzwAfIH30ZamW6JPK6+5QzBLDJ2CC45u4ZySC7239GWRFJ30aB85/+YvatLrdY5/Hf/tQnTVZARoxZLSSnM9YvGQf9TNhAbuSGfiKccU+0j9V6QxpaqwBsEj3Emlpf38t3eOpSJFmvJ4kEH0JqYvYjN7Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=hSn9NDoP; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=ZhsbIXFNOoOJ8ZX4+6Y1Tfv+zUQqehas4lLbJyxnt9U=;
	b=hSn9NDoPDyVhJnamiV1TQi5v2FbGParWsrEUpuyRTzLUf6FBtm1rShLeKJBBid
	FL1mEVeHMijfXyuRQC3YGTNVXGwfAyZMoHcG51t0wq5UeEhStFvixibXvzhecrWo
	kWeK52d4wF+kzzTxmS7B+5o91Aihk2LDJL7OUvMIxUrMg=
Received: from [IPV6:240e:b8f:919b:3100:3980:6173:5059:2d2a] (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgD3XxQ2U5toJw+iAA--.23507S2;
	Tue, 12 Aug 2025 22:44:08 +0800 (CST)
Message-ID: <9d0cce06-25fa-4ca6-8cd1-388e932d1ffc@163.com>
Date: Tue, 12 Aug 2025 22:44:06 +0800
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
 <06012cc6-824d-4a7d-85c9-9995ec915382@163.com>
 <6efa10219a41907ebdd7b75fc8d9249e115e8864.camel@linux.ibm.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <6efa10219a41907ebdd7b75fc8d9249e115e8864.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:PCgvCgD3XxQ2U5toJw+iAA--.23507S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ww15tF4fGFyUKryxuF47twb_yoW8Jw1fpF
	WSyF4akF4kGrWxJFWIgw1UXF1j93yvyryfu395Gwn8A3Z09r1rJrs3ZF4YgF9rGr97ur4Y
	va13ZF1aqryjvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UZiSLUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiQw+no2ibT2J2SgAAsq



On 2025/8/4 18:09, Gerd Bayer wrote:
> On Mon, 2025-08-04 at 11:06 +0800, Hans Zhang wrote:
>>
>> On 2025/8/1 19:30, Gerd Bayer wrote:
>>> On Fri, 2025-08-01 at 16:24 +0530, Manivannan Sadhasivam wrote:
>>>
>>> <--- snip --->
>>>
>>>>>>
>>
>> Dear all,
>>
>> According to the issue mentioned by Lukas and Mani. Gerd has already
>> been tested on the s390. I have tested it on the RK3588 and it works
>> fine. RK3588 uses Synopsys' PCIe IP, that is, the DWC driver. Our
>> company's is based on Cadence's PCIe 4.0 IP, and the test function is
>> normal. All the platforms I tested were based on ARM.
>>
>> The following is the patch based on the capability-search branch. May I
>> ask everyone, do you have any more questions?
>>
>> Gerd, if there's no problem, I'll add your Tested-by label.
> 
> Before you add that I'd like to re-test with the "final" patch.
> 
>> Branch:
>> https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=capability-search
>>
>> Patch:
> 
> <--- snip --->
> 
> Please bear with me while I'm working on that.


Dear Gerd,

May I ask if there is any update?



I plan to submit the v15 version of my series based on v6.17-rc1.
The modification method is like the previous comment:
https://lore.kernel.org/linux-pci/06012cc6-824d-4a7d-85c9-9995ec915382@163.com/

Best regards,
Hans


