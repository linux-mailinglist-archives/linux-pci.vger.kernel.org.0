Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A776A6B7A36
	for <lists+linux-pci@lfdr.de>; Mon, 13 Mar 2023 15:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbjCMOTr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Mar 2023 10:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbjCMOTh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Mar 2023 10:19:37 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2100.outbound.protection.outlook.com [40.107.92.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC564EF5;
        Mon, 13 Mar 2023 07:19:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ItbM7ZBOB3AjYBAndI4wbFUHGe6OQAT5Iq+bfT85roi1qhD7retdq+1vs+eg6j+4P9T8vbPylAkcofM4Ly2/3Kwr4dPowE/+NhwKMRci11IS7CutF/egE6pK+Wjul1j1bNR28kcqQ/YrOyFFDky4qsoTMsD6R8gETPW0BNVWe5ODHVzluVQvAOS/bjjcjpDoOpB+yT4ChAvwVGtvaJJNmooWIpBsFcujadMzeyo+eObPgQvdghEOSpBD6LAVqPEkz09AyKKRTg70aamggfAyTwW/elnpsopOJghRYsOb0KjVdO/3dRlLQnBeKrA94rNttnFyeDtX37YA7x58OgZN7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=89CmER4+fCOuqivdyxHWlGVHRK5KSdrNTByf8p/MSVQ=;
 b=eqSyz50desJYchii0k4VzqAhX4V7TnPPrQcxi8xM7DlZvhaWMiPt4okN5Rfs0JVgldvGPn2gvzM3I7EQ6gOQJ1GIPVoLzATvXSCb+pivzdgAVrZsmfkNSHgE7xhpO0lfxJV5amair4cc6x47Bfb8nAw2WO8yyNajdulTNnDu00/PDPxbURpVX2ZlsR0uF0y8XUu+7KQ+66gbJkZqfzncrJqgBUd25d5/KzfZSyvkTmbUHhHKLhc6c4iV28P1Dc9TxU8d+BoNLlnEJ8oxyC+MqFv9CxsPgtxzitej6eMB3ZTctZnUMS9IG7ZvaAmoHVyRlzArWLsbdDwcM71fiGucNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=89CmER4+fCOuqivdyxHWlGVHRK5KSdrNTByf8p/MSVQ=;
 b=CiSMHV36hn0KKkxoAflKPJM7NE0cr0GeKq/z8AzV1VsA0Ho4U+tc+sQ2rA3sc3C/8VxXcj3EcuL8rOA24fIJySimzygMyQ1RM111MVNyyRKvPM25D9kkZXUOw/sKtHu6OyBM4brgSQUpSj/i4B0bFcAkj5wuVNbbrJXoKdhZaCQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM8PR01MB6824.prod.exchangelabs.com (2603:10b6:8:23::24) by
 CO1PR01MB6568.prod.exchangelabs.com (2603:10b6:303:f9::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.24; Mon, 13 Mar 2023 14:19:29 +0000
Received: from DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::fc8b:5e5e:a850:7f0a]) by DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::fc8b:5e5e:a850:7f0a%7]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 14:19:29 +0000
Message-ID: <2dc4db94-1d03-2080-aa6d-56a7327bde5f@os.amperecomputing.com>
Date:   Mon, 13 Mar 2023 19:49:20 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 2/2] iommu/arm-smmu-v3: Configure STU of a PF if ATS is
 not enabled.
Content-Language: en-US
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        joro@8bytes.org, bhelgaas@google.com, robin.murphy@arm.com,
        will@kernel.org
Cc:     jean-philippe@linaro.org,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        darren@os.amperecomputing.com, scott@os.amperecomputing.com
References: <20230228042137.1941024-1-gankulkarni@os.amperecomputing.com>
 <20230228042137.1941024-3-gankulkarni@os.amperecomputing.com>
