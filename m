Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A871B36EE94
	for <lists+linux-pci@lfdr.de>; Thu, 29 Apr 2021 19:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240748AbhD2RHG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Apr 2021 13:07:06 -0400
Received: from mail-dm6nam12on2051.outbound.protection.outlook.com ([40.107.243.51]:17505
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233622AbhD2RHG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 29 Apr 2021 13:07:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mjmkWF97hL0g8ZI7jxZ61+fbvGjV28sj3eNPqgn5UYrpey/EMVuc5HhxjASTwPwGyO2SucxKBg/QCp7ZCVljS8mnJ0xxs3+4piuGcjmJ5b3Pkks9LhDng5rqzzF2EogyW9B0zKR/wYqSKQSsx/Ddu+vZLWKVTW6yjn02quxCu8akHVNiSMtcP8LRKKbIEkS/11MDLInYDaOgXfTyavJhBaOpwBWqetbdTQK7jCLtZhpD8Q3B4fpe7pM1gM8yMBvw3bjZBDJi1HPNpqve6Wg4Y+FT3BdBBl2KttlojX0meijFMmGx9pdN9LuBgnDsuN7G4qVwRltFGGJPRGSGLecy+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yRj3WmsVXXrvqXG6I7H+X3ayRp/ED9PSWuIlwtZ587k=;
 b=f15ig5fRnBE+Qxix9xoBNIuhaGYamz8RC3iGvO0gEwu5Rv4nPKlcURYpmJb+aBLzW5L93C2yBt0E4AUFbvPbfe1vx/tRT9FW6NVmHUTI02MsFSZjfO7jvcsTl3R4Af1jEiKl/2axYEW0OCzLVa4FmrH/SX3h41P6m1iIyusHrWATINxjYWdUwuAvqRIy15v6jT6EUZ8jRdzm+6bpabGxpXaZx8Q/6koC3/KI21mdsMfCTEFn48CtSURmwWfEbpkDTCzzBje1OdH0xxWa905pe8jh/vvOrZ/nMjjtZgJKJGIuGg5xvral7CpNeilRBCWfXQ9st6kRqvxVEKY+OWU52Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yRj3WmsVXXrvqXG6I7H+X3ayRp/ED9PSWuIlwtZ587k=;
 b=PMsEFgJ6UUp+fGP0lR7M9PXQ23zkOAduFM0IqMhC/v5UqIAwgIbTV5kUI9ORkbfILOXt1g+PFnTvkH/k7DvPZ8dVcoUVS8UFLszccKwm9dPUzJS0IbgPIEWz/1NSEwIxRHnQemHnK2ZZM98nkFyUDibPhdYYl6Io1RvenZRGf94=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SN6PR12MB2655.namprd12.prod.outlook.com (2603:10b6:805:72::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.24; Thu, 29 Apr
 2021 17:06:17 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::ad51:8c49:b171:856c]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::ad51:8c49:b171:856c%7]) with mapi id 15.20.4065.026; Thu, 29 Apr 2021
 17:06:17 +0000
Subject: Re: [PATCH v5 15/27] drm/scheduler: Fix hang when sched_entity
 released
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-pci@vger.kernel.org, ckoenig.leichtzumerken@gmail.com,
        daniel.vetter@ffwll.ch, Harry.Wentland@amd.com
Cc:     ppaalanen@gmail.com, Alexander.Deucher@amd.com,
        gregkh@linuxfoundation.org, helgaas@kernel.org,
        Felix.Kuehling@amd.com
References: <20210428151207.1212258-1-andrey.grodzovsky@amd.com>
 <20210428151207.1212258-16-andrey.grodzovsky@amd.com>
 <a8314d77-578f-e0df-5c49-77d5f10c76c7@amd.com>
