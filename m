Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A153236DB59
	for <lists+linux-pci@lfdr.de>; Wed, 28 Apr 2021 17:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239433AbhD1PNx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Apr 2021 11:13:53 -0400
Received: from mail-co1nam11on2062.outbound.protection.outlook.com ([40.107.220.62]:20864
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238948AbhD1PNq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Apr 2021 11:13:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZlUabXx78O+VdqPt94BtQGyyT9HYPpo0/aDZgJr6/x2io51Lj9EkLQDPplWpfJuEzGHJ0G/U4vS+QBy0NW47f78DggqhwXrfOf614x8pktp+MVWHS7t8cj5Dt1Mo5a7IiyPo+GI3BjCksNwkA0lX2PwT5PIu7WWv1nGBsp/mF3GTQIqI/PQ+3l0So/s+dYL4Zta3p1tr8dOnEAlWZy2WHjtVYMBXCPEIYm/3boDP3shdIMHLfN69oI0PQR7CnwClCWOYxb6n3jg8qgMwpEcrfLM3ZSMWpIuFUDh8H4pG+1I9pmcUMc9bINPXlaEbtIiaIZYpAWa9gZo7Z++4KgVbUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nl/O/shlSz/P5DjdJh1C7b4UObg5BRm5//EqkEZWN84=;
 b=mm2To12TQrYrtHDTzQMgQIJ4asJvvjqFBkbyFYNQR8c7ST68MA6wd7eyvTjcxq73gHdVX/ovgSo3ha1165KPJw8osGFbdA4KHPQJPMe/0R+u1xlD9n0Z/DxPiDawFCJsChHJ1nZYIaPwAXMUDztDGS26QC1hZjx7D8nzX0ky1GawA279NlAKLvb6IQw4lcdFWkzGb3537vIecHWB8K5qHSyKKKlx6Di/ey4Rh8duKZ/7Gw8pzU+42rnsPD6PB4YDcUwScm5EwZR4HYnWy7AZdtIPZvesgRCXrh4g79fCa+U1Ayo9A1EoWcustF9M39/rv1Z84IpURkIhTAY4Sr+A9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nl/O/shlSz/P5DjdJh1C7b4UObg5BRm5//EqkEZWN84=;
 b=PfHgEYUHdlvBy6D0pqOhh5WDv2yEwM32zAQ3AcUMq/mTx7bSV+wdGfRq7c1mOjYZ6XX/lDrwAeMoihbNkkhkC5hxLD5Pe67lVyg1e+8scWb4CYYZRwi/Ai+HTRHFlqUlTbC0ILN6gijhzw637uFvmIaNjbWVY14leIR17h5cwV0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SN6PR12MB2749.namprd12.prod.outlook.com (2603:10b6:805:6d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.22; Wed, 28 Apr
 2021 15:13:00 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::ad51:8c49:b171:856c]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::ad51:8c49:b171:856c%7]) with mapi id 15.20.4065.026; Wed, 28 Apr 2021
 15:12:59 +0000
From:   Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-pci@vger.kernel.org, ckoenig.leichtzumerken@gmail.com,
        daniel.vetter@ffwll.ch, Harry.Wentland@amd.com
Cc:     ppaalanen@gmail.com, Alexander.Deucher@amd.com,
        gregkh@linuxfoundation.org, helgaas@kernel.org,
        Felix.Kuehling@amd.com,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH v5 15/27] drm/scheduler: Fix hang when sched_entity released
