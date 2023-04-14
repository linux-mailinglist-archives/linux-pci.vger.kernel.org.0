Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACE386E2151
	for <lists+linux-pci@lfdr.de>; Fri, 14 Apr 2023 12:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjDNKyd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Apr 2023 06:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjDNKyc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Apr 2023 06:54:32 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061f.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::61f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9532719;
        Fri, 14 Apr 2023 03:54:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=izIz//5ZdFyt9IFkHKxYXLgqu/PZs7zwe1vvQEjbcQrdNhFCGxXyvg6pwb1P5rXNz9vjOfpk2n+rqHAWDlAIOQiJaydNhbV2Jb3BEA2baztuXz0phd9Di/uMGsIYRzPkx/pvtb14d4lMgRdIQ3DqWAAM17fYg5Nf9/QAJaJ4VctdbCQyDz6YiwvSfU3lb35YW2pjkUOxZsZGKUvCetW5qgC+YXuaC/xuDeEn6Hfqzoah8C+KIBF9ubloTd9LzxkUinw2HI2Npe7XFOzuDmCxs5AwhQCNj3k4sBHDxj9hkPsri6NE9hOaHPporutUCaJwxQCNvaKDvXbgxKMGQrxTzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2N0Hz6Bg5g1ZA1jqc4u0pI2rS42RbEExSWRpoTUZYxQ=;
 b=E+7xp2bXPU+2GBNzExDW/lq7EvqxjzOsiMnBsXIlnKOY59caL42MKU89dIY2ZVW95GV6oFyRc+Pup7ZFkf4qaAN1r6v4BjZN8ARbppeiP9MiVXeUk/bPAzkDlcsUTT+ojBhEzaDlxSXyh2nH2kMQLbO1tA77mGAnoDXg5r5XtgzNreQPVxJxPzESF4Kf0U1cqZ9+leckhw1JGN6ijxSOlt1FSj/PxUD7MSfCi+1msZ7x1H77nBZgUDzMug/F9ae0xZ8oJPdi5Iz3vF4YTpXhRnsW8d+7LpmjHAK79dQv/YRr8ssUa5O9PlwI3mQpr0dEp3LjiVuT29Tx9lQd0p68Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2N0Hz6Bg5g1ZA1jqc4u0pI2rS42RbEExSWRpoTUZYxQ=;
 b=U6I1Zc11xHkmG5CqD8qZQkxc/3biOoqaYne1OgP6ot/3cfU2XDoHcoomPkbfj30Z0FKDVG56Zv6UI0N/LrBlbPQOlktuPCwv+MX78u1Vl+NyY2jIkwZ2x/eE5pU4aqaES/alKs3KVRpuC7ncHdK3Ze8DuoYFAjx/FPqVIpbIr4l2LvqNOser1rbfMragn2qgQyRa+6ICaYbIXwEqiq6AwzChIg49jfr/IjoXJf3iaCjTMWkyZF3PP4J0fXSMjM18I0bWmzm9e16e2CKy3LQU/TXfqHBouZVxii01zuDv1cligRWw33G1sZEqEXM86kpRagAOBaFd6mPA+jB3nCDKKw==
