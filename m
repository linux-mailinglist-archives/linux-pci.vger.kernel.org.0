Return-Path: <linux-pci+bounces-29750-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16330AD91B0
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 17:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DF8B1890013
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 15:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED39E19D08F;
	Fri, 13 Jun 2025 15:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="lS3LqaYl"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA493FE7;
	Fri, 13 Jun 2025 15:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749829325; cv=none; b=V/85rZHcYloCSJ/vpuPgtN7JH3rqOJUyh1zDSAO8lAauhfhZy5DyE6kCZmQv0ufSC0pPqtGoLmmoXcgLjdgSy2ZdFpGL7VCZUDVeR0+N0Gs0DZBdmqz4V3sxDAAcEhZZxGJ6Rlb2x+d9CJaU1gbnmSyfZ7+syU+iGUkBISsUqHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749829325; c=relaxed/simple;
	bh=CcMeN1ClBQJ17hvOxUPI/rw5Y2cGPHGJq4NyBmQQxXo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GhMu8NwgiVr/XK7Wk95Ax3BhgqwNZkWequ3NBRKvLE1VsjAdzoiCvOR0Fn92KHqEK5xKRFqW+Bof5iNKlm3if+mEzcEKzZx/VkqgBUykTq3OzJDuJs9POdvyZ6GhBDqBXkeWJXRyaVpFOIwWPZblzjvCdwdJSM7Bkmeyotw2R0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=lS3LqaYl; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=2M/eCXY1ToDvTm9hwkGDq/8LUzWrm55Tahx+FO3/MkM=;
	b=lS3LqaYlJDzuE5fir8AzvoACaNs2VvSrzFWYdhJauogGyv7h0960NeLFzcFewe
	s+kbgv00uhKvD4vmYfQu3NemlkNUI/EYKTGH1EzVTq8U0dLSHOgUFu/kcYBd64m5
	/RM5+8n2FFAW0ysoNM1tOLE9n0ePrEbHzigmWrEY4hOVo=
Received: from [192.168.71.94] (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wBnkHB4RkxorB7fHw--.15462S2;
	Fri, 13 Jun 2025 23:40:41 +0800 (CST)
Message-ID: <a88ccb03-3039-4955-a6cc-18774c6799f6@163.com>
Date: Fri, 13 Jun 2025 23:40:40 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] PCI: dwc: Remove redundant MPS configuration
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
 heiko@sntech.de, manivannan.sadhasivam@linaro.org, yue.wang@amlogic.com,
 pali@kernel.org, neil.armstrong@linaro.org, robh@kernel.org,
 jingoohan1@gmail.com, khilman@baylibre.com, jbrunet@baylibre.com,
 martin.blumenstingl@googlemail.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-rockchip@lists.infradead.org,
 yue.wang@amlogic.com, hanjie.lin@amlogic.com
References: <20250510155607.390687-1-18255117159@163.com>
 <20250510155607.390687-3-18255117159@163.com>
 <6v7m7qt4n26n6pmx5tggmmvv7na6t5v5wtfqev5x4wxosymwul@j3dizxyyy4tg>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <6v7m7qt4n26n6pmx5tggmmvv7na6t5v5wtfqev5x4wxosymwul@j3dizxyyy4tg>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wBnkHB4RkxorB7fHw--.15462S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWF4UZFWrurWxWFy8Zr1UJrb_yoW5Zw15pF
	W5XFs3CF4rJr4rZanFka1rAa42yas8AFyUJF9rG34fZF9IyFsrGFy2yFWF9FyxZrZ2gF1S
	v34Ygr43Z3Z8JFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uq9a9UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiQxdro2hMQiMsKAACsf



On 2025/6/13 14:54, Manivannan Sadhasivam wrote:
> On Sat, May 10, 2025 at 11:56:07PM +0800, Hans Zhang wrote:
>> The Meson PCIe controller driver manually configures maximum payload
>> size (MPS) through meson_set_max_payload, duplicating functionality now
>> centralized in the PCI core.  Deprecating redundant code simplifies the
>> driver and aligns it with the consolidated MPS management strategy,
>> improving long-term maintainability.
>>
>> Signed-off-by: Hans Zhang <18255117159@163.com>
> 
> I believe that the root port MPS set by PCI core in patch 1 should be enough to
> remove the logic in the driver. But given that we already saw that is not the
> case with Armada controllers, it would be good if one of the Meson maintainers
> could verify if this series works as intented. Since the driver is not using the
> DEVCAP value, but using the hardcoded value, I'm slightly worried that setting
> MPS value other than 256 would have any downside.
> 
> But anyway, the root port MPS should be the same with and without this series.
> This can be verified by:
> 
> sudo lspci -vvv | grep MaxPayload
> 
> Also, performing any benchmark and making sure that the device performance
> didn't get affected would be great.
> 

Dear Mani,

Thank you for your reminder. I found two friends of Amlogic from the 
submission records and copied the email to them. And ask them to help 
test these two patches.

But I don't know if they are still employed, or do you know anyone to 
help with the test?





Dear yue.wang and hanjie.lin,

Could you help test these two patches? I don't know if it affects the 
normal function of your Root Port. If it works properly, please let me 
know. Thank you very much.

Best regards,
Hans



> - Mani
> 
>> ---
>>   drivers/pci/controller/dwc/pci-meson.c | 17 -----------------
>>   1 file changed, 17 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
>> index db9482a113e9..126f38ed453d 100644
>> --- a/drivers/pci/controller/dwc/pci-meson.c
>> +++ b/drivers/pci/controller/dwc/pci-meson.c
>> @@ -261,22 +261,6 @@ static int meson_size_to_payload(struct meson_pcie *mp, int size)
>>   	return fls(size) - 8;
>>   }
>>   
>> -static void meson_set_max_payload(struct meson_pcie *mp, int size)
>> -{
>> -	struct dw_pcie *pci = &mp->pci;
>> -	u32 val;
>> -	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
>> -	int max_payload_size = meson_size_to_payload(mp, size);
>> -
>> -	val = dw_pcie_readl_dbi(pci, offset + PCI_EXP_DEVCTL);
>> -	val &= ~PCI_EXP_DEVCTL_PAYLOAD;
>> -	dw_pcie_writel_dbi(pci, offset + PCI_EXP_DEVCTL, val);
>> -
>> -	val = dw_pcie_readl_dbi(pci, offset + PCI_EXP_DEVCTL);
>> -	val |= PCIE_CAP_MAX_PAYLOAD_SIZE(max_payload_size);
>> -	dw_pcie_writel_dbi(pci, offset + PCI_EXP_DEVCTL, val);
>> -}
>> -
>>   static void meson_set_max_rd_req_size(struct meson_pcie *mp, int size)
>>   {
>>   	struct dw_pcie *pci = &mp->pci;
>> @@ -381,7 +365,6 @@ static int meson_pcie_host_init(struct dw_pcie_rp *pp)
>>   
>>   	pp->bridge->ops = &meson_pci_ops;
>>   
>> -	meson_set_max_payload(mp, MAX_PAYLOAD_SIZE);
>>   	meson_set_max_rd_req_size(mp, MAX_READ_REQ_SIZE);
>>   
>>   	return 0;
>> -- 
>> 2.25.1
>>
> 


