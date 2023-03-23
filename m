Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DEF66C6901
	for <lists+linux-pci@lfdr.de>; Thu, 23 Mar 2023 14:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbjCWNAH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Mar 2023 09:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjCWNAG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Mar 2023 09:00:06 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D982FCD8;
        Thu, 23 Mar 2023 06:00:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kjr2kXQ3oPeyvz3gN27oxcBuwBDoplpTAE2WHyMAcUeCgIzO6+VT+hwzOISFMgfMZSlHEVhSDz80v4ByAG6p5745RB11vRcV1deTjloQT9SZJIHBveHwALLx59m2emcbojrumuAmZYkJ6EoalWproLQieyPMJngGMLg7npwDk26c5/NfDYmyYO7A1VSzFier70idKJGUuEvkFe5C8pyvfnSuu5HHtl5yYz/AuShZly02qnZkm5OR4kjFeOryPQNwiGV35Va/EaO0bgpoxdbidPolLeO/Yh5dS89YN486oX8ao8LYZyNAu7k/JQnUPydFVTbyrWw8SczzkBcQdOgk1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BTWUjc5IAUswz2wUrGyMauyczuDOVyRIkwq+Wl7Zla8=;
 b=HPNRQwNryaVLcXNullXiHw6s0tlQTunQB2WLnH7tTnPZYns1prNxpctgwv+KbbRj+ksS3VVUdGEnvVsvuH0nxXLq6o31e+Qdc4cnxuyZf7R4SykroojOG57Gd81mNxKcpDEKv3HCzvCSwhajfBr6EIIH7gsTI5ZMLycJpCdi7QCSCDSd607epPS1e63PdObysmN2JZxWVF1LmzHmLSMH04ciHHZInAauskqs4pOql+e+mO0DE6vToMS0LUYJzx+IOoj70TVOZScj1fuNhHcLy52fFigTdBHXFDCldeKwdwzDaHkrC7Kp+MF52Ik8mmjWkVE7y2JI5fxELaAfx+t/kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BTWUjc5IAUswz2wUrGyMauyczuDOVyRIkwq+Wl7Zla8=;
 b=t+Qby4sFpK+MRgYtODGMKr60QiJ2koJarXvVx8hh3lQhjczKaHt9VGO1hGLXMq37+tj2+uOHcdtOjMxIDCtASTiptXl3BqgMQnBi2JXNozQaY7fGvjcqGmEci6KLcjqIOJsUelEJVdcgKz31ROzinSNvRzbx0n0UnIaojFvAcVbYNNLVJPth8X828OXTpwub4NNRy0SpOUPhtRS9S1dkr6NMymS/wUPd72XC64tBxc2NDONM1EtGB4as06Khng4AQKHrRSXR7ITFOQSj4QUIyz4pdKmQxKRhhoAK8pwCL02H/Pq0GprbZmO2rbCpS7dWa2YI3Uh+hRnf+pn7zA9/tw==
