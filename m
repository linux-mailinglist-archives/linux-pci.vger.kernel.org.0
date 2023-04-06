Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D976D96E1
	for <lists+linux-pci@lfdr.de>; Thu,  6 Apr 2023 14:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjDFMOV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Apr 2023 08:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjDFMOU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Apr 2023 08:14:20 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA481985;
        Thu,  6 Apr 2023 05:14:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ffhjl/JnaX/dtweEhSogyGDvFJUKIxSp/qJbUWN/waZ0uAoXc+jjHzfEzwf3swzy1++dQfwrjg/lX8CGt5vlancCmpnwzS2rPbt+KV4QaO27CeWP6K9MqVxQWJbx24P1wC4pPB2LAUZEISem3UuCwnJ6wg9DRVAf0g/IjkA3adkjHD/dbsl/4oYpKZcdb0FlWTjXTyjNYLqvrQhHae5+F6BQX++MLVJ/YYU/f6KINqVhnQnlEQpo3yty1bUSYvuLn3Cj8J/vuikbmDTQoxH7ll0nyofxtXasFOm8aC4RPf+Re42Y75ofvAG/fMe4rvXmoTm3WiZRw8TplivZ/xiiLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qUCfkxBKDqDe9oYjj8GVGzzX5dXa0m4gxm0V8iZbKTM=;
 b=K+MRUH8u+9iCxJUee+h0tgQRZwNVGQqlWNb4KkInFwCuJKbU9NXUCWfNvDLhSasS/tTcHwkjwDooubL1QBL4ApkLqUERMJk5dnHABY5XJb2Nc5mIz4B9W0PCZbZglFb3hqcwMPyMVBAfmdy1q8yng/5+lUVicz+/kehdsXsIFTGwFVvgWFBqrr2PR3wXE8F++cRB0VV1M7rTo/QwXPef+w2rUgITtCW3lNog6T8dNFYoR2mAXjmP9qZyNtbPFK/LaSGJex2VzpNmCXrXEoWtH+RpcbwPJs5Cj+47FgAhBOt41aR3Ab4rRr5la92dDRXtVMZVthObRLKrj+PCg1R72A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qUCfkxBKDqDe9oYjj8GVGzzX5dXa0m4gxm0V8iZbKTM=;
 b=BxI07cjj9BpLYVdgRLhQlzaTzDzvBcpSrr0yogrE2/pRpNwP+DOnVJ47GN4wCOZHQeH/isIfe4kgzwK9G0ipF9iT0dK+c2BpsiVJZ8+EQgqRKb2EbhJcajJw485qaCDYz5jLtqSwDV9cU2nyZ3mGdySA0HNl9+/dUsvaAz3LmRCBS+Ak72p2dPrAbtku5d/cOcJnqusolFRu3CI5tcAchA4fYHdieZ25hnX/MVfgF6aiQThVq7kmZMgALm/Z/iaPxsZFymAX4B7DP0OTIcE9/Bo1MfIY0XKl3IMxF44DYooWm1OOhpe9YH2AvILNqfJS3wH12plETDmrAQCvZLAZOQ==
