Return-Path: <linux-pci+bounces-35017-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F2514B39F4C
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 15:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 97CE04E2827
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 13:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD101BD9CE;
	Thu, 28 Aug 2025 13:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="MeWDqhk5"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6824518C034;
	Thu, 28 Aug 2025 13:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756388877; cv=none; b=gWG/1YrHne5D8emPAOZPvsTuqo3nP69sSdbL7avQ7W5ITD79HSHU04rJSN43yMD0cbxAipll4MbjR/QGeA0O9u94nH7KmN2KZGUkzD6pKaiznCWYT7pFQ/VHzR8ywkjNKtgCHemn7JvhrC7KWD7fC0QJ9X4NgMuoDPaPCvyM2sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756388877; c=relaxed/simple;
	bh=o/X3XZ/6OBB1rmQze8OxBiOeqqr0Dre1xoe+LWKp95Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PbdeZe8iZYfxHrK3OlYw7IVKL1jYTxCGYtEvIFwhSuNFDB603SxJQZjolSutSSStfZeFzYBCgpWkLTxEGggkyzBd2XwdrAQ5argNF029r+H+sxZKcixI2dY4MdZs1OZ3zeSSaQ8PKqW20i5gdWcddPnaWIvgtMOOMf1lVnsxcrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=MeWDqhk5; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=xBLLsiAN4pe0CURXmH4j6QXps7YJcvxVYiQNA1fD854=;
	b=MeWDqhk5KhLlLe2aTBEIY695V5QM9x2oN65e+kMLlKIUyz4CckPDEIDy/ZhrJf
	aunUKL8M/3rB2nZB643dgdLD305F0TeXIdZQ924RX2frylg9aWeXE5yaJ6fy021Y
	c8V7VFH+fbPyrXDOuSJRCeOzeM6IOyzwk8GZ5aTvc/jvY=
Received: from [IPV6:240e:b8f:919b:3100:3980:6173:5059:2d2a] (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wAH1Ef0XbBogl2wEg--.36208S2;
	Thu, 28 Aug 2025 21:47:32 +0800 (CST)
Message-ID: <6aaafcce-0dc4-45b1-aef5-9004f84fd207@163.com>
Date: Thu, 28 Aug 2025 21:47:32 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/13] PCI: dwc: Refactor code by using
 dw_pcie_clear_and_set_dword()
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: lpieralisi@kernel.org, bhelgaas@google.com, kwilczynski@kernel.org,
 robh@kernel.org, jingoohan1@gmail.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250813044531.180411-1-18255117159@163.com>
 <20250813044531.180411-3-18255117159@163.com>
 <wi2mylqrf6szc5iluncle2lj373aoxu46lyy7d2gaqx4dv3abq@sja5aj5mwv3j>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <wi2mylqrf6szc5iluncle2lj373aoxu46lyy7d2gaqx4dv3abq@sja5aj5mwv3j>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wAH1Ef0XbBogl2wEg--.36208S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3AF1DurWfKw1rGw15Aw17Awb_yoW7Aw48pa
	9xAF4akF45JFnxuw4kZa4kZw1rZws5AFZxGwsrC34xuF9Ivr92qFyjg34YyFWxJrWIqw45
	Kw4Utasrurn8AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UIoGdUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiQxu3o2iwWuYqaAABsr



