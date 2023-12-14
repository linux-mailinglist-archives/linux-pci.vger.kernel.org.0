Return-Path: <linux-pci+bounces-1001-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68CB98136A1
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 17:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24AA22834D2
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 16:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B5360BA8;
	Thu, 14 Dec 2023 16:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KipDBREn"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D858E112;
	Thu, 14 Dec 2023 08:44:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=etfBJjZYmhYQhTzpghE3md4mAm5JQDHODZ5cyDWUJFUJFI+Yo/8NGAmhfWubLP/xgcxrMVIBn+RmJL8wkh1RQSosmRQ6FWMpkRn5crdbxr8kjGU0NSrLP1mZ09eUUq5DGLGcf5sA7Sujik+MRSzytKDuWygmWqJ2+3BKBBaQfAuLd+ns6AfHsBMdDQDapHsCuwcdLeT14ft68K0GHNPaDoKUG9uXLeJW8rqcgf0JhiSHPG8jXxebTgfLqfjKDov8KSLlJIPBWSLR88MQd97Pj+kGyh+lll877dvZf7NM038QGJ78oJuiEypx7yPBJAZ9oyrl3qD6Mgbp4+WJ4MAtZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=chaPzz0GwbaIGGDQDjhTk6u3LybUZBN+YEF4TGWX4GM=;
 b=JjtvmRJaE58yPt56lf2IgukdEG7L/IISa0Kr9weds/uuiKQMSmoAloHT7D1boJJhXqL0OevsgK8Xv5v5YPZpJkOrv7gZ9VdWJ2VQQdBvH7vJ5XOb4jzwntCa3MZK8WtS3sQSFK7MW99pN5NHobwMU4oAsx0Twx40gKXgsCLg/W6pgo/79F5MO35WptaxDNmkya5lTJ0Bu2XFH6PT0gRZeswINGo853236a72cClo5YYB2j3ryEXEt1QCEztQ0Q43eRDeThWLVZ4OWJZhfis2D85boG6A2cg37P4hLU26BgZYtNaYeMqJEN1SCXc3oEKJVkXxLeXIrgd7dx1u47QiQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=chaPzz0GwbaIGGDQDjhTk6u3LybUZBN+YEF4TGWX4GM=;
 b=KipDBREndZosGSsT9zXm6jK5a3ce0ME3W9A0uD8lukDvcdwZxCHujnatEoyhmRVBRu+isgXjAqkBs80KGZ/8c6EkBwxvUnMlxjTKg4eeVZlhT2tKRQ+80Uipjky8S3KS9kgJBQLWcr+SjDdqjkwwB1s9AVdSOMp/QNGTQiB/lqs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH3PR12MB9250.namprd12.prod.outlook.com (2603:10b6:610:1ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.38; Thu, 14 Dec
 2023 16:44:45 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 16:44:45 +0000
Message-ID: <3ed302e4-4287-49be-838b-932ecbdc8d12@amd.com>
Date: Thu, 14 Dec 2023 10:44:43 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] PCI/portdrv: Place PCIe port hierarchy into D3cold at
 shutdown
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pci@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 mpearson-lenovo@squebb.ca
References: <20231213182656.6165-1-mario.limonciello@amd.com>
 <20231213182656.6165-3-mario.limonciello@amd.com>
 <CAJZ5v0gDjwEpx-WNSY0=qchoSGxizsD3XM7Bgq=i0xufBm=Cag@mail.gmail.com>
 <766d621c-695d-4ae7-87cf-690cb8d066df@amd.com>
 <CAJZ5v0i95EeS40pzkBH=jgB1wbMP6SNO_s=pNZ8FPOtcMywgAA@mail.gmail.com>
 <CAAd53p6XynUJimepnXDzcVa4Dps4-F0BNEXxGZh_O38LvSdkkg@mail.gmail.com>
 <CAJZ5v0ijf9-faD-bDaGi9U0JR4iQ68DECyPM8c-AeECOfhQ=Bg@mail.gmail.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAJZ5v0ijf9-faD-bDaGi9U0JR4iQ68DECyPM8c-AeECOfhQ=Bg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR05CA0028.namprd05.prod.outlook.com
 (2603:10b6:805:de::41) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH3PR12MB9250:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c4597be-ed62-4ba3-f643-08dbfcc3fa67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UuVKbobs4/hb5SXKpqvPbWh2BSwzYmzaqgzpAZz4YOUraf0QIekWlNWkqsjmlHU8Bx6O92G4g1VJuKSioC9dFAqz9Owj6pm0IF5FeA88qh0M2f4f6gkxBRLVsYRR38u8ex1ssTyQ8oOXWNBwQUf8ZD/iItFDgI5P7h9ci5ey+SXhRxsMTkcqJ//k+W0dKeYKY1ZLjNwpUXJjpz5Lm6Q72Y4HWGjCTVxXvb0ZpwmiP/NZs5Ai8qaaVb38msYJtMBI4ckw2FYb8viFaXjXbZfhQjRJeDAhb90iSDBTXPtrqcucjNpZDBbVwTU0FUlS9n5wROvhM9cvw4gidB0Ql5MtqiYslBSoQOz6C/YLiXRUh36mPcWrSWTdGtYD41z0VnbPbM+Nd8WAb+DW/fVBtU604cV1IszAGPVJFdducuOMXFk7n00rZa7Y/hdaI2rxaLMZasGr4MY3PijPYZ9iwXxgEDgqaYJHyZ7+WhRxkUpTK2Etynwo6PHXcbjWWCwwfEKbtxVvIADFqhldz81xHDG/t1/eLihyueoPfrTHydlzUZeplXROQB2Hpy8dPaVwGvK+QpxUT1YgKNKpfungr6qe9BiEBPShrlpugV25giz3QWklQkl6/+NpIymbsDlPv0BkrUBGdd2K2isvIcakGRdv0KtIGUHW1frIWwMfVB1EpjE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(39860400002)(376002)(346002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(38100700002)(83380400001)(41300700001)(2906002)(6486002)(478600001)(5660300002)(31696002)(53546011)(6506007)(6512007)(66556008)(66476007)(316002)(54906003)(66946007)(44832011)(110136005)(31686004)(36756003)(8676002)(8936002)(4326008)(2616005)(26005)(86362001)(32563001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YitRZnk4bDF5RHVRTWxabkNRM282UjlEOTQ3ZWlaRWVWaC9WTDRQQWhtTExq?=
 =?utf-8?B?ZVR2YklZbWF6UUlEVkZKUmJ4REVldlNQNmRQRkE5OGgyVXg5OVJyb1VCMnlV?=
 =?utf-8?B?ekc1Tnp1UWxrS0l6WVREUXhadUFFUzFCRmo2Z1MrM0gyUUJVK2RvQnRzU3Bq?=
 =?utf-8?B?N1Y0aStkZ1ovb1NXSG9aUDQxMmN3MTdaWnQreTJEY1NNZy8xSkV0aG8zMWZa?=
 =?utf-8?B?NVlnTmd0dHBzWndrOGpyd2pKSDkzb0doUkI0Vy9tZWVjdkFNbjRCRFNOMFYr?=
 =?utf-8?B?MXFBR1RtbDdLT3IrYnB2dS9SZDZXN1F4bzBmbW9qMGNGU0NpbC94Y2s0SFFo?=
 =?utf-8?B?N0lYZm9mUnMzWkplZWNDU0Iyakc5QnFDQnJUM1htNDFRbWRrVEZ4b2Z4MlRy?=
 =?utf-8?B?d3JlOVVuWG83VGFhZU5hS3d6ZnpHOVh3bE5qMW12VU8rT216dWNpMUFpQms3?=
 =?utf-8?B?SmpmUi9KaGw2S2ZKVTNXNU5WVVd4MzF2c3NSWmZWM3hKQ2lDN1FqNHF5cjk4?=
 =?utf-8?B?b2oyd2wxS1BHakQ3cTRyMzJIem4zdkRLZ1lDZEpHdElSeGYzZHorUWwzOWc1?=
 =?utf-8?B?UlRMN3lNTmxtRXJFcHdvekVPYmtBRktDVk4wYWhTZ2pnSW1rd3VvOGx5cGJL?=
 =?utf-8?B?ejFZMzJxVUdoeHBkZ09JQzgwcGU1WWN1aTBXNEJtcWN5N2JzdVhMYkloRnBQ?=
 =?utf-8?B?aTJmWlZjZmxwZnZiVmt0aW9TY1gwREt3U3JJRGtwOEk0enZMRGR1R1NscjVm?=
 =?utf-8?B?WERsQmpBTzFIZnp1Y05Rdmx4K2E5T09MaFN0cWdiZVQyb3JqOWtBUUZCUUZ3?=
 =?utf-8?B?M3hQNzloK085S1k2WnJ4L2xERjBZT3pJc0piUnlJbEc1M0d1UHJBb2ZObXRy?=
 =?utf-8?B?bElDeEhQaDVuRndyUFRqR25MR1FiTzlWcSttKzRsM2g5dWxvbGlLOWZ1YnJx?=
 =?utf-8?B?QWoxN1pZTlBCK2JKTTJLWHNzZk1jZlZwUXNlSkFrZVJCSGRVMTB1RVJuUWQz?=
 =?utf-8?B?cmpqRU9qakZDQStRYjBXZVN2RDBobyt2S3VvSmpsQmhFd1daN25WVjYwVXdT?=
 =?utf-8?B?Z0ZVK3Q5K3lycmpIOXZuWTkxYWZRRjVDSVlHM1VtNFZOdmVvdWhhRDdXV1VM?=
 =?utf-8?B?TWs3dVJSTk1ESUhyQ1MyYXFWYlVRLzJqTkxpOWxTd3ZTa05NMXJ4MlRzUmxY?=
 =?utf-8?B?dTAwaG50YjFyUVBsVnpIL3QvZTdZMHpBSXI5Wm5SMFA1RlM5WU9iNUFoc1Bh?=
 =?utf-8?B?em0vZk5NV0RqbFlxUW5iMlJKQWhTYmxpZzJEbDhBMXVCcExwYmpTY1Z3RXFS?=
 =?utf-8?B?TC82dlhRUUtiTDlLWTdJdkFDSEZRN1VOWXMwV2YwbFNxVmRFQVpCNzBlLytu?=
 =?utf-8?B?czZWUDBzSlVoeHEybDJzdkc1bVJBVkxqb1A5QVpaV1FoVzV5clVndmo3SnZS?=
 =?utf-8?B?V09UUDRXQUloYTVlVVE1MmoyaEdXdWNuY3d5dzZVc3ZRMG56dzQvVWlmRUFW?=
 =?utf-8?B?MmJoTUZjTXRuellpUWlMQjY2M2UvaWdNdWlkMU5IcjJFa09FNWdLV0FjODdL?=
 =?utf-8?B?MVNmSXNlUkw2TGVvcE1ZWVZmWE52Z0hTR1VmenFXT0lNRjVUd24wT0RtLy9R?=
 =?utf-8?B?b1VoRVY3Y1RiRExFSUt0NTFoVjA2R042N3hVZlJIekNTL1B0NUo3dE1mRHFW?=
 =?utf-8?B?SS92NWpYR0ZBYldQSE55Z3VXWGthT0NGeUMzcU9tMWNFZlZGZDhKNzd2N0dn?=
 =?utf-8?B?bUZ0NFZTMlVlbXZzaHk2OVJlbWw4YlJ0ZVZPLy9wWndMSE1pTXVqeHdCMlRr?=
 =?utf-8?B?TEdhNWdEYmgwVjE0Q3VvMVE5dzlhWjhxUmwwa2dYZTdCZStmYURvajMzVVFl?=
 =?utf-8?B?aEp6bFR3LzlGVm1WZ0FCLzFwODFxeGRkZlN0TEpYMFI5WUVJMnozZHphMmtu?=
 =?utf-8?B?WVk1R09Gblp4V2RBdDJMMkFjck1TQ2FOSGR2YThYTThWUnlyWStjMnVzOVJP?=
 =?utf-8?B?RlZxUkRKYmtUQ0hBbzQwOW1USmg5dSswQU00dFV5V2NzN29oUkZiWmJERmUy?=
 =?utf-8?B?U0ZpazRVcEtmZC9YdnlndGVVd3l5Q1YyTEZPcDdlNjJvdWRJMjl4cVRpeFV6?=
 =?utf-8?Q?yf0ldTHVKJWxMwHWIoSLC7PfL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c4597be-ed62-4ba3-f643-08dbfcc3fa67
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 16:44:45.4305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A6UP5RKxHa7QTyuTo+u7/FiK9EYMrJM+ZVqEeINUkajrekJruFLVsDkzXYQiiI5NyVoDEX3zCCa4eCbn6bbMjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9250

