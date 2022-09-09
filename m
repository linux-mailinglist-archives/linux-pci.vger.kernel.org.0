Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B51D25B3DD3
	for <lists+linux-pci@lfdr.de>; Fri,  9 Sep 2022 19:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbiIIRRs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Sep 2022 13:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbiIIRRr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Sep 2022 13:17:47 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5FE1269F3
        for <linux-pci@vger.kernel.org>; Fri,  9 Sep 2022 10:17:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VRl1UZlkfYfRKUQsgCEqzWpbcRugBJWek10H8pzDajKHhPpbd8/dXRG+83ZJvR75PSbGlhrYYR7ehuJo3kjpXS6u0Ryl99wFNHIPaNlp7l0nb4hPLp8zhTv2W7tvlQ2y0hBXsbyWuUWEF7V30Y7c/Fe4t8VuyJOkQoTSbr5Iw7EX2cewVKAmGQhThKKsSipDVL4SyQGdHoQVAyBmszvxRvb4gIHjOh9gBg3Sr4zaibrVLG16MQmp/plCjheLzy/Uwmz5hOc2Q9Hk4EnGnUP2j522Ixtj/NDKOVHivZY0t09TsZrgsXjVwSC3rvdkQpF+ulIstA9IbhLODh+v5RqvSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yDy1LZew+EtbgKxD94e3j2s/4qFA8o5vjmYVRE+Eryg=;
 b=eqWQVvlgLMGA7yJ/Hm37R9LbQtasUL72td2ohyOeLy38XrIG/lXiij5usnJbsAz4QQ6mBVMugf6wuUqGJ+Ayqdyjnb9M/wK8WvbhDWWevCXrOXv4zRmZqxAzHIXANewZFemceL9HJZphvYLHifgAEEjF/Pvqhee8f3pv9Ld42TMVDHq8NhEaNLzdEbSldHEbErR0Nw1MetcdF21Ar3vVh3UBkkBu2zNFowiUydvPNdE8HN0D3yvo3BRWCdwLa6GSzvc3awtN+cTlWYIznN3sUhcAUMT8m6xyXN5iLuCTfp8WUi/Z2Uw5izFSkYQv9pWyCHZwOQFkbkNJMW84Um3//g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yDy1LZew+EtbgKxD94e3j2s/4qFA8o5vjmYVRE+Eryg=;
 b=pn/2DKOvnY8aM1owGc2PXNkq7Ld1z/wVdB1tqDqB8cntluAbFbNEW/Eds8mx1zhNZkQfe2Ez0KDYCfKTxED1QG0zqtRE/M8I1MMQx4SlBAyLP6U/dwOGgMVPTMkb/4NjSy44hUGLQ1MsGmA2QZ2iuwAwAj9+iWlUh56XqMYUfXw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by SJ0PR12MB5407.namprd12.prod.outlook.com (2603:10b6:a03:3ac::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Fri, 9 Sep
 2022 17:17:45 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::2925:100a:f0b9:9ad8]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::2925:100a:f0b9:9ad8%3]) with mapi id 15.20.5612.014; Fri, 9 Sep 2022
 17:17:45 +0000
Message-ID: <4f9441e7-6ca3-25a6-6dd3-644b211d3fcc@amd.com>
Date:   Fri, 9 Sep 2022 22:47:32 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 1/7] drm/amdgpu: move nbio remap_hdp_registers() to gmc9
 code
Content-Language: en-US
To:     Alex Deucher <alexander.deucher@amd.com>,
        amd-gfx@lists.freedesktop.org, helgaas@kernel.org
Cc:     regressions@lists.linux.dev, airlied@linux.ie,
        linux-pci@vger.kernel.org, m.seyfarth@gmail.com,
        tseewald@gmail.com, kai.heng.feng@canonical.com, daniel@ffwll.ch,
        sr@denx.de
References: <20220909164758.5632-1-alexander.deucher@amd.com>
 <20220909164758.5632-2-alexander.deucher@amd.com>
