Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE7B6FC96E
	for <lists+linux-pci@lfdr.de>; Tue,  9 May 2023 16:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235671AbjEIOsE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 May 2023 10:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235438AbjEIOsD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 May 2023 10:48:03 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on20617.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eab::617])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35264E6A;
        Tue,  9 May 2023 07:48:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jpSbmnyYXAJ3f1Kd8jqrx0UG0j2RWMOULG6Aeza8aRWxfa/6nH/itkJKoZ71q6QyoU8OQ29AgrWifbFjYMK/2zv3F8ntzvdzkvbouyYC0HtI0VPLu+QxI4SLG8kAY2KCcey1C4/FXyh210xzHeaUqTYfGahcHBChe8t64S4S3DGjnvjtlQ8djhPISgL7Q9HPKH4BoNZWn9iFxQLBq35FZYswJRARxMs1sQ2h+i3T84yap6cNiVkXpDdLaaK2S+x2VoOj/jyKUsWeKyBPL6sGYfbiyChvJ/5MyoDGbkPZor+7oilQsCx8V5QTwS5R47wwxnP17qCL6Mkg576qTNDyKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mBMvaTwB/d/bpYmBActCJBpt6VsoE9OlH3gndvwhubk=;
 b=M9uWp38neQnpAZvqGZTEy0HUon8+FJQ5J8f9Jr1/ys2iORxDLzLkZM5HaL7X6y/dCwjwK3lVJBZ5V7L51NP/OjMWPLgk2rS7A/LgNOxGO5fhe8G0N9csvBFL8F/ndlLRAtLrFQ4rPldR9q09p51h32CA2bdRNON5gQbab1XHxJoOu3t+wobOwEBbLvatdAp/+1fX3mX1tpEaITN/HhMN6KZxRDV3nI5sRUJp41bHCpRjU3tldUxtq5PED3oXlyVyijg/+7tsAsZjeiG1YZ6KOTaPCfKGf5aJbeNa2CR32N4jGwUu2yWQdaExGLlYzgzjIfMi4Yx6eNbEQJ3+gk7oSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mBMvaTwB/d/bpYmBActCJBpt6VsoE9OlH3gndvwhubk=;
 b=NMGFiJuA9SN2dLri2AQ4YLPenL9p5yEG7cJc02REIVzh9O3AxfIxydY4PCw4P5K1Phi4dOapFIeL+Hk7w6G0PjmP5z5RW7J2FuieRqLYonw0xWmrpGjHSpkVEPqBqRO5oM6JDGoJNzU6X2uqc1gkRbBhs5nPFZz4F3adFTcKNYdk+w27FzWx3Q1HMwasYwK/naIssoiv8OYsNlMsYBn9XgUHGPLvwo4ijw2ygr7pX/eGMoqIhlL1g+id/+BS8sfmX+0qh+bNh5fQ5x58VrxRCLQoKCFInO/jejez7TY19Wn84LrbZok4B5Cyav25dLq+UTdZQniwEKjIP1oVgGvPVw==
