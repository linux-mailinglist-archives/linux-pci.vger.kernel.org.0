Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E67732F679
	for <lists+linux-pci@lfdr.de>; Sat,  6 Mar 2021 00:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbhCEXNg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Mar 2021 18:13:36 -0500
Received: from mail-co1nam11on2053.outbound.protection.outlook.com ([40.107.220.53]:56417
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229701AbhCEXNe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 5 Mar 2021 18:13:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BLzO1WDwuaxUPk+2hCIOp54o6iUf8kSdedFfjwkwMelvGchW540aiRVYETqBeI7rzrmz1XS/M/6YuZT0KonQJuJnGWO6wyIX/Cv6T6Gpw3WzVuLAY+q2wUvyDG82u5j0HitNj0UXSKJH7LMPh0BOYNMOWo2T5j1TyQ8t+DZ8s1M4jCr+IhdAA1Xktwfd5TO/LI2eJDXvrAldYpbWsTFp16oonU63tHV40LGP97Xpy0WAbEzz1ULU0iAr8SMESg9heGi+8srAFJ//xyFgkFx3YAEzErvak7r5HwwBIV5s54yqTKbTtVqpvPOyUcWq9gLxG2GwA9kL4hbfMWYDZWghPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0zIn4OCzrcDx6RovE4pX1a/gho/YCoNKfJywIH0li1o=;
 b=OPh3ZKUFYFxcNNl8V7lqN/rv3YfpdD25gvcbPOs67u+67NCyVD/Pqqob6K//cpWaD+GDyjb0TNOw4ZsvmEDioiGZZqC32WQ9TZOFvFGLD11o/bktlU4mU8XglOhJzt4Xgh8P0Wo4fuVuftTFlxkYmkf/XUpPgD5xX02UpComCVDYe7eBmg0JBE5hyWH8erjRNc9hno1xlTKTn7B/pYZ/SGarigJzOmv55f0KCA5W8UWAhkJfwR6tCzilk54UidhSKU3/RHX4vx4STPugOKSqzKSXe95U1jbVYa+70qUuuhR8042TvpYFIJLKqSxiW3BSF8wwF7z1vYu2U2dCsRRLMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0zIn4OCzrcDx6RovE4pX1a/gho/YCoNKfJywIH0li1o=;
 b=DvcNdB/IsZZvaE4GgYK3YCcbbsoXLJAfEntzTmmcFxK50cr0M1C2f+ln37UCr7N3cDmwbzAaYvpSB0eR5N9jMDFxXMoXumdgC9BSkYvg80kL+8bfar544HPQnG6GXAxkiGmljZ6EOU+6nOJNO2+FrWxNTEPZreOhTUuSkVE374Q=
Authentication-Results: yadro.com; dkim=none (message not signed)
 header.d=none;yadro.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SA0PR12MB4494.namprd12.prod.outlook.com (2603:10b6:806:94::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Fri, 5 Mar
 2021 23:13:31 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::29cb:752d:a8a7:24a8]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::29cb:752d:a8a7:24a8%6]) with mapi id 15.20.3912.024; Fri, 5 Mar 2021
 23:13:31 +0000
Subject: Re: Question about supporting AMD eGPU hot plug case
To:     Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Cc:     "Alexander.Deucher@amd.com" <Alexander.Deucher@amd.com>,
        "Christian.Koenig@amd.com" <Christian.Koenig@amd.com>,
        "anatoli.antonovitch@amd.com" <anatoli.antonovitch@amd.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux@yadro.com" <linux@yadro.com>