From:   Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
In-Reply-To: <20230228042137.1941024-3-gankulkarni@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR14CA0009.namprd14.prod.outlook.com
 (2603:10b6:610:60::19) To DM8PR01MB6824.prod.exchangelabs.com
 (2603:10b6:8:23::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR01MB6824:EE_|CO1PR01MB6568:EE_
X-MS-Office365-Filtering-Correlation-Id: 06220686-d437-459e-9c94-08db23cdf51d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WgsQzKkBwz+P7aIhh0kQCSLsbAbycTdfzXgC5IE+vmfPv7OOQIC8Kejei65E6nTAKy3ZyqQf1b0cKutfaa6HP6A2dybYEnIcCMTmOdi/iThdwHiGJujuRJsVU+1ldWTBs1TypepO9F6oF57so36ANKRmUzYgC1dqfBz7ZaW8lTTf6Z2wSCpl0EAQlJ5spSWOCfUieJ/q6AIpuL8tDh+DO15RDWapafJpwMcM7rYuAWLwCRlZ6BheSJ2eJHWOWGZNNEAMWs3LrBWxJbEs/5ycDdYpMH4jczvboZGgoFwQ4crFHaZzXtfMGEdVtQYu2PRCxafhiKEg3vO1vlXgKMWJLo6WYAqCPQ9qdqE5xZ9I2xL3eLTXa6Lav65Wy4LnEMcjDqvdF2K7Q8vWO6JoVnZOk5tzZYxDiSerwD6Hw8We4PGw6pZEcZDqK6fwUcAbNLYmd5CHOGLLYHU/Y73PyheUpZhWMS+6YANBSjgvyg+m52csfmlofbF43x+O1HWioaBwJQ/spu7M4Y1Jam5eotyUiS258FvjKBTSv77bxs8tRhOl/4iHwmYjMGF8yLKoSOyIr5tQHh2E9wWXHAsx6FRTPquUOTWG/kqxB2cZqj9K9P7GYU10YSRImUP62gCCyYuq77JfSsfJcRtYVJi43El9287hpNoe2WpW+6caet0HFPIHNHVbch+9GczWGvvF+1X4Sicz89M/aTKgsDuBgC+uTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR01MB6824.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(366004)(136003)(346002)(39850400004)(451199018)(86362001)(31696002)(38100700002)(4326008)(8676002)(66556008)(66476007)(66946007)(8936002)(41300700001)(478600001)(316002)(6506007)(7416002)(5660300002)(2906002)(2616005)(83380400001)(6486002)(186003)(107886003)(6666004)(6512007)(26005)(53546011)(31686004)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1pBUS9TV0JNQjhPSFM1enl3RkFKcXZIUGVwV1JadnBuSnJMVFY0UWVGQUhE?=
 =?utf-8?B?WlQ1UXpzN3REVUNOeXYyRDFRM2F5REpnQ2lKT1NQS0dobUV4eDJMRy9lTTdk?=
 =?utf-8?B?N1dCZ2libmNneEhwZDJ5SHVuMlZxK3lPQkNwd3VIWGdYNk1DRFM4UlcyV0Y5?=
 =?utf-8?B?WlNQeEwxbG56ZG1QdXRKNXI0RitkYk9OcFVMbjQwK0VITURLU2ZjZG50V2N1?=
 =?utf-8?B?Wlo0WUFRai8wVWxHa1VNTVNpN0VwTHlvbENmZHp4OWV4cEwrQ3B6TUM4SFA2?=
 =?utf-8?B?c3BzeTlpY0ZXN25mY3VEM2JEL0J3dTlLUmlOU2c1N1Nxc1lKTEc0NnRLTVBE?=
 =?utf-8?B?RU94TnVkalZub2NhVWYzbU9PUi9JeUFpeDlSd3k3dXJNN0lTUGNLM200WGts?=
 =?utf-8?B?eVo4eXo4ZEhyNWdtaTg5M01OMTV4T1JLNUJ2dGNXcDJkVmRMRHN5aDhUd3By?=
 =?utf-8?B?MjhkcVdrMHFGMDNkQWFvUUJnalV4ZEtZNUxJZ0VpVytyRThPVGhOa2trVmtB?=
 =?utf-8?B?RlArMXBUMC8zQjNFZmpTVWlLL05nNXR3MFJCODhFSVF3aXFGTVljcHhaNGxY?=
 =?utf-8?B?SjVYVW82TXJjUEYxNnlLRVlIbWZsT2ZNUnVBa2ZSMW9wM2dadlIrWDBMdXdk?=
 =?utf-8?B?b0ZkaHBhZUtjQloxNXo0SzQyV0Ntc0hoREppUnJJdVZSZTRMbTRYRitPVS9y?=
 =?utf-8?B?OGdjL2RuWEhQWkhDUTQxT0RuNkw1ckZ1RUJNdVkxZXR6ZlpiSUVWOC9RdVVu?=
 =?utf-8?B?ZkdzVkJ2QXlFa3BYbmlIWE50S00rMVVYZ2dGZm5BRzRlQ2M3R2xEMFplemdk?=
 =?utf-8?B?emE3cFVNK3pyUHFwTktHZURBR3BoOGdqVEUwRFhCUEhKenRMeXJPZnhpWHk4?=
 =?utf-8?B?QzlSUHB2cWd5aHhaMGVGQUx3a2NpVjFiaGtFNmQ0dGpTQlVLNmJXVTZJMlRB?=
 =?utf-8?B?SnpYeHZKZjM1L1ZhbHJCaUtRWll6Q2NHTXhkNW9Gbkl6bXBjQy9XYjBwNHVt?=
 =?utf-8?B?bnMwcUYzRjNKbmJWa2J1L2o3NWhyclNqbEh0VFBnai9TT05kQnhvZ2xxeUJU?=
 =?utf-8?B?aTNITE1kb2RRcURRb2hWQnlzY3VpTHRrc2d4SzhrVHdVNHpJR1ZTUHF0NHQ4?=
 =?utf-8?B?OEg4SzNrRFFZdU5OZ0IvNjRWTUkxV3FQRk05SlR4dlpBZTRRNmorSGF1bGFM?=
 =?utf-8?B?aWlUQ3hTR3paUVU2eklFaXJZTFBDYUt6Nm4rMjF5UzV6NHdGdnZjTGkvMWRX?=
 =?utf-8?B?aTh4Y0JGNVBkK1FTVlhmUjRoa05FZlJVNXF4anNwcmtKTGdzbmVuVWlWSWJD?=
 =?utf-8?B?cnVUQUxWeWE4L0YwMGRhTnRsRXlXNTJhSTdBM3lpaHI5RXNCMmpDRUt0V3VU?=
 =?utf-8?B?Z056N2JyYVJiWjZkTUtaVmc1QWJIa0hDeGNpWG00d3V4QVd3MWVtNlZjNjdw?=
 =?utf-8?B?bStsMy9sdXpacFpOV0hFNXZpQ2xqWjFjZkc1ajNGQzVsQVBXZGc0TEJzS2hJ?=
 =?utf-8?B?S29qUm1oa0FlV0JKMDBaZGtpL0N1UmEvQlFBczdybkgvNllMcXBxUGthQnI5?=
 =?utf-8?B?bUtTMGZOQ1pjdWdTaW1BOFR5dFdvUzR5cWRuR0pYKzE1eXRkcGhmZkExWnJm?=
 =?utf-8?B?cWtRMExmQ2xvNzB6TEJ4aWtLUG5Bdmd5akVFTUpGT2FrWE9WUUdEWWRyUTFJ?=
 =?utf-8?B?a2dzbld5OENPb1k3eFMzT2REY2JoMUVKQkRlTithTWM1TXZSSVpaRjdtcW1h?=
 =?utf-8?B?aTJXcFJnSTAvakVuRm4ybUxsQlNWbm44MGtYdUhwN0tYaXN0TVgxLzZnUzlY?=
 =?utf-8?B?NzR6M1MxN2x2RFgrajE5MFpmVlpxQkNaUnNZdU4xRm9IZ2FkMUQ1cHkxNU4y?=
 =?utf-8?B?aGl5ZzBhS0c5U0lJWmhYV2xjaDJldWszQW54L0dwRnAxcnp2RXMwL1lqcUkr?=
 =?utf-8?B?MllST2IwUlZDcFBrWnpUaGtNK0tmbXZnS2EwRnp4blFyeEFMcStkb09DazIy?=
 =?utf-8?B?M2hUcEViaHYzUEYzR2lRNFFMWDZZTlBBbmtwMjE2c2RkNHFoUnRlN2JkVksw?=
 =?utf-8?B?L1k4eVRXWlRZU21HRUFpUmtXN3JiNS9ZM0NqMEZvMHR4UUR0cXNLN3FFeVZW?=
 =?utf-8?B?RTgwekprSkwzWlVmNHBRUkZLYzhPSlJjemxyMVQ4QlBGOGRVdWxlelYzaW9j?=
 =?utf-8?Q?hmBakvlpbywahwiQCSpEXW8KtfnNjTge/JJNDFmGZkg0?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06220686-d437-459e-9c94-08db23cdf51d
X-MS-Exchange-CrossTenant-AuthSource: DM8PR01MB6824.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 14:19:29.6619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fc+2EbS3+wy/IvibomYcGm7ej+nuKchnoFfx/PQZ23cbi+sRb//bXZcfBnqsGrcMHF9Q3N7eQfpRnd+/d3hNK4JE3eaqUwmxTpIuzfwi7up/CVKvQq0B6qH+FARzoF1a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB6568
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


Hi Will, Robin,

On 28-02-2023 09:51 am, Ganapatrao Kulkarni wrote:
> When the host kernel is booted with iommu passthrough mode, PF and VFs
> are enumerated with iommu/smmu domain set to bypass mode.
> In bypass mode, ATS is not enabled on all VFs and associated PF.
> When VFs are attached to a VM, the corresponding iommu domain is set to
> SMMU translation mode and smmu-v3 driver try to enable the ATS and fails
> due to invalid STU of a PF.
> 
> Adding a fix to configure STU of a PF while enumerating in passthrough
> mode.
> 

Any comments on this patch/series?

> Signed-off-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
> ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 25 ++++++++++++++++++++-
>   1 file changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index f2425b0f0cd6..b218ef0bf001 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2292,6 +2292,23 @@ static bool arm_smmu_ats_supported(struct arm_smmu_master *master)
>   	return dev_is_pci(dev) && pci_ats_supported(to_pci_dev(dev));
>   }
>   
> +static void arm_smmu_ats_stu_init(struct arm_smmu_master *master)
> +{
> +	size_t stu;
> +	struct pci_dev *pdev;
> +	struct arm_smmu_device *smmu = master->smmu;
> +
> +	if (master->ats_enabled)
> +		return;
> +
> +	/* Smallest Translation Unit: log2 of the smallest supported granule */
> +	stu = __ffs(smmu->pgsize_bitmap);
> +	pdev = to_pci_dev(master->dev);
> +
> +	if (pci_ats_stu_configure(pdev, stu))
> +		dev_err(master->dev, "Failed to configure ATS STU (%zu)\n", stu);
> +}
> +
>   static void arm_smmu_enable_ats(struct arm_smmu_master *master)
>   {
>   	size_t stu;
> @@ -2404,6 +2421,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
>   	struct arm_smmu_device *smmu;
>   	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
>   	struct arm_smmu_master *master;
> +	bool ats_supported;
>   
>   	if (!fwspec)
>   		return -ENOENT;
> @@ -2446,9 +2464,10 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
>   	}
>   
>   	master->domain = smmu_domain;
> +	ats_supported = arm_smmu_ats_supported(master);
>   
>   	if (smmu_domain->stage != ARM_SMMU_DOMAIN_BYPASS)
> -		master->ats_enabled = arm_smmu_ats_supported(master);
> +		master->ats_enabled = ats_supported;
>   
>   	arm_smmu_install_ste_for_dev(master);
>   
> @@ -2458,6 +2477,10 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
>   
>   	arm_smmu_enable_ats(master);
>   
> +	/* Configure ATS STU of a PF in passthrough */
> +	if (!master->ats_enabled && ats_supported)
> +		arm_smmu_ats_stu_init(master);
> +
>   out_unlock:
>   	mutex_unlock(&smmu_domain->init_mutex);
>   	return ret;

Thanks,
Ganapat
