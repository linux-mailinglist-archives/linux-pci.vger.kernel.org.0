Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C22D56ED131
	for <lists+linux-pci@lfdr.de>; Mon, 24 Apr 2023 17:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbjDXPWM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Apr 2023 11:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjDXPWK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Apr 2023 11:22:10 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9986E2D53;
        Mon, 24 Apr 2023 08:22:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OsYUGljp77UCc530Xiqq1ASjpeMAt/spllS+TgzXlI1s0tSogWAUJqionYT6wAENPqYxqru0V1Fe6DIt7rVEzySPCjJr7PeuXfskvwZ1VZQpuUPdvBt2aKpAXuEImGsmi/PEp4woruMw9aVpfKbJMYkNB4iB6yYFvoTiMd9xSi+QuK/tiDZQCI6VBn9/29Er6ZFYfHA7kCuzXRjHOu/W9oU6ltd78LC+95uq8UZX4KG47ba2Xxr6SRvfC5gtfg704INd2Ms4oETYb5bNRT1KXd9BvdU3p68bEtBOZ/xbgpjbqwAV5vRIBFXcKmacf1sFc6gMFf/RhzuPt/SJorTvbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wkNyH9PrA9NRO1gC8bFsn1pBISDSrYxTEt1Bhw0tr2E=;
 b=TSFzt0p3OAsXtgXAVg2a3UG6dKB6rorkzw6Gc+Vj1Yx7X6KXctjT7lxiFvyklACi/gHWEBn+kaUo7hLoqfN21NiP6TE/58l2uDweWWHsLAmWpIBmlTT06RLHQtNENayVOO2p3SFra0iCCbmH8nnw6NJASMKbNqCzJMEsmAc+OzQg3laVTD6fPT6nDCfbMBTJzKGWU7KaSAgP1JZrCX2845ofwy4aVBSKnh9IAh5SykPwd0tiqEFfsg+eCifVnNCHiJsPr59FfB5+a3QbNLcxJpasG2lP6+vuWBdiM2PRgdPvfDje93zG4hhfh+ZcB4CMGGpEFKcFIkFvXhQ+NPZ4uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wkNyH9PrA9NRO1gC8bFsn1pBISDSrYxTEt1Bhw0tr2E=;
 b=grjVeOFOiIUX9/dTnkoE9erdTklgQFIc/rnJ7IR4n1FT6DN2u2EYMbQdH7DN+mLE7V1i5biA1UvSTlyVNjXPmrhXJe9cdR7aRcgJfexdsqTeo2DnoMoOcej8i9A4tQVUh+BdBbPBEj766yLsnqjbGKE2ORM8FSpIsUWptcApcG/cxIcGxt50E+CWRiySlogY+3yg7yFseHVVh897ULzyJfO9l2m9sDXR32ySjBFGTCvhjuJga74eEqDOMV0Fj3zqqyc3Nsn3/w6AM4wruhxjOpPcvEswWjaq0bHiCb2mx27glrxms5/e6JDnO97qXnPMEzP9G1VP+05Y/9Dz/Vn/4A==
