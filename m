Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7EDB33C0BF
	for <lists+linux-pci@lfdr.de>; Mon, 15 Mar 2021 17:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbhCOQAj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Mar 2021 12:00:39 -0400
Received: from mail-eopbgr700061.outbound.protection.outlook.com ([40.107.70.61]:58074
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231799AbhCOQAa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 15 Mar 2021 12:00:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TTkk02L1PCdbfW6ivm8Bo4ThBDarG0qovDDL6ojf6A2nwRd2VtG8yAV2RPvUpLpkJ5HbSVV3I3UqI4M+gSya7us3ofMu64noG2rrtw/Dma3wyNmKv5Hz8MYl8UOLJwAUbmrPLrKpZUUoS1CPf6HATRmen7uwuhgW9eMSgK2u3+WVODw7oaXkZFuL6J9eeZAuZpTSJCVAr1WczB8nUYTDbJZwpzvX0oSBB5I2mkylmdjdHEeYN+PVvKTx3t7UReq6AB5SNrGn+Tdfl9FTp/K2YUPk/Sre3bri+xO+RUoJSHuxmZ5Eu42pQyd4xp9IDhi73uBhz5VJSRUYP6jLsGAaJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jg0kcuXQN5QKKbzmKUEUKDJPLD2pRncIByHqWjQlwns=;
 b=OF4/yEo4IvK9TvZRzABNOMkO3Ep4WBNg+zUzaoxWQxfb/jRZ4ohdKbf98DG7gUYQ+97i6HMSZCjftuD0FCA0aV5kZiXsdVhdHlxoQacSacYWZ9QexKYyiR8O8eU6SUZSLzQgzYWvDdUo5snqISRiWUhLs0CpWyJVZLsugA5jRsHqW9KyT/hav1KC2okLD4s0i2B51u/uhcw8wN6ertqusWYYR9FPdDi/brHwQcMOVpZhaNa13Q+z87t7lTzlmZoxONbeB7U+iWzA7uy4Cg0ulrZrmhp6ACihMfliWw6YZC/YbK1l9G/PtZd7St6JVkezYSzO1RqrLmglT9h1NNAkgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jg0kcuXQN5QKKbzmKUEUKDJPLD2pRncIByHqWjQlwns=;
 b=Kto0TXYtcM9ABkYrDvtZqAJkMsHD6t3dSBA2yFX3VMF5u486DzOll4dXV1k7rISCR8O4MqTD2uvDbH+BqUA1A8svEZv8p7TVbmj75IbvAat0F5UhMqfnsNiYbQCyJ3gmMIqoA3JJrVQKGjWmBMPdEsdMaYTKzHTW25CAzer/VZs=
Authentication-Results: yadro.com; dkim=none (message not signed)
 header.d=none;yadro.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SN6PR12MB2815.namprd12.prod.outlook.com (2603:10b6:805:78::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Mon, 15 Mar
 2021 16:00:27 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::29cb:752d:a8a7:24a8]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::29cb:752d:a8a7:24a8%6]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 16:00:27 +0000
Subject: Re: Question about supporting AMD eGPU hot plug case
From:   Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Cc:     "Alexander.Deucher@amd.com" <Alexander.Deucher@amd.com>,
        "anatoli.antonovitch@amd.com" <anatoli.antonovitch@amd.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux@yadro.com" <linux@yadro.com>
References: <ddef2da4-4726-7321-40fe-5f90788cc836@amd.com>
 <c82919f3-5296-cd0a-0b8f-c33614ca3ea9@amd.com>
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
Message-ID: <52f477bf-e11e-6b28-5818-a83d3f657488@amd.com>
Date:   Mon, 15 Mar 2021 12:00:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <f3f74ff6-f7cf-5567-6af4-cfb0e2769cc9@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2607:fea8:3edf:49b0:6d99:e7bc:e939:916d]
X-ClientProxiedBy: YT1PR01CA0003.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::16)
 To SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:6d99:e7bc:e939:916d] (2607:fea8:3edf:49b0:6d99:e7bc:e939:916d) by YT1PR01CA0003.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32 via Frontend Transport; Mon, 15 Mar 2021 16:00:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 67a608fb-5d3e-43cd-ccf0-08d8e7cb72fd
