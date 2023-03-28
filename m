Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD1C6CBF73
	for <lists+linux-pci@lfdr.de>; Tue, 28 Mar 2023 14:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232709AbjC1Mmp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Mar 2023 08:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232494AbjC1Mmj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Mar 2023 08:42:39 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E025283F6;
        Tue, 28 Mar 2023 05:42:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N7VvDVJa4KwRG/ZJDI4wWcfJgygOr/A8dG7Q/BM8SU0CSRmaMUMqSPjRZ56fXFeG+AWldmN3/SJnNnWS2NgL23Q4LpeFkUArE41+dzLr2xdj0ap0kGEk/XNUP6zOSAsmfDxWkjmfrNafc5b+BNuXQrDnIF6X5SID9AXOUlWHcIqbeFuhFhJiplm+NDtpKqxJnUkexrS9O9B1IeZb+VVOpaHfVT2so2xgjhTddQTLl1oDyxT7fKqpydV5okPknbpIQMTbTLUFrodATqN/LwDQfn2omuJ/aC3nUkv9ebizmdX+6mM3Sux9qqqxboXaRPVMcRiLZT9FscmhBeZjO/QK1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RCNWDk1jVtPNZxpVXdlzF4nocbA7v7f8PjQq1mHeOHA=;
 b=IdJkpbGwiUb9LxUaj6VtVbiPs1WN5G7TiJP3P9c7qP/4YZzNXwN0I6pHvIdbfEjUgRzfjWUfpqvzJM2PpyORjMNNqPNh0Igv/DzXmeTASqLAVZqzqzojPnLZQqpiR0Y5YFuP8bhV0GyrbZyJzSZVAbQgWAB2U5j2YXdRHEPTmqkbKZJw84H481hemYJyyBv2ZWxUZB6CqGf+tOQeAmQydhQjb1VVYaz23ioZMGPf3v4sxJ7Wbo54QCRpmiuTn4EiItBQoXu43WHabagw/Ylgdwc6PsA/phsUWbCfds3WYgM0XsprgLtahSuGGeM7rpNtVJAlReYfv0jkFDAWl61TVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RCNWDk1jVtPNZxpVXdlzF4nocbA7v7f8PjQq1mHeOHA=;
 b=mwkYexB6B/4TiHW7QFhWTQ51Xkaahay0UuZduCLUDsA+bhvLmCiOCQpPvX0GqJqam/U4mzplz6baCryG9A+D0qr7F4sB+uArxjNvtkU5uMYLJK3hJp2cjnwd9KDZQMBvrCg8DaCTXFOb8RZpoCZGt9rvX6X+p8HmfT9OGLBtZiBpuQWS3eYJGYUOEtlLL6fttxcifQeI0T2sbF7TCHaIlUzhM48AgrZGF9czcEYQy7MeykivxPyVrA71l9dgn3lZ60dzKmnFXOxHPo4mqNEm2OBvW4sVR9PgfbpHxOYhbvUMDx4e5dUJ9ElV8Iswf5rIb8938raezEnpB0vuOVt7BA==