Received: from BN9P223CA0017.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::22)
 by CH2PR12MB4070.namprd12.prod.outlook.com (2603:10b6:610:ae::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 14:47:58 +0000
Received: from BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::d7) by BN9P223CA0017.outlook.office365.com
 (2603:10b6:408:10b::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18 via Frontend
 Transport; Tue, 9 May 2023 14:47:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT029.mail.protection.outlook.com (10.13.177.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.18 via Frontend Transport; Tue, 9 May 2023 14:47:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 9 May 2023
 07:47:49 -0700
Received: from [10.41.21.79] (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 9 May 2023
 07:47:43 -0700
Message-ID: <10e2d3b4-d66f-947f-4643-97b1f04e4b31@nvidia.com>
Date:   Tue, 9 May 2023 20:17:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [Patch v7 1/8] memory: tegra: add interconnect support for DRAM
 scaling in Tegra234
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <treding@nvidia.com>, <dmitry.osipenko@collabora.com>,
        <viresh.kumar@linaro.org>, <rafael@kernel.org>,
        <jonathanh@nvidia.com>, <robh+dt@kernel.org>,
        <lpieralisi@kernel.org>, <helgaas@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <mmaddireddy@nvidia.com>,
        <kw@linux.com>, <bhelgaas@google.com>, <vidyas@nvidia.com>,
        <sanjayc@nvidia.com>, <ksitaraman@nvidia.com>, <ishah@nvidia.com>,
        <bbasu@nvidia.com>, Sumit Gupta <sumitg@nvidia.com>
References: <20230424131337.20151-1-sumitg@nvidia.com>
 <20230424131337.20151-2-sumitg@nvidia.com>
 <7c6c6584-204a-ada1-d669-2e8bef50e5e5@linaro.org>
 <3071273b-b03b-5fc8-ffa1-9b18311a3a5d@nvidia.com>
 <5ab9687e-756d-f94b-b085-931d4ea534c1@nvidia.com>
 <10b32e55-4d28-5405-035e-c73a514c95e4@linaro.org>
 <14438cf9-ec78-afb5-107a-4ed954ac0eb7@nvidia.com>
 <0815c0b5-304b-568f-5a64-d19d7d2aeb93@linaro.org>
Content-Language: en-US
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <0815c0b5-304b-568f-5a64-d19d7d2aeb93@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT029:EE_|CH2PR12MB4070:EE_
X-MS-Office365-Filtering-Correlation-Id: d5d73416-18af-4439-8d07-08db509c6169
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hm1NFOYmdVbEo6lTkAsiNJOGE0sXD2tFlXTp1MY+1JQMSBW4daycBzI78SQhhSdhiFlQY5vRwybVUtd+cuAU7i5cZTZEvmcqZ6hvoByEkFYgAaWrA/Pu9CZwkYv3+70V0YmVxLThSa9HPAQJAND1bPxMsHpNiW0+MQB+q97gOB3S9gVRrW2beJXuH3JlhG5iYl+kIh+ZwPkoV0VGv7bV7M3IEh0Vq804vbR79ob/71irqIjwOniuucNxeb1V3qW/WKmFgLWWlTWHYQYndm4gNFl7CU24CLmNRBuKObDGii5ozPVR++elTCWZj67lyVzO6Hu1h4ECrUkzXfkaI5pTI+BdOwn/Oo/goZkEY7cMe+eZTuXyozLaInFX5d/hUiQMOx9sfVvCIozC2ARYggrYSP3HCRvtqpkKFdKdmLuNQcO1N1LOJu9klDYKFPRpM/djualjMHomIAUW6I+b9RSSmTzzzSVZjvRX192edvOeWgoXLgJRpYDFVFP5/lmEOnm7erRqiny6Pi+F/+in82IcTVx+LmpkZ30S7uCYhJeyJ79w3ubdQ8Hmfr4uSPXmaCmLhdewwMQ3Szw7/MIXh5ztjYGL1EiMEDVPbMmQGBUahJ94GSyC6fqcYW0cPDq3xgSXlCByF8UQqdwzuaEb/RMuY1t20IGVr/Q7BzRMVZabSGacWxVrbXg8RJ4/tGHaHGqTBopMuzeTrXsFq8lSi1EjzvBEBn/B8ZVkSFleXHwk0V8=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(396003)(346002)(136003)(451199021)(46966006)(36840700001)(40470700004)(70586007)(70206006)(356005)(7636003)(4326008)(40480700001)(40460700003)(41300700001)(426003)(336012)(316002)(31696002)(107886003)(82740400003)(16526019)(2906002)(86362001)(186003)(2616005)(36756003)(82310400005)(5660300002)(53546011)(8936002)(8676002)(7416002)(26005)(36860700001)(54906003)(16576012)(110136005)(31686004)(47076005)(478600001)(83380400001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 14:47:58.0609
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5d73416-18af-4439-8d07-08db509c6169
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4070
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 09/05/23 19:06, Krzysztof Kozlowski wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 09/05/2023 15:17, Sumit Gupta wrote:
>>>>>>> +                     /*
>>>>>>> +                      * MC driver probe can't get BPMP reference as
>>>>>>> it gets probed
>>>>>>> +                      * earlier than BPMP. So, save the BPMP ref got
>>>>>>> from the EMC
>>>>>>> +                      * DT node in the mc->bpmp and use it in MC's
>>>>>>> icc_set hook.
>>>>>>> +                      */
>>>>>>> +                     mc->bpmp = emc->bpmp;
>>>>>>
>>>>>> This (and ()) are called without any locking. You register first the
>>>>>> interconnect, so set() callback can be used, right? Then set() could be
>>>>>> called anytime between tegra_emc_interconnect_init() and assignment
>>>>>> above. How do you synchronize these?
>>>>>>
>>>>>> Best regards,
>>>>>> Krzysztof
>>>>>>
>>>>>
>>>>> Currently, the tegra234_mc_icc_set() has NULL check. So, it will give
>>>>> this error.
>>>>>     if (!mc->bpmp) {
>>>
>>> How does it solve concurrent accesses and re-ordering of instructions by
>>> compiler or CPU?
>>>
>>
>> Now, the "mc->bpmp" is set before tegra_emc_interconnect_init().
>> So, until the EMC interconnect initializes, set() won't be
>> called as the devm_of_icc_get() call will fail.
> 
> What if compiler puts "mc->bpmp" assignment after
> tegra_emc_interconnect_init()?
> 
> What if CPU executes above assignment also after
> tegra_emc_interconnect_init()?
> 
> Considering amount of code inside tegra_emc_interconnect_init() second
> case is rather unlikely, but first possible, right?
> 
> Best regards,
> Krzysztof
> 

Yes, for protection from compiler re-ordering I can add
barrier() after the assignment.

   mc->bpmp = emc->bpmp;
   barrier();

Thank you,
Sumit Gupta
