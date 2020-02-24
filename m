Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D69E516A5FC
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2020 13:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbgBXMUf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Feb 2020 07:20:35 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:1262 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbgBXMUe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Feb 2020 07:20:34 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e53bf450000>; Mon, 24 Feb 2020 04:19:18 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 24 Feb 2020 04:20:33 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 24 Feb 2020 04:20:33 -0800
Received: from [10.24.47.202] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 24 Feb
 2020 12:20:29 +0000
Subject: Re: [PATCH V3 4/5] PCI: dwc: Add API to notify core initialization
 completion
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <andrew.murray@arm.com>, <bhelgaas@google.com>, <kishon@ti.com>,
        <thierry.reding@gmail.com>, <Jisheng.Zhang@synaptics.com>,
        <jonathanh@nvidia.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20200217121036.3057-1-vidyas@nvidia.com>
 <20200217121036.3057-5-vidyas@nvidia.com>
 <20200224113217.GA11120@e121166-lin.cambridge.arm.com>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <77748536-4f9a-1357-8180-91c1da2e912e@nvidia.com>
Date:   Mon, 24 Feb 2020 17:50:26 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200224113217.GA11120@e121166-lin.cambridge.arm.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1582546758; bh=yBaGSW1tBg/TBcMPrMVU3SdLiOlKXH9yWql7w5S0VZ0=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=F+KXVqLQfjPEj9ipmfMVbfvaXuVy8HnlqbSojs68TnUtUAwYqLtjhUVe00jBFuMPE
         +zVsseHf4zIjZOibRY+rSBBCbezsnYgL5/r8RKb4mP4ttL8EQ6I8DMVThfCzxcMBUd
         dwmdYARtalyO1s0aTKOz0fB5WiI160feH+JF3uHjJNeMxCE9j7t0AHyS1NC+YY51cP
         egF2FQA0PVEN8nqjZnP/JvKME9/ODY15Bft5JvJeI9g2sklHwV5QKw7FMTdliIib8p
         U6eKyy1si+vG5zRx+VsuAaaPogZM47E8q7IDlLNST3GAAovGGPjJNIZI4FLLminUar
         NSVPJuo7AqpmA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2/24/2020 5:02 PM, Lorenzo Pieralisi wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Mon, Feb 17, 2020 at 05:40:35PM +0530, Vidya Sagar wrote:
>> Add a new API dw_pcie_ep_init_notify() to let platform drivers
>> call it when the core is available for initialization.
>>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>> V3:
>> * Added Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
>>
>> V2:
>> * None
>>
>>   drivers/pci/controller/dwc/pcie-designware-ep.c | 7 +++++++
>>   drivers/pci/controller/dwc/pcie-designware.h    | 5 +++++
>>   2 files changed, 12 insertions(+)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
>> index 84a102df9f62..dfbb806c25bf 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
>> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
>> @@ -19,6 +19,13 @@ void dw_pcie_ep_linkup(struct dw_pcie_ep *ep)
>>        pci_epc_linkup(epc);
>>   }
>>
>> +void dw_pcie_ep_init_notify(struct dw_pcie_ep *ep)
>> +{
>> +     struct pci_epc *epc = ep->epc;
>> +
>> +     pci_epc_init_notify(epc);
>> +}
> 
> Do we really need this wrapper ? I would drop this code and I would
> appreciate if you could post tegra changes benefiting from this
> series, at the moment I don't see any user of this newly added
> infrastructure.
I've posted that series also for review
@ http://patchwork.ozlabs.org/project/linux-pci/list/?series=152889
Sorry if I have to create explicit dependency by some means. I'm not
aware of that and would like to know if that exists. All that I did was 
to mention this as a dependency for the other (Tegra change) series.

Thanks,
Vidya Sagar

> 
> Thanks,
> Lorenzo
> 
>>   static void __dw_pcie_ep_reset_bar(struct dw_pcie *pci, enum pci_barno bar,
>>                                   int flags)
>>   {
>> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
>> index b67b7f756bc2..aa98fbd50807 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware.h
>> +++ b/drivers/pci/controller/dwc/pcie-designware.h
>> @@ -412,6 +412,7 @@ static inline int dw_pcie_allocate_domains(struct pcie_port *pp)
>>   void dw_pcie_ep_linkup(struct dw_pcie_ep *ep);
>>   int dw_pcie_ep_init(struct dw_pcie_ep *ep);
>>   int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep);
>> +void dw_pcie_ep_init_notify(struct dw_pcie_ep *ep);
>>   void dw_pcie_ep_exit(struct dw_pcie_ep *ep);
>>   int dw_pcie_ep_raise_legacy_irq(struct dw_pcie_ep *ep, u8 func_no);
>>   int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
>> @@ -434,6 +435,10 @@ static inline int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
>>        return 0;
>>   }
>>
>> +static inline void dw_pcie_ep_init_notify(struct dw_pcie_ep *ep)
>> +{
>> +}
>> +
>>   static inline void dw_pcie_ep_exit(struct dw_pcie_ep *ep)
>>   {
>>   }
>> --
>> 2.17.1
>>
