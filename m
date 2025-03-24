Return-Path: <linux-pci+bounces-24534-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A090A6DCFE
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 15:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 173D17A69F6
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 14:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4765A25FA1D;
	Mon, 24 Mar 2025 14:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="iWkVaDfS"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F0A25F7BE;
	Mon, 24 Mar 2025 14:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742826604; cv=none; b=oxC1HN7BlfIZJAl49RuojL9dIZXhV0BtvsccquvAGzqc3TjQQLdSs2jv6lcKBreKgc7+iMmRmwnQjPbRGldgiBs+3BdwQoLWA7FXpXIglo1QbejKpYG7Qoc3ktG8rw2QBW83rfLsFyqrUwkZqYCv2sRwj5FkLHfWgW0k69apHDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742826604; c=relaxed/simple;
	bh=r6g9GYW5+DPpmp8kpNgFim7YFEsYj+4GXPG+wNKw3Pc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HrFM2IO95HWl7hfTZ2EAOI8jgLio5KzQ4b7e/eDNKFWFpxJ1SFKm6CVC4+wSHHN4/AkIYZ7KrPxdWzLcZFz5fABzdqqcEh12SjB7yWtnrcQOmEG5avrYdA1OI6SXxibYbGiMujn07VfTgJNfv8UVDe58Butp5idOo+ks6oTzask=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=iWkVaDfS; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=Gt3fDdMNSQsTh6KadhgNQ6YSOYKA/bZgZ2CyiiHLs4k=;
	b=iWkVaDfSJjE56Z2n44PkcRay6y3NTxgQZt255HBaAdGgL/0Me5htyeiKh6v9JL
	YYdXbK/QwgzQtZcJiwmoobBe47f5JgA987DidKTL7OP/S32t3Y6b/+rwLaTdMkmo
	JHz8Q6I8qlsQR4Vxz+aEni3vLWbvNMuPVkSZaoNFZiOsY=
Received: from [192.168.71.89] (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgDHT8A1bOFnWfEvAA--.6387S2;
	Mon, 24 Mar 2025 22:29:11 +0800 (CST)
Message-ID: <d370b69a-3b70-4e3b-94a3-43e0bc1305cd@163.com>
Date: Mon, 24 Mar 2025 22:29:09 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v6 3/5] PCI: cadence: Use common PCI host bridge APIs for
 finding the capabilities
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org,
 robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com,
 thomas.richard@bootlin.com, linux-pci@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <20250323164852.430546-1-18255117159@163.com>
 <20250323164852.430546-4-18255117159@163.com>
 <f467056d-8d4a-9dab-2f0a-ca589adfde53@linux.intel.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <f467056d-8d4a-9dab-2f0a-ca589adfde53@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgDHT8A1bOFnWfEvAA--.6387S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZFyUZrWrGrW3WF17trW7CFg_yoWrtr1kpF
	W8GF1fCF1rJrW3uan7Za1UXF13tasay347t392k347ZrnruryUGF9FgFy3KF9xCrsFgr17
	Z3yDtas2krn0yFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UBHqcUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWwoao2fhZfufXQAAsy



On 2025/3/24 21:44, Ilpo Järvinen wrote:
> On Mon, 24 Mar 2025, Hans Zhang wrote:
> 
>> Since the PCI core is now exposing generic APIs for the host bridges to
> 
> No need to say "since ... is now exposing". Just say "Use ..." as if the
> API has always existed even if you just added it.
> 

Hi Ilpo,

Thanks your for reply. Will change.


