Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F50633C295
	for <lists+linux-pci@lfdr.de>; Mon, 15 Mar 2021 17:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233194AbhCOQza (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Mar 2021 12:55:30 -0400
Received: from mail-eopbgr750072.outbound.protection.outlook.com ([40.107.75.72]:12358
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229704AbhCOQzV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 15 Mar 2021 12:55:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aSg1MnyqAe0HhKTK7dQTEF0JKNHm+qeh3WPky9vtQSCcQ4FLAMjgU70Xi4mj03G5nxo/THKs1lyYqPQeVDZEeRLLWazdViNzmzybMtzb4v+rkPwaNoqZqOcbLrV/LHhHh4CtimBnGDhcuL0CQVFbC4Vk/uSmSw82jYuSqZH0IJfQ/FLVMTPTZfP7wAVoyTx0t2toI+C0gXZ0TYyD/KRct1RHSkV/t5Is93wFwPfXqXhX7Sqaz6fr8JgYwktLoy5gv0X/OXPNNdr7lYUQN91SHMMVf/lQJmPGdqny2KwV7M6ChZrw+9+Zuk4JzU3WDYjNA1c0DVRmv2t6rWjFRYdikw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V9YSQvicisR9ww+A7cwAtWcu0iVQIrVYaEhskhyhEIg=;
 b=fEq3JrwlYXvJ0zlcibQO/6+tLIMkJbRCmbfbXTM/RVJetCjP4kF0ZqFut/PCPycZZD/Qkqwgl4E5lZ2pW54K3+wtS1or/y0s47/XAyAxF6kxgjOzUGh+KPl7a3+DzYt/MbhSjWgRRPW8zC8wKnmu4JOu0vbB5gNLatKAC8cn/CIp1VAXJvo67y2fpc5yukokmSvc9/72jC+W73sDchz/FuX3+JerCHT4Kjk90rAxqbo/Rk/w1MHqrCpKGMakOK0AClIx7tVNwuGiJp9q1m78PxyL9x9Ho9KQcx8Kz2XOVcJgDgR/SyIy2AbrPL7cRgCwQGQFcxbh0/ReKojXJk4UJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V9YSQvicisR9ww+A7cwAtWcu0iVQIrVYaEhskhyhEIg=;
 b=wEXFDlOw05Wazg7Hq9l8Zbixkvbxka0O+QpPeJhiUDT8ViywLWW6n/Zh8Zw3jZiXp/I4wH/4S7wkhtVvJUkm4qJEWNMXubKI8+eD0YnYBmL/6dX2XJThG5aJKMWfMqhT8rItGWd0UfvIGDqW8K9XVJi8VjhoMb/lIAx4euftNYk=
Authentication-Results: yadro.com; dkim=none (message not signed)
 header.d=none;yadro.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB2482.namprd12.prod.outlook.com (2603:10b6:207:4a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.28; Mon, 15 Mar
 2021 16:55:18 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 16:55:18 +0000
Subject: Re: Question about supporting AMD eGPU hot plug case
To:     Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
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
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <546ba5d4-d27a-4f81-cf1c-222c5f95899a@amd.com>
Date:   Mon, 15 Mar 2021 17:55:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <77b5cd7c-3871-0943-8a19-a7ce9c4a91dd@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:dd5e:327:8807:376f]
X-ClientProxiedBy: AM0PR03CA0053.eurprd03.prod.outlook.com (2603:10a6:208::30)
 To MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:dd5e:327:8807:376f] (2a02:908:1252:fb60:dd5e:327:8807:376f) by AM0PR03CA0053.eurprd03.prod.outlook.com (2603:10a6:208::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32 via Frontend Transport; Mon, 15 Mar 2021 16:55:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fa39159f-1f30-4fa5-88ac-08d8e7d31cdc
X-MS-TrafficTypeDiagnostic: BL0PR12MB2482:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB2482FD61E934C1A3573B68AB836C9@BL0PR12MB2482.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 70S1WwU+kHkPWSRRNOQNhdTV4hqJHWxXkehoeuBcFTGN3aPPmRZ/IZu7nsfhkjGXgL4X/EHKZmStbQWZTnJoVTwYW3YxgUoN9w/kUUbcsl7sboZhahxCqzw5hwB58HGhExoyUzZC7BMKJbc9GZ1mJDqPVTPEMBPAN1wHdnWaL5JCgIK1m342JP2NLX8B/kXdlWTJnPsPJWFxs/dviornF5buQgA7VM5GAQTsC/j8ecAVaGAWv8xcjPmxR+Sm4DZMHHYYVw5XqWLnsJhi0NW9R3udMPRjt1v3pPXxcy2q0Yt4/XyB8y++XLa24OQPPLJ0qlyiZ8t61Qs1jvd1RfqD5v9QIj5mG7YYqFUR6xyjHawF878z7lLCvgd8kEN7gOWbt1XceQEu65E6E7i2VunEhRP/42ZNHfepID0G6a71R6KzOzhbY1clH9LJE9cP7fjyptilxI4edqxta0jQYqA1eosUDj+KmPxbK1BB7uq6HvQRfZXWaKOFYGcbhv6Rst/yYL8kHczvpwv21ymHXzrWKj7EjOT0KBlxAx3bZDKu2Tldu/91ARTpkQAv/tobxXUPFSxKBY7udIw6U8DjE13IonHrsS67qhT+WmdOBFVIG1rs6ydiaaFiR526OxVCSKtHZpyx1ahPeL8lxWlCGZX+Fw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(39860400002)(136003)(366004)(346002)(6666004)(53546011)(478600001)(54906003)(8936002)(66574015)(36756003)(5660300002)(66556008)(66476007)(6486002)(2616005)(4326008)(186003)(8676002)(316002)(2906002)(31696002)(16526019)(966005)(52116002)(86362001)(66946007)(31686004)(110136005)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZnpZVnBvTFJRMXBxb1BtaUczL1JrVnRhcGpQNmgxRm1UT3RFcFRTYkRKenhw?=
 =?utf-8?B?ZWp1bUVUeGlNN0pJYnVpQ2xwSTZxMlgxa09TQlFUQTdGak9NdFBUdVNaaVA0?=
 =?utf-8?B?T3FUcWVaKzBWWHRoeWRrN0J0bktVWVoyS01vN0xkQk9RQ3lFZVBPQ0kwaW82?=
 =?utf-8?B?Vzg4bXJkR3RiY0NzVDArdEFkWXNhbk9iUjBtTExUTERzU2I5bE1xUkg0MXJE?=
 =?utf-8?B?bWwwOGJBQnRWZU9LN1pzMW5yVVBhN0NzQWlQQXA1RXo2UzI5UFk5ZE5nM1lk?=
 =?utf-8?B?dTB3Uncwc0RuekdhMUVYTWI2RXFGanZJUEhsNDlRSytUYmRQaEFzbXBuYWlJ?=
 =?utf-8?B?NVNSWlZZK0VHbGcvSVZ2eXN0YjJYb3hoNVFMUWRHZHphcEVDdE5GS1NtQXZq?=
 =?utf-8?B?a2VUS1YyYjN5aGpZekM1NzhvNFR4cGdDWmN5bUIyWDduejdlaFlhNDIrWnNS?=
 =?utf-8?B?c0NTN2M3ZXNnNzNnUmllTmw4c3FVem1QeEVGSy9PNk50YisyQTVGSEtqbzBy?=
 =?utf-8?B?MVJJRmhRdmNGMktkb2dDUXJ4dldwWS9uLy8wL1BkcnR1M3NEY0luSHJTSTkx?=
 =?utf-8?B?c1pNZ1h0d3JJK3pJMXVvbjJKeittYU5DNGZIZytHRG9zZkovRXhISXE1REdO?=
 =?utf-8?B?Wmljd1BrMXg4NkN3UzUzNUowNTh4M2JkNHB4Z1hsWmQ0blNXYThxRVNRWG9i?=
 =?utf-8?B?UEwrazZyZU53a3N0ZmxadWJVWkc0MW4zQkNHL2RFTGx2TlBNL2NPNmZNM04z?=
 =?utf-8?B?VFVTSzJVeUlkeDRoNDdoMzU4K3hLUlp3SVR6VjM2Z0haUEtYYXY2eTdZdlMy?=
 =?utf-8?B?dDhPb25lMnFaNERaMjRyQWZ2TVFtalAwaStuR0pGUTNKRnpabm5jNi9wakN6?=
 =?utf-8?B?bUdQY1gwZDR0RDRSSVZtTHJrTTMycmdqckIwdkx0cVBKMmt3Qi80OGJSK0dG?=
 =?utf-8?B?TWkydG5CMjBGS2dHbU0zQjQvbkV0bnB1NjZxakNzM2NYZUpZbXNBWFp5L0dN?=
 =?utf-8?B?UEt4M1pkcXFZRUVpajh5ZkRQRGVuS2hpZi83V0s2eHNqQnNOejBzRHo5N3JW?=
 =?utf-8?B?RmxxbWlSM0JDaGc4WmYvck80UU9JTFl5MGhPd0RNcjhUZEQyVkVRWVMxTXh4?=
 =?utf-8?B?SysyeTlwMTZwcDFIZjFJREFKcE9rOEYwYzBUZGZYM2g1d3B1a1I4YTI1RlJh?=
 =?utf-8?B?enpib2M0S08zZHNyOVFNR3ZwQkk5UGlNeEVJQVhYclNDd0RrZThFZ2o5NG9h?=
 =?utf-8?B?SHRxS0FGU3dDY1YwTlQ2ZHFseGtZYzdtTWF0NmNhZFU0L2w5bzc1TXE3S29C?=
 =?utf-8?B?OFg4QUtsZnhycWxoc1VocTY4UTQxYmxYVmU2UUlCY1NoQ0JUQVFlYW5aME9k?=
 =?utf-8?B?WWNlRHY0K2tRS0VnZzlwdFZrcVdqdTFqY1R3YlByb3BaM0EvYkVDUnJ1Z2Ey?=
 =?utf-8?B?bXNFTmVxU3VZZFlGWndldHo5Z3JnUHFjLzltOXR3b1NwaHhnQ0NhYWdkeVVP?=
 =?utf-8?B?WVY3c1hyeHIwTXhTWW5NcFF4Mkc4REJJby8vUmYra2pmRUdpQ0NYb0IyTmky?=
 =?utf-8?B?Qi85bTNQcUZ2MTlKNTE5dW5wSjNSMWNHam9SSjBZRXRtcXZrZEp5Y2FZZHl5?=
 =?utf-8?B?TFFEQWR0eWVkc09DNnFPbm4xdkRwbnhUb09qYU9tL1ZvcGZVWWVjZDFFODJM?=
 =?utf-8?B?N2F2SU5taVBYRW5pTXkyTCthWGJKWHc1bjUxenI4OGJXM0JHSE94aFZjMEZW?=
 =?utf-8?B?ZFNqbkNlOXJSd08yZGs3d2doalBqNHlFamhrOXN2WE1ENVhzQmtIMG4yMnpv?=
 =?utf-8?B?a3JhQjdRTXAvRHl5eGdOdEdwQitCN1lFWjFtYU1FTzhXUlFUNDNuRGVZVTQx?=
 =?utf-8?Q?se+dkzzehIhkG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa39159f-1f30-4fa5-88ac-08d8e7d31cdc
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2021 16:55:18.3414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k8937h9ATEpsgupiOFwv1oiEWXmgcUGRe+63yrA7/4b+leVIToiedpfjOt0R0ESr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2482
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



Am 15.03.21 um 17:21 schrieb Andrey Grodzovsky:
>
> On 2021-03-15 12:10 p.m., Christian König wrote:
>> Am 12.03.21 um 16:34 schrieb Andrey Grodzovsky:
>>>
>>>
>>> On 2021-03-12 4:03 a.m., Christian König wrote:
>>>> Am 11.03.21 um 23:40 schrieb Andrey Grodzovsky:
>>>>> [SNIP]
>>>>>>> The expected result is they all move closer to the start of PCI 
>>>>>>> address
>>>>>>> space.
>>>>>>>
>>>>>>
>>>>>> Ok, I updated as you described. Also I removed PCI conf command 
>>>>>> to stop
>>>>>> address decoding and restart later as I noticed PCI core does it 
>>>>>> itself
>>>>>> when needed.
>>>>>> I tested now also with graphic desktop enabled while submitting
>>>>>> 3d draw commands and seems like under this scenario everything still
>>>>>> works. Again, this all needs to be tested with VRAM BAR move as then
>>>>>> I believe I will see more issues like handling of MMIO mapped 
>>>>>> VRAM objects (like GART table). In case you do have an AMD card 
>>>>>> you could also maybe give it a try. In the meanwhile I will add 
>>>>>> support to ioremapping of those VRAM objects.
>>>>>>
>>>>>> Andrey
>>>>>
>>>>> Just an update, added support for unmaping/remapping of all VRAM
>>>>> objects, both user space mmaped and kernel ioremaped. Seems to work
>>>>> ok but again, without forcing VRAM BAR to move I can't be sure.
>>>>> Alex, Chsristian - take a look when you have some time to give me 
>>>>> some
>>>>> initial feedback on the amdgpu side.
>>>>>
>>>>> The code is at 
>>>>> https://cgit.freedesktop.org/~agrodzov/linux/log/?h=yadro%2Fpcie_hotplug%2Fmovable_bars_v9.1 
>>>>>
>>>>
>>>> Mhm, that let's userspace busy retry until the BAR movement is done.
>>>>
>>>> Not sure if that can't live lock somehow.
>>>>
>>>> Christian.
>>>
>>> In my testing it didn't but, I can instead route them to some
>>> global static dummy page while BARs are moving and then when everything
>>> done just invalidate the device address space again and let the
>>> pagefaults fill in valid PFNs again.
>>
>> Well that won't work because the reads/writes which are done in the 
>> meantime do need to wait for the BAR to be available again.
>>
>> So waiting for the BAR move to finish is correct, but what we should 
>> do is to use a lock instead of an SRCU because that makes lockdep 
>> complain when we do something nasty.
>>
>> Christian.
>
>
> Spinlock I assume ? We can't sleep there - it's an interrupt.

Mhm, the BAR movement is in interrupt context?

Well that is rather bad. I was hoping to rename the GPU reset rw_sem 
into device_access rw_sem and then use the same lock for both (It's 
essentially the same problem).

But when we need to move the BAR in atomic/interrupt context that makes 
things a bit more complicated.

Christian.

>
> Andrey
>
>
>>
>>>
>>> Andrey
>>>
>>>>
>>>>>
>>>>> Andrey
>>>>
>>

