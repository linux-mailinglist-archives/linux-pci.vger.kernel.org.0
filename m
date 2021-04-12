Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 970E735C1FA
	for <lists+linux-pci@lfdr.de>; Mon, 12 Apr 2021 11:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240385AbhDLJhR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Apr 2021 05:37:17 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:16571 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240370AbhDLJdB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Apr 2021 05:33:01 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FJk3z6xxCz1BGgr;
        Mon, 12 Apr 2021 17:30:23 +0800 (CST)
Received: from [127.0.0.1] (10.69.38.196) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.498.0; Mon, 12 Apr 2021
 17:32:32 +0800
Subject: Re: [PATCH] PCI/DPC: Disable ERR_COR explicitly for native dpc
 service
To:     Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>
CC:     <linux-pci@vger.kernel.org>,
        <sathyanarayanan.kuppuswamy@linux.intel.com>, <kbusch@kernel.org>,
        <sean.v.kelley@intel.com>, <qiuxu.zhuo@intel.com>,
        <prime.zeng@huawei.com>, <linuxarm@openeuler.org>
References: <1612356795-32505-2-git-send-email-yangyicong@hisilicon.com>
 <20210410152103.GA2043340@bjorn-Precision-5520>
 <20210410191749.GA16240@wunner.de>
From:   Yicong Yang <yangyicong@hisilicon.com>
Message-ID: <0c3faac2-6b22-ab04-a145-99c29dd240e2@hisilicon.com>
Date:   Mon, 12 Apr 2021 17:32:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20210410191749.GA16240@wunner.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.38.196]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021/4/11 3:17, Lukas Wunner wrote:
> On Sat, Apr 10, 2021 at 10:21:03AM -0500, Bjorn Helgaas wrote:
>> Anybody want to chime in and review this?  Sometimes I feel like a
>> one-man band :)
> 
> Can't say anything about the object of the patch, but style-wise
> this looks cryptic:
> 
>>> --- a/drivers/pci/pcie/dpc.c
>>> +++ b/drivers/pci/pcie/dpc.c
>>> @@ -302,7 +302,7 @@ static int dpc_probe(struct pcie_device *dev)
>>>  	pci_read_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, &ctl);
>>>  
>>> -	ctl = (ctl & 0xfff4) | PCI_EXP_DPC_CTL_EN_FATAL | PCI_EXP_DPC_CTL_INT_EN;
>>> +	ctl = (ctl & 0xffe4) | PCI_EXP_DPC_CTL_EN_FATAL | PCI_EXP_DPC_CTL_INT_EN;
>>>  	pci_write_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, ctl);
> 
> Instead of writing "ctl & 0xfff4", I'd prefer defining macros for the
> register bits of interest, then use "ctl &= ~(u16)(bits to clear)"
> and in a separate line use "ctl |= (bits to set)".
> 

yes. that's clearer. I'll use macros if we're going to have this patch.

> Obviously, clearing bits that are unconditionally set afterwards is
> unnecessary (as is done here).
> 

ok. I found this when I read the Spec and thought it might be sanity
to ensure the bit is not set.

> 
>>>  	pci_info(pdev, "enabled with IRQ %d\n", dev->irq);
> 
> This looks superfluous since the IRQ can be found out in /proc/interrupts.

this can help us track dpc interrupts on certain ports through /proc/interrupts,
as all the dpc interrupts are named 'pcie-dpc' and its hard to distinguish.

Thanks,
Yicong

> 
> Thanks,
> 
> Lukas
> 
> .
> 

