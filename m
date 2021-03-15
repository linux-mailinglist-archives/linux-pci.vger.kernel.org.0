Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8785D33C3BD
	for <lists+linux-pci@lfdr.de>; Mon, 15 Mar 2021 18:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235042AbhCORMe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Mar 2021 13:12:34 -0400
Received: from mail-bn8nam11on2062.outbound.protection.outlook.com ([40.107.236.62]:15873
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235796AbhCORMG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 15 Mar 2021 13:12:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iLNHpENaZd13RW0GaVxQat2LX1P9VLJSyRPT3jB01m4/7XbZvu6LECmCWaPA6Veizn7Ex/+u30vIoSFf9iLGUGM42xPM3Gvtqt50d4ZjwUitxDDxqDAnXg6rAlhdzMVj52IsPAx/Pc5DwIYok1374T9BQJlyO8x4IOJY1WiI5gPdwG4o54MF3zBWXCmiROyxtFg2ztERCzPGb6PzxRgvuACsR4wR6HsvblbjGs+E3EMk9xJDKYhcNvmJ2R8ev0WJH1zmxZe+eZJCih8d7LJMlBA5tySXnf+GqYdCfOZBDqsJ9Uw/ewDg5F3UgtrZr98bpJDebHKfA9VwRFx0GC3nlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PcBhV9alpFzohkMC9VFVRRe5KSfURP7gPFcabMqVffQ=;
 b=jIinl9Gm1SpyaZqbKqMxdHHnDfLHjJMHOlSLYSyDWTzN2ZM34Vru0Ix5cT5Y6DfoUvATYyxboo+Wz5zTvsa0ElyQqbXh+MwLj5fYV8NQq65uksG6Ykp8byL1W6z5o9z8wsSQRQbuGhAcXvFknq29bFMVjzm/u4s0YGCVsNzOukpW+KElyBPr/QFwbau/fseIWC0LSkv+cX4VVX8S8fWpu3+u/O6EPpkeMsHijqHgGqaWazK6nryTQRSAJ25ft4FKqvz/5wWbjTLRurcJHk+afshLiCvIcx56KqLYWeY8NrX49JMjTLCg1kExqE4HhxzC7Pd9nz0/xnB26dRV0yY51A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PcBhV9alpFzohkMC9VFVRRe5KSfURP7gPFcabMqVffQ=;
 b=opWJevfgClLfC04Gos9DOgoPKP6prqYjn6JFqjb2z6JC4TUg3Udw8Ui1EadusGHAo3GnyLVh1Y3oAFu1DakPA03iHIDQtAxjPtbVRjWx27xH8wfmanO3K9dM9isJWFQGi/S67lHb7MA7etkm7Y4Ce99tpljrffHrDtALt28tkEM=
Authentication-Results: yadro.com; dkim=none (message not signed)
 header.d=none;yadro.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SN6PR12MB4767.namprd12.prod.outlook.com (2603:10b6:805:e5::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Mon, 15 Mar
 2021 17:12:02 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::29cb:752d:a8a7:24a8]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::29cb:752d:a8a7:24a8%6]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 17:12:02 +0000
Subject: Re: Question about supporting AMD eGPU hot plug case
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Cc:     "Alexander.Deucher@amd.com" <Alexander.Deucher@amd.com>,
        "anatoli.antonovitch@amd.com" <anatoli.antonovitch@amd.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux@yadro.com" <linux@yadro.com>
References: <ddef2da4-4726-7321-40fe-5f90788cc836@amd.com>
 <927d7fbe-756f-a4f1-44cd-c68aecd906d7@amd.com>
 <dc2de228b92c4e27819c7681f650e1e5@yadro.com>
 <a6af29ed-179a-7619-3dde-474542c180f4@amd.com>
 <8f53f1403f0c4121885398487bbfa241@yadro.com>
 <fc2ea091-8470-9501-242d-8d82714adecb@amd.com>
 <50afd1079dbabeba36fd35fdef84e6e15470ef45.camel@yadro.com>
 <c53c23b5-dd37-44f1-dffd-ff9699018a82@amd.com>
 <8d7e2d7b7982d8d78c0ecaa74b9d40ace4db8453.camel@yadro.com>
 <f5a9bc49-3708-a4af-fff1-6822b49732c0@amd.com>
 <1647946cb73ae390b40a593bb021699308bab33e.camel@yadro.com>
 <3873f1ee-1cec-1740-4238-a154dd670d62@amd.com>
 <98ac52f982409e22fbd6e6659e2724f9b1f2fafd.camel@yadro.com>
 <146844cc-e2d9-aade-8223-db41b37853c5@amd.com>
 <e3f3de55-8011-77d8-25ac-f16f8256beff@amd.com>
 <1f5add8b-9b2d-8efd-02d8-ee8ab33c070a@amd.com>
 <f3f74ff6-f7cf-5567-6af4-cfb0e2769cc9@amd.com>
 <6714c482-7662-8e26-65f2-76a011be6f78@amd.com>
 <77b5cd7c-3871-0943-8a19-a7ce9c4a91dd@amd.com>
 <546ba5d4-d27a-4f81-cf1c-222c5f95899a@amd.com>
