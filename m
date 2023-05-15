Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4324C702AF5
	for <lists+linux-pci@lfdr.de>; Mon, 15 May 2023 12:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236542AbjEOK5j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 May 2023 06:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjEOK5i (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 May 2023 06:57:38 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D374493;
        Mon, 15 May 2023 03:57:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Btr6T0G/yC7QxBY32sjMYFXMS99v9MdLzBwxCwtSrYUTgal3j0uAgblGI/c6TlNMOcaOaemRh9xgCeyL3LvzQOp4rwYxOUPui7NFTiTRs/ObMhsVXXodz9PZ8vzDhTKe3kT+CrHw+uUo7KNFzIq4QTejyKZp6VKUiu3yFWGrfbaB/uRom1XlMEKKc37Iyf27LQwwP9rQQrUjh0dFpBeDDR04/KD6aIZlj+7ZP0aPfwJnFZ+EvqPaVpA+STrIrCpIfLRryGt33kfOQheVDWk+YspF0vKvXsIewk9GFiFyItHn5WTg8KA4fEVPMdEemhm9UvgziIJ5r2Lc2+bHOCQt6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bJOw3ltf55yXRRRLkl6eJw2L8EdRoG2qgOJnBEGqafg=;
 b=Lck+/zsxxlp/ZjFGKFJirkG/nra/PjWEH3MZMhXLd9zddWEo4R16WoFg4vVOh0iB0gdV199oKcsCz9AZawx9RQkStlyiVlvPY0yJ0Mhty6o3EggUcPOOrUFVJNSJrmwQjaqtQA06RtjWQ5N121SdsUvMa+p63xjRAUx/ac4VGNgWOeUkXdBQEKbZu++4dx156MKoby9MzaoVbA1SGnZRrDcosvM1rXJYRStSbr2Mdf9eOaVWwEc+PAtIrn6BVBOAA0ks1lnLlqAqOzGXiBzNrrVzJ+0Axrkg3VsKvMsgnGC3PaOoHCBBTllup5S1IdN34RQPcWHEXTCNa99jj56rrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bJOw3ltf55yXRRRLkl6eJw2L8EdRoG2qgOJnBEGqafg=;
 b=ZP6rhHbRsf6FWwCcJI7U9YxQVSRlD5dgQJ8Fnq5HotWStU5bNWv16fIveHSGId9CMfNFLi6BFvwU5XOm/+ErwMXPyEYQZxjSwQjOwzknaA4fdQ63rtuisvH41nWGptiemAVH+Q37oZJXujKVObic8fBBfWlha9uUcAJZP1tx4sB3pGd43E/IrMva7ZPj1p8143QCOGRHvGEO52TaG/jWk20A4lVvpdgOAfTrhZosbFYGW1Z8WzE9t0rgrTID2rF1G4XIpCSK19MLqOGxgoCx4ODJp+AXIUV2BF5+Z7V5cna2V0YUDVYB8hANBcOTeigs3mNNy/kGliU2MWAQ4D39mw==
Received: from MW4PR03CA0223.namprd03.prod.outlook.com (2603:10b6:303:b9::18)
 by MN2PR12MB4391.namprd12.prod.outlook.com (2603:10b6:208:269::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 10:57:34 +0000
Received: from CO1NAM11FT069.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::3a) by MW4PR03CA0223.outlook.office365.com
 (2603:10b6:303:b9::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30 via Frontend
 Transport; Mon, 15 May 2023 10:57:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT069.mail.protection.outlook.com (10.13.174.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.14 via Frontend Transport; Mon, 15 May 2023 10:57:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 15 May 2023
 03:57:23 -0700
Received: from [10.41.21.79] (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 15 May
 2023 03:57:17 -0700
Message-ID: <6c8f0a58-ee37-8588-42fc-55697dd6dd37@nvidia.com>
Date:   Mon, 15 May 2023 16:27:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [Patch v8 0/8] Tegra234 Memory interconnect support
Content-Language: en-US
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
References: <20230511173211.9127-1-sumitg@nvidia.com>
 <a032d9e6-6cb5-1856-9eda-28028bf05633@linaro.org>
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <a032d9e6-6cb5-1856-9eda-28028bf05633@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT069:EE_|MN2PR12MB4391:EE_
X-MS-Office365-Filtering-Correlation-Id: 13f27d27-ad9d-45f2-359d-08db5533303a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: osKsD75lLZ/NBHfCXVEt/32xfH8LPBZ7pHWzR9akWNXR6APFAda+29YII4Y9RRfPMUyAf6ZOC3ifL2etgUTDdZaM+wB7lIyC43J0DMHp7opHnIeN/81LWU4tZu5SYROl9vQBzPhQYrOo4zQe8FTIBo0TRiFErGOVBibfpPjLuIgBnDNZC83LbPU3yGq8nixQHS1f4aee0yKeW31glwuUsgVZfsBqcnEIv29IC2ugVFp+VTk5OhbZujJOt5+HzPtL7kd82FW6Zt+Txv3YK4qrrC5Dw5OHs3bN4PsXd3JDDwQ90l0XIyGpLxGuaOFqXdmsrO+tJZb4eaDso3EBQlovDDQtar85gdauSPWVuse4DWxaQlsqifSUgxAVUJS8MS/Es48CGmDQA10YQklvrURbg8uCIjSn9JMMk6xCj2xDkXYizIUZmm4a127R9HeJew2oFougqMSkLKuNivgSxSv2AfadoeKvcBklcwO6hcpCJWZl+b0n+M51JAAMsxqAQDBtDMuu/hiv5s84NTnlvr1fUZMDTSSyFplaYn4KQsRsYkoow+VSKKNlFgg40uFhf7H79IYIUegsEBGcKuDoBk6287VlP6J2T8FUBTBfIaRodfKym+zVf3lka7UElOsB4cI6tBNc2e9KMUAqiLuPuDEZBzXf9r3XQbtiZyK8Vo6Pt+MoUSTcXq3EJfsgjETPAEmvbXqlN9SK+5/8VgOC72+LdujqKaw2zYlQ7lo/571wxcNu2ha5kjEZGD0Fcln6CCyp/cnv6YWtQPQUGD/RUYpnqPRpWOiFYY6mNAyDfejPBXkmrSgqLf78OqM+9fGL/rmV
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(136003)(346002)(451199021)(46966006)(36840700001)(40470700004)(36756003)(86362001)(16576012)(54906003)(110136005)(316002)(4326008)(70206006)(70586007)(966005)(478600001)(4744005)(82310400005)(40480700001)(5660300002)(8676002)(8936002)(6666004)(2906002)(7416002)(7636003)(31696002)(356005)(82740400003)(41300700001)(16526019)(2616005)(186003)(53546011)(107886003)(26005)(336012)(36860700001)(83380400001)(426003)(47076005)(31686004)(40460700003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 10:57:34.2933
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13f27d27-ad9d-45f2-359d-08db5533303a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT069.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4391
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 14/05/23 16:11, Krzysztof Kozlowski wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 11/05/2023 19:32, Sumit Gupta wrote:
>> Hi All,
>>
>> Have incorporated the suggestions in v7. Only changed 'patch 1' in v7
>> to fix possible race when setting 'mc->bpmp' as pointed by Krzysztof.
>> Requesting to merge the patch series.
>>
> 
> Can I apply it since you request it? 

Yes, the patch series can be applied in current sequence except that
the 'patch 4' comes before 'patch 3' (just realized).

Would you please swap 'patch 4' with 'patch 3' while applying
(or) you want me to re-send?

I asked you long time ago to
> clearly state dependencies or merging limitations. It's v8 and cover
> letter still does not state it. Neither the patches do.
> 
I added the dependency list in previous versions [7] but removed
thinking the patch series will now be applied altogether.

[7] https://lore.kernel.org/lkml/20230424131337.20151-1-sumitg@nvidia.com/

Thank you,
Sumit Gupta
