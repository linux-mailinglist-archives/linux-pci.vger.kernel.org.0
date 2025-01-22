Return-Path: <linux-pci+bounces-20239-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E50A19217
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jan 2025 14:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59A247A213A
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jan 2025 13:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90BA6212B1C;
	Wed, 22 Jan 2025 13:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="dDYqx38+"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B1E212FB1;
	Wed, 22 Jan 2025 13:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737551390; cv=none; b=X9e7HWYfdglDaZiRsAyWyj4XOlhnwXaoiyMJrz0cI/1xCSBPIqzgqlKdM1FfAQ2xPjd2lu5uWZ9I6xiCSNzkr/UB8UqHGaanLaIF2nQiwCjsSSXiMs6L6yzv9HjiCoEUKXNHez+spq/vByi7xKM0r3UVmtDDk/KQU2Fm4IFwVGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737551390; c=relaxed/simple;
	bh=CVnyb+Tj+iKa5qkMXL/MV20kBMd8lMzO7AbpaJTL50A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k1wBGu6jfZBoM1rabfdMHzlVfKSJgTrGc+C/oX5WpK20An6S4EejH5DgC7AzCmFlX2r+F4Tn/atdLJp4ToCulFsykm23M4fBolV+HE3nt6FuVUjKG5O2jADfrqNQmRIS/rgBIBLiibPp8u9E1IR+CyAoHHuineaxzXT8N8yQAjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=dDYqx38+; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=S+B0TZJS1JnGA9K5ssDhevZhBKlOatGVyBdkqkqlf8o=;
	b=dDYqx38+YOqqrOR+Wa2zq6vdKcjeQY1vdVN30gsvH+JRX60PCxwy3pPaUwkFUa
	Ub63WS1wta5UIueqUfVEKh8JOwVRHRG01i2Z6bIEmdeicTnXqA7S/urcaJOKmRfW
	WpXj05PvZlc5GUNMe0rFxA7QlwpwnYVux69LHg0+SH85U=
Received: from [192.168.31.193] (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgA3vgx47ZBnq2rQFA--.28665S2;
	Wed, 22 Jan 2025 21:07:05 +0800 (CST)
Message-ID: <c366fa2f-753c-4123-ac6a-cc28b39f3217@163.com>
Date: Wed, 22 Jan 2025 21:07:04 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] PCI: Fix the wrong reading of register fields
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: ilpo.jarvinen@linux.intel.com, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, helgaas@kernel.org,
 lukas@wunner.de, ahuang12@lenovo.com, sunjw10@lenovo.com,
 jiwei.sun.bj@qq.com, sunjw10@outlook.com
References: <20250122080610.902706-1-sjiwei@163.com>
 <20250122080610.902706-2-sjiwei@163.com>
 <alpine.DEB.2.21.2501221247290.27203@angie.orcam.me.uk>
Content-Language: en-US
From: Jiwei Sun <sjiwei@163.com>
In-Reply-To: <alpine.DEB.2.21.2501221247290.27203@angie.orcam.me.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:PSgvCgA3vgx47ZBnq2rQFA--.28665S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WF1rCr1kJF4DJr4rKrW8Crg_yoW8CF1xp3
	W3Wa4jyr48Jw4UGrn5W3Z7Xa4IvFn3GF4v9ryUWr90qFy7G34DAF10ywnIgF17Ar4vkry8
	X3sFvw43Gw12y3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U5b1nUUUUU=
X-CM-SenderInfo: 5vml4vrl6rljoofrz/1tbiDwbcmWeQ6lUtpAAAsN



On 1/22/25 20:53, Maciej W. Rozycki wrote:
>> The macro PCIE_LNKCTL2_TLS2SPEED() and PCIE_LNKCAP_SLS2SPEED() just use
>> the link speed field of the registers. However, there are many other
>> different function fields in the Link Control 2 Register or the Link
>> Capabilities Register. If the register value is directly used by the two
>> macros, it may cause getting an error link speed value (PCI_SPEED_UNKNOWN).
> 
>  The change proposed seems right to me, however...
> 
>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>> index 2e40fc63ba31..c571f5943f3d 100644
>> --- a/drivers/pci/pci.h
>> +++ b/drivers/pci/pci.h
>> @@ -337,12 +337,14 @@ void pci_bus_put(struct pci_bus *bus);
>>  
>>  #define PCIE_LNKCAP_SLS2SPEED(lnkcap)					\
>>  ({									\
>> -	((lnkcap) == PCI_EXP_LNKCAP_SLS_64_0GB ? PCIE_SPEED_64_0GT :	\
>> -	 (lnkcap) == PCI_EXP_LNKCAP_SLS_32_0GB ? PCIE_SPEED_32_0GT :	\
>> -	 (lnkcap) == PCI_EXP_LNKCAP_SLS_16_0GB ? PCIE_SPEED_16_0GT :	\
>> -	 (lnkcap) == PCI_EXP_LNKCAP_SLS_8_0GB ? PCIE_SPEED_8_0GT :	\
>> -	 (lnkcap) == PCI_EXP_LNKCAP_SLS_5_0GB ? PCIE_SPEED_5_0GT :	\
>> -	 (lnkcap) == PCI_EXP_LNKCAP_SLS_2_5GB ? PCIE_SPEED_2_5GT :	\
>> +	u32 __lnkcap = (lnkcap) & PCI_EXP_LNKCAP_SLS;			\
>> +									\
>> +	(__lnkcap == PCI_EXP_LNKCAP_SLS_64_0GB ? PCIE_SPEED_64_0GT :	\
>> +	 __lnkcap == PCI_EXP_LNKCAP_SLS_32_0GB ? PCIE_SPEED_32_0GT :	\
>> +	 __lnkcap == PCI_EXP_LNKCAP_SLS_16_0GB ? PCIE_SPEED_16_0GT :	\
>> +	 __lnkcap == PCI_EXP_LNKCAP_SLS_8_0GB ? PCIE_SPEED_8_0GT :	\
>> +	 __lnkcap == PCI_EXP_LNKCAP_SLS_5_0GB ? PCIE_SPEED_5_0GT :	\
>> +	 __lnkcap == PCI_EXP_LNKCAP_SLS_2_5GB ? PCIE_SPEED_2_5GT :	\
> 
>  ... wouldn't it make sense to give the intermediate variable a meaningful 
> name reflecting data it carries, e.g. `lnkcap_sls'?

This is a good idea. I will modify the patch in the v4 patch.

Thanks,
Regards,
Jiwei


