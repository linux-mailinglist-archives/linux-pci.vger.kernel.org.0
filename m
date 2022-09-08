Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 797255B13DC
	for <lists+linux-pci@lfdr.de>; Thu,  8 Sep 2022 07:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbiIHFMa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Sep 2022 01:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbiIHFMR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Sep 2022 01:12:17 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB554BA142
        for <linux-pci@vger.kernel.org>; Wed,  7 Sep 2022 22:12:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZoiezgJWhe62fC7yke2+bL72MZTlYKS+RTARLZJc6yVzwLNlJUC0OE/48rwlKIDc+9uT2bMPG9PiSCD2/MthmUZD+fyUWTZCsOt8zkL0+Qcj3lYuu9mXyCOfiRgfbKkIgKPy+8+9NKh01jw1k+ZV3OZPtkEePCCEPj4O+O1M0BOlUDetaKrtQpftjH/+FfdSfNsoDstHavq2gHh2sc+iWsD8FILuHblJYDIyMnU/hTU+paNCo/alGXUd6Fuir+jKPdqID//EwOJUjgJrpxd96CxBMlm6Asb6ZCwZFmOPuvI3Awe9IjFFhuwJWRhvnRqoWE/48yphYlWxdwGUc51NNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XPvFV+FRoM22G6HWCDDSUDdsmJvqJfLZiaT6Ok8YwZE=;
 b=iogYR7UAk/E3+SDaGLWpDsOErwzKVcgzDbHuvboaBERy/tKNeR2Zf6YIAp7eT3eV8BBTRmSSALv4P9Uw54yxskaWpUBENuEjwJgtj54jqEEJO515Vnaqwn7ce2FBDZwlg0ICL1QU6tuv0HFevb2naW8fouVh4VT9h9zZgIEnEKj8xwLwqd9Va76ohzqdGfLTxf60d5DTLcLiLqy/i3qqe2j7MB3doFeIlkZ7g42dFbdFNN7bhTLeESV/gqRQNYErpuUwSL3+MK1nKyW/x5lGIPoS9UbrVva1Z7s3Z7iElgwUWfvytHS+wDyKk7MPMgqt2FfMutPMDXEYYs8p+F70jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XPvFV+FRoM22G6HWCDDSUDdsmJvqJfLZiaT6Ok8YwZE=;
 b=VhT6qv1zEdTf+uoACF9dQSO/O6Aen7rvKOdqVdITOhEy0ykUwt6yTWQt7k7R1uY0cJYfk3ntV9xpHUvdbtBWGUNAr/UwMEu2XlHMEWuGZ4kNx3Wlmnii2yF7ot2r6QEVTRSZORNiBneRnTxFk1FnLEzEj/sPStnhDFh5xeeXVwo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by MW4PR12MB5601.namprd12.prod.outlook.com (2603:10b6:303:168::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Thu, 8 Sep
 2022 05:11:45 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::2925:100a:f0b9:9ad8]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::2925:100a:f0b9:9ad8%3]) with mapi id 15.20.5612.014; Thu, 8 Sep 2022
 05:11:45 +0000
Message-ID: <4148adb1-2181-efa4-672c-defb45abe0e8@amd.com>
Date:   Thu, 8 Sep 2022 10:41:33 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 1/2] drm/amdgpu: make sure to init common IP before gmc
Content-Language: en-US
To:     Alex Deucher <alexander.deucher@amd.com>,
        amd-gfx@lists.freedesktop.org, helgaas@kernel.org
Cc:     regressions@lists.linux.dev, airlied@linux.ie,
        linux-pci@vger.kernel.org, tseewald@gmail.com,
        kai.heng.feng@canonical.com, daniel@ffwll.ch, sr@denx.de
