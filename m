Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB8632E3BE
	for <lists+linux-pci@lfdr.de>; Fri,  5 Mar 2021 09:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbhCEIgb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Mar 2021 03:36:31 -0500
Received: from mail-bn7nam10on2051.outbound.protection.outlook.com ([40.107.92.51]:55795
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229497AbhCEIg3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 5 Mar 2021 03:36:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hr5t/Qn4g9SC996EJobsDZhZU2LkfwSm3UrPVlhVO4IFPRi3S/0gwvEDh3ZKlBNpxXvnKSanVCyNnxGBLtBXzkt5WCUPACLCwo7iCzZf+esCfN/JD2whYdO3MnyQXz0OS3HLbuLTUF6gsnpEUR8wfLINr0VAekpvZBVxPxRjx8lQ3hDEwLUs8dwgNHsfK0dZAmmpb2mQ9y3U+jSr+mPEsK/Q7UWH/U4TR+LrR3Nae4oI+V/DyuBAWLjxJdMaw9Dvvi2SnEZYZ+TgkH63FsGkKTsolEL2Gw8zFvTVmHxOssbjJIRT+Biy2Q7y5Von53q9JhLPKu3JFfoe6zzkJKJt3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IFpw3XPysmnGPJAWj6NEUwj0N7u6ksQzEG1kP42SIl8=;
 b=FY1HIc6xKzTXwZ4kAa3q1BobG8ZKPR7v5OHHemfL0t2lrg4QFfQYrWzQ2hCrjfX/yEofj2xkW1zffXVltKER6hR9jCsr1LGGlCRqUxYtq+xz4WObbpNLK7DBOPjHKkOrblj31udqbGEAYFC1D/BmAR9KaqsNDrZIIyNgikkm53XXBKjXb90vK49hIJ6uU17DyI3oVMDwTChacCIfyDC4ocYNYJDJNnj5iK3Tp5pdWVO+1U5dvF8B3zezYbfEMbgH8T9KaQ1klzvvcB1LNQTC4GN6R+5iFXhYNm0fkpc75P4WGjT0Rmooi9LWww2JDTjaRMq0SJLq+ic/NiTTafeYLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IFpw3XPysmnGPJAWj6NEUwj0N7u6ksQzEG1kP42SIl8=;
 b=gVkviG5aHgbZJIrCcXg/NNLM+wQe2HsGNsU0b02uFECfAdiqDtmEtUO02oIMEfg2ChCT9oF8k2YCdeTjRNetifCggIU6pdWPn+5SGqoI9OYWh4El1oldqV2kB0ppR0VaKyR78wzNmdwwssMAXVqNwHBCxrazBeH6LaVWwvNQyA8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3886.namprd12.prod.outlook.com (2603:10b6:208:16a::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.24; Fri, 5 Mar
 2021 08:36:27 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3912.023; Fri, 5 Mar 2021
 08:36:27 +0000
Subject: Re: Remapping BOs and registers post BAR movements [was - Re:
 Question about supporting AMD eGPU hot plug case]
To:     Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Alexander.Deucher@amd.com" <Alexander.Deucher@amd.com>,
        Sergei Miroshnichenko <s.miroshnichenko@yadro.com>,
        linux-pci@vger.kernel.org
References: <20210302164944.GA424771@bjorn-Precision-5520>
 <81cc1a93-3a77-7ef7-c9f9-6083c1c313f7@amd.com>
 <5c2b2379-9961-c6f6-b343-b874cc22260f@amd.com>
 <6685096d-3c01-7f5a-58c5-70d139b61f6e@amd.com>
 <0fda1f26-9b26-faee-8208-0fe1bf644935@amd.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <e078a773-dc5e-b9a2-3078-3562b8dd215a@amd.com>
Date:   Fri, 5 Mar 2021 09:36:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <0fda1f26-9b26-faee-8208-0fe1bf644935@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:9f0d:d59a:6448:4a90]
X-ClientProxiedBy: AM4PR05CA0006.eurprd05.prod.outlook.com (2603:10a6:205::19)
 To MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:9f0d:d59a:6448:4a90] (2a02:908:1252:fb60:9f0d:d59a:6448:4a90) by AM4PR05CA0006.eurprd05.prod.outlook.com (2603:10a6:205::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Fri, 5 Mar 2021 08:36:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c975ab45-45c3-4146-18e3-08d8dfb1c3fd
X-MS-TrafficTypeDiagnostic: MN2PR12MB3886:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3886D2D8B59DC6D81264523283969@MN2PR12MB3886.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CsAqo/boapBp3tAK7CpNSiJtt39JalbPIvN0Q+isbXzlyQ22l2/LA6RKg/nKm792nzIRh3EvFMhgsGjmA8IQT1mto+GZq0Jqs5z8LMOusthYglwm1RBcb4faLVNE05YJMenSJmyAWVXW/BQRBw+2TFdn3mKRd4BBy3URbXkvL5qeUh+iqytoMcCp9/0nB+eCy9oTiTYNBv3XrwRrCLvnVPhCi2wgzrfW+0YPNLY68fvnkNyY65UkBfQUdyybmgeGtLqq+W2iv0Q2UiwS0hhD41V+O/DncdhYM2X7o2Xi+yZwnBypfimiz5C5kcoKGDXYOMulT+LOBCspjqMbt/hpshATS3xcUyHhl3X/aTz2Fa1jOIpTS/dKNgCtoh6Hr3UB00G0iLpebrIUKQDNNcr07+ViU0tk2DRtL9k3L1LEBnGfnnTmqpYQGz3av2H+UDBgXrcrJGm/K0SQQVUAfGk9XHkx2DtvIrQUOutqy02K9dtxRtPMxA6YxpK92RWRy9n0ziJcuTaG5FiWz7mTXArQ+qcF61wZPujW3ieH4d2Joi6aWVdJqn0iq2pSnRjOnVmNIzA1ZU/ZuhakAK1tJ7m4wmJrN/rcRovDkXzAsU368SWFllAFLwvX+y4n02yjsEWIn4LJBYfEN+APvb0bRCaLYH1mGztenqjPyaslKGQ3371F6rHoESmKBT/7zMRfKgOF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(396003)(366004)(346002)(376002)(66574015)(8676002)(2616005)(45080400002)(36756003)(52116002)(966005)(83380400001)(478600001)(5660300002)(53546011)(31696002)(86362001)(316002)(66556008)(8936002)(6486002)(66946007)(110136005)(186003)(66476007)(2906002)(54906003)(31686004)(16526019)(6666004)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Z0I2QXFORDFaL3lVRFVWK3VnYUxrZkNZZDNKVG44d1pPb01VWlBxU2NBZzFT?=
 =?utf-8?B?QU9JMDVYeEZBRDc2bDduWmp0T0ZzVFF3TTYya1FhRXg2SlRFR3VPSExCdWZP?=
 =?utf-8?B?TGx3a0ppSjE5Z2ZBQTZWTmgyNHZtNzlwZzg3SXNLaE04SnlpdnRQaTBqK1RU?=
 =?utf-8?B?T1hFa2hrazNRZVc0T0R5enNzNGcydXp6WUkySEdkdzdZMjd1akNrdjEwbnZF?=
 =?utf-8?B?RXZNeVVyUUs5ejNiMU80K0dUaEh5NE0vRUowaHdHeVExd3BDVjZEcU13c0J5?=
 =?utf-8?B?MXBQUG1kOGNidDNtZlZXK3NreGN4cVErSVRQc3JnZDB6RGdobzAyVEpwNXI1?=
 =?utf-8?B?L1BUN3drVmlYLzR5Mnl5R1p2STZuR1p3QldLQ1VwRVZHQ2g3S05GZnlUblVZ?=
 =?utf-8?B?RDMzTnBaanFqck92ZHNqOXBRSlFNSWFURDI3RzQrMHF5cTcyMGIvbUZvTWU4?=
 =?utf-8?B?RURZeUtIQThYMjR1Zjk2UHBoN2ZnMDRlRUZPS3ExS250Q2ZoajNHM3VlNTNV?=
 =?utf-8?B?ZG9jaGIya2V4N3EyVFhlWWhPMmhjM2RRbG1walJmZG91YUhGK3VPUFA3YWJO?=
 =?utf-8?B?UkxHVklENzYwb3pKcmprdS9kT0h4NHJuRFkyUytmdW9uOTVBZ2JoNFgxWjZ0?=
 =?utf-8?B?aUNKSVI5TGZMV0VacDA1QmdsZmRWaFJ6MWhXNXAzTUdydjJBbmgvMForOHhL?=
 =?utf-8?B?U0xiVEpGVzhUNzhGV2pLbUl2c3hHYS93a0tMZFJUWFhhcHc3dTl5VHZHUm9H?=
 =?utf-8?B?dVl1aUpkZkQwK3hrUFkwYnlqWmo4d0VEZFJLNzlKczIxaksySWNTQzBOUDUz?=
 =?utf-8?B?RWtXK29HMjZ1MGpvcXVhUWNFMzRPUGpnSms2ZnJ5Mitwc3FjRnpyOXgwREVC?=
 =?utf-8?B?NVk1VVloOEVJSjRNa0hmNktzSzVUdjd1S0oxRzh3ay9wK00yNytqRjdzOWtZ?=
 =?utf-8?B?dHVJdFdVeHlERGMzSVdvbzFCSmlvOXZ3TGdiOW13dHJXbEJubnlqUjFabVk1?=
 =?utf-8?B?MmlENll2SkpIRWo4MURiZkZxQ2ErNDJDdC9qeERST2JjQUFuNldGZVB3Yi9z?=
 =?utf-8?B?U3lTQTcvbkFYODFRSGJLd2N4VG9IeXJxOFRvZm1oZFVQdC9IemRCaWlFV0lT?=
 =?utf-8?B?YkFSSWtZcW4rYzh1QUsvZ3JTVHI1WGo4R01DU0lXVHRiRzhOOUJFQTZQb2Nk?=
 =?utf-8?B?NGpQQ0N0Tm5ERDNFSnBmUXhmSmdzdk9jUlliTlcrQzUvODVqMWlOcEFQclhM?=
 =?utf-8?B?bDV0TkdNNmJBbnA4UHp3U3dUS1RZQk0yTStnMHV5M0RnVE9DRVFMMGxna1lW?=
 =?utf-8?B?dnkrQmZTd0Q5cW1zQ0tRbDc3S1ZIMFdaZjlrUEZNeHYzWlc2SE9qdkx5UUJz?=
 =?utf-8?B?Qk11VHl4RE1KSWdNYlB0U2RMck1MTmpQTzhoUEJyZFBUS0hGOTVkWU1md1Vt?=
 =?utf-8?B?Y3R3VFFaTmc2NXJIQTE0aEVzSlBId0Q5MEhRcXd4UGtFcDB2UEEwbW1OYTQv?=
 =?utf-8?B?WW9tQTJzaWgzakZaSnNlMlRhRWNtVW1kTkJFSExWZzZJeGFTR2FUaXZjK3Vo?=
 =?utf-8?B?RWY1MzVzdW1Ealpwc25Md2x2SFh4YzluQVR3cUlYN2pnbkZHZTU4ZUJ2MTdR?=
 =?utf-8?B?UUZDTlRsZUZodUxoY1hVaFZwQ3BMQS9GdGdrWEhMVGp2ZkVxanFrOUpwWDgx?=
 =?utf-8?B?bXhuT25tOTd5WEZxclpna3g3eEh1MEdjYXZkQTBJVU56Qk94NTJVT3hUZnIv?=
 =?utf-8?B?MmVHWDRsZlg5Ky9od2xFMkY5N0dRV3ErbituaGdWblk3bzhUTzdTVmtxMEZ4?=
 =?utf-8?B?K1A4Q2QyU0tWSmNFa2Z4SDBkYkRqNTAwUU9WS1BSdVZVM29hc1BTOU5zTTFX?=
 =?utf-8?Q?AkX6dZSQScU4h?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c975ab45-45c3-4146-18e3-08d8dfb1c3fd
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2021 08:36:27.0870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +JM7v90R10sY46WQPL0GA0cBaBnVYfkb4X5WYQBSYTuxrBbSBw1Wzt76txxV1JoW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3886
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Andrey,

Am 03.03.21 um 17:05 schrieb Andrey Grodzovsky:
> Ping
>
> Andrey
>
> On 2021-03-02 12:48 p.m., Andrey Grodzovsky wrote:
>> Adding PCI mailing list per Bjorn's advise (sorry, skipped the 
>> address last time).
>>
>> On 2021-03-02 12:22 p.m., Christian König wrote:
>>> Hi Andrey,
>>>
>>>> Can you elaborate more why you need such a lock on a global level 
>>>> and not
>>>> enough per driver (per device more specifically) local lock 
>>>> acquired in
>>>> rescan_preapare (before BARs shuffling starts) and released in 
>>>> rescan_done
>>>> (after BARs shuffling done) ? 
>>>
>>> because this adds inter device dependencies.
>>>
>>> E.g. when we have device A, B and C and each is taking it's own lock 
>>> we end up with 3 locks.
>>>
>>> If those device have inter dependencies on their own, for example 
>>> because of DMA-buf we will end up in quite a locking mess.
>>>
>>> Apart from that if we don't always keep the order A, B, C but 
>>> instead end up with A, C, B lockdep will certainly start to complain.
>>>
>>> Regards,
>>> Christian.
>>
>> But as far as I understand those locks are agnostic to each other - 
>> each lock is taken only by it's respective device and not by others.

