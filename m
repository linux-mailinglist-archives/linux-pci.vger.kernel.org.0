Return-Path: <linux-pci+bounces-24664-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2386DA6FAF3
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 13:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36AF617141D
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 12:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7CD2580C3;
	Tue, 25 Mar 2025 12:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="extbD/m+"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8302580CB;
	Tue, 25 Mar 2025 12:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742905019; cv=none; b=dPWbY2mIEsiMwxCTUZBKwC27LkJlH8EgHCH2Hbm11tGi2s/32MGbJE0+PM/am8gyDCJ9STcELW3YF1El6ovGgXo0X9CwOkjxVrcSdimEvOsOoaQl3G8kGtaZiq9dKjDPZxgOHgQn5BDjQF8woIDZ8J2n3eP9WzJggBffFNZCK28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742905019; c=relaxed/simple;
	bh=NcEPb55Rco6EjfgmgRqxo9YOOSFOucPfaWT3g07OCLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IfTsWsSSKZM5Aern4xrVyETbzwOrZBkxInhKSCm1mQdMiSN9z/O+5HWGLj34BA7fP+ucUaqPerR14pQyHmSXPZysUwZ80qPEAlP1eYwAOT1YRvR66OxilDnjogsvRiuPkeZJRa0z4WZsJxsWXECnK8olwSev/WW+BSq9evQJtKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=extbD/m+; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=rnao7tYHGP/XCO8pJr95a8UIsRVe2QvBuKZ594nf8Qk=;
	b=extbD/m+mQB7gssuj51WZuVMW15Wa1YryIk/AwXIPLk5lENT7oDHlrFT5CJkcP
	Wm8asJYT4MpshdvzBOkX/jzuyBRmmhT7v+hLw6SvJgdsiyhdBQgzS7vLKu/1MV86
	yszyV/lg6CcyIo7sntPHehSHsAqY0/fH0G9ZfAm5M+dhU=
