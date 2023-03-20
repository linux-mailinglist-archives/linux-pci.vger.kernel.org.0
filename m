Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 810B06C229D
	for <lists+linux-pci@lfdr.de>; Mon, 20 Mar 2023 21:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjCTU1c (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Mar 2023 16:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCTU1J (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Mar 2023 16:27:09 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2062b.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 337DC35273;
        Mon, 20 Mar 2023 13:26:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cWqZZhT61OYML4O+bcPATQf64kqvcvPckYPHjog+1Ij2DgVp7XV38Hsrjb4yB5rnrhXyADyicJDUGNUL4UNeGN2GXr3AZ2iCTJrfkeTnBfUjNq+FsagqJq8T904996yxFsCph+OmCJ/eLeLmsEWXGP/xP09QkMoMstiXlEnbcwaylIRYpbntTwz3T0iSuUCghfwHp1sI7kwatpw2fglsRHoBv7AVwCz2Sc0ovq1UftxC7Wk+yZoL3I6wvPFpiCpMr1bKjGGNnGZ045ROXfZ3T96njVCX6oyU6p/v6Pv5waeKu/YzOKPiqDrhpJCvnBQN9X3Q3lvDgIZQNNu1fepIfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V71PG3aWLvwXfm69SymFHhQVcVRj1uQYffO3NFNaF7c=;
 b=bSCq9Uqb22UJ+ijZxqS5XbIHt2wp6s5LWpKHZHVwT72BdLqM1ecLpMdoSueZX4D8tZEzEZ0JchtCeQog4Xr3ctDSvUAwQiA0lWxYOXq7n/Zg4NK8L1hXoTR2Vcy5ZqjCAOt6qgcFzLJoNd+Rn/EDsQggyX0O+yGpZ2kN75DLKdSb/UhwXUX/TEhRqIjWr1FUVYW6qkWZcT1b32zFb2LX2PeKo7rOSOl2TCipSYB0/xEa5xu8/iEb/YTwo+WCxJw4cE7YGaTA+eTfbR47hrhUpdxGlTWH2W8VS18evasfkYst6sC+mui7FvdGVC2Np3a+d/tFrqtsI+BjGv9H9mB5iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V71PG3aWLvwXfm69SymFHhQVcVRj1uQYffO3NFNaF7c=;
 b=A3UkOYPZCcLuTRz7lKtYXhXdsbT04Hh3A4W7PXVosfdxNP2MYYFnBpkzkjwbGK6pZlWo40vJd9U43O2JFlQMhCpu+WavQ8k+FvmFXA8lHfr4qhoQWwetpDpaPqj1aQPjsMBOB0sCkSrFRx0hFh+IPaHQQn2cYTsgqqoLeLzOOINuDX4dT8LPsBUmBxDFvcWs+t5DYskN5VBeneX/p/TYhGU+u0n0xeJHV2jFQ0JWD4t5XnzDv2LfWPb1f3KmE68Ks2U8WEMezKF8ySSe757DIMubgsDBl0v+vV6oDQUeOySJTpEkQm7cq1+eeq9lyd6tKI7JdLuWsTNEQTZsWio/YQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 MN0PR12MB6317.namprd12.prod.outlook.com (2603:10b6:208:3c2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 20:26:13 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::5464:997b:389:4b07]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::5464:997b:389:4b07%9]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 20:26:13 +0000
Message-ID: <b529cb69-0602-9eed-fc02-2f068707a006@nvidia.com>
Date:   Mon, 20 Mar 2023 20:26:05 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] PCI: Assign PCI domain by ida_alloc()
Content-Language: en-US
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        =?UTF-8?Q?Marek_Beh=c3=ban?= <marek.behun@nic.cz>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20220702204737.7719-1-pali@kernel.org>
 <20220714184130.5436-1-pali@kernel.org>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20220714184130.5436-1-pali@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0003.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::8) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|MN0PR12MB6317:EE_
