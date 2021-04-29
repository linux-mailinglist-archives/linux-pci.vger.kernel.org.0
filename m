Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D896136E5CE
	for <lists+linux-pci@lfdr.de>; Thu, 29 Apr 2021 09:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbhD2HVG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Apr 2021 03:21:06 -0400
Received: from mail-co1nam11on2072.outbound.protection.outlook.com ([40.107.220.72]:12544
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239316AbhD2HVF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 29 Apr 2021 03:21:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OGR7Fh6CBRR/qxms65Ptv0wiI+Ddh7MqP4obK6+RYnWxVIVy3SCftYnDRoloqMIz7GEi6japFpPWvSeV5ZMkduDlIPBMk7OPGuMMXnv3IQx3nBcfJ9k0oIh3kQL0nYy8oAXIxUaJAjC8RW0nluW7WLI59ER6iWxQzD4+Bdk9RKLd6N18Y9c4GJye+ykHCQIOuUf8yZSMD9i16hOCA92hlmcnbpj2PFhVWtLYnnbr9nYcpPXWbWiGdYQ5kKS8Je1g43c37TmITaZ1aEODtre+ayxaXQeq79gffS1o+SYFiiTWGD1kHBtF6y43MVIed3Rnei90wLRir2bga0mKrLE0Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sn6oMAWRlInr2XLygHlYtSVveNrUgJMJFc+EnkhdLtM=;
 b=nB8TrrP16QrLPDJHvG85IOCHGwdg1utraaCxWMq+EM4DyXrM1+/zMH2EXjAgVKb27jXITNGFc7bezWO+XYPb08s9qL+Mp606tYR26eL2FMsm7ZdhOFypOgX7mXU3diQIO4algex+1Hxtgkor5G4Gwae81KUCTwsvyvbI6SJ1G1IeMkV+70T/k58amnI6dGwDEOLQUOz5SXMUqY1tgvryy4OWFz54xnqJ19+vf2cE002UrcsoIJfS2u1NsZrvTZZXzatoPh5XWJXWTRdCHb60i0Y9uGgpngabxERsPI6HBVZH8ylbOktHNLg6Sf2J4V5QUnRUgeCUp6PQkcW0SIts9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sn6oMAWRlInr2XLygHlYtSVveNrUgJMJFc+EnkhdLtM=;
 b=ovd4+Tpwo0TKu2gvyPqGABKo9uQi/2UGHz7Eorbx+Od64i/BmwtYikijWOPpYaP39qWfpjg1QvCfrKD3Lq3Mv4O1bkpyt+NxiF6gC8WPIl4t8h/JfrLkR5bVsY7jQ1e4pjf+X62freFoHglaAELSIowfnIh3Z3L9JrvCKqc5beA=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4816.namprd12.prod.outlook.com (2603:10b6:208:1b5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Thu, 29 Apr
 2021 07:18:20 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34%6]) with mapi id 15.20.4065.029; Thu, 29 Apr 2021
 07:18:20 +0000
Subject: Re: [PATCH v5 15/27] drm/scheduler: Fix hang when sched_entity
 released
To:     Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-pci@vger.kernel.org, ckoenig.leichtzumerken@gmail.com,
        daniel.vetter@ffwll.ch, Harry.Wentland@amd.com
Cc:     ppaalanen@gmail.com, Alexander.Deucher@amd.com,
        gregkh@linuxfoundation.org, helgaas@kernel.org,
        Felix.Kuehling@amd.com
References: <20210428151207.1212258-1-andrey.grodzovsky@amd.com>
 <20210428151207.1212258-16-andrey.grodzovsky@amd.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <a8314d77-578f-e0df-5c49-77d5f10c76c7@amd.com>