References: <ddef2da4-4726-7321-40fe-5f90788cc836@amd.com>
 <ffb816ae8336ff2373ec5fcf695e698900c3d557.camel@yadro.com>
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
From:   Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <146844cc-e2d9-aade-8223-db41b37853c5@amd.com>
Date:   Fri, 5 Mar 2021 18:13:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <98ac52f982409e22fbd6e6659e2724f9b1f2fafd.camel@yadro.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2607:fea8:3edf:49b0:85a8:f308:1dca:3588]
X-ClientProxiedBy: YTBPR01CA0025.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::38) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:85a8:f308:1dca:3588] (2607:fea8:3edf:49b0:85a8:f308:1dca:3588) by YTBPR01CA0025.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.24 via Frontend Transport; Fri, 5 Mar 2021 23:13:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d892d6e8-e3b4-4e0a-519a-08d8e02c4af8
X-MS-TrafficTypeDiagnostic: SA0PR12MB4494:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB44949A4FF49F7B0BB7CE60F4EA969@SA0PR12MB4494.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R2XrFzba7AdoCZ4XmzmVLwwlnUTWapZpMoM0PE/YslABJ6ggSaI+0IKBAt0KkNrXtGgDn6A0EC72rJSUDA9j2jA1wTTjFfmWcy16t/JVx7MJG1bBB6zQd0Y33n2FuyjlvTmZu83u3IRbLoONULgADtvbpUAJKXyTJvnIbd9h0bFdYo1rDInGXv6U5m9/dETrr7G0ogoqlWW+TI7hnifkZRTAuAo35aLDR6+Tx8GvaQZ/ynAUIN99hhtA4oGYTzAf02m9e0fM9bZJcjd4yA9O8xpFZV4jUV0Xqd165OHmNzUCYAr5zJlVHFxnxlKU15NaoFUgBXq0K5AxHpUQrroG02IpIx0svN85tGvXvITwz9jJO5Hpi0RTa0j/iAbun2Ddkjiv9WIW02br3lyV1HsNIxUQc1ewWP+pXGkUlUyfKmmutguCOssDlFGemzeySaoMoPpuZwC36WOR/Qs91csDnnOY5kadr0asAdMv7VKnNEIpgauaekAj5zix3ZeXyH6dPPupqDNFLfaIg3PCB6m3dNVzYi1JPFpVwgqm9Y5Bty8GQOLNxNYeg+R41YVnQTInGEVGRTYwpip6+fWWiNSQ9pGJvbv7+7utwvKkWGw8fc4p+nDWMan077cygkKel3L1qUY83oydInKZeIz0EL7tqTOVuKKVTOfhCfcuSXbLm3DW514NYFk3XZHywDSnZFOM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB4623.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(396003)(39860400002)(346002)(376002)(316002)(2616005)(478600001)(86362001)(4326008)(5660300002)(31696002)(44832011)(16526019)(53546011)(66946007)(45080400002)(52116002)(8936002)(6486002)(36756003)(8676002)(31686004)(54906003)(186003)(2906002)(966005)(66476007)(83380400001)(6916009)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?eDZuSW9sRkREN2ZYVVB2VzdPK0t0SFZST3RRSE94TmtLSVJickEyRHVpMCtr?=
 =?utf-8?B?Q2NyRHo3RVhtTmcrNjUxUWFNRWd1bjQrcjY0QitzemlhdXlOd3MxblJKUFFr?=
 =?utf-8?B?WkRCbnlxaXh5WUdHR2YvWWNVTTJaOFRZQloyVXZINHpyK2tZTURldXZOYnBl?=
 =?utf-8?B?QTUwWW5KYlpjVWVtbm4rNFU1L1lYdmo4YVRlNVR2WGR4MlhRc3pROG9hQUNW?=
 =?utf-8?B?MWViMVJOMGc0WHd6WDRHbnN6bUJ5WmNkcVlVM2hGVjdtZW0vZEtuZHZyTEQ0?=
 =?utf-8?B?cG9RUFpuVFBSRzBMalJRVjhXYmJzUHdlaVZITTFrQ1crVUtUejFKSmErK2Ev?=
 =?utf-8?B?VW52SmlZa2ttcldQdmx5eDVGMHRQdER1UXQvRHhLK2h4b0NVSWRsd09EY05s?=
 =?utf-8?B?ckRFSEVFYjVwanhFYmFUOEV1OGptekl3QkZ0U09idzAzQzhIUmQ2aVJPSEtU?=
 =?utf-8?B?ZzNaNjA0UUlhNE00MVBWUXZvdC81azBwUkZLbTZ0VENSOTYvaGw1RHRHSlpN?=
 =?utf-8?B?eUhpV0Z5YmZPazU4d08zT0lnQjkwYUkwTHlQbnl4NmZBL3NYQnJ4TzBvVDNE?=
 =?utf-8?B?bk5Lekk0S05lU2pZR1BabkJ1MlVZYURJS1hPWWJvK1hRa0xsV3dOZmRWbEpK?=
 =?utf-8?B?R0N6RnRzV2g4MkVuMnY5MjJ6ODdjV3paaGhQUHpIZ0h6U2g4QnlUVVh3REtX?=
 =?utf-8?B?QVZqZmZEdVdVOWRqQjhDb1ptdnFlcGQ1ZzZPaXpVQXcvV3dsaXc2MHhiOW1J?=
 =?utf-8?B?OXZzMzMyZVR2UXZRTXlJancyejlTTGg1SzNOdkJkanY3WEJiRVRVcTY5bDlo?=
 =?utf-8?B?V3BaSGdrZnpjODJWdGx4U1ZoTXFwR0VMS0I2bnRIamErVEs5YlhDZTE5bTdB?=
 =?utf-8?B?bDNrY0xxQjJaNUZMUVA0aHI3YkJUTW9HcnV0aXZzQmVZYVhsL0ZjTnk5TDRz?=
 =?utf-8?B?OFNWaXEyWVpKY1dTZ0FNL05yUHc5MzZpcVZwVnFrVnhjYUFjdkFwZUZrOXVB?=
 =?utf-8?B?ckJvQWVobUE5RzhkYTRkeExlSzVldFh6dWpRbytRL3RXTWttc3J4QnptZTJQ?=
 =?utf-8?B?eDRnMHB5Zk4vWW0vVU8rd0N5N1dDZFNnSEJlVmM5emZaK3lSY0RnbURkK1NK?=
 =?utf-8?B?ZVlUZlBkNXAxdWRIKzRFNnFNYXpTVThIUmkyRTMxRGt2SnBrNU54TUtvMUwr?=
 =?utf-8?B?U0hKdlJlNDgzVDhZUVhZR2tmS3NmRVF6d2FwLzFSdkxlYVhlVTJqc2Eya21D?=
 =?utf-8?B?TWdzVWxDRDR5bm84MjEwNU1SbHhySmlHU0VWdkZZY2p4SEY1YThkWVlwR0VX?=
 =?utf-8?B?c25LOFZSdUJ5VnF6WWJiWmVIRkg4MjkvR0Zrck5yTEVIVDQ3N2s1RkszV3lU?=
 =?utf-8?B?bksvVEV1THFsRm1UQ3hXVXA3WklwVnVHRDV5eGswczhIeGVnZmJseGN0MnZ4?=
 =?utf-8?B?bmU0c2FONzhXY3J6blErZmFBYXR2SWtjb243L0dHYkRXSjg1YmFxNnNGTm5k?=
 =?utf-8?B?cHRtRVI3ZmhpL0U3VEI4VUpLYjl2ZUtNY0lwRlR5UG9jSE82VldEeWVDcXpC?=
 =?utf-8?B?UEFKczFQNDNmbjFzUW5mWHZvZnpXekdDemtucTI2SGhWTGNUTTdnNk8yUG15?=
 =?utf-8?B?U21BZHpqNVk2d2Q3dFBzaC9Oak1VVEt2THY0bW9kSnc0ZGlVbFF1ME5qY2wx?=
 =?utf-8?B?N3FxNTFNN1kvekh4NTI3c29BTG05RFRYeE5vdVFuMU1VdVRWWnoxVi9aRWNk?=
 =?utf-8?B?NHNiUlVyWkxZaUlvOE41b3ZybGoyTEJYTytzdGZiVngxd1FOOUppYXB2dWR3?=
 =?utf-8?B?ZDQyVU9TOE50WDZ6VVBhblVOM0tXb0RLTkh3eEdDWEF4YUZDRnBlZUhNU1Bh?=
 =?utf-8?Q?VmKrQQZFiaG9s?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d892d6e8-e3b4-4e0a-519a-08d8e02c4af8
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2021 23:13:31.6034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4iUQ+zcLivKQFUSI+L9vKRkItd2JTL2vMaAwYStPM42FPhlej5oU0IzbqAYn/fbzEtnH7wGgSbCp8Su+3Cnx0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4494
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2021-03-05 2:12 p.m., Sergei Miroshnichenko wrote:
> On Fri, 2021-03-05 at 12:13 -0500, Andrey Grodzovsky wrote:
>>
>> On 2021-03-05 11:08 a.m., Sergei Miroshnichenko wrote:
>>> On Thu, 2021-03-04 at 14:49 -0500, Andrey Grodzovsky wrote:
>>>> + linux-pci
>>>>
>>>> On 2021-02-26 1:44 a.m., Sergei Miroshnichenko wrote:
>>>>> On Thu, 2021-02-25 at 13:28 -0500, Andrey Grodzovsky wrote:
>>>>>> On 2021-02-25 2:00 a.m., Sergei Miroshnichenko wrote:
>>>>>>> On Wed, 2021-02-24 at 17:51 -0500, Andrey Grodzovsky wrote:
>>>>>>>> On 2021-02-24 1:23 p.m., Sergei Miroshnichenko wrote:
>>>>>>>>> ...
>>>>>>>> Are you saying that even without hot-plugging, while both
>>>>>>>> nvme
>>>>>>>> and
>>>>>>>> AMD
>>>>>>>> card are present
>>>>>>>> right from boot, you still get BARs moving and MMIO
>>>>>>>> ranges
>>>>>>>> reassigned
>>>>>>>> for NVME BARs
>>>>>>>> just because amdgpu driver will start resize of AMD card
>>>>>>>> BARs
>>>>>>>> and
>>>>>>>> this
>>>>>>>> will trigger NVMEs BARs move to
>>>>>>>> allow AMD card BARs to cover full range of VIDEO RAM ?
>>>>>>> Yes. Unconditionally, because it is unknown beforehand if
>>>>>>> NVMe's
>>>>>>> BAR
>>>>>>> movement will help. In this particular case BAR movement is
>>>>>>> not
>>>>>>> needed,
>>>>>>> but is done anyway.
>>>>>>>
>>>>>>> BARs are not moved one by one, but the kernel releases all
>>>>>>> the
>>>>>>> releasable ones, and then recalculates a new BAR layout to
>>>>>>> fit
>>>>>>> them
>>>>>>> all. Kernel's algorithm is different from BIOS's, so NVME
>>>>>>> has
>>>>>>> appeared
>>>>>>> at a new place.
>>>>>>>
>>>>>>> This is triggered by following:
>>>>>>> - at boot, if BIOS had assigned not every BAR;
>>>>>>> - during pci_resize_resource();
>>>>>>> - during pci_rescan_bus() -- after a pciehp event or a
>>>>>>> manual
>>>>>>> via
>>>>>>> sysfs.
>>>>>>
>>>>>> By manual via sysfs you mean something like this - 'echo 1 >
>>>>>> /sys/bus/pci/drivers/amdgpu/0000\:0c\:00.0/remove && echo 1 >
>>>>>> /sys/bus/pci/rescan ' ? I am looking into how most reliably
>>>>>> trigger
>>>>>> PCI
>>>>>> code to call my callbacks even without having external PCI
>>>>>> cage
>>>>>> for
>>>>>> GPU
>>>>>> (will take me some time to get it).
>>>>>
>>>>> Yeah, this is our way to go when a device can't be physically
>>>>> removed
>>>>> or unpowered remotely. With just a bit shorter path:
>>>>>
>>>>>      sudo sh -c 'echo 1 >
>>>>> /sys/bus/pci/devices/0000\:0c\:00.0/remove'
>>>>>      sudo sh -c 'echo 1 > /sys/bus/pci/rescan'
>>>>>
>>>>> Or, just a second command (rescan) is enough: a BAR movement
>>>>> attempt
>>>>> will be triggered even if there were no changes in PCI
>>>>> topology.
>>>>>
>>>>> Serge
>>>>>
>>>>
>>>> Hi Segrei
>>>>
>>>> Here is a link to initial implementation on top of your tree
>>>> (movable_bars_v9.1) -
>>>> https://nam11.safelinks.protection.outlook.com/?url=https:%2F%2Fcgit.freedesktop.org%2F~agrodzov%2Flinux%2Fcommit%2F%3Fh%3Dyadro%2Fpcie_hotplug%2Fmovable_bars_v9.1%26id%3D05d6abceed650181bb7fe0a49884a26e378b908e&amp;data=04%7C01%7Candrey.grodzovsky%40amd.com%7C6658f0cc7c344791ce0f08d8e00a96bf%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637505683386334114%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=qEC3qIAM8h1vU4gGEgT6sThXsaCuatTI2UjM9Bb8KGI%3D&amp;reserved=0
>>>> I am able to pass one re-scan cycle and can use the card
>>>> afterwards
>>>> (see
>>>> log1.log).
>>>> But, according to your prints only BAR5 which is registers BAR
>>>> was
>>>> updated (amdgpu 0000:0b:00.0: BAR 5 updated: 0xfcc00000 ->
>>>> 0xfc100000)
>>>> while I am interested to test BAR0 (Graphic RAM) move since this
>>>> is
>>>> where most of the complexity is. Is there a way to hack your code
>>>> to
>>>> force this ?
>>>
>>> Hi Andrey,
>>>
>>> Regarding the amdgpu's BAR0 remaining on its place: it seems this
>>> is
>>> because of fixed BARs starting from fc600000. The kernel tends to
>>> group
>>> the BARs close to each other, making a bridge window as compact as
>>> possible. So the BAR0 had occupied the closest "comfortable" slots
>>> 0xe0000000-0xefffffff, with the resulting bridge window of bus 00
>>> covering all the BARs:
>>>
>>>       pci_bus 0000:00: resource 10 [mem 0xe0000000-0xfec2ffff
>>> window]
>>>
>>> I'll let you know if I get an idea how to rearrange that manually.
>>>
>>> Two GPUs can actually swap their places.
>>
>> What do you mean ?
> 
> I was thinking: when the scenario of a PCI rescan with two GPUs (as was
> described below) will start working, BAR0 of GPU0 can take place of
> BAR0 of GPU1 after the first rescan.
> 
>>> What also can make a BAR movable -- is rmmod'ing its driver. It
>>> could
>>> be some hack from within a tmux, like:
>>>
>>>     rmmod igb; \
>>>     rmmod xhci_hcd; \
>>>     rmmod ahci; \
>>>     echo 1 > /sys/bus/pci/rescan; \
>>>     modprobe igb; \
>>>     modprobe xhci_hcd; \
>>>     modprobe ahci
>>
>> But should I also rmmod amdgpu ? Or modprobing back the other
>> drivers
>> should cause (hopefully) BAR0 move in AMD graphic card ?
> 
> You have already made the amdgpu movable, so no need to rmmod it --
> just those with fixed BARs:
> 
>      xhci_hcd 0000:0c:00.3: BAR 0: assigned fixed [mem 0xfc600000-
> 0xfc6fffff 64bit]
>      igb 0000:07:00.0: BAR 0: assigned fixed [mem 0xfc900000-0xfc91ffff]
>      igb 0000:07:00.0: BAR 3: assigned fixed [mem 0xfc920000-0xfc923fff]
>      ahci 0000:02:00.1: BAR 6: assigned fixed [mem 0xfcb00000-0xfcb7ffff
> pref]
>      ahci 0000:02:00.1: BAR 5: assigned fixed [mem 0xfcb80000-
> 0xfcb9ffff]
>      xhci_hcd 0000:02:00.0: BAR 0: assigned fixed [mem 0xfcba0000-
> 0xfcba7fff 64bit]
>      xhci_hcd 0000:05:00.0: BAR 0: assigned fixed [mem 0xfca00000-
> 0xfca07fff 64bit]
>      ahci 0000:0d:00.2: BAR 5: assigned fixed [mem 0xfce08000-
> 0xfce08fff]
> 
> The expected result is they all move closer to the start of PCI address
> space.
> 

