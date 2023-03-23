Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 713DF6C7303
	for <lists+linux-pci@lfdr.de>; Thu, 23 Mar 2023 23:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbjCWWWT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Mar 2023 18:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbjCWWWB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Mar 2023 18:22:01 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2085.outbound.protection.outlook.com [40.107.212.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74ABE303CC;
        Thu, 23 Mar 2023 15:21:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=keJu6Mb/hwVDStmBJaLkF0uwVml1Xb9SQgA7SJmSDshoZ1hy5c+02X12Wrrye+XlyQBelvvs0zOs4snd3pvDicWEZBz+UjcywnRSIToW4mEePHDDKFm1dY6srDUrfpr0lQ/E+zjqlH5cGRvJnpirsBY0EsAhGcB9eyBsVyoxS2sS2cVXRUxbMFNm66uVi5JCPHeS4125FXZ14H5i3gF+b+9SSoatw2089Dbpq9gyiNEcHAzQ4hEf6+xs6nT2SurFmGvYjmcM7ohemMWcNXaeDFmE01Uo812GvguL4wB8zUNKnQjWRjAmW4Hom0iTyCWYWvXvUSd3S9+LWJbGUKFpbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AOR5AtT6SQ9LT5jS2SqMghYSJnHNzbi4FtMRsBbgN9Y=;
 b=gIiH3b19aTzVnqTezpBU1Z+LcB3gaUGK+Rb0hWiM6uXdxiVasJFf4O0BRuf9XxoRZzYHmeuIysRN/sJRV7ZVLbnxhE6F3ADjVY2STH248oNMvDxhTxVTdSP8j+xGdwNHDy6iN6V/KO4RAOzz9w3jVdUXmmJI3D8cWHf86Xszrre851bjnGvl1omapDqSOnZnDLv+nj0QjilK+H7Mr7ABqx6UqPlYCb913OuEwMYz01Gq754nlCWsFWXDGGBjYzXmYmZIeFL1Vm9XVrNbEQ7o+p1z59eBn4+rUDy9ZyClrg+yi4pLxxhude7izfaxvmUv1tmCA+umzvDMzYwPO8VI+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AOR5AtT6SQ9LT5jS2SqMghYSJnHNzbi4FtMRsBbgN9Y=;
 b=fAyXYlOgM71mGhz/mMD6t2cZwfZl/X6dZHKrV8NT1qEN0+TNs+2I4cpYWAXyqLWL1jZ0LCZNfaU/FD1SPv6iywIY5YnUlnS56z0R2vtETK03qbylIotTIvwEvXAULMQ1hGa2VSL4ZCBqnMmtQTHMoZWBSMSZGGe7BstkucXPFA0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 SA0PR12MB7002.namprd12.prod.outlook.com (2603:10b6:806:2c0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Thu, 23 Mar
 2023 22:20:38 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::8ffc:be4a:e730:2bbc]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::8ffc:be4a:e730:2bbc%5]) with mapi id 15.20.6178.038; Thu, 23 Mar 2023
 22:20:38 +0000
Message-ID: <f31edb04-04c7-2d98-e3ef-a591993e7ceb@amd.com>
Date:   Thu, 23 Mar 2023 17:20:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 3/5] pci/aer: Export cper_print_aer() for CXL driver
 logging
Content-Language: en-US
To:     alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, bwidawsk@kernel.org, dan.j.williams@intel.com,
        dave.jiang@intel.com, Jonathan.Cameron@huawei.com,
        linux-cxl@vger.kernel.org, rrichter@amd.com, mahesh@linux.ibm.com,
        oohall@gmail.com, linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, bhelgaas@google.com
References: <20230323213808.398039-1-terry.bowman@amd.com>
 <20230323213808.398039-4-terry.bowman@amd.com>
