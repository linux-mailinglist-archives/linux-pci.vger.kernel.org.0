Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93BDC32F236
	for <lists+linux-pci@lfdr.de>; Fri,  5 Mar 2021 19:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbhCESNv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Mar 2021 13:13:51 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:6122 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbhCESNT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 5 Mar 2021 13:13:19 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B604274bf0001>; Fri, 05 Mar 2021 10:13:19 -0800
Received: from [10.25.102.43] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 5 Mar
 2021 18:13:08 +0000
Subject: Re: [PATCH] PCI: tegra: Disable PTM capabilities for EP mode
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Om Prakash Singh <omp@nvidia.com>
CC:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lorenzo.pieralisi@arm.com>, <amurray@thegoodpenguin.co.uk>,
        <bhelgaas@google.com>, <kishon@ti.com>, <thierry.reding@gmail.com>,
        <Jisheng.Zhang@synaptics.com>, <jonathanh@nvidia.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>,
        <oop.singh@gmail.com>
References: <20210305121934.GA1067436@bjorn-Precision-5520>
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <81c84df2-e52b-7713-5026-c3e0a27376bd@nvidia.com>
Date:   Fri, 5 Mar 2021 23:43:05 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210305121934.GA1067436@bjorn-Precision-5520>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1614967999; bh=iXH6BGuoOPrc5Y2F4o7qmuZpbDhOYFMuk95svGbaDhA=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=j6b14bYx8SWcuYKB4nYMCnrbfhD7TM8A7PARdKS7aVhJVDlRn1T1WeSYbjTFQGNEV
         nG9W45W2/T+LPXqHKcem76+9r/upO/BeP+p4H+TDJUR8NHzqNsZIo5XRttlPq/7h0I
         zO5rhourvYT0X1ymHx55NMTYQX9dXdRzoi16a2P18sJzEbS9B2eS7TmwQbIbTtFWFn
         RhJD2O7X9U4LriG0PCYnFDv9oef7DKvNVbeURSISGIJyRZBMyFjJ+Kw5SCu4Z6qurW
         cVpcXWvJD45DJYH02h6QRYBEYOVrE16rVNAVQvxt57ttNrELYzGwm4xB00zfp+6GMX
         5k0sUveJtzZiQ==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 3/5/2021 5:49 PM, Bjorn Helgaas wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Fri, Mar 05, 2021 at 01:42:34PM +0530, Om Prakash Singh wrote:
>> PCIe EP compliance expect PTM capabilities (ROOT_CAPABLE, RES_CAPABLE,
>> CLK_GRAN) to be disabled.
> 
> I guess this is just enforcing the PCIe spec requirements that only
> Root Ports, RCRBs, and Switches are allowed to set the PTM Responder
> Capable bit, and that the Local Clock Granularity is RsvdP if PTM Root
> Capable is zero?  (PCIe r5.0, sec 7.9.16.2)
> 
> Should this be done more generally somewhere in the dwc code as
> opposed to in the tegra code?
Agree.

> 
>> Signed-off-by: Om Prakash Singh <omp@nvidia.com>
>> ---
>>   drivers/pci/controller/dwc/pcie-tegra194.c | 17 ++++++++++++++++-
>>   include/uapi/linux/pci_regs.h              |  1 +
>>   2 files changed, 17 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
>> index 6fa216e..a588312 100644
>> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
>> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
>> @@ -1639,7 +1639,7 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
>>        struct dw_pcie *pci = &pcie->pci;
>>        struct dw_pcie_ep *ep = &pci->ep;
>>        struct device *dev = pcie->dev;
>> -     u32 val;
>> +     u32 val, ptm_cap_base = 0;
> 
> Unnecessary init.
> 
>>        int ret;
>>
>>        if (pcie->ep_state == EP_STATE_ENABLED)
>> @@ -1760,6 +1760,21 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
>>                                                      PCI_CAP_ID_EXP);
>>        clk_set_rate(pcie->core_clk, GEN4_CORE_CLK_FREQ);
>>
>> +     /* Disable PTM root and responder capability */
>> +     ptm_cap_base = dw_pcie_find_ext_capability(&pcie->pci,
>> +                                                PCI_EXT_CAP_ID_PTM);
>> +     if (ptm_cap_base) {
>> +             dw_pcie_dbi_ro_wr_en(pci);
>> +             val = dw_pcie_readl_dbi(pci, ptm_cap_base + PCI_PTM_CAP);
>> +             val &= ~PCI_PTM_CAP_ROOT;
>> +             dw_pcie_writel_dbi(pci, ptm_cap_base + PCI_PTM_CAP, val);
>> +
>> +             val = dw_pcie_readl_dbi(pci, ptm_cap_base + PCI_PTM_CAP);
>> +             val &= ~(PCI_PTM_CAP_RES | PCI_PTM_GRANULARITY_MASK);
Why can't this be clubbed with "val &= ~PCI_PTM_CAP_ROOT;" ?

>> +             dw_pcie_writel_dbi(pci, ptm_cap_base + PCI_PTM_CAP, val);
>> +             dw_pcie_dbi_ro_wr_dis(pci);
>> +     }
>> +
>>        val = (ep->msi_mem_phys & MSIX_ADDR_MATCH_LOW_OFF_MASK);
>>        val |= MSIX_ADDR_MATCH_LOW_OFF_EN;
>>        dw_pcie_writel_dbi(pci, MSIX_ADDR_MATCH_LOW_OFF, val);
>> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
>> index e709ae8..9dd6f8d 100644
>> --- a/include/uapi/linux/pci_regs.h
>> +++ b/include/uapi/linux/pci_regs.h
>> @@ -1050,6 +1050,7 @@
>>   /* Precision Time Measurement */
>>   #define PCI_PTM_CAP                  0x04        /* PTM Capability */
>>   #define  PCI_PTM_CAP_REQ             0x00000001  /* Requester capable */
>> +#define  PCI_PTM_CAP_RES             0x00000002  /* Responder capable */
>>   #define  PCI_PTM_CAP_ROOT            0x00000004  /* Root capable */
>>   #define  PCI_PTM_GRANULARITY_MASK    0x0000FF00  /* Clock granularity */
>>   #define PCI_PTM_CTRL                 0x08        /* PTM Control */
>> --
>> 2.7.4
>>
