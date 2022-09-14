Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F735B81C1
	for <lists+linux-pci@lfdr.de>; Wed, 14 Sep 2022 09:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbiINHFC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Sep 2022 03:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiINHFA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Sep 2022 03:05:00 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3A518B21
        for <linux-pci@vger.kernel.org>; Wed, 14 Sep 2022 00:04:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HbzijHNYgd216kgE+05EXekN8S8Eulq+Mgcr3tA/EA/U7wcGsB+k2luOVwSbcPPrK2PtPlYNzxFtWNGrspRgXXVPzWVzKvf5eFRMJSXyW3ZXo8RwWpKH+4aq4DFuPlcbaH5aA1TrOWipeTHPHR7WfaSMu0iJgjIieaLRikSjoFi5t4AoLJ7aeYMMa/nnfJAC8/UyT3Q9WT3fWKwNgDc1SOj/aoaxzRPJuF63KJwUmsL27wbS4dm+y2jEWrJVPbIjPwUWpkuvu70r5scYMH3QxLx39l8qsJPbRCegXJMPaRLOss6yXi1iI35/4gqvuMkRpgRYcTKINbxKO+TkdR1bQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t8s7jvcDOdneVn+gTCyWum+Ua9v/0ZPXHyuckZ8e3Nc=;
 b=GGWJPPHKuo4yiojZd2k9fjWQ/3ozLO461JEIvlKH1/KxMeZtvQl6dhbyyi6E02ZoUZzh3DOPYEYZ22Xgzf+9GTbhOnzS6VSYlzBdfqTpIVSSXA/E9veAyeojlDoQJ75A5ihsByhOFSWvnPV2z6DCrt+4QV+sRuOE65FpYkS45ZKZeKGM8X0N4LTqKt/W9k4/edqFDTpUu2/5OUzVoTAdZupcwJjsfqJ4v4R6FpkgKFzUMNEsiL4SGtnXgZIuCvHvZS6tE8XvvCl/OISrInRzJETDzmL0QzDtlozfO4c12HKg9XmXgQjnVoS5nJTAO8I2exbzQi8se9/vY/bGotnhFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t8s7jvcDOdneVn+gTCyWum+Ua9v/0ZPXHyuckZ8e3Nc=;
 b=k/z5xUqqY8KIhUiFRGnVPbijQLn51dwEiivoOoqpoMtGYZaThknpwmgUy51mZw8CVYFUwlskgGCS4la//VvNlLhSntNeEc5iqLYHVgR2OPlIEfpoXYsPtBdwZIwkPuf+hrDZbPWxXTVDLqKCn9pz/Z5aseCCb/i7gLsAkspFM10=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by BN9PR12MB5098.namprd12.prod.outlook.com (2603:10b6:408:137::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Wed, 14 Sep
 2022 07:04:57 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::3054:3089:efbb:78c0]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::3054:3089:efbb:78c0%6]) with mapi id 15.20.5612.022; Wed, 14 Sep 2022
 07:04:56 +0000
Message-ID: <6dd85297-76d0-07c6-bfd2-5795a339f032@amd.com>
Date:   Wed, 14 Sep 2022 12:34:31 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 1/3] drm/amdgpu: move nbio ih_doorbell_range() into ih
 code for vega
Content-Language: en-US
To:     Alex Deucher <alexander.deucher@amd.com>,
        amd-gfx@lists.freedesktop.org, helgaas@kernel.org
Cc:     regressions@lists.linux.dev, airlied@linux.ie,
        linux-pci@vger.kernel.org, m.seyfarth@gmail.com,
        tseewald@gmail.com, kai.heng.feng@canonical.com, daniel@ffwll.ch,
        sr@denx.de
References: <20220913144832.2784012-1-alexander.deucher@amd.com>
 <20220913144832.2784012-2-alexander.deucher@amd.com>
