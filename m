Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F07106CBF0E
	for <lists+linux-pci@lfdr.de>; Tue, 28 Mar 2023 14:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232385AbjC1MbA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Mar 2023 08:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjC1Ma7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Mar 2023 08:30:59 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12hn2229.outbound.protection.outlook.com [52.100.165.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83BEB93CE;
        Tue, 28 Mar 2023 05:30:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z1ME4TQKbIpSbwkWPZVQUC3+H1ytxNe3+apZ7PkIJkY1s2QjDnEPaGgwKXMNZ/WBaWMT+Gt+hD/z2Uwz5nlsfDAeswTwQSTX2mqWQRjfPbWZa8mBBGh5yex7yBuAqCJtiKjrOQZy1KZCqCFgznutXVaQzFU/qqBOcnSvPQK5/QV3j9aPVMV2YqnX4nNyPUEIxQFPSBjvthxjfrF9h21IAtgoNoHqhiCMlJG9CnsOg9nM4uJAccaZ9SxPuE3bimaFPAkPxlBsMSftFWRhSILM4kbKNINikI7LnT9LJkFcypc7ilhD2SrwXYsv8tcZJj8HK/seOSS0Bie0OiabkUoCaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=trYyPnFc9/lt/ky83OY9EH8qkN+Cstbnm/KPxWwQapo=;
 b=Aeplxk7ed8QfZ6LdE9E1mitWtlNYqb0XfAKOGseGB67wyQDyc2KM9g5gFAX8Hww22AKgWApl1QHMp6CUK8AlewqENUYLXxgzReA9Gj746H91+q/OVAViLFK4dK4Y8Fkmuk1PTillCN4uNKBMpkFHh407qBReFyzRIC6ST9jopYj2TQ7U/1N0PCSMaDljagymlmc+R5qKbwpbUlkENH7ND4/IX+idbWmgRzFaxjBaNcLlsmGkHbJSxEQquch4vb6bSbTqTKkcJ+Yr0o0YDh0j4F9xiNYtXMJdG7+S4jIKt2TAZ01aeSyyYiyRH4dxk1Gcps3kn/nH/anFBDwiaxUTtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=trYyPnFc9/lt/ky83OY9EH8qkN+Cstbnm/KPxWwQapo=;
 b=rPsDJkBDAivnV1tvfMyulNcRoY4f49XVXj/h9i9wsXUr8MU9YGuf1Mz1yQoy57nGJpT29FZHjPr6pTvuk0d757ED9hK7l/Ekm9wLVK11TP4o8GfIRqLT9oMBsUDsKyMoP73l3jd8uNqeSGxmFv5TPk/6E3h33lxlSfD6WFF3MIXEG7smmq88JG3S1A5vRKbj5VvZWF/lc2dtS5a9cxDEwBlH06KYBX6NF2wfMNvDVOX33ejACO5oGfftxFMH74F+7toaW4Zxt7jlqMw589TV66omWwj0F1DvDIn+44rKKYZXZoMOVKoTSOJjpB9OiOp929d0Gz2Yf4yKncqDmmGh6w==
Received: from BN9PR03CA0043.namprd03.prod.outlook.com (2603:10b6:408:fb::18)
 by DS7PR12MB9043.namprd12.prod.outlook.com (2603:10b6:8:db::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.30; Tue, 28 Mar 2023 12:30:55 +0000
Received: from BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fb:cafe::7c) by BN9PR03CA0043.outlook.office365.com
 (2603:10b6:408:fb::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.42 via Frontend
 Transport; Tue, 28 Mar 2023 12:30:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT009.mail.protection.outlook.com (10.13.176.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6199.32 via Frontend Transport; Tue, 28 Mar 2023 12:30:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 28 Mar 2023
 05:30:41 -0700
Received: from [10.41.21.79] (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 28 Mar
 2023 05:30:34 -0700
Message-ID: <8139e102-677d-6850-b1c3-7a35e0e36904@nvidia.com>
Date:   Tue, 28 Mar 2023 18:00:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [Patch v4 03/10] memory: tegra: add interconnect support for DRAM
 scaling in Tegra234
Content-Language: en-US
To:     Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     <treding@nvidia.com>, <dmitry.osipenko@collabora.com>,
        <viresh.kumar@linaro.org>, <rafael@kernel.org>,
        <jonathanh@nvidia.com>, <robh+dt@kernel.org>,
        <lpieralisi@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <mmaddireddy@nvidia.com>, <kw@linux.com>, <bhelgaas@google.com>,
        <vidyas@nvidia.com>, <sanjayc@nvidia.com>, <ksitaraman@nvidia.com>,
        <ishah@nvidia.com>, <bbasu@nvidia.com>,
        Sumit Gupta <sumitg@nvidia.com>
References: <20230327161426.32639-1-sumitg@nvidia.com>
 <20230327161426.32639-4-sumitg@nvidia.com>
 <8b04a266-20eb-f1c1-278f-764b1b06b78b@linaro.org> <ZCLJ895gHPXQE+Lz@orome>
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <ZCLJ895gHPXQE+Lz@orome>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT009:EE_|DS7PR12MB9043:EE_
X-MS-Office365-Filtering-Correlation-Id: c0016396-0b92-4598-330a-08db2f8846e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o7B11kIsEyN4zPD60xq2tZ7SYbmTXrPBC+kyqflqkHk1FMcTQAMxI6vRkvc8v5QdoXoaWx8yiiy1Du+2RJAw/x52S1Unv1ZxyufZNtox56h1N52xI4dPTzRXIcO4GjOGXEmN60wjBD4zMwKoJ9drmB5eTWRgwHkKt5ayVpwL1W7cCuO19In9+MYGY2zADyxUW51FwFm3z1OzAQWNDsHaL0D6lFv86ri8CLRCkbI7Uq8L/CBBlEyXa2j4hBzwyGZKrWwkw7dgz8Wbx2A8dyBuBuQzYz1SNpR8Y3lbZ8qRBng6HpXmwSxr+BGTw8P+9I/7W/fJKpljUm87r+fv0c7NmL1mr2G5TlfAhyJj9i302q/wUz57xWClWlHjK3F4gfswm5g4bGsU5+EITNVmRyX/w1iVX2fDWEBIVoj+Qr4oPWlSvFUeEAfjDVzLj3mXejV1eMa5zdpxZOpzgJ6ubbjVBmj1RBlDov6GPlJdPosJx00B/xqbr19k4Fm83D8Sj+2JyrofA5JFFALdC4uhFRh1Fdsb0QnHrYXcUx/WV3AyxND1vmCj2+lT14nhBAjs9finjOeG+OX6UJCc0OHbLjRyX1czdqYcLGZ5H0ABZve3RWbHGliY6JaqvvkVSAUZsVy75A7fBoujznAUUJQFNgCbgYshTTBnlWuLjEgKPT7vNvjD3EQDy0l8nzGhXYjmIhIGxD8aFLj676cyr4AZgBTJGXbgnzAnYVVddEe9mon+gPa+zsDKhzZAivCG3yo/XVzVSXnA6k/VPfyDSy7YQw/WCHNB3bYZEMHdg/rZqpwGSDwtEaFQhH3Iv6lYqiIGPBm/Es/6DxkCNoBVsgI/CJnLGPhuyOgoW128fhHQVU557OU=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(136003)(39860400002)(5400799015)(451199021)(36840700001)(40470700004)(46966006)(356005)(7636003)(7416002)(8936002)(5660300002)(82310400005)(40480700001)(36756003)(53546011)(186003)(26005)(2616005)(16526019)(2906002)(107886003)(86362001)(31696002)(47076005)(36860700001)(83380400001)(426003)(336012)(34020700004)(82740400003)(40460700003)(4326008)(54906003)(70586007)(8676002)(41300700001)(70206006)(478600001)(110136005)(16576012)(316002)(31686004)(43740500002)(12100799027);DIR:OUT;SFP:1501;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 12:30:55.2706
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0016396-0b92-4598-330a-08db2f8846e8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9043
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 28/03/23 16:35, Thierry Reding wrote:
> On Tue, Mar 28, 2023 at 09:31:58AM +0200, Krzysztof Kozlowski wrote:
>> On 27/03/2023 18:14, Sumit Gupta wrote:
> [...]
>>> diff --git a/drivers/memory/tegra/tegra186-emc.c b/drivers/memory/tegra/tegra186-emc.c
> [...]
>>> @@ -158,6 +260,9 @@ static int tegra186_emc_probe(struct platform_device *pdev)
>>>   	if (!emc)
>>>   		return -ENOMEM;
>>>   
>>> +	platform_set_drvdata(pdev, emc);
>>> +	emc->dev = &pdev->dev;
>>
>> This patch looks like stiched from two or more patches... emc->dev does
>> not look like new member of emc, thus why do you set in exisitng
>> function in this patch? Why it wasn't needed before?
> 
> This looks like it may be leftover from some development. These two
> lines exist in this driver a few lines further down. Either one pair
> should be removed. I don't see why this would need to be moved, so
> probably the above additions can just be dropped.
> 
> Thierry
> 
Yes, sorry i was left over. Will remove this.
Thank you for catching.

>>>   	emc->bpmp = tegra_bpmp_get(&pdev->dev);
>>>   	if (IS_ERR(emc->bpmp))
>>>   		return dev_err_probe(&pdev->dev, PTR_ERR(emc->bpmp), "failed to get BPMP\n");
>>> @@ -236,6 +341,25 @@ static int tegra186_emc_probe(struct platform_device *pdev)
>>>   	debugfs_create_file("max_rate", S_IRUGO | S_IWUSR, emc->debugfs.root,
>>>   			    emc, &tegra186_emc_debug_max_rate_fops);
>>>   
>>> +	mc = dev_get_drvdata(emc->dev->parent);
>>> +	if (mc && mc->soc->icc_ops) {
>>> +		/*
>>> +		 * Initialize the ICC even if BPMP-FW doesn't support 'MRQ_BWMGR_INT'.
>>> +		 * Use the flag 'mc->bwmgr_mrq_supported' within MC driver and return
>>> +		 * EINVAL instead of passing the request to BPMP-FW later when the BW
>>> +		 * request is made by client with 'icc_set_bw()' call.
>>> +		 */
>>> +		err = tegra_emc_interconnect_init(emc);
>>> +		if (err)
>>> +			goto put_bpmp;
>>> +
>>> +		if (tegra_bpmp_mrq_is_supported(emc->bpmp, MRQ_BWMGR_INT))
>>> +			mc->bwmgr_mrq_supported = true;
>>> +		else
>>> +
>>
>> Drop blank line.
>>
Ok.

>>> +			dev_info(&pdev->dev, "MRQ_BWMGR_INT not present\n");
>>
>> And what user is supposed to do with this? Either make it descriptive or
>> drop.
> 
> Agreed. I think we can just drop this. If the intention was to provide a
> quick way for people to detect whether BWMGR is available or not, using
> something from sysfs/debugfs would be preferable.
> 
> Thierry

Sure, will drop this.

Thank you,
Sumit Gupta