Received: from DM6PR10CA0009.namprd10.prod.outlook.com (2603:10b6:5:60::22) by
 DS0PR12MB8453.namprd12.prod.outlook.com (2603:10b6:8:157::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.36; Thu, 23 Mar 2023 13:00:02 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:60:cafe::b7) by DM6PR10CA0009.outlook.office365.com
 (2603:10b6:5:60::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38 via Frontend
 Transport; Thu, 23 Mar 2023 13:00:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.21 via Frontend Transport; Thu, 23 Mar 2023 13:00:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 23 Mar 2023
 05:59:53 -0700
Received: from [10.41.21.79] (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 23 Mar
 2023 05:59:47 -0700
Message-ID: <c240eae7-8862-0589-d56d-f2e82e21569c@nvidia.com>
Date:   Thu, 23 Mar 2023 18:29:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [Patch v3 01/11] firmware: tegra: add function to get BPMP data
Content-Language: en-US
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <treding@nvidia.com>, <krzysztof.kozlowski@linaro.org>,
        <dmitry.osipenko@collabora.com>, <viresh.kumar@linaro.org>,
        <rafael@kernel.org>, <jonathanh@nvidia.com>, <robh+dt@kernel.org>,
        <lpieralisi@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <mmaddireddy@nvidia.com>, <kw@linux.com>, <bhelgaas@google.com>,
        <vidyas@nvidia.com>, <sanjayc@nvidia.com>, <ksitaraman@nvidia.com>,
        <ishah@nvidia.com>, <bbasu@nvidia.com>,
        Sumit Gupta <sumitg@nvidia.com>
References: <20230320182441.11904-1-sumitg@nvidia.com>
 <20230320182441.11904-2-sumitg@nvidia.com> <ZBwlLmPlBgC5tYTD@orome>
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <ZBwlLmPlBgC5tYTD@orome>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT003:EE_|DS0PR12MB8453:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a763006-29f7-4291-d329-08db2b9e83f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KRXnL6wQ8BVttKldbHYwzo3hVSFyOekSIvYCr6xrFbeLitvzNU9MDn/5vTQeZsSdU2BGGnKCcDPKpQWaPmOecYUkTxONyEVNG0s1hkpkZuADmpA9g4E+NLqwTTj7P/0jaaCKjgIgwFnlcFhVvAFW4ok4ichVgu5/A+ZI+K3hcy2gadJHmCUR4DvGiaXfm11B2IRfmtZ2wTGjRMubwpLKRV1PXK1I1//62JhdZUUEwmctMxlSG1PlmQcaTJvmVWFUbk41QFbNG5BaD2ustWLii4uIFcpsHS0J1wsBsmuQ6lHpoNpnPmZuyyNILwatXQOHTyBfcjmgzrDeOZ003Ujrrt9ddGLUdOm7BQgPOX5N61tdQUTWjkWC+ioGFbc7HdclESdhGQVNiZSSnkMKtbhCDcyTFR21LnjxjUMzRq+aQgU4nFDIcK4+1Z/Fcr2Z1B23hv7VIUs721VTzFUeSLeoPQJ5PveJAt/xGtcTrtKORYDPhIRaUqrrWHMtOIyJOcbeiEdeiHi368dZK4gf38uIoh8Y+CLLTil+KASUR1DT1V7EwdWGpcSKC3d/uCFoRQE11XM4ayVOeVXCcjycV+iYDsuLs8qGR3PxhToP308UT8H79bwAGOye0/iy/AVs3qSC4JR6nyhnQINqCamCnpkNXZG79P+ywOM1ygGVsLPhwXyIygnR1OpnrBoopayHg8lifs6nXmSjmXLHAxBRZueKTZwMgD+5nu4jkw+792C7pjVU2Gg7CT10mlMEIjRdCsZTHcxYoFZz5WgdFyXvxv8z2g==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(136003)(39860400002)(346002)(451199018)(46966006)(40470700004)(36840700001)(31686004)(41300700001)(4744005)(7416002)(5660300002)(8676002)(6916009)(4326008)(2906002)(40460700003)(36860700001)(82740400003)(356005)(86362001)(36756003)(31696002)(7636003)(26005)(107886003)(6666004)(70586007)(70206006)(478600001)(16576012)(316002)(8936002)(40480700001)(82310400005)(426003)(54906003)(47076005)(336012)(2616005)(16526019)(53546011)(186003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 13:00:02.0509
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a763006-29f7-4291-d329-08db2b9e83f9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8453
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 23/03/23 15:38, Thierry Reding wrote:
> On Mon, Mar 20, 2023 at 11:54:31PM +0530, Sumit Gupta wrote:
>> Add new function 'of_tegra_bpmp_get()' which can be
>> used by other drivers like MC to get BPMP data without
>> adding any property in respective drivers DT node.
>>
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> ---
>>   drivers/firmware/tegra/bpmp.c | 38 +++++++++++++++++++++++++++++++++++
>>   include/soc/tegra/bpmp.h      |  5 +++++
>>   2 files changed, 43 insertions(+)
> 
> Sorry for not noticing this earlier, but can we not resolve the BPMP
> using the existing tegra_bpmp_get()? That requires the presence of the
> nvidia,bpmp property, but since we're adding new functionality here
> that's not a problem.
> 
> Thierry

Ok, will add "nvidia,bpmp" property within mc node and cache the result 
to use later instead of doing the lookup every time. Also, will drop 
this patch in v4.

Thank you for suggesting.


Thank,
Sumit