On 12/14/2023 03:00, Rafael J. Wysocki wrote:
> On Thu, Dec 14, 2023 at 4:46 AM Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
>>
>> Hi Mario and Rafael,
>>
>> On Thu, Dec 14, 2023 at 2:46 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>>
>>> On Wed, Dec 13, 2023 at 7:42 PM Mario Limonciello
>>> <mario.limonciello@amd.com> wrote:
>>>>
>>>> On 12/13/2023 12:38, Rafael J. Wysocki wrote:
>>>>> On Wed, Dec 13, 2023 at 7:27 PM Mario Limonciello
>>>>> <mario.limonciello@amd.com> wrote:
>>>>>>
>>>>>> When a system is being powered off it's important that PCIe ports
>>>>>> have been put into D3cold as there is no other software to turn
>>>>>> off the devices at S5.
>>>>>>
>>>>>> If PCIe ports are left in D0 then any GPIOs toggled by the ACPI
>>>>>> power resources may be left enabled and devices may consume excess
>>>>>> power.
>>>>>
>>>>> Isn't that a platform firmware issue?
>>>>>
>>>>> It is the responsibility of the platform firmware to properly put the
>>>>> platform into S5, including power removal from devices that are not
>>>>> armed for power-on.
>>>>
>>>> The specific issues that triggered this series were tied to the PCIe
>>>> ports for dGPUs.  There is a GPIO that is toggled by _ON or _OFF.
>>>>
>>>> Windows calls _OFF as part of S5..
>>>
>>> I see.
>>>
>>>>>
>>>>>> Cc: mpearson-lenovo@squebb.ca
>>>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>>>> ---
>>>>>>    drivers/pci/pcie/portdrv.c | 11 ++++++++---
>>>>>>    1 file changed, 8 insertions(+), 3 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
>>>>>> index 14a4b89a3b83..08238680c481 100644
>>>>>> --- a/drivers/pci/pcie/portdrv.c
>>>>>> +++ b/drivers/pci/pcie/portdrv.c
>>>>>> @@ -734,9 +734,14 @@ static void pcie_portdrv_remove(struct pci_dev *dev)
>>>>>>    static void pcie_portdrv_shutdown(struct pci_dev *dev)
>>>>>>    {
>>>>>>           if (pci_bridge_d3_possible(dev)) {
>>>>>> -               pm_runtime_forbid(&dev->dev);
>>>>>> -               pm_runtime_get_noresume(&dev->dev);
>>>>>> -               pm_runtime_dont_use_autosuspend(&dev->dev);
>>>>>> +               /* whole hierarchy goes into a low power state for S5 */
>>>>>> +               if (system_state == SYSTEM_POWER_OFF) {
>>>>>> +                       pci_set_power_state(dev, PCI_D3cold);
>>>>>> +               } else {
>>>>>> +                       pm_runtime_forbid(&dev->dev);
>>>>>> +                       pm_runtime_get_noresume(&dev->dev);
>>>>>> +                       pm_runtime_dont_use_autosuspend(&dev->dev);
>>>>>> +               }
>>>>>>           }
>>>>>
>>>>> Wouldn't it be better to remove power from the port after running the
>>>>> code below?
>>>>>
>>>>
>>>> Yes; I think you're right.  I'll do some more testing with this.
>>>>
>>>>>>           pcie_port_device_remove(dev);
>>>>>> --
>>>
>>> IIRC, to do this all properly, you'd need to rework the shutdown path
>>> to look like the hibernation power-off one.  Or even use the latter
>>> for shutdown?
>>>
>>> There was no reason to do that till now, so it has not been done, but
>>> it looks like you have one.
>>>
>>
>> I am working on exactly same thing but with a different approach.
>> Because this is needed for more than just PCI devices.
>> I haven't written a proper commit message yet, but the implementation
>> is quite simple:
> 
> As I said, doing this properly requires something like the hibernation
> power-off transition to be carried out for S5.
> 
> I think that the existing hibernation power-off code can be used as-is
> for this purpose even.
> 

I feel Rafael is right here that unifying the hibernation and shutdown 
paths is the right direction.  Our team just double checked the 
"unpatched" Linux S4 measurements on a system that otherwise had 
problems with S5 and they show the same decreases in power my patch 
series showed.

KH,

I'm going to be OOO for a while with the holidays around the corner and 
some personal time.  If you end up working on some patches to unify the 
S4/S5 codepaths CC me on them and I'll look when I'm back from my leave.

Thanks,


