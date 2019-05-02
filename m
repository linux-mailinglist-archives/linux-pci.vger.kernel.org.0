Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE8E120BB
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2019 19:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbfEBRBI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 May 2019 13:01:08 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:8530 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbfEBRBH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 May 2019 13:01:07 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ccb22580000>; Thu, 02 May 2019 10:01:12 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 02 May 2019 10:01:05 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 02 May 2019 10:01:05 -0700
Received: from [10.25.72.23] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 2 May
 2019 17:01:01 +0000
Subject: Re: [PATCH V2 2/2] PCI: dwc: Export APIs to support .remove()
 implementation
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <bhelgaas@google.com>, <Jisheng.Zhang@synaptics.com>,
        <thierry.reding@gmail.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20190416141516.23908-1-vidyas@nvidia.com>
 <20190416141516.23908-3-vidyas@nvidia.com>
 <20190502145146.GA19656@e121166-lin.cambridge.arm.com>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <4f8c228b-7548-6ec2-cb0e-228bba6f42bb@nvidia.com>
Date:   Thu, 2 May 2019 22:30:58 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190502145146.GA19656@e121166-lin.cambridge.arm.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1556816472; bh=SbX8+dTJ7ImsuH2VwNbOYlGrcvz7fR3RadTS9syAJz4=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=S2oQ3+nlWI8QN1oWZOgEE5na0u8YRdWerU9GZrh+UvCUl2L42F6KHTvAdSVqMwHIV
         onnkOBOaa15QdnRI6cS4ZmH/G1IJpWMerNC/GdjK54xDOOAEn3gHlvue/wtDaocqRv
         b2ZEHYqR0i5ZydAKXicGtD6llx7vzDSWmq3mY8PL+VsWhpvJEo8+yXvzhjngMlSRvz
         QpdlR4mo/ivW5s2+/8n0cW5o3o2GZ5wjHe8gDfiAdQbuzPwSuFwf9SqTuQ0scpNhWc
         sGqRDhSJZmZOn7FZIzeBF/+IdAvYyzP9LEKmtBgqOHN85CMPRbbWh9S+vxcRT28UfA
         9NUmUvl6OzkUA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 5/2/2019 8:21 PM, Lorenzo Pieralisi wrote:
