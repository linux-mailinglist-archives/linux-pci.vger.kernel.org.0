Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0953380C1
	for <lists+linux-pci@lfdr.de>; Thu, 11 Mar 2021 23:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbhCKWlb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Mar 2021 17:41:31 -0500
Received: from mail-dm6nam11on2088.outbound.protection.outlook.com ([40.107.223.88]:44992
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229441AbhCKWlB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Mar 2021 17:41:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UrXydLkbmfPoT/5u6S1F4KeKaDQ5/XWS72wMQemuOfU8P93P+fRb0TB4WhkThXIoof1Cu6d3crNVChAKYjdgoIUvSf/Uhhjb6LoFvD2XbsDxwKyFieiiwEGKUeCHsRDNq55i9qv4CBqU8bLAIvlvQL+90TyEE90yFWG5RQicAcDTmbX0hye4G1gsCHBd8JuUM1nnq/685JsZf1R0vrznGwpKVVcsQHMH8SXmFIq5ExFekIN2JJaND9emdl7zQeqmOS3zwjvYFEaF3Xz/BxGwFhyAepYFVWYvN2IAgVFHwndsD48236odVl4BeN3KOj77Zi9BylSdKnCMEO2piFFStg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=no65LuAqCMscKEzlt1nS8Guoxdw/J0HbwNf7OqOK/OA=;
 b=TrZHI3DARwGBBUcdL8wv9lsRe2cYe+FM4uSZ3yV3q93Xlhu0EQ2yshXEl1xBEYqm0a7esYXfQa2B+NDoew68yY/7Xn7nfNwra0ojz6nvW/4oFQtvl0jW8+irwRnXAVyRYEoZh3R31iA/OrMkPDD2I0auWV1V5rdhgN/4m2KNN6Iu1z+0qFhkxqE6w6bfATsiLt2WakV2rHZ3Fkq9ci37PIXCjn3/EnP0B4+ySIqYv46aWVFej0KaSYr5YltlclU5QwtSasJb1DIxzk1cR0/sLxpa4P5tpCORFi6bY0SBY6iERCS+ZNo+fxUwPLyZaxYrNh3bUmwOPtL8eoZxl6ufcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=no65LuAqCMscKEzlt1nS8Guoxdw/J0HbwNf7OqOK/OA=;
 b=jSunb2BiIPEs4MpTAqW/0kf6NGAJVTYY8zmG1zrteeQuQEEypWtUXAW7XgGCWCWckvWNZwKaN+Y8/UE8LQg/I5ySy/6xBszRHHGO6lHOqMbGIIDCAwEqg6YeXjL0/B7nmc/8PNTs4Hbqj43TuGAtdPz4yTHpjcn5mrZ53x9XtWU=
Authentication-Results: yadro.com; dkim=none (message not signed)
 header.d=none;yadro.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SN6PR12MB2655.namprd12.prod.outlook.com (2603:10b6:805:72::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.29; Thu, 11 Mar
 2021 22:40:58 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::29cb:752d:a8a7:24a8]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::29cb:752d:a8a7:24a8%6]) with mapi id 15.20.3912.031; Thu, 11 Mar 2021
 22:40:58 +0000
Subject: Re: Question about supporting AMD eGPU hot plug case
From:   Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To:     Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Cc:     "Alexander.Deucher@amd.com" <Alexander.Deucher@amd.com>,
        "Christian.Koenig@amd.com" <Christian.Koenig@amd.com>,
        "anatoli.antonovitch@amd.com" <anatoli.antonovitch@amd.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux@yadro.com" <linux@yadro.com>
