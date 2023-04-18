Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9956E5E9F
	for <lists+linux-pci@lfdr.de>; Tue, 18 Apr 2023 12:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbjDRKXf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Apr 2023 06:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbjDRKXH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Apr 2023 06:23:07 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A983C02;
        Tue, 18 Apr 2023 03:22:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JnU38xYUdjqDbG0/lvg8EOZYN8psb40rT6Wqs7aZL8ugvloqA/orck9/8Dmb3OKgFwPh0WllPijCJK2PKSYfy6IerQwoLXcjbSciTHuDvGkXHqcEjE5OgRoMMIw7buFEAZKIdk6J2gS4Re32ylv4BWbrjTI7jYKIS+4spREOSlAm1NrnkMZ3chcrPRPG1Qy5vx7PXVzSOw6GJbFoTqupLKzbaeLMI6i0AFtqs0mpvpAZqstAcOvP4RlsyMy2r5TJEoQklL9yidn/zN6yMJccUCmmItYJitDwH1SEzC7fYL/uyaI6qHGLwdM4qNHLif3r6kW0ff26yBjWB4hU8+ZhHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kSMWIp5QxTb1MANdUanUII7y/nc/B5lDWJcB/FevO9M=;
 b=eY5Q7v5sSxVpU/m9QWWUx3nS7rKRByAPh1trbxojCP0wEa+vhlKV+kRl+bR+6vbclo4GxM2ZZZILF/f14JEH4D825p5qeQcwwAgHeuuxWL4j9zR/YBuoTY7njQma85WhQ6tRHCYpnRFSb18nuHL3VQN5awgC3xomMpLbPYqxr3XpWxEDhJ/R+9RxWNBFTn/uZ3jeXHuAolotrmiU6nqmykCQ0z4BGl71p6HmhGlr9E0oa0zmSljxIlKlDh5AIVWH+7Ky57IxZHxe2rfRLJeMHm/rgrRxs3I6v7UV8NaEhYUHMxL6jcTEguOMuioswhevEyCdJnZaMYCa/NCyOlEt3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kSMWIp5QxTb1MANdUanUII7y/nc/B5lDWJcB/FevO9M=;
 b=XXK+7c1tO5BBEQOvFNHG4UPg+nMHJaeQ+50xXG5Yk+pe5mDxf/lvqudJnMnrVUJlEaJ7u7a0KzHKFiWdW1/bnbjOK9LtxYxExwZ5YDCneCX1UCNTvtztO1O6AqSAypYb5I4b4b7xQ0sDiDaqT7ywOaxR7nmder6WMNVvwb9zLWSXcrGJv5oKKLetoQDbPrk/N+YCvc/p4xG3e7qIm6HZy8JdRFH1c853/dab4EBk2ghyucvk0dkYPuoZAxm9aOqQ2hngclM7agBwglNUyXbw/KjbUcgj1muPoLsDtcD6GVRPfgxr80h4p0a3ZWY8JhXiSNBUECl7Z6DDR55sS7sc8w==
