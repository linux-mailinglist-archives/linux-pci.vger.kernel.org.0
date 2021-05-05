Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9315B373CC5
	for <lists+linux-pci@lfdr.de>; Wed,  5 May 2021 15:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233324AbhEEN6F (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 May 2021 09:58:05 -0400
Received: from mail-co1nam11on2066.outbound.protection.outlook.com ([40.107.220.66]:14560
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233178AbhEEN6E (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 May 2021 09:58:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ORM//lCXu8zyuHlbtTv7fEKVr5VFpzVka4nx0YnjdrJrwZ0eVqdJqEcN8mY2dBrKjFU/JaLLAfTDsLvzUMVdosRKXpeLjn+MUbWvDt/RlnvQr6Zw3lE2rrKYgGNgewQJQYGe6uVXPZtzYSO+emvaEqkZ5Ni0+zWuGkyiqYmwYWYt6VQwEExCbiVSk7ouJA1BorsXHcEMmvW6sn/crlFdVFZGRXxATXylGM3lkHrJoCQ5Ik2qC+ZGjlB4otNtT0VWNWzT3QEyU6NQdBU5heaTsyK+/LRNE/Yh15O+L4y+APidSAhy3FCPFArLA9kFv65QnnhiG9UI4UmXjfE1aLl0Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s7yOAoEW9384c/VQ5GzWY5AMZ/9mJiDk9JTnJQk5Ac4=;
 b=Dnfo1BIoHrafZKBLKZ6ZUffH/KZOPVKwte0zlTbFwcLHHd5/AXpOpdygmOmH3xE60e4UK74rsj9KAYeu+6RCDWi6UCRXm50059QVpd+Dqd8YnB8yTjsYJnwUijcYoH8OTOdPRrUV597lDFmmCXO1YszEQ2Ot75CPrlcKZG6Qd5N60JLbRd5C/fb7SnM90hvNHdHkK/NT9H6hwXMBnPTbASR0uzM6uTpXWQA0vRY5teQjdUwJYM8+klj7bBqaPsZuzJOF1h8F+itJVeHbL+1mxQV2/SkCaZqM16cZ+bcBhyNypA9EpJoToNtvLDtoryvkoETfyIFXFUs7kADC0RMikA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s7yOAoEW9384c/VQ5GzWY5AMZ/9mJiDk9JTnJQk5Ac4=;
 b=2BGhe6rHXs/AAO3ZGklJ8cOX8cbRjIXIk2vM2s2OakLgilj+Na68Atrht2oW4DljRQ6AjyuzQb+kOIXQT4JnmDGMzUZFaEg07nhWxf59v9KCTPkbHiIOiSml9p1XbzTGYHos9lbZjFCIM8DREHcHFqDSj87ZavekcP4tRPU+Mxg=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SN6PR12MB2656.namprd12.prod.outlook.com (2603:10b6:805:67::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.44; Wed, 5 May
 2021 13:57:06 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::ad51:8c49:b171:856c]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::ad51:8c49:b171:856c%7]) with mapi id 15.20.4108.026; Wed, 5 May 2021
 13:57:06 +0000
Subject: Re: [PATCH v5 15/27] drm/scheduler: Fix hang when sched_entity
 released
From:   Andrey Grodzovsky <andrey.grodzovsky@amd.com>
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
 <a704880d-8e27-3cca-f42b-1320d39ac503@amd.com>
Message-ID: <aa42d956-7bcb-9c90-ba5f-12ab701548dd@amd.com>
Date:   Wed, 5 May 2021 09:57:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <a704880d-8e27-3cca-f42b-1320d39ac503@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2607:fea8:3edf:49b0:7d63:ab2e:d405:e927]
X-ClientProxiedBy: YT1PR01CA0047.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::16) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:7d63:ab2e:d405:e927] (2607:fea8:3edf:49b0:7d63:ab2e:d405:e927) by YT1PR01CA0047.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.41 via Frontend Transport; Wed, 5 May 2021 13:57:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7472e6e3-3219-4d1b-65db-08d90fcdaaf1
X-MS-TrafficTypeDiagnostic: SN6PR12MB2656:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2656DA82529F2E7611FC93D4EA599@SN6PR12MB2656.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3hVa0Xqc/xV8bvw7gFSAnAOQng/+OdajNi2Rzxwp634Y3MWnbkEe63kycFHz2Q/Sd2QciOxuBK+3aR9treF4fINS9771c5Pg0Mq4myUThJr64uR5O8NioOidvq0S6HjuSX32689qZddcUFd7coRw+mL+se8mXj/J70shw2/qu4vQV5+L5eB+iLWoom4IfB9NEfq8PpxHodmYxFlswRJF16KdhzWVZ+fheSuPNeOllXgfCiN87OWH15ic4y4aUe5FAlmD+5Cp5Y7uXj/94/KXQK/VYwLl8WZdLtDb0WJVutW56U/ozWSJUfg8K+z8SYaXYnMNqOQXn4ZHYk3tw9R5tQzPym/9sJhJoYRDQsDtOwfjE9gpvi0g6uBozFt1naZ8g5pfQrk/dItkuHXBMk1jsWJPpo9qS8awbcFb+Jlx703eEl6Jgj99XEd0EMcEX938BY/rOQND5jAVH3cnXhKeQVgVnR2om6O3ppcdKu0Lin8nW9+av3T603FEwXhLWPOvdwaRZty7/5231vNXba/nZwixVhsHFN1XAcXX8jNc00DvbTQsycGyBxWOtAS5r6rD8r2/+Leg+Hmn8+xFZ1gfbzDGaXoG22WS7x0wXT4JjMgpKFbOdl3vvK3bPEVu/j2mNHPJJcxXaVhhQGylOjsawqjA5kwfq2n6QxAs8cqiyrTL6v6QB7RBBj6E2+XVlf9J
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB4623.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(346002)(136003)(396003)(366004)(110136005)(38100700002)(83380400001)(53546011)(31686004)(31696002)(36756003)(2906002)(16526019)(6636002)(86362001)(4326008)(66946007)(8676002)(44832011)(66574015)(186003)(6486002)(478600001)(316002)(66476007)(5660300002)(2616005)(8936002)(66556008)(52116002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?QWQ3OFZQQnBGYllxZGNZMGdHa1ZFRmFzOW45SkppR3lsOEs3OTVsN1Y3SjJ1?=
 =?utf-8?B?UXFMUmROek1tNzY2R0FHYUZZcEw2WEdrVnFXZmt2VzQ0NktqTWhlc1R6UFBi?=
 =?utf-8?B?YWZDaEoxcjJ4MlVTU0djL01JczhhZThGdHgvM0FXTFloMVB6N0pXaUpQMUs0?=
 =?utf-8?B?QzJGWTNwMnBIRXFEY2JWV3RzMHRIUnB5STZ2YVczMWZmSFNQc3lGTDBsYXRk?=
 =?utf-8?B?UVV2SkFNT240VlNvQUNydUNXYjV5bGpRanVrSjd6ci9iVDhKMlNma1Zxb3hw?=
 =?utf-8?B?aTdYZkVDb3JZdkpNSitVekZnSWdrVDBnbWFGcTUwUHdadXlWY3Jzazlpb2ZC?=
 =?utf-8?B?UHBYSEx4Z3BsalJLWjAxcXVYSS9FYjNpWkRBYXNHQ0EwcE81WEcrdTRJSVhL?=
 =?utf-8?B?UzJGaU5nVUk3UlVWaFltdjkrd0RXUHlHRWdyaW5ISlpCTkMvTzIyTFdSWVk3?=
 =?utf-8?B?dGhmZEloRjZBbFVNanpGOUQvRXdVYlVqclRWZ2g2cllEaTVRLzZ5Z1haUGFL?=
 =?utf-8?B?dVl2SlVmT1JHdzB1dDZqcEg2aEpLVHhMZWYra0Nwa3lHSW9qUklGRGRXeXNm?=
 =?utf-8?B?N3ZlcllNc2VKNHhTUVJmNjlUeFN3bThYRVJmaHJVZlRMUVZJMWdNdHZxNzZH?=
 =?utf-8?B?T1FEL285NlNvcmpBeVZDZHNwL1l0Y1FxSmJMN3RuQmlnb0dVYVh1dG9vWjV2?=
 =?utf-8?B?NlROUjlDZmMvblE5T1luait2VGtJTHVQSHhnc2oxTkd6dFBqQkdKT1lQUzIz?=
 =?utf-8?B?SllsMUVHWUlWUkJJWVFPSndxd25QQTZnRWhWc2F5NlNkcVhjMkdJUkZMN1lp?=
 =?utf-8?B?Yyt1QUlkZ0pjQ201Q09vL3BjejZ0Unc1Ti85N1lyMWxsb0Q2alZKbExTcDZO?=
 =?utf-8?B?dEdXTldwTmwxTDNEZCt2c2RNQ3dXQmE4ZUtlcXFrU3VkcWNFQ2lHOURvTVRQ?=
 =?utf-8?B?Zlk3eFlZM3IrU2wxc25SWnRWVzVTbzd2NUNySHVKQ1cvTnEzMXFMcnFqTXhB?=
 =?utf-8?B?ZXY5dU1WenZuT01sUXcwSG1ia2ZhZTBETFFaQjBFZStsdkhraTdsQ2xlSGhq?=
 =?utf-8?B?em9MUEFvN1h0d204TmRzTm1xdWU0OG01SHBDRXRORWY5Vm5TWGtqeitUME5o?=
 =?utf-8?B?eDdTaWFTalJEZ2wycmErM0trWExFcU1kbFZmNkc3cWpoSEw0a0RZaFA1MWQ4?=
 =?utf-8?B?eW5SZWlGVXB5UTIxMTJyWUZDRU8rTTlMVm9oejZMOWdoQno3NWU2cWRvSk1m?=
 =?utf-8?B?STA3OG8xd1NFVmpBcHduZjI0WUxVM3pvcmRHdU96dTIxalNKQjZiOFplNFQ4?=
 =?utf-8?B?RSt0ajFaUlo1Z1docm9zVWNuaFVMcmVoZVlEaFBwejFTdHI0ais0T2IzbCs4?=
 =?utf-8?B?MHpiU0VKaFVHYzc1T2ZGRENPb1FVSDVJVUhWSjk4bEp5ZzFydFliOXE4S2Vs?=
 =?utf-8?B?WS81S2s0N3cxS2Q4b3BmcTA1azl4V1J5SFVUamIxNTk5M3NJUjM5eFJnM3RG?=
 =?utf-8?B?T3pQVnpkVHZTZmNpTGd3eEdPTUJ1NW8raU9qMWRXK0xsVXRMdlBRVjJvalIx?=
 =?utf-8?B?TVFncC9uSktCQ0F4ZU9qTjAvTFNXUWtVVGVnM2oyK29Mekg4ZkplSmJMYllN?=
 =?utf-8?B?a0pjWEk1V3d3S2syVTNsbTRIdHRUS2MxcTdxZWhJdFpxcGR3a2dJQnI1dnJn?=
 =?utf-8?B?cGZJbVVrYloyTTcvcWZDdzRWdjI1cjZ6QkR0OFBWT2pGdHdwUkpraktjVE9Q?=
 =?utf-8?B?SExGM0pZczRnM2ZWRVNvN3ZrdWlleWtOb2Jud281bFE0VzhiWHdhZWhZRk1T?=
 =?utf-8?B?RmVGWkxTTGY4ZXdwZ05Qc3ZUa2VvQjVwVVcxYVk4VjVJSE04YjY5UXgxZjJw?=
 =?utf-8?Q?Y7FXGRlp8Prvv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7472e6e3-3219-4d1b-65db-08d90fcdaaf1
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2021 13:57:06.3043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nqVwTy2Sw/aK+2gsKGzGywG0za2uq/IKTti2J6mVQxQZLyMgoAfWOE2pQVTGYBiw1m6kDz1pPx1cVqMVAXiIFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2656
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Ping

Andrey

On 2021-04-30 12:10 p.m., Andrey Grodzovsky wrote:
> 
> 
> On 2021-04-30 2:47 a.m., Christian König wrote:
>>
>>
>> Am 29.04.21 um 19:06 schrieb Andrey Grodzovsky:
>>>
>>>
>>> On 2021-04-29 3:18 a.m., Christian König wrote:
>>>> I need to take another look at this part when I don't have a massive 
>>>> headache any more.
>>>>
>>>> Maybe split the patch set up into different parts, something like:
>>>> 1. Adding general infrastructure.
>>>> 2. Making sure all memory is unpolated.
>>>> 3. Job and fence handling
>>>
>>> I am not sure you mean this patch here, maybe another one ?
>>> Also note you already RBed it.
>>
>> No what I meant was to send out the patches before this one as #1 and #2.
>>
>> That is the easier stuff which can easily go into the drm-misc-next or 
>> amd-staging-drm-next branch.
>>
>> The scheduler stuff certainly need to go into drm-misc-next.
>>
>> Christian.
> 
> Got you. I am fine with it. What we have here is a working hot-unplug
> code but, one with potential use after free MMIO ranges frpom the zombie
> device. The followup patches after this patch are all about preventing
> this and so the patch-set up until this patch including, is functional
> on it's own. While it's necessary to solve the above issue, it's has
> complications as can be seen from the discussion with Daniel on later
> patch in this series. Still, in my opinion it's better to rollout some
> initial support to hot-unplug without use after free protection then
> having no support for hot-unplug at all. It will also make the merge
> work easier as I need to constantly rebase the patches on top latest
> kernel and solve new regressions.
> 
> Daniel - given the arguments above can you sound your opinion on this
> approach ?
> 
> Andrey
>>
>>>
>>> Andrey
>>>
>>>>
>>>> Christian.
>>>>
>>>> Am 28.04.21 um 17:11 schrieb Andrey Grodzovsky:
>>>>> Problem: If scheduler is already stopped by the time sched_entity
>>>>> is released and entity's job_queue not empty I encountred
>>>>> a hang in drm_sched_entity_flush. This is because 
>>>>> drm_sched_entity_is_idle
>>>>> never becomes false.
>>>>>
>>>>> Fix: In drm_sched_fini detach all sched_entities from the
>>>>> scheduler's run queues. This will satisfy drm_sched_entity_is_idle.
>>>>> Also wakeup all those processes stuck in sched_entity flushing
>>>>> as the scheduler main thread which wakes them up is stopped by now.
>>>>>
>>>>> v2:
>>>>> Reverse order of drm_sched_rq_remove_entity and marking
>>>>> s_entity as stopped to prevent reinserion back to rq due
>>>>> to race.
>>>>>
>>>>> v3:
>>>>> Drop drm_sched_rq_remove_entity, only modify entity->stopped
>>>>> and check for it in drm_sched_entity_is_idle
>>>>>
>>>>> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>>>>> Reviewed-by: Christian König <christian.koenig@amd.com>
>>>>> ---
>>>>>   drivers/gpu/drm/scheduler/sched_entity.c |  3 ++-
>>>>>   drivers/gpu/drm/scheduler/sched_main.c   | 24 
>>>>> ++++++++++++++++++++++++
>>>>>   2 files changed, 26 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c 
>>>>> b/drivers/gpu/drm/scheduler/sched_entity.c
>>>>> index f0790e9471d1..cb58f692dad9 100644
>>>>> --- a/drivers/gpu/drm/scheduler/sched_entity.c
>>>>> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
>>>>> @@ -116,7 +116,8 @@ static bool drm_sched_entity_is_idle(struct 
>>>>> drm_sched_entity *entity)
>>>>>       rmb(); /* for list_empty to work without lock */
>>>>>       if (list_empty(&entity->list) ||
>>>>> -        spsc_queue_count(&entity->job_queue) == 0)
>>>>> +        spsc_queue_count(&entity->job_queue) == 0 ||
>>>>> +        entity->stopped)
>>>>>           return true;
>>>>>       return false;
>>>>> diff --git a/drivers/gpu/drm/scheduler/sched_main.c 
>>>>> b/drivers/gpu/drm/scheduler/sched_main.c
>>>>> index 908b0b56032d..ba087354d0a8 100644
>>>>> --- a/drivers/gpu/drm/scheduler/sched_main.c
>>>>> +++ b/drivers/gpu/drm/scheduler/sched_main.c
>>>>> @@ -897,9 +897,33 @@ EXPORT_SYMBOL(drm_sched_init);
>>>>>    */
>>>>>   void drm_sched_fini(struct drm_gpu_scheduler *sched)
>>>>>   {
>>>>> +    struct drm_sched_entity *s_entity;
>>>>> +    int i;
>>>>> +
>>>>>       if (sched->thread)
>>>>>           kthread_stop(sched->thread);
>>>>> +    for (i = DRM_SCHED_PRIORITY_COUNT - 1; i >= 
>>>>> DRM_SCHED_PRIORITY_MIN; i--) {
>>>>> +        struct drm_sched_rq *rq = &sched->sched_rq[i];
>>>>> +
>>>>> +        if (!rq)
>>>>> +            continue;
>>>>> +
>>>>> +        spin_lock(&rq->lock);
>>>>> +        list_for_each_entry(s_entity, &rq->entities, list)
>>>>> +            /*
>>>>> +             * Prevents reinsertion and marks job_queue as idle,
>>>>> +             * it will removed from rq in drm_sched_entity_fini
>>>>> +             * eventually
>>>>> +             */
>>>>> +            s_entity->stopped = true;
>>>>> +        spin_unlock(&rq->lock);
>>>>> +
>>>>> +    }
>>>>> +
>>>>> +    /* Wakeup everyone stuck in drm_sched_entity_flush for this 
>>>>> scheduler */
>>>>> +    wake_up_all(&sched->job_scheduled);
>>>>> +
>>>>>       /* Confirm no work left behind accessing device structures */
>>>>>       cancel_delayed_work_sync(&sched->work_tdr);
>>>>
>>
