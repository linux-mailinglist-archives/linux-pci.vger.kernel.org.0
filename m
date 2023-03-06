Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C36D26ACF0A
	for <lists+linux-pci@lfdr.de>; Mon,  6 Mar 2023 21:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjCFUT7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Mar 2023 15:19:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjCFUTu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Mar 2023 15:19:50 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5054AFE1;
        Mon,  6 Mar 2023 12:19:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iPAlIYEaIUTdK44HEuKDd4W2orF7JZPPXPBGV9e1agtXMhJLnzH75G5J3MAHPJzU/yBy5XC/o/N1kPyo5NffmcyrXOli2AulmhgRLvnNcsEj1967GKPYiRCaDsiM61izM7BvDDG6XExlY+Q9L0Ac/oCUnusvA8iQEg2zmaCS2ndKG9v9TZcviM5EBbR3cYp/YS1dt0nOObeGbDB6PBtLxR7GrdSTdZXl605VKCykoX6AeFLCYwYKITf8/evPTfw+ZpxAPSgcPjj6sdDuFHjHUCuwizeNaSTgh1p/1pWqaG5FdaqBl+mRitRxVSXpoZwhuevBYnn5ulunpBAwz3UGoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vAlcgVn4Hm9unMJbm71XlCCzJFOKDbFzfDZNu0qMl2I=;
 b=SCYQHsAtz/FhlSbIbSTEi9Z4UdlOsIdOLYS4mVE5Nt9dtdxLUYLp/dWdtMkCa3ROdd5vG/uj89lbr2Uco6PuOmSmcv7CIt+68k322zkTczTCCujkqm6TY8dcgjA4DJyN6entsQfaaiO/p2Zc0i/vMeKo7RQSZVQ9FfqKGojxYKJhpb6Bd1cfgaK9pXwebJNkAbgqG0Jy0gxxbn6nEko4KDqdw+KD2noKG/2kykUJt4IA5Kc30DuUYaCgZgsv3EAAPBmboIPaclsD504hRj8MTmyJ1CunS5YMtwCQFgO/s8eHKAl9orfC2BByPL2fKRVA52lAZQjxbynw9QcyH8zK7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vAlcgVn4Hm9unMJbm71XlCCzJFOKDbFzfDZNu0qMl2I=;
 b=BwFwdPtXzontXI8ueNa18veYu6aXs/uakp0SlXcJpNchYZajM2Bh0rdvggdTLr7SBDg8nrw2avG1BZCNlo2PqBdCN74B3Bpg6MahM5KYvAVlVkYWe1gjiDSFkejOQsJ24YIpDjZUBHzCJkGej1EM0NmWqYzRJ6pJvH366VmZV3Kod0ytVH6tePkvdmS9RTKbJzt4LjjvnAEvgXgJLbmBV8TLHe/MvoKK/bCsHyKMpMk7QR8IYyEydo8RmFUNdQOPyt5gmuhTS5hnvQZl/UVbl9eTueMVGSyxrIlYN9eLWC39TZ1cMvLFLKUkefhhzHO3El52VWvmtojMWuOIUjiWjA==
