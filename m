Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCD49372D32
	for <lists+linux-pci@lfdr.de>; Tue,  4 May 2021 17:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbhEDPot (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 May 2021 11:44:49 -0400
Received: from mail-dm3nam07on2083.outbound.protection.outlook.com ([40.107.95.83]:13729
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230256AbhEDPos (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 4 May 2021 11:44:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WCpA4qEpGXTLtSF8HxLZyG9NCKk6p8Ox1SuVx4J1dJRoTnpXEKUvkn1QZeRJwOwLI0AJC+RsPbKDdqMLImkDMEGzMURC2NI0Q40PO+BD9VcClmNttocvoKRAa+wV8cvp3drwW8wl2e9mEnkLpQ1eVRlA867Mqw5HYtkqd4Xm6/0ye670k1TC6zAqPzaOVj7xjxXPR5DiQqf349n7kUWa1V2T+FP3MaYDU7ndn5HhmS0xm1wWiUtTwI98Qoi88GyfIBvEioDT+/p1nLG+LNFAfYgboOMoLpXqGgSMBd4nXl6guM4XzAUpfpipSmpc/bmbTnAkmw4gVLmoeRDXnkFWtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WXi3HBEkSFS5jb5W1X2VIUbFg/qRq9EQsh6sO4I+Eg4=;
 b=ZSA6BrLjypO5tPwcXXa0PWt3qCMH+gA2UqirY6HHF+bXFYmE7ntinQWUcmoASwaJur6XONaTq0hhq1HmJ5i/vVvcy/QeIQ47r4IhZtbgOeX1h2GeZe+MHCGtjjO0d6z+1KkU6Mg4BpjWH8lYO1hN+m45cusG29vomFe8gmJlSiEDWopY9FNsDhyvTQ4FARpYnie3lWjnKIx5k2ap3SyRssaFOkQgPD+MKzplvDTHRDlAsKwP6k8lVm9LEoSTyTzF9scBHO5ZRtAZDCLbXgaf1hBvACVosl1rrhB1tPhHoimEqPno8Ecf0PKaScxU/SFIX2NPY99jzZ1qh25pSNf05g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WXi3HBEkSFS5jb5W1X2VIUbFg/qRq9EQsh6sO4I+Eg4=;
 b=o7V7pLGRfndhRCyPrGtO2PbdSaxY64rPtdP7KBNIBo83zGEm/erWQDstvn91jwHvgeZVdHw77FmQNwWIGPDUaIbldhohjVHS0bOlqkELefCXBAA9TlQG6j7W6alMODjbjks0VO2B5HxoBgGAR3uwma0lqK7U28aBwx5skiNQITI=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SN6PR12MB4767.namprd12.prod.outlook.com (2603:10b6:805:e5::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.40; Tue, 4 May
 2021 15:43:51 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::ad51:8c49:b171:856c]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::ad51:8c49:b171:856c%7]) with mapi id 15.20.4087.044; Tue, 4 May 2021
 15:43:51 +0000
Subject: Re: [PATCH v5 06/27] drm/amdgpu: Handle IOMMU enabled case.
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-pci@vger.kernel.org, daniel.vetter@ffwll.ch,
        Harry.Wentland@amd.com
Cc:     Alexander.Deucher@amd.com, gregkh@linuxfoundation.org,
        ppaalanen@gmail.com, helgaas@kernel.org, Felix.Kuehling@amd.com
References: <20210428151207.1212258-1-andrey.grodzovsky@amd.com>
 <20210428151207.1212258-7-andrey.grodzovsky@amd.com>
 <8ba9edd8-9d6d-b6c3-342c-3f137d0cacd0@gmail.com>
 <df2bfa14-917b-939b-8ec1-f1e787313868@amd.com>
 <6607918c-cf02-98e1-f8a3-4106109e77cf@gmail.com>
From:   Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <dcb33aa5-a3ed-79e9-67dc-8bb8d9299755@amd.com>
Date:   Tue, 4 May 2021 11:43:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <6607918c-cf02-98e1-f8a3-4106109e77cf@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2607:fea8:3edf:49b0:c1e6:9682:cde:27ee]
X-ClientProxiedBy: YT1PR01CA0056.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::25) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:c1e6:9682:cde:27ee] (2607:fea8:3edf:49b0:c1e6:9682:cde:27ee) by YT1PR01CA0056.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.37 via Frontend Transport; Tue, 4 May 2021 15:43:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab30c030-ebd9-47ab-a462-08d90f136a30
X-MS-TrafficTypeDiagnostic: SN6PR12MB4767:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB4767891931310AD94ED658F4EA5A9@SN6PR12MB4767.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rVzmnCf/1loSCBf2QcSONZ2AOnEMl29SBUYrfjI3CYvVvV8OU45yqQWOUuJi/9s3US/Fu25rV1cFJEHkukyWlTxfDLvkErU1sDG5vMiIlboRWAk5i9anClvuXiCiYltMNzaZttjTg4cW/DEplmG4XpZ1kHw4kiEvJ6UqlgKy1iRz4d6dp+rkn98OYtdqtUvYcsNuoyawDNsbwE6qRA5g9tnOR+luprz3WyZa9G6IUe5wqrenU1Iz/dIUyxx8oCvmon9e3wePu3+9XIFZvZ8EeRLjjuDbv32kLoziXU4Ktk7tb7kw+rmOyS0dp4cEPej6VI6uwEfSsFS72b+0uUMyJEB9utLfk/lMF1P8X5BusdFnYqFBVvtLwhuBiWDK7qMY0TGIfwvsaGbCRV5IyNa2EOj5+xsaTxPAlmCYpuwjRclJx3B1baa9WfKR+FqxP3lSZcufRqQJELQ98kzC4nIM7YbiVn4ko7FJyA5lR8u4HuGNeoLTzCfAwE4H/6RC5P7oxl717IgCJmTbQzBUyDVgPPH9YNdtBlorpquama/NucWWdfXH+d3fLvIAVvMHWRK+7mzP94GlMXGhgmAv7LGt2KmtlYDDuzQG9lx6DO/4NA5zCdD7zXmiektRpwN6tM8fDL807teClcXil8DJ7yrZp/NXjIf5RdZl09MG0Jp7m70zoWeJvyz8CtPr63Z+DfDNosKiWotL37QEHJiSX1ld1UGk7whcLtHJavZkVWeGLMs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB4623.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(136003)(396003)(39860400002)(376002)(66946007)(45080400002)(53546011)(5660300002)(2616005)(478600001)(66556008)(66476007)(66574015)(6486002)(52116002)(38100700002)(186003)(36756003)(86362001)(83380400001)(30864003)(8936002)(31686004)(16526019)(2906002)(44832011)(31696002)(4326008)(966005)(8676002)(316002)(6636002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MFk3RmZqYzJncDIwOXM3cm95dHNkSkRMVlpQeHJtMW9vdTFwWk50ckRmbWtC?=
 =?utf-8?B?NW5BY0NBeVg5c1RGWkJIMjBRU3V1TlE2bDVJTkVMSDM4R0dHWWp4cTZyb1BW?=
 =?utf-8?B?U3JQc25NQkRGYnJhZklnWisxSzdFK1YrekZVWEs1aUJlUDZadzNRc081bkRy?=
 =?utf-8?B?YmIwYkpDZ3ZqWXVzRkZCZkFVZjVQR1hlSDBSb3JLRVlxQ0RkZDJsSkkzUEVp?=
 =?utf-8?B?MXQ2ZmpDRldwK1B5eTZua3B0NWtWRW8vZUwwSUxUS3pCRVdGcVFYRitQL0xs?=
 =?utf-8?B?MlNxa21NWmZHNWdJTW1iTDd5bmlaL0U4aG14UTlKN1NwK0RabEVTSFl5bTZC?=
 =?utf-8?B?YjAvTEhwVWZzeVVNRnpYcm1LWDBTTEc1NzBVN292bnRxT3lkTmRNbVFYUmRM?=
 =?utf-8?B?NWtXNkhlS3FDSHQ5ZjFrTXNRV2pidXBDSlFrTWFwL09mYXVnbGlNc0pyUjJr?=
 =?utf-8?B?eUFSSEpyWVlQNGN2Z1lab1A5ZW1UVnZyMitnZ2ZScWNWaWRmNkpqUzYvelFX?=
 =?utf-8?B?YXIwcXpNUzJqckJ6S3RRVFoyZjV2SlJWS2RBS0wvMVAycC9FNFAxSE5ZeU1U?=
 =?utf-8?B?Z3czdGY3WDJMTmpTSVJ4S04yY01hVE1qQzdESE9ETHhxV2p4MXQyQ1pGTVl3?=
 =?utf-8?B?MEZ5N1BrbGNMU21YU1hCNXhtRVpYa0FzUTIvZWE1eXF1NVJBQkxoWHRZNmVu?=
 =?utf-8?B?bjE1VDMwemxGc2xtUFVZUTBYTmk4RzZkREdDZFFuY3lEa3VMVjhlTjFjSU1w?=
 =?utf-8?B?dUxPUUh3YzR3dVJRRkdpMDBhTnhEVEdpK01HblFVTGRtQVB1RWpEVm5GYk5s?=
 =?utf-8?B?dWhoRE1IL3pPODFzUjhXNVBUYmplb3JsdHVQd1dQZFZNejlmSFQ5S3l1TTFW?=
 =?utf-8?B?dDFCODBhSWtlREFtQm5GVDQ1ME9HOEhqT2lETE9GY2E5emFPNytsTEwxSFRB?=
 =?utf-8?B?RXVtMzZKRGRObjliamdHWXFsT1JBT3NqSnJDZ3lRejhkT3hBZzdDak9NVWo2?=
 =?utf-8?B?S3ZJWG56Uks1ejdadThGU29RRFBYRmUySkZKbVRlMEdNTWNMWVVZdjAyYldZ?=
 =?utf-8?B?aTZDK0k1RWgxQVVNdVVSaERPbmcrUlRsYWthRy9NOExnMUkwS3V1dTZrcU5m?=
 =?utf-8?B?VzdXWlBqekZPR2JGbDVRVHBOZmtsOGQrRjQ3aUN3dlJaSXRZTHptL0ZrbjZY?=
 =?utf-8?B?M2IzcE4waUVnekJJNmNGbWt0M3ZYbnBWZXBMdkdoRmZWZ012WHVhcWlnNVdz?=
 =?utf-8?B?YXgvdHpmN0V4OVcvaE9aV2tlYXhzQXE4bmg4L1M4N0N6bVBsTGhBRm43K2JR?=
 =?utf-8?B?djlHajFOR29kL3oyVGo5V1k0WG5OTGVZSkpUSzVKWHBQL0JmT2NWd2w4RzJJ?=
 =?utf-8?B?RVRVZWV6bjlGVGg0TmxvNGw0eFF4Zlk0bUpTZGJBVFNNREk1U2NUd2lPQytC?=
 =?utf-8?B?czV1M1RJcDFLTURjem56a25PWWtmQnN6L2tjc21uZFJqMFNEWFdOaTJzYnUx?=
 =?utf-8?B?aWJ3UFo4M2NHTWRoNVIvaERxaDNHUTJiTGhWQUEzczJaN25nVnI3em1nWndm?=
 =?utf-8?B?eWpNa3MxaHZpVmVwbUlTQTlGRkFzOHdyTVBLWDVhRUVSakIwMHFIM0xzaUwx?=
 =?utf-8?B?WFFteHY4Smc5UDNiczRGM1h1ZkxLZ3N6UnE2cWpCdVFiSnBielhFTC9VT0tS?=
 =?utf-8?B?VHdhemVVSDFpU3NiYmJZcE1xWWJZK3V2c2VmNDFrcUVRaFUxMVR0TWR0cEYz?=
 =?utf-8?B?cWpBTk5DRTE5dUgzbGRiMnhlSzVPdFRjQU5JT1J3TjE1N0dhSEFuM285czhj?=
 =?utf-8?B?MjNiU1lxRXR5aCtTSDAzczQydUU4TEsvWXpTRE5tVXFIUkJ6TzkwZmkzZDNx?=
 =?utf-8?Q?BU0wmFZ3TEfN/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab30c030-ebd9-47ab-a462-08d90f136a30
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2021 15:43:51.2122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: otmrdbJQUgqWox56XmUTnpltuzcimmoq7Qx3NtKY/mapFODJBGOcCVPLVyIgh/bhFwZ47Y2pVEPyDToQEmhLZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4767
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2021-05-04 3:03 a.m., Christian König wrote:
> Am 03.05.21 um 22:43 schrieb Andrey Grodzovsky:
>>
>>
>> On 2021-04-29 3:08 a.m., Christian König wrote:
>>> Am 28.04.21 um 17:11 schrieb Andrey Grodzovsky:
>>>> Handle all DMA IOMMU gropup related dependencies before the
>>>> group is removed.
>>>>
>>>> v5: Drop IOMMU notifier and switch to lockless call to 
>>>> ttm_tt_unpopulate
>>>
>>> Maybe split that up into more patches.
>>>
>>>>
>>>> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 ++
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 31 
>>>> ++++++++++++++++++++--
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c   |  3 +--
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h   |  1 +
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c    |  9 +++++++
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 13 ++++++++-
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  2 ++
>>>>   drivers/gpu/drm/amd/amdgpu/cik_ih.c        |  1 -
>>>>   drivers/gpu/drm/amd/amdgpu/cz_ih.c         |  1 -
>>>>   drivers/gpu/drm/amd/amdgpu/iceland_ih.c    |  1 -
>>>>   drivers/gpu/drm/amd/amdgpu/navi10_ih.c     |  3 ---
>>>>   drivers/gpu/drm/amd/amdgpu/si_ih.c         |  1 -
>>>>   drivers/gpu/drm/amd/amdgpu/tonga_ih.c      |  1 -
>>>>   drivers/gpu/drm/amd/amdgpu/vega10_ih.c     |  3 ---
>>>>   14 files changed, 56 insertions(+), 16 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> index fddb82897e5d..30a24db5f4d1 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> @@ -1054,6 +1054,8 @@ struct amdgpu_device {
>>>>       bool                            in_pci_err_recovery;
>>>>       struct pci_saved_state          *pci_state;
>>>> +
>>>> +    struct list_head                device_bo_list;
>>>>   };
>>>>   static inline struct amdgpu_device *drm_to_adev(struct drm_device 
>>>> *ddev)
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> index 46d646c40338..91594ddc2459 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> @@ -70,6 +70,7 @@
>>>>   #include <drm/task_barrier.h>
>>>>   #include <linux/pm_runtime.h>
>>>> +
>>>>   MODULE_FIRMWARE("amdgpu/vega10_gpu_info.bin");
>>>>   MODULE_FIRMWARE("amdgpu/vega12_gpu_info.bin");
>>>>   MODULE_FIRMWARE("amdgpu/raven_gpu_info.bin");
>>>> @@ -3211,7 +3212,6 @@ static const struct attribute 
>>>> *amdgpu_dev_attributes[] = {
>>>>       NULL
>>>>   };
>>>> -
>>>>   /**
>>>>    * amdgpu_device_init - initialize the driver
>>>>    *
>>>> @@ -3316,6 +3316,8 @@ int amdgpu_device_init(struct amdgpu_device 
>>>> *adev,
>>>>       INIT_WORK(&adev->xgmi_reset_work, amdgpu_device_xgmi_reset_func);
>>>> +    INIT_LIST_HEAD(&adev->device_bo_list);
>>>> +
>>>>       adev->gfx.gfx_off_req_count = 1;
>>>>       adev->pm.ac_power = power_supply_is_system_supplied() > 0;
>>>> @@ -3601,6 +3603,28 @@ int amdgpu_device_init(struct amdgpu_device 
>>>> *adev,
>>>>       return r;
>>>>   }
>>>> +static void amdgpu_clear_dma_mappings(struct amdgpu_device *adev)
>>>> +{
>>>> +    struct amdgpu_bo *bo = NULL;
>>>> +
>>>> +    /*
>>>> +     * Unmaps all DMA mappings before device will be removed from it's
>>>> +     * IOMMU group otherwise in case of IOMMU enabled system a crash
>>>> +     * will happen.
>>>> +     */
>>>> +
>>>> +    spin_lock(&adev->mman.bdev.lru_lock);
>>>> +    while (!list_empty(&adev->device_bo_list)) {
>>>> +        bo = list_first_entry(&adev->device_bo_list, struct 
>>>> amdgpu_bo, bo);
>>>> +        list_del_init(&bo->bo);
>>>> +        spin_unlock(&adev->mman.bdev.lru_lock);
>>>> +        if (bo->tbo.ttm)
>>>> +            ttm_tt_unpopulate(bo->tbo.bdev, bo->tbo.ttm);
>>>> +        spin_lock(&adev->mman.bdev.lru_lock);
>>>> +    }
>>>> +    spin_unlock(&adev->mman.bdev.lru_lock);
>>>
>>> Can you try to use the same approach as amdgpu_gtt_mgr_recover() 
>>> instead of adding something to the BO?
>>>
>>> Christian.
>>
>> Are you sure that dma mappings limit themself only to GTT BOs
>> which have allocated mm nodes ?
> 
> Yes, you would also need the system domain BOs. But those can be put on 
> a similar list.

What list ? Those BOs don't have ttm_resource_manager and so no
drm_mm_node list they all bound to. Should I maintain a list for them
spcifically for the unmap purpuse ?

> 
>> Otherwsie we will crash and burn
>> on missing IOMMU group when unampping post device remove.
>> Problem for me to test this as in 5.12 kernel I don't crash even
>> when removing this entire patch.  Looks like iommu_dma_unmap_page
>> was changed since 5.9 when I introdiced this patch.
> 
> Do we really still need that stuff then? What exactly has changed?

At first I assumed that because of this change 'iommu: Allow the 
dma-iommu api to use bounce buffers'
Which changed iommu_dma_unmap_page to call __iommu_dma_unmap_swiotlb
instead if __iommu_dma_unmap directly. But then i looked inside
__iommu_dma_unmap_swiotlb and it still calls __iommu_dma_unmap
evenetually. So maybe the fact that I moved the amd_ip_funcs.hw_fini
call to inside amdgpu_pci_remove helps.

Andrey


> 
> Christian.
> 
>>
>> Andrey
>>
>>>
>>>> +}
>>>> +
>>>>   /**
>>>>    * amdgpu_device_fini - tear down the driver
>>>>    *
>>>> @@ -3639,12 +3663,15 @@ void amdgpu_device_fini_hw(struct 
>>>> amdgpu_device *adev)
>>>>           amdgpu_ucode_sysfs_fini(adev);
>>>>       sysfs_remove_files(&adev->dev->kobj, amdgpu_dev_attributes);
>>>> -
>>>>       amdgpu_fbdev_fini(adev);
>>>>       amdgpu_irq_fini_hw(adev);
>>>>       amdgpu_device_ip_fini_early(adev);
>>>> +
>>>> +    amdgpu_clear_dma_mappings(adev);
>>>> +
>>>> +    amdgpu_gart_dummy_page_fini(adev);
>>>>   }
>>>>   void amdgpu_device_fini_sw(struct amdgpu_device *adev)
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
>>>> index fde2d899b2c4..49cdcaf8512d 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
>>>> @@ -92,7 +92,7 @@ static int amdgpu_gart_dummy_page_init(struct 
>>>> amdgpu_device *adev)
>>>>    *
>>>>    * Frees the dummy page used by the driver (all asics).
>>>>    */
>>>> -static void amdgpu_gart_dummy_page_fini(struct amdgpu_device *adev)
>>>> +void amdgpu_gart_dummy_page_fini(struct amdgpu_device *adev)
>>>>   {
>>>>       if (!adev->dummy_page_addr)
>>>>           return;
>>>> @@ -397,5 +397,4 @@ void amdgpu_gart_fini(struct amdgpu_device *adev)
>>>>       vfree(adev->gart.pages);
>>>>       adev->gart.pages = NULL;
>>>>   #endif
>>>> -    amdgpu_gart_dummy_page_fini(adev);
>>>>   }
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
>>>> index afa2e2877d87..5678d9c105ab 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
>>>> @@ -61,6 +61,7 @@ int amdgpu_gart_table_vram_pin(struct 
>>>> amdgpu_device *adev);
>>>>   void amdgpu_gart_table_vram_unpin(struct amdgpu_device *adev);
>>>>   int amdgpu_gart_init(struct amdgpu_device *adev);
>>>>   void amdgpu_gart_fini(struct amdgpu_device *adev);
>>>> +void amdgpu_gart_dummy_page_fini(struct amdgpu_device *adev);
>>>>   int amdgpu_gart_unbind(struct amdgpu_device *adev, uint64_t offset,
>>>>                  int pages);
>>>>   int amdgpu_gart_map(struct amdgpu_device *adev, uint64_t offset,
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>>>> index 63e815c27585..a922154953a7 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>>>> @@ -326,6 +326,15 @@ void amdgpu_irq_fini_hw(struct amdgpu_device 
>>>> *adev)
>>>>           if (!amdgpu_device_has_dc_support(adev))
>>>>               flush_work(&adev->hotplug_work);
>>>>       }
>>>> +
>>>> +    if (adev->irq.ih_soft.ring)
>>>> +        amdgpu_ih_ring_fini(adev, &adev->irq.ih_soft);
>>>> +    if (adev->irq.ih.ring)
>>>> +        amdgpu_ih_ring_fini(adev, &adev->irq.ih);
>>>> +    if (adev->irq.ih1.ring)
>>>> +        amdgpu_ih_ring_fini(adev, &adev->irq.ih1);
>>>> +    if (adev->irq.ih2.ring)
>>>> +        amdgpu_ih_ring_fini(adev, &adev->irq.ih2);
>>>>   }
>>>>   /**
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>> index 485f249d063a..62d829f5e62c 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>> @@ -68,8 +68,13 @@ static void amdgpu_bo_destroy(struct 
>>>> ttm_buffer_object *tbo)
>>>>           list_del_init(&bo->shadow_list);
>>>>           mutex_unlock(&adev->shadow_list_lock);
>>>>       }
>>>> -    amdgpu_bo_unref(&bo->parent);
>>>> +
>>>> +    spin_lock(&adev->mman.bdev.lru_lock);
>>>> +    list_del(&bo->bo);
>>>> +    spin_unlock(&adev->mman.bdev.lru_lock);
>>>> +
>>>> +    amdgpu_bo_unref(&bo->parent);
>>>>       kfree(bo->metadata);
>>>>       kfree(bo);
>>>>   }
>>>> @@ -585,6 +590,12 @@ static int amdgpu_bo_do_create(struct 
>>>> amdgpu_device *adev,
>>>>       if (bp->type == ttm_bo_type_device)
>>>>           bo->flags &= ~AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
>>>> +    INIT_LIST_HEAD(&bo->bo);
>>>> +
>>>> +    spin_lock(&adev->mman.bdev.lru_lock);
>>>> +    list_add_tail(&bo->bo, &adev->device_bo_list);
>>>> +    spin_unlock(&adev->mman.bdev.lru_lock);
>>>> +
>>>>       return 0;
>>>>   fail_unreserve:
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>>>> index 9ac37569823f..5ae8555ef275 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>>>> @@ -110,6 +110,8 @@ struct amdgpu_bo {
>>>>       struct list_head        shadow_list;
>>>>       struct kgd_mem                  *kfd_bo;
>>>> +
>>>> +    struct list_head        bo;
>>>>   };
>>>>   static inline struct amdgpu_bo *ttm_to_amdgpu_bo(struct 
>>>> ttm_buffer_object *tbo)
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/cik_ih.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
>>>> index 183d44a6583c..df385ffc9768 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/cik_ih.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
>>>> @@ -310,7 +310,6 @@ static int cik_ih_sw_fini(void *handle)
>>>>       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>>>       amdgpu_irq_fini_sw(adev);
>>>> -    amdgpu_ih_ring_fini(adev, &adev->irq.ih);
>>>>       amdgpu_irq_remove_domain(adev);
>>>>       return 0;
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/cz_ih.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
>>>> index d32743949003..b8c47e0cf37a 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/cz_ih.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
>>>> @@ -302,7 +302,6 @@ static int cz_ih_sw_fini(void *handle)
>>>>       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>>>       amdgpu_irq_fini_sw(adev);
>>>> -    amdgpu_ih_ring_fini(adev, &adev->irq.ih);
>>>>       amdgpu_irq_remove_domain(adev);
>>>>       return 0;
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
>>>> index da96c6013477..ddfe4eaeea05 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
>>>> @@ -301,7 +301,6 @@ static int iceland_ih_sw_fini(void *handle)
>>>>       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>>>       amdgpu_irq_fini_sw(adev);
>>>> -    amdgpu_ih_ring_fini(adev, &adev->irq.ih);
>>>>       amdgpu_irq_remove_domain(adev);
>>>>       return 0;
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
>>>> index 5eea4550b856..e171a9e78544 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
>>>> @@ -571,9 +571,6 @@ static int navi10_ih_sw_fini(void *handle)
>>>>       amdgpu_irq_fini_sw(adev);
>>>>       amdgpu_ih_ring_fini(adev, &adev->irq.ih_soft);
>>>> -    amdgpu_ih_ring_fini(adev, &adev->irq.ih2);
>>>> -    amdgpu_ih_ring_fini(adev, &adev->irq.ih1);
>>>> -    amdgpu_ih_ring_fini(adev, &adev->irq.ih);
>>>>       return 0;
>>>>   }
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/si_ih.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/si_ih.c
>>>> index 751307f3252c..9a24f17a5750 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/si_ih.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/si_ih.c
>>>> @@ -176,7 +176,6 @@ static int si_ih_sw_fini(void *handle)
>>>>       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>>>       amdgpu_irq_fini_sw(adev);
>>>> -    amdgpu_ih_ring_fini(adev, &adev->irq.ih);
>>>>       return 0;
>>>>   }
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
>>>> index 973d80ec7f6c..b08905d1c00f 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
>>>> @@ -313,7 +313,6 @@ static int tonga_ih_sw_fini(void *handle)
>>>>       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>>>       amdgpu_irq_fini_sw(adev);
>>>> -    amdgpu_ih_ring_fini(adev, &adev->irq.ih);
>>>>       amdgpu_irq_remove_domain(adev);
>>>>       return 0;
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
>>>> index 2d0094c276ca..8c8abc00f710 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
>>>> @@ -525,9 +525,6 @@ static int vega10_ih_sw_fini(void *handle)
>>>>       amdgpu_irq_fini_sw(adev);
>>>>       amdgpu_ih_ring_fini(adev, &adev->irq.ih_soft);
>>>> -    amdgpu_ih_ring_fini(adev, &adev->irq.ih2);
>>>> -    amdgpu_ih_ring_fini(adev, &adev->irq.ih1);
>>>> -    amdgpu_ih_ring_fini(adev, &adev->irq.ih);
>>>>       return 0;
>>>>   }
>>>
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Candrey.grodzovsky%40amd.com%7C1cee392c0b934cda6c7608d90ecabc41%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637557086175078458%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=C8QBsUQhJa1eWV1YYdQaykUVQGwmCn6OIoWQSrDkWoU%3D&amp;reserved=0 
> 