References: <20220908040821.5786-1-alexander.deucher@amd.com>
From:   "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20220908040821.5786-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0067.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::12) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|MW4PR12MB5601:EE_
X-MS-Office365-Filtering-Correlation-Id: 782f0b91-da09-49fb-9de1-08da91589fbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8k24mZNpNLwq63rADvgCixJNCIKpk7LyK0MRZHkuMRETw4Zz/rDdjgCrj9Wkm4BtAd4vM8RZRt2TAx3z6ohxWgjC/3lnX57FevTlv1Cy/bXDZzJFjG+CLk9qTKRqSVUpkiXMD7qiZbUvyOIFR+xax8pAiOLjBCSB47TobwVetGlSjIYqC8h4H/IC/6pyaSnBJfc9JD8LGH5zwmdtcFx+VfEjuROfpsxtGI3XPJk7tp/kVPsuaBOBfJ//ACIkEQIxht0YLeWve2FEl1An5cHEL2R/9a7FbAnKdd4xWE3kbzXGmLFk8TKx54S8UTOTuAUehqQld5EIGj9ia+SFnvqozIg4TJz60mWrMjWp92D8L7/ALzBTMQhVn3SSIUm3OQUl+oZAK0PiN0bKXnaGJVvLcSTkVijBx8MSNpCMKYAjq6S4MrbWyOmufFjcD+8JCafvK78E1KIzjNDcBmXIfOMdjKud5EUwxiWjSEg+6WYuO+B5yqv7jhCmouWbSJP9AA+yBweIpN4SZVfBa7Z3k9ATui19Bz5jJ07+XmCyCZswBxXQ0fEGYTkfRnIFK5aVRX/iZRYyDSUeXXeOQ+BwECB947Db657z33h8j0JluAZ4pyQkWmZ0NHniLS5ItTwL6j4ALk9yCmPsyjMvd0uWbY1CJxW0Ko78YdIbiimeQaQA+lLT6d6hZ98TWJwHbsJ2cb3KRDF4vEJsPF5mXWBi5Ev7XPjEU59zkkEBcdh0/RiLRsLKAPNC08CFaec5/8lfkoVvAlV6i38C1uTZFK2MFrrRVJrx9BpkysSXM1Zr9/FceErB3E/u+5xpn5+8T4fp3K0/bc1eNzMsCU8WqcrrTkeXKg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4614.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(346002)(376002)(366004)(396003)(66946007)(8936002)(966005)(6486002)(66476007)(86362001)(316002)(31696002)(5660300002)(478600001)(66556008)(38100700002)(26005)(6666004)(8676002)(31686004)(2616005)(2906002)(53546011)(36756003)(6506007)(41300700001)(186003)(4326008)(6512007)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVNPQWxPZnFxMVNEanc0eUxUS0ZndzZGbkFEU01ROUxZMDBqOHp1K3pOc0tZ?=
 =?utf-8?B?WDJ5ZmUyVXl0L1F4V09saGNuNzRWY3dWS1crSi84S0FSeTNMREZRdm5hTU1k?=
 =?utf-8?B?VGZWanJHY1pwNU55Zk1ESDkzM2JIdDkwWkNicW10ZVZ4SWNmU2YzMUpqRkI5?=
 =?utf-8?B?S201cVFqdlUxaStSKzJPZllmSHFnNm9lTkpTMGhJTXpXZVlVUk5NZmJlbXBI?=
 =?utf-8?B?SXI3bFBGVHhiN1E2K1JQR3FQVFRjVlQ1ZGRHRmowckI4UlRLaHhUaDI4YnNF?=
 =?utf-8?B?ek90Qmd2K0ljbC9UTkdKVjlrVW4rM0NJSVpOYkxNVmsrYmRFQ0N0enZ6bWhu?=
 =?utf-8?B?djk3b0xveVVUbFZaM2NFYm1FVFZNOG9TQXlQODFVQTZETGRSYjg0ZGROSXJO?=
 =?utf-8?B?K1NBN1NBUUdieERLVVdpbmhGeHV0NkFOTUF6NjNxMEZDVTc2dUE3K0Z5djlM?=
 =?utf-8?B?R1dPN0dSbGRNS3lwOHBaUnhnZlhRdWZhZlV5VkVtN1grVUpHQzAxNHRiSFVo?=
 =?utf-8?B?cW1kazZYT1BIdTRNdFlQM1h2U3RMcjgyYlEwamtCN2gxM0Y3N2pWa1c3bTNM?=
 =?utf-8?B?emxhS3FIMkI0eDFWU2puZlNKc05ycG0zejd1L3FKVjBoL2EwVEpJWnYzd1o1?=
 =?utf-8?B?WTVmVzUwT3ZoeFNJWkREUnFneElLZi82cmRRMmcwenpFNzZWUEN3bm9FNnUz?=
 =?utf-8?B?UW9RbllIVXVGbkpCUVdKSDZWTm9ob2kzcStXMEYvME0yQ25FMWJweVRXZWxU?=
 =?utf-8?B?RWFXa3FsYzZGVFlsbmJ5ZFhzQVBjY0ptQ2EvOGNkd0ZzbUN6a0RYcnM4Y2tR?=
 =?utf-8?B?QWNJU0RZZzFsMUo1V04xVnhHdkU1WlhGSm5MemJRdm9WNXVTZVNxMjFIKzI2?=
 =?utf-8?B?OE5vWUx6bUViZCtVNjM2ZFBkVHJKemFTL0JoQ2Mzd09uTGNRN2MyQ0FRSGMx?=
 =?utf-8?B?NTE5VW1DQ1lxcmRhZWl5b1dTZnVBV1FTK3FQVVAxTnRHQ3dzQ0FxUy9KMzRW?=
 =?utf-8?B?OTAxcUtKR21VK09kMFdtaHIvaFpVWFJpRng0MTdiZ1dTd2Z0Rit2M0ltbjJ6?=
 =?utf-8?B?WEtYTWhUQ0k5MnNLMEhhRUlpaDJZNnNpQmhKTlZYYUN2bkJNU2w2dmNERnhE?=
 =?utf-8?B?amZYRGpKLysvdjZhZ1FLdzBTdFhjMHZZdzNmUTBmVzMzZEVUbFpEZ0V2dE4w?=
 =?utf-8?B?RGdnWEVCTUgzdEk1aVExelk3Z29SeXo0Ti90citPVlhqSEloeUhDblJNeE5M?=
 =?utf-8?B?V0RtVkVTVDN3NG95a1ljVzNYb3hMRi9kSHNNaEJyZC9YMkN0cno1eVl3N1B2?=
 =?utf-8?B?VlZnZ2xtNlgyN0kwaDg4NXZJbmVzWjFjQWdpVXZLeU1UUkhJdkdrcmtpdDFj?=
 =?utf-8?B?TktjelVIaXNqQzNOU0FDeHVWR2R4WU1maHBKaktzckhoRjJybEs0WGN5UTlQ?=
 =?utf-8?B?Wk95L1d3aUJFeFM2aENISU12STAzU2FKVVR4Tk1neDJoYWdrRGF0dmNMNXlX?=
 =?utf-8?B?WEdXaDZLSFBIMjgxSjF5TEloaVBucm9VcEZ3djlubzJ4SmZIU2Fjbm8yVzNl?=
 =?utf-8?B?d0pqTGJIeU5MeHBBYzVYNzg3dHl1YWFSNXp5QnA4SjR0cStQL250YUIrRlhS?=
 =?utf-8?B?OC84NEo1cis2YTg1ZGZ3RXM4SHB0TDArekFHaE9ETklEQUxlVGxIU0xpMjA1?=
 =?utf-8?B?QjJjWlh5SkpuVnBFOHpuY3JXTmF6Y09SeGtaZmZ2UWVnU1Qvd1pDUXN4cmM5?=
 =?utf-8?B?SnJ0T2lGUGtWMHVKNzg1WENHajk5eXVvL3ZMcHptelhXTS9HRHkrck0rY2lY?=
 =?utf-8?B?VVdRZnJpRDYzSHpLZm43TldJVldMWEpyTCtXWTZsZm9qTXhXWGJPK3JLckpv?=
 =?utf-8?B?QzlZczFKWHpmVkVHckM2QkhXZ0cxR1A0Um9xNGpzTWgzMTB5YjhjNWJHUkJw?=
 =?utf-8?B?eTU2anhxSTROZkVyL0MvOEJyWVF5K1RVWWhOdFdVakxBWEgrZXQ4N3ZyVmZs?=
 =?utf-8?B?Nit6UEFQbmlrYlM3dkREREowc0hWOFRoakJMWDhBbHRDWUovTXRxMjNRb3NR?=
 =?utf-8?B?bDdIenNOM1NDQzZZNFd5aW91OG43VThMcFo2dldLdC84TFVyRWpuOU1DS2tB?=
 =?utf-8?Q?8at5XgkbnRJH+UVBZPnd2BJy+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 782f0b91-da09-49fb-9de1-08da91589fbf
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 05:11:45.2912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VekpPPG4LJRFgLMccg0rZc/Qc4f861nmte69SX4qykHPxnFPVq/0lnVZYO1tGpUv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5601
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 9/8/2022 9:38 AM, Alex Deucher wrote:
> Common is mainly golden register setting and HDP register
> remapping, it shouldn't allocate any GPU memory.  Make sure
> common happens before gmc so that the HDP registers are
> remapped before gmc attempts to access them.
> 
> This fixes the Unsupported Request error reported through
> AER during driver load. The error happens as a write happens
> to the remap offset before real remapping is done.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216373
> 
> The error was unnoticed before and got visible because of the commit
> referenced below. This doesn't fix anything in the commit below, rather
> fixes the issue in amdgpu exposed by the commit. The reference is only
> to associate this commit with below one so that both go together.
> 
> Fixes: 8795e182b02d ("PCI/portdrv: Don't disable AER reporting in get_port_device_capability()")
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Series is:
	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 14 +++++++++++---
