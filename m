Return-Path: <linux-pci+bounces-34142-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A701B293BF
	for <lists+linux-pci@lfdr.de>; Sun, 17 Aug 2025 17:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C1911B2273F
	for <lists+linux-pci@lfdr.de>; Sun, 17 Aug 2025 15:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07521B4233;
	Sun, 17 Aug 2025 15:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="RALJ+BR8"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E1915C15F;
	Sun, 17 Aug 2025 15:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755443339; cv=none; b=A4EkNKzoYS7kwMY/kmhhRxNUCFQUkXAAHI+OQlqFLWo/mwy95xrIeLVyb76tZ8FEkTqCvGGyfo0/tQ8gsRUIdg2mz3Bch+RfooRCzBkGpY+z8s3dTJvcV+IpoFOQscjAAQ/baO4uM/vfQpKG+jcLn5/3WrJn7PLB7n0HnlvbzRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755443339; c=relaxed/simple;
	bh=xFFNgygElDRMmZxg+Zqr+RegHwU+0tAmKY/7LULwtmE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OsYg05nbjW7DvE08kvKH2ABqdOKE0DaXYre4pJ1QEuMhvuzu94gVg2epMS+5JQK+BaScdEe/lmYdwAsMC3McZkR8P82Lb8wyhf1ehPOgEAPf88uP4Q2rcCAQ0wyEvaqGREQOOeKQGLmq8gFGny2XsW+r21upnAq10AAnjZagu5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=RALJ+BR8; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=Nh9VtSmIvZ6GYEv/OaxHwtfzdia7HWB/NNDWbUf/1ug=;
	b=RALJ+BR87H3/NAZQHDCTrE6qZA1RQx1+qp5Iz+ukwudl1zoVySZo3vhY+3dsUX
	TUt2Y7zENiLAlx7wTUsgjXeTCDIkZh+U1sTpLsY4CbdD7WxRHaWh2IL8AybsifS8
	0gdBjOlSN7pmyoPxUGgaiv/r5mtbI4mkuuAf2PDZ864Xc=
Received: from [IPV6:240e:b8f:919b:3100:3980:6173:5059:2d2a] (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wAH0F5B8KFokuwsCg--.33766S2;
	Sun, 17 Aug 2025 23:07:46 +0800 (CST)
Message-ID: <c965d655-8423-435b-ade7-6bd02e5989b0@163.com>
Date: Sun, 17 Aug 2025 23:07:44 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] PCI/AER: Use pci_clear_and_set_config_dword() to
 simplify mask updates
To: Lukas Wunner <lukas@wunner.de>
Cc: mahesh@linux.ibm.com, bhelgaas@google.com, oohall@gmail.com,
 mani@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250816161743.340684-1-18255117159@163.com>
 <aKDpIeQgt7I9Ts8F@wunner.de>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <aKDpIeQgt7I9Ts8F@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wAH0F5B8KFokuwsCg--.33766S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCw43ZrW3Xw48ZF45Ar4Utwb_yoWrJr4kpr
	Z8JF4rJrWUJF1YvrWDXaykArnYvr9rtFy8Kr93Gas5ZF4UuFZrJF9av347Jw1UKFZ5Xw4r
	Jw4rKan5Zr4UtaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UIeHgUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWxmso2ih7swDZwABsD



On 2025/8/17 04:25, Lukas Wunner wrote:
> On Sun, Aug 17, 2025 at 12:17:43AM +0800, Hans Zhang wrote:
>> Replace manual read-modify-write sequences in multiple functions with
>> pci_clear_and_set_config_dword() helper to reduce code duplication.
> 
> None of the occurrences you're replacing is clearing *and* setting
> bits at the same time.  They all either clear or set bits, but not both.
> 
> For the PCIe Capability, there are pcie_capability_clear_dword()
> and pcie_capability_set_dword() helpers.
> 
> It would arguably be clearer and less confusing to introduce similar
> pci_clear_config_dword() and pci_set_config_dword() helpers and use
> those, instead of using pci_clear_and_set_config_dword() and setting
> one argument to 0.
> 

