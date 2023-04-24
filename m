Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9696D6ECC88
	for <lists+linux-pci@lfdr.de>; Mon, 24 Apr 2023 15:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbjDXNE1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Apr 2023 09:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbjDXNEY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Apr 2023 09:04:24 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2045.outbound.protection.outlook.com [40.107.102.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB72849DD;
        Mon, 24 Apr 2023 06:04:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dvCLg4HsEJrtOzwiYyLBHJtGaJQa2jc1rk9JgzOL6WF1efMmCThDue7aMFCwmbMwz+lfAjusdPS47eRkfUD0mySPIWcheRnPsed0nhyNeewNA0HfrAUMt7utU29ZTSq5aHkq9VuFahhtC+AcBa+ozfewAfYWA+2nTH32vS82P+n9eCxgWGXlPENc+AmpX9g1QYR/J2X/mA01UfDxIg7b5/8ahIkno60iZTMbZvNws1kvm/z0rdm+SxRCQ7/te97gEc3qJS3fQqZLjMEG/BZjAvymoWk4Nwazn0+nav4X9OmH/98HB8YBL124yQDhTbyVNAV62bZNmRZzDC22WBT1LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xNyvBIhascCwOQ4gew+R2NZvnqyiJLXUcYa7YqUmmFE=;
 b=SseDPnb1hTLRxX1JrBRdDEBBxNQNxWogr4JH0eVMAe82VYKHbqaVywqrpxIu2IaLnxC351cdeOfS38aQq6Cbx1Q7G3PleaqRjlNXr3Kf3/ZL/GkIO0xArV2SnARX2ofZxgDtcbZzuMqAkVYuZpa3vfshkF0STLJTzGVkrwjk1XHny5UspYuR22JCAQ0s7+84pTAjjHBZayWNQvjLLgXHPhydGpN4XVq31sfhNVNtgkS9m2DAz83o1Iq50jCxmRXztwAw1UNTmPaJBeaMHO8rfkBNvTi1MqElV3HdyWiTZh8Sh10yX89l6RIHlnTlxSr9JWiXYBYvxeFgvlIkcfF9UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xNyvBIhascCwOQ4gew+R2NZvnqyiJLXUcYa7YqUmmFE=;
 b=oGJXYmTT1W3Kvad+gGNLt2yLnM47v4iBdD/h73L6b0gvimqaugDr9v9gXvk4cq0hBF6C3Q7U63Ll2XpSoKj140b2ntLZnB18CWt4nOK1f5Bv1+uxAHqhhzwXhOp0JnQ5Y1mIrdDNO3qYoDPWgh4dL67lzzn6knWH3NiLKmG945r2sqSBpmQ4AaiFCH/y4I77APgOI5pNLyadaWyOs/RbSk2Fiv6vSL00FM5y3sV1sh/63gsd9Yd2t8v2e1asgBpTvI32wgEsH4FQRL+ksirwQey9sfpemXYlkBx5Mz4OJekjpnHU6wHvD2bbtTbcv0wA/b9glwz6pZfuYIT0aIfzAg==
Received: from BN9PR03CA0409.namprd03.prod.outlook.com (2603:10b6:408:111::24)
 by SN7PR12MB6744.namprd12.prod.outlook.com (2603:10b6:806:26c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.32; Mon, 24 Apr
 2023 13:04:06 +0000
Received: from BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:111:cafe::6a) by BN9PR03CA0409.outlook.office365.com
 (2603:10b6:408:111::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33 via Frontend
 Transport; Mon, 24 Apr 2023 13:04:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT015.mail.protection.outlook.com (10.13.176.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.19 via Frontend Transport; Mon, 24 Apr 2023 13:04:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 24 Apr 2023
 06:03:47 -0700
Received: from [10.41.21.79] (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 24 Apr
 2023 06:03:41 -0700
Message-ID: <c247a72c-5e69-09ed-e7a6-c87a410f392c@nvidia.com>
Date:   Mon, 24 Apr 2023 18:33:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [Patch v6 7/9] PCI: tegra194: Fix possible array out of bounds
 access
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
 <20230411110002.19824-8-sumitg@nvidia.com> <ZEKL1XzYzOwcEkHK@lpieralisi>
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <ZEKL1XzYzOwcEkHK@lpieralisi>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT015:EE_|SN7PR12MB6744:EE_
X-MS-Office365-Filtering-Correlation-Id: bea1e208-b568-4ef1-2852-08db44c46258
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RAUqXoHXmzCVDYYDpUkZZFVo3771RY0BPbpc9afKJ8b0nW1FsLZmnB5xT2eqtcsolLQFyltoD2TODN1+gFbqQYqG4FXAwTHOj7cyqorkVEty055kTsjz53LLVeZXI0rLcJk1fJowPdc7etuvzec62BRp1qCWmTYDGiuY+gf+iL1xmu3UrTDAorHQtoux03lR3Ikxz3Bj983XaUZeTjn+ljem69W89Eg9Jtl9V19S5E/es5kQjtdGwNYZVFnGenJR2jaxhv1U6yGtVIQUthLhQB2JC592g+pTqoHWroYLF1tJECYZoN0eut83HaRg5I1e0CpbRFbedK00gXQbsHDBAGcJDV6d9JzL4gtS5mdUWlnnwbgKG6Vij1g7jlvPL1a+lSTAWEnD2PjDMBGXkp22GgJP0R0RsFd8GYacgmyBi0K2NoA2XYpafVtdM+nQJLXUV2yquctEu3W+qNLM2G47HE/JFVQl8dEamVDoKNYlB46Ygk09yGnaDPCqyFntkQQ2rvRwnA85X/VWlMV5XkTXeEAWlJjJpu2jSAEJUi42dk6t1nl3/lVP3a/dD9UQ3+VT+SwvcqizHynm0W5PXYHAokOr6WO7besmR6qXvYvUMsozwdtcY2zgUuIl3ORM4EJRU0nnZ8j5Wt2s1O26jBnPvpVvhKko9NQpACjGCKJOq2OtIBJYtX+5sePtxkmIqrl+n6m4g7V5XxnduJZ3WKfn+K9vC4qoPKk+94sJhDZ0aFR8f/J9j2O0ndhfFh30C1oLLKtXoqBv4AFLaqMu/AG/uhzXYb7T+X3eFGrnWcROigjbWA6IyUAk7jgx5gTaZa0T
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(376002)(136003)(451199021)(40470700004)(46966006)(36840700001)(36756003)(8676002)(8936002)(54906003)(40460700003)(16576012)(34020700004)(478600001)(4326008)(6916009)(70206006)(70586007)(7416002)(40480700001)(7636003)(356005)(316002)(41300700001)(82740400003)(2906002)(5660300002)(2616005)(86362001)(186003)(36860700001)(16526019)(966005)(336012)(426003)(26005)(31686004)(53546011)(107886003)(31696002)(6666004)(47076005)(83380400001)(82310400005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 13:04:05.5249
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bea1e208-b568-4ef1-2852-08db44c46258
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6744
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



On 21/04/23 18:42, Lorenzo Pieralisi wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Tue, Apr 11, 2023 at 04:30:00PM +0530, Sumit Gupta wrote:
>> Add check to fix the possible array out of bounds violation by
>> making speed equal to GEN1_CORE_CLK_FREQ when its value is more
>> than the size of "pcie_gen_freq" array. This array has size of
>> four but possible speed (CLS) values are from "0 to 0xF". So,
>> "speed - 1" values are "-1 to 0xE". This change was suggested by
>> "Bjorn Helgaas" in the below link.
> 
> There is a Suggested-by tag and a Link: tag remove the last
> sentence, that's duplicate information.
> 
Removed in v7.

Thank you,
Sumit Gupta

>> Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> Link: https://lore.kernel.org/lkml/72b9168b-d4d6-4312-32ea-69358df2f2d0@nvidia.com/
>> ---
>>   drivers/pci/controller/dwc/pcie-tegra194.c | 13 +++++++++++--
>>   1 file changed, 11 insertions(+), 2 deletions(-)
> 
> Acked-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> 
>> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
>> index 09825b4a075e..e6eec85480ca 100644
>> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
>> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
>> @@ -223,6 +223,7 @@
>>   #define EP_STATE_ENABLED     1
>>
>>   static const unsigned int pcie_gen_freq[] = {
>> +     GEN1_CORE_CLK_FREQ,     /* PCI_EXP_LNKSTA_CLS == 0; undefined */
>>        GEN1_CORE_CLK_FREQ,
>>        GEN2_CORE_CLK_FREQ,
>>        GEN3_CORE_CLK_FREQ,
>> @@ -459,7 +460,11 @@ static irqreturn_t tegra_pcie_ep_irq_thread(int irq, void *arg)
>>
>>        speed = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKSTA) &
>>                PCI_EXP_LNKSTA_CLS;
>> -     clk_set_rate(pcie->core_clk, pcie_gen_freq[speed - 1]);
>> +
>> +     if (speed >= ARRAY_SIZE(pcie_gen_freq))
>> +             speed = 0;
>> +
>> +     clk_set_rate(pcie->core_clk, pcie_gen_freq[speed]);
>>
>>        if (pcie->of_data->has_ltr_req_fix)
>>                return IRQ_HANDLED;
>> @@ -1020,7 +1025,11 @@ static int tegra_pcie_dw_start_link(struct dw_pcie *pci)
>>
>>        speed = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKSTA) &
>>                PCI_EXP_LNKSTA_CLS;
>> -     clk_set_rate(pcie->core_clk, pcie_gen_freq[speed - 1]);
>> +
>> +     if (speed >= ARRAY_SIZE(pcie_gen_freq))
>> +             speed = 0;
>> +
>> +     clk_set_rate(pcie->core_clk, pcie_gen_freq[speed]);
>>
>>        tegra_pcie_enable_interrupts(pp);
>>
>> --
>> 2.17.1
>>
