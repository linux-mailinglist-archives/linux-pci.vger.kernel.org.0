Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 879EE36EEA2
	for <lists+linux-pci@lfdr.de>; Thu, 29 Apr 2021 19:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233329AbhD2RNr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Apr 2021 13:13:47 -0400
Received: from mail-dm6nam10on2054.outbound.protection.outlook.com ([40.107.93.54]:34401
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233302AbhD2RNq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 29 Apr 2021 13:13:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=koHHn4I0T5q202tsoPCYArVGsbqLYhiDu1D+5jAO1a8V4FqBrd6exaHI4KI/Qj42C6yg2HvmoQdSVo/gNbrVAlp9S1fnDa/HGzWdn4zrT12yIByZ85HU4aJrfNOiCIIibTKuL+qPfp4EJdrEHlueL0505jyidfXh6zjWnl1bbAJAunC0j9OLJDlLz9RGZwNWUF1Pmtt6wNAAI8B9uZsRMWRFOiIDLz7AvfO2E6dl4P0YJBC1wCOyUUG327Hzk1dpPMUxbXTNlaVwrNt74g2rhRLymYYFuwFYeG3oFcNsZXSDv/Bi4Yoj5LfO+yn8uPG5nukK+RZmvXP439qJ8Yxyrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ryLv2AcH2FiW1e4rfnRgFjKOIjiH0I1sXeStmMW0yGI=;
 b=M/p7lr0VfgtMu2/CCVCKWUVPoCyl8gfcxQ1FoM9MREltAA3OFHaFpq5cbNFWVkgDPuZdNaO+v6YOmv3W4ZcrOEhEo+zmVVglSlM7DM/UqctkG1dIUTHZSzyIh0jvtQJP5UmGBCbPgHVTCaM21t3Nlsy0bnxKuNNL2kkVXKBm4dHOsKr9m8H0vULSO3obEr3EoQcL10rWEEbJ/C2bISst3S5lMB3628iqRklld8zS5j09ikJMmdmEnOdzIs7hs0hnxOR0yYT15bj/Kdd79tAEpQYhJnRk0U2Bn9SwRO9/Kxj3QYgaiYLsokKojOY5Tl/thIkFdhQwnJGit0GDCiRqIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ryLv2AcH2FiW1e4rfnRgFjKOIjiH0I1sXeStmMW0yGI=;
 b=GqQ/9lKKukrNRS12hNJ8THxu4SSncztPkS7lUhW5UK91Lu4GlSmY4CTAdZ0Fz185ib62Eghkyl7le+cgCAe2fPV2If1+ZWgET7Ht2gkTfF07UrA1OWeDJnIKAFWsEowNEq72EA4mtKRGYGS0BoC2jKYs2nhMewL4XMOf45XfcjY=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SN6PR12MB4717.namprd12.prod.outlook.com (2603:10b6:805:e2::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Thu, 29 Apr
 2021 17:12:57 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::ad51:8c49:b171:856c]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::ad51:8c49:b171:856c%7]) with mapi id 15.20.4065.026; Thu, 29 Apr 2021
 17:12:57 +0000
Subject: Re: [PATCH v5 13/27] drm/amdgpu: When filizing the fence driver. stop
 scheduler first.
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-pci@vger.kernel.org, daniel.vetter@ffwll.ch,
        Harry.Wentland@amd.com
Cc:     ppaalanen@gmail.com, Alexander.Deucher@amd.com,
        gregkh@linuxfoundation.org, helgaas@kernel.org,
        Felix.Kuehling@amd.com
References: <20210428151207.1212258-1-andrey.grodzovsky@amd.com>
 <20210428151207.1212258-14-andrey.grodzovsky@amd.com>
 <f6bbd803-202c-7514-082b-18efa5296520@gmail.com>
