Return-Path: <linux-pci+bounces-33935-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22670B2432E
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 09:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D39B0721B70
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 07:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13CDD2E2DC0;
	Wed, 13 Aug 2025 07:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="fZhjrpq5"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520212DEA60;
	Wed, 13 Aug 2025 07:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755071468; cv=none; b=ioZeCdWwE5XQuSo9FtPMU5JCxkFumnvq5FrUVdHBIIxHmyDJU4X5YKSeGexdrWgWmr2cklq7zVnj01B4Bnw1reZP//d0jSztjXXDTAVJpFAb5S9y3/sWc2W7NvMZnG/Cfmk9qjUP3ktE+wpK7KdSj/9niZF4BKU96gAG0BgLyLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755071468; c=relaxed/simple;
	bh=r4pEFPASKK8up77RtFL+P52xmtDqK18x1y6KA4edrLo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AnlWT8mGkk3piUdkCNdjqxPicTKV1zowxrLSiVFzusW96vO4Am5B2BKrHCJ6FNNIyzKkzkvS4wl7jPqgQpkcE/LhlaEQLBXWZB9zOQ7k6rXtSeP+yh/5K/LJO+8sblyMHQ5UWX/5zFhWScmSs9p+KVMlVMTfZ4mkzxZZeZ1aou8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=fZhjrpq5; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=Mz/nBgsZ7duNmoAntgvSoINKl5IHWwCVTu1EHDpSdzQ=;
	b=fZhjrpq5DU+sSpql1h/6xp16nQxxOvnhOGR2x59nypWWrCnMONGJcQun0j/8NH
	01c5O2ASgxLZ/xF85LpQ2twoAqWNYvnUcabKitLATAyjJLMMCreH5zXdaJH7UPww
	an/6YufaPEcJ8eg9ZJVp3N1lw3woqYxwWIj209m4pKReQ=
Received: from [192.168.172.52] (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgD3n8fKQ5xoY8CzAw--.5193S2;
	Wed, 13 Aug 2025 15:50:37 +0800 (CST)
Message-ID: <96c686b7-2a42-4a1b-8cb6-07fd2ca1f5c1@163.com>
Date: Wed, 13 Aug 2025 15:50:33 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: Fix endianness issues in pci_bus_read_config()
To: Niklas Schnelle <schnelle@linux.ibm.com>,
 Gerd Bayer <gbayer@linux.ibm.com>, Manivannan Sadhasivam <mani@kernel.org>,
 Hans Zhang <hans.zhang@cixtech.com>
Cc: Arnd Bergmann <arnd@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
 bhelgaas@google.com, Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 jingoohan1@gmail.com, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-next <linux-next@vger.kernel.org>,
 linux-pci@vger.kernel.org, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Rob Herring <robh@kernel.org>, geert@linux-m68k.org
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
 <9d0cce06-25fa-4ca6-8cd1-388e932d1ffc@163.com>
 <8d5b5e0450ac4a4f8ca0a9d7b9399a7b0b5eee00.camel@linux.ibm.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <8d5b5e0450ac4a4f8ca0a9d7b9399a7b0b5eee00.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:PigvCgD3n8fKQ5xoY8CzAw--.5193S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zr4xZr45ur4kAr13tw18Xwb_yoW8ur17pF
	WSyF4YyF4kJr4xtFsFqr1UXF12y3yktry3Xr15Gr1UJF1qvr18Jrn7AFWY9r9rury7uF1j
	yrWava42qr1jvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j0YLkUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOh2oo2icPqCcEgAAsI



On 2025/8/13 15:47, Niklas Schnelle wrote:
> On Tue, 2025-08-12 at 22:44 +0800, Hans Zhang wrote:
>>
>> On 2025/8/4 18:09, Gerd Bayer wrote:
>>> On Mon, 2025-08-04 at 11:06 +0800, Hans Zhang wrote:
>>>>
>>>> On 2025/8/1 19:30, Gerd Bayer wrote:
>>>>> On Fri, 2025-08-01 at 16:24 +0530, Manivannan Sadhasivam wrote:
>>>>>
>>>>> <--- snip --->
>>>>>
>>>>>>>>
>>>>
>>>> Dear all,
>>>>
>>>> According to the issue mentioned by Lukas and Mani. Gerd has already
>>>> been tested on the s390. I have tested it on the RK3588 and it works
>>>> fine. RK3588 uses Synopsys' PCIe IP, that is, the DWC driver. Our
>>>> company's is based on Cadence's PCIe 4.0 IP, and the test function is
>>>> normal. All the platforms I tested were based on ARM.
>>>>
>>>> The following is the patch based on the capability-search branch. May I
>>>> ask everyone, do you have any more questions?
>>>>
>>>> Gerd, if there's no problem, I'll add your Tested-by label.
>>>
>>> Before you add that I'd like to re-test with the "final" patch.
>>>
>>>> Branch:
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=capability-search
>>>>
>>>> Patch:
>>>
>>> <--- snip --->
>>>
>>> Please bear with me while I'm working on that.
>>
>>
>> Dear Gerd,
>>
>> May I ask if there is any update?
>>
>>
>>
>> I plan to submit the v15 version of my series based on v6.17-rc1.
>> The modification method is like the previous comment:
>> https://lore.kernel.org/linux-pci/06012cc6-824d-4a7d-85c9-9995ec915382@163.com/
>>
>> Best regards,
>> Hans
>>
> 
> Hi Hans,
> 
> Gerd is currently out so I just gave the patch you provided against
> capability-search-v14 a try on s390. Didn't see any issues with the
> previously broken device probing. As I understand it Bjorn asked you to
> send a complete v15 and then for people to test that. I like that
> approach and would prefer to provide a Tested-by for v15 rather than
> via a patch on top. Gerd should be back next week too. Does that work
> for you?
> 

Hi Niklas,

Ok, no problem. I'm starting to prepare the patch for V15 now.

Best regards,
Hans


