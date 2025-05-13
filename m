Return-Path: <linux-pci+bounces-27643-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD1FAB57D4
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 17:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9CC1169C54
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 15:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6061A83E8;
	Tue, 13 May 2025 15:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="AsCqCO8U"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8AF15ECDF;
	Tue, 13 May 2025 15:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747148479; cv=none; b=CLizLbBHi3ror4l8PBpLUuF+V3fwiWEXvSocay4B9qQhYsKeOoWAXLwkUmGBY0z3bWRoyWZV7ZAgDo6epTsJBQLZ+TQZfLqCwyBemoXjlWoXSR3Fyv6ok8NmKn4IpuL3N21Vqe8cebig9ZKGU9ZCZaHeP/5xFIZVZjt4SLiHAp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747148479; c=relaxed/simple;
	bh=WOCgooOqNHfVitxFGiwPrHiUXsFevFjpNNsnb/a7uXU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O4WD8W+gadrt1Z4CkI10eHZmjOefLBzkARztOFa7hRq59BbILuxZ5aucPyL81/KpgZd0fr94eWQ65++HBZwEUGflz7V/NkVSFZ8BtoCcx0lEA09G2Z70eL/6nT1/nPyFM+u5wRZdJMnHTOpUV2zqwf1z6kXMJMkd2SUnEGdqUtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=AsCqCO8U; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=mE88zcY2X1p4mvw+nTu0FWHvQdAVxVuWNqjWxk7qu9I=;
	b=AsCqCO8UJkR9X5Ckmm1k+1vNpSX7uQnwpbi/9IgvOJZE5n9bZ/L5IgYffmkDVt
	YCkvcnDZq9b0G4/3XNnA1R8iuEpItnXEeo/Ikp/n5VgqXenRjLXmnjZ4zmJKsZqk
	bhD2VKhJb9vqEMVxKpE+8Bh8qMmhiUFCAhqYmPeQCc2II=
Received: from [192.168.71.93] (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wBHsFiBXiNovmmgBA--.7222S2;
	Tue, 13 May 2025 23:00:18 +0800 (CST)
Message-ID: <3cf413ee-b70f-4bd1-8a43-3e64fdd5bff9@163.com>
Date: Tue, 13 May 2025 23:00:18 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] PCI: rockchip-host: Refactor IRQ handling with info
 arrays
To: =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
Cc: shawn.lin@rock-chips.com, lpieralisi@kernel.org, bhelgaas@google.com,
 heiko@sntech.de, manivannan.sadhasivam@linaro.org, robh@kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
References: <20250509155402.377923-1-18255117159@163.com>
 <20250509155402.377923-4-18255117159@163.com>
 <20250513104020.GC2003346@rocinante>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20250513104020.GC2003346@rocinante>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBHsFiBXiNovmmgBA--.7222S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Jw1rKr4fAw1DGr1fJFykAFb_yoWxJw4xpw
	48tFnrAr4UXr1xZ3sIyF98J3WrJrnI9aykCw15G3y7A3Wvvwn0gF1jvF9xGw1IgFWDXw4I
	9w47WFn7CF4UCFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UIiihUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWwRMo2gjWgSfUwAAsp



