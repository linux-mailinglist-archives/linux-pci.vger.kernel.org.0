Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 773A032F682
	for <lists+linux-pci@lfdr.de>; Sat,  6 Mar 2021 00:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbhCEXTi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Mar 2021 18:19:38 -0500
Received: from mail-dm6nam11on2074.outbound.protection.outlook.com ([40.107.223.74]:25185
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229637AbhCEXTi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 5 Mar 2021 18:19:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n2PUmFfp6upVNtM0qgsWT9uvwlVWsZTl6aK0YlU+GsI4Kx/AGNbDpWI8DP/rfYvceGUTEXnwGgyQ42Mndv80dsGy12ywg/sF/3MONZXWyyM6mwjY3IYCAgSi89HCLEZJAHHWVn7C5tQeOJs03dp5svYINlIuHf7wJnSjMZEhOKhWFX0KccEtWazbnzZjIlt85Kdx/9PmTonGjhFZfG/+ds0e5OejRPVQlgvJGKjG4/NNWHzPjIL1tuUb1qgA/1a8nRCDnd2oBO+H0+fBdnfSF6VfhGBMBsJ0TG+ngpFNyq4B7ZnyV8pjg85drqmSk6vjhslF9kWHhSAiECZb7Lkzeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RqIJ1EorcUe1nHwTzT0gbkcJXwIhQ6FDe4qrMq/WwB8=;
 b=a9M9P/tisjUwdxsxIbN7alwBFEbogfbTi4ASSA0XwGdvRq9Ep8CfCmpHxBficd0sRWiI9KpgMhntcIKWaXPpD9ardGPZJIiiKpuNA4wFmUFJ2FppEu9gO2FMS+dzHoXUWddtSX/uYFiDWuE7cpIkw5Q43NqhM36NIYjWaehexPalFMRLYndkZvIxrXOL+/dSGhCsfYJDfKGgMDfesH8OxBTTlY+QrFaykG9Yst8Ohcn1ccV85rUf1XhwGhgiRiTotJVFgp/NRIQ2pHKtgekD4FEocu854Yg4M1fNc8lh4tW5CB6MbhcawwjhV5ow/NG5C1RRARLhTW8WE+otKvvcVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RqIJ1EorcUe1nHwTzT0gbkcJXwIhQ6FDe4qrMq/WwB8=;
 b=ZH6O8DlSFg1hdQ91aIWlqxuF3ngxDa37FtK9Bs66JO0EiTD2BTqe/aabjjwPEkVEo08Ov5mIG56l0YxShJisw4GiYo98diTAiQFpHfUiN8DIdfmoMydFAxGo3u+PXo2SM1X6zRhk/o3Lj16M+RsSSjcGEfPBVcSBu7IDvciV+Cs=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SA0PR12MB4462.namprd12.prod.outlook.com (2603:10b6:806:95::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Fri, 5 Mar
 2021 23:19:36 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::29cb:752d:a8a7:24a8]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::29cb:752d:a8a7:24a8%6]) with mapi id 15.20.3912.024; Fri, 5 Mar 2021
 23:19:36 +0000
Subject: Re: Remapping BOs and registers post BAR movements [was - Re:
 Question about supporting AMD eGPU hot plug case]
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Alexander.Deucher@amd.com" <Alexander.Deucher@amd.com>,
        Sergei Miroshnichenko <s.miroshnichenko@yadro.com>,
        linux-pci@vger.kernel.org
References: <20210302164944.GA424771@bjorn-Precision-5520>
 <81cc1a93-3a77-7ef7-c9f9-6083c1c313f7@amd.com>
 <5c2b2379-9961-c6f6-b343-b874cc22260f@amd.com>
 <6685096d-3c01-7f5a-58c5-70d139b61f6e@amd.com>
 <0fda1f26-9b26-faee-8208-0fe1bf644935@amd.com>
 <e078a773-dc5e-b9a2-3078-3562b8dd215a@amd.com>
