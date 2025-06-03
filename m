Return-Path: <linux-pci+bounces-28875-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BEC9ACCAD4
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 17:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13D703A807F
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 15:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16AEC23C50F;
	Tue,  3 Jun 2025 15:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Er8xVMZd"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720001422DD;
	Tue,  3 Jun 2025 15:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748966344; cv=none; b=oNJrNg0Hk4xfVXetntNnqJq1I1NMB+jsLVa2BibNDEiVavTSdlnaLmLlBZjINhsmSWYBy29cD8u2+ISuyQqZ7QsPpVL74WaJSCHAAW2/3eZXR8a3m7MkWLPiOXxoVceuX72w0e8uoxwcZ8EnPUqY6dlNgRAVff4sw3yJQKk+hEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748966344; c=relaxed/simple;
	bh=fBtqBlAKBen+7mOYoc8yRAb98plBAjHXaGZ5DkPt6nY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AEYGfPk1CpTDjdN35pjNwNjDwydbfIe6iDxoPwL6YyCDaEENlyypBsWGXeZNBIj9Ulep/s2UQsYZmTEgIHSdxBpUG+6qb0Xd0VKJ9SN/oMpXcmuLhwyPtIwyGBcos6nwjWTLUVeGXBY7Qx6WF2g5VFYnVuK//H+SmtUdZuTcGKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Er8xVMZd; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=rSnUnTa8ZcPtiT4ijTUZDfXbklv70tLxi4gi6Skkm3s=;
	b=Er8xVMZdUJgHZhkOPfjA3d2FkrhONm82mr+ehfuZqEo+853KmNxLYWB1TmrHET
	LiqXU0NZ3RvcOrOk7+5Mu9xweYUdvmI4ZSvbpxEjDPz+H8z1toH/DkUX0Nuul7xB
	8tAR0dgW2IUL5VV9zVLxjbmp9nOntuJOQjOYEAL3OoMYg=
Received: from [192.168.71.94] (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDnsoChGz9oNtfdFw--.23979S2;
	Tue, 03 Jun 2025 23:58:26 +0800 (CST)
Message-ID: <dc1ac533-1c76-4e4e-93d9-5b25165fea63@163.com>
Date: Tue, 3 Jun 2025 23:58:25 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 4/6] PCI: dwc: Use common PCI host bridge APIs for
 finding the capabilities
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: lpieralisi@kernel.org, bhelgaas@google.com,
 manivannan.sadhasivam@linaro.org, kw@linux.com, cassel@kernel.org,
 robh@kernel.org, jingoohan1@gmail.com, linux-pci@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <20250514161258.93844-1-18255117159@163.com>
 <20250514161258.93844-5-18255117159@163.com>
 <4f23df8e-bebe-149c-a638-be7208c8c71a@linux.intel.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <4f23df8e-bebe-149c-a638-be7208c8c71a@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnsoChGz9oNtfdFw--.23979S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXr1kKF1fGrWUWF13CF4fAFb_yoWrKw43p3
	yrJF1YyFZ8Jr1aqa1qvFn0v3WavF9xAF1xGay7G3ZIvF9FyryUK34jkrWfKr97ArsrKF1r
	Wr48JFn3Crn3tFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UsXocUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOgNho2g-EXT23gABsg