On 2025/8/27 21:51, Manivannan Sadhasivam wrote:
> On Wed, Aug 13, 2025 at 12:45:20PM GMT, Hans Zhang wrote:
>> DesignWare core modules contain multiple instances of manual
>> read-modify-write operations for register bit manipulation.
>> These patterns duplicate functionality now provided by
>> dw_pcie_clear_and_set_dword(), particularly in debugfs, endpoint,
>> host, and core initialization paths.
>>
>> Replace open-coded bit manipulation sequences with calls to
>> dw_pcie_clear_and_set_dword(). Affected areas include debugfs register
>> control, endpoint capability configuration, host setup routines, and
>> core link initialization logic. The changes simplify power management
>> handling, capability masking, and feature configuration.
>>
>> Standardizing on the helper function reduces code duplication by ~140
>> lines across core modules while improving readability. The refactoring
>> also ensures consistent error handling for register operations and
>> provides a single point of control for future bit manipulation logi
>> updates.
>>
>> Signed-off-by: Hans Zhang <18255117159@163.com>
>> ---
>>   .../controller/dwc/pcie-designware-debugfs.c  | 66 +++++++---------
>>   .../pci/controller/dwc/pcie-designware-ep.c   | 20 +++--
>>   .../pci/controller/dwc/pcie-designware-host.c | 26 +++----
>>   drivers/pci/controller/dwc/pcie-designware.c  | 75 +++++++------------
>>   drivers/pci/controller/dwc/pcie-designware.h  | 18 +----
>>   5 files changed, 76 insertions(+), 129 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-designware-debugfs.c b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
>> index 0fbf86c0b97e..ff185b8977f3 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware-debugfs.c
>> +++ b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
>> @@ -213,10 +213,8 @@ static ssize_t lane_detect_write(struct file *file, const char __user *buf,
>>   	if (val)
>>   		return val;
>>   
>> -	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + SD_STATUS_L1LANE_REG);
>> -	val &= ~(LANE_SELECT);
>> -	val |= FIELD_PREP(LANE_SELECT, lane);
>> -	dw_pcie_writel_dbi(pci, rinfo->ras_cap_offset + SD_STATUS_L1LANE_REG, val);
>> +	dw_pcie_clear_and_set_dword(pci, rinfo->ras_cap_offset + SD_STATUS_L1LANE_REG,
>> +				    LANE_SELECT, FIELD_PREP(LANE_SELECT, lane));
>>   
>>   	return count;
>>   }
>> @@ -309,12 +307,11 @@ static void set_event_number(struct dwc_pcie_rasdes_priv *pdata,
>>   {
>>   	u32 val;
>>   
>> -	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG);
>> -	val &= ~EVENT_COUNTER_ENABLE;
>> -	val &= ~(EVENT_COUNTER_GROUP_SELECT | EVENT_COUNTER_EVENT_SELECT);
>> -	val |= FIELD_PREP(EVENT_COUNTER_GROUP_SELECT, event_list[pdata->idx].group_no);
>> +	val = FIELD_PREP(EVENT_COUNTER_GROUP_SELECT, event_list[pdata->idx].group_no);
>>   	val |= FIELD_PREP(EVENT_COUNTER_EVENT_SELECT, event_list[pdata->idx].event_no);
>> -	dw_pcie_writel_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG, val);
>> +	dw_pcie_clear_and_set_dword(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG,
>> +				    EVENT_COUNTER_ENABLE | EVENT_COUNTER_GROUP_SELECT |
>> +				    EVENT_COUNTER_EVENT_SELECT, val);
>>   }
>>   
>>   static ssize_t counter_enable_read(struct file *file, char __user *buf,
>> @@ -354,13 +351,10 @@ static ssize_t counter_enable_write(struct file *file, const char __user *buf,
>>   
>>   	mutex_lock(&rinfo->reg_event_lock);
>>   	set_event_number(pdata, pci, rinfo);
>> -	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG);
>> -	if (enable)
>> -		val |= FIELD_PREP(EVENT_COUNTER_ENABLE, PER_EVENT_ON);
>> -	else
>> -		val |= FIELD_PREP(EVENT_COUNTER_ENABLE, PER_EVENT_OFF);
>>   
>> -	dw_pcie_writel_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG, val);
>> +	val |= FIELD_PREP(EVENT_COUNTER_ENABLE, enable ? PER_EVENT_ON : PER_EVENT_OFF);
> 
> So you just added the bitfields to the existing 'val' variable which was storing
> the return value of kstrtou32_from_user().
> 

Dear Mani,

Thank you very much for your reply and for taking the time to point out 
the problem. I double-checked today, identified the problem and will fix 
it in the next version.


> What makes me nervous about this series is these kind of subtle bugs. It is
> really hard to spot all with too many drivers/changes :/
> 
> I would suggest you to just convert whatever drivers you can test with and leave
> the rest to platforms maintainers to convert later. I do not want to regress
> platforms for cleanups.

My original intention was to hope that the code would become 
increasingly concise and that a lot of repetitive code would be removed. 
I also believe it will provide convenience for the subsequent 
development. I hope there won't be any problems with my next version.

> 
>> +	dw_pcie_clear_and_set_dword(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG,
>> +				    0, val);
> 
> Similar to what Lukas suggested here: https://lore.kernel.org/linux-pci/aKDpIeQgt7I9Ts8F@wunner.de
> 
> Please use separate API for just setting the word instead of passing 0 to this
> API.
> 

Will add dw_pcie_clear_dword and dw_pcie_set_dword.

Best regards,
Hans

> - Mani
> 