From:   Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <3a90f6be-8e89-d47f-e8d7-048d3b9cb481@amd.com>
Date:   Fri, 5 Mar 2021 18:19:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <e078a773-dc5e-b9a2-3078-3562b8dd215a@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2607:fea8:3edf:49b0:85a8:f308:1dca:3588]
X-ClientProxiedBy: YTXPR0101CA0069.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::46) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:85a8:f308:1dca:3588] (2607:fea8:3edf:49b0:85a8:f308:1dca:3588) by YTXPR0101CA0069.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.26 via Frontend Transport; Fri, 5 Mar 2021 23:19:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a2735649-3447-42ca-166d-08d8e02d244c
X-MS-TrafficTypeDiagnostic: SA0PR12MB4462:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB446224ABFAAC988C8308CCA9EA969@SA0PR12MB4462.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yMH4R10QPqqizb4UVQkQ+0LsoNvAkRthJoC9GNOo1CU5R97B6Ifg4d7Z/5k/qpfFZoNpGJ7dbLuZ5TxyUbQKB3dSVPre6zIaaf8lw71h/neA5wtYnbvJH+l5bF1u/MWgrHN0Iv39NbpjkMjAlMPJJe3Zbv+niRskZKoyYDmm1Cl7gJ13BQrRtSE4Ve3sz6ijp75jZ14lASaKEa+O3phpUN6bMEV/TYy1W8cwUaeiJUn3tLiSCudRrpjx/CHuK8ZRzH10/bUQuTV5mC+OcDRnOzjf8hF2uDCqAAYcbjPvtLC3FF50HBrMytKEJNdKq6hyBgY9l4lXSvlyCkhIePfZgly0DbAuRfBkgdQNGdO5NFlTo02FBsVRKThrL+hDAVEJCC42AroNVCq27wKHFID2FHWGMDypu0j0pMjDQ+3d3Rdwf3kKyPvlt1b6pCTbcB5SQ+q86mtE+neL3GzZMJXsYKJThvP3re3TpDh6n8TU0fUrDwRZHtJAtd7MpYscHn8trjV+P6Pz8S9J6MzUEyNJaRIlN70qHvTRzk8+EeS56jd6qEMTcGLmjYWdUv8NhTyFr1cjNjfyKz1YZ8WG7+sqWsmFjX+Cwad2AL29C/umY6XCqG0xUf8GGiulMDR3vx0vMj64k09ieSaGz6EWjxNEFvAkhON7KLPKxgEdEC9BN7ojqCuQcZin6yzjuAxrrEL1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB4623.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(396003)(39860400002)(376002)(366004)(66556008)(478600001)(44832011)(54906003)(83380400001)(66476007)(31686004)(52116002)(2906002)(186003)(16526019)(6486002)(5660300002)(66574015)(66946007)(30864003)(8936002)(8676002)(53546011)(110136005)(86362001)(316002)(2616005)(36756003)(966005)(31696002)(4326008)(45080400002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WjZMK05Ibm5taGo0OWJ5ckloQ0RzcVNKWm9FR1B3V0F3d29icjZ5WTZVdnQ0?=
 =?utf-8?B?NXZQT1NiNVI1L1BrNVMxcEo4ODdGZVZvTGJyek9XdEliYUVKYUthdWV3Yk1T?=
 =?utf-8?B?RkYxaHpLcnZ5Sy9tdTBQOE5NOEpmZ01kQkN3QmV5MHFwZ0dqSWJmNno3aVQ1?=
 =?utf-8?B?bFcxYmdCT0JrZExZZ0p3RTFRcklrODFZTFJzS0pmYmo1YlBTTXM1K1pqSlZM?=
 =?utf-8?B?T3hwV21mdXlHblN1aXQ3aFllM1dOYU1HaVdlbURLZ3VkMDBnclUzU1VsZ1VK?=
 =?utf-8?B?NTg4OGRrY0MwNGl6NHo1eVRrbXlISVFjRXNRSmRiTHhZNzV6TzlGd3hrTC9U?=
 =?utf-8?B?UTRRQm1LQlZFTlFLcEQrbGtxYlMyNElrcEZqREFiSEhLdzloL1RteE1uUGw0?=
 =?utf-8?B?SWp6UXlZcVNzRzg5OFQ2ZTZvSWMrZnFMS0hjK0ZYc054NG82cit5R2kwNDdE?=
 =?utf-8?B?U2Z3WWxDSEZjaXY2WWhKR0FSUVpxOTRPRGl3eVNGN3I5dWVyR052NUdXV0c4?=
 =?utf-8?B?SVRMMWFlaEpIUW81S1VUdldPUkIvdlBsMnUxM2l3d2hiOE5aOUJSSkdUT3N6?=
 =?utf-8?B?WExoNm9lS2FTb2ZhemtYZXF2RFVVMGNSb1pWTm1mRXA5RExVN1dQS00vOGl2?=
 =?utf-8?B?b1YyaWtRcHUyK2x4UWZxZnNmdTBsSFVRRU9mUUU0dUYwbThRRVhMUlJCSlhW?=
 =?utf-8?B?NXk0Q0VGWlNjWGY5VExmRXZ1S1dNQlkvbiswY2t1NW5kVjJ0TWdKTXVmYkRj?=
 =?utf-8?B?cGh3NS9tNW4wd01NV0Z4dW15eEhkY1dLY0ZOYm1XYllMTjJpa3VsM0dYblhW?=
 =?utf-8?B?SzMvQUZueWt4eFJXRGN6TFFIRGhoeDhmdEJQdkV3RHhTeFhGYzVBNG5NNzBU?=
 =?utf-8?B?YmlGUHRaTE5VVXNEbkd4dUFMT3NrTmNKdTdqZk40WE8zcXcxWlNnTVZ0ZVFC?=
 =?utf-8?B?ZDlGZDJxSlFhL2svdVdlTUgvYWlJTEp4T1hQbVppOEtwWVhCUU1CTy9PbFlC?=
 =?utf-8?B?SHozb3A2Q1Fic3Bmeit2TkZNS0VSdzZyMzRDK29IZ2lJa0Rmb0padzJDaFpq?=
 =?utf-8?B?eklWUVZCRzlMQXl5TlJwSDNaUVphRUgvK1pkd3VGUFhqTlFwRC9GQWlVY3ZG?=
 =?utf-8?B?aURRNjZDclJRV3BkRlRzUGdkL01KaGRFMVlPRWMxVStuWjU1QTB0M3lpRloz?=
 =?utf-8?B?NHVSeDM2U0dRdmxxblNGSThTdDRrcE9PcGJMQThKUjAyUEludUI3OUdPL2lW?=
 =?utf-8?B?bUFjRFptR2FTbnhzWm0xSW9ESXlDcmdGNUVwN3p2a1dJOE9zMTkxcGRHNXhm?=
 =?utf-8?B?WmdXcW1wWmxqSG9paTVVWUZTSUxHTUMrcE1vbml5Y3FlRDhXOG02aW1vTjUy?=
 =?utf-8?B?Y0wxTVphZUZpU1M1T1VDR0NrMk5JQzdGb0pqL0FZTmoyTkNTM3ZZNnBEcjNE?=
 =?utf-8?B?TmNlS3Q3ZWU3Q2FhME53TVA2RjNPakt2UENwZnRlRndzem83QVplRys2M3Rs?=
 =?utf-8?B?ZndkTFZ1SXlNMWEvcnYxcUR0dkJCM2VXNUpYUWtVb0djTUFBeVdFWFZZUHhE?=
 =?utf-8?B?eWRFejN2VHBZV3k1WGlRRWg1WktZM1NNanlIZzJKc1d2RllPZXRnSXhlRmtI?=
 =?utf-8?B?VWdPVHJqQmxVSHhLeHVKR2JaQ2RjVlp5aGcwSE16U2l2L1RaNXljZVYzandw?=
 =?utf-8?B?VnVjbWw1aWJXaXlYdW9WUlgzUkUveXk1NlFGZ2dqQkpuY3lGV3JoQVpnZS9P?=
 =?utf-8?B?MS9qMmRCZG5ZYXEvMDFIMW9nb29qcTlXQkdhMDlNcnorNGVjUmdkajJLamgz?=
 =?utf-8?B?UDRrdWl6TTJxaWJraGd6SHRqVUE0ZERQV0xiK3k0dEIybUlDais2b0RYL2ZB?=
 =?utf-8?Q?PlLSkgGyxgi2u?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2735649-3447-42ca-166d-08d8e02d244c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2021 23:19:36.1930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g2Y4aIR2AKkfI7F8QbURph0tHWrYLev/bq+foJxY+LybIQ6E12dlGCActd7c1MWABTOSIVwJH8RKcXOsskME3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4462
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2021-03-05 3:36 a.m., Christian König wrote:
> Hi Andrey,
> 
> Am 03.03.21 um 17:05 schrieb Andrey Grodzovsky:
>> Ping
>>
>> Andrey
>>
>> On 2021-03-02 12:48 p.m., Andrey Grodzovsky wrote:
>>> Adding PCI mailing list per Bjorn's advise (sorry, skipped the 
>>> address last time).
>>>
>>> On 2021-03-02 12:22 p.m., Christian König wrote:
>>>> Hi Andrey,
>>>>
>>>>> Can you elaborate more why you need such a lock on a global level 
>>>>> and not
>>>>> enough per driver (per device more specifically) local lock 
>>>>> acquired in
>>>>> rescan_preapare (before BARs shuffling starts) and released in 
>>>>> rescan_done
>>>>> (after BARs shuffling done) ? 
>>>>
>>>> because this adds inter device dependencies.
>>>>
>>>> E.g. when we have device A, B and C and each is taking it's own lock 
>>>> we end up with 3 locks.
>>>>
>>>> If those device have inter dependencies on their own, for example 
>>>> because of DMA-buf we will end up in quite a locking mess.
>>>>
>>>> Apart from that if we don't always keep the order A, B, C but 
>>>> instead end up with A, C, B lockdep will certainly start to complain.
>>>>
>>>> Regards,
>>>> Christian.
>>>
>>> But as far as I understand those locks are agnostic to each other - 
>>> each lock is taken only by it's respective device and not by others.
> 
> Well they should be agnostic to each other, but are they really? I mean 
> we could have inter device lock dependencies because of DMA-buf or good 
> knows what.
> 
>>> So I don't see deadlock danger here but, I do suspect lockdep might 
>>> throw a false warning...
> 
> Yeah and disabling or ignoring the lockdep warning could cause problems 
> because we don't see issues caused by inter device lock dependencies any 
> more.
> 
> I just have the feeling that this would cause a lot of problems.
> 
> Christian.

