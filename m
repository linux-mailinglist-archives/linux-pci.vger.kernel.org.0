Return-Path: <linux-pci+bounces-1816-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEEEE8270BD
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 15:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12EA81C222B8
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 14:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72764653A;
	Mon,  8 Jan 2024 14:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iDRZlDxk"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2633A46B89;
	Mon,  8 Jan 2024 14:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hfLE4kbAYFDdLrkfkvwlGRz+M8Ak2yIEdtXj/xz+L5G4NNR4NcMW4b7c0aYQvA8wcKu91LwoLfGwSZTn2OAHc6+weFSRbxkDOo2ZlcN5n54v7Hnffhe1b5TfQr/KUPMVAviWrOXJVi/rcSEyxQEvnYbVBkabFDkk1OpsRCe2e2n1dJzFgxDnxcJyChvvNbdrRjbRQFtp84ZDcMgocSjAQy0RwhnqN8149gH+GdVoqIRBGM+kMMhN5J+GLn3O/+0/DkxD+D7+HsgQ71bFOzD2aXauORsyRtoCl/shl9l6tXrzaXJ3Fy9Q8wtvMY6JC3gFgawID0d6FURnp4S5JxA3Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MDC3WEVPbSKBpj1G+4UbtIapV1vDPxVnC712S9xOcHE=;
 b=Roelnbw7ZCwbY0mm/dN5HvoxYttaVMC+RtyLTxuJ8uF53sodBwxwTnewlF3p+wZL3Tq9FXE7RWBixZQeZRK+5jUB34cH7XduR51Rgk0iFfLCHhLfwXizOm72h9+X9gcds8IUlzwPY3UQH9yrVzOwUddCWJnljrEOSr45TlYirpIvu+1CgWWjJk/tIAxGOjT4i+H71HI90vRz9P01zUn8zUUuDLjfUkLzJ07ER9Uk17PDLv9z3iWOUx3OKRqIxosuL0h9qkZmkNyMjGt/RCiBkiq/cTl4xfcrTcLtKI9U1rdUuA/OpJYuMZgu5DxDKzDMgRtnwBkyJxxs8OTVHdgYoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MDC3WEVPbSKBpj1G+4UbtIapV1vDPxVnC712S9xOcHE=;
 b=iDRZlDxk8tZI1LK89oFWYwItWzysuP98L0aEt1qhnWsI7ZJnAQHa/381QhPMD4pUs17BEgR4zeSIr51Z/XlhGwcdUbYu8AS/ccqb0iiz7f4U/BLXS5l7D2eqZ8QPVEM2VqTsWoFNsGzAOx69gQcGUzQLao3hNa/ZXV/OJIstaOCh046tngPAPlwZdY5J2E/WM5IUt+eakohWx2fIwarYS3MTmq3YvtnQ+WIwxaxsGZa6gTidRRwR0vb+AmZhs9s23sN7QbrEAlU6TTLXTeKZ/L248kU1o8btnu2zF7O0tKnm3JgiO2DDXrvKkLZ2Q5dHQnznRTjIz3paJro3SrqodA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5762.namprd12.prod.outlook.com (2603:10b6:208:375::12)
 by CH0PR12MB5123.namprd12.prod.outlook.com (2603:10b6:610:be::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Mon, 8 Jan
 2024 14:09:24 +0000
Received: from MN0PR12MB5762.namprd12.prod.outlook.com
 ([fe80::8217:c0b2:9fe3:6304]) by MN0PR12MB5762.namprd12.prod.outlook.com
 ([fe80::8217:c0b2:9fe3:6304%3]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 14:09:24 +0000
Message-ID: <ed28cb13-12b7-42f1-8a44-48454b629d1b@nvidia.com>
Date: Mon, 8 Jan 2024 08:09:19 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] PCI/MSI: Fix MSI hwirq truncation
To: Vidya Sagar <vidyas@nvidia.com>, bhelgaas@google.com,
 rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com, tglx@linutronix.de,
 jiang.liu@linux.intel.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 treding@nvidia.com, jonathanh@nvidia.com, kthota@nvidia.com,
 mmaddireddy@nvidia.com, sagar.tv@gmail.com
References: <20240105134339.3091497-1-vidyas@nvidia.com>
 <20240108120522.1368240-1-vidyas@nvidia.com>
Content-Language: en-US
From: Shanker Donthineni <sdonthineni@nvidia.com>
In-Reply-To: <20240108120522.1368240-1-vidyas@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0101.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::42) To MN0PR12MB5762.namprd12.prod.outlook.com
 (2603:10b6:208:375::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5762:EE_|CH0PR12MB5123:EE_
X-MS-Office365-Filtering-Correlation-Id: 749ef92d-6fe6-4a43-b7a4-08dc10536af1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3etJEuXzRmAKRy8/guwjjvFCQEADD8L14fibhDcNzR9usihQeW1uI0II+vNi/gFZrAtizQMR5fIkpyboqNvg3BwFfuO22Mg7oEtOkP2TQFbJWq2vDQb2jH47NgfBdP1RK6jfO6NLCTapqboaYjtjaLchgloMOf/g3A66KpLKsIPHt+phISTm9kqZMf5krfjGgJp8IL30mImAwyViadnNpBrG0jMeEIkK3024ytdWU8jUxYrIPqDkFR6+Uy4f9bfZpokf6fcS0km1cCPyMSn8oz4xBld5DcQ8wpipfi9HOAk4K8z0VPr/6kNR0zEk3tKPvWsIDwL50Pn4ed7ZRiKCUoe+r5J152TF1ZLHZqQp5saF25nONclIg2HDiDRePGi05S7zIfc2yZUvznccKWKp3XvFZalHNUTC50mtmaCTOIBgCGdeswjC7qZFrZIVo/uTaGTSFbFx/OwSsEQT4DuOOFkagz3DSYsdMT8Mh+7f/Fdtep3TUd/2ldhq/aGy15n074CBkqNfJVsOAe6QZLjdoNJCJ/Gtbr+z/wyB26KldtXKckSKotKye2Jje4YptkH6hr4p5y70cGgww7+swc+0N+JwmB1RirlgbTbjaskMGc/2BvTnKt+fBE1fE7WSU/1obyMtRznqHl7pP3/sNE1FPQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5762.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(366004)(136003)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(41300700001)(86362001)(6486002)(8676002)(8936002)(31686004)(31696002)(5660300002)(2906002)(2616005)(26005)(316002)(66476007)(36756003)(66556008)(66946007)(478600001)(6512007)(83380400001)(6666004)(53546011)(6506007)(38100700002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cVJQa3F0YkdRWW9UQnNsNEtRU1dsVlJJL2VPR0x1ZkRNb01HT1J6U2Q4cFRM?=
 =?utf-8?B?aGptb1l1WXdBeUJvYXdXQWpVMkJyYTRZT1hUYTlTZ2tydVQvVmN4UWJEMW9V?=
 =?utf-8?B?UFFZc3JjV1dVZ091emJIVUpXYmpNWitTQzZwWWRxekNvY1RxbHRHbkpIV2Jm?=
 =?utf-8?B?MzZZVmswSXB1STFVcFVmU2k1bDRZelJxT1dWQ1cvQmVDdHR4cm93dUhiSzR5?=
 =?utf-8?B?TzA2aWRWeDlnQmxvdENoWCt4K0xvdDQrMXBkTzcwckUzQ2NkTk1nbHRFeGpL?=
 =?utf-8?B?cms4emFwbFVad25YQjd2OGlnV0orVEI2RHJQZ05zSnhnQXlnTEVKelhEOVdy?=
 =?utf-8?B?Njg2Y0RXcDZRWmtYVDRWZXFPZ29wL0QvdVpORTY4ZjFFRE10RERsbUxEYjZB?=
 =?utf-8?B?bkJ5OXBpTUxXRXZXVjdUVnd6elJiTVBxTnVSRmpQeFZJRlYyS2s5QzZWZjRn?=
 =?utf-8?B?K3JmajdSNTZXQjBHWXlRRFI4ZEcrajM1bSsvZEEySitEMXU4V3k0YndlcHVv?=
 =?utf-8?B?WjR5R2xOc2NXNWlCYnQ5SFBBekxyUTNWaGNiL0sybnVUZjhjbDQxdmRsR2I2?=
 =?utf-8?B?Z1JGbUd0WmhRNFdaOWc4VGlwL1ZiU1pxZGlEcHY4MmptN0lqekdadzNOMGZ1?=
 =?utf-8?B?ZjBocXk1cHBNOThYVXBWQWdvOW1KZnh1QUl2b2VLZEo1OUlZTmdZL1dJWUM5?=
 =?utf-8?B?ekp5WUJscDRFMHVaNXpITWZIb1l6dTg5dk0wTFBmRXd1UmhsS2h1aGdsN2M3?=
 =?utf-8?B?c3I2RVVWTWdPeGdzdUZudXV3cHp6ZFFVS1pDOGZkV04xWS9SbkVsam1WOFFn?=
 =?utf-8?B?UUZTZWlrTTFaQ0NUcGVkWE80cUJJbnY5eCtWWkFGcE5saS9LOUdJRHFHVEEz?=
 =?utf-8?B?b0dpVTBuQmhRdVd6MXN0N3kvRDhXbGJScTJ1Ulk4NjY5UGQ1aWw0UUVNQTc3?=
 =?utf-8?B?RUxRSW83R1RJRGpvaStuWXZmTFhjeDk1S0JqRGUvMDNSdlU0NXYwcE9NTWhJ?=
 =?utf-8?B?WE9UbzB1UXRXTENQLzlab2YwM3hKdC93ZkxqVytQWmlnRVg4K2lSQUZ2RDhI?=
 =?utf-8?B?NDF1OWZESlNxVEZUcGt6TXNUbGZWTjZ6Ukl4ekhyVFMvQjJ6NzhYcCtVMjFE?=
 =?utf-8?B?TFVLYnJKc3JVTkFHTlplVUIvOG1pVHc3ck05TzFhY1hWS0hXVFFURXp6RUJM?=
 =?utf-8?B?SW4vajFmeVY1dHczeVBNeVIwMGMrL2NTMmJ3Snl2OTB3aldpWFZIaXNBVGNQ?=
 =?utf-8?B?eGZWU0hWY3hXb25ESGRacmJsS0U4bzlvSXl5ZG4rV1BwRDdZRFV1elh3WEJO?=
 =?utf-8?B?ZStWU3dIVlNYZEJSTDRURWU4THNnZlBvV1M3cDNIVDUvVHV5Q2RTN28yVTZr?=
 =?utf-8?B?ZzdKTHd6UzVTSDJyWjVuN3oxNy8zbndVR3k3MTJzbHBPeDd1d2JsdzFUaDdQ?=
 =?utf-8?B?RTc4b290S2pFZ2kzTUhHbzhGR0R5c3NiM2hFNjFLYWxSdGxCSFpjbmFWajdF?=
 =?utf-8?B?bEpKd2ZuR09VdUxnVGk4VmtyYlppcnd6UWtXaDNoSElKM0VSRHNtK0RTVlky?=
 =?utf-8?B?RGVzeWR3cm9NWVR6K0pYMEpRZGVwam5tMFdoUENBVStKV2V5TytLTVRMUXYr?=
 =?utf-8?B?SzJTb21KY0YxcERiMjJtVnViMm41bkVwcWVDT3NYR2ZIaldVZUZkWEJLWXJx?=
 =?utf-8?B?bUhpN0pkSlNTcGlvcm5EcFlXL0VvTEFlOTV5Sm1EVUgxNXRRQ042Ukgra0tX?=
 =?utf-8?B?VTZuZjMrVnFZMURkU3N0Z0Q0bXg3YStod3hPbyszQzZmSXBFTmRFYUJPNzRu?=
 =?utf-8?B?alhldmNSQVN6bk80RWxTVFVYaHJyT3FVS3hGRkl2Z3ZPZzNhcmNqTW5IR3hJ?=
 =?utf-8?B?d0hFcndZenZwdVZyYzFmSWpzakFuMmRWanUvbDltMXA4SlR5UjFQSVNHcUZn?=
 =?utf-8?B?WXR3dEJWQ0Y4d2s3UThhbWIzRTNmUzBhMDErbm84aDNCOEVxUFFBWkQ5dkhl?=
 =?utf-8?B?NEVZK2tob1FCR3FxNEpnR2E1ZjZEUzdrSUl3UENaNXFXOFovYiszV2ltN3dT?=
 =?utf-8?B?WU5hdzFhNXU2emxzL3h6SStHclRwTXZFOS9mSy90V3hvalhXVGxISms0L3Z3?=
 =?utf-8?Q?+dom+JXEVmJrjAnFznFQKv3qg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 749ef92d-6fe6-4a43-b7a4-08dc10536af1
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5762.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 14:09:24.5310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sy66cyNnFlTOFnjYwk8eMq3/ti4O4v6PXCimJ8fnLUfeZaBogIcFLoQTC4Jh3UL7uY+rU1FHPJUuPIw0sLX16w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5123

Thanks Vidya.

Tested-By: Shanker Donthineni <sdonthineni@nvidia.com>

-ShankerD

On 1/8/24 06:05, Vidya Sagar wrote:
> While calculating the hwirq number for an MSI interrupt, the higher
> bits (i.e. from bit-5 onwards a.k.a domain_nr >= 32) of the PCI domain
> number gets truncated because of the shifted value casting to u32. This
> for example is resulting in same hwirq number for devices 0019:00:00.0
> and 0039:00:00.0.
> 
> So, cast the PCI domain number to u64 before left shifting it to
> calculate hwirq number.
> 
> Fixes: 3878eaefb89a ("PCI/MSI: Enhance core to support hierarchy irqdomain")
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> V2:
> * Added Fixes tag
> 
>   drivers/pci/msi/irqdomain.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
> index c8be056c248d..cfd84a899c82 100644
> --- a/drivers/pci/msi/irqdomain.c
> +++ b/drivers/pci/msi/irqdomain.c
> @@ -61,7 +61,7 @@ static irq_hw_number_t pci_msi_domain_calc_hwirq(struct msi_desc *desc)
>   
>   	return (irq_hw_number_t)desc->msi_index |
>   		pci_dev_id(dev) << 11 |
> -		(pci_domain_nr(dev->bus) & 0xFFFFFFFF) << 27;
> +		((irq_hw_number_t)(pci_domain_nr(dev->bus) & 0xFFFFFFFF)) << 27;
>   }
>   
>   static void pci_msi_domain_set_desc(msi_alloc_info_t *arg,

