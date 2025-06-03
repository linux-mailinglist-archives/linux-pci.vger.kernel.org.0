Return-Path: <linux-pci+bounces-28866-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA2AACCA55
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 17:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E30516C2D0
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 15:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A9A1DF258;
	Tue,  3 Jun 2025 15:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Ee+c2usy"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314D4140E34;
	Tue,  3 Jun 2025 15:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748965286; cv=none; b=DTpTIeeEc7kGa0CLtFEyIDsblWXDoQpntj5kDZEaT22fQyuAFpmKstkd3q0oD9VY8ygJOwWI3c/dXgIiAcXgJuT1vfIXLYLqbHoIc2uf0jXPJnXFVJUEk0okfisOrKe/LrfQ8F5fj1//dOnQgf3QxUuUx4nQhDCu3YlBZ0vTSS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748965286; c=relaxed/simple;
	bh=pXZeYSGxUIzQB00Kk+nSuewsBJ1+A8jLycmkwTd//ss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lu0ULC3iixsmvsu5k+iMKjI9NARWLQzFPboFCmnd0UwCGKTPJS67eIqmJiEyITX04GQ4JydMFA430TCnPGlugLKH84Znk2qg/kadTPSKpnn5ca/kh484DV+GrywK9ak+jv9s0nkxCXjX8AUUk+R6Y5JrSp5LZWcFquS9RPzsuCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Ee+c2usy; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=g4OPY/PyEn6wqrGBcT5BIWfztE8z18k+cpHeuPX1le0=;
	b=Ee+c2usySGMRt1p955PtpgLHyg+0jh4Lq+ZZPpMocbnPenOGgbahrcqslXnnMH
	aRYESCqj2EYhqVE9CN/DFhtEVV3JcOk4hXKa6jJ8BPTgZS5sy1baSY3xWWHlM4oX
	j9uii3HjqdbWQpQR6wEpA0NVCHJiSJ4NWZPt5uCmTELI8=
Received: from [192.168.71.94] (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wDnX957Fz9oEfqnFw--.7670S2;
	Tue, 03 Jun 2025 23:40:43 +0800 (CST)
Message-ID: <016e1a37-ca63-4ecb-9e55-eb701f789e9d@163.com>
Date: Tue, 3 Jun 2025 23:40:43 +0800
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
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <d6eeb0b5-53b3-5c40-00df-f79aa2619711@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnX957Fz9oEfqnFw--.7670S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZFyxCw1rGw43Cr4xWrWDXFb_yoW5Wr4xpF
	WUAF13Cr48JFy7CFsYvay8WFyYgFs7tFyUGrWfJ3sxZF13CF95CFy3K345ury2gr4DZr10
	vw4rWa4DC3Z8AFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UIiihUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWxFho2g-Ev5r3AABsF



On 2025/6/3 17:18, Ilpo Järvinen wrote:
> On Thu, 15 May 2025, Hans Zhang wrote:
> 
>> The primary PCI config space accessors are tied to the size of the read
>> (byte/word/dword). Upcoming refactoring of PCI capability discovery logic
>> requires passing a config accessor function that must be able to perform
>> read with different sizes.
>>
>> Add any size config space read accessor pci_bus_read_config() to allow
>> giving it as the config space accessor to the upcoming PCI capability
>> discovery macro.
>>
>> Reconstructs the PCI function discovery logic to prepare for unified
>> configuration of access modes. No function changes are intended.
>>
>> Signed-off-by: Hans Zhang <18255117159@163.com>
>> ---
>> Changes since v9 ~ v11:
>> - None
>>
>> Changes since v8:
>> - The new split is patch 1/6.
>> - The patch commit message were modified.
>> ---
>>   drivers/pci/access.c | 17 +++++++++++++++++
>>   drivers/pci/pci.h    |  2 ++
>>   2 files changed, 19 insertions(+)
>>
>> diff --git a/drivers/pci/access.c b/drivers/pci/access.c
>> index b123da16b63b..603332658ab3 100644
>> --- a/drivers/pci/access.c
>> +++ b/drivers/pci/access.c
>> @@ -85,6 +85,23 @@ EXPORT_SYMBOL(pci_bus_write_config_byte);
>>   EXPORT_SYMBOL(pci_bus_write_config_word);
>>   EXPORT_SYMBOL(pci_bus_write_config_dword);
>>   
>> +int pci_bus_read_config(void *priv, unsigned int devfn, int where, u32 size,
>> +			u32 *val)
>> +{
>> +	struct pci_bus *bus = priv;
>> +	int ret;
>> +
>> +	if (size == 1)
>> +		ret = pci_bus_read_config_byte(bus, devfn, where, (u8 *)val);
>> +	else if (size == 2)
>> +		ret = pci_bus_read_config_word(bus, devfn, where, (u16 *)val);
>> +	else
>> +		ret = pci_bus_read_config_dword(bus, devfn, where, val);
> 
> Perhaps this should check also size == 4 and return
> PCIBIOS_BAD_REGISTER_NUMBER in case size is wrong.
> 

Dear Ilpo,

Thank you very much for your reply. Will change.

I will send the next version after v6.16.

Best regards,
Hans

>> +
>> +	return ret;
> 
> 
>> +}
>> +EXPORT_SYMBOL_GPL(pci_bus_read_config);
> 
> Does this even need to be exported? Isn't the capability search always
> built in?
> 
>>   int pci_generic_config_read(struct pci_bus *bus, unsigned int devfn,
>>   			    int where, int size, u32 *val)
>>   {
>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>> index b81e99cd4b62..5e1477d6e254 100644
>> --- a/drivers/pci/pci.h
>> +++ b/drivers/pci/pci.h
>> @@ -88,6 +88,8 @@ extern bool pci_early_dump;
>>   bool pcie_cap_has_lnkctl(const struct pci_dev *dev);
>>   bool pcie_cap_has_lnkctl2(const struct pci_dev *dev);
>>   bool pcie_cap_has_rtctl(const struct pci_dev *dev);
>> +int pci_bus_read_config(void *priv, unsigned int devfn, int where, u32 size,
>> +			u32 *val);
>>   
>>   /* Functions internal to the PCI core code */
>>   
>>
> 


