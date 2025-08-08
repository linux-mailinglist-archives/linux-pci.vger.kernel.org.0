Return-Path: <linux-pci+bounces-33617-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70DDFB1E4A8
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 10:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EE681627E8
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 08:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10AB322687C;
	Fri,  8 Aug 2025 08:48:57 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D38264638;
	Fri,  8 Aug 2025 08:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754642936; cv=none; b=aVznl6F/BrfH8d5UDv6RKoXrfKdd3VBkSlA3dfm16bUk513LkUD5hAWdu6BklZtBjkaqRtrmtasGIzRvoqLOjcHpm+t6IcPNCxZGYVhFmx9hp0PRAiO/mKmuBSxUd1nArMMsCMmEGzDjnuT0BCWlIlVnzwBYJ7QRgtAS7T0TmLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754642936; c=relaxed/simple;
	bh=L5PUFgboiQEWI51dOrJeiQBVhnKgWaRlhyd/gfoW3cQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=U0ODBqzeFrlZ+OHCHPQkKfoINkuCsuYgUUDCh9LIpO5Yn1Eg/Ll0i39QtW5fRK1E/mI2viYrVCcQ01XANi6PxfO+/6wKYGSGSunp5BoA3C2YNHGYL3BUR2M4/w/WMIEVnWevezreqoIod/imYdNZiVEN68KtMgXHhva/WKQ1Znk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4byyLJ1mdzz2RW6V;
	Fri,  8 Aug 2025 16:46:16 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id F37151402C6;
	Fri,  8 Aug 2025 16:48:49 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 8 Aug 2025 16:48:48 +0800
Message-ID: <3c754d4e-a2d9-4115-c105-2f199f26abc3@huawei.com>
Date: Fri, 8 Aug 2025 16:48:48 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v7 22/31] irqchip/gic-v5: Add GICv5 LPI/IPI support
Content-Language: en-US
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
CC: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Sascha Bischoff
	<sascha.bischoff@arm.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Timothy Hayes <timothy.hayes@arm.com>, Bjorn Helgaas <bhelgaas@google.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Peter Maydell
	<peter.maydell@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Jiri Slaby
	<jirislaby@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
References: <20250703-gicv5-host-v7-0-12e71f1b3528@kernel.org>
 <20250703-gicv5-host-v7-22-12e71f1b3528@kernel.org>
 <cc611dda-d1e4-4793-9bb2-0eaa47277584@huawei.com>
 <aJSvUWRqLEiARDIW@lpieralisi>
 <c8e3dc2c-617b-2988-10ff-88082370e787@huawei.com>
 <aJWzKqM9bHuKy+1m@lpieralisi>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <aJWzKqM9bHuKy+1m@lpieralisi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf500011.china.huawei.com (7.185.36.131)



On 2025/8/8 16:19, Lorenzo Pieralisi wrote:
> On Fri, Aug 08, 2025 at 09:20:30AM +0800, Jinjie Ruan wrote:
>>
>>

[...]

>>
>> I also did not see any place in the code where these pointers are
>> accessed, nor did I see in section "L2_ISTE, Level 2 interrupt state
>> table entry" that L2_ISTE can be accessed by software. So, are these
>> states of the LPI interrupt maintained by the GIC hardware itself?
> 
> The IST table is where interrupt state and configuration is kept -
> it is managed by GIC IRS HW. SW controls interrupt configuration
> through GIC instructions.
> 
> It is therefore a false positive, I will send the patch below for
> inclusion.

Thank you for your explanation, I now have a general understanding of
how IST works.

> 
> Thanks,
> Lorenzo
> 
>>>
>>> -- >8 --
>>> diff --git a/drivers/irqchip/irq-gic-v5-irs.c b/drivers/irqchip/irq-gic-v5-irs.c
>>> index ad1435a858a4..e8a576f66366 100644
>>> --- a/drivers/irqchip/irq-gic-v5-irs.c
>>> +++ b/drivers/irqchip/irq-gic-v5-irs.c
>>> @@ -5,6 +5,7 @@
>>>  
>>>  #define pr_fmt(fmt)	"GICv5 IRS: " fmt
>>>  
>>> +#include <linux/kmemleak.h>
>>>  #include <linux/log2.h>
>>>  #include <linux/of.h>
>>>  #include <linux/of_address.h>
>>> @@ -117,6 +118,7 @@ static int __init gicv5_irs_init_ist_linear(struct gicv5_irs_chip_data *irs_data
>>>  		kfree(ist);
>>>  		return ret;
>>>  	}
>>> +	kmemleak_ignore(ist);
>>>  
>>>  	return 0;
>>>  }
>>> @@ -232,6 +234,7 @@ int gicv5_irs_iste_alloc(const u32 lpi)
>>>  		kfree(l2ist);
>>>  		return ret;
>>>  	}
>>> +	kmemleak_ignore(l2ist);
>>>  
>>>  	/*
>>>  	 * Make sure we invalidate the cache line pulled before the IRS
>>>
> 