From:   Terry Bowman <Terry.Bowman@amd.com>
In-Reply-To: <20230323213808.398039-4-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0156.namprd03.prod.outlook.com
 (2603:10b6:208:32f::29) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|SA0PR12MB7002:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ad3d407-6b46-41f7-37c3-08db2becd48f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pCasH9cEhKkzh2qopy9l2EnY0NabeZ7td/Ebc03WP8laJ3Z9VRMeV94Ko0X6v7DwazwuGCLlTXUVj39K10mYzcysZxMgzHEGyF11Flo9CQ232fAr67X6cVolAtTFuNppJJobLldRRnD7aWOoD4txyQkMj8aDGKI8uYUdwLADr3UDgbYl2uFr1aovndZIkjzMPEuMvOobeikqhrsI3HGqPSnoAcn0e66mfd8WHcy1FS1XviSH0CSFT58KWEB1nJVPMNSDpxIomOgh34d9otVAtJMagvab6OqFHrd5dlhXtc6EdmxoqUElzkWar8eFaXtz5OCWGgEF2Tp0ELZYsy0LHQESlPcWkxuCZNs5d0WzkZAd6gVky59OqDPggj3Wi9eoia/NsAdSntGrL6RKTgOwlOxUThiB5t1u7np9vJBLwZc+2xPf4tz9JTQcEFYpO8ezXzEFxu6XU1EnTERSRI83NCqmTJT1YFL3ZncpOrPIkmaeHcb7+jNbN6bF1tHI0G4u+3Mytljjboq1qOSFk5jR6kje0XWKjx2EJ6ahOLE7zCKQHjuvuG6CthrhfdE5ryb514gW7UE4D9UTKrUnBDwwsh8JQ55Y8T82yvFRJB1uz+ATPwjpFkqAo6GqgjvEG/nCdnMj1sYbCvVFqu1nH1Q5O2eAf3LuXk7BtKi7P3OREDEXSxzuhPm5A6L7szopI7YYzlLKRQrk/hv/lX9+VDkw5JxxAFl4OCLYnX1o19LGzWQRHZ0zPnc0J8m9e5acpM+O
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(39860400002)(396003)(136003)(366004)(451199018)(31686004)(316002)(8676002)(36756003)(38100700002)(66476007)(7416002)(2906002)(8936002)(53546011)(6512007)(478600001)(31696002)(6666004)(6506007)(66946007)(41300700001)(6486002)(66556008)(2616005)(4326008)(86362001)(921005)(186003)(5660300002)(966005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkV3WTVORjVaQ1plQndMTEF6WlBxMXd0QXd6dk9aNFJSdFFNcy9pdlNYL2Ev?=
 =?utf-8?B?RFhGUjNBTWM0Q2xnSFhmdWVTMVFKMWtkdnQ3NjZQYWg3ZFZrdzd5TStjZ1VZ?=
 =?utf-8?B?cnZvTDliYzNxckt5MVBOQkVmMEgraUphdmRNTkhyNGxaTU9uRXB1ckFndnBI?=
 =?utf-8?B?dXJVSmVUY2hPelR0STVGb2dPaVRlK0RtMytlbitEa2o2M2NhbkhhZmlCRXBz?=
 =?utf-8?B?REJWQldEN2s1dHZYUzNBS21RV0JvT0xiWE5OSUxXVjV2Vy9wZG9JTklLZEY2?=
 =?utf-8?B?bGdZQjRyaGlHd3dtOFZWNUNHbDFPVi9aekgxcC9rM0RCeU9iWTNYWmNsKyta?=
 =?utf-8?B?RUpxOVJ4RmRvY2lPUUJsS2tBcm8wcGNVRTh3Z1FNb0hITDg5V29iODQ2cVNo?=
 =?utf-8?B?RUZxRTJSRktVd1VQWnlOMVNWYXN1Z3Nla1AwMWU1UWtESlUvY2JBRVBSUEtl?=
 =?utf-8?B?YkZjUVVWbGVYczJzL1c0aVlBOXZHU3I1UE56U2h5ZklpbmgzQklORS9Beko5?=
 =?utf-8?B?RmJzejNGWDczWHN1QTBDa0NDOUNJZUU4eTBFbWpXYUx3U3FSV3R5MzlYRVRL?=
 =?utf-8?B?M0FJZGRiZFh4QTlCckhtRXNqYStMMStBbFBtcmtJaytObWtZRmRWQVFpeTVs?=
 =?utf-8?B?dXpCUEFSc21lNGc5YW9aMThqVlZ0ZzhxblVmL24xQ29BLzZWUzMwK3Q2T3Rh?=
 =?utf-8?B?N28xYkxkVzZGRDVMWndkdTFkZjZSOXFHa1BialJJZEZWTWR4bWtmYkd1N3I4?=
 =?utf-8?B?OER0YTNEWXNvZnBCelQyaEdsZXl1NGRmckVFc1hScURtRnBkRDcxN2JoM2Nu?=
 =?utf-8?B?QlBVL3BHcWhEQjczMXVNRFRDbkdWeTljelNRSHFMWHZnREM4ZDQ3bk1aWXJZ?=
 =?utf-8?B?OW4wUy80YmhDNTJtZSt3R3JTdTlEYjFLSExrNXB4YVEvT2ZSOHNVTWVZWHor?=
 =?utf-8?B?S290OU8ycTFLYkFMcTVHU3JVVnZHYk5BNDE3dXNCK0xWOTBHT2RKdFArZG8x?=
 =?utf-8?B?ZWc2Q0g1a0VwdDJQZDc3SHFNR2lQaUxOUDJwRktWcWM5bFFYTkN0RGk0RE5Y?=
 =?utf-8?B?UHBoTDQyQlJhcnhrN09XL1R1VUZueGNPZEpGcklrRSt6NUhMVkFtb0JGYUNT?=
 =?utf-8?B?WFBWR09FT2FLOStvRmViNE8rNnRZQUw2cHUyVFJua2w1K0RQd01QQi9DWFN6?=
 =?utf-8?B?MTVPSHhaY1JEYnRwMHFWd1BlZE1EUXliTW8zMFJ5REJsRS9IdjVxcDlseDFh?=
 =?utf-8?B?OEg3eU0vRStSQTlKbHE1ck9yVlFxdHlpOWFZMEsxT2c1QWp3ZEdBQWNqZzVa?=
 =?utf-8?B?ZkJjVkU3MDNhbU5CZkpORVl3b1JNc2ZOYmlXQXNyaHhJRzU1K1Z3d1RZcFky?=
 =?utf-8?B?ZmhMSmJwdWt1N3hYQnFqT200TTAyanRBVmtsTlA5cHYrUnh6SVBlYmNvOW9R?=
 =?utf-8?B?bzdETUJnWlJiZk5nZjlkcnlsNWRLL0FRSHpUcDZaeGt4eEtOdFRuODZCejR4?=
 =?utf-8?B?UkNSK3FpOWx3MEJpOW94SFRSSnN3elZoeC9OTXpYa2dnL0Z0OTJ3RTBFY0g4?=
 =?utf-8?B?TVlKWUdVamZGUFpBM2VXTTdlcllKZ0U2R0trcUZQT09KR3hpZ0ZLSUdHQ05O?=
 =?utf-8?B?c1NsVzlmb2VhS29ZT080V0ZONjhydktBUWJjZlI1aEVjYnhKSU8rNDZiZUNs?=
 =?utf-8?B?Q3J4R2M3cUhaYkJrTFpMeUExQld0eExQMW9RMFM5YWFac08xMmNUdzduVTZG?=
 =?utf-8?B?U1hqYllJVUJaMHhmTk5kd1FWb1NWZy9ITEJUb0MrYnEyZURUWk1EYW1vNHV4?=
 =?utf-8?B?VEk0V0pGK3RCZnE4Qzdkd1pPaWc4NzBQUTQ5dVVnWEd4Q2gvckVmWWNYRVVv?=
 =?utf-8?B?dlVjWGRtZmRrdFh2aDd3WDJZWVNyRTl4TjByRklPRUt4Wk93bUp6ZTZCV3R4?=
 =?utf-8?B?RHc5UzhRSWNoZEFOMFBYNVRsMGZnTldHbzlvNnl5anB1MjFqbWsxKzk1UTdp?=
 =?utf-8?B?aE8xcnMvcVRGa1ZNYS9WQnp3ZmZTek1uSnFrZUo5NWF1U2RXVTNzTWJIbjJp?=
 =?utf-8?B?aDAvMEVnZ2NRK3M3RG1YQXB0VVdoTFNndUM5SlAxWHo2SHRXa0xZKzBZSmRD?=
 =?utf-8?B?VG9va2FPNzk3SjRhMWlLdUYvRnUwWlpEN0dvajRNRmVYR3A1N0dtdHRqSEQ5?=
 =?utf-8?Q?h2p8nOLVy4UZqUfDZy4MBH4W0qvfHOvdaY/+gBZvTmke?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ad3d407-6b46-41f7-37c3-08db2becd48f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 22:20:38.3376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TOE1o3LJ8PABq+Y9eWByAQsSfGDDmMnmG7iL9LIOJEV9nu/OYbMzlSq7rP7n5A7pcBZ01w1C5tS3d1Y76ctSww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7002
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Adding PCI reviewers.

https://lore.kernel.org/all/20230323213808.398039-1-terry.bowman@amd.com/

On 3/23/23 16:38, Terry Bowman wrote:
> The CXL driver plans to use cper_print_aer() for restricted CXL host
> (RCH) logging. cper_print_aer() is not exported and as a result is not
> available to the CXL driver or other loadable modules. Export
> cper_print_aer() making it available to CXL and other loadable modules.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
> Cc: "Oliver O'Halloran" <oohall@gmail.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> ---
>  drivers/pci/pcie/aer.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 625f7b2cafe4..7f0f52d094a4 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -809,6 +809,7 @@ void cper_print_aer(struct pci_dev *dev, int aer_severity,
>  	trace_aer_event(dev_name(&dev->dev), (status & ~mask),
>  			aer_severity, tlp_header_valid, &aer->header_log);
>  }
> +EXPORT_SYMBOL_GPL(cper_print_aer);
>  #endif
>  
>  /**
