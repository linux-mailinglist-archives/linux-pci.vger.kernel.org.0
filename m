Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E469433C191
	for <lists+linux-pci@lfdr.de>; Mon, 15 Mar 2021 17:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbhCOQW1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Mar 2021 12:22:27 -0400
Received: from mail-dm6nam10on2040.outbound.protection.outlook.com ([40.107.93.40]:52193
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229705AbhCOQWC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 15 Mar 2021 12:22:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NWobdl1ZXqm6qSxNNRzkagTmMJmHVFF5Qp3zjrGpB94mZn8my/huzwtgS+CHp6sD0wCmdiIwY9mB16eQYc0ahPJRBT24XyOCerfMNHhq68buWE/JA8ryy4a29V++nHvMFBvi/WNqmFDyLj9HYIqcFs6M1b45TdP72g7vekK2xyqwdJFg/71xZiG72hXSuyIs7lv9b36zosaVXkb5wDwHqQyw1Pq6aqM+6rC1VXHDD0C/ZY9PGebSrzcdfDziLGmZS7RMzXTMaJO2ibg1nkfoDPztEUGsz+g2ahmM7cgNKohTMuSP5hf+xCildRBk2PUoaR0QYqo5emba5dk++rDe3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w70os6mRgpA68/amue30wUGLxN92nlttI4pI4EDUevw=;
 b=RAylw55F1yuqqvPnyyFuuD3e4M+qXpCTXJceaVM9j5APsyBaYcT7tHYzQciJ1o0Kv3Ub97ZHXfjpBwLl5aIuUOTiDi2/A5J4QxpvxyputiLqYOQLLfu9U8eEXIPOU85Uv+YmzOfqk7YKIW6N44aAi0O5brKh2+A0sknIHBQ7aCaEaltneclQTK0LJMKCmpmOCY1uhP+fKTLIS133N3p1bCIFN7KDMzo6w4Ho50FxALK/KV1iOqD5x4ePyPsf/3iD9WTAFvmM7xuBg2ZpItDndDqbvTX/SghUfFe/oXS684V7gBW2PTdSnwmkCWkFseP7G+cMPj5VipBLrzeEjyr5tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w70os6mRgpA68/amue30wUGLxN92nlttI4pI4EDUevw=;
 b=3lOQCt1NqkmyHa9bFS+LSRLN2IVBeAnzr1BA+JD5zRCpSr3gyqxPbCFJye5m8AlOsDhK9ErOFqVrAeD0phsiMhAgTh/0kmrBHojHixgUqfD6ke9l7PuMiXiNxqKNT09eXA+S3pRZPGKpuaEG55xhoVm1FT4noTdy3wNKbt8d4FM=
Authentication-Results: yadro.com; dkim=none (message not signed)
 header.d=none;yadro.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SA0PR12MB4541.namprd12.prod.outlook.com (2603:10b6:806:9e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Mon, 15 Mar
 2021 16:22:00 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::29cb:752d:a8a7:24a8]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::29cb:752d:a8a7:24a8%6]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 16:22:00 +0000
Subject: Re: Question about supporting AMD eGPU hot plug case
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Cc:     "Alexander.Deucher@amd.com" <Alexander.Deucher@amd.com>,
        "anatoli.antonovitch@amd.com" <anatoli.antonovitch@amd.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux@yadro.com" <linux@yadro.com>
