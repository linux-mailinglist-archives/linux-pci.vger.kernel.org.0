Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 469783721C4
	for <lists+linux-pci@lfdr.de>; Mon,  3 May 2021 22:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbhECUoe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 May 2021 16:44:34 -0400
Received: from mail-dm6nam10on2078.outbound.protection.outlook.com ([40.107.93.78]:1513
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229764AbhECUoa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 3 May 2021 16:44:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D3ETmDrUeUWPAJt43UgHA09p3FI7Jg/+31Fe2mCMGmk4VLgaSA7EgVBClebejcExOvDvYa3F2RrZCSWh+i3+gFBvDHEGn32d2P3+hx8J8N/YcWpXx4c9OaoaY7kzlrBA3fWy70I5+uI8mseHOTskyuRPfJhdz8Bz5knQklK4taL29CWmdpRizky2su7SEyzZuGfjPZVVxvPRlYHqi8CSswAclAN/c5UVqF7/sV3l8FKtvapRF0AfsTxxnY0di098rtasSK43SzMKHKD6OUGyV7CVELk1Bzf6L2vOkYBys3euFshjlnSdPBNGlTppeSMFgFFUVcpT/LElIVB7xDBx6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GtEgmuQSVTQCmOJTIJ/H4VIgPfSyYK5pM/RLLfiV1FY=;
 b=WDgOrdv9plqhabQRfVbGcksbRL0JDSihqZABWUt2Z+x1MG5AzeJjJiXgreJxVcmqcgulIfk6biAOXjLZmUImrn21iz4YoLfMhziPQVLzcPAHujNC46apnvbm/tRt2YIpH4o+A5eK2SpYxW3w3Pn4waTVFRr7sufGG2PEcKT2vfWjQ1xd8wBS2YSt+UMvYhJp8tH8eT2S2b+djRdQdedYSHpjOPMmGdZnQcLbmi9ZB2rFB62v+uVULTiS/qDzAkcYNnDevu2W48xVzCY4UUFVPTpRKx9LENbjzcjlc3q9uc48qrN5tjkKRv6OHDqLQHoIBDNEpymajkGREDR06UCTpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GtEgmuQSVTQCmOJTIJ/H4VIgPfSyYK5pM/RLLfiV1FY=;
 b=YWBm19DNk0uZmXyL1DGt8J1nI8IrY6ZT6yUaeO8L05l2GgPWQt7SmuXe4xxUxpiVv0/BAeX5I7TRp2ESPexr7sg0Ci8Wd1eySithf83LHPvSr83G7kfJLKLPbW5CMVYkq9MhF0+N9DVJnc3FneSdpBIe3crPZZUNV4l6Cg/BcPs=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SA0PR12MB4368.namprd12.prod.outlook.com (2603:10b6:806:9f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25; Mon, 3 May
 2021 20:43:33 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::ad51:8c49:b171:856c]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::ad51:8c49:b171:856c%7]) with mapi id 15.20.4087.043; Mon, 3 May 2021
 20:43:33 +0000
Subject: Re: [PATCH v5 06/27] drm/amdgpu: Handle IOMMU enabled case.
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-pci@vger.kernel.org, daniel.vetter@ffwll.ch,
        Harry.Wentland@amd.com
Cc:     ppaalanen@gmail.com, Alexander.Deucher@amd.com,
        gregkh@linuxfoundation.org, helgaas@kernel.org,
        Felix.Kuehling@amd.com
References: <20210428151207.1212258-1-andrey.grodzovsky@amd.com>
 <20210428151207.1212258-7-andrey.grodzovsky@amd.com>
 <8ba9edd8-9d6d-b6c3-342c-3f137d0cacd0@gmail.com>