Received: from BN9PR03CA0045.namprd03.prod.outlook.com (2603:10b6:408:fb::20)
 by IA1PR12MB6019.namprd12.prod.outlook.com (2603:10b6:208:3d5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Tue, 28 Mar
 2023 12:42:14 +0000
Received: from BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fb:cafe::8e) by BN9PR03CA0045.outlook.office365.com
 (2603:10b6:408:fb::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.43 via Frontend
 Transport; Tue, 28 Mar 2023 12:42:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT059.mail.protection.outlook.com (10.13.177.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.22 via Frontend Transport; Tue, 28 Mar 2023 12:42:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 28 Mar 2023
 05:42:04 -0700
Received: from [10.41.21.79] (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 28 Mar
 2023 05:41:58 -0700
Message-ID: <db682990-573f-e827-7342-ca8cda0b4067@nvidia.com>
Date:   Tue, 28 Mar 2023 18:11:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [Patch v4 02/10] arm64: tegra: add bpmp ref in tegra234-mc node
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
References: <20230327161426.32639-1-sumitg@nvidia.com>
 <20230327161426.32639-3-sumitg@nvidia.com>
 <af455119-7178-bed8-4099-ee50c7b6134b@linaro.org>
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <af455119-7178-bed8-4099-ee50c7b6134b@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT059:EE_|IA1PR12MB6019:EE_
X-MS-Office365-Filtering-Correlation-Id: 78d0f487-76db-435a-e95a-08db2f89db99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1tAHrFmrmFxxzDEMAy9twXiDJtMp638uARarkaes7lglUE1xassMz+qOCUFtQ6J+kbAza8/XCmO/Fy7dSLLVXEDKnRWbYRJcNoauZYDY+QsPYF6kZy0ygbRTSg5wrOR79gACHygCYa7VKvXnxHdYLimmdBtWHpkg2grFiFPOQ1HG+2qpC8/FBQTFoKWitz6n6SQf1swK4/a35SKH7Y6HH0tdp92mB3GqiYU9HAqVqUmo0qIjRumtmfcDwkgvPebEhKVduzpDIn/xnT03Ir6Y51uc8/04AaHwgs0TNiVXSu0I12oypaF5G5eTT00lL+FB/WOKCONLcBIR/cy7TYB/jY+twxJHEu33SThE8Q1aVq+Dk7QCRJ8D9E8dyQhuEMYiWWsYYrrkiTsAGhLoWO2XkVXbVlQdY3ZdtjHc+IDJDZBTWml189S5uNw16dafLfDfB+zXQFmyM2La7E5aB3Y6jeU6eVdUsEFQHdP3fy74FlFvtk1Qq3YcuGBhJjMdKuNyDM4xrKyuVd4+uDrX/cC7u71U6XjNQddsGlhYfPbCSbkj8kXBMtw9zUtSn2x4yn5d8u7AXY1gC+vWQsZJV3ffKyKe3VnPsrI6NBM9yoYmoPlII6+PMvUVi20TB6na3oYl2WOZmZJ6/FSh1+NTWFyEQDjL6WRxaPOIJvLllPFyftpT4WxVL9g0tKu3g46IDfO2iwbPi5tscSSFygsDZnrtqtxNPhMELajw67aIcaUWtKyTp7Ne1MIvtLSWJizSaTT5VV3+c/c0JWPCG3bbJoVkwvkQPfyZS95dmJB+By7k2nrVup2A9qpISRD1qL4AfEvc
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(136003)(376002)(451199021)(46966006)(40470700004)(36840700001)(4326008)(40480700001)(41300700001)(36860700001)(40460700003)(70586007)(70206006)(16576012)(316002)(34020700004)(110136005)(478600001)(8676002)(54906003)(2906002)(53546011)(16526019)(186003)(7416002)(5660300002)(4744005)(2616005)(82310400005)(336012)(426003)(31696002)(31686004)(86362001)(47076005)(36756003)(82740400003)(107886003)(26005)(8936002)(7636003)(356005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 12:42:14.2348
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78d0f487-76db-435a-e95a-08db2f89db99
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6019
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 28/03/23 12:51, Krzysztof Kozlowski wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 27/03/2023 18:14, Sumit Gupta wrote:
>> Add the "nvidia,bpmp" property within the "memory-controller" node
>> to reference BPMP node. This is needed by the MC driver to pass
>> the client info to the BPMP-FW when memory interconnect support is
>> available.
>>
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> 
> DTS goes to the end of patchset. If you put it here to fix
> bisectability, then your patchset is already broken.
> 
> Best regards,
> Krzysztof
> 

Ok, will move the 'Patch 2 & 7' to the end of patch set (i.e. Patch 9 & 10)
   [Patch v4 02/10] arm64: tegra: add bpmp ref in tegra234-mc node
   [Patch v4 07/10] arm64: tegra: Add cpu OPP tables and interconnects 
property

Thank you,
Sumit Gupta