References: <ddef2da4-4726-7321-40fe-5f90788cc836@amd.com>
 <340062dba82b813b311b2c78022d2d3d0e6f414d.camel@yadro.com>
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
From:   Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <77b5cd7c-3871-0943-8a19-a7ce9c4a91dd@amd.com>
Date:   Mon, 15 Mar 2021 12:21:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <6714c482-7662-8e26-65f2-76a011be6f78@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2607:fea8:3edf:49b0:4d2a:2ae2:5c90:5ef9]
X-ClientProxiedBy: YTOPR0101CA0036.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::49) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:4d2a:2ae2:5c90:5ef9] (2607:fea8:3edf:49b0:4d2a:2ae2:5c90:5ef9) by YTOPR0101CA0036.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32 via Frontend Transport; Mon, 15 Mar 2021 16:21:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2459ff54-2ea6-40b2-33b4-08d8e7ce7635
X-MS-TrafficTypeDiagnostic: SA0PR12MB4541:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4541235C406E26BA092681DEEA6C9@SA0PR12MB4541.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WUFwhj8B8qUlw+MYAGNZMSIRnKGjD7l/7Fm9tkiDQve/plRI6E5noB3/IFKrPXbjOBwy0mBEc5BFDLJKnDLpqOpqEFBoT1JtW3aYLZqHUGWkBIGdSOBCpsE7NJSDC1xgvtGFljvx1+jE1QNtady3RB0TcsO7vZnZNnzdYZvCxeSdSbbzhDOM34/WsTE/CZmPpAygombvso+FelL1aCHF+o8lZ2klXTmSKrcvwaoCdbJ5hNcjXlcgBIVgic3AjxxrVCNI66cpAfAZdYLgWUwmfEsNwtq9cRCjusbmhTBmxQREajCH4ApG4dbLe3+wRoztDASyp1ix2UHlHPCj++OXECE/7GYyII0+tTCw6XnqojvlzDa7uu6DY/AtCsTwLWzyiApPQXgGTzC24ILdl9GUTwrZEoNikI5+tqyPDeaW/oJ81pnY6GBa1Wg2c8zYHwBC2PTiCTm4rIzicq+ah4O3Xjcr5SJ5SQWNizMC0LS9VpwnHWuBDGSu4wSstXqAtMGPmzzbJRwFY3cWhGhkuEr/0YputoRvzbLli91j3NT2Mi5SdDUwI8FTdBLh+KAt/U4XviE5e4Nb6QlEiYCo/1gGin66PxJsFqhtqP3+Z223ywDVqyVXUS+qe/Qj1L5s16VVY4I+TkMSo0fnM0f45tfFwDub+OKzpYTJxq8zRlzHh5Jy2uFmw8DbJSZd3ZXsR1i5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB4623.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(396003)(366004)(39860400002)(8936002)(66476007)(966005)(5660300002)(4326008)(16526019)(110136005)(2616005)(52116002)(86362001)(478600001)(53546011)(44832011)(8676002)(2906002)(186003)(66574015)(316002)(83380400001)(36756003)(6486002)(66946007)(31696002)(66556008)(54906003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?d014bDJIQVBDTEl3RmtpZXc2eTJYcEg0K1VCYVJ0U2tHb3c4SDFDd0tVNU9q?=
 =?utf-8?B?aUdvMHhYRmdSUlhYYlNpM3NuWVMzL3BhK282aXNNczhCcm8wQzVwQnVmMFI5?=
 =?utf-8?B?Q0RaTEJxTllJL1Nyd0NtdlA1aDlhYVErNDMxdEhwN3FvRENuU2ZpL3lZZjJV?=
 =?utf-8?B?TGpZTXVkM2p4TWkvN2p3T2pwZExQSFZmRFZ0NkNpeVA4UUJwNXA1akZlMGQy?=
 =?utf-8?B?dDluUGNscGhRd09MZkpOL3dYZTd6TmdyeDVuSldnYVhqZGVJUXdmT0tlSXp4?=
 =?utf-8?B?Wlh6WHJqbklBSnZRYzk1aksvaVNrRm54cUZNR250ZFFEN3IyVGR4SVJSTWxs?=
 =?utf-8?B?ZU5mK1pqd3ZSdHdQT2VSUFNFVUdUYWJMOFhNenFVcXFmUUJDcHVVTmMvVE1n?=
 =?utf-8?B?MEtJTVpINU1rUHlSYUxtOEEyRUNPQTRPeG8zSnMrQmt4aThrOGFaSW0yRFJN?=
 =?utf-8?B?ZEh2QWgrRkxubWd0ZzVkNmQxOXRSdi9JMGJ3alVKSjZERkZRejkvMG5kNGcw?=
 =?utf-8?B?NG4xY1lDRXFPcUhnaW00aHJLRFFiWXFpTUdlTDI1UTVrTHhKQ2ZxRlpVUlQy?=
 =?utf-8?B?ODNqQS9kaGVrbEN2T0ZmL0M1WFkyaDNuUlhicFltRStPeEQyTWluVUZlMnBC?=
 =?utf-8?B?ZkxpV3UrNk9oWkU0Y0dTU0w4dlRneWVOUHhmUm9LL005Nk9zUVllcU1CcmY5?=
 =?utf-8?B?MXFVVWpBK0o2UHJtMEpJcGNkbVdWYVBEaDVMVmNDSTdYUm5YN1FPTjhDTU45?=
 =?utf-8?B?c2hQN09mVmF3Q3R6dGFWNWJFNGF4RDNQNEFycjE3ZTVpaTRYMlY4ckdCbXdM?=
 =?utf-8?B?b3RnSnpsOGw4cHFSU3ZiZTZHZk9YWVhWTFhoenlZT29oNG5RekVSN2UvMlZY?=
 =?utf-8?B?RHNPNXFjRUxxQUJOditNVnd4V251R2pOLzhZZEFjQ3dVMk12SUxWQTQ3S3pW?=
 =?utf-8?B?UVZzekFhV041TTBsYWRZTFZFODBFT2lBWVBNTDZCYTNqWW9HRjFlQU5WNFgx?=
 =?utf-8?B?UE83eUltb3ZCVVU1RWFtNXhjNDVFblpHZG8xcEtXeFZ0NXFlRVF3NkN2YUVY?=
 =?utf-8?B?TWEwbEt4SGtnK0hOU0dEakx5cWQzTlovUTJML3dFY1N6UXZmbjREMUo3Q0ln?=
 =?utf-8?B?dDV2Q3RuOFBDeGVtWWoyNDhCeFUxOXlBUUNMU2JCakdJdjlhWS9RNFZWUDdP?=
 =?utf-8?B?QWdQV0NaU2hhUTkrVXNnWVFFdm1nMTNSL3UzajZaSEVqaEdFR05CalpqMUw1?=
 =?utf-8?B?V2N3OEpsc0wrenlOcW4zUC9GRjBZVzJoMDZ4YTRHSnRTM0wrQW15ejZ0cTh4?=
 =?utf-8?B?VWVQMnVxdWNNQ1RFOHA5R1NyaEZ4cDV0YUpRaGUxNzVHREcrYTArWkZQK2Fk?=
 =?utf-8?B?Qmo3SVU2a0dzV1JjSDlqTWhpdEp2NGFqVGdMa0dUczM3amUyS2Y5VTZvNkpl?=
 =?utf-8?B?WVFpeUtDKzl5WmlDZlpiekVzdmRKMU5aNktkMFpNTS9nK1M0Ung1NUhGUHZo?=
 =?utf-8?B?YUl4K3ZncGVNY3U0UUFrTGtOQ0F6dkYzem1lUngyNUVNSlpIN2Q1RS93aWdD?=
 =?utf-8?B?Y1BFS21RdWcyVjZQSFhSREV5OWs1TCtUcnFKOGlFRkFVaFgwWWlWWUtERVNk?=
 =?utf-8?B?N2p2dFk4TTZCUkFtbFE1NTNMdzdXanYxaDZTWEtRVkIzVXJKbEt0Ung4QXdO?=
 =?utf-8?B?TE1VeERSRm5JNnFwdmxhSUxaZkdvZFhaOExJa1pvTW5WSHBhZEI2d2E1cGRS?=
 =?utf-8?B?bUFBbVNvdzJSQWNMWGE4QkNYUUl6RFdWcUFmZlQvckxna0RFZDBObUpPdFRU?=
 =?utf-8?B?ZHRUZWIxckR0eG5JL2ZVS212WHBRSDY1dkVYd1ZGaUhoOExHR0FhWkhPRWRD?=
 =?utf-8?Q?pi+fa4IFrm+yQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2459ff54-2ea6-40b2-33b4-08d8e7ce7635
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2021 16:22:00.8550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kHLXGPYRg4nmT26K4ubel7MQR9RjJmMkD707BKwNObEEI3f1U73lScvozDd0TDX/vpPa9NZnB2uaDTBMrpG0DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4541
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 2021-03-15 12:10 p.m., Christian König wrote:
> Am 12.03.21 um 16:34 schrieb Andrey Grodzovsky:
>>
>>
>> On 2021-03-12 4:03 a.m., Christian König wrote:
>>> Am 11.03.21 um 23:40 schrieb Andrey Grodzovsky:
>>>> [SNIP]
>>>>>> The expected result is they all move closer to the start of PCI 
>>>>>> address
>>>>>> space.
>>>>>>
>>>>>
>>>>> Ok, I updated as you described. Also I removed PCI conf command to 
>>>>> stop
>>>>> address decoding and restart later as I noticed PCI core does it 
>>>>> itself
>>>>> when needed.
>>>>> I tested now also with graphic desktop enabled while submitting
>>>>> 3d draw commands and seems like under this scenario everything still
>>>>> works. Again, this all needs to be tested with VRAM BAR move as then
>>>>> I believe I will see more issues like handling of MMIO mapped VRAM 
>>>>> objects (like GART table). In case you do have an AMD card you 
>>>>> could also maybe give it a try. In the meanwhile I will add 
>>>>> support to ioremapping of those VRAM objects.
>>>>>
>>>>> Andrey
>>>>
>>>> Just an update, added support for unmaping/remapping of all VRAM
>>>> objects, both user space mmaped and kernel ioremaped. Seems to work
>>>> ok but again, without forcing VRAM BAR to move I can't be sure.
>>>> Alex, Chsristian - take a look when you have some time to give me some
>>>> initial feedback on the amdgpu side.
>>>>
>>>> The code is at 
>>>> https://cgit.freedesktop.org/~agrodzov/linux/log/?h=yadro%2Fpcie_hotplug%2Fmovable_bars_v9.1 
>>>>
>>>
>>> Mhm, that let's userspace busy retry until the BAR movement is done.
>>>
>>> Not sure if that can't live lock somehow.
>>>
>>> Christian.
>>
>> In my testing it didn't but, I can instead route them to some
>> global static dummy page while BARs are moving and then when everything
>> done just invalidate the device address space again and let the
>> pagefaults fill in valid PFNs again.
>
> Well that won't work because the reads/writes which are done in the 
> meantime do need to wait for the BAR to be available again.
>
> So waiting for the BAR move to finish is correct, but what we should 
> do is to use a lock instead of an SRCU because that makes lockdep 
> complain when we do something nasty.
>
> Christian.


Spinlock I assume ? We can't sleep there - it's an interrupt.

Andrey


>
>>
>> Andrey
>>
>>>
>>>>
>>>> Andrey
>>>
>