From:   "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20220909164758.5632-2-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0135.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::6) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|SJ0PR12MB5407:EE_
X-MS-Office365-Filtering-Correlation-Id: 96832e56-7d16-4413-5c61-08da928735c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g6SnqZZV5FmqgtvUGrxn5lUs2YV9nJiMhTMp7bAn1hxQpIQFULxy1MuzArUOwwK8Edppzu0fd00Nw7kBuMbbYQwHycNaBqGxj2+rXUcYaVlD9RWhUcmGxn5j8E0B5olZijF6i8sB3NyJ/jyAg9R8qhkCejee8uugrYsF/obWOY+Q6MxUXEw1OHKO2Ix6oaiqBR1oZO7F1GQpiC3nXSQSWa3omL/+i+iS4DGy4uH8H9RlZYzdckE6uFrSuJY5OIDMailF0ZIbbsLiSpozqZkxw185MKxdrvJdTkZnmL0sjnLVLSi8kM7s1HI07mNtO5motFcxZNZ8s4XjTf5XMXaAjPT8nTgnTCollyd7WLkpV0a+gYvUKjRpYmUto2/jtTO+hqwDhYeAluv6otMDuo/IYlr0wJPdVEEMLwcWKxabdxFaU0tqhLehKzHcg6Wh5DY4FYTCAi0QBrCWPJamgAMcrTP2Xt+T0uq5A/mozMa0HL1NW0A+adPB5g4bz9mB2Zqsg/EXJurR0ITHM8rnEtoanEjZt87vHgypfgF3Urv9CbESkADD0JuZDQrbaSg16sARiy5RfRcGQ1ddnz6WjnZl9nuCX51QGAjYpEVXtbcguj9DkHYdrob3hz63Ml043tq+R7Uy4TAMmIpvykk2KLnqLPVdOADsk+EpvApQNubCb3Nx3aKQZIstJD6BqJEocB7YNtoOeWCtVBjCcwv7kM9QHiYBNAfHSEc6mHq0IMelOv/AQMZonT9klfneqErbRK8bAR6UEWPA6DxNf+ym9JvBRoXVfV+xkDF/FOZJh5gyPPq8/J3ZbETwqEwwr7uN8zY0LIHtZKwxeIkskSC2Ty2w6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4614.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(366004)(396003)(376002)(136003)(38100700002)(8676002)(66946007)(66556008)(4326008)(66476007)(316002)(2906002)(5660300002)(7416002)(8936002)(2616005)(186003)(83380400001)(966005)(478600001)(6486002)(53546011)(6506007)(6512007)(26005)(41300700001)(6666004)(31686004)(86362001)(31696002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2RyN1hTdXRreDFNY2pSdVgrYm0vM1ZUS21TRHZ0a29Kb1A3a2haRTFOeW9m?=
 =?utf-8?B?Umxub3FYRHk5KzRIbGF3bHdUcDQrN2ttV0xmaFNSZ1JMOWkzemxWKzV0V1po?=
 =?utf-8?B?M3R4ZS81a0VlZDNSN3pKeHJoV2tqVEFtRU1wUWxIc1VIQW1CVkxjYnoyQVVP?=
 =?utf-8?B?MXBnL0pGWmV0ZUxrZEM4UDVWY3N4c3FlOVZzZ1Vna0VpMnhHN09pdk15MHRC?=
 =?utf-8?B?RVFUMFllVWNLWUdDdDhpY2NmM0dTSHRhTTk1RGdmNWlLMXVGTXJPQVJkcVJM?=
 =?utf-8?B?TS9IOG45VjJvaTVscnordUZtTGNMdXBZdWhrMVZuSEh6U2JMZlNQZjRuZksv?=
 =?utf-8?B?N1lHZ1J6QlFUZ3BieUM5VVh2VDl1ZjYxUnJQQUV6Y20zQndTMTB5ck1JTjkz?=
 =?utf-8?B?QnhOVWRNM3V6QWIxNHY0Unpwd0lCaDkzK3NodTVoZ0pqYXBERVpvMkNBSWxH?=
 =?utf-8?B?dTYrTE9xMUNMb2pOc01ndndVeklJT3BzeFlJb0YwZUE2SW1ac3FLN2dRcGp6?=
 =?utf-8?B?bURzRWE2NG5YcEN3bFVpRDV2N0R0bThDYUpIQjVWeEoxd24rQUZpY2VJWklP?=
 =?utf-8?B?cE9RTm9PVHQ1dmMyanJwWTlKalcvSXNOZERHalN2Ymd5elRqZVRFVHJnN0RI?=
 =?utf-8?B?TERKUkFyaklBdVAvWm5SMUVycFhrWTdqWGNxUThMWGt2OU1Xekg1bGpySENi?=
 =?utf-8?B?Ui9VUTIrRmEzaWNCS05mejRRZElUZlZ2L1BvMXN3Mm4zcnJJaXRwUVp4Qktq?=
 =?utf-8?B?LzBIdGFOQ1U2VnZZdDFVM0pCdlZ3VkQvTTZQUmJjbnA3UXBvZVgxZFNtZzhX?=
 =?utf-8?B?TXNnSE5GOUpuU0dRTkhha1pRNHl6TWZzSm5MLzNXZCs5WWk1aWRMQ2toYTYz?=
 =?utf-8?B?NWFBdVUzU2pRQzN5WUtScXlucG1jYi9vV2pWWDJ1RE5ydk9URjNlN2VBaWxv?=
 =?utf-8?B?RytGOXR3cHdkaVNMOE1aWTA4TnNrV0diM2lOZlFGQmlOMUtiVWx5ZFVUYWp1?=
 =?utf-8?B?TE5qRysydTBocGo1RHdPa3BLalVYUDI5alRCeHQrbDRyOEg1NWRsdUNiTjVO?=
 =?utf-8?B?TFI0SGN4eU1ldHVJVk43WE9ZMURTMVA5UVp2cWJ6c1Y4djVSVGxYNlVyZThP?=
 =?utf-8?B?bDJBOFBWL2tNMlhCbFhnNnppZnhpSjh1MGcxQ1Y0TnRKNWhwaGNDOUJrVWg3?=
 =?utf-8?B?OXl3TGt4c2hjb1FoSUtXRitiYmY5a3I3M0dIRE53TmNXV1V5NGd1Q3ZVMGh5?=
 =?utf-8?B?K1NJK1dCbHU1djd3TWdzZEp2THNINXZMS2o3Q0lRQ2JvdmpqTC9DUUZicjNv?=
 =?utf-8?B?L2lna1kveWljUkloSmhKSjBrT3pSelhFUC8wR090WUViRko0dkFHSEZJYVVI?=
 =?utf-8?B?VHdlajM0MXEzOHR3RGg0Q2U4UnhEN2hyak1tSXVjSXFlTGdsaE5BSGJmUi8x?=
 =?utf-8?B?SzR5NkRTTzlDaWFpM1EybEZwOFAxaS96ZGQwd3BycUlpeW9GeDFTejNINndY?=
 =?utf-8?B?a1MzTndocnBOcVdwUzdlSGsyQVF4d1RJVitneEk3eXZCOTZRcVk3SS9CemZN?=
 =?utf-8?B?ZlIrQWdGWkZZdm9BQjhqdUU3VWRRRGVuNHF2Sk9BTGFhMnc4Ny80SzFXTFpT?=
 =?utf-8?B?d3J3djh0cy95OE8yYVB1RVc1eXd0ZG5Vd3VMeEh3a0IyVUVveWZBUmlhMVdM?=
 =?utf-8?B?ck5tMDRIN05VcG0wYi9kNjh6bXBzOHhibXkvRkJPc0JEOHVuTFhYUkdrUHF2?=
 =?utf-8?B?RCsvSVBqbGcvOFVRTDBXSi9pNXg3YlI0enpNTUM1N29rc1F0V3BGZys3OEMy?=
 =?utf-8?B?QU1RMVIrdWxMSmtFZWFJUTJXQlF0WVFzbVlUT0hkSW55QW1BK0FMOXdaS3Rt?=
 =?utf-8?B?bTJZSDZBVVpnMUU3aCtTT3llSVJTYTR0MUtJUTdEcm5rb1NCMnBxUkZyT3BG?=
 =?utf-8?B?WFpDTlF1Z3dpTjJBTVRFYjR1TDhhR1RsV3NjNFpQMnNuYXRteVJ1bGZKeER3?=
 =?utf-8?B?SE5ScUlOUlUyY0phNWVWOW9LUzU2L1c4d1JKdGdXYkFhc0oraTA2eVNPamgr?=
 =?utf-8?B?ZmlnYmJGTjBJTis1NmttYjBpejdsUGxlTUFqS3pWUlA3K0RDV3Ewd3VKVEsw?=
 =?utf-8?Q?lGRdJ+V77e+cpPGgKfSnpfnqZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96832e56-7d16-4413-5c61-08da928735c8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 17:17:44.9878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7J7IDWWDk0OktY0+T8oE3mhwG8mZnsaAD7UEXY5uiR6jJdhV1MGHHyNv/G+r4hFR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5407
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 9/9/2022 10:17 PM, Alex Deucher wrote:
> This is where it is used, so move it into gmc init so

It's only the *side effect* of GMC IP init process, but that doesn't 
mean these IPs are interlinked. Any IP init process which requires HDP 
flush also would need this. It is not a good idea to couple HDP remap 
with GMC especially when there exists a HDP data path way without 
setting up GMC (MM INDEX/DATA).

 From a generic software perspective, I think programming pre-requisite 
for HDP flush need to be standalone and the order needs to be guaranteed 
before any client IPs that make use of it.

Thanks,
Lijo

> that it will always be initialized in the right order.
> We already do this for other nbio and hdp callbacks so
> it's consistent with what we do on other IPs.
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
> ---
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 7 +++++++
>   drivers/gpu/drm/amd/amdgpu/soc15.c    | 7 -------
>   2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 4603653916f5..3a4b0a475672 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1819,6 +1819,13 @@ static int gmc_v9_0_hw_init(void *handle)
>   	bool value;
>   	int i, r;
>   
> +	/* remap HDP registers to a hole in mmio space,
> +	 * for the purpose of expose those registers
> +	 * to process space
> +	 */
> +	if (adev->nbio.funcs->remap_hdp_registers && !amdgpu_sriov_vf(adev))
> +		adev->nbio.funcs->remap_hdp_registers(adev);
> +
>   	/* The sequence of these two function calls matters.*/
>   	gmc_v9_0_init_golden_registers(adev);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index 5188da87428d..39c3c6d65aef 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -1240,13 +1240,6 @@ static int soc15_common_hw_init(void *handle)
>   	soc15_program_aspm(adev);
>   	/* setup nbio registers */
>   	adev->nbio.funcs->init_registers(adev);
> -	/* remap HDP registers to a hole in mmio space,
> -	 * for the purpose of expose those registers
> -	 * to process space
> -	 */
> -	if (adev->nbio.funcs->remap_hdp_registers && !amdgpu_sriov_vf(adev))
> -		adev->nbio.funcs->remap_hdp_registers(adev);
> -
>   	/* enable the doorbell aperture */
>   	soc15_enable_doorbell_aperture(adev, true);
>   	/* HW doorbell routing policy: doorbell writing not
> 
