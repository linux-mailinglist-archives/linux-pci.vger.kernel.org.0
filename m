Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9A0120C0
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2019 19:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbfEBRCc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 May 2019 13:02:32 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:8596 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfEBRCb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 May 2019 13:02:31 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ccb22ad0000>; Thu, 02 May 2019 10:02:37 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 02 May 2019 10:02:30 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 02 May 2019 10:02:30 -0700
Received: from [10.25.72.23] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 2 May
 2019 17:02:27 +0000
Subject: Re: [PATCH V2 1/2] PCI: dwc: Add API support to de-initialize host
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <bhelgaas@google.com>, <Jisheng.Zhang@synaptics.com>,
        <thierry.reding@gmail.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20190416141516.23908-1-vidyas@nvidia.com>
 <20190416141516.23908-2-vidyas@nvidia.com>
 <20190502145830.GB19656@e121166-lin.cambridge.arm.com>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <3ff0649d-88ac-826f-cf24-55445fa5bb52@nvidia.com>
Date:   Thu, 2 May 2019 22:32:24 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190502145830.GB19656@e121166-lin.cambridge.arm.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1556816557; bh=0/5+jmjKCtlCL92YtuR6fnAUJacAoSreq+W8K+cxOVU=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=R1AxrEv3sHl9V+/rpJSjVnWg/bqc8eFHQ+MYE0gZRdxf1uUBis0ayurqdCs/b39Yy
         Z6WKWTWfV/yntaS0F/nNBoQIiCIwhIGb0gAVCfn9/80/CK0CHD3qdWDc4My0qw9Fpc
         bgFEeDFP/RJPjm0EDR02gMfcsX9r4nXGPrbs+CDUINPP7bv0fiiu/48+gVXX9ubpUJ
         EZlxpW0klifWfj1RzOuD4pQyqsNAlhyjzfmLbYh8/zfwyCCP34S4UzAg9nYKy9nCp8
         q8xVYAgcOnnnk32Q7pdunwK/SVSUmEEWO1aec1qx7/7Ss+uG+ECQ8tQsxqIcGSGQaR
         sju/EgfAGuSSg==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 5/2/2019 8:28 PM, Lorenzo Pieralisi wrote:
> On Tue, Apr 16, 2019 at 07:45:15PM +0530, Vidya Sagar wrote:
>> Add an API to group all the tasks to be done to de-initialize host which
>> can then be called by any DesignWare core based driver implementations
>> while adding .remove() support in their respective drivers.
>>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
>> ---
>> v2:
>> * s/Designware/DesignWare
>>
>>   drivers/pci/controller/dwc/pcie-designware-host.c | 7 +++++++
>>   drivers/pci/controller/dwc/pcie-designware.h      | 5 +++++
>>   2 files changed, 12 insertions(+)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
>> index 3e4169e738a5..d7881490282d 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
>> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
>> @@ -516,6 +516,13 @@ int dw_pcie_host_init(struct pcie_port *pp)
>>   	return ret;
>>   }
>>   
>> +void dw_pcie_host_deinit(struct pcie_port *pp)
>> +{
>> +	pci_stop_root_bus(pp->root_bus);
>> +	pci_remove_root_bus(pp->root_bus);
>> +	dw_pcie_free_msi(pp);
> 
> This must mirror the init path, so AFAICS it should not be done
> if pp->ops->msi_host_init != NULL
Done.
I'll add check "if (pci_msi_enabled() && !pp->ops->msi_host_init)"

> 
> Lorenzo
> 
>> +}
>> +
>>   static int dw_pcie_access_other_conf(struct pcie_port *pp, struct pci_bus *bus,
>>   				     u32 devfn, int where, int size, u32 *val,
>>   				     bool write)
>> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
>> index adff0c713665..ea8d1caf11c5 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware.h
>> +++ b/drivers/pci/controller/dwc/pcie-designware.h
>> @@ -343,6 +343,7 @@ void dw_pcie_msi_init(struct pcie_port *pp);
>>   void dw_pcie_free_msi(struct pcie_port *pp);
>>   void dw_pcie_setup_rc(struct pcie_port *pp);
>>   int dw_pcie_host_init(struct pcie_port *pp);
>> +void dw_pcie_host_deinit(struct pcie_port *pp);
>>   int dw_pcie_allocate_domains(struct pcie_port *pp);
>>   #else
>>   static inline irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
>> @@ -367,6 +368,10 @@ static inline int dw_pcie_host_init(struct pcie_port *pp)
>>   	return 0;
>>   }
>>   
>> +static inline void dw_pcie_host_deinit(struct pcie_port *pp)
>> +{
>> +}
>> +
>>   static inline int dw_pcie_allocate_domains(struct pcie_port *pp)
>>   {
>>   	return 0;
>> -- 
>> 2.17.1
>>

