Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D219233DB16
	for <lists+linux-pci@lfdr.de>; Tue, 16 Mar 2021 18:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232686AbhCPRjx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Mar 2021 13:39:53 -0400
Received: from mail-dm6nam12on2089.outbound.protection.outlook.com ([40.107.243.89]:39520
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231578AbhCPRjk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 16 Mar 2021 13:39:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K0pgDfjtjXyJR/0i6n0QAfO1Pxd+oz+qaMDSINKbv4LB2iqpm3U8zFGIwLeM3RHNsIuA7SfLZRoF0R7Grdbj2IcpPDQUme7dN1ubBasE0cm6aQbfmQKdBI/1VkPB5AUuU3PWsy9HjIKvqxINwscthRx0FXlMJ77iloe8i5KZriMHJCKFeFOXgBZhjk67eWGNwzqcFBpqZJ7PHQ72jk3mMSzD4GsRlfN1L/brRQuGioP7ZzuEnOzPNnUr5oLT6/uBH4JusFtxggQ472xi+QiRbX+fY5WIHTEg5jrlac/wWq8/scJPYsrv0joflXNicD20YzHoLX7VNKER4310FiHcqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AXljVqjdsitTuTBoKqQCJdMWkC9CRS5s27Hd13gbbOc=;
 b=nLR5pg/0YH2JlRTEmBz83oJXAq9v4JoMya0eO7n51oJ7j+Cm/GlllFhFOgnRaU2hS+FOSSR+PCCSCJE7R+569sIqV+Sq5sK8KWAX0VxB9a/nyhBzMxGSgkiaSf/8Tie8Xh1d+/nk2N3GwUQlD5NTC5pPQRbtp3GBVzCZWr4P9bz6rpTgBRGLcSDR9DABwwHsEp4n00gDg6wpe4IirCXTW84HvN/ed8KOJ23sO8r3uDecVjq7pe2tglamPOuSqkSmtqpNEUoNxD3WuW79n9WFcZlGpD1Rz4zxOXiJeOeEpoGPQmRAxQV7j8l2ozwzzNSvZ8hPj4vnUHhW+CdQ0SJhOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AXljVqjdsitTuTBoKqQCJdMWkC9CRS5s27Hd13gbbOc=;
 b=C0ynh2/KtA7GVlwh7AUB3T4R8z94uK+vyNr1fRG3BlXvHkBe44Vs0iVjsrRJN05kVfAydvUu3Uy6UIy9vb/+wRwCaZt3iSHXVOq1U7Zped3zTyesbZu31cpu8fNK/zi8rAki+ojFFl0aYHvvTZM2sTnBabOonHS/685kFbJwjxA=
Authentication-Results: yadro.com; dkim=none (message not signed)
 header.d=none;yadro.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SA0PR12MB4397.namprd12.prod.outlook.com (2603:10b6:806:93::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Tue, 16 Mar
 2021 17:39:39 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::29cb:752d:a8a7:24a8]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::29cb:752d:a8a7:24a8%6]) with mapi id 15.20.3933.032; Tue, 16 Mar 2021
 17:39:39 +0000
Subject: Re: Question about supporting AMD eGPU hot plug case
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Cc:     "Alexander.Deucher@amd.com" <Alexander.Deucher@amd.com>,
        "anatoli.antonovitch@amd.com" <anatoli.antonovitch@amd.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux@yadro.com" <linux@yadro.com>
References: <ddef2da4-4726-7321-40fe-5f90788cc836@amd.com>
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
 <bd621789-d9de-aa2e-4a83-f8154e868325@amd.com>
 <57a72ca6-c58e-76a3-3e19-8aca98fa831c@amd.com>
From:   Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <eb36c4d7-c69b-8e80-c911-d0757d99f124@amd.com>
Date:   Tue, 16 Mar 2021 13:39:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <57a72ca6-c58e-76a3-3e19-8aca98fa831c@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2607:fea8:3edf:49b0:5590:b510:518f:11dc]
X-ClientProxiedBy: YT1PR01CA0033.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::46)
 To SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:5590:b510:518f:11dc] (2607:fea8:3edf:49b0:5590:b510:518f:11dc) by YT1PR01CA0033.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32 via Frontend Transport; Tue, 16 Mar 2021 17:39:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ee9f349c-be83-4a01-2b12-08d8e8a27938
