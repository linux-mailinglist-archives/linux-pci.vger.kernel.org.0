Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4AEB2A3B04
	for <lists+linux-pci@lfdr.de>; Tue,  3 Nov 2020 04:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725958AbgKCD1N (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Nov 2020 22:27:13 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:1290 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725952AbgKCD1N (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Nov 2020 22:27:13 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa0ce140001>; Mon, 02 Nov 2020 19:27:16 -0800
Received: from [10.40.203.207] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 3 Nov
 2020 03:27:05 +0000
Subject: Re: [PATCH V3 2/2] PCI: dwc: Add support to configure for ECRC
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <amurray@thegoodpenguin.co.uk>, <robh@kernel.org>,
        <treding@nvidia.com>, <jonathanh@nvidia.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20201102230234.GA62945@bjorn-Precision-5520>
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <ad86fd8c-ea49-fa87-b491-348503d0bd52@nvidia.com>
Date:   Tue, 3 Nov 2020 08:57:01 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201102230234.GA62945@bjorn-Precision-5520>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604374036; bh=IniZ6GJAHwarEstcenywJVoAKKjjHxfTNPlPnHSSHME=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=ejfSv5e6hfJNa29i/k/TuIEjk256eOvSIF7S914aJsEvDv78qC67MvaCJLKOyPOd7
         faSEQNhe/r9b+hxXgseUwvujyC2hFN2PVwSj0a9MCcQAgB9+rpqwaV9rWcTcDxmmlU
         9PgnGQ8jfN/rkqWf01MTJQrt5g10k1cnU5+nQr28zdcnJ2FSe3aXVH5O15MiX8VLAh
         0hv8xgPNycvdQgR6yqLvKxYiI/FUO9twH6Z7W5BmogQrn0IINmjF3OGnSn5GS4RSZJ
         sUdzlefiSRDsG+DGxj4hU0bi66zJ8zSkKUMFEOkrarABLFsC4sF40DlmHcK1W92G7Z
         CZo6edTmTiN5w==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 11/3/2020 4:32 AM, Bjorn Helgaas wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Thu, Oct 29, 2020 at 11:09:59AM +0530, Vidya Sagar wrote:
>> DesignWare core has a TLP digest (TD) override bit in one of the control
>> registers of ATU. This bit also needs to be programmed for proper ECRC
>> functionality. This is currently identified as an issue with DesignWare
>> IP version 4.90a. This patch does the required programming in ATU upon
>> querying the system policy for ECRC.
> 
> I guess this is a hardware defect, right?
Yes. This is common across all DWC implementations (version 4.90 precisely)

> 
> How much of a problem would it be if we instead added a "no_ecrc"
> quirk for this hardware so we never enabled ECRC?
Well, on Tegra for some of the high fidelity use cases, ECRC is required 
to be turned on and if it can be done safely with these patches, why 
shouldn't we not enable ECRC at all?

> 
> IIUC, the current Linux support of ECRC is a single choice at
> boot-time: by default ECRC is not enabled, but if you boot with
> "pci=ecrc=on", we turn on ECRC for every device.
> 
> That seems like the minimal support, but I think the spec allows ECRC
> to be enabled selectively, on individual devices.  I can imagine a
> sysfs knob that would allow us to enable/disable ECRC per-device at
> run-time.
> 
> If we had such a sysfs knob, it would be pretty ugly and maybe
> impractical to work around this hardware issue.  So I'm a little bit
> hesitant to add functionality that might have to be removed in the
> future.
Agree with this. But since it is a boot-time choice at this point, I 
think we can still go ahead with this approach to have a working ECRC 
mechanism right? I don't see any sysfs knob for AER controlling at this 
point.

> 
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> Reviewed-by: Jingoo Han <jingoohan1@gmail.com>
>> ---
>> V3:
>> * Added 'Reviewed-by: Jingoo Han <jingoohan1@gmail.com>'
>>
>> V2:
>> * Addressed Jingoo's review comment
>> * Removed saving 'td' bit information in 'dw_pcie' structure
>>
>>   drivers/pci/controller/dwc/pcie-designware.c | 8 ++++++--
>>   drivers/pci/controller/dwc/pcie-designware.h | 1 +
>>   2 files changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
>> index b5e438b70cd5..cbd651b219d2 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware.c
>> +++ b/drivers/pci/controller/dwc/pcie-designware.c
>> @@ -246,6 +246,8 @@ static void dw_pcie_prog_outbound_atu_unroll(struct dw_pcie *pci, u8 func_no,
>>        dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_UPPER_TARGET,
>>                                 upper_32_bits(pci_addr));
>>        val = type | PCIE_ATU_FUNC_NUM(func_no);
>> +     if (pci->version == 0x490A)
>> +             val = val | pcie_is_ecrc_enabled() << PCIE_ATU_TD_SHIFT;
>>        val = upper_32_bits(size - 1) ?
>>                val | PCIE_ATU_INCREASE_REGION_SIZE : val;
>>        dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL1, val);
>> @@ -294,8 +296,10 @@ static void __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
>>                           lower_32_bits(pci_addr));
>>        dw_pcie_writel_dbi(pci, PCIE_ATU_UPPER_TARGET,
>>                           upper_32_bits(pci_addr));
>> -     dw_pcie_writel_dbi(pci, PCIE_ATU_CR1, type |
>> -                        PCIE_ATU_FUNC_NUM(func_no));
>> +     val = type | PCIE_ATU_FUNC_NUM(func_no);
>> +     if (pci->version == 0x490A)
>> +             val = val | pcie_is_ecrc_enabled() << PCIE_ATU_TD_SHIFT;
>> +     dw_pcie_writel_dbi(pci, PCIE_ATU_CR1, val);
>>        dw_pcie_writel_dbi(pci, PCIE_ATU_CR2, PCIE_ATU_ENABLE);
>>
>>        /*
>> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
>> index e7f441441db2..b01ef407fd52 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware.h
>> +++ b/drivers/pci/controller/dwc/pcie-designware.h
>> @@ -89,6 +89,7 @@
>>   #define PCIE_ATU_TYPE_IO             0x2
>>   #define PCIE_ATU_TYPE_CFG0           0x4
>>   #define PCIE_ATU_TYPE_CFG1           0x5
>> +#define PCIE_ATU_TD_SHIFT            8
>>   #define PCIE_ATU_FUNC_NUM(pf)           ((pf) << 20)
>>   #define PCIE_ATU_CR2                 0x908
>>   #define PCIE_ATU_ENABLE                      BIT(31)
>> --
>> 2.17.1
>>