Received: from [192.168.60.52] (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3n1SJnuJnE9JrBw--.50275S2;
	Tue, 25 Mar 2025 20:16:11 +0800 (CST)
Message-ID: <f2725090-e199-493d-9ae3-e807d65f647b@163.com>
Date: Tue, 25 Mar 2025 20:16:09 +0800
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
 <3d9b2fa9-98bf-4f47-aa76-640a4f82cb2f@163.com>
 <26dcba54-93c1-dda4-c5e2-e324e9d50b09@linux.intel.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <26dcba54-93c1-dda4-c5e2-e324e9d50b09@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3n1SJnuJnE9JrBw--.50275S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Gw1UAFy5WF1xCryUZw4Dtwb_yoW7ur1xpF
	W5tF15KF4kJr47Grn2va1FqF1ayr90yFy5X34kG34UZwn093WfGFWqkay5CFn7CFs7Jr1j
	qayjqr93ur90yaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07ULzV8UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDxUbo2fim2FegAAAsD



On 2025/3/25 19:15, Ilpo Järvinen wrote:
> On Tue, 25 Mar 2025, Hans Zhang wrote:
>> On 2025/3/24 23:02, Ilpo Järvinen wrote:
>>>>>>     +static u32 cdns_pcie_read_cfg(void *priv, int where, int size)
>>>>>> +{
>>>>>> +	struct cdns_pcie *pcie = priv;
>>>>>> +	u32 val;
>>>>>> +
>>>>>> +	if (size == 4)
>>>>>> +		val = readl(pcie->reg_base + where);
>>>>>
>>>>> Should this use cdns_pcie_readl() ?
>>>>
>>>> pci_host_bridge_find_*capability required to read two or four bytes.
>>>>
>>>> reg = read_cfg(priv, cap_ptr, 2);
>>>> or
>>>> header = read_cfg(priv, pos, 4);
>>>>
>>>> Here I mainly want to write it the same way as size == 2 and size == 1.
>>>> Or size == 4 should I write it as cdns_pcie_readl() ?
>>>
>>> As is, it seems two functions are added for the same thing for the case
>>> with size == 4 with different names which feels duplication. One could add
>>> cdns_pcie_readw() and cdns_pcie_readb() too but perhaps cdns_pcie_readl()
>>> should just call this new function instead?
>>
>> Hi Ilpo,
>>
>> Redefine a function with reference to DWC?
> 
> This patch was about cadence so my comment above what related to that.
> 

Hi Ilpo,

Thanks your for reply. Let's look at the main problem first.

>> u32 dw_pcie_read_dbi(struct dw_pcie *pci, u32 reg, size_t size)
>>    dw_pcie_read(pci->dbi_base + reg, size, &val);
>>      dw_pcie_read
>>
>> int dw_pcie_read(void __iomem *addr, int size, u32 *val)
>> {
>> 	if (!IS_ALIGNED((uintptr_t)addr, size)) {
>> 		*val = 0;
>> 		return PCIBIOS_BAD_REGISTER_NUMBER;
>> 	}
>>
>> 	if (size == 4) {
>> 		*val = readl(addr);
>> 	} else if (size == 2) {
>> 		*val = readw(addr);
>> 	} else if (size == 1) {
>> 		*val = readb(addr);
>> 	} else {
>> 		*val = 0;
>> 		return PCIBIOS_BAD_REGISTER_NUMBER;
>> 	}
>>
>> 	return PCIBIOS_SUCCESSFUL;
>> }
>> EXPORT_SYMBOL_GPL(dw_pcie_read);
>>
>>>
>>>>>> +	else if (size == 2)
>>>>>> +		val = readw(pcie->reg_base + where);
>>>>>> +	else if (size == 1)
>>>>>> +		val = readb(pcie->reg_base + where);
>>>>>> +
>>>>>> +	return val;
>>>>>> +}
>>>>>> +
>>>>>> +u8 cdns_pcie_find_capability(struct cdns_pcie *pcie, u8 cap)
>>>>>> +{
>>>>>> +	return pci_host_bridge_find_capability(pcie,
>>>>>> cdns_pcie_read_cfg, cap);
>>>>>> +}
>>>>>> +
>>>>>> +u16 cdns_pcie_find_ext_capability(struct cdns_pcie *pcie, u8 cap)
>>>>>> +{
>>>>>> +	return pci_host_bridge_find_ext_capability(pcie,
>>>>>> cdns_pcie_read_cfg,
>>>>>> cap);
>>>>>> +}
>>>>>
>>>>> I'm really wondering why the read config function is provided directly
>>>>> as
>>>>> an argument. Shouldn't struct pci_host_bridge have some ops that can
>>>>> read
>>>>> config so wouldn't it make much more sense to pass it and use the func
>>>>> from there? There seems to ops in pci_host_bridge that has read(), does
>>>>> that work? If not, why?
>>>>>
>>>>
>>>> No effect.
>>>
>>> I'm not sure what you meant?
>>>
>>>> Because we need to get the offset of the capability before PCIe
>>>> enumerates the device.
>>>
>>> Is this to say it is needed before the struct pci_host_bridge is created?
>>>
>>>> I originally added a separate find capability related
>>>> function for CDNS in the following patch. It's also copied directly from
>>>> DWC.
>>>> Mani felt there was too much duplicate code and also suggested passing a
>>>> callback function that could manipulate the registers of the root port of
>>>> DWC
>>>> or CDNS.
>>>
>>> I very much like the direction this patchset is moving (moving shared
>>> part of controllers code to core), I just feel this doesn't go far enough
>>> when it's passing function pointer to the read function.
>>>
>>> I admit I've never written a controller driver so perhaps there's
>>> something detail I lack knowledge of but I'd want to understand why
>>> struct pci_ops (which exists both in pci_host_bridge and pci_bus) cannot
>>> be used?
>>>
>>
>>
>> I don't know if the following code can make it clear to you.
>>
>> static const struct dw_pcie_host_ops qcom_pcie_dw_ops = {
>> 	.host_init	= qcom_pcie_host_init,
>>                    pcie->cfg->ops->post_init(pcie);
>>                      qcom_pcie_post_init_2_3_3
>>                        dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
>> };
>>
>> int dw_pcie_host_init(struct dw_pcie_rp *pp)
>>    bridge = devm_pci_alloc_host_bridge(dev, 0);
> 
> It does this almost immediately:
> 
>      bridge->ops = &dw_pcie_ops;
> 
> Can we like add some function into those ops such that the necessary read
> can be performed? Like .early_root_config_read or something like that?
> 
> Then the host bridge capability finder can input struct pci_host_bridge
> *host_bridge and can do host_bridge->ops->early_root_cfg_read(host_bridge,
> ...). That would already be a big win over passing the read function
> itself as a pointer.
> 
> Hopefully having such a function in the ops would allow moving other
> common controller driver functionality into PCI core as well as it would
> abstract the per controller read function (for the time before everything
> is fully instanciated).
> 
> Is that a workable approach?
>

I'll try to add and test it in your way first.

Another problem here is that I've seen some drivers invoke 
dw_pcie_find_*capability before if (pp->ops->init) {. When I confirm it, 
or I'll see if I can cover all the issues.

If I pass the test, I will provide the temporary patch here, please 
check whether it is OK, and then submit the next version. If not, we'll 
discuss it.

Thank you very much for your advice.

>>    if (pp->ops->host_init)
>>      pp->ops = &qcom_pcie_dw_ops;  // qcom here needs to find capability
>>
>>    pci_host_probe(bridge); // pcie enumerate flow
>>      pci_scan_root_bus_bridge(bridge);
>>        pci_register_host_bridge(bridge);
>>          bus->ops = bridge->ops;   // Only pci bus ops can be used
>>
>>


Best regards,
Hans