X-MS-Office365-Filtering-Correlation-Id: 2371301d-a064-4c26-c6d4-08db2981596b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xXnVGI+GFo2jS+ypBJRMBSUBejmde2hs2aZvRlGFivlz36u8pS9p6hOzx1NNXRg4uHCrrDKsf9KqG2s8itpkZZQp8RhfXUKNae9NRG5J13Lz2uVIRqkcZg3OUQIxwBbRRvKoEr5EhtL19RzmIWba/shBOl/g09i06b60PLczpeENWwwJE94XX92eclvvOC+7daA1wiCbwyAZ5dSoKBB0pWOkd40tc/BchlESM/ReakOCZ3W2XQHm469P2KwWVEipMKm75lIndDpsADofLS/g4ew6qKVEqNgnZmGGHY8a81eVwNuEux3mxD4sbbY7v7SbY1xR+rDzxp2mjTg2I2C9Q1KKxZsnlTXEo7ji0UYVwvdNxs/Blekmx6PeBciikALnV/mp/NgDj31oWR2aGp9/XMkAR8rjGxB/b+4oYKzZqZjnvVD9ZjztuI1A5Q3xgd3pCt4/HBC1EdBw1MjWgRSTLko1bsKHzayjpyB1EtlhsrgbnbRxB44wMjC6s5EYimxAtx8ufiZQJHblbRoGW/x46ZNYcwppVJ6iojyQdtciZXQZnKdg9NzGWF6KItOlsoH1LNMu4v4hCD1SZMyPvLgMw/6/Rpxao69pb6Gbgz1clyKvATnhSd3ncKenAuv9sjim6ijaj3ORqUrS4ErxR2QxSH0fU30bHVSbTTghuosA69PaoopbHYUjS/yOFVEWWuSbkZp/wN2LNTQctw+oik3m8aaevwOUZ2lgLtEBzlIa/iHDHhY4hZ/OelrgYUy4aNXrF1PB5npOLNwxARSxPQ2JkQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(366004)(376002)(346002)(396003)(451199018)(83380400001)(2616005)(66574015)(38100700002)(86362001)(31696002)(8676002)(66556008)(36756003)(41300700001)(66476007)(8936002)(5660300002)(2906002)(30864003)(66946007)(4326008)(186003)(478600001)(53546011)(6666004)(966005)(316002)(110136005)(6512007)(6506007)(6486002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2kzS3lKYVF4ZGx1QWtUVkg4N0xLazF2WnJpcnp2ak4zQWdnWjVrS2JKbEMz?=
 =?utf-8?B?eFRCYWVJbHVRWmsyTmdLajk0MlJUVVlFTEhzUUhGbTNiZXpvMVNnQnBUcG5W?=
 =?utf-8?B?S2NWQmFEUUpVSVZBS2tYTmFWejh0V3ZtQUc2YmY4VzBCMUhTb3ZRc2MrdFl0?=
 =?utf-8?B?VitnTmgrOFFmeFlqNDdxQnA1emNhMW1jTWVxUHVxWVpncit6eUhPOFYvQWd0?=
 =?utf-8?B?b25LcHJqMW9mYkJ0aDY1TUlUT0VOMTg0TU1UYnJTRkJBWmRQdnVzNFNMdE5q?=
 =?utf-8?B?YXJ6OWRqVHFJR2ZKSlNxemErRmxyc1lqcVNFODJMMlpKdnFNOU5xS3ZFSUZy?=
 =?utf-8?B?b0RCYmlxbmVBUGswNS8vd00wbkhUQmpRcU1BTHBJOHZ3K1VjTGlXZ1Z2TSta?=
 =?utf-8?B?TUJYS0ZNRW5CdGdhemVidS9najc4YVh1MzI3SDRjbmdJOW9GQWpOUXl1cTNw?=
 =?utf-8?B?RVNYTDJxQmZTRzR6dTgyRnVRRGJVbkkyU05XL0dFaGVpYXVEc0syalVvd001?=
 =?utf-8?B?SWNYS0dTdlp1T3ZqVXBrNXJ0SXZQVUM4UW5sYjZCaGR6MUV3Vy83WFdCclNC?=
 =?utf-8?B?dzFZRXhkS2ZZSUNXZHBwdUJrcjM1T0Mxb0RjUVRFcTRpY24yclFLOHFhZ2l0?=
 =?utf-8?B?YW9pNXpaMkpzY084N0RiTEcrNnJjK0FxczR1bXVqclJLeGNtNzZBQXUyK0J2?=
 =?utf-8?B?NG16ZHl2U0E0enJLSTkrSlQwQy9MUUsrMFRUdk12WGNiM01sd1FoTzZaNWF3?=
 =?utf-8?B?TTBNd3pSZXdxak5MZmlEcGJNaDdjUnN2bDdLenpvQk4vZjBFUUZCMndGbjVI?=
 =?utf-8?B?eVgvN0RQSldlaEtTSU43ZVBxT3E3MjBYVzU3azd1KzlhMk1jY3g4ZHovSWNp?=
 =?utf-8?B?b28rY0pZQVVCZnpOeVdqeldQR2owN3IzMXB3Q2RUQ1JWelA2K2hRd2pXczhS?=
 =?utf-8?B?Q2gwTnlLL0dWbExvUTBYcGcvMHZqWjMwL3NpQU5sK2RlS3Nwcmh6dzd5YUxN?=
 =?utf-8?B?OEdMWjlQcmJJcmFQaWE5U1NPVDVOaWJFbGY2ZmxaVEIreXpWVkxTeWgzNGIr?=
 =?utf-8?B?bkM2d3NYVkxLQUJZNmlMWDhud3BXeitmdjZBRjR2U0xWWTE2ZGV5a2tyZXdR?=
 =?utf-8?B?TFJSN3ovdjZJblNUOExVSElUNlVNQkRTajViejYyL1YwdmorVkJvRnY2R2J0?=
 =?utf-8?B?NU8xMnBSNjNtUFl1TUdaYmIvd0FNZmhBMFlCVXZKK2d5RWJEeVVPaVV4Sldt?=
 =?utf-8?B?NWxaYk4zYnI0ODA2QjV1bTV5RU5ZbUdKVWxaT3AxaTdoV1BlYWYvWEtlVXdt?=
 =?utf-8?B?UHdYK2ZGZDdicGVYMFdIcHlGWUFmRXJSRnllQ2ZNWWZpYlEyVllDdWc1bk1w?=
 =?utf-8?B?ZWlDWGFzSzU1Zm0xaEFLbmF3c2xwMWUxNGxNN2dJY1JLcjAxOVFZbHZKOTRl?=
 =?utf-8?B?dUFxbHZmcHh0SkNuLzFGV0daZXlIODBhRkh6UUd0YmhYYmNlTTJEdVRrcHc0?=
 =?utf-8?B?SFd5ZGg4eHlFWkJteDJ6UTdFWGJvUFhwUnhqdTA0SjZpS1RRR0RTc2h3VDMx?=
 =?utf-8?B?YzhTdEJNb09Qb1FFOGNVOTMvemdqTWFQOXJ5ZGhtY3hXb3M1Z3dRRUl3cFJ3?=
 =?utf-8?B?eFl3TDNMeFVqaDh4NzgvbUZxdGkvM1hjbHBuWHhQTkwrV0w5bXMwZ2p4L0dx?=
 =?utf-8?B?dU1PSTdzTDBqT2RiM2NQYkpzK0ZIeHV1UksveE1WVDA0QzNzWm1tc0FScmhW?=
 =?utf-8?B?bTJRQ29CTjF6UnlnMDFTZnlvQSs3WTd5bmFpM01lUkJVR3F2Wk1GaDd1bnI4?=
 =?utf-8?B?SUhnc0pTSlBHbUNKRGxZQUZzYnRnbkc0Q1dUeTVtbkliZ00rZjBEWGFRTE1h?=
 =?utf-8?B?eU56MWswWHdybXpPV1drNTBPSUZmWXdmSHRrN2laYng2T1lKSVpOZWtSTkEw?=
 =?utf-8?B?OGIxemtTOFIvd2xQbzNrK3FTOE9hRDNQVGpTaVQ4WEl4RjNtZU4xcWJTcFVN?=
 =?utf-8?B?VVZsV3pqdUdOTkNUTDF1MXpLNHRWUUlTWkQ2WXltdUN0WndkZ09vNEg5TFY5?=
 =?utf-8?B?S0k0SjRpZmZ0cFh2Z01Gd2Qwa2pFTjI5eUxZR3VmOFJDNjljWWRteUhHazQx?=
 =?utf-8?B?dEJSWjByRHJZN1BiUEowNjFKUVhrWlJFUUt6MDNFdHBPazJHaDRyYVdqOHd4?=
 =?utf-8?B?bFZWZVJHM3ZUQmZXTUg5T1BTMUREQm1hanFWcW8yZTltaU9lQmc1MW5XY1I2?=
 =?utf-8?B?SGY4MlBnOEM4bk5IRGozVDlkL0pRPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2371301d-a064-4c26-c6d4-08db2981596b
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 20:26:13.2062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gvfXdeFb1rIDdKN4nRoJkEzTTKhQWbaglhuRD9USag3j3OiJ7TJpF1HiTAP9baW+s0rZrUZIc74j+MoIDCSylA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6317
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Pali,

On 14/07/2022 19:41, Pali Rohár wrote:
> Replace assignment of PCI domain from atomic_inc_return() to ida_alloc().
> 
> Use two IDAs, one for static domain allocations (those which are defined in
> device tree) and second for dynamic allocations (all other).
> 
> During removal of root bus / host bridge release also allocated domain id.
> So released id can be reused again, for example in situation when
> dynamically loading and unloading native PCI host bridge drivers.
> 
> This change also allows to mix static device tree assignment and dynamic by
> kernel as all static allocations are reserved in dynamic pool.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> ---
> Idea of this patch comes from the following discussion:
> https://lore.kernel.org/linux-pci/20210412123936.25555-1-pali@kernel.org/t/#u
> 
> Changes in v2:
> * Fix broken compilation
> ---
>   drivers/pci/pci.c    | 103 +++++++++++++++++++++++++------------------
>   drivers/pci/probe.c  |   5 +++
>   drivers/pci/remove.c |   6 +++
>   include/linux/pci.h  |   1 +
>   4 files changed, 72 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index cfaf40a540a8..34fdcee6634a 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -6762,60 +6762,70 @@ static void pci_no_domains(void)
>   }
>   
>   #ifdef CONFIG_PCI_DOMAINS_GENERIC
> -static atomic_t __domain_nr = ATOMIC_INIT(-1);
> +static DEFINE_IDA(pci_domain_nr_static_ida);
> +static DEFINE_IDA(pci_domain_nr_dynamic_ida);
>   
> -static int pci_get_new_domain_nr(void)
> +static void of_pci_reserve_static_domain_nr(void)
>   {
> -	return atomic_inc_return(&__domain_nr);
> +	struct device_node *np;
> +	int domain_nr;
> +
> +	for_each_node_by_type(np, "pci") {
> +		domain_nr = of_get_pci_domain_nr(np);
> +		if (domain_nr < 0)
> +			continue;
> +		/*
> +		 * Permanently allocate domain_nr in dynamic_ida
> +		 * to prevent it from dynamic allocation.
> +		 */
> +		ida_alloc_range(&pci_domain_nr_dynamic_ida,
> +				domain_nr, domain_nr, GFP_KERNEL);
> +	}
>   }
>   
>   static int of_pci_bus_find_domain_nr(struct device *parent)
>   {
> -	static int use_dt_domains = -1;
> -	int domain = -1;
> +	static bool static_domains_reserved = false;
> +	int domain_nr;
>   
> -	if (parent)
> -		domain = of_get_pci_domain_nr(parent->of_node);
> +	/* On the first call scan device tree for static allocations. */
> +	if (!static_domains_reserved) {
> +		of_pci_reserve_static_domain_nr();
> +		static_domains_reserved = true;
> +	}
> +
> +	if (parent) {
> +		/*
> +		 * If domain is in DT then allocate it in static IDA.
> +		 * This prevent duplicate static allocations in case
> +		 * of errors in DT.
> +		 */
> +		domain_nr = of_get_pci_domain_nr(parent->of_node);
> +		if (domain_nr >= 0)
> +			return ida_alloc_range(&pci_domain_nr_static_ida,
> +					       domain_nr, domain_nr,
> +					       GFP_KERNEL);
> +	}
>   
>   	/*
> -	 * Check DT domain and use_dt_domains values.
> -	 *
> -	 * If DT domain property is valid (domain >= 0) and
> -	 * use_dt_domains != 0, the DT assignment is valid since this means
> -	 * we have not previously allocated a domain number by using
> -	 * pci_get_new_domain_nr(); we should also update use_dt_domains to
> -	 * 1, to indicate that we have just assigned a domain number from
> -	 * DT.
> -	 *
> -	 * If DT domain property value is not valid (ie domain < 0), and we
> -	 * have not previously assigned a domain number from DT
> -	 * (use_dt_domains != 1) we should assign a domain number by
> -	 * using the:
> -	 *
> -	 * pci_get_new_domain_nr()
> -	 *
> -	 * API and update the use_dt_domains value to keep track of method we
> -	 * are using to assign domain numbers (use_dt_domains = 0).
> -	 *
> -	 * All other combinations imply we have a platform that is trying
> -	 * to mix domain numbers obtained from DT and pci_get_new_domain_nr(),
> -	 * which is a recipe for domain mishandling and it is prevented by
> -	 * invalidating the domain value (domain = -1) and printing a
> -	 * corresponding error.
> +	 * If domain was not specified in DT then choose free id from dynamic
> +	 * allocations. All domain numbers from DT are permanently in dynamic
> +	 * allocations to prevent assigning them to other DT nodes without
> +	 * static domain.
>   	 */
> -	if (domain >= 0 && use_dt_domains) {
> -		use_dt_domains = 1;
> -	} else if (domain < 0 && use_dt_domains != 1) {
> -		use_dt_domains = 0;
> -		domain = pci_get_new_domain_nr();
> -	} else {
> -		if (parent)
> -			pr_err("Node %pOF has ", parent->of_node);
> -		pr_err("Inconsistent \"linux,pci-domain\" property in DT\n");
> -		domain = -1;
> -	}
> +	return ida_alloc(&pci_domain_nr_dynamic_ida, GFP_KERNEL);
> +}
>   
> -	return domain;
> +static void of_pci_bus_release_domain_nr(struct pci_bus *bus, struct device *parent)
> +{
> +	if (bus->domain_nr < 0)
> +		return;
> +
> +	/* Release domain from ida in which was it allocated. */
> +	if (of_get_pci_domain_nr(parent->of_node) == bus->domain_nr)
> +		ida_free(&pci_domain_nr_static_ida, bus->domain_nr);
> +	else
> +		ida_free(&pci_domain_nr_dynamic_ida, bus->domain_nr);
>   }
>   
>   int pci_bus_find_domain_nr(struct pci_bus *bus, struct device *parent)
> @@ -6823,6 +6833,13 @@ int pci_bus_find_domain_nr(struct pci_bus *bus, struct device *parent)
>   	return acpi_disabled ? of_pci_bus_find_domain_nr(parent) :
>   			       acpi_pci_bus_find_domain_nr(bus);
>   }
> +
> +void pci_bus_release_domain_nr(struct pci_bus *bus, struct device *parent)
> +{
> +	if (!acpi_disabled)
> +		return;
> +	of_pci_bus_release_domain_nr(bus, parent);
> +}
>   #endif
>   
>   /**
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 17a969942d37..12092d238403 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -906,6 +906,8 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
>   		bus->domain_nr = pci_bus_find_domain_nr(bus, parent);
>   	else
>   		bus->domain_nr = bridge->domain_nr;
> +	if (bus->domain_nr < 0)
> +		goto free;
>   #endif
>   
>   	b = pci_find_bus(pci_domain_nr(bus), bridge->busnr);
> @@ -1030,6 +1032,9 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
>   	device_del(&bridge->dev);
>   
>   free:
> +#ifdef CONFIG_PCI_DOMAINS_GENERIC
> +	pci_bus_release_domain_nr(bus, parent);
> +#endif
>   	kfree(bus);
>   	return err;
>   }
> diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
> index 4c54c75050dc..0145aef1b930 100644
> --- a/drivers/pci/remove.c
> +++ b/drivers/pci/remove.c
> @@ -160,6 +160,12 @@ void pci_remove_root_bus(struct pci_bus *bus)
>   	pci_remove_bus(bus);
>   	host_bridge->bus = NULL;
>   
> +#ifdef CONFIG_PCI_DOMAINS_GENERIC
> +	/* Release domain_nr if it was dynamically allocated */
> +	if (host_bridge->domain_nr == PCI_DOMAIN_NR_NOT_SET)
> +		pci_bus_release_domain_nr(bus, host_bridge->dev.parent);
> +#endif
> +
>   	/* remove the host bridge */
>   	device_del(&host_bridge->dev);
>   }