>> search for the PCIe capabilities, make use of them in the CDNS driver.
>>
>> Signed-off-by: Hans Zhang <18255117159@163.com>
>> ---
>> Changes since v5:
>> https://lore.kernel.org/linux-pci/20250321163803.391056-4-18255117159@163.com
>>
>> - Kconfig add "select PCI_HOST_HELPERS"
>> ---
>>   drivers/pci/controller/cadence/Kconfig        |  1 +
>>   drivers/pci/controller/cadence/pcie-cadence.c | 25 +++++++++++++++++++
>>   drivers/pci/controller/cadence/pcie-cadence.h |  3 +++
>>   3 files changed, 29 insertions(+)
>>
>> diff --git a/drivers/pci/controller/cadence/Kconfig b/drivers/pci/controller/cadence/Kconfig
>> index 8a0044bb3989..0a4f245bbeb0 100644
>> --- a/drivers/pci/controller/cadence/Kconfig
>> +++ b/drivers/pci/controller/cadence/Kconfig
>> @@ -5,6 +5,7 @@ menu "Cadence-based PCIe controllers"
>>   
>>   config PCIE_CADENCE
>>   	bool
>> +	select PCI_HOST_HELPERS
>>   
>>   config PCIE_CADENCE_HOST
>>   	bool
>> diff --git a/drivers/pci/controller/cadence/pcie-cadence.c b/drivers/pci/controller/cadence/pcie-cadence.c
>> index 204e045aed8c..329dab4ff813 100644
>> --- a/drivers/pci/controller/cadence/pcie-cadence.c
>> +++ b/drivers/pci/controller/cadence/pcie-cadence.c
>> @@ -8,6 +8,31 @@
>>   
>>   #include "pcie-cadence.h"
>>   
>> +static u32 cdns_pcie_read_cfg(void *priv, int where, int size)
>> +{
>> +	struct cdns_pcie *pcie = priv;
>> +	u32 val;
>> +
>> +	if (size == 4)
>> +		val = readl(pcie->reg_base + where);
> 
> Should this use cdns_pcie_readl() ?

pci_host_bridge_find_*capability required to read two or four bytes.

reg = read_cfg(priv, cap_ptr, 2);
or
header = read_cfg(priv, pos, 4);

Here I mainly want to write it the same way as size == 2 and size == 1.
Or size == 4 should I write it as cdns_pcie_readl() ?

> 
>> +	else if (size == 2)
>> +		val = readw(pcie->reg_base + where);
>> +	else if (size == 1)
>> +		val = readb(pcie->reg_base + where);
>> +
>> +	return val;
>> +}
>> +
>> +u8 cdns_pcie_find_capability(struct cdns_pcie *pcie, u8 cap)
>> +{
>> +	return pci_host_bridge_find_capability(pcie, cdns_pcie_read_cfg, cap);
>> +}
>> +
>> +u16 cdns_pcie_find_ext_capability(struct cdns_pcie *pcie, u8 cap)
>> +{
>> +	return pci_host_bridge_find_ext_capability(pcie, cdns_pcie_read_cfg, cap);
>> +}
> 
> I'm really wondering why the read config function is provided directly as
> an argument. Shouldn't struct pci_host_bridge have some ops that can read
> config so wouldn't it make much more sense to pass it and use the func
> from there? There seems to ops in pci_host_bridge that has read(), does
> that work? If not, why?
> 

No effect. Because we need to get the offset of the capability before 
PCIe enumerates the device. I originally added a separate find 
capability related function for CDNS in the following patch. It's also 
copied directly from DWC. Mani felt there was too much duplicate code 
and also suggested passing a callback function that could manipulate the 
registers of the root port of DWC or CDNS.

https://patchwork.kernel.org/project/linux-pci/patch/20250308133903.322216-1-18255117159@163.com/

The original function is in the following file:
drivers/pci/controller/dwc/pcie-designware.c
u8 dw_pcie_find_capability(struct dw_pcie *pci, u8 cap)
u16 dw_pcie_find_ext_capability(struct dw_pcie *pci, u8 cap)

CDNS has the same need to find the offset of the capability.

>> +
>>   void cdns_pcie_detect_quiet_min_delay_set(struct cdns_pcie *pcie)
>>   {
>>   	u32 delay = 0x3;
>> diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
>> index f5eeff834ec1..6f4981fccb94 100644
>> --- a/drivers/pci/controller/cadence/pcie-cadence.h
>> +++ b/drivers/pci/controller/cadence/pcie-cadence.h
>> @@ -557,6 +557,9 @@ static inline int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
>>   }
>>   #endif
>>   
>> +u8 cdns_pcie_find_capability(struct cdns_pcie *pcie, u8 cap);
>> +u16 cdns_pcie_find_ext_capability(struct cdns_pcie *pcie, u8 cap);
>> +
>>   void cdns_pcie_detect_quiet_min_delay_set(struct cdns_pcie *pcie);
>>   
>>   void cdns_pcie_set_outbound_region(struct cdns_pcie *pcie, u8 busnr, u8 fn,
>>
> 

Best regards,
Hans