X-MS-TrafficTypeDiagnostic: SN6PR12MB2815:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2815A03D64979FF17A12C742EA6C9@SN6PR12MB2815.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: anPZZuFvYq7NpGJW0+IB0UHXJD74O8eQzPW9taTjky75nkbT6yshq/Bj5F41GuvXmMSPB8LQN3boxdduLbii8qcKUVk2N/cpM3n3i0hLV9oMLQACIEYLEKS0d5BGfnOArwohMUWwN/iTbQMryEogL6QHL9BOGMXmmTRVB1jMhLfN/dmLpY+mwT5Ava/0fXWr7Qlc12np6dHQ6Zm/nUvsdbpjYCqGYuEz0j/x4k63p+DrTYRHAYWdpVSC20SFd8bjQJDIzIVXcA67/qvIrfQLTYNYXPGUFvXi3iKA/DD7bruPrpZbiD+vHQcrL+tQ/49HgAmFkHzBy8WXs/bjeyN1+pUDSoUEfRJk3OanzBnzEaEPNNVQg7/uXwJqmJj2eEhh1H+n70Ej7+fN1JXLreWyqUlLb1Lw+32N4qNWrfEQ3DT6N9OgQiBb3K1VdFHpl+5jGaJuGNCXvE3B8mcv8421sMkcWRu+Tgr9q1QrFouBrxLTv5zI1+I8Z8OaDu2CKNcfbHqruJE7CoYJm3hBTE69Ypylg8gVBlDy4k7bJMJqqqzi0XJG1kKPDslEwSF2o2cgliRQUWtmYDJQpFNr+MMd9WFtJpXoyIl9s/UGltJ6avPU3TfVi791BlLHkvw2KrukQH2TeAmFBSuBPyyHxoGBKAlNnA3OjlONkSe1vWoSOj0ULoTX5zBGzrqkAh0ccw66
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB4623.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(366004)(346002)(376002)(44832011)(316002)(31686004)(186003)(66574015)(6666004)(16526019)(36756003)(54906003)(110136005)(5660300002)(66556008)(66946007)(66476007)(4326008)(2906002)(83380400001)(8676002)(478600001)(52116002)(8936002)(53546011)(31696002)(2616005)(6486002)(86362001)(966005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?azg1YWh3ZzJITUR3Zmd6UllKczdKQVgvSXF4akYxcUxyY2l3VDh1M3VtKzht?=
 =?utf-8?B?MVl4SUZXM083NGp2R21GTXRYNXpFUFVwUVVpWkpWcEJyRmVUODNNWUFhTE8y?=
 =?utf-8?B?dldodCtXN3JWRzdFeVJLdG9TMXNJbHdIbDJ0U1JNOG1ONXZ4UGFyMm9mQ2xt?=
 =?utf-8?B?QjhZMFNLMFNpWnNsYklwM05VWmJsVkFuOFlXRUV3NDVpZGUrV0x0ZUNkMHFx?=
 =?utf-8?B?aUx4UGR6M21ReWZLZ3E0QXB5a1dkcEtzb3FWOHJCRkMvRVlPaGdobjJXSG9x?=
 =?utf-8?B?dm5tcENoUTlvNmFwZGM1RWt4dUlacDQvVnVrZlJZOUMvQXJSeURFcmh6ZWUz?=
 =?utf-8?B?Ry93OExCb3BDb2x0eEhjRnp4aUpTOTJvSFdLcGlNQ2wwQlhFWDNVcktNK2lZ?=
 =?utf-8?B?RmM1Z2k4QTc3eXVnRXZSSkp0TFNiczRVczZ4N1djOEV6Rmh6djRkY0V6VGpT?=
 =?utf-8?B?V2lrc0N4Ry9TOXFTempJd0xSUjNmekRNS2t3Z3FVOVRCeUhwdzNjUG50V0tJ?=
 =?utf-8?B?TXJ6YUdqS1B6ajI5V1cxeDVGd3JLbjdmREpxa0FZZUdoZGFYbDd0c3BFUENS?=
 =?utf-8?B?enpLeHlFemJMTExDaVFMbERKVmtRTllTaVhLQ0U5MzBhYXhRZEp2TDlLSkJl?=
 =?utf-8?B?ZjY0a2ZTZUtwVUpNbmFZYjRZSFdkeURsVVc1bWd6emlCUHlTV1lOK1pKeTM0?=
 =?utf-8?B?NExFSjZlOG9FUGhlTEJIc2g3LzI0SjArV0ZtU2R5cTl6VFVrc1hQL2dBTHY1?=
 =?utf-8?B?ZFlRajlaRmRra1g2VDZ2MXl3TnBTTzBZODVxQWs2SjhjYXpta2ZGeDZWWXpQ?=
 =?utf-8?B?V2NORVd1V1RDSnZwM3k3Z2g2MUFSUEdud2hBL0JBY3VIczcvVDRzNzhnMyts?=
 =?utf-8?B?NURXcUdaZlZ5MnRoSWNZVmVmcjVkRVl2Wm1DMTFNaTEyTHpjdmxWUnI0YXZX?=
 =?utf-8?B?ZGNaNVk2bmVNTmhVVlk3L3IzbDBVVyt1VE9XWU1OZHorbWVFV3ZDYmI3UXU4?=
 =?utf-8?B?THdDTFJUVlAzMUNjUXdkUWtac09QWC96THBOelJSNFMwUTJQTUxrZGVhODRz?=
 =?utf-8?B?NjU2WUJuL1JPQmxqZnVGeityWWYrdXZBeUxEa2p1cWlBRW81OUtWU2FrUTk4?=
 =?utf-8?B?LyttMHpVcExOTlZDUmZNMGVzRFNhMkN6cEVlMmN6WlB6blg2UE1QOGtGMURN?=
 =?utf-8?B?NG1FSjJMZzAwakFKNjBESWFqVVhibFBXT3pCMXcyTitZWWl6aG41aGw1SjZJ?=
 =?utf-8?B?QXVhRzh0L1EzeHBoSVVVcXJ1cW5zZXkvVVljVTl2NGl1QW91VFFhVXJyUWZH?=
 =?utf-8?B?b2Fvd3NxNFByMHlFNGpNVGtsakgyK3ZSMnBwdDkvNkQ0Ym5SekMwdWc2UDcy?=
 =?utf-8?B?U1VrYWt5bXJsUDFMWkFWM3dWUUUweTRtRnF0UzdOMnBZQnVmN0dxVW1UV2pw?=
 =?utf-8?B?VlRIaEgrV0MrWVJZczlYQUxSZTVoVUtKeEdMQW5zRCt5T2tuUzdQQnRwVXBT?=
 =?utf-8?B?djFCTkxjQXQxV3JHU1VDM2swRjJ6bEhqZzlFNlFxMDJIR3ZqaVF0Q1pEd2NK?=
 =?utf-8?B?c3hUM3pXTExxb0lFOUhTdGRadEFWRXNmN3B4WUxXT1p3bFdDVm1VdlZMWU52?=
 =?utf-8?B?Um5tbzExOU9aT2ljaktQN2lobEVaWFhGdjFrdlc3L2wvUG5pbUJLRzExc0NG?=
 =?utf-8?B?WEdUZGVTWWxPTkxlVzRrUEFsT2ZheTQ3Vmh0RHFnbVFqajJQcnV6UEpCUlZB?=
 =?utf-8?B?NXhITmNzQXhoZHAyazdFTzlYc0pZbDlqVm53SFNlK0liZENubEtDVjRnRTMv?=
 =?utf-8?B?YVNyY2JGTlBCTVRLQ0dEMHJLQnB4NjZ2QlpHaWd5RlliWFM0VXl0emlVZFlh?=
 =?utf-8?Q?UUkeN2IzllIGZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67a608fb-5d3e-43cd-ccf0-08d8e7cb72fd
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2021 16:00:27.1545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FwRJB+c0SY3vO+6wlBcHaqy1sC9XV9HW0aeNtX0ifCCWd1KX1p3fuqX0MZfbulpY+shZ7ZGVmGHO35Q7v/de2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2815
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Ping

Andrey

On 2021-03-12 10:34 a.m., Andrey Grodzovsky wrote:
>
>
> On 2021-03-12 4:03 a.m., Christian König wrote:
>> Am 11.03.21 um 23:40 schrieb Andrey Grodzovsky:
>>> [SNIP]
>>>>> The expected result is they all move closer to the start of PCI 
>>>>> address
>>>>> space.
>>>>>
>>>>
>>>> Ok, I updated as you described. Also I removed PCI conf command to 
>>>> stop
>>>> address decoding and restart later as I noticed PCI core does it 
>>>> itself
>>>> when needed.
>>>> I tested now also with graphic desktop enabled while submitting
>>>> 3d draw commands and seems like under this scenario everything still
>>>> works. Again, this all needs to be tested with VRAM BAR move as then
>>>> I believe I will see more issues like handling of MMIO mapped VRAM 
>>>> objects (like GART table). In case you do have an AMD card you 
>>>> could also maybe give it a try. In the meanwhile I will add support 
>>>> to ioremapping of those VRAM objects.
>>>>
>>>> Andrey
>>>
>>> Just an update, added support for unmaping/remapping of all VRAM
>>> objects, both user space mmaped and kernel ioremaped. Seems to work
>>> ok but again, without forcing VRAM BAR to move I can't be sure.
>>> Alex, Chsristian - take a look when you have some time to give me some
>>> initial feedback on the amdgpu side.
>>>
>>> The code is at 
>>> https://cgit.freedesktop.org/~agrodzov/linux/log/?h=yadro%2Fpcie_hotplug%2Fmovable_bars_v9.1 
>>>
>>
>> Mhm, that let's userspace busy retry until the BAR movement is done.
>>
>> Not sure if that can't live lock somehow.
>>
>> Christian.
>
> In my testing it didn't but, I can instead route them to some
> global static dummy page while BARs are moving and then when everything
> done just invalidate the device address space again and let the
> pagefaults fill in valid PFNs again.
>
> Andrey
>
>>
>>>
>>> Andrey
>>