Sergei, can you please address Christian's suggestion bellow - quote
"
What we need instead is a upper level PCI layer rw-lock which we
can take on the read side in the driver
"

Andrey

> 
>>>
>>> Andrey
>>>
>>>>
>>>> Am 02.03.21 um 18:16 schrieb Andrey Grodzovsky:
>>>>> Per Bjorn's advise adding PCI mailing list.
>>>>>
>>>>> Christian, please reply on top of this mail and not on top the 
>>>>> earlier, original one.
>>>>>
>>>>> Andrey
>>>>>
>>>>> On 2021-03-02 11:49 a.m., Bjorn Helgaas wrote:
>>>>>> Please add linux-pci@vger.kernel.org to the cc list.  There's a 
>>>>>> lot of
>>>>>> useful context in this thread and it needs to be archived.
>>>>>> On Tue, Mar 02, 2021 at 11:37:25AM -0500, Andrey Grodzovsky wrote:
>>>>>>> Adding Sergei and Bjorn since you are suggesting some PCI related 
>>>>>>> changes.
>>>>>>>
>>>>>>> On 2021-03-02 6:28 a.m., Christian König wrote:
>>>>>>>> Yeah, I'm thinking about that as well for quite a while now.
>>>>>>>>
>>>>>>>> I'm not 100% sure what Sergei does in his patch set will work 
>>>>>>>> for us. He
>>>>>>>> basically tells the driver to stop any processing then shuffle 
>>>>>>>> around
>>>>>>>> the BARs and then tells him to start again.
>>>>>>>>
>>>>>>>> Because of the necessity to reprogram bridges there isn't much 
>>>>>>>> other way
>>>>>>>> how to do this, but we would need something like taking a lock,
>>>>>>>> returning and dropping the lock later on. If you do this for 
>>>>>>>> multiple
>>>>>>>> drivers at the same time this results in a locking nightmare.
>>>>>>>>
>>>>>>>> What we need instead is a upper level PCI layer rw-lock which we 
>>>>>>>> can
>>>>>>>> take on the read side in the driver, similar to our internal 
>>>>>>>> reset lock.
>>>>>>>
>>>>>>>
>>>>>>> Can you elaborate more why you need such a lock on a global level 
>>>>>>> and not
>>>>>>> enough per driver (per device more specifically) local lock 
>>>>>>> acquired in
>>>>>>> rescan_preapare (before BARs shuffling starts) and released in 
>>>>>>> rescan_done
>>>>>>> (after BARs shuffling done) ?
>>>>>>>
>>>>>>> Andrey
>>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>> Wiring up changing the mapping is the smaller problem in that 
>>>>>>>> picture.
>>>>>>>>
>>>>>>>> Christian.
>>>>>>>>
>>>>>>>> Am 01.03.21 um 22:14 schrieb Andrey Grodzovsky:
>>>>>>>>> Hi, I started looking into actual implementation for this, as
>>>>>>>>> reference point I am using Sege's NVME implementations (see 
>>>>>>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2FYADRO-KNS%2Flinux%2Fcommit%2F58c375df086502538706ee23e8ef7c8bb5a4178f&amp;data=04%7C01%7Candrey.grodzovsky%40amd.com%7C44bc68a68feb4b71836c08d8dd9b306a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637503005898302093%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=nuTptAjGewG2T7tXOQr2h%2Bdr42lyg3m1%2Bfv0mJzd8tw%3D&amp;reserved=0) 
>>>>>>>>>
>>>>>>>>> and our own amdgpu_device_resize_fb_bar. Our use case being more
>>>>>>>>> complicated then NVME's arises some questions or thoughts:
>>>>>>>>>
>>>>>>>>> Before the PCI core will move the BARs (VRAM and registers) we 
>>>>>>>>> have
>>>>>>>>> to stop the HW and SW and then unmap all MMIO mapped entitles 
>>>>>>>>> in the
>>>>>>>>> driver. This includes, registers of all types and VRAM placed BOs
>>>>>>>>> with CPU visibility. My concern is how to prevent accesses to all
>>>>>>>>> MMIO ranges between iounmap in rescan_preapare and ioremap in
>>>>>>>>> rescan_done. For register accesses we are again back to same issue
>>>>>>>>> we had with device unplug and GPU reset we are discussing with 
>>>>>>>>> Denis
>>>>>>>>> now. So here at least as first solution just to confirm the 
>>>>>>>>> feature
>>>>>>>>> works I can introduce low level (in register accessors) RW locking
>>>>>>>>> to avoid access until all register access driver pointers are
>>>>>>>>> remapped post BARs move. What more concerns me is how to - In
>>>>>>>>> rescan_preapare: collect all CPU accessible BOs placed in VRAM (i
>>>>>>>>> can use amdgpu specific list like I currently use for device
>>>>>>>>> unplug), lock them to prevent any further use of them, unpin them
>>>>>>>>> (and unmap). In rescan_preapare: remap them back and unlock 
>>>>>>>>> them for
>>>>>>>>> further use. Also, there is a difference between kernel BOs where
>>>>>>>>> indeed iounmap, ioremap should be enough and user space mapped BOs
>>>>>>>>> where it seems like in hot unplug, we need in rescan_preapare to
>>>>>>>>> only unamp them, in between drop new page faults with 
>>>>>>>>> VM_FAULT_RETRY
>>>>>>>>> and post rescan_done allow page faults to go through to refill all
>>>>>>>>> the user page tables with updated MMIO addresses.
>>>>>>>>>
>>>>>>>>> Let me know your thoughts.
>>>>>>>>>
>>>>>>>>> Andrey
>>>>>>>>>
>>>>>>>>> On 2021-02-26 4:03 p.m., Andrey Grodzovsky wrote:
>>>>>>>>>>
>>>>>>>>>> On 2021-02-26 1:44 a.m., Sergei Miroshnichenko wrote:
>>>>>>>>>>> On Thu, 2021-02-25 at 13:28 -0500, Andrey Grodzovsky wrote:
>>>>>>>>>>>> On 2021-02-25 2:00 a.m., Sergei Miroshnichenko wrote:
>>>>>>>>>>>>> On Wed, 2021-02-24 at 17:51 -0500, Andrey Grodzovsky wrote:
>>>>>>>>>>>>>> On 2021-02-24 1:23 p.m., Sergei Miroshnichenko wrote:
>>>>>>>>>>>>>>> ...
>>>>>>>>>>>>>> Are you saying that even without hot-plugging, while both 
>>>>>>>>>>>>>> nvme
>>>>>>>>>>>>>> and
>>>>>>>>>>>>>> AMD
>>>>>>>>>>>>>> card are present
>>>>>>>>>>>>>> right from boot, you still get BARs moving and MMIO ranges
>>>>>>>>>>>>>> reassigned
>>>>>>>>>>>>>> for NVME BARs
>>>>>>>>>>>>>> just because amdgpu driver will start resize of AMD card 
>>>>>>>>>>>>>> BARs and
>>>>>>>>>>>>>> this
>>>>>>>>>>>>>> will trigger NVMEs BARs move to
>>>>>>>>>>>>>> allow AMD card BARs to cover full range of VIDEO RAM ?
>>>>>>>>>>>>> Yes. Unconditionally, because it is unknown beforehand if 
>>>>>>>>>>>>> NVMe's
>>>>>>>>>>>>> BAR
>>>>>>>>>>>>> movement will help. In this particular case BAR movement is 
>>>>>>>>>>>>> not
>>>>>>>>>>>>> needed,
>>>>>>>>>>>>> but is done anyway.
>>>>>>>>>>>>>
>>>>>>>>>>>>> BARs are not moved one by one, but the kernel releases all the
>>>>>>>>>>>>> releasable ones, and then recalculates a new BAR layout to 
>>>>>>>>>>>>> fit them
>>>>>>>>>>>>> all. Kernel's algorithm is different from BIOS's, so NVME has
>>>>>>>>>>>>> appeared
>>>>>>>>>>>>> at a new place.
>>>>>>>>>>>>>
>>>>>>>>>>>>> This is triggered by following:
>>>>>>>>>>>>> - at boot, if BIOS had assigned not every BAR;
>>>>>>>>>>>>> - during pci_resize_resource();
>>>>>>>>>>>>> - during pci_rescan_bus() -- after a pciehp event or a 
>>>>>>>>>>>>> manual via
>>>>>>>>>>>>> sysfs.
>>>>>>>>>>>> By manual via sysfs you mean something like this - 'echo 1 >
>>>>>>>>>>>> /sys/bus/pci/drivers/amdgpu/0000\:0c\:00.0/remove && echo 1 >
>>>>>>>>>>>> /sys/bus/pci/rescan ' ? I am looking into how most reliably 
>>>>>>>>>>>> trigger
>>>>>>>>>>>> PCI
>>>>>>>>>>>> code to call my callbacks even without having external PCI 
>>>>>>>>>>>> cage for
>>>>>>>>>>>> GPU
>>>>>>>>>>>> (will take me some time to get it).
>>>>>>>>>>> Yeah, this is our way to go when a device can't be physically 
>>>>>>>>>>> removed
>>>>>>>>>>> or unpowered remotely. With just a bit shorter path:
>>>>>>>>>>>
>>>>>>>>>>>     sudo sh -c 'echo 1 > 
>>>>>>>>>>> /sys/bus/pci/devices/0000\:0c\:00.0/remove'
>>>>>>>>>>>     sudo sh -c 'echo 1 > /sys/bus/pci/rescan'
>>>>>>>>>>>
>>>>>>>>>>> Or, just a second command (rescan) is enough: a BAR movement 
>>>>>>>>>>> attempt
>>>>>>>>>>> will be triggered even if there were no changes in PCI topology.
>>>>>>>>>>>
>>>>>>>>>>> Serge
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Ok, able to trigger stub callbacks call after doing rescan from
>>>>>>>>>> sysfs. Also I see BARs movement
>>>>>>>>>>
>>>>>>>>>> [ 1860.968036] amdgpu 0000:09:00.0: BAR 0: assigned [mem
>>>>>>>>>> 0xc0000000-0xcfffffff 64bit pref]
>>>>>>>>>> [ 1860.968050] amdgpu 0000:09:00.0: BAR 0 updated: 0xe0000000 ->
>>>>>>>>>> 0xc0000000
>>>>>>>>>> [ 1860.968054] amdgpu 0000:09:00.0: BAR 2: assigned [mem
>>>>>>>>>> 0xd0000000-0xd01fffff 64bit pref]
>>>>>>>>>> [ 1860.968068] amdgpu 0000:09:00.0: BAR 2 updated: 0xf0000000 ->
>>>>>>>>>> 0xd0000000
>>>>>>>>>> [ 1860.968071] amdgpu 0000:09:00.0: BAR 5: assigned [mem
>>>>>>>>>> 0xf0100000-0xf013ffff]
>>>>>>>>>> [ 1860.968078] amdgpu 0000:09:00.0: BAR 5 updated: 0xfce00000 ->
>>>>>>>>>> 0xf0100000
>>>>>>>>>>
>>>>>>>>>> As expected, after the move the device becomes unresponsive as
>>>>>>>>>> unmap/ioremap wasn't done.
>>>>>>>>>>
>>>>>>>>>> Andrey
>>>>>>>>>>
>>>>>>>>
>>>>
> 
