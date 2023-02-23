Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F596A0506
	for <lists+linux-pci@lfdr.de>; Thu, 23 Feb 2023 10:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbjBWJhi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Feb 2023 04:37:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233738AbjBWJh3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Feb 2023 04:37:29 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64354515FB;
        Thu, 23 Feb 2023 01:37:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BvOooXi0wf9JZACdz7bKi4cgnAG1iQ6nS/ZTzdrgf1Qs9QEbRb+OIODzcX3Eq3H9206PuHYnd3bcm/KfNGm4KTRwpq9xn+j9teN7EPXpF887LxuxFWlyoa/znf6xPL7SyAP0/BrFhAwa2N18aInkCdcsxgpSQ1Mhqi/ygNxu+H9T5T3QhIq/pkr+zIaYavDl1356rgBoWWr+heLX6tNEB0i4FMcDn2kh2RfLTEUH7v8R8zu8qKWh1AlSYG76UVwLaRrkJvkDmqpfxyt+AoizUUS/yWp8rvHISqKYBMGwdcWYQob4I99WhY54QSMrajKZH0vg9+in+z8nXakkCIqJUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fRFftHCpj9jXdf/LDmklQhW9elWlSEauDRrd7aZAt4k=;
 b=T8X1ac/jhdcKv93z6icJ9ZSmlBf6mHwkHEtynAxKae4HCXzM6yDCVzNIk9odYmkvtLw7O0N3/JGaPuIsyjCyGuZANzCsZ0KFDeHQn0o0oXR65q023qFgFJn46aOJNOxcgq+2JefOYTUHdMJWIoE27iSLt8+xTpVfsw/S9Rs5ELrylgevQbLPBNcLEO+gHDoPCrXTy952Dq6KikpF1JVJLAbPTfbaSwchIwZVHXBbj6CStL4Ir7bbM4/EqfWbQ4VaAFw2h1W412widAW5ghcFvzMDQ7JypFhC4U9B1YFGze+JCePndXJhLFfJn73dTHWfv7mSrfpo8z+xqNl5AajJBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fRFftHCpj9jXdf/LDmklQhW9elWlSEauDRrd7aZAt4k=;
 b=MRz/7trTtXZMI3heH4KUQwokNV966b53h+9YCOAv/V388BWrrYGkTzKrgv4JEiJ7CmgaYe3FDma+i9l6tnBMX/ZUhde67JsEZvbUsiw9jmenExyJUcv1eWElOhJXMwXgrAfOPvAH+oCoDPBfOOyFHlw8NA94ffo6o5PLXDE53oYtT/YQ8NtbiLCfyPAkssh4qFmcs+d/BXz9AmZwAMcoNifoi5uT0JIKUhjIq4GI+GZWJy4/KMBBbjDZziAr+bsNWS6+hIYWncBEnoOoAjfemLvdvjBiDRoUTOnng69Ft6x9zdO7+01dn2NXGZkdhX1LQXuR3d6BcncRgUSKWg616A==
