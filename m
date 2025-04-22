Return-Path: <linux-pci+bounces-26388-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4ED0A96830
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 13:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78A2C3A50D8
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 11:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A8D27C166;
	Tue, 22 Apr 2025 11:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="cQhyIger"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6294221481B;
	Tue, 22 Apr 2025 11:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745322695; cv=none; b=dGziZkV9NstC47Yst2H0IgZUFWjqKNGxgnY1PuL2+hqnxTDToK+dkXNmSAIBz68gfzUr79Cuxp0nOi9t7JkLsa4PE9AHjyxtqt0LmHwAYU8XwN85EfEeisG9gRvxfO7ZJU68OBnKEeGEBq3GpXYqGDQ5WG5yqI90OHzrUJd8eAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745322695; c=relaxed/simple;
	bh=kH7Bu98CXyFDWfRtCbE6jVTFUkeXdMMl89atMiI6+EA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nnUGfcGykNK9Yl7rmGG3HGQRCKIwZSNxFB40Y4Za25lkOb2nyFz1dQEG6m8fkKdwSmPTpov3ysRqX/lwHa2cJHAkg/t/0nwkX0GPUf+IblJLX+5WXzXr6ysacaYY1FdoGUUQ3GbbmV0g4rQYAxxH9WkLyWipCwWXoVoDG9QubsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=cQhyIger; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=gcRt9ezSoUZXl+ybi8UTJwVtL/3rgcw0CTAfTjkR8vY=;
	b=cQhyIgerv2t2OKWa813hjNs6p7T9rVSVSVozFET0uogARuoQqizRWoSbEXtofZ
	8AdjWXAYVdgOJ2L7dCvNDJ/eodZDcvcfdznwcTF3ZdYHsIf8t0mwen7QwoaqJ5AU
	xUyMz+DnmwgZ5Lo3PmSHbJmQFCkGjdUCB5e0wE9VmBudo=
Received: from [192.168.142.52] (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgDnQ1Gaggdo6FbJAQ--.7526S2;
	Tue, 22 Apr 2025 19:50:52 +0800 (CST)
Message-ID: <7716b76f-be79-4ed1-b8d2-29258cb250ab@163.com>
Date: Tue, 22 Apr 2025 19:50:50 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] PCI: dw-rockchip: Unify link status checks with
 FIELD_GET
To: Niklas Cassel <cassel@kernel.org>
Cc: lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
 heiko@sntech.de, manivannan.sadhasivam@linaro.org, robh@kernel.org,
 jingoohan1@gmail.com, shawn.lin@rock-chips.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org
References: <20250422112830.204374-1-18255117159@163.com>
 <20250422112830.204374-4-18255117159@163.com> <aAeAAhb4R8ya_mBO@ryzen>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <aAeAAhb4R8ya_mBO@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:QCgvCgDnQ1Gaggdo6FbJAQ--.7526S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCrWUGr47GF4DAr4rJF43Jrb_yoW5trWxpa
	yDJFWqkF48GrWI9F1kCa98XFWFvFsI9ayUCrn7Ka4xWasFyr1DG3Wj9r9xtr1xAr47CFyS
	kw48ta47Xr43ZrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U33ktUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWwA3o2gHfn+KJwAAsM



On 2025/4/22 19:39, Niklas Cassel wrote:
> On Tue, Apr 22, 2025 at 07:28:30PM +0800, Hans Zhang wrote:
>> Link-up detection manually checked PCIE_LINKUP bits across RC/EP modes,
>> leading to code duplication. Centralize the logic using FIELD_GET. This
>> removes redundancy and abstracts hardware-specific bit masking, ensuring
>> consistent link state handling.
>>
>> Signed-off-by: Hans Zhang <18255117159@163.com>
>> ---
>>   drivers/pci/controller/dwc/pcie-dw-rockchip.c | 15 +++++----------
>>   1 file changed, 5 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
>> index cdc8afc6cfc1..2b26060af5c2 100644
>> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
>> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
>> @@ -196,10 +196,7 @@ static int rockchip_pcie_link_up(struct dw_pcie *pci)
>>   	struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
>>   	u32 val = rockchip_pcie_get_ltssm(rockchip);
>>   
>> -	if ((val & PCIE_LINKUP) == PCIE_LINKUP)
>> -		return 1;
>> -
>> -	return 0;
>> +	return FIELD_GET(PCIE_LINKUP_MASK, val) == 3;
> 
> While I like the idea of your patch, here you are replacing something that
> is easy to read (PCIE_LINKUP) with a magic value, which IMO is a step in
> the wrong direction.
> 

Hi Niklas,

Thank you very much for your reply. How about I add another macro 
definition?

#define PCIE_LINKUP 3


If not, I'll restore it. At least the following can use the 
rockchip_pcie_get_ltssm function to avoid duplicate code.

Best regards,
Hans

> 
>>   }
>>   
>>   static void rockchip_pcie_enable_l0s(struct dw_pcie *pci)
>> @@ -499,7 +496,7 @@ static irqreturn_t rockchip_pcie_rc_sys_irq_thread(int irq, void *arg)
>>   	struct dw_pcie *pci = &rockchip->pci;
>>   	struct dw_pcie_rp *pp = &pci->pp;
>>   	struct device *dev = pci->dev;
>> -	u32 reg, val;
>> +	u32 reg;
>>   
>>   	reg = rockchip_pcie_readl_apb(rockchip, PCIE_CLIENT_INTR_STATUS_MISC);
>>   	rockchip_pcie_writel_apb(rockchip, reg, PCIE_CLIENT_INTR_STATUS_MISC);
>> @@ -508,8 +505,7 @@ static irqreturn_t rockchip_pcie_rc_sys_irq_thread(int irq, void *arg)
>>   	dev_dbg(dev, "LTSSM_STATUS: %#x\n", rockchip_pcie_get_ltssm(rockchip));
>>   
>>   	if (reg & PCIE_RDLH_LINK_UP_CHGED) {
>> -		val = rockchip_pcie_get_ltssm(rockchip);
>> -		if ((val & PCIE_LINKUP) == PCIE_LINKUP) {
>> +		if (rockchip_pcie_link_up(pci)) {
>>   			dev_dbg(dev, "Received Link up event. Starting enumeration!\n");
>>   			/* Rescan the bus to enumerate endpoint devices */
>>   			pci_lock_rescan_remove();
>> @@ -526,7 +522,7 @@ static irqreturn_t rockchip_pcie_ep_sys_irq_thread(int irq, void *arg)
>>   	struct rockchip_pcie *rockchip = arg;
>>   	struct dw_pcie *pci = &rockchip->pci;
>>   	struct device *dev = pci->dev;
>> -	u32 reg, val;
>> +	u32 reg;
>>   
>>   	reg = rockchip_pcie_readl_apb(rockchip, PCIE_CLIENT_INTR_STATUS_MISC);
>>   	rockchip_pcie_writel_apb(rockchip, reg, PCIE_CLIENT_INTR_STATUS_MISC);
>> @@ -540,8 +536,7 @@ static irqreturn_t rockchip_pcie_ep_sys_irq_thread(int irq, void *arg)
>>   	}
>>   
>>   	if (reg & PCIE_RDLH_LINK_UP_CHGED) {
>> -		val = rockchip_pcie_get_ltssm(rockchip);
>> -		if ((val & PCIE_LINKUP) == PCIE_LINKUP) {
>> +		if (rockchip_pcie_link_up(pci)) {
>>   			dev_dbg(dev, "link up\n");
>>   			dw_pcie_ep_linkup(&pci->ep);
>>   		}
>> -- 
>> 2.25.1
>>