> On Tue, Apr 16, 2019 at 07:45:16PM +0530, Vidya Sagar wrote:
>> Export all configuration space access APIs and also other APIs to
>> support host controller drivers of DesignWare core based
>> implementations while adding support for .remove() hook to build their
>> respective drivers as modules
>>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
>> ---
>> v2:
>> * s/Designware/DesignWare
>>
>>   .../pci/controller/dwc/pcie-designware-host.c |  4 ++
>>   drivers/pci/controller/dwc/pcie-designware.c  | 38 +++++++++++++++++++
>>   drivers/pci/controller/dwc/pcie-designware.h  | 35 +++--------------
>>   3 files changed, 48 insertions(+), 29 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
>> index d7881490282d..2a5332e5ccfa 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
>> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
>> @@ -333,6 +333,7 @@ void dw_pcie_msi_init(struct pcie_port *pp)
>>   	dw_pcie_wr_own_conf(pp, PCIE_MSI_ADDR_HI, 4,
>>   			    upper_32_bits(msi_target));
>>   }
>> +EXPORT_SYMBOL_GPL(dw_pcie_msi_init);
>>   
>>   int dw_pcie_host_init(struct pcie_port *pp)
>>   {
>> @@ -515,6 +516,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
>>   		dw_pcie_free_msi(pp);
>>   	return ret;
>>   }
>> +EXPORT_SYMBOL_GPL(dw_pcie_host_init);
>>   
>>   void dw_pcie_host_deinit(struct pcie_port *pp)
>>   {
>> @@ -522,6 +524,7 @@ void dw_pcie_host_deinit(struct pcie_port *pp)
>>   	pci_remove_root_bus(pp->root_bus);
>>   	dw_pcie_free_msi(pp);
>>   }
>> +EXPORT_SYMBOL_GPL(dw_pcie_host_deinit);
>>   
>>   static int dw_pcie_access_other_conf(struct pcie_port *pp, struct pci_bus *bus,
>>   				     u32 devfn, int where, int size, u32 *val,
>> @@ -731,3 +734,4 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
>>   	val |= PORT_LOGIC_SPEED_CHANGE;
>>   	dw_pcie_wr_own_conf(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, 4, val);
>>   }
>> +EXPORT_SYMBOL_GPL(dw_pcie_setup_rc);
>> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
>> index 31f6331ca46f..f98e2f284ae1 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware.c
>> +++ b/drivers/pci/controller/dwc/pcie-designware.c
>> @@ -40,6 +40,7 @@ int dw_pcie_read(void __iomem *addr, int size, u32 *val)
>>   
>>   	return PCIBIOS_SUCCESSFUL;
>>   }
>> +EXPORT_SYMBOL_GPL(dw_pcie_read);
>>   
>>   int dw_pcie_write(void __iomem *addr, int size, u32 val)
>>   {
>> @@ -57,6 +58,7 @@ int dw_pcie_write(void __iomem *addr, int size, u32 val)
>>   
>>   	return PCIBIOS_SUCCESSFUL;
>>   }
>> +EXPORT_SYMBOL_GPL(dw_pcie_write);
>>   
>>   u32 __dw_pcie_read_dbi(struct dw_pcie *pci, void __iomem *base, u32 reg,
>>   		       size_t size)
>> @@ -89,6 +91,42 @@ void __dw_pcie_write_dbi(struct dw_pcie *pci, void __iomem *base, u32 reg,
>>   		dev_err(pci->dev, "Write DBI address failed\n");
>>   }
>>   
>> +void dw_pcie_writel_dbi(struct dw_pcie *pci, u32 reg, u32 val)
>> +{
>> +	__dw_pcie_write_dbi(pci, pci->dbi_base, reg, 0x4, val);
>> +}
>> +EXPORT_SYMBOL_GPL(dw_pcie_writel_dbi);
>> +
>> +u32 dw_pcie_readl_dbi(struct dw_pcie *pci, u32 reg)
>> +{
>> +	return __dw_pcie_read_dbi(pci, pci->dbi_base, reg, 0x4);
>> +}
>> +EXPORT_SYMBOL_GPL(dw_pcie_readl_dbi);
>> +
>> +void dw_pcie_writew_dbi(struct dw_pcie *pci, u32 reg, u16 val)
>> +{
>> +	__dw_pcie_write_dbi(pci, pci->dbi_base, reg, 0x2, val);
>> +}
>> +EXPORT_SYMBOL_GPL(dw_pcie_writew_dbi);
>> +
>> +u16 dw_pcie_readw_dbi(struct dw_pcie *pci, u32 reg)
>> +{
>> +	return __dw_pcie_read_dbi(pci, pci->dbi_base, reg, 0x2);
>> +}
>> +EXPORT_SYMBOL_GPL(dw_pcie_readw_dbi);
>> +
>> +void dw_pcie_writeb_dbi(struct dw_pcie *pci, u32 reg, u8 val)
>> +{
>> +	__dw_pcie_write_dbi(pci, pci->dbi_base, reg, 0x1, val);
>> +}
>> +EXPORT_SYMBOL_GPL(dw_pcie_writeb_dbi);
>> +
>> +u8 dw_pcie_readb_dbi(struct dw_pcie *pci, u32 reg)
>> +{
>> +	return __dw_pcie_read_dbi(pci, pci->dbi_base, reg, 0x1);
>> +}
>> +EXPORT_SYMBOL_GPL(dw_pcie_readb_dbi);
>> +
>>   static u32 dw_pcie_readl_ob_unroll(struct dw_pcie *pci, u32 index, u32 reg)
>>   {
>>   	u32 offset = PCIE_GET_ATU_OUTB_UNR_REG_OFFSET(index);
>> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
>> index ea8d1caf11c5..86df36701a37 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware.h
>> +++ b/drivers/pci/controller/dwc/pcie-designware.h
>> @@ -265,35 +265,12 @@ void dw_pcie_disable_atu(struct dw_pcie *pci, int index,
>>   			 enum dw_pcie_region_type type);
>>   void dw_pcie_setup(struct dw_pcie *pci);
>>   
>> -static inline void dw_pcie_writel_dbi(struct dw_pcie *pci, u32 reg, u32 val)
>> -{
>> -	__dw_pcie_write_dbi(pci, pci->dbi_base, reg, 0x4, val);
>> -}
>> -
>> -static inline u32 dw_pcie_readl_dbi(struct dw_pcie *pci, u32 reg)
>> -{
>> -	return __dw_pcie_read_dbi(pci, pci->dbi_base, reg, 0x4);
>> -}
>> -
>> -static inline void dw_pcie_writew_dbi(struct dw_pcie *pci, u32 reg, u16 val)
>> -{
>> -	__dw_pcie_write_dbi(pci, pci->dbi_base, reg, 0x2, val);
>> -}
>> -
>> -static inline u16 dw_pcie_readw_dbi(struct dw_pcie *pci, u32 reg)
>> -{
>> -	return __dw_pcie_read_dbi(pci, pci->dbi_base, reg, 0x2);
>> -}
>> -
>> -static inline void dw_pcie_writeb_dbi(struct dw_pcie *pci, u32 reg, u8 val)
>> -{
>> -	__dw_pcie_write_dbi(pci, pci->dbi_base, reg, 0x1, val);
>> -}
>> -
>> -static inline u8 dw_pcie_readb_dbi(struct dw_pcie *pci, u32 reg)
>> -{
>> -	return __dw_pcie_read_dbi(pci, pci->dbi_base, reg, 0x1);
>> -}
>> +void dw_pcie_writel_dbi(struct dw_pcie *pci, u32 reg, u32 val);
>> +u32 dw_pcie_readl_dbi(struct dw_pcie *pci, u32 reg);
>> +void dw_pcie_writew_dbi(struct dw_pcie *pci, u32 reg, u16 val);
>> +u16 dw_pcie_readw_dbi(struct dw_pcie *pci, u32 reg);
>> +void dw_pcie_writeb_dbi(struct dw_pcie *pci, u32 reg, u8 val);
>> +u8 dw_pcie_readb_dbi(struct dw_pcie *pci, u32 reg);
> 
> What's the point of exporting all these functions ?
> 
> Export __dw_pcie_{write/read}_dbi() and be done with it.
Yup. That would have been simpler. In retrospection, I don't remember
why I had done it this way. Anyway, I'll export only __dw_pcie* APIs
in next patch series.

> 
> Thanks,
> Lorenzo
> 
>>   
>>   static inline void dw_pcie_writel_dbi2(struct dw_pcie *pci, u32 reg, u32 val)
>>   {
>> -- 
>> 2.17.1
>>

