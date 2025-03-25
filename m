Return-Path: <linux-pci+bounces-24602-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 191A8A6E874
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 04:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3028C3ABE53
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 03:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5655C16F282;
	Tue, 25 Mar 2025 03:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="BrjDdUFQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C45A610B;
	Tue, 25 Mar 2025 03:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742871626; cv=none; b=lYH+9RbT+4T6uA4QUV5lydjbminUGzKHs0lUvLksQSgwRj+EC+P5hDiwqlzXpqD/GVMweQRCqNzVnloENA02X4dIs5K95zIwj9DqpAIWIZHI/8DLZcla/RcmZ4sxat9ZSGOVFrvlijYIumqIBI7SwT6VTrm4lw2vam+cGVTL5qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742871626; c=relaxed/simple;
	bh=uUulRKjZ00n5Mt31D5KLgP81ALiFmubB5Y5oq+az+ww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IlF9KfqWFQyznQdI3mu6Mqg++k39i1KS3KErSrk/C3pFoUfYIV2TaFlzQeRuH7Bg51MTljj7PqS+UbcV7XAYJM6dG8DxLtIuAMlCoOR5CohTZ1smEi0+pcr2KjN9GqGSGNycNGSqZNH1WnAC7VlxlkWqInUzDuK6HFLXD1AynCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=BrjDdUFQ; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=0eer3EgLHRT+qs+bXoeJVJZ6rL+V0jGlXoHAUa4zRQI=;
	b=BrjDdUFQ9dI6XU/JQ+YSri9SwXf+r3gw2/TeqZfJFZlcTAzqpsHTDSuz2koAAH
	MvUF8vLjk8c3SPV4vXFWBTjXGuIi3+HRbSldOJNgcSr4TbwTwqCZR1iNezDKCp9K
	B5jjS1r4rWZp0TnmSa0TFgU++obmj0mOIBqaRsYA63Wsc=
Received: from [192.168.60.52] (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD33w4cHOJnKK3sBg--.25762S2;
	Tue, 25 Mar 2025 10:59:41 +0800 (CST)
Message-ID: <3d9b2fa9-98bf-4f47-aa76-640a4f82cb2f@163.com>
Date: Tue, 25 Mar 2025 10:59:40 +0800
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
 <d370b69a-3b70-4e3b-94a3-43e0bc1305cd@163.com>
 <a3462c68-ec1b-0b1a-fee7-612bd1109819@linux.intel.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <a3462c68-ec1b-0b1a-fee7-612bd1109819@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD33w4cHOJnKK3sBg--.25762S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCF4UKF1xAF15Xw1Dtw4Utwb_yoWrXFW7pF
	W5KF1ayr18Jr47Wrn2va1YqF1Syr9IyFy5Aas5Ga47Zrn0g3ZIgFWqkFW3CFyfCFs7J3WU
	X3yDtrZ3Crn8AFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uq0PhUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDw4bo2fiFsHsUwAAsU



On 2025/3/24 23:02, Ilpo Järvinen wrote:
>>>>    +static u32 cdns_pcie_read_cfg(void *priv, int where, int size)
>>>> +{
>>>> +	struct cdns_pcie *pcie = priv;
>>>> +	u32 val;
>>>> +
>>>> +	if (size == 4)
>>>> +		val = readl(pcie->reg_base + where);
>>>
>>> Should this use cdns_pcie_readl() ?
>>
>> pci_host_bridge_find_*capability required to read two or four bytes.
>>
>> reg = read_cfg(priv, cap_ptr, 2);
>> or
>> header = read_cfg(priv, pos, 4);
>>
>> Here I mainly want to write it the same way as size == 2 and size == 1.
>> Or size == 4 should I write it as cdns_pcie_readl() ?
> 
> As is, it seems two functions are added for the same thing for the case
> with size == 4 with different names which feels duplication. One could add
> cdns_pcie_readw() and cdns_pcie_readb() too but perhaps cdns_pcie_readl()
> should just call this new function instead?

Hi Ilpo,

Redefine a function with reference to DWC?

u32 dw_pcie_read_dbi(struct dw_pcie *pci, u32 reg, size_t size)
   dw_pcie_read(pci->dbi_base + reg, size, &val);
     dw_pcie_read

int dw_pcie_read(void __iomem *addr, int size, u32 *val)
{
	if (!IS_ALIGNED((uintptr_t)addr, size)) {
		*val = 0;
		return PCIBIOS_BAD_REGISTER_NUMBER;
	}

	if (size == 4) {
		*val = readl(addr);
	} else if (size == 2) {
		*val = readw(addr);
	} else if (size == 1) {
		*val = readb(addr);
	} else {
		*val = 0;
		return PCIBIOS_BAD_REGISTER_NUMBER;
	}

	return PCIBIOS_SUCCESSFUL;
}
EXPORT_SYMBOL_GPL(dw_pcie_read);

> 
>>>> +	else if (size == 2)
>>>> +		val = readw(pcie->reg_base + where);
>>>> +	else if (size == 1)
>>>> +		val = readb(pcie->reg_base + where);
>>>> +
>>>> +	return val;
>>>> +}
>>>> +
>>>> +u8 cdns_pcie_find_capability(struct cdns_pcie *pcie, u8 cap)
>>>> +{
>>>> +	return pci_host_bridge_find_capability(pcie, cdns_pcie_read_cfg, cap);
>>>> +}
>>>> +
>>>> +u16 cdns_pcie_find_ext_capability(struct cdns_pcie *pcie, u8 cap)
>>>> +{
>>>> +	return pci_host_bridge_find_ext_capability(pcie, cdns_pcie_read_cfg,
>>>> cap);
>>>> +}
>>>
>>> I'm really wondering why the read config function is provided directly as
>>> an argument. Shouldn't struct pci_host_bridge have some ops that can read
>>> config so wouldn't it make much more sense to pass it and use the func
>>> from there? There seems to ops in pci_host_bridge that has read(), does
>>> that work? If not, why?
>>>
>>
>> No effect.
> 
> I'm not sure what you meant?
> 
>> Because we need to get the offset of the capability before PCIe
>> enumerates the device.
> 
> Is this to say it is needed before the struct pci_host_bridge is created?
> 
>> I originally added a separate find capability related
>> function for CDNS in the following patch. It's also copied directly from DWC.
>> Mani felt there was too much duplicate code and also suggested passing a
>> callback function that could manipulate the registers of the root port of DWC
>> or CDNS.
> 
> I very much like the direction this patchset is moving (moving shared
> part of controllers code to core), I just feel this doesn't go far enough
> when it's passing function pointer to the read function.
> 
> I admit I've never written a controller driver so perhaps there's
> something detail I lack knowledge of but I'd want to understand why
> struct pci_ops (which exists both in pci_host_bridge and pci_bus) cannot
> be used?
> 


I don't know if the following code can make it clear to you.

static const struct dw_pcie_host_ops qcom_pcie_dw_ops = {
	.host_init	= qcom_pcie_host_init,
                   pcie->cfg->ops->post_init(pcie);
                     qcom_pcie_post_init_2_3_3
                       dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
};

int dw_pcie_host_init(struct dw_pcie_rp *pp)
   bridge = devm_pci_alloc_host_bridge(dev, 0);
   if (pp->ops->host_init)
     pp->ops = &qcom_pcie_dw_ops;  // qcom here needs to find capability

   pci_host_probe(bridge); // pcie enumerate flow
     pci_scan_root_bus_bridge(bridge);
       pci_register_host_bridge(bridge);
         bus->ops = bridge->ops;   // Only pci bus ops can be used


Best regards,
Hans