Dear Lukas,

Thank you very much for your reply and suggestions.

In the next version, I will introduce two helper functions, 
pci_clear_config_dword() and pci_set_config_dword().

Best regards,
Hans


> Thanks,
> 
> Lukas
> 
>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>> index e286c197d716..3d37e2b7e412 100644
>> --- a/drivers/pci/pcie/aer.c
>> +++ b/drivers/pci/pcie/aer.c
>> @@ -176,14 +176,13 @@ static int enable_ecrc_checking(struct pci_dev *dev)
>>   static int disable_ecrc_checking(struct pci_dev *dev)
>>   {
>>   	int aer = dev->aer_cap;
>> -	u32 reg32;
>>   
>>   	if (!aer)
>>   		return -ENODEV;
>>   
>> -	pci_read_config_dword(dev, aer + PCI_ERR_CAP, &reg32);
>> -	reg32 &= ~(PCI_ERR_CAP_ECRC_GENE | PCI_ERR_CAP_ECRC_CHKE);
>> -	pci_write_config_dword(dev, aer + PCI_ERR_CAP, reg32);
>> +	pci_clear_and_set_config_dword(dev, aer + PCI_ERR_CAP,
>> +				       PCI_ERR_CAP_ECRC_GENE |
>> +				       PCI_ERR_CAP_ECRC_CHKE, 0);
>>   
>>   	return 0;
>>   }
>> @@ -1102,15 +1101,12 @@ static bool find_source_device(struct pci_dev *parent,
>>   static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
>>   {
>>   	int aer = dev->aer_cap;
>> -	u32 mask;
>>   
>> -	pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_MASK, &mask);
>> -	mask &= ~PCI_ERR_UNC_INTN;
>> -	pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_MASK, mask);
>> +	pci_clear_and_set_config_dword(dev, aer + PCI_ERR_UNCOR_MASK,
>> +				       PCI_ERR_UNC_INTN, 0);
>>   
>> -	pci_read_config_dword(dev, aer + PCI_ERR_COR_MASK, &mask);
>> -	mask &= ~PCI_ERR_COR_INTERNAL;
>> -	pci_write_config_dword(dev, aer + PCI_ERR_COR_MASK, mask);
>> +	pci_clear_and_set_config_dword(dev, aer + PCI_ERR_COR_MASK,
>> +				       PCI_ERR_COR_INTERNAL, 0);
>>   }
>>   
>>   static bool is_cxl_mem_dev(struct pci_dev *dev)
>> @@ -1556,23 +1552,19 @@ static irqreturn_t aer_irq(int irq, void *context)
>>   static void aer_enable_irq(struct pci_dev *pdev)
>>   {
>>   	int aer = pdev->aer_cap;
>> -	u32 reg32;
>>   
>>   	/* Enable Root Port's interrupt in response to error messages */
>> -	pci_read_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
>> -	reg32 |= ROOT_PORT_INTR_ON_MESG_MASK;
>> -	pci_write_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND, reg32);
>> +	pci_clear_and_set_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND,
>> +				       0, ROOT_PORT_INTR_ON_MESG_MASK);
>>   }
>>   
>>   static void aer_disable_irq(struct pci_dev *pdev)
>>   {
>>   	int aer = pdev->aer_cap;
>> -	u32 reg32;
>>   
>>   	/* Disable Root Port's interrupt in response to error messages */
>> -	pci_read_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
>> -	reg32 &= ~ROOT_PORT_INTR_ON_MESG_MASK;
>> -	pci_write_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND, reg32);
>> +	pci_clear_and_set_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND,
>> +				       ROOT_PORT_INTR_ON_MESG_MASK, 0);
>>   }
>>   
>>   /**


