Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB4A447A83
	for <lists+linux-pci@lfdr.de>; Mon,  8 Nov 2021 07:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbhKHGkU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Nov 2021 01:40:20 -0500
Received: from smtp05.smtpout.orange.fr ([80.12.242.127]:64329 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236305AbhKHGkR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Nov 2021 01:40:17 -0500
Received: from [192.168.1.18] ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id jyHZmF8HponYgjyHZmBySq; Mon, 08 Nov 2021 07:37:32 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Mon, 08 Nov 2021 07:37:32 +0100
X-ME-IP: 86.243.171.122
Subject: Re: [PATCH] PCI: xilinx-nwl: Simplify code and fix a memory leak
To:     =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>
Cc:     lorenzo.pieralisi@arm.com, robh@kernel.org, bhelgaas@google.com,
        michal.simek@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <5483f10a44b06aad55728576d489adfa16c3be91.1636279388.git.christophe.jaillet@wanadoo.fr>
 <YYhv9vZCw5r+PKzj@rocinante>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <4d0576fb-0232-b165-bdef-e8a4310c6d29@wanadoo.fr>
Date:   Mon, 8 Nov 2021 07:37:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YYhv9vZCw5r+PKzj@rocinante>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Le 08/11/2021 à 01:31, Krzysztof Wilczyński a écrit :
> Hi Christophe,
> 
>> Allocate space for 'bitmap' in 'struct nwl_msi' at build time instead of
>> dynamically allocating the memory at runtime.
>>
>> This simplifies code (especially error handling paths) and avoid some
>> open-coded arithmetic in allocator arguments
>>
>> This also fixes a potential memory leak. The bitmap was never freed. It is
>> now part of a managed resource.
> 
> Just to confirm - you mean potentially leaking when the driver would be
> unloaded?  Not the error handling path, correct?

Correct, the leak would happen on driver unload only.

CJ

> 
>> --- a/drivers/pci/controller/pcie-xilinx-nwl.c
>> +++ b/drivers/pci/controller/pcie-xilinx-nwl.c
>> @@ -146,7 +146,7 @@
>>   
>>   struct nwl_msi {			/* MSI information */
>>   	struct irq_domain *msi_domain;
>> -	unsigned long *bitmap;
>> +	DECLARE_BITMAP(bitmap, INT_PCI_MSI_NR);
>>   	struct irq_domain *dev_domain;
>>   	struct mutex lock;		/* protect bitmap variable */
>>   	int irq_msi0;
>> @@ -335,12 +335,10 @@ static void nwl_pcie_leg_handler(struct irq_desc *desc)
>>   
>>   static void nwl_pcie_handle_msi_irq(struct nwl_pcie *pcie, u32 status_reg)
>>   {
>> -	struct nwl_msi *msi;
>> +	struct nwl_msi *msi = &pcie->msi;
>>   	unsigned long status;
>>   	u32 bit;
>>   
>> -	msi = &pcie->msi;
>> -
>>   	while ((status = nwl_bridge_readl(pcie, status_reg)) != 0) {
>>   		for_each_set_bit(bit, &status, 32) {
>>   			nwl_bridge_writel(pcie, 1 << bit, status_reg);
>> @@ -560,30 +558,21 @@ static int nwl_pcie_enable_msi(struct nwl_pcie *pcie)
>>   	struct nwl_msi *msi = &pcie->msi;
>>   	unsigned long base;
>>   	int ret;
>> -	int size = BITS_TO_LONGS(INT_PCI_MSI_NR) * sizeof(long);
>>   
>>   	mutex_init(&msi->lock);
>>   
>> -	msi->bitmap = kzalloc(size, GFP_KERNEL);
>> -	if (!msi->bitmap)
>> -		return -ENOMEM;
>> -
>>   	/* Get msi_1 IRQ number */
>>   	msi->irq_msi1 = platform_get_irq_byname(pdev, "msi1");
>> -	if (msi->irq_msi1 < 0) {
>> -		ret = -EINVAL;
>> -		goto err;
>> -	}
>> +	if (msi->irq_msi1 < 0)
>> +		return -EINVAL;
>>   
>>   	irq_set_chained_handler_and_data(msi->irq_msi1,
>>   					 nwl_pcie_msi_handler_high, pcie);
>>   
>>   	/* Get msi_0 IRQ number */
>>   	msi->irq_msi0 = platform_get_irq_byname(pdev, "msi0");
>> -	if (msi->irq_msi0 < 0) {
>> -		ret = -EINVAL;
>> -		goto err;
>> -	}
>> +	if (msi->irq_msi0 < 0)
>> +		return -EINVAL;
>>   
>>   	irq_set_chained_handler_and_data(msi->irq_msi0,
>>   					 nwl_pcie_msi_handler_low, pcie);
>> @@ -592,8 +581,7 @@ static int nwl_pcie_enable_msi(struct nwl_pcie *pcie)
>>   	ret = nwl_bridge_readl(pcie, I_MSII_CAPABILITIES) & MSII_PRESENT;
>>   	if (!ret) {
>>   		dev_err(dev, "MSI not present\n");
>> -		ret = -EIO;
>> -		goto err;
>> +		return -EIO;
>>   	}
>>   
>>   	/* Enable MSII */
>> @@ -632,10 +620,6 @@ static int nwl_pcie_enable_msi(struct nwl_pcie *pcie)
>>   	nwl_bridge_writel(pcie, MSGF_MSI_SR_LO_MASK, MSGF_MSI_MASK_LO);
>>   
>>   	return 0;
>> -err:
>> -	kfree(msi->bitmap);
>> -	msi->bitmap = NULL;
>> -	return ret;
> 
> Thank you!
> 
> Reviewed-by: Krzysztof Wilczyński <kw@linux.com>
> 
> 	Krzysztof
> 