From:   "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20220913144832.2784012-2-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0170.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::12) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|BN9PR12MB5098:EE_
X-MS-Office365-Filtering-Correlation-Id: 9262b570-70cd-4c43-c25f-08da961f6e04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dppXQBCchSJd4HrZ6+el4H05pnF+puVZ4dQ+Ck8jMHeHC1+rPvbLpMAx5VFnSXKmvyetarTLpLtlf4WNm16o5P4XhLo3pdyxXdQrSfXmmbNuopfqMh7I9eUUaSjAwYygPW5eY8zmcAySyS9zqYJldQ+RgGT++6e5LkUnVze6yIw4zn9mloMu1FCglRNpcjdUlqXgg3VIiv7KKJL5H5QaKwEEaOGgCSXOpmCPWcbB+SNt6lCx9r5aRE4WKQA7UmtC2oNfcvCHFNbY9TWcKcJCm0uv0UekUJciLqMTnnlU0byjRqFvPerHQKpepHGVvnnZwLBEjPfhDGznKfZHSlhfmGlu2oj9HKpGqO8+z6nZ+gYYeUPeg+GkxMwDZk09uJoXbyEbfmagQGpz14SdQ/2kCAWOXwwnZ8d0nrZyu3InD+HlvSJRTP/AlQvfGR3tcjhayjQBLTQibL5igtMR7RhSqWxx1WLrqYQH4zEek6CjYbZAdxY2reOWqOMGn6iY64JPgrrfq4U/cQ41hDFLR7zuXfeTiO39IbeeUyJ4XsFWRu/XSuMb04Btyt+3voFFGof+xcAnSSWrKw0mrqfgMfTOASwQHLP4mVg06rXWH9PHKb9q+nsaklotW0MkvXAZC7J5JhXHo1q66J3H+Rso+8//jcdSgP+Co46ANvoRPU8fEoHlNsFfbaBio1JCIZANMu7VM4wpWcou4q62NQ9ITx73uCNQ1YlqFXWoREPxO1f6q7RXHeM0mYTeXmfrDSnKWXujQPD0a7UnQWngdmt1ukLwk/nVw6Ps1vTgaLHxhyrCfI2Wu/wHzBOt1iEPqwrV7q9g
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4614.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(39860400002)(366004)(396003)(451199015)(31686004)(2616005)(6512007)(186003)(41300700001)(6666004)(38100700002)(8936002)(8676002)(4326008)(26005)(7416002)(5660300002)(66556008)(66476007)(66946007)(36756003)(86362001)(31696002)(2906002)(83380400001)(316002)(478600001)(966005)(6486002)(6506007)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TStnYUlaMDdEVzVIZkR4c0hXRWE2NXJhVS9mdGU1RGtnNTNWY0YxRDJQZXlK?=
 =?utf-8?B?QXB6NjJCYSs5OHFJYUwrNzQ5cUZ2dkxiQ3ZjUVFQUHpRQi91STlOdGdqay9Z?=
 =?utf-8?B?NjY2azY5MWo1UmhWeU5yUHh0cU1ldFE4RmZqZlplL3ZqeFhnWUNsUjFZbHZv?=
 =?utf-8?B?eEM3azY0SXp4S3Z6T2kvSU5tN3dhQmJibzJpM01Zb2M2Z0JodzcyQ2ZPRXVX?=
 =?utf-8?B?L2lkRGFYWFFnQkQxalNoYWlhZ1JkemFrNTdwR0FNTUdXLzRxaElEaU91UUdY?=
 =?utf-8?B?SVpjS1Qzbitwd1JVVlFHMjd5bUhTK2QvaXY4T0VYN0NZUFZQWE1jYXJPdlJR?=
 =?utf-8?B?RlJjRkh4OHZwMVlCUiszVitFd2haMDBLYWYxTmpDVzVQVFNUK2oxR3gvMWkw?=
 =?utf-8?B?WSt2TjJNTUFhRURXMVhFWFJ1c0U0WHVRNUgrcWEvNUdVdGlDeVQ1YW1yKzhY?=
 =?utf-8?B?R1Z3b0tBVWJUaWdOUE40TmtveWo5RVNVRndLLzhmZHpXbVdnY2NSR1VydGpy?=
 =?utf-8?B?OWQwSGMxcUZzWFlGRmRrSStwY1FDTG93NEV0QWE0cWJPcUVXREo5d0NJQ21D?=
 =?utf-8?B?Y1lHVWdTcXB0MzBMQXd6SzgwcDZRbDByaHlYWStGcm5NRVpVUTMrYmpBRjZ1?=
 =?utf-8?B?NTBsQ2JiVW85cHlNSlVhS0NFVmNPend5bStVUEY4Y0pwOVd1SHpsSXY5cjUx?=
 =?utf-8?B?SEpieEJKbGppNHZFemYxMVhSeStCUGxaSG9NRGM3Qng0SGpZbW1YM2lwUUxX?=
 =?utf-8?B?Q1p0RmNldlM3RHNBeTYwcFlWT0l6UUdPNzdqQythTkd5VmR6ZThyMFVOVThS?=
 =?utf-8?B?ZlNjUVhBYVVFZk0zNTJBeFdIcU11RnFHSENKam1wNzZHeHBzbG9RRGx2Nm9t?=
 =?utf-8?B?U3poakNrMEVNbFdsNERYWXZLUXRZSmdLWGczd0VWMFZWb21aRmV6eTJiWHZx?=
 =?utf-8?B?VnBxK0hzMmxKMm94QkdkNHEyaUh3Smt3WkFMdENtM0FJUGpXZjNSZmdKL2pp?=
 =?utf-8?B?akJjakFIcTQxaVJkR0txMldTbjdoL3YvcE1OZVpHTXBicnhjMVZFYXBpQW53?=
 =?utf-8?B?aC9oMHRkektmdHRHL2F4a3ZRU3VWREw3dTlNZjZiM1dkbHQ0Y3JpQXlyZDZ2?=
 =?utf-8?B?VnRWV2lhamlUVFhRUGxkMGMydFc5ZmFLejg3TWVqWTF3L0ZnTFhLRVYrRUt0?=
 =?utf-8?B?T3NTTXM1N3hPdkRZc3pOSFQ0U1NNaTJWcEVnZCtlemp0T0xmYklEUTBHR2pk?=
 =?utf-8?B?aDdCYmczZ0lRbitoYTErbkorMGU2ZTJURkVKV1I0M212WXl2bGFPOFIzak1z?=
 =?utf-8?B?QTRRNjFBenF6WFFLRGhRRjBiK1B0eWJ0ZEswVEtyWGxYSm5QaFdwc3kvVUNP?=
 =?utf-8?B?U2p5U1Q1V2hRU2w3ajB0YWpmeGxQVzl5YlpWYVhkajFWY2VRbXN4TDJQbGo5?=
 =?utf-8?B?N2I3ZWhQcFBVL0ZubUdFeWlWeXQvaEN5aDV4SDNadlhad05tQ2M5L1JmbG1u?=
 =?utf-8?B?Qnpzd1loc3I2cmgyeVZERlRTME5kdUR1eGptczh5QXZuYzdYK0o0NEVMT3hO?=
 =?utf-8?B?V05zdlUxbEFxcllPd1hneW5ROUZKelVUTE55cGVDd1QzbE83SXNqNEJZYVFV?=
 =?utf-8?B?MjFpREFZaU1XbEo4Z21JVXhvVXNISThkS29nOUxsV0VBMmtrdUZmT3Zmd2di?=
 =?utf-8?B?MVRCRjZzOURUNXVKYUlmdjEzNDh4YnZEM3lzaWNtQ2NmNkF0cE9IVEY2dk81?=
 =?utf-8?B?MFNHWDFsZG5JMXE2dVZnbXVEQlNnSHVTa1M1eUZzVExsWERjSzZSYUdheFZG?=
 =?utf-8?B?dzA1WEM5Ry9NRzZSNm5YMllVVWkwcTRYZ1Era2k5QWVrL013SHZlbURkcGNz?=
 =?utf-8?B?VzR0K2J3Yk1lNnZrdDFuOE42UGlERmNoZUxjQWZ3NmxaMHJrTFY4T3RwNDh1?=
 =?utf-8?B?eVFHNHVnZFduME95S1lpazBwSDFsME9Wbm5oaFdYTjRSWXFGRHFHRlNoNEZx?=
 =?utf-8?B?a3QzOEFva1ltTGNoblFiNWNSV3RYUVo4UmZ3aER4cTFmUG13NllqM2Y0ZWpR?=
 =?utf-8?B?RzJVWTV0R3QvbHZrejJCcDZ5VFpCb2pSQkdib2lhWDc3M2dWMlZDZS9palAx?=
 =?utf-8?Q?gXEs7z4b2ytotvm5y0Rh/RiTR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9262b570-70cd-4c43-c25f-08da961f6e04
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 07:04:56.4835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7bn77X3wz4HXCYZurC2kBuAIIgHIunVEMPjYWZyZf/oXTPV09/R1QSchbKyBWS5E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5098
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 9/13/2022 8:18 PM, Alex Deucher wrote:
> This mirrors what we do for other asics and this way we are
> sure the ih doorbell range is properly initialized.
> 
> There is a comment about the way doorbells on gfx9 work that
> requires that they are initialized for other IPs before GFX
> is initialized.  In this case IH is initialized before GFX,
> so there should be no issue.
> 

