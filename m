Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 196536CD626
	for <lists+linux-pci@lfdr.de>; Wed, 29 Mar 2023 11:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjC2JPP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Mar 2023 05:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbjC2JPD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Mar 2023 05:15:03 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ACB110E;
        Wed, 29 Mar 2023 02:15:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HYMq5Rt30Qw5tcOgzUTz108DkKXvd82qYOVVpmjji7Qv86kT0CStSlwoFXN2uM6AIxCcl5EYo5MjU6RG9hjLhrwAsa0BOAVbNPyKRjIouBGd1xoZaINzOJU7a7uZBNkH/l5a9ouB8yAKdFHHQgXhFpkDpptGXslzakC5ziRvjHwBon5Hioe8pW6wH3VYkQoJOW8oYpFBt5kw75W6jRW4xgjIn+5V8yjd9uhfo1zcdN8i7qexgLfGTa1+EjExZDt+uro1piJPRRDSGUd4/Z9qnd0Vjy8oHnRfrC2nsDvqC69hJGdPcBHJhcGzYQYCIdmICAykWVxnqBQEK1VcaGL6Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9AO6dyYuZsswLG2jZ5Y+lLDh8nbogVUYx1Ryt03QHT0=;
 b=AVT1zxLTddKPMWad+CskSQfJITpgX5DHtWnv5g0VzuTrGQNMs+ZG+f/bYm8mljwEjBQSa9TpEuAjyMVFDuBDr3+B6HgJBQzCaNIi7FhHxSEgOBIRmSx8aSoj7vv0C4P8wXWmiRDSwKuQo8yVMZ4Wasy/yDY6uXN1LTRPUIn7BP6uiAmsv4mxEY3iKIag9MFMmMj8W1VmOtqywZp+JLvre958rq4XjUFam34IgktFFSXERcXAR95cqR2gZ7yWf+55ozj6y2yqOGQBpJjMOW55L0COSols1RuYOuIek89ZfnvzAZHzxZ4GX2h9Bh2BDcbFlWhJkzR477HpkxOsOoIWlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9AO6dyYuZsswLG2jZ5Y+lLDh8nbogVUYx1Ryt03QHT0=;
 b=Z0YyAGxrhQgPRC6W8nW0sXakfIKVK4Ze1SDJYknmSFFczKHe5Jzq2Vyx3GcFJiCLiD0CDzU0YFzrKDC7gUtESFGIp/GDli2Bof1YRPhMAX2aFILM6oLQ+lwEejXyzFwj6SOXTiQSq7+Wxt4UxxlAWHcambIlGwNYQqaGIKA1lV6BgpyhWvAzUiUnZX6G/FAG/lKbz3y9RDztj8KahnrfMNfjWK35NS27ad/yJgQIKV7q/SJ3qy/nQyx1rx0Fhda6Lj0SYwWXQnFr/G6+7LoQDSLN38viFJdhIltZjWTbBacR/NYdKGUm3p243U9fNwx6bK0z6ibhhL77oU4B78APmw==
