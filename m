Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B46B16AC5B
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2020 17:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbgBXQ5U (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Feb 2020 11:57:20 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:6763 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727405AbgBXQ5U (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Feb 2020 11:57:20 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e5400620000>; Mon, 24 Feb 2020 08:57:06 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 24 Feb 2020 08:57:19 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 24 Feb 2020 08:57:19 -0800
Received: from [10.25.75.13] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 24 Feb
 2020 16:57:15 +0000
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
 <77748536-4f9a-1357-8180-91c1da2e912e@nvidia.com>
 <20200224143218.GC15614@e121166-lin.cambridge.arm.com>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <8ed75fb3-e5d8-7f7b-3c1b-4fd4d1de348d@nvidia.com>
Date:   Mon, 24 Feb 2020 22:27:12 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200224143218.GC15614@e121166-lin.cambridge.arm.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1582563426; bh=BwVm0kTdxw6SztrrqbyUEhatN7pPXBUcSggw5yxKlJc=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=p682gilM9Yg/5prBLRD8RMd/ZIVZWGzYSRsGYSYJ45ycnioqJzuax1N7FrzjCNpTV
         aPAQ2fEFcotpLbfrUgR8IC543uU7CK+ngO/ZatgCpbnWdjYi4DoXYbUNSri1XcatJQ
         ou14sX+ANVevM/QXL2TokvE0qkIAz/WXEF7ggSgY7MWzHQNugZ0egWkaYzppcY7Joi
         Vm7KPEEBRFA9HIO+kCOl6A2MTgXYaGnnrmdbv1gdkRNCpfSjzifSPts9orGZ95pbl3
         G3ka2GJovUMkj+PuCfk6o+/fYG8h5d37FvRc62U6IVPbglIzB5MDT+PmGO7itIIRwn
         OYk88FCFTxTcQ==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2/24/2020 8:02 PM, Lorenzo Pieralisi wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Mon, Feb 24, 2020 at 05:50:26PM +0530, Vidya Sagar wrote:
>>
>>
>> On 2/24/2020 5:02 PM, Lorenzo Pieralisi wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On Mon, Feb 17, 2020 at 05:40:35PM +0530, Vidya Sagar wrote:
>>>> Add a new API dw_pcie_ep_init_notify() to let platform drivers
>>>> call it when the core is available for initialization.
>>>>
>>>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>>>> Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
>>>> ---
>>>> V3:
>>>> * Added Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
>>>>
>>>> V2:
>>>> * None
>>>>
>>>>    drivers/pci/controller/dwc/pcie-designware-ep.c | 7 +++++++
>>>>    drivers/pci/controller/dwc/pcie-designware.h    | 5 +++++
>>>>    2 files changed, 12 insertions(+)
>>>>
>>>> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
>>>> index 84a102df9f62..dfbb806c25bf 100644
>>>> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
>>>> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
>>>> @@ -19,6 +19,13 @@ void dw_pcie_ep_linkup(struct dw_pcie_ep *ep)
>>>>         pci_epc_linkup(epc);
>>>>    }
>>>>
>>>> +void dw_pcie_ep_init_notify(struct dw_pcie_ep *ep)
>>>> +{
>>>> +     struct pci_epc *epc = ep->epc;
>>>> +
>>>> +     pci_epc_init_notify(epc);
>>>> +}
>>>
>>> Do we really need this wrapper ? I would drop this code and I would
>>> appreciate if you could post tegra changes benefiting from this
>>> series, at the moment I don't see any user of this newly added
>>> infrastructure.
>> I've posted that series also for review
>> @ http://patchwork.ozlabs.org/project/linux-pci/list/?series=152889
>> Sorry if I have to create explicit dependency by some means. I'm not
>> aware of that and would like to know if that exists. All that I did was
>> to mention this as a dependency for the other (Tegra change) series.
> 
> No worries - I just want to merge code that is actually used, I assume
> the series above should be reposted right ? You need an ACK from Thierry
> for it and we can merge the whole thing on top of Kishon's patches.
I'll get the Ack from Thierry.
BTW, my Tegra change series applies cleanly on top of this series. Do I 
still need to repost them?

> 
> I was just referring to the wrapper above, it does not seem very
> useful given that we can call pci_epc_init_notify() directly,
> please correct me if I am wrong, there does not seem to be anything
> DWC specific (at least for the time being) in the _notify() hook.
This is inline with other API dw_pcie_ep_linkup() for which this 
notification mechanism is used.

Thanks,
Vidya Sagar
> 
> Thanks,
> Lorenzo
> 
>>
>> Thanks,
>> Vidya Sagar
>>
>>>
>>> Thanks,
>>> Lorenzo
>>>
>>>>    static void __dw_pcie_ep_reset_bar(struct dw_pcie *pci, enum pci_barno bar,
>>>>                                    int flags)
>>>>    {
>>>> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
>>>> index b67b7f756bc2..aa98fbd50807 100644
>>>> --- a/drivers/pci/controller/dwc/pcie-designware.h
>>>> +++ b/drivers/pci/controller/dwc/pcie-designware.h
>>>> @@ -412,6 +412,7 @@ static inline int dw_pcie_allocate_domains(struct pcie_port *pp)
>>>>    void dw_pcie_ep_linkup(struct dw_pcie_ep *ep);
>>>>    int dw_pcie_ep_init(struct dw_pcie_ep *ep);
>>>>    int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep);
>>>> +void dw_pcie_ep_init_notify(struct dw_pcie_ep *ep);
>>>>    void dw_pcie_ep_exit(struct dw_pcie_ep *ep);
>>>>    int dw_pcie_ep_raise_legacy_irq(struct dw_pcie_ep *ep, u8 func_no);
>>>>    int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
>>>> @@ -434,6 +435,10 @@ static inline int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
>>>>         return 0;
>>>>    }
>>>>
>>>> +static inline void dw_pcie_ep_init_notify(struct dw_pcie_ep *ep)
>>>> +{
>>>> +}
>>>> +
>>>>    static inline void dw_pcie_ep_exit(struct dw_pcie_ep *ep)
>>>>    {
>>>>    }
>>>> --
>>>> 2.17.1
>>>>
