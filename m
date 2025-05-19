Return-Path: <linux-pci+bounces-27981-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11608ABC036
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 16:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FDB47A03E3
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 14:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1277E284B39;
	Mon, 19 May 2025 14:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ffyDfyS6"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7AD284693;
	Mon, 19 May 2025 14:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747663465; cv=none; b=UoDB4R5wVcU+YSVFWePeILmOHxRyFm+6P37EPPZPbM+5AXDLeCmeKWz6RiRWFKFIScPk4CS+ATsxtuPpk0cAjSJXoU/PN9cXKhLmKtplCK7E5l4KxsUoIC5IOQwp3z8gcNyHUwThPU97Anu4xhkUwMILk3KJxXLP5354S3IvRtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747663465; c=relaxed/simple;
	bh=tWfvXwhAdZ5gTeptiPE9Fe1/fwx01QSqHBxpZlGmt+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u8Y0U1Jk6RCi1JGSoyWHWGoS1mt/baZA/yw2IRzW54rNebOohfkdrLh4o2oMY9oySQHE9Ik72f6slL7//XOuGf+pOOOQgTicrv7LmcW2eCa1YQFj1Ja9HU4jfs/etECxGj97ihlUvJEyS7to2A5I44CEZKCXjj6Nqx50mGe3eNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ffyDfyS6; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=w5WmlRLBiaSyBNP62+3UzxDW04RPKWnE0s58YY3pWoQ=;
	b=ffyDfyS6/Sye1aNzIMf3Rx+icmkqMACwSvMovxfXiCqUcshMSAj2jMlfuSZsev
	gAmwPb9UkhuPFKi/JpZYmTQc5Q+8vznlWOfCvc/HkjtUW7/LPi9MypWEq0lB0WLK
	/oEOp9B38hEVClJZn8sjuuRjKWO0fYiwynfMwHWFHFaYc=
Received: from [192.168.71.93] (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wC3T8srOitoOT5PCg--.21492S2;
	Mon, 19 May 2025 22:03:24 +0800 (CST)
Message-ID: <f3033cfb-6a70-4fa3-bf06-ee79517ef740@163.com>
Date: Mon, 19 May 2025 22:03:25 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] PCI/AER: Expose AER panic state via
 pci_aer_panic_enabled()
To: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
 bhelgaas@google.com, tglx@linutronix.de, kw@linux.com,
 manivannan.sadhasivam@linaro.org, mahesh@linux.ibm.com
Cc: oohall@gmail.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Hans Zhang <hans.zhang@cixtech.com>
References: <20250516165518.125495-1-18255117159@163.com>
 <20250516165518.125495-4-18255117159@163.com>
 <6d946767-aa61-441d-965b-115e415bfd4f@linux.intel.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <6d946767-aa61-441d-965b-115e415bfd4f@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC3T8srOitoOT5PCg--.21492S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGr1kGr4DZw1rXrWrKrWfKrg_yoW5GF1DpF
	WrJa4UArW8GFy8WFZ7Z3W8ZFyrZ3s7tryrArWxG3y8uFnxA3WrJF93AFyUWFn7Xr4DuF1a
	yF1jyrnxGF45taDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UBrWwUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDwlSo2grOTwcZgAAsL



On 2025/5/17 12:07, Sathyanarayanan Kuppuswamy wrote:
> 
> On 5/16/25 9:55 AM, Hans Zhang wrote:
>> From: Hans Zhang <hans.zhang@cixtech.com>
>>
>> Add pci_aer_panic_enabled() to check if aer_panic is enabled system-wide.
>> Export the function for use in error recovery logic.
>>
>> Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
>> ---
>>   drivers/pci/pci.h      |  2 ++
>>   drivers/pci/pcie/aer.c | 12 ++++++++++++
>>   2 files changed, 14 insertions(+)
>>
>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>> index 8ddfc1677eeb..f92928dadc6a 100644
>> --- a/drivers/pci/pci.h
>> +++ b/drivers/pci/pci.h
>> @@ -959,6 +959,7 @@ static inline void 
>> of_pci_remove_host_bridge_node(struct pci_host_bridge *bridge
>>   #ifdef CONFIG_PCIEAER
>>   void pci_no_aer(void);
>>   void pci_aer_panic(void);
>> +bool pci_aer_panic_enabled(void);
>>   void pci_aer_init(struct pci_dev *dev);
>>   void pci_aer_exit(struct pci_dev *dev);
>>   extern const struct attribute_group aer_stats_attr_group;
>> @@ -970,6 +971,7 @@ void pci_restore_aer_state(struct pci_dev *dev);
>>   #else
>>   static inline void pci_no_aer(void) { }
>>   static inline void pci_aer_panic(void) { }
>> +static inline bool pci_aer_panic_enabled(void) { return false; }
>>   static inline void pci_aer_init(struct pci_dev *d) { }
>>   static inline void pci_aer_exit(struct pci_dev *d) { }
>>   static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>> index fa51fb8a5fe7..4fd7db90b77c 100644
>> --- a/drivers/pci/pcie/aer.c
>> +++ b/drivers/pci/pcie/aer.c
>> @@ -125,6 +125,18 @@ void pci_aer_panic(void)
>>       pcie_aer_panic = true;
>>   }
>> +/**
>> + * pci_aer_panic_enabled() - Are AER panic enabled system-wide?
>> + *
>> + * Return: true if AER panic has not been globally disabled through 
>> ACPI FADT,
>> + * PCI bridge quirks, or the "pci=aer_panic" kernel command-line option.
> 
> I don't think we have code to disable it via ACPI FADT or PCI bridge quirks
> currently, right? If yes, just list what is currently supported.
> 

Dear Sathyanarayanan,

Thank you very much for your reply. You're right. If this series of 
patches is supported in the discussion, I will remove the comment "ACPI 
FADT, PCI bridge quirks" in the next version.

Best regards,
Hans

>> + */
>> +bool pci_aer_panic_enabled(void)
>> +{
>> +    return pcie_aer_panic;
>> +}
>> +EXPORT_SYMBOL(pci_aer_panic_enabled);
>> +
>>   bool pci_aer_available(void)
>>   {
>>       return !pcie_aer_disable && pci_msi_enabled();
> 