From:   Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <eca718d6-249a-166f-d44b-7bc2dce462a8@amd.com>
Date:   Thu, 29 Apr 2021 13:12:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <f6bbd803-202c-7514-082b-18efa5296520@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2607:fea8:3edf:49b0:497:888:9bb9:54f1]
X-ClientProxiedBy: YTBPR01CA0012.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::25) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:497:888:9bb9:54f1] (2607:fea8:3edf:49b0:497:888:9bb9:54f1) by YTBPR01CA0012.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25 via Frontend Transport; Thu, 29 Apr 2021 17:12:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fcf6ca25-6828-4093-5514-08d90b3208af
X-MS-TrafficTypeDiagnostic: SN6PR12MB4717:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB47170C055C12A51FFD32C487EA5F9@SN6PR12MB4717.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TrkTY/9sbdMCpTWijNPXvcsPJfHRE1Q+Spmw7058isxPgewYb74f1vBYsejkEt/UXAfLVYbVx4YC/Suz2EBaeC1B4Ng/LX9h0kw/fD/QFF/whptbadCtkrkD67J1KKzgPV3PYY3V1NpITZgE/P6kVbtiykWVoCRpgPZZZnEryAcdeS/RnEkpzALyT7tyEUL3q0l4qAj1XFpDI0f0NJyhZU+IMyZqBoVLHvxc4irhILCUdfofs1fsFFBUDf6H/irD/9J87yKXne0OMQh0QDd/QaeL/L6u4aCE9I7rL1U6wRnO7S/kIrVxGiulfLKhBpiqxsJRQCPtAadOPMNoaBSBY4qRwOZIOJUusVFsw/x0wN91SkjgK33pQWciIIxIkYh4BnGhkzzTn/6gQHbpkyuI9TlqmyHVeZw8gLv9I6uT5fmI1cQP0GAVy0H4Cw2JarDgzpOmY5BAPF5Wdzz+tG36edPN4X+1Neug70tmj3li4T/EEQzifvMLQCpK9URmms4CkmjYo3N5Gz+yZj28lidAyPvNvY+jQoW3GkIY9HJHj6o9NZLJwH6TlrYKsZp9Vn6y9miN84D+goecQSdMPuvyNg5hJeTh8r0EAM54UtmNUS/mMZx6A82g1dJqnu87uC7c8zRs4KUZiBT6NKM61TJ53wPrOdXuyqhayNl1nVVIg0tYotc8HlIq/BsttnXBaIK6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB4623.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(136003)(366004)(396003)(36756003)(6636002)(16526019)(66556008)(66946007)(53546011)(86362001)(186003)(5660300002)(52116002)(2906002)(83380400001)(38100700002)(66476007)(44832011)(4326008)(8676002)(8936002)(31686004)(6486002)(2616005)(478600001)(316002)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?eFF1TjFIQVVHbE1yU0NjZ2xKQXZJT2JGZWcxMEZ0d0xwbVN2bmVoRnVZVFAz?=
 =?utf-8?B?WXYvLzhOWldhL21UWTZzOXhSdTZNMk9LQVZmN3dHSldJVStVbXNPK3pqRHUx?=
 =?utf-8?B?Ynh5dUMyUzJaUnZBL2JFb1JMSVRiZG04NlpqS2tpN3NFeWhPcjV4Umc4VEQ3?=
 =?utf-8?B?SmI1NkNXVWE1WnhHNWlhT3luVi92WDUwTWlKTnBnYjhOVURhc3hpeEVTUll3?=
 =?utf-8?B?b1RIVHFQNjNVMlU4S3ZqRXFGc2NCQmwrQlBYeWVDSTdpanIxbXk1MWl6cHNJ?=
 =?utf-8?B?cjlZcTVmVVQ5SVc4WHYxa09uTUl0M0pOSzNodFMraExkenY5RlNtaXhMRUFl?=
 =?utf-8?B?M0dEalkzdnJEUlhzdGh2RXBUOTVaZ3BINDZFOG5wYUprMXdienplV0MzNVlo?=
 =?utf-8?B?dFFueTloTUNZWnVScllQMkgvNUoxczJlMjI4cjRmRUJWSnZHOU1uM0lpaStT?=
 =?utf-8?B?bkJxVTdLSndjelpPc3lEOFpiVEVacGxiSWh5NEJyZkJTamx4a0tIVWhYOXhk?=
 =?utf-8?B?ZmRtZllTTEpMaFJpS0FFQnZZaitMeDFVb0xOL0MvU0ZZemcxWHNxWm5Pam16?=
 =?utf-8?B?NUxKNlJqbUVIUXFEbm53ZnI3RC93dE1TL2swdXhpUWtGSUk2blNFczVTMTJy?=
 =?utf-8?B?UlI2SFlwRTlBV3pmbjQ3VEVqOXlETHJFa0VEeGtTTWR0YzV6NkZpWk5oZHVi?=
 =?utf-8?B?bzFScDhLQ0JVWWNXRUluT2RRS0RCaG45N2phZkNEZ01uQTNsS0NUY2FoYW5h?=
 =?utf-8?B?UVVyY2ZWakNxMHBQTVNBdHZyUWdUeHY4MUpxR1QvRWEwMHVnNk5jRE1hWE1J?=
 =?utf-8?B?WXBNQ1BOUStLSzZTWTM5elFLdG4yMWEyR2x5Z1g5WGFxNnhqUC9CbjYzQlVD?=
 =?utf-8?B?WkpYTWRiOXJGaHFWbWVnL2NQZ3gzZ2JtTnc0c2orYW5tcnlHY3BRbmY0R0E3?=
 =?utf-8?B?M1B1REs0emlUQ1hESjU4YVB0V3o3cU9VU0NFRlJwNTJQZEFHL0pTWG1MSEc0?=
 =?utf-8?B?a09TVitiR2YrVG9DalhENVlRSUNvZnR5cGhoVk95ZHp5RHRlR2tJbkkzWWE4?=
 =?utf-8?B?RTR3Q05qb0FQdXFJQmpBb3BXTzVGODJEMGpjY3VrTndEc2xsWmtlQTROYlpM?=
 =?utf-8?B?MGRFeVpTWDJhZG1Ld3FjV1F0T0RMRTNKUlBjYkZKbDdzMUhNSElEVjc5Rklk?=
 =?utf-8?B?V0dENjRUMnlMOXdZeG1QUkNBWWg2MHVGTDUwdmdYaWJZSnJDbUsrSUE3c09J?=
 =?utf-8?B?M3Y5cVorTGlHQ0dzSDl4dVR5eDc2d1RHUnpNQ1AyOEt4NS9ERzhES0FNZ2Vq?=
 =?utf-8?B?VEpwT1VZYjVNZktCZzZpaXRGMmx1MEhUaWJIekE3NnJ6Y3FmNFJIQ0U4N3N1?=
 =?utf-8?B?Z3piZ1NxRlUwZ3pOWFpEQ0JNcEQ4YzRlNE9Jclk4b1hGa1dKYVQ3RW51NTdM?=
 =?utf-8?B?SWViSW1rNmtoOWczOWNWSHBuNWZ3TDFvWFV3cUdIWVN0c3dpaXl2Um5vNEhv?=
 =?utf-8?B?Uk9kU2FsNTZqVThXTFN5YjlSR3BCZk1STEorYkZpdFhXNFREZys1YzcwejV2?=
 =?utf-8?B?bWxxRXUvTzhiM294RGY0YjY2YVphVHBhaXZRUG9GS0xJVS9va0VubjdzN3R0?=
 =?utf-8?B?S0lMQVYzb0tNeGk0aTRBTmZlRXZiclRPRUpzYndDdzV6YThEUHFuT3J2Yzc3?=
 =?utf-8?B?UWYwQWRTZStvZkdLWDVGeEZ2Yno2R3JJajlOS25yN3FTVlBmaXM3dmR3SERU?=
 =?utf-8?B?V1cxblBMN1ZpeVNOd21QT1BxRHpvN3N6R1c3alAxeHk2MDd5WmVyYnVzTTcy?=
 =?utf-8?B?RzllYVhHSWNzOTFDTFhNem5GamJBWUJMRDNKeFRwbGI4cmhuTC90cHFYY01a?=
 =?utf-8?Q?2oOqQ1C/YfD4k?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcf6ca25-6828-4093-5514-08d90b3208af
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 17:12:57.4063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xPkItgDr7Xws1Dn3cYwbMsDnIX1lBOaFp34oqBZ8605bPcSHhA9KTE9Gzc/c+Qw432sNd8ZsAQmRcg2nloSv4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4717
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2021-04-29 3:15 a.m., Christian König wrote:
> 
> Filizing the fences? You mean finishing the fences, don't you? :)

