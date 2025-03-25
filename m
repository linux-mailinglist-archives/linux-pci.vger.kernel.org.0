Return-Path: <linux-pci+bounces-24601-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C838A6E86B
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 03:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85E59171927
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 02:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5020BDDAB;
	Tue, 25 Mar 2025 02:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="C+Ui5zkj"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95CA5291E;
	Tue, 25 Mar 2025 02:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742871563; cv=none; b=S9llK58I4G8lw4vLCiFupfAGkEOypaKoIecw8ubEXwD+oWlDa5Z+WI6acJpIc9WBXQMiXrZuYq/YE4VqofAXTLuSsGDcnIab2n60yPPkexA/zGZ2g7BuQ/fgefs3GmNYa672oTZlCPF59yw3lGKzLylrhJ2pni1MYnBzCQbIrqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742871563; c=relaxed/simple;
	bh=Y9z7F5JLkMuPI/sEYkg3vVvcDH9FgVE1nbT2FCZgfV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QS9nj+kRKGwf1F6LjnsekoYbvyFGuT5snozoH5MPfMKz72pltWfBuhceRC00Ch485AH3qkcMO98pISmA9aEd0q8qvl54GM6goBfcFphlIMyK9sChH6ydRgetOCAK4lKdrjMobHUSpBTKyXCsNKn822Gc9BXTofOiJ5QgdpEhPG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=C+Ui5zkj; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=2qw6dvYpZWZFfrtTa82kfSVcyByXP7JEHsfo1qEhQ8k=;
	b=C+Ui5zkj7+XgdAGb0sd3bOQ5nmKo/c5oXdQbAYFHxwq9srE5yodvDujDSZdgsc
	JsGDyAxs4lTsmWt16GMWVo004XFST1pL8fw+b/rxVws27fQ2hmwoSOlwaTC5wxwF
	BcLK7AJJs3g9/9MrUZ4uD08ncPaEk1bgK+fcfVywXYSQ8=
Received: from [192.168.60.52] (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wBXfD3TG+JngimnBg--.27167S2;
	Tue, 25 Mar 2025 10:58:31 +0800 (CST)
Message-ID: <bee6ba78-d65a-4a04-b83f-3be0676e8ad8@163.com>
Date: Tue, 25 Mar 2025 10:58:27 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v6 1/5] PCI: Introduce generic capability search functions
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org,
 robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com,
 thomas.richard@bootlin.com, linux-pci@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <20250323164852.430546-1-18255117159@163.com>
 <20250323164852.430546-2-18255117159@163.com>
 <f89f3d00-4423-f65d-293e-8aec3be14418@linux.intel.com>
 <b846123d-a161-4380-b7c7-24d7066f8d25@163.com>
 <1846e0b6-e743-f743-b972-723ee81fd434@linux.intel.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <1846e0b6-e743-f743-b972-723ee81fd434@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBXfD3TG+JngimnBg--.27167S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3WrWDGryDurWrWw4kKFW8tFb_yoW7KryfpF
	WrX3W2kF4kJF4aywsFva1FyF9IgFZrAry7X3ykG34DZrsI9F92qrW2y34YkF97Ar4xXF1j
	vrWUt3Z7Cr98AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Ug4SwUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWw8bo2fiGftRHgAAsE



On 2025/3/24 22:52, Ilpo Järvinen wrote:
>>>> --- a/drivers/pci/controller/Kconfig
>>>> +++ b/drivers/pci/controller/Kconfig
>>>> @@ -132,6 +132,23 @@ config PCI_HOST_GENERIC
>>>>    	  Say Y here if you want to support a simple generic PCI host
>>>>    	  controller, such as the one emulated by kvmtool.
>>>>    +config PCI_HOST_HELPERS
>>>> +	bool
>>>> +	prompt "PCI Host Controller Helper Functions" if EXPERT
>>>> + 	help
>>>> +	  This provides common infrastructure for PCI host controller drivers
>>>> to
>>>> +	  handle PCI capability scanning and other shared operations. The
>>>> helper
>>>> +	  functions eliminate code duplication across controller drivers.
>>>> +
>>>> +	  These functions are used by PCI controller drivers that need to scan
>>>> +	  PCI capabilities using controller-specific access methods (e.g. when
>>>> +	  the controller is behind a non-standard configuration space).
>>>> +
>>>> +	  If you are using any PCI host controller drivers that require these
>>>> +	  helpers (such as DesignWare, Cadence, etc), this will be
>>>> +	  automatically selected. Say N unless you are developing a custom PCI
>>>> +	  host controller driver.
>>>
>>> Hi,
>>>
>>> Does this need to be user selectable at all? What's the benefit? If
>>> somebody is developing a driver, they can just as well add the select
>>> clause in that driver to get it built.
>>>
>>
>> Dear Ilpo,
>>
>> Thanks your for reply. Only DWC and CDNS drivers are used here, what do you
>> suggest should be done?
> 
> Just make it only Kconfig select'able and not user selectable at all.
> 

