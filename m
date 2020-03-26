Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECE8194331
	for <lists+linux-pci@lfdr.de>; Thu, 26 Mar 2020 16:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbgCZP24 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Mar 2020 11:28:56 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:51626 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728479AbgCZP2z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Mar 2020 11:28:55 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02QFSpZ1077498;
        Thu, 26 Mar 2020 10:28:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1585236531;
        bh=KaXzgZRMHuOhjbAAQamjPiN1/h7tkGtzd9HYl/NPv84=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=WzKBzPq5BIEMcPIl/sz2eDp+dindhIqLnLHFWicvE1dmeemDrpgdT7Jwi3iekYw39
         ccaMXwFDAKMoM0YgfhVBcVhVXgrsjH7AP9W+rKehkOufft37xcf8iHsZJPmwK5EfXy
         Q/IZNkHIEGsbTlbW+UWk+ZdK3Fi+LxRjSmY4DBl0=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 02QFSpDK009076
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 26 Mar 2020 10:28:51 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 26
 Mar 2020 10:28:50 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 26 Mar 2020 10:28:50 -0500
Received: from [10.250.132.187] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02QFSkbQ096295;
        Thu, 26 Mar 2020 10:28:47 -0500
Subject: Re: [PATCH] PCI: dwc: pci-dra7xx: Fix MSI IRQ handling
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200124163650.4457-1-vigneshr@ti.com>
 <20200324150520.GA1174@e121166-lin.cambridge.arm.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <42024104-deb0-42e1-5e77-6ca7df822963@ti.com>
Date:   Thu, 26 Mar 2020 20:58:46 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200324150520.GA1174@e121166-lin.cambridge.arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 24/03/20 8:35 pm, Lorenzo Pieralisi wrote:
[...]
>> -static irqreturn_t dra7xx_pcie_msi_irq_handler(int irq, void *arg)
>> +static void dra7xx_pcie_msi_irq_handler(struct irq_desc *desc)
>>  {
>> -	struct dra7xx_pcie *dra7xx = arg;
>> -	struct dw_pcie *pci = dra7xx->pci;
>> -	struct pcie_port *pp = &pci->pp;
>> +	struct irq_chip *chip = irq_desc_get_chip(desc);
>> +	struct dra7xx_pcie *dra7xx;
>> +	struct dw_pcie *pci;
>> +	struct pcie_port *pp;
>>  	unsigned long reg;
>>  	u32 virq, bit;
>> +	int count = 0;
>> +
>> +	chained_irq_enter(chip, desc);
>> +
>> +	pp = irq_desc_get_handler_data(desc);
>> +	pci = to_dw_pcie_from_pp(pp);
>> +	dra7xx = to_dra7xx_pcie(pci);
>>  
>>  	reg = dra7xx_pcie_readl(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MSI);
>> +	dra7xx_pcie_writel(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MSI, reg);
>>  
>>  	switch (reg) {
>>  	case MSI:
>> -		dw_handle_msi_irq(pp);
>> +		/**
>> +		 * Need to make sure all MSI status bits read 0 before
>> +		 * exiting. Else, new MSI IRQs are not registered by the
>> +		 * wrapper. Have an upperbound for the loop and exit the
>> +		 * IRQ in case of IRQ flood to avoid locking up system
>> +		 * in interrupt context.
>> +		 */
>> +		while (dra7xx_pcie_handle_msi_irq(pp) && count < 1000)
>> +			count++;
> 
> Apologies for the delay in replying.
> 
> Do you really need to call the function in a loop ? Can't the loop
> be written inside the function ? It is not going to be any nicer
> but I think it would make code easier to follow. Also, don't know
> if you want to print a warning to signal a count overrun.
> 
> I don't like this code at all but at least it is self-contained
> so we may get it in this cycle.
> 

I have posted v3 with loop moved inside dra7xx_pcie_handle_msi_irq() and
also added dev_warn on overrun. Thanks!

Regard
Vignesh

[...]

