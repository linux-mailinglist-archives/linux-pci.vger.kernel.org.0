Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB20418C6B5
	for <lists+linux-pci@lfdr.de>; Fri, 20 Mar 2020 06:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbgCTFPg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Mar 2020 01:15:36 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:7305 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgCTFPg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Mar 2020 01:15:36 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e74516a0000>; Thu, 19 Mar 2020 22:15:22 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 19 Mar 2020 22:15:35 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 19 Mar 2020 22:15:35 -0700
Received: from [10.25.97.155] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 20 Mar
 2020 05:15:32 +0000
Subject: Re: [PATCH -next] PCI: dwc: fix compile err for pcie-tagra194
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Qiujun Huang <hqjagain@gmail.com>, <anders.roxell@linaro.org>
CC:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <amurray@thegoodpenguin.co.uk>, <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1584621380-21152-1-git-send-email-hqjagain@gmail.com>
 <20200319173710.GA7433@e121166-lin.cambridge.arm.com>
From:   Vidya Sagar <vidyas@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <e16eb1a7-6ada-a8ed-c308-6fc5c9a8b7be@nvidia.com>
Date:   Fri, 20 Mar 2020 10:45:29 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200319173710.GA7433@e121166-lin.cambridge.arm.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1584681322; bh=5cDnCRVr/SQ+yk+RPLat6q5cSmCpBVeJdv46ovb/TLA=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=L3FmoXlOLZBJDmfUoTpBdPgvdunMUXY0nysEiquE9EG4KKGiN6M0FQy4HZr/4+iGq
         lYU7NsF7sarzjjH0C67tIepd2evlFb0HApy9iGvodOvFmW4iWX7zBWDirNHArKQMmf
         YBeyJRnf4K8guy3MO3pVIiELn6umNXzspDxubf6sY5jbHO9m+CVOogvqABOMHEifkK
         blqvFgjOqGqry/0nMgioizgsvjaBXRfUiZjjov1HEvBzlNjkuret1lVSkVo+3SiTwG
         CGYLQeg/NPi2TPw6/Nqv6p+IwudYEIqEGwulJaFSWkvR3Na/LjdLVLqnRetJcb2h/9
         8GAJ/F0LVZ6pw==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 3/19/2020 11:07 PM, Lorenzo Pieralisi wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Thu, Mar 19, 2020 at 08:36:20PM +0800, Qiujun Huang wrote:
>> make allmodconfig
>> ERROR: modpost: "dw_pcie_ep_init_notify" [drivers/pci/controller/dwc/pcie-tegra194.ko] undefined!
>> ERROR: modpost: "dw_pcie_ep_init_complete" [drivers/pci/controller/dwc/pcie-tegra194.ko] undefined!
>> ERROR: modpost: "dw_pcie_ep_linkup" [drivers/pci/controller/dwc/pcie-tegra194.ko] undefined!
>> make[2]: *** [__modpost] Error 1
>> make[1]: *** [modules] Error 2
>> make: *** [sub-make] Error 2
>>
>> need to export the symbols.
>>
>> Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
>> ---
>>   drivers/pci/controller/dwc/pcie-designware-ep.c | 3 +++
>>   1 file changed, 3 insertions(+)
> 
> I have squashed this in with the original patch.
> 
> @Vidya: is this something we missed in the review cycle ? Asking just
> to make sure it was not me who made a mistake while merging the code.
My apologies. I wasn't compiling the driver as a module (instead built 
into the kernel image)
BTW, I see
ERROR: modpost: "dw_pcie_ep_init" 
[drivers/pci/controller/dwc/pcie-tegra194.ko] undefined!
also along with the above three. So I think even dw_pcie_ep_init() needs 
to be exported.

Thanks,
Vidya Sagar
> 
> Thanks,
> Lorenzo
> 
>> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
>> index 4233c43..60d62ef 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
>> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
>> @@ -18,6 +18,7 @@ void dw_pcie_ep_linkup(struct dw_pcie_ep *ep)
>>
>>        pci_epc_linkup(epc);
>>   }
>> +EXPORT_SYMBOL_GPL(dw_pcie_ep_linkup);
>>
>>   void dw_pcie_ep_init_notify(struct dw_pcie_ep *ep)
>>   {
>> @@ -25,6 +26,7 @@ void dw_pcie_ep_init_notify(struct dw_pcie_ep *ep)
>>
>>        pci_epc_init_notify(epc);
>>   }
>> +EXPORT_SYMBOL_GPL(dw_pcie_ep_init_notify);
>>
>>   static void __dw_pcie_ep_reset_bar(struct dw_pcie *pci, enum pci_barno bar,
>>                                   int flags)
>> @@ -535,6 +537,7 @@ int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
>>
>>        return 0;
>>   }
>> +EXPORT_SYMBOL_GPL(dw_pcie_ep_init_complete);
>>
>>   int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>>   {
>> --
>> 1.8.3.1
>>
