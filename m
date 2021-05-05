Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A921E373DF2
	for <lists+linux-pci@lfdr.de>; Wed,  5 May 2021 16:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233314AbhEEOwp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 May 2021 10:52:45 -0400
Received: from mail-dm6nam10on2046.outbound.protection.outlook.com ([40.107.93.46]:42880
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233309AbhEEOwp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 May 2021 10:52:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JL1eN8aNu+mpDz6LDA77AJVUdzZPt2b+bPXI3PQjHJT/n3jh6bHS3pYgwsINzYC0wYjwqK1Mcn5LbgYoAgIIukb0gDBrBnX2MqxGTL/L2J/TzKbHsuixGcr5dl/76v3MeclY6m9c4XE7QaFelJ532zIgPiSvuKfINmbTl9IOdweDzQMGrCiQB/szOsnUOpnK0yl002ddPBRFy/Y63e7qj7P7R9MqmAuugYIo7TwmGAgLgYOnQsQRr4eQIukdWbMjuJRtB75MjX+EMaem6ox+1ZIFAckHJUnxxiz/w2B1Nb5tOQq/aSwyNBiEx3goYGnRY54T+fyXLND4H3QiqnzbVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vRf6p1II1n/Vll9UZRwX5FPSwJ9jREuUJxtRSN/f2PY=;
 b=miWgDesNUn5V/gM4GlEG7el5cQS2n4hghqXv02Rp7xs5+GsSY/kzgsh1n8+faO4SBK6pSdqX0RSyaouHtU5nNUchUMYbxlhDciJqnChXMaR79KUT+AqkfDZaBGQxY9l6ijmlGhfIOhyaC0UthsyOWIntAPRNjVINVhg4ZOCjd6ZCUtO7O4XopPzfyYCnkJrCW7YjGN1UEHJWquZtlbNxnf2XnqW9mQLdhybRsiY+VhDNbkRt95+dPWfjXD2o+yhoGG6FUJT3gQYftgtgGcoT0qxKf9cYs0jQrsPJPsxnTmp+pbEINPhwbJfb5VYhUioBdRt6PqClLW9E56S0F/aGLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vRf6p1II1n/Vll9UZRwX5FPSwJ9jREuUJxtRSN/f2PY=;
 b=DfM938Pi+qEs3u9hqA/0cWu8ridypEbVzYBfjX7XAhCh0FHb8iELbp9Rmu1tsy1oEHPViMLLGy3QyUmUugjg09zk7eH645n/pw1BA91+HhxVNhD+8bWML4JqDZuWFPkNkFbnnI2HcANYBklQHbszsYyxPD/5C0AVWmX8fS6m5ys=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SN1PR12MB2397.namprd12.prod.outlook.com (2603:10b6:802:27::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.40; Wed, 5 May
 2021 14:51:45 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::ad51:8c49:b171:856c]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::ad51:8c49:b171:856c%7]) with mapi id 15.20.4108.026; Wed, 5 May 2021
 14:51:45 +0000
Subject: Re: [PATCH v5 06/27] drm/amdgpu: Handle IOMMU enabled case.
From:   Andrey Grodzovsky <andrey.grodzovsky@amd.com>
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
 <dcb33aa5-a3ed-79e9-67dc-8bb8d9299755@amd.com>
