Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F432373CC8
	for <lists+linux-pci@lfdr.de>; Wed,  5 May 2021 15:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233178AbhEEN6b (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 May 2021 09:58:31 -0400
Received: from mail-bn7nam10on2049.outbound.protection.outlook.com ([40.107.92.49]:16225
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232558AbhEEN6a (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 May 2021 09:58:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V9R7mWf7VdjPtC2UOMjn+CXZW7nb4s1S6uNgGt37HJJsisRXAIY3oUCz9WOhj6Kzq97C18DPmthaOSuJ8v/eYwT+MwfziR0ASZtgGfEAzaMJMXp0tNMqwz4vs0NKGhTnJUdebLgj5MFg6OY1qLS6ezj4dPTQFeRfMsbeWST3mms3Ujqdm5IlinIyyGBD97Wysf3fPDsx9mQYbSsOUl1UtHm67xQ0B7SiOhbdbG0pxjOGYPb/+bLUXuAbqxWlCxVoMGaldYQ9YonDWP/So2zUe3d1EVMbAFcb4IAJQ/pOyxUa/+bZQDeNvY3QphVQH/D0/hZmtVz+I6yYnSNRoTG+lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9I0tucZjO/YXMGY0z2MelcI3tajhyUDKT92gLgJx280=;
 b=QuMGBMIB/ZCPK5LUfkRBhY5HBd9rUSCXkHOh9uQBP8hLCLZh1DTnJedCA2yD3aOEgaiUYGODPpfekQqwEXmOnnl9JIBUQQPvEfnDfk8vNpVi6bIWZbYui/nqVNjmGcUOQvjYabQfu9L8NuWtVjPfOJ+gfAjnmsGLQlz2rv7fir59jzS7lxU1WEc89oMblZpHNqDI/NGcHka57oL9faGIOompiZjP4ors0SXtNDhyVus/SldmQHWlMS91vRP9XiYv/4bEefFF4Pv5XxwKp3AZ3cPGjr8im+5y9dV52rEZoLYpl8iag8OU7CGskKzzbhY/VoVHW+BKmCIv9gjsJHeURA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9I0tucZjO/YXMGY0z2MelcI3tajhyUDKT92gLgJx280=;
 b=0V/UIvbRMfQfKKlD3qhedLEL2cDBb3tVplryWMAgmIHLPNEihuHjjrMHYnsJV5Ie+ZdrZljLpBMgrZ4wdgcPbOsZ3eAAnOfDyu1QRmSgvyfOsmR/AUd1lRId9DJUi2SZfKmf2J9rbQdOvU8LrRyGgdXmpHgdb7S4zjvN5u28aIk=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SN1PR12MB2400.namprd12.prod.outlook.com (2603:10b6:802:2f::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.40; Wed, 5 May
 2021 13:57:32 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::ad51:8c49:b171:856c]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::ad51:8c49:b171:856c%7]) with mapi id 15.20.4108.026; Wed, 5 May 2021
 13:57:32 +0000
Subject: Re: [PATCH v5 20/27] drm: Scope all DRM IOCTLs with
 drm_dev_enter/exit
From:   Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-pci@vger.kernel.org, ckoenig.leichtzumerken@gmail.com,
        daniel.vetter@ffwll.ch, Harry.Wentland@amd.com,
        ppaalanen@gmail.com, Alexander.Deucher@amd.com,
        gregkh@linuxfoundation.org, helgaas@kernel.org,
        Felix.Kuehling@amd.com
References: <20210428151207.1212258-1-andrey.grodzovsky@amd.com>
 <20210428151207.1212258-21-andrey.grodzovsky@amd.com>
 <YIqXJ5LA6wKl/yzZ@phenom.ffwll.local> <YIqZZW9iFyGCyOmU@phenom.ffwll.local>
 <95935e46-408b-4fee-a7b4-691e9db4f455@amd.com>
 <YIsDXWMYkMeNhBYk@phenom.ffwll.local>
 <342ab668-554c-637b-b67b-bd8e6013b4c3@amd.com>
 <YIvbAI4PjFlZw+z9@phenom.ffwll.local>
 <b6d0c32c-cf90-6118-5c60-238b6f4a0aaa@amd.com>
Message-ID: <de7ecf08-b2e5-48de-710a-217b4bfde6ca@amd.com>
Date:   Wed, 5 May 2021 09:57:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <b6d0c32c-cf90-6118-5c60-238b6f4a0aaa@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2607:fea8:3edf:49b0:7d63:ab2e:d405:e927]
X-ClientProxiedBy: YT1PR01CA0044.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::13) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:7d63:ab2e:d405:e927] (2607:fea8:3edf:49b0:7d63:ab2e:d405:e927) by YT1PR01CA0044.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.40 via Frontend Transport; Wed, 5 May 2021 13:57:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 278c4905-8bfb-4275-0eb7-08d90fcdba42
X-MS-TrafficTypeDiagnostic: SN1PR12MB2400:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2400B88E75475EA8C37DCACFEA599@SN1PR12MB2400.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aGXpzCKgw49dkwSpLu92PsCKOlxvTTuar4ZT3PIFQG837QoAznj0mwg0XDHnBLeKqMpFAq0HWjGmDI6R9vwhOEE1xmax4LJl3BLs0i4xq3ZyVj14zJYXPguUnqgbe15TBazQs0rsDvmSg/DwNpjHVqAcaIbzXX2ecQFQOmfjoHFC/8vYpvxLU5k5PUaoL5L9PF/4xrZ9v1242844jhsCdKMKUClzAMf4oAbtxOVMumt0rCVRfM9jvfQ7MvYS++TH+wlOIzdLEEW0DBZ6GGWCX5bX3nZYMU+BlnG4GAAZpOvjA2Gk/bgSFVaRtuK48DYmiTzQfaJc4umdUojYrvn2JHnqz0Deg6NgEmgaXV28VzgEsYlJXljJft+ezgGNOuSHj8AqmGlZi6t0Hkj37EkzDh7uzUdz1BoVFClbe32H/Qg99hAsDis3lqOFG5ldKZP+cHpPEdYYoEEawDMJf+2xIH8n8CDipRPtNzZY3tTdIiYxdqkq5WfYnHBm5LURksXgm56UN8sMMBbbQxB5UOxhGqUZN+8NafgxOA3E6h1+bRqaQIpcAvNz/oZs5o0bFeaNLfoFAzPPMoMcYqBsXGsbX8ii3dZYPCMKNQc5srsrvI6Sr40z/bp14dtC3vZvF0qq5SpALRYDppbpmx/zZ3i3td1MNO4/zCTEGs42172uC19ZZblWOMRM8xMVKhEuloHhXS8Jk5Z62uMUtYbZIm9EMnSg2jaTXKlKkbhd1rOoQTibH2dscCFAIRrQpmA4Z2qObN9bl5RoJvHmBXEZAdJCHw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB4623.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(396003)(346002)(366004)(136003)(36756003)(86362001)(8936002)(45080400002)(4326008)(2906002)(83380400001)(31686004)(6486002)(66476007)(52116002)(2616005)(53546011)(66556008)(316002)(8676002)(186003)(38100700002)(66946007)(16526019)(478600001)(5660300002)(31696002)(966005)(30864003)(6916009)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?azdhanBaRzlFS3o5YVhZYmh6WDJhQUw3YnRlejJ4WGxSaWs5SVd4TUdwazVO?=
 =?utf-8?B?TEFTVWlHNHdIeUx5NVoxS1Y3VlQ4V0tHVEJQTkFON0tINCtqTnFRV2NhZzBr?=
 =?utf-8?B?Y1BmT0FzVDFvNU1DZFJhdFBCa0NZcnF2T0xnbE0yRnYrc1lnOWc4MWxHbmFH?=
 =?utf-8?B?a2ZBVjZ3U1hJbTRhdnZHSWNNa1dpL1VzQzB0d0d3MWVZNEZueHhPNmdVM1dP?=
 =?utf-8?B?ZkV4T0pKZ2dINUxDbWRydTdVTldFMTU5ak04Ty9mbmdMNmd1eWF4RXVERkkr?=
 =?utf-8?B?VE5vcVJkaSs3NDF5Tjgvb1dxckpqT3dwTFhHMlJNa1FmMkxldmNEQVNxdlli?=
 =?utf-8?B?c3ZQRUhFSUVMQzczdGZrOHlCVk12aHpuMjN3MEFMNHRFWXNCTXU0QmIwWEU5?=
 =?utf-8?B?cVNDcklKQ21kV1EwNUZzYVJCQW1vQi9nczBmN09zMnBLOXlCSG1yRWE0UzJ3?=
 =?utf-8?B?UTF2aG5NeDQ1NTdqUXByL3RMUjI4VVNMSXRMdkVQSDJVakhvNVhVSWttemk4?=
 =?utf-8?B?QU9SQ3pGZ0RKcnpRc0tRNTBvZUJJeFVqQWpmRytXMWNIVFdsRlVyZ1ZwaEwr?=
 =?utf-8?B?azNmUjRiTHZLYkJ5R0RpK0RvQnpwcHFBaENCSXplQTdDMkx0SUdhMEJDbUox?=
 =?utf-8?B?MWwzWFdQdGJNNUloU1hnRnhDZEYwTi9pQUNIS1pXbXBSdUE0WkFtVEs5aXdj?=
 =?utf-8?B?R2gxYW9VSHpNQ3NJN3ZTT25ZSHZNald1WWpCWmErZ1laNElEaE5ZMjN3YWkr?=
 =?utf-8?B?OENML3o1QjhnSzFRVm1KMHUrL1hibzNsV3gySVpZTDNRaWhIaWRqbjNvZFll?=
 =?utf-8?B?V0JXSVlGOFBJR0tUdEdzSFkzdEloWmNtVy9jQ0phSzEwN0Jta0tZc1UzN2hS?=
 =?utf-8?B?cHJuV2ZnR1BoTjhZRURUTXlPMVd0WnFwSFVJb3NGcU91Z0lFOTlYbVBhZzcy?=
 =?utf-8?B?WWFSYzE4VDQ3MEdyclY0MjRlSmhjUG55c0ZIUnB5bmszU1FMNHdwQUR1SXg0?=
 =?utf-8?B?UE0rNjJpL1RLc2pHWHRTaHM2c0wxcmpMNjhqM0xDc0syZERXTXNadnRtYkd2?=
 =?utf-8?B?RUJhNjQzSC9iVG1TQVFPU2FMdHU5bk5PR0FTQkhYZkd2NGIxTlhEUktSWEln?=
 =?utf-8?B?UHd2RS9pL2IzeXZiaEJiWU9YdHZweXZNTEZ5dVVxaytCTmRQQWxxTnhEd0pF?=
 =?utf-8?B?UkJOdk9CWEhQalRnajQxWW1Wc3U0a1NYZTU2Vld0dUdyN2NJNHV1ZTlQNWkz?=
 =?utf-8?B?cFFSZWJQVzV0MFN2alEvaE1WSWQ0eG9HenIzKzNTeW9LMWJ3OUZhdFhBMGhI?=
 =?utf-8?B?bGpDQTFVVDJhb2dRSXlhcXpBSnV1UXk5c09HbVNsSldWL0Z3V2VmbVBhd1JI?=
 =?utf-8?B?M1crMFpPRnZGcWVqand1MzdpQWVtR1lrUHhnOUl4RGZJSnZTV3VlbEc0VEV6?=
 =?utf-8?B?eWZpa1pNZFRhbG1uQVg2TXRIcFd2L2JDQjd1YXJINzg1cDFFeHhHb21vMUVO?=
 =?utf-8?B?QURUazFiNW9GU1FvVU83SkgwalBjbDBGdGgwR1BqMzVJUUxLdVNNVzFFRE1J?=
 =?utf-8?B?aUkwZStxK21SRHlzOVQ3ckdiY09pMnhlcithaWFVLzdaNTU4YWtOQWJvR1VL?=
 =?utf-8?B?NlpLOTgyZ3Nld3NsMURheHhjL3BpZisrK3VVcHZsc2wyWnoyK1dqSHF4QXpE?=
 =?utf-8?B?N2tRajF1YmFvOXRpZkNnUngvem5EMXo2V3p1cXNqTklNYTN1YWVRbCtad1J2?=
 =?utf-8?B?WlMvaXZuL2g4Y0JXcmVTMW5hUXk0a3dOdndhTWptOVR1L0plak9DMUw4bGFo?=
 =?utf-8?B?VVVyMzlqTFhKSUl6RGxMOXZsR1dQK2FrZU41dFNTM2tvTVJHNlR5UDlMMENQ?=
 =?utf-8?Q?SqiX1sJrZ9tbW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 278c4905-8bfb-4275-0eb7-08d90fcdba42
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2021 13:57:31.9538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xNTT02yzwDeuJ3uGOCKM6dLEHfUEG6sMwWnq8JOb0GthPQC0ZOQ7LLhP6HM4djqx10egb5LmUnisTrHYFdQm8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2400
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Ping