From:   Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <9cb771f2-d52f-f14e-f3d4-b9488b353ae3@amd.com>
Date:   Thu, 29 Apr 2021 13:06:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <a8314d77-578f-e0df-5c49-77d5f10c76c7@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2607:fea8:3edf:49b0:497:888:9bb9:54f1]
X-ClientProxiedBy: YTOPR0101CA0046.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::23) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:497:888:9bb9:54f1] (2607:fea8:3edf:49b0:497:888:9bb9:54f1) by YTOPR0101CA0046.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.24 via Frontend Transport; Thu, 29 Apr 2021 17:06:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50081f5e-82f7-4f76-2d11-08d90b311a28
X-MS-TrafficTypeDiagnostic: SN6PR12MB2655:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2655EA8E701CCB22AFF45F8FEA5F9@SN6PR12MB2655.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DUbloVCIvi7309wShhKl8znAY2n+PPheqJlptA59EdsxXhJE7zOGdVsM81/yhj53LiqjncJsZl9mBp8ODx8/msqEgs23Aj5mLmPqDDJML6C4uGuZcwlynoEoIwJRb8ZkFMIjcz1D6beQBIRIw3eaqU/TTyHsvT4JEpENkXt8jIUnPNMpYP+lX0NfZBLnXKjLv0vFxJrfUPCPwhMrxq3S8+5a/4t5ZpkzLiPLdeQMaOxAJYWRX5WBfd/QUbjGwBBuDP1AqUQAp7mA/U9jtpl2WK0dGAn1OoFjdJvxrEQPCKKFoNivqtv4pfo4IssHE3hvsp8oDKzQoZmEAgn4533JBkXp73N7+r5inl6JwoPIxkCEiTVMTxKbBMmG1PVp0fZdWzBPYOzw/esJB2iAgiYcWl25j7YkYN+GnxwvEHHSaWH7JcIZ1u1jwKZsWSFoi9bD0XzR4ESgxzej/sxEoPv7vbG5a5v+YwU0r4QXgZtXFWB7o5bfH01Rtn0L3CWKZItPTgFuBjC+xvA3W7bRKiALY3QMHm5huMb35gjlFivrzEdYoKCJn27t49rYdGtDMFAuh+K+T6eZctzQyI5QfeOV5Z7qwpDVGNsCiDaaBGcKVBUUShIkuKrrV/MeUvoItz6YDL28qoIB5kRNCOJz7YM8byXfhFj83tgZFe/tsg1+t5jTLSc/73GngP66oBNJQw9w
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB4623.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(136003)(346002)(39860400002)(396003)(4326008)(6486002)(31696002)(66556008)(86362001)(316002)(31686004)(8936002)(66476007)(5660300002)(186003)(44832011)(16526019)(8676002)(2616005)(38100700002)(478600001)(66946007)(66574015)(36756003)(52116002)(2906002)(53546011)(6636002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bENjM3UyZHY1dXkwbERsUVduSHFzVVRPTGNJWHNmWDBtbDl2cWNRNm83REt3?=
 =?utf-8?B?N25xTDlEY2d3R3VPTFlLVU0vQ2xsNlV3QjYvblJHazVZeEYxVTlySXBUNkNr?=
 =?utf-8?B?cVpzai9jK3V1U0hnOEtOeG9kS2d1elRGYmVTbVpNbktvQnQxQVpOeGhDam1o?=
 =?utf-8?B?ZlFKdE0zSDJUdGFkTCttUEl1QjFQanNPbi9Fc1RWL2o3SUZtUmZWNGoxZklT?=
 =?utf-8?B?TWNVcXpQcEtWS1lLQUJTYnJkU2xMTXNrTHYwWHExN1UyVGdNbFhmUExXT3pS?=
 =?utf-8?B?SUNJcFBiendiaUhSamhtR0NkWGpnK1hMeGdjQzNpVjJtcTFmYUZxMWZXb2JZ?=
 =?utf-8?B?UGgySkJ1V1NKOU1VOGx4a01WTjdGNmh6QXdhU09WS2VXbXJ0YldOY2M4a2t6?=
 =?utf-8?B?UWpQRWdxVmQ5WWE0TXVsYUExb1d1SmhDcEs4am9jQm1FSCsyeTdVWnNObzF5?=
 =?utf-8?B?MHdZeVlxTFhQeExleURkUExya3prOVpIRFNwaStvVm00UzBhM2htczJpWGVD?=
 =?utf-8?B?M1B2RHNCTnJUOWJlZExsalNpUmZrOE9STml5OU00Z3NsVEZEUXhCWUplemVZ?=
 =?utf-8?B?VktwUTBxbWJOVFp4dmRJeXBkV05xb3JDMjE1MTZaTWpvS3huUjZyRGMxeUgy?=
 =?utf-8?B?KzlpVTN1aGRVSEdzSmc0VDU1NSszRWVsRUFVSjc1d1VtakNlUjJSejBPeFBz?=
 =?utf-8?B?WDVQTTBlQlRkNzJtSk5SWFFvYXJKVXZkL3BDeVZQSjhWWmF0LzgxTUt4ZFpm?=
 =?utf-8?B?QTJnK2dNWE9YZzhLcVFHT2Y0ZC9LRFVJV2NhcnoyS2lrWkNGTDBMTmxsbXA0?=
 =?utf-8?B?TmNVRzBRSk5hdk1wMWtOWEZmWW8yNjR5UUIzMFk1emtkY0NZUVhZNGpxbGx5?=
 =?utf-8?B?Q3U5TVY0N2dsMDdSSE5sa2Q5Ny9sQXhVWUJtbGcwUGtlSDlmb25adUlMbWEv?=
 =?utf-8?B?TWI4MVk5V3ZCWjdvK0s3WXgxRzA0U0tSS3ErZWZUR0R0RUs1b1dnTHR2YURl?=
 =?utf-8?B?dW9jY2FQMkJONGJFQlM2QnlKSmVraWFZbUlzeGoyUlRqOUhma2g1aFhraDNk?=
 =?utf-8?B?VEpFNmhBUHVXT0RsWkRSZFowL3JRL0g3NkUvNjduTjRoQTVoR0hLWUtxcDky?=
 =?utf-8?B?T2tMWHZzZFB1eGI1M0FjcVZqUS90Rmo1eU9DOFVSbDB4MHVCVkwvcHQwVTFy?=
 =?utf-8?B?WXB2RzB5V0dWUXNBNlk4S3dWUldNVjhLTVBLZ3hqaUdVSGZCeS9UZzE3K055?=
 =?utf-8?B?RktSa2VPcDZRMUV5SVlaY3hUeG1QU3B4QkQvd2hpYjBNNStIUXkrV1hDK0Rz?=
 =?utf-8?B?NmdzeTBGOHpTdXdnTlNkNTlLanpXQWpxSytqK0Y3cEh3UXVuZGhUcml0dDJk?=
 =?utf-8?B?akxSd0NkRlRzakw0V0FNb3FBamRHOVJIWEZoaFE3dUFhUDB3MVpDWE8xV3Zq?=
 =?utf-8?B?aHVydGFvakN1RXZUOG0wWkF6ZllFU1FoMGd4UmtIbmRBaWdOSSt4YmRUV3pS?=
 =?utf-8?B?b0ZGQkFlclArODkzTGs1anRTbk9SaklyUlFoWCtJQktESk00dWN3NVlBdVNT?=
 =?utf-8?B?amhycDM2eGQ0TzZRZ0xVcFNuV3FERWR3M25qUTI1WXBER04yd1Zrem12VlVu?=
 =?utf-8?B?WktrZW0zNzNRRDlla1BLSWdFcDdEU3RyNTBwKzVtMitKZmVzY3haTGRXditz?=
 =?utf-8?B?YVFSU0RlNGN2ZjJOem1KMDQzcHdHblJ0RnRoTWdvSHJLc0hidTVvMkhjWURP?=
 =?utf-8?B?MUFXSG9qbXZpQU1GNHc2S2VoT2I2TVBSM3BvbTRsTGRjeThudDFoelJpMmhC?=
 =?utf-8?B?MjhtNlc3cEY4UWZwUjh3YmdjY1o0QlAxNmtXVW4rWG9PWGdtWjBTNWhXbXRK?=
 =?utf-8?Q?k/CNKvMlqQqv8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50081f5e-82f7-4f76-2d11-08d90b311a28
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 17:06:17.1508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s72ri+qUlH/STJH7b4uLYHhOg8EPAWS8ERDooqnOFWXHkbWxnoNMi8wLZ6eTveW0lIP4nuomYRa1zsgFWgnI5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2655
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2021-04-29 3:18 a.m., Christian König wrote:
> I need to take another look at this part when I don't have a massive 
> headache any more.
> 
> Maybe split the patch set up into different parts, something like:
> 1. Adding general infrastructure.
> 2. Making sure all memory is unpolated.
> 3. Job and fence handling

I am not sure you mean this patch here, maybe another one ?
Also note you already RBed it.

Andrey

> 
> Christian.
> 
> Am 28.04.21 um 17:11 schrieb Andrey Grodzovsky:
>> Problem: If scheduler is already stopped by the time sched_entity
>> is released and entity's job_queue not empty I encountred
>> a hang in drm_sched_entity_flush. This is because 
>> drm_sched_entity_is_idle
>> never becomes false.
>>
>> Fix: In drm_sched_fini detach all sched_entities from the
>> scheduler's run queues. This will satisfy drm_sched_entity_is_idle.
>> Also wakeup all those processes stuck in sched_entity flushing
>> as the scheduler main thread which wakes them up is stopped by now.
>>
>> v2:
>> Reverse order of drm_sched_rq_remove_entity and marking
>> s_entity as stopped to prevent reinserion back to rq due
>> to race.
>>
>> v3:
>> Drop drm_sched_rq_remove_entity, only modify entity->stopped
>> and check for it in drm_sched_entity_is_idle
>>
>> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>> Reviewed-by: Christian König <christian.koenig@amd.com>
>> ---
>>   drivers/gpu/drm/scheduler/sched_entity.c |  3 ++-
>>   drivers/gpu/drm/scheduler/sched_main.c   | 24 ++++++++++++++++++++++++
>>   2 files changed, 26 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c 
>> b/drivers/gpu/drm/scheduler/sched_entity.c
>> index f0790e9471d1..cb58f692dad9 100644
>> --- a/drivers/gpu/drm/scheduler/sched_entity.c
>> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
>> @@ -116,7 +116,8 @@ static bool drm_sched_entity_is_idle(struct 
>> drm_sched_entity *entity)
>>       rmb(); /* for list_empty to work without lock */
>>       if (list_empty(&entity->list) ||
>> -        spsc_queue_count(&entity->job_queue) == 0)
>> +        spsc_queue_count(&entity->job_queue) == 0 ||
>> +        entity->stopped)
>>           return true;
>>       return false;
>> diff --git a/drivers/gpu/drm/scheduler/sched_main.c 
>> b/drivers/gpu/drm/scheduler/sched_main.c
>> index 908b0b56032d..ba087354d0a8 100644
>> --- a/drivers/gpu/drm/scheduler/sched_main.c
>> +++ b/drivers/gpu/drm/scheduler/sched_main.c
>> @@ -897,9 +897,33 @@ EXPORT_SYMBOL(drm_sched_init);
>>    */
>>   void drm_sched_fini(struct drm_gpu_scheduler *sched)
>>   {
>> +    struct drm_sched_entity *s_entity;
>> +    int i;
>> +
>>       if (sched->thread)
>>           kthread_stop(sched->thread);
>> +    for (i = DRM_SCHED_PRIORITY_COUNT - 1; i >= 
>> DRM_SCHED_PRIORITY_MIN; i--) {
>> +        struct drm_sched_rq *rq = &sched->sched_rq[i];
>> +
>> +        if (!rq)
>> +            continue;
>> +
>> +        spin_lock(&rq->lock);
>> +        list_for_each_entry(s_entity, &rq->entities, list)
>> +            /*
>> +             * Prevents reinsertion and marks job_queue as idle,
>> +             * it will removed from rq in drm_sched_entity_fini
>> +             * eventually
>> +             */
>> +            s_entity->stopped = true;
>> +        spin_unlock(&rq->lock);
>> +
>> +    }
>> +
>> +    /* Wakeup everyone stuck in drm_sched_entity_flush for this 
>> scheduler */
>> +    wake_up_all(&sched->job_scheduled);
>> +
>>       /* Confirm no work left behind accessing device structures */
>>       cancel_delayed_work_sync(&sched->work_tdr);
> 
