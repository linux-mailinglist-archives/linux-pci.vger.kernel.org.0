Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9394A25FD6
	for <lists+linux-pci@lfdr.de>; Wed, 22 May 2019 10:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbfEVI4T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 May 2019 04:56:19 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:15243 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727796AbfEVI4T (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 May 2019 04:56:19 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ce50eb00000>; Wed, 22 May 2019 01:56:16 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 22 May 2019 01:56:16 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 22 May 2019 01:56:16 -0700
Received: from [10.24.45.128] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 22 May
 2019 08:56:10 +0000
Subject: Re: [PATCH V7 04/15] PCI: dwc: Move config space capability search
 API
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <lorenzo.pieralisi@arm.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <kishon@ti.com>, <catalin.marinas@arm.com>,
        <will.deacon@arm.com>, <jingoohan1@gmail.com>,
        <gustavo.pimentel@synopsys.com>, <mperttunen@nvidia.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20190517123846.3708-1-vidyas@nvidia.com>
 <20190517123846.3708-5-vidyas@nvidia.com> <20190521211757.GF57618@google.com>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <fd164d1f-cf99-fe81-c368-46e3a3742a59@nvidia.com>
Date:   Wed, 22 May 2019 14:26:08 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190521211757.GF57618@google.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1558515376; bh=N5UCTQ0Qf3AxzLE/m3Mt3Uz4MoUt0G5MVA4MUrcYgjU=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=H7ig9Dkd6/qCtoQSM9CHdizNJAtYYEgV880CAyRSPzwwAbd0ON5e2B2zSimxScECX
         2DcyRpTM+hnuxBBHTwXrAUmH/6BaXys4QwUQZVttaMLscQ/FjGpOO7y3f6EoHtWHUw
         mWaMYhpb0OBZJElgPwsoflDpGisEh0NMEcP85FK1+mol5oFRFWVIZ+gShKoSf+UDS7
         nf+7bwdB9/3XFgpQpwXKk0nxuJZSEcX1RZ6nz1ZgxlDkehFQR7uongXo92t1s3Tofv
         1Srxotb5+yfq6PQTxBiOIutjHsF7gU2XmdG1GgAFVaVaBJBYP9c8VtZ3FK2NwPLAMb
         bAG/lQBsYN+2w==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 5/22/2019 2:47 AM, Bjorn Helgaas wrote:
> On Fri, May 17, 2019 at 06:08:35PM +0530, Vidya Sagar wrote:
>> Move PCIe config space capability search API to common DesignWare file
>> as this can be used by both host and ep mode codes.
>>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
>> ---
>> Changes since [v6]:
>> * Exported dw_pcie_find_capability() API
>>
>> Changes since [v5]:
>> * None
>>
>> Changes since [v4]:
>> * Removed redundant APIs in pcie-designware-ep.c file after moving them
>>    to pcie-designware.c file based on Bjorn's comments.
>>
>> Changes since [v3]:
>> * Rebased to linux-next top of the tree
>>
>> Changes since [v2]:
>> * None
>>
>> Changes since [v1]:
>> * Removed dw_pcie_find_next_ext_capability() API from here and made a
>>    separate patch for that
>>
>>   .../pci/controller/dwc/pcie-designware-ep.c   | 37 +----------------
>>   drivers/pci/controller/dwc/pcie-designware.c  | 40 +++++++++++++++++++
>>   drivers/pci/controller/dwc/pcie-designware.h  |  2 +
>>   3 files changed, 44 insertions(+), 35 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
>> index 2bf5a35c0570..65f479250087 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
>> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
>> @@ -40,39 +40,6 @@ void dw_pcie_ep_reset_bar(struct dw_pcie *pci, enum pci_barno bar)
>>   	__dw_pcie_ep_reset_bar(pci, bar, 0);
>>   }
>>   
>> -static u8 __dw_pcie_ep_find_next_cap(struct dw_pcie *pci, u8 cap_ptr,
>> -			      u8 cap)
>> -{
>> -	u8 cap_id, next_cap_ptr;
>> -	u16 reg;
>> -
>> -	if (!cap_ptr)
>> -		return 0;
>> -
>> -	reg = dw_pcie_readw_dbi(pci, cap_ptr);
>> -	cap_id = (reg & 0x00ff);
>> -
>> -	if (cap_id > PCI_CAP_ID_MAX)
>> -		return 0;
>> -
>> -	if (cap_id == cap)
>> -		return cap_ptr;
>> -
>> -	next_cap_ptr = (reg & 0xff00) >> 8;
>> -	return __dw_pcie_ep_find_next_cap(pci, next_cap_ptr, cap);
>> -}
>> -
>> -static u8 dw_pcie_ep_find_capability(struct dw_pcie *pci, u8 cap)
>> -{
>> -	u8 next_cap_ptr;
>> -	u16 reg;
>> -
>> -	reg = dw_pcie_readw_dbi(pci, PCI_CAPABILITY_LIST);
>> -	next_cap_ptr = (reg & 0x00ff);
>> -
>> -	return __dw_pcie_ep_find_next_cap(pci, next_cap_ptr, cap);
>> -}
>> -
>>   static int dw_pcie_ep_write_header(struct pci_epc *epc, u8 func_no,
>>   				   struct pci_epf_header *hdr)
>>   {
>> @@ -612,9 +579,9 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>>   		dev_err(dev, "Failed to reserve memory for MSI/MSI-X\n");
>>   		return -ENOMEM;
>>   	}
>> -	ep->msi_cap = dw_pcie_ep_find_capability(pci, PCI_CAP_ID_MSI);
>> +	ep->msi_cap = dw_pcie_find_capability(pci, PCI_CAP_ID_MSI);
>>   
>> -	ep->msix_cap = dw_pcie_ep_find_capability(pci, PCI_CAP_ID_MSIX);
>> +	ep->msix_cap = dw_pcie_find_capability(pci, PCI_CAP_ID_MSIX);
>>   
>>   	offset = dw_pcie_ep_find_ext_capability(pci, PCI_EXT_CAP_ID_REBAR);
>>   	if (offset) {
>> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
>> index 83cdd2ce2486..8f53ce63d17e 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware.c
>> +++ b/drivers/pci/controller/dwc/pcie-designware.c
>> @@ -14,6 +14,46 @@
>>   
>>   #include "pcie-designware.h"
>>   
>> +/*
>> + * These APIs are different from standard pci_find_*capability() APIs in the
>> + * sense that former can only be used post device enumeration as they require
>> + * 'struct pci_dev *' pointer whereas these APIs require 'struct dw_pcie *'
>> + * pointer and can be used before link up also.
> 
> I think this comment is slightly misleading because it suggests the
> reason we need these DW interfaces is because we're doing something
> before a pci_dev pointer is available.
> 
> But these DW interfaces are used on devices that will *never* have a
> pci_dev pointer because they are not PCI devices.  They're used on
> host controller devices, which have a PCIe link on the downstream
> side, but the host controller driver operates them using their
> upstream, non-PCI interfaces.  Logically, I think they would be
> considered parts of Root Complexes, not Root Ports.
> 
> There's actually no reason why that upstream interface should look
> anything like PCI; it doesn't need to organize registers into
> capability lists at all.  It might be convenient for the hardware to
> do that and share things with a Root Port device, which *is* a PCI
> device, but it's not required.
> 
> It also really has nothing to do with whether the link is up.  This
> code operates on hardware that is upstream from the link, so we can
> reach it regardless of the link.
I added this comment after receiving a review comment to justify why standard
pci_find_*capability() APIs can't be used here. Hence added this.
I understand your comment that DW interface need not have to be a PCI device,
but what is present in the hardware is effectively a root port implementation
and post enumeration, we get a 'struct pci_dev' created for it, hence I thought
it is fine to bring 'struct pci_dev' into picture.
Also, I agree that mention of 'link up' is unwarranted and could be reworded in
a better way.
Do you suggest to remove this comment altogether or reword it
s/and can be used before link up also/and can be used before 'struct pci_dev' is
available/ ?

> 
>> + */
>> +static u8 __dw_pcie_find_next_cap(struct dw_pcie *pci, u8 cap_ptr,
>> +				  u8 cap)
>> +{
>> +	u8 cap_id, next_cap_ptr;
>> +	u16 reg;
>> +
>> +	if (!cap_ptr)
>> +		return 0;
>> +
>> +	reg = dw_pcie_readw_dbi(pci, cap_ptr);
>> +	cap_id = (reg & 0x00ff);
>> +
>> +	if (cap_id > PCI_CAP_ID_MAX)
>> +		return 0;
>> +
>> +	if (cap_id == cap)
>> +		return cap_ptr;
>> +
>> +	next_cap_ptr = (reg & 0xff00) >> 8;
>> +	return __dw_pcie_find_next_cap(pci, next_cap_ptr, cap);
>> +}
>> +
>> +u8 dw_pcie_find_capability(struct dw_pcie *pci, u8 cap)
>> +{
>> +	u8 next_cap_ptr;
>> +	u16 reg;
>> +
>> +	reg = dw_pcie_readw_dbi(pci, PCI_CAPABILITY_LIST);
>> +	next_cap_ptr = (reg & 0x00ff);
>> +
>> +	return __dw_pcie_find_next_cap(pci, next_cap_ptr, cap);
>> +}
>> +EXPORT_SYMBOL_GPL(dw_pcie_find_capability);
>> +
>>   int dw_pcie_read(void __iomem *addr, int size, u32 *val)
>>   {
>>   	if (!IS_ALIGNED((uintptr_t)addr, size)) {
>> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
>> index 14762e262758..6cb978132469 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware.h
>> +++ b/drivers/pci/controller/dwc/pcie-designware.h
>> @@ -251,6 +251,8 @@ struct dw_pcie {
>>   #define to_dw_pcie_from_ep(endpoint)   \
>>   		container_of((endpoint), struct dw_pcie, ep)
>>   
>> +u8 dw_pcie_find_capability(struct dw_pcie *pci, u8 cap);
>> +
>>   int dw_pcie_read(void __iomem *addr, int size, u32 *val);
>>   int dw_pcie_write(void __iomem *addr, int size, u32 val);
>>   
>> -- 
>> 2.17.1
>>

