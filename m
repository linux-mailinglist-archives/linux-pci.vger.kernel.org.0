Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC10E33C145
	for <lists+linux-pci@lfdr.de>; Mon, 15 Mar 2021 17:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbhCOQKn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Mar 2021 12:10:43 -0400
Received: from mail-eopbgr760085.outbound.protection.outlook.com ([40.107.76.85]:43061
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233565AbhCOQK2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 15 Mar 2021 12:10:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LgoV6bp8OGC2FYIAIm0rnvq2G5fMe6FHP9Var/TVTyD5o+BxVBst0J7ooSUx1KTNpqUN8d46VcZIjZBIFhGyFvToWVkUK72zkAD5uiriJu7rjdan5F4lMQI3Yp0yhmFRNncepN6W4fh+mSrXHeuH2WQ4y/pyuwksOfSya7kYEC+YqH6qWDMzspOKAV2IXEyKuLUfuXPcXEAPL3rHXXqB/iMZYKspJCg0VYCNO+uV3C+nhHJ3h57W/jCyeKwpIjh0nYxdP0e9syMkJck+WuzBztLtElgZdZEShDY5gEjBfi4lyGycqFHblb1I109vmhJ/IAD5XYl/X48jSmmpiauDyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pojx5t/upO3wx+tlE5fEMbfLOguXk8umDhgx2XJBMbE=;
 b=U6DVtI2t6wHuz2HZmKtITTscVBNXtT5z51MSAoOot92R+EXpJwbvSFMQO9FAafZUOqy//pzc6O03KuVqH9/mpqPDbZOUk7+6brHrFL2UAOh/JNdmn92uybs1lNFalVQYF/BSh0dqD8Tdq7iZGqpKWVXbwV6f3ZDZXEQa5aWFE0aP4Rw1B5CWgFmIRONsyGZqt+QuBBfmOR/dCCijNQwqXTfEdOOIJmKFhHvE5uoT46auSQLYb0HUJ/nEnehCfmz5e4cnawmArwsUP8HYkS81CSfjZS85pxDJufDsI2JVy+hNrCrmXIEic34XIL0ingsy/TOcqCQTu0f2wbdXbO+SQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pojx5t/upO3wx+tlE5fEMbfLOguXk8umDhgx2XJBMbE=;
 b=PmcLIaVKMJY7p4RRS9OLUProIItPv4r6HtF8VMSWF3dbeZEniySegmNMgiiPiSQw2N6VLgB6zR8jmqKsV+vGfqcqdt3+ztYm/OMV/VgLy6P7UibmgNSI83YCeNDWJV3kxlBC3PJ8KNGyzDzJt+307BqoqG6I+kFvhTG1NhSIRq8=
Authentication-Results: yadro.com; dkim=none (message not signed)
 header.d=none;yadro.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4191.namprd12.prod.outlook.com (2603:10b6:208:1d3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Mon, 15 Mar
 2021 16:10:26 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 16:10:25 +0000
Subject: Re: Question about supporting AMD eGPU hot plug case
To:     Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
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
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <6714c482-7662-8e26-65f2-76a011be6f78@amd.com>
Date:   Mon, 15 Mar 2021 17:10:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <f3f74ff6-f7cf-5567-6af4-cfb0e2769cc9@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:dd5e:327:8807:376f]
X-ClientProxiedBy: AM0PR04CA0053.eurprd04.prod.outlook.com
 (2603:10a6:208:1::30) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:dd5e:327:8807:376f] (2a02:908:1252:fb60:dd5e:327:8807:376f) by AM0PR04CA0053.eurprd04.prod.outlook.com (2603:10a6:208:1::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32 via Frontend Transport; Mon, 15 Mar 2021 16:10:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1f4afef9-ea60-4719-c4b7-08d8e7ccd7f0
X-MS-TrafficTypeDiagnostic: MN2PR12MB4191:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB419118BF6AF75134B9768FD9836C9@MN2PR12MB4191.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a1iCjrP6xhJyJHQG3zmumXYkriybgoGds0z8yYbzwV4iHikNv3cGCsBKg2TqtAFUHhOKVjkm+r3AA7THaK7bGPGpRsAOclOWGiLVMor7zQX7ne9rXZ82svJXkjO5W9sSdzlw2EtF4z9PoTpcpvghJs0h4HbQwGtNQuy7q5qCHr+yX5rGjaZe78htmdwKhUxCdcfzfZ49ChQwTqsf0vk5vZmMLn2fNND+VCwTh/StjNpijjtRsV4Mj9IVCdQfC5BhuIwzPFwFz0U37F5VRA4apdEgGiqrjzOqju0FRD3jLjEmvW9Bata54xk3nU+z37taPsVsClI4u7P71OuFQuQe/eS7WPTLLGXwOeFkYf1GR+juIJPctDBGHugzN/kylt7s4J0uwpN1TDvLgrItLrm9tLiWn8Un6uyjdsbiyCzXi6BHf4VfZWXQQRJFrXRANnK7d35IFuHEcX89OwFnYI/rUr+XogPg1kbP4C8sajQuKobN6wK3EB2hM9j0PsLrabQakZT8DzDwJXi/AoJo8nmry1/JLPOaPol+3sKzLOlk0xZbdKV3DRYoq1wSOWruJ1mRNHSnW01azrFcNQt6VKCnGWugdHdcRl/qgb3Aj3aSbaWDkC1QkqxHlgpisGNxtNq0gRLxzv597VgEISSlXDHJam9eieGBUJ0z4NyvDMRBej9KTws2GSh5pIPp9USvIqLi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(376002)(136003)(396003)(346002)(31686004)(316002)(83380400001)(966005)(53546011)(2906002)(8676002)(52116002)(66574015)(8936002)(86362001)(16526019)(478600001)(31696002)(6486002)(2616005)(66476007)(110136005)(186003)(36756003)(6666004)(66946007)(5660300002)(66556008)(4326008)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cnlISGxwS0RyZkNEL3ZvYklwbDRSV1VzeFFHN0VrSFpURWJCVHE5SS9tQ2w5?=
 =?utf-8?B?NUNNdmVOTkNvd0VmNWlGbmx2KzlHYkc0Wm9XeW96aTRRdUNVVnJUdkQ2Z0Yy?=
 =?utf-8?B?VnpTYjZETkdZSVg1U2Jobm83YjJEN0V0MHUrR3pqampiNUM0UHpFdUplWStY?=
 =?utf-8?B?bXZ2b2huOHRwZWorV0JLZjloN1Q1SXVlNXhsTEJqaXUrTzg0NHZHSU9Ma0Vn?=
 =?utf-8?B?UVFhVXhNdUZ4OGNYSzhiaGh4UnhUc1pINWlHNG1LK1pvQi95alRjMU1XOU5U?=
 =?utf-8?B?RTQ2Q2Y5QXNoZkt0a2ZPY1czUVFpYmtiOTBjM0ZOSExseWhhTFpIMkdQN1Z6?=
 =?utf-8?B?NWIrOGJLV1h2V3NGbUFXa1FNOTZ4MXZRdWFSc0w2RVNWbDRlVXVNZDRtWE5T?=
 =?utf-8?B?a3I4Q2hhU3c3dWp0UGdvRUZmL3F1TVNVbkRoM05aSTk3OWpSQWVLM1VrVUgy?=
 =?utf-8?B?RE5Qb3FJamZJQWhFbHlObVFpbGpSTTBsSWt0RmRqQndMcmVOdGcxTytKaEVE?=
 =?utf-8?B?QXpEMUxsTVI4ajZUSXpic3BXN05OdEdlNHlTWHIrVFNCVjdqMU1hRTdtSldM?=
 =?utf-8?B?QWVJSmxvdkdYQnhmbzlpdUVHUlMyTjFKWER3LzVvcGhPWWphZGM5a3RJN0U0?=
 =?utf-8?B?WERkdytBOWdiM0VJOEF6T1hqbXRwZ1JiUmN6c3VHODQxMzFrVEtBQjlmaEVL?=
 =?utf-8?B?L3NRU1g3YmRjSlpkV3ZlM1V3UzhpaENHQVg5VE4yWUZlV3V1ZGV1TFhPYUNG?=
 =?utf-8?B?dWlIdWJCVU1CNWdWaHo4UFRtU3VVRWxGYUxFaUZnaWZETzh4aEFEdmY3eUJl?=
 =?utf-8?B?UUlMK2pxaDAwM1RmM1JWYUs3LytFbWc5aVI5eGk5aW51UFlCN1Q0NUtZZUIz?=
 =?utf-8?B?K0ZwVXlZd0MwbzNjVlJhOHhyRjRBZFIxcTd4N1V3ZTZPelFhL2paYlk1VUJP?=
 =?utf-8?B?Q2lCODJacWVLL2FabkNlQ0dZVG1aMUYrTGtiMzVxVnVLTEVJSVRiU1pyTFI3?=
 =?utf-8?B?b1lCSmJhcmxRZUNtYnp4dDlMT3ROczVWdGhBNFBzRHA5dGxXdG90eThhUlJF?=
 =?utf-8?B?dnZjQng5cENDY0hTN2F3azhxbFFEV28yQzN6UDZFVGN4RzdUM1hYa0FOZkU1?=
 =?utf-8?B?T2x2Q3pCTDV6aWFLRlowUkNXRHRvcDJMdVVnUVNDZ2wvVC9vSkhkcGJCWWRY?=
 =?utf-8?B?Wk1GOW9aOWV0SitiYjk1Wlhzd2RJWWladTdETkNYSkRnRUF6KzhTY2hCQi9h?=
 =?utf-8?B?UG0yY3NoaTJxcmNycFE4alk1cW5qTGVGNWQyOS9lMGZENHVwQUpyMnp5Wk1I?=
 =?utf-8?B?MThkSmVTNkRxOTh5dVI3ajE3VkhFd3RzZWR4WGV1MnBoci8wZXFWMHlIekRu?=
 =?utf-8?B?TlB2eUpEYVBhTDJIanJ2bHNwZTd3R3VNeHhQbWhQZEozTEJrYjNMTTdkOE5Y?=
 =?utf-8?B?R3Jjc2hGV2N4SzNwZ1gyYloxM1JjQ253T2VOTFJySUZjQW5TK1JPVHdTY3Rn?=
 =?utf-8?B?b21HdmQ2K2ZoWWVERUhReUY5blN1c3hDWkpvQ3c0RVZNZkZlWkhuWThEdnk1?=
 =?utf-8?B?TEpYbWU1WWxucGQxdjE5ZmFCQjdsNFFDQjVPM2JnL2R6MU11ZVdCTU5Ib2RB?=
 =?utf-8?B?UFlrU1JXTWpVUHlkMUhIR2E5SWNQcS9JY3hyUmZGV1FlMEVoZEdHcDJNS3Np?=
 =?utf-8?B?b2o2QzFaa0dFYm5EYmVrS3Jwd29NNXZscEEwK0x1eDBPNkYzdmdBaWRSSGJu?=
 =?utf-8?B?QW1sVnVzUVpjM056QmEyVUh6RXV5T0J2TUtHbXFPeXN5VHNLZUIzSnFaRkNs?=
 =?utf-8?B?NkZ6Z2phSUxTMVlBVW8rWjRySC9SVldtTy81cFR0QVFuZCs1TUM0ZlhybEFr?=
 =?utf-8?Q?YkxiBotqLtLYv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f4afef9-ea60-4719-c4b7-08d8e7ccd7f0
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2021 16:10:25.7958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b8sxCjIZeiqCq33IAv405NRSP/IkDm6f3oRgoSiTx5LdkXYqLXPkv7yLMKoGqlS5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4191
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am 12.03.21 um 16:34 schrieb Andrey Grodzovsky:
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

Well that won't work because the reads/writes which are done in the 
meantime do need to wait for the BAR to be available again.

So waiting for the BAR move to finish is correct, but what we should do 
is to use a lock instead of an SRCU because that makes lockdep complain 
when we do something nasty.

Christian.

>
> Andrey
>
>>
>>>
>>> Andrey
>>

