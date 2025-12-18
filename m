Return-Path: <linux-pci+bounces-43294-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D2694CCBD54
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 13:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D3E9E30164F5
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 12:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E90309EE5;
	Thu, 18 Dec 2025 12:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="DO6todlx"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BD63A1E9F;
	Thu, 18 Dec 2025 12:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766062016; cv=none; b=Jsh0JAvdvI6efHbaOFL6G/xMt8U4elQdMrSrCoJI1cMERT39OcNfK1WZw2DYPh41OxsuzNK/OvP0+K8F4dXMZ+JKZbC9g5NBs9zUmCMz3JMdD9miwhP+cF8eo7mn8eDDqJy2C0w6Z/j0mpbfWZm3lg61gaZn7kbR/CvjLSCtRfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766062016; c=relaxed/simple;
	bh=SfuHmxtutn7F3jnLF0bTxil8taf9cfpivJegw3emGW0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nVdFmeEJ2KyXPICZ4wyXK2uDllPratNUHEWU5/snjaxLwEDiNwW4dkdnYNj8RUaUCL4CjhP2VjkS7xn9bWN7fVcG1udvQjcimIcjRL4QPfrcLNY0UYtebH7fPrVQPCkMwXjqHwHfbNvBzqLGz82ZzDir9flDeDyadDDhlFv6kLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=DO6todlx; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=Fbp3ZxP6S+llRLvCHyU0Sn4+POSfMVE2vHVOMRCxZPs=;
	b=DO6todlxsiMSD/kDPMjuWUQi9nSwo2uAPkJrndtf3n78ux0IXfxEMIbIdr85ea
	avETXyO6POa8iFHiwtKx5YDAr/QJHuu69VkMngJXHRNoahQ9OIL+nK7PUTtlkEIN
	Lh2RF9FQfDgyYgzCtPXXPDdUgqZyArY7RxnAX/RmUAvx8=
Received: from [IPV6:240e:b8f:927e:1000:25d6:ba9d:e967:4b1c] (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wCntKim90Npk7h8BA--.26302S2;
	Thu, 18 Dec 2025 20:46:30 +0800 (CST)
Message-ID: <6b9c522b-4359-433d-905c-85170ba1c3dc@163.com>
Date: Thu, 18 Dec 2025 20:46:30 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] PCI: of: Relax max-link-speed check to support
 PCIe Gen5/Gen6
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: bhelgaas@google.com, helgaas@kernel.org, ilpo.jarvinen@linux.intel.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251105134701.182795-1-18255117159@163.com>
 <hsfa7kxvhrjcth3pabsrid2bzzjch7thu2uxggrg32tt54ipaq@lj7nbweoaj35>
 <b4c24074-0898-40d8-8cf0-ff5f95e2a8a9@163.com>
 <jwyze44q3dte4ac3ajythb7mxy7sp2hcidugp2kowxubcp6knm@fcixtanjn2ss>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <jwyze44q3dte4ac3ajythb7mxy7sp2hcidugp2kowxubcp6knm@fcixtanjn2ss>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wCntKim90Npk7h8BA--.26302S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ArW7Kr45WFWDGw4Utr47urg_yoW8Kr15pa
	yUAa4F9FW8JFWfZF4vq3WFvF4Yg3Z5JrWUtryrWrnFkrnIqFn3ta4aqF45Wr1v9Fn8ZF12
	q3W2qrW7Z3yYyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U45lnUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7AdS9WlD96cuVQAA3N



On 2025/12/18 20:44, Manivannan Sadhasivam wrote:
> On Thu, Dec 18, 2025 at 07:56:14PM +0800, Hans Zhang wrote:
>>
>>
>> On 2025/12/18 14:31, Manivannan Sadhasivam wrote:
>>> On Wed, Nov 05, 2025 at 09:47:01PM +0800, Hans Zhang wrote:
>>>> The existing code restricted max-link-speed to values 1~4 (Gen1~Gen4),
>>>> but current SOCs using Synopsys/Cadence IP may require Gen5/Gen6 support.
>>>> While DT binding validation already checks this property, the code-level
>>>> validation in of_pci_get_max_link_speed still lags behind, needing an
>>>> update to accommodate newer PCIe generations.
>>>>
>>>> Hardcoded literals in such validation logic create maintainability
>>>> challenges, as they are difficult to track and update when adding
>>>> support for future PCIe link speeds.  To address this, a helper function
>>>> pcie_max_supported_link_speed() is added in drivers/pci/pci.h, which
>>>> calculates the maximum supported link speed generation using existing
>>>> PCIe capability macros (PCI_EXP_LNKCAP_SLS_*). This ensures alignment
>>>> with the kernel's generic PCIe link speed definitions and avoids
>>>> standalone hardcoded values.
>>>>
>>>> The previous hardcoded "4" in the validation check is replaced with a
>>>> call to this helper function, eliminating the need to modify this specific
>>>> code path when extending support for future PCIe generations.
>>>
>>> How can you not modify this function when PCIe 7.0 gets added? It still requires
>>> an update.
>>>
>>> I'd prefer to just drop the check altogether as the callers already have checks
>>> on their own.
>>
>> Hi Mani,
>>
>>
>> Thank you very much for your reply. Do you mean the following modification?
>>
>> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
>> index 3579265f1198..9d3980e425b4 100644
>> --- a/drivers/pci/of.c
>> +++ b/drivers/pci/of.c
>> @@ -890,7 +890,7 @@ int of_pci_get_max_link_speed(struct device_node *node)
>>   	u32 max_link_speed;
>>
>>   	if (of_property_read_u32(node, "max-link-speed", &max_link_speed) ||
>> -	    max_link_speed == 0 || max_link_speed > 4)
>> +	    max_link_speed == 0)
>>   		return -EINVAL;
>>
>>   	return max_link_speed;
>>
> 
> Yes! But you could remove the 0 check also.

Hi Mani,

Okay, thank you.

Best regards,
Hans

> 
> - Mani
> 