References: <ddef2da4-4726-7321-40fe-5f90788cc836@amd.com>
 <9c41221f-ecfa-5554-f2ea-6f72cfe7dc7e@amd.com>
 <dae8dfd8-3a99-620d-f0aa-ceb39923b807@amd.com>
 <7d9e947648ce47a4ba8d223cdec08197@yadro.com>
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
Message-ID: <e3f3de55-8011-77d8-25ac-f16f8256beff@amd.com>
Date:   Thu, 11 Mar 2021 17:40:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <146844cc-e2d9-aade-8223-db41b37853c5@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2607:fea8:3edf:49b0:9d0c:37c8:e184:bbaa]
X-ClientProxiedBy: YTOPR0101CA0072.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::49) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:9d0c:37c8:e184:bbaa] (2607:fea8:3edf:49b0:9d0c:37c8:e184:bbaa) by YTOPR0101CA0072.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.26 via Frontend Transport; Thu, 11 Mar 2021 22:40:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c65052e4-db51-426a-fd7c-08d8e4debd0b
X-MS-TrafficTypeDiagnostic: SN6PR12MB2655:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB26553959E92B42CDEEA76B96EA909@SN6PR12MB2655.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ajrHCyaMZ9JlWHKl0ZVpNYyYQCturT7Fd7wPPmcy3cTIPyc31HH1U66qJW9IA0agJCZasCyGoNFGnN1v8zD4wquwPMUzpElDquUZD8LVFqWkpzJjHvNvkHRbt9yEpyzMopd3g6WVZ46sPU74cSwhuswQjiEJrzSSXXVd3555Ksfw6DyBWo9Q69MHV5VSCMOFgWvO/tEyKBKuNaiM0CrnvdUYvr7lGPYtmnFmSEHIGuQ1q1HZlWFW3U1Bx0NKTja6k/hMxn+CXQHP6N8/E4mdDtPef9DxvpgQwrnNdYFeJIiIDD9aD/SoSOdcwZd9v2MdgDutVc8kuHIW2ojjK/y7Z2gOnh8lh3r8TZ4b+Bo3fNGWKUEVzj4PxKR7tsn1xvrddMBkLLZtZQSMDsPlpoptCzsAapDxyE/vqFSdsZGp+aDSE5mjlhMzDw5Fu7Fy3TAURSVoypy87cMDw9NrQL6kzqY/0Dy7zLf3sdJ2iQq++S5RXUavqka35gyKdvdrIXFJ06OoE74O0CD8UvEEwL2sP7LXd5ZftzpScNIdkaLtwv4OHvwVq/tqizWjiAHcXAsHRAYXINzEXbyvXwUzKQMi/7asVUZBTccAav1sC4ruEyK5yErZNenZLadeqjgnoJDP/S+tOBJoTJA1hzjkxv1e08HfU+Ud8ZqoRl3aX2yxq7+BgsllnnWXRLokNdPS0rin
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB4623.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(39860400002)(136003)(366004)(396003)(2616005)(6916009)(44832011)(54906003)(186003)(16526019)(4326008)(45080400002)(86362001)(8676002)(83380400001)(5660300002)(52116002)(66946007)(66556008)(53546011)(2906002)(36756003)(966005)(316002)(66476007)(31686004)(6486002)(30864003)(31696002)(478600001)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RmpvdEg2Zk1YalcvRjJkWWJxMWs3cGh1ZTFQSXJEbDR1NlFhd1BaMUdUUysy?=
 =?utf-8?B?LzI3bFd1cFp5YmRWWGhOSHdwenVySU1jbElUajVnNGVITHRGWFFEVVVka0pK?=
 =?utf-8?B?RXZrUlBJQnlyZ296Y2k3OVlTbXM2dUpiTThxcFQ1NHlZUFdhUzJWeVRybDlp?=
 =?utf-8?B?U3prZld4U2pCOFlYeTlvcmZVSDZHUkFtenJBcWluU2ZPNU12b29SaXU2N3R4?=
 =?utf-8?B?UU0zZEtnQXQzWFJETmw0REVaVmhaK09XMWVrMWg2RzBldW5JM1VuR252TEJu?=
 =?utf-8?B?bWVGUXpYL09TamEyL09nTFc5VnJmNXlVcGJ5SXpxcldRUWhYREhrclhwQi9C?=
 =?utf-8?B?eUNwT3VGU1dWMzU1Ym1RRVVPU04yUUR2WlhRSklGVUF4c0RKL0pueHh2S2Zj?=
 =?utf-8?B?MHV2SERVcmRmWTlYcndIbUZTblJSYVZMTW5zS2xaRVJ3Wm5lRmV1d214Zk9z?=
 =?utf-8?B?c1JnUXRLaHhXbFpMUThyRXQ2bThqdEdjN1h0UWJISElDZHNSNGxKTjBPcW5Q?=
 =?utf-8?B?R0lkaUE3UHJ4SGZiQ3VDTHlIM3Y5SGZEN1ZqeVJXaFJYWHp2eFY2VzdFR05V?=
 =?utf-8?B?b251TUxEY1VIZnd5S0U2SUxUUzVCeDc4TVRrNVE2UHBqcW9QN0xCTlNhV2ZR?=
 =?utf-8?B?NEhiNVZ5eWpkbjVyRHlMeGEybC9GNHE1dVVWbjhIUXl2d2pkVU1INzllVnFx?=
 =?utf-8?B?bmRlVkx5ZzJwL1JoMUZkeE1hMW51ZWY4aUJvbk0rWUNIQUVJZlZMRm5Uenkr?=
 =?utf-8?B?cFZWdU1acHBSaUhHcEVNeVA2TzdveVliUWYrMFBWN29JUFdCMStPK1FKdTJW?=
 =?utf-8?B?M3FQYk1vdjZSd092cHNzQ0pSS2dKRmFsTXNTZlFEZmdDKzdpZElMWFk1Z2g0?=
 =?utf-8?B?TWZ6b1g5MVEzRyt2OCthbklFSlZQSE9ZYlZmTngzQlVTUWZRV1NLa1RhZzY4?=
 =?utf-8?B?SU9ST3hBNjRTTmVuL1RmeTNHYUgxRmZ2STJjclhKNmRNeU1WZ3l1RWlBOS9k?=
 =?utf-8?B?UjNCU0I0MjVRQmcvS3lYbG1mOG53dmxpL1RNQzJUc20vVjNlMmc2Z095QS9G?=
 =?utf-8?B?SGViSEN5YmMyRklEVm1IY0dxNjUyRFcrc3lTTEhkakQzVTdsSFl1K3F6WjEy?=
 =?utf-8?B?Qmp6d0VWS211Qm5QemhiRkNiRmF6MENWeE8zQnhOdTQ0NEpabGZKZTEvN3Za?=
 =?utf-8?B?blhvOTdpOXpKNjZ1RkFoSDZZTzVvTnY4K1dpWmEzdGJ1aEhrcEtHMHY3Z2Nv?=
 =?utf-8?B?bFo2YnRZUDA5NHZYQS8yL28vNTNnNjhlSm1hQzVMbEQ1UzIxZDNwUm9QWlh3?=
 =?utf-8?B?Y3Rsck5EUXc1RXgwMDJ2dFhmUkR1REhBZHZxenp2SVdheTgveVR5Wk5NYy96?=
 =?utf-8?B?dE1naFNNdldLQ0VxbnRIUXY4cStJUjlPN3pnYnI5bHV6YkdYSEIxaFZjZGVQ?=
 =?utf-8?B?UG9ZaDB0eTlMY2ZQVGdXTEtkZjhKTWdndUtRdkNuRjlRY2pBV0l4K0c3c0dJ?=
 =?utf-8?B?QWtjalFqU2Nuei90NndGOTZXU3ludDg0cGNPSXlIakxmOFFseWZ0NnRnenNB?=
 =?utf-8?B?WU1nZUpXbTd5SGJ5OTFiNzFPV2ZsWC8vOWpENGFXdDhoeHUrQ3llSEtYbHM0?=
 =?utf-8?B?WHBOVDFqQWVnbHB2Nlhxa21UY3N5NzU3a0R1SGlTQUU1T0V6S1hFNFFpTHJp?=
 =?utf-8?B?VDh3cWlibDJtMUt4REJQSklEQjBDdHJHSG8ydGdJdEFNc0NyVDNsMDFTZ2hQ?=
 =?utf-8?B?Ujh5UVMzZ0pJRklPckN5OG56T2ZSVEpTaW9zeUFWVkI1bFlJS2ZiTDMxNUpR?=
 =?utf-8?B?cFVneUhVTlZXaHJqZDFiOTRsZE4raXVlRnNtbjN6RTA4OEJ2dTk0T3RUNUIw?=
 =?utf-8?Q?scEIdcV9Rmgkc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c65052e4-db51-426a-fd7c-08d8e4debd0b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2021 22:40:58.1655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KTipOyeG5APptUy5wGFD2c/Iqp2QkvgRyBbwHWNL3qb4cAABzbctK0/1U1jmsyEcO2A5Xb/xQq0JHnDJQDbEHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2655
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2021-03-05 6:13 p.m., Andrey Grodzovsky wrote:
> 
> 
> On 2021-03-05 2:12 p.m., Sergei Miroshnichenko wrote:
>> On Fri, 2021-03-05 at 12:13 -0500, Andrey Grodzovsky wrote:
>>>
>>> On 2021-03-05 11:08 a.m., Sergei Miroshnichenko wrote:
>>>> On Thu, 2021-03-04 at 14:49 -0500, Andrey Grodzovsky wrote:
>>>>> + linux-pci
>>>>>
>>>>> On 2021-02-26 1:44 a.m., Sergei Miroshnichenko wrote:
>>>>>> On Thu, 2021-02-25 at 13:28 -0500, Andrey Grodzovsky wrote:
>>>>>>> On 2021-02-25 2:00 a.m., Sergei Miroshnichenko wrote:
>>>>>>>> On Wed, 2021-02-24 at 17:51 -0500, Andrey Grodzovsky wrote:
>>>>>>>>> On 2021-02-24 1:23 p.m., Sergei Miroshnichenko wrote:
>>>>>>>>>> ...
>>>>>>>>> Are you saying that even without hot-plugging, while both
>>>>>>>>> nvme
>>>>>>>>> and
>>>>>>>>> AMD
>>>>>>>>> card are present
>>>>>>>>> right from boot, you still get BARs moving and MMIO
>>>>>>>>> ranges
>>>>>>>>> reassigned
>>>>>>>>> for NVME BARs
>>>>>>>>> just because amdgpu driver will start resize of AMD card
>>>>>>>>> BARs
>>>>>>>>> and
>>>>>>>>> this
>>>>>>>>> will trigger NVMEs BARs move to
>>>>>>>>> allow AMD card BARs to cover full range of VIDEO RAM ?
>>>>>>>> Yes. Unconditionally, because it is unknown beforehand if
>>>>>>>> NVMe's
>>>>>>>> BAR
>>>>>>>> movement will help. In this particular case BAR movement is
>>>>>>>> not
>>>>>>>> needed,
>>>>>>>> but is done anyway.
>>>>>>>>
>>>>>>>> BARs are not moved one by one, but the kernel releases all
>>>>>>>> the
>>>>>>>> releasable ones, and then recalculates a new BAR layout to
>>>>>>>> fit
>>>>>>>> them
>>>>>>>> all. Kernel's algorithm is different from BIOS's, so NVME
>>>>>>>> has
>>>>>>>> appeared
>>>>>>>> at a new place.
>>>>>>>>
>>>>>>>> This is triggered by following:
>>>>>>>> - at boot, if BIOS had assigned not every BAR;
>>>>>>>> - during pci_resize_resource();
>>>>>>>> - during pci_rescan_bus() -- after a pciehp event or a
>>>>>>>> manual
>>>>>>>> via
>>>>>>>> sysfs.
>>>>>>>
>>>>>>> By manual via sysfs you mean something like this - 'echo 1 >
>>>>>>> /sys/bus/pci/drivers/amdgpu/0000\:0c\:00.0/remove && echo 1 >
>>>>>>> /sys/bus/pci/rescan ' ? I am looking into how most reliably
>>>>>>> trigger
>>>>>>> PCI
>>>>>>> code to call my callbacks even without having external PCI
>>>>>>> cage
>>>>>>> for
>>>>>>> GPU
>>>>>>> (will take me some time to get it).
>>>>>>
>>>>>> Yeah, this is our way to go when a device can't be physically
>>>>>> removed
>>>>>> or unpowered remotely. With just a bit shorter path:
>>>>>>
>>>>>>      sudo sh -c 'echo 1 >
>>>>>> /sys/bus/pci/devices/0000\:0c\:00.0/remove'
>>>>>>      sudo sh -c 'echo 1 > /sys/bus/pci/rescan'
>>>>>>
>>>>>> Or, just a second command (rescan) is enough: a BAR movement
>>>>>> attempt
>>>>>> will be triggered even if there were no changes in PCI
>>>>>> topology.
>>>>>>
>>>>>> Serge
>>>>>>
>>>>>
>>>>> Hi Segrei
>>>>>
>>>>> Here is a link to initial implementation on top of your tree
>>>>> (movable_bars_v9.1) -
>>>>> https://nam11.safelinks.protection.outlook.com/?url=https:%2F%2Fcgit.freedesktop.org%2F~agrodzov%2Flinux%2Fcommit%2F%3Fh%3Dyadro%2Fpcie_hotplug%2Fmovable_bars_v9.1%26id%3D05d6abceed650181bb7fe0a49884a26e378b908e&amp;data=04%7C01%7Candrey.grodzovsky%40amd.com%7C6658f0cc7c344791ce0f08d8e00a96bf%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637505683386334114%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=qEC3qIAM8h1vU4gGEgT6sThXsaCuatTI2UjM9Bb8KGI%3D&amp;reserved=0 
>>>>>
>>>>> I am able to pass one re-scan cycle and can use the card
>>>>> afterwards
>>>>> (see
>>>>> log1.log).
>>>>> But, according to your prints only BAR5 which is registers BAR
>>>>> was
>>>>> updated (amdgpu 0000:0b:00.0: BAR 5 updated: 0xfcc00000 ->
>>>>> 0xfc100000)
>>>>> while I am interested to test BAR0 (Graphic RAM) move since this
>>>>> is
>>>>> where most of the complexity is. Is there a way to hack your code
>>>>> to
>>>>> force this ?
>>>>
>>>> Hi Andrey,
>>>>
>>>> Regarding the amdgpu's BAR0 remaining on its place: it seems this
>>>> is
>>>> because of fixed BARs starting from fc600000. The kernel tends to
>>>> group
>>>> the BARs close to each other, making a bridge window as compact as
>>>> possible. So the BAR0 had occupied the closest "comfortable" slots
>>>> 0xe0000000-0xefffffff, with the resulting bridge window of bus 00
>>>> covering all the BARs:
>>>>
>>>>       pci_bus 0000:00: resource 10 [mem 0xe0000000-0xfec2ffff
>>>> window]
>>>>
>>>> I'll let you know if I get an idea how to rearrange that manually.
>>>>
>>>> Two GPUs can actually swap their places.
>>>
>>> What do you mean ?
>>
>> I was thinking: when the scenario of a PCI rescan with two GPUs (as was
>> described below) will start working, BAR0 of GPU0 can take place of
>> BAR0 of GPU1 after the first rescan.
>>
>>>> What also can make a BAR movable -- is rmmod'ing its driver. It
>>>> could
>>>> be some hack from within a tmux, like:
>>>>
>>>>     rmmod igb; \
>>>>     rmmod xhci_hcd; \
>>>>     rmmod ahci; \
>>>>     echo 1 > /sys/bus/pci/rescan; \
>>>>     modprobe igb; \
>>>>     modprobe xhci_hcd; \
>>>>     modprobe ahci
>>>
>>> But should I also rmmod amdgpu ? Or modprobing back the other
>>> drivers
>>> should cause (hopefully) BAR0 move in AMD graphic card ?
>>
>> You have already made the amdgpu movable, so no need to rmmod it --
>> just those with fixed BARs:
>>
>>      xhci_hcd 0000:0c:00.3: BAR 0: assigned fixed [mem 0xfc600000-
>> 0xfc6fffff 64bit]
>>      igb 0000:07:00.0: BAR 0: assigned fixed [mem 0xfc900000-0xfc91ffff]
>>      igb 0000:07:00.0: BAR 3: assigned fixed [mem 0xfc920000-0xfc923fff]
>>      ahci 0000:02:00.1: BAR 6: assigned fixed [mem 0xfcb00000-0xfcb7ffff
>> pref]
>>      ahci 0000:02:00.1: BAR 5: assigned fixed [mem 0xfcb80000-
>> 0xfcb9ffff]
>>      xhci_hcd 0000:02:00.0: BAR 0: assigned fixed [mem 0xfcba0000-
>> 0xfcba7fff 64bit]
>>      xhci_hcd 0000:05:00.0: BAR 0: assigned fixed [mem 0xfca00000-
>> 0xfca07fff 64bit]
>>      ahci 0000:0d:00.2: BAR 5: assigned fixed [mem 0xfce08000-
>> 0xfce08fff]
>>
>> The expected result is they all move closer to the start of PCI address
>> space.
>>
> 
> Ok, I updated as you described. Also I removed PCI conf command to stop
> address decoding and restart later as I noticed PCI core does it itself
> when needed.
> I tested now also with graphic desktop enabled while submitting
> 3d draw commands and seems like under this scenario everything still
> works. Again, this all needs to be tested with VRAM BAR move as then
> I believe I will see more issues like handling of MMIO mapped VRAM 
> objects (like GART table). In case you do have an AMD card you could 
> also maybe give it a try. In the meanwhile I will add support to 
> ioremapping of those VRAM objects.
> 
> Andrey