>   1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 899564ea8b4b..4da85ce9e3b1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2375,8 +2375,16 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
>   		}
>   		adev->ip_blocks[i].status.sw = true;
>   
> -		/* need to do gmc hw init early so we can allocate gpu mem */
> -		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GMC) {
> +		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_COMMON) {
> +			/* need to do common hw init early so everything is set up for gmc */
> +			r = adev->ip_blocks[i].version->funcs->hw_init((void *)adev);
> +			if (r) {
> +				DRM_ERROR("hw_init %d failed %d\n", i, r);
> +				goto init_failed;
> +			}
> +			adev->ip_blocks[i].status.hw = true;
> +		} else if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GMC) {
> +			/* need to do gmc hw init early so we can allocate gpu mem */
>   			/* Try to reserve bad pages early */
>   			if (amdgpu_sriov_vf(adev))
>   				amdgpu_virt_exchange_data(adev);
> @@ -3062,8 +3070,8 @@ static int amdgpu_device_ip_reinit_early_sriov(struct amdgpu_device *adev)
>   	int i, r;
>   
>   	static enum amd_ip_block_type ip_order[] = {
> -		AMD_IP_BLOCK_TYPE_GMC,
>   		AMD_IP_BLOCK_TYPE_COMMON,
> +		AMD_IP_BLOCK_TYPE_GMC,
>   		AMD_IP_BLOCK_TYPE_PSP,
>   		AMD_IP_BLOCK_TYPE_IH,
>   	};
> 