Received: from MW4PR02CA0011.namprd02.prod.outlook.com (2603:10b6:303:16d::28)
 by BY5PR12MB4936.namprd12.prod.outlook.com (2603:10b6:a03:1d4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 10:54:26 +0000
Received: from CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::38) by MW4PR02CA0011.outlook.office365.com
 (2603:10b6:303:16d::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.36 via Frontend
 Transport; Fri, 14 Apr 2023 10:54:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT033.mail.protection.outlook.com (10.13.174.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.36 via Frontend Transport; Fri, 14 Apr 2023 10:54:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 14 Apr 2023
 03:54:13 -0700
Received: from [10.41.21.79] (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 14 Apr
 2023 03:54:05 -0700
Message-ID: <7ce0a62a-546e-8b01-abe7-598012a6ac2d@nvidia.com>
Date:   Fri, 14 Apr 2023 16:24:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [Patch v6 8/9] PCI: tegra194: Add interconnect support in
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
References: <20230411110002.19824-1-sumitg@nvidia.com>
 <20230411110002.19824-9-sumitg@nvidia.com> <ZDgXGCJQAHpLTw9S@lpieralisi>
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <ZDgXGCJQAHpLTw9S@lpieralisi>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT033:EE_|BY5PR12MB4936:EE_
X-MS-Office365-Filtering-Correlation-Id: b060692f-c031-4fef-86db-08db3cd69d8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ltKiJ6MoDqfpCQ289J2nm7Au0OzeYNRa/JCEThP7q4iCgoDstyZNcLyrlnQb2kQMe6D5PO72YksMdDN0KpPYh4aHDIfmpxIzkwwCfK7RkjMzIzBOCqfCb36h9EQrgR/Ln6JUTjop39ST4brC1lwqPYAA0la1hQKp3dmnDG6aeIvDI6plGPh+V0CetAWN5LN77VBCM0x2WCvnamDu+OL/QIHwJovjd4OcxW2XwqO/0UOeAPU+AJhHaGW3yGQlTWTr7F422KSa8qjqE1glX8FuwVSPT8dCBENRUaBc/LZUU4XxyJ5BKxjPj6XM0JAoZk2d6Pxo2tDvhhEVCxrNgrF8I25D7I3Dw5jd0ybbmXI0l8tlpooriGpO1vit+trpcpmXIZ6PUQ6TVg03vE0/1/g93LnN6dJxTsVtyRLUwTtNbzxfxnnGtNVa6096KanCWk+Yl3ywsDqkeajPj4ddz8vyAdE2pavkNztmHDDrgW+dVQ9qh4haeDWyiOX5zLRK6YVBhPd6imH7nkHgszM8ECgq74KI6apQpN7D1QjuiRDrL/tykv+MDZbESi+MVqGfeI4Mb+CaPYxTtiYZslv+DYz0x+vIeSYVsbLBIRUvxDz1L/uauzyRrX8l79DjEzdMm9dLc6Kta/IBwMfAvfabcrTXPYmmGEmfMlhYUH3tMcj0EJTQSDdCmkJG/fz7eTziMBbEo3jXWUvcM3TNFaJqdrHnMNPfyUtWrNzzzVln01b/8QjKgY2EWY4FduibK/ionxyoZ6zM27EkcKAfOC0+VXeGWn/QVjvf+mZCIspACKoYDpY2Yq7eCOr8dVzUf7Yz9Qvf
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(376002)(136003)(451199021)(46966006)(36840700001)(40470700004)(82310400005)(36756003)(40480700001)(40460700003)(478600001)(34020700004)(54906003)(8676002)(16576012)(6666004)(356005)(7636003)(41300700001)(8936002)(70206006)(316002)(4326008)(82740400003)(16526019)(6916009)(36860700001)(336012)(47076005)(426003)(83380400001)(2616005)(70586007)(31686004)(186003)(53546011)(26005)(107886003)(86362001)(5660300002)(7416002)(2906002)(31696002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 10:54:26.5264
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b060692f-c031-4fef-86db-08db3cd69d8a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4936
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 13/04/23 20:22, Lorenzo Pieralisi wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Tue, Apr 11, 2023 at 04:30:01PM +0530, Sumit Gupta wrote:
>> Add support to request DRAM bandwidth with Memory Interconnect
>> in Tegra234 SoC. The DRAM BW required for different modes depends
>> on speed (Gen-1/2/3/4) and width/lanes (x1/x2/x4/x8).
>> Currently, no latency is observed in data transfer with PCI as the
>> DRAM Freq is always set to max. But that results in high power
>> consumption. Now for Tegra234, we are enabling the dynamic scaling
>> of the DRAM Freq based on requests from Clients instead of running
>> at the max Freq always. This change does that for PCI MC client.
> 
> I am sorry but this is still unclear to me. The sentence above makes
> me think that you are *adding* latency to the data transfer trading
> it with lower power consumption; probably that's a wrong parsing of
> what you are saying - so please explain what you want to say
> with "no latency is observed" and whether this patch changes that
> (which is not allowed because that would count as a regression).
> 
> Thanks,
> Lorenzo
> 

Rephrased as below. Please suggest if it is clear now.

Add support to request DRAM bandwidth with Memory Interconnect in
Tegra234 SoC. The DRAM BW required for different modes depends on
speed (Gen-1/2/3/4) and width/lanes (x1/x2/x4/x8).
Currently, the DRAM freq is always set to max but that results in
higher power consumption. Memory Interconnect feature adds capability
for MC clients to request BW and scale the DRAM freq dynamically to
provide the requested BW.

Thank you,
Sumit Gupta

>>
>> Suggested-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> ---
>>   drivers/pci/controller/dwc/pcie-tegra194.c | 51 +++++++++++++++-------
>>   1 file changed, 35 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
>> index e6eec85480ca..4fdadc7b045f 100644
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
>> @@ -288,6 +289,7 @@ struct tegra_pcie_dw {
>>        unsigned int pex_rst_irq;
>>        int ep_state;
>>        long link_status;
>> +     struct icc_path *icc_path;
>>   };
>>
>>   static inline struct tegra_pcie_dw *to_tegra_pcie(struct dw_pcie *pci)
>> @@ -310,6 +312,27 @@ struct tegra_pcie_soc {
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
>> @@ -453,18 +476,12 @@ static irqreturn_t tegra_pcie_ep_irq_thread(int irq, void *arg)
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
>> -
>> -     if (speed >= ARRAY_SIZE(pcie_gen_freq))
>> -             speed = 0;
>> -
>> -     clk_set_rate(pcie->core_clk, pcie_gen_freq[speed]);
>> +     tegra_pcie_icc_set(pcie);
>>
>>        if (pcie->of_data->has_ltr_req_fix)
>>                return IRQ_HANDLED;
>> @@ -950,9 +967,9 @@ static int tegra_pcie_dw_host_init(struct dw_pcie_rp *pp)
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
>> @@ -1023,13 +1040,7 @@ static int tegra_pcie_dw_start_link(struct dw_pcie *pci)
>>                goto retry_link;
>>        }
>>
>> -     speed = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKSTA) &
>> -             PCI_EXP_LNKSTA_CLS;
>> -
>> -     if (speed >= ARRAY_SIZE(pcie_gen_freq))
>> -             speed = 0;
>> -
>> -     clk_set_rate(pcie->core_clk, pcie_gen_freq[speed]);
>> +     tegra_pcie_icc_set(pcie);
>>
>>        tegra_pcie_enable_interrupts(pp);
>>
>> @@ -2233,6 +2244,14 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
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
