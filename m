Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 650496ECC79
	for <lists+linux-pci@lfdr.de>; Mon, 24 Apr 2023 15:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbjDXNDG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Apr 2023 09:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjDXNDF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Apr 2023 09:03:05 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C64E358E;
        Mon, 24 Apr 2023 06:03:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EhIzf2YI9+VzstIXk0Q5aTx5xt3DsdzJO9+oMnEeNTcPdEk8avPNmEUQIyezAAdElIZU2sRUkr+lWpyOX6kNLIfb83wur/61nE6HT/ei+Yx/6xF+6I4tCAlbPwh24PAOKMMtSFegB/WVbrIAHmYNlcKgtSlhksiw+zpqmkJYXwWSu6aYZ/F9Dlw6xjp3xFJwkPR5Z0pHT5ZmDrn49M7CpX6/Ssn7MlbDsFdofEAj7mWHr54UfQPhTHTG+OFMaeZNFcjQDsnoa7rae78RMUE0cO4lHkvRkGgQ7topetOqhx2bnyNxkilWybkJ1OJi0D0g56bdaYds1bMtchgHW/RalA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+TmGxs+VxSNvjaNL4uZYNU3QmebfhaCMAcXlWXwMViI=;
 b=GoEgP1hi8yHGNwQ86Ww1ZmRt7Jk33gX9yTEiHKCLfcX8nv8TIsgyhKuze6ZIvEwEFfDJwpWXuL3ajqb0c8nd4YD/0QrTv9DLveUunLKQo/QA5HKQn5OLHp/NEOkrAE6gTjgp2AjvEqHpA4eE99m+r/FPh415ttLRNAVrf2zcT78gqckkIPp2pvJGzhoBFR3RVnaiLPjdx6z4XdQo1reaU8+1ncJX6MbGxzzsXEHELTygx/qhr6jRPMmImnBByNmIOTnR+bNOD9VW5ve7sB5ASJUOX9FkQTxISEZpjGtvOt+ZoRpOimcQ7kUeMCvS1kDj1sbenkH8NQiUC+EHqYsMaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+TmGxs+VxSNvjaNL4uZYNU3QmebfhaCMAcXlWXwMViI=;
 b=aO+ppxGzkDPpgAR06/HsjNEj9JrRXCFRu/gfKF7ktkbkOA22LNRFYJGmyaYlfcPOfi6/kJaIJWeLy+Z9Fh7uhsyCzeKDoZHKhwkw1cpkLC0AXj+GKUc8+iRbC7fOPH3mfRqxu3l9mXyFKSAxFB55w1ITjLiB4N57dRWsN1qkG0ErVpluDkx+wtrOsQrLmqXiHRHy0WtMXJ8WX6XX/cHGaCjGnCNOWzKaaOCwEujqekq7cdWM4Z3SWWAFcmhmERS8m1Xx3R4i2PMO97K84Aimh54bZa07Z3j6FZRbFP2fwQdPXj8Cmg0dk3eD/bWaaBxGv2LeVjEZs6AI6GUFVrauEg==
