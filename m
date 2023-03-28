Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C48D6CBF40
	for <lists+linux-pci@lfdr.de>; Tue, 28 Mar 2023 14:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjC1Mga (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Mar 2023 08:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbjC1Mg3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Mar 2023 08:36:29 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on20629.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaa::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0760DA5E0;
        Tue, 28 Mar 2023 05:36:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N70gmgFgs+4yLDYprIIaAuGWuQkvR7dr7e+N4hFEVstAY5DvmIvVuRp+phTzMNkWf90Z4Okoxl0pSaH/thVkPejqz8skiGuHGnCYe9o4Ag6rXSbDR6b3q3A8678S48WccCkE16+Us222rxrKGqRFeCKj/EHnizQqUU4Pq7oZhOTAfQOI43gSHjScf4ieSNJTN76SlLZAq7+hV7l7svsn8YQlVnV5qFmmMQs7vtjvCg7IlQVoWQsvyYe/XViigDrjzxl93jIVb+18GkP7Zu167S/+fMbbK2pIlO8taIhhIQrj0GvMeHVK/DaAwiImlaozzz1jLIygYSDVrK6PdXEdqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g88IRCFz5dM5RtmHZGUDQNCP9oPjwuqMIcc1TspUo6w=;
 b=eRH78wUL4bO0hXzmhh6nsOtOhghFVCEuAYXIv6iUZkKgM8NkAH1WRfhD+/B4Zdb+D5nDJR1x0SWPTUBcMWQzBfAt3NPXGefA235qT+6KpbCMtirAgwHPDXsjIjG+yYP0eq9jFDC4CQJorjZNw2aP9gF5PB9KtSzukFGoA5Jh5PitohvPromlroCLxbLdw7HhqFeIc6VWsF23adRjpOoakVwKp1fRRU6RfRB7V8mw79ATycpiVWRdSAmv6aqQruhkv3WHm4dDltH8jBCrqYubFabcWGhEcrsmSljnpv2lp2Xba7gT3rrNAvhKRtON2hesEzw3HH4fcukbGy7GjyGvFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g88IRCFz5dM5RtmHZGUDQNCP9oPjwuqMIcc1TspUo6w=;
 b=F1CKwIeLWYUfEeUVKMMaHxp2q3xoyfKrldTnhSZgJxwQRKoZVzS4/ZZZU1dATHGIhMFM9b41U8OBOAjGKxNHN5fgWsoiICIzZ2eAdOB0czBcjlGkRFNTN6iQhqp/nIE2cwMyoK3y8uVPj/WhA33cQFY2GwzPPmegcX1eZ6zKq0+YA3yPP6urw3dhrx/7QBWQWuof1sKN6ux5EZ28EzfwADE4HZqMM0b0lnvmHnTZcuh1CMAhCLz8Y0COLv0CAQueDPQNOixWZpetcOZeWEcfyrh1lhA6X9Lu0TfcUaCvhjiTXnAaVSg0yzocGaTvy8jj8dbJ5oHbYBSaCYNU768weA==
Received: from MW4PR02CA0018.namprd02.prod.outlook.com (2603:10b6:303:16d::17)
 by SJ1PR12MB6171.namprd12.prod.outlook.com (2603:10b6:a03:45a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Tue, 28 Mar
 2023 12:34:56 +0000
Received: from CO1NAM11FT097.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::72) by MW4PR02CA0018.outlook.office365.com
 (2603:10b6:303:16d::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.43 via Frontend
 Transport; Tue, 28 Mar 2023 12:34:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT097.mail.protection.outlook.com (10.13.175.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.22 via Frontend Transport; Tue, 28 Mar 2023 12:34:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 28 Mar 2023
 05:34:45 -0700
Received: from [10.41.21.79] (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 28 Mar
 2023 05:34:39 -0700
Message-ID: <34631b30-7589-9b9d-4dd0-2e2606f62887@nvidia.com>
Date:   Tue, 28 Mar 2023 18:04:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [Patch v4 03/10] memory: tegra: add interconnect support for DRAM
 scaling in Tegra234
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
 <20230327161426.32639-4-sumitg@nvidia.com>
 <8b04a266-20eb-f1c1-278f-764b1b06b78b@linaro.org>
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <8b04a266-20eb-f1c1-278f-764b1b06b78b@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT097:EE_|SJ1PR12MB6171:EE_
X-MS-Office365-Filtering-Correlation-Id: 25e68f07-af5b-475b-f637-08db2f88d675
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UxrjGKoImP6apgizhhXjnLqTrFk0jmXamaOnxrF88xPEcXK0vLFmeKpzLCKqQhoqhJJhnXyFVESaMlBYzi3gj/japLcOGQtutvLnH/k+cwgTpwLmBJdLDdKo+IhaI0CqDaVUMe8AARR4CV5/8xwk4EY0Vk2RV35JYuaaII8U+foe3i3CwYD54KUY2NJ26WlieLxtt+/6E3ZTF3fHLrTiCU2yZn5u2uBz1tVnYYICZAx1k8p44Amq3rntNRbEcpXdRzLphmhfFRvpMUAFvfz34MVBRdYQaJz+aDHsPLVDztbaWWFwbWAR4FbZJlhe73EIkyDIKOuu0o5+vdw0l1LZ9taTltLNx/LHT22eE9r/Yddi8Ow0e8CtMv6kRhm02aj+xpEfmjd3n8X6S3W4/eeUm9mO3TXKe1/gEE0l/4RZceB83XZYiD2Gt/zu4qYY6cjim+8ewpiJE+n4V/yuR8P0nb4wY6whLemUB0kzLwomWgEgk4MNX1ESjCy9hKjQ/B89lp4XxS7CGhTS78R/fkpQlIX8+4E1jl/Ht2sXESl8wJ83VFnIlMnJSQddl6RobSjFHhwMEdSQiCoHuJz8OIHI9mP9AbAnZhp3byvnpyaWVu6GsE3YPsTTh7271p5gxW8iUJQ6/SPNREiw291h+lJFnS64ecbGLj7V4gYzLRj4q66ULr0BK09I8HQZwCrbOxWIWZKT2XVcdKEK7ZKSTsZy5pAUzZ+U71dB8RfQBT8LBEWlzNBAO2wsOnzdxy73VmDvmAZm17pz3oVceHVyXjpO3rrlilhjbNRxEwagrABkpKiC/xvd0V1GJGEcaNPwq/7N
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(376002)(396003)(346002)(451199021)(36840700001)(46966006)(40470700004)(54906003)(5660300002)(478600001)(8936002)(7416002)(186003)(16576012)(82310400005)(316002)(2906002)(82740400003)(26005)(31696002)(40480700001)(107886003)(70206006)(36756003)(110136005)(426003)(16526019)(40460700003)(4326008)(83380400001)(41300700001)(31686004)(47076005)(336012)(36860700001)(70586007)(34020700004)(53546011)(8676002)(86362001)(356005)(2616005)(7636003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 12:34:56.1451
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25e68f07-af5b-475b-f637-08db2f88d675
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT097.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6171
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 28/03/23 13:01, Krzysztof Kozlowski wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 27/03/2023 18:14, Sumit Gupta wrote:
>> Add Interconnect framework support to dynamically set the DRAM
>> bandwidth from different clients. Both the MC and EMC drivers are
>> added as ICC providers. The path for any request is:
>>   MC-Client[1-n] -> MC -> EMC -> EMEM/DRAM
>>
>> MC client's request for bandwidth will go to the MC driver which
>> passes the client request info like BPMP Client ID, Client type
>> and the Bandwidth to the BPMP-FW. The final DRAM freq to achieve
>> the requested bandwidth is set by the BPMP-FW based on the passed
>> parameters.
>>
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> ---
>>   drivers/memory/tegra/mc.c           |   5 +
>>   drivers/memory/tegra/tegra186-emc.c | 125 ++++++++++++++++++++++++
>>   drivers/memory/tegra/tegra186.c     |   3 +
>>   drivers/memory/tegra/tegra234.c     | 143 +++++++++++++++++++++++++++-
>>   include/linux/tegra-icc.h           |  65 +++++++++++++
>>   include/soc/tegra/mc.h              |   7 ++
>>   6 files changed, 347 insertions(+), 1 deletion(-)
>>   create mode 100644 include/linux/tegra-icc.h
>>
>> diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
>> index 9082b6c3763d..983455b1f98d 100644
>> --- a/drivers/memory/tegra/mc.c
>> +++ b/drivers/memory/tegra/mc.c
>> @@ -15,6 +15,7 @@
>>   #include <linux/platform_device.h>
>>   #include <linux/slab.h>
>>   #include <linux/sort.h>
>> +#include <linux/tegra-icc.h>
>>
>>   #include <soc/tegra/fuse.h>
>>
>> @@ -792,6 +793,8 @@ static int tegra_mc_interconnect_setup(struct tegra_mc *mc)
>>        mc->provider.data = &mc->provider;
>>        mc->provider.set = mc->soc->icc_ops->set;
>>        mc->provider.aggregate = mc->soc->icc_ops->aggregate;
>> +     mc->provider.get_bw = mc->soc->icc_ops->get_bw;
>> +     mc->provider.xlate = mc->soc->icc_ops->xlate;
>>        mc->provider.xlate_extended = mc->soc->icc_ops->xlate_extended;
>>
>>        icc_provider_init(&mc->provider);
>> @@ -824,6 +827,8 @@ static int tegra_mc_interconnect_setup(struct tegra_mc *mc)
>>                err = icc_link_create(node, TEGRA_ICC_MC);
>>                if (err)
>>                        goto remove_nodes;
>> +
>> +             node->data = (struct tegra_mc_client *)&(mc->soc->clients[i]);
>>        }
>>
>>        err = icc_provider_register(&mc->provider);
>> diff --git a/drivers/memory/tegra/tegra186-emc.c b/drivers/memory/tegra/tegra186-emc.c
>> index e935ad4e95b6..1eefcf2ac0c7 100644
>> --- a/drivers/memory/tegra/tegra186-emc.c
>> +++ b/drivers/memory/tegra/tegra186-emc.c
>> @@ -7,9 +7,11 @@
>>   #include <linux/debugfs.h>
>>   #include <linux/module.h>
>>   #include <linux/mod_devicetable.h>
>> +#include <linux/of_platform.h>
>>   #include <linux/platform_device.h>
>>
>>   #include <soc/tegra/bpmp.h>
>> +#include "mc.h"
>>
>>   struct tegra186_emc_dvfs {
>>        unsigned long latency;
>> @@ -29,8 +31,15 @@ struct tegra186_emc {
>>                unsigned long min_rate;
>>                unsigned long max_rate;
>>        } debugfs;
>> +
>> +     struct icc_provider provider;
>>   };
>>
>> +static inline struct tegra186_emc *to_tegra186_emc(struct icc_provider *provider)
>> +{
>> +     return container_of(provider, struct tegra186_emc, provider);
>> +}
>> +
>>   /*
>>    * debugfs interface
>>    *
>> @@ -146,11 +155,104 @@ DEFINE_DEBUGFS_ATTRIBUTE(tegra186_emc_debug_max_rate_fops,
>>                          tegra186_emc_debug_max_rate_get,
>>                          tegra186_emc_debug_max_rate_set, "%llu\n");
>>
>> +/*
>> + * tegra_emc_icc_set_bw() - Set BW api for EMC provider
>> + * @src: ICC node for External Memory Controller (EMC)
>> + * @dst: ICC node for External Memory (DRAM)
>> + *
>> + * Do nothing here as info to BPMP-FW is now passed in the BW set function
>> + * of the MC driver. BPMP-FW sets the final Freq based on the passed values.
>> + */
>> +static int tegra_emc_icc_set_bw(struct icc_node *src, struct icc_node *dst)
>> +{
>> +     return 0;
>> +}
>> +
>> +static struct icc_node *
>> +tegra_emc_of_icc_xlate(struct of_phandle_args *spec, void *data)
>> +{
>> +     struct icc_provider *provider = data;
>> +     struct icc_node *node;
>> +
>> +     /* External Memory is the only possible ICC route */
>> +     list_for_each_entry(node, &provider->nodes, node_list) {
>> +             if (node->id != TEGRA_ICC_EMEM)
>> +                     continue;
>> +
>> +             return node;
>> +     }
>> +
>> +     return ERR_PTR(-EPROBE_DEFER);
>> +}
>> +
>> +static int tegra_emc_icc_get_init_bw(struct icc_node *node, u32 *avg, u32 *peak)
>> +{
>> +     *avg = 0;
>> +     *peak = 0;
>> +
>> +     return 0;
>> +}
>> +
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
> 
> Blank line
> 
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
>>        struct mrq_emc_dvfs_latency_response response;
>>        struct tegra_bpmp_message msg;
>>        struct tegra186_emc *emc;
>> +     struct tegra_mc *mc;
>>        unsigned int i;
>>        int err;
>>
>> @@ -158,6 +260,9 @@ static int tegra186_emc_probe(struct platform_device *pdev)
>>        if (!emc)
>>                return -ENOMEM;
>>
>> +     platform_set_drvdata(pdev, emc);
>> +     emc->dev = &pdev->dev;
> 
> This patch looks like stiched from two or more patches... emc->dev does
> not look like new member of emc, thus why do you set in exisitng
> function in this patch? Why it wasn't needed before?
> 
> Same about line before.
> 
Replied in other mail. will fix this.

>> +
>>        emc->bpmp = tegra_bpmp_get(&pdev->dev);
>>        if (IS_ERR(emc->bpmp))
>>                return dev_err_probe(&pdev->dev, PTR_ERR(emc->bpmp), "failed to get BPMP\n");
>> @@ -236,6 +341,25 @@ static int tegra186_emc_probe(struct platform_device *pdev)
>>        debugfs_create_file("max_rate", S_IRUGO | S_IWUSR, emc->debugfs.root,
>>                            emc, &tegra186_emc_debug_max_rate_fops);
>>
>> +     mc = dev_get_drvdata(emc->dev->parent);
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
>> +             if (tegra_bpmp_mrq_is_supported(emc->bpmp, MRQ_BWMGR_INT))
>> +                     mc->bwmgr_mrq_supported = true;
>> +             else
>> +
> 
> Drop blank line.
> 
>> +                     dev_info(&pdev->dev, "MRQ_BWMGR_INT not present\n");
> 
> And what user is supposed to do with this? Either make it descriptive or
> drop.
> 
Replied in other mail. will fix this.


>> +     }
>> +
>>        return 0;
>>
>>   put_bpmp:
>> @@ -272,6 +396,7 @@ static struct platform_driver tegra186_emc_driver = {
>>                .name = "tegra186-emc",
>>                .of_match_table = tegra186_emc_of_match,
>>                .suppress_bind_attrs = true,
>> +             .sync_state = icc_sync_state,
>>        },
>>        .probe = tegra186_emc_probe,
>>        .remove = tegra186_emc_remove,
>> diff --git a/drivers/memory/tegra/tegra186.c b/drivers/memory/tegra/tegra186.c
>> index 7bb73f06fad3..386e029e41bb 100644
>> --- a/drivers/memory/tegra/tegra186.c
>> +++ b/drivers/memory/tegra/tegra186.c
>> @@ -10,6 +10,7 @@
>>   #include <linux/of_device.h>
>>   #include <linux/platform_device.h>
>>
>> +#include <soc/tegra/bpmp.h>
>>   #include <soc/tegra/mc.h>
>>
>>   #if defined(CONFIG_ARCH_TEGRA_186_SOC)
>> @@ -65,6 +66,8 @@ static int tegra186_mc_probe(struct tegra_mc *mc)
>>   static void tegra186_mc_remove(struct tegra_mc *mc)
>>   {
>>        of_platform_depopulate(mc->dev);
>> +
>> +     tegra_bpmp_put(mc->bpmp);
>>   }
>>
>>   #if IS_ENABLED(CONFIG_IOMMU_API)
>> diff --git a/drivers/memory/tegra/tegra234.c b/drivers/memory/tegra/tegra234.c
>> index 02dcc5748bba..4f34247c9bda 100644
>> --- a/drivers/memory/tegra/tegra234.c
>> +++ b/drivers/memory/tegra/tegra234.c
>> @@ -1,18 +1,24 @@
>>   // SPDX-License-Identifier: GPL-2.0-only
>>   /*
>> - * Copyright (C) 2021-2022, NVIDIA CORPORATION.  All rights reserved.
>> + * Copyright (C) 20212-2023, NVIDIA CORPORATION.  All rights reserved.
> 
> Typo, 2021.
> 
Will fix.

>>    */
>>
>>   #include <soc/tegra/mc.h>
>>
>>   #include <dt-bindings/memory/tegra234-mc.h>
>> +#include <linux/interconnect.h>
>> +#include <linux/of_device.h>
> 
> One more suprising change...
> 
Will remove the header file "of_device.h".

>> +#include <linux/tegra-icc.h>
>>
>> +#include <soc/tegra/bpmp.h>
>>   #include "mc.h"
>>
>>   static const struct tegra_mc_client tegra234_mc_clients[] = {
>>        {
>>                .id = TEGRA234_MEMORY_CLIENT_MGBEARD,
>>                .name = "mgbeard",
>> +             .bpmp_id = TEGRA_ICC_BPMP_EQOS,
>> +             .type = TEGRA_ICC_NISO,
>>                .sid = TEGRA234_SID_MGBE,
>>                .regs = {
>>                        .sid = {
> 
> 
> Best regards,
> Krzysztof
> 