Date:   Thu, 29 Apr 2021 09:18:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210428151207.1212258-16-andrey.grodzovsky@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:49f7:8b5a:d7ab:5e3e]
X-ClientProxiedBy: AM3PR04CA0140.eurprd04.prod.outlook.com (2603:10a6:207::24)
 To MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:49f7:8b5a:d7ab:5e3e] (2a02:908:1252:fb60:49f7:8b5a:d7ab:5e3e) by AM3PR04CA0140.eurprd04.prod.outlook.com (2603:10a6:207::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25 via Frontend Transport; Thu, 29 Apr 2021 07:18:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf8c16dd-e58d-4e42-73a1-08d90adef750
X-MS-TrafficTypeDiagnostic: MN2PR12MB4816:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB48163EC124944473A8DD1615835F9@MN2PR12MB4816.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UeQ0I3f0LJbbSJVp4piBsxS6nKAh9+leU1Z1m+SmVuZUzdLdZGQmB835h7v3Yyi5hiReS7lySnezuwIABCK6+awGTXGh8cXSL65Cxp7x0uzihRLmQSmSzqnD8rXQ3UYk/BYLTsUecHMSPcNFBp1RlLSFBzWR/MUbo5jhzsKn43+nvodFCKH2MMto2tNu+fLo4XZuIOYWOTRPYGOkiULH5FCZfrjlbso3NotsX0ZVk/uCt9YKD5FCUgVXtsKVbCAJ5/GaZZlNInEahnA20dkrpAyDHDwarQAYfvHoYszBrVdzg1WrJwaJ6fEm0FOsNc0zbMZP3DMMLBRZaatUeSWB6nmGvDGL+RNEwMi1ohrHUzYCnm1VSFGFvK20617TUKuYlcDr9ez3kphqeIHW7aZJEkIFTdS1k3wNZP4BiSrPT4Pyl/NfYJsx4jWndYFrUhFGvCSJrZKoL21gFYQue67gi/YtUlWz31/RRVdEO/qwpSY5I8dqdfLfafvWMk3fPSQUf544FSX1px/6m0ADAe5KhoA4QuEZFYcjKB7FHc7LMFSTvj01AeJSTy+L5/5z3x7xYoQPIvcg0MUqV4QM/YPRVb+xaAkj1byJEch0qU+kS8r7qXWPdlNPURyjYBOs+0eEcVN9Pxvdmr6ybm2oWu/oiYSMG5dumUqXn/VRYYVYNPSV/cFZ0XclMfbM/TWWlR7z
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(136003)(39860400002)(366004)(316002)(478600001)(6486002)(5660300002)(66556008)(36756003)(66476007)(31696002)(6636002)(66946007)(8676002)(66574015)(8936002)(83380400001)(31686004)(2616005)(86362001)(16526019)(52116002)(186003)(6666004)(38100700002)(4326008)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?YVpjelo0MGVpSEUwT25ObWFQMmw4V1FLVmNSb24ydERWMlJHeDNzMEw2UUFB?=
 =?utf-8?B?d1I0cjNrVytPSG13bklTMWJVTUlMVjI5bGxOMnRNQ2lEYVhMZFp5VzROVTd6?=
 =?utf-8?B?Vkd2eDRMWFRNWE9yQWxnbkpmTWFXL2tiZVJ0OUErVWpmNjhtcGdFTW54d2NK?=
 =?utf-8?B?WGdQc3V3U1crZE9yb3pleXNINEl3QnZlN3BIc1N5S0ZteXRSdzBOeDZqL2lF?=
 =?utf-8?B?UG1WaVFYMHBMWFVURFlHRFU4MjY3cm5WK1ZDRy9xd1Bxa3hHUzlQVzVIVk4r?=
 =?utf-8?B?dHdGdENpY2Eyd2s3M2tWK1ZMcVpGbldqRFJjQjFSRkZQaXhpWW9NV1pPeU54?=
 =?utf-8?B?SFNPWTZFQldrVXRrN3Frdm0wZkdmalNXeko3SzlyZFpEd21VcnRQWnU0Vk5h?=
 =?utf-8?B?L3RIUTZiN25rSjI1VTE1YnhLWEhvaDczbCtUeVZIMTFxUlltTndKRDJJSEFU?=
 =?utf-8?B?cU1ZTmFLbFBsUlJvVlZUNzk4RkpmUFV3cnN0N3lhOTJsQW1uRWNZbHdMVzVz?=
 =?utf-8?B?a1hVQkpJN0hqZWQrUXFKbzNmd050M2NtMUd5NVEwY0lEZFY4c2dDL0FoMENs?=
 =?utf-8?B?OE1qdTNiWlQxbUdwbjFqcGVBT2dpUlBPMDVwSTJLUXRJTitwdkNLM2t3dmpY?=
 =?utf-8?B?SGsrMUd0ZEVjZnBXYkQ1RXRlT0g2Z1BMcmNLM2dlaVp2ZXBSM2VybmJwWEJi?=
 =?utf-8?B?YWs2WlFOUVVqV1BzUldORVpkd2wrSGFUNVl2bjNvdUhzTG9STFB5bTNYZk5u?=
 =?utf-8?B?STVhRU1zTGJIa0pIYmRsZ3d6QUcxSisrZFo1SGkxY0ZENTdVTnA1QmpBdmJ5?=
 =?utf-8?B?a25kTkVGNExXZUJTOWVWZmJlUThpWkhUcHUzc2xIOTg0VmoxVFA1bmVjUE1h?=
 =?utf-8?B?Uy9lOXBnMDcxMVRGbk1uMlBhN3hPaytjRGdEQVN1TjlTRnJ5M0hMcitvdzhR?=
 =?utf-8?B?QmNLVStxMU5hVEhDRCtrTzlsM2tFUTYxVythU2lqMEF2UUN6aFZja2RraStj?=
 =?utf-8?B?T3FJWWVQNDBGVHNUZmJYd2lFeFNaaFo3ZEVHaC9ScERpZUZYbFZ5ZWVUdzRq?=
 =?utf-8?B?QWRXN1ZIQTNLWlkwR2N6OUJsc0NqS3FsQ1VkZnluc2RyczhIYkwwbmpQaEtU?=
 =?utf-8?B?bE9rWmJ0R215ZkNiL2FIaHI2aDZ5WlhYdmtjdWhrbE83ZytnQjY3bWdHR2FQ?=
 =?utf-8?B?a0ZwNzFKa21zY0dRWkdhOS9CUFh2VkNLNWhUZkxxa1dEb1N6YlRMQkJTd3lT?=
 =?utf-8?B?ZzkvSGpIZUxIczhneUxXMTA2MzlRZW1CcjdZYXVKZkR2bG5ZeVFCV1lCSjN2?=
 =?utf-8?B?RFhCNHo5bVphbFN1R2NhRHZXUFR6TmFPcTFHcFhkMktMN0dPUCtPcldpVktG?=
 =?utf-8?B?NUtZQzRUcTYvZm1TQXNJMHB5SHpRak9Ld040dnJxamJwTzZYMnBzTTU0K0lx?=
 =?utf-8?B?L21aSUg2WTNwd3VHQTdFT2hKRmcyYk1QMFBNdWp1ZktTWWhYMlNpZjhrdzQ0?=
 =?utf-8?B?Wm01YldMN1FYV0U1VjdTd05nQ1dmN3Y2ZFljNmtmRjQzaGJ0dnRMSDNqdFgy?=
 =?utf-8?B?ZnFDRFRlWmRGSmNIRmNTeXJlalNtQUVFNWhxUmRreUFmU0R5RW42U3cvZ09I?=
 =?utf-8?B?RjZTR1RZTDh5QS9VMDExTWdjRTF3NVQrZ3o2THFkUnVBRU91MjhCZW43UVU3?=
 =?utf-8?B?ekxydGFjWW9QaGV2K3RXV2NwbndpUmY3d21DdlpCNmV6WXNUa0hQd2YwTVZG?=
 =?utf-8?B?YmtISVUzM1ZiZ1VlYTVER0x4QXo5WFdsSmo4Q0x2Y2daR1RVYzVkWWxETXAz?=
 =?utf-8?B?WTJNRFhSSWVpb1cxYTBBUEE2cDE3Nk8xV1AzejZ6OVNWaVdGUUM3azQyZ3B1?=
 =?utf-8?Q?7++2nirJhLb3L?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf8c16dd-e58d-4e42-73a1-08d90adef750
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 07:18:20.0716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VdzjZeqDnn7zVbnMjqJzySlaEmwL4KhI5Oxj4QxtWNQ1T5y/yQRPNeLbZl0rIrec
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4816
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

I need to take another look at this part when I don't have a massive 
headache any more.

Maybe split the patch set up into different parts, something like:
1. Adding general infrastructure.
2. Making sure all memory is unpolated.
3. Job and fence handling

Christian.

Am 28.04.21 um 17:11 schrieb Andrey Grodzovsky:
> Problem: If scheduler is already stopped by the time sched_entity
> is released and entity's job_queue not empty I encountred
> a hang in drm_sched_entity_flush. This is because drm_sched_entity_is_idle
> never becomes false.
>
> Fix: In drm_sched_fini detach all sched_entities from the
> scheduler's run queues. This will satisfy drm_sched_entity_is_idle.
> Also wakeup all those processes stuck in sched_entity flushing
> as the scheduler main thread which wakes them up is stopped by now.
>
> v2:
> Reverse order of drm_sched_rq_remove_entity and marking
> s_entity as stopped to prevent reinserion back to rq due
> to race.
>
> v3:
> Drop drm_sched_rq_remove_entity, only modify entity->stopped
> and check for it in drm_sched_entity_is_idle
>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> Reviewed-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/scheduler/sched_entity.c |  3 ++-
>   drivers/gpu/drm/scheduler/sched_main.c   | 24 ++++++++++++++++++++++++
>   2 files changed, 26 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
> index f0790e9471d1..cb58f692dad9 100644
> --- a/drivers/gpu/drm/scheduler/sched_entity.c
> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
> @@ -116,7 +116,8 @@ static bool drm_sched_entity_is_idle(struct drm_sched_entity *entity)
>   	rmb(); /* for list_empty to work without lock */
>   
>   	if (list_empty(&entity->list) ||
> -	    spsc_queue_count(&entity->job_queue) == 0)
> +	    spsc_queue_count(&entity->job_queue) == 0 ||
> +	    entity->stopped)
>   		return true;
>   
>   	return false;
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
> index 908b0b56032d..ba087354d0a8 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -897,9 +897,33 @@ EXPORT_SYMBOL(drm_sched_init);
>    */
>   void drm_sched_fini(struct drm_gpu_scheduler *sched)
>   {
> +	struct drm_sched_entity *s_entity;
> +	int i;
> +
>   	if (sched->thread)
>   		kthread_stop(sched->thread);
>   
> +	for (i = DRM_SCHED_PRIORITY_COUNT - 1; i >= DRM_SCHED_PRIORITY_MIN; i--) {
> +		struct drm_sched_rq *rq = &sched->sched_rq[i];
> +
> +		if (!rq)
> +			continue;
> +
> +		spin_lock(&rq->lock);
> +		list_for_each_entry(s_entity, &rq->entities, list)
> +			/*
> +			 * Prevents reinsertion and marks job_queue as idle,
> +			 * it will removed from rq in drm_sched_entity_fini
> +			 * eventually
> +			 */
> +			s_entity->stopped = true;
> +		spin_unlock(&rq->lock);
> +
> +	}
> +
> +	/* Wakeup everyone stuck in drm_sched_entity_flush for this scheduler */
> +	wake_up_all(&sched->job_scheduled);
> +
>   	/* Confirm no work left behind accessing device structures */
>   	cancel_delayed_work_sync(&sched->work_tdr);
>   