Well they should be agnostic to each other, but are they really? I mean 
we could have inter device lock dependencies because of DMA-buf or good 
knows what.

>> So I don't see deadlock danger here but, I do suspect lockdep might 
>> throw a false warning...

Yeah and disabling or ignoring the lockdep warning could cause problems 
because we don't see issues caused by inter device lock dependencies any 
more.

I just have the feeling that this would cause a lot of problems.

Christian.

>>
>> Andrey
>>
>>>
>>> Am 02.03.21 um 18:16 schrieb Andrey Grodzovsky:
>>>> Per Bjorn's advise adding PCI mailing list.
>>>>
>>>> Christian, please reply on top of this mail and not on top the 
>>>> earlier, original one.
>>>>
>>>> Andrey
>>>>
>>>> On 2021-03-02 11:49 a.m., Bjorn Helgaas wrote:
>>>>> Please add linux-pci@vger.kernel.org to the cc list.  There's a 
>>>>> lot of
>>>>> useful context in this thread and it needs to be archived.
>>>>> On Tue, Mar 02, 2021 at 11:37:25AM -0500, Andrey Grodzovsky wrote:
>>>>>> Adding Sergei and Bjorn since you are suggesting some PCI related 
>>>>>> changes.
>>>>>>
>>>>>> On 2021-03-02 6:28 a.m., Christian König wrote:
>>>>>>> Yeah, I'm thinking about that as well for quite a while now.
>>>>>>>
>>>>>>> I'm not 100% sure what Sergei does in his patch set will work 
>>>>>>> for us. He
>>>>>>> basically tells the driver to stop any processing then shuffle 
>>>>>>> around
>>>>>>> the BARs and then tells him to start again.
>>>>>>>
>>>>>>> Because of the necessity to reprogram bridges there isn't much 
>>>>>>> other way
>>>>>>> how to do this, but we would need something like taking a lock,
>>>>>>> returning and dropping the lock later on. If you do this for 
>>>>>>> multiple
>>>>>>> drivers at the same time this results in a locking nightmare.
>>>>>>>
>>>>>>> What we need instead is a upper level PCI layer rw-lock which we 
>>>>>>> can
>>>>>>> take on the read side in the driver, similar to our internal 
>>>>>>> reset lock.
>>>>>>
>>>>>>
>>>>>> Can you elaborate more why you need such a lock on a global level 
>>>>>> and not
>>>>>> enough per driver (per device more specifically) local lock 
>>>>>> acquired in
>>>>>> rescan_preapare (before BARs shuffling starts) and released in 
>>>>>> rescan_done
>>>>>> (after BARs shuffling done) ?
>>>>>>
>>>>>> Andrey
>>>>>>
>>>>>>
>>>>>>>
>>>>>>> Wiring up changing the mapping is the smaller problem in that 
>>>>>>> picture.
>>>>>>>
>>>>>>> Christian.
>>>>>>>
>>>>>>> Am 01.03.21 um 22:14 schrieb Andrey Grodzovsky:
>>>>>>>> Hi, I started looking into actual implementation for this, as
>>>>>>>> reference point I am using Sege's NVME implementations (see 
>>>>>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2FYADRO-KNS%2Flinux%2Fcommit%2F58c375df086502538706ee23e8ef7c8bb5a4178f&amp;data=04%7C01%7Candrey.grodzovsky%40amd.com%7C44bc68a68feb4b71836c08d8dd9b306a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637503005898302093%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=nuTptAjGewG2T7tXOQr2h%2Bdr42lyg3m1%2Bfv0mJzd8tw%3D&amp;reserved=0) 
>>>>>>>>
>>>>>>>> and our own amdgpu_device_resize_fb_bar. Our use case being more
>>>>>>>> complicated then NVME's arises some questions or thoughts:
>>>>>>>>
>>>>>>>> Before the PCI core will move the BARs (VRAM and registers) we 
>>>>>>>> have
>>>>>>>> to stop the HW and SW and then unmap all MMIO mapped entitles 
>>>>>>>> in the
>>>>>>>> driver. This includes, registers of all types and VRAM placed BOs
>>>>>>>> with CPU visibility. My concern is how to prevent accesses to all
>>>>>>>> MMIO ranges between iounmap in rescan_preapare and ioremap in
>>>>>>>> rescan_done. For register accesses we are again back to same issue
>>>>>>>> we had with device unplug and GPU reset we are discussing with 
>>>>>>>> Denis
>>>>>>>> now. So here at least as first solution just to confirm the 
>>>>>>>> feature
>>>>>>>> works I can introduce low level (in register accessors) RW locking
>>>>>>>> to avoid access until all register access driver pointers are
>>>>>>>> remapped post BARs move. What more concerns me is how to - In
>>>>>>>> rescan_preapare: collect all CPU accessible BOs placed in VRAM (i
>>>>>>>> can use amdgpu specific list like I currently use for device
>>>>>>>> unplug), lock them to prevent any further use of them, unpin them
>>>>>>>> (and unmap). In rescan_preapare: remap them back and unlock 
>>>>>>>> them for
>>>>>>>> further use. Also, there is a difference between kernel BOs where
>>>>>>>> indeed iounmap, ioremap should be enough and user space mapped BOs
>>>>>>>> where it seems like in hot unplug, we need in rescan_preapare to
>>>>>>>> only unamp them, in between drop new page faults with 
>>>>>>>> VM_FAULT_RETRY
>>>>>>>> and post rescan_done allow page faults to go through to refill all
>>>>>>>> the user page tables with updated MMIO addresses.
>>>>>>>>
>>>>>>>> Let me know your thoughts.
>>>>>>>>
>>>>>>>> Andrey
>>>>>>>>
>>>>>>>> On 2021-02-26 4:03 p.m., Andrey Grodzovsky wrote:
>>>>>>>>>
>>>>>>>>> On 2021-02-26 1:44 a.m., Sergei Miroshnichenko wrote:
>>>>>>>>>> On Thu, 2021-02-25 at 13:28 -0500, Andrey Grodzovsky wrote:
>>>>>>>>>>> On 2021-02-25 2:00 a.m., Sergei Miroshnichenko wrote:
>>>>>>>>>>>> On Wed, 2021-02-24 at 17:51 -0500, Andrey Grodzovsky wrote:
>>>>>>>>>>>>> On 2021-02-24 1:23 p.m., Sergei Miroshnichenko wrote:
>>>>>>>>>>>>>> ...
>>>>>>>>>>>>> Are you saying that even without hot-plugging, while both 
>>>>>>>>>>>>> nvme
>>>>>>>>>>>>> and
>>>>>>>>>>>>> AMD
>>>>>>>>>>>>> card are present
>>>>>>>>>>>>> right from boot, you still get BARs moving and MMIO ranges
>>>>>>>>>>>>> reassigned
>>>>>>>>>>>>> for NVME BARs
>>>>>>>>>>>>> just because amdgpu driver will start resize of AMD card 
>>>>>>>>>>>>> BARs and
>>>>>>>>>>>>> this
>>>>>>>>>>>>> will trigger NVMEs BARs move to
>>>>>>>>>>>>> allow AMD card BARs to cover full range of VIDEO RAM ?
>>>>>>>>>>>> Yes. Unconditionally, because it is unknown beforehand if 
>>>>>>>>>>>> NVMe's
>>>>>>>>>>>> BAR
>>>>>>>>>>>> movement will help. In this particular case BAR movement is 
>>>>>>>>>>>> not
>>>>>>>>>>>> needed,
>>>>>>>>>>>> but is done anyway.
>>>>>>>>>>>>
>>>>>>>>>>>> BARs are not moved one by one, but the kernel releases all the
>>>>>>>>>>>> releasable ones, and then recalculates a new BAR layout to 
>>>>>>>>>>>> fit them
>>>>>>>>>>>> all. Kernel's algorithm is different from BIOS's, so NVME has
>>>>>>>>>>>> appeared
>>>>>>>>>>>> at a new place.
>>>>>>>>>>>>
>>>>>>>>>>>> This is triggered by following:
>>>>>>>>>>>> - at boot, if BIOS had assigned not every BAR;
>>>>>>>>>>>> - during pci_resize_resource();
>>>>>>>>>>>> - during pci_rescan_bus() -- after a pciehp event or a 
>>>>>>>>>>>> manual via
>>>>>>>>>>>> sysfs.
>>>>>>>>>>> By manual via sysfs you mean something like this - 'echo 1 >
>>>>>>>>>>> /sys/bus/pci/drivers/amdgpu/0000\:0c\:00.0/remove && echo 1 >
>>>>>>>>>>> /sys/bus/pci/rescan ' ? I am looking into how most reliably 
>>>>>>>>>>> trigger
>>>>>>>>>>> PCI
>>>>>>>>>>> code to call my callbacks even without having external PCI 
>>>>>>>>>>> cage for
>>>>>>>>>>> GPU
>>>>>>>>>>> (will take me some time to get it).
>>>>>>>>>> Yeah, this is our way to go when a device can't be physically 
>>>>>>>>>> removed
>>>>>>>>>> or unpowered remotely. With just a bit shorter path:
>>>>>>>>>>
>>>>>>>>>>     sudo sh -c 'echo 1 > 
>>>>>>>>>> /sys/bus/pci/devices/0000\:0c\:00.0/remove'
>>>>>>>>>>     sudo sh -c 'echo 1 > /sys/bus/pci/rescan'
>>>>>>>>>>
>>>>>>>>>> Or, just a second command (rescan) is enough: a BAR movement 
>>>>>>>>>> attempt
>>>>>>>>>> will be triggered even if there were no changes in PCI topology.
>>>>>>>>>>
>>>>>>>>>> Serge
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Ok, able to trigger stub callbacks call after doing rescan from
>>>>>>>>> sysfs. Also I see BARs movement
>>>>>>>>>
>>>>>>>>> [ 1860.968036] amdgpu 0000:09:00.0: BAR 0: assigned [mem
>>>>>>>>> 0xc0000000-0xcfffffff 64bit pref]
>>>>>>>>> [ 1860.968050] amdgpu 0000:09:00.0: BAR 0 updated: 0xe0000000 ->
>>>>>>>>> 0xc0000000
>>>>>>>>> [ 1860.968054] amdgpu 0000:09:00.0: BAR 2: assigned [mem
>>>>>>>>> 0xd0000000-0xd01fffff 64bit pref]
>>>>>>>>> [ 1860.968068] amdgpu 0000:09:00.0: BAR 2 updated: 0xf0000000 ->
>>>>>>>>> 0xd0000000
>>>>>>>>> [ 1860.968071] amdgpu 0000:09:00.0: BAR 5: assigned [mem
>>>>>>>>> 0xf0100000-0xf013ffff]
>>>>>>>>> [ 1860.968078] amdgpu 0000:09:00.0: BAR 5 updated: 0xfce00000 ->
>>>>>>>>> 0xf0100000
>>>>>>>>>
>>>>>>>>> As expected, after the move the device becomes unresponsive as
>>>>>>>>> unmap/ioremap wasn't done.
>>>>>>>>>
>>>>>>>>> Andrey
>>>>>>>>>
>>>>>>>
>>>

