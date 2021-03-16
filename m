Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3C8433D8F5
	for <lists+linux-pci@lfdr.de>; Tue, 16 Mar 2021 17:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238543AbhCPQSN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Mar 2021 12:18:13 -0400
Received: from mail-co1nam11on2055.outbound.protection.outlook.com ([40.107.220.55]:1408
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238563AbhCPQRo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 16 Mar 2021 12:17:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QWNgZdwKV2bZR7AY52zCNq1wMwzgDvuN0EJOHWwZTficBmMt8dL7AHR3jKPKb87boBvHRFrRrEfOWeYXw2ctdJjgWHDX2vpJvrLlzFq48lf7T7ehwTD+hbsMuLNcmvaxrTE3gZsy8GSsHDonrv3pdIBrtzQgZDtcGo98r2opYp6mZ9qDyS87RiKqdq1Ze8bXVWKhbCP7uUdgLz30Cr/6P38+O7IaAs4kEBHlzXOLN/Svl0LZ29lNhh9H5/Fw+SM4OgRplkxkwbVyMFrwm46utfqz/gjBLHyDc8YmoHSYgCWSr5wnMGQ5SdQ4KGdZaNWRZdPmGdTeH2VkoRMvBjPM3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hJ54eVciKFJe+YvVDaLXtUl5q+QSbJm2QQxLl1Hk60o=;
 b=DF80W/pmtSCvSUlq7HjEg2EPebYamZOkWVaEWCx2qy1Cb3VY6wVaaE32MVwKdKMAe93sYZbE2ERnamVKXYcRhlLIs0TdLdCBzPBb/g/OiNAtKu+2d4ybACZ73GQ0K8CFfweoXbHaHxaeTYuL29BLZlEK7PCriL8yPCaf+xdtjYwBm4ZljKfv3SwSSD9FpajVXXgXiOaajsI382FDwQKuF5225NmppMey4MmWOoZk1UoZHWeCXbNjt+JjSLVnF+6RWGs9rHlWXx3aVBM1AJjdNtk09J5CkJOI4rphupgBW0X5b6VNSiI1DJS4mFn48V6xg6Bgi4Yh51WpZxJABLSIfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hJ54eVciKFJe+YvVDaLXtUl5q+QSbJm2QQxLl1Hk60o=;
 b=am1LLgLi0WhBA+Ea93WjqwnIQDd0q+A4DFCU9Yly+i6Bo8yTsvHseJoiwEV9OlRFFTmEvNtdaMNwUEonCoQkQi/JROZEDNhDY/4+IzpM+Ob/ujbu1XxVVGGEW6mxSbtjFuhsB8lNGmcXgW1in4APuRWOJeMYQ39tr7YBqHYA+Kw=
Authentication-Results: yadro.com; dkim=none (message not signed)
 header.d=none;yadro.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4096.namprd12.prod.outlook.com (2603:10b6:208:1dc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Tue, 16 Mar
 2021 16:17:42 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3933.032; Tue, 16 Mar 2021
 16:17:42 +0000
Subject: Re: Question about supporting AMD eGPU hot plug case
To:     Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Cc:     "Alexander.Deucher@amd.com" <Alexander.Deucher@amd.com>,
        "anatoli.antonovitch@amd.com" <anatoli.antonovitch@amd.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux@yadro.com" <linux@yadro.com>
References: <ddef2da4-4726-7321-40fe-5f90788cc836@amd.com>
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
 <bd621789-d9de-aa2e-4a83-f8154e868325@amd.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <57a72ca6-c58e-76a3-3e19-8aca98fa831c@amd.com>
Date:   Tue, 16 Mar 2021 17:17:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <bd621789-d9de-aa2e-4a83-f8154e868325@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:b42c:fec3:9423:57fe]
X-ClientProxiedBy: AM0PR10CA0039.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::19) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:b42c:fec3:9423:57fe] (2a02:908:1252:fb60:b42c:fec3:9423:57fe) by AM0PR10CA0039.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32 via Frontend Transport; Tue, 16 Mar 2021 16:17:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ffa5ea36-fd8e-480b-5242-08d8e8970634
X-MS-TrafficTypeDiagnostic: MN2PR12MB4096:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB40969262D67415485B1F8E4A836B9@MN2PR12MB4096.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JopI/tFZY/6UnauqAKb8IrJsygpdULCJiDwzhf8qbYokBC40FHeYdG0YkTBq0xdETayEhDm+odgknkskA6RVMpLXKNV2+L6jxo3CnzdWh3fjol7EjeDVKf//P6MuY5r0axGu2TqsL7rfXD9ChgIsbNuHMDS/7oW6suVjKi7OjgAdLuuS4SmtfiV2owQDNTvwH9cBdHvLVi/Ua9KaZ8M1Um2DdDD+J+vxoQrs5SqbHD06fbaFhIIXdRGjVSVpFdNjs9+jDGrGtrGW0QENg41KplJ5k4mvktBvEHyp3Q7gbdbFGJGqyoXdlDICLXkm1jUM/Fdj9aplQx8l2G93KlTZSFZWFGtv5EJFGB31mJeVSg1KQaU39woiPADqPljfhVWXGnuyPam+vOQp5Gri0Ss/uCVsN9UnjGzlTKzJU1bc2MWX2g6txoybMqQ3d2WApuZc29jlocho+w5QvSIseecgi6RCOzqK0LDBeZC/qZrlyicrBoNX4fyoZBhkx/c44XtCtq0/DoXYlcS7drcbFxRMx0EYw2ti2CoWS05awEO8by8p+x6NS1psW6pGrBgXkjEQbRAmoGW58E3scBXTlVxOsZ0wlWE1WUEF/oOtxZL/eaLUp2ff2D1RMjfVqzwsIGICRtbvVPv4MDlqoaZcVei40YDRysakIgJ3gGvIvyAy2mEJD1C1Zj76lI4N7Kurq5EH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(396003)(136003)(376002)(366004)(6486002)(86362001)(966005)(66556008)(8936002)(5660300002)(8676002)(316002)(66946007)(2906002)(16526019)(54906003)(186003)(66476007)(478600001)(53546011)(52116002)(6666004)(31686004)(66574015)(4326008)(83380400001)(110136005)(36756003)(31696002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bnliNVVvT3JkdHh1OHoyeTVsU3FzUGlBM1BSdDZZaktvbDFqNWpaT1BiN0ZL?=
 =?utf-8?B?c3l2RXlCUDNLTDBRSUtLWnhuWFVUUXRudCttbG10cmZpbXp4OHlIRWRuTUxT?=
 =?utf-8?B?N1N6anV1bzJ2K2ZTZnBzbWJYdk9Tdk40bExPdU9aZE5yU1R0MDNBOHZEdk1N?=
 =?utf-8?B?SVA4MGQ0YmhQMlFXSncrR0dWZWM1Y0NHeWU0Y0RXdkNjZnozcVR3NUdMdlYy?=
 =?utf-8?B?dTUvTi8xT2hBUXgyRHNCeUVvQSttMHlzYjFhazROYk9nT0tGeVdGNjJBNWN4?=
 =?utf-8?B?SkJvM0ZITWdMbVovYXJBODIrUStMZHMrd1h2UlNUOWhrOFhnZGZTeVh0R1ox?=
 =?utf-8?B?WGExN3JaMHJPMXdDNGdqMHA0YUlvdlprWnJpeEtSM0tTb05rV3ozZCtCdW4v?=
 =?utf-8?B?NXJjUWNrQmtYVUhjUUtOd1hWS2IydDBMcWxCSGMxZVBFRUhrRXVqRk0wMEdE?=
 =?utf-8?B?S2hYRTdrL0FMUysyMGo3RWtIdXJsTjJ5TWdXd2VKU2plbUNiOEN3UW4zc0Fs?=
 =?utf-8?B?SHQ0NERYaDJDWGtkMWZsZlpnNGczT2dKOWc3Y0RGMU12R1U0L2J6TFgwZTAz?=
 =?utf-8?B?cFV4c2hrMUtIbHNwS1NZSno0YUFTN2JjQmxFVGZDR29DeTJxR1lCTHNXK0NY?=
 =?utf-8?B?aVJrNThraDhvNnYvc1MzeHNpT3o3QXZoNGxuMExLbFZOUUVvZFJjbFE1YUpD?=
 =?utf-8?B?TVpmazNqQzBZeUlOVjZBbU1SaE1SSDYrRjJtU0hITHIyR2JUTXpCUDdRS0No?=
 =?utf-8?B?N1FaQ3A0ekxqbDY3MmdsRndRVmNjWWdzRk9WZmpKQVZTM1QreWxhZDlxZjBr?=
 =?utf-8?B?Z1hjZlNlUjlId21xMStvaGVlZjc0eVRpU0hkS0dTVkRZeStVbUZmRGk2REVJ?=
 =?utf-8?B?QTRaZFlqTkdPSUdsUFB3cHU0SDhFZUxVL0FzVU5vQ3FMRkIrVFdScHdzbDA3?=
 =?utf-8?B?Zmtjd2UzR0RZazNHdSt5cG1GNWJvZDJkcHY5QkZiVkQxSGM2NW00OVVVOTBx?=
 =?utf-8?B?ellQd28rNkJsMndjbjQzcGxvVU51TWtpeFRhRWJGM1doL1F5Q2g3QnJUd2JS?=
 =?utf-8?B?aGRKMTFYRHdLSFowOThNN0ZNS2hoVHFLbmF3alRlM3hqUTZsNUY5RDRKVE92?=
 =?utf-8?B?b3grVHY4VituNHpReGVmeVFnT3V5dFRIU2FhUHR3TU1DWkc5ZFVKdWttUlVR?=
 =?utf-8?B?QjVsRjRCTEZ0WkpnTWtqWlpjaFBRY2RoOGlyejNtaHR4NXJJZjkveWU2TTRi?=
 =?utf-8?B?N1ZhazFyZ2lBdFB6bnZsMGNOajBiYmdMWmRGbWRNKzk4MzNiTXI1OER0WE1S?=
 =?utf-8?B?R1BpRWtXNFlKQ2ovOG5BSk5uc2Rna3V1WHM2UG4rdEoyUWo2WVlXQjhOSmRs?=
 =?utf-8?B?ck85aTE2TWdvSGpaRTV2Q09FaEpPN3VWbi9jYTJnd0h5bkhNdC9PdjJLeUxZ?=
 =?utf-8?B?UHgwaUpLM2NaNXl3YW9kcG9FZW0xczU1MDVYb2F0RDFjcm00dXN6dkQrTzZ5?=
 =?utf-8?B?Z3VtRXZMNlJONnoyS1dyT2Z5N0xZRlpIVjFzMEgvZ3FNeFZHamNXbFhjWmJj?=
 =?utf-8?B?aTIvWWx3QytkL1lxZFNveVRsRGU3d21GczFNN05hbUkrTlEwQ0dMdkEzUnVu?=
 =?utf-8?B?L3M3aUd6anNQOWhwT2xLeTlRUTNlM1NFM3ZDR1RNZVRRV3JwaWVWVjFndFFL?=
 =?utf-8?B?UWhFZXBFclJuL05TSFJoeGR5SzNWVjh0WHlHSTdzZ1llUC9TWFNjVWVBY21N?=
 =?utf-8?B?QUNrRnJiNjNBUDcrZW5yUjV5dXFlNjJxZlhRaGt4SjJaZXN3T2pYOGY1RU9y?=
 =?utf-8?B?TytOOUFseHA4ZXdNckxJWnJPNnZDTFUrN3hGY0VxT2I1MWxKRjF3eXF6WXlt?=
 =?utf-8?Q?owFfoQFMlwwUW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffa5ea36-fd8e-480b-5242-08d8e8970634
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2021 16:17:42.3677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZoI2erXylmS3ZkHXoRBYDm7cnq3tCgnFtDUxo8qubjc7QdjDqKuLFSL4dayzrPfC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4096
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am 15.03.21 um 18:11 schrieb Andrey Grodzovsky:
>
> On 2021-03-15 12:55 p.m., Christian König wrote:
>>
>>
>> Am 15.03.21 um 17:21 schrieb Andrey Grodzovsky:
>>>
>>> On 2021-03-15 12:10 p.m., Christian König wrote:
>>>> Am 12.03.21 um 16:34 schrieb Andrey Grodzovsky:
>>>>>
>>>>>
>>>>> On 2021-03-12 4:03 a.m., Christian König wrote:
>>>>>> Am 11.03.21 um 23:40 schrieb Andrey Grodzovsky:
>>>>>>> [SNIP]
>>>>>>>>> The expected result is they all move closer to the start of 
>>>>>>>>> PCI address
>>>>>>>>> space.
>>>>>>>>>
>>>>>>>>
>>>>>>>> Ok, I updated as you described. Also I removed PCI conf command 
>>>>>>>> to stop
>>>>>>>> address decoding and restart later as I noticed PCI core does 
>>>>>>>> it itself
>>>>>>>> when needed.
>>>>>>>> I tested now also with graphic desktop enabled while submitting
>>>>>>>> 3d draw commands and seems like under this scenario everything 
>>>>>>>> still
>>>>>>>> works. Again, this all needs to be tested with VRAM BAR move as 
>>>>>>>> then
>>>>>>>> I believe I will see more issues like handling of MMIO mapped 
>>>>>>>> VRAM objects (like GART table). In case you do have an AMD card 
>>>>>>>> you could also maybe give it a try. In the meanwhile I will add 
>>>>>>>> support to ioremapping of those VRAM objects.
>>>>>>>>
>>>>>>>> Andrey
>>>>>>>
>>>>>>> Just an update, added support for unmaping/remapping of all VRAM
>>>>>>> objects, both user space mmaped and kernel ioremaped. Seems to work
>>>>>>> ok but again, without forcing VRAM BAR to move I can't be sure.
>>>>>>> Alex, Chsristian - take a look when you have some time to give 
>>>>>>> me some
>>>>>>> initial feedback on the amdgpu side.
>>>>>>>
>>>>>>> The code is at 
>>>>>>> https://cgit.freedesktop.org/~agrodzov/linux/log/?h=yadro%2Fpcie_hotplug%2Fmovable_bars_v9.1 
>>>>>>>
>>>>>>
>>>>>> Mhm, that let's userspace busy retry until the BAR movement is done.
>>>>>>
>>>>>> Not sure if that can't live lock somehow.
>>>>>>
>>>>>> Christian.
>>>>>
>>>>> In my testing it didn't but, I can instead route them to some
>>>>> global static dummy page while BARs are moving and then when 
>>>>> everything
>>>>> done just invalidate the device address space again and let the
>>>>> pagefaults fill in valid PFNs again.
>>>>
>>>> Well that won't work because the reads/writes which are done in the 
>>>> meantime do need to wait for the BAR to be available again.
>>>>
>>>> So waiting for the BAR move to finish is correct, but what we 
>>>> should do is to use a lock instead of an SRCU because that makes 
>>>> lockdep complain when we do something nasty.
>>>>
>>>> Christian.
>>>
>>>
>>> Spinlock I assume ? We can't sleep there - it's an interrupt.
>>
>> Mhm, the BAR movement is in interrupt context?
>
>
> No, BARs move is in task context I believe. The page faults are in 
> interrupt context and so we can only lock a spinlock there I assume,