Ok, I updated as you described. Also I removed PCI conf command to stop
address decoding and restart later as I noticed PCI core does it itself
when needed.
I tested now also with graphic desktop enabled while submitting
3d draw commands and seems like under this scenario everything still
works. Again, this all needs to be tested with VRAM BAR move as then
I believe I will see more issues like handling of MMIO mapped VRAM 
objects (like GART table). In case you do have an AMD card you could 
also maybe give it a try. In the meanwhile I will add support to 
ioremapping of those VRAM objects.

Andrey

>>> I think pci_release_resource() should not be in
>>> amdgpu_device_unmap_mmio() -- the patched kernel will do that
>>> itself
>>> for BARs the amdgpu_device_bar_fixed() returns false. Even more --
>>> the
>>> kernel will ensure that all BARs which were working before, are
>>> reassigned properly, so it needs them to be assigned before the
>>> procedure.
>>> The same for pci_assign_unassigned_bus_resources() in
>>> amdgpu_device_remap_mmio(): this callback is invoked from
>>> pci_rescan_bus() after pci_assign_unassigned_root_bus_resources().
>>
>> This seems to me in contrast to your documentation (see
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2FYADRO-KNS%2Flinux%2Fcommit%2F5bc12ba7c74f1c19c11db29b4807bd32acfac2c2&amp;data=04%7C01%7Candrey.grodzovsky%40amd.com%7C6658f0cc7c344791ce0f08d8e00a96bf%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637505683386334114%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=kO1OlRL8iHMTcijuV0jDpODCtXpCCTpJv6YIn%2FuypNQ%3D&amp;reserved=0
>> step 1) although step 2 seems also to contradict step 1 with regard
>> to
>> BARs release - so now I am a bit confused. Also looking at
>> nvme_dev_unmap - it calls pci_release_mem_regions. Symmetrical
>> acquisition happens in nvme_dev_unmap.
> 
> Ah, there is a difference between pci_release_region() and
> pci_release_resource(), so subtle that I had to refresh my memory. You
> are right, this has to be explained in the documentation!
> 
> $ sudo cat /proc/iomem
> ...
> f0000000-fcffffff : PCI Bus 0000:00     -- root bus resource
> ...
>    fcf00000-fcffffff : PCI Bus 0000:01   -- bridge window
>      fcf00000-fcf03fff : 0000:01:00.0    -- pci resource (BAR)
>        fcf00000-fcf03fff : nvme          -- pci region (reserved by
>                                             a driver, has its name).
> 
> So the nvme_dev_unmap() reflects with pci_release_region() that the BAR
> is not used by the driver anymore -- this actually should be called in
> every rescan_prepare().
> 
> But the pci_release_resource() tells to the PCI subsystem that the BAR
> is "released" from the device and has to be assigned to some address
> before using again, and makes the pci_resource_start(pdev,
> relased_barno) invalid.
> 
> Why the quotes: pci_release_resource() doesn't turn off the BAR,
> doesn't write the registers -- this happens later.
> 
> I thouht at first that pci_release_resource() is not safe in a
> rescan_prepare(), but then double-checked, and found it's fine, just
> not needed, as the kernel will do it anyway. And the
> pci_bus_check_bars_assigned() to compare the bitmasks of successfully
> assigned BARs is called *before* the hook.
> 
>>>> When testing with 2 graphic cards and triggering rescan, hard
>>>> hang of
>>>> the system happens during rescan_prepare of the second card  when
>>>> stopping the HW (see log2.log) - I don't understand why this
>>>> would
>>>> happen as each of them passes fine when they are standalone
>>>> tested
>>>> and
>>>> there should be no interdependence between them as far as i know.
>>>> Do you have any idea ?
>>>
>>> What happens with two GPUs is unclear for me as well, nothing looks
>>> suspicious.
>>>
>>> Serge
>>>