Received: from DM5PR08CA0052.namprd08.prod.outlook.com (2603:10b6:4:60::41) by
 DM4PR12MB8524.namprd12.prod.outlook.com (2603:10b6:8:18d::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.33; Mon, 24 Apr 2023 15:22:04 +0000
Received: from DS1PEPF0000E64D.namprd02.prod.outlook.com
 (2603:10b6:4:60:cafe::d3) by DM5PR08CA0052.outlook.office365.com
 (2603:10b6:4:60::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33 via Frontend
 Transport; Mon, 24 Apr 2023 15:22:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF0000E64D.mail.protection.outlook.com (10.167.18.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.15 via Frontend Transport; Mon, 24 Apr 2023 15:22:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 24 Apr 2023
 08:21:53 -0700
Received: from [10.41.21.79] (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 24 Apr
 2023 08:21:47 -0700
Message-ID: <5ab9687e-756d-f94b-b085-931d4ea534c1@nvidia.com>
Date:   Mon, 24 Apr 2023 20:51:44 +0530
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
Content-Language: en-US
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <3071273b-b03b-5fc8-ffa1-9b18311a3a5d@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E64D:EE_|DM4PR12MB8524:EE_
X-MS-Office365-Filtering-Correlation-Id: af3a6628-73b5-4738-4599-08db44d7a89e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GXFmR1nLty4KCbQ1aPrP+lgJg/zbHJexKLUBwPFRDLyvDuYHFPzluWCTAASqELD1f1n1m1nq3Osc0hK42qTUfEmhFub+4fV5+JR0rI1+QNqSRfIKBx2mbYAial6ua41+67Zhmyfp1HZfMk/Kakf2h1s6bkG05Hn/iDpLbLaA0nvABEnkzKXgYRvxFQSGW2LP2o2SnjV6T8+cks/ljx/0HfbVoNkBburwt2mWM08euXVB98TFIVXzOiFsuhPUoQ6tlpYA1SzdDIU9dc2txoessBx/XeCEmDK7/Um8g/NeqUZ0sNP8v1X77P5CDPlDya+DEP4BYJwI2A4pkJBSZc/Mg70hAKpRXzWjBPY9uKbxsb5//UEaClKFouS9nCXxvGFh+/jjgaWEY5EWRs395tO7/S2TYN/9pUFb+3Mg5orCgYwAuk1KgKkkFlqrbmjDXzoKobMHAoi8NEPGydpLoRvy+bR+BDpxvDiv3hufeHaJG826FtlVMfuqdbZM5r8eacYbYwdWEaRHSnC/GzvM7dsuAkTAmZWl0nhPPeS41OZxd5snCVxgw3JfhKm5LKURPnsHidyxjY4Z4uvGpgQ+LZjzlDKTmeQnjfAfCkMRv3oXLbYXfaTh0pMyMgiCdM6RBL2mAvc0qe3dHxj0TL3Ywy+53qy9lb3vT9uJzG0AcOovfnsUFt2stqONb9uigOxUPCINmZnJT5WPyx/cOichJAXw/2j1LW304szYHYCqYmlisVc=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(376002)(346002)(451199021)(46966006)(36840700001)(40470700004)(26005)(53546011)(186003)(16526019)(40460700003)(40480700001)(31696002)(16576012)(110136005)(6666004)(426003)(336012)(54906003)(86362001)(478600001)(8936002)(5660300002)(47076005)(8676002)(7416002)(83380400001)(82740400003)(316002)(70206006)(70586007)(4326008)(31686004)(2906002)(7636003)(356005)(41300700001)(2616005)(107886003)(82310400005)(36756003)(36860700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 15:22:03.9253
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af3a6628-73b5-4738-4599-08db44d7a89e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E64D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8524
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



On 24/04/23 20:30, Sumit Gupta wrote:
> 
> 
> On 24/04/23 19:18, Krzysztof Kozlowski wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On 24/04/2023 15:13, Sumit Gupta wrote:
>>> Add Interconnect framework support to dynamically set the DRAM
>>> bandwidth from different clients. Both the MC and EMC drivers are
>>> added as ICC providers. The path for any request is:
>>>   MC-Client[1-n] -> MC -> EMC -> EMEM/DRAM
>>>
>> Thank you for your patch. There is something to discuss/improve.
>>
>>
>>> +static int tegra_emc_interconnect_init(struct tegra186_emc *emc)
>>> +{
>>> +     struct tegra_mc *mc = dev_get_drvdata(emc->dev->parent);
>>> +     const struct tegra_mc_soc *soc = mc->soc;
>>> +     struct icc_node *node;
>>> +     int err;
>>> +
>>> +     emc->provider.dev = emc->dev;
>>> +     emc->provider.set = tegra_emc_icc_set_bw;
>>> +     emc->provider.data = &emc->provider;
>>> +     emc->provider.aggregate = soc->icc_ops->aggregate;
>>> +     emc->provider.xlate = tegra_emc_of_icc_xlate;
>>> +     emc->provider.get_bw = tegra_emc_icc_get_init_bw;
>>> +
>>> +     icc_provider_init(&emc->provider);
>>> +
>>> +     /* create External Memory Controller node */
>>> +     node = icc_node_create(TEGRA_ICC_EMC);
>>> +     if (IS_ERR(node)) {
>>> +             err = PTR_ERR(node);
>>> +             goto err_msg;
>>> +     }
>>> +
>>> +     node->name = "External Memory Controller";
>>> +     icc_node_add(node, &emc->provider);
>>> +
>>> +     /* link External Memory Controller to External Memory (DRAM) */
>>> +     err = icc_link_create(node, TEGRA_ICC_EMEM);
>>> +     if (err)
>>> +             goto remove_nodes;
>>> +
>>> +     /* create External Memory node */
>>> +     node = icc_node_create(TEGRA_ICC_EMEM);
>>> +     if (IS_ERR(node)) {
>>> +             err = PTR_ERR(node);
>>> +             goto remove_nodes;
>>> +     }
>>> +
>>> +     node->name = "External Memory (DRAM)";
>>> +     icc_node_add(node, &emc->provider);
>>> +
>>> +     err = icc_provider_register(&emc->provider);
>>> +     if (err)
>>> +             goto remove_nodes;
>>> +
>>> +     return 0;
>>> +
>>> +remove_nodes:
>>> +     icc_nodes_remove(&emc->provider);
>>> +err_msg:
>>> +     dev_err(emc->dev, "failed to initialize ICC: %d\n", err);
>>> +
>>> +     return err;
>>> +}
>>> +
>>>   static int tegra186_emc_probe(struct platform_device *pdev)
>>>   {
>>> +     struct tegra_mc *mc = dev_get_drvdata(pdev->dev.parent);
>>>        struct mrq_emc_dvfs_latency_response response;
>>>        struct tegra_bpmp_message msg;
>>>        struct tegra186_emc *emc;
>>> @@ -236,6 +339,29 @@ static int tegra186_emc_probe(struct 
>>> platform_device *pdev)
>>>        debugfs_create_file("max_rate", S_IRUGO | S_IWUSR, 
>>> emc->debugfs.root,
>>>                            emc, &tegra186_emc_debug_max_rate_fops);
>>>
>>> +     if (mc && mc->soc->icc_ops) {
>>> +             /*
>>> +              * Initialize the ICC even if BPMP-FW doesn't support 
>>> 'MRQ_BWMGR_INT'.
>>> +              * Use the flag 'mc->bwmgr_mrq_supported' within MC 
>>> driver and return
>>> +              * EINVAL instead of passing the request to BPMP-FW 
>>> later when the BW
>>> +              * request is made by client with 'icc_set_bw()' call.
>>> +              */
>>> +             err = tegra_emc_interconnect_init(emc);
>>> +             if (err)
>>> +                     goto put_bpmp;
>>> +
>>> +             if (tegra_bpmp_mrq_is_supported(emc->bpmp, 
>>> MRQ_BWMGR_INT)) {
>>> +                     mc->bwmgr_mrq_supported = true;
>>> +
>>> +                     /*
>>> +                      * MC driver probe can't get BPMP reference as 
>>> it gets probed
>>> +                      * earlier than BPMP. So, save the BPMP ref got 
>>> from the EMC
>>> +                      * DT node in the mc->bpmp and use it in MC's 
>>> icc_set hook.
>>> +                      */
>>> +                     mc->bpmp = emc->bpmp;
>>
>> This (and ()) are called without any locking. You register first the
>> interconnect, so set() callback can be used, right? Then set() could be
>> called anytime between tegra_emc_interconnect_init() and assignment
>> above. How do you synchronize these?
>>
>> Best regards,
>> Krzysztof
>>
> 
> Currently, the tegra234_mc_icc_set() has NULL check. So, it will give 
> this error.
>   if (!mc->bpmp) {
>           dev_err(mc->dev, "BPMP reference NULL\n");
>           return -ENOENT;
>   }
> 
> To fix, we can do the below change and swap the order. Please let me 
> know if this sounds fine ?
>   if (mc && mc->soc->icc_ops) {
>           if (tegra_bpmp_mrq_is_supported(emc->bpmp, MRQ_BWMGR_INT)) {
>                   mc->bwmgr_mrq_supported = true;
>                   mc->bpmp = emc->bpmp;
>           }
> 
>           err = tegra_emc_interconnect_init(emc);
>           if (err)
>                   goto put_bpmp;
> 
>   }
Sorry, replied too soon. Missed setting "mc->bpmp" to NULL. Sharing new 
proposed change. Please let me know if this looks OK.

  if (mc && mc->soc->icc_ops) {
     if (tegra_bpmp_mrq_is_supported(emc->bpmp, MRQ_BWMGR_INT)) {
             mc->bwmgr_mrq_supported = true;
             mc->bpmp = emc->bpmp;
     }

     err = tegra_emc_interconnect_init(emc);
     if (err) {
             mc->bpmp = NULL;
             goto put_bpmp;
     }
  }

> 
> Thank you,
> Sumit Gupta