Not sure about the association of patch 1 and 2 with AER as in the 
comment below. I thought the access would go through (PCIE errors may 
not be reported) and the only side effect is doorbell won't be hit/routed.

The comments may not be relevant to patches 1/2, apart from that -

Series is:
	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

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
>   drivers/gpu/drm/amd/amdgpu/soc15.c     | 3 ---
>   drivers/gpu/drm/amd/amdgpu/vega10_ih.c | 4 ++++
>   drivers/gpu/drm/amd/amdgpu/vega20_ih.c | 4 ++++
>   3 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index 5188da87428d..e6a4002fa67d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -1224,9 +1224,6 @@ static void soc15_doorbell_range_init(struct amdgpu_device *adev)
>   				ring->use_doorbell, ring->doorbell_index,
>   				adev->doorbell_index.sdma_doorbell_range);
>   		}
> -
> -		adev->nbio.funcs->ih_doorbell_range(adev, adev->irq.ih.use_doorbell,
> -						adev->irq.ih.doorbell_index);
>   	}
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
> index 03b7066471f9..1e83db0c5438 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
> @@ -289,6 +289,10 @@ static int vega10_ih_irq_init(struct amdgpu_device *adev)
>   		}
>   	}
>   
> +	if (!amdgpu_sriov_vf(adev))
> +		adev->nbio.funcs->ih_doorbell_range(adev, adev->irq.ih.use_doorbell,
> +						    adev->irq.ih.doorbell_index);
> +
>   	pci_set_master(adev->pdev);
>   
>   	/* enable interrupts */
> diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> index 2022ffbb8dba..59dfca093155 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> @@ -340,6 +340,10 @@ static int vega20_ih_irq_init(struct amdgpu_device *adev)
>   		}
>   	}
>   
> +	if (!amdgpu_sriov_vf(adev))
> +		adev->nbio.funcs->ih_doorbell_range(adev, adev->irq.ih.use_doorbell,
> +						    adev->irq.ih.doorbell_index);
> +
>   	pci_set_master(adev->pdev);
>   
>   	/* enable interrupts */
> 
