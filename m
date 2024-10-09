Return-Path: <linux-pci+bounces-14026-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5840C99623C
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 10:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 800501C20DB9
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 08:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3964638DD3;
	Wed,  9 Oct 2024 08:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qGGTSzQK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DCA16EB4C
	for <linux-pci@vger.kernel.org>; Wed,  9 Oct 2024 08:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728461821; cv=none; b=cI6DM9WzK2pEaxWVARlgq5pxUznWz2TObhFZdAdZ3+vq5NDtj6bQpA7etuTkNnJwlUUTBjrCHLfrUupzyRyZr6QR7jTLnmmCVu9T7Zk6AYC8x8sG8KjWXa4Qo1iVMl2A5QDycZDNxPqyVyDLkWt7xNOgZwwpaJl1LUoI7DrmNM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728461821; c=relaxed/simple;
	bh=B+SM6erZaNO4b0mIjZjP2ripiTOGmpQnP56439FrrtU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GwxfrfUIFjHhOg1u5pT20OZbGYN8yhy/2Y2JhNGJcLgCa+jLRRj0YzK6JhT9bxNBIv07/sW8xVm06Dhm0k0x6g/9O4L/oam+aTINn+7kuWzUAo4eJlq3nQSBRKC0nXIMYHg8Yj9uwdjZBNLeUuIVnWVo/evpMo14eAOb6QR6gWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qGGTSzQK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F2A1C4CEC5;
	Wed,  9 Oct 2024 08:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728461820;
	bh=B+SM6erZaNO4b0mIjZjP2ripiTOGmpQnP56439FrrtU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qGGTSzQKbjdvvQRPCido3DFwGRhbSp4ecf1GA7J0SEHAGRcMj73eK0/TWSarf5R5h
	 LAh3y2ZkHy/EP0HeqIu0URrMmHyHcZyhP//5niHn3eGOJ8/UwLcopWMhrkX+mmr0Yr
	 ZpEBi5mx5Ayx2m6tcSYOAhc9morzlvPkz2/kom0t50sTmqdagJVOn56g8+zfK3h0sc
	 VIvWS7EzqsQjQ1gl67UHYi5ybXYJM6JPHAmt8I0MxXdz+FJ9cjWnKIVJd9h4OC4KIz
	 LoQa+ZVLh04JkB1uIGvaEytDRQfKT2jhhvRJW2/ketniWc9ifh1dXy0nRcckP88kXV
	 nVxYiudn+MgGg==
Message-ID: <3c017172-c8ba-450d-902a-e937a76d11ad@kernel.org>
Date: Wed, 9 Oct 2024 17:16:57 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/5] PCI: endpoint: Add NVMe endpoint function driver
To: Rick Wertenbroek <rick.wertenbroek@gmail.com>
Cc: Niklas Cassel <cassel@kernel.org>, linux-nvme@lists.infradead.org,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, linux-pci@vger.kernel.org
References: <20241007044351.157912-1-dlemoal@kernel.org>
 <20241007044351.157912-5-dlemoal@kernel.org> <ZwO0H0WCnORq9EzQ@ryzen>
 <8b1c846d-6c86-43ea-bc73-aef619094267@kernel.org>
 <CAAEEuhqpthLsNX70WWCn6+udPaNhks41d=oCZRKpPSHKnRc-AQ@mail.gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <CAAEEuhqpthLsNX70WWCn6+udPaNhks41d=oCZRKpPSHKnRc-AQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/9/24 16:28, Rick Wertenbroek wrote:
> On Mon, Oct 7, 2024 at 12:26 PM Damien Le Moal <dlemoal@kernel.org> wrote:
>>
>> On 10/7/24 19:12, Niklas Cassel wrote:
>>> On Mon, Oct 07, 2024 at 01:43:50PM +0900, Damien Le Moal wrote:
>>>> From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>>>
>>> (snip)
>>>
>>>> Early versions of this driver code were based on an RFC submission by
>>>> Alan Mikhak <alan.mikhak@sifive.com> (https://lwn.net/Articles/804369/).
>>>> The code however has since been completely rewritten.
>>>
>>> Here you state that the code has been completely rewritten...
>>>
>>>
>>>>
>>>> Co-developed-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
>>>> Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
>>>> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>>>> ---
>>>>  MAINTAINERS                                   |    7 +
>>>>  drivers/pci/endpoint/functions/Kconfig        |    9 +
>>>>  drivers/pci/endpoint/functions/Makefile       |    1 +
>>>>  drivers/pci/endpoint/functions/pci-epf-nvme.c | 2489 +++++++++++++++++
>>>>  4 files changed, 2506 insertions(+)
>>>>  create mode 100644 drivers/pci/endpoint/functions/pci-epf-nvme.c
>>>
>>> (snip)
>>>
>>>> --- /dev/null
>>>> +++ b/drivers/pci/endpoint/functions/pci-epf-nvme.c
>>>> @@ -0,0 +1,2489 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +/*
>>>> + * NVMe function driver for PCI Endpoint Framework
>>>> + *
>>>> + * Copyright (C) 2019 SiFive
>>>
>>> ...yet here you claim Copyright (C) SiFive.
>>>
>>> *If* the code has been completely rewritten, then you probably should
>>> put yourself and/or your current employeer as the copyright holder.
>>
>> Oops. One thing I forgot to rewrite :)
>> Will change the copyright in v2.
> 
> Hello Damien.
> Thank you for acknowledging my contributions in the commit message. I
> would appreciate it if you could add both our names in the copyright
> for the v2, I don't mind not being in the MODULE_AUTHOR() but I would
> appreciate a mention in the header comment of the file, thank you.

Sure, no problem. Would a copyright with your name only (no affiliation) be OK ?

> 
> Best regards,
> Rick
> 
>>
>>>
>>>
>>> Kind regards,
>>> Niklas
>>
>>
>> --
>> Damien Le Moal
>> Western Digital Research


-- 
Damien Le Moal
Western Digital Research