Just an update, added support for unmaping/remapping of all VRAM
objects, both user space mmaped and kernel ioremaped. Seems to work
ok but again, without forcing VRAM BAR to move I can't be sure.
Alex, Chsristian - take a look when you have some time to give me some
initial feedback on the amdgpu side.

The code is at 
https://cgit.freedesktop.org/~agrodzov/linux/log/?h=yadro%2Fpcie_hotplug%2Fmovable_bars_v9.1

Andrey

> 
>>>> I think pci_release_resource() should not be in
>>>> amdgpu_device_unmap_mmio() -- the patched kernel will do that
>>>> itself
>>>> for BARs the amdgpu_device_bar_fixed() returns false. Even more --
>>>> the
>>>> kernel will ensure that all BARs which were working before, are
>>>> reassigned properly, so it needs them to be assigned before the
>>>> procedure.
>>>> The same for pci_assign_unassigned_bus_resources() in
>>>> amdgpu_device_remap_mmio(): this callback is invoked from
>>>> pci_rescan_bus() after pci_assign_unassigned_root_bus_resources().
>>>
>>> This seems to me in contrast to your documentation (see
>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2FYADRO-KNS%2Flinux%2Fcommit%2F5bc12ba7c74f1c19c11db29b4807bd32acfac2c2&amp;data=04%7C01%7Candrey.grodzovsky%40amd.com%7C6658f0cc7c344791ce0f08d8e00a96bf%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637505683386334114%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=kO1OlRL8iHMTcijuV0jDpODCtXpCCTpJv6YIn%2FuypNQ%3D&amp;reserved=0 
>>>
>>> step 1) although step 2 seems also to contradict step 1 with regard
>>> to
>>> BARs release - so now I am a bit confused. Also looking at
>>> nvme_dev_unmap - it calls pci_release_mem_regions. Symmetrical
>>> acquisition happens in nvme_dev_unmap.
>>
>> Ah, there is a difference between pci_release_region() and
>> pci_release_resource(), so subtle that I had to refresh my memory. You
>> are right, this has to be explained in the documentation!
>>
>> $ sudo cat /proc/iomem
>> ...
>> f0000000-fcffffff : PCI Bus 0000:00     -- root bus resource
>> ...
>>    fcf00000-fcffffff : PCI Bus 0000:01   -- bridge window
>>      fcf00000-fcf03fff : 0000:01:00.0    -- pci resource (BAR)
>>        fcf00000-fcf03fff : nvme          -- pci region (reserved by
>>                                             a driver, has its name).
>>
>> So the nvme_dev_unmap() reflects with pci_release_region() that the BAR
>> is not used by the driver anymore -- this actually should be called in
>> every rescan_prepare().
>>
>> But the pci_release_resource() tells to the PCI subsystem that the BAR
>> is "released" from the device and has to be assigned to some address
>> before using again, and makes the pci_resource_start(pdev,
>> relased_barno) invalid.
>>
>> Why the quotes: pci_release_resource() doesn't turn off the BAR,
>> doesn't write the registers -- this happens later.
>>
>> I thouht at first that pci_release_resource() is not safe in a
>> rescan_prepare(), but then double-checked, and found it's fine, just
>> not needed, as the kernel will do it anyway. And the
>> pci_bus_check_bars_assigned() to compare the bitmasks of successfully
>> assigned BARs is called *before* the hook.
>>
>>>>> When testing with 2 graphic cards and triggering rescan, hard
>>>>> hang of
>>>>> the system happens during rescan_prepare of the second card  when
>>>>> stopping the HW (see log2.log) - I don't understand why this
>>>>> would
>>>>> happen as each of them passes fine when they are standalone
>>>>> tested
>>>>> and
>>>>> there should be no interdependence between them as far as i know.
>>>>> Do you have any idea ?
>>>>
>>>> What happens with two GPUs is unclear for me as well, nothing looks
>>>> suspicious.
>>>>
>>>> Serge
>>>>