After this change was made we are seeing the following bug
report on a Tegra234 Jetson Orin board ...

[   17.172346] tegra194-pcie 141a0000.pcie: host bridge /pcie@141a0000 ranges:
[   17.172470] tegra194-pcie 141a0000.pcie:      MEM 0x2800000000..0x2b27ffffff -> 0x2800000000
[   17.172519] tegra194-pcie 141a0000.pcie:      MEM 0x2b28000000..0x2b2fffffff -> 0x0040000000
[   17.172548] tegra194-pcie 141a0000.pcie:       IO 0x003a100000..0x003a1fffff -> 0x003a100000
[   17.173449] tegra194-pcie 141a0000.pcie: iATU: unroll T, 8 ob, 2 ib, align 64K, limit 32G
[   18.279048] tegra194-pcie 141a0000.pcie: Phy link never came up
[   19.279285] tegra194-pcie 141a0000.pcie: Phy link never came up
[   19.279599] tegra194-pcie 141a0000.pcie: PCI host bridge to bus 0005:00
[   19.279613] pci_bus 0005:00: root bus resource [bus 00-ff]
[   19.279622] pci_bus 0005:00: root bus resource [mem 0x2800000000-0x2b27ffffff pref]
[   19.279631] pci_bus 0005:00: root bus resource [mem 0x2b28000000-0x2b2fffffff] (bus address [0x40000000-0x47ffffff])
[   19.279639] pci_bus 0005:00: root bus resource [io  0x200000-0x2fffff] (bus address [0x3a100000-0x3a1fffff])
[   19.279687] pci 0005:00:00.0: [10de:229a] type 01 class 0x060400
[   19.279886] pci 0005:00:00.0: PME# supported from D0 D3hot
[   19.283256] pci 0005:00:00.0: PCI bridge to [bus 01-ff]
[   19.283590] pcieport 0005:00:00.0: Adding to iommu group 26
[   19.283991] pcieport 0005:00:00.0: PME: Signaling with IRQ 174
[   19.284429] pcieport 0005:00:00.0: AER: enabled with IRQ 174
[   19.285003] pci_bus 0005:01: busn_res: [bus 01-ff] is released
[   19.285591] pci 0005:00:00.0: Removing from iommu group 26
[   19.285751] pci_bus 0005:00: busn_res: [bus 00-ff] is released
[   19.285870] ==================================================================
[   19.293351] BUG: KFENCE: use-after-free read in pci_bus_release_domain_nr+0x10/0x70