No, page faults are in task context as well! Otherwise you wouldn't be 
able to sleep for network I/O in a page fault for example.

> not a mutex which might sleep. But we can't lock
> spinlock for the entire BAR move because HW suspend + asic reset is a 
> long process with some sleeps/context switches inside it probably.
>
>
>>
>> Well that is rather bad. I was hoping to rename the GPU reset rw_sem 
>> into device_access rw_sem and then use the same lock for both (It's 
>> essentially the same problem).
>
>
> I was thinking about it from day 1 but what looked to me different is 
> that in GPU reset case there is no technical need to block MMIO 
> accesses as the BARs are not moving
> and so the page table entries remain valid. It's true that while the 
> device in reset those MMIO accesses are meaninglessness - so this 
> indeed could be good reason to block
> access even during GPU reset.

 From the experience now I would say that we should block MMIO access 
during GPU reset as necessary.

We can't do things like always taking the lock in each IOCTL, but for 
low level hardware access it shouldn't be a problem at all.

Christian.

>
> Andrey
>
>
>>
>> But when we need to move the BAR in atomic/interrupt context that 
>> makes things a bit more complicated.
>>
>> Christian.
>>
>>>
>>> Andrey
>>>
>>>
>>>>
>>>>>
>>>>> Andrey
>>>>>
>>>>>>
>>>>>>>
>>>>>>> Andrey
>>>>>>
>>>>
>>