From:   Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <df2bfa14-917b-939b-8ec1-f1e787313868@amd.com>
Date:   Mon, 3 May 2021 16:43:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <8ba9edd8-9d6d-b6c3-342c-3f137d0cacd0@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2607:fea8:3edf:49b0:8db:36bc:53f4:eb99]
X-ClientProxiedBy: YTOPR0101CA0034.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::47) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:8db:36bc:53f4:eb99] (2607:fea8:3edf:49b0:8db:36bc:53f4:eb99) by YTOPR0101CA0034.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.39 via Frontend Transport; Mon, 3 May 2021 20:43:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39ce1502-ee3a-4199-e61f-08d90e741e10
X-MS-TrafficTypeDiagnostic: SA0PR12MB4368:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB43688A58005FFE36A4C8460FEA5B9@SA0PR12MB4368.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3AvUXj5Gez6R+AXDS9jSl35/n9ZKsv6XEsIhGBtorcP2dmvNFmvMzOBTGENCy2yM6VBOiojdFdBCavV+CbGiBrhzw1yQj1SRPovglL/w/rOxXR/QaDFDOjG2NBWS4zLvSoJ6Dn3Ny7P3XJhiNpPPluYLcbljkpEU4kESh2mFlRhuTOgDw8NNI2vanXYr+xkxhEsfPsK9K65fcDm9wlWB2xzDPhJ7bdgS9gb4L/6gsnZrVq2j6X4ms6MgDzYJoOhVrh9nkW73WsAeNcVDR4FlmPBEzhEVd1+uA+n018L7HK12tvUfjrgRHqZxSWthCRZqSS2JAyrcfJ7+0warOdBi3boVEOCmlyxSLAUNbTEPYQEgPcRENsoQHF7QvpQrcE+F9S63FuhA25o3iWnJJHlWUZnhHHOl+UAjNJOPYw0UEqQ4bl9WK74TRXseLDIXu+/z89PORmFH7dZC1XpjlUYYd8jcJSrHk4x1RTQ7OCyTF0SDEVZ0ASmorfNwm6n9vgDDZiSth/JgCCWKVUQCD1ERlaGj+qK/XTXg7v6rycNSagNSzh8phPoXLG/Udo03sjlZH1jHb8it9qs9g8TljzHW33fnQyBGCdVF3CsWWsEvd2mDJGxZwRZJPanLRwwiwthdtYl2lm8mmvxSloMV9JsDV/szwEl6sANMAlyP2mjr4CXbkgokeO4tljCApSmOHZEM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB4623.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(136003)(376002)(396003)(39860400002)(38100700002)(53546011)(316002)(31686004)(52116002)(8936002)(66556008)(83380400001)(6486002)(66574015)(66476007)(2906002)(2616005)(4326008)(478600001)(186003)(16526019)(36756003)(31696002)(86362001)(8676002)(6636002)(5660300002)(30864003)(66946007)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?eElPYithYllZMXVheGxsaWpNKy93b05QYmU1QWVBN0UvUEh2MlR4T2lGTFVp?=
 =?utf-8?B?Y3BJTGZIU25KRlkrZkZIVXR5SGpVVDMyU1IxR0dDRFE4cG9EdkI5YTJiMTNy?=
 =?utf-8?B?UDRhME90RFhoSU02Z2prV1JvR0dyalVwdGdndXJRUTVTTk41VjdvWnJOWjEv?=
 =?utf-8?B?U1VjQkhxZVcrWUU4YkxjRWRUbDAzNUZ4bWVsMUdYdFNsTlFZd2hGQkg3Nk1P?=
 =?utf-8?B?U0E3SEFaUkhFTVg2WmtUTlJ6bExHV1dlandwUU9yLzdsWCtwSUcvN00wbi9l?=
 =?utf-8?B?RzNyb3JCOVV4SXM1WGw0Uk1EWWpLNWxTZ0NnMDMxVjRaZGFWVXkrUE1SWVQy?=
 =?utf-8?B?bnp6NEpIRUUvMmlTcTQ3WEx5bVpvcUltVlJFd3JQNGJydG9tZE1lOUNMeC9s?=
 =?utf-8?B?M3R3WjR2c2hIN2JsZnF4M3dQbjNnd1ZDTWFadXhzcWhpVnBmNStKc256VnNP?=
 =?utf-8?B?UlErcmVPbWk3dzcrSG9UNHdzR2RJQk5sdnJ0VkJUWmduSWNQa1grN3p6ZG5x?=
 =?utf-8?B?QlErSkhqZCs0TW1NUHVLUG16YTR3WE5rcm9BM3VWdXFnM0t1YmtDRXM2SnNH?=
 =?utf-8?B?STF0YXpzSG1kZ0Y2UWs1dCtoZHRkNE5jdUMxRkwvUFRTS1Z0TGtsSlA1NHRw?=
 =?utf-8?B?YkQrQTdNVW0zWlV6QUpua0lUZHNPME04ZGF6K0ExeXZyK1ZMT1NzMjVFOHJ3?=
 =?utf-8?B?Ri9OTE5iWW1iYUp4ZGdGdnFUTVhpSEhORHJpcU1EeGtRNndZTlEwV0kxcHlB?=
 =?utf-8?B?RlpoWDBsbVZDenVzWDRKUGhPcVhueExwQysyQjFVYVZ4clREckpENWJYNUY0?=
 =?utf-8?B?eEp0eUE4ZWdTVWk5RnhiTnJMSHBUSUUwL2VTZno3V3V2djNlaWdwM3I5VmlM?=
 =?utf-8?B?THEwZmM3Q0ZPWWt0WkhJdldhb0tISlRVdFVTZDNLM1FNWnl0ZFhvSGtIbnpx?=
 =?utf-8?B?VGV2M1NySEpGZEF4OXdSQ0JBVWphZ2RsNkRlU0hUVkM5VytUZzRYTUlBYTlH?=
 =?utf-8?B?Ym1xY256TVczenJoTU5BaUE4dkJtTDd3R29meTk5L0pScXRWVm1CR1llNy9G?=
 =?utf-8?B?TjRQY0o3cTFRZ3FENWJtMSs5N3pZRGtvMldHdUFqRmwzZ2lkaWlzNVFQcmYw?=
 =?utf-8?B?c3RsTlQ4TFI1Y0lNMHdpVW5xRTlHQTM2a01hK2lhUm9SUDRWWE5USHlucmFB?=
 =?utf-8?B?UTdHcFFSeXA4emJvZVNuU1JPekN1NDNNdDhTRzQ3dkttc1YvTWtkRHhtMHRt?=
 =?utf-8?B?MkpMaTc1VDlmN0JmSkhkUzkzeGIxMk00V2svSHRickdOR0FtSTlhVUFzaDhS?=
 =?utf-8?B?UUJQMWNsa0VJZkF5VmxyaHpKbmhWNC9DcThqZHMxdWZLS0x3UEZDVUNiSmlQ?=
 =?utf-8?B?V1ZnaTlGRlhzOXRRSXlTa2RnMnBQTzZ1T2U2OHk3Z1JUaEd6eS8vZktCVTc3?=
 =?utf-8?B?Z2U1N2wwNEJDM2NxR1JrNXR1dzdyb1F1U2VFNXpCejk2Q05YZ1hBeWdRbWI3?=
 =?utf-8?B?cmNSalMzSXNjaEsyajlHSFFnLzNmaGwxU0FWK2R5OEFsdnVKdDVXVzZrT1BN?=
 =?utf-8?B?S09QU3c3RVhUZUJhT0hndlVvUjdiZXRxYUtEZ1o4dEcwcTFJeG5OR2h6Tyto?=
 =?utf-8?B?dlAwQ0ZzcmNhN0dBUjRmaWNIaWpBR1JTUExUSVB2YnhlZkpjVmJNUk5KaSs0?=
 =?utf-8?B?c00wNmwvREtSV3FWajc1VHBHS3o3TGl5K2xiWElLWHoyNHE0WlFJbjMxL3Rr?=
 =?utf-8?B?K2pUcHpMeFA4aTFtbU9IUkxMRXI5aWJpMTd2YWQ0OExzQ1pudUF0OUFOMjlR?=
 =?utf-8?B?YitvWWx4SUQxbjBiT2FXUDhjdFlIeG96N2xTVGFqaG82c1grTFFndXBJM1Bo?=
 =?utf-8?Q?6JzdRvo3t1/iX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39ce1502-ee3a-4199-e61f-08d90e741e10
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2021 20:43:33.5383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LJAyH/Jkxp7DUydcm/Ng4otj53C/bxE6PnTH/8NTrZUNLytv3f1wFtUcCpz9td3yeLbEjbNU+VN9h/PAZxNj5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4368
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2021-04-29 3:08 a.m., Christian König wrote:
> Am 28.04.21 um 17:11 schrieb Andrey Grodzovsky:
>> Handle all DMA IOMMU gropup related dependencies before the
>> group is removed.
>>
>> v5: Drop IOMMU notifier and switch to lockless call to ttm_tt_unpopulate
> 
> Maybe split that up into more patches.
> 
>>
>> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 ++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 31 ++++++++++++++++++++--
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c   |  3 +--
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h   |  1 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c    |  9 +++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 13 ++++++++-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  2 ++
>>   drivers/gpu/drm/amd/amdgpu/cik_ih.c        |  1 -
>>   drivers/gpu/drm/amd/amdgpu/cz_ih.c         |  1 -
>>   drivers/gpu/drm/amd/amdgpu/iceland_ih.c    |  1 -
>>   drivers/gpu/drm/amd/amdgpu/navi10_ih.c     |  3 ---
>>   drivers/gpu/drm/amd/amdgpu/si_ih.c         |  1 -
>>   drivers/gpu/drm/amd/amdgpu/tonga_ih.c      |  1 -
>>   drivers/gpu/drm/amd/amdgpu/vega10_ih.c     |  3 ---
>>   14 files changed, 56 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index fddb82897e5d..30a24db5f4d1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -1054,6 +1054,8 @@ struct amdgpu_device {
>>       bool                            in_pci_err_recovery;
>>       struct pci_saved_state          *pci_state;
>> +
>> +    struct list_head                device_bo_list;
>>   };
>>   static inline struct amdgpu_device *drm_to_adev(struct drm_device 
>> *ddev)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 46d646c40338..91594ddc2459 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -70,6 +70,7 @@
>>   #include <drm/task_barrier.h>
>>   #include <linux/pm_runtime.h>
>> +
>>   MODULE_FIRMWARE("amdgpu/vega10_gpu_info.bin");
>>   MODULE_FIRMWARE("amdgpu/vega12_gpu_info.bin");
>>   MODULE_FIRMWARE("amdgpu/raven_gpu_info.bin");
>> @@ -3211,7 +3212,6 @@ static const struct attribute 
>> *amdgpu_dev_attributes[] = {
>>       NULL
>>   };
>> -
>>   /**
>>    * amdgpu_device_init - initialize the driver
>>    *
>> @@ -3316,6 +3316,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>>       INIT_WORK(&adev->xgmi_reset_work, amdgpu_device_xgmi_reset_func);
>> +    INIT_LIST_HEAD(&adev->device_bo_list);
>> +
>>       adev->gfx.gfx_off_req_count = 1;
>>       adev->pm.ac_power = power_supply_is_system_supplied() > 0;
>> @@ -3601,6 +3603,28 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>>       return r;
>>   }
>> +static void amdgpu_clear_dma_mappings(struct amdgpu_device *adev)
>> +{
>> +    struct amdgpu_bo *bo = NULL;
>> +
>> +    /*
>> +     * Unmaps all DMA mappings before device will be removed from it's
>> +     * IOMMU group otherwise in case of IOMMU enabled system a crash
>> +     * will happen.
>> +     */
>> +
>> +    spin_lock(&adev->mman.bdev.lru_lock);
>> +    while (!list_empty(&adev->device_bo_list)) {
>> +        bo = list_first_entry(&adev->device_bo_list, struct 
>> amdgpu_bo, bo);
>> +        list_del_init(&bo->bo);
>> +        spin_unlock(&adev->mman.bdev.lru_lock);
>> +        if (bo->tbo.ttm)
>> +            ttm_tt_unpopulate(bo->tbo.bdev, bo->tbo.ttm);
>> +        spin_lock(&adev->mman.bdev.lru_lock);
>> +    }
>> +    spin_unlock(&adev->mman.bdev.lru_lock);
> 
> Can you try to use the same approach as amdgpu_gtt_mgr_recover() instead 
> of adding something to the BO?
> 
> Christian.