Received: from BN9PR03CA0426.namprd03.prod.outlook.com (2603:10b6:408:113::11)
 by DM4PR12MB7622.namprd12.prod.outlook.com (2603:10b6:8:109::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.28; Wed, 29 Mar
 2023 09:15:00 +0000
Received: from BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:113:cafe::82) by BN9PR03CA0426.outlook.office365.com
 (2603:10b6:408:113::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.43 via Frontend
 Transport; Wed, 29 Mar 2023 09:15:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT015.mail.protection.outlook.com (10.13.176.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.20 via Frontend Transport; Wed, 29 Mar 2023 09:15:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 29 Mar 2023
 02:14:43 -0700
Received: from [10.41.21.79] (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 29 Mar
 2023 02:14:37 -0700
Message-ID: <8d0e4e2f-a131-ca19-e5ae-ef2349623b39@nvidia.com>
Date:   Wed, 29 Mar 2023 14:44:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [Patch v4 10/10] PCI: tegra194: add interconnect support in
 Tegra234
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <treding@nvidia.com>, <krzysztof.kozlowski@linaro.org>,
        <dmitry.osipenko@collabora.com>, <viresh.kumar@linaro.org>,
        <rafael@kernel.org>, <jonathanh@nvidia.com>, <robh+dt@kernel.org>,
        <lpieralisi@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <mmaddireddy@nvidia.com>, <kw@linux.com>, <bhelgaas@google.com>,
        <vidyas@nvidia.com>, <sanjayc@nvidia.com>, <ksitaraman@nvidia.com>,
        <ishah@nvidia.com>, <bbasu@nvidia.com>,
        Sumit Gupta <sumitg@nvidia.com>
References: <20230328175350.GA2953686@bhelgaas>
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <20230328175350.GA2953686@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT015:EE_|DM4PR12MB7622:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e2ccf97-726d-4310-d043-08db303612d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v70Z5N2Ssl1pu0SG8BEZZkYN76IJ2x9gXFi7fA+lTzOkP8exs+GNa2Tr+m8miGu+rLzQhEN07XrLf629d117JIklBJ6rTtS6EUSDH4dzrjmle9bG5XSW4PlJLxL10zqMSkibXpdAzTlijk9nt99KGEkKcpXsnwzTkhV2eKb3H488kmXHfAZqxajTArobzDUHOwMSf2Gg9Fy3K0iM3wMxXNow9W6R3nf7kvdZwzyGkr6LIlG9VKWj3mXiihdIAN6myRX9XVr1z6Fi9s7R7AIyrgxwqu4MMxwQhMsP3CtjBl/jmgEl1gh1XCqdP1pGuzEt83gsi1R9H75nvy54fNDH3PYROhztk2nAT7dbLBw1ToMlxxMzBoz9IFshGVuheuv1qHCdBSxUHVXUOvzozDEmyFasuoxb3qlkbz1cfD6vUJIa5sjBKljn9OrfFRhaO3tj2yRrPRzKl3WKXcqL3jv6bOnjA8/FPGHQ5ukcpXTXWnNUr4HEEN/dYhccMfcewth3yeH48shf6RzJRPSts2UqRpkXG/lhwOp7a3HU2wyXG7XhiMTZfRepjWTxwLzZIhP6ErrXwOpS1tazf3AVhbwmNrHfqSk4xfSkVfsMO+zdm6KhEnmpTQgFFZu5uOmilyFjN5p0elMg+ipbBSKq8b35JAtiEZIzquwawjt0XkV1kd9jhbIm2HahCqAXyxjXwSoS7JvtEr+7MCRmweSy6EyPoty3TDtJ/KhV91dUVsQRYqIYfrMrdwghgDg6eJqTRWh7TCcnFqoi6L7KBw1UgQB4b/SJf/MiwkD92rsznpb6xbYZ6ysvpc+25gm9Z2Gq7yE+
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(396003)(136003)(376002)(451199021)(36840700001)(40470700004)(46966006)(8936002)(31686004)(2906002)(47076005)(336012)(83380400001)(426003)(2616005)(36860700001)(86362001)(41300700001)(31696002)(36756003)(40460700003)(7636003)(5660300002)(82740400003)(356005)(40480700001)(34020700004)(54906003)(478600001)(8676002)(70586007)(6916009)(70206006)(4326008)(7416002)(107886003)(16526019)(6666004)(82310400005)(186003)(53546011)(316002)(26005)(16576012)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 09:15:00.3461
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e2ccf97-726d-4310-d043-08db303612d6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7622
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 28/03/23 23:23, Bjorn Helgaas wrote:
> External email: Use caution opening links or attachments
> 
> 
> Capitalize subject line please, to match pcie-tegra194.c history.
> 
> On Mon, Mar 27, 2023 at 09:44:26PM +0530, Sumit Gupta wrote:
>> Add support to request DRAM bandwidth with Memory Interconnect
>> in Tegra234 SoC. The DRAM BW required for different modes depends
>> on speed (Gen-1/2/3/4) and width/lanes (x1/x2/x4/x8).
>>
>> Suggested-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> ---
>>   drivers/pci/controller/dwc/pcie-tegra194.c | 40 +++++++++++++++++-----
>>   1 file changed, 32 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
>> index 09825b4a075e..d2513c9d3feb 100644
>> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
>> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
>> @@ -15,6 +15,7 @@
>>   #include <linux/gpio.h>
>>   #include <linux/gpio/consumer.h>
>>   #include <linux/interrupt.h>
>> +#include <linux/interconnect.h>
> 
> Almost alphabetized, swap interrupt.h and interconnect.h.
> 
Ok, will swap.

>>   #include <linux/iopoll.h>
>>   #include <linux/kernel.h>
>>   #include <linux/module.h>
>> @@ -287,6 +288,7 @@ struct tegra_pcie_dw {
>>        unsigned int pex_rst_irq;
>>        int ep_state;
>>        long link_status;
>> +     struct icc_path *icc_path;
>>   };
>>
>>   static inline struct tegra_pcie_dw *to_tegra_pcie(struct dw_pcie *pci)
>> @@ -309,6 +311,24 @@ struct tegra_pcie_soc {
>>        enum dw_pcie_device_mode mode;
>>   };
>>
>> +static void tegra_pcie_icc_set(struct tegra_pcie_dw *pcie)
>> +{
>> +     struct dw_pcie *pci = &pcie->pci;
>> +     u32 val, speed, width;
>> +
>> +     val = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKSTA);
>> +
>> +     speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, val);
>> +     width = FIELD_GET(PCI_EXP_LNKSTA_NLW, val);
>> +
>> +     val = width * (PCIE_SPEED2MBS_ENC(pcie_link_speed[speed]) / BITS_PER_BYTE);
>> +
>> +     if (icc_set_bw(pcie->icc_path, MBps_to_icc(val), 0))
>> +             dev_err(pcie->dev, "can't set bw[%u]\n", val);
>> +
>> +     clk_set_rate(pcie->core_clk, pcie_gen_freq[speed - 1]);
> 
> Array bounds violation; PCI_EXP_LNKSTA_CLS is 0x000f, so possible
> speed (CLS) values are 0..0xf and "speed - 1" values are -1..0xe.
> 
> pcie_gen_freq[] is of size 4 (valid indices 0..3).
> 
> I see that you're just *moving* this code, but might as well fix it.
> 
Thank you for the review.
Will include the below change in the same patch. Please let me know if 
any issue.

  -       clk_set_rate(pcie->core_clk, pcie_gen_freq[speed - 1]);
  +       if (speed && (speed <= ARRAY_SIZE(pcie_gen_freq)))
  +               clk_set_rate(pcie->core_clk, pcie_gen_freq[speed - 1]);
  +       else
  +               clk_set_rate(pcie->core_clk, pcie_gen_freq[0]);

Thank you,
Sumit Gupta

>> +}
>> +
>>   static void apply_bad_link_workaround(struct dw_pcie_rp *pp)
>>   {
>>        struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>> @@ -452,14 +472,12 @@ static irqreturn_t tegra_pcie_ep_irq_thread(int irq, void *arg)
>>        struct tegra_pcie_dw *pcie = arg;
>>        struct dw_pcie_ep *ep = &pcie->pci.ep;
>>        struct dw_pcie *pci = &pcie->pci;
>> -     u32 val, speed;
>> +     u32 val;
>>
>>        if (test_and_clear_bit(0, &pcie->link_status))
>>                dw_pcie_ep_linkup(ep);
>>
>> -     speed = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKSTA) &
>> -             PCI_EXP_LNKSTA_CLS;
>> -     clk_set_rate(pcie->core_clk, pcie_gen_freq[speed - 1]);
>> +     tegra_pcie_icc_set(pcie);
