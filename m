Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51625373CFD
	for <lists+linux-pci@lfdr.de>; Wed,  5 May 2021 16:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233505AbhEEOGJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 May 2021 10:06:09 -0400
Received: from mail-bn8nam12on2086.outbound.protection.outlook.com ([40.107.237.86]:18354
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232569AbhEEOGH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 May 2021 10:06:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KcuDH5/4RnrWYbcKK6cqev8+iRpivy5X0SZGpDsLX2kHmcLSt7D02jh6eIS1eMwLUa7UnjtsP8PtKnAI4Y9BOiN3AGLjcA/LhNPbydpRcX8rk4K7T266wPYFyjPK8t2XO1TcVq36EfHN3TxyTTqKI1Nu/S8Awm6BTy5ZUv7Iaxe/z75VSQDFD1WB1bewog75F6oBcZxAssTTqfWuObQAuKzKc5DTxU/P+5Wyz1sirsJze8Zd49Qym4iYLAgsS4Dm+29+AINtoZU+abUyVlw4JAO/dwRGw/JpuupbR5kr8jzqHT6wkolq/M2HO4KCTE1LkWDktkdk3m5sunIzIowh6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VCXg4kCCyP+Z5BeZLBskgjprVRWyqJWBPRABEv+FyLA=;
 b=MwOmnMThsl479eQ9ZgCxapB7zwYXA7Uf2sMSHY2ZfqvCsgwYM0GGOcs2hoahDNWE8QxOM379jNaJ3jKtN9XOjY7nDNNyPwInAnAW56Bn1viN5x4ojThNF543iNuwLPICYAyZKj+GhdrOrH2w/23tJSdWkEwMx/Kd7m8++tL9zCud/J/9fgiJufjVmhaWRj5J+atXqmb667aFaJYpCQb7unJ5/w4rEGpX9ribXL/7qoKeb2hXj49eFv53RKgkaZg98tftJTwlOY3lWQy9jgSUILRHrkIRpUYPQE+Chk2E/LlYHRMB9lElrixX+7PmhpK2emMIQEGbWH6FaEZqzH7ZQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VCXg4kCCyP+Z5BeZLBskgjprVRWyqJWBPRABEv+FyLA=;
 b=ajmErjcrvoaitWIqmItIwoht471c+0ZA/eoWTb3rpRhrZQFUjhYAjJSTsBdlJ1BANzj1b52epQE55Il62yup+jEMPSaYPEZOfjzfOaQvZrH/7UcI4xB2xctMSiuAC9SUNOk9+brM9yKbX5BsBWrBc/C6kkHECyiZU+CbK+3QKZU=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SN6PR12MB2814.namprd12.prod.outlook.com (2603:10b6:805:72::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Wed, 5 May
 2021 14:05:08 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::ad51:8c49:b171:856c]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::ad51:8c49:b171:856c%7]) with mapi id 15.20.4108.026; Wed, 5 May 2021
 14:05:08 +0000
Subject: Re: [PATCH v5 06/27] drm/amdgpu: Handle IOMMU enabled case.
To:     Felix Kuehling <felix.kuehling@amd.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-pci@vger.kernel.org, ckoenig.leichtzumerken@gmail.com,
        daniel.vetter@ffwll.ch, Harry.Wentland@amd.com
Cc:     ppaalanen@gmail.com, Alexander.Deucher@amd.com,
        gregkh@linuxfoundation.org, helgaas@kernel.org
References: <20210428151207.1212258-1-andrey.grodzovsky@amd.com>
 <20210428151207.1212258-7-andrey.grodzovsky@amd.com>
 <4f752f79-2541-d62d-5279-17992e4161d7@amd.com>