Are you sure that dma mappings limit themself only to GTT BOs
which have allocated mm nodes ? Otherwsie we will crash and burn
on missing IOMMU group when unampping post device remove.
Problem for me to test this as in 5.12 kernel I don't crash even
when removing this entire patch.  Looks like iommu_dma_unmap_page
was changed since 5.9 when I introdiced this patch.

Andrey

> 
>> +}
>> +
>>   /**
>>    * amdgpu_device_fini - tear down the driver
>>    *
>> @@ -3639,12 +3663,15 @@ void amdgpu_device_fini_hw(struct 
>> amdgpu_device *adev)
>>           amdgpu_ucode_sysfs_fini(adev);
>>       sysfs_remove_files(&adev->dev->kobj, amdgpu_dev_attributes);
>> -
>>       amdgpu_fbdev_fini(adev);
>>       amdgpu_irq_fini_hw(adev);
>>       amdgpu_device_ip_fini_early(adev);
>> +
>> +    amdgpu_clear_dma_mappings(adev);
>> +
>> +    amdgpu_gart_dummy_page_fini(adev);
>>   }
>>   void amdgpu_device_fini_sw(struct amdgpu_device *adev)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
>> index fde2d899b2c4..49cdcaf8512d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
>> @@ -92,7 +92,7 @@ static int amdgpu_gart_dummy_page_init(struct 
>> amdgpu_device *adev)
>>    *
>>    * Frees the dummy page used by the driver (all asics).
>>    */
>> -static void amdgpu_gart_dummy_page_fini(struct amdgpu_device *adev)
>> +void amdgpu_gart_dummy_page_fini(struct amdgpu_device *adev)
>>   {
>>       if (!adev->dummy_page_addr)
>>           return;
>> @@ -397,5 +397,4 @@ void amdgpu_gart_fini(struct amdgpu_device *adev)
>>       vfree(adev->gart.pages);
>>       adev->gart.pages = NULL;
>>   #endif
>> -    amdgpu_gart_dummy_page_fini(adev);
>>   }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
>> index afa2e2877d87..5678d9c105ab 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
>> @@ -61,6 +61,7 @@ int amdgpu_gart_table_vram_pin(struct amdgpu_device 
>> *adev);
>>   void amdgpu_gart_table_vram_unpin(struct amdgpu_device *adev);
>>   int amdgpu_gart_init(struct amdgpu_device *adev);
>>   void amdgpu_gart_fini(struct amdgpu_device *adev);
>> +void amdgpu_gart_dummy_page_fini(struct amdgpu_device *adev);
>>   int amdgpu_gart_unbind(struct amdgpu_device *adev, uint64_t offset,
>>                  int pages);
>>   int amdgpu_gart_map(struct amdgpu_device *adev, uint64_t offset,
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>> index 63e815c27585..a922154953a7 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>> @@ -326,6 +326,15 @@ void amdgpu_irq_fini_hw(struct amdgpu_device *adev)
>>           if (!amdgpu_device_has_dc_support(adev))
>>               flush_work(&adev->hotplug_work);
>>       }
>> +
>> +    if (adev->irq.ih_soft.ring)
>> +        amdgpu_ih_ring_fini(adev, &adev->irq.ih_soft);
>> +    if (adev->irq.ih.ring)
>> +        amdgpu_ih_ring_fini(adev, &adev->irq.ih);
>> +    if (adev->irq.ih1.ring)
>> +        amdgpu_ih_ring_fini(adev, &adev->irq.ih1);
>> +    if (adev->irq.ih2.ring)
>> +        amdgpu_ih_ring_fini(adev, &adev->irq.ih2);
>>   }
>>   /**
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> index 485f249d063a..62d829f5e62c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> @@ -68,8 +68,13 @@ static void amdgpu_bo_destroy(struct 
>> ttm_buffer_object *tbo)
>>           list_del_init(&bo->shadow_list);
>>           mutex_unlock(&adev->shadow_list_lock);
>>       }
>> -    amdgpu_bo_unref(&bo->parent);
>> +
>> +    spin_lock(&adev->mman.bdev.lru_lock);
>> +    list_del(&bo->bo);
>> +    spin_unlock(&adev->mman.bdev.lru_lock);
>> +
>> +    amdgpu_bo_unref(&bo->parent);
>>       kfree(bo->metadata);
>>       kfree(bo);
>>   }
>> @@ -585,6 +590,12 @@ static int amdgpu_bo_do_create(struct 
>> amdgpu_device *adev,
>>       if (bp->type == ttm_bo_type_device)
>>           bo->flags &= ~AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
>> +    INIT_LIST_HEAD(&bo->bo);
>> +
>> +    spin_lock(&adev->mman.bdev.lru_lock);
>> +    list_add_tail(&bo->bo, &adev->device_bo_list);
>> +    spin_unlock(&adev->mman.bdev.lru_lock);
>> +
>>       return 0;
>>   fail_unreserve:
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>> index 9ac37569823f..5ae8555ef275 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>> @@ -110,6 +110,8 @@ struct amdgpu_bo {
>>       struct list_head        shadow_list;
>>       struct kgd_mem                  *kfd_bo;
>> +
>> +    struct list_head        bo;
>>   };
>>   static inline struct amdgpu_bo *ttm_to_amdgpu_bo(struct 
>> ttm_buffer_object *tbo)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/cik_ih.c 
>> b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
>> index 183d44a6583c..df385ffc9768 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/cik_ih.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
>> @@ -310,7 +310,6 @@ static int cik_ih_sw_fini(void *handle)
>>       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>       amdgpu_irq_fini_sw(adev);
>> -    amdgpu_ih_ring_fini(adev, &adev->irq.ih);
>>       amdgpu_irq_remove_domain(adev);
>>       return 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/cz_ih.c 
>> b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
>> index d32743949003..b8c47e0cf37a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/cz_ih.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
>> @@ -302,7 +302,6 @@ static int cz_ih_sw_fini(void *handle)
>>       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>       amdgpu_irq_fini_sw(adev);
>> -    amdgpu_ih_ring_fini(adev, &adev->irq.ih);
>>       amdgpu_irq_remove_domain(adev);
>>       return 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c 
>> b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
>> index da96c6013477..ddfe4eaeea05 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
>> @@ -301,7 +301,6 @@ static int iceland_ih_sw_fini(void *handle)
>>       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>       amdgpu_irq_fini_sw(adev);
>> -    amdgpu_ih_ring_fini(adev, &adev->irq.ih);
>>       amdgpu_irq_remove_domain(adev);
>>       return 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c 
>> b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
>> index 5eea4550b856..e171a9e78544 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
>> @@ -571,9 +571,6 @@ static int navi10_ih_sw_fini(void *handle)
>>       amdgpu_irq_fini_sw(adev);
>>       amdgpu_ih_ring_fini(adev, &adev->irq.ih_soft);
>> -    amdgpu_ih_ring_fini(adev, &adev->irq.ih2);
>> -    amdgpu_ih_ring_fini(adev, &adev->irq.ih1);
>> -    amdgpu_ih_ring_fini(adev, &adev->irq.ih);
>>       return 0;
>>   }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/si_ih.c 
>> b/drivers/gpu/drm/amd/amdgpu/si_ih.c
>> index 751307f3252c..9a24f17a5750 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/si_ih.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/si_ih.c
>> @@ -176,7 +176,6 @@ static int si_ih_sw_fini(void *handle)
>>       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>       amdgpu_irq_fini_sw(adev);
>> -    amdgpu_ih_ring_fini(adev, &adev->irq.ih);
>>       return 0;
>>   }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c 
>> b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
>> index 973d80ec7f6c..b08905d1c00f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
>> @@ -313,7 +313,6 @@ static int tonga_ih_sw_fini(void *handle)
>>       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>       amdgpu_irq_fini_sw(adev);
>> -    amdgpu_ih_ring_fini(adev, &adev->irq.ih);
>>       amdgpu_irq_remove_domain(adev);
>>       return 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c 
>> b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
>> index 2d0094c276ca..8c8abc00f710 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
>> @@ -525,9 +525,6 @@ static int vega10_ih_sw_fini(void *handle)
>>       amdgpu_irq_fini_sw(adev);
>>       amdgpu_ih_ring_fini(adev, &adev->irq.ih_soft);
>> -    amdgpu_ih_ring_fini(adev, &adev->irq.ih2);
>> -    amdgpu_ih_ring_fini(adev, &adev->irq.ih1);
>> -    amdgpu_ih_ring_fini(adev, &adev->irq.ih);
>>       return 0;
>>   }
> 
