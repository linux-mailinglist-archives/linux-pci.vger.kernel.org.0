Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA1BB36FE48
	for <lists+linux-pci@lfdr.de>; Fri, 30 Apr 2021 18:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbhD3QLu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Apr 2021 12:11:50 -0400
Received: from mail-bn1nam07on2074.outbound.protection.outlook.com ([40.107.212.74]:53254
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229579AbhD3QLu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 30 Apr 2021 12:11:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=imEHx81Vh2V48KsA9UZ4vFcY4cRycd6EOWVP6ubze59HqKY4fnmg0uzrRbzqQCQ2Qy04gcsdLI6vhVV+JeN7HMP6G+bm0hEsMosHBmemGASyn+F4iXwbvUvV23DlUPP9sLfYKkFPhCfzQdeX7vhUAZ49ET8+GLni0bYrK+LJorVtC1NFkRrV5e+D6H6npw+pZyY6PAls07Y6JiwEAbKuB4W/YKPR/3I9VdJkTrI4gaLomhMbws2dSrBx8eagX/cT6hRIPr6aXVy3pBz1hj7iAODeUZ5imMHSheDMnwpcAp2n1NAsqZf/jAU2YJo29POuiRdjOoW5mWdRpKqF8dDU3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xeG/S8C2nbztHwYZfZ0eWBMLcqrBY9UsOCfrthgI5rQ=;
 b=JRlHvxjgONJxqt7A0gcNBTRE5i80k2y9TneUbxaLohCw0RYTI+nRNDwdrASlSPJys3As5gK75NzFEukQlvwSofJCUdgHYiwm5OnCmlAGJxDkJ8BvtJQVbmYvWjYk9YTXWBXXBXoLX8j30jim70h8+ZUj1DXUz/lvmI94qf9EZVqsgasmXTa01K0vLp6sEoKPM18SpuTNa68y8Bt2yWjWJFMLuG3XGlbegRd3RKU3NLJvDGFebw58vCe5XuT3An+Dm6g+ioV3oITQA4Hk2+cagsFDPwdY+0ld9ntJy6+5I/9BnXCXdxvCM5X1VfMeAt1i8PC4wNfiF7/wuHR8gwbCBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xeG/S8C2nbztHwYZfZ0eWBMLcqrBY9UsOCfrthgI5rQ=;
 b=b9dDPmScTXNkHwWipZJYUJC1uu7EUkLzHF1/Xdt3dNsNQ/yB4CaOQdU0bMfFdb2+LBdLdYSH5bCbFkAx1TpG5gpWqoFLAFI3qQ6APkP5wveiwkQzvcSgDvX55lVIQLG3dkLYgD70fS5kdtwjcj6nSnUqtKByBGXNyF1nrdcrFvU=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SN6PR12MB2815.namprd12.prod.outlook.com (2603:10b6:805:78::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Fri, 30 Apr
 2021 16:11:00 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::ad51:8c49:b171:856c]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::ad51:8c49:b171:856c%7]) with mapi id 15.20.4065.033; Fri, 30 Apr 2021
 16:11:00 +0000
Subject: Re: [PATCH v5 15/27] drm/scheduler: Fix hang when sched_entity
 released
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-pci@vger.kernel.org, daniel.vetter@ffwll.ch,
        Harry.Wentland@amd.com
Cc:     ppaalanen@gmail.com, Alexander.Deucher@amd.com,
        gregkh@linuxfoundation.org, helgaas@kernel.org,
        Felix.Kuehling@amd.com
References: <20210428151207.1212258-1-andrey.grodzovsky@amd.com>
 <20210428151207.1212258-16-andrey.grodzovsky@amd.com>
 <a8314d77-578f-e0df-5c49-77d5f10c76c7@amd.com>
 <9cb771f2-d52f-f14e-f3d4-b9488b353ae3@amd.com>
 <0c598888-d7d4-451a-3d4a-01c46ddda397@gmail.com>
