Return-Path: <linux-pci+bounces-34308-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9137AB2C776
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 16:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FA3717C4D9
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 14:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93DD527EFFB;
	Tue, 19 Aug 2025 14:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="DX9KGgGH"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F9C27E1C5;
	Tue, 19 Aug 2025 14:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755614770; cv=none; b=aZ7A5jsZqJJXAcSpICE3aJMnVGf4OwvyePnIUklywKdpr0LjamNd5UXeljiNLtAim9L3hm/ZOdYnLufu+EqWjQ6ODGvJRHp1LN2hYfTaFmOHqMY7+LmW4LKQEfMt7hVZqm8UbZ05+8a+OXIbv+5wG4t4dQIo+dHcFoY1NGpbGEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755614770; c=relaxed/simple;
	bh=AYNH8QyYoUHUfDvW5vJJ5GpLPY54PmF/80c4Us8WTzc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jLF77W9PGlMKcqfYRhSzRi7Lv3rn88hfPuE0RFNUD0PUKgOPUd8vebTWAxgePKQ410iJ8xU2mlyGe4qwUZqDyDIp+qym+LGEHt/w59OxI4yjSKVrfnVzZ4pZYqT8ieCLTwdDwyWnBxap81hDsK1kdbAsgt0bu/7WTNuDDsxI+2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=DX9KGgGH; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=az420M8Nq7k4V2eTOcbw+s6XgRTSOOlRZ6rQb05EIRM=;
	b=DX9KGgGHJeqmoi+e0WEFuwBVUTILmtziMh7PPXR6tSWxeFWET0o0OLuNfAuu6U
	4ZmtKgMqex9lDJopAuM4zfrRBiRdVAq5LMTeiolh+ScQ/gfyTaX1jbFu6C/psayZ
	jGrXv7xCyM6pCE5X1DdbPtaWtdp/15nEXr34A2WazPJkY=
Received: from [IPV6:240e:b8f:919b:3100:3980:6173:5059:2d2a] (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgBHjZ8CjqRoTy78Aw--.18055S2;
	Tue, 19 Aug 2025 22:45:23 +0800 (CST)
Message-ID: <a71bb77d-6725-4c79-b817-7c8e4b0c7612@163.com>
Date: Tue, 19 Aug 2025 22:45:23 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: endpoint: Use common PCI host bridge APIs for
 finding the capabilities
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com,
 jingoohan1@gmail.com, robh@kernel.org, ilpo.jarvinen@linux.intel.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250616152515.966480-1-18255117159@163.com>
 <767tx2yce7ohfowz5vtec3a5fkcdo7qjmrfpklmy5g6y5yqwao@fxacvqh2zrhb>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <767tx2yce7ohfowz5vtec3a5fkcdo7qjmrfpklmy5g6y5yqwao@fxacvqh2zrhb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:PSgvCgBHjZ8CjqRoTy78Aw--.18055S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXr1kKF15CrWUKr4rKr45Wrg_yoW5Ar45pa
	yrXFy5Cr4UtFyaq3WavFs8Zr90vFn8AF1xZ3sxG3WavrnrZr9aga47KFWYk34xKF4jgF18
	Kr4jvFZ3Wr13KFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U58nOUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWwauo2ikh-6zBgAAsQ



On 2025/8/19 22:14, Manivannan Sadhasivam wrote:
> On Mon, Jun 16, 2025 at 11:25:15PM GMT, Hans Zhang wrote:
>> Use the PCI core is now exposing generic macros for the host bridges to
>> search for the PCIe capabilities, make use of them in the DWC EP driver.
>>
>> Signed-off-by: Hans Zhang <18255117159@163.com>
> 
> Please send it together with the dependent series.
> 

Dear Mani,

I'll send it out right away later.

Best regards,
Hans


> 
>> ---
>> - Submissions based on the following patches:
>> https://patchwork.kernel.org/project/linux-pci/patch/20250607161405.808585-1-18255117159@163.com/
>>
>> Recently, I checked the code and found that there are still some areas that can be further optimized.
>> The above series of patches has been around for a long time, so I'm sending this one out for review
>> as a separate patch.
>> ---
>>   .../pci/controller/dwc/pcie-designware-ep.c   | 39 +++++++------------
>>   1 file changed, 14 insertions(+), 25 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
>> index 0ae54a94809b..9f1880cc1925 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
>> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
>> @@ -69,37 +69,26 @@ void dw_pcie_ep_reset_bar(struct dw_pcie *pci, enum pci_barno bar)
>>   }
>>   EXPORT_SYMBOL_GPL(dw_pcie_ep_reset_bar);
>>   
>> -static u8 __dw_pcie_ep_find_next_cap(struct dw_pcie_ep *ep, u8 func_no,
>> -				     u8 cap_ptr, u8 cap)
>> +static int dw_pcie_ep_read_cfg(void *priv, u8 func_no, int where, int size, u32 *val)
>>   {
>> -	u8 cap_id, next_cap_ptr;
>> -	u16 reg;
>> -
>> -	if (!cap_ptr)
>> -		return 0;
>> -
>> -	reg = dw_pcie_ep_readw_dbi(ep, func_no, cap_ptr);
>> -	cap_id = (reg & 0x00ff);
>> -
>> -	if (cap_id > PCI_CAP_ID_MAX)
>> -		return 0;
>> -
>> -	if (cap_id == cap)
>> -		return cap_ptr;
>> +	struct dw_pcie_ep *ep = priv;
>> +
>> +	if (size == 4)
>> +		*val = dw_pcie_ep_readl_dbi(ep, func_no, where);
>> +	else if (size == 2)
>> +		*val = dw_pcie_ep_readw_dbi(ep, func_no, where);
>> +	else if (size == 1)
>> +		*val = dw_pcie_ep_readb_dbi(ep, func_no, where);
>> +	else
>> +		return PCIBIOS_BAD_REGISTER_NUMBER;
>>   
>> -	next_cap_ptr = (reg & 0xff00) >> 8;
>> -	return __dw_pcie_ep_find_next_cap(ep, func_no, next_cap_ptr, cap);
>> +	return PCIBIOS_SUCCESSFUL;
>>   }
>>   
>>   static u8 dw_pcie_ep_find_capability(struct dw_pcie_ep *ep, u8 func_no, u8 cap)
>>   {
>> -	u8 next_cap_ptr;
>> -	u16 reg;
>> -
>> -	reg = dw_pcie_ep_readw_dbi(ep, func_no, PCI_CAPABILITY_LIST);
>> -	next_cap_ptr = (reg & 0x00ff);
>> -
>> -	return __dw_pcie_ep_find_next_cap(ep, func_no, next_cap_ptr, cap);
>> +	return PCI_FIND_NEXT_CAP_TTL(dw_pcie_ep_read_cfg, PCI_CAPABILITY_LIST,
>> +				     cap, ep, func_no);
>>   }
>>   
>>   /**
>>
>> base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
>> -- 
>> 2.25.1
>>
> 


