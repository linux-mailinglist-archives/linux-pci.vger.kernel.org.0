Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1842B15EC7
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2019 10:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfEGIEr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 May 2019 04:04:47 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:3111 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbfEGIEq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 May 2019 04:04:46 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cd13bf90000>; Tue, 07 May 2019 01:04:09 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 07 May 2019 01:04:44 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 07 May 2019 01:04:44 -0700
Received: from [10.25.73.250] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 7 May
 2019 08:04:37 +0000
Subject: Re: [PATCH V5 05/16] PCI: dwc: Move config space capability search
 API
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>
CC:     "mperttunen@nvidia.com" <mperttunen@nvidia.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kthota@nvidia.com" <kthota@nvidia.com>,
        "mmaddireddy@nvidia.com" <mmaddireddy@nvidia.com>,
        "sagar.tv@gmail.com" <sagar.tv@gmail.com>
References: <20190424052004.6270-1-vidyas@nvidia.com>
 <20190424052004.6270-6-vidyas@nvidia.com>
 <305100E33629484CBB767107E4246BBB0A230666@de02wembxa.internal.synopsys.com>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <ee628f18-0f19-f501-db28-7db31fd3bcbc@nvidia.com>
Date:   Tue, 7 May 2019 13:34:32 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <305100E33629484CBB767107E4246BBB0A230666@de02wembxa.internal.synopsys.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1557216249; bh=oaxpdSeWbRmtvMFY8nsXxh8qoIbsiyLvjd1S5o4zNW0=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=ILwo5gUOR2el5WDFG8gTIVo8IOsekFFb1GtKg8mIiSV10Pk+Apx5Cv5HXE0FBFjFd
         mBcKO7JTtL01hhLZ1fZS1NCvxOdjjMBBtsNWOpfX5YZBHwMk1gBTbWJSv+QL0q8g7+
         l8wbF7OMqYdBlWuKra6TviXzvJ0t41eO4UKbtk0pYQQCWNGZaYfvUlkrAi1Q8MoCyx
         SrE9pfRwa1HzE+rSWA+KonGDS3iS20kDMFJRgmWLoYtBtBTK/NEcJs/lBGwQK36KP0
         i2ovkD/PC/7VWmASEU2q1uz6Mny2VY99Ozh/+rw2VEtvzTYrrYrPYG010MLN3qGaEE
         IUYzS2I7lRorw==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/24/2019 1:43 PM, Gustavo Pimentel wrote:
> On Wed, Apr 24, 2019 at 6:19:53, Vidya Sagar <vidyas@nvidia.com> wrote:
> 
>> Move PCIe config space capability search API to common DesignWare file
>> as this can be used by both host and ep mode codes.
>>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
>> ---
>> Changes from [v4]:
>> * Removed redundant APIs in pcie-designware-ep.c file after moving them
>>    to pcie-designware.c file based on Bjorn's comments.
>>
>> Changes from [v3]:
>> * Rebased to linux-next top of the tree
>>
>> Changes from [v2]:
>> * None
>>
>> Changes from [v1]:
>> * Removed dw_pcie_find_next_ext_capability() API from here and made a
>>    separate patch for that
>>
>>   .../pci/controller/dwc/pcie-designware-ep.c   | 37 +-----------------
>>   drivers/pci/controller/dwc/pcie-designware.c  | 39 +++++++++++++++++++
>>   drivers/pci/controller/dwc/pcie-designware.h  |  2 +
>>   3 files changed, 43 insertions(+), 35 deletions(-)
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
>> index 8e0081ccf83b..ed21e861df82 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware.c
>> +++ b/drivers/pci/controller/dwc/pcie-designware.c
>> @@ -20,6 +20,45 @@
>>   #define PCIE_PHY_DEBUG_R1_LINK_UP	(0x1 << 4)
>>   #define PCIE_PHY_DEBUG_R1_LINK_IN_TRAINING	(0x1 << 29)
>>   
>> +/*
>> + * These APIs are different from standard pci_find_*capability() APIs in the
>> + * sense that former can only be used post device enumeration as they require
>> + * 'struct pci_dev *' pointer whereas these APIs require 'struct dw_pcie *'
>> + * pointer and can be used before link up also.
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
>> +
>>   int dw_pcie_read(void __iomem *addr, int size, u32 *val)
>>   {
>>   	if (!IS_ALIGNED((uintptr_t)addr, size)) {
>> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
>> index 9ee98ced1ef6..35160b4ce929 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware.h
>> +++ b/drivers/pci/controller/dwc/pcie-designware.h
>> @@ -248,6 +248,8 @@ struct dw_pcie {
>>   #define to_dw_pcie_from_ep(endpoint)   \
>>   		container_of((endpoint), struct dw_pcie, ep)
>>   
>> +u8 dw_pcie_find_capability(struct dw_pcie *pci, u8 cap);
>> +
> 
> Can you remove this extra line space?
In patch 06/15, I added dw_pcie_find_ext_capability() API so that they are grouped together
(separated by a blank line) like how dw_pcie_read() and dw_pcie_write() are grouped.

> 
>>   int dw_pcie_read(void __iomem *addr, int size, u32 *val);
>>   int dw_pcie_write(void __iomem *addr, int size, u32 val);
>>   
>> -- 
>> 2.17.1
> 
> 

