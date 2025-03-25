Return-Path: <linux-pci+bounces-24674-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB24BA70432
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 15:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2B263AAD72
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 14:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2DE825A34E;
	Tue, 25 Mar 2025 14:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="UV/YGwZH"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8896198A29;
	Tue, 25 Mar 2025 14:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742914106; cv=none; b=Iz8EHeeBMEmp7F4h4/GlkHX1WsI99AHTRKdfgxvRjghguyizzw1gmslKAopuvlbZXXea9dH1Y6fz8H+XmJF51hpkoFyTu/gjsSgW653jjAfFojlKHkEjtkqHnluZhyOkaZkNoAT85/Xlt1mk3h8dmL4tk542HusjpIW2P+sTBdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742914106; c=relaxed/simple;
	bh=9+2Uh/BLViIs+1GHNo/s+KKopYxrsV6VsqfGI5tmUfk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Ycyob5aARveP3gMBdjOB8j2wtRUhhCLE8RNthNXZpf9cweqpUykVBH/uGYyVMD4Tnj1+rKA6URt4zEjQeSK71o2fh7U7ZFJnE7PMl5kBud4AyG+X3nTxjQahgoXSYArG3P89kl8Z/e5wwh8wReLHAd/ENsVo+dzdON1VCBCAvug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=UV/YGwZH; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=txp6lf9K0o1E/un52ErXwYWFA2aX9m0KATXJ22mjZqg=;
	b=UV/YGwZHERd+GITRKoypcpDEVAC+YcbpU0KN2MM3mdleF02gWUeAMo+2jn3glV
	pYiyreE9/fedampuGZbJZxqXYAYMIsNLnAtBI1U/teozyUKeHMnI7VhHPxQ4rF5Z
	GzjXJVo/BCokahWMTNccVuyu1SHxL7S57/jBBpcRm5gMk=
Received: from [192.168.60.52] (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wCHrnEOwuJn_ts_Bw--.57661S2;
	Tue, 25 Mar 2025 22:47:42 +0800 (CST)
Message-ID: <de6ce71c-ba82-496e-9c72-7c9c61b37906@163.com>
Date: Tue, 25 Mar 2025 22:47:42 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v6 3/5] PCI: cadence: Use common PCI host bridge APIs for
 finding the capabilities
From: Hans Zhang <18255117159@163.com>
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
 <f2725090-e199-493d-9ae3-e807d65f647b@163.com>
Content-Language: en-US
In-Reply-To: <f2725090-e199-493d-9ae3-e807d65f647b@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCHrnEOwuJn_ts_Bw--.57661S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGFykArW5Jr45KFy8tryxXwb_yoWrJF1kpa
	yY93W7Kr4kJr43Cr1IvF48tF12yrZ0yrW5Xw1DJryUZw1q93W0gFZrCryjkFnrAF4rtF1j
	qa1Yqryxur98AaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UBrWwUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOhAbo2fivrtfRQAAsI



On 2025/3/25 20:16, Hans Zhang wrote:
>>>>>> I'm really wondering why the read config function is provided 
>>>>>> directly
>>>>>> as
>>>>>> an argument. Shouldn't struct pci_host_bridge have some ops that can
>>>>>> read
>>>>>> config so wouldn't it make much more sense to pass it and use the 
>>>>>> func
>>>>>> from there? There seems to ops in pci_host_bridge that has read(), 
>>>>>> does
>>>>>> that work? If not, why?
>>>>>>
>>>>>
>>>>> No effect.
>>>>
>>>> I'm not sure what you meant?
>>>>
>>>>> Because we need to get the offset of the capability before PCIe
>>>>> enumerates the device.
>>>>
>>>> Is this to say it is needed before the struct pci_host_bridge is 
>>>> created?
>>>>
>>>>> I originally added a separate find capability related
>>>>> function for CDNS in the following patch. It's also copied directly 
>>>>> from
>>>>> DWC.
>>>>> Mani felt there was too much duplicate code and also suggested 
>>>>> passing a
>>>>> callback function that could manipulate the registers of the root 
>>>>> port of
>>>>> DWC
>>>>> or CDNS.
>>>>
>>>> I very much like the direction this patchset is moving (moving shared
>>>> part of controllers code to core), I just feel this doesn't go far 
>>>> enough
>>>> when it's passing function pointer to the read function.
>>>>
>>>> I admit I've never written a controller driver so perhaps there's
>>>> something detail I lack knowledge of but I'd want to understand why
>>>> struct pci_ops (which exists both in pci_host_bridge and pci_bus) 
>>>> cannot
>>>> be used?
>>>>
>>>
>>>
>>> I don't know if the following code can make it clear to you.
>>>
>>> static const struct dw_pcie_host_ops qcom_pcie_dw_ops = {
>>>     .host_init    = qcom_pcie_host_init,
>>>                    pcie->cfg->ops->post_init(pcie);
>>>                      qcom_pcie_post_init_2_3_3
>>>                        dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
>>> };
>>>
>>> int dw_pcie_host_init(struct dw_pcie_rp *pp)
>>>    bridge = devm_pci_alloc_host_bridge(dev, 0);
>>
>> It does this almost immediately:
>>
>>      bridge->ops = &dw_pcie_ops;
>>
>> Can we like add some function into those ops such that the necessary read
>> can be performed? Like .early_root_config_read or something like that?
>>
>> Then the host bridge capability finder can input struct pci_host_bridge
>> *host_bridge and can do 
>> host_bridge->ops->early_root_cfg_read(host_bridge,
>> ...). That would already be a big win over passing the read function
>> itself as a pointer.
>>
>> Hopefully having such a function in the ops would allow moving other
>> common controller driver functionality into PCI core as well as it would
>> abstract the per controller read function (for the time before everything
>> is fully instanciated).
>>
>> Is that a workable approach?
>>
> 
> I'll try to add and test it in your way first.
> 
> Another problem here is that I've seen some drivers invoke 
> dw_pcie_find_*capability before if (pp->ops->init) {. When I confirm it, 
> or I'll see if I can cover all the issues.
> 
> If I pass the test, I will provide the temporary patch here, please 
> check whether it is OK, and then submit the next version. If not, we'll 
> discuss it.
> 

Hi Ilpo,

Another question comes to mind:
If working in EP mode, devm_pci_alloc_host_bridge will not be executed 
and there will be no struct pci_host_bridge.

Don't know if you have anything to add?

> Thank you very much for your advice.
> 
>>>    if (pp->ops->host_init)
>>>      pp->ops = &qcom_pcie_dw_ops;  // qcom here needs to find capability
>>>
>>>    pci_host_probe(bridge); // pcie enumerate flow
>>>      pci_scan_root_bus_bridge(bridge);
>>>        pci_register_host_bridge(bridge);
>>>          bus->ops = bridge->ops;   // Only pci bus ops can be used
>>>
>>>

Best regards,
Hans


