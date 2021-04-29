Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE5C36EE6D
	for <lists+linux-pci@lfdr.de>; Thu, 29 Apr 2021 18:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbhD2Q4h (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Apr 2021 12:56:37 -0400
Received: from mail-dm6nam08on2085.outbound.protection.outlook.com ([40.107.102.85]:34465
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240852AbhD2Q4g (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 29 Apr 2021 12:56:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ihFr2dW0Hk5+/pZ2DxLCdC2Uura6Y3WJ2e4sKtBkmiyflwxNkBJ39L1O/GGqJqiO/PlUSmRmjjp3vt4PwW/BGSThvOYaw3o3pXPQ2JrBrfq6coqqmlTfgFtRxACjsMWgELSyWU0jILoszbFZ/tivhHbdxb/QqbU5SHBBXTTanBpuH/7Sygch8UdotPvGY7wafserPucst9lT7xL00jpBipLkuFB5arNyQtHhoNADc/jXaNGIctr6NVZAY+peyaLlrTW7FVFyMRYcJ3u1cKc71ed1k/ROs70xniQ5civv9qYDxbl3NDjPLxi8qC+1q5WBQB86PBno/c9jGrthcSyHQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ckHwN0cC2b9435Y1X5w13UYX+tJvJHHmrhzmAnUwEUA=;
 b=nViFpOO1VyTZyqE2y0RnFOwVvf8rxU0Edhh2cSRjcdeXB0h05ki6EdFq13gaEX9zNGEAL8xZrvUIZaDldIAtw5PeBgXNFzT1nrSEOO8uea00B4DqZkOlSiheNmXUvIggKv3eQS8eT25O0t+cVq+DWDJpOgu16YUQPma80KsySb/sUwgacB3t56lkRE8+Lc1OIqWikRz4efDiWsKrWItfu8XTCr617Jw7dXN8atk8lmPHH9PniyMJeeJFvs0aLp8d/lQ+CulfO7vwk/+Gkg1QWM2bbVbg3xLzjdZNyyQzHQACJpZLjoo7KQO0x67Zpyf62yjaqbfYU8/+zPxblGBVGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ckHwN0cC2b9435Y1X5w13UYX+tJvJHHmrhzmAnUwEUA=;
 b=WKxnEqTI3qKQqnB0sWk4F3fLUKFhy8lxd0pfqP1AdAVAHPODtl6a4CTPxF2OSBywDWNFcXoQp90cwBsLdlONyx4m7DPdQbU5fjfoOTWIBxiSNQvl14mv4wn8uAhp+nyinRjJvjBM5tiiebeEpQMeCFzr3+JUEZpfkbpEp9umsis=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SN1PR12MB2398.namprd12.prod.outlook.com (2603:10b6:802:26::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.26; Thu, 29 Apr
 2021 16:55:47 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::ad51:8c49:b171:856c]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::ad51:8c49:b171:856c%7]) with mapi id 15.20.4065.026; Thu, 29 Apr 2021
 16:55:47 +0000
Subject: Re: [PATCH v5 16/27] drm/amdgpu: Unmap all MMIO mappings
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-pci@vger.kernel.org, daniel.vetter@ffwll.ch,
        Harry.Wentland@amd.com
Cc:     ppaalanen@gmail.com, Alexander.Deucher@amd.com,
        gregkh@linuxfoundation.org, helgaas@kernel.org,
        Felix.Kuehling@amd.com
References: <20210428151207.1212258-1-andrey.grodzovsky@amd.com>
 <20210428151207.1212258-17-andrey.grodzovsky@amd.com>
 <ac2bb28e-141a-ef05-328a-af398455c8b2@gmail.com>
From:   Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <e8ba3e91-69df-0103-24da-033a9aeae3fb@amd.com>
Date:   Thu, 29 Apr 2021 12:55:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <ac2bb28e-141a-ef05-328a-af398455c8b2@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2607:fea8:3edf:49b0:497:888:9bb9:54f1]
X-ClientProxiedBy: YT1PR01CA0100.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::9) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:497:888:9bb9:54f1] (2607:fea8:3edf:49b0:497:888:9bb9:54f1) by YT1PR01CA0100.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25 via Frontend Transport; Thu, 29 Apr 2021 16:55:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ffb942d7-f6fd-4b7c-1abc-08d90b2fa2d4
X-MS-TrafficTypeDiagnostic: SN1PR12MB2398:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2398A2E7E31B759DD47345A8EA5F9@SN1PR12MB2398.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MI9n4mO55ZwjkjtQ/0WyosI2wLHjYT+GaWs4RGe4bS4e0I1+VwxAQ6iFXI1czvVGiBDE5J6csHFVFjoF9131brlJ+mjHkMGsuxyYLc7iZ9IgtU/8rBJzGPsP2aZ7WYQwRI1mZ//55oD0stUfYaZX2yG1qAVuHzPuHwC4kTc/WUoqXSKPeyB2rVU8JTnPsAQ2lavuFSnflwsPELOVdFBJQhZMW9ZJ/DGwRlHl63u2efvBBER7gjPLlduyHSEf21WzOrPdp1isttUE8OahAdRwsrRtE+dbkQTMjuTjLg+bDrBeVUR436sT4QrsZVxpsGbW5PujO8UGshtSsAP1pkwSjPNdsh3NXYUyRqbCPzAKIsETc+/AuLGRq4pSCqyWvdCWMn1gBJ3e1BPYutOBnBzHIIO850xoH0wFvLkC5Mq+4u8uRXVy/okeifFcX1hC9MxI9y1f28p3EPCibqJU4DmLOz8Fjl6YYQd44y0Xat/iul2VnXmJIuNvV8E+AMJmC5IPZqsBRq4S4ITQqw/TYP+KJeIPS4E5aPzo+Vrehc/e36R1bUOqkYF0BCafBx8pS1P/+0W5xvrvLvazGA0OZBw2xFPBhGB0SO00bceHfNY0KWEZsbmxSeFJ8tFP/CuyTPGoGazLFQLOnzOIzgwC7o2W34KzK/DM49P4RktJMQ2mqbd+dxYj5TBigBwUcv3fb7tb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB4623.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(366004)(376002)(396003)(346002)(136003)(6636002)(36756003)(4326008)(316002)(53546011)(66476007)(66556008)(186003)(16526019)(52116002)(66574015)(8936002)(8676002)(31686004)(6486002)(44832011)(86362001)(31696002)(5660300002)(2906002)(2616005)(478600001)(38100700002)(83380400001)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?d3pCRXF3OFlZaUQ1Smk5RmExdjZOQng2eGpQWllnYS9mYVFzempMZ3lsYUtM?=
 =?utf-8?B?S0NyazlIMmR2c2ZFZkFaeUVjcjBQK2VKcFRBOFFicVBTdDRjc1FIY013alN6?=
 =?utf-8?B?VmJydzNaeTducUs5cStnMmdaWXdXcU4wNkQwU3FHM2pVeTI4cGtBSGtRNUhU?=
 =?utf-8?B?a0ViTENWSVdtWmJBN1lmUWpHeDlIYTlXZ1FsOWJvbEhsV2hGWmYxckZNRE4x?=
 =?utf-8?B?Mi9YeVIydHFBN2k2d2VmRkl0T3Jic2lvQlFFMGg4b09YTEU5bEYzU3lkYjBM?=
 =?utf-8?B?bW43djhUZWpjM2JDNkZSOHUzZkp4SmxqSndneFdPcm45cWk5UWdYdGUvWFZH?=
 =?utf-8?B?UkYrMEF6cU9ReC9IbGdwaHp5YVpzK2VtYUhOeW00STR4TFBqZ3VNb3VXVzFI?=
 =?utf-8?B?dFVKSHplam5zcFBuYjFKN1pLVTFLYlhITTNYZkV0RFFxMVlzQk44b2x1d3ZW?=
 =?utf-8?B?QnhJazFaOTIvc25RMjg2WitZNVBDa1dzaEtjQUhIaWYxYkVYMGp1blVGUUdM?=
 =?utf-8?B?NGtBcDkvWVNlYWRsM3ZMMmxBcmkwWHAxSGJqU3JjVVZzc3RwclpZQllXR1lQ?=
 =?utf-8?B?Q0E3WGJGOWZTbENCUlBMay80ZDVmZEFreW50YjNJMWRyZ0NwdXhJM09odjBm?=
 =?utf-8?B?ZHNXL01kSDMvNFhreitXN0hjUFdYQkZFVnRGTjhnODBXVW04WE4zeU1WK0Zi?=
 =?utf-8?B?c1doMFlZcGtvWXRNcHNzb0tKaUR1Q25BejNvOW1yRjBYaHpveG41YjVVaGZm?=
 =?utf-8?B?YjhELzA1cTV3R3MrcCtLejRKdUg1S0NNR3NMZktYOW0yTGhBaTZzQStDVzN0?=
 =?utf-8?B?VU1WNGZHUGJLcXY4NitjKzZjMm03NmkwMVQ0aWduR04vUFg4VHUrUnZTQ1Np?=
 =?utf-8?B?cC9SY1h0b2RsUjAzTWVxOGxXRFEvZ0Vqd1J1bjBCbWlvMTBaS3Q1R01HK0dO?=
 =?utf-8?B?WkdwOXFGT2RmNE5XeUY3c2hsY012T0dkaGl4RE1yNDJ6aVYxYUJTeDk2RSs4?=
 =?utf-8?B?UlV1dWs2S3VyTmtzUWoxSURJL213V09ML3cyZ0U0WmxSTzROSW9INWFxbnE2?=
 =?utf-8?B?ZG4xVUpkalZkczVMM0M1MTRMSG1ZY0tkNkk1dXd0M2hmcEFDdVR1L0pNWlJC?=
 =?utf-8?B?SzBFcXBOUEdpUU53WkdsSW5HbzdvTDMwZkFncVBmay9yY0dISUhrQXdkdG9v?=
 =?utf-8?B?U0x2b3BIcUdKU1Z4OUd0QjNxazMrNUxvRENVUnFlQzJUaTlnTy85dnE0SmI4?=
 =?utf-8?B?SER3L0YxeGtGRTMzWCtVT1pSYVQ2SmVKdkFNYllYSlh1S2swM3lOdjQ3UDc2?=
 =?utf-8?B?YU5YSkNBWW93YkJjY3RyRWVzLzB3RXNlMTV5aGRPMDJIN2MvZUx3QmovTUFB?=
 =?utf-8?B?QXpxbDgvd2JWWTdycmg1NHBuc00zeERHaWhOVVNvRXR1NldYSGcvbVExWlNY?=
 =?utf-8?B?U3JKUUNza21JVFBLNlFHMGkrWmhPUnVmbnhnMU5SaDZUK1hEamQreWExMlJy?=
 =?utf-8?B?MDEvSHpmaUZSSzRXUFVEaldSNVdTbjR5Z0JFMkdqY2VDbzlUV1kyZWY0WkVq?=
 =?utf-8?B?WmVEK00rcGZUejJISy9RZ2FyR2tYVmJxWkJ2QnB2Wk8wM3B5REJVanAvVGRZ?=
 =?utf-8?B?dHVRblBWWndacm1FNWhJeDBTRS83QXMrd0w4NlhsQ2E0SUpKOVpsVVN2c0Ez?=
 =?utf-8?B?YlB4SkxNNzIzc0ZyRkQ3ZTR4d0IwT0pYYkQyWStHVU5xQkZ6aWowdU55S2JU?=
 =?utf-8?B?QUVLSndXNzdOcEFobk9sNFdVZ0tjb2liWXV6Tkk3SFdoZ2xYelY2R0lsQzhW?=
 =?utf-8?B?SkE4VnFITjI4dXVwbDVibisweFhwZGozTjQ4WTVNZ1lxSnR6NFlQYkExcW1V?=
 =?utf-8?Q?BSEZccJJ4T4sV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffb942d7-f6fd-4b7c-1abc-08d90b2fa2d4
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 16:55:47.5052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /8SlncVt3GWax83Ka6YWpUM6+I6J94K6MbpMysuhOsalrFM57jvQzOdhqZgI2VXcSJuxDvppaM/ITsPbyJBN/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2398
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2021-04-29 3:19 a.m., Christian König wrote:
> Am 28.04.21 um 17:11 schrieb Andrey Grodzovsky:
>> Access to those must be prevented post pci_remove
> 
> That is certainly a no-go. We want to get rid of the kernel pointers in 
> BOs, not add another one.
> 
> Christian.

