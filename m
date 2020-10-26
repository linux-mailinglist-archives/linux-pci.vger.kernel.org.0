Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC9329872D
	for <lists+linux-pci@lfdr.de>; Mon, 26 Oct 2020 08:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1769840AbgJZG7f (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Oct 2020 02:59:35 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:18389 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730770AbgJZG7f (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Oct 2020 02:59:35 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f9673c20000>; Sun, 25 Oct 2020 23:59:14 -0700
Received: from [10.40.202.195] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 26 Oct
 2020 06:59:23 +0000
Subject: Re: [PATCH 2/2] PCI: dwc: Add support to configure for ECRC
To:     Jingoo Han <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "amurray@thegoodpenguin.co.uk" <amurray@thegoodpenguin.co.uk>,
        "robh@kernel.org" <robh@kernel.org>,
        "treding@nvidia.com" <treding@nvidia.com>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kthota@nvidia.com" <kthota@nvidia.com>,
        "mmaddireddy@nvidia.com" <mmaddireddy@nvidia.com>,
        "sagar.tv@gmail.com" <sagar.tv@gmail.com>
References: <20201025073113.31291-1-vidyas@nvidia.com>
 <20201025073113.31291-3-vidyas@nvidia.com>
 <SLXP216MB0477AAC31DF68862BE5BC3EEAA180@SLXP216MB0477.KORP216.PROD.OUTLOOK.COM>
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <ccec2428-0efe-101c-11be-28766738951d@nvidia.com>
Date:   Mon, 26 Oct 2020 12:29:18 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <SLXP216MB0477AAC31DF68862BE5BC3EEAA180@SLXP216MB0477.KORP216.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603695554; bh=EZR6bOvonAhqaAmY5+zlrFqM8/4BkLY98W9Jb8B95Lw=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=Kiw+sBzZSVZof0ZTSkPAD5J72NB0cEk7U8Gmx50l+pTAJ9FIX+DzKkmMUudhd8VLl
         Xa2KWvVQ2/PhMExM45+fnswj1Hf/G8rRVjgYarZEtdPMjOV8hU8zfeMDkOFvAGfEqt
         cUlcNzjMu2YFCwES8ulPBl13VN0/uP1fCLID5jQebG/Zg852zNlAiYOL0c4QdjetHj
         2cUCIbWMGIR/VXeIDgnNgBKfnS06vuDsXmSxlvQk6TP14p61yuyHGrxSygpqEmPB/G
         Tg9jHUfK83887g8xC5nHDalEacZRDKDZpJMp+5M/Nj8Z9zhP7f9q8vJTbAIZizOZ8J
         yuRG9ORhZQjSA==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 10/26/2020 2:19 AM, Jingoo Han wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 10/25/20, 3:31 AM, Vidya Sagar wrote:
>>
>> DesignWare core has a TLP digest (TD) override bit in one of the control
>> registers of ATU. This bit also needs to be programmed for proper ECRC
>> functionality. This is currently identified as an issue with DesignWare
>> IP version 4.90a. This patch does the required programming in ATU upon
>> querying the system policy for ECRC.
>>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> ---
>>   drivers/pci/controller/dwc/pcie-designware.c | 8 ++++++--
>>   drivers/pci/controller/dwc/pcie-designware.h | 2 ++
>>   2 files changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
>> index b5e438b70cd5..810dcbdbe869 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware.c
>> +++ b/drivers/pci/controller/dwc/pcie-designware.c
>> @@ -245,7 +245,7 @@ static void dw_pcie_prog_outbound_atu_unroll(struct dw_pcie *pci, u8 func_no,
>>                                 lower_32_bits(pci_addr));
>>        dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_UPPER_TARGET,
>>                                 upper_32_bits(pci_addr));
>> -     val = type | PCIE_ATU_FUNC_NUM(func_no);
>> +     val = type | PCIE_ATU_FUNC_NUM(func_no) | pci->td << PCIE_ATU_TD_SHIFT;
>>        val = upper_32_bits(size - 1) ?
>>                val | PCIE_ATU_INCREASE_REGION_SIZE : val;
>>        dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL1, val);
>> @@ -295,7 +295,8 @@ static void __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
>>        dw_pcie_writel_dbi(pci, PCIE_ATU_UPPER_TARGET,
>>                           upper_32_bits(pci_addr));
>>        dw_pcie_writel_dbi(pci, PCIE_ATU_CR1, type |
>> -                        PCIE_ATU_FUNC_NUM(func_no));
>> +                        PCIE_ATU_FUNC_NUM(func_no) |
>> +                        pci->td << PCIE_ATU_TD_SHIFT);
>>        dw_pcie_writel_dbi(pci, PCIE_ATU_CR2, PCIE_ATU_ENABLE);
>>
>>        /*
>> @@ -565,6 +566,9 @@ void dw_pcie_setup(struct dw_pcie *pci)
>>        dev_dbg(pci->dev, "iATU unroll: %s\n", pci->iatu_unroll_enabled ?
>>                "enabled" : "disabled");
>>
>> +     if (pci->version == 0x490A)
>> +             pci->td = pcie_is_ecrc_enabled();
>> +
>>        if (pci->link_gen > 0)
>>                dw_pcie_link_set_max_speed(pci, pci->link_gen);
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
>> index 21dd06831b50..d34723e42e79 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware.h
>> +++ b/drivers/pci/controller/dwc/pcie-designware.h
>> @@ -90,6 +90,7 @@
>>   #define PCIE_ATU_TYPE_IO             0x2
>>   #define PCIE_ATU_TYPE_CFG0           0x4
>>   #define PCIE_ATU_TYPE_CFG1           0x5
>> +#define PCIE_ATU_TD_SHIFT            8
>>   #define PCIE_ATU_FUNC_NUM(pf)           ((pf) << 20)
>>   #define PCIE_ATU_CR2                 0x908
>>   #define PCIE_ATU_ENABLE                      BIT(31)
>> @@ -276,6 +277,7 @@ struct dw_pcie {
>>        int                     num_lanes;
>>        int                     link_gen;
>>        u8                      n_fts[2];
>> +     bool                    td;     /* TLP Digest (for ECRC purpose) */
> 
> If possible, don't add a new variable to 'dw_pcie' structure.
> Please find a way to set TD bit without adding a new variable to 'dw_pcie' structure'.

I can use pcie_is_ecrc_enabled() directly in place of pci->td. That 
should be fine right? BTW, curious to know if there is any specific 
reason behind asking not to add any new variables to 'dw_pcie' structure?

> 
> Best regards,
> Jingoo Han
> 
>>   };
>>
>>   #define to_dw_pcie_from_pp(port) container_of((port), struct dw_pcie, pp)
>> --
>> 2.17.1
> 