Received: from DM6PR11CA0016.namprd11.prod.outlook.com (2603:10b6:5:190::29)
 by CY8PR12MB7145.namprd12.prod.outlook.com (2603:10b6:930:5f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Thu, 23 Feb
 2023 09:36:48 +0000
Received: from DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:190:cafe::b3) by DM6PR11CA0016.outlook.office365.com
 (2603:10b6:5:190::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.21 via Frontend
 Transport; Thu, 23 Feb 2023 09:36:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT064.mail.protection.outlook.com (10.13.172.234) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.21 via Frontend Transport; Thu, 23 Feb 2023 09:36:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 23 Feb
 2023 01:36:37 -0800
Received: from [10.41.21.79] (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 23 Feb
 2023 01:36:30 -0800
Message-ID: <df054fae-5195-1ef8-c72e-e5afe8d901d3@nvidia.com>
Date:   Thu, 23 Feb 2023 15:06:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [Patch v2 7/9] cpufreq: tegra194: add OPP support and set
 bandwidth
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     <treding@nvidia.com>, <krzysztof.kozlowski@linaro.org>,
        <dmitry.osipenko@collabora.com>, <rafael@kernel.org>,
        <jonathanh@nvidia.com>, <robh+dt@kernel.org>,
        <lpieralisi@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <mmaddireddy@nvidia.com>, <kw@linux.com>, <bhelgaas@google.com>,
        <vidyas@nvidia.com>, <sanjayc@nvidia.com>, <ksitaraman@nvidia.com>,
        <ishah@nvidia.com>, <bbasu@nvidia.com>,
        Sumit Gupta <sumitg@nvidia.com>
References: <20230220140559.28289-1-sumitg@nvidia.com>
 <20230220140559.28289-8-sumitg@nvidia.com>
 <20230222040317.r2p6zlbumazymluc@vireshk-i7>
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <20230222040317.r2p6zlbumazymluc@vireshk-i7>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT064:EE_|CY8PR12MB7145:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c6763b8-7424-4fea-a971-08db15817c50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vieRK5rQRrMRd9S1aQkI6SY4REc5M5EUPRWgPEqf9HsDgSKnmHX+bgHp330u8MJfeQKJpBQkjQd+vM0EtvDPmCH/YYAQgEq5zSvlO5Ttw+BJxkhtjKf7OboH7EF3duDjNuWdXcfCqm9yrGr3U098Qe1DgCyNrSxMUuTDCsNgc2rWs9+ZyzK3A6NDucox/pTX5zR7GzybIjK74fe7n5ZQXTHpuJ24RKVGHdLtPVBzXWuhhnpv26xohVlv8CJFIe2S3bC8GF1EXVHVn6VKYJHn1gPY/+5iYI/40WLnBZZMvwIn6HWHVjcGeBwdEX8TmbZ71JuZ0uIIa5ml1mHntm+5x/A0p2rIzrs0UfPVa7cvl/BJQ4Jpqtt/gEoHuU5Vp7DRN0swPsLwfXYtafvfj5e1sOy90M0jDfh93tOdDpK+GYn/MKQvKHqAnhNVSxszzvqfd7syuaQPwZyDPU4at3sFyldDUtjapfeqjL7NVxwiJUJx8hUeorcmihR3GTn+SbnYP1op/fAhDoCDusOOmTPFNPxmQdAm/jS7vBIq8MH6QuWsBAnbS6hUfb5EB54blpn97m9RgYx1Le61qdhWIqRSiU8p9F7PGpGhHdCEkrcft8YbSq1s6uFsQp8rAB7sF5Y0b3JZXGlSWG+0kVkdf+wED0qRgHHI352quzScwnHOZJtZ/2Jt310Ms3poAGEpH8Po34PvvDmfgMJwzmTKHQY7egEZAooqzXMkMcYbCnvDQpUIMOhpFGp3E/vWf+EZxvZ0HnGL4QXe8McoKqyatqbTTQ==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(136003)(376002)(346002)(451199018)(46966006)(40470700004)(36840700001)(336012)(16526019)(31696002)(36756003)(186003)(26005)(82310400005)(31686004)(6666004)(2616005)(6916009)(478600001)(86362001)(426003)(47076005)(16576012)(83380400001)(70206006)(8676002)(70586007)(53546011)(107886003)(54906003)(316002)(4326008)(41300700001)(8936002)(7416002)(5660300002)(36860700001)(34020700004)(82740400003)(2906002)(40480700001)(7636003)(40460700003)(356005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2023 09:36:48.2120
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c6763b8-7424-4fea-a971-08db15817c50
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7145
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 22/02/23 09:33, Viresh Kumar wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 20-02-23, 19:35, Sumit Gupta wrote:
>> +static int tegra_cpufreq_set_bw(struct cpufreq_policy *policy, unsigned long freq_khz)
>> +{
>> +     struct dev_pm_opp *opp;
>> +     struct device *dev;
>> +     int ret;
>> +
>> +     dev = get_cpu_device(policy->cpu);
>> +     if (!dev)
>> +             return -ENODEV;
>> +
>> +     opp = dev_pm_opp_find_freq_exact(dev, freq_khz * KHZ, true);
>> +     if (IS_ERR(opp))
>> +             return PTR_ERR(opp);
>> +
>> +     ret = dev_pm_opp_set_opp(dev, opp);
>> +     dev_pm_opp_put(opp);
> 
> What about dev_pm_opp_set_rate() instead ?
> 
>> +     return ret;
>> +}
> 
> --
> viresh

Tried using it and got below crash. It seems to be coming because we 
don't have clocks property within CPU node for SoC's having BPMP-FW.

  Unable to handle kernel NULL pointer dereference at virtual address 
000000000000002e
  ....
  Call trace:
   clk_round_rate+0x38/0xd8
   dev_pm_opp_set_rate+0xe4/0x1a8
   tegra194_cpufreq_set_target+0x74/0x88
   __cpufreq_driver_target+0x154/0x250
   cpufreq_online+0x7b4/0x9ac

Thanks,
Sumit