Received: from BN9PR03CA0229.namprd03.prod.outlook.com (2603:10b6:408:f8::24)
 by DM6PR12MB4942.namprd12.prod.outlook.com (2603:10b6:5:1be::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Tue, 18 Apr
 2023 10:22:11 +0000
Received: from BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f8:cafe::e6) by BN9PR03CA0229.outlook.office365.com
 (2603:10b6:408:f8::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.47 via Frontend
 Transport; Tue, 18 Apr 2023 10:22:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT043.mail.protection.outlook.com (10.13.177.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.20 via Frontend Transport; Tue, 18 Apr 2023 10:22:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 18 Apr 2023
 03:21:57 -0700
Received: from [10.41.21.79] (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 18 Apr
 2023 03:21:52 -0700
Message-ID: <71e45a06-6b02-6b29-b9d9-0c34ff508b64@nvidia.com>
Date:   Tue, 18 Apr 2023 15:51:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [Patch v6 6/9] cpufreq: tegra194: add OPP support and set
 bandwidth
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     <treding@nvidia.com>, <krzysztof.kozlowski@linaro.org>,
        <dmitry.osipenko@collabora.com>, <rafael@kernel.org>,
        <jonathanh@nvidia.com>, <robh+dt@kernel.org>,
        <lpieralisi@kernel.org>, <helgaas@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <mmaddireddy@nvidia.com>,
        <kw@linux.com>, <bhelgaas@google.com>, <vidyas@nvidia.com>,
        <sanjayc@nvidia.com>, <ksitaraman@nvidia.com>, <ishah@nvidia.com>,
        <bbasu@nvidia.com>, Sumit Gupta <sumitg@nvidia.com>
References: <20230411110002.19824-1-sumitg@nvidia.com>
 <20230411110002.19824-7-sumitg@nvidia.com>
 <20230418091315.bxh4hp6g3vekdi2r@vireshk-i7>
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <20230418091315.bxh4hp6g3vekdi2r@vireshk-i7>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT043:EE_|DM6PR12MB4942:EE_
X-MS-Office365-Filtering-Correlation-Id: 844a4177-1932-41bf-12ea-08db3ff6c5bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s6xW2psMOPbG/PcFmqYdQzuxYru0E+erRcjxxYHklaDE0UuNUv64PBMmiOQ1DyhnMcElofL29pCValeVT50xGXcReJH5eyjOV9Mw8R4RyU4Ld29zG4yBr+XchKQ8eSZ/XiVN6a9AsjuzreZIeCFcrhqnG94HE7i6PQ6P5SAxtI3/ySGH1EsvhF5iykE7RAFVeazAq8CF89ktwh1gTG4m+Aq6tcvk95C8YP9/b2K5AkboDF7naAPOPEFida467kDElnHNnLL3UgEsLx9k+c0zDhCGwZgFbk4YtfkCzGe2NnHFXDCIkvVZurXzLbK+B6gFVj23TKvTrunY3zG8w8e8nChjB8nF42GCgwNJe6M6nQ7lgPrwRTAO2IKMJBSq+M+WyLvukFDusxEI4QCx8+PoMWtAr+g/Eg1YVmG7My8BmTaQIDY36W6f7OxsTPXTU4JstOrpydtWMNsoavtMIoNbyXurhdDzLFAwVovzdb6/ZULekP3ECC7s/b1kc577Rk65xbUlD6ibT6AblTk2d6EfAHNpsAr5vu7GgRYBTELgWVPBdu8kSvhxPonNWce0h2yZHQqJ1jMSPXTf8FJwJoNeZltDbiowlmQ78DA0Cn5pSBj8303WX+ACafSgjqG/r6k7I4+2nm8bcs9H+bYMgMJ3PkVn3YDCFRIFzbZsgNxAierQdsUpivenQKIPAWWlxJMv0fqjQ3uwJ1qnTS0xjLIMN7cbyX/Qe5OpGERlUd6emhrVO00XpKw9HHe35xSMET/GBYMECS09BA14fAWo79ooidIT6FLp8hV6lC6tLAu7GO16W3YUkRjb3vwGBvslCNfa
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(7416002)(5660300002)(86362001)(2616005)(426003)(336012)(82310400005)(107886003)(31696002)(47076005)(83380400001)(16526019)(186003)(53546011)(356005)(82740400003)(26005)(7636003)(40480700001)(36860700001)(8676002)(34020700004)(8936002)(478600001)(16576012)(54906003)(6666004)(316002)(41300700001)(40460700003)(36756003)(4326008)(6916009)(70586007)(70206006)(31686004)(2906002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2023 10:22:11.2811
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 844a4177-1932-41bf-12ea-08db3ff6c5bc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4942
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 18/04/23 14:43, Viresh Kumar wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 11-04-23, 16:29, Sumit Gupta wrote:
>> Add support to use OPP table from DT in Tegra194 cpufreq driver.
>> Tegra SoC's receive the frequency lookup table (LUT) from BPMP-FW.
>> Cross check the OPP's present in DT against the LUT from BPMP-FW
>> and enable only those DT OPP's which are present in LUT also.
>>
>> The OPP table in DT has CPU Frequency to bandwidth mapping where
>> the bandwidth value is per MC channel. DRAM bandwidth depends on the
>> number of MC channels which can vary as per the boot configuration.
>> This per channel bandwidth from OPP table will be later converted by
>> MC driver to final bandwidth value by multiplying with number of
>> channels before sending the request to BPMP-FW.
>>
>> If OPP table is not present in DT, then use the LUT from BPMP-FW
>> directy as the CPU frequency table and not do the DRAM frequency
>> scaling which is same as the current behavior.
>>
>> Now, as the CPU Frequency table is being controlling through OPP
>> table in DT. Keeping fewer entries in the table will create less
>> frequency steps and can help to scale fast to high frequencies
>> when required.
>>
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> ---
>>   drivers/cpufreq/tegra194-cpufreq.c | 156 ++++++++++++++++++++++++++---
>>   1 file changed, 143 insertions(+), 13 deletions(-)
> 
> Can this be applied independently of the rest of the series ?
> 
> --
> viresh

Yes, this can be applied independently.

Thank you,
Sumit Gupta
