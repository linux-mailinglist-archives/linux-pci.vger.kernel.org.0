Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE8E56ED0DA
	for <lists+linux-pci@lfdr.de>; Mon, 24 Apr 2023 17:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231917AbjDXPA6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Apr 2023 11:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbjDXPA5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Apr 2023 11:00:57 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F85EA;
        Mon, 24 Apr 2023 08:00:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b+DEgv5WydH8j+fPAPoNW8E4OpC0jiS6WD+kwtAPsJq9NyyfNNw5GV5dXM1rtP/OGSIPalNcJLPxWH/m7rGv2J5Pq56NDCii2DAPIxbpJjTCCMQftI7sObjle36hYj2AGUr+cReQHx1iIHNSORyZwHoL2c2GFx2LyTg/2BY6+kBiFq0qYnXH17Q08Hu2y3QTFIUpLcoNjcFpl6Kt9W+6F65FArJNNZEKqJ1b6UztvRnvVN5pVUY9WN0s70pyuWpYmXW61JF2KeLD5zW1Y74wJrgKygVFPbg5rjyT6T/W+4dTcY19ZhVyZMp+UCsEBHh5LuujvLHvgxOeFZswqjH2hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VW4rInGFW2+FKAbW2pviwzHs37gmUwgB3wNhXLMW9XI=;
 b=D7YtUzZn/YF0tDa734J0tbkeMnAqMji3skyxJfbiKZOhdm8ydxH4UR6Pd0nOQ5lv854Ee1ebWg1Jw7TFjmCFJG/J83pdQz2X84fXOxwZhzEPWCuTQYETnxUtsDqiM6UZww9l2JjxZbrheeeR1ouL9+RmYljNBICljcH8dyEn41vO+M7eFRqnST8lAViRMtkR5GgK/f7GzCWJ3cF/i3a7qgF8ceqCuqImCS28S+9QwkCAYCbik4lorimHV0/vKzm6JZNWJrm+Uvmrg0A2raVYSJB5M2hiJKzjRqD4h3Z+SHiajhQm22b0AA5KsifK4iE7FuZbWru1lUCh28DX72MsFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VW4rInGFW2+FKAbW2pviwzHs37gmUwgB3wNhXLMW9XI=;
 b=NOGVNKkF3cDtaIui5r4D4vbs4JcgWxXZPmWp8ex6Lo+OdpcMcAbzxTYPllq4FeJ0Ti3SBxId6/Km3EvBGiTD6yL0yDP+WMl/nNFzdw/t2laH9/rC8NMteFdXVhr6TfCxkAe8qo2GQuxZNSaXEeEcoPHDJ0Xuqokej92ybTWydKzVfzpOKIR+FAsjPyonIRpeNOUzz2tQD3hyEAL+ppDcwML1Fbd9qnzA54MpNbsVGVao9BJZenRJIGWcU3CGSY/QatRx8cIJyk4ch23lCXzWn7KBOol8ka5+GpK1wxpGXr8171oC8V9/q76Icwjab+TJBqalWKYa5vwDitDgPVO2XA==