Date:   Wed, 28 Apr 2021 11:11:55 -0400
Message-Id: <20210428151207.1212258-16-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210428151207.1212258-1-andrey.grodzovsky@amd.com>
References: <20210428151207.1212258-1-andrey.grodzovsky@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2607:fea8:3edf:49b0:7212:f93a:73b0:8f23]
X-ClientProxiedBy: YT1PR01CA0142.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::21) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from agrodzovsky-All-Series.hitronhub.home (2607:fea8:3edf:49b0:7212:f93a:73b0:8f23) by YT1PR01CA0142.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25 via Frontend Transport; Wed, 28 Apr 2021 15:12:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce484d86-8da4-4163-f65e-08d90a581c30
X-MS-TrafficTypeDiagnostic: SN6PR12MB2749:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB274954E60AD29DD29BD9F6F4EA409@SN6PR12MB2749.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:663;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lulc5oekbOtXj1MaqcGN1BTIc6Cp4R8OS7NZVrhvetkmTF2eGi3vjmJg68sjSit8fOIH3NvALxllkZNEjI2sLLwiqlNoGLfGpzKweMHlFQp5JTVn6udkfb2YkSejPNbl3KQnTMKOgHf1MSJdXLncV+lke3L9o4g7ATTmg7b5RsLU92e5uzTi6Qu41qWWF8Q1/t12+OMeySx8+gCKFK+prSnSeE82w643Dt74J8m73mTt7AD+bFntua6xXB1ljDTR0SytT07eLBzOJ5dhg39K7dKRLOG983KMX5E0iqcbfxzDxY7QqIQK/mlO3lBAvWNHTAldG7FxyOK6KbF4DgTrWKqS/MmoSyY8knNnujNPzdQ8bRfo/8mMAB1XvZqi+tUzuvqXxJglKqQv207MrzcDhxazB32AbJZnhAiPJz1YnOF0DpCX9GVFREjkiW1Nc1lbMh4IUa39NOyxeqk+Qz+LclHDn6SRFwow4PQ93Bcg8bYN35FOoxH6Minb/hi5RYMCbFIPSzBSo76ib+Wh/jrGwXotA7BeVoEn99jNB5MsiJ+Ft5/ijvJJTZoYnic2MpOPVyCz5QydCbjYsCAql4LHWy8F+No8z2buxd4W6k46sA8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB4623.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(136003)(396003)(366004)(16526019)(6666004)(66574015)(6512007)(2616005)(1076003)(2906002)(6636002)(66556008)(186003)(86362001)(5660300002)(8936002)(83380400001)(6486002)(478600001)(44832011)(38100700002)(54906003)(66946007)(52116002)(6506007)(66476007)(8676002)(4326008)(36756003)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?aEhYUUFaTnFuZ3pYTzAyK2xoU0JkZU1mR01DM2N0Vks3eS9yVnh3b2dpOFB2?=
 =?utf-8?B?cUNpOHBGYmZWY2ZrVWRhaUdabHZaMnVZeXF2aXlodE9EY3F0U2M1QXlFcEE0?=
 =?utf-8?B?RzNjTWtMUXVQc2l4a3Z2U0FRY2thNVBqcDhhWExDdnZ5aEhTTWs2R2hKWTJF?=
 =?utf-8?B?YWVNS1N6YW9PNWNaU01jNTBFVEhYeFhaVmd4bzN5RTJoMmpUWno1Z0xwSndY?=
 =?utf-8?B?eVpIQ0hRY3pIMjQvYW1ZUmNCekJ5YzZhY2pIcC9mMjNFeWRXSUxzanFPL1lx?=
 =?utf-8?B?TjBRbmNKc2htTngrdzkwbENDMVMzWmFycTJ5UEFuQmRISEsrYjNPTzhlejFv?=
 =?utf-8?B?d0xDMUMvNjhqQ1VaeERuUmxhb1VLTXptZTB5bXhlbzZxNTZGZ2JhNUNVbmhP?=
 =?utf-8?B?MnZEL0NoaHo4UzFyWGlYNEQ5SDRpUkhDVU5HTllzWkRJcE12VjY0Tlp2VWVZ?=
 =?utf-8?B?VmRtVEdJVnB4Qk9HTHhsMDIwSzJyQzVkeTYxSVo1L1dTRC9yTHpUNXJ2U21G?=
 =?utf-8?B?R2dxSjlwRlU5UnZmKzFnNDQ5MUllRE9xN0lmdXg0S2MvdDRGWEUvWWxZSC9J?=
 =?utf-8?B?VmpEK3E4QVp5RHN3N3ZWQklLRGJpMmE4SlNBVDZXaXhiRVhzcXhIS0Q0UnJB?=
 =?utf-8?B?QmFCaUNvbTJ2N0krMGptejJBRnE5Q2UwanZ1K3NNU1BEVldWaEFpajIwcVRZ?=
 =?utf-8?B?dDk0UDAvNHpBZmNtZVB3ME04Z3g2NWszS05tYmJHbmJNRUI5Q3QrVmZhV0o1?=
 =?utf-8?B?K1VkdTBSZzRoNGFvOVptUUNDTnFaWEJPbUhaMXlHQVQ0aVY4S0NzeGpiY0tk?=
 =?utf-8?B?SVpZL3VkZkdaODFKU25xRS9BNDl5WUc2YUJseWttQkQ0REhQdHpTSUZKWFJq?=
 =?utf-8?B?SnoxakE4d2RWK3k2eU93REpBMDFuNU1ZZFc3U0d1YUNLRVJNTDcxN3VPZ1RU?=
 =?utf-8?B?V2tXZzNDd3B0c0oxNVVUS3BjY0NmVGJxT1Zkb1BEMmluRUc4WlRuVVloUXdS?=
 =?utf-8?B?MEpPV2RVM05XczI1S0ZmaU95RzdZQVRyTkRBQVVxV1lGM3BEZE1VY2tvUTVt?=
 =?utf-8?B?N0R4YzhOeUUrbXI1NVNmL1Z5c0JUT0JFOXZrY1dnNTd6bmNudVNYaDFDeE9w?=
 =?utf-8?B?enNqWVBCOGNBRCtUU050TDREV0dzeVA3YWhXc0VsWkJZQXdRd2oza3Buci85?=
 =?utf-8?B?R2g1U0Z6czlLM0dUNUtIZWsycVNoSTROc0lYaUZXTUVNQnh0WE1qY2pSWmh5?=
 =?utf-8?B?d2w3aUVScEJ6LzBYZ1VkZGEvOVVGaVFmRExpcFRFazVzVkNmbDl0MmV2UU9v?=
 =?utf-8?B?dXF4N3Y3YmFDNnRkQlZsLy9veXlKZFBBdG5yS3AyaDZLM3ZocUFURXhkWTBm?=
 =?utf-8?B?a3dBb2VRTWlPQmFMdTBZck0xbWpwR2JEeVpPSnhSWFlwSGZSVjNpY3N0a3c5?=
 =?utf-8?B?cUxRRGFXaU54ZE1qNmFlMENVNE1yMFovQVMxdXBhZjBpcHZPZlpNcG9MUUVQ?=
 =?utf-8?B?Sk1HbmYxK3JqTDFxZ3VnZU1qRmlOaEhRc2FsSzlkeFpOeHk4RGEvR3JuckZ4?=
 =?utf-8?B?a3VqWGY0RjZQb0RYQUdnVGpVdEpuZkpFVTFoV0ZMdjNSZzB1UDZIWCtXV0pk?=
 =?utf-8?B?T0V0ZUdxd3RGL0g3bTUyRW9jdmh1MzBqS01ZSFZ1K010VXphVmxSMlp2ZmJn?=
 =?utf-8?B?VklldDZqTzJ0NTNISXhjc1VhbTJOdzdyK2ZsZ3hGZlhUaEhVWlp6N0xHUE9F?=
 =?utf-8?B?UUd5L0RXdTBpU0o1R2h3TGxzdkNKa2lSaFowWVArQWU1LzhoOGF1cG9SVEtP?=
 =?utf-8?B?bFVIbnVMK3FrWGtreG5waWlqaWFtNUk2WkZ1bW5wcFhtU2V5MVdhRWpEWnI0?=
 =?utf-8?Q?gUg4MOFWqRYRr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce484d86-8da4-4163-f65e-08d90a581c30
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2021 15:12:59.7125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tidZahAWe63VbKeEMpdBSQLgXVe1Gr1otsTGygf0HvRQLXgyrWPJ2pI+vIhfyuA3b+uMlbuqO7bunDgzpq3QKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2749
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Problem: If scheduler is already stopped by the time sched_entity
is released and entity's job_queue not empty I encountred
a hang in drm_sched_entity_flush. This is because drm_sched_entity_is_idle
never becomes false.