Message-ID: <d009d4a3-d0ef-f470-084c-ab2d942787c3@amd.com>
Date:   Wed, 5 May 2021 10:51:42 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <dcb33aa5-a3ed-79e9-67dc-8bb8d9299755@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2607:fea8:3edf:49b0:7d63:ab2e:d405:e927]
X-ClientProxiedBy: YTOPR0101CA0014.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::27) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:7d63:ab2e:d405:e927] (2607:fea8:3edf:49b0:7d63:ab2e:d405:e927) by YTOPR0101CA0014.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.38 via Frontend Transport; Wed, 5 May 2021 14:51:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64ff99d7-4cbb-4cfc-9682-08d90fd54d8a
X-MS-TrafficTypeDiagnostic: SN1PR12MB2397:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2397AB46198FA597DB47EDC2EA599@SN1PR12MB2397.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ta1jdl/RmeFptxhn+fDn68kvjxcOQYTeDPaBRX8Iyq7fIo3axODn+yVDSd6pKPZ+3V9aN/Gq8let9tSQXWYiHgCLZROCni3C7VsMBMJVVV895mI8aRn3IMNBIcemQ9gn5lXxSZyHK0sGwIymYdRcoRf68ehfFA3Ra7PROxkXpFvPKxlRuY8vzWt6nisw4twLZy4yr1ijUdT5KE9v4FOfql6ehcN+Q6B3ZkUZSQb4EheuTcXddQp4ZhUb4bLNZUKsyKvnwxrxGUuT9wgX1D+GkGCQC+sSzRjVfYM/iI3LONOlmcYwrA9pXJIOGTobH/C9wokR6409A9NvH1BXD8d9IZrNdtG2IIaCYJJxZX1mEID2RbhgsZ09XSIwuFGGRi8M816AqR8DsJ3zBjoFnpS1Q/EuTOF3WiTcPJTmKhBMoM6E+JnYSYNRbwJYjk7hx2Y0hW/HVQFKHp34k07jQf5+3Ph1rNUiQQEEIkYL1rFfIuBjo6QWaoVb/6AVC3U9xLMXP52+tJHWSWHSVajQf6ms8DEhQxA9I+vxrOtT1l3jPsya4PgPO7YeB8VsjTlG2fTCgbac8I/9o11ew7+ixhdc/CwkkNV5vHWI54R78gd4fD5mswd/cfkqB2wis20Y2/dLMCbIDEI8yzzccGJv85hxgvL4RKkbx/FA26y4O+hxTrfEu8GANEsUL2S19wia4guMKxQxeDoGkfgCVo5764gwd14QrgoX8cL/3XpUDu+orvU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB4623.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(39860400002)(366004)(396003)(346002)(38100700002)(31686004)(31696002)(6486002)(66574015)(45080400002)(966005)(16526019)(478600001)(8676002)(186003)(86362001)(66946007)(2616005)(66476007)(5660300002)(66556008)(316002)(53546011)(8936002)(30864003)(44832011)(2906002)(4326008)(36756003)(83380400001)(6636002)(52116002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TEpXZlpMMUZ3SkMxYWs2S0N0U2NkYXcvVkxXTUpYU3Y4N1UyaWh4anRiSVhT?=
 =?utf-8?B?dFBTZTBqSXF0bTRwK2FJRm5WM1R6dVU4S2NONUdmdTZpckh1Um40dys2QWNS?=
 =?utf-8?B?SWF4NzRta2FTK283RWY1dzdhUi9zS1lEYnIrZEN5emVSUWZKcWE2VHQvRjc2?=
 =?utf-8?B?cll2RHBaMGZtdUdvVFd6SXlNdHMvK2Q2bit3c3lXcDlVbm9Ed0tBcnZ5TXF1?=
 =?utf-8?B?Y1gzaXRZTllFZDQrUHZGcmkweHAwVlgrOVFnYlZ6dW1nZVB3UVA2bHB2Nncv?=
 =?utf-8?B?WVVTMEg3ZjVtSXlQY1F4cUtNVjkvYmFRQjR2QlR2MEc2V1pOanpKa05QbTE0?=
 =?utf-8?B?WkNXN1hGVmVUZGRMUDFJeGt6N0pYVExpMUhPL1A0cnlkSnRpay8vSXJ1ZVRB?=
 =?utf-8?B?ZVMxOXhseE5sYTVibmhXRmRxNDBsdDZ4aTV3bkUraWg2Sm9weVZrUnhmYncv?=
 =?utf-8?B?RVh0ZmFhaEh4MFJYS0o4dXM4bWlWOG5ObG1BZzVuU2JNTy81QkJELy9BeWRk?=
 =?utf-8?B?eGorSnhnNE9UTXpOdWVjT3ZKbUgwdnFhbmNDNFpDWlVLWmt0VXFMYlIwR012?=
 =?utf-8?B?RnFKOUF4dDNWYmdsZzVDQnlWYi8xNWxtWHlqam42TDlzTWZwcEJiYTFIOTlW?=
 =?utf-8?B?OCtvbW1QSkxlRTIrVGgvUVVCc1JmeVZ4MElNaG5FZjVubGRsSVZ2aUZteUF3?=
 =?utf-8?B?YTB1S2hjM2V2L2U0Nk9YNVVsQ0FUUFhvYzByWFhhRXFHMURwWkhyZjg2YjFM?=
 =?utf-8?B?QzRuNEZpSjJSMCs1cDVnNkthSjdsdGkzSUgyd2QrVkVrU1pVK1dpcVFBc0x2?=
 =?utf-8?B?M0p5SlR6eWdJUXNnbUVGUjhEQmlGUUQzOXNvRk1kNWJxTklwZVFiejNGbkFy?=
 =?utf-8?B?cWxFYVhzajFoVS9JelJqMDF6N0xYUEVFc2ZyNXYvSkRYUnVNMk1HUUFKV3FD?=
 =?utf-8?B?S3NxUzVYSUorSyt0emxlclFTUlNrMUh3Q0EwZ2JvNzBrZ1dWVzR5MEsvV0pi?=
 =?utf-8?B?ZVpPQUJwOENNTHRMcXRkMHU5MDZNWitxQWRYZFc1NXRsWGZ6cjRBaHM1VkdG?=
 =?utf-8?B?Mk43cjdleGw1NHFzWUhNRk9iSVNEdVNxT1JNUUR6dmlQMDN1NDNTZUFqZGpQ?=
 =?utf-8?B?WlBGeHJIK0VQTU9WdjVRbVZHa2RXQURDUHk3ZWwwemlBUWwxSHdlNnhBR24w?=
 =?utf-8?B?bG5UbUpkMHZCNHBoSW92cWZPQkVwMUxQRW9Hdjl6R1hhNmduVElPZitSK3ZE?=
 =?utf-8?B?VXhhREFIY1VTS1Z2dkNQZHJnd2ZDRGdVcllrWmFRSUtjTUpOTk5ZUVBxbyt1?=
 =?utf-8?B?dTk1TFdCMTYwRmVzZWVqbkw5dm1ZbHhIUmhISlZRZER6bFhZbFY1bHlwZnFw?=
 =?utf-8?B?aEFnVGhHbDcvaEFWNlNILzQ3K0VpWHNtZUR1LzhWUTdFZFIxdkJYeXpnS0Rq?=
 =?utf-8?B?K05BZi9rbDVhNE1raVR1cW5xd0IzL3RCdElJRHhoYnVYRi9uUkF5UFBqekMx?=
 =?utf-8?B?SS96bnpwM3lqTkJZWm9qSGJJeHlPRFoweVFqcUsxZDBiRWpKbTRubk56UERv?=
 =?utf-8?B?MlRPSmJlcENmbDJ1aTlCV2dEV0JHMWZNR2FlN3lmZGwvNFFBajhWajF2NXBv?=
 =?utf-8?B?S2U5ZFh5ZUZWdUluenpteUl1VEk0TVF2UmV5eU1DZ2gyVW5MYzNyNVg3WmQx?=
 =?utf-8?B?eEFHeWtKK3pHRUt2Z3FydHZmdlUzblMxVS9kTnJTTG8vYXlId0lxYUxhTjFx?=
 =?utf-8?B?UzhBQUVpM3hmODZLaVFZTDQ4MHlpQ2lmRXZpOWxtbC9zUnNJWlhqeFZrd2tr?=
 =?utf-8?B?bWJCUWowL3loVUJiLzJUallkQzZWcHZVU1luZW1yNTBvWlIvRUgrSk1CVndl?=
 =?utf-8?Q?d18S+fMpNQMFj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64ff99d7-4cbb-4cfc-9682-08d90fd54d8a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2021 14:51:45.4933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KZ2xy1pa+8sOPNmU6CBprcCIcKCFpJq/vcrd9KD7d8cJX1d9LM8KhfwJDRsxhZr6jBO8ixBlC6syhTpBpSztLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2397
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Ping

Andrey

On 2021-05-04 11:43 a.m., Andrey Grodzovsky wrote:
> 
> 
> On 2021-05-04 3:03 a.m., Christian König wrote:
>> Am 03.05.21 um 22:43 schrieb Andrey Grodzovsky:
>>>
>>>
>>> On 2021-04-29 3:08 a.m., Christian König wrote:
>>>> Am 28.04.21 um 17:11 schrieb Andrey Grodzovsky:
>>>>> Handle all DMA IOMMU gropup related dependencies before the
>>>>> group is removed.
>>>>>
>>>>> v5: Drop IOMMU notifier and switch to lockless call to 
>>>>> ttm_tt_unpopulate
>>>>
>>>> Maybe split that up into more patches.
>>>>
>>>>>
>>>>> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>>>>> ---
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 ++
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 31 
>>>>> ++++++++++++++++++++--
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c   |  3 +--
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h   |  1 +
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c    |  9 +++++++
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 13 ++++++++-
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  2 ++
>>>>>   drivers/gpu/drm/amd/amdgpu/cik_ih.c        |  1 -
>>>>>   drivers/gpu/drm/amd/amdgpu/cz_ih.c         |  1 -
>>>>>   drivers/gpu/drm/amd/amdgpu/iceland_ih.c    |  1 -
>>>>>   drivers/gpu/drm/amd/amdgpu/navi10_ih.c     |  3 ---
>>>>>   drivers/gpu/drm/amd/amdgpu/si_ih.c         |  1 -
>>>>>   drivers/gpu/drm/amd/amdgpu/tonga_ih.c      |  1 -
>>>>>   drivers/gpu/drm/amd/amdgpu/vega10_ih.c     |  3 ---
>>>>>   14 files changed, 56 insertions(+), 16 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>> index fddb82897e5d..30a24db5f4d1 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>> @@ -1054,6 +1054,8 @@ struct amdgpu_device {
>>>>>       bool                            in_pci_err_recovery;
>>>>>       struct pci_saved_state          *pci_state;
>>>>> +
>>>>> +    struct list_head                device_bo_list;
>>>>>   };
>>>>>   static inline struct amdgpu_device *drm_to_adev(struct drm_device 
>>>>> *ddev)
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> index 46d646c40338..91594ddc2459 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> @@ -70,6 +70,7 @@
>>>>>   #include <drm/task_barrier.h>
>>>>>   #include <linux/pm_runtime.h>
>>>>> +
>>>>>   MODULE_FIRMWARE("amdgpu/vega10_gpu_info.bin");
>>>>>   MODULE_FIRMWARE("amdgpu/vega12_gpu_info.bin");
>>>>>   MODULE_FIRMWARE("amdgpu/raven_gpu_info.bin");
>>>>> @@ -3211,7 +3212,6 @@ static const struct attribute 
>>>>> *amdgpu_dev_attributes[] = {
>>>>>       NULL
>>>>>   };
>>>>> -
>>>>>   /**
>>>>>    * amdgpu_device_init - initialize the driver
>>>>>    *
>>>>> @@ -3316,6 +3316,8 @@ int amdgpu_device_init(struct amdgpu_device 
>>>>> *adev,
>>>>>       INIT_WORK(&adev->xgmi_reset_work, 
>>>>> amdgpu_device_xgmi_reset_func);
>>>>> +    INIT_LIST_HEAD(&adev->device_bo_list);
>>>>> +
>>>>>       adev->gfx.gfx_off_req_count = 1;
>>>>>       adev->pm.ac_power = power_supply_is_system_supplied() > 0;
>>>>> @@ -3601,6 +3603,28 @@ int amdgpu_device_init(struct amdgpu_device 
>>>>> *adev,
>>>>>       return r;
>>>>>   }
>>>>> +static void amdgpu_clear_dma_mappings(struct amdgpu_device *adev)
>>>>> +{
>>>>> +    struct amdgpu_bo *bo = NULL;
>>>>> +
>>>>> +    /*
>>>>> +     * Unmaps all DMA mappings before device will be removed from 
>>>>> it's
>>>>> +     * IOMMU group otherwise in case of IOMMU enabled system a crash
>>>>> +     * will happen.
>>>>> +     */
>>>>> +
>>>>> +    spin_lock(&adev->mman.bdev.lru_lock);
>>>>> +    while (!list_empty(&adev->device_bo_list)) {
>>>>> +        bo = list_first_entry(&adev->device_bo_list, struct 
>>>>> amdgpu_bo, bo);
>>>>> +        list_del_init(&bo->bo);
>>>>> +        spin_unlock(&adev->mman.bdev.lru_lock);
>>>>> +        if (bo->tbo.ttm)
>>>>> +            ttm_tt_unpopulate(bo->tbo.bdev, bo->tbo.ttm);
>>>>> +        spin_lock(&adev->mman.bdev.lru_lock);
>>>>> +    }
>>>>> +    spin_unlock(&adev->mman.bdev.lru_lock);
>>>>
>>>> Can you try to use the same approach as amdgpu_gtt_mgr_recover() 
>>>> instead of adding something to the BO?
>>>>
>>>> Christian.
>>>
>>> Are you sure that dma mappings limit themself only to GTT BOs
>>> which have allocated mm nodes ?
>>
>> Yes, you would also need the system domain BOs. But those can be put 
>> on a similar list.
> 
> What list ? Those BOs don't have ttm_resource_manager and so no
> drm_mm_node list they all bound to. Should I maintain a list for them
> spcifically for the unmap purpuse ?
> 
>>
>>> Otherwsie we will crash and burn
>>> on missing IOMMU group when unampping post device remove.
>>> Problem for me to test this as in 5.12 kernel I don't crash even
>>> when removing this entire patch.  Looks like iommu_dma_unmap_page
>>> was changed since 5.9 when I introdiced this patch.
>>
>> Do we really still need that stuff then? What exactly has changed?
> 
> At first I assumed that because of this change 'iommu: Allow the 
> dma-iommu api to use bounce buffers'
> Which changed iommu_dma_unmap_page to call __iommu_dma_unmap_swiotlb
> instead if __iommu_dma_unmap directly. But then i looked inside
> __iommu_dma_unmap_swiotlb and it still calls __iommu_dma_unmap
> evenetually. So maybe the fact that I moved the amd_ip_funcs.hw_fini
> call to inside amdgpu_pci_remove helps.
> 
> Andrey
> 
> 
>>
>> Christian.
>>
>>>
>>> Andrey
>>>
>>>>
>>>>> +}
>>>>> +
>>>>>   /**
>>>>>    * amdgpu_device_fini - tear down the driver
>>>>>    *
>>>>> @@ -3639,12 +3663,15 @@ void amdgpu_device_fini_hw(struct 
>>>>> amdgpu_device *adev)
>>>>>           amdgpu_ucode_sysfs_fini(adev);
>>>>>       sysfs_remove_files(&adev->dev->kobj, amdgpu_dev_attributes);
>>>>> -
>>>>>       amdgpu_fbdev_fini(adev);
>>>>>       amdgpu_irq_fini_hw(adev);
>>>>>       amdgpu_device_ip_fini_early(adev);
>>>>> +
>>>>> +    amdgpu_clear_dma_mappings(adev);
>>>>> +
>>>>> +    amdgpu_gart_dummy_page_fini(adev);
>>>>>   }
>>>>>   void amdgpu_device_fini_sw(struct amdgpu_device *adev)
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
>>>>> index fde2d899b2c4..49cdcaf8512d 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
>>>>> @@ -92,7 +92,7 @@ static int amdgpu_gart_dummy_page_init(struct 
>>>>> amdgpu_device *adev)
>>>>>    *
>>>>>    * Frees the dummy page used by the driver (all asics).
>>>>>    */
>>>>> -static void amdgpu_gart_dummy_page_fini(struct amdgpu_device *adev)
>>>>> +void amdgpu_gart_dummy_page_fini(struct amdgpu_device *adev)
>>>>>   {
>>>>>       if (!adev->dummy_page_addr)
>>>>>           return;
>>>>> @@ -397,5 +397,4 @@ void amdgpu_gart_fini(struct amdgpu_device *adev)
>>>>>       vfree(adev->gart.pages);
>>>>>       adev->gart.pages = NULL;
>>>>>   #endif
>>>>> -    amdgpu_gart_dummy_page_fini(adev);
>>>>>   }
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
>>>>> index afa2e2877d87..5678d9c105ab 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
>>>>> @@ -61,6 +61,7 @@ int amdgpu_gart_table_vram_pin(struct 
>>>>> amdgpu_device *adev);
>>>>>   void amdgpu_gart_table_vram_unpin(struct amdgpu_device *adev);
>>>>>   int amdgpu_gart_init(struct amdgpu_device *adev);
>>>>>   void amdgpu_gart_fini(struct amdgpu_device *adev);
>>>>> +void amdgpu_gart_dummy_page_fini(struct amdgpu_device *adev);
>>>>>   int amdgpu_gart_unbind(struct amdgpu_device *adev, uint64_t offset,
>>>>>                  int pages);
>>>>>   int amdgpu_gart_map(struct amdgpu_device *adev, uint64_t offset,
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>>>>> index 63e815c27585..a922154953a7 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>>>>> @@ -326,6 +326,15 @@ void amdgpu_irq_fini_hw(struct amdgpu_device 
>>>>> *adev)
>>>>>           if (!amdgpu_device_has_dc_support(adev))
>>>>>               flush_work(&adev->hotplug_work);
>>>>>       }
>>>>> +
>>>>> +    if (adev->irq.ih_soft.ring)
>>>>> +        amdgpu_ih_ring_fini(adev, &adev->irq.ih_soft);
>>>>> +    if (adev->irq.ih.ring)
>>>>> +        amdgpu_ih_ring_fini(adev, &adev->irq.ih);
>>>>> +    if (adev->irq.ih1.ring)
>>>>> +        amdgpu_ih_ring_fini(adev, &adev->irq.ih1);
>>>>> +    if (adev->irq.ih2.ring)
>>>>> +        amdgpu_ih_ring_fini(adev, &adev->irq.ih2);
>>>>>   }
>>>>>   /**
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>>> index 485f249d063a..62d829f5e62c 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>>> @@ -68,8 +68,13 @@ static void amdgpu_bo_destroy(struct 
>>>>> ttm_buffer_object *tbo)
>>>>>           list_del_init(&bo->shadow_list);
>>>>>           mutex_unlock(&adev->shadow_list_lock);
>>>>>       }
>>>>> -    amdgpu_bo_unref(&bo->parent);
>>>>> +
>>>>> +    spin_lock(&adev->mman.bdev.lru_lock);
>>>>> +    list_del(&bo->bo);
>>>>> +    spin_unlock(&adev->mman.bdev.lru_lock);
>>>>> +
>>>>> +    amdgpu_bo_unref(&bo->parent);
>>>>>       kfree(bo->metadata);
>>>>>       kfree(bo);
>>>>>   }
>>>>> @@ -585,6 +590,12 @@ static int amdgpu_bo_do_create(struct 
>>>>> amdgpu_device *adev,
>>>>>       if (bp->type == ttm_bo_type_device)
>>>>>           bo->flags &= ~AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
>>>>> +    INIT_LIST_HEAD(&bo->bo);
>>>>> +
>>>>> +    spin_lock(&adev->mman.bdev.lru_lock);
>>>>> +    list_add_tail(&bo->bo, &adev->device_bo_list);
>>>>> +    spin_unlock(&adev->mman.bdev.lru_lock);
>>>>> +
>>>>>       return 0;
>>>>>   fail_unreserve:
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>>>>> index 9ac37569823f..5ae8555ef275 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>>>>> @@ -110,6 +110,8 @@ struct amdgpu_bo {
>>>>>       struct list_head        shadow_list;
>>>>>       struct kgd_mem                  *kfd_bo;
>>>>> +
>>>>> +    struct list_head        bo;
>>>>>   };
>>>>>   static inline struct amdgpu_bo *ttm_to_amdgpu_bo(struct 
>>>>> ttm_buffer_object *tbo)
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/cik_ih.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
>>>>> index 183d44a6583c..df385ffc9768 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/cik_ih.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
>>>>> @@ -310,7 +310,6 @@ static int cik_ih_sw_fini(void *handle)
>>>>>       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>>>>       amdgpu_irq_fini_sw(adev);
>>>>> -    amdgpu_ih_ring_fini(adev, &adev->irq.ih);
>>>>>       amdgpu_irq_remove_domain(adev);
>>>>>       return 0;
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/cz_ih.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
>>>>> index d32743949003..b8c47e0cf37a 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/cz_ih.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
>>>>> @@ -302,7 +302,6 @@ static int cz_ih_sw_fini(void *handle)
>>>>>       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>>>>       amdgpu_irq_fini_sw(adev);
>>>>> -    amdgpu_ih_ring_fini(adev, &adev->irq.ih);
>>>>>       amdgpu_irq_remove_domain(adev);
>>>>>       return 0;
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
>>>>> index da96c6013477..ddfe4eaeea05 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
>>>>> @@ -301,7 +301,6 @@ static int iceland_ih_sw_fini(void *handle)
>>>>>       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>>>>       amdgpu_irq_fini_sw(adev);
>>>>> -    amdgpu_ih_ring_fini(adev, &adev->irq.ih);
>>>>>       amdgpu_irq_remove_domain(adev);
>>>>>       return 0;
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
>>>>> index 5eea4550b856..e171a9e78544 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
>>>>> @@ -571,9 +571,6 @@ static int navi10_ih_sw_fini(void *handle)
>>>>>       amdgpu_irq_fini_sw(adev);
>>>>>       amdgpu_ih_ring_fini(adev, &adev->irq.ih_soft);
>>>>> -    amdgpu_ih_ring_fini(adev, &adev->irq.ih2);
>>>>> -    amdgpu_ih_ring_fini(adev, &adev->irq.ih1);
>>>>> -    amdgpu_ih_ring_fini(adev, &adev->irq.ih);
>>>>>       return 0;
>>>>>   }
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/si_ih.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/si_ih.c
>>>>> index 751307f3252c..9a24f17a5750 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/si_ih.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/si_ih.c
>>>>> @@ -176,7 +176,6 @@ static int si_ih_sw_fini(void *handle)
>>>>>       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>>>>       amdgpu_irq_fini_sw(adev);
>>>>> -    amdgpu_ih_ring_fini(adev, &adev->irq.ih);
>>>>>       return 0;
>>>>>   }
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
>>>>> index 973d80ec7f6c..b08905d1c00f 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
>>>>> @@ -313,7 +313,6 @@ static int tonga_ih_sw_fini(void *handle)
>>>>>       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>>>>       amdgpu_irq_fini_sw(adev);
>>>>> -    amdgpu_ih_ring_fini(adev, &adev->irq.ih);
>>>>>       amdgpu_irq_remove_domain(adev);
>>>>>       return 0;
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
>>>>> index 2d0094c276ca..8c8abc00f710 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
>>>>> @@ -525,9 +525,6 @@ static int vega10_ih_sw_fini(void *handle)
>>>>>       amdgpu_irq_fini_sw(adev);
>>>>>       amdgpu_ih_ring_fini(adev, &adev->irq.ih_soft);
>>>>> -    amdgpu_ih_ring_fini(adev, &adev->irq.ih2);
>>>>> -    amdgpu_ih_ring_fini(adev, &adev->irq.ih1);
>>>>> -    amdgpu_ih_ring_fini(adev, &adev->irq.ih);
>>>>>       return 0;
>>>>>   }
>>>>
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Candrey.grodzovsky%40amd.com%7C1cee392c0b934cda6c7608d90ecabc41%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637557086175078458%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=C8QBsUQhJa1eWV1YYdQaykUVQGwmCn6OIoWQSrDkWoU%3D&amp;reserved=0 
>>
