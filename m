Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0C512D2377
	for <lists+linux-pci@lfdr.de>; Tue,  8 Dec 2020 07:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgLHGNI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Dec 2020 01:13:08 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:17214 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbgLHGNI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Dec 2020 01:13:08 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fcf194b0000>; Mon, 07 Dec 2020 22:12:27 -0800
Received: from [10.40.102.151] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 8 Dec
 2020 06:12:16 +0000
Subject: Re: [PATCH V5 5/5] PCI: tegra: Disable LTSSM during L2 entry
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <lorenzo.pieralisi@arm.com>, <robh+dt@kernel.org>,
        <bhelgaas@google.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <amanharitsh123@gmail.com>,
        <dinghao.liu@zju.edu.cn>, <kw@linux.com>,
        <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
References: <20201207203730.GA2289423@bjorn-Precision-5520>
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <4343a216-e583-6823-1c15-bd0efd64c026@nvidia.com>
Date:   Tue, 8 Dec 2020 11:42:10 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20201207203730.GA2289423@bjorn-Precision-5520>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1607407947; bh=jfYakN3OOCnq6wVg1mrOEiYgJ9rsfC1HNUK9WgYrKN4=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=qX1ZkIOVjp3l6LNmFGr4j85niHkJNdsPQKi1QnMd0nivPsW7rGna21mechKe40Gau
         YO0UEpaHkwIxvoDVoWtiqxYzh6ON2m2FiqL1/2fvtU7k1I6vzFV4IOmlD3cJFa9OUy
         qdSsghDBo/TM3bontdnRXoxwgqZwYymxeSWlVkUj4/FhJ+Y4ErPY6K4kyDrGtAFgAk
         u4EML67NgrKVxcBJ6FpIb2xqw0DSL8mC6KJwsaSAZIbxHVoE4G+sGp2VRohLXTUHWC
         D2L67uKpPRN/FJ5LaWecfvnpYrcv3A5eaacqWTrEIabF3KiKPyAUx1cgh+wGhPX8bM
         IZcx7BxpE1N9g==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 12/8/2020 2:07 AM, Bjorn Helgaas wrote:
> External email: Use caution opening links or attachments
> 
> 
> [+cc Jingoo, Gustavo]
> 
> On Thu, Dec 03, 2020 at 07:04:51PM +0530, Vidya Sagar wrote:
>> PCIe cards like Marvell SATA controller and some of the Samsung NVMe
>> drives don't support taking the link to L2 state. When the link doesn't
>> go to L2 state, Tegra194 requires the LTSSM to be disabled to allow PHY
>> to start the next link up process cleanly during suspend/resume sequence.
>> Failing to disable LTSSM results in the PCIe link not coming up in the
>> next resume cycle.
> 
> Is this a Tegra194-specific issue, or will other DWC-based controllers
> need a similar change?
This is a Tegra194 specific issue.

Thanks,
Vidya Sagar
> 
>> Tested-by: Thierry Reding <treding@nvidia.com>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> Acked-by: Thierry Reding <treding@nvidia.com>
>> ---
>> V5:
>> * Added Tested-by and Acked-by from Thierry Reding
>>
>> V4:
>> * New patch in this series
>>
>>   drivers/pci/controller/dwc/pcie-tegra194.c | 16 +++++++++-------
>>   1 file changed, 9 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
>> index f4109d71f20b..5597b2a49598 100644
>> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
>> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
>> @@ -1506,6 +1506,14 @@ static void tegra_pcie_dw_pme_turnoff(struct tegra_pcie_dw *pcie)
>>                data &= ~APPL_PINMUX_PEX_RST;
>>                appl_writel(pcie, data, APPL_PINMUX);
>>
>> +             /*
>> +              * Some cards do not go to detect state even after de-asserting
>> +              * PERST#. So, de-assert LTSSM to bring link to detect state.
>> +              */
>> +             data = readl(pcie->appl_base + APPL_CTRL);
>> +             data &= ~APPL_CTRL_LTSSM_EN;
>> +             writel(data, pcie->appl_base + APPL_CTRL);
>> +
>>                err = readl_poll_timeout_atomic(pcie->appl_base + APPL_DEBUG,
>>                                                data,
>>                                                ((data &
>> @@ -1513,14 +1521,8 @@ static void tegra_pcie_dw_pme_turnoff(struct tegra_pcie_dw *pcie)
>>                                                APPL_DEBUG_LTSSM_STATE_SHIFT) ==
>>                                                LTSSM_STATE_PRE_DETECT,
>>                                                1, LTSSM_TIMEOUT);
>> -             if (err) {
>> +             if (err)
>>                        dev_info(pcie->dev, "Link didn't go to detect state\n");
>> -             } else {
>> -                     /* Disable LTSSM after link is in detect state */
>> -                     data = appl_readl(pcie, APPL_CTRL);
>> -                     data &= ~APPL_CTRL_LTSSM_EN;
>> -                     appl_writel(pcie, data, APPL_CTRL);
>> -             }
>>        }
>>        /*
>>         * DBI registers may not be accessible after this as PLL-E would be
>> --
>> 2.17.1
>>