On 2025/6/3 17:42, Ilpo Järvinen wrote:
> On Thu, 15 May 2025, Hans Zhang wrote:
> 
>> Use the PCI core is now exposing generic macros for the host bridges to
>> search for the PCIe capabilities, make use of them in the DWC driver.
>>
>> Signed-off-by: Hans Zhang <18255117159@163.com>
>> ---
>> Changes since v11:
>> - Resolve compilation errors. s/dw_pcie_read_dbi/dw_pcie_read*_dbi
>>
>> Changes since v10:
>> - None
>>
>> Changes since v9:
>> - Resolved [v9 4/6] compilation error.
>>    The latest 6.15 rc1 merge __dw_pcie_find_vsec_capability, which uses
>>    dw_pcie_find_next_ext_capability.
>>
>> Changes since v8:
>> - None
>>
>> Changes since v7:
>> - Resolve compilation errors.
>>
>> Changes since v6:
>> https://lore.kernel.org/linux-pci/20250323164852.430546-3-18255117159@163.com/
>>
>> - The patch commit message were modified.
>>
>> Changes since v5:
>> https://lore.kernel.org/linux-pci/20250321163803.391056-3-18255117159@163.com/
>>
>> - Kconfig add "select PCI_HOST_HELPERS"
>> ---
>>   drivers/pci/controller/dwc/pcie-designware.c | 81 ++++----------------
>>   1 file changed, 14 insertions(+), 67 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
>> index 97d76d3dc066..7939411a24eb 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware.c
>> +++ b/drivers/pci/controller/dwc/pcie-designware.c
>> @@ -205,83 +205,30 @@ void dw_pcie_version_detect(struct dw_pcie *pci)
>>   		pci->type = ver;
>>   }
>>   
>> -/*
>> - * These interfaces resemble the pci_find_*capability() interfaces, but these
>> - * are for configuring host controllers, which are bridges *to* PCI devices but
>> - * are not PCI devices themselves.
>> - */
>> -static u8 __dw_pcie_find_next_cap(struct dw_pcie *pci, u8 cap_ptr,
>> -				  u8 cap)
>> +static int dw_pcie_read_cfg(void *priv, int where, int size, u32 *val)
>>   {
>> -	u8 cap_id, next_cap_ptr;
>> -	u16 reg;
>> -
>> -	if (!cap_ptr)
>> -		return 0;
>> +	struct dw_pcie *pci = priv;
>>   
>> -	reg = dw_pcie_readw_dbi(pci, cap_ptr);
>> -	cap_id = (reg & 0x00ff);
>> -
>> -	if (cap_id > PCI_CAP_ID_MAX)
>> -		return 0;
>> -
>> -	if (cap_id == cap)
>> -		return cap_ptr;
>> +	if (size == 4)
>> +		*val = dw_pcie_readl_dbi(pci, where);
>> +	else if (size == 2)
>> +		*val = dw_pcie_readw_dbi(pci, where);
>> +	else if (size == 1)
>> +		*val = dw_pcie_readb_dbi(pci, where);
> 
> Maybe here as well return error if the given size is invalid.

Dear Ilpo.

Will add return PCIBIOS_BAD_REGISTER_NUMBER.

>>   
>> -	next_cap_ptr = (reg & 0xff00) >> 8;
>> -	return __dw_pcie_find_next_cap(pci, next_cap_ptr, cap);
>> +	return PCIBIOS_SUCCESSFUL;
>>   }
>>   
>>   u8 dw_pcie_find_capability(struct dw_pcie *pci, u8 cap)
>>   {
>> -	u8 next_cap_ptr;
>> -	u16 reg;
>> -
>> -	reg = dw_pcie_readw_dbi(pci, PCI_CAPABILITY_LIST);
>> -	next_cap_ptr = (reg & 0x00ff);
>> -
>> -	return __dw_pcie_find_next_cap(pci, next_cap_ptr, cap);
>> +	return PCI_FIND_NEXT_CAP_TTL(dw_pcie_read_cfg, PCI_CAPABILITY_LIST, cap,
>> +				     pci);
>>   }
>>   EXPORT_SYMBOL_GPL(dw_pcie_find_capability);
>>   
>> -static u16 dw_pcie_find_next_ext_capability(struct dw_pcie *pci, u16 start,
>> -					    u8 cap)
>> -{
>> -	u32 header;
>> -	int ttl;
>> -	int pos = PCI_CFG_SPACE_SIZE;
>> -
>> -	/* minimum 8 bytes per capability */
>> -	ttl = (PCI_CFG_SPACE_EXP_SIZE - PCI_CFG_SPACE_SIZE) / 8;
>> -
>> -	if (start)
>> -		pos = start;
>> -
>> -	header = dw_pcie_readl_dbi(pci, pos);
>> -	/*
>> -	 * If we have no capabilities, this is indicated by cap ID,
>> -	 * cap version and next pointer all being 0.
>> -	 */
>> -	if (header == 0)
>> -		return 0;
>> -
>> -	while (ttl-- > 0) {
>> -		if (PCI_EXT_CAP_ID(header) == cap && pos != start)
>> -			return pos;
>> -
>> -		pos = PCI_EXT_CAP_NEXT(header);
>> -		if (pos < PCI_CFG_SPACE_SIZE)
>> -			break;
>> -
>> -		header = dw_pcie_readl_dbi(pci, pos);
>> -	}
>> -
>> -	return 0;
>> -}
>> -
>>   u16 dw_pcie_find_ext_capability(struct dw_pcie *pci, u8 cap)
>>   {
>> -	return dw_pcie_find_next_ext_capability(pci, 0, cap);
>> +	return PCI_FIND_NEXT_EXT_CAPABILITY(dw_pcie_read_cfg, 0, cap, pci);
>>   }
>>   EXPORT_SYMBOL_GPL(dw_pcie_find_ext_capability);
>>   
>> @@ -294,8 +241,8 @@ static u16 __dw_pcie_find_vsec_capability(struct dw_pcie *pci, u16 vendor_id,
>>   	if (vendor_id != dw_pcie_readw_dbi(pci, PCI_VENDOR_ID))
>>   		return 0;
>>   
>> -	while ((vsec = dw_pcie_find_next_ext_capability(pci, vsec,
>> -						       PCI_EXT_CAP_ID_VNDR))) {
>> +	while ((vsec = PCI_FIND_NEXT_EXT_CAPABILITY(
>> +			dw_pcie_read_cfg, vsec, PCI_EXT_CAP_ID_VNDR, pci))) {
> 
> Start the arguments from the first line and align the continuations to (.

Will change.

Best regards,
Hans

> 
>>   		header = dw_pcie_readl_dbi(pci, vsec + PCI_VNDR_HEADER);
>>   		if (PCI_VNDR_HEADER_ID(header) == vsec_id)
>>   			return vsec;
>>
> 


