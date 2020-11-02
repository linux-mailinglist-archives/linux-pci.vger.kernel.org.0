Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8847C2A2CF3
	for <lists+linux-pci@lfdr.de>; Mon,  2 Nov 2020 15:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbgKBO1o (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Nov 2020 09:27:44 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:2260 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgKBO1o (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Nov 2020 09:27:44 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa0176a0000>; Mon, 02 Nov 2020 06:27:54 -0800
Received: from [10.40.203.207] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 2 Nov
 2020 14:27:29 +0000
Subject: Re: [PATCH V3 2/2] PCI: dwc: Add support to configure for ECRC
To:     Rob Herring <robh@kernel.org>
CC:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Andrew Murray" <amurray@thegoodpenguin.co.uk>,
        Thierry Reding <treding@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        <sagar.tv@gmail.com>
References: <20201029053959.31361-1-vidyas@nvidia.com>
 <20201029053959.31361-3-vidyas@nvidia.com>
 <CAL_Jsq+3Ek9SRbsTqEmjiZtszvi7Er=TNgOt8t=0OESva2=sTg@mail.gmail.com>
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <902c0445-9fed-8e61-3aba-0e87988eb8df@nvidia.com>
Date:   Mon, 2 Nov 2020 19:57:09 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+3Ek9SRbsTqEmjiZtszvi7Er=TNgOt8t=0OESva2=sTg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604327274; bh=BmBd10lTydU2z4T/pVMGIVfq9htbIjqzmMQoqrsWnrw=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=dzjPyLUDBZ1nY+/mE1Shogm4xP9Uri06oXQB9HOBLqc69OAk0XGniUqt94R2YUyQZ
         jVVr3zzd6dAoE7N7sQIHJf/Bl9QinVV8wrpr407+oHBTchyLRzH9wADodUs1i2vbco
         KBm17eHecuzJkjnAIyo5wmpE1l1Xp6CoF4YYOO5VFdXdwCVuJyZOlAbFruBmePXQMe
         gn7Uu1vta9sXbgs4cFuIiCXILOB3s7HhPjTUztBGWdCJlnJ6AxBWJhQPbZbawleVOf
         D+QxRRLJUSr2A4TqYb5qnZvLXrpMTuDght6KGFRn/ymt85ViQatGUvtaI2HeIHEkLM
         OUMNeMJUB4JHA==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 11/2/2020 7:45 PM, Rob Herring wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Thu, Oct 29, 2020 at 12:40 AM Vidya Sagar <vidyas@nvidia.com> wrote:
>>
>> DesignWare core has a TLP digest (TD) override bit in one of the control
>> registers of ATU. This bit also needs to be programmed for proper ECRC
>> functionality. This is currently identified as an issue with DesignWare
>> IP version 4.90a. This patch does the required programming in ATU upon
>> querying the system policy for ECRC.
>>
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
>>          dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_UPPER_TARGET,
>>                                   upper_32_bits(pci_addr));
>>          val = type | PCIE_ATU_FUNC_NUM(func_no);
>> +       if (pci->version == 0x490A)
>> +               val = val | pcie_is_ecrc_enabled() << PCIE_ATU_TD_SHIFT;
>>          val = upper_32_bits(size - 1) ?
>>                  val | PCIE_ATU_INCREASE_REGION_SIZE : val;
>>          dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL1, val);
>> @@ -294,8 +296,10 @@ static void __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
>>                             lower_32_bits(pci_addr));
>>          dw_pcie_writel_dbi(pci, PCIE_ATU_UPPER_TARGET,
>>                             upper_32_bits(pci_addr));
>> -       dw_pcie_writel_dbi(pci, PCIE_ATU_CR1, type |
>> -                          PCIE_ATU_FUNC_NUM(func_no));
>> +       val = type | PCIE_ATU_FUNC_NUM(func_no);
>> +       if (pci->version == 0x490A)
> 
> Is this even possible? Are the non-unroll ATU registers available post 4.80?
I'm not sure. Gustavo might have information about this. I made this 
change so that it is taken care off even if they available.

> 
> Rob
> 