[   19.302817] Use-after-free read at 0x000000007f3b80eb (in kfence-#115):
[   19.309677]  pci_bus_release_domain_nr+0x10/0x70
[   19.309691]  dw_pcie_host_deinit+0x28/0x78
[   19.309702]  tegra_pcie_deinit_controller+0x1c/0x38 [pcie_tegra194]
[   19.309734]  tegra_pcie_dw_probe+0x648/0xb28 [pcie_tegra194]
[   19.309752]  platform_probe+0x90/0xd8
[   19.309764]  really_probe+0xb8/0x298
[   19.309777]  __driver_probe_device+0x78/0xd8
[   19.309788]  driver_probe_device+0x38/0x120
[   19.309799]  __device_attach_driver+0x94/0xe0
[   19.309812]  bus_for_each_drv+0x70/0xc8
[   19.309822]  __device_attach+0xfc/0x188
[   19.309833]  device_initial_probe+0x10/0x18
[   19.309844]  bus_probe_device+0x94/0xa0
[   19.309854]  deferred_probe_work_func+0x80/0xb8
[   19.309864]  process_one_work+0x1e0/0x348
[   19.309882]  worker_thread+0x48/0x410
[   19.309891]  kthread+0xf4/0x110
[   19.309904]  ret_from_fork+0x10/0x20

[   19.311457] kfence-#115: 0x00000000063a155a-0x00000000ba698da8, size=1072, cache=kmalloc-2k

[   19.311469] allocated by task 96 on cpu 10 at 19.279323s:
[   19.311562]  __kmem_cache_alloc_node+0x260/0x278
[   19.311571]  kmalloc_trace+0x24/0x30
[   19.311580]  pci_alloc_bus+0x24/0xa0
[   19.311590]  pci_register_host_bridge+0x48/0x4b8
[   19.311601]  pci_scan_root_bus_bridge+0xc0/0xe8
[   19.311613]  pci_host_probe+0x18/0xc0
[   19.311623]  dw_pcie_host_init+0x2c0/0x568
[   19.311630]  tegra_pcie_dw_probe+0x610/0xb28 [pcie_tegra194]
[   19.311647]  platform_probe+0x90/0xd8
[   19.311653]  really_probe+0xb8/0x298
[   19.311663]  __driver_probe_device+0x78/0xd8
[   19.311672]  driver_probe_device+0x38/0x120
[   19.311682]  __device_attach_driver+0x94/0xe0
[   19.311694]  bus_for_each_drv+0x70/0xc8
[   19.311702]  __device_attach+0xfc/0x188
[   19.311713]  device_initial_probe+0x10/0x18
[   19.311724]  bus_probe_device+0x94/0xa0
[   19.311733]  deferred_probe_work_func+0x80/0xb8
[   19.311743]  process_one_work+0x1e0/0x348
[   19.311753]  worker_thread+0x48/0x410
[   19.311763]  kthread+0xf4/0x110
[   19.311771]  ret_from_fork+0x10/0x20

[   19.311782] freed by task 96 on cpu 10 at 19.285833s:
[   19.311799]  release_pcibus_dev+0x30/0x40
[   19.311808]  device_release+0x30/0x90
[   19.311814]  kobject_put+0xa8/0x120
[   19.311832]  device_unregister+0x20/0x30
[   19.311839]  pci_remove_bus+0x78/0x88
[   19.311850]  pci_remove_root_bus+0x5c/0x98
[   19.311860]  dw_pcie_host_deinit+0x28/0x78
[   19.311866]  tegra_pcie_deinit_controller+0x1c/0x38 [pcie_tegra194]
[   19.311883]  tegra_pcie_dw_probe+0x648/0xb28 [pcie_tegra194]
[   19.311900]  platform_probe+0x90/0xd8
[   19.311906]  really_probe+0xb8/0x298
[   19.311916]  __driver_probe_device+0x78/0xd8
[   19.311926]  driver_probe_device+0x38/0x120
[   19.311936]  __device_attach_driver+0x94/0xe0
[   19.311947]  bus_for_each_drv+0x70/0xc8
[   19.311956]  __device_attach+0xfc/0x188
[   19.311966]  device_initial_probe+0x10/0x18
[   19.311976]  bus_probe_device+0x94/0xa0
[   19.311985]  deferred_probe_work_func+0x80/0xb8
[   19.311995]  process_one_work+0x1e0/0x348
[   19.312005]  worker_thread+0x48/0x410
[   19.312014]  kthread+0xf4/0x110
[   19.312022]  ret_from_fork+0x10/0x20

[   19.313579] CPU: 10 PID: 96 Comm: kworker/u24:2 Not tainted 6.2.0 #4
[   19.320171] Hardware name:  /, BIOS 1.0-d7fb19b 08/10/2022
[   19.325852] Workqueue: events_unbound deferred_probe_work_func
[   19.331919] ==================================================================

After reverting this change I no longer see this issue.
Let me know if you have any thoughts.

Thanks
Jon
  
-- 
nvpublic