Received: from DS7PR03CA0015.namprd03.prod.outlook.com (2603:10b6:5:3b8::20)
 by CH0PR12MB5314.namprd12.prod.outlook.com (2603:10b6:610:d5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Mon, 6 Mar
 2023 20:19:32 +0000
Received: from DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b8:cafe::fb) by DS7PR03CA0015.outlook.office365.com
 (2603:10b6:5:3b8::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28 via Frontend
 Transport; Mon, 6 Mar 2023 20:19:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT052.mail.protection.outlook.com (10.13.172.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.15 via Frontend Transport; Mon, 6 Mar 2023 20:19:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 6 Mar 2023
 12:19:25 -0800
Received: from [10.41.21.79] (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 6 Mar 2023
 12:19:19 -0800
Message-ID: <beb3ce07-b431-11e9-744e-bb632c2069db@nvidia.com>
Date:   Tue, 7 Mar 2023 01:49:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [Patch v2 0/9] Tegra234 Memory interconnect support
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <treding@nvidia.com>, <dmitry.osipenko@collabora.com>,
        <viresh.kumar@linaro.org>, <rafael@kernel.org>,
        <jonathanh@nvidia.com>, <robh+dt@kernel.org>,
        <lpieralisi@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <mmaddireddy@nvidia.com>,
        <kw@linux.com>, <bhelgaas@google.com>, <vidyas@nvidia.com>,
        <sanjayc@nvidia.com>, <ksitaraman@nvidia.com>, <ishah@nvidia.com>,
        <bbasu@nvidia.com>, Sumit Gupta <sumitg@nvidia.com>
References: <20230220140559.28289-1-sumitg@nvidia.com>
 <c8cf2435-8b18-7af7-c751-267021142f5a@linaro.org>
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <c8cf2435-8b18-7af7-c751-267021142f5a@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT052:EE_|CH0PR12MB5314:EE_
X-MS-Office365-Filtering-Correlation-Id: 04b85422-98c3-4192-7ab4-08db1e8018f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jLlZVTskmBeBAsN+gMyHjfdK8llT8K7NBAS1nMAxIlDXiJyKcMBK3D7Dwu8R5a1ZZH9kRnAGs9WOYZheUM+yukAlbmWuLoZPygaihnF5LweWGmKXWIu0kexa2RcHKN+Ze1tk+c2IsTuVN62zN/Pht262Q+rsGaR+gBlp44txLQxzfOYTDNlfAD8/JqLqnxaAa+GqdUaOqfja6xhV33t3EGLR9IQ1UTK7RXs42Vf5k1Q67mQjpI6PEh6aPaMgPooLaAyHx3KaP6kEz8NcCEnVyzssQ7mdXg5YVLxcF1LfOXutzJRaDr+HtSB6ZIkJgOiEataqMXejx0ggjJwkhiHt7U7gZA7m0S8Lk3ulym1gcG5THBZ5sqXQ0/A5JKEK3R+OjQoFXKHaMGA1SYqpLAAHqa0eDiSccSCOO0Bu3+8AJsaj7Jmof94jqSXTpi1F4CQ0/5Z5lRT46CmIS138GiGKSUM6wzRkv5/BVdJ6bduo7dCLqHm7Jd8tBBaxigNEcPVnICnpttYB0JgSO3HsvLJ0OyRPrGz0DBYYgZnaVxJGUfvTkf2oU859qnWh1qA8rkH+wu7qKjxfbr5gAQkGS2oNUvl475wbbklFYT1SMZ9ymTgYtRkPB85sC8rGwpKQiG35VTOZCigFojgNgqRjg+DHe1N/NhaqAJ+H8jiy83n2K/SO11BzpZvFJ8veqc8VGnOZsLtI7GbqW+k0WO6jSxQ0a0nYdP5g802J/By48P2b/Eg=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(39860400002)(136003)(376002)(451199018)(36840700001)(40470700004)(46966006)(36756003)(83380400001)(426003)(47076005)(82740400003)(36860700001)(107886003)(53546011)(186003)(41300700001)(26005)(16526019)(336012)(40460700003)(2616005)(5660300002)(70586007)(8936002)(31696002)(40480700001)(86362001)(4326008)(8676002)(70206006)(2906002)(7416002)(110136005)(316002)(356005)(16576012)(478600001)(54906003)(7636003)(31686004)(82310400005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 20:19:32.5104
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04b85422-98c3-4192-7ab4-08db1e8018f6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5314
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 06/03/23 20:35, Krzysztof Kozlowski wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 20/02/2023 15:05, Sumit Gupta wrote:
>> This patch series adds memory interconnect support for Tegra234 SoC.
>> It is used to dynamically scale DRAM Frequency as per the bandwidth
>> requests from different Memory Controller (MC) clients.
>> MC Clients use ICC Framework's icc_set_bw() api to dynamically request
>> for the DRAM bandwidth (BW). As per path, the request will be routed
>> from MC to the EMC driver. MC driver passes the request info like the
>> Client ID, type, and frequency request info to the BPMP-FW which will
>> set the final DRAM freq considering all exisiting requests.
>>
>> MC and EMC are the ICC providers. Nodes in path for a request will be:
>>       Client[1-n] -> MC -> EMC -> EMEM/DRAM
>>
>> The patch series also adds interconnect support in below client drivers:
>> 1) CPUFREQ driver for scaling bandwidth with CPU frequency. For that,
>>     added per cluster OPP table which will be used in the CPUFREQ driver
>>     by requesting the minimum BW respective to the given CPU frequency in
>>     the OPP table of given cluster.
>> 2) PCIE driver to request BW required for different modes.
> 
> No dependencies or ordering written, so I am free to take memory
> controller bits, I assume.
> 
> Best regards,
> Krzysztof
> 

Apologies for not mentioning the order in cover letter. The patches are 
divided into below groups.
  Patch [9]: Memory Interconnect support in PCI (MC client)
  Patch [4-8]: Memory Interconnect support in CPUFREQ (MC client)
  Patch [1-3]: Memory Interconnect base support

Both the Memory Controller (MC) client patches are dependent on the 
'Memory Interconnect base support patch [1-3]'.

Thanks,
Sumit