Yes, my bad.

Andrey

> 
> Am 28.04.21 um 17:11 schrieb Andrey Grodzovsky:
>> No point calling amdgpu_fence_wait_empty before stopping the
>> SW scheduler otherwise there is always a chance another job sneaked
>> in after the wait.
>>
>> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 9 +++++++--
>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>> index 34d51e962799..fd9282637549 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>> @@ -533,6 +533,12 @@ void amdgpu_fence_driver_fini_hw(struct 
>> amdgpu_device *adev)
>>           if (!ring || !ring->fence_drv.initialized)
>>               continue;
>> +
>> +        /* Stop any new job submissions from sched before flushing 
>> the ring */
>> +        /* TODO Handle amdgpu_job_submit_direct and 
>> amdgpu_amdkfd_submit_ib */
>> +        if (!ring->no_scheduler)
>> +            drm_sched_fini(&ring->sched);
>> +
>>           r = amdgpu_fence_wait_empty(ring);
>>           if (r) {
>>               /* no need to trigger GPU reset as we are unloading */
>> @@ -541,8 +547,7 @@ void amdgpu_fence_driver_fini_hw(struct 
>> amdgpu_device *adev)
>>           if (ring->fence_drv.irq_src)
>>               amdgpu_irq_put(adev, ring->fence_drv.irq_src,
>>                          ring->fence_drv.irq_type);
>> -        if (!ring->no_scheduler)
>> -            drm_sched_fini(&ring->sched);
>> +
>>           del_timer_sync(&ring->fence_drv.fallback_timer);
>>       }
>>   }
> 