Andrey

On 2021-04-30 1:27 p.m., Andrey Grodzovsky wrote:
> 
> 
> On 2021-04-30 6:25 a.m., Daniel Vetter wrote:
>> On Thu, Apr 29, 2021 at 04:34:55PM -0400, Andrey Grodzovsky wrote:
>>>
>>>
>>> On 2021-04-29 3:05 p.m., Daniel Vetter wrote:
>>>> On Thu, Apr 29, 2021 at 12:04:33PM -0400, Andrey Grodzovsky wrote:
>>>>>
>>>>>
>>>>> On 2021-04-29 7:32 a.m., Daniel Vetter wrote:
>>>>>> On Thu, Apr 29, 2021 at 01:23:19PM +0200, Daniel Vetter wrote:
>>>>>>> On Wed, Apr 28, 2021 at 11:12:00AM -0400, Andrey Grodzovsky wrote:
>>>>>>>> With this calling drm_dev_unplug will flush and block
>>>>>>>> all in flight IOCTLs
>>>>>>>>
>>>>>>>> Also, add feature such that if device supports graceful unplug
>>>>>>>> we enclose entire IOCTL in SRCU critical section.
>>>>>>>>
>>>>>>>> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>>>>>>>
>>>>>>> Nope.
>>>>>>>
>>>>>>> The idea of drm_dev_enter/exit is to mark up hw access. Not 
>>>>>>> entire ioctl.
>>>>>
>>>>> Then I am confused why we have 
>>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Felixir.bootlin.com%2Flinux%2Fv5.12%2Fsource%2Fdrivers%2Fgpu%2Fdrm%2Fdrm_ioctl.c%23L826&amp;data=04%7C01%7Candrey.grodzovsky%40amd.com%7Cf4c0568093cc462f625808d90bc23a3c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637553751106596888%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=PPKrQYBrgRMjpwlL0r8n5zenIhQMFWc6gniHgUTxTAY%3D&amp;reserved=0 
>>>>>
>>>>> currently in code ?
>>>>
>>>> I forgot about this one, again. Thanks for reminding.
>>>>
>>>>>>> Especially not with an opt-in flag so that it could be shrugged 
>>>>>>> of as a
>>>>>>> driver hack. Most of these ioctls should have absolutely no problem
>>>>>>> working after hotunplug.
>>>>>>>
>>>>>>> Also, doing this defeats the point since it pretty much guarantees
>>>>>>> userspace will die in assert()s and stuff. E.g. on i915 the rough 
>>>>>>> contract
>>>>>>> is that only execbuf (and even that only when userspace has 
>>>>>>> indicated
>>>>>>> support for non-recoverable hw ctx) is allowed to fail. Anything 
>>>>>>> else
>>>>>>> might crash userspace.
>>>>>
>>>>> Given that as I pointed above we already fail any IOCTls with -ENODEV
>>>>> when device is unplugged, it seems those crashes don't happen that
>>>>> often ? Also, in all my testing I don't think I saw a user space crash
>>>>> I could attribute to this.
>>>>
>>>> I guess it should be ok.
>>>
>>> What should be ok ?
>>
>> Your approach, but not your patch. If we go with this let's just lift it
>> to drm_ioctl() as the default behavior. No driver opt-in flag, because
>> that's definitely worse than any other approach because we really need to
>> get rid of driver specific behaviour for generic ioctls, especially
>> anything a compositor will use directly.
>>
>>>> My reasons for making this work is both less trouble for userspace (did
>>>> you test with various wayland compositors out there, not just amdgpu 
>>>> x86
>>>
>>> I didn't - will give it a try.
> 
> Weston worked without crashes, run the egl tester cube there.
> 
>>>
>>>> driver?), but also testing.
>>>>
>>>> We still need a bunch of these checks in various places or you'll 
>>>> wait a
>>>> very long time for a pending modeset or similar to complete. Being 
>>>> able to
>>>> run that code easily after hotunplug has completed should help a lot 
>>>> with
>>>> testing.
>>>>
>>>> Plus various drivers already acquired drm_dev_enter/exit and now I 
>>>> wonder
>>>> whether that was properly tested or not ...
>>>>
>>>> I guess maybe we need a drm module option to disable this check, so 
>>>> that
>>>> we can exercise the code as if the ioctl has raced with hotunplug at 
>>>> the
>>>> worst possible moment.
>>>>
>>>> Also atomic is really tricky here: I assume your testing has just done
>>>> normal synchronous commits, but anything that goes through atomic 
>>>> can be
>>>> done nonblocking in a separate thread. Which the ioctl catch-all 
>>>> here wont
>>>> capture.
>>>
>>> Yes, async commit was on my mind and thanks for reminding me. Indeed
>>> I forgot this but i planned to scope the entire amdgpu_dm_atomic_tail in
>>> drm_dev_enter/exit. Note that i have a bunch of patches, all name's
>>> starting with 'Scope....' that just methodically put all the background
>>> work items and timers the drivers schedules in drm_dev_enter/exit scope.
>>> This was supposed to be part of the 'Scope Display code' patch.
>>
>> That's too much. You still have to arrange that the flip completion event
>> gets sent out. So it's a bit tricky.
>>
>> In other places the same problem applies, e.g. probe functions need to
>> make sure they report "disconnected".
> 
> I see, well, this is all part of KMS support which I defer for now
> anyway. Will tackle it then.
> 
>>
>>>>>>> You probably need similar (and very precisely defined) rules for 
>>>>>>> amdgpu.
>>>>>>> And those must definitely exclude any shard ioctls from randomly 
>>>>>>> failing
>>>>>>> with EIO, because that just kills the box and defeats the point 
>>>>>>> of trying
>>>>>>> to gracefully handling hotunplug and making sure userspace has a 
>>>>>>> chance of
>>>>>>> survival. E.g. for atomic everything should continue, including flip
>>>>>>> completion, but we set all outputs to "disconnected" and send out 
>>>>>>> the
>>>>>>> uevent. Maybe crtc enabling can fail too, but that can also be 
>>>>>>> handled
>>>>>>> through the async status we're using to signal DP link failures to
>>>>>>> userspace.
>>>>>
>>>>> As I pointed before, because of the complexity of the topic I 
>>>>> prefer to
>>>>> take it step by step and solve first for secondary device use case, 
>>>>> not
>>>>> for primary, display attached device.
>>>>
>>>> Yeah makes sense. But then I think the right patch is to roll this 
>>>> out for
>>>> all drivers, properly justified with existing code. Not behind a driver
>>>> flag, because with all these different compositors the last thing we 
>>>> want
>>>> is a proliferation of driver-specific behaviour. That's imo the worst
>>>> option of all of them and needs to be avoided.
>>>
>>> So this kind of patch would be acceptable to you if I unconditionally
>>> scope the drm_ioctl with drm_dev_enter/exit without the driver flag ?
>>> I am worried to break other drivers with this, see patch 
>>> https://nam11.safelinks.protection.outlook.com/?url=https:%2F%2Fcgit.freedesktop.org%2F~agrodzov%2Flinux%2Fcommit%2F%3Fh%3Ddrm-misc-next%26id%3Df0c593f35b22ca5bf60ed9e7ce2bf2b80e6c68c6&amp;data=04%7C01%7Candrey.grodzovsky%40amd.com%7Cf4c0568093cc462f625808d90bc23a3c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637553751106596888%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=%2F3Jq6SvTm%2BZX7AVpaxEepfOj0C3O7%2Bo2Wm3y0gxrmKI%3D&amp;reserved=0 
>>>
>>> Before setting drm_dev_unplug I go through a whole process of signalling
>>> all possible fences in the system which some one some where might be
>>> waiting on. My concern is that in the absence of HW those fences won't
>>> signal and so unless I signal them myself srcu_synchrionize in
>>> drm_dev_unplug will hang waiting for any such code scoped by
>>> drm_dev_enter/exit.
>>
>> Uh right. I forgot about this.
>>
>> Which would kinda mean the top level scope is maybe not the best idea, 
>> and
>> perhaps we should indeed drill it down. But then the testing issue
>> definitely gets a lot worse.
>>
>> So what if we'd push that drm_dev_is_unplugged check down into ioctls?
>> Then we can make a case-by case decision whether it should be 
>> converted to
>> drm_dev_enter/exit, needs to be pushed down further into drivers (due to
>> fence wait issues) or other concerns?
>>
>> Also I guess we need to have a subsystem wide rule on whether you need to
>> force complete all fences before you call drm_dev_unplug, or afterwards.
> 
> I don't see how you can handle it afterwards. If a thread is stuck in
> dma_fence_wait in non interruptible wait (any kernel thread) and with no
> timeout there is nothing you can do to stop the wait. Any such code
> scopped with drm_dev_enter/exit will cause a hang in drm_dev_unplug.
> The only way then is to preemptively force signal all such fences before
> calling drm_dev_unplug - as I do in the above mentioned patch.
> 
>> If we have mixed behaviour on this there will be disappointment. And 
>> since
>> hotunplug and dma_fence completion are both userspace visible that
>> inconsistency might have bigger impact.
>>
>> This is all very tricky indeed :-/
>>
>> btw for the "gradual pushing drm_dev_enter into ioctl" approach, if we go
>> with that: We could do the same trick we've done for DRM_UNLOCKED:
>> - drm_dev_enter/exit is called for any ioctl that has not set the
>>    DRM_HOTUNPLUG_SAFE flag
>> - for drm core ioctls we push them into all ioctls and decide how to
>>    handle/where (with the aim to have the least amount of code flow
>>    different during hotunplug vs after hotunplug has finished, to reduce
>>    testing scope)
>> - then we make DRM_HOTUNPLUG_SAFE the implied default
>>
>> This would have us left with render ioctls, and I think the defensive
>> assumption there is that they're all hotunplug safe. We might hang on a
>> fence wait, but that's fixable, and it's better than blowing up on a
>> use-after-free security bug.
>>
>> Thoughts?
> 
> I don't fully see a difference between the approach described above and
> the full drill down to each driver and even within the driver, to the HW
> back-ends - what criteria I would use to decide if for a given IOCTL i
> scope with drm_dev_enter/exit at the highest level while for another
> i go all the way down ? If we would agree that signaling the fences
> preemptively before engaging drm_dev_unplug is generically the right
> approach maybe we can then scope drm_ioctl unconditionally with
> drm_dev_enter/exit and then for each driver go through the same process
> I do for amdgpu - writing driver specific function which takes care of
> all the fences. We could then just create a drm callback which would
> be called from drm_ioctl before drm_dev_unplug is called.
> 
> Andrey
> 
>>
>> It is unfortunately even more work until we've reached the goal, but I
>> think it's safest and most flexible approach overall.
>>
>> Cheers, Daniel
>>
>>>
>>> Andrey
>>>
>>>>
>>>> Cheers, Daniel
>>>>
>>>>
>>>>>
>>>>>>>
>>>>>>> I guess we should clarify this in the hotunplug doc?
>>>>>
>>>>> Agree
>>>>>
>>>>>>
>>>>>> To clarify: I'm not against throwing an ENODEV at userspace for 
>>>>>> ioctl that
>>>>>> really make no sense, and where we're rather confident that all 
>>>>>> properly
>>>>>> implemented userspace will gracefully handle failures. Like a 
>>>>>> modeset, or
>>>>>> opening a device, or trying to import a dma-buf or stuff like that 
>>>>>> which
>>>>>> can already fail in normal operation for any kind of reason.
>>>>>>
>>>>>> But stuff that never fails, like GETRESOURCES ioctl, really 
>>>>>> shouldn't fail
>>>>>> after hotunplug.
>>>>>
>>>>> As I pointed above, this a bit confuses me given that we already do
>>>>> blanker rejection of IOCTLs if device is unplugged.
>>>>
>>>> Well I'm confused about this too :-/
>>>>
>>>>>> And then there's the middle ground, like doing a pageflip or 
>>>>>> buffer flush,
>>>>>> which I guess some userspace might handle, but risky to inflict those
>>>>>> consequences on them. atomic modeset is especially fun since 
>>>>>> depending
>>>>>> what you're doing it can be both "failures expected" and "failures 
>>>>>> not
>>>>>> really expected in normal operation".
>>>>>>
>>>>>> Also, this really should be consistent across drivers, not solved 
>>>>>> with a
>>>>>> driver flag for every possible combination.
>>>>>>
>>>>>> If you look at the current hotunplug kms drivers, they have
>>>>>> drm_dev_enter/exit sprinkled in specific hw callback functions 
>>>>>> because of
>>>>>> the above problems. But maybe it makes sense to change things in a 
>>>>>> few
>>>>>> cases. But then we should do it across the board.
>>>>>
>>>>> So as I understand your preferred approach is that I scope any 
>>>>> back_end, HW
>>>>> specific function with drm_dev_enter/exit because that where MMIO
>>>>> access takes place. But besides explicit MMIO access thorough
>>>>> register accessors in the HW back-end there is also indirect MMIO 
>>>>> access
>>>>> taking place throughout the code in the driver because of various VRAM
>>>>> BOs which provide CPU access to VRAM through the VRAM BAR. This 
>>>>> kind of
>>>>> access is spread all over in the driver and even in mid-layers such as
>>>>> TTM and not limited to HW back-end functions. It means it's much 
>>>>> harder
>>>>> to spot such places to surgically scope them with 
>>>>> drm_dev_enter/exit and
>>>>> also that any new such code introduced will immediately break hot 
>>>>> unplug
>>>>> because the developers can't be expected to remember making their code
>>>>> robust to this specific use case. That why when we discussed 
>>>>> internally
>>>>> what approach to take to protecting code with drm_dev_enter/exit we
>>>>> opted for using the widest available scope.
>>>>
>>>> The thing is, you kinda have to anyway. There's enormous amounts of
>>>> asynchronous processing going on. E.g. nonblocking atomic commits 
>>>> also do
>>>> ttm unpinning and fun stuff like that, which if you sync things 
>>>> wrong can
>>>> happen way late. So the door for bad fallout is wide open :-(
>>>>
>>>> I'm not sure where the right tradeoff is to make sure we catch them 
>>>> all,
>>>> and can make sure with testing that we've indeed caught them all.
>>>> -Daniel
>>>>
>>
