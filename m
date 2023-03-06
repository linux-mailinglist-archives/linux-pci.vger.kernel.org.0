Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADBAE6ACF5D
	for <lists+linux-pci@lfdr.de>; Mon,  6 Mar 2023 21:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjCFUni (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Mar 2023 15:43:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjCFUnh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Mar 2023 15:43:37 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4887E3C7AC;
        Mon,  6 Mar 2023 12:43:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NcfKjkWROx2Mq+FaEYBQxU+0akBd4XLgDZ9dR+bZkSNRmX72dx9+94qMej/pDJ0irMa4PxpPsc0BgMAjFgoWjzmzF2ChXHsBAtLYbcC0wb8x4Cl/K4LkRQAyIGdkJ25hDjYxwJ980IG1LLGt+BJC7j2d//iHEU276jFbxk1RtmiHtlDC0h6+0iWDgT6d7FTQipy8pW167Hoc62idVaZK3IdzkedOD0SNfQe7+MSC73IUgLwfqlPirgmyHjv7BG0KrJLyntKTOHnLn7HG+u+F+R+H3jzqj+841uE0UV+xGHeV0GD7b6HSWcDyqfeltcV+PXZDVDQogo+MkGj30IAh4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3sypFZxefza6QyR23jhdf2Uj856Q0Y8N8YvDWhhAsfw=;
 b=aZl5zV6uNJf4cEnvOwKtMVA3tQQYSmQQOsxqdE5cg9LnJTuQYdJt2NrBwGa80nUeBuCBrm/WYfHVE68CIse0ghR+tbwUiUJX1o5malp6bJ3HdBJo/Jok6O6R9kgA92mW+zMxedUXXQdPSRQvLQK7fcOhZe7JeqEWDRoiKSt7lWB620xK6+cjj9MnNgS4/FwNKw3wEp/LlqJVvNilVsftZ3a0kK4j6assfjpyz9lgk0nzl9EX70jxGGsHlM+3w8IHf2xYp7YCqtJ1npukFxAjw/PXQgrULGgPQ5VbvkE+sbGLEEY9ruPea8+336XiZMex7s/uKARZL3MzH3QOL+fWeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3sypFZxefza6QyR23jhdf2Uj856Q0Y8N8YvDWhhAsfw=;
 b=WAPsSP+kqkQvtgATLSL5PtyNdalNaq5MwSLIwnWXDKWphpeYiaP0Z8DNB5TT4qiBUgo5LNhho1OmDTZy/1LKLg5fSQXqMGwna9VoHyd264eTJQ4lf3+yMEpvd5SIMpfdPJlhTKsvXrUo2wXcQrZ4ho+7TgsXebblRMqCy307TrFF2SO/LUsaMXBkD5n3RPnjvxkYYAKoPpFCC6Ip1g1zvRaQvG39NjNLKywd2gOmxDog464r+627JHI8ywONGUYW+eXb8iR1aHK9pyMjmLZxcQW3z6ADyfqxeGLVBDdKCLwr4oJvitsaIwG/jK5pe9QqQiavCkXZCO9PcPdYBuQzMA==
Received: from MW4PR03CA0080.namprd03.prod.outlook.com (2603:10b6:303:b6::25)
 by SA0PR12MB7090.namprd12.prod.outlook.com (2603:10b6:806:2d5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Mon, 6 Mar
 2023 20:43:34 +0000
Received: from CO1NAM11FT080.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::23) by MW4PR03CA0080.outlook.office365.com
 (2603:10b6:303:b6::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28 via Frontend
 Transport; Mon, 6 Mar 2023 20:43:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT080.mail.protection.outlook.com (10.13.174.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.15 via Frontend Transport; Mon, 6 Mar 2023 20:43:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 6 Mar 2023
 12:43:23 -0800
Received: from [10.41.21.79] (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 6 Mar 2023
 12:43:18 -0800
Message-ID: <b1a98a10-cc8d-e2f1-f234-c4804763b6ab@nvidia.com>
Date:   Tue, 7 Mar 2023 02:13:15 +0530
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
 <22525720-9def-27de-cf41-8fd8165d6e01@linaro.org>
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <22525720-9def-27de-cf41-8fd8165d6e01@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT080:EE_|SA0PR12MB7090:EE_
X-MS-Office365-Filtering-Correlation-Id: 68f901d3-a63d-4e8e-e627-08db1e8373ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0swMJzxT9fElDx4/MEJQJs9AdkLV65JL3j7mQF7lEfHBRpKUFXECW6EPDxIiXMv8XJYsqV1GbsHKzm3+FR8AR7rJpqZ5hhPf4BcQyEq27TN9NbiBIfqM/oaoxCDYp9elxeG6xHHs1pcH/c0ztYANqBgVHI1mTdRj9OYPW6t3/H0vf+3BryptzaLBN+18EYDU0Fztu2aM78EIOeWNxxS3Bt6UIb9jKqEbR8swanxNJJ8ICmHo2XqfxKan1Wr5qIUiSoWDxKjxUUE351VqUCnj+EzgXHu6yZQa5nYu1Lnmgv585YygyFpF7DZZsDNV+iZzJ40Jsnfm2q39noT1C+gSnpN97YBznFzlEkR5PtQAGl4XakzgoRQfojKNGqM9AXXmBJidzFFvJNsddjZ0lb/CF5/6/PAdVQkbZ2obdfB/Oi9ALxdJg6T11XcTyDFh+mu76v3t0n0F9sz9bXlMtV5pPsvZrCCyE8PeP6YNEic242y3mc+CutvVYi0PzDMtASAitl1Aj4XutKi22rQeASF3FqPumW3gVCCF56ysLojkRxixKLNAJ4U3p8ZEZUjiUTSCXc4W6jle9p09XuqxYKIsRicTuOw4ukuMUAO35JwU+Fd3LHS3pEfKNY4WpoXOt3+cMtW1OS7qPdxEOvEsjqFZXzNatZPy5nOUYokSIILXfDrXHRhJOWgqxlU+PGit5Ivze+9h0WBKbhmPn2Im0gIkfzJ86xh++OPPIJXJbp0MGdk=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(39860400002)(346002)(451199018)(46966006)(36840700001)(40470700004)(31686004)(36756003)(4326008)(70206006)(70586007)(41300700001)(7416002)(40480700001)(8676002)(8936002)(2906002)(5660300002)(82740400003)(7636003)(36860700001)(86362001)(31696002)(356005)(6666004)(107886003)(478600001)(110136005)(54906003)(316002)(16576012)(82310400005)(47076005)(83380400001)(40460700003)(426003)(53546011)(2616005)(336012)(186003)(16526019)(26005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 20:43:33.4345
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68f901d3-a63d-4e8e-e627-08db1e8373ca
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT080.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7090
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 06/03/23 20:37, Krzysztof Kozlowski wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 06/03/2023 16:05, Krzysztof Kozlowski wrote:
>> On 20/02/2023 15:05, Sumit Gupta wrote:
>>> This patch series adds memory interconnect support for Tegra234 SoC.
>>> It is used to dynamically scale DRAM Frequency as per the bandwidth
>>> requests from different Memory Controller (MC) clients.
>>> MC Clients use ICC Framework's icc_set_bw() api to dynamically request
>>> for the DRAM bandwidth (BW). As per path, the request will be routed
>>> from MC to the EMC driver. MC driver passes the request info like the
>>> Client ID, type, and frequency request info to the BPMP-FW which will
>>> set the final DRAM freq considering all exisiting requests.
>>>
>>> MC and EMC are the ICC providers. Nodes in path for a request will be:
>>>       Client[1-n] -> MC -> EMC -> EMEM/DRAM
>>>
>>> The patch series also adds interconnect support in below client drivers:
>>> 1) CPUFREQ driver for scaling bandwidth with CPU frequency. For that,
>>>     added per cluster OPP table which will be used in the CPUFREQ driver
>>>     by requesting the minimum BW respective to the given CPU frequency in
>>>     the OPP table of given cluster.
>>> 2) PCIE driver to request BW required for different modes.
>>
>> No dependencies or ordering written, so I am free to take memory
>> controller bits, I assume.
> 
> And not.. NAK, since you decided to ignore my comments. Really, we do
> not have time for such useless ping pong.
> 
> Best regards,
> Krzysztof
> 

Hi Krzysztof,

I tried to address the comments given during review of v1 in v2.
I am sorry if in case I missed any suggestion. Please let me know so I 
can incorporate that.

Thanks,
Sumit
