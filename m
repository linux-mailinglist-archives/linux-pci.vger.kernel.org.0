Return-Path: <linux-pci+bounces-30759-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A49AEA0A6
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 16:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C9C33ADBA3
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 14:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA522EAD1B;
	Thu, 26 Jun 2025 14:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="lm0jVkFQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6BE218858;
	Thu, 26 Jun 2025 14:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750948301; cv=none; b=creoeUnSIWUrUVXGU4Nvc+8m5eabkFUnjNP6cyZIrRDfF5+b+UumEviFMwistEXHPU1mIkYHSnR5ME4KNH2DrO/7sHwzMz0e/a/AvCHC7YXSRJIS8d1uOAxzQyNFZZgWaisCa9ekSxRH/78krg8uk7YFCFYMOjl1jvxfSzevX8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750948301; c=relaxed/simple;
	bh=CDNeUhcwn1fieliy8eQB03EGAGSjSxhhMohngzPXcZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FG2e9gePyimhDSIYZSnR2UWioZ+Uiqzza4Z8ds2Lu8/zDQag93Bins/Uyk7akuCUCMCIPvZYeIGecdxwbgzvhhoQxrjO2RhhH145spclgxp5aKOc15wZxvP19myilM6hhLuDkHZzqHi7e9v+dQXUogGD6itfunz6UuSMS9l/Rhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=lm0jVkFQ; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=EjJBTW04LPLIj6Zf1fAybOyEQnJQi1pQai76WohOpG8=;
	b=lm0jVkFQazYTCcDVZF0kPG7gzO5FjSIj7expSny1aplQt4s69nQk830XN+oMh5
	1ODR0AFWev1Ls8z5fo3kdqm916ckrf2jkJUVNEjO4QDd8IesV7WUNqy2uRA/CIt5
	RkMX+ijYoUrYx0R90hmAmR4L4GwcpQM0/czxefcxH/pz4=
Received: from [IPV6:240e:b8f:919b:3100:5951:e2f3:d3e5:8d13] (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD3N7e1WV1oh9b0Ag--.56579S2;
	Thu, 26 Jun 2025 22:31:18 +0800 (CST)
Message-ID: <55158500-73b4-4715-87f5-94b872357391@163.com>
Date: Thu, 26 Jun 2025 22:31:17 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/13] PCI: tegra194: Refactor code by using
 dw_pcie_clear_and_set_dword()
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: lpieralisi@kernel.org, bhelgaas@google.com, kwilczynski@kernel.org,
 robh@kernel.org, jingoohan1@gmail.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250618152112.1010147-1-18255117159@163.com>
 <20250618152112.1010147-14-18255117159@163.com>
 <ci3ojmiiuajwedx3desa7vf5lkk35meaj4kdqnunf3f66knvm5@gtgxoagzl7ek>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <ci3ojmiiuajwedx3desa7vf5lkk35meaj4kdqnunf3f66knvm5@gtgxoagzl7ek>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD3N7e1WV1oh9b0Ag--.56579S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZw1rZF1UJr4xtF1xGF4xtFb_yoW5urW8pF
	WUJa9YkF1UJw42vF10ka48ZFW5Z3ZakF9rurs7GF1xZFnrA347WayFqryUKFsxCFW2qF1I
	kw48tayfW3W5AFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UaAp5UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiQwd4o2hdUjK9UAAAsn



On 2025/6/26 04:57, Manivannan Sadhasivam wrote:
> On Wed, Jun 18, 2025 at 11:21:12PM +0800, Hans Zhang wrote:
>> Tegra194 PCIe driver contains extensive manual bit manipulation across
>> interrupt handling, ASPM configuration, and controller initialization.
>> The driver implements complex read-modify-write sequences with explicit
>> bit masking, leading to verbose and hard-to-maintain code.
>>
>> Refactor interrupt handling, ASPM setup, capability configuration, and
>> controller initialization using dw_pcie_clear_and_set_dword(). Replace
>> multi-step register modifications with single helper calls, eliminating
>> intermediate variables and reducing code size by ~100 lines. For CDMA
>> error handling, initialize the value variable to zero before setting
>> status bits.
>>
>> This comprehensive refactoring significantly improves code readability
>> and maintainability. Standardizing on the helper ensures consistent
>> register access patterns across all driver components and reduces the
>> risk of bit manipulation errors in this complex controller driver.
>>
>> Signed-off-by: Hans Zhang <18255117159@163.com>
>> ---
>>   drivers/pci/controller/dwc/pcie-tegra194.c | 155 +++++++++------------
>>   1 file changed, 64 insertions(+), 91 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
>> index 4f26086f25da..c6f5c35a4be4 100644
>> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
>> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
>> @@ -378,9 +378,8 @@ static irqreturn_t tegra_pcie_rp_irq_handler(int irq, void *arg)
>>   			val |= APPL_CAR_RESET_OVRD_CYA_OVERRIDE_CORE_RST_N;
>>   			appl_writel(pcie, val, APPL_CAR_RESET_OVRD);
>>   
>> -			val = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
>> -			val |= PORT_LOGIC_SPEED_CHANGE;
>> -			dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
>> +			dw_pcie_clear_and_set_dword(pci, PCIE_LINK_WIDTH_SPEED_CONTROL,
>> +						    0, PORT_LOGIC_SPEED_CHANGE);
>>   		}
>>   	}
>>   
>> @@ -412,7 +411,7 @@ static irqreturn_t tegra_pcie_rp_irq_handler(int irq, void *arg)
>>   
>>   	if (status_l0 & APPL_INTR_STATUS_L0_CDM_REG_CHK_INT) {
>>   		status_l1 = appl_readl(pcie, APPL_INTR_STATUS_L1_18);
>> -		val = dw_pcie_readl_dbi(pci, PCIE_PL_CHK_REG_CONTROL_STATUS);
>> +		val = 0;
>>   		if (status_l1 & APPL_INTR_STATUS_L1_18_CDM_REG_CHK_CMPLT) {
>>   			dev_info(pci->dev, "CDM check complete\n");
>>   			val |= PCIE_PL_CHK_REG_CHK_REG_COMPLETE;
>> @@ -425,7 +424,8 @@ static irqreturn_t tegra_pcie_rp_irq_handler(int irq, void *arg)
>>   			dev_err(pci->dev, "CDM Logic error\n");
>>   			val |= PCIE_PL_CHK_REG_CHK_REG_LOGIC_ERROR;
>>   		}
>> -		dw_pcie_writel_dbi(pci, PCIE_PL_CHK_REG_CONTROL_STATUS, val);
>> +		dw_pcie_clear_and_set_dword(pci, PCIE_PL_CHK_REG_CONTROL_STATUS,
>> +					    PORT_LOGIC_SPEED_CHANGE, val);
> 
> I don't know why you are clearing PORT_LOGIC_SPEED_CHANGE here which is not part
> of PCIE_PL_CHK_REG_CONTROL_STATUS. Typo?
> 
Dear Mani,

Thank you very much for your reply and reminder.

This is copied from the first change of this patch and will be fixed in 
the next version.

Best regards,
Hans


> - Mani
> 