Received: from MW4PR03CA0167.namprd03.prod.outlook.com (2603:10b6:303:8d::22)
 by DM4PR12MB5392.namprd12.prod.outlook.com (2603:10b6:5:39f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Thu, 6 Apr
 2023 12:14:16 +0000
Received: from CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::83) by MW4PR03CA0167.outlook.office365.com
 (2603:10b6:303:8d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Thu, 6 Apr 2023 12:14:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT014.mail.protection.outlook.com (10.13.175.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6277.30 via Frontend Transport; Thu, 6 Apr 2023 12:14:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 6 Apr 2023
 05:14:07 -0700
Received: from [10.41.21.79] (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 6 Apr 2023
 05:13:59 -0700
Message-ID: <141f83be-e08b-9c0b-8939-554e3d5ed37d@nvidia.com>
Date:   Thu, 6 Apr 2023 17:43:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [Patch v5 7/8] PCI: tegra194: add interconnect support in
 Tegra234
Content-Language: en-US
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
CC:     <treding@nvidia.com>, <krzysztof.kozlowski@linaro.org>,
        <dmitry.osipenko@collabora.com>, <viresh.kumar@linaro.org>,
        <rafael@kernel.org>, <jonathanh@nvidia.com>, <robh+dt@kernel.org>,
        <helgaas@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <mmaddireddy@nvidia.com>, <kw@linux.com>, <bhelgaas@google.com>,
        <vidyas@nvidia.com>, <sanjayc@nvidia.com>, <ksitaraman@nvidia.com>,
        <ishah@nvidia.com>, <bbasu@nvidia.com>,
        Sumit Gupta <sumitg@nvidia.com>
References: <20230330133354.714-1-sumitg@nvidia.com>
 <20230330133354.714-8-sumitg@nvidia.com> <ZC1Rnrb0MObR5S42@lpieralisi>
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <ZC1Rnrb0MObR5S42@lpieralisi>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT014:EE_|DM4PR12MB5392:EE_
X-MS-Office365-Filtering-Correlation-Id: b3547d38-da55-42b4-4228-08db36987101
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /Rf7JeL3M8lr6mZ2+30qZM+iLv0DglIjLNEI2nSxKxAVbnjnD49bJyA9+f6LcsI6EB5ZJzlnM3REVpCu8O27r1qhZ0/oGEnmiQlqcT3+uHIceAuuGFvL/AkUFBDNnCBT9BqN+nTe0y1oC9VUliOSWiBHe9Y1W66jmWmpYWN8vGKvGkaH5zZhk6IkrRLe599tCUUUcAqee+YJlNjYoAxkuTHobijSjSzUzgSEp30IqQJtHRxsmae4n/avOyLfv//Kud7kue2sPlTLrwmktF0qh8ktgwgqZG45RW6EkTWh6UYO6hFfqypOaeZxGN0x6tTUPQ/eruoYS0lthkRSyJFDNsA/lqxU8Ub/DMlHaE65EEL43JR3Kdlh2Q8bZYlUBCcqIlLIoqeeLbBlcJ2aIjRMuYvXlpQ0ijwbS0Ldf6x0qc28W5A4P96NMPGADrGBeksAUCF2t7pqR7NuBszS9rucBYnXKlWRVJIHz/fCLcZVzyXiQ0gR/+t/Gg3uU22CNqObR/BNlmsoG0LbVXkeDGCA/7i57ODVddfItbE9GnwrtNPqYY7LV5tZ/dPbmVhYeoViGqjJlbahOaEjDzM1EHkijKrCKobEiDG89LYYB8BeTOV3Hv8FX9YWm4z/ekJuO1souKIjfmUKC/Upb4wiZ/O7xC3fPAJMHB3qhfwftdozeGv8yitYbU5o+KZ9derqZEosgjkFF+lX1B5N46YQMJG3chA2k7mPVD9snd/nPJpsov9GRKXq/dxrLD+zvJwtN/+SqB3nR2lHpI4JyzM9sKFTdF5Bl5rvw5YVJ4txMl93LpE=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(396003)(376002)(451199021)(46966006)(36840700001)(40470700004)(8936002)(41300700001)(316002)(54906003)(5660300002)(16576012)(2906002)(4326008)(186003)(70206006)(70586007)(6916009)(8676002)(478600001)(7416002)(31686004)(16526019)(31696002)(107886003)(6666004)(7636003)(40460700003)(26005)(83380400001)(356005)(2616005)(336012)(426003)(47076005)(36756003)(40480700001)(82310400005)(82740400003)(36860700001)(86362001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 12:14:16.0331
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3547d38-da55-42b4-4228-08db36987101
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5392
X-Spam-Status: No, score=-1.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> 
> You should still capitalize the subject.
> 
> "PCI: tegra194: Add interconnect.."
> 
Sure.

> On Thu, Mar 30, 2023 at 07:03:53PM +0530, Sumit Gupta wrote:
>> Add support to request DRAM bandwidth with Memory Interconnect
>> in Tegra234 SoC. The DRAM BW required for different modes depends
>> on speed (Gen-1/2/3/4) and width/lanes (x1/x2/x4/x8).
>>
>> Suggested-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> 
> You should add a Link to the relevant lore archive, I am
> pretty sure Bjorn chimed in too.
> 
Sure.

> This patch does too many things at once; more importantly it
> does *not* explain why we request memory bandwidth and why it
> is required and *safe* given that the current code works so far.
> 
> So:
> 
> patch 1: fix the array overflow issues with the current code
> patch 2: add memory bandwidth interconnect support
> 
> Thanks,
> Lorenzo
> 
Thank you for the review.
I will split this patch into two and add the info as sugested in v6.

Will spin a v6 soon if there is no further comment.

Thanks,
Sumit

>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> ---
>>   drivers/pci/controller/dwc/pcie-tegra194.c | 44 ++++++++++++++++++----
>>   1 file changed, 36 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
>> index 09825b4a075e..89d829a946ee 100644
>> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
>> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
>> @@ -14,6 +14,7 @@
>>   #include <linux/delay.h>
>>   #include <linux/gpio.h>
>>   #include <linux/gpio/consumer.h>
>> +#include <linux/interconnect.h>
>>   #include <linux/interrupt.h>
>>   #include <linux/iopoll.h>
>>   #include <linux/kernel.h>
>> @@ -223,6 +224,7 @@
>>   #define EP_STATE_ENABLED     1
>>
>>   static const unsigned int pcie_gen_freq[] = {
>> +     GEN1_CORE_CLK_FREQ,   /* PCI_EXP_LNKSTA_CLS == 0; undefined */
>>        GEN1_CORE_CLK_FREQ,
>>        GEN2_CORE_CLK_FREQ,
>>        GEN3_CORE_CLK_FREQ,
>> @@ -287,6 +289,7 @@ struct tegra_pcie_dw {
>>        unsigned int pex_rst_irq;
>>        int ep_state;
>>        long link_status;
>> +     struct icc_path *icc_path;
>>   };
>>
>>   static inline struct tegra_pcie_dw *to_tegra_pcie(struct dw_pcie *pci)
>> @@ -309,6 +312,27 @@ struct tegra_pcie_soc {
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
>> +     if (speed >= ARRAY_SIZE(pcie_gen_freq))
>> +             speed = 0;
>> +
>> +     clk_set_rate(pcie->core_clk, pcie_gen_freq[speed]);
>> +}
>> +
>>   static void apply_bad_link_workaround(struct dw_pcie_rp *pp)
>>   {
>>        struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>> @@ -452,14 +476,12 @@ static irqreturn_t tegra_pcie_ep_irq_thread(int irq, void *arg)
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
>>
>>        if (pcie->of_data->has_ltr_req_fix)
>>                return IRQ_HANDLED;
>> @@ -945,9 +967,9 @@ static int tegra_pcie_dw_host_init(struct dw_pcie_rp *pp)
>>
>>   static int tegra_pcie_dw_start_link(struct dw_pcie *pci)
>>   {
>> -     u32 val, offset, speed, tmp;
>>        struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
>>        struct dw_pcie_rp *pp = &pci->pp;
>> +     u32 val, offset, tmp;
>>        bool retry = true;
>>
>>        if (pcie->of_data->mode == DW_PCIE_EP_TYPE) {
>> @@ -1018,9 +1040,7 @@ static int tegra_pcie_dw_start_link(struct dw_pcie *pci)
>>                goto retry_link;
>>        }
>>
>> -     speed = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKSTA) &
>> -             PCI_EXP_LNKSTA_CLS;
>> -     clk_set_rate(pcie->core_clk, pcie_gen_freq[speed - 1]);
>> +     tegra_pcie_icc_set(pcie);
>>
>>        tegra_pcie_enable_interrupts(pp);
>>
>> @@ -2224,6 +2244,14 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
>>
>>        platform_set_drvdata(pdev, pcie);
>>
>> +     pcie->icc_path = devm_of_icc_get(&pdev->dev, "write");
>> +     ret = PTR_ERR_OR_ZERO(pcie->icc_path);
>> +     if (ret) {
>> +             tegra_bpmp_put(pcie->bpmp);
>> +             dev_err_probe(&pdev->dev, ret, "failed to get write interconnect\n");
>> +             return ret;
>> +     }
>> +
>>        switch (pcie->of_data->mode) {
>>        case DW_PCIE_RC_TYPE:
>>                ret = devm_request_irq(dev, pp->irq, tegra_pcie_rp_irq_handler,
>> --
>> 2.17.1
>>