From:   Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <8810235e-7394-5c6c-b074-fe97bc2fb044@amd.com>
Date:   Wed, 5 May 2021 10:05:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <4f752f79-2541-d62d-5279-17992e4161d7@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2607:fea8:3edf:49b0:7d63:ab2e:d405:e927]
X-ClientProxiedBy: YT1PR01CA0155.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::34) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:7d63:ab2e:d405:e927] (2607:fea8:3edf:49b0:7d63:ab2e:d405:e927) by YT1PR01CA0155.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.38 via Frontend Transport; Wed, 5 May 2021 14:05:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d79d950-2229-40e0-8be1-08d90fceca32
X-MS-TrafficTypeDiagnostic: SN6PR12MB2814:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2814EE44EB08ACFC34FE6DECEA599@SN6PR12MB2814.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BJ3hSdpBBs0R40m4u1r5IBv5M7PUIUa17rk83FE0lsq1c3EPoA+3W+wo6SnBBrh6Xj5lwq5TVxKomdEJocfzUn0AG0Am1uFLUrcA+mmccy8/s7VAU7kAEGvBq0eZAv+FhArTOnTYtDXJdkgOjuFaAsKH98wc4kwRW3eWwAbk7dylfehqksGRv5iOKLeReA4pqxMMziSKzdGEH7rkwx3Sn9U0VDAcILW1ft9hlJYylXCtxP+IoMchwsvjktyb1utcrtlcwN1Ml3Zs1iA6d2StqPX1WU2p7rbaCguQ0cs2xGyXmYAqWvKyRIdsQDHkGuuTFrSFwyB/uzHwYHqHoDHFdcZetGou8ZcCC8A7g+FYsmDjEtgeJs7qBrq/r3t+IVPQYT8LqFTwqA8xS1xpawc0CQ10XLcbYGGXREWjtZYdXoI/cZZjvfcPWsNKDPW5uwxuLGksCOSsgXCDU3ee6joHm/h21OFbG0O3XYdKA5hT/zr/OQYQsuLsw1ovkE0hMxcPIt/nexnyAYNoU+MCVBUFTLsvMcdUD1l+brX41DlCSlicscx6S0TPLqfrzwXTjuFA7nxnuCSlm5AUo9x4yt/7KPC5rarrj+HA8QHvN7IZxYy0L0dJvw73xsVK5ys0LWqdDSvUdZdKyD8HLnfkb/yQDLZpOGE4VGeBLV7jpF4kwIUz5OLOmCL33YeLbK9VuZxU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB4623.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(136003)(396003)(376002)(366004)(52116002)(38100700002)(44832011)(478600001)(316002)(36756003)(4326008)(2906002)(186003)(53546011)(6636002)(86362001)(66556008)(31696002)(66946007)(66476007)(31686004)(30864003)(8676002)(8936002)(2616005)(16526019)(6486002)(5660300002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?c251dFdrWG5SNEN2L2lPNXFNVXptSVlxcVY1d1dRZUlQa3NBSWExUm1RYVpT?=
 =?utf-8?B?M3BZdEZyWUtMSExQMThnRG1TTWlxMnlmeGx1UU90N3ljU1YzdmVLWHpCR1FQ?=
 =?utf-8?B?eWU1VldEK0RzUWdMOFdOdTVTcGdXSTVEQ2FHbnNDVUsxbVpiN1R3NGlLYkho?=
 =?utf-8?B?YU5hNHg1ZURLV3RpVVVnUnhNUjZxRWF4VXZxOHAxVG5wWXkxQ01lVzFWcVpZ?=
 =?utf-8?B?VUdLWHhzQTN3b0FMakV6QzZ0cUJVZzBJODJVcXZXRHFPUmE0Y1QrZENycVg3?=
 =?utf-8?B?WWpNN0tqdWRicm1kV0xjV1ByRXYrR2Y0WWE4T3JSMUxGUHhqMXc2aW83MXhT?=
 =?utf-8?B?N1BVbXJKd1U4NFNnaTBqZkZPUndxdE5nR0tpVGhlQS9ySC9hVVZOZFFlbURV?=
 =?utf-8?B?eElFY0ZTaEIyRjduSjR2M3JsM0xOcGFsbDN0d2RJVjh1cHVKWVN4UW9odldh?=
 =?utf-8?B?Nm1pRmNFV0dkcEpkdVJIYVhJMVpaVERtRVFXMDY5YlBNZGtYc1E5MlAyNFNY?=
 =?utf-8?B?dEFjVXJIUnJISnFlTzdsS0RHeG5NOElLS0J3OENiNkZtL0QyRDE5RURKWXV5?=
 =?utf-8?B?YWJ0OVVIUFZZWEVNQzdQcTFzWi9mV0p6TldiZFdOS3FsOE9kZGJ1RU1NNWVl?=
 =?utf-8?B?MVNmaW1naWpHU29XYVdadmk0bFBSdVRxeW1SblcvcTM4ekFJNytwc1RrU3dZ?=
 =?utf-8?B?K2RmODlrVjRMUTRPcFdGVytPS0NzYlhOVHBVcDUybkxIdkFCd21UZnRsMVlo?=
 =?utf-8?B?TWhKTHFCQW5GYVNENXJYQWtCeTBkWFIzZmJxOStPdSt5cFR2dVV6S29rSEZ0?=
 =?utf-8?B?MEdLcDR3ckcrMW1iaVREWlArQWZNVnd4OVdCYXl5RzRaMWpxZ3JST1Vya2N5?=
 =?utf-8?B?Y2JJR1Z1bk9TdTc1NzEzWG45VWFIYU5aZmZxaDZxRDdEVkRmakFIaXg1NUs1?=
 =?utf-8?B?V0FDeUNmMXRHUUtkanpzZXh3aGczM01xNkRrY3dUZGpMRjN0NGljcUVYenFF?=
 =?utf-8?B?dWNUb2gyU1RRczFwZEdHeExzUTNTazdrT1ZGbVlaQU16OVU0aCtPV1FqTk1z?=
 =?utf-8?B?Zno3TmJuQ2d1RTN3S01uZmxYWDNqbGxHVjdRbUxOQzRIQkt4WE12MHBBRGZq?=
 =?utf-8?B?VEtqVm12NlJ5ckFWVEhldlRrclpndFhzVzduUkg0Q3NTUDZYY2djOFN0UTlP?=
 =?utf-8?B?VG5xenBLR3RMTlFNaXlabzUrZEo3Z1F2VVV6a1N4UmFOeEdYRkxsZnJrejZ6?=
 =?utf-8?B?NmJPRVRwZkh4SHhRK1Nmb2c0eFhuWWJsOVljUU5BZm5ndGY1NGFJYitKK3dU?=
 =?utf-8?B?amdvdDJ2T3dKTVY4WDcwaW5qa2l6aU13a09ucExIKzIyUngrWWhvUlUwTzJX?=
 =?utf-8?B?WVpKWjRJUTdDaWdkazc3c2dRb3F2VmR1RHhYc2RiTkxZLytvaGZYVEgzUG5X?=
 =?utf-8?B?dVEvNHk0UTFLeUUwNUtJVHhNclQrU3FZM2ltQ3FVQTVGTGhRMGhReUhCUFFu?=
 =?utf-8?B?amhTaUZVVVo1ZGpyUW9tTGNoeXpRU1BDQUVqcHNhUVBVNXdzQjF4amE3d2lV?=
 =?utf-8?B?KzF4akRZMStnT2VOZENEczh2OFJjaWxZdWwvUW9taElRaVBTMHNWRWFzRXoy?=
 =?utf-8?B?aktQb3F6UGtwOTRNLzVXY28yNkxkNnBTbHdydTg0YnN3SHBnQ0JhWDMwYlpZ?=
 =?utf-8?B?UXZXSkR5RC8yUzVldzU2eWkvS0F6SUs5dGZ5YVlvM1hNajdPN2hkNmpYcEla?=
 =?utf-8?B?ZzJMZmx6bzBmV3VQUDhmenVHb3hvSnJGNG9IUE1xalgwYmVUek0rQlJBQkI5?=
 =?utf-8?B?SjlIY1ZKZXVRTkFZb0Fudm1MLzkyRExtcjFiY3dzSlpNYkRWWEIxTG5NMU01?=
 =?utf-8?Q?0q1oP6ikAxitg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d79d950-2229-40e0-8be1-08d90fceca32
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2021 14:05:08.2164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bXFxqXLmKqz7rA8Hm3jyqg9N3DwCE9g4hW0csKCIwbCdX8qfDAU83Se9qb2JdYsNX8RdIyUQwNr+3fertn4ZPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2814
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2021-05-04 1:05 p.m., Felix Kuehling wrote:
> 
> Am 2021-04-28 um 11:11 a.m. schrieb Andrey Grodzovsky:
>> Handle all DMA IOMMU gropup related dependencies before the
>> group is removed.
>>
>> v5: Drop IOMMU notifier and switch to lockless call to ttm_tt_unpopulate
>>
>> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 ++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 31 ++++++++++++++++++++--
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c   |  3 +--
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h   |  1 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c    |  9 +++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 13 ++++++++-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  2 ++
>>   drivers/gpu/drm/amd/amdgpu/cik_ih.c        |  1 -
>>   drivers/gpu/drm/amd/amdgpu/cz_ih.c         |  1 -
>>   drivers/gpu/drm/amd/amdgpu/iceland_ih.c    |  1 -
>>   drivers/gpu/drm/amd/amdgpu/navi10_ih.c     |  3 ---
>>   drivers/gpu/drm/amd/amdgpu/si_ih.c         |  1 -
>>   drivers/gpu/drm/amd/amdgpu/tonga_ih.c      |  1 -
>>   drivers/gpu/drm/amd/amdgpu/vega10_ih.c     |  3 ---
>>   14 files changed, 56 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index fddb82897e5d..30a24db5f4d1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -1054,6 +1054,8 @@ struct amdgpu_device {
>>   
>>   	bool                            in_pci_err_recovery;
>>   	struct pci_saved_state          *pci_state;
>> +
>> +	struct list_head                device_bo_list;
>>   };
>>   
>>   static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 46d646c40338..91594ddc2459 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -70,6 +70,7 @@
>>   #include <drm/task_barrier.h>
>>   #include <linux/pm_runtime.h>
>>   
>> +
>>   MODULE_FIRMWARE("amdgpu/vega10_gpu_info.bin");
>>   MODULE_FIRMWARE("amdgpu/vega12_gpu_info.bin");
>>   MODULE_FIRMWARE("amdgpu/raven_gpu_info.bin");
>> @@ -3211,7 +3212,6 @@ static const struct attribute *amdgpu_dev_attributes[] = {
>>   	NULL
>>   };
>>   
>> -
>>   /**
>>    * amdgpu_device_init - initialize the driver
>>    *
>> @@ -3316,6 +3316,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>>   
>>   	INIT_WORK(&adev->xgmi_reset_work, amdgpu_device_xgmi_reset_func);
>>   
>> +	INIT_LIST_HEAD(&adev->device_bo_list);
>> +
>>   	adev->gfx.gfx_off_req_count = 1;
>>   	adev->pm.ac_power = power_supply_is_system_supplied() > 0;
>>   
>> @@ -3601,6 +3603,28 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>>   	return r;
>>   }
>>   
>> +static void amdgpu_clear_dma_mappings(struct amdgpu_device *adev)
>> +{
>> +	struct amdgpu_bo *bo = NULL;
>> +
>> +	/*
>> +	 * Unmaps all DMA mappings before device will be removed from it's
>> +	 * IOMMU group otherwise in case of IOMMU enabled system a crash
>> +	 * will happen.
>> +	 */
>> +
>> +	spin_lock(&adev->mman.bdev.lru_lock);
>> +	while (!list_empty(&adev->device_bo_list)) {
>> +		bo = list_first_entry(&adev->device_bo_list, struct amdgpu_bo, bo);
>> +		list_del_init(&bo->bo);
>> +		spin_unlock(&adev->mman.bdev.lru_lock);
>> +		if (bo->tbo.ttm)
>> +			ttm_tt_unpopulate(bo->tbo.bdev, bo->tbo.ttm);
> 
> I have a patch pending (reviewed by Christian) that moves the
> dma-unmapping to amdgpu_ttm_backend_unbind. With that patch,
> ttm_tt_unpopulate would no longer be the right way to remove the DMA
> mapping.
> 
> Maybe I'd need to add a check in ttm_tt_unpopulate to call
> backend_unbind first, if necessary. Or is there some other mechanism
> that moves the BO to the CPU domain before unpopulating it?
> 
> Regards,
>    Felix

At least in the context of this patch we don't move the BO to system
domain but rather preemptively remove DMA mappings before IOMMU grpoup
is gone post pci_remove. So yes, I would say yes, we need to check here
for backend_unbind first.

Andrey

> 
> 
>> +		spin_lock(&adev->mman.bdev.lru_lock);
>> +	}
>> +	spin_unlock(&adev->mman.bdev.lru_lock);
>> +}
>> +
>>   /**
>>    * amdgpu_device_fini - tear down the driver
>>    *
>> @@ -3639,12 +3663,15 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
>>   		amdgpu_ucode_sysfs_fini(adev);
>>   	sysfs_remove_files(&adev->dev->kobj, amdgpu_dev_attributes);
>>   
>> -
>>   	amdgpu_fbdev_fini(adev);
>>   
>>   	amdgpu_irq_fini_hw(adev);
>>   
>>   	amdgpu_device_ip_fini_early(adev);
>> +
>> +	amdgpu_clear_dma_mappings(adev);
>> +
>> +	amdgpu_gart_dummy_page_fini(adev);
>>   }
>>   
>>   void amdgpu_device_fini_sw(struct amdgpu_device *adev)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
>> index fde2d899b2c4..49cdcaf8512d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
>> @@ -92,7 +92,7 @@ static int amdgpu_gart_dummy_page_init(struct amdgpu_device *adev)
>>    *
>>    * Frees the dummy page used by the driver (all asics).
>>    */
>> -static void amdgpu_gart_dummy_page_fini(struct amdgpu_device *adev)
>> +void amdgpu_gart_dummy_page_fini(struct amdgpu_device *adev)
>>   {
>>   	if (!adev->dummy_page_addr)
>>   		return;
>> @@ -397,5 +397,4 @@ void amdgpu_gart_fini(struct amdgpu_device *adev)
>>   	vfree(adev->gart.pages);
>>   	adev->gart.pages = NULL;
>>   #endif
>> -	amdgpu_gart_dummy_page_fini(adev);
>>   }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
>> index afa2e2877d87..5678d9c105ab 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
>> @@ -61,6 +61,7 @@ int amdgpu_gart_table_vram_pin(struct amdgpu_device *adev);
>>   void amdgpu_gart_table_vram_unpin(struct amdgpu_device *adev);
>>   int amdgpu_gart_init(struct amdgpu_device *adev);
>>   void amdgpu_gart_fini(struct amdgpu_device *adev);
>> +void amdgpu_gart_dummy_page_fini(struct amdgpu_device *adev);
>>   int amdgpu_gart_unbind(struct amdgpu_device *adev, uint64_t offset,
>>   		       int pages);
>>   int amdgpu_gart_map(struct amdgpu_device *adev, uint64_t offset,
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>> index 63e815c27585..a922154953a7 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>> @@ -326,6 +326,15 @@ void amdgpu_irq_fini_hw(struct amdgpu_device *adev)
>>   		if (!amdgpu_device_has_dc_support(adev))
>>   			flush_work(&adev->hotplug_work);
>>   	}
>> +
>> +	if (adev->irq.ih_soft.ring)
>> +		amdgpu_ih_ring_fini(adev, &adev->irq.ih_soft);
>> +	if (adev->irq.ih.ring)
>> +		amdgpu_ih_ring_fini(adev, &adev->irq.ih);
>> +	if (adev->irq.ih1.ring)
>> +		amdgpu_ih_ring_fini(adev, &adev->irq.ih1);
>> +	if (adev->irq.ih2.ring)
>> +		amdgpu_ih_ring_fini(adev, &adev->irq.ih2);
>>   }
>>   
>>   /**
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> index 485f249d063a..62d829f5e62c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> @@ -68,8 +68,13 @@ static void amdgpu_bo_destroy(struct ttm_buffer_object *tbo)
>>   		list_del_init(&bo->shadow_list);
>>   		mutex_unlock(&adev->shadow_list_lock);
>>   	}
>> -	amdgpu_bo_unref(&bo->parent);
>>   
>> +
>> +	spin_lock(&adev->mman.bdev.lru_lock);
>> +	list_del(&bo->bo);
>> +	spin_unlock(&adev->mman.bdev.lru_lock);
>> +
>> +	amdgpu_bo_unref(&bo->parent);
>>   	kfree(bo->metadata);
>>   	kfree(bo);
>>   }
>> @@ -585,6 +590,12 @@ static int amdgpu_bo_do_create(struct amdgpu_device *adev,
>>   	if (bp->type == ttm_bo_type_device)
>>   		bo->flags &= ~AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
>>   
>> +	INIT_LIST_HEAD(&bo->bo);
>> +
>> +	spin_lock(&adev->mman.bdev.lru_lock);
>> +	list_add_tail(&bo->bo, &adev->device_bo_list);
>> +	spin_unlock(&adev->mman.bdev.lru_lock);
>> +
>>   	return 0;
>>   
>>   fail_unreserve:
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>> index 9ac37569823f..5ae8555ef275 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>> @@ -110,6 +110,8 @@ struct amdgpu_bo {
>>   	struct list_head		shadow_list;
>>   
>>   	struct kgd_mem                  *kfd_bo;
>> +
>> +	struct list_head		bo;
>>   };
>>   
>>   static inline struct amdgpu_bo *ttm_to_amdgpu_bo(struct ttm_buffer_object *tbo)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/cik_ih.c b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
>> index 183d44a6583c..df385ffc9768 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/cik_ih.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
>> @@ -310,7 +310,6 @@ static int cik_ih_sw_fini(void *handle)
>>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>   
>>   	amdgpu_irq_fini_sw(adev);
>> -	amdgpu_ih_ring_fini(adev, &adev->irq.ih);
>>   	amdgpu_irq_remove_domain(adev);
>>   
>>   	return 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/cz_ih.c b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
>> index d32743949003..b8c47e0cf37a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/cz_ih.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
>> @@ -302,7 +302,6 @@ static int cz_ih_sw_fini(void *handle)
>>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>   
>>   	amdgpu_irq_fini_sw(adev);
>> -	amdgpu_ih_ring_fini(adev, &adev->irq.ih);
>>   	amdgpu_irq_remove_domain(adev);
>>   
>>   	return 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
>> index da96c6013477..ddfe4eaeea05 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
>> @@ -301,7 +301,6 @@ static int iceland_ih_sw_fini(void *handle)
>>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>   
>>   	amdgpu_irq_fini_sw(adev);
>> -	amdgpu_ih_ring_fini(adev, &adev->irq.ih);
>>   	amdgpu_irq_remove_domain(adev);
>>   
>>   	return 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
>> index 5eea4550b856..e171a9e78544 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
>> @@ -571,9 +571,6 @@ static int navi10_ih_sw_fini(void *handle)
>>   
>>   	amdgpu_irq_fini_sw(adev);
>>   	amdgpu_ih_ring_fini(adev, &adev->irq.ih_soft);
>> -	amdgpu_ih_ring_fini(adev, &adev->irq.ih2);
>> -	amdgpu_ih_ring_fini(adev, &adev->irq.ih1);
>> -	amdgpu_ih_ring_fini(adev, &adev->irq.ih);
>>   
>>   	return 0;
>>   }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/si_ih.c b/drivers/gpu/drm/amd/amdgpu/si_ih.c
>> index 751307f3252c..9a24f17a5750 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/si_ih.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/si_ih.c
>> @@ -176,7 +176,6 @@ static int si_ih_sw_fini(void *handle)
>>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>   
>>   	amdgpu_irq_fini_sw(adev);
>> -	amdgpu_ih_ring_fini(adev, &adev->irq.ih);
>>   
>>   	return 0;
>>   }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
>> index 973d80ec7f6c..b08905d1c00f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
>> @@ -313,7 +313,6 @@ static int tonga_ih_sw_fini(void *handle)
>>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>   
>>   	amdgpu_irq_fini_sw(adev);
>> -	amdgpu_ih_ring_fini(adev, &adev->irq.ih);
>>   	amdgpu_irq_remove_domain(adev);
>>   
>>   	return 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
>> index 2d0094c276ca..8c8abc00f710 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
>> @@ -525,9 +525,6 @@ static int vega10_ih_sw_fini(void *handle)
>>   
>>   	amdgpu_irq_fini_sw(adev);
>>   	amdgpu_ih_ring_fini(adev, &adev->irq.ih_soft);
>> -	amdgpu_ih_ring_fini(adev, &adev->irq.ih2);
>> -	amdgpu_ih_ring_fini(adev, &adev->irq.ih1);
>> -	amdgpu_ih_ring_fini(adev, &adev->irq.ih);
>>   
>>   	return 0;
>>   }