Hi Ilpo,

Thanks your for reply. Will change.

Will delete it.
prompt "PCI Host Controller Helper Functions" if EXPERT

>>>> + * These interfaces resemble the pci_find_*capability() interfaces, but
>>>> these
>>>> + * are for configuring host controllers, which are bridges *to* PCI
>>>> devices but
>>>> + * are not PCI devices themselves.
>>>> + */
>>>> +static u8 __pci_host_bridge_find_next_cap(void *priv,
>>>> +					  pci_host_bridge_read_cfg read_cfg,
>>>> +					  u8 cap_ptr, u8 cap)
>>>> +{
>>>> +	u8 cap_id, next_cap_ptr;
>>>> +	u16 reg;
>>>> +
>>>> +	if (!cap_ptr)
>>>> +		return 0;
>>>> +
>>>> +	reg = read_cfg(priv, cap_ptr, 2);
>>>> +	cap_id = (reg & 0x00ff);
>>>> +
>>>> +	if (cap_id > PCI_CAP_ID_MAX)
>>>> +		return 0;
>>>> +
>>>> +	if (cap_id == cap)
>>>> +		return cap_ptr;
>>>> +
>>>> +	next_cap_ptr = (reg & 0xff00) >> 8;
>>>> +	return __pci_host_bridge_find_next_cap(priv, read_cfg, next_cap_ptr,
>>>> +					       cap);
>>>
>>> This is doing (tail) recursion?? Why??
>>>
>>> What should be done, IMO, is that code in __pci_find_next_cap_ttl()
>>> refactored such that it can be reused instead of duplicating it in a
>>> slightly different form here and the functions below.
>>>
>>> The capability list parser should be the same?
>>>
>>
>> The original function is in the following file:
>> drivers/pci/controller/dwc/pcie-designware.c
>> u8 dw_pcie_find_capability(struct dw_pcie *pci, u8 cap)
>> u16 dw_pcie_find_ext_capability(struct dw_pcie *pci, u8 cap)
>>
>> CDNS has the same need to find the offset of the capability.
>>
>> We don't have pci_dev before calling pci_host_probe, but we want to get the
>> offset of the capability and configure some registers to initialize the root
>> port. Therefore, the __pci_find_next_cap_ttl function cannot be used. This is
>> also the purpose of dw_pcie_find_*capability.
> 
> __pci_find_next_cap_ttl() does not take pci_dev so I'm unsure if the
> problem is real or not?!?

__pci_find_next_cap_ttl uses pci_bus as the first argument, and other 
functions take pci_dev->bus as its first argument. Either way, either 
pci_bus or pci_dev is required, and before pcie enumeration, there was 
no pci_bus or pci_dev.

I replied to you in the patch email [v6 3/5], if I wasn't clear enough, 
please remind me and we'll discuss it again.

> 
>> The CDNS driver does not have a cdns_pcie_find_*capability function.
>> Therefore, separate the find capability, and then DWC and CDNS can be used at
>> the same time to reduce duplicate code.
>>
>>
>> Communication history:
>>
>> Bjorn HelgaasMarch 14, 2025, 8:31 p.m. UTC | #8
>> On Fri, Mar 14, 2025 at 06:35:11PM +0530, Manivannan Sadhasivam wrote:
>>> ...
>>
>>> Even though this patch is mostly for an out of tree controller
>>> driver which is not going to be upstreamed, the patch itself is
>>> serving some purpose. I really like to avoid the hardcoded offsets
>>> wherever possible. So I'm in favor of this patch.
>>>
>>> However, these newly introduced functions are a duplicated version
>>> of DWC functions. So we will end up with duplicated functions in
>>> multiple places. I'd like them to be moved (both this and DWC) to
>>> drivers/pci/pci.c if possible. The generic function
>>> *_find_capability() can accept the controller specific readl/ readw
>>> APIs and the controller specific private data.
>>
>> I agree, it would be really nice to share this code.
>>
>> It looks a little messy to deal with passing around pointers to
>> controller read ops, and we'll still end up with a lot of duplicated
>> code between __pci_find_next_cap() and __cdns_pcie_find_next_cap(),
>> etc.
>>
>> Maybe someday we'll make a generic way to access non-PCI "config"
>> space like this host controller space and PCIe RCRBs.
>>
>> Or if you add interfaces that accept read/write ops, maybe the
>> existing pci_find_capability() etc could be refactored on top of them
>> by passing in pci_bus_read_config_word() as the accessor.
> 
> At minimum, the loop in __pci_find_next_cap_ttl() could be turned into a
> macro similar to eg. read_poll_timeout() that takes the read function as
> an argument (read_poll_timeout() looks messy because it doesn't align
> backslashed to far right). That would avoid duplicating the parsing logic
> on C code level.
> 

The config space register cannot be read before PCIe enumeration. Only 
the read and write functions of the root port driver can be used.

Best regards,
Hans