Fix: In drm_sched_fini detach all sched_entities from the
scheduler's run queues. This will satisfy drm_sched_entity_is_idle.
Also wakeup all those processes stuck in sched_entity flushing
as the scheduler main thread which wakes them up is stopped by now.

v2:
Reverse order of drm_sched_rq_remove_entity and marking
s_entity as stopped to prevent reinserion back to rq due
to race.

v3:
Drop drm_sched_rq_remove_entity, only modify entity->stopped
and check for it in drm_sched_entity_is_idle

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/scheduler/sched_entity.c |  3 ++-
 drivers/gpu/drm/scheduler/sched_main.c   | 24 ++++++++++++++++++++++++
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index f0790e9471d1..cb58f692dad9 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -116,7 +116,8 @@ static bool drm_sched_entity_is_idle(struct drm_sched_entity *entity)
 	rmb(); /* for list_empty to work without lock */
 
 	if (list_empty(&entity->list) ||
-	    spsc_queue_count(&entity->job_queue) == 0)
+	    spsc_queue_count(&entity->job_queue) == 0 ||
+	    entity->stopped)
 		return true;
 
 	return false;
diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 908b0b56032d..ba087354d0a8 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -897,9 +897,33 @@ EXPORT_SYMBOL(drm_sched_init);
  */
 void drm_sched_fini(struct drm_gpu_scheduler *sched)
 {
+	struct drm_sched_entity *s_entity;
+	int i;
+
 	if (sched->thread)
 		kthread_stop(sched->thread);
 
+	for (i = DRM_SCHED_PRIORITY_COUNT - 1; i >= DRM_SCHED_PRIORITY_MIN; i--) {
+		struct drm_sched_rq *rq = &sched->sched_rq[i];
+
+		if (!rq)
+			continue;
+
+		spin_lock(&rq->lock);
+		list_for_each_entry(s_entity, &rq->entities, list)
+			/*
+			 * Prevents reinsertion and marks job_queue as idle,
+			 * it will removed from rq in drm_sched_entity_fini
+			 * eventually
+			 */
+			s_entity->stopped = true;
+		spin_unlock(&rq->lock);
+
+	}
+
+	/* Wakeup everyone stuck in drm_sched_entity_flush for this scheduler */
+	wake_up_all(&sched->job_scheduled);
+
 	/* Confirm no work left behind accessing device structures */
 	cancel_delayed_work_sync(&sched->work_tdr);
 
-- 
2.25.1

