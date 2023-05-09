Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69EAF6FC7BD
	for <lists+linux-pci@lfdr.de>; Tue,  9 May 2023 15:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234838AbjEINST (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 May 2023 09:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234094AbjEINSS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 May 2023 09:18:18 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A911BE4;
        Tue,  9 May 2023 06:18:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KIOa7mH2JicmmVLTW/gj59LX2Mvm4iQyA3rjH7Wk3QpR6oxT+EyMlyPb3YkF6NjVwsX3e8rUK/k1RT03xiu2QcWT+DaCao+fJP9lAW70UtJK8a4RH3sJQKCjNOVH8UBtFBII9JyneaJDVPFGtqGeNnavQ5y6Euq3+nFYTEfcxTuUt3iwH8TgmIW9B8pj/5LRIgp5ARqJnhIMNdZDig5sR0VJeN+yScptfIUE3/Yn/efZom2TIZQi7q/RHIT4adQFl+DnnJGQ1S5ZypPXGkXxAtZRi6wGDBr0zLIXt1QyJrFGv7LX3UIH0GZUb27WKtQRpXAnfTcsrDoM105lFatlnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ILLYF4mvFibEJVb9UtUlh9+gJkApzyYSjsE94jYGEh4=;
 b=ThwP/VxKRp/hXTVItuvXq3i12ZNajsP4d2ARKMA6ojXjCGelgUUmnxmQb/rVczNWTUWMDrb0qTy4uKAz4m9QQEeiT6UNP8zdPpJRrQkNGlp3xNZ/YBJfCt9RiaxEYO13YiP+l+BA469K64jqjUElAh9uWx6xPFbVnWR9cg9N8724kBNatyoC3Mw/1K3N6TOcuf7djauyyUHySc8xf3jub/v4zJmVnP18tm7r71mM9v1oq8pLxeP9c9XDRVPoE6FFYlHPFpIU3vCcuYZlPJmpg11D82fFByHFIHE2gKa78IzvJdWA3Dim6uSAvgqy5eUqhVxCDG+mkVEE5TNraQAU2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ILLYF4mvFibEJVb9UtUlh9+gJkApzyYSjsE94jYGEh4=;
 b=ih3L3Y790BCnUKHn2lke03/L0fuGpqpp+9I3B97IYIyiQ0SIENX44Hf3pDoDxoAOXI4ln0HGqCQJ/QN7tvjXa+bvVErrzFu8xDjwN1QFZjFvFYfs9r/oLuQ/6B+kbWD98BvN0MoWXKADeL9PCv48iXi8iyCnW/0dpTMxBRE3MQn1N+UDKayhw3aXIKF+UHLkki+EkefHEY/NehtCUoRE1ZZKmi0NmPq6DwU7rRcm5mtXB3q/zeZq3fDV40PkoNnHrd/vgA/wrKg+UDqgjrBYKDSrbSwJYFLA9czSQvogHg7bCVSJid8q+xs9oRk7899MBSTbC8Pyg2hlb2HTOuIKeA==
Received: from DS7PR03CA0238.namprd03.prod.outlook.com (2603:10b6:5:3ba::33)
 by BL3PR12MB6594.namprd12.prod.outlook.com (2603:10b6:208:38d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 13:18:14 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:5:3ba:cafe::30) by DS7PR03CA0238.outlook.office365.com
 (2603:10b6:5:3ba::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33 via Frontend
 Transport; Tue, 9 May 2023 13:18:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.83) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.18 via Frontend Transport; Tue, 9 May 2023 13:18:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 9 May 2023
 06:17:56 -0700
Received: from [10.41.21.79] (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 9 May 2023
 06:17:50 -0700
Message-ID: <14438cf9-ec78-afb5-107a-4ed954ac0eb7@nvidia.com>
Date:   Tue, 9 May 2023 18:47:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
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
 <3071273b-b03b-5fc8-ffa1-9b18311a3a5d@nvidia.com>
 <5ab9687e-756d-f94b-b085-931d4ea534c1@nvidia.com>
 <10b32e55-4d28-5405-035e-c73a514c95e4@linaro.org>
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <10b32e55-4d28-5405-035e-c73a514c95e4@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|BL3PR12MB6594:EE_
X-MS-Office365-Filtering-Correlation-Id: 0827f75c-2ac9-48b5-df63-08db508fd84b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vN5/53qbm8U6fo622snRB9pHZs/mDSos6W22IQSWE3rYiU9cxX4NIrfbAcLsyA9cTVxfHRG6Okm8ZNlBiQFF9B/vCz+CYx709iXYSQoh5uyEPzyt5DJYGGOyAWjhvnTcogKbkUptPkgaIW14JEfy4qDASWXiLw8WsxSM5FH4saZvvATD3uEceEMeSOoH/sFV2FpXUyI7229UUioBM56C5FufxoWd/betfSR2ujozAmmBlPdsV2bOqrFXiFA6ct4dONPMmyWm3++S7kTSfijRH1IdDvbwGtXoNgyp52hlZMPYu1Q7MYaxFvcdu6R4rr/yyWvi9vrBEB4IgzMdN+H596viOnTaVYPGBc7Efa7Itliv8EIdhK8G6rIhKrioso1Dm+dI27bln4uFB+A2tBFW7npVXONVuS0iuPB8+9byWeL+yIbbI55QHFWW1zcC6Oerh+CE8hCRrcxSoak/ot1273pchC2RNvyKFiPJYQD6EqyTOKrX0vxErXaPrkOVOJCwR7ajYxEDTuM8THXomYpatSwNay+Dk096xAg85/DcPK8o580E0If/FjRY89BlY4wvoT0OjhKMGNvT5fWV/mRMl27csCMjGn6JzuaJ0SVIple38GW2uERd1GHNKevEYUpRHs47byl0A1z1Af0nKSEKxZzKX2dIYakuqsa9M6okaELb0sIuV+1IDbDkgF8OIPAzpyVhiK6mJ8wS5pVneV+uw8IxbulyP0EyMptW/Hu/65M=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(136003)(346002)(396003)(451199021)(40470700004)(46966006)(36840700001)(16526019)(186003)(478600001)(6666004)(7416002)(54906003)(16576012)(110136005)(82310400005)(107886003)(40480700001)(86362001)(53546011)(26005)(7636003)(40460700003)(356005)(31696002)(2906002)(82740400003)(4326008)(31686004)(41300700001)(83380400001)(5660300002)(36860700001)(2616005)(8936002)(8676002)(316002)(47076005)(36756003)(70206006)(70586007)(426003)(336012)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 13:18:14.1047
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0827f75c-2ac9-48b5-df63-08db508fd84b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6594
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 07/05/23 14:41, Krzysztof Kozlowski wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 24/04/2023 17:21, Sumit Gupta wrote:
>>
>>
>> On 24/04/23 20:30, Sumit Gupta wrote:
>>>
>>>
>>> On 24/04/23 19:18, Krzysztof Kozlowski wrote:
>>>> External email: Use caution opening links or attachments
>>>>
>>>>
>>>> On 24/04/2023 15:13, Sumit Gupta wrote:
>>>>> Add Interconnect framework support to dynamically set the DRAM
>>>>> bandwidth from different clients. Both the MC and EMC drivers are
>>>>> added as ICC providers. The path for any request is:
>>>>>    MC-Client[1-n] -> MC -> EMC -> EMEM/DRAM
>>>>>
>>>> Thank you for your patch. There is something to discuss/improve.
>>>>
>>>>
>>>>> +static int tegra_emc_interconnect_init(struct tegra186_emc *emc)
>>>>> +{
>>>>> +     struct tegra_mc *mc = dev_get_drvdata(emc->dev->parent);
>>>>> +     const struct tegra_mc_soc *soc = mc->soc;
>>>>> +     struct icc_node *node;
>>>>> +     int err;
>>>>> +
>>>>> +     emc->provider.dev = emc->dev;
>>>>> +     emc->provider.set = tegra_emc_icc_set_bw;
>>>>> +     emc->provider.data = &emc->provider;
>>>>> +     emc->provider.aggregate = soc->icc_ops->aggregate;
>>>>> +     emc->provider.xlate = tegra_emc_of_icc_xlate;
>>>>> +     emc->provider.get_bw = tegra_emc_icc_get_init_bw;
>>>>> +
>>>>> +     icc_provider_init(&emc->provider);
>>>>> +
>>>>> +     /* create External Memory Controller node */
>>>>> +     node = icc_node_create(TEGRA_ICC_EMC);
>>>>> +     if (IS_ERR(node)) {
>>>>> +             err = PTR_ERR(node);
>>>>> +             goto err_msg;
>>>>> +     }
>>>>> +
>>>>> +     node->name = "External Memory Controller";
>>>>> +     icc_node_add(node, &emc->provider);
>>>>> +
>>>>> +     /* link External Memory Controller to External Memory (DRAM) */
>>>>> +     err = icc_link_create(node, TEGRA_ICC_EMEM);
>>>>> +     if (err)
>>>>> +             goto remove_nodes;
>>>>> +
>>>>> +     /* create External Memory node */
>>>>> +     node = icc_node_create(TEGRA_ICC_EMEM);
>>>>> +     if (IS_ERR(node)) {
>>>>> +             err = PTR_ERR(node);
>>>>> +             goto remove_nodes;
>>>>> +     }
>>>>> +
>>>>> +     node->name = "External Memory (DRAM)";
>>>>> +     icc_node_add(node, &emc->provider);
>>>>> +
>>>>> +     err = icc_provider_register(&emc->provider);
>>>>> +     if (err)
>>>>> +             goto remove_nodes;
>>>>> +
>>>>> +     return 0;
>>>>> +
>>>>> +remove_nodes:
>>>>> +     icc_nodes_remove(&emc->provider);
>>>>> +err_msg:
>>>>> +     dev_err(emc->dev, "failed to initialize ICC: %d\n", err);
>>>>> +
>>>>> +     return err;
>>>>> +}
>>>>> +
>>>>>    static int tegra186_emc_probe(struct platform_device *pdev)
>>>>>    {
>>>>> +     struct tegra_mc *mc = dev_get_drvdata(pdev->dev.parent);
>>>>>         struct mrq_emc_dvfs_latency_response response;
>>>>>         struct tegra_bpmp_message msg;
>>>>>         struct tegra186_emc *emc;
>>>>> @@ -236,6 +339,29 @@ static int tegra186_emc_probe(struct
>>>>> platform_device *pdev)
>>>>>         debugfs_create_file("max_rate", S_IRUGO | S_IWUSR,
>>>>> emc->debugfs.root,
>>>>>                             emc, &tegra186_emc_debug_max_rate_fops);
>>>>>
>>>>> +     if (mc && mc->soc->icc_ops) {
>>>>> +             /*
>>>>> +              * Initialize the ICC even if BPMP-FW doesn't support
>>>>> 'MRQ_BWMGR_INT'.
>>>>> +              * Use the flag 'mc->bwmgr_mrq_supported' within MC
>>>>> driver and return
>>>>> +              * EINVAL instead of passing the request to BPMP-FW
>>>>> later when the BW
>>>>> +              * request is made by client with 'icc_set_bw()' call.
>>>>> +              */
>>>>> +             err = tegra_emc_interconnect_init(emc);
>>>>> +             if (err)
>>>>> +                     goto put_bpmp;
>>>>> +
>>>>> +             if (tegra_bpmp_mrq_is_supported(emc->bpmp,
>>>>> MRQ_BWMGR_INT)) {
>>>>> +                     mc->bwmgr_mrq_supported = true;
>>>>> +
>>>>> +                     /*
>>>>> +                      * MC driver probe can't get BPMP reference as
>>>>> it gets probed
>>>>> +                      * earlier than BPMP. So, save the BPMP ref got
>>>>> from the EMC
>>>>> +                      * DT node in the mc->bpmp and use it in MC's
>>>>> icc_set hook.
>>>>> +                      */
>>>>> +                     mc->bpmp = emc->bpmp;
>>>>
>>>> This (and ()) are called without any locking. You register first the
>>>> interconnect, so set() callback can be used, right? Then set() could be
>>>> called anytime between tegra_emc_interconnect_init() and assignment
>>>> above. How do you synchronize these?
>>>>
>>>> Best regards,
>>>> Krzysztof
>>>>
>>>
>>> Currently, the tegra234_mc_icc_set() has NULL check. So, it will give
>>> this error.
>>>    if (!mc->bpmp) {
> 
> How does it solve concurrent accesses and re-ordering of instructions by
> compiler or CPU?
> 

Now, the "mc->bpmp" is set before tegra_emc_interconnect_init().
So, until the EMC interconnect initializes, set() won't be
called as the devm_of_icc_get() call will fail.

Added the change in v8.

Thank you,
Sumit Gupta

>>>            dev_err(mc->dev, "BPMP reference NULL\n");
>>>            return -ENOENT;
>>>    }
>>>
>>> To fix, we can do the below change and swap the order. Please let me
>>> know if this sounds fine ?
>>>    if (mc && mc->soc->icc_ops) {
>>>            if (tegra_bpmp_mrq_is_supported(emc->bpmp, MRQ_BWMGR_INT)) {
>>>                    mc->bwmgr_mrq_supported = true;
>>>                    mc->bpmp = emc->bpmp;
>>>            }
>>>
>>>            err = tegra_emc_interconnect_init(emc);
>>>            if (err)
>>>                    goto put_bpmp;
>>>
>>>    }
>> Sorry, replied too soon. Missed setting "mc->bpmp" to NULL. Sharing new
>> proposed change. Please let me know if this looks OK.
>>
>>    if (mc && mc->soc->icc_ops) {
>>       if (tegra_bpmp_mrq_is_supported(emc->bpmp, MRQ_BWMGR_INT)) {
>>               mc->bwmgr_mrq_supported = true;
>>               mc->bpmp = emc->bpmp;
>>       }
>>
>>       err = tegra_emc_interconnect_init(emc);
>>       if (err) {
>>               mc->bpmp = NULL;
>>               goto put_bpmp;
> 
> Sorry, I didn't check the code. I assume you should do it...
> 
> Best regards,
> Krzysztof
> 