From:   Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <bd621789-d9de-aa2e-4a83-f8154e868325@amd.com>
Date:   Mon, 15 Mar 2021 13:11:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <546ba5d4-d27a-4f81-cf1c-222c5f95899a@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2607:fea8:3edf:49b0:4d2a:2ae2:5c90:5ef9]
X-ClientProxiedBy: YT1PR01CA0142.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::21) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:4d2a:2ae2:5c90:5ef9] (2607:fea8:3edf:49b0:4d2a:2ae2:5c90:5ef9) by YT1PR01CA0142.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32 via Frontend Transport; Mon, 15 Mar 2021 17:12:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2e3ae24d-3b53-4595-6f07-08d8e7d57338
X-MS-TrafficTypeDiagnostic: SN6PR12MB4767:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB4767F395E2E9BC62C5071579EA6C9@SN6PR12MB4767.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 94PJFhkoxNIEckRflMNmmmbIrKcVTaUL78KmecM9NPbMeVpBXgGUDuyS2uQn8vT4klWiPM8HkqtBVqGIdBWaPLRcHFIcSO60m6HfVctPgQQP6xgc300o+PV8EaqeujSSh/T8hT+758Ufyj7wc108+8CP5EfvULz7LuWHpAW0MINL9pb2Zo82LuKD9owgwEgb74DfRvGSdaCJNhM4obVirE1TeLs+B9/+Tw8xqm9RbzXthudSDywDFUVOIvM0KawcHzp4R+/YlZCamB4UrId854eZW4zKfaLGo8eiGayPaZr9E8s3kU5bykzZvqiWKEglr/If4x1Qyu0CPibibEv4mv1/hTBQivNIriA9e9Pmp9Xiy5G623/3JRG7qM1hVfwmV8swuYLxmB+IsOq30SIPxqyU0jYB/bZ9zpOIv8mkU9N1bqn5ddrz+DWe6lMzPBiwyiTvocO44lP7w/UKUEq5XMyjzfCFDbH+Ya7lWQkRElO70JYxQOv1EJyfiQo31Bdd7l4MhauytciifLhe0Mi7mEuaH48XZkOXaIdKeBrgbMPnkXPBE9s9gKTxANoeD5CrWYi45zm/vp3NPNRMfNjUxDj4hPFPCHqrAhPn4MdyBP8WzlkGpN9Em3N3701S6etiu96pV/x8dLEF2wXpvVefQvnZWsrjTE5QGB4+GUTZnZVpr3hTWksHvyUtVFDvGE0V
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB4623.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(396003)(39860400002)(366004)(110136005)(6486002)(2906002)(53546011)(66556008)(31686004)(66476007)(52116002)(44832011)(316002)(86362001)(83380400001)(66574015)(4326008)(54906003)(16526019)(31696002)(8676002)(966005)(36756003)(5660300002)(186003)(8936002)(478600001)(66946007)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WTZjUE15VVNaL0pnLzljUlgrdFNXMGJ1R00rb29OTzZSWlhadE1zcUNDZVJF?=
 =?utf-8?B?TTJnZ01WNU5weVQ0bDhuTUNrQXYxa3hrRi9yeFRUbzVSYW1VaGYvUVhlcktq?=
 =?utf-8?B?YW1UbjZtYUZvdENleGErZTVYNWVnZGZDS3FHS242NHRGLzVvTG0vUlYyVEhq?=
 =?utf-8?B?Q0E0ai9sbXpJQkxFcTN1bUZ4T3czTXVkTnBseStkSzE1TU1pM2NxQjB6OHpD?=
 =?utf-8?B?dVZ2Z29GVDBSaTFYUVVDeWh6S0s5QlJFV0lHUnJYTkV3WHh0aG9idkpnbUlS?=
 =?utf-8?B?Qzk1VllEdWFJTUxpWXhjVGJ2QVZaSFFiMm51Rng0V1ZRQU1BczE0eGhyV1lU?=
 =?utf-8?B?TUgwYnZ3QTE4cEtoQW1HM2J0dndjT1RWK3dRM0hsb2pVa0FFV3pUT2cwbzJi?=
 =?utf-8?B?V2FQRTJiSG1acDVqcUVHUGllaDZ0akhvbXNESnAveHEvY0dSVUVhR3FEZzVy?=
 =?utf-8?B?N3Q1YUdRMDBFRG9Td1UyMDNaREduNGFVRDdmSVlIeklmMThlWmJ3SFRqYkcz?=
 =?utf-8?B?NkR0VndXWEc0elYwck8vcWhPWDZsak5BV2x4TGpPdnJaaGUvWXFCVGhZaVRI?=
 =?utf-8?B?ckM4K0JpMngzbnA1ZlJyc3JweDRCNUVxZFR1bzBYWXVnMG44Tmw1dDBibWtY?=
 =?utf-8?B?a3I4Q0VaaFFrc1ZNc2d3Tk55TmRlUzlJYWtYRW55RzQxUkk2OWU3QnhtN2JJ?=
 =?utf-8?B?SHdwNzRiRlBOL211a3lFdGVKemh6U1lXSTlzT1ArcEZmNU9OMmxoZjZSdDE5?=
 =?utf-8?B?OFJ5bDhhOWN4TU8zMHRZSzVWbkhLc3cybWVkUTVzZ2k1N09LOHVYY0tVdERF?=
 =?utf-8?B?NThVQkpDeXpONkg1Sis4QWNtR0w1ZDZzcGVFdlV0bmtidFNYWjhadGJ1U0ds?=
 =?utf-8?B?Z2FGYW5WV0lQNmdHS0c3Y1pjT2FreVZoaTN6WnJZc0hPWlBuTUNsODlXRkVn?=
 =?utf-8?B?ekF3czdHMEpOdlR5Y0E4Z3R2Rml4RHZQcldzVTdxTGo1eXlmZm5SZTUyTm1G?=
 =?utf-8?B?RUxTbmlKNnZRdFhkU3VLVVM5SU1pQWN3a3p6WC9uekZQV2l0cjlMVWFWSFJ3?=
 =?utf-8?B?ZnlUb2wxYXBpNkFHTkpUdEM4eFFYbllzWFkvN21ucVRJcTlEdkhPeUR3OW4y?=
 =?utf-8?B?a3Y4aVA2b3FVdWJ2STk2SE15QlAwc2c2SHBUS0lxT1FZYk1xV3hSYWJDa0Jo?=
 =?utf-8?B?RzhaNnhyVUwxcnlMRjluVVpTYUhwWGJtaGs1RllHQnp4TTNsV3ROZjVHUTFa?=
 =?utf-8?B?RmV3TTZsU2I1V0tlOC96U3pNZEZhNTJQSFZ0Z053dU1kcFBwcVNaekp1OE5p?=
 =?utf-8?B?UjNhdjdpbU5aa1NRcDFxdk9iTHZ6Ui94QjhpeTlFazY3VzlzUEVFSCsxTDBY?=
 =?utf-8?B?LzQ2VTBzaU5qR01kUlJ5SlE1RDJhQVNGWXgyU2FYL0ZweFRNVitDQzU5cjB2?=
 =?utf-8?B?VlpJU2sxKzhQNnJyZU1yMWFCalFsaUsyMUZ2dWNYR0FiblBybXhXTG84dGV5?=
 =?utf-8?B?UHNzZkszNW40Q1J1QkljQVlyUVc5di9lMzhEZVZzQ2ttelhudmpGa1o1MUIx?=
 =?utf-8?B?RGVzczBYNkZHZUs5Q0JNelRwcmozc0RlZDk2aUNmL2NHN3hkcnJLUDNuMjNV?=
 =?utf-8?B?aVRmL2xiQStXK2E3aWgycm9uY0l0SElPNHJwWTNXY1BhRlRIS0taNE51U2pu?=
 =?utf-8?B?eHV0VjI1WDVsRkxLOGU3TEc2a3BseEdnT0VmOTNtV1JpNVlkN1JSQlVzaTd4?=
 =?utf-8?B?ZThvSlkvcWNxYTRkNEZRai9HMHJleGlaKzFGbi8xK2dNcGtxMTZuYS9DbUNS?=
 =?utf-8?B?VWZ6bzE1WVJrTjZPL2JDWTBQc3JoaS9aNEtyazAwTGlKSVpaeGRWaElxazJr?=
 =?utf-8?Q?rrr+BKvLXc/pt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e3ae24d-3b53-4595-6f07-08d8e7d57338
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2021 17:12:02.2212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hSg2KoQB1uUxVx9wDE8KzAuVDl+036o1hAFy6CUoP0oNOxxBo0gZfupoqcFkdO4+F7t9F39ZJDbWtSdYifkb0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4767
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 2021-03-15 12:55 p.m., Christian König wrote:
>
>
> Am 15.03.21 um 17:21 schrieb Andrey Grodzovsky:
>>
>> On 2021-03-15 12:10 p.m., Christian König wrote:
>>> Am 12.03.21 um 16:34 schrieb Andrey Grodzovsky:
>>>>
>>>>
>>>> On 2021-03-12 4:03 a.m., Christian König wrote:
>>>>> Am 11.03.21 um 23:40 schrieb Andrey Grodzovsky:
>>>>>> [SNIP]
>>>>>>>> The expected result is they all move closer to the start of PCI 
>>>>>>>> address
>>>>>>>> space.
>>>>>>>>
>>>>>>>
>>>>>>> Ok, I updated as you described. Also I removed PCI conf command 
>>>>>>> to stop
>>>>>>> address decoding and restart later as I noticed PCI core does it 
>>>>>>> itself
>>>>>>> when needed.
>>>>>>> I tested now also with graphic desktop enabled while submitting
>>>>>>> 3d draw commands and seems like under this scenario everything 
>>>>>>> still
>>>>>>> works. Again, this all needs to be tested with VRAM BAR move as 
>>>>>>> then
>>>>>>> I believe I will see more issues like handling of MMIO mapped 
>>>>>>> VRAM objects (like GART table). In case you do have an AMD card 
>>>>>>> you could also maybe give it a try. In the meanwhile I will add 
>>>>>>> support to ioremapping of those VRAM objects.
>>>>>>>
>>>>>>> Andrey
>>>>>>
>>>>>> Just an update, added support for unmaping/remapping of all VRAM
>>>>>> objects, both user space mmaped and kernel ioremaped. Seems to work
>>>>>> ok but again, without forcing VRAM BAR to move I can't be sure.
>>>>>> Alex, Chsristian - take a look when you have some time to give me 
>>>>>> some
>>>>>> initial feedback on the amdgpu side.
>>>>>>
>>>>>> The code is at 
>>>>>> https://cgit.freedesktop.org/~agrodzov/linux/log/?h=yadro%2Fpcie_hotplug%2Fmovable_bars_v9.1 
>>>>>>
>>>>>
>>>>> Mhm, that let's userspace busy retry until the BAR movement is done.
>>>>>
>>>>> Not sure if that can't live lock somehow.
>>>>>
>>>>> Christian.
>>>>
>>>> In my testing it didn't but, I can instead route them to some
>>>> global static dummy page while BARs are moving and then when 
>>>> everything
>>>> done just invalidate the device address space again and let the
>>>> pagefaults fill in valid PFNs again.
>>>
>>> Well that won't work because the reads/writes which are done in the 
>>> meantime do need to wait for the BAR to be available again.
>>>
>>> So waiting for the BAR move to finish is correct, but what we should 
>>> do is to use a lock instead of an SRCU because that makes lockdep 
>>> complain when we do something nasty.
>>>
>>> Christian.
>>
>>
>> Spinlock I assume ? We can't sleep there - it's an interrupt.
>
> Mhm, the BAR movement is in interrupt context?


No, BARs move is in task context I believe. The page faults are in 
interrupt context and so we can only lock a spinlock there I assume, not 
a mutex which might sleep. But we can't lock
spinlock for the entire BAR move because HW suspend + asic reset is a 
long process with some sleeps/context switches inside it probably.


>
> Well that is rather bad. I was hoping to rename the GPU reset rw_sem 
> into device_access rw_sem and then use the same lock for both (It's 
> essentially the same problem).


I was thinking about it from day 1 but what looked to me different is 
that in GPU reset case there is no technical need to block MMIO accesses 
as the BARs are not moving
and so the page table entries remain valid. It's true that while the 
device in reset those MMIO accesses are meaninglessness - so this indeed 
could be good reason to block
access even during GPU reset.

Andrey


>
> But when we need to move the BAR in atomic/interrupt context that 
> makes things a bit more complicated.
>
> Christian.
>
>>
>> Andrey
>>
>>
>>>
>>>>
>>>> Andrey
>>>>
>>>>>
>>>>>>
>>>>>> Andrey
>>>>>
>>>
>