X-MS-TrafficTypeDiagnostic: SA0PR12MB4397:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4397EC71A91D84971B059943EA6B9@SA0PR12MB4397.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mKx2nX0iK3sTTvZNhSEUb9t9at3FuL5+C/bkbYjKcdmbZI4AUm7EEmXNC1J9CK1clXYLlHXb3WO1vD6YrlvSuESxzuDPDeosti3aH1BhKpof6AomzcKM7gBISh/vV+ytu27sgkE2tKd3OrE+WctJASbvU0kg4OLiQV1ngMSQ+zewCmRk5R6kSRjvR85+Tbh2fOG2wvRbz7ny14qUyZQ6mxBC/tI5VDoMFwenuDs7OD702vwMpv8OXHZ3T62X/RChJvIcQ/BVHEZvkmFQbIglqYB1qTNDrExTK6rQQHnc7UWijQ1UZ+25EPx+dEWAv4XfXekjC2ellBfp2LHLHV493kdgU+0YofWY+FwRGzd9JszfwV+iLPAa3aHx2en8CyGoWJP5rr7I9agimPU7+SIL/LnKu+ZNvRry8QftnXaXa9vzfHIIjJ/b36GhbmxxzSAuFqZZE5i4kDTosSxowFgLmUJY/uLi3K4/4jNV5Ryz9jHvHGk+fIgoZdLDdr2F838SEYMclBKtT1BcFouMb2nGIWsUh/IvIyHx7YSFXSjQ/4QW4u5HI293LLCGViXVEuX0Ha3UbKLSwaS8UtJu5C3RPKNiCdCB/oK5m3N1UXg+FHv3qed+1cYaPiq2vww4JvaZHP1G77hJCVFx6kIq8eXWkXLSBIGReJQJy0TS0GH1DlLeGzKC51JgQ9ISU7l29eeEE1UMpFQEitpHYuF0y9e87S0oBWW6cbf5UVSkdDwKuEc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB4623.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(39850400004)(376002)(136003)(366004)(110136005)(966005)(54906003)(8676002)(2906002)(16526019)(6486002)(66476007)(5660300002)(66946007)(53546011)(2616005)(478600001)(6666004)(186003)(316002)(4326008)(83380400001)(66574015)(52116002)(36756003)(31696002)(8936002)(86362001)(31686004)(44832011)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UjBhUjFKZFdXQUYzMk5XNExmbzE4cmF2VDRXZXdvRUlYbUlvaE45OGlmempz?=
 =?utf-8?B?dnFCV2tRVkM1VFBmRHU3VjdJRFlQRkluZlI1aTlKWDZ6a0ptN0JFQ0E3YzRV?=
 =?utf-8?B?ZUhnWGo0M21zbkxJOVlRWjNwT1dDNUZROWM3WVFyaEJRN1lldjcwN2hHUmtY?=
 =?utf-8?B?VFVXL2pDNmRINGNiSUF4Nkx0RzNIbDZsdGluaXJjdjV2REhYdHdtOXBIRmdS?=
 =?utf-8?B?SkVFekNINHBBMm1GNVoyazdseCs0c1c3UGtEODhxeTgxQzZmMDVzb3hJc2tF?=
 =?utf-8?B?R2tmRFpGNGJnTlZpV2Z1MmFyMk9saFpsM05EaW83Zmc2U29GblRDQkZzV3di?=
 =?utf-8?B?S2VkVEh0aWpneThLdXRmNyt1RUwyY2dsWTdQTHN0Snh2cWk3Z3lWQkFENGIw?=
 =?utf-8?B?SGthajdjbndhcGNjbVgwQnJwbklCL0RCVzJpYWdQSks1eGZkK0FxZWdKUklP?=
 =?utf-8?B?QS9YWEcvQXY0Z08rdlpiV1RiU21zc1YzQVoyNmZXb2hEYWhGYTQyQk44SVIz?=
 =?utf-8?B?TS9Jc2pxa0NTOXM1bDJuR2hjbEZpd0FMaGM0cmpRSnhIcXErcWl3L1lkRlNu?=
 =?utf-8?B?Y2J1V1h3aVN0VHFPVVdUVDl3UnplVXNuMTdJQklRbStFVnRKb2gzSmFPUEUx?=
 =?utf-8?B?MW1pNkRLYzRxeTR5aVphRkljLzRLbmpJUTJWT3FxOTRLRURwZ21WcVRSTXVJ?=
 =?utf-8?B?Nk52VDRlSVVnM2VWL0hDcGZ4N3A1ZWhIMEozUU0zcHdTOFdWWlE0bndxcjRx?=
 =?utf-8?B?QzEwZ1hMRjMxSllXQS9BQmtPOFFNZC9tRWFvazFXV21DbDkzYXEzTVNwYnpN?=
 =?utf-8?B?VjJkYjdWelZ0cGxNcFd4SW1xNFk2MGJDa3FrbzZnOXM2WGhLeUpsMFFNc2dx?=
 =?utf-8?B?RGgrNzYzYmxPV1ZCWVdwVDdhWGprUW9mZDNtejFVeUt1T1JPTE5EVGxGS3Fk?=
 =?utf-8?B?Vmw0MVU5RWFqandIVktGRFV1TC9hQzhXdVB0U1VWN25LSjVwSFlhZEFMeG1R?=
 =?utf-8?B?bjJTU1BaUWtqSVg2VG5DSVV6RWZ1Wm1NcHcrVThXcDdVNnJEY3Nsa0NKSWVK?=
 =?utf-8?B?bGJubVpxUGJYUEoyZnYwb0xvUzArb0hnUXl3d1RhNTk4M2NqL3cvYjArcjlQ?=
 =?utf-8?B?VEo2OExMNkJxWFk4cWU0ZEdnUFRkekZ0blhoUUdmZStWYXNGYlFqYW9Va3R3?=
 =?utf-8?B?S2llWEJKcE9rNExuV0l0VTdKT1ZMK2hiTWdBSm9mOFhDTlp6NHR1UThRNlNE?=
 =?utf-8?B?RW82UHd4empyTzZYT1NrUjZxS2FUelJpL3g5ZHY1Q2dZMWZWYjNDRWtndUk5?=
 =?utf-8?B?R3Q3QnFUKytZeUFVaEFaMjVPMlVHRTZ3eWtETXhJeDI0a0FCR0F3U1RmV0Fi?=
 =?utf-8?B?b3lPY211SWEzNHI3ZEdtKzlueFBnTFlqQ0c4LytXckhSejhQdE94SG1QWXB2?=
 =?utf-8?B?K2VOQ2hYVWNtUW1tTERIdFB0LzZ1NVRieUdWRXZ2dVdzSTY5Y2N1QU5ibWtE?=
 =?utf-8?B?S0lOb1d0YnNlckRYTnBrWFd0N0lGMC9yYWoveXJ2cURiRGNCMGRoN0lRN3c0?=
 =?utf-8?B?amQ5QWR6aHJKSzMwMnVvdlVGMFZtTGt0N3I5eWhwVEVVTG5CZWtwc0ZkM29i?=
 =?utf-8?B?ZkpKc2FxTWczSTM1WUxsRmMrd1UwOXV2QUF1TjBPNVRCZkZNNng2Tk1qUDJN?=
 =?utf-8?B?VVhZVnZsWlFpYWhmSUZZRnVjQnRza1RXcE5HVzdNaGd5MG8wVE1WMHZZcTNT?=
 =?utf-8?B?aHhSWUFNd1pDQUVSMGVkWTlPMnhaMkFVTEUzQm8xY2dkMy8zNytEYlU1TW5n?=
 =?utf-8?B?OGR4SXJXM2ZQRlhUU09vZW55UWRGMEVOUTIxdXJMYWdQQWxxdkhmWE9hYm42?=
 =?utf-8?Q?XASfHhXoHGdHX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee9f349c-be83-4a01-2b12-08d8e8a27938
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2021 17:39:39.0674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rsRhWI96VfRZl8R5XPLSNS2oajSdqRKesDSTqnzLjp9bzlGxEFseo6xXBhHJPMceQFvoyPEAzLnmhXhI6LxmRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4397
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 2021-03-16 12:17 p.m., Christian König wrote:
> Am 15.03.21 um 18:11 schrieb Andrey Grodzovsky:
>>
>> On 2021-03-15 12:55 p.m., Christian König wrote:
>>>
>>>
>>> Am 15.03.21 um 17:21 schrieb Andrey Grodzovsky:
>>>>
>>>> On 2021-03-15 12:10 p.m., Christian König wrote:
>>>>> Am 12.03.21 um 16:34 schrieb Andrey Grodzovsky:
>>>>>>
>>>>>>
>>>>>> On 2021-03-12 4:03 a.m., Christian König wrote:
>>>>>>> Am 11.03.21 um 23:40 schrieb Andrey Grodzovsky:
>>>>>>>> [SNIP]
>>>>>>>>>> The expected result is they all move closer to the start of 
>>>>>>>>>> PCI address
>>>>>>>>>> space.
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Ok, I updated as you described. Also I removed PCI conf 
>>>>>>>>> command to stop
>>>>>>>>> address decoding and restart later as I noticed PCI core does 
>>>>>>>>> it itself
>>>>>>>>> when needed.
>>>>>>>>> I tested now also with graphic desktop enabled while submitting
>>>>>>>>> 3d draw commands and seems like under this scenario everything 
>>>>>>>>> still
>>>>>>>>> works. Again, this all needs to be tested with VRAM BAR move 
>>>>>>>>> as then
>>>>>>>>> I believe I will see more issues like handling of MMIO mapped 
>>>>>>>>> VRAM objects (like GART table). In case you do have an AMD 
>>>>>>>>> card you could also maybe give it a try. In the meanwhile I 
>>>>>>>>> will add support to ioremapping of those VRAM objects.
>>>>>>>>>
>>>>>>>>> Andrey
>>>>>>>>
>>>>>>>> Just an update, added support for unmaping/remapping of all VRAM
>>>>>>>> objects, both user space mmaped and kernel ioremaped. Seems to 
>>>>>>>> work
>>>>>>>> ok but again, without forcing VRAM BAR to move I can't be sure.
>>>>>>>> Alex, Chsristian - take a look when you have some time to give 
>>>>>>>> me some
>>>>>>>> initial feedback on the amdgpu side.
>>>>>>>>
>>>>>>>> The code is at 
>>>>>>>> https://cgit.freedesktop.org/~agrodzov/linux/log/?h=yadro%2Fpcie_hotplug%2Fmovable_bars_v9.1 
>>>>>>>>
>>>>>>>
>>>>>>> Mhm, that let's userspace busy retry until the BAR movement is 
>>>>>>> done.
>>>>>>>
>>>>>>> Not sure if that can't live lock somehow.
>>>>>>>
>>>>>>> Christian.
>>>>>>
>>>>>> In my testing it didn't but, I can instead route them to some
>>>>>> global static dummy page while BARs are moving and then when 
>>>>>> everything
>>>>>> done just invalidate the device address space again and let the
>>>>>> pagefaults fill in valid PFNs again.
>>>>>
>>>>> Well that won't work because the reads/writes which are done in 
>>>>> the meantime do need to wait for the BAR to be available again.
>>>>>
>>>>> So waiting for the BAR move to finish is correct, but what we 
>>>>> should do is to use a lock instead of an SRCU because that makes 
>>>>> lockdep complain when we do something nasty.
>>>>>
>>>>> Christian.
>>>>
>>>>
>>>> Spinlock I assume ? We can't sleep there - it's an interrupt.
>>>
>>> Mhm, the BAR movement is in interrupt context?
>>
>>
>> No, BARs move is in task context I believe. The page faults are in 
>> interrupt context and so we can only lock a spinlock there I assume,
>
> No, page faults are in task context as well! Otherwise you wouldn't be 
> able to sleep for network I/O in a page fault for example.