On 2025/5/13 18:40, Krzysztof Wilczyński wrote:
> Hello,
> 
> Thank you for the patch and the proposed changes.
> 
>> Replace repetitive if-conditions for IRQ status checks with structured
>> arrays (`pcie_subsys_irq_info` and `pcie_client_irq_info`) and loop-based
>> logging. This simplifies maintenance and reduces code duplication.
> [...]
>> +static const struct rockchip_irq_info pcie_subsys_irq_info[] = {
>> +	{ PCIE_CORE_INT_PRFPE,
>> +	  "parity error detected while reading from the PNP receive FIFO RAM" },
>> +	{ PCIE_CORE_INT_CRFPE,
>> +	  "parity error detected while reading from the Completion Receive FIFO RAM" },
>> +	{ PCIE_CORE_INT_RRPE,
>> +	  "parity error detected while reading from replay buffer RAM" },
>> +	{ PCIE_CORE_INT_PRFO, "overflow occurred in the PNP receive FIFO" },
>> +	{ PCIE_CORE_INT_CRFO,
>> +	  "overflow occurred in the completion receive FIFO" },
>> +	{ PCIE_CORE_INT_RT, "replay timer timed out" },
>> +	{ PCIE_CORE_INT_RTR,
>> +	  "replay timer rolled over after 4 transmissions of the same TLP" },
>> +	{ PCIE_CORE_INT_PE, "phy error detected on receive side" },
>> +	{ PCIE_CORE_INT_MTR, "malformed TLP received from the link" },
>> +	{ PCIE_CORE_INT_UCR, "Unexpected Completion received from the link" },
>> +	{ PCIE_CORE_INT_FCE,
>> +	  "an error was observed in the flow control advertisements from the other side" },
>> +	{ PCIE_CORE_INT_CT, "a request timed out waiting for completion" },
>> +	{ PCIE_CORE_INT_UTC, "unmapped TC error" },
>> +	{ PCIE_CORE_INT_MMVC, "MSI mask register changes" },
>> +};
>> +
>> +static const struct rockchip_irq_info pcie_client_irq_info[] = {
>> +	{ PCIE_CLIENT_INT_LEGACY_DONE, "legacy done" },
>> +	{ PCIE_CLIENT_INT_MSG, "message done" },
>> +	{ PCIE_CLIENT_INT_HOT_RST, "hot reset" },
>> +	{ PCIE_CLIENT_INT_DPA, "dpa" },
>> +	{ PCIE_CLIENT_INT_FATAL_ERR, "fatal error" },
>> +	{ PCIE_CLIENT_INT_NFATAL_ERR, "Non fatal error" },
>> +	{ PCIE_CLIENT_INT_CORR_ERR, "correctable error" },
>> +	{ PCIE_CLIENT_INT_PHY, "phy" },
>> +};
>> +
>>   static void rockchip_pcie_enable_bw_int(struct rockchip_pcie *rockchip)
>>   {
>>   	u32 status;
>> @@ -411,47 +450,11 @@ static irqreturn_t rockchip_pcie_subsys_irq_handler(int irq, void *arg)
>>   	if (reg & PCIE_CLIENT_INT_LOCAL) {
>>   		dev_dbg(dev, "local interrupt received\n");
>>   		sub_reg = rockchip_pcie_read(rockchip, PCIE_CORE_INT_STATUS);
>> -		if (sub_reg & PCIE_CORE_INT_PRFPE)
>> -			dev_dbg(dev, "parity error detected while reading from the PNP receive FIFO RAM\n");
>> -
>> -		if (sub_reg & PCIE_CORE_INT_CRFPE)
>> -			dev_dbg(dev, "parity error detected while reading from the Completion Receive FIFO RAM\n");
>> -
>> -		if (sub_reg & PCIE_CORE_INT_RRPE)
>> -			dev_dbg(dev, "parity error detected while reading from replay buffer RAM\n");
>> -
>> -		if (sub_reg & PCIE_CORE_INT_PRFO)
>> -			dev_dbg(dev, "overflow occurred in the PNP receive FIFO\n");
>> -
>> -		if (sub_reg & PCIE_CORE_INT_CRFO)
>> -			dev_dbg(dev, "overflow occurred in the completion receive FIFO\n");
>> -
>> -		if (sub_reg & PCIE_CORE_INT_RT)
>> -			dev_dbg(dev, "replay timer timed out\n");
>> -
>> -		if (sub_reg & PCIE_CORE_INT_RTR)
>> -			dev_dbg(dev, "replay timer rolled over after 4 transmissions of the same TLP\n");
>> -
>> -		if (sub_reg & PCIE_CORE_INT_PE)
>> -			dev_dbg(dev, "phy error detected on receive side\n");
>>   
>> -		if (sub_reg & PCIE_CORE_INT_MTR)
>> -			dev_dbg(dev, "malformed TLP received from the link\n");
>> -
>> -		if (sub_reg & PCIE_CORE_INT_UCR)
>> -			dev_dbg(dev, "Unexpected Completion received from the link\n");
>> -
>> -		if (sub_reg & PCIE_CORE_INT_FCE)
>> -			dev_dbg(dev, "an error was observed in the flow control advertisements from the other side\n");
>> -
>> -		if (sub_reg & PCIE_CORE_INT_CT)
>> -			dev_dbg(dev, "a request timed out waiting for completion\n");
>> -
>> -		if (sub_reg & PCIE_CORE_INT_UTC)
>> -			dev_dbg(dev, "unmapped TC error\n");
>> -
>> -		if (sub_reg & PCIE_CORE_INT_MMVC)
>> -			dev_dbg(dev, "MSI mask register changes\n");
>> +		for (int i = 0; i < ARRAY_SIZE(pcie_subsys_irq_info); i++) {
>> +			if (sub_reg & pcie_subsys_irq_info[i].bit)
>> +				dev_dbg(dev, "%s\n", pcie_subsys_irq_info[i].msg);
>> +		}
>>   
>>   		rockchip_pcie_write(rockchip, sub_reg, PCIE_CORE_INT_STATUS);
>>   	} else if (reg & PCIE_CLIENT_INT_PHY) {
>> @@ -473,29 +476,12 @@ static irqreturn_t rockchip_pcie_client_irq_handler(int irq, void *arg)
>>   	u32 reg;
>>   
>>   	reg = rockchip_pcie_read(rockchip, PCIE_CLIENT_INT_STATUS);
>> -	if (reg & PCIE_CLIENT_INT_LEGACY_DONE)
>> -		dev_dbg(dev, "legacy done interrupt received\n");
>> -
>> -	if (reg & PCIE_CLIENT_INT_MSG)
>> -		dev_dbg(dev, "message done interrupt received\n");
>>   
>> -	if (reg & PCIE_CLIENT_INT_HOT_RST)
>> -		dev_dbg(dev, "hot reset interrupt received\n");
>> -
>> -	if (reg & PCIE_CLIENT_INT_DPA)
>> -		dev_dbg(dev, "dpa interrupt received\n");
>> -
>> -	if (reg & PCIE_CLIENT_INT_FATAL_ERR)
>> -		dev_dbg(dev, "fatal error interrupt received\n");
>> -
>> -	if (reg & PCIE_CLIENT_INT_NFATAL_ERR)
>> -		dev_dbg(dev, "non fatal error interrupt received\n");
>> -
>> -	if (reg & PCIE_CLIENT_INT_CORR_ERR)
>> -		dev_dbg(dev, "correctable error interrupt received\n");
>> -
>> -	if (reg & PCIE_CLIENT_INT_PHY)
>> -		dev_dbg(dev, "phy interrupt received\n");
>> +	for (int i = 0; i < ARRAY_SIZE(pcie_client_irq_info); i++) {
>> +		if (reg & pcie_client_irq_info[i].bit)
>> +			dev_dbg(dev, "%s interrupt received\n",
>> +				pcie_client_irq_info[i].msg);
> 
> Why do you think that this is better?
> 
> Other patches in this series seem sensible, but this one does not stands
> out as something that needs to be changed.
> 

Dear Krzysztof

Thank you very much for your reply.

In the interrupt handling function: rockchip_pcie_subsys_irq_handler, 
personally, I think the amount of code can be simplified and it looks 
more concise.

There are many repetitive "interrupt received" print messages in the 
interrupt handling function: rockchip_pcie_client_irq_handler. My 
original intention was to simplify it.

If you think it's not necessary, I will drop this patch.

Best regards,
Hans


