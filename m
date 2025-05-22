Return-Path: <linux-pci+bounces-28283-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D4DAC1150
	for <lists+linux-pci@lfdr.de>; Thu, 22 May 2025 18:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80E5A3A3C9F
	for <lists+linux-pci@lfdr.de>; Thu, 22 May 2025 16:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF492853FF;
	Thu, 22 May 2025 16:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jueRHUc2"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27CF12512EC;
	Thu, 22 May 2025 16:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747932087; cv=none; b=pNu/zrpo1/a1fnZC1QjH8xMc3CaZXHY09LstLq4B2aZ4eE5whaCJkubal4Rft7uRlC4lgpVcaLO6vJyQcd1bcmePXnv8iH6pYG4pmOftdvJALl92mdLIQQKW7G6fXzDNdGTvrvqnWc2fQgAybOLZTBFzONJqNHxWmR74pgmjJKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747932087; c=relaxed/simple;
	bh=crPL1jEiYz9vumhMbCM8KylOWiGOqdsKjRUv6x/Lj0o=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=IktMXArPN9UkYGwUoSgfVZCGf0Wwuk5ybZFZ9KWx7s6YWJb4C3zJg9lw5RTMiE5xGfRsKY5EeSbofsq9q86+ny1bFrS58Jl2/PuWTynzzpx1G9zCyAGwHYIRQlVr9VlD99x5XNUvKv/babNZsIlIRr+eaQMc6rmegpWyTDcxtso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=jueRHUc2; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:To:
	Content-Type; bh=cmCLcWS0KLMM912YRmQXXhWg3w7uEQGxZs6hXxfJW4k=;
	b=jueRHUc2fb7ak/hlRgDgFEadBFdSL/cVjmLFAHOhJ9fT5oSP7Eulp5I+N+0nFO
	EcMRhvXxKXM85lIDX7EL0iGf+JqCtHWcDFP6wtgmHpa4Y6nDcxwlXfwtSD/72cNe
	OwiJGJWikEDMwMiAEWcaImFZ1SD5lJgnuafa76QQwJiVc=
Received: from [192.168.71.93] (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wCnDlebUy9onccJDQ--.9263S2;
	Fri, 23 May 2025 00:41:00 +0800 (CST)
Message-ID: <8ae7e59e-a47f-4005-ae30-90d4be78c536@163.com>
Date: Fri, 23 May 2025 00:40:59 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i2c: tegra: Add missing kernel-doc for dma_dev member
From: Hans Zhang <18255117159@163.com>
To: =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: bhelgaas@google.com, manivannan.sadhasivam@linaro.org,
 ajayagarwal@google.com, ilpo.jarvinen@linux.intel.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250522163251.399223-1-18255117159@163.com>
 <20250522163535.GA3558378@rocinante>
 <8472c23c-167f-4e77-bc04-a9498fd41fa8@163.com>
Content-Language: en-US
In-Reply-To: <8472c23c-167f-4e77-bc04-a9498fd41fa8@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCnDlebUy9onccJDQ--.9263S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU05rcDUUUU
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDx9Vo2gvSyDRZgAAs9



On 2025/5/23 00:39, Hans Zhang wrote:
> 
> 
> On 2025/5/23 00:35, Krzysztof Wilczyński wrote:
>> Hello,
>>
>> [...]
>>>   drivers/i2c/busses/i2c-tegra.c | 1 +
>>
>> I think you got a wrong set of maintainers here. :)
>>
>> Thank you!
>>
>>     Krzysztof
> 
> Dear Krzysztof,
> 
> Yes, I just found out. I'm very sorry.
> 

The notes made locally have been copied and sent to the previous email 
address. It has been resent to the corresponding Maintainer. :)

> Best regards,
> Hans