Received: from DM5PR07CA0074.namprd07.prod.outlook.com (2603:10b6:4:ad::39) by
 SA1PR12MB7221.namprd12.prod.outlook.com (2603:10b6:806:2bd::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.32; Mon, 24 Apr 2023 15:00:52 +0000
Received: from DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ad:cafe::62) by DM5PR07CA0074.outlook.office365.com
 (2603:10b6:4:ad::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33 via Frontend
 Transport; Mon, 24 Apr 2023 15:00:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT037.mail.protection.outlook.com (10.13.172.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.19 via Frontend Transport; Mon, 24 Apr 2023 15:00:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 24 Apr 2023
 08:00:23 -0700
Received: from [10.41.21.79] (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 24 Apr
 2023 08:00:17 -0700
Message-ID: <3071273b-b03b-5fc8-ffa1-9b18311a3a5d@nvidia.com>
Date:   Mon, 24 Apr 2023 20:30:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [Patch v7 1/8] memory: tegra: add interconnect support for DRAM
 scaling in Tegra234
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
References: <20230424131337.20151-1-sumitg@nvidia.com>
 <20230424131337.20151-2-sumitg@nvidia.com>
 <7c6c6584-204a-ada1-d669-2e8bef50e5e5@linaro.org>
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <7c6c6584-204a-ada1-d669-2e8bef50e5e5@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT037:EE_|SA1PR12MB7221:EE_
X-MS-Office365-Filtering-Correlation-Id: f0ef6c75-c9d3-4911-df82-08db44d4b2b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lMxVoRQ4vhGBIJgP6xA72XJMmUAz4wOTpX8MmsGEAy3YFLlTaG2KLyy8BrZkk0ZDJB43JE/Mfd405nUzPF9ZSkMmxFWJxdL4zS2i+9ogjYhauDGoAnmufCKIFAUI/+4NGaG4ZO6+jkHzb4FISzSHKuB9BFljZRP4Zd/Z6D0R5YXf7LXFR959iSQP69m0me1DWI/O2dnQEFqZwDvmQ0ECI3dGzevihxJ1eAKo+AefvYD+NeXlY0bLsneGIIPhbmbBf+Y+b3jABNRIUQQkJGHu42BSLX7XuI0CUPSiW6u4T3qNnjjO+GBULgzvopxxkAca3wsuv6gfZfT64NypJpKmRa1i5hleVOO2s40vaOZC8O3ydEudp29epL4TP60U7sSYV4ZtG/ePp1Ac9WYzAu+fcnDsjbDHvD6MiP5knGURwnRCzSXINCFgRVGX9Bj46Q20fhyqX5fcPTAMQBh6vLQ7FzDsMG6F/bDCwj63S4MMLoV5FL5pXsno6EdB6JiU/kS2t/v79xd4RG17J6CqWn2EJOJkU/h2/6ayJ/DjZNTowp3o1s4Whm4OLURDTLKVo0YYP1ceQXz6zR+AOMEwN6/I5M94Cz12M+EHAkLVtOoWsRtqxYQbAVZrfqCgxRcxJaQsWs6pwff8sulT0ee+9Fx+qGM8WAmXDjnLlMSezv/iJvYTdwpBginr14bfzlVVGRyem1tuyu33qEIv0anxmjSz4i9Rwn3nzhosVQy+usYwt6qHmB4FnomjDOESzr0k/DD6
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(346002)(136003)(451199021)(46966006)(40470700004)(36840700001)(34020700004)(336012)(7636003)(356005)(82740400003)(53546011)(426003)(26005)(2616005)(40480700001)(186003)(16526019)(83380400001)(47076005)(107886003)(36860700001)(2906002)(8676002)(7416002)(5660300002)(8936002)(36756003)(40460700003)(478600001)(54906003)(110136005)(316002)(4326008)(41300700001)(70586007)(31696002)(70206006)(16576012)(86362001)(82310400005)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 15:00:52.3539
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0ef6c75-c9d3-4911-df82-08db44d4b2b3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7221
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



On 24/04/23 19:18, Krzysztof Kozlowski wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 24/04/2023 15:13, Sumit Gupta wrote:
>> Add Interconnect framework support to dynamically set the DRAM
>> bandwidth from different clients. Both the MC and EMC drivers are
>> added as ICC providers. The path for any request is:
>>   MC-Client[1-n] -> MC -> EMC -> EMEM/DRAM
>>
> Thank you for your patch. There is something to discuss/improve.
> 
> 
>> +static int tegra_emc_interconnect_init(struct tegra186_emc *emc)
>> +{
>> +     struct tegra_mc *mc = dev_get_drvdata(emc->dev->parent);
>> +     const struct tegra_mc_soc *soc = mc->soc;
>> +     struct icc_node *node;
>> +     int err;
>> +
>> +     emc->provider.dev = emc->dev;
>> +     emc->provider.set = tegra_emc_icc_set_bw;
>> +     emc->provider.data = &emc->provider;
>> +     emc->provider.aggregate = soc->icc_ops->aggregate;
>> +     emc->provider.xlate = tegra_emc_of_icc_xlate;
>> +     emc->provider.get_bw = tegra_emc_icc_get_init_bw;
>> +
>> +     icc_provider_init(&emc->provider);
>> +
>> +     /* create External Memory Controller node */
>> +     node = icc_node_create(TEGRA_ICC_EMC);
>> +     if (IS_ERR(node)) {
>> +             err = PTR_ERR(node);
>> +             goto err_msg;
>> +     }
>> +
>> +     node->name = "External Memory Controller";
>> +     icc_node_add(node, &emc->provider);
>> +
>> +     /* link External Memory Controller to External Memory (DRAM) */
>> +     err = icc_link_create(node, TEGRA_ICC_EMEM);
>> +     if (err)
>> +             goto remove_nodes;
>> +
>> +     /* create External Memory node */
>> +     node = icc_node_create(TEGRA_ICC_EMEM);
>> +     if (IS_ERR(node)) {
>> +             err = PTR_ERR(node);
>> +             goto remove_nodes;
>> +     }
>> +
>> +     node->name = "External Memory (DRAM)";
>> +     icc_node_add(node, &emc->provider);
>> +
>> +     err = icc_provider_register(&emc->provider);
>> +     if (err)
>> +             goto remove_nodes;
>> +
>> +     return 0;
>> +
>> +remove_nodes:
>> +     icc_nodes_remove(&emc->provider);
>> +err_msg:
>> +     dev_err(emc->dev, "failed to initialize ICC: %d\n", err);
>> +
>> +     return err;
>> +}
>> +
>>   static int tegra186_emc_probe(struct platform_device *pdev)
>>   {
>> +     struct tegra_mc *mc = dev_get_drvdata(pdev->dev.parent);
>>        struct mrq_emc_dvfs_latency_response response;
>>        struct tegra_bpmp_message msg;
>>        struct tegra186_emc *emc;
>> @@ -236,6 +339,29 @@ static int tegra186_emc_probe(struct platform_device *pdev)
>>        debugfs_create_file("max_rate", S_IRUGO | S_IWUSR, emc->debugfs.root,
>>                            emc, &tegra186_emc_debug_max_rate_fops);
>>
>> +     if (mc && mc->soc->icc_ops) {
>> +             /*
>> +              * Initialize the ICC even if BPMP-FW doesn't support 'MRQ_BWMGR_INT'.
>> +              * Use the flag 'mc->bwmgr_mrq_supported' within MC driver and return
>> +              * EINVAL instead of passing the request to BPMP-FW later when the BW
>> +              * request is made by client with 'icc_set_bw()' call.
>> +              */
>> +             err = tegra_emc_interconnect_init(emc);
>> +             if (err)
>> +                     goto put_bpmp;
>> +
>> +             if (tegra_bpmp_mrq_is_supported(emc->bpmp, MRQ_BWMGR_INT)) {
>> +                     mc->bwmgr_mrq_supported = true;
>> +
>> +                     /*
>> +                      * MC driver probe can't get BPMP reference as it gets probed
>> +                      * earlier than BPMP. So, save the BPMP ref got from the EMC
>> +                      * DT node in the mc->bpmp and use it in MC's icc_set hook.
>> +                      */
>> +                     mc->bpmp = emc->bpmp;
> 
> This (and ()) are called without any locking. You register first the
> interconnect, so set() callback can be used, right? Then set() could be
> called anytime between tegra_emc_interconnect_init() and assignment
> above. How do you synchronize these?
> 
> Best regards,
> Krzysztof
> 

Currently, the tegra234_mc_icc_set() has NULL check. So, it will give 
this error.
  if (!mc->bpmp) {
          dev_err(mc->dev, "BPMP reference NULL\n");
          return -ENOENT;
  }

To fix, we can do the below change and swap the order. Please let me 
know if this sounds fine ?
  if (mc && mc->soc->icc_ops) {
          if (tegra_bpmp_mrq_is_supported(emc->bpmp, MRQ_BWMGR_INT)) {
                  mc->bwmgr_mrq_supported = true;
                  mc->bpmp = emc->bpmp;
          }

          err = tegra_emc_interconnect_init(emc);
          if (err)
                  goto put_bpmp;

  }

Thank you,
Sumit Gupta