Ok, that was a long standing confusion on my side, especially because 
'Understanding the Linux Kernel' states that do_page_fault is an 
interrupt handler here - 
https://vistech.net/~champ/online-docs/books/linuxkernel2/060.htm
while in fact this is an exception handler which is ran in the context 
of the user process causing it and hence can sleep ( as explained here 
by Rober Love himself) https://www.spinics.net/lists/newbies/msg07287.html


>
>> not a mutex which might sleep. But we can't lock
>> spinlock for the entire BAR move because HW suspend + asic reset is a 
>> long process with some sleeps/context switches inside it probably.
>>
>>
>>>
>>> Well that is rather bad. I was hoping to rename the GPU reset rw_sem 
>>> into device_access rw_sem and then use the same lock for both (It's 
>>> essentially the same problem).
>>
>>
>> I was thinking about it from day 1 but what looked to me different is 
>> that in GPU reset case there is no technical need to block MMIO 
>> accesses as the BARs are not moving
>> and so the page table entries remain valid. It's true that while the 
>> device in reset those MMIO accesses are meaninglessness - so this 
>> indeed could be good reason to block
>> access even during GPU reset.
>
> From the experience now I would say that we should block MMIO access 
> during GPU reset as necessary.
>
> We can't do things like always taking the lock in each IOCTL, but for 
> low level hardware access it shouldn't be a problem at all.
>
> Christian.


I will update the code then to reuse  our adev->reset_sem for this locking.

Andrey


>
>>
>> Andrey
>>
>>
>>>
>>> But when we need to move the BAR in atomic/interrupt context that 
>>> makes things a bit more complicated.
>>>
>>> Christian.
>>>
>>>>
>>>> Andrey
>>>>
>>>>
>>>>>
>>>>>>
>>>>>> Andrey
>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>> Andrey
>>>>>>>
>>>>>
>>>
>