Received: from DS7PR07CA0011.namprd07.prod.outlook.com (2603:10b6:5:3af::22)
 by SA3PR12MB7974.namprd12.prod.outlook.com (2603:10b6:806:307::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.32; Mon, 24 Apr
 2023 13:02:58 +0000
Received: from DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3af:cafe::a) by DS7PR07CA0011.outlook.office365.com
 (2603:10b6:5:3af::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33 via Frontend
 Transport; Mon, 24 Apr 2023 13:02:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT008.mail.protection.outlook.com (10.13.172.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.18 via Frontend Transport; Mon, 24 Apr 2023 13:02:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 24 Apr 2023
 06:02:45 -0700
Received: from [10.41.21.79] (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 24 Apr
 2023 06:02:39 -0700
Message-ID: <51807461-5454-9997-a6f6-3d8bb63a4e3a@nvidia.com>
Date:   Mon, 24 Apr 2023 18:32:37 +0530
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
 <7ce0a62a-546e-8b01-abe7-598012a6ac2d@nvidia.com>
 <ZEKLaveXizeptIIh@lpieralisi>
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <ZEKLaveXizeptIIh@lpieralisi>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT008:EE_|SA3PR12MB7974:EE_
X-MS-Office365-Filtering-Correlation-Id: 2927d829-0151-4668-2e6a-08db44c439f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ycn/m7yXI++0Dp29cKTVuC3op/MM30wmGgp/1V7GHOQUpe46UwdQnKoADsU0BbC14oqVzmmV/G47jmb02pk2EFfsapFSdsLEHOzs3cc/oX7a9Nhimae+HRnXhg3o8t3WvFZd/6KQuRMb7C6UqZzPGOmHo4GakQWQoPTLKwtG1ftpQWqsoXoGM6GBEOLV23Hw0O4S3WdpnfkYZDkKGaZD7xNKY9zYfSvDqctLu1Fio/3YER6fi8yHktzlartRlZGfz23u9wW7qfYLx0OMzmgAWS3yg1xxOc9IijLW8VhJxVT4wF06phy9FhtFqfuUfFjFw9X1BNrmVdvTG9ThF9myS4fdeJ7uEZHjE9n+LQ6twji99tXlcd3iHIATNU1pEODTOnEyBH+NDAV2+1Fo20yKjKnQyj61TzFpvgDRf5VgpoADuVl5Hdga7g1GVg0rP/6dXpIOT3Ya5hE6idg/mCEvc0Kw12+5cBTUF+6mV6zUj9T8NyWCfsPL5SRZR0V4P+6Hzk7orFPlR8XcSp8urLx+wfatrekNAM/AOMuRlsE0zhMsjN88CfcifI6qnYapXQMKBV0DS7Myy/vbiZ6LyeDxWSTPec4aK903Wg199dFxJ7v4H1JUbhXqBlO9M+d/5iPIJFGinUTEhwl9Xo21h+sT2bVxbNNqmAuBlAIajdAJ0Ud4jUAK44KJSjDcGiO3kvJ+IjMkbu3q28G/BfRzWehCJYEywLKFYcC3dNMUY3QUSpXZVxBLsdunYCfck5G1nO/8WW4o/qAXpALnsD1iDY4txQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(136003)(396003)(451199021)(36840700001)(46966006)(40470700004)(478600001)(40460700003)(16526019)(31696002)(16576012)(54906003)(86362001)(36756003)(107886003)(34020700004)(186003)(53546011)(26005)(82310400005)(40480700001)(4326008)(6916009)(316002)(82740400003)(83380400001)(70206006)(70586007)(36860700001)(2906002)(7636003)(336012)(356005)(426003)(41300700001)(8676002)(8936002)(31686004)(5660300002)(47076005)(7416002)(2616005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 13:02:57.8430
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2927d829-0151-4668-2e6a-08db44c439f7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7974
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 21/04/23 18:41, Lorenzo Pieralisi wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Fri, Apr 14, 2023 at 04:24:02PM +0530, Sumit Gupta wrote:
>>
>>
>> On 13/04/23 20:22, Lorenzo Pieralisi wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On Tue, Apr 11, 2023 at 04:30:01PM +0530, Sumit Gupta wrote:
>>>> Add support to request DRAM bandwidth with Memory Interconnect
>>>> in Tegra234 SoC. The DRAM BW required for different modes depends
>>>> on speed (Gen-1/2/3/4) and width/lanes (x1/x2/x4/x8).
>>>> Currently, no latency is observed in data transfer with PCI as the
>>>> DRAM Freq is always set to max. But that results in high power
>>>> consumption. Now for Tegra234, we are enabling the dynamic scaling
>>>> of the DRAM Freq based on requests from Clients instead of running
>>>> at the max Freq always. This change does that for PCI MC client.
>>>
>>> I am sorry but this is still unclear to me. The sentence above makes
>>> me think that you are *adding* latency to the data transfer trading
>>> it with lower power consumption; probably that's a wrong parsing of
>>> what you are saying - so please explain what you want to say
>>> with "no latency is observed" and whether this patch changes that
>>> (which is not allowed because that would count as a regression).
>>>
>>> Thanks,
>>> Lorenzo
>>>
>>
>> Rephrased as below. Please suggest if it is clear now.
>>
>> Add support to request DRAM bandwidth with Memory Interconnect in
>> Tegra234 SoC. The DRAM BW required for different modes depends on
>> speed (Gen-1/2/3/4) and width/lanes (x1/x2/x4/x8).
>> Currently, the DRAM freq is always set to max but that results in
>> higher power consumption. Memory Interconnect feature adds capability
>> for MC clients to request BW and scale the DRAM freq dynamically to
>> provide the requested BW.
> 
> What does "Memory Interconnect" stand for ?
> 
> Is that HW technology or a Linux framework (or both) ?
> 
> What does MC stand for ?
> 
> Update the commit log below accordingly.
> 
> "Add support to request DRAM bandwidth with Memory Interconnect
> in Tegra234 SoC.
> 
> The DRAM BW required for different modes depends on the link
> speed (Gen-1/2/3/4) and width/lanes (x1/x2/x4/x8).
> 
> Currently, the DRAM frequency is always set to the maximum available
> but that results in the highest power consumption.
> 
> The Memory Interconnect feature adds the capability for MC clients to
> request bandwidth and therefore scale DRAM frequency dynamically
> depending on the required link speed so that the DRAM energy consumption
> can be optimized".
> 
> With that:
> 
> Acked-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> 
Thank you for the inputs.
Have added changes in v7.

>>
>> Thank you,
>> Sumit Gupta
>>
>>>>
>>>> Suggested-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>>>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>>>> ---
>>>>    drivers/pci/controller/dwc/pcie-tegra194.c | 51 +++++++++++++++-------
>>>>    1 file changed, 35 insertions(+), 16 deletions(-)
>>>>
>>>> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
>>>> index e6eec85480ca..4fdadc7b045f 100644
>>>> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
>>>> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
>>>> @@ -14,6 +14,7 @@
>>>>    #include <linux/delay.h>
>>>>    #include <linux/gpio.h>
>>>>    #include <linux/gpio/consumer.h>
>>>> +#include <linux/interconnect.h>
>>>>    #include <linux/interrupt.h>
>>>>    #include <linux/iopoll.h>
>>>>    #include <linux/kernel.h>
>>>> @@ -288,6 +289,7 @@ struct tegra_pcie_dw {
>>>>         unsigned int pex_rst_irq;
>>>>         int ep_state;
>>>>         long link_status;
>>>> +     struct icc_path *icc_path;
>>>>    };
>>>>
>>>>    static inline struct tegra_pcie_dw *to_tegra_pcie(struct dw_pcie *pci)
>>>> @@ -310,6 +312,27 @@ struct tegra_pcie_soc {
>>>>         enum dw_pcie_device_mode mode;
>>>>    };
>>>>
>>>> +static void tegra_pcie_icc_set(struct tegra_pcie_dw *pcie)
>>>> +{
>>>> +     struct dw_pcie *pci = &pcie->pci;
>>>> +     u32 val, speed, width;
>>>> +
>>>> +     val = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKSTA);
>>>> +
>>>> +     speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, val);
>>>> +     width = FIELD_GET(PCI_EXP_LNKSTA_NLW, val);
>>>> +
>>>> +     val = width * (PCIE_SPEED2MBS_ENC(pcie_link_speed[speed]) / BITS_PER_BYTE);
>>>> +
>>>> +     if (icc_set_bw(pcie->icc_path, MBps_to_icc(val), 0))
>>>> +             dev_err(pcie->dev, "can't set bw[%u]\n", val);
>>>> +
>>>> +     if (speed >= ARRAY_SIZE(pcie_gen_freq))
>>>> +             speed = 0;
>>>> +
>>>> +     clk_set_rate(pcie->core_clk, pcie_gen_freq[speed]);
>>>> +}
>>>> +
>>>>    static void apply_bad_link_workaround(struct dw_pcie_rp *pp)
>>>>    {
>>>>         struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>>>> @@ -453,18 +476,12 @@ static irqreturn_t tegra_pcie_ep_irq_thread(int irq, void *arg)
>>>>         struct tegra_pcie_dw *pcie = arg;
>>>>         struct dw_pcie_ep *ep = &pcie->pci.ep;
>>>>         struct dw_pcie *pci = &pcie->pci;
>>>> -     u32 val, speed;
>>>> +     u32 val;
>>>>
>>>>         if (test_and_clear_bit(0, &pcie->link_status))
>>>>                 dw_pcie_ep_linkup(ep);
>>>>
>>>> -     speed = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKSTA) &
>>>> -             PCI_EXP_LNKSTA_CLS;
>>>> -
>>>> -     if (speed >= ARRAY_SIZE(pcie_gen_freq))
>>>> -             speed = 0;
>>>> -
>>>> -     clk_set_rate(pcie->core_clk, pcie_gen_freq[speed]);
>>>> +     tegra_pcie_icc_set(pcie);
>>>>
>>>>         if (pcie->of_data->has_ltr_req_fix)
>>>>                 return IRQ_HANDLED;
>>>> @@ -950,9 +967,9 @@ static int tegra_pcie_dw_host_init(struct dw_pcie_rp *pp)
>>>>
>>>>    static int tegra_pcie_dw_start_link(struct dw_pcie *pci)
>>>>    {
>>>> -     u32 val, offset, speed, tmp;
>>>>         struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
>>>>         struct dw_pcie_rp *pp = &pci->pp;
>>>> +     u32 val, offset, tmp;
>>>>         bool retry = true;
>>>>
>>>>         if (pcie->of_data->mode == DW_PCIE_EP_TYPE) {
>>>> @@ -1023,13 +1040,7 @@ static int tegra_pcie_dw_start_link(struct dw_pcie *pci)
>>>>                 goto retry_link;
>>>>         }
>>>>
>>>> -     speed = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKSTA) &
>>>> -             PCI_EXP_LNKSTA_CLS;
>>>> -
>>>> -     if (speed >= ARRAY_SIZE(pcie_gen_freq))
>>>> -             speed = 0;
>>>> -
>>>> -     clk_set_rate(pcie->core_clk, pcie_gen_freq[speed]);
>>>> +     tegra_pcie_icc_set(pcie);
>>>>
>>>>         tegra_pcie_enable_interrupts(pp);
>>>>
>>>> @@ -2233,6 +2244,14 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
>>>>
>>>>         platform_set_drvdata(pdev, pcie);
>>>>
>>>> +     pcie->icc_path = devm_of_icc_get(&pdev->dev, "write");
>>>> +     ret = PTR_ERR_OR_ZERO(pcie->icc_path);
>>>> +     if (ret) {
>>>> +             tegra_bpmp_put(pcie->bpmp);
>>>> +             dev_err_probe(&pdev->dev, ret, "failed to get write interconnect\n");
>>>> +             return ret;
>>>> +     }
>>>> +
>>>>         switch (pcie->of_data->mode) {
>>>>         case DW_PCIE_RC_TYPE:
>>>>                 ret = devm_request_irq(dev, pp->irq, tegra_pcie_rp_irq_handler,
>>>> --
>>>> 2.17.1
>>>>