As we discussed internally, will drop the entire explicit BOs unmapping
approach as unmapping the VRAM bar alone will give the same results.

Andrey

> 
>>
>> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  5 +++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 38 ++++++++++++++++++++--
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 28 ++++++++++++++--
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  5 +++
>>   4 files changed, 71 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index 30a24db5f4d1..3e4755fc10c8 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -1056,6 +1056,11 @@ struct amdgpu_device {
>>       struct pci_saved_state          *pci_state;
>>       struct list_head                device_bo_list;
>> +
>> +    /* List of all MMIO BOs */
>> +    struct list_head                mmio_list;
>> +    struct mutex                    mmio_list_lock;
>> +
>>   };
>>   static inline struct amdgpu_device *drm_to_adev(struct drm_device 
>> *ddev)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 22b09c4db255..3ddad6cba62d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -3320,6 +3320,9 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>>       INIT_LIST_HEAD(&adev->shadow_list);
>>       mutex_init(&adev->shadow_list_lock);
>> +    INIT_LIST_HEAD(&adev->mmio_list);
>> +    mutex_init(&adev->mmio_list_lock);
>> +
>>       INIT_DELAYED_WORK(&adev->delayed_init_work,
>>                 amdgpu_device_delayed_init_work_handler);
>>       INIT_DELAYED_WORK(&adev->gfx.gfx_off_delay_work,
>> @@ -3636,6 +3639,36 @@ static void amdgpu_clear_dma_mappings(struct 
>> amdgpu_device *adev)
>>       spin_unlock(&adev->mman.bdev.lru_lock);
>>   }
>> +static void amdgpu_device_unmap_mmio(struct amdgpu_device *adev)
>> +{
>> +    struct amdgpu_bo *bo;
>> +
>> +    /* Clear all CPU mappings pointing to this device */
>> +    unmap_mapping_range(adev->ddev.anon_inode->i_mapping, 0, 0, 1);
>> +
>> +    /* Unmap all MMIO mapped kernel BOs */
>> +    mutex_lock(&adev->mmio_list_lock);
>> +    list_for_each_entry(bo, &adev->mmio_list, mmio_list) {
>> +        amdgpu_bo_kunmap(bo);
>> +        if (*bo->kmap_ptr)
>> +            *bo->kmap_ptr = NULL;
>> +    }
>> +    mutex_unlock(&adev->mmio_list_lock);
>> +
>> +    /* Unmap all mapped bars - Doorbell, registers and VRAM */
>> +    amdgpu_device_doorbell_fini(adev);
>> +
>> +    iounmap(adev->rmmio);
>> +    adev->rmmio = NULL;
>> +    if (adev->mman.aper_base_kaddr)
>> +        iounmap(adev->mman.aper_base_kaddr);
>> +    adev->mman.aper_base_kaddr = NULL;
>> +
>> +    /* Memory manager related */
>> +    arch_phys_wc_del(adev->gmc.vram_mtrr);
>> +    arch_io_free_memtype_wc(adev->gmc.aper_base, adev->gmc.aper_size);
>> +}
>> +
>>   /**
>>    * amdgpu_device_fini - tear down the driver
>>    *
>> @@ -3683,6 +3716,8 @@ void amdgpu_device_fini_hw(struct amdgpu_device 
>> *adev)
>>       amdgpu_clear_dma_mappings(adev);
>>       amdgpu_gart_dummy_page_fini(adev);
>> +
>> +    amdgpu_device_unmap_mmio(adev);
>>   }
>>   void amdgpu_device_fini_sw(struct amdgpu_device *adev)
>> @@ -3713,9 +3748,6 @@ void amdgpu_device_fini_sw(struct amdgpu_device 
>> *adev)
>>       if (adev->rio_mem)
>>           pci_iounmap(adev->pdev, adev->rio_mem);
>>       adev->rio_mem = NULL;
>> -    iounmap(adev->rmmio);
>> -    adev->rmmio = NULL;
>> -    amdgpu_device_doorbell_fini(adev);
>>       if (IS_ENABLED(CONFIG_PERF_EVENTS))
>>           amdgpu_pmu_fini(adev);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> index 62d829f5e62c..9b05e3b96fa0 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> @@ -531,6 +531,9 @@ static int amdgpu_bo_do_create(struct 
>> amdgpu_device *adev,
>>           return -ENOMEM;
>>       drm_gem_private_object_init(adev_to_drm(adev), &bo->tbo.base, 
>> size);
>>       INIT_LIST_HEAD(&bo->shadow_list);
>> +
>> +    INIT_LIST_HEAD(&bo->mmio_list);
>> +
>>       bo->vm_bo = NULL;
>>       bo->preferred_domains = bp->preferred_domain ? 
>> bp->preferred_domain :
>>           bp->domain;
>> @@ -774,9 +777,21 @@ int amdgpu_bo_kmap(struct amdgpu_bo *bo, void **ptr)
>>       if (r)
>>           return r;
>> -    if (ptr)
>> +    if (bo->kmap.bo_kmap_type == ttm_bo_map_iomap) {
>> +        struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
>> +
>> +        mutex_lock(&adev->mmio_list_lock);
>> +        list_add_tail(&bo->mmio_list, &adev->mmio_list);
>> +        mutex_unlock(&adev->mmio_list_lock);
>> +    }
>> +
>> +    if (ptr) {
>>           *ptr = amdgpu_bo_kptr(bo);
>> +        if (bo->kmap.bo_kmap_type == ttm_bo_map_iomap)
>> +            bo->kmap_ptr = ptr;
>> +    }
>> +
>>       return 0;
>>   }
>> @@ -804,8 +819,17 @@ void *amdgpu_bo_kptr(struct amdgpu_bo *bo)
>>    */
>>   void amdgpu_bo_kunmap(struct amdgpu_bo *bo)
>>   {
>> -    if (bo->kmap.bo)
>> +    struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
>> +
>> +    if (bo->kmap.bo) {
>> +        if (bo->kmap.bo_kmap_type == ttm_bo_map_iomap) {
>> +            mutex_lock(&adev->mmio_list_lock);
>> +            list_del_init(&bo->mmio_list);
>> +            mutex_unlock(&adev->mmio_list_lock);
>> +        }
>> +
>>           ttm_bo_kunmap(&bo->kmap);
>> +    }
>>   }
>>   /**
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>> index 5ae8555ef275..3129d9bbfa22 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>> @@ -112,6 +112,11 @@ struct amdgpu_bo {
>>       struct kgd_mem                  *kfd_bo;
>>       struct list_head        bo;
>> +
>> +    struct list_head                mmio_list;
>> +    /* Address of kernel VA pointer to MMIO so they can be updated 
>> post remap */
>> +    void                **kmap_ptr;
>> +
>>   };
>>   static inline struct amdgpu_bo *ttm_to_amdgpu_bo(struct 
>> ttm_buffer_object *tbo)
> 
