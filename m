Return-Path: <linux-pci+bounces-28867-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A61CDACCA5B
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 17:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DC081890D30
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 15:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A02623C4E6;
	Tue,  3 Jun 2025 15:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="OvdsR7UT"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11DDF22B5A3;
	Tue,  3 Jun 2025 15:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748965330; cv=none; b=t7QDrJADdEqCETQOq30I4Q/SBjl7Fz4cZFtwROYyh43o9rTawQTU/eLZr1OH0Lh2472x0sjovvnNJJrxs2RCkR4fZtsP6fVX1M3xEAxsskERWSUXJOXZz9hYeK49kCZlyxaHHu5VsnowZaBZUbLEdVny1bsgxEUW2ToZe0B6Vd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748965330; c=relaxed/simple;
	bh=Ea3h8GhDrURK7P1IDrFGuY10NwCvjtNlBGB7ufVYezg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aQEafxMX1UiV5ow8UqalCMaBQwp2bk7MWAVb6F0pxalVffdjqf4YR2L88j95bqOeTNK8G5doLStDSKED0yz3U78IxufROwSRuITwFAtoiEH+YAgPkcCvpw+Sflxuu29z4vC0aku7UypvRNvkXZ+0jEA8n8X59ZUFuet5mPnNQYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=OvdsR7UT; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=LbdlW517gAVxF6YkObS0cL9gAA0GG3ky+sP/GiGLlYc=;
	b=OvdsR7UTz92nvEvl94UK53OPE2Q+GD5gmbcLDIj6hPykqfYGKFvDPvWC9m/YIL
	pnUSqxRZWc/n37QiXbKQWc43s5i7tiH/B+pJ36muM82Dif+F6uhV8JwHmwyJwYF8
	aq+oBULDZGmMY+1Z6NMnG2F/QVR4X1uFOx6jW/iwrLSd4=
Received: from [192.168.71.94] (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3P5upFz9oV9brFw--.7834S2;
	Tue, 03 Jun 2025 23:41:29 +0800 (CST)
Message-ID: <93896043-2b25-4fbc-8102-b67ab3a3b973@163.com>
Date: Tue, 3 Jun 2025 23:41:29 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 1/6] PCI: Introduce generic bus config read helper
 function
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: lpieralisi@kernel.org, bhelgaas@google.com,
 manivannan.sadhasivam@linaro.org, kw@linux.com, cassel@kernel.org,
 robh@kernel.org, jingoohan1@gmail.com, linux-pci@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <20250514161258.93844-1-18255117159@163.com>
 <20250514161258.93844-2-18255117159@163.com>
 <d6eeb0b5-53b3-5c40-00df-f79aa2619711@linux.intel.com>
 <e486d187-e869-98b5-a0cb-8bd463540312@linux.intel.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <e486d187-e869-98b5-a0cb-8bd463540312@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3P5upFz9oV9brFw--.7834S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZr4rXFyrtryDtw4DWF17KFg_yoW5Ar4rpF
	WUJF13Ar48JFy7GFsaqa40gF15tFn7tFy8Wr4xJ3sxZFnIkF9IkFy3KFy5ury2gr4DZw10
	vw4rGa9rC3Z8AFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UIiihUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOhpho2g-EXSmMQAAsH



On 2025/6/3 17:21, Ilpo Järvinen wrote:
> On Tue, 3 Jun 2025, Ilpo Järvinen wrote:
> 
>> On Thu, 15 May 2025, Hans Zhang wrote:
>>
>>> The primary PCI config space accessors are tied to the size of the read
>>> (byte/word/dword). Upcoming refactoring of PCI capability discovery logic
>>> requires passing a config accessor function that must be able to perform
>>> read with different sizes.
>>>
>>> Add any size config space read accessor pci_bus_read_config() to allow
>>> giving it as the config space accessor to the upcoming PCI capability
>>> discovery macro.
>>>
>>> Reconstructs the PCI function discovery logic to prepare for unified
>>> configuration of access modes. No function changes are intended.
>>>
>>> Signed-off-by: Hans Zhang <18255117159@163.com>
>>> ---
>>> Changes since v9 ~ v11:
>>> - None
>>>
>>> Changes since v8:
>>> - The new split is patch 1/6.
>>> - The patch commit message were modified.
>>> ---
>>>   drivers/pci/access.c | 17 +++++++++++++++++
>>>   drivers/pci/pci.h    |  2 ++
>>>   2 files changed, 19 insertions(+)
>>>
>>> diff --git a/drivers/pci/access.c b/drivers/pci/access.c
>>> index b123da16b63b..603332658ab3 100644
>>> --- a/drivers/pci/access.c
>>> +++ b/drivers/pci/access.c
>>> @@ -85,6 +85,23 @@ EXPORT_SYMBOL(pci_bus_write_config_byte);
>>>   EXPORT_SYMBOL(pci_bus_write_config_word);
>>>   EXPORT_SYMBOL(pci_bus_write_config_dword);
>>>   
>>> +int pci_bus_read_config(void *priv, unsigned int devfn, int where, u32 size,
>>> +			u32 *val)
>>> +{
>>> +	struct pci_bus *bus = priv;
>>> +	int ret;
>>> +
>>> +	if (size == 1)
>>> +		ret = pci_bus_read_config_byte(bus, devfn, where, (u8 *)val);
>>> +	else if (size == 2)
>>> +		ret = pci_bus_read_config_word(bus, devfn, where, (u16 *)val);
>>> +	else
>>> +		ret = pci_bus_read_config_dword(bus, devfn, where, val);
>>
>> Perhaps this should check also size == 4 and return
>> PCIBIOS_BAD_REGISTER_NUMBER in case size is wrong.
>>
>>> +
>>> +	return ret;
> 
> I'd also forgo ret variable and return directly.


Dear Ilpo,

Will delete ret.

Best regards,
Hans

> 
>>> +}
>>> +EXPORT_SYMBOL_GPL(pci_bus_read_config);
>>
>> Does this even need to be exported? Isn't the capability search always
>> built in?
>>
>>>   int pci_generic_config_read(struct pci_bus *bus, unsigned int devfn,
>>>   			    int where, int size, u32 *val)
>>>   {
>>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>>> index b81e99cd4b62..5e1477d6e254 100644
>>> --- a/drivers/pci/pci.h
>>> +++ b/drivers/pci/pci.h
>>> @@ -88,6 +88,8 @@ extern bool pci_early_dump;
>>>   bool pcie_cap_has_lnkctl(const struct pci_dev *dev);
>>>   bool pcie_cap_has_lnkctl2(const struct pci_dev *dev);
>>>   bool pcie_cap_has_rtctl(const struct pci_dev *dev);
>>> +int pci_bus_read_config(void *priv, unsigned int devfn, int where, u32 size,
>>> +			u32 *val);
>>>   
>>>   /* Functions internal to the PCI core code */
>>>   
>>>
>>
>>
> 