From:   Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <a704880d-8e27-3cca-f42b-1320d39ac503@amd.com>
Date:   Fri, 30 Apr 2021 12:10:57 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <0c598888-d7d4-451a-3d4a-01c46ddda397@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2607:fea8:3edf:49b0:28bc:ce08:83b6:6c00]
X-ClientProxiedBy: YT2PR01CA0022.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::27) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:28bc:ce08:83b6:6c00] (2607:fea8:3edf:49b0:28bc:ce08:83b6:6c00) by YT2PR01CA0022.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:38::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25 via Frontend Transport; Fri, 30 Apr 2021 16:10:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d117d2b5-72ab-47ab-26f7-08d90bf28b45
X-MS-TrafficTypeDiagnostic: SN6PR12MB2815:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2815664446CAACD9330BB40CEA5E9@SN6PR12MB2815.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zKiSQVLfbNd33BQ5yezNENgUrx9g1aEMotH2/GL0RSCnpo4I/t2F0VhuU+HO/743cmzd4H20ngpnyjz80MfgClmhk5udVG5gkkbf8bDYVuugAbwwJ9R9gan8sdrDVOuZZUDG4u0RD9wH9CelS/vcHort7c6T7qzdiE7FviRcgQwsJ7dM6FfRPt2gafxDs8AUkKWXsh7P10fTJ+W7KKaJtGDiSElAMgVY0KO+U8ffojvlkvQ7yBudq5vgK+oulAtgZkIwD51ZmECu98XCFHomwjw8d3vxObcN8H5EWS8ayrtRsR4Vl+jr3mVcuwF49F3E30bpBnu11x3v8w/nfJNsdiJwfaZRP9DPBnzxz1DCXIDG8eFNqL2KUT4xMWfHUjSsXC8NoR8k+g32n8xc68xs7focSk2CtEYB99NrhoS9+zQ1yI8u0QN8JlDynMhFz7yUoRGXaZL0eqfj3BDB5WIijuvUufq0z6b0HVwe0uG9Jr5pI03qqZ5D87QOmqM8JmNia+Fomc2fuTGnn77VyTBlnsQqWpEECZNYy5+07l1N0MrlRKckPN7Dbrzt00vBgbLPXVkhwcZGODJ/rQ8Mtj60U9oY9az64A6ConR+ihDlT1F7+xeSGe2dx+LjCvjabx9S6y200fP7YX9eNN9keysvyTgVvnxtZTipMps/tnx/GeoaCCgCo1LGIrqo1EBQaooP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB4623.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(346002)(366004)(39860400002)(66476007)(8676002)(66946007)(66574015)(66556008)(38100700002)(110136005)(31686004)(478600001)(53546011)(316002)(6486002)(36756003)(4326008)(86362001)(16526019)(186003)(52116002)(5660300002)(8936002)(83380400001)(6636002)(44832011)(2906002)(31696002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bEZmVHk4MXVvMkVjUSthREUyYXNkVGtjV1hMbDlaYzQ4OG40L3BxUVJuNW04?=
 =?utf-8?B?ejFjeGNpUG43WWZpdVNUZ2xFMXBEN3RQWlIzQU5hWi9pL0Y2cVNEeXBNbDdr?=
 =?utf-8?B?b1E4TXhVSDV5bzBvTVpnaGNxWkhnTkswak5hcnpQMW8vcmkxZTgrUjBBTmQ1?=
 =?utf-8?B?V2RqcXBBWndjNVNWS3hPZWhWV3NJUUx3ZXI2VGtVc05PWERTWjVjY1hUZEo1?=
 =?utf-8?B?SU5mT2diaFRYOGM3L0x0a1cwNWQvU2xGdDcySEY4V01xZjJleUkwbDNvejR1?=
 =?utf-8?B?S0JqVG55RUx2eXZDVXR2M21nVlVObS9nNVNnNUdPbmtjMnlnenJoQUFJY0Q1?=
 =?utf-8?B?UktjOHlrVE02MmZhTnBBSFU0YUZRMjVwMHM2L24yZ2NrNi9DNTJMUndRODZz?=
 =?utf-8?B?Rk1Fb1RKMXVQcnFSaXFoRzQ2eFg0cXlzZVBhdi9TUlJSR01rWEFhZllIYmhY?=
 =?utf-8?B?U1BoeDgyOGY3Y3hCNWVCS2l3WFNNWkFvZDl5bjlRQU9JWTBDcHo5SmhKYUI0?=
 =?utf-8?B?dkdIUUk2YTRXcXlWUGF6cTJEQ243M2ZqeDBMM3NQNnU2UlRjMjN4c202U0tv?=
 =?utf-8?B?QUM2MFh5WVkvT2wreUYvQ2JIZmVJRWRHdnZhQlFUMkMxMGJWUTlJT1Y3QUNZ?=
 =?utf-8?B?NW0yVHBNOWw1Q1c3U1hrVEpRRG1RVnlTMGpGS3ZkL2hiWFFTR3dSVklocHI5?=
 =?utf-8?B?di9WUmpBQXJPMHRHRzBPRkh1N3BHQWtaRXlwWVlpejFYQXBScmx1VitOY2R5?=
 =?utf-8?B?Tk1ONkJOdkJZRUNPK25YUVkzTU9FUW1jVSsxL2dLb0JRYXJYY1VnYUR0c2FK?=
 =?utf-8?B?ODFieWRKZ0FhZjN4aEs4OG81a2hMUXgvMGZ0Ymd0NUl0cDliNnNGK0NvL25L?=
 =?utf-8?B?bGg4cUx0a1l4eDZBemc3Wmc0NE94QlQ3bDBkdkViRy9YNjlQWU1kKzY1UVc2?=
 =?utf-8?B?MmEveGlGOVc5K01uV1c0aisxSTZseG1JUXhYUVBpWHpGNkt2K0t3aGJVUjlH?=
 =?utf-8?B?U1Q5bmZjVEFWcmJPald4ZWVtNSt0R2ErZ3Q5ZXMzczVSa1lLTzRORDlDdUhG?=
 =?utf-8?B?SGJKN3FJSDYxQkxMQWwvOW40WjhzZDBxOUpXWEVQNFkvd1EwYklISmFLQjNs?=
 =?utf-8?B?VTVqY1NzYjNGMVl5dDhMaDVVRGFDKzJxVUtRcEpLTStJeVBReW1HTXoreFg2?=
 =?utf-8?B?bTVKaGNObGtneVF5ZGRKVTg5YnNjNU9lSlJxNVVkcGRLOUZCZkZwbVM0dWhO?=
 =?utf-8?B?YXRJOHlicmpIdFIxMHdiVVdHRDJTYmFoRG44aGQ0ZmdPMEFLWmdMVWRtVTBO?=
 =?utf-8?B?RVNjdnFZRmUxdHE3MDBTMWEvVnJTYW84ZzA4bUpQM3BZZEFmdUlQM0hJQll6?=
 =?utf-8?B?RlJseHlBU3RVZVhhSmJjYitmWlBwLzQ4aGxBTUdxZmxkSUtHbHppWUZEYm1w?=
 =?utf-8?B?Q3JTOGoyWTQzWWpraWYzTG9qR0xwV25NZlpWd2RBZ2hqWVNZRmdDRkxqM0Ev?=
 =?utf-8?B?enU4UENCeTlvZXlobXFjeGpiWC84djhOUWZhSG9BREZpU2F1ZkZ1aXNoV1hK?=
 =?utf-8?B?aFcrdUEvV29uY3pmZVo2alNCRDJ1YVBWYjNsczR2QzJJazhKdDF4aGZaaHZD?=
 =?utf-8?B?Ukh6eUd1S05BbXh0WGx5R1Ztb0t1emJvU1hYV1loUm93R2FLWnVkNDh2VnV4?=
 =?utf-8?B?Z2dKcjRzdEFBbFp4cTBsUVI5K1JDOHdvQ2R5aVJTZHFieGFnMnRjczROQnpG?=
 =?utf-8?B?WUIrRlpBUlY1TDd1ZWhaSmpqUGRLVFBHNEh4anZZRTIyeTJPY3pEZ0JCQWQz?=
 =?utf-8?B?ZWszMk5qbVpjOEgranZIL0ZmMXNSTnpZSWtrLy9nU3NjcXh4MjJicHN2c2xy?=
 =?utf-8?Q?+1OzJIBVv8X91?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d117d2b5-72ab-47ab-26f7-08d90bf28b45
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2021 16:10:59.9100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tqq1363qkyYf1wr7aRUhGSVqLGLy/eJafNsi/EnnvLbhzKswtsGObASrN5yLAgZFTmANBpY7Ci9FPnclHsCfsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2815
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2021-04-30 2:47 a.m., Christian König wrote:
> 
> 
> Am 29.04.21 um 19:06 schrieb Andrey Grodzovsky:
>>
>>
>> On 2021-04-29 3:18 a.m., Christian König wrote:
>>> I need to take another look at this part when I don't have a massive 
>>> headache any more.
>>>
>>> Maybe split the patch set up into different parts, something like:
>>> 1. Adding general infrastructure.
>>> 2. Making sure all memory is unpolated.
>>> 3. Job and fence handling
>>
>> I am not sure you mean this patch here, maybe another one ?
>> Also note you already RBed it.
> 
> No what I meant was to send out the patches before this one as #1 and #2.
> 
> That is the easier stuff which can easily go into the drm-misc-next or 
> amd-staging-drm-next branch.
> 
> The scheduler stuff certainly need to go into drm-misc-next.
> 
> Christian.

Got you. I am fine with it. What we have here is a working hot-unplug
code but, one with potential use after free MMIO ranges frpom the zombie
device. The followup patches after this patch are all about preventing
this and so the patch-set up until this patch including, is functional
on it's own. While it's necessary to solve the above issue, it's has
complications as can be seen from the discussion with Daniel on later
patch in this series. Still, in my opinion it's better to rollout some
initial support to hot-unplug without use after free protection then
having no support for hot-unplug at all. It will also make the merge
work easier as I need to constantly rebase the patches on top latest
kernel and solve new regressions.

Daniel - given the arguments above can you sound your opinion on this
approach ?

Andrey
> 
>>
>> Andrey
>>
>>>
>>> Christian.
>>>
>>> Am 28.04.21 um 17:11 schrieb Andrey Grodzovsky:
>>>> Problem: If scheduler is already stopped by the time sched_entity
>>>> is released and entity's job_queue not empty I encountred
>>>> a hang in drm_sched_entity_flush. This is because 
>>>> drm_sched_entity_is_idle
>>>> never becomes false.
>>>>
>>>> Fix: In drm_sched_fini detach all sched_entities from the
>>>> scheduler's run queues. This will satisfy drm_sched_entity_is_idle.
>>>> Also wakeup all those processes stuck in sched_entity flushing
>>>> as the scheduler main thread which wakes them up is stopped by now.
>>>>
>>>> v2:
>>>> Reverse order of drm_sched_rq_remove_entity and marking
>>>> s_entity as stopped to prevent reinserion back to rq due
>>>> to race.
>>>>
>>>> v3:
>>>> Drop drm_sched_rq_remove_entity, only modify entity->stopped
>>>> and check for it in drm_sched_entity_is_idle
>>>>
>>>> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>>>> Reviewed-by: Christian König <christian.koenig@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/scheduler/sched_entity.c |  3 ++-
>>>>   drivers/gpu/drm/scheduler/sched_main.c   | 24 
>>>> ++++++++++++++++++++++++
>>>>   2 files changed, 26 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c 
>>>> b/drivers/gpu/drm/scheduler/sched_entity.c
>>>> index f0790e9471d1..cb58f692dad9 100644
>>>> --- a/drivers/gpu/drm/scheduler/sched_entity.c
>>>> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
>>>> @@ -116,7 +116,8 @@ static bool drm_sched_entity_is_idle(struct 
>>>> drm_sched_entity *entity)
>>>>       rmb(); /* for list_empty to work without lock */
>>>>       if (list_empty(&entity->list) ||
>>>> -        spsc_queue_count(&entity->job_queue) == 0)
>>>> +        spsc_queue_count(&entity->job_queue) == 0 ||
>>>> +        entity->stopped)
>>>>           return true;
>>>>       return false;
>>>> diff --git a/drivers/gpu/drm/scheduler/sched_main.c 
>>>> b/drivers/gpu/drm/scheduler/sched_main.c
>>>> index 908b0b56032d..ba087354d0a8 100644
>>>> --- a/drivers/gpu/drm/scheduler/sched_main.c
>>>> +++ b/drivers/gpu/drm/scheduler/sched_main.c
>>>> @@ -897,9 +897,33 @@ EXPORT_SYMBOL(drm_sched_init);
>>>>    */
>>>>   void drm_sched_fini(struct drm_gpu_scheduler *sched)
>>>>   {
>>>> +    struct drm_sched_entity *s_entity;
>>>> +    int i;
>>>> +
>>>>       if (sched->thread)
>>>>           kthread_stop(sched->thread);
>>>> +    for (i = DRM_SCHED_PRIORITY_COUNT - 1; i >= 
>>>> DRM_SCHED_PRIORITY_MIN; i--) {
>>>> +        struct drm_sched_rq *rq = &sched->sched_rq[i];
>>>> +
>>>> +        if (!rq)
>>>> +            continue;
>>>> +
>>>> +        spin_lock(&rq->lock);
>>>> +        list_for_each_entry(s_entity, &rq->entities, list)
>>>> +            /*
>>>> +             * Prevents reinsertion and marks job_queue as idle,
>>>> +             * it will removed from rq in drm_sched_entity_fini
>>>> +             * eventually
>>>> +             */
>>>> +            s_entity->stopped = true;
>>>> +        spin_unlock(&rq->lock);
>>>> +
>>>> +    }
>>>> +
>>>> +    /* Wakeup everyone stuck in drm_sched_entity_flush for this 
>>>> scheduler */
>>>> +    wake_up_all(&sched->job_scheduled);
>>>> +
>>>>       /* Confirm no work left behind accessing device structures */
>>>>       cancel_delayed_work_sync(&sched->work_tdr);
>>>
> 
